From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: Toshiba Portege 4000 - keyboard is lost every second reboot
Date: Wed, 6 Jul 2005 22:53:20 +0400
Message-ID: <200507062253.26575.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2981675.2gs9eyAumV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
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

--nextPart2981675.2gs9eyAumV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have old P4000 that I intended to install Linux on; I switched it on a=20
couple of times after I got it just see if it works at all. Then I booted M=
dk=20
10.2 (Mandriva LE2005) install CD to see how it would detect devices (the=20
point of interest was WiFi) and suddenly after reboot keyboard was dead (it=
=20
did not respond to any keypress even during normal "Press F12 for boot=20
menu"). I had to switch it off to reboot again.

Currently this has WinXP SP2. After playing around a bit I suddenly discove=
red=20
the same issue under Windows as well. Every second reboot keryboard is "los=
t"=20
=2D I can use mouse to reboot and keyboard is back again. After switching i=
t=20
off keyboard was always present.

Being curious I reconfigured Windows to for normal (non-ACPI) PC - and the=
=20
problem went away (well, apparently P4000 does not support APM so it is=20
possible even switch off in this mode). So the problem is apparently=20
ACPI-related. Also during reboot it behaves quite diferently - with ACPI OS=
=20
it looks like P4000 is switched off and later on.

Anybody has seen it before? It will run Linux that is the reason I ask here=
; I=20
looked for DSDT but none for P4000; any idea what could cause it and how to=
=20
debug?

TIA

=2Dandrey

--nextPart2981675.2gs9eyAumV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCzCimR6LMutpd94wRAh92AKC9MqnpLisOYm61iXT87OLWS5EjuQCeIHqz
3Poxs3sXP8WSnqLvnDLnHAo=
=Fwyg
-----END PGP SIGNATURE-----

--nextPart2981675.2gs9eyAumV--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
