From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: (unknown)
Date: Sun, 28 Dec 2008 12:24:38 +0100
Message-ID: <200812281224.41223.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3443844.CzGAOAAVVo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:44032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750737AbYL1LYp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Dec 2008 06:24:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net

--nextPart3443844.CzGAOAAVVo
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I'm wondering why at my ThinkPad T41 the bluetooth LED is on even if I did =
not=20
compiled bluetooth support into the kernel nor as module.

More data:

tfoerste@n22 ~ $ uname -a
Linux n22 2.6.27-gentoo-r7 #6 Sun Dec 28 12:08:24 CET 2008 i686 Intel(R)=20
Pentium(R) M processor 1700MHz GenuineIntel GNU/Linux

tfoerste@n22 ~ $ cat /proc/acpi/ibm/bluetooth
status:         enabled
commands:       enable, disable

tfoerste@n22 ~ $ zgrep CONFIG_BT /proc/config.gz
# CONFIG_BT is not set

=2D-=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3


--nextPart3443844.CzGAOAAVVo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklXYfkACgkQhyrlCH22naOgqACfUVufXkwa/X4y1NCEVSLy1HMT
QeMAoIBLEria2qSD6ANAHQhVovD9hvXl
=Djxb
-----END PGP SIGNATURE-----

--nextPart3443844.CzGAOAAVVo--
