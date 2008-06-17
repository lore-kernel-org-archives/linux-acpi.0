From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 21/28] PNPACPI: ignore _PRS interrupt numbers larger than PNP_IRQ_NR
Date: Tue, 17 Jun 2008 16:58:44 -0600
Message-ID: <20080617225912.012910968@ldl.fc.hp.com>
References: <20080617225823.045233728@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:8413 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760537AbYFQXAG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 19:00:06 -0400
Content-Disposition: inline; filename=pnpacpi-extended-irq-option
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>

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

Index: work14/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work14.orig/drivers/pnp/pnpacpi/rsparser.c	2008-06-17 15:52:27.000000000 -0600
+++ work14/drivers/pnp/pnpacpi/rsparser.c	2008-06-17 15:52:29.000000000 -0600
@@ -435,9 +435,16 @@ static __init void pnpacpi_parse_irq_opt
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
