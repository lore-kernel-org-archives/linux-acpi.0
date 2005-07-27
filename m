From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] PNPACPI: cleanup whitespace & coding style
Date: Wed, 27 Jul 2005 16:43:31 -0600
Message-ID: <200507271643.31654.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Make whitespace/coding style consistent.  No functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work.orig/drivers/pnp/pnpacpi/rsparser.c	2005-07-27 10:22:02.000000000 -0600
+++ work/drivers/pnp/pnpacpi/rsparser.c	2005-07-27 10:42:59.000000000 -0600
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2004 Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
  * Copyright (c) 2004 Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
- * 
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2, or (at your option) any
@@ -35,14 +35,15 @@
 static int irq_flags(int edge_level, int active_high_low)
 {
 	int flag;
+
 	if (edge_level == ACPI_LEVEL_SENSITIVE) {
-		if(active_high_low == ACPI_ACTIVE_LOW)
+		if (active_high_low == ACPI_ACTIVE_LOW)
 			flag = IORESOURCE_IRQ_LOWLEVEL;
 		else
 			flag = IORESOURCE_IRQ_HIGHLEVEL;
 	}
 	else {
-		if(active_high_low == ACPI_ACTIVE_LOW)
+		if (active_high_low == ACPI_ACTIVE_LOW)
 			flag = IORESOURCE_IRQ_LOWEDGE;
 		else
 			flag = IORESOURCE_IRQ_HIGHEDGE;
@@ -57,7 +58,7 @@
 		*edge_level = ACPI_LEVEL_SENSITIVE;
 		*active_high_low = ACPI_ACTIVE_LOW;
 		break;
-	case IORESOURCE_IRQ_HIGHLEVEL:	
+	case IORESOURCE_IRQ_HIGHLEVEL:
 		*edge_level = ACPI_LEVEL_SENSITIVE;
 		*active_high_low = ACPI_ACTIVE_HIGH;
 		break;
@@ -72,10 +73,11 @@
 	}
 }
 
-static void
-pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 irq)
+static void pnpacpi_parse_allocated_irqresource(struct pnp_resource_table *res,
+	u32 irq)
 {
 	int i = 0;
+
 	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
 			i < PNP_MAX_IRQ)
 		i++;
@@ -90,10 +92,11 @@
 	}
 }
 
-static void
-pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, u32 dma)
+static void pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res,
+	u32 dma)
 {
 	int i = 0;
+
 	while (i < PNP_MAX_DMA &&
 			!(res->dma_resource[i].flags & IORESOURCE_UNSET))
 		i++;
@@ -108,11 +111,11 @@
 	}
 }
 
-static void
-pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
+static void pnpacpi_parse_allocated_ioresource(struct pnp_resource_table *res,
 	u32 io, u32 len)
 {
 	int i = 0;
+
 	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
 			i < PNP_MAX_PORT)
 		i++;
@@ -127,11 +130,11 @@
 	}
 }
 
-static void
-pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
+static void pnpacpi_parse_allocated_memresource(struct pnp_resource_table *res,
 	u64 mem, u64 len)
 {
 	int i = 0;
+
 	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
 			(i < PNP_MAX_MEM))
 		i++;
