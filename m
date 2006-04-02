From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 06/26] PNPACPI: whitespace cleanup
Date: Sun, 2 Apr 2006 00:21:23 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DE3@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2988 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750855AbWDBFV1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:21:27 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

applied.
thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Tuesday, March 28, 2006 5:04 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; bjorn.helgaas@hp.com
>Subject: [patch 06/26] PNPACPI: whitespace cleanup
>
>
>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>Tidy up whitespace.  No functional change.
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/pnp/pnpacpi/rsparser.c |   97 +++++++++++++++----------------
> 1 files changed, 47 insertions(+), 50 deletions(-)
>
>diff -puN 
>drivers/pnp/pnpacpi/rsparser.c~pnpacpi-whitespace-cleanup 
>drivers/pnp/pnpacpi/rsparser.c
>--- 
>devel/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-whitespace-
>cleanup	2006-03-28 14:03:02.000000000 -0800
>+++ devel-akpm/drivers/pnp/pnpacpi/rsparser.c	2006-03-28 
>14:03:02.000000000 -0800
>@@ -36,13 +36,13 @@ static int irq_flags(int triggering, int
> {
> 	int flag;
> 	if (triggering == ACPI_LEVEL_SENSITIVE) {
>-		if(polarity == ACPI_ACTIVE_LOW)
>+		if (polarity == ACPI_ACTIVE_LOW)
> 			flag = IORESOURCE_IRQ_LOWLEVEL;
> 		else
> 			flag = IORESOURCE_IRQ_HIGHLEVEL;
> 	}
> 	else {
>-		if(polarity == ACPI_ACTIVE_LOW)
>+		if (polarity == ACPI_ACTIVE_LOW)
> 			flag = IORESOURCE_IRQ_LOWEDGE;
> 		else
> 			flag = IORESOURCE_IRQ_HIGHEDGE;
>@@ -57,7 +57,7 @@ static void decode_irq_flags(int flag, i
> 		*triggering = ACPI_LEVEL_SENSITIVE;
> 		*polarity = ACPI_ACTIVE_LOW;
> 		break;
>-	case IORESOURCE_IRQ_HIGHLEVEL:	
>+	case IORESOURCE_IRQ_HIGHLEVEL:
> 		*triggering = ACPI_LEVEL_SENSITIVE;
> 		*polarity = ACPI_ACTIVE_HIGH;
> 		break;
>@@ -73,7 +73,7 @@ static void decode_irq_flags(int flag, i
> }
> 
> static void
>-pnpacpi_parse_allocated_irqresource(struct pnp_resource_table 
>* res, u32 gsi,
>+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table 
>*res, u32 gsi,
> 	int triggering, int polarity)
> {
> 	int i = 0;
>@@ -101,7 +101,7 @@ pnpacpi_parse_allocated_irqresource(stru
> }
> 
> static void
>-pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table 
>* res, u32 dma)
>+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table 
>*res, u32 dma)
> {
> 	int i = 0;
> 	while (i < PNP_MAX_DMA &&
>@@ -119,7 +119,7 @@ pnpacpi_parse_allocated_dmaresource(stru
> }
> 
> static void
>-pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
>+pnpacpi_parse_allocated_ioresource(struct pnp_resource_table *res,
> 	u64 io, u64 len)
> {
> 	int i = 0;
>@@ -138,7 +138,7 @@ pnpacpi_parse_allocated_ioresource(struc
> }
> 
> static void
>-pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
>+pnpacpi_parse_allocated_memresource(struct pnp_resource_table *res,
> 	u64 mem, u64 len)
> {
> 	int i = 0;
>@@ -181,7 +181,7 @@ pnpacpi_parse_allocated_address_space(st
> static acpi_status pnpacpi_allocated_resource(struct 
>acpi_resource *res,
> 	void *data)
> {
>-	struct pnp_resource_table * res_table = (struct 
>pnp_resource_table *)data;
>+	struct pnp_resource_table *res_table = (struct 
>pnp_resource_table *)data;
> 	int i;
> 
> 	switch (res->type) {
>@@ -266,11 +266,11 @@ static acpi_status pnpacpi_allocated_res
> 		pnp_warn("PnPACPI: unknown resource type %d", 
>res->type);
> 		return AE_ERROR;
> 	}
>-			
>+
> 	return AE_OK;
> }
> 
>-acpi_status pnpacpi_parse_allocated_resource(acpi_handle 
>handle, struct pnp_resource_table * res)
>+acpi_status pnpacpi_parse_allocated_resource(acpi_handle 
>handle, struct pnp_resource_table *res)
> {
> 	/* Blank the resource table values */
> 	pnp_init_resource_table(res);
>@@ -328,17 +328,17 @@ static void pnpacpi_parse_dma_option(str
> 		pnp_err("Invalid DMA transfer type");
> 	}
> 
>-	pnp_register_dma_resource(option,dma);
>+	pnp_register_dma_resource(option, dma);
> 	return;
> }
> 
>-	
>+
> static void pnpacpi_parse_irq_option(struct pnp_option *option,
> 	struct acpi_resource_irq *p)
> {
> 	int i;
>-	struct pnp_irq * irq;
>-	
>+	struct pnp_irq *irq;
>+
> 	if (p->interrupt_count == 0)
> 		return;
> 	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
>@@ -358,7 +358,7 @@ static void pnpacpi_parse_ext_irq_option
> 	struct acpi_resource_extended_irq *p)
> {
> 	int i;
>-	struct pnp_irq * irq;
>+	struct pnp_irq *irq;
> 
> 	if (p->interrupt_count == 0)
> 		return;
>@@ -379,7 +379,7 @@ static void
> pnpacpi_parse_port_option(struct pnp_option *option,
> 	struct acpi_resource_io *io)
> {
>-	struct pnp_port * port;
>+	struct pnp_port *port;
> 
> 	if (io->address_length == 0)
> 		return;
>@@ -392,7 +392,7 @@ pnpacpi_parse_port_option(struct pnp_opt
> 	port->size = io->address_length;
> 	port->flags = ACPI_DECODE_16 == io->io_decode ?
> 		PNP_PORT_FLAG_16BITADDR : 0;
>-	pnp_register_port_resource(option,port);
>+	pnp_register_port_resource(option, port);
> 	return;
> }
> 
>@@ -400,7 +400,7 @@ static void
> pnpacpi_parse_fixed_port_option(struct pnp_option *option,
> 	struct acpi_resource_fixed_io *io)
> {
>-	struct pnp_port * port;
>+	struct pnp_port *port;
> 
> 	if (io->address_length == 0)
> 		return;
>@@ -411,7 +411,7 @@ pnpacpi_parse_fixed_port_option(struct p
> 	port->size = io->address_length;
> 	port->align = 0;
> 	port->flags = PNP_PORT_FLAG_FIXED;
>-	pnp_register_port_resource(option,port);
>+	pnp_register_port_resource(option, port);
> 	return;
> }
> 
>@@ -419,7 +419,7 @@ static void
> pnpacpi_parse_mem24_option(struct pnp_option *option,
> 	struct acpi_resource_memory24 *p)
> {
>-	struct pnp_mem * mem;
>+	struct pnp_mem *mem;
> 
> 	if (p->address_length == 0)
> 		return;
>@@ -434,7 +434,7 @@ pnpacpi_parse_mem24_option(struct pnp_op
> 	mem->flags = (ACPI_READ_WRITE_MEMORY == p->write_protect) ?
> 			IORESOURCE_MEM_WRITEABLE : 0;
> 
>-	pnp_register_mem_resource(option,mem);
>+	pnp_register_mem_resource(option, mem);
> 	return;
> }
> 
>@@ -442,7 +442,7 @@ static void
> pnpacpi_parse_mem32_option(struct pnp_option *option,
> 	struct acpi_resource_memory32 *p)
> {
>-	struct pnp_mem * mem;
>+	struct pnp_mem *mem;
> 
> 	if (p->address_length == 0)
> 		return;
>@@ -457,7 +457,7 @@ pnpacpi_parse_mem32_option(struct pnp_op
> 	mem->flags = (ACPI_READ_WRITE_MEMORY == p->write_protect) ?
> 			IORESOURCE_MEM_WRITEABLE : 0;
> 
>-	pnp_register_mem_resource(option,mem);
>+	pnp_register_mem_resource(option, mem);
> 	return;
> }
> 
>@@ -465,7 +465,7 @@ static void
> pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
> 	struct acpi_resource_fixed_memory32 *p)
> {
>-	struct pnp_mem * mem;
>+	struct pnp_mem *mem;
> 
> 	if (p->address_length == 0)
> 		return;
>@@ -479,7 +479,7 @@ pnpacpi_parse_fixed_mem32_option(struct 
> 	mem->flags = (ACPI_READ_WRITE_MEMORY == p->write_protect) ?
> 			IORESOURCE_MEM_WRITEABLE : 0;
> 
>-	pnp_register_mem_resource(option,mem);
>+	pnp_register_mem_resource(option, mem);
> 	return;
> }
> 
>@@ -488,8 +488,8 @@ pnpacpi_parse_address_option(struct pnp_
> {
> 	struct acpi_resource_address64 addr, *p = &addr;
> 	acpi_status status;
>-	struct pnp_mem * mem;
>-	struct pnp_port * port;
>+	struct pnp_mem *mem;
>+	struct pnp_port *port;
> 
> 	status = acpi_resource_to_address64(r, p);
> 	if (!ACPI_SUCCESS(status)) {
>@@ -509,7 +509,7 @@ pnpacpi_parse_address_option(struct pnp_
> 		mem->align = 0;
> 		mem->flags = (p->info.mem.write_protect ==
> 		    ACPI_READ_WRITE_MEMORY) ? 
>IORESOURCE_MEM_WRITEABLE : 0;
>-		pnp_register_mem_resource(option,mem);
>+		pnp_register_mem_resource(option, mem);
> 	} else if (p->resource_type == ACPI_IO_RANGE) {
> 		port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
> 		if (!port)
>@@ -518,7 +518,7 @@ pnpacpi_parse_address_option(struct pnp_
> 		port->size = p->address_length;
> 		port->align = 0;
> 		port->flags = PNP_PORT_FLAG_FIXED;
>-		pnp_register_port_resource(option,port);
>+		pnp_register_port_resource(option, port);
> 	}
> }
> 
>@@ -542,7 +542,7 @@ static acpi_status pnpacpi_option_resour
> 			break;
> 
> 		case ACPI_RESOURCE_TYPE_DMA:
>-			pnpacpi_parse_dma_option(option, 
>&res->data.dma);	
>+			pnpacpi_parse_dma_option(option, 
>&res->data.dma);
> 			break;
> 
> 		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
>@@ -550,7 +550,7 @@ static acpi_status pnpacpi_option_resour
> 				case ACPI_GOOD_CONFIGURATION:
> 					priority = 
>PNP_RES_PRIORITY_PREFERRED;
> 					break;
>-					
>+
> 				case ACPI_ACCEPTABLE_CONFIGURATION:
> 					priority = 
>PNP_RES_PRIORITY_ACCEPTABLE;
> 					break;
>@@ -566,7 +566,7 @@ static acpi_status pnpacpi_option_resour
> 			option = 
>pnp_register_dependent_option(dev, priority);
> 			if (!option)
> 				return AE_ERROR;
>-			parse_data->option = option;	
>+			parse_data->option = option;
> 			break;
> 
> 		case ACPI_RESOURCE_TYPE_END_DEPENDENT:
>@@ -626,7 +626,7 @@ static acpi_status pnpacpi_option_resour
> 			pnp_warn("PnPACPI: unknown resource 
>type %d", res->type);
> 			return AE_ERROR;
> 	}
>-			
>+
> 	return AE_OK;
> }
> 
>@@ -679,10 +679,9 @@ static acpi_status pnpacpi_count_resourc
> 	return AE_OK;
> }
> 
>-static acpi_status pnpacpi_type_resources(struct acpi_resource *res,
>-	void *data)
>+static acpi_status pnpacpi_type_resources(struct 
>acpi_resource *res, void *data)
> {
>-	struct acpi_resource **resource = (struct acpi_resource 
>**)data;	
>+	struct acpi_resource **resource = (struct acpi_resource **)data;
> 
> 	if (pnpacpi_supported_resource(res)) {
> 		(*resource)->type = res->type;
>@@ -731,9 +730,8 @@ static void pnpacpi_encode_irq(struct ac
> 	struct resource *p)
> {
> 	int triggering, polarity;
>-	
>-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering,
>-		&polarity);
>+
>+	decode_irq_flags(p->flags & IORESOURCE_BITS, 
>&triggering, &polarity);
> 	resource->data.irq.triggering = triggering;
> 	resource->data.irq.polarity = polarity;
> 	if (triggering == ACPI_EDGE_SENSITIVE)
>@@ -748,9 +746,8 @@ static void pnpacpi_encode_ext_irq(struc
> 	struct resource *p)
> {
> 	int triggering, polarity;
>-	
>-	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering,
>-		&polarity);
>+
>+	decode_irq_flags(p->flags & IORESOURCE_BITS, 
>&triggering, &polarity);
> 	resource->data.extended_irq.producer_consumer = ACPI_CONSUMER;
> 	resource->data.extended_irq.triggering = triggering;
> 	resource->data.extended_irq.polarity = polarity;
>@@ -862,37 +859,37 @@ int pnpacpi_encode_resources(struct pnp_
> 			pnp_dbg("Encode dma");
> 			pnpacpi_encode_dma(resource,
> 				&res_table->dma_resource[dma]);
>-			dma ++;
>+			dma++;
> 			break;
> 		case ACPI_RESOURCE_TYPE_IO:
> 			pnp_dbg("Encode io");
> 			pnpacpi_encode_io(resource,
> 				&res_table->port_resource[port]);
>-			port ++;
>+			port++;
> 			break;
> 		case ACPI_RESOURCE_TYPE_FIXED_IO:
> 			pnp_dbg("Encode fixed io");
> 			pnpacpi_encode_fixed_io(resource,
> 				&res_table->port_resource[port]);
>-			port ++;
>+			port++;
> 			break;
> 		case ACPI_RESOURCE_TYPE_MEMORY24:
> 			pnp_dbg("Encode mem24");
> 			pnpacpi_encode_mem24(resource,
> 				&res_table->mem_resource[mem]);
>-			mem ++;
>+			mem++;
> 			break;
> 		case ACPI_RESOURCE_TYPE_MEMORY32:
> 			pnp_dbg("Encode mem32");
> 			pnpacpi_encode_mem32(resource,
> 				&res_table->mem_resource[mem]);
>-			mem ++;
>+			mem++;
> 			break;
> 		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> 			pnp_dbg("Encode fixed mem32");
> 			pnpacpi_encode_fixed_mem32(resource,
> 				&res_table->mem_resource[mem]);
>-			mem ++;
>+			mem++;
> 			break;
> 		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> 			pnp_dbg("Encode ext irq");
>@@ -913,8 +910,8 @@ int pnpacpi_encode_resources(struct pnp_
> 			pnp_warn("unknown resource type %d", 
>resource->type);
> 			return -EINVAL;
> 		}
>-		resource ++;
>-		i ++;
>+		resource++;
>+		i++;
> 	}
> 	return 0;
> }
>_
>
