#!/bin/sh
#!/bin/bash
# simple Bash Menu Script by jackluke


printf '\e[96m;%s\a' "$color"

printf "$'\e[40m'BigSur beta snapshot fix by jackluke"

printf "\n\n\n"

clear && printf '\e[3J'
echo "Welcome to the BigSur beta snapshot this should fix sudo mount -uw /"
echo "\nBigSur snapshot fix can't be executed as standard user if you want to suspend the script just press CTRL+Z"
echo "\nto apply this fix your current account password is required\notherwise the script can't process\n"
echo "\nSetting nvram parameter to enforce compatibility check"
sudo nvram boot-args="-no_compat_check"
echo "Done"
echo "\nDetecting and adjusting BigSur APFS Preboot"
diskutil mount Preboot
if [ -e /Volumes/Preboot/*/boot/System/Library/KernelCollections/ ]
then
cd /Volumes/Preboot/*/boot/System/Library/KernelCollections/
cd .. ; cd .. ; cd .. ; cd ..
cd System/Library/CoreServices/
sudo mv PlatformSupport.plist PlatformSupport.plist2
sudo bless --folder /Volumes/Preboot/*/System/Library/CoreServices --label "BigSurFix"
echo "Done"
echo "\nAfter reboot your BigSur should use sudo mount -uw /"
elif [ -e /System/Volumes/Preboot/*/boot/System/Library/KernelCollections/ ]
then
cd /System/Volumes/Preboot/*/boot/System/Library/KernelCollections/
cd .. ; cd .. ; cd .. ; cd ..
cd System/Library/CoreServices/
sudo mv PlatformSupport.plist PlatformSupport.plist2
sudo bless --folder /System/Volumes/Preboot/*/System/Library/CoreServices --label "BigSurFix"
echo "Done"
echo "\nAfter reboot your BigSur should use sudo mount -uw /"
else
echo "\nWarning: you have multiple separate APFS containers to find your correct BigSur APFS Preboot type:\n\ndiskutil unmount Preboot\ndiskutil list | grep Preboot\n(select the largest MB Preboot and mount)\ndiskutil mount diskXsY\n\n"
fi
