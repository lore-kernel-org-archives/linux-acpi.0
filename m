From: Mario Limonciello <mario_limonciello@dell.com>
Subject: [PATCH] Temporarily add modalias for Dell DMI match on dell-wmi
Date: Tue, 28 Apr 2009 17:22:57 -0500
Message-ID: <49F781C1.4080001@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig75DED4E4088DD029FA3D90D0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:59787 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbZD1WWs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2009 18:22:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75DED4E4088DD029FA3D90D0
Content-Type: multipart/mixed;
 boundary="------------070609030505050705090301"

This is a multi-part message in MIME format.
--------------070609030505050705090301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi:

Until the sysfs interface is ready, there is no way to automatically
load dell-wmi.  The equivalent module for Acer laptops, acer-wmi has a
workaround in place to match on the DMI tables for the machine.  This
type of solution works on for Dell as well and gets the module loading
when necessary.

Patch is attached to prevent Exchange messing up line breaks.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------070609030505050705090301
Content-Type: text/x-patch;
 name="dell-wmi-temporary-modalias.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dell-wmi-temporary-modalias.patch"

--- a/drivers/platform/x86/dell-wmi.c~	2009-04-28 17:12:01.000000000 -050=
0
+++ b/drivers/platform/x86/dell-wmi.c	2009-04-28 17:12:43.000000000 -0500=

@@ -40,6 +40,10 @@
=20
 MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
=20
+/* Temporary workaround until the WMI sysfs interface goes in.
+   Borrowed from acer-wmi */
+MODULE_ALIAS("dmi:*:*Dell*:*:");
+
 struct key_entry {
 	char type;		/* See KE_* below */
 	u16 code;

--------------070609030505050705090301--

--------------enig75DED4E4088DD029FA3D90D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkn3gcIACgkQ2CrZjkA73YseDgCeKCKp38K94nvxtS0dZEtkNZhR
Ym8An1r6KhpYbprQx/0ZF1Xwq4DLT4Ap
=2/1t
-----END PGP SIGNATURE-----

--------------enig75DED4E4088DD029FA3D90D0--
