From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: acpi build breakage
Date: Thu, 27 Mar 2008 14:20:32 +1100
Message-ID: <20080327142032.432ddb0b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__27_Mar_2008_14_20_32_+1100_rWNP6h626Qyi3Wn3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:55665 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbYC0DUk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Mar 2008 23:20:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

--Signature=_Thu__27_Mar_2008_14_20_32_+1100_rWNP6h626Qyi3Wn3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Len,

Today's linux-next build (x86_64 allmodconfig) produces the following
errors:

ERROR: "pnp_get_resource" [sound/oss/sb.ko] undefined!
ERROR: "pnp_get_resource" [sound/drivers/mpu401/snd-mpu401.ko] undefined!
ERROR: "pnp_get_resource" [drivers/watchdog/sc1200wdt.ko] undefined!
ERROR: "pnp_get_resource" [drivers/serial/8250_pnp.ko] undefined!
ERROR: "pnp_get_resource" [drivers/rtc/rtc-cmos.ko] undefined!
ERROR: "pnp_get_resource" [drivers/parport/parport_pc.ko] undefined!
ERROR: "pnp_get_resource" [drivers/net/sb1000.ko] undefined!
ERROR: "pnp_get_resource" [drivers/net/irda/smsc-ircc2.ko] undefined!
ERROR: "pnp_get_resource" [drivers/net/irda/nsc-ircc.ko] undefined!
ERROR: "pnp_get_resource" [drivers/mmc/host/wbsd.ko] undefined!
ERROR: "pnp_get_resource" [drivers/input/serio/i8042.ko] undefined!
ERROR: "pnp_get_resource" [drivers/input/gameport/ns558.ko] undefined!
ERROR: "pnp_get_resource" [drivers/ide/ide-pnp.ko] undefined!
ERROR: "pnp_get_resource" [drivers/char/tpm/tpm_tis.ko] undefined!
ERROR: "pnp_get_resource" [drivers/char/tpm/tpm_infineon.ko] undefined!

I added the following patch.  It should really be merged back into commit
6d889e6c99155449934449ef6e2f87747eb4487e ("PNP: add pnp_get_resource()
interface").

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

>From 99b26196cf3fd1c66047376bfe82c05fa1ff2a85 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 27 Mar 2008 14:13:37 +1100
Subject: [PATCH] Export pnp_get_resource

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/pnp/resource.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 9911b92..36487ae 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -613,6 +613,7 @@ struct resource *pnp_get_resource(struct pnp_dev *dev,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(pnp_get_resource);
=20
 /* format is: pnp_reserve_irq=3Dirq1[,irq2] .... */
 static int __init pnp_setup_reserve_irq(char *str)
--=20
1.5.4.4


--Signature=_Thu__27_Mar_2008_14_20_32_+1100_rWNP6h626Qyi3Wn3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6xKFTgG2atn1QN8RAvviAKCMvPL/+9v7ELi3XuE/ryGDoOiZegCeIB8x
U4MpCGgi8CpjEaiENOeqzHI=
=K43x
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Mar_2008_14_20_32_+1100_rWNP6h626Qyi3Wn3--
