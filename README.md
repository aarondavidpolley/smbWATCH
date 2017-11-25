# smbWATCH

Scripting for monitoring and unmounting SMB drives

//How To Use//

Download the repo and edit the smbWATCH.sh file.  Adjust the "Variables To Edit" section, save, and then build the installer using the Packages App Project file included.  See:

http://s.sudre.free.fr/Software/Packages/about.html

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
