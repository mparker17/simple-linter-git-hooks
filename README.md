# simple-linter-git-hooks

A collection of simple linting templates to use with icefox/git-hooks.

**This project is designed to be a template**. I suggest cloning this repository
to your Documents folder, and only copying the parts of it that you want to use
into your project.

# Prerequisites

1. Download and install the
    [GNU Bourne-again Shell](https://www.gnu.org/software/bash/) (bash), because
    the scripts in the `pre-commit/` folder depend on it to run.

    Exactly how you do this will depend on the type of computer you have, e.g.:

        $ brew install bash      # macOS with the Homebrew package manager
        $ sudo apt install bash  # Debian or Ubuntu linux

    You are welcome to use another shell (I personally use
    [fish](https://fishshell.com/), but bash still needs to be installed for
    this project's scripts to work).

2. Download and install the [Git version control system](https://git-scm.com/).
    Exactly how you do this will depend on the type of computer you have, e.g.:

        $ brew install git      # macOS with the Homebrew package manager
        $ sudo apt install git  # Debian or Ubuntu linux

3. Download [icefox/git-hooks](https://github.com/icefox/git-hooks):

        $ cd $HOME/Documents/Tools  # or wherever you want
        $ git clone --recursive https://github.com/icefox/git-hooks.git

4. Add icefox/git-hooks to your shell's `$PATH` variable.

    Exactly how you do this will depend on the shell you use. Some common
    examples are:

        $ cd $HOME/Documents/Tools/git-hooks # or wherever you cloned icefox/git-hooks in the last step
        $ echo "export PATH=\$PATH:$PWD/git-hooks" | tee -a $HOME/.bashrc  # If you use bash
        $ echo "export PATH=\$PATH:$PWD/git-hooks" | tee -a $HOME/.zshrc   # If you use zsh
        $ echo "set PATH \$PATH $PWD/git-hooks" | tee -a $HOME/.config/fish/config.fish  # If you use fish

Many of the `pre-commit` hooks are simple wrappers that call other programs; and
the other programs do the "real" work of linting. Please refer to the comment at
the top of each script in the `pre-commit` folder for more information about
what it requires in order to work.

# Install

1. Clone this repository

        $ cd $HOME/Documents/Templates  # or wherever you want
        $ git clone --recursive https://github.com/mparker17/simple-linter-git-hooks.git

# Use

1. Set up `icefox/git-hooks` to run in the repository that you want to lint:

        $ cd /path/to/your/project/repo
        $ git hooks --install

    Git detects the script named `git-hooks` in your `$PATH` (i.e.: at
    `$HOME/Documents/Tools/git-hooks/git-hooks`), and makes it available as a
    `git` sub-command automatically.

    When you cloned or initialized your project, git automatically put a bunch
    of hook template scripts in `.git/hooks/` - icefox/git-hooks replaces them
    with its own scripts. These scripts scan a certain set of folders, and runs
    all the scripts inside those folders instead. You'll set up these folders in
    the next step.

2. Create a folder for these hooks. `icefox/git-hooks` allows you to use either
    a folder named `git_hooks`, or a folder named `.githooks`

        $ cd /path/to/your/project/repo
        $ mkdir -p .githooks/pre-commit
        $ # or
        $ mkdir -p git_hooks/pre-commit

    It doesn't matter what name you choose; but you'll have to remember which
    you chose later. I personally prefer `.githooks`.

3. Optional: If you are working on a team, and your team is not yet ready to
    commit these hooks to the repository, you can tell Git to temporarily ignore
    them, so that you can still use them:

        $ cd /path/to/your/project/repo
        $ echo "/.githooks" | tee -a .git/info/exclude
        $ # or
        $ echo "/git_hooks" | tee -a .git/info/exclude

4. Copy the hooks that you want to use from this repository into your project.
    Make sure that you copy them to the `pre-commit` folder inside the
    `git_hooks` or `.githooks` folder, otherwise git won't know when to run
    them!

    If you're not sure where to start, you can copy everything:

        $ /path/to/your/project/repo
        $ cp $HOME/Documents/Templates/simple-linter-git-hooks/pre-commit/* .githooks/pre-commit/
        $ # or
        $ cp $HOME/Documents/Templates/simple-linter-git-hooks/pre-commit/* git_hooks/pre-commit/

5. Check that you installed the hooks properly:

        $ git hooks

    If you installed them properly, then it should list all the hooks you copied
    over.

6. Work normally, and commit your work using the command-line.

    If you prefer to use git through your editor (e.g.: Atom's "Git" or "Github"
    pane, IntelliJ's Version Control tab, Visual Studio Code's Source Control
    pane), or a GUI (Github Desktop, Atom, Sourcetree, Tower, etc.), it may not
    know how to run these linters. You will need to check your GUI's
    documentation, or simply test to see if it works.

# Questions and answers:

1. Do you plan to support my editor or Git GUI?

    No. There are so many GUIs available and they change so frequently that I
    don't have time to follow all of their changes. Remember I maintain this
    project on a volunteer basis. Also note that the only officially-supported
    user interface for Git is the command-line.

2. Why are the linter filenames prefixed with `1-`, `2-`, and `3-`?

    It sets the order that they run in, and establishes a sort of priority.

    Currently, all of the linters whose names start with `1-` check a file's
    syntax; all of the linters whose names start with `2-` check a file's style,
    and all of the linters whose names start with `3-` check if a file conforms
    to best practices.

    Since syntax errors will result in a compilation and/or runtime error, I
    generally want to run those first, so I can fix them first, before I worry
    about things like style and best practices.

    Also some style linters tend to get really confused and spit out errors that
    don't actually exist when there is a syntax error, so fixing syntax first is
    usually more efficient. Likewise, some best-practices issues will go away
    when you start conforming to the style that the style linter is checking.

    Note that, as a general rule, the (syntax) linters prefixed with `1-` will
    abort the commit if they detect a problem, and the other linters will not.
    See the next question for more information about this behavior.

3. Will this abort my commit if my whitespace is wrong or my style is bad?

    The answer depends on your programming language, but as a general rule, no.

    A syntax error will usually result in a fatal runtime or compilation error,
    so I generally don't want to commit code with syntax errors. For this reason
    all of the syntax linters (the ones prefixed with `1-`) will abort a commit.

    The other (`2-` style, and `3-` best-practice) linters will write messages
    to your console to notify you of problems, but will let the commit finish.
    If you care about conforming to style and best practices, then you can fix
    them and amend the commit or make a follow-up commit at your discretion.

    That being said, in a language like Python, where whitespace determines the
    structure of the program, you probably want to be a bit more strict with
    whitespace errors and abort the commit. There are instructions in each
    script for how to change that behavior.

4. Can I make my own hooks?

    Yes, feel free to use the ones in this repo as a template. There should be
    enough documentation in each script for someone with basic shell-scripting
    knowledge to make their own.

    On systems that use POSIX permissions, you'll need to make the script
    executable in order for it icefox/git-hooks to consider it valid
    (`chmod u+x $script`).

    I usually copy `pre-commit/1-unresolved-merge.sh` to
    `$HOME/.git_hooks/pre-commit/1-mparker17.sh` and modify it grep for my name
    so that I don't accidentally leave debugging code like "mparker17 was here".

5. What if I want another type of hook, e.g.: `post-commit` or `post-receive`?

    Create a `post-commit` or `post-receive` folder, and put your script in that
    folder instead. See [icefox/git-hooks](https://github.com/icefox/git-hooks)
    for more information.

6. If git made me a bunch of script templates, why do I need icefox/git-hooks?

    Essentially, icefox/git-hooks makes it way easier to use git's hook system.

    Out-of-the-box, git only supports one single script file per event (e.g.:
    one file to contain all of your pre-commit hooks, one file to contain all of
    your post-receive hooks, etc.). This means you would have to try to jam all
    of your linters into that one file. From a maintainability standpoint, this
    is a nightmare.

    Furthermore, you cannot commit git hooks at their default location inside
    the `.git` folder, which is frustrating because a large script to run all
    your linters is complex enough that version controlling that script would be
    quite valuable! Icefox/git-hooks lets you commit your hooks (if you want).
