# BigSurfixes
Big Sur fixes for unsupported Mac

Prelinkedkernel fix

to support Big Sur booting on non-APFS mac or APFS firmware mac

BigSur added the BootKernelExtensions.kc as the new kernelcache with new command kmutil

but kextcache command and prelinkedkernel are still working

to apply the prelinkedkernel fix after BigSur Install:

diskutil mount Preboot

diskutil apfs list

Locate your BigSur Data Volume UUID

replace the "prelinkedkernel fix" file in this path:

/Volumes/UUID-BigSur/System/Library/CoreServices/

replace the "patched prelinkedkernel beta1" in this path:

/Volumes/UUID-BigSur/System/Library/PrelinkedKernels/