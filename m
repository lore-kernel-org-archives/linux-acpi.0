From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 13/18] PNPACPI: ignore _PRS interrupt numbers larger than PNP_IRQ_NR
Date: Wed, 04 Jun 2008 16:09:46 -0600
Message-ID: <20080604221129.362951051@ldl.fc.hp.com>
References: <20080604220933.168145536@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:46648 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762721AbYFDWL7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2008 18:11:59 -0400
Content-Disposition: inline; filename=pnpacpi-extended-irq-option
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

ACPI Extended Interrupt Descriptors can encode 32-bit interrupt
numbers, so an interrupt number may exceed the size of the bitmap
we use to track possible IRQ settings.

To avoid corrupting memory, complain and ignore too-large interrupt
numbers.

There's similar code in pnpacpi_parse_irq_option(), but I didn't
change that because the small IRQ descriptor can only encode
IRQs 0-15, which do not exceed bitmap size.

In the future, we could handle IRQ numbers greater than PNP_IRQ_NR
by replacing the bitmap with a table or list.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work10.orig/drivers/pnp/pnpacpi/rsparser.c	2008-05-30 13:23:34.000000000 -0600
+++ work10/drivers/pnp/pnpacpi/rsparser.c	2008-05-30 14:45:52.000000000 -0600
@@ -421,9 +421,16 @@ static __init void pnpacpi_parse_ext_irq
 		return;
 
 	bitmap_zero(map.bits, PNP_IRQ_NR);
-	for (i = 0; i < p->interrupt_count; i++)
-		if (p->interrupts[i])
-			__set_bit(p->interrupts[i], map.bits);
+	for (i = 0; i < p->interrupt_count; i++) {
+		if (p->interrupts[i]) {
+			if (p->interrupts[i] < PNP_IRQ_NR)
+				__set_bit(p->interrupts[i], map.bits);
+			else
+				dev_err(&dev->dev, "ignoring IRQ %d option "
+					"(too large for %d entry bitmap)\n",
+					p->interrupts[i], PNP_IRQ_NR);
+		}
+	}
 
 	flags = irq_flags(p->triggering, p->polarity, p->sharable);
 	pnp_register_irq_resource(dev, option, &map, flags);

-- 
