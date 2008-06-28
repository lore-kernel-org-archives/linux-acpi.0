From: Len Brown <lenb@kernel.org>
Subject: [PATCH 60/84] PNP: make pnp_{port,mem,etc}_start(),
 et al work for invalid resources
Date: Sat, 28 Jun 2008 01:44:04 -0400
Message-ID: <e49e9994db232f0f285d8c75fe1bd72da8b95552.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:36480 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbYF1Fpn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:43 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K350032ARZXW4ZD@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:34 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Some callers use pnp_port_start() and similar functions without
making sure the resource is valid.  This patch makes us fall
back to returning the initial values if the resource is not
valid or not even present.

This mostly preserves the previous behavior, where we would just
return the initial values set by pnp_init_resource_table().  The
original 2.6.25 code didn't range-check the "bar", so it would
return garbage if the bar exceeded the table size.  This code
returns sensible values instead.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/pnp.h |   72 ++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 63b128d..8b607ae 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -40,19 +40,31 @@ static inline resource_size_t pnp_resource_len(struct resource *res)
 static inline resource_size_t pnp_port_start(struct pnp_dev *dev,
 					     unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_IO, bar)->start;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_IO, bar);
+
+	if (pnp_resource_valid(res))
+		return res->start;
+	return 0;
 }
 
 static inline resource_size_t pnp_port_end(struct pnp_dev *dev,
 					   unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_IO, bar)->end;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_IO, bar);
+
+	if (pnp_resource_valid(res))
+		return res->end;
+	return 0;
 }
 
 static inline unsigned long pnp_port_flags(struct pnp_dev *dev,
 					   unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_IO, bar)->flags;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_IO, bar);
+
+	if (pnp_resource_valid(res))
+		return res->flags;
+	return IORESOURCE_IO | IORESOURCE_AUTO | IORESOURCE_UNSET;
 }
 
 static inline int pnp_port_valid(struct pnp_dev *dev, unsigned int bar)
@@ -63,25 +75,41 @@ static inline int pnp_port_valid(struct pnp_dev *dev, unsigned int bar)
 static inline resource_size_t pnp_port_len(struct pnp_dev *dev,
 					   unsigned int bar)
 {
-	return pnp_resource_len(pnp_get_resource(dev, IORESOURCE_IO, bar));
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_IO, bar);
+
+	if (pnp_resource_valid(res))
+		return pnp_resource_len(res);
+	return 0;
 }
 
 
 static inline resource_size_t pnp_mem_start(struct pnp_dev *dev,
 					    unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_MEM, bar)->start;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_MEM, bar);
+
+	if (pnp_resource_valid(res))
+		return res->start;
+	return 0;
 }
 
 static inline resource_size_t pnp_mem_end(struct pnp_dev *dev,
 					  unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_MEM, bar)->end;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_MEM, bar);
+
+	if (pnp_resource_valid(res))
+		return res->end;
+	return 0;
 }
 
 static inline unsigned long pnp_mem_flags(struct pnp_dev *dev, unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_MEM, bar)->flags;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_MEM, bar);
+
+	if (pnp_resource_valid(res))
+		return res->flags;
+	return IORESOURCE_MEM | IORESOURCE_AUTO | IORESOURCE_UNSET;
 }
 
 static inline int pnp_mem_valid(struct pnp_dev *dev, unsigned int bar)
@@ -92,18 +120,30 @@ static inline int pnp_mem_valid(struct pnp_dev *dev, unsigned int bar)
 static inline resource_size_t pnp_mem_len(struct pnp_dev *dev,
 					  unsigned int bar)
 {
-	return pnp_resource_len(pnp_get_resource(dev, IORESOURCE_MEM, bar));
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_MEM, bar);
+
+	if (pnp_resource_valid(res))
+		return pnp_resource_len(res);
+	return 0;
 }
 
 
 static inline resource_size_t pnp_irq(struct pnp_dev *dev, unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_IRQ, bar)->start;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_IRQ, bar);
+
+	if (pnp_resource_valid(res))
+		return res->start;
+	return -1;
 }
 
 static inline unsigned long pnp_irq_flags(struct pnp_dev *dev, unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_IRQ, bar)->flags;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_IRQ, bar);
+
+	if (pnp_resource_valid(res))
+		return res->flags;
+	return IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
 }
 
 static inline int pnp_irq_valid(struct pnp_dev *dev, unsigned int bar)
@@ -114,12 +154,20 @@ static inline int pnp_irq_valid(struct pnp_dev *dev, unsigned int bar)
 
 static inline resource_size_t pnp_dma(struct pnp_dev *dev, unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_DMA, bar)->start;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_DMA, bar);
+
+	if (pnp_resource_valid(res))
+		return res->start;
+	return -1;
 }
 
 static inline unsigned long pnp_dma_flags(struct pnp_dev *dev, unsigned int bar)
 {
-	return pnp_get_resource(dev, IORESOURCE_DMA, bar)->flags;
+	struct resource *res = pnp_get_resource(dev, IORESOURCE_DMA, bar);
+
+	if (pnp_resource_valid(res))
+		return res->flags;
+	return IORESOURCE_DMA | IORESOURCE_AUTO | IORESOURCE_UNSET;
 }
 
 static inline int pnp_dma_valid(struct pnp_dev *dev, unsigned int bar)
-- 
1.5.6.1.89.gd544

