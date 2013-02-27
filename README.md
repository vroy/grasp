# Grasp

Interactive screenshots on Mac.

## Features

* Use the same shortcuts as the native screenshot tool.
* Interactive screenshot (area or window, toggled with space).
* Enter filename after screenshot.
* Automatically organized in subdirectories for each day.
* Prompt to annotate with Preview.
* Share on Dropbox and copy public url to clipboard.

## Installation

    gem install grasp

And follow the instructions on the screen to set up the rest.

## Configuration

Environment variables can override the default directories:

`GRASP_SCREENSHOTS_DIR` stores the screenshots. Defaults to `~/Screenshots/`

`GRASP_DROPBOX_DIR` points to your Public Dropbox folder. Screenshots
are symlinked to the `GRASP_SCREENSHOTS_DIR` location. If set to
empty, Share prompt will be skipped. Defaults to `~/Dropbox/Public/`

`GRASP_NO_DATES` Dumps all of the screenshots into
`GRASP_SCREENSHOTS_DIR` without organizing them in subdirectories.

## Requirements

* Ruby?
* Mac x.x?
* Automator?
* Applescript (osascript)?
* screencapture?

## Author

Vincent Roy :: vince@vroy.ca
