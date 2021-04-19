# h3 | Joonas Kulmala

- [h3 | Joonas Kulmala](#h3--joonas-kulmala)
  - [Exercise goals and enviroment](#exercise-goals-and-enviroment)
  - [Exercises](#exercises)
    - [a) Markdown](#a-markdown)
      - [After rendering](#after-rendering)
      - [Before rendering](#before-rendering)
    - [d) Basic git commands](#d-basic-git-commands)
      - [git log](#git-log)
      - [git diff](#git-diff)
      - [git blame](#git-blame)
    - [e) Dumb git change](#e-dumb-git-change)
    - [f) New salt module](#f-new-salt-module)
    - [d) `/srv/salt` on git](#d-srvsalt-on-git)
  - [Final thoughts](#final-thoughts)
  - [Sources](#sources)
  - [Edit history](#edit-history)

## Exercise goals and enviroment

This week's topic was to learn about the most widely used version control tool [Git](https://git-scm.com/). Git is an amazing piece of software with easy to learn basics which I've personally used ever since first discovering it.

Git repositories can be published on the Internet. One such platform is [GitHub](https://github.com/) which will be used in this exercise.

The exercises for h3 can be found on Tero Karvinen's website [here](https://terokarvinen.com/2021/configuration-management-systems-palvelinten-hallinta-ict4tn022-spring-2021/#h3-versionhallinta).

## Exercises

### a) Markdown

The task was to be written in **Markdown**. And so, here we are.

Please check out the [raw](https://raw.githubusercontent.com/JoonasKulmala/Palvelinten-Hallinta/main/h3/README.md) format of this `README.md` file. GitHub automatically renders Markdown, so it should be interesting to see the syntax before that happens.

Here is Markdown's [Basic Syntax](https://www.markdownguide.org/basic-syntax "Basic Syntax") guide.  

#### After rendering

So *what* **is** ~~Markdonw~~ **Markdown** ***capable*** of?

Here's some examples:

    Code blocks

> Quotations!
> 
>> Woo!

Bullet points?
* no?
* yes!

1. Numbered
2. Lists
   1. Like
3. This

[Hyperlinks](https://www.markdownguide.org/basic-syntax/)

![images](/h3/Resources/Tux_small.png)

[![Twitter Follow](https://img.shields.io/twitter/follow/JoonasKulmala?color=1DA1F2&logo=twitter&style=for-the-badge)](https://twitter.com/intent/follow?original_referer=https%3A%2F%2Fgithub.com%2FcodeSTACKr&screen_name=JoonasKulmala)

<!--[url_direct]: -->
[twitter]: https://twitter.com/JoonasKulmala

#### Before rendering

Here's the part above in plain text before automatic rendering:

```
So *what* **is** ~~Markdonw~~ **Markdown** ***capable*** of?

Here's some examples:

    Code blocks

> Quotations!
> 
>> Woo!

Bullet points?
* no?
* yes!

1. Numbered
2. Lists
   1. Like
3. This

[Hyperlinks](https://www.markdownguide.org/basic-syntax/)

![images](/h3/Resources/Tux_small.png)

[![Twitter Follow](https://img.shields.io/twitter/follow/JoonasKulmala?color=1DA1F2&logo=twitter&style=for-the-badge)](https://twitter.com/intent/follow?original_referer=https%3A%2F%2Fgithub.com%2FcodeSTACKr&screen_name=JoonasKulmala)

<!--[url_direct]: -->
[twitter]: https://twitter.com/JoonasKulmala
```

### d) Basic git commands

Now thay we have a git repository, let's try out some basic git monitoring commands. These will barely scratch the surface; consult [git documentation](https://git-scm.com/doc) for all features.

#### git log

This commands shows repository's commit logs. In my case this repository has a single contributor and multiple commits:

    $ git log
    commit 904e7b811a7a2970a4a0a2085cb977795f96df54 (HEAD -> main, origin/main)
    Author: Joonas Kulmala <joonas.kulmala@protonmail.com>
    Date:   Sat Apr 17 21:52:51 2021 +0300

    Add h3
    ...
    commit 9c274c4996ab370f52fcd9a1139f6f6437d1a314
    Author: Joonas Kulmala <joonas.kulmala@protonmail.com>
    Date:   Tue Apr 6 00:49:43 2021 +0300

    Initial commit

So what do we have here?
* Secure Hash Algorithm (SHA) hash, unique to each commit
* Author's name and email
* Date and time
* Commit message

Besides git documentation, this [guide](https://careerkarma.com/blog/git-log/) by James Gallagher has some good examples on how to utilize this command.

#### git diff

    $ git diff

#### git blame

    # switch to target file's directory
    $ cd /PATH
    $ git blame README.md

### e) Dumb git change

### f) New salt module

### d) `/srv/salt` on git

## Final thoughts

## Sources

Tero Karvinen - [h3](https://www.markdownguide.org/basic-syntax)

Markdown - [Basic Syntax](https://www.markdownguide.org/basic-syntax)

James Gallagher - [Git Log: How to Use It](https://careerkarma.com/blog/git-log/)

## Edit history

<!--[url_direct]: -->
[twitter]: https://twitter.com/JoonasKulmala
[github]: https://github.com/
