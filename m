From: Mario Limonciello <mario_limonciello@dell.com>
Subject: [PATCH 2/3] Don't load Dell-WMI on non WMI systems
Date: Tue, 21 Apr 2009 13:01:55 -0500
Message-ID: <49EE0A13.50403@dell.com>
References: <49ECBAE2.2080308@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5C0F3905616614173C27B6E0"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757454AbZDUSCL@vger.kernel.org>
In-Reply-To: <49ECBAE2.2080308@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C0F3905616614173C27B6E0
Content-Type: multipart/mixed;
 boundary="------------000104010207040103090209"

This is a multi-part message in MIME format.
--------------000104010207040103090209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi:

I've noticed that the dell-wmi module will load on systems even if WMI
isn't supported.  As this is dependent upon BIOS version, dell-wmi
should return -ENODEV in these situations.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------000104010207040103090209
Content-Type: text/x-patch;
 name="dell-wmi-dont-load-on-non-wmi-system.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dell-wmi-dont-load-on-non-wmi-system.patch"

--- a/drivers/platform/x86/dell-wmi.c~	2009-04-21 12:41:50.000000000 -050=
0
+++ b/drivers/platform/x86/dell-wmi.c	2009-04-21 12:30:35.000000000 -0500=

@@ -255,8 +255,10 @@
 			return err;
 		}
=20
-	} else
-		printk(KERN_WARNING "dell-wmi: No known WMI GUID found\n");
+	} else {
+		printk(KERN_ERR "dell-wmi: No known WMI GUID found\n");
+		return -ENODEV;
+    }
=20
 	return 0;
 }

--------------000104010207040103090209--

--------------enig5C0F3905616614173C27B6E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknuChQACgkQ2CrZjkA73Yv7kwCfaX3kaNY/+9c+usVu31p4OCMy
mWcAoIYyaOKLGQdSmeZrN7VywRalEbaH
=YsKN
-----END PGP SIGNATURE-----

--------------enig5C0F3905616614173C27B6E0--
