From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: my acpid lid scipt
Date: Sat, 29 Mar 2003 11:20:45 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030329182046.2935AF7E5F@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Thought some people might be interested in this... 

My lid script for acpid. When you close the lid it turns off the lcd
backlight, locks xscreensaver and throttles it (so it doesn't run a
bunch of cpu intensive savers no one will see). 
On opening the lid it turns the backlight back on and untrottles
xscreensaver so you can get the cpu intensive ones. 

- --cut--
#!/bin/sh -e

# /etc/acpi/lid-button

# 
# radeontool is avail at: http://fdd.com/software/radeon/
#

if [ `cat /proc/acpi/button/lid/C11D/state  | awk '{print $2}'` == "open" ]; then
#	turn backlight back on
	/usr/local/sbin/radeontool light on 
	/usr/X11R6/bin/xscreensaver-command -unthrottle
elif [ `cat /proc/acpi/button/lid/C11D/state  | awk '{print $2}'` == "closed" ]; then
#	turn off the backlight
	/usr/local/sbin/radeontool light off
#	lock the screen
	/usr/X11R6/bin/xscreensaver-command -throttle
	/usr/X11R6/bin/xscreensaver-command -lock
fi
- --cut--
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+heP93imCezTjY0ERAuXuAJ4tIPKNP7qt8tK5PNuZqSqCDdG3gACgnJTN
z7mMvJhmmPet2C0lKJHOLOU=
=vkn3
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
