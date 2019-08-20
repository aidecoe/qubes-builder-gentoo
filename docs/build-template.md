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
installed, a dialog will pop up.

In "Choose Which Qubes Release To Use To Build Packages" pick your
current Qubes release.

In "Choose Source Repos To Use To Build Packages" choose default,
`QubesOs/qubes-   Stable - Default Repo`. This shouldn't really matter
for Gentoo Template Builder.

In "Choose Pre-Built Packages Repositories" there's no need to choose
anything, just continue with "OK".

In "Enable SSH Access" choose "No".

In "Build Template Only" choose "Yes".

In "Template Distribution Selection" unselect all items. There would be
no `gentoo` present here, but that doesn't matter.

In "Builder Plugins Selection" select `builder-gentoo` and uselect
everything else.

In "Get sources" choose "Yes".

Once getting sources is complete, continue with "OK". A configuration
followed by next steps should be printed.

Qubes Builder should be ready to build Gentoo template.
