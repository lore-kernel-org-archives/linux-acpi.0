From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 31/53] PNP: convert encoders to use pnp_get_resource(), not pnp_resource_table
Date: Fri, 18 Apr 2008 14:50:26 -0600
Message-ID: <20080418205053.529822865@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:26271 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761126AbYDRUwS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Apr 2008 16:52:18 -0400
Content-Disposition: inline; filename=pnp-convert-encoders-to-pnp_get_resource
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This removes more direct references to pnp_resource_table.  This
path is used when telling a device what resources it should use.

This doesn't convert ISAPNP because ISA needs to know the config
register index in addition to the resource itself.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work8.orig/drivers/pnp/pnpacpi/rsparser.c	2008-04-17 14:51:52.000000000 -0600
+++ work8/drivers/pnp/pnpacpi/rsparser.c	2008-04-17 14:54:45.000000000 -0600
@@ -954,7 +954,6 @@
 
 int pnpacpi_encode_resources(struct pnp_dev *dev, struct acpi_buffer *buffer)
 {
-	struct pnp_resource_table *res_table = &dev->res;
 	int i = 0;
 	/* pnpacpi_build_resource_template allocates extra mem */
 	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
@@ -967,52 +966,50 @@
 		case ACPI_RESOURCE_TYPE_IRQ:
 			pnp_dbg("Encode irq");
 			pnpacpi_encode_irq(resource,
-					   &res_table->irq_resource[irq]);
+				pnp_get_resource(dev, IORESOURCE_IRQ, irq));
 			irq++;
 			break;
 
 		case ACPI_RESOURCE_TYPE_DMA:
 			pnp_dbg("Encode dma");
 			pnpacpi_encode_dma(resource,
-					   &res_table->dma_resource[dma]);
+				pnp_get_resource(dev, IORESOURCE_DMA, dma));
 			dma++;
 			break;
 		case ACPI_RESOURCE_TYPE_IO:
 			pnp_dbg("Encode io");
 			pnpacpi_encode_io(resource,
-					  &res_table->port_resource[port]);
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_IO:
 			pnp_dbg("Encode fixed io");
 			pnpacpi_encode_fixed_io(resource,
-						&res_table->
-						port_resource[port]);
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY24:
 			pnp_dbg("Encode mem24");
 			pnpacpi_encode_mem24(resource,
-					     &res_table->mem_resource[mem]);
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY32:
 			pnp_dbg("Encode mem32");
 			pnpacpi_encode_mem32(resource,
-					     &res_table->mem_resource[mem]);
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
 			pnp_dbg("Encode fixed mem32");
 			pnpacpi_encode_fixed_mem32(resource,
-						   &res_table->
-						   mem_resource[mem]);
+				pnp_get_resource(dev, IORESOURCE_MEM, mem));
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 			pnp_dbg("Encode ext irq");
 			pnpacpi_encode_ext_irq(resource,
-					       &res_table->irq_resource[irq]);
+				pnp_get_resource(dev, IORESOURCE_IRQ, irq));
 			irq++;
 			break;
 		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
Index: work8/drivers/pnp/pnpbios/rsparser.c
===================================================================
--- work8.orig/drivers/pnp/pnpbios/rsparser.c	2008-04-17 14:51:52.000000000 -0600
+++ work8/drivers/pnp/pnpbios/rsparser.c	2008-04-17 14:53:00.000000000 -0600
@@ -650,7 +650,6 @@
 							     unsigned char *p,
 							     unsigned char *end)
 {
-	struct pnp_resource_table *res = &dev->res;
 	unsigned int len, tag;
 	int port = 0, irq = 0, dma = 0, mem = 0;
 
@@ -673,42 +672,48 @@
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
 
@@ -719,7 +724,8 @@
 		case SMALL_TAG_FIXEDPORT:
 			if (len != 3)
 				goto len_err;
-			pnpbios_encode_fixed_port(p, &res->port_resource[port]);
+			pnpbios_encode_fixed_port(p,
+				pnp_get_resource(dev, IORESOURCE_IO, port));
 			port++;
 			break;
 

-- 
