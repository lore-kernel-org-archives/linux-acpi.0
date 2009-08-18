From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH 1/3] Add known supported Dell Mini series laptops to compal-laptop
Date: Tue, 18 Aug 2009 12:35:10 -0500
Message-ID: <4A8AE64E.3080108@dell.com>
References: <4A89E766.5040600@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8101A335EE145796421378F7"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759331AbZHRRe3@vger.kernel.org>
In-Reply-To: <4A89E766.5040600@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cezary.jackiewicz@gmail.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8101A335EE145796421378F7
Content-Type: multipart/mixed;
 boundary="------------010205020806040501020009"

This is a multi-part message in MIME format.
--------------010205020806040501020009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Mario Limonciello wrote:
> This adds the system information as matched by DMI tables for laptops
> I've verified can work with compal-laptop.
>  =20
In light of Alan Jenkins recommendation of scripts/cleanpatch, here's a
patch with cleaned up whitespace.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------010205020806040501020009
Content-Type: text/x-patch;
 name="01_detect_dell.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="01_detect_dell.diff"

--- a/drivers/platform/x86/compal-laptop.c.old	2009-08-18 01:32:12.192650=
851 -0500
+++ b/drivers/platform/x86/compal-laptop.c	2009-08-18 01:31:57.984669096 =
-0500
@@ -311,6 +311,47 @@
 		},
 		.callback =3D dmi_check_cb
 	},
+	{
+		.ident =3D "Dell Mini 9",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 910"),
+		},
+		.callback =3D dmi_check_cb
+	},
+	{
+		.ident =3D "Dell Mini 10",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1010"),
+		},
+		.callback =3D dmi_check_cb
+	},
+	{
+		.ident =3D "Dell Mini 10v",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1011"),
+		},
+		.callback =3D dmi_check_cb
+	},
+	{
+		.ident =3D "Dell Inspiron 11z",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1110"),
+		},
+		.callback =3D dmi_check_cb
+	},
+	{
+		.ident =3D "Dell Mini 12",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1210"),
+		},
+		.callback =3D dmi_check_cb
+	},
+
 	{ }
 };
=20
@@ -404,3 +445,8 @@
 MODULE_ALIAS("dmi:*:rnIFL91:rvrIFT00:*");
 MODULE_ALIAS("dmi:*:rnJFL92:rvrIFT00:*");
 MODULE_ALIAS("dmi:*:rnIFT00:rvrIFT00:*");
+MODULE_ALIAS("dmi:*:svnDellInc.:pnInspiron910:*");
+MODULE_ALIAS("dmi:*:svnDellInc.:pnInspiron1010:*");
+MODULE_ALIAS("dmi:*:svnDellInc.:pnInspiron1011:*");
+MODULE_ALIAS("dmi:*:svnDellInc.:pnInspiron1110:*");
+MODULE_ALIAS("dmi:*:svnDellInc.:pnInspiron1210:*");

--------------010205020806040501020009--

--------------enig8101A335EE145796421378F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqK5k4ACgkQ2CrZjkA73YuSYQCglsOhPNgBacscf0ZitsXzvvTu
v6AAn2/kWRT5GKM8/hHI/OYBpk0dNZ6M
=bP0h
-----END PGP SIGNATURE-----

--------------enig8101A335EE145796421378F7--
