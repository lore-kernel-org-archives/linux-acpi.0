From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: clear/enable power button on resume
Date: Sun, 07 Mar 2004 20:38:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <404B7A1B.80006@pca.it>
References: <1078685555.541.9.camel@sunshine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1078685555.541.9.camel-eqrHSpLoP5M@public.gmane.org>
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

on 03/07/04 19:52, Timo Hoenig wrote:
> after trying 2.6.4-rc1 I discovered some strange behavior: My machine
> simply shut down after resuming from S3.
>
> Since [ACPI] ACPICA 20040220 from Bob Moore there is code to
> clear/enable the power button on resume in acpi_leave_sleep_state().
> This leads to an acpi event which is handled by acpid if active. In my
> case acpid executed the corresponding shutdown script.
>
> I guess this is going to clutter many people.
this is a known problem at least for resuming from S1, please refers to the
thread called 'ASUS M3N and sleep states' started 20031227 by me or the direct
link to the relevant post here:
http://sourceforge.net/mailarchive/forum.php?thread_id=3676335&forum_id=6102

BTW, my simple workaround for S1 is using this trick on the ACPI power button
script:
=====
#!/bin/sh
#
# /etc/acpi/btn-power.sh

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
=====

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAS3oaVAp7Xm10JmkRAha3AJsF9j0VIFD4DHxXq/n8KpmgYiTFDACcCZ63
8pP1UHalIUnSpiRfibleBkU=
=58ik
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
