# h6 | Joonas Kulmala

## Exercise goals and enviroment

This week is mostly about preparations for h7, specifically planning our own modules.

## Exercises

The name of the course is 'Linux Servers' but that doesn't mean we shouldn't try using Salt with Windows machines right?

Note: remember to allow connections to salt-master via ports 4505 & 4506. E.g. with UFW:

	$ sudo ufw allow 4505/tcp
	$ sudo ufw allow 4506/tcp

### a) Kokeile Saltia Windowsissa

#### Establishing master-minion connection

For this I'll be using my Windows PC as salt-minion and Linux Laptop as salt-master.

Downloading salt-minion on Windows is as easy as it gets - you can grab the `.exe` from here: [Windows](https://docs.saltproject.io/en/latest/topics/installation/windows.html).

![Installing salt-minion](/Resources/windows_salt-minion_install.png)

![Configuring minion](/Resources/salt-minion_config)

Once installed, run Windows PowerShell/similar as administrator and type the following command:

	sc start salt-minion

Salt minion should have started and attempted contant with salt master. Back at Linux salt master, accept the key:

	# -L to see all keys, -A accepts	
	$ sudo salt-key -A

![windows-minion accepted](/Resources/windows-minion_accepted)

Let's test the connection:

	master $ sudo salt windows-minion test.ping
	windows-minion:
	    True

#### Testing salt states

Now that master has accepted a new minion, let's try out some basic states.

## Final thoughts

## Sources

## Edit history
