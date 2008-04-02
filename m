From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: rc6+ regression - backlight reset to 0 on boot after 7c0ea45be4f114d85ee35caeead8e1660699c46f
Date: Wed, 2 Apr 2008 22:53:15 +0400
Message-ID: <200804022253.17862.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2019604.mx0Q6UFNd7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx6.mail.ru ([194.67.23.26]:20381 "EHLO mx6.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756966AbYDBSxZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Apr 2008 14:53:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart2019604.mx0Q6UFNd7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Commit 7c0ea45be4f114d85ee35caeead8e1660699c46f registers ACPI backlight
even if _BQC method (query current backlight level) is missing. The effect is:

during initialization video.c:acpi_video_device_find_cap() calls backlight_update_status(). It tries to fetch actual level via acpi_video_get_brightness() - but as _BQC is missing it just returns current value
as stored in memory - i.e. zero, because it was never set. So effectively
backlight_update_status() reset brightness to minimal value == 0.

This happens on Toshiba Portege 4000. Verified by reverting commit on top of
rc8.

On a side note, it would be nice to fit backlight device into actual ACPI
device tree instead of /devices/virtual.

--nextPart2019604.mx0Q6UFNd7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkfz1h0ACgkQR6LMutpd94yg0wCgsofIQqOpo7kjJsw7D/SdgjIu
p7kAoISGT98GrGTc+d/qoYFZ4XnjH5Jh
=BwDj
-----END PGP SIGNATURE-----

--nextPart2019604.mx0Q6UFNd7--
