#!/bin/sh

# Change this to the specific user profile folder you want to clear the history of
PROFILE_FOLDER=Default

# System-wide cache and sensitive info
SHARED_CACHE_FOLDER=ShaderCache
CRASH_REPORTS_FOLDER=Crashpad

# Pass argument "dry-run" to list which files will be deleted without actually deleting them
if [ "$1" == "dry-run" ]
then
	DEBUG=TRUE
else
	DEBUG=FALSE
fi


function join { local IFS="$1"; shift; echo "$*"; }

CHROMIUM_FOLDER=~/Library/Application\ Support/Chromium
CACHE_FOLDER=~/Library/Caches/Chromium
CHROMIUMPATH=$CHROMIUM_FOLDER/$PROFILE_FOLDER
CACHEPATH=$CACHE_FOLDER/$PROFILE_FOLDER

SHARED_CACHEPATH=$CHROMIUM_FOLDER/$SHARED_CACHE_FOLDER
CRASH_REPORTS_PATH=$CHROMIUM_FOLDER/$CRASH_REPORTS_FOLDER

if [ $DEBUG = FALSE ]
then
	rm -Rf "$CACHEPATH"
	rm -Rf "$SHARED_CACHEPATH"
	rm -Rf "$CRASH_REPORTS_PATH"
else
	echo "$CACHEPATH"
	echo "$SHARED_CACHEPATH"
	echo "$CRASH_REPORTS_PATH"
fi


# folders to delete
FOLDERS=(
	"Application Cache" 
	"File System" 
	"GCM Store" 
	"GPUCache" 
	"IndexedDB" 
	"Pepper Data" 
	"Service Worker" 
	"Session Storage" 
	"Storage" 
	"data_reduction_proxy_leveldb" 
	"databases"
)

# files containing these strings will be deleted
FILES=(
	"Cookies" 
	"Current" 
	"Favicons" 
	"History" 
	"Last" 
	"Network Action Predictor" 
	"Network Persistent State" 
	"Origin Bound Certs" 
	"QuotaManager" 
	"Shortcuts" 
	"Top Sites" 
	"Visited Links" 
	"WebRTCIdentifyStore" 
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

find -E "$CHROMIUMPATH" -regex ".*/($FOLDERREGEX).*$" -type d -depth 1 $ACTION -o -regex ".*/($FILESREGEX).*$" -type f $ACTION