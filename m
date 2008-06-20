From: Len Brown <lenb@kernel.org>
Subject: [PATCH 48/70] PNP: add pnp_possible_config() -- can a device could be
 configured this way?
Date: Fri, 20 Jun 2008 03:43:50 -0400
Message-ID: <f2517484fe1f43b258788cf246c8a79117720ed8.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40470 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbYFTHot (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:49 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00EKL46J1LE2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:44 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

As part of a heuristic to identify modem devices, 8250_pnp.c
checks to see whether a device can be configured at any of the
legacy COM port addresses.

This patch moves the code that traverses the PNP "possible resource
options" from 8250_pnp.c to the PNP subsystem.  This encapsulation
is important because a future patch will change the implementation
of those resource options.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/resource.c    |   62 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/serial/8250_pnp.c |   24 +++++------------
 include/linux/pnp.h       |    3 ++
 3 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index ff79aa6..786fd35 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -624,6 +624,68 @@ struct pnp_resource *pnp_add_mem_resource(struct pnp_dev *dev,
 	return pnp_res;
 }
 
+static int pnp_possible_option(struct pnp_option *option, int type,
+			       resource_size_t start, resource_size_t size)
+{
+	struct pnp_option *tmp;
+	struct pnp_port *port;
+	struct pnp_mem *mem;
+	struct pnp_irq *irq;
+	struct pnp_dma *dma;
+
+	if (!option)
+		return 0;
+
+	for (tmp = option; tmp; tmp = tmp->next) {
+		switch (type) {
+		case IORESOURCE_IO:
+			for (port = tmp->port; port; port = port->next) {
+				if (port->min == start && port->size == size)
+					return 1;
+			}
+			break;
+		case IORESOURCE_MEM:
+			for (mem = tmp->mem; mem; mem = mem->next) {
+				if (mem->min == start && mem->size == size)
+					return 1;
+			}
+			break;
+		case IORESOURCE_IRQ:
+			for (irq = tmp->irq; irq; irq = irq->next) {
+				if (start < PNP_IRQ_NR &&
+				    test_bit(start, irq->map))
+					return 1;
+			}
+			break;
+		case IORESOURCE_DMA:
+			for (dma = tmp->dma; dma; dma = dma->next) {
+				if (dma->map & (1 << start))
+					return 1;
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Determine whether the specified resource is a possible configuration
+ * for this device.
+ */
+int pnp_possible_config(struct pnp_dev *dev, int type, resource_size_t start,
+			resource_size_t size)
+{
+	if (pnp_possible_option(dev->independent, type, start, size))
+		return 1;
+
+	if (pnp_possible_option(dev->dependent, type, start, size))
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(pnp_possible_config);
+
 /* format is: pnp_reserve_irq=irq1[,irq2] .... */
 static int __init pnp_setup_reserve_irq(char *str)
 {
diff --git a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
index 97c68d0..638b686 100644
--- a/drivers/serial/8250_pnp.c
+++ b/drivers/serial/8250_pnp.c
@@ -383,21 +383,14 @@ static int __devinit check_name(char *name)
 	return 0;
 }
 
-static int __devinit check_resources(struct pnp_option *option)
+static int __devinit check_resources(struct pnp_dev *dev)
 {
-	struct pnp_option *tmp;
-	if (!option)
-		return 0;
+	resource_size_t base[] = {0x2f8, 0x3f8, 0x2e8, 0x3e8};
+	int i;
 
-	for (tmp = option; tmp; tmp = tmp->next) {
-		struct pnp_port *port;
-		for (port = tmp->port; port; port = port->next)
-			if ((port->size == 8) &&
-			    ((port->min == 0x2f8) ||
-			     (port->min == 0x3f8) ||
-			     (port->min == 0x2e8) ||
-			     (port->min == 0x3e8)))
-				return 1;
+	for (i = 0; i < ARRAY_SIZE(base); i++) {
+		if (pnp_possible_config(dev, IORESOURCE_IO, base[i], 8))
+			return 1;
 	}
 
 	return 0;
@@ -420,10 +413,7 @@ static int __devinit serial_pnp_guess_board(struct pnp_dev *dev, int *flags)
 		(dev->card && check_name(dev->card->name))))
 			return -ENODEV;
 
-	if (check_resources(dev->independent))
-		return 0;
-
-	if (check_resources(dev->dependent))
+	if (check_resources(dev))
 		return 0;
 
 	return -ENODEV;
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index dfaa567..86e0e1d 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -479,6 +479,8 @@ void pnp_unregister_card_driver(struct pnp_card_driver *drv);
 extern struct list_head pnp_cards;
 
 /* resource management */
+int pnp_possible_config(struct pnp_dev *dev, int type, resource_size_t base,
+			resource_size_t size);
 int pnp_auto_config_dev(struct pnp_dev *dev);
 int pnp_start_dev(struct pnp_dev *dev);
 int pnp_stop_dev(struct pnp_dev *dev);
@@ -506,6 +508,7 @@ static inline int pnp_register_card_driver(struct pnp_card_driver *drv) { return
 static inline void pnp_unregister_card_driver(struct pnp_card_driver *drv) { }
 
 /* resource management */
+static inline int pnp_possible_config(struct pnp_dev *dev, int type, resource_size_t base, resource_size_t size) { return 0; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_start_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
-- 
1.5.6

