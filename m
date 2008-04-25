From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 37/54] PNP: convert encoders to use pnp_get_resource(), not pnp_resource_table
Date: Fri, 25 Apr 2008 12:38:44 -0600
Message-ID: <20080425183931.626226516@ldl.fc.hp.com>
References: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:19297 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761259AbYDYSkR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:40:17 -0400
Content-Disposition: inline; filename=pnp-convert-encoders-to-pnp_get_resource
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This removes more direct references to pnp_resource_table.  This
path is used when telling a device what resources it should use.

This doesn't convert ISAPNP because ISA needs to know the config
register index in addition to the resource itself.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work10/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work10.orig/drivers/pnp/pnpacpi/rsparser.c	2008-04-25 11:14:59.000000000 -0600
+++ work10/drivers/pnp/pnpacpi/rsparser.c	2008-04-25 11:15:06.000000000 -0600
@@ -1014,7 +1014,6 @@
 
 int pnpacpi_encode_resources(struct pnp_dev *dev, struct acpi_buffer *buffer)
 {
-	struct pnp_resource_table *res_table = &dev->res;
 	int i = 0;
 	/* pnpacpi_build_resource_template allocates extra mem */
 	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
@@ -1026,45 +1025,43 @@
 		switch (resource->type) {
 		case ACPI_RESOURCE_TYPE_IRQ:
 			pnpacpi_encode_irq(dev, resource,
-					   &res_table->irq_resource[irq]);
+			       pnp_get_resource(dev, IORESOURCE_IRQ, irq));
 			irq++;
 			break;
 
 		case ACPI_RESOURCE_TYPE_DMA:
 			pnpacpi_encode_dma(dev, resource,
-					   &res_table->dma_resource[dma]);
+				pnp_get_resource(dev, IORESOURCE_DMA, dma));
 			dma++;
 			break;
 		case ACPI_RESOURCE_TYPE_IO:
 			pnpacpi_encode_io(dev, resource,
-					  &res_table->port_resource[port]);
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_IO:
 			pnpacpi_encode_fixed_io(dev, resource,
-						&res_table->
-						port_resource[port]);
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY24:
 			pnpacpi_encode_mem24(dev, resource,
-					     &res_table->mem_resource[mem]);
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY32:
 			pnpacpi_encode_mem32(dev, resource,
-					     &res_table->mem_resource[mem]);
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
 			pnpacpi_encode_fixed_mem32(dev, resource,
-						   &res_table->
-						   mem_resource[mem]);
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 			pnpacpi_encode_ext_irq(dev, resource,
-					       &res_table->irq_resource[irq]);
+				pnp_get_resource(dev, IORESOURCE_IRQ, irq));
 			irq++;
 			break;
 		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
Index: work10/drivers/pnp/pnpbios/rsparser.c
===================================================================
--- work10.orig/drivers/pnp/pnpbios/rsparser.c	2008-04-25 11:14:59.000000000 -0600
+++ work10/drivers/pnp/pnpbios/rsparser.c	2008-04-25 11:15:06.000000000 -0600
@@ -688,7 +688,6 @@
 							     unsigned char *p,
 							     unsigned char *end)
 {
-	struct pnp_resource_table *res = &dev->res;
 	unsigned int len, tag;
 	int port = 0, irq = 0, dma = 0, mem = 0;
 
@@ -711,42 +710,48 @@
 		case LARGE_TAG_MEM:
 			if (len != 9)
 				goto len_err;
-			pnpbios_encode_mem(dev, p, &res->mem_resource[mem]);
+			pnpbios_encode_mem(dev, p,
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 
 		case LARGE_TAG_MEM32:
 			if (len != 17)
 				goto len_err;
-			pnpbios_encode_mem32(dev, p, &res->mem_resource[mem]);
+			pnpbios_encode_mem32(dev, p,
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 
 		case LARGE_TAG_FIXEDMEM32:
 			if (len != 9)
 				goto len_err;
-			pnpbios_encode_fixed_mem32(dev, p, &res->mem_resource[mem]);
+			pnpbios_encode_fixed_mem32(dev, p,
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 
 		case SMALL_TAG_IRQ:
 			if (len < 2 || len > 3)
 				goto len_err;
-			pnpbios_encode_irq(dev, p, &res->irq_resource[irq]);
+			pnpbios_encode_irq(dev, p,
+				pnp_get_resource(dev, IORESOURCE_IRQ, irq));
 			irq++;
 			break;
 
 		case SMALL_TAG_DMA:
 			if (len != 2)
 				goto len_err;
-			pnpbios_encode_dma(dev, p, &res->dma_resource[dma]);
+			pnpbios_encode_dma(dev, p,
+				pnp_get_resource(dev, IORESOURCE_DMA, dma));
 			dma++;
 			break;
 
 		case SMALL_TAG_PORT:
 			if (len != 7)
 				goto len_err;
-			pnpbios_encode_port(dev, p, &res->port_resource[port]);
+			pnpbios_encode_port(dev, p,
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 
@@ -757,7 +762,8 @@
 		case SMALL_TAG_FIXEDPORT:
 			if (len != 3)
 				goto len_err;
-			pnpbios_encode_fixed_port(dev, p, &res->port_resource[port]);
+			pnpbios_encode_fixed_port(dev, p,
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 

-- 
