From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: bug in acpid scripts
Date: Sat, 24 Jul 2004 16:40:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <410274C5.1050809@pca.it>
References: <20040723193658.GA3331@omocha.vort.org> <1090673420.4412.14.camel@tyrosine> <20040724135111.GC2328@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040724135111.GC2328-MEqNC12sBsHxa7XIdbXXog@public.gmane.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 07/24/04 15:51, Mattia Dongili wrote:
> On Sat, Jul 24, 2004 at 01:50:20PM +0100, Matthew Garrett wrote:
>>My current workaround is to make button support modular, and then remove
>>the button module during suspend. The power button event then gets
>>ignored on wakeup.
> You may simply want to stop acpid just before suspending and restarting
> it after having resumed.
or you can use an hack similar to my script attached (original one at
http://sourceforge.net/mailarchive/forum.php?thread_id=3676335&forum_id=6102
as this problem was already reported in this list).

Thx, bye,
Gismo / Luca

=====
luca@gismo:~/download$ cat /etc/acpi/tbtn_power.sh
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
luca@gismo:~/download$
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBAnTEVAp7Xm10JmkRAjGWAJ9nFHsoIIDg298SXBF4VIDQ6QoK3ACeOBy2
UdlexHHxH2oiVYAOQjtBRM0=
=gB7h
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
