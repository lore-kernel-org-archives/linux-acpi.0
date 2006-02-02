From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] PNPACPI: whitespace cleanup
Date: Thu, 2 Feb 2006 14:57:55 -0700
Message-ID: <200602021457.55676.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:32997 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932327AbWBBV56 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2006 16:57:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Tidy up whitespace.  No functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-mm4.orig/drivers/pnp/pnpacpi/rsparser.c	2006-02-02 14:22:10.000000000 -0700
+++ work-mm4/drivers/pnp/pnpacpi/rsparser.c	2006-02-02 14:29:55.000000000 -0700
@@ -36,13 +36,13 @@
 {
 	int flag;
 	if (triggering == ACPI_LEVEL_SENSITIVE) {
-		if(polarity == ACPI_ACTIVE_LOW)
+		if (polarity == ACPI_ACTIVE_LOW)
 			flag = IORESOURCE_IRQ_LOWLEVEL;
 		else
 			flag = IORESOURCE_IRQ_HIGHLEVEL;
 	}
 	else {
-		if(polarity == ACPI_ACTIVE_LOW)
+		if (polarity == ACPI_ACTIVE_LOW)
 			flag = IORESOURCE_IRQ_LOWEDGE;
 		else
 			flag = IORESOURCE_IRQ_HIGHEDGE;
@@ -57,7 +57,7 @@
 		*triggering = ACPI_LEVEL_SENSITIVE;
 		*polarity = ACPI_ACTIVE_LOW;
 		break;
-	case IORESOURCE_IRQ_HIGHLEVEL:	
+	case IORESOURCE_IRQ_HIGHLEVEL:
 		*triggering = ACPI_LEVEL_SENSITIVE;
 		*polarity = ACPI_ACTIVE_HIGH;
 		break;
@@ -73,7 +73,7 @@
 }
 
 static void
-pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 gsi,
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table *res, u32 gsi,
 	int triggering, int polarity)
 {
 	int i = 0;
@@ -101,7 +101,7 @@
 }
 
 static void
-pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, u32 dma)
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res, u32 dma)
 {
 	int i = 0;
 	while (i < PNP_MAX_DMA &&
@@ -119,7 +119,7 @@
 }
 
 static void
-pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
+pnpacpi_parse_allocated_ioresource(struct pnp_resource_table *res,
 	u64 io, u64 len)
 {
 	int i = 0;
@@ -138,7 +138,7 @@
 }
 
 static void
-pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
+pnpacpi_parse_allocated_memresource(struct pnp_resource_table *res,
 	u64 mem, u64 len)
 {
 	int i = 0;
@@ -157,7 +157,7 @@
 }
 
 static void
-pnpacpi_parse_allocated_address_space(struct pnp_resource_table * res_table,
+pnpacpi_parse_allocated_address_space(struct pnp_resource_table *res_table,
 	struct acpi_resource *res)
 {
 	struct acpi_resource_address64 addr, *p = &addr;
@@ -181,7 +181,7 @@
 static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	void *data)
 {
-	struct pnp_resource_table * res_table = (struct pnp_resource_table *)data;
+	struct pnp_resource_table *res_table = (struct pnp_resource_table *)data;
 	int i;
 
 	switch (res->type) {
@@ -266,11 +266,11 @@
 		pnp_warn("PnPACPI: unknown resource type %d", res->type);
 		return AE_ERROR;
 	}
-			
+
 	return AE_OK;
 }
 
-acpi_status pnpacpi_parse_allocated_resource(acpi_handle handle, struct pnp_resource_table * res)
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle handle, struct pnp_resource_table *res)
 {
 	/* Blank the resource table values */
 	pnp_init_resource_table(res);
@@ -328,17 +328,17 @@
 		pnp_err("Invalid DMA transfer type");
 	}
 
-	pnp_register_dma_resource(option,dma);
+	pnp_register_dma_resource(option, dma);
 	return;
 }
 
