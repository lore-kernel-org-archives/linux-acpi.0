From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 1/4] PNP: make pnp_{port,mem,etc}_start(), et al work for invalid resources
Date: Thu, 15 May 2008 16:07:27 -0600
Message-ID: <20080515220754.366570486@ldl.fc.hp.com>
References: <20080515220726.029505668@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:22715 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbYEOW5W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 18:57:22 -0400
Content-Disposition: inline; filename=pnp-make-accessors-work-for-invalid-bars
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

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

Index: work10/include/linux/pnp.h
===================================================================
--- work10.orig/include/linux/pnp.h	2008-05-14 16:57:23.000000000 -0600
+++ work10/include/linux/pnp.h	2008-05-14 17:04:30.000000000 -0600
@@ -40,19 +40,31 @@ static inline resource_size_t pnp_resour
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
@@ -63,25 +75,41 @@ static inline int pnp_port_valid(struct 
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
@@ -92,18 +120,30 @@ static inline int pnp_mem_valid(struct p
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
@@ -114,12 +154,20 @@ static inline int pnp_irq_valid(struct p
 
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
