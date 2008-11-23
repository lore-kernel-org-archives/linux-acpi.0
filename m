From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: More vendor vs. ACPI methods - FAN?
Date: Sun, 23 Nov 2008 07:31:39 +0300
Message-ID: <200811230731.43966.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1741645.CV9efCpfXa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx71.mail.ru ([194.67.23.4]:50721 "EHLO mx71.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbYKWEbr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Nov 2008 23:31:47 -0500
Received: from [91.77.249.218] (port=4168 helo=cooker.net)
	by mx71.mail.ru with asmtp
	id 1L46dN-000A2Q-00
	for linux-acpi@vger.kernel.org; Sun, 23 Nov 2008 07:31:45 +0300
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart1741645.CV9efCpfXa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On the same poor old Toshiba Portege 4000:

{pts/1}% cat /proc/acpi/power_resource/PFAN/state
state:                   off
system level:            S0
order:                   0
reference count:         0
{pts/1}% cat /sys/class/thermal/cooling_device0/cur_state
0
{pts/1}% cat /sys/class/thermal/cooling_device1/cur_state
0
{pts/1}% cat /proc/acpi/toshiba/fan
running:                 1
force_on:                0

Looks like we need something similar to video handlink for FAN as well ...

--nextPart1741645.CV9efCpfXa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkko3KwACgkQR6LMutpd94xbdgCgubOL42jnp66UPE8nF/zuzFng
/KwAn28Yzu5r1Sz9iN/uFNFvBJNyqDzK
=VP4J
-----END PGP SIGNATURE-----

--nextPart1741645.CV9efCpfXa--
