From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] Fix key f70f4b50 not in .data in thermal_sys V2
Date: Mon, 22 Mar 2010 16:45:03 +0200
Message-ID: <20100322144503.GD3388@swordfish.minsk.epam.com>
References: <20100309102754.GA3316@swordfish.minsk.epam.com>
 <20100309141826.GC28606@suse.de>
 <20100322135235.GA3388@swordfish.minsk.epam.com>
 <20100322140713.GB1076@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100322140713.GB1076@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Greg KH <gregkh@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Initialize sysfs attributes before device_create_file call.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 5066de5..ecb181d 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -505,6 +505,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	tz->temp_input.attr.attr.name =3D tz->temp_input.name;
 	tz->temp_input.attr.attr.mode =3D 0444;
 	tz->temp_input.attr.show =3D temp_input_show;
+	sysfs_attr_init(&tz->temp_input.attr.attr);
 	result =3D device_create_file(hwmon->device, &tz->temp_input.attr);
 	if (result)
 		goto unregister_hwmon_device;
@@ -517,6 +518,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 			tz->temp_crit.attr.attr.name =3D tz->temp_crit.name;
 			tz->temp_crit.attr.attr.mode =3D 0444;
 			tz->temp_crit.attr.show =3D temp_crit_show;
+			sysfs_attr_init(&tz->temp_crit.attr.attr);
 			result =3D device_create_file(hwmon->device,
 						    &tz->temp_crit.attr);
 			if (result)
@@ -725,6 +727,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zon=
e_device *tz,
 		goto release_idr;
=20
 	sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
+	sysfs_attr_init(&dev->attr.attr);
 	dev->attr.attr.name =3D dev->attr_name;
 	dev->attr.attr.mode =3D 0444;
 	dev->attr.show =3D thermal_cooling_device_trip_point_show;


--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iJwEAQECAAYFAkungm8ACgkQfKHnntdSXjRvrgP/bBwdLYqn3ivi+FfZ6t04AIbs
ssji4gVUuw0KLUrTOcMQYm2h1gqVFLMC8T4Y9CorzbEOMujC0154/oJiBYvYGjeA
VxGF6g2+BJF6fp63mlOKpjlEFqYxI1mT0E5fbz6eAmN/biphxYSMeBMcve3bW36g
WMhkUXljreahn9qmVVU=
=ih3v
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
