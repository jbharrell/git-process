# CHANGELOG - 1.0.5 #

### Since 1.0.4 ###

* Do not try to fetch/push when doing sync if there is not remote. (GH-70)
* git-sync now merges in upstream changes. (GH-79)
* Simplified Windows installation instructions. (GH-76 GH-77)

### Since 1.0.3 ###

* Gets rid of infinate loop in Highline library. (GH-72)

### Since 1.0.2 ###

* Removes the last of the gem dependencies that require native code. This makes it fully compatible
  with systems like Windows.
* Adds an option to explicitly set the remote server name.

### Since 1.0.1 ###

* Changes to dependencies to allow this to work on both Ruby 1.8 and 1.9

### Since 0.9.7 ###

* Adds --keep option to git-to-master
* Fixes problem trying to add/remove an empty list of files
* Documentation updates

### Since 0.9.7 ###

* Adds --keep option to git-to-master
* Fixes problem trying to add/remove an empty list of files
* Documentation updates

### Since 0.9.6 ###

* Cleans up Gem dependencies

### Since 0.9.5 ###

* Cleans up some error messages
* Improved documentation
* Adds support for spaces and renames in Status
* No longer complains if it can't find _parking_
* Prompts to remove the local version of the integration branch
* Adds help for handling changed files