From: mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: Re: 2.6 won't poweroff
Date: Fri, 28 May 2004 01:55:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040527235535.GA21670@zimen.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi (already posted, but only for Emma)

I have the same laptop and the same problem.

and what about this patch ??? : (from bugzilla)

--- linux/drivers/acpi/hardware/hwsleep.c.orig	2004-03-04 23:10:41.00000000=
0 +0100
+++ linux/drivers/acpi/hardware/hwsleep.c	2004-03-04 23:11:58.000000000 +01=
00
@@ -249,6 +249,11 @@
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);
 		}
+	} else {
+		status =3D acpi_hw_clear_acpi_status (ACPI_MTX_DO_NOT_LOCK);
+		if (ACPI_FAILURE (status)) {
+			return_ACPI_STATUS (status);
+		}
 	}
=20
 	status =3D acpi_hw_disable_non_wakeup_gpes ();





           mizu






On Tue, May 25, 2004 at 12:45:14AM -0400, Emma Jane Hogbin wrote:
> I have two big irritants for the 2.6.5/2.6.6 (patched for ACPI) kernels=
=20
> with ACPI.=20
>=20
> 	1. My computer no longer powers off. acpi_power_off is called, but the
> 	computer doesn't actually turn itself off. In fact when I use
> 	"poweroff" directly I get a message flashing across my screen saying:
> 		syntax error on 658 of stdin
>=20
> 	2. Random freezes. It's not just the touch pad or the keyboard, but
> 	rather the entire monitor seems to freeze from time to time and for no
> 	apparent reason. Gaim and xmms are usually (always?) open when it
> 	happens, but I can't believe that either of them would cause my system
> 	to freeze.
>=20
> I have an AcerTM 634 that did not have either of these two problems with
> 2.4.22. As requested on acpi.sf.net I have also made available:
>=20
> www.xtrinsic.com/geek/config/2.6.6/dmidecode.txt=20
> www.xtrinsic.com/geek/config/2.6.6/interrupts.txt=20
> www.xtrinsic.com/geek/config/2.6.6/lscpi.txt=20
> www.xtrinsic.com/geek/config/2.6.6/dmesg.txt
>=20
> (and 2.6.5 by changing the kernel number) I installed the PMTools Debian
> package, but it doesn't seem to include acpidmp. Is there a Debian package
> for it?
>=20
> Any suggestions would be much appreciated.
>=20
> thanks,
> emma
>=20
> --=20
> Emma Jane Hogbin
> [[ 416 417 2868 ][ www.xtrinsic.com ]]
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.=
=20
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=20
              mizu
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
[-> E-mail:michal_AT_zimen_DOT_sk   =20
[-> ICQ:97165392
[-> WWW: http://michal.zimen.sk
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtn/39kFXwDL4DRkRAi1oAKCY9Yj/GSMKIjUsjMLpoyzIUn8YyACfTQj9
3Fg5T4tGr5c8iDFwDF9Ak1Q=
=Skes
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
