From: Patrick Dreker <patrick-G8S07CpUG8qzQB+pC5nmwQ@public.gmane.org>
Subject: Nforce2 Patch by Andrew de Quincey
Date: Wed, 30 Jul 2003 20:27:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307302028.03463.patrick@dreker.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello...

By sheer coincidence I found the patch metioned in the subject in the=20
Mailinglist Archives on sourceforge=20
(http://sourceforge.net/mailarchive/forum.php?thread_id=3D2844765&forum_id=
=3D6102).=20
As I have some massive troubles getting ACPI to work on my Asus A7N8X I wou=
ld=20
like to give this patch a try. Unfortunately the patch in the ML archives i=
s=20
mangled (whitespace and linebreaks) and is truncated and the authors eMail=
=20
address is truncated too. I am now currently using a forward ported version=
=20
of the 2.4.21 backport of the patch which seems to work more or less. :-/

All devices get assigned an IRQ, which wasn't the case before (only 2 out o=
f 3=20
USB ports e.g.). Unfortunately the machine is very prone to lock-ups now, s=
o=20
I'd like to give the "original" patch a try, to exclude the possibility of =
me=20
having made an error in "re-forward-porting" the patch.

Could someone (the original author?) be so kind to mail the patch to me, or=
=20
give an URL, where I can find a working (i.e. non mangled) version of the=20
patch?=20
As a side note: Is it possible to apply the patch to 2.6.0-test2 instead of=
=20
2.5.75 or are there any reasons not to do so (other than failing hunks whic=
h=20
have to applied "by hand")?

Thanks in advance.
=2D --=20
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
=46ingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers or http://www.dreker.de/pubkey.asc
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KA4zcERm2vzC96cRAl01AJ411jRkOGgbK9Uy+hnirJUjERu6awCeIfoR
LBK6ngZ1kwgtuwJcngOdBB4=3D
=3DHwq+
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
