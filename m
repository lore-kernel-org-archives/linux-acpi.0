From: Pere =?ISO-8859-15?Q?Casta=F1er?= <XaRz69-pCzzcW6XgXY@public.gmane.org>
Subject: acpi-20031203-2.6.0.diff brokes the battery status readings with
 2.6.0 in DELL Inspiron 8500
Date: Fri, 19 Dec 2003 01:00:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031219010004.179b5059.XaRz69@terra.es>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__19_Dec_2003_01_00_04_+0100_ExhadzM.n5P7/0zW"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Signature=_Fri__19_Dec_2003_01_00_04_+0100_ExhadzM.n5P7/0zW
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've just aplyied last patch into 2.6.0 stable release and it brokes the ba=
ttery monitor from acpi in /proc/acpi/battery/BAT0/status...because of this=
 gnome-battery applet don't shows any information.

Do you need more information?

PS:with acpi included on 2.6.0 all works fine.


--=20
"Soy una piedra, no muevo ni un m=FAsculo,lentamente me pongo nieve=20
en la boca para que no vea mi aliento , me tomo mi tiempo,=20
dejo que se acerque, s=F3lo tengo una bala, apunto a sus ojos, muy=20
suavemente mi dedo presiona el gatillo,mi pulso no tiembla, no=20
tengo miedo: ahora ya soy mayor"
					     Enemy at gates
------
Pere Casta=F1er Sard=E0=A0 - http://xarz.no-ip.org
GnuPG Public key available - http://xarz.no-ip.org/keys.html
Computer Science Student on UOC - http://www.uoc.edu
Linux Registered User #232073=20
Debian/GNU User - http://www.debian.org
---------------------

--Signature=_Fri__19_Dec_2003_01_00_04_+0100_ExhadzM.n5P7/0zW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/4j+Iz9pL9wbHcwIRAuYgAKCQtpXR+Ve9WrkFvxTt6FNgCmBd9QCfYsOY
NRRyVWF/7j4KvkLu3fN0J/k=
=QuET
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Dec_2003_01_00_04_+0100_ExhadzM.n5P7/0zW--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
