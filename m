From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 11/53] PNPACPI: pnpacpi_encode_ext_irq() wrongly set "irq" instead of "extended_irq"
Date: Fri, 18 Apr 2008 14:50:06 -0600
Message-ID: <20080418205049.444779428@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762229AbYDRU5p@vger.kernel.org>
Content-Disposition: inline; filename=pnpacpi-fix-encode-extended-irq
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

pnpacpi_encode_ext_irq() should set resource->data.extended_irq, not
resource->data.irq.

This has been wrong since at least 2.6.12.  I haven't seen any bug
reports, but it's clearly incorrect.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work8.orig/drivers/pnp/pnpacpi/rsparser.c	2008-04-10 12:26:08.000000000 -0600
+++ work8/drivers/pnp/pnpacpi/rsparser.c	2008-04-10 13:26:19.000000000 -0600
@@ -818,9 +818,9 @@
 	resource->data.extended_irq.triggering = triggering;
 	resource->data.extended_irq.polarity = polarity;
 	if (triggering == ACPI_EDGE_SENSITIVE)
-		resource->data.irq.sharable = ACPI_EXCLUSIVE;
+		resource->data.extended_irq.sharable = ACPI_EXCLUSIVE;
 	else
-		resource->data.irq.sharable = ACPI_SHARED;
+		resource->data.extended_irq.sharable = ACPI_SHARED;
 	resource->data.extended_irq.interrupt_count = 1;
 	resource->data.extended_irq.interrupts[0] = p->start;
 }

-- 
