#!/bin/sh

# Pass argument "dry-run" to list which files will be deleted without actually deleting them
if [ "$1" == "dry-run" ]
then
	DEBUG=TRUE
else
	DEBUG=FALSE
fi


function join { local IFS="$1"; shift; echo "$*"; }

OPERAPATH=~/Library/Application\ Support/com.operasoftware.OperaNext
CACHEPATH=~/Library/Caches/com.operasoftware.OperaNext

if [ $DEBUG = FALSE ]
then
	rm -Rf "$CACHEPATH"
else
	echo "$CACHEPATH"
fi


# folders to delete
FOLDERS=(
	"Application Cache" 
	"Crash Reports" 
	"databases" 
	"File System" 
	"GPUCache" 
	"IndexedDB"
	"Pepper Data" 
	"Service Worker" 
	"Session Storage" 
	"Storage"
)

# files containing these strings will be deleted
FILES=(
	"Cookies" 
	"Current" 
	"Favicons" 
	"History" 
	"Origin Bound Certs"
	"QuotaManager" 
	"stash" 
	"thumbnails" 
	"Top Sites" 
	"Visited Links" 
	"WebRTCIdentityStore" 
	"Web Data" 
	"Local Storage/http"
)


if [ $DEBUG = FALSE ]
then
	ACTION="-exec rm -rf {} +"
else
	ACTION="-print"
fi


FOLDERREGEX=$(join "|" "${FOLDERS[@]}")
FILESREGEX=$(join "|" "${FILES[@]}")

find -E "$OPERAPATH" -regex ".*/($FOLDERREGEX).*$" -type d -depth 1 $ACTION -o -regex ".*/($FILESREGEX).*$" -type f $ACTION