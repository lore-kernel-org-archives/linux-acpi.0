From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 12/55] PNPACPI: pnpacpi_encode_ext_irq() wrongly set "irq" instead of "extended_irq"
Date: Mon, 28 Apr 2008 16:33:59 -0600
Message-ID: <20080428223618.877424514@ldl.fc.hp.com>
References: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:3545 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966158AbYD1Wgc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:36:32 -0400
Content-Disposition: inline; filename=pnpacpi-fix-encode-extended-irq
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

pnpacpi_encode_ext_irq() should set resource->data.extended_irq, not
resource->data.irq.

This has been wrong since at least 2.6.12.  I haven't seen any bug
reports, but it's clearly incorrect.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work10.orig/drivers/pnp/pnpacpi/rsparser.c	2008-04-28 15:57:04.000000000 -0600
+++ work10/drivers/pnp/pnpacpi/rsparser.c	2008-04-28 16:09:15.000000000 -0600
@@ -820,9 +820,9 @@
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
