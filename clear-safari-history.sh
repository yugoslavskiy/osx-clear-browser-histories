#!/bin/sh

# Pass argument "dry-run" to list which files will be deleted without actually deleting them
if [ "$1" == "dry-run" ]
then
	DEBUG=TRUE
else
	DEBUG=FALSE
fi


function join { local IFS="$1"; shift; echo "$*"; }

SAFARIPATH=~/Library/Safari
CACHEPATH=~/Library/Caches/com.apple.Safari
HISTORY_PATH=~/Library/Caches/Metadata/Safari/History
COOKIES_PATH=~/Library/Cookies/Cookies.binarycookies

if [ $DEBUG = FALSE ]
then
	rm -Rf "$CACHEPATH"
	rm -Rf "${HISTORY_PATH}"
	rm -Rf "${COOKIES_PATH}"
else
	echo "$CACHEPATH"
	echo "${HISTORY_PATH}"
	echo "${COOKIES_PATH}"
fi


# files containing these strings will be deleted
FILES=(
	"History" 
	"Downloads" 
	"LastSession" 
	"TopSites" 
	"LocalStorage/http" 
	"WebpageIcons"
)


if [ $DEBUG = FALSE ]
then
	ACTION="-exec rm -rf {} +"
else
	ACTION="-print"
fi

FILESREGEX=$(join "|" "${FILES[@]}")

find -E "$SAFARIPATH" -regex ".*/($FILESREGEX).*$" -type f $ACTION