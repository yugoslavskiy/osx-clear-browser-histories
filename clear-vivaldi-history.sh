#!/bin/sh

# Change this to the specific user profile folder you want to clear the history of
PROFILE_FOLDER=Default

# Pass argument "dry-run" to list which files will be deleted without actually deleting them
if [ "$1" == "dry-run" ]
then
	DEBUG=TRUE
else
	DEBUG=FALSE
fi


function join { local IFS="$1"; shift; echo "$*"; }

VIVALDI_FOLDER=~/Library/Application\ Support/Vivaldi
CACHE_FOLDER=~/Library/Caches/Vivaldi
VIVALDIPATH=$VIVALDI_FOLDER/$PROFILE_FOLDER
CACHEPATH=$CACHE_FOLDER/$PROFILE_FOLDER

if [ $DEBUG = FALSE ]
then
	rm -Rf "$CACHEPATH"
else
	echo "$CACHEPATH"
fi


# folders to delete
FOLDERS=(
	"databases"
	"GPUCache" 
	"IndexedDB" 
	"Pepper Data" 
	"Session Storage" 
	"Storage" 
)

# files containing these strings will be deleted
FILES=(
	"Cookies" 
	"Current" 
	"Favicons" 
	"History" 
	"Last" 
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

find -E "$VIVALDIPATH" -regex ".*/($FOLDERREGEX).*$" -type d -depth 1 $ACTION -o -regex ".*/($FILESREGEX).*$" -type f $ACTION