-	
+
 static void pnpacpi_parse_irq_option(struct pnp_option *option,
 	struct acpi_resource_irq *p)
 {
 	int i;
-	struct pnp_irq * irq;
-	
+	struct pnp_irq *irq;
+
 	if (p->interrupt_count == 0)
 		return;
 	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
@@ -358,7 +358,7 @@
 	struct acpi_resource_extended_irq *p)
 {
 	int i;
-	struct pnp_irq * irq;
+	struct pnp_irq *irq;
 
 	if (p->interrupt_count == 0)
 		return;
@@ -379,7 +379,7 @@
 pnpacpi_parse_port_option(struct pnp_option *option,
 	struct acpi_resource_io *io)
 {
-	struct pnp_port * port;
+	struct pnp_port *port;
 
 	if (io->address_length == 0)
 		return;
@@ -392,7 +392,7 @@
 	port->size = io->address_length;
 	port->flags = ACPI_DECODE_16 == io->io_decode ?
 		PNP_PORT_FLAG_16BITADDR : 0;
-	pnp_register_port_resource(option,port);
+	pnp_register_port_resource(option, port);
 	return;
 }
 
@@ -400,7 +400,7 @@
 pnpacpi_parse_fixed_port_option(struct pnp_option *option,
 	struct acpi_resource_fixed_io *io)
 {
-	struct pnp_port * port;
+	struct pnp_port *port;
 
 	if (io->address_length == 0)
 		return;
@@ -411,7 +411,7 @@
 	port->size = io->address_length;
 	port->align = 0;
 	port->flags = PNP_PORT_FLAG_FIXED;
-	pnp_register_port_resource(option,port);
+	pnp_register_port_resource(option, port);
 	return;
 }
 
@@ -419,7 +419,7 @@
 pnpacpi_parse_mem24_option(struct pnp_option *option,
 	struct acpi_resource_memory24 *p)
 {
-	struct pnp_mem * mem;
+	struct pnp_mem *mem;
 
 	if (p->address_length == 0)
 		return;
@@ -434,7 +434,7 @@
 	mem->flags = (ACPI_READ_WRITE_MEMORY == p->write_protect) ?
 			IORESOURCE_MEM_WRITEABLE : 0;
 
-	pnp_register_mem_resource(option,mem);
+	pnp_register_mem_resource(option, mem);
 	return;
 }
 
@@ -442,7 +442,7 @@
 pnpacpi_parse_mem32_option(struct pnp_option *option,
 	struct acpi_resource_memory32 *p)
 {
-	struct pnp_mem * mem;
+	struct pnp_mem *mem;
 
 	if (p->address_length == 0)
 		return;
@@ -457,7 +457,7 @@
 	mem->flags = (ACPI_READ_WRITE_MEMORY == p->write_protect) ?
 			IORESOURCE_MEM_WRITEABLE : 0;
 
-	pnp_register_mem_resource(option,mem);
+	pnp_register_mem_resource(option, mem);
 	return;
 }
 
@@ -465,7 +465,7 @@
 pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
 	struct acpi_resource_fixed_memory32 *p)
 {
-	struct pnp_mem * mem;
+	struct pnp_mem *mem;
 
 	if (p->address_length == 0)
 		return;
@@ -479,7 +479,7 @@
 	mem->flags = (ACPI_READ_WRITE_MEMORY == p->write_protect) ?
 			IORESOURCE_MEM_WRITEABLE : 0;
 
-	pnp_register_mem_resource(option,mem);
+	pnp_register_mem_resource(option, mem);
 	return;
 }
 
@@ -488,8 +488,8 @@
 {
 	struct acpi_resource_address64 addr, *p = &addr;
 	acpi_status status;
-	struct pnp_mem * mem;
-	struct pnp_port * port;
+	struct pnp_mem *mem;
+	struct pnp_port *port;
 
 	status = acpi_resource_to_address64(r, p);
 	if (!ACPI_SUCCESS(status)) {
@@ -509,7 +509,7 @@
 		mem->align = 0;
 		mem->flags = (p->info.mem.write_protect ==
 		    ACPI_READ_WRITE_MEMORY) ? IORESOURCE_MEM_WRITEABLE : 0;
-		pnp_register_mem_resource(option,mem);
+		pnp_register_mem_resource(option, mem);
 	} else if (p->resource_type == ACPI_IO_RANGE) {
 		port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
 		if (!port)
@@ -518,7 +518,7 @@
 		port->size = p->address_length;
 		port->align = 0;
 		port->flags = PNP_PORT_FLAG_FIXED;
-		pnp_register_port_resource(option,port);
+		pnp_register_port_resource(option, port);
 	}
 }
 
