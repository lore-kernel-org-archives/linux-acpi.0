From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Can video_detect be made __init?
Date: Sat, 8 Nov 2008 16:55:07 +0300
Message-ID: <200811081655.08226.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12516688.zlN7n4Zbhr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx30.mail.ru ([194.67.23.238]:5592 "EHLO mx30.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbYKHNzQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Nov 2008 08:55:16 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

--nextPart12516688.zlN7n4Zbhr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I would add DMI entries to force vendor backlight for my system, but
I'd really prefer they are not remain in memory forever. Is there any
reason for the whole detection to not happen exactly once? After all,
ACPI cannot change after boot, can it?

Hmm ... actually DSDT can be loaded from initrd, so it can change ... but
in this case we actually are just interested in DMI matching which says
whether vendor driver is preferred or not. What would be the the best
place to call it from?

-andrey

--nextPart12516688.zlN7n4Zbhr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkVmjwACgkQR6LMutpd94yojACgwipiClbM9G9nJL8MGemWo5iI
QbIAoJhgzjl5c5ytA6pRoJvj1jhRM/Qt
=fNss
-----END PGP SIGNATURE-----

--nextPart12516688.zlN7n4Zbhr--
