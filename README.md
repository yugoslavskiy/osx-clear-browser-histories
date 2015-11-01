#Clear OSX Browser Histories

These shell scripts clear the private data (browsing histories) of Google Chrome, Apple Safari, and Opera Next on OSX. Unlike Firefox, these browsers do not offer the option to automatically clear all private data upon browser exit. 

This has been tested with OSX El Capitan, but should work for Yosemite and Mountain Lion.




####**Removal includes:**

* Browsing History
* Saved Windows/Tabs from Last Browser Session
* Cookies, Local Storage
* Favicons
* Top Sites
* Cache Files
* Shortcuts
* Visited Links
* Listing of Downloaded Files (but not the files themselves)

####**The scripts do NOT remove:**

* Bookmarks
* Browser Configuration Settings
* Extensions and Extension Settings


##USAGE

Open terminal and run this command:

```
sh clear-chome-history.sh
```

To list which folders/files would be deleted, without actually deleting them:

```
sh clear-chome-history.sh dry-run
```


##NOTES


1. **Browser startup times will be slightly longer**  
This is because each browser regenerates blank versions of the folders/files removed by the scripts on startup.
2. **Backup your browser data BEFORE using these scripts**  
Though I've been using these scripts for sometime without issue, I simply cannot test every unique combination of browser configuration settings and user installed extensions. *I highly recommend making backups of your browsers before using the scripts, instructions for which are included below.*
3. **Ideally the scripts should be run automatically when quitting Chrome, Safari or Opera**  
I use [Keyboard Maestro](https://www.keyboardmaestro.com/main/) to have these scripts automatically run anytime I quit Chrome, Safari, or Opera. However, if anyone is aware of a free / open-source app that can do the same thing, please submit an issue and let me know and I'll include that in the instructions here.

-

#####**To make backups:**  
Ensure Chrome, Safari and Opera are completely closed and not running, then use the following terminal commands to backup each browser's data in a "Browser_Backups" folder on your desktop:

```
mkdir ~/Desktop/Browser_Backups  
cp -R ~/Library/Application\ Support/Google/Chrome ~/Desktop/Browser_Backups
cp -R ~/Library/Safari ~/Desktop/Browser_Backups
cp -R ~/Library/Application\ Support/com.operasoftware.OperaNext ~/Desktop/Browser_Backups
```
#####**To restore from backups:**  
Ensure Chrome, Safari and Opera are completely closed and not running, then use the following terminal commands:

```
rm -Rf ~/Library/Application\ Support/Google/Chrome
cp -R ~/Desktop/Browser_Backups/Chrome ~/Library/Application\ Support/Google/

rm -Rf ~/Library/Safari
cp -R ~/Desktop/Browser_Backups/Safari ~/Library/

rm -Rf ~/Library/Application\ Support/com.operasoftware.OperaNext
cp -R ~/Desktop/Browser_Backups/com.operasoftware.OperaNext ~/Library/Application\ Support/
```


DISCLAIMER
----------
Please note: all files in this repo are released for use "AS IS" **without any warranties of any kind**,
including, but not limited to their installation, use, or performance.  We disclaim any and all warranties, either 
express or implied, including but not limited to any warranty of noninfringement, merchantability, and/ or fitness 
for a particular purpose.  We do not warrant that the technology will meet your requirements, that the operation 
thereof will be uninterrupted or error-free, or that any errors will be corrected.

Any use of these scripts and tools is **at your own risk**.  There is no guarantee that they have been through 
thorough testing in a comparable environment and we are not responsible for any damage or data loss incurred with 
their use.

You are responsible for reviewing and testing any scripts you run *thoroughly* before use in any non-testing 
environment.