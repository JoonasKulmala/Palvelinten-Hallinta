# h1 | Joonas Kulmala

- [h1 | Joonas Kulmala](#h1--joonas-kulmala)
  - [Exercise goals and enviroment](#exercise-goals-and-enviroment)
  - [Exercises](#exercises)
    - [a) Salt master & minion](#a-salt-master--minion)
      - [Installing salt-master, troubleshooting package issue](#installing-salt-master-troubleshooting-package-issue)
      - [Round 2: Installing salt-master and salt-minion](#round-2-installing-salt-master-and-salt-minion)
      - [Assign keys and try out giving commands](#assign-keys-and-try-out-giving-commands)
    - [b) Idempotent state](#b-idempotent-state)
      - [Apply state to all minions, set to automatic](#apply-state-to-all-minions-set-to-automatic)
    - [d) Collect machine data using grains.items command](#d-collect-machine-data-using-grainsitems-command)
    - [e) Testing state pkg.installed](#e-testing-state-pkginstalled)
      - [apache2](#apache2)
      - [fortune](#fortune)
  - [Final thoughts](#final-thoughts)
  - [Sources](#sources)
  - [Edit history](#edit-history)

## Exercise goals and enviroment

Goal was to learn about Salt Stacks.

The exercises can be found [here](https://terokarvinen.com/2021/configuration-management-systems-palvelinten-hallinta-ict4tn022-spring-2021/#h1-hei-maailma-verkon-yli-ja-idempotenssi).

## Exercises

### a) Salt master & minion

#### Installing salt-master, troubleshooting package issue

Let's start by installing Salt master & minion.

```bash
# Begin with updating 
$ sudo apt-get update

$ sudo apt-get -y install salt-master
# E: Unable to locate package salt-master
```

And we ran into a problem immediately. APT is unable to locate the package. During the lecture we used [this](https://repo.saltproject.io/index.html#ubuntu) tutorial to resolve the issue. In short what is needed is to add SaltStack repository key to `sources.list` file and downloading the APT package again.

```bash
$ sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg
$ echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list
$ sudo apt-get update
```

Now let's try again. I'll install packages and setup a new salt minion while at it:

#### Round 2: Installing salt-master and salt-minion

```bash
# Salt Master
$ sudo apt-get -y install salt-master
# Salt minion
$ sudo apt-get -y install salt-minion

# salt-master name
$ hostname -I
# Add master's info to minion config
$ sudoedit /etc/salt/minion
#m name of salt-master from above
master: hostname
# minions must have unique id, I'll name this 'minion-1'
id: id

#Restart service
$ sudo systemctl restart salt-minion.service
```
#### Assign keys and try out giving commands

Now it's time to assign the newly created salt-minion to salt-master.
```bash
$ sudo salt-key -A
The following keys are going to be accepted:
Unaccepted Keys:
minion-1
Proceed? [n/Y] Y
Key for minion minion-1 accepted.
```

Now let's try out giving minion-1 a command:
```bash
$ sudo salt '*' cmd.run 'whoami'
minion-1:
    root
```

Everything seems to be working as intended.

### b) Idempotent state

Let's create idompotent state *hello*. What does it mean, though?

"*Simply put, an operation is idempotent if it produces the same result when called over and over. An identical request should return an identical result when done twice, two thousand, or two million times.*"

```bash
$ sudo mkdir -p /srv/salt/
# State file
$ sudoedit /srv/salt/hello.sls
# Contents in YAML
/tmp/helloworld.txt:
  file.managed:
    - source: salt://helloworld.txt
```

```bash
# salt-master
$ sudoedit /srv/salt/helloworld.txt
See you at http://joonaskulmala.me
```

#### Apply state to all minions, set to automatic

```bash
$  sudo salt '*' state.apply hello
slave-1:
----------
          ID: /tmp/helloworld.txt
    Function: file.managed
      Result: True
     Comment: File /tmp/helloworld.txt updated
     Started: 01:57:19.481779
    Duration: 25.168 ms
     Changes:   
              ----------
              diff:
                  New file
              mode:
                  0644

Summary for slave-1
------------
Succeeded: 1 (changed=1)
Failed:    0
------------
Total states run:     1
Total run time:  25.168 ms
```

```bash
# Create top file
$ sudoedit /srv/salt/top.sls
base:
  '*':
    - hello
# Apply top file
$  sudo salt '*' state.highstate
```

And there we go!

### d) Collect machine data using grains.items command

Let's collect some information. I'm currently running virtual Linux build hosted on [DigitalOcean](https://www.digitalocean.com/):

```bash
# '*' returns all minions
$ sudo salt '*' grains.items
# Few snippets:
slave-1:
    ----------
    biosreleasedate:
        12/12/2017
    biosversion:
        20171212
...
    cpu_model:
        DO-Regular
    cpuarch:
        x86_64
...
    localhost:
        palvelinten-hallinta
    lsb_distrib_codename:
        focal
    lsb_distrib_description:
        Ubuntu 20.04.2 LTS
    lsb_distrib_id:
        Ubuntu
    lsb_distrib_release:
        20.04
...
    saltpath:
        /usr/lib/python3/dist-packages/salt
    saltversion:
        3003
    saltversioninfo:
        - 3003
```

### e) Testing state pkg.installed

#### apache2

Let's try setting up state other than *file.managed*. I'll create state named **init.sls** which ensures the minions have installed *apache2* package and that is is up and running.

```bash
$ sudoedit /srv/salt/apache.sls
# apache2 is Apache server tools, the world's most popular web server
apache2:
  pkg.installed: []
  service.running:
    - require:
      - pkg: apache2

# Apply state 'apache'
$ sudo salt '*' state.apply apache
slave-1:
----------
          ID: apache2
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 03:40:10.247662
    Duration: 33.526 ms
     Changes:   
----------
          ID: apache2
    Function: service.running
      Result: True
     Comment: The service apache2 is already running
     Started: 03:40:10.284083
    Duration: 38.174 ms
     Changes:   

Summary for slave-1
------------
Succeeded: 2
Failed:    0
------------
Total states run:     2
Total run time:  71.700 ms
```

I made a typo on my first run - for the *service.running* check there's misspelled package **apache** (should be apache2). Here's how an eror looks like:
```bash
----------
          ID: apache2
    Function: service.running
      Result: False
     Comment: The following requisites were not found:
                                 require:
                                     pkg: apache
```

#### fortune

Simple setup file for *fortune-mod* package, only for **slave-1** minion:

```bash
$ sudoedit /srv/salt/fortune.sls
fortune-mod:
  pkg.installed: []
$ sudo salt slave-1 state.apply fortune
slave-1:
----------
          ID: fortune-mod
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 03:54:43.919315
    Duration: 32.923 ms
     Changes:   

Summary for slave-1
------------
Succeeded: 1
Failed:    0
------------
Total states run:     1
Total run time:  32.923 ms
```
Everything seems to be fully working!

## Final thoughts

Salt was very interesting topic and would appear extremely useful tool. Setting up master and minions was easy. It took me a few tries to get states to work, mostly typos (as is often the case). I will definitely keep learning more about Salt!

## Sources

Tero Karvinen - [Configuration Management Systems - Palvelinten Hallinta - Spring 2021 h1](https://terokarvinen.com/2021/configuration-management-systems-palvelinten-hallinta-ict4tn022-spring-2021/#h1-hei-maailma-verkon-yli-ja-idempotenssi)

Tero Karvinen - [Salt Quickstart – Salt Stack Master and Slave on Ubuntu Linux](http://terokarvinen.com/2018/salt-quickstart-salt-stack-master-and-slave-on-ubuntu-linux/)

Tero Karvinen - [Salt States – I Want My Computers Like This](http://terokarvinen.com/2018/salt-states-i-want-my-computers-like-this/)

SaltStack - [Salt Project Package Repo](https://repo.saltproject.io/index.html#ubuntu)

SaltStack - [How Do I Use Salt States?](https://docs.saltproject.io/en/latest/topics/tutorials/starting_states.html)

LinuxForDevices - [How to fix “Unable To Locate Package”? – (Fix with APT Sources)](https://www.linuxfordevices.com/tutorials/ubuntu/fix-unable-to-locate-package)

Kristopher Sandoval - [Understanding Idempotency and Safety in API Design ](https://nordicapis.com/understanding-idempotency-and-safety-in-api-design/)

## Edit history

19.05.2021
* Typo fixes
