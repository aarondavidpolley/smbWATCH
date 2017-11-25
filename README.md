# smbWATCH

Scripting for monitoring and unmounting SMB drives

//How To Use//

Download the installer packages from https://github.com/aarondavidpolley/smbWATCH/releases

As of v1.0, you can also pass a "debug" variable running from command line or LaunchAgent for more verbose logging.  For example:

sh /LibraryScripts/smbWATCH.sh debug

or

<key>ProgramArguments</key>
<array>
 <string>/Library/Scripts/smbWATCH.sh</string>
 <string>debug</string>
</array>

Logs are written to ~/Library/Logs/smbWATCH.log

//LICENSE//

This is available under the MIT License: https://github.com/aarondavidpolley/smbWATCH/blob/master/LICENSE
