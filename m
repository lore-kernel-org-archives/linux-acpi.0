From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M3N and sleep states
Date: Mon, 05 Jan 2004 20:19:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FF9B8AD.2050404@pca.it>
References: <3FED7289.1070201@pca.it> <20031227215137.GA28438@hell.org.pl> <3FF1CD0D.6030602@pca.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010307010801050709000208"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FF1CD0D.6030602-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307010801050709000208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 12/30/03 20:07, Luca Capello wrote:
| sometimes I'm a bit stupid... You're right, there's a PWRF event once
| you resume from S1 and this is the cause for the entering in 'INIT 0'.
| Stopping 'acpid' or renaming the action associated to the PWRF event all
| goes well: I got a complete S1 and a complete resume. There're 2 new
I hacked a little the general 'power-button action' included in the
'acpid', to act correctly even when resuming from S1. I attached it :-)
On my box it works without any problems, even if I don't use a lot S1.

If someone wants to use it, you should modify /etc/acpi/events/power (or
whatever you have associated to 'power-button event') to call this script.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/+bisVAp7Xm10JmkRAs9+AJ9POpmd6AAVk+wYHCv8bjz44axxUgCgg4gc
DKPgh2Gw76+OAqNjspJJhUU=
=fnlB
-----END PGP SIGNATURE-----

--------------010307010801050709000208
Content-Type: application/x-sh;
 name="btn_power.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="btn_power.sh"

#!/bin/sh
#
# /etc/acpi/btn-power.sh
# BASH script which acts when the 'power button' is pressed, causing
#   - shutdown
#
# Useful infos at
#   - http://acpi.sourceforge.net/documentation/sleep.html
#
# (C) 2004 - Gismo / Luca Capello <luca.pca.it> http://luca.pca.it

# shutdown
echo "Checking if resuming from S1..."
if tail -n 5 /var/log/messages | grep 'Restarting tasks... done'
then
	echo "Resuming from S1, so not acting, exited."
	exit 0
else
	echo "Shutdown in progress"
fi

if ps -Af | grep -q '[k]desktop' && test -f /usr/bin/dcop
then
    dcop --all-users ksmserver ksmserver logout 0 2 0 && exit 0
fi
/sbin/init 0

--------------010307010801050709000208--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
