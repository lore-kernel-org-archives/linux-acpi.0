From: Len Brown <lenb@kernel.org>
Subject: [PATCH 70/84] PNP: increase I/O port & memory option address sizes
Date: Sat, 28 Jun 2008 01:44:14 -0400
Message-ID: <154868e7f2f5ef8bb6d94fd2bc812edd67325a9c.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51151 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbYF1FrZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:47:25 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BABS2AA872@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:46:59 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

ACPI Address Space Descriptors can be up to 64 bits wide.
We should keep track of the whole thing when parsing resource
options, so this patch changes PNP port and mem option
fields from "unsigned short" and "unsigned int" to
"resource_size_t".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/base.h      |   16 ++++++++--------
 drivers/pnp/interface.c |   17 +++++++++++------
 drivers/pnp/resource.c  |   14 ++++++++++----
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index a9ee0a9..afbeee5 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -20,10 +20,10 @@ int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev);
 void pnp_remove_card_device(struct pnp_dev *dev);
 
 struct pnp_port {
-	unsigned short min;	/* min base number */
-	unsigned short max;	/* max base number */
-	unsigned char align;	/* align boundary */
-	unsigned char size;	/* size of range */
+	resource_size_t min;	/* min base number */
+	resource_size_t max;	/* max base number */
+	resource_size_t align;	/* align boundary */
+	resource_size_t size;	/* size of range */
 	unsigned char flags;	/* port flags */
 	unsigned char pad;	/* pad */
 	struct pnp_port *next;	/* next port */
@@ -46,10 +46,10 @@ struct pnp_dma {
 };
 
 struct pnp_mem {
-	unsigned int min;	/* min base number */
-	unsigned int max;	/* max base number */
-	unsigned int align;	/* align boundary */
-	unsigned int size;	/* size of range */
+	resource_size_t min;	/* min base number */
+	resource_size_t max;	/* max base number */
+	resource_size_t align;	/* align boundary */
+	resource_size_t size;	/* size of range */
 	unsigned char flags;	/* memory flags */
 	unsigned char pad;	/* pad */
 	struct pnp_mem *next;	/* next memory resource */
diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 249b407..b09f67d 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -53,10 +53,12 @@ static int pnp_printf(pnp_info_buffer_t * buffer, char *fmt, ...)
 static void pnp_print_port(pnp_info_buffer_t * buffer, char *space,
 			   struct pnp_port *port)
 {
-	pnp_printf(buffer,
-		   "%sport 0x%x-0x%x, align 0x%x, size 0x%x, %i-bit address decoding\n",
-		   space, port->min, port->max,
-		   port->align ? (port->align - 1) : 0, port->size,
+	pnp_printf(buffer, "%sport %#llx-%#llx, align %#llx, size %#llx, "
+		   "%i-bit address decoding\n", space,
+		   (unsigned long long) port->min,
+		   (unsigned long long) port->max,
+		   port->align ? ((unsigned long long) port->align - 1) : 0,
+		   (unsigned long long) port->size,
 		   port->flags & IORESOURCE_IO_16BIT_ADDR ? 16 : 10);
 }
 
@@ -148,8 +150,11 @@ static void pnp_print_mem(pnp_info_buffer_t * buffer, char *space,
 {
 	char *s;
 
-	pnp_printf(buffer, "%sMemory 0x%x-0x%x, align 0x%x, size 0x%x",
-		   space, mem->min, mem->max, mem->align, mem->size);
+	pnp_printf(buffer, "%sMemory %#llx-%#llx, align %#llx, size %#llx",
+		   space, (unsigned long long) mem->min,
+		   (unsigned long long) mem->max,
+		   (unsigned long long) mem->align,
+		   (unsigned long long) mem->size);
 	if (mem->flags & IORESOURCE_MEM_WRITEABLE)
 		pnp_printf(buffer, ", writeable");
 	if (mem->flags & IORESOURCE_MEM_CACHEABLE)
diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 55a57cd..391828c 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -143,8 +143,11 @@ int pnp_register_port_resource(struct pnp_dev *dev, struct pnp_option *option,
 		option->port = data;
 
 	dev_dbg(&dev->dev, "  io  "
-		"min %#x max %#x align %d size %d flags %#x\n",
-		data->min, data->max, data->align, data->size, data->flags);
+		"min %#llx max %#llx align %lld size %lld flags %#x\n",
+		(unsigned long long) data->min,
+		(unsigned long long) data->max,
+		(unsigned long long) data->align,
+		(unsigned long long) data->size, data->flags);
 	return 0;
 }
 
@@ -162,8 +165,11 @@ int pnp_register_mem_resource(struct pnp_dev *dev, struct pnp_option *option,
 		option->mem = data;
 
 	dev_dbg(&dev->dev, "  mem "
-		"min %#x max %#x align %d size %d flags %#x\n",
-		data->min, data->max, data->align, data->size, data->flags);
+		"min %#llx max %#llx align %lld size %lld flags %#x\n",
+		(unsigned long long) data->min,
+		(unsigned long long) data->max,
+		(unsigned long long) data->align,
+		(unsigned long long) data->size, data->flags);
 	return 0;
 }
 
-- 
1.5.6.1.89.gd544

