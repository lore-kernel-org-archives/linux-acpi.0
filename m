From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/23] pnpacpi: fix shareable IRQ encode/decode
Date: Wed, 11 Jun 2008 03:59:13 -0400
Message-ID: <f90bb36d65335ab4913fd4f5ebc5c190fbea1967.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:37111 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbYFKH7e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:34 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A007K7GV947R2@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:34 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

When we encode IRQ resources, we should use the "shareable" flag we got
from _PRS rather than guessing based on the IRQ trigger mode.

This is based on a patch by Tom Jaeger:
    http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index ab09fe6..8681ff6 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -50,14 +50,14 @@ static int irq_flags(int triggering, int polarity, int shareable)
 			flags = IORESOURCE_IRQ_HIGHEDGE;
 	}
 
-	if (shareable)
+	if (shareable == ACPI_SHARED)
 		flags |= IORESOURCE_IRQ_SHAREABLE;
 
 	return flags;
 }
 
 static void decode_irq_flags(struct pnp_dev *dev, int flags, int *triggering,
-			     int *polarity)
+			     int *polarity, int *shareable)
 {
 	switch (flags & (IORESOURCE_IRQ_LOWLEVEL | IORESOURCE_IRQ_HIGHLEVEL |
 			 IORESOURCE_IRQ_LOWEDGE  | IORESOURCE_IRQ_HIGHEDGE)) {
@@ -84,6 +84,11 @@ static void decode_irq_flags(struct pnp_dev *dev, int flags, int *triggering,
 		*polarity = ACPI_ACTIVE_HIGH;
 		break;
 	}
+
+	if (flags & IORESOURCE_IRQ_SHAREABLE)
+		*shareable = ACPI_SHARED;
+	else
+		*shareable = ACPI_EXCLUSIVE;
 }
 
 static void pnpacpi_parse_allocated_irqresource(struct pnp_dev *dev,
@@ -796,15 +801,12 @@ static void pnpacpi_encode_irq(struct pnp_dev *dev,
 			       struct resource *p)
 {
 	struct acpi_resource_irq *irq = &resource->data.irq;
-	int triggering, polarity;
+	int triggering, polarity, shareable;
 
-	decode_irq_flags(dev, p->flags, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity, &shareable);
 	irq->triggering = triggering;
 	irq->polarity = polarity;
-	if (triggering == ACPI_EDGE_SENSITIVE)
-		irq->sharable = ACPI_EXCLUSIVE;
-	else
-		irq->sharable = ACPI_SHARED;
+	irq->sharable = shareable;
 	irq->interrupt_count = 1;
 	irq->interrupts[0] = p->start;
 
@@ -819,16 +821,13 @@ static void pnpacpi_encode_ext_irq(struct pnp_dev *dev,
 				   struct resource *p)
 {
 	struct acpi_resource_extended_irq *extended_irq = &resource->data.extended_irq;
-	int triggering, polarity;
+	int triggering, polarity, shareable;
 
-	decode_irq_flags(dev, p->flags, &triggering, &polarity);
+	decode_irq_flags(dev, p->flags, &triggering, &polarity, &shareable);
 	extended_irq->producer_consumer = ACPI_CONSUMER;
 	extended_irq->triggering = triggering;
 	extended_irq->polarity = polarity;
-	if (triggering == ACPI_EDGE_SENSITIVE)
-		extended_irq->sharable = ACPI_EXCLUSIVE;
-	else
-		extended_irq->sharable = ACPI_SHARED;
+	extended_irq->sharable = shareable;
 	extended_irq->interrupt_count = 1;
 	extended_irq->interrupts[0] = p->start;
 
-- 
1.5.6.rc2.23.gea81e

