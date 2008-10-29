From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: 2.6.28 - new warning evaluating _BIF - found Buffer, expected String
Date: Wed, 29 Oct 2008 20:38:52 +0300
Message-ID: <200810292038.53075.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4350232.HtJvUNEjUg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx30.mail.ru ([194.67.23.238]:6483 "EHLO mx30.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbYJ2RjE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Oct 2008 13:39:04 -0400
Received: from [91.77.237.82] (port=24911 helo=cooker.net)
	by mx30.mail.ru with asmtp
	id 1KvF0W-000KHl-00
	for linux-acpi@vger.kernel.org; Wed, 29 Oct 2008 20:39:00 +0300
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart4350232.HtJvUNEjUg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[   36.156325] ACPI: AC Adapter [ADP1] (off-line)
[   36.177259] ACPI Warning (nspredef-0858): \_SB_.BAT1._BIF: Return Package type mismatch at index 9 - found Buffer, expected String [20080926]
[   36.183721] ACPI: Battery Slot [BAT1] (battery present)
[   36.184307] ACPI: Battery Slot [BAT2] (battery absent)

well, battery.c extrac_package deals with both string and buffer just fine.
I am not sure if this warning is really needed in normal kernel - after all,
Buffer to String conversion has well defined sematic in ACPI.

There is nothing user can do about it anyway.

For reference, here is _BIF method; it is Toshiba Portege 4000:

            Method (_BIF, 0, NotSerialized)
            {
                Name (BUFF, Package (0x0D) {})
                Store (0x00, Index (BUFF, 0x00))
                Store (\_SB.MEM.BDV1, Local2)
                Multiply (\_SB.MEM.BDC1, Local2, Local0)
                Divide (Local0, 0x03E8, Local1, Local0)
                Store (Local0, Index (BUFF, 0x01))
                Multiply (\_SB.MEM.BLF1, Local2, Local0)
                Divide (Local0, 0x03E8, Local1, Local0)
                Store (Local0, Index (BUFF, 0x02))
                Store (\_SB.MEM.BTC1, Index (BUFF, 0x03))
                Store (\_SB.MEM.BDV1, Index (BUFF, 0x04))
                Multiply (\_SB.MEM.BCW1, Local2, Local0)
                Divide (Local0, 0x03E8, Local1, Local0)
                Store (Local0, Index (BUFF, 0x05))
                Multiply (\_SB.MEM.BCL1, Local2, Local0)
                Divide (Local0, 0x03E8, Local1, Local0)
                Store (Local0, Index (BUFF, 0x06))
                Multiply (\_SB.MEM.BG11, Local2, Local0)
                Divide (Local0, 0x03E8, Local1, Local0)
                Store (Local0, Index (BUFF, 0x07))
                Multiply (\_SB.MEM.BG21, Local2, Local0)
                Divide (Local0, 0x03E8, Local1, Local0)
                Store (Local0, Index (BUFF, 0x08))
                Store (\_SB.MEM.BMN1, Index (BUFF, 0x09))
                Store (\_SB.MEM.BSN1, Index (BUFF, 0x0A))
                Store (\_SB.MEM.BTP1, Index (BUFF, 0x0B))
                Store (\_SB.MEM.BOI1, Index (BUFF, 0x0C))
                Return (BUFF)
            }

--nextPart4350232.HtJvUNEjUg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkIn6wACgkQR6LMutpd94w+VQCfQY6kc4QJCZ6eUN3kkPZYQnvL
0qoAnjER/eO5RsjDtxPo/nczX9vkcxuT
=sfMG
-----END PGP SIGNATURE-----

--nextPart4350232.HtJvUNEjUg--