@@ -542,7 +542,7 @@
 			break;
 
 		case ACPI_RESOURCE_TYPE_DMA:
-			pnpacpi_parse_dma_option(option, &res->data.dma);	
+			pnpacpi_parse_dma_option(option, &res->data.dma);
 			break;
 
 		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
@@ -550,7 +550,7 @@
 				case ACPI_GOOD_CONFIGURATION:
 					priority = PNP_RES_PRIORITY_PREFERRED;
 					break;
-					
+
 				case ACPI_ACCEPTABLE_CONFIGURATION:
 					priority = PNP_RES_PRIORITY_ACCEPTABLE;
 					break;
@@ -566,7 +566,7 @@
 			option = pnp_register_dependent_option(dev, priority);
 			if (!option)
 				return AE_ERROR;
-			parse_data->option = option;	
+			parse_data->option = option;
 			break;
 
 		case ACPI_RESOURCE_TYPE_END_DEPENDENT:
@@ -626,7 +626,7 @@
 			pnp_warn("PnPACPI: unknown resource type %d", res->type);
 			return AE_ERROR;
 	}
-			
+
 	return AE_OK;
 }
 
@@ -679,10 +679,9 @@
 	return AE_OK;
 }
 
-static acpi_status pnpacpi_type_resources(struct acpi_resource *res,
-	void *data)
+static acpi_status pnpacpi_type_resources(struct acpi_resource *res, void *data)
 {
-	struct acpi_resource **resource = (struct acpi_resource **)data;	
+	struct acpi_resource **resource = (struct acpi_resource **)data;
 
 	if (pnpacpi_supported_resource(res)) {
 		(*resource)->type = res->type;
@@ -731,9 +730,8 @@
 	struct resource *p)
 {
 	int triggering, polarity;
-	
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering,
-		&polarity);
+
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering, &polarity);
 	resource->data.irq.triggering = triggering;
 	resource->data.irq.polarity = polarity;
 	if (triggering == ACPI_EDGE_SENSITIVE)
@@ -748,9 +746,8 @@
 	struct resource *p)
 {
 	int triggering, polarity;
-	
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering,
-		&polarity);
+
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering, &polarity);
 	resource->data.extended_irq.producer_consumer = ACPI_CONSUMER;
 	resource->data.extended_irq.triggering = triggering;
 	resource->data.extended_irq.polarity = polarity;
@@ -862,37 +859,37 @@
 			pnp_dbg("Encode dma");
 			pnpacpi_encode_dma(resource,
 				&res_table->dma_resource[dma]);
-			dma ++;
+			dma++;
 			break;
 		case ACPI_RESOURCE_TYPE_IO:
 			pnp_dbg("Encode io");
 			pnpacpi_encode_io(resource,
 				&res_table->port_resource[port]);
-			port ++;
+			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_IO:
 			pnp_dbg("Encode fixed io");
 			pnpacpi_encode_fixed_io(resource,
 				&res_table->port_resource[port]);
-			port ++;
+			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY24:
 			pnp_dbg("Encode mem24");
 			pnpacpi_encode_mem24(resource,
 				&res_table->mem_resource[mem]);
-			mem ++;
+			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY32:
 			pnp_dbg("Encode mem32");
 			pnpacpi_encode_mem32(resource,
 				&res_table->mem_resource[mem]);
-			mem ++;
+			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
 			pnp_dbg("Encode fixed mem32");
 			pnpacpi_encode_fixed_mem32(resource,
 				&res_table->mem_resource[mem]);
-			mem ++;
+			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 			pnp_dbg("Encode ext irq");
@@ -913,8 +910,8 @@
 			pnp_warn("unknown resource type %d", resource->type);
 			return -EINVAL;
 		}
-		resource ++;
-		i ++;
+		resource++;
+		i++;
 	}
 	return 0;
 }
