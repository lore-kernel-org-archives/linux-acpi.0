From: Stephan Herhut <sah-jNDFPZUTrfRKC+uPiMyuuyYxWCU7E+c1@public.gmane.org>
Subject: Kernel 2.6-test10 and /sys/power/state on Thinkpad R32
Date: Wed, 26 Nov 2003 14:05:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069851924.3708.4.camel@hogfather.northernmaniacs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-quDMxCxAWrCr8cYxD8HL"
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


--=-quDMxCxAWrCr8cYxD8HL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

I gave kernel 2.6-test10 a try to test the long-awaited suspend to
ram/disk. I am using fedora core 1 on a ThinkPad R32 with the newest
BIOS available. Everythings works fine, except suspending my thinkpad.

echo {ram|disk} > /sys/power/state

just yields a Preparing for suspend kernel message and afterwards
nothing happens. I can even retry as often as I want to, always only
producing this message.

I use the current kernel rpm from people.radhat.com/arjanv.

Anyone something to try or is this already known?

Thanks
Stephan

--=-quDMxCxAWrCr8cYxD8HL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/xKUTcyUaCzpzST8RAhLHAKDQNSuOOSVjxYKf12JQiG0+Tuv3kQCgwWxV
4MLS5RG9jahWRvcRlTkf+Pc=
=OOW2
-----END PGP SIGNATURE-----

--=-quDMxCxAWrCr8cYxD8HL--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
