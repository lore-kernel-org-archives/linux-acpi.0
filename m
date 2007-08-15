From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 2/6] PNPACPI: simplify irq_flags()
Date: Wed, 15 Aug 2007 10:32:09 -0600
Message-ID: <20070815163432.316070716@ldl.fc.hp.com>
References: <20070815163207.062263984@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:60747 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761529AbXHOQfY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2007 12:35:24 -0400
Content-Disposition: inline; filename=pnp-simplify-irq-flags
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

No need for a temporary variable; just return the flags once we know them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- w.orig/drivers/pnp/pnpacpi/rsparser.c	2007-08-14 11:46:58.000000000 -0600
+++ w/drivers/pnp/pnpacpi/rsparser.c	2007-08-14 11:47:17.000000000 -0600
@@ -34,20 +34,17 @@
  */
 static int irq_flags(int triggering, int polarity)
 {
-	int flag;
-
 	if (triggering == ACPI_LEVEL_SENSITIVE) {
 		if (polarity == ACPI_ACTIVE_LOW)
-			flag = IORESOURCE_IRQ_LOWLEVEL;
+			return IORESOURCE_IRQ_LOWLEVEL;
 		else
-			flag = IORESOURCE_IRQ_HIGHLEVEL;
+			return IORESOURCE_IRQ_HIGHLEVEL;
 	} else {
 		if (polarity == ACPI_ACTIVE_LOW)
-			flag = IORESOURCE_IRQ_LOWEDGE;
+			return IORESOURCE_IRQ_LOWEDGE;
 		else
-			flag = IORESOURCE_IRQ_HIGHEDGE;
+			return IORESOURCE_IRQ_HIGHEDGE;
 	}
-	return flag;
 }
 
 static void decode_irq_flags(int flag, int *triggering, int *polarity)

--
