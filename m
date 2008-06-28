From: Len Brown <lenb@kernel.org>
Subject: [PATCH 78/84] PNP: support optional IRQ resources
Date: Sat, 28 Jun 2008 01:44:22 -0400
Message-ID: <af1ce371b6de94b8e62086b7de828d36af0564e6.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:36032 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbYF1FsB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:48:01 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500DAJRS3W013@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:41:12 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds an IORESOURCE_IRQ_OPTIONAL flag for use when
assigning resources to a device.  If the flag is set and we are
unable to assign an IRQ to the device, we can leave the IRQ
disabled but allow the overall resource allocation to succeed.

Some devices request an IRQ, but can run without an IRQ
(possibly with degraded performance).  This flag lets us run
the device without the IRQ instead of just leaving the
device disabled.

This is a reimplementation of this previous change by Rene
Herman <rene.herman@gmail.com>:
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=3b73a223661ed137c5d3d2635f954382e94f5a43

I reimplemented this for two reasons:
    - to prepare for converting all resource options into a single linked
      list, as opposed to the per-resource-type lists we have now, and
    - to preserve the order and number of resource options.

In PNPBIOS and ACPI, we configure a device by giving firmware a
list of resource assignments.  It is important that this list
has exactly the same number of resources, in the same order,
as the "template" list we got from the firmware in the first
place.

The problem of a sound card MPU401 being left disabled for want of
an IRQ was reported by Uwe Bugla <uwe.bugla@gmx.de>.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/interface.c |    2 +
 drivers/pnp/manager.c   |    9 ++++++
 drivers/pnp/quirks.c    |   71 ++++++++++++++++++-----------------------------
 include/linux/ioport.h  |    1 +
 4 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index b09f67d..7a9fb55 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -90,6 +90,8 @@ static void pnp_print_irq(pnp_info_buffer_t * buffer, char *space,
 		pnp_printf(buffer, " High-Level");
 	if (irq->flags & IORESOURCE_IRQ_LOWLEVEL)
 		pnp_printf(buffer, " Low-Level");
+	if (irq->flags & IORESOURCE_IRQ_OPTIONAL)
+		pnp_printf(buffer, " (optional)");
 	pnp_printf(buffer, "\n");
 }
 
diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index 7ea9e1e..a20accb 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -153,6 +153,15 @@ static int pnp_assign_irq(struct pnp_dev *dev, struct pnp_irq *rule, int idx)
 				goto __add;
 		}
 	}
+
+	if (rule->flags & IORESOURCE_IRQ_OPTIONAL) {
+		res->start = -1;
+		res->end = -1;
+		res->flags |= IORESOURCE_DISABLED;
+		dev_dbg(&dev->dev, "  irq %d disabled (optional)\n", idx);
+		goto __add;
+	}
+
 	dev_dbg(&dev->dev, "  couldn't assign irq %d\n", idx);
 	return -EBUSY;
 
diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index 48e6017..e8515ce 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -121,34 +121,46 @@ static struct pnp_option *quirk_isapnp_mpu_options(struct pnp_dev *dev)
 	struct pnp_option *res;
 
 	/*
-	 * Build a functional IRQ-less variant of each MPU option.
+	 * Build a functional IRQ-optional variant of each MPU option.
 	 */
 
 	for (res = dev->dependent; res; res = res->next) {
 		struct pnp_option *curr;
 		struct pnp_port *port;
-		struct pnp_port *copy;
+		struct pnp_port *copy_port;
+		struct pnp_irq *irq;
+		struct pnp_irq *copy_irq;
 
 		port = res->port;
-		if (!port || !res->irq)
+		irq = res->irq;
+		if (!port || !irq)
 			continue;
 
-		copy = pnp_alloc(sizeof *copy);
-		if (!copy)
+		copy_port = pnp_alloc(sizeof *copy_port);
+		if (!copy_port)
+			break;
+
+		copy_irq = pnp_alloc(sizeof *copy_irq);
+		if (!copy_irq) {
+			kfree(copy_port);
 			break;
+		}
+
+		*copy_port = *port;
+		copy_port->next = NULL;
 
-		copy->min = port->min;
-		copy->max = port->max;
-		copy->align = port->align;
-		copy->size = port->size;
-		copy->flags = port->flags;
+		*copy_irq = *irq;
+		copy_irq->flags |= IORESOURCE_IRQ_OPTIONAL;
+		copy_irq->next = NULL;
 
 		curr = pnp_build_option(PNP_RES_PRIORITY_FUNCTIONAL);
 		if (!curr) {
-			kfree(copy);
+			kfree(copy_port);
+			kfree(copy_irq);
 			break;
 		}
-		curr->port = copy;
+		curr->port = copy_port;
+		curr->irq = copy_irq;
 
 		if (prev)
 			prev->next = curr;
@@ -157,7 +169,7 @@ static struct pnp_option *quirk_isapnp_mpu_options(struct pnp_dev *dev)
 		prev = curr;
 	}
 	if (head)
-		dev_info(&dev->dev, "adding IRQ-less MPU options\n");
+		dev_info(&dev->dev, "adding IRQ-optional MPU options\n");
 
 	return head;
 }
@@ -167,10 +179,6 @@ static void quirk_ad1815_mpu_resources(struct pnp_dev *dev)
 	struct pnp_option *res;
 	struct pnp_irq *irq;
 
-	/*
-	 * Distribute the independent IRQ over the dependent options
-	 */
-
 	res = dev->independent;
 	if (!res)
 		return;
@@ -179,33 +187,8 @@ static void quirk_ad1815_mpu_resources(struct pnp_dev *dev)
 	if (!irq || irq->next)
 		return;
 
-	res = dev->dependent;
-	if (!res)
-		return;
-
-	while (1) {
-		struct pnp_irq *copy;
-
-		copy = pnp_alloc(sizeof *copy);
-		if (!copy)
-			break;
-
-		bitmap_copy(copy->map.bits, irq->map.bits, PNP_IRQ_NR);
-		copy->flags = irq->flags;
-
-		copy->next = res->irq; /* Yes, this is NULL */
-		res->irq = copy;
-
-		if (!res->next)
-			break;
-		res = res->next;
-	}
-	kfree(irq);
-
-	res->next = quirk_isapnp_mpu_options(dev);
-
-	res = dev->independent;
-	res->irq = NULL;
+	irq->flags |= IORESOURCE_IRQ_OPTIONAL;
+	dev_info(&dev->dev, "made independent IRQ optional\n");
 }
 
 static void quirk_isapnp_mpu_resources(struct pnp_dev *dev)
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 39db059..08c825b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -59,6 +59,7 @@ struct resource_list {
 #define IORESOURCE_IRQ_HIGHLEVEL	(1<<2)
 #define IORESOURCE_IRQ_LOWLEVEL		(1<<3)
 #define IORESOURCE_IRQ_SHAREABLE	(1<<4)
+#define IORESOURCE_IRQ_OPTIONAL		(1<<5)
 
 /* PnP DMA specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_DMA_TYPE_MASK	(3<<0)
-- 
1.5.6.1.89.gd544

