From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 29/37] PNP: convert encoders to use pnp_get_resource(), not pnp_resource_table
Date: Wed, 26 Mar 2008 11:11:27 -0600
Message-ID: <20080326171229.165625297@ldl.fc.hp.com>
References: <20080326171058.099442579@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:22221 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761114AbYCZRJL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 13:09:11 -0400
Content-Disposition: inline; filename=pnp-convert-encoders-to-pnp_get_resource
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This removes more direct references to pnp_resource_table.  This
path is used when setting the resources used by a device.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work7/drivers/pnp/isapnp/core.c
===================================================================
--- work7.orig/drivers/pnp/isapnp/core.c	2008-03-26 10:04:57.000000000 -0600
+++ work7/drivers/pnp/isapnp/core.c	2008-03-26 10:18:06.000000000 -0600
@@ -982,42 +982,37 @@
 
 static int isapnp_set_resources(struct pnp_dev *dev)
 {
-	struct pnp_resource_table *res = &dev->res;
-	int tmp;
+	int i, irq;
+	struct resource *res;
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = 1;
-	for (tmp = 0;
-	     tmp < ISAPNP_MAX_PORT
-	     && (res->port_resource[tmp].
-		 flags & (IORESOURCE_IO | IORESOURCE_UNSET)) == IORESOURCE_IO;
-	     tmp++)
-		isapnp_write_word(ISAPNP_CFG_PORT + (tmp << 1),
-				  res->port_resource[tmp].start);
-	for (tmp = 0;
-	     tmp < ISAPNP_MAX_IRQ
-	     && (res->irq_resource[tmp].
-		 flags & (IORESOURCE_IRQ | IORESOURCE_UNSET)) == IORESOURCE_IRQ;
-	     tmp++) {
-		int irq = res->irq_resource[tmp].start;
-		if (irq == 2)
-			irq = 9;
-		isapnp_write_byte(ISAPNP_CFG_IRQ + (tmp << 1), irq);
-	}
-	for (tmp = 0;
-	     tmp < ISAPNP_MAX_DMA
-	     && (res->dma_resource[tmp].
-		 flags & (IORESOURCE_DMA | IORESOURCE_UNSET)) == IORESOURCE_DMA;
-	     tmp++)
-		isapnp_write_byte(ISAPNP_CFG_DMA + tmp,
-				  res->dma_resource[tmp].start);
-	for (tmp = 0;
-	     tmp < ISAPNP_MAX_MEM
-	     && (res->mem_resource[tmp].
-		 flags & (IORESOURCE_MEM | IORESOURCE_UNSET)) == IORESOURCE_MEM;
-	     tmp++)
-		isapnp_write_word(ISAPNP_CFG_MEM + (tmp << 3),
-				  (res->mem_resource[tmp].start >> 8) & 0xffff);
+	for (i = 0; i < ISAPNP_MAX_PORT; i++) {
+		res = pnp_get_resource(dev, IORESOURCE_IO, i);
+		if (res && !(res->flags & IORESOURCE_UNSET))
+			isapnp_write_word(ISAPNP_CFG_PORT + (i << 1),
+					  res->start);
+	}
+	for (i = 0; i < ISAPNP_MAX_IRQ; i++) {
+		res = pnp_get_resource(dev, IORESOURCE_IRQ, i);
+		if (res && !(res->flags & IORESOURCE_UNSET)) {
+			irq = res->start;
+			if (irq == 2)
+				irq = 9;
+			isapnp_write_byte(ISAPNP_CFG_IRQ + (i << 1), irq);
+		}
+	}
+	for (i = 0; i < ISAPNP_MAX_DMA; i++) {
+		res = pnp_get_resource(dev, IORESOURCE_DMA, i);
+		if (res && !(res->flags & IORESOURCE_UNSET))
+			isapnp_write_byte(ISAPNP_CFG_DMA + i, res->start);
+	}
+	for (i = 0; i < ISAPNP_MAX_MEM; i++) {
+		res = pnp_get_resource(dev, IORESOURCE_MEM, i);
+		if (res && !(res->flags & IORESOURCE_UNSET))
+			isapnp_write_word(ISAPNP_CFG_MEM + (i << 3),
+					  (res->start >> 8) & 0xffff);
+	}
 	/* FIXME: We aren't handling 32bit mems properly here */
 	isapnp_activate(dev->number);
 	isapnp_cfg_end();
Index: work7/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work7.orig/drivers/pnp/pnpacpi/rsparser.c	2008-03-26 10:18:03.000000000 -0600
+++ work7/drivers/pnp/pnpacpi/rsparser.c	2008-03-26 10:18:06.000000000 -0600
@@ -852,7 +852,6 @@
 
 int pnpacpi_encode_resources(struct pnp_dev *dev, struct acpi_buffer *buffer)
 {
-	struct pnp_resource_table *res_table = &dev->res;
 	int i = 0;
 	/* pnpacpi_build_resource_template allocates extra mem */
 	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
@@ -863,45 +862,43 @@
 		switch (resource->type) {
 		case ACPI_RESOURCE_TYPE_IRQ:
 			pnpacpi_encode_irq(resource,
-					   &res_table->irq_resource[irq]);
+				pnp_get_resource(dev, IORESOURCE_IRQ, irq));
 			irq++;
 			break;
 
 		case ACPI_RESOURCE_TYPE_DMA:
 			pnpacpi_encode_dma(resource,
-					   &res_table->dma_resource[dma]);
+				pnp_get_resource(dev, IORESOURCE_DMA, dma));
 			dma++;
 			break;
 		case ACPI_RESOURCE_TYPE_IO:
 			pnpacpi_encode_io(resource,
-					  &res_table->port_resource[port]);
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_IO:
 			pnpacpi_encode_fixed_io(resource,
-						&res_table->
-						port_resource[port]);
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY24:
 			pnpacpi_encode_mem24(resource,
-					     &res_table->mem_resource[mem]);
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY32:
 			pnpacpi_encode_mem32(resource,
-					     &res_table->mem_resource[mem]);
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
 			pnpacpi_encode_fixed_mem32(resource,
-						   &res_table->
-						   mem_resource[mem]);
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 			pnpacpi_encode_ext_irq(resource,
-					       &res_table->irq_resource[irq]);
+				pnp_get_resource(dev, IORESOURCE_IRQ, irq));
 			irq++;
 			break;
 		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
