From: Bill Chmura <bill-AiILL61qbRugSpxsJD1C4w@public.gmane.org>
Subject: Help with my Friggin compag 2701us
Date: Sun, 23 Nov 2003 13:30:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069612236.3685.21.camel@loki>
Reply-To: bill-AiILL61qbRugSpxsJD1C4w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2gVsIL3ymLPJF/jQmY1W"
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


--=-2gVsIL3ymLPJF/jQmY1W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

I am having issues getting my battery power from Linux.  Here are the
stats:

Compaq 2701US : RedHat9 base, Kernel 2.4.22 (from kernel.org), Kde 3.1.4
(from KDE.org)

Shutdown works which is fantastic.  I cannot however get any readings
from my batteries.  I have KLaptop running, which does tell when I am on
AC power versus batteries, but when I am on batteries it thinks I am out
of power.

If I go into /proc and poke around:

/proc/acpi/battery/BAT1 or BAT2/info - says no battery is present under
AC or Battery

/proc/acpi/ac_adapter/ACAD/state - shows off-line or on-line depending
on if I am plugged in (which is where I guess the applet can tell if I
am plugged in or not)

I noticed there were some patches for my kernel, but all of the kernel
how-tos have been taken down on the internet (strange) and that was
pretty much my guide to rebuilding...

If that patch will help, I will give it a try - but I am not sure I
remember how to do it...

Thanks

Bill



--=-2gVsIL3ymLPJF/jQmY1W
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/wPzMTb7le3pxe0IRAtb4AJ9xNux5e+3ZU8xXrB5cJBmm7HHPGQCeMCNW
6FFGEl68r7VJZAR2gjbBQTc=
=rQ7+
-----END PGP SIGNATURE-----

--=-2gVsIL3ymLPJF/jQmY1W--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
