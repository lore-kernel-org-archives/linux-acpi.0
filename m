From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] PNP: update kernel parameter documentation
Date: Tue, 29 Jul 2008 15:42:24 -0600
Message-ID: <20080729214213.26989.19095.stgit@tigger.helgaas>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:43905 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbYG2Vmk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jul 2008 17:42:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, linux-acpi@vger.kernel.org


Remove obsolete "pnpbios=res" and "pnpbios=no-res" options, note that
"pnp_reserve_{irq,dma,io,mem}=" work for all PNP (not just ISAPNP) and
add formats.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 Documentation/kernel-parameters.txt |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)


diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e7bea3e..3cba6ed 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1655,25 +1655,32 @@ and is between 256 and 4096 characters. It is defined in the file
 			Override pmtimer IOPort with a hex value.
 			e.g. pmtmr=0x508
 
-	pnpacpi=	[ACPI]
+	pnpacpi=	[PNP && ACPI]
 			{ off }
 
-	pnpbios=	[ISAPNP]
-			{ on | off | curr | res | no-curr | no-res }
+	pnpbios=option[,option...]	[PNPBIOS]
+		off		Disable PNPBIOS
+		no-curr		Use static device configuration, i.e., how
+				the device will be configured on the next boot
 
 	pnp_reserve_irq=
-			[ISAPNP] Exclude IRQs for the autoconfiguration
+			[PNP] Keep Linux from assigning listed IRQs
+			to PNP devices
+			Format: <irq>[,<irq>,...]
 
 	pnp_reserve_dma=
-			[ISAPNP] Exclude DMAs for the autoconfiguration
+			[PNP] Keep Linux from assigning listed DMA channels
+			to PNP devices
+			Format: <dma>[,<dma>,...]
 
-	pnp_reserve_io=	[ISAPNP] Exclude I/O ports for the autoconfiguration
-			Ranges are in pairs (I/O port base and size).
+	pnp_reserve_io=	[PNP] Keep Linux from assigning listed I/O port ranges
+			to PNP devices
+			Format: <io>,<size>[,<io>,<size>,...]
 
 	pnp_reserve_mem=
-			[ISAPNP] Exclude memory regions for the
-			autoconfiguration.
-			Ranges are in pairs (memory base and size).
+			[PNP] Keep Linux from assigning listed memory ranges
+			to PNP devices
+			Format: <mem>,<size>[,<mem>,<size>,...]
 
 	print-fatal-signals=
 			[KNL] debug: print fatal signals

