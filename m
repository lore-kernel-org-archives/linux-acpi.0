From: Mario Limonciello <mario_limonciello@dell.com>
Subject: [PATCH 1/3] Add known supported Dell Mini series laptops to compal-laptop
Date: Mon, 17 Aug 2009 18:27:34 -0500
Message-ID: <4A89E766.5040600@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B1842A0038EDB9405183FFB"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932659AbZHQX0z@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cezary.jackiewicz@gmail.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B1842A0038EDB9405183FFB
Content-Type: multipart/mixed;
 boundary="------------040102060404020909060500"

This is a multi-part message in MIME format.
--------------040102060404020909060500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This adds the system information as matched by DMI tables for laptops
I've verified can work with compal-laptop.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------040102060404020909060500
Content-Type: text/x-patch;
 name="01_detect_dell.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="01_detect_dell.diff"

--- drivers/platform/x86/compal-laptop.c.old	2009-08-17 06:27:52.73178692=
8 -0500
+++ drivers/platform/x86//compal-laptop.c	2009-08-17 06:29:31.199787056 -=
0500
@@ -311,6 +311,39 @@
 		},
 		.callback =3D dmi_check_cb
 	},
+	{
+		.ident =3D "Dell Mini 9",
+		.matches =3D {
+                        DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 910"),
+		},
+		.callback =3D dmi_check_cb
+	},
+	{
+		.ident =3D "Dell Mini 10",
+		.matches =3D {
+                        DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1010"),
+		},
+		.callback =3D dmi_check_cb
+	},
+	{
+		.ident =3D "Dell Mini 10v",
+		.matches =3D {
+                        DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1011"),
+		},
+		.callback =3D dmi_check_cb
+	},
+	{
+		.ident =3D "Dell Inspiron 1010",
+		.matches =3D {
+                        DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1110"),
+		},
+		.callback =3D dmi_check_cb
+	},
+
 	{ }
 };
=20
@@ -404,3 +437,7 @@
 MODULE_ALIAS("dmi:*:rnIFL91:rvrIFT00:*");
 MODULE_ALIAS("dmi:*:rnJFL92:rvrIFT00:*");
 MODULE_ALIAS("dmi:*:rnIFT00:rvrIFT00:*");
+MODULE_ALIAS("dmi:*:svnDellInc.:pnInspiron910:*");
+MODULE_ALIAS("dmi:*:svnDellInc.:pnInspiron1010:*");
+MODULE_ALIAS("dmi:*:svnDellInc.:pnInspiron1011:*");
+MODULE_ALIAS("dmi:*:svnDellInc.:pnInspiron1110:*");

--------------040102060404020909060500--

--------------enig6B1842A0038EDB9405183FFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqJ52YACgkQ2CrZjkA73YufUgCcDzQQofbgHdmyWntRZBwL0Ta9
HhoAn2E3HyeOWvxt5a5fePT/+Id2OEz4
=N+ge
-----END PGP SIGNATURE-----

--------------enig6B1842A0038EDB9405183FFB--
