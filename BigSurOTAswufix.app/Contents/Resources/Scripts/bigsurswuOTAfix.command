#!/bin/sh
#!/bin/bash
# simple Bash Menu Script by jackluke

printf '\e[96m;%s\a' "$color"
printf "$'\e[40m'OTA Software update beta fix by jackluke"
clear && printf '\e[3J'
echo "\n\nWelcome to the BigSur OTA Software update beta fix"
echo "\nUse keyboard arrows or mouse and trackpad scrolling to read this report"
echo "\nDetecting your OTA dist file"
if [ -e /Library/Updates/*-*/*-*.dist ]
then
echo "\nYour OTA dist file is correctly detected"
echo "\nSetting nvram parameter to enforce any AMFI compatibility check"
sudo nvram boot-args="-no_compat_check amfi_get_out_of_my_way=1"
sudo defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true
echo "\nChecking library validation"
sudo defaults read /Library/Preferences/com.apple.security.libraryvalidation.plist
echo "\nAny AMFI disable library validation method is applied to BigSur"
echo "\nDetecting machine board id"
Macmid="$(sysctl -n hw.model)";
echo "\nYour machine model is ${Macmid}"
Macmidswap='s/\'${Macmid}'/MacExample7,0/';
Boardid="$(ioreg -l | grep "board-id" | awk -F\" '{print $4}')";
echo "\nYour machine board number is ${Boardid}\n"
Boardidswap='s/Mac-9AE82516C7C6B903/\'${Boardid}'/';
OTAdist="$(ls -l /Library/Updates/*-*/*-*.dist)";
cd /Library/Updates/*-*/
echo "\nPatching the OTA dist file\n${OTAdist}"
sudo perl -i -pe ${Boardidswap} /Library/Updates/*-*/*-*.dist
echo "\nDone"
echo "\nLet the OTA update to complete through its automatic phases, after apply the known BigSur post install patches\n"
else
echo "\nWARNING: You need to run first the Sotware Update fix to allow Beta Updates\nif you already done it, then the BigSur OTA dist is not yet ready or downloaded\n\nCheck again your Software Update panel if a new update is available and start to Download the OTA update clicking the Update Now button, then download at least 1% and after a minute retry the OTA fix button\n"
fi