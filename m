From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: [PATCH] force polling when manual trip points are set
Date: Sun, 3 Nov 2002 23:33:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103233332.H19750@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
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
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

I'm sure you've seen the arguments on acpi-devel with the pros and cons for
such a patch. Please decide,

	Dominik

--- linux/drivers/acpi/thermal.c.original	Sun Nov  3 23:02:35 2002
+++ linux/drivers/acpi/thermal.c	Sun Nov  3 23:31:32 2002
@@ -59,6 +59,8 @@
 #define ACPI_THERMAL_MODE_ACTIVE	0x00
 #define ACPI_THERMAL_MODE_PASSIVE	0x01
 #define ACPI_THERMAL_PATH_POWEROFF	"/sbin/poweroff"
+#define ACPI_THERMAL_POLLING_MANUAL_TRIPS  50    /* polling frequency when=
 manual trip points are set. Can be overridden
+						    by writing into ACPI_THERMAL_FILE_POLLING_FREQ */
=20
 #define ACPI_THERMAL_MAX_ACTIVE	10
=20
@@ -879,6 +881,7 @@
 	struct acpi_thermal	*tz =3D (struct acpi_thermal *) data;
 	char			limit_string[25] =3D {'\0'};
 	int			critical, hot, passive, active0, active1;
+	int			result =3D 0;=09
=20
 	ACPI_FUNCTION_TRACE("acpi_thermal_write_trip_points");
=20
@@ -904,6 +907,15 @@
 	tz->trips.passive.temperature =3D CELSIUS_TO_KELVIN(passive);
 	tz->trips.active[0].temperature =3D CELSIUS_TO_KELVIN(active0);
 	tz->trips.active[1].temperature =3D CELSIUS_TO_KELVIN(active1);
+
+	/* we need to start polling now as Firmware won't inform us of our custom=
 trip points */
+	if (!tz->polling_frequency) {
+		acpi_thermal_set_polling(tz, ACPI_THERMAL_POLLING_MANUAL_TRIPS);
+		if (result)
+			return_VALUE(result);
+
+		acpi_thermal_check(tz);
+	}
 =09
 	return_VALUE(count);
 }

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9xaQ8Z8MDCHJbN8YRAsleAJ0eYAQa2pRe9Qk/EY3csf+8zpc/RACeMEQi
iC8lCq4FQ8J6p8mwz5j0MXY=
=yZFb
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
