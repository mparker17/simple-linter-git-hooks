# simple-linter-git-hooks

A collection of simple linting templates to use with icefox/git-hooks.

# Prerequisites

## Required

1. Download and install the [Git version control system](https://git-scm.com/).
    Exactly how you do this will depends on the type of computer you have, e.g.:

        $ brew install git # MacOS with the Homebrew package manager.
        $ sudo apt install git # Linux with the Advanced Package Tool package manager.
        $ sudo yum install git # Linux with the Yellowdog Update Manager package manager.

2. Download [icefox/git-hooks](https://github.com/icefox/git-hooks) and add
    it's `git-hooks` script to your shell's `$PATH`, e.g.:

        $ git clone --recursive https://github.com/icefox/git-hooks.git
        $ # If you use the Bourne-again Shell (bash):
        $ echo "export PATH=\$PATH:$PWD/git-hooks" | tee -a $HOME/.bashrc
        $ # If you use the Friendly Interactive Shell (fish):
        $ echo "set PATH \$PATH $PWD/git-hooks" | tee -a $HOME/.config/fish/config.fish

## Optional

Many of the `pre-commit` hooks call other programs to perform linting on files
you're about to commit. You'll need to install the appropriate program(s) for
the type of file(s) you want to lint:

* Syntax linters:
    * If you want to syntax-lint Bourne-again Shell scripts, you will need to
        install [GNU Bash](https://www.gnu.org/software/bash/).

            $ which bash # returns a path if it is installed properly.

    * If you want to syntax-lint Friendly Interactive Shell scripts, you will
        need to install the [fish shell](http://fishshell.com/).

            $ which fish # returns a path if it is installed properly.

    * If you want to syntax-lint JavaScript files, you will need to install
        [Node.js](https://nodejs.org/).

            $ which node # returns a path if it is installed properly.

    * If you want to syntax-lint PHP files, you will need to
        [install PHP](http://php.net/manual/install.php).

            $ which php # returns a path if it is installed properly.

    * If you want to syntax-lint SCSS files, you will need to install
        [Sass](https://github.com/sass/sass#using).

            $ which scss # returns a path if it is installed properly.

* Style linters:
    * If you want to style-lint CSS files, you will need to
        [install CSSLint](https://github.com/CSSLint/csslint/wiki/Command-line-interface).

            $ which csslint # returns a path if it is installed properly.

    * If you want to style-lint PHP files, you will need to
        [install PHPCodeSniffer and the Drupal Coder sniffs](https://www.drupal.org/node/1419988).

            $ which phpcs # returns a path if PHPCodeSniffer is installed properly.
            $ phpcs -i # lists Drupal if the Drupal Coder Sniffs are installed properly.

    * If you want to style-lint JS files, you will need to
        [install ESLint](http://eslint.org/docs/user-guide/getting-started#local-installation-and-usage).

            $ which eslint # returns a path if it is installed properly.

    * If you want to style-lint Puppet files, you will need to
        [install puppet-lint](https://github.com/rodjek/puppet-lint#installation).

            $ which puppet-lint # returns a path if it is installed properly.

    * If you want to style-lint Ruby files, you will need to
        [install Rubocop](https://github.com/bbatsov/rubocop#installation).

            $ which rubocop # returns a path if it is installed properly.

    * If you want to style-lint SCSS files, you will need to
        [install SCSS-lint](https://github.com/brigade/scss-lint#installation).

            $ which scss-lint # returns a path if it is installed properly.

    * If you want to style-lint Bourne-again Shell scripts, you will need to
        [install ShellCheck](https://github.com/koalaman/shellcheck#installing).

            $ which shellcheck # returns a path if it is installed properly.

* Best-practice linters:
    * If you want to best-practice-lint PHP files, you will need to
        [install PHPCodeSniffer and the Drupal Coder sniffs](https://www.drupal.org/node/1419988).

            $ which phpcs # returns a path if PHPCodeSniffer is installed properly.
            $ phpcs -i # lists DrupalPractice if the Drupal Coder Sniffs are installed properly.

# Install

1. Download this repository:

        $ cd $HOME/Documents/Reference # or wherever you want
        $ git clone --recursive https://github.com/mparker17/simple-linter-git-hooks.git

# Use

1. Set up `icefox/git-hooks` in the repository you want to run these linters in:

        $ cd /path/to/repo
        $ git hooks install

2. Create a folder for these hooks:

        $ cd /path/to/repo
        $ mkdir git_hooks
        $ # or, `mkdir .githooks` if you'd prefer
        $ cp -r $HOME/Documents/Reference/simple-linter-git-hooks/pre-commit git_hooks/
        $ # or, `cp -r $HOME/Documents/Reference/simple-linter-git-hooks/pre-commit .githooks/` if you did that in the previous step
        $ git hooks # will list all the hooks if you did that correctly

    **This project is designed to be a template you can customize**, so once you
    have installed these linter templates, feel free to:

    * delete any linters that you do not want to use,
    * customize any linters according to your / your team's preferences, and/or,
    * commit the linters to your repo for everyone on your team to use.
        * If the rest of your team is not comfortable with running linters in
            their pre-commit hooks, and/or committing them to the repository,
            `echo "/git_hooks" | tee -a .git/info/exclude` will tell Git to
            ignore them. If you want to stop ignoring them, you'll have to open
            the `.git/info/exclude` file and delete the `/git_hooks` line.

3. Work normally, and commit your work using the command-line.

    The linter scripts that begin with `1-` will abort the commit if the linter
    returns an "unsuccessful" error code to bash (i.e.: non-zero). These linters
    are syntax-linters, meaning trying to compile or run the code in those files
    will certainly result in a fatal error. This behavior is based upon the
    assumption that you would never want to intentionally commit things that did
    that!

    All other linter scripts will allow the commit to happen, but will display
    their output, giving you the option of fixing the code and either amending
    the last commit, or creating a new commit with the fixes depending on your /
    your team's preference.

# Notes

**If you use a third-party GUI** (e.g.: Github Desktop, Atom, Sourcetree, Tower,
etc.) **your mileage may vary**. You will need to check your GUI's documentation
to determine:

1. Does it actually run pre-commit hooks upon commit?
2. Will it allow pre-commit hooks to abort a commit?
3. Does the GUI have a way to display the messages that the pre-commit hooks
    spit out, *even if the commit does not fail*?

Because there are so many GUIs available, and because I currently prefer to use
the command-line for most (but not all) operations, I have no current plans for
this project to support git GUIs.
