From: Jean-Marc Valin <jean-marc.valin-ZbDpfo6ompS0w+vkrfm4Cg@public.gmane.org>
Subject: Crash on boot with latest ACPI versions
Date: Sat, 24 May 2003 02:35:27 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1053758126.4072.9.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-FQ8YxyU1bpb4u7K0s6e0";
 protocol="application/pgp-signature"; micalg=pgp-sha1
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


--=-FQ8YxyU1bpb4u7K0s6e0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I've been experiencing crashes while booting with the latest ACPI
driver. Since I can't use a screendump program, I tried to take a
picture instead (sorry, bad quality):
http://www.xiph.org/~jm/acpi_crash.jpg

I'm using a Compaq Presario 1720CA laptop (PIII 1 GHz) under 2.4.20. The
stock kernel ACPI doesn't crash (though battery status doesn't work),
but the latest ACPI drivers (all versions less than 6-10 months old)
crash on boot every time.

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada


--=-FQ8YxyU1bpb4u7K0s6e0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+zxKudXwABdFiRMQRAryGAKCkYBXnV/X2P1w+UcXzWfw40UpTQwCgiyYZ
9wE9xcJARDUOjKoXYvVDmqs=
=thYs
-----END PGP SIGNATURE-----

--=-FQ8YxyU1bpb4u7K0s6e0--



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
