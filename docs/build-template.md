Build Gentoo Template
=====================

All the steps should be run as regular user.

Set up Qubes Builder
--------------------

Clone Qubes Builder:

    git clone https://github.com/QubesOS/qubes-builder.git

Change directory to `qubes-builder`.

Place [override.conf](../builder/override.conf) and
[override.data](../builder/override.data) in root of `qubes-builder`
working directory.

In `qubes-builder` run `setup` script:

    ./setup

Allow script to install missing dependencies. Once all of them are
installed, a dialog will pop up. Find steps how to go through setup
wizard below. You don't really need to follow instructions exactly if
you want to build other stuff in addition to Gentoo template. The steps
below do the minimum to prepare Qubes Builder to build Gentoo template.

1.  Wizard will start with asking whether to import GPG keys one by one.
    Answer "Yes" to all, so plugin repository checkouts can be verified
    successfully. If you experience a problem with importing GPG keys,
    try a different keys server by changing value of `GPG_KEY_SERVER` in
    `setup` script to e.g. `'keys.gnupg.net'`.
2.  In "Choose Which Qubes Release To Use To Build Packages" pick your
    current Qubes release.
3.  In "Choose Source Repos To Use To Build Packages" choose default,
    `QubesOs/qubes-   Stable - Default Repo`. This shouldn't really
    matter for Gentoo Template Builder.
4.  In "Choose Pre-Built Packages Repositories" there's no need to choose
    anything, just continue with "OK".
5.  In "Enable SSH Access" choose "No".
6.  In "Build Template Only" choose "Yes".
7.  In "Template Distribution Selection" unselect all items. There would
    be no `gentoo` present here, but that doesn't matter.
8.  In "Builder Plugins Selection" select `builder-gentoo` and unselect
    everything else.
9.  In "Get sources" choose "Yes". Bare in mind it may take a while to
    fetch all repositories.
10. Once getting sources is complete, continue with "OK". A
    configuration followed by "Template Only Build Steps" should be
    printed. Do not follow those step just yet!

Qubes Builder should be ready to build Gentoo template.


Build the template
------------------

The setup script provides instructions to execute next, but only the
last one is needed to build the template:

    make template

You can follow the log in another terminal instance:

    tail -f build-logs/template-gentoo.log

(It is assumed that `qubes-builder` is the current working directory.)
