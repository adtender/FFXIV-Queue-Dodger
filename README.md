# FFXIV-Queue-Dodger
On server 3001 error, continuously retries login
<br>
On server 2002 error, relaunches the game and puts you back into queue

Works with both the default launcher and FFXIV Quick Launcher but works better and faster with the Quick Launcher. Quick Launcher users must check "Log in automatically" for this script to work. Change the quickLauncher variable on line 10 to 0 if you are not using quick launcher. Quick Launcher users edit lines 27 and 94 to reflect the location of your XIVLauncher.exe. Standard launcher users edit lines 33 and 100 to do the same. Standard launcher users must input their password on line 104. The intended use currently for the standard launcher is to only input the password as it assumes you've checked "Remember Square Enix ID".

Requires AutoHotKey

<h3> This script will not run with two factor authentication!</h3>

Logitech G Hub is also known to make FFXIV not close entirely after exiting. Please turn it off to avoid any issues if applicable.

<h2>Commands</h2>
F3 to toggle on
<br>
F4 to toggle off

F1 to mute audio
<br>
F2 to unmute

<p>F9 to end the script</p>

<h2>Links</h2>
AutoHotKey:<br>
https://www.autohotkey.com

<br>FFXIV Quick Launcher:<br>
https://github.com/goatcorp/FFXIVQuickLauncher

PiP-Tool:<br>
https://github.com/LionelJouin/PiP-Tool
