From: Pere =?ISO-8859-15?Q?Casta=F1er?= <XaRz69-pCzzcW6XgXY@public.gmane.org>
Subject: [ACPI-sppt] Reporting success on i8k5 Suspend/Resume linux-2.6.0-test6!!!
Date: Fri, 3 Oct 2003 15:04:23 +0200
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031003150423.462e88f4.XaRz69@terra.es>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__3_Oct_2003_15_04_23_+0200_JMJEX=O0n439EIWw"
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: ACPI-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Signature=_Fri__3_Oct_2003_15_04_23_+0200_JMJEX=O0n439EIWw
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi all!

I'm having good news for all linux i8k5 users. With the kernel 2.6.0-test6 =
and the acpi patch of 20030918 I can suspend the laptop correctly and resum=
e BUT:

-Tested with Nvidia binary drivers and executing suspend in Xfree:

Suspend:Ok
Resume: BAD. The system freezes.

-Tested without Xfree direct from console (framebufered 0x31B)

Suspend:Ok.
Resume:Bad, but the system is ok only the screen has cubes of colors maybe =
the framebuffer is th problem????

-Tested without Xfree direct from console without vesa frambuffer

Suspend:Ok
Resume:Ok!!

-Tested in Xfree with nv driver for gforce-4200go without vesa fb

Suspend:Ok
Resume:Ok!
Comments:=20
	-The usb seems not be resumed, in a previous acpi version I've 		listen so=
mething about it. I will seach more info and i'll tell 	all new advance.
	-The network is down perhaps something happened with daemons..
	-When you switch to console (ctrl-ALT FX) it was damaged..some 		problems =
setting the resolution seems.

Well, I sent this to linux-dell-laptop for people interested in this.

Good resuming!=20

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


--Signature=_Fri__3_Oct_2003_15_04_23_+0200_JMJEX=O0n439EIWw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/fXPXz9pL9wbHcwIRAvZMAJ9ypkrgBXJa4k73oOI01SjU+jHn/QCeIY1Q
2J06Jj8uOgEOI6+0fUOhE2Q=
=Vd6s
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Oct_2003_15_04_23_+0200_JMJEX=O0n439EIWw--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
