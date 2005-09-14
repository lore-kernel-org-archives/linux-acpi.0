From: giskard <giskard-GaUfNO9RBHfsrOwW+9ziJQ@public.gmane.org>
Subject: standby problem
Date: Wed, 14 Sep 2005 19:45:45 +0200
Message-ID: <1126719945.4563.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FZdJLQ/Ki8439YSSkzSM"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-FZdJLQ/Ki8439YSSkzSM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello,

i wanted to know what's mean this error :)

mrspurr:/home/giskard# echo standby > /sys/power/state
acpi_pm_prepare does not support 1

means that my laptop doesn't supporto standby mode?

another question: i can suspend to ram my laptop without problems (echo
mem > /sys/power/state) but when i try to resume it i get a black screen
and then i need to reboot it. i need to do something else for resume
it?=20

i have a:
satellite a80-111
linux 2.6.13 with suspend2.net patch
=20
--=20
ciao giskard

non ho peli sulla lingua. e se ce li ho... non sono miei.

--=-FZdJLQ/Ki8439YSSkzSM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDKGHJokwHIYS/ecgRAqBNAJ0SvQ2FFcxxRTonuQXNhFrpdlzFzQCfQudl
YnwbYMK83G5UsvPqa+h8WLI=
=zb3y
-----END PGP SIGNATURE-----

--=-FZdJLQ/Ki8439YSSkzSM--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