Index: work7/drivers/pnp/pnpbios/rsparser.c
===================================================================
--- work7.orig/drivers/pnp/pnpbios/rsparser.c	2008-03-26 10:01:31.000000000 -0600
+++ work7/drivers/pnp/pnpbios/rsparser.c	2008-03-26 10:18:06.000000000 -0600
@@ -592,7 +592,6 @@
 							     unsigned char *p,
 							     unsigned char *end)
 {
-	struct pnp_resource_table *res = &dev->res;
 	unsigned int len, tag;
 	int port = 0, irq = 0, dma = 0, mem = 0;
 
@@ -615,42 +614,48 @@
 		case LARGE_TAG_MEM:
 			if (len != 9)
 				goto len_err;
-			pnpbios_encode_mem(p, &res->mem_resource[mem]);
+			pnpbios_encode_mem(p,
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 
 		case LARGE_TAG_MEM32:
 			if (len != 17)
 				goto len_err;
-			pnpbios_encode_mem32(p, &res->mem_resource[mem]);
+			pnpbios_encode_mem32(p,
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 
 		case LARGE_TAG_FIXEDMEM32:
 			if (len != 9)
 				goto len_err;
-			pnpbios_encode_fixed_mem32(p, &res->mem_resource[mem]);
+			pnpbios_encode_fixed_mem32(p,
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 
 		case SMALL_TAG_IRQ:
 			if (len < 2 || len > 3)
 				goto len_err;
-			pnpbios_encode_irq(p, &res->irq_resource[irq]);
+			pnpbios_encode_irq(p,
+				pnp_get_resource(dev, IORESOURCE_IRQ, irq));
 			irq++;
 			break;
 
 		case SMALL_TAG_DMA:
 			if (len != 2)
 				goto len_err;
-			pnpbios_encode_dma(p, &res->dma_resource[dma]);
+			pnpbios_encode_dma(p,
+				pnp_get_resource(dev, IORESOURCE_DMA, dma));
 			dma++;
 			break;
 
 		case SMALL_TAG_PORT:
 			if (len != 7)
 				goto len_err;
-			pnpbios_encode_port(p, &res->port_resource[port]);
+			pnpbios_encode_port(p,
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 
@@ -661,7 +666,8 @@
 		case SMALL_TAG_FIXEDPORT:
 			if (len != 3)
 				goto len_err;
-			pnpbios_encode_fixed_port(p, &res->port_resource[port]);
+			pnpbios_encode_fixed_port(p,
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 

-- 
