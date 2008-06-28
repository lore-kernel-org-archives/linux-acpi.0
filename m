From: Len Brown <lenb@kernel.org>
Subject: [PATCH 69/84] PNP: introduce pnp_irq_mask_t typedef
Date: Sat, 28 Jun 2008 01:44:13 -0400
Message-ID: <faef2ce0bbcaf483a97b41f3ff4f13f12221c62b.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51151 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014AbYF1FrX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:47:23 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BIIS29AC42@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:46:58 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This adds a typedef for the IRQ bitmap, which should cause
no functional change, but will make it easier to pass a
pointer to a bitmap to pnp_register_irq_resource().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/base.h             |    4 +++-
 drivers/pnp/interface.c        |    4 ++--
 drivers/pnp/isapnp/core.c      |    2 +-
 drivers/pnp/manager.c          |    6 +++---
 drivers/pnp/pnpacpi/rsparser.c |    4 ++--
 drivers/pnp/pnpbios/rsparser.c |    2 +-
 drivers/pnp/quirks.c           |   11 +++++++----
 drivers/pnp/resource.c         |    6 +++---
 8 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index 3126e45..a9ee0a9 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -30,8 +30,10 @@ struct pnp_port {
 };
 
 #define PNP_IRQ_NR 256
+typedef struct { DECLARE_BITMAP(bits, PNP_IRQ_NR); } pnp_irq_mask_t;
+
 struct pnp_irq {
-	DECLARE_BITMAP(map, PNP_IRQ_NR);	/* bitmask for IRQ lines */
+	pnp_irq_mask_t map;	/* bitmap for IRQ lines */
 	unsigned char flags;	/* IRQ flags */
 	unsigned char pad;	/* pad */
 	struct pnp_irq *next;	/* next IRQ */
diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index c172b6d..249b407 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -67,7 +67,7 @@ static void pnp_print_irq(pnp_info_buffer_t * buffer, char *space,
 
 	pnp_printf(buffer, "%sirq ", space);
 	for (i = 0; i < PNP_IRQ_NR; i++)
-		if (test_bit(i, irq->map)) {
+		if (test_bit(i, irq->map.bits)) {
 			if (!first) {
 				pnp_printf(buffer, ",");
 			} else {
@@ -78,7 +78,7 @@ static void pnp_print_irq(pnp_info_buffer_t * buffer, char *space,
 			else
 				pnp_printf(buffer, "%i", i);
 		}
-	if (bitmap_empty(irq->map, PNP_IRQ_NR))
+	if (bitmap_empty(irq->map.bits, PNP_IRQ_NR))
 		pnp_printf(buffer, "<none>");
 	if (irq->flags & IORESOURCE_IRQ_HIGHEDGE)
 		pnp_printf(buffer, " High-Edge");
diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index c5b9252..e0caa71 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -441,7 +441,7 @@ static void __init isapnp_parse_irq_resource(struct pnp_dev *dev,
 	if (!irq)
 		return;
 	bits = (tmp[1] << 8) | tmp[0];
-	bitmap_copy(irq->map, &bits, 16);
+	bitmap_copy(irq->map.bits, &bits, 16);
 	if (size > 2)
 		irq->flags = tmp[2];
 	else
diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index 165b624..e758dd2 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -128,20 +128,20 @@ static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
 	res->start = -1;
 	res->end = -1;
 
-	if (bitmap_empty(rule->map, PNP_IRQ_NR)) {
+	if (bitmap_empty(rule->map.bits, PNP_IRQ_NR)) {
 		res->flags |= IORESOURCE_DISABLED;
 		dev_dbg(&dev->dev, "  irq %d disabled\n", idx);
 		goto __add;
 	}
 
 	/* TBD: need check for >16 IRQ */
-	res->start = find_next_bit(rule->map, PNP_IRQ_NR, 16);
+	res->start = find_next_bit(rule->map.bits, PNP_IRQ_NR, 16);
 	if (res->start < PNP_IRQ_NR) {
 		res->end = res->start;
 		goto __add;
 	}
 	for (i = 0; i < 16; i++) {
-		if (test_bit(xtab[i], rule->map)) {
+		if (test_bit(xtab[i], rule->map.bits)) {
 			res->start = res->end = xtab[i];
 			if (pnp_check_irq(dev, res))
 				goto __add;
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 46069e6..ae65454 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -442,7 +442,7 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
 
 	for (i = 0; i < p->interrupt_count; i++)
 		if (p->interrupts[i])
-			__set_bit(p->interrupts[i], irq->map);
+			__set_bit(p->interrupts[i], irq->map.bits);
 	irq->flags = irq_flags(p->triggering, p->polarity, p->sharable);
 
 	pnp_register_irq_resource(dev, option, irq);
@@ -463,7 +463,7 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
 
 	for (i = 0; i < p->interrupt_count; i++)
 		if (p->interrupts[i])
-			__set_bit(p->interrupts[i], irq->map);
+			__set_bit(p->interrupts[i], irq->map.bits);
 	irq->flags = irq_flags(p->triggering, p->polarity, p->sharable);
 
 	pnp_register_irq_resource(dev, option, irq);
diff --git a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
index 489fec3..dd2ea7b 100644
--- a/drivers/pnp/pnpbios/rsparser.c
+++ b/drivers/pnp/pnpbios/rsparser.c
@@ -275,7 +275,7 @@ static __init void pnpbios_parse_irq_option(struct pnp_dev *dev,
 	if (!irq)
 		return;
 	bits = (p[2] << 8) | p[1];
-	bitmap_copy(irq->map, &bits, 16);
+	bitmap_copy(irq->map.bits, &bits, 16);
 	if (size > 2)
 		irq->flags = p[3];
 	else
diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index 21acb54..48e6017 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -66,15 +66,18 @@ static void quirk_cmi8330_resources(struct pnp_dev *dev)
 		struct pnp_irq *irq;
 		struct pnp_dma *dma;
 
-		for (irq = res->irq; irq; irq = irq->next) {	// Valid irqs are 5, 7, 10
+		for (irq = res->irq; irq; irq = irq->next) {
+			/* Valid irqs are 5, 7, 10 */
 			tmp = 0x04A0;
-			bitmap_copy(irq->map, &tmp, 16);	// 0000 0100 1010 0000
+			bitmap_copy(irq->map.bits, &tmp, 16);
 		}
 
-		for (dma = res->dma; dma; dma = dma->next)	// Valid 8bit dma channels are 1,3
+		for (dma = res->dma; dma; dma = dma->next) {
+			/* Valid 8bit dma channels are 1,3 */
 			if ((dma->flags & IORESOURCE_DMA_TYPE_MASK) ==
 			    IORESOURCE_DMA_8BIT)
 				dma->map = 0x000A;
+		}
 	}
 	dev_info(&dev->dev, "CMI8330 quirk - forced possible IRQs to 5, 7, 10 "
 		"and DMA channels to 1, 3\n");
@@ -187,7 +190,7 @@ static void quirk_ad1815_mpu_resources(struct pnp_dev *dev)
 		if (!copy)
 			break;
 
-		memcpy(copy->map, irq->map, sizeof copy->map);
+		bitmap_copy(copy->map.bits, irq->map.bits, PNP_IRQ_NR);
 		copy->flags = irq->flags;
 
 		copy->next = res->irq; /* Yes, this is NULL */
diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 786fd35..55a57cd 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -98,13 +98,13 @@ int pnp_register_irq_resource(struct pnp_dev *dev, struct pnp_option *option,
 		int i;
 
 		for (i = 0; i < 16; i++)
-			if (test_bit(i, data->map))
+			if (test_bit(i, data->map.bits))
 				pcibios_penalize_isa_irq(i, 0);
 	}
 #endif
 
 #ifdef DEBUG
-	bitmap_scnprintf(buf, sizeof(buf), data->map, PNP_IRQ_NR);
+	bitmap_scnprintf(buf, sizeof(buf), data->map.bits, PNP_IRQ_NR);
 	dev_dbg(&dev->dev, "  irq bitmask %s flags %#x\n", buf,
 		data->flags);
 #endif
@@ -653,7 +653,7 @@ static int pnp_possible_option(struct pnp_option *option, int type,
 		case IORESOURCE_IRQ:
 			for (irq = tmp->irq; irq; irq = irq->next) {
 				if (start < PNP_IRQ_NR &&
-				    test_bit(start, irq->map))
+				    test_bit(start, irq->map.bits))
 					return 1;
 			}
 			break;
-- 
1.5.6.1.89.gd544

