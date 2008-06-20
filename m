From: Len Brown <lenb@kernel.org>
Subject: [PATCH 60/70] PNP: rename pnp_register_*_resource() local variables
Date: Fri, 20 Jun 2008 03:44:02 -0400
Message-ID: <a630737c64a2c831bea0f11fc85b58a8ab20f3f7.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:53530 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbYFTHp0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:45:26 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R007RK3WHDNE3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:38:42 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

No functional change; just rename "data" to something more
descriptive.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/resource.c |   94 ++++++++++++++++++++++++------------------------
 1 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 6114549..a795864 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -80,40 +80,40 @@ struct pnp_option *pnp_register_dependent_option(struct pnp_dev *dev,
 int pnp_register_irq_resource(struct pnp_dev *dev, struct pnp_option *option,
 			      pnp_irq_mask_t *map, unsigned char flags)
 {
-	struct pnp_irq *data, *ptr;
+	struct pnp_irq *irq, *ptr;
 #ifdef DEBUG
 	char buf[PNP_IRQ_NR];   /* hex-encoded, so this is overkill but safe */
 #endif
 
-	data = kzalloc(sizeof(struct pnp_irq), GFP_KERNEL);
-	if (!data)
+	irq = kzalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
 		return -ENOMEM;
 
-	data->map = *map;
-	data->flags = flags;
+	irq->map = *map;
+	irq->flags = flags;
 
 	ptr = option->irq;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
 	if (ptr)
-		ptr->next = data;
+		ptr->next = irq;
 	else
-		option->irq = data;
+		option->irq = irq;
 
 #ifdef CONFIG_PCI
 	{
 		int i;
 
 		for (i = 0; i < 16; i++)
-			if (test_bit(i, data->map.bits))
+			if (test_bit(i, irq->map.bits))
 				pcibios_penalize_isa_irq(i, 0);
 	}
 #endif
 
 #ifdef DEBUG
-	bitmap_scnprintf(buf, sizeof(buf), data->map.bits, PNP_IRQ_NR);
+	bitmap_scnprintf(buf, sizeof(buf), irq->map.bits, PNP_IRQ_NR);
 	dev_dbg(&dev->dev, "  irq bitmask %s flags %#x\n", buf,
-		data->flags);
+		irq->flags);
 #endif
 	return 0;
 }
@@ -121,25 +121,25 @@ int pnp_register_irq_resource(struct pnp_dev *dev, struct pnp_option *option,
 int pnp_register_dma_resource(struct pnp_dev *dev, struct pnp_option *option,
 			      unsigned char map, unsigned char flags)
 {
-	struct pnp_dma *data, *ptr;
+	struct pnp_dma *dma, *ptr;
 
-	data = kzalloc(sizeof(struct pnp_dma), GFP_KERNEL);
-	if (!data)
+	dma = kzalloc(sizeof(struct pnp_dma), GFP_KERNEL);
+	if (!dma)
 		return -ENOMEM;
 
-	data->map = map;
-	data->flags = flags;
+	dma->map = map;
+	dma->flags = flags;
 
 	ptr = option->dma;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
 	if (ptr)
-		ptr->next = data;
+		ptr->next = dma;
 	else
-		option->dma = data;
+		option->dma = dma;
 
-	dev_dbg(&dev->dev, "  dma bitmask %#x flags %#x\n", data->map,
-		data->flags);
+	dev_dbg(&dev->dev, "  dma bitmask %#x flags %#x\n", dma->map,
+		dma->flags);
 	return 0;
 }
 
@@ -148,32 +148,32 @@ int pnp_register_port_resource(struct pnp_dev *dev, struct pnp_option *option,
 			       resource_size_t align, resource_size_t size,
 			       unsigned char flags)
 {
-	struct pnp_port *data, *ptr;
+	struct pnp_port *port, *ptr;
 
-	data = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
-	if (!data)
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
 		return -ENOMEM;
 
-	data->min = min;
-	data->max = max;
-	data->align = align;
-	data->size = size;
-	data->flags = flags;
+	port->min = min;
+	port->max = max;
+	port->align = align;
+	port->size = size;
+	port->flags = flags;
 
 	ptr = option->port;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
 	if (ptr)
-		ptr->next = data;
+		ptr->next = port;
 	else
-		option->port = data;
+		option->port = port;
 
 	dev_dbg(&dev->dev, "  io  "
 		"min %#llx max %#llx align %lld size %lld flags %#x\n",
-		(unsigned long long) data->min,
-		(unsigned long long) data->max,
-		(unsigned long long) data->align,
-		(unsigned long long) data->size, data->flags);
+		(unsigned long long) port->min,
+		(unsigned long long) port->max,
+		(unsigned long long) port->align,
+		(unsigned long long) port->size, port->flags);
 	return 0;
 }
 
@@ -182,32 +182,32 @@ int pnp_register_mem_resource(struct pnp_dev *dev, struct pnp_option *option,
 			      resource_size_t align, resource_size_t size,
 			      unsigned char flags)
 {
-	struct pnp_mem *data, *ptr;
+	struct pnp_mem *mem, *ptr;
 
-	data = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
-	if (!data)
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
 		return -ENOMEM;
 
-	data->min = min;
-	data->max = max;
-	data->align = align;
-	data->size = size;
-	data->flags = flags;
+	mem->min = min;
+	mem->max = max;
+	mem->align = align;
+	mem->size = size;
+	mem->flags = flags;
 
 	ptr = option->mem;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
 	if (ptr)
-		ptr->next = data;
+		ptr->next = mem;
 	else
-		option->mem = data;
+		option->mem = mem;
 
 	dev_dbg(&dev->dev, "  mem "
 		"min %#llx max %#llx align %lld size %lld flags %#x\n",
-		(unsigned long long) data->min,
-		(unsigned long long) data->max,
-		(unsigned long long) data->align,
-		(unsigned long long) data->size, data->flags);
+		(unsigned long long) mem->min,
+		(unsigned long long) mem->max,
+		(unsigned long long) mem->align,
+		(unsigned long long) mem->size, mem->flags);
 	return 0;
 }
 
-- 
1.5.6