@@ -150,13 +153,13 @@
 static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	void *data)
 {
-	struct pnp_resource_table * res_table = (struct pnp_resource_table *)data;
+	struct pnp_resource_table *res_table = (struct pnp_resource_table *)data;
 
 	switch (res->id) {
 	case ACPI_RSTYPE_IRQ:
 		if ((res->data.irq.number_of_interrupts > 0) &&
 			valid_IRQ(res->data.irq.interrupts[0])) {
-			pnpacpi_parse_allocated_irqresource(res_table, 
+			pnpacpi_parse_allocated_irqresource(res_table,
 				acpi_register_gsi(res->data.irq.interrupts[0],
 					res->data.irq.edge_level,
 					res->data.irq.active_high_low));
@@ -167,7 +170,7 @@
 	case ACPI_RSTYPE_EXT_IRQ:
 		if ((res->data.extended_irq.number_of_interrupts > 0) &&
 			valid_IRQ(res->data.extended_irq.interrupts[0])) {
-			pnpacpi_parse_allocated_irqresource(res_table, 
+			pnpacpi_parse_allocated_irqresource(res_table,
 				acpi_register_gsi(res->data.extended_irq.interrupts[0],
 					res->data.extended_irq.edge_level,
 					res->data.extended_irq.active_high_low));
@@ -176,47 +179,47 @@
 		break;
 	case ACPI_RSTYPE_DMA:
 		if (res->data.dma.number_of_channels > 0)
-			pnpacpi_parse_allocated_dmaresource(res_table, 
+			pnpacpi_parse_allocated_dmaresource(res_table,
 					res->data.dma.channels[0]);
 		break;
 	case ACPI_RSTYPE_IO:
-		pnpacpi_parse_allocated_ioresource(res_table, 
-				res->data.io.min_base_address, 
+		pnpacpi_parse_allocated_ioresource(res_table,
+				res->data.io.min_base_address,
 				res->data.io.range_length);
 		break;
 	case ACPI_RSTYPE_FIXED_IO:
-		pnpacpi_parse_allocated_ioresource(res_table, 
-				res->data.fixed_io.base_address, 
+		pnpacpi_parse_allocated_ioresource(res_table,
+				res->data.fixed_io.base_address,
 				res->data.fixed_io.range_length);
 		break;
 	case ACPI_RSTYPE_MEM24:
-		pnpacpi_parse_allocated_memresource(res_table, 
-				res->data.memory24.min_base_address, 
+		pnpacpi_parse_allocated_memresource(res_table,
+				res->data.memory24.min_base_address,
 				res->data.memory24.range_length);
 		break;
 	case ACPI_RSTYPE_MEM32:
-		pnpacpi_parse_allocated_memresource(res_table, 
-				res->data.memory32.min_base_address, 
+		pnpacpi_parse_allocated_memresource(res_table,
+				res->data.memory32.min_base_address,
 				res->data.memory32.range_length);
 		break;
 	case ACPI_RSTYPE_FIXED_MEM32:
-		pnpacpi_parse_allocated_memresource(res_table, 
-				res->data.fixed_memory32.range_base_address, 
+		pnpacpi_parse_allocated_memresource(res_table,
+				res->data.fixed_memory32.range_base_address,
 				res->data.fixed_memory32.range_length);
 		break;
 	case ACPI_RSTYPE_ADDRESS16:
-		pnpacpi_parse_allocated_memresource(res_table, 
-				res->data.address16.min_address_range, 
+		pnpacpi_parse_allocated_memresource(res_table,
+				res->data.address16.min_address_range,
 				res->data.address16.address_length);
 		break;
 	case ACPI_RSTYPE_ADDRESS32:
-		pnpacpi_parse_allocated_memresource(res_table, 
-				res->data.address32.min_address_range, 
+		pnpacpi_parse_allocated_memresource(res_table,
+				res->data.address32.min_address_range,
 				res->data.address32.address_length);
 		break;
 	case ACPI_RSTYPE_ADDRESS64:
-		pnpacpi_parse_allocated_memresource(res_table, 
-		res->data.address64.min_address_range, 
+		pnpacpi_parse_allocated_memresource(res_table,
+		res->data.address64.min_address_range,
 		res->data.address64.address_length);
 		break;
 	case ACPI_RSTYPE_VENDOR:
@@ -225,11 +228,11 @@
 		pnp_warn("PnPACPI: unknown resource type %d", res->id);
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
@@ -240,7 +243,7 @@
 static void pnpacpi_parse_dma_option(struct pnp_option *option, struct acpi_resource_dma *p)
 {
 	int i;
-	struct pnp_dma * dma;
+	struct pnp_dma *dma;
 
 	if (p->number_of_channels == 0)
 		return;
@@ -248,7 +251,7 @@
 	if (!dma)
 		return;
 
-	for(i = 0; i < p->number_of_channels; i++)
+	for (i = 0; i < p->number_of_channels; i++)
 		dma->map |= 1 << p->channels[i];
 	dma->flags = 0;
 	if (p->bus_master)
@@ -291,20 +294,19 @@
 	return;
 }
 
-	
 static void pnpacpi_parse_irq_option(struct pnp_option *option,
 	struct acpi_resource_irq *p)
 {
 	int i;
-	struct pnp_irq * irq;
-	
+	struct pnp_irq *irq;
+
 	if (p->number_of_interrupts == 0)
 		return;
 	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 
-	for(i = 0; i < p->number_of_interrupts; i++)
+	for (i = 0; i < p->number_of_interrupts; i++)
 		if (p->interrupts[i])
 			__set_bit(p->interrupts[i], irq->map);
 	irq->flags = irq_flags(p->edge_level, p->active_high_low);
@@ -317,7 +319,7 @@
 	struct acpi_resource_ext_irq *p)
 {
 	int i;
-	struct pnp_irq * irq;
+	struct pnp_irq *irq;
 
 	if (p->number_of_interrupts == 0)
 		return;
@@ -325,7 +327,7 @@
 	if (!irq)
 		return;
 
-	for(i = 0; i < p->number_of_interrupts; i++)
+	for (i = 0; i < p->number_of_interrupts; i++)
 		if (p->interrupts[i])
 			__set_bit(p->interrupts[i], irq->map);
 	irq->flags = irq_flags(p->edge_level, p->active_high_low);
@@ -334,11 +336,10 @@
 	return;
 }
 
-static void
-pnpacpi_parse_port_option(struct pnp_option *option,
+static void pnpacpi_parse_port_option(struct pnp_option *option,
 	struct acpi_resource_io *io)
 {
-	struct pnp_port * port;
+	struct pnp_port *port;
 
 	if (io->range_length == 0)
 		return;
@@ -349,17 +350,16 @@
 	port->max = io->max_base_address;
 	port->align = io->alignment;
 	port->size = io->range_length;
-	port->flags = ACPI_DECODE_16 == io->io_decode ? 
+	port->flags = ACPI_DECODE_16 == io->io_decode ?
 		PNP_PORT_FLAG_16BITADDR : 0;
 	pnp_register_port_resource(option,port);
 	return;
 }
 
-static void
-pnpacpi_parse_fixed_port_option(struct pnp_option *option,
+static void pnpacpi_parse_fixed_port_option(struct pnp_option *option,
 	struct acpi_resource_fixed_io *io)
 {
-	struct pnp_port * port;
+	struct pnp_port *port;
 
 	if (io->range_length == 0)
 		return;
@@ -374,11 +374,10 @@
 	return;
 }
 
-static void
-pnpacpi_parse_mem24_option(struct pnp_option *option,
+static void pnpacpi_parse_mem24_option(struct pnp_option *option,
 	struct acpi_resource_mem24 *p)
 {
-	struct pnp_mem * mem;
+	struct pnp_mem *mem;
 
 	if (p->range_length == 0)
 		return;
@@ -397,11 +396,10 @@
 	return;
 }
 
-static void
-pnpacpi_parse_mem32_option(struct pnp_option *option,
+static void pnpacpi_parse_mem32_option(struct pnp_option *option,
 	struct acpi_resource_mem32 *p)
 {
-	struct pnp_mem * mem;
+	struct pnp_mem *mem;
 
 	if (p->range_length == 0)
 		return;
@@ -420,11 +418,10 @@
 	return;
 }
 
-static void
-pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
+static void pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
 	struct acpi_resource_fixed_mem32 *p)
 {
-	struct pnp_mem * mem;
+	struct pnp_mem *mem;
 
 	if (p->range_length == 0)
 		return;
@@ -448,7 +445,7 @@
 	struct pnp_dev *dev;
 };
 
-static acpi_status pnpacpi_option_resource(struct acpi_resource *res, 
+static acpi_status pnpacpi_option_resource(struct acpi_resource *res,
 	void *data)
 {
 	int priority = 0;
@@ -465,7 +462,7 @@
 				&res->data.extended_irq);
 			break;
 		case ACPI_RSTYPE_DMA:
-			pnpacpi_parse_dma_option(option, &res->data.dma);	
+			pnpacpi_parse_dma_option(option, &res->data.dma);
 			break;
 		case ACPI_RSTYPE_IO:
 			pnpacpi_parse_port_option(option, &res->data.io);
@@ -489,7 +486,7 @@
 				case ACPI_GOOD_CONFIGURATION:
 					priority = PNP_RES_PRIORITY_PREFERRED;
 					break;
-					
+
 				case ACPI_ACCEPTABLE_CONFIGURATION:
 					priority = PNP_RES_PRIORITY_ACCEPTABLE;
 					break;
@@ -501,14 +498,14 @@
 					priority = PNP_RES_PRIORITY_INVALID;
 					break;
 			}
-			/* TBD: Considering performace/robustness bits */
+			/* TBD: Considering performance/robustness bits */
 			option = pnp_register_dependent_option(dev, priority);
 			if (!option)
 				return AE_ERROR;
-			parse_data->option = option;	
+			parse_data->option = option;
 			break;
 		case ACPI_RSTYPE_END_DPF:
-			/*only one EndDependentFn is allowed*/
+			/* only one EndDependentFn is allowed */
 			if (!parse_data->option_independent) {
 				pnp_warn("PnPACPI: more than one EndDependentFn");
 				return AE_ERROR;
@@ -520,11 +517,11 @@
 			pnp_warn("PnPACPI: unknown resource type %d", res->id);
 			return AE_ERROR;
 	}
-			
+
 	return AE_OK;
 }
 
-acpi_status pnpacpi_parse_resource_option_data(acpi_handle handle, 
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle handle,
 	struct pnp_dev *dev)
 {
 	acpi_status status;
@@ -535,7 +532,7 @@
 		return AE_ERROR;
 	parse_data.option_independent = parse_data.option;
 	parse_data.dev = dev;
-	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
+	status = acpi_walk_resources(handle, METHOD_NAME__PRS,
 		pnpacpi_option_resource, &parse_data);
 
 	return status;
@@ -562,7 +559,7 @@
 	case ACPI_RSTYPE_ADDRESS32:
 	case ACPI_RSTYPE_ADDRESS64:
 #endif
-		(*res_cnt) ++;
+		(*res_cnt)++;
 	default:
 		return AE_OK;
 	}
@@ -572,7 +569,7 @@
 static acpi_status pnpacpi_type_resources(struct acpi_resource *res,
 	void *data)
 {
-	struct acpi_resource **resource = (struct acpi_resource **)data;	
+	struct acpi_resource **resource = (struct acpi_resource **)data;
 	switch (res->id) {
 	case ACPI_RSTYPE_IRQ:
 	case ACPI_RSTYPE_EXT_IRQ:
@@ -596,14 +593,14 @@
 	return AE_OK;
 }
 
-int pnpacpi_build_resource_template(acpi_handle handle, 
+int pnpacpi_build_resource_template(acpi_handle handle,
 	struct acpi_buffer *buffer)
 {
 	struct acpi_resource *resource;
 	int res_cnt = 0;
 	acpi_status status;
 
-	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
 		pnpacpi_count_resources, &res_cnt);
 	if (ACPI_FAILURE(status)) {
 		pnp_err("Evaluate _CRS failed");
@@ -617,7 +614,7 @@
 		return -ENOMEM;
 	pnp_dbg("Res cnt %d", res_cnt);
 	resource = (struct acpi_resource *)buffer->pointer;
-	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
 		pnpacpi_type_resources, &resource);
 	if (ACPI_FAILURE(status)) {
 		kfree(buffer->pointer);
@@ -630,12 +627,12 @@
 	return 0;
 }
 
-static void pnpacpi_encode_irq(struct acpi_resource *resource, 
+static void pnpacpi_encode_irq(struct acpi_resource *resource,
 	struct resource *p)
 {
 	int edge_level, active_high_low;
-	
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level,
 		&active_high_low);
 	resource->id = ACPI_RSTYPE_IRQ;
 	resource->length = sizeof(struct acpi_resource);
@@ -653,8 +650,8 @@
 	struct resource *p)
 {
 	int edge_level, active_high_low;
-	
-	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level,
 		&active_high_low);
 	resource->id = ACPI_RSTYPE_EXT_IRQ;
 	resource->length = sizeof(struct acpi_resource);
@@ -701,7 +698,7 @@
 	resource->length = sizeof(struct acpi_resource);
 	/* Note: pnp_assign_port will copy pnp_port->flags into p->flags */
 	resource->data.io.io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR)?
-		ACPI_DECODE_16 : ACPI_DECODE_10; 
+		ACPI_DECODE_16 : ACPI_DECODE_10;
 	resource->data.io.min_base_address = p->start;
 	resource->data.io.max_base_address = p->end;
 	resource->data.io.alignment = 0; /* Correct? */
@@ -758,7 +755,7 @@
 	resource->data.fixed_memory32.range_length = p->end - p->start + 1;
 }
 
-int pnpacpi_encode_resources(struct pnp_resource_table *res_table, 
+int pnpacpi_encode_resources(struct pnp_resource_table *res_table,
 	struct acpi_buffer *buffer)
 {
 	int i = 0;
@@ -772,59 +769,59 @@
 		switch(resource->id) {
 		case ACPI_RSTYPE_IRQ:
 			pnp_dbg("Encode irq");
-			pnpacpi_encode_irq(resource, 
+			pnpacpi_encode_irq(resource,
 				&res_table->irq_resource[irq]);
 			irq++;
 			break;
 
 		case ACPI_RSTYPE_EXT_IRQ:
 			pnp_dbg("Encode ext irq");
-			pnpacpi_encode_ext_irq(resource, 
+			pnpacpi_encode_ext_irq(resource,
 				&res_table->irq_resource[irq]);
 			irq++;
 			break;
 		case ACPI_RSTYPE_DMA:
 			pnp_dbg("Encode dma");
-			pnpacpi_encode_dma(resource, 
+			pnpacpi_encode_dma(resource,
 				&res_table->dma_resource[dma]);
-			dma ++;
+			dma++;
 			break;
 		case ACPI_RSTYPE_IO:
 			pnp_dbg("Encode io");
-			pnpacpi_encode_io(resource, 
+			pnpacpi_encode_io(resource,
 				&res_table->port_resource[port]);
-			port ++;
+			port++;
 			break;
 		case ACPI_RSTYPE_FIXED_IO:
 			pnp_dbg("Encode fixed io");
 			pnpacpi_encode_fixed_io(resource,
 				&res_table->port_resource[port]);
-			port ++;
+			port++;
 			break;
 		case ACPI_RSTYPE_MEM24:
 			pnp_dbg("Encode mem24");
 			pnpacpi_encode_mem24(resource,
 				&res_table->mem_resource[mem]);
-			mem ++;
+			mem++;
 			break;
 		case ACPI_RSTYPE_MEM32:
 			pnp_dbg("Encode mem32");
 			pnpacpi_encode_mem32(resource,
 				&res_table->mem_resource[mem]);
-			mem ++;
+			mem++;
 			break;
 		case ACPI_RSTYPE_FIXED_MEM32:
 			pnp_dbg("Encode fixed mem32");
 			pnpacpi_encode_fixed_mem32(resource,
 				&res_table->mem_resource[mem]);
-			mem ++;
+			mem++;
 			break;
 		default: /* other type */
 			pnp_warn("unknown resource type %d", resource->id);
 			return -EINVAL;
 		}
-		resource ++;
-		i ++;
+		resource++;
+		i++;
 	}
 	return 0;
 }
Index: work/drivers/pnp/pnpacpi/core.c
===================================================================
--- work.orig/drivers/pnp/pnpacpi/core.c	2005-07-27 10:37:03.000000000 -0600
+++ work/drivers/pnp/pnpacpi/core.c	2005-07-27 10:39:26.000000000 -0600
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2004 Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
  * Copyright (c) 2004 Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
- * 
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2, or (at your option) any
@@ -18,7 +18,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
- 
+
 #include <linux/acpi.h>
 #include <linux/pnp.h>
 #include <acpi/acpi_bus.h>
@@ -44,6 +44,7 @@
 void *pnpacpi_kmalloc(size_t size, int f)
 {
 	void *p = kmalloc(size, f);
+
 	if (p)
 		memset(p, 0, size);
 	return p;
@@ -84,15 +85,17 @@
 	str[7] = '\0';
 }
 
-static int pnpacpi_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+static int pnpacpi_get_resources(struct pnp_dev *dev,
+	struct pnp_resource_table *res)
 {
 	acpi_status status;
-	status = pnpacpi_parse_allocated_resource((acpi_handle)dev->data, 
+	status = pnpacpi_parse_allocated_resource((acpi_handle)dev->data,
 		&dev->res);
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
 
-static int pnpacpi_set_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+static int pnpacpi_set_resources(struct pnp_dev *dev,
+	struct pnp_resource_table *res)
 {
 	acpi_handle handle = dev->data;
 	struct acpi_buffer buffer;
@@ -117,9 +120,9 @@
 static int pnpacpi_disable_resources(struct pnp_dev *dev)
 {
 	acpi_status status;
-	
+
 	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
-	status = acpi_evaluate_object((acpi_handle)dev->data, 
+	status = acpi_evaluate_object((acpi_handle)dev->data,
 		"_DIS", NULL, NULL);
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
@@ -171,7 +174,7 @@
 		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
 
 	dev->number = num;
-	
+
 	/* set the initial values for the PnP device */
 	dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!dev_id)
@@ -179,7 +182,7 @@
 	pnpidacpi_to_pnpid(acpi_device_hid(device), dev_id->id);
 	pnp_add_id(dev_id, dev);
 
-	if(dev->active) {
+	if (dev->active) {
 		/* parse allocated resource */
 		status = pnpacpi_parse_allocated_resource(device->handle, &dev->res);
 		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
@@ -188,15 +191,15 @@
 		}
 	}
 
-	if(dev->capabilities & PNP_CONFIGURABLE) {
-		status = pnpacpi_parse_resource_option_data(device->handle, 
+	if (dev->capabilities & PNP_CONFIGURABLE) {
+		status = pnpacpi_parse_resource_option_data(device->handle,
 			dev);
 		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
 			pnp_err("PnPACPI: METHOD_NAME__PRS failure for %s", dev_id->id);
 			goto err1;
 		}
 	}
-	
+
 	/* parse compatible ids */
 	if (device->flags.compatible_ids) {
 		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
@@ -205,7 +208,7 @@
 		for (i = 0; i < cid_list->count; i++) {
 			if (!ispnpidacpi(cid_list->id[i].value))
 				continue;
-			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), 
+			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id),
 				GFP_KERNEL);
 			if (!dev_id)
 				continue;
@@ -219,7 +222,7 @@
 	if (!dev->active)
 		pnp_init_resource_table(&dev->res);
 	pnp_add_device(dev);
-	num ++;
+	num++;
 
 	return AE_OK;
 err1:
Index: work/drivers/pnp/pnpacpi/pnpacpi.h
===================================================================
--- work.orig/drivers/pnp/pnpacpi/pnpacpi.h	2005-07-25 15:04:26.000000000 -0600
+++ work/drivers/pnp/pnpacpi/pnpacpi.h	2005-07-27 10:42:19.000000000 -0600
@@ -6,8 +6,8 @@
 #include <linux/pnp.h>
 
 void *pnpacpi_kmalloc(size_t size, int f);
-acpi_status pnpacpi_parse_allocated_resource(acpi_handle, struct pnp_resource_table*);
-acpi_status pnpacpi_parse_resource_option_data(acpi_handle, struct pnp_dev*);
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle, struct pnp_resource_table *);
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle, struct pnp_dev *);
 int pnpacpi_encode_resources(struct pnp_resource_table *, struct acpi_buffer *);
-int pnpacpi_build_resource_template(acpi_handle, struct acpi_buffer*);
+int pnpacpi_build_resource_template(acpi_handle, struct acpi_buffer *);
 #endif


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
