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
COOKIES_PATH=~/Library/Cookies

CACHEPATH=~/Library/Caches/com.apple.Safari
HISTORY_PATH=~/Library/Caches/Metadata/Safari/History


if [ $DEBUG = FALSE ]
then
	rm -Rf "$CACHEPATH"
	rm -Rf "${HISTORY_PATH}"
else
	echo "$CACHEPATH"
	echo "${HISTORY_PATH}"
fi


# folders to delete
FOLDERS=(
	"Touch Icons"
	"LocalStorage"
)

FOLDERS_TO_DELETE=(
	"RemoteNotifications"
	"Databases"
	)

# files containing these strings will be deleted
COOKIES_FILES=(
	"Cookies.binarycookies"
	"com.apple.Safari.SearchHelper.binarycookies"
	"com.apple.Safari.SafeBrowsing.binarycookies"
	"com.apple.safari.cookies"
)

FILES=(
	"History" 
	"Downloads" 
	"LastSession" 
	"TopSites" 
	"LocalStorage/http" 
	"WebpageIcons"
	"StorageTracker"
	"SearchDescriptions"
	"UserNotificationPermissions.plist"
	"TopSites.plist"
	"RecentlyClosedTabs.plist"
)


if [ $DEBUG = FALSE ]
then
	ACTION="-exec rm -rf {} +"
else
	ACTION="-print"
fi


FOLDERREGEX=$(join "|" "${FOLDERS[@]}")
FILESREGEX=$(join "|" "${FILES[@]}")
COOKIESREGEX=$(join "|" "${COOKIES_FILES[@]}")


find -E "$SAFARIPATH" -regex ".*/($FOLDERREGEX).*$" -type d -depth 1 $ACTION -o -regex ".*/($FILESREGEX).*$" -type f $ACTION
find -E "$SAFARIPATH" ${FOLDERS_TO_DELETE} -type d $ACTION
find -E "$COOKIES_PATH" -regex ".*/($COOKIESREGEX).*$" -type f $ACTION



