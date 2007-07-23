From: helgaas@ldl.fc.hp.com
Subject: [patch 17/17] PNPACPI: Lindent rsparser.c
Date: Mon, 23 Jul 2007 15:28:14 -0600
Message-ID: <20070723213243.748497969@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:56472 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759178AbXGWVdd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:33 -0400
Content-Disposition: inline; filename=pnpacpi-format-rsparser
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work2.orig/drivers/pnp/pnpacpi/rsparser.c	2007-07-20 16:13:38.000000000 -0600
+++ work2/drivers/pnp/pnpacpi/rsparser.c	2007-07-20 16:14:28.000000000 -0600
@@ -40,8 +40,7 @@
 			flag = IORESOURCE_IRQ_LOWLEVEL;
 		else
 			flag = IORESOURCE_IRQ_HIGHLEVEL;
-	}
-	else {
+	} else {
 		if (polarity == ACPI_ACTIVE_LOW)
 			flag = IORESOURCE_IRQ_LOWEDGE;
 		else
@@ -72,9 +71,9 @@
 	}
 }
 
-static void
-pnpacpi_parse_allocated_irqresource(struct pnp_resource_table *res, u32 gsi,
-	int triggering, int polarity, int shareable)
+static void pnpacpi_parse_allocated_irqresource(struct pnp_resource_table *res,
+						u32 gsi, int triggering,
+						int polarity, int shareable)
 {
 	int i = 0;
 	int irq;
@@ -83,12 +82,12 @@
 		return;
 
 	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
-			i < PNP_MAX_IRQ)
+	       i < PNP_MAX_IRQ)
 		i++;
 	if (i >= PNP_MAX_IRQ)
 		return;
 
-	res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+	res->irq_resource[i].flags = IORESOURCE_IRQ;	// Also clears _UNSET flag
 	res->irq_resource[i].flags |= irq_flags(triggering, polarity);
 	irq = acpi_register_gsi(gsi, triggering, polarity);
 	if (irq < 0) {
@@ -147,17 +146,19 @@
 	return flags;
 }
 
-static void
-pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res, u32 dma,
-	int type, int bus_master, int transfer)
+static void pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res,
+						u32 dma, int type,
+						int bus_master, int transfer)
 {
 	int i = 0;
+
 	while (i < PNP_MAX_DMA &&
-			!(res->dma_resource[i].flags & IORESOURCE_UNSET))
+	       !(res->dma_resource[i].flags & IORESOURCE_UNSET))
 		i++;
 	if (i < PNP_MAX_DMA) {
-		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
-		res->dma_resource[i].flags |= dma_flags(type, bus_master, transfer);
+		res->dma_resource[i].flags = IORESOURCE_DMA;	// Also clears _UNSET flag
+		res->dma_resource[i].flags |=
+		    dma_flags(type, bus_master, transfer);
 		if (dma == -1) {
 			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
@@ -167,19 +168,19 @@
 	}
 }
 
-static void
-pnpacpi_parse_allocated_ioresource(struct pnp_resource_table *res,
-	u64 io, u64 len, int io_decode)
+static void pnpacpi_parse_allocated_ioresource(struct pnp_resource_table *res,
+					       u64 io, u64 len, int io_decode)
 {
 	int i = 0;
+
 	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
-			i < PNP_MAX_PORT)
+	       i < PNP_MAX_PORT)
 		i++;
 	if (i < PNP_MAX_PORT) {
-		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+		res->port_resource[i].flags = IORESOURCE_IO;	// Also clears _UNSET flag
 		if (io_decode == ACPI_DECODE_16)
 			res->port_resource[i].flags |= PNP_PORT_FLAG_16BITADDR;
-		if (len <= 0 || (io + len -1) >= 0x10003) {
+		if (len <= 0 || (io + len - 1) >= 0x10003) {
 			res->port_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
@@ -188,21 +189,22 @@
 	}
 }
 
-static void
-pnpacpi_parse_allocated_memresource(struct pnp_resource_table *res,
-	u64 mem, u64 len, int write_protect)
+static void pnpacpi_parse_allocated_memresource(struct pnp_resource_table *res,
+						u64 mem, u64 len,
+						int write_protect)
 {
 	int i = 0;
+
 	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
-			(i < PNP_MAX_MEM))
+	       (i < PNP_MAX_MEM))
 		i++;
 	if (i < PNP_MAX_MEM) {
-		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+		res->mem_resource[i].flags = IORESOURCE_MEM;	// Also clears _UNSET flag
 		if (len <= 0) {
 			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		if(write_protect == ACPI_READ_WRITE_MEMORY)
+		if (write_protect == ACPI_READ_WRITE_MEMORY)
 			res->mem_resource[i].flags |= IORESOURCE_MEM_WRITEABLE;
 
 		res->mem_resource[i].start = mem;
@@ -210,9 +212,8 @@
 	}
 }
 
-static void
-pnpacpi_parse_allocated_address_space(struct pnp_resource_table *res_table,
-	struct acpi_resource *res)
+static void pnpacpi_parse_allocated_address_space(struct pnp_resource_table *res_table,
+						  struct acpi_resource *res)
 {
 	struct acpi_resource_address64 addr, *p = &addr;
 	acpi_status status;
@@ -220,7 +221,7 @@
 	status = acpi_resource_to_address64(res, p);
 	if (!ACPI_SUCCESS(status)) {
 		pnp_warn("PnPACPI: failed to convert resource type %d",
-			res->type);
+			 res->type);
 		return;
 	}
 
@@ -229,17 +230,20 @@
 
 	if (p->resource_type == ACPI_MEMORY_RANGE)
 		pnpacpi_parse_allocated_memresource(res_table,
-				p->minimum, p->address_length, p->info.mem.write_protect);
+			p->minimum, p->address_length,
+			p->info.mem.write_protect);
 	else if (p->resource_type == ACPI_IO_RANGE)
 		pnpacpi_parse_allocated_ioresource(res_table,
-				p->minimum, p->address_length,
-				p->granularity == 0xfff ? ACPI_DECODE_10 : ACPI_DECODE_16);
+			p->minimum, p->address_length,
+			p->granularity == 0xfff ? ACPI_DECODE_10 :
+				ACPI_DECODE_16);
 }
 
 static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
-	void *data)
+					      void *data)
 {
-	struct pnp_resource_table *res_table = (struct pnp_resource_table *)data;
+	struct pnp_resource_table *res_table =
+	    (struct pnp_resource_table *)data;
 	int i;
 
 	switch (res->type) {
@@ -260,17 +264,17 @@
 	case ACPI_RESOURCE_TYPE_DMA:
 		if (res->data.dma.channel_count > 0)
 			pnpacpi_parse_allocated_dmaresource(res_table,
-					res->data.dma.channels[0],
-					res->data.dma.type,
-					res->data.dma.bus_master,
-					res->data.dma.transfer);
+				res->data.dma.channels[0],
+				res->data.dma.type,
+				res->data.dma.bus_master,
+				res->data.dma.transfer);
 		break;
 
 	case ACPI_RESOURCE_TYPE_IO:
 		pnpacpi_parse_allocated_ioresource(res_table,
-				res->data.io.minimum,
-				res->data.io.address_length,
-				res->data.io.io_decode);
+			res->data.io.minimum,
+			res->data.io.address_length,
+			res->data.io.io_decode);
 		break;
 
 	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
@@ -279,9 +283,9 @@
 
 	case ACPI_RESOURCE_TYPE_FIXED_IO:
 		pnpacpi_parse_allocated_ioresource(res_table,
-				res->data.fixed_io.address,
-				res->data.fixed_io.address_length,
-				ACPI_DECODE_10);
+			res->data.fixed_io.address,
+			res->data.fixed_io.address_length,
+			ACPI_DECODE_10);
 		break;
 
 	case ACPI_RESOURCE_TYPE_VENDOR:
@@ -292,21 +296,21 @@
 
 	case ACPI_RESOURCE_TYPE_MEMORY24:
 		pnpacpi_parse_allocated_memresource(res_table,
-				res->data.memory24.minimum,
-				res->data.memory24.address_length,
-				res->data.memory24.write_protect);
+			res->data.memory24.minimum,
+			res->data.memory24.address_length,
+			res->data.memory24.write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_MEMORY32:
 		pnpacpi_parse_allocated_memresource(res_table,
-				res->data.memory32.minimum,
-				res->data.memory32.address_length,
-				res->data.memory32.write_protect);
+			res->data.memory32.minimum,
+			res->data.memory32.address_length,
+			res->data.memory32.write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
 		pnpacpi_parse_allocated_memresource(res_table,
-				res->data.fixed_memory32.address,
-				res->data.fixed_memory32.address_length,
-				res->data.fixed_memory32.write_protect);
+			res->data.fixed_memory32.address,
+			res->data.fixed_memory32.address_length,
+			res->data.fixed_memory32.write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
@@ -343,18 +347,21 @@
 	return AE_OK;
 }
 
-acpi_status pnpacpi_parse_allocated_resource(acpi_handle handle, struct pnp_resource_table *res)
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle handle,
+					     struct pnp_resource_table * res)
 {
 	/* Blank the resource table values */
 	pnp_init_resource_table(res);
 
-	return acpi_walk_resources(handle, METHOD_NAME__CRS, pnpacpi_allocated_resource, res);
+	return acpi_walk_resources(handle, METHOD_NAME__CRS,
+				   pnpacpi_allocated_resource, res);
 }
 
-static void pnpacpi_parse_dma_option(struct pnp_option *option, struct acpi_resource_dma *p)
+static void pnpacpi_parse_dma_option(struct pnp_option *option,
+				     struct acpi_resource_dma *p)
 {
 	int i;
-	struct pnp_dma * dma;
+	struct pnp_dma *dma;
 
 	if (p->channel_count == 0)
 		return;
@@ -362,18 +369,16 @@
 	if (!dma)
 		return;
 
-	for(i = 0; i < p->channel_count; i++)
+	for (i = 0; i < p->channel_count; i++)
 		dma->map |= 1 << p->channels[i];
 
 	dma->flags = dma_flags(p->type, p->bus_master, p->transfer);
 
 	pnp_register_dma_resource(option, dma);
-	return;
 }
 
-
 static void pnpacpi_parse_irq_option(struct pnp_option *option,
-	struct acpi_resource_irq *p)
+				     struct acpi_resource_irq *p)
 {
 	int i;
 	struct pnp_irq *irq;
@@ -384,17 +389,16 @@
 	if (!irq)
 		return;
 
-	for(i = 0; i < p->interrupt_count; i++)
+	for (i = 0; i < p->interrupt_count; i++)
 		if (p->interrupts[i])
 			__set_bit(p->interrupts[i], irq->map);
 	irq->flags = irq_flags(p->triggering, p->polarity);
 
 	pnp_register_irq_resource(option, irq);
-	return;
 }
 
 static void pnpacpi_parse_ext_irq_option(struct pnp_option *option,
-	struct acpi_resource_extended_irq *p)
+					 struct acpi_resource_extended_irq *p)
 {
 	int i;
 	struct pnp_irq *irq;
@@ -405,18 +409,16 @@
 	if (!irq)
 		return;
 
-	for(i = 0; i < p->interrupt_count; i++)
+	for (i = 0; i < p->interrupt_count; i++)
 		if (p->interrupts[i])
 			__set_bit(p->interrupts[i], irq->map);
 	irq->flags = irq_flags(p->triggering, p->polarity);
 
 	pnp_register_irq_resource(option, irq);
-	return;
 }
 
-static void
-pnpacpi_parse_port_option(struct pnp_option *option,
-	struct acpi_resource_io *io)
+static void pnpacpi_parse_port_option(struct pnp_option *option,
+				      struct acpi_resource_io *io)
 {
 	struct pnp_port *port;
 
@@ -430,14 +432,12 @@
 	port->align = io->alignment;
 	port->size = io->address_length;
 	port->flags = ACPI_DECODE_16 == io->io_decode ?
-		PNP_PORT_FLAG_16BITADDR : 0;
+	    PNP_PORT_FLAG_16BITADDR : 0;
 	pnp_register_port_resource(option, port);
-	return;
 }
 
-static void
-pnpacpi_parse_fixed_port_option(struct pnp_option *option,
-	struct acpi_resource_fixed_io *io)
+static void pnpacpi_parse_fixed_port_option(struct pnp_option *option,
+					    struct acpi_resource_fixed_io *io)
 {
 	struct pnp_port *port;
 
@@ -451,12 +451,10 @@
 	port->align = 0;
 	port->flags = PNP_PORT_FLAG_FIXED;
 	pnp_register_port_resource(option, port);
-	return;
 }
 
-static void
-pnpacpi_parse_mem24_option(struct pnp_option *option,
-	struct acpi_resource_memory24 *p)
+static void pnpacpi_parse_mem24_option(struct pnp_option *option,
+				       struct acpi_resource_memory24 *p)
 {
 	struct pnp_mem *mem;
 
@@ -471,15 +469,13 @@
 	mem->size = p->address_length;
 
 	mem->flags = (ACPI_READ_WRITE_MEMORY == p->write_protect) ?
-			IORESOURCE_MEM_WRITEABLE : 0;
+	    IORESOURCE_MEM_WRITEABLE : 0;
 
 	pnp_register_mem_resource(option, mem);
-	return;
 }
 
-static void
-pnpacpi_parse_mem32_option(struct pnp_option *option,
-	struct acpi_resource_memory32 *p)
+static void pnpacpi_parse_mem32_option(struct pnp_option *option,
+				       struct acpi_resource_memory32 *p)
 {
 	struct pnp_mem *mem;
 
@@ -494,15 +490,13 @@
 	mem->size = p->address_length;
 
 	mem->flags = (ACPI_READ_WRITE_MEMORY == p->write_protect) ?
-			IORESOURCE_MEM_WRITEABLE : 0;
+	    IORESOURCE_MEM_WRITEABLE : 0;
 
 	pnp_register_mem_resource(option, mem);
-	return;
 }
 
-static void
-pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
-	struct acpi_resource_fixed_memory32 *p)
+static void pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
+					 struct acpi_resource_fixed_memory32 *p)
 {
 	struct pnp_mem *mem;
 
@@ -516,14 +510,13 @@
 	mem->align = 0;
 
 	mem->flags = (ACPI_READ_WRITE_MEMORY == p->write_protect) ?
-			IORESOURCE_MEM_WRITEABLE : 0;
+	    IORESOURCE_MEM_WRITEABLE : 0;
 
 	pnp_register_mem_resource(option, mem);
-	return;
 }
 
-static void
-pnpacpi_parse_address_option(struct pnp_option *option, struct acpi_resource *r)
+static void pnpacpi_parse_address_option(struct pnp_option *option,
+					 struct acpi_resource *r)
 {
 	struct acpi_resource_address64 addr, *p = &addr;
 	acpi_status status;
@@ -532,7 +525,8 @@
 
 	status = acpi_resource_to_address64(r, p);
 	if (!ACPI_SUCCESS(status)) {
-		pnp_warn("PnPACPI: failed to convert resource type %d", r->type);
+		pnp_warn("PnPACPI: failed to convert resource type %d",
+			 r->type);
 		return;
 	}
 
@@ -547,7 +541,8 @@
 		mem->size = p->address_length;
 		mem->align = 0;
 		mem->flags = (p->info.mem.write_protect ==
-		    ACPI_READ_WRITE_MEMORY) ? IORESOURCE_MEM_WRITEABLE : 0;
+			      ACPI_READ_WRITE_MEMORY) ? IORESOURCE_MEM_WRITEABLE
+		    : 0;
 		pnp_register_mem_resource(option, mem);
 	} else if (p->resource_type == ACPI_IO_RANGE) {
 		port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
@@ -568,109 +563,108 @@
 };
 
 static acpi_status pnpacpi_option_resource(struct acpi_resource *res,
-	void *data)
+					   void *data)
 {
 	int priority = 0;
-	struct acpipnp_parse_option_s *parse_data = (struct acpipnp_parse_option_s *)data;
+	struct acpipnp_parse_option_s *parse_data =
+	    (struct acpipnp_parse_option_s *)data;
 	struct pnp_dev *dev = parse_data->dev;
 	struct pnp_option *option = parse_data->option;
 
 	switch (res->type) {
-		case ACPI_RESOURCE_TYPE_IRQ:
-			pnpacpi_parse_irq_option(option, &res->data.irq);
-			break;
+	case ACPI_RESOURCE_TYPE_IRQ:
+		pnpacpi_parse_irq_option(option, &res->data.irq);
+		break;
 
-		case ACPI_RESOURCE_TYPE_DMA:
-			pnpacpi_parse_dma_option(option, &res->data.dma);
-			break;
+	case ACPI_RESOURCE_TYPE_DMA:
+		pnpacpi_parse_dma_option(option, &res->data.dma);
+		break;
 
-		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
-			switch (res->data.start_dpf.compatibility_priority) {
-				case ACPI_GOOD_CONFIGURATION:
-					priority = PNP_RES_PRIORITY_PREFERRED;
-					break;
-
-				case ACPI_ACCEPTABLE_CONFIGURATION:
-					priority = PNP_RES_PRIORITY_ACCEPTABLE;
-					break;
-
-				case ACPI_SUB_OPTIMAL_CONFIGURATION:
-					priority = PNP_RES_PRIORITY_FUNCTIONAL;
-					break;
-				default:
-					priority = PNP_RES_PRIORITY_INVALID;
-					break;
-			}
-			/* TBD: Considering performace/robustness bits */
-			option = pnp_register_dependent_option(dev, priority);
-			if (!option)
-				return AE_ERROR;
-			parse_data->option = option;
+	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
+		switch (res->data.start_dpf.compatibility_priority) {
+		case ACPI_GOOD_CONFIGURATION:
+			priority = PNP_RES_PRIORITY_PREFERRED;
 			break;
 
-		case ACPI_RESOURCE_TYPE_END_DEPENDENT:
-			/*only one EndDependentFn is allowed*/
-			if (!parse_data->option_independent) {
-				pnp_warn("PnPACPI: more than one EndDependentFn");
-				return AE_ERROR;
-			}
-			parse_data->option = parse_data->option_independent;
-			parse_data->option_independent = NULL;
+		case ACPI_ACCEPTABLE_CONFIGURATION:
+			priority = PNP_RES_PRIORITY_ACCEPTABLE;
 			break;
 
-		case ACPI_RESOURCE_TYPE_IO:
-			pnpacpi_parse_port_option(option, &res->data.io);
+		case ACPI_SUB_OPTIMAL_CONFIGURATION:
+			priority = PNP_RES_PRIORITY_FUNCTIONAL;
 			break;
-
-		case ACPI_RESOURCE_TYPE_FIXED_IO:
-			pnpacpi_parse_fixed_port_option(option,
-				&res->data.fixed_io);
+		default:
+			priority = PNP_RES_PRIORITY_INVALID;
 			break;
+		}
+		/* TBD: Consider performance/robustness bits */
+		option = pnp_register_dependent_option(dev, priority);
+		if (!option)
+			return AE_ERROR;
+		parse_data->option = option;
+		break;
 
-		case ACPI_RESOURCE_TYPE_VENDOR:
-		case ACPI_RESOURCE_TYPE_END_TAG:
-			break;
+	case ACPI_RESOURCE_TYPE_END_DEPENDENT:
+		/*only one EndDependentFn is allowed */
+		if (!parse_data->option_independent) {
+			pnp_warn("PnPACPI: more than one EndDependentFn");
+			return AE_ERROR;
+		}
+		parse_data->option = parse_data->option_independent;
+		parse_data->option_independent = NULL;
+		break;
 
-		case ACPI_RESOURCE_TYPE_MEMORY24:
-			pnpacpi_parse_mem24_option(option, &res->data.memory24);
-			break;
+	case ACPI_RESOURCE_TYPE_IO:
+		pnpacpi_parse_port_option(option, &res->data.io);
+		break;
 
-		case ACPI_RESOURCE_TYPE_MEMORY32:
-			pnpacpi_parse_mem32_option(option, &res->data.memory32);
-			break;
+	case ACPI_RESOURCE_TYPE_FIXED_IO:
+		pnpacpi_parse_fixed_port_option(option, &res->data.fixed_io);
+		break;
 
-		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
-			pnpacpi_parse_fixed_mem32_option(option,
-				&res->data.fixed_memory32);
-			break;
+	case ACPI_RESOURCE_TYPE_VENDOR:
+	case ACPI_RESOURCE_TYPE_END_TAG:
+		break;
 
-		case ACPI_RESOURCE_TYPE_ADDRESS16:
-		case ACPI_RESOURCE_TYPE_ADDRESS32:
-		case ACPI_RESOURCE_TYPE_ADDRESS64:
-			pnpacpi_parse_address_option(option, res);
-			break;
+	case ACPI_RESOURCE_TYPE_MEMORY24:
+		pnpacpi_parse_mem24_option(option, &res->data.memory24);
+		break;
 
-		case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
-			break;
+	case ACPI_RESOURCE_TYPE_MEMORY32:
+		pnpacpi_parse_mem32_option(option, &res->data.memory32);
+		break;
 
-		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
-			pnpacpi_parse_ext_irq_option(option,
-				&res->data.extended_irq);
-			break;
+	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
+		pnpacpi_parse_fixed_mem32_option(option,
+						 &res->data.fixed_memory32);
+		break;
 
-		case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
-			break;
+	case ACPI_RESOURCE_TYPE_ADDRESS16:
+	case ACPI_RESOURCE_TYPE_ADDRESS32:
+	case ACPI_RESOURCE_TYPE_ADDRESS64:
+		pnpacpi_parse_address_option(option, res);
+		break;
 
-		default:
-			pnp_warn("PnPACPI: unknown resource type %d", res->type);
-			return AE_ERROR;
+	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		break;
+
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		pnpacpi_parse_ext_irq_option(option, &res->data.extended_irq);
+		break;
+
+	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
+		break;
+
+	default:
+		pnp_warn("PnPACPI: unknown resource type %d", res->type);
+		return AE_ERROR;
 	}
 
 	return AE_OK;
 }
 
 acpi_status pnpacpi_parse_resource_option_data(acpi_handle handle,
-	struct pnp_dev *dev)
+					       struct pnp_dev * dev)
 {
 	acpi_status status;
 	struct acpipnp_parse_option_s parse_data;
@@ -681,7 +675,7 @@
 	parse_data.option_independent = parse_data.option;
 	parse_data.dev = dev;
 	status = acpi_walk_resources(handle, METHOD_NAME__PRS,
-		pnpacpi_option_resource, &parse_data);
+				     pnpacpi_option_resource, &parse_data);
 
 	return status;
 }
@@ -709,7 +703,7 @@
  * Set resource
  */
 static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
-	void *data)
+					   void *data)
 {
 	int *res_cnt = (int *)data;
 
@@ -732,14 +726,14 @@
 }
 
 int pnpacpi_build_resource_template(acpi_handle handle,
-	struct acpi_buffer *buffer)
+				    struct acpi_buffer *buffer)
 {
 	struct acpi_resource *resource;
 	int res_cnt = 0;
 	acpi_status status;
 
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-		pnpacpi_count_resources, &res_cnt);
+				     pnpacpi_count_resources, &res_cnt);
 	if (ACPI_FAILURE(status)) {
 		pnp_err("Evaluate _CRS failed");
 		return -EINVAL;
@@ -753,7 +747,7 @@
 	pnp_dbg("Res cnt %d", res_cnt);
 	resource = (struct acpi_resource *)buffer->pointer;
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-		pnpacpi_type_resources, &resource);
+				     pnpacpi_type_resources, &resource);
 	if (ACPI_FAILURE(status)) {
 		kfree(buffer->pointer);
 		pnp_err("Evaluate _CRS failed");
@@ -766,7 +760,7 @@
 }
 
 static void pnpacpi_encode_irq(struct acpi_resource *resource,
-	struct resource *p)
+			       struct resource *p)
 {
 	int triggering, polarity;
 
@@ -782,7 +776,7 @@
 }
 
 static void pnpacpi_encode_ext_irq(struct acpi_resource *resource,
-	struct resource *p)
+				   struct resource *p)
 {
 	int triggering, polarity;
 
@@ -799,32 +793,32 @@
 }
 
 static void pnpacpi_encode_dma(struct acpi_resource *resource,
-	struct resource *p)
+			       struct resource *p)
 {
 	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags */
 	switch (p->flags & IORESOURCE_DMA_SPEED_MASK) {
-		case IORESOURCE_DMA_TYPEA:
-			resource->data.dma.type = ACPI_TYPE_A;
-			break;
-		case IORESOURCE_DMA_TYPEB:
-			resource->data.dma.type = ACPI_TYPE_B;
-			break;
-		case IORESOURCE_DMA_TYPEF:
-			resource->data.dma.type = ACPI_TYPE_F;
-			break;
-		default:
-			resource->data.dma.type = ACPI_COMPATIBILITY;
+	case IORESOURCE_DMA_TYPEA:
+		resource->data.dma.type = ACPI_TYPE_A;
+		break;
+	case IORESOURCE_DMA_TYPEB:
+		resource->data.dma.type = ACPI_TYPE_B;
+		break;
+	case IORESOURCE_DMA_TYPEF:
+		resource->data.dma.type = ACPI_TYPE_F;
+		break;
+	default:
+		resource->data.dma.type = ACPI_COMPATIBILITY;
 	}
 
 	switch (p->flags & IORESOURCE_DMA_TYPE_MASK) {
-		case IORESOURCE_DMA_8BIT:
-			resource->data.dma.transfer = ACPI_TRANSFER_8;
-			break;
-		case IORESOURCE_DMA_8AND16BIT:
-			resource->data.dma.transfer = ACPI_TRANSFER_8_16;
-			break;
-		default:
-			resource->data.dma.transfer = ACPI_TRANSFER_16;
+	case IORESOURCE_DMA_8BIT:
+		resource->data.dma.transfer = ACPI_TRANSFER_8;
+		break;
+	case IORESOURCE_DMA_8AND16BIT:
+		resource->data.dma.transfer = ACPI_TRANSFER_8_16;
+		break;
+	default:
+		resource->data.dma.transfer = ACPI_TRANSFER_16;
 	}
 
 	resource->data.dma.bus_master = !!(p->flags & IORESOURCE_DMA_MASTER);
@@ -833,31 +827,31 @@
 }
 
 static void pnpacpi_encode_io(struct acpi_resource *resource,
-	struct resource *p)
+			      struct resource *p)
 {
 	/* Note: pnp_assign_port will copy pnp_port->flags into p->flags */
-	resource->data.io.io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR)?
-		ACPI_DECODE_16 : ACPI_DECODE_10;
+	resource->data.io.io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR) ?
+	    ACPI_DECODE_16 : ACPI_DECODE_10;
 	resource->data.io.minimum = p->start;
 	resource->data.io.maximum = p->end;
-	resource->data.io.alignment = 0; /* Correct? */
+	resource->data.io.alignment = 0;	/* Correct? */
 	resource->data.io.address_length = p->end - p->start + 1;
 }
 
 static void pnpacpi_encode_fixed_io(struct acpi_resource *resource,
-	struct resource *p)
+				    struct resource *p)
 {
 	resource->data.fixed_io.address = p->start;
 	resource->data.fixed_io.address_length = p->end - p->start + 1;
 }
 
 static void pnpacpi_encode_mem24(struct acpi_resource *resource,
-	struct resource *p)
+				 struct resource *p)
 {
 	/* Note: pnp_assign_mem will copy pnp_mem->flags into p->flags */
 	resource->data.memory24.write_protect =
-		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
-		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	    (p->flags & IORESOURCE_MEM_WRITEABLE) ?
+	    ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
 	resource->data.memory24.minimum = p->start;
 	resource->data.memory24.maximum = p->end;
 	resource->data.memory24.alignment = 0;
@@ -865,11 +859,11 @@
 }
 
 static void pnpacpi_encode_mem32(struct acpi_resource *resource,
-	struct resource *p)
+				 struct resource *p)
 {
 	resource->data.memory32.write_protect =
-		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
-		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	    (p->flags & IORESOURCE_MEM_WRITEABLE) ?
+	    ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
 	resource->data.memory32.minimum = p->start;
 	resource->data.memory32.maximum = p->end;
 	resource->data.memory32.alignment = 0;
@@ -877,74 +871,77 @@
 }
 
 static void pnpacpi_encode_fixed_mem32(struct acpi_resource *resource,
-	struct resource *p)
+				       struct resource *p)
 {
 	resource->data.fixed_memory32.write_protect =
-		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
-		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	    (p->flags & IORESOURCE_MEM_WRITEABLE) ?
+	    ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
 	resource->data.fixed_memory32.address = p->start;
 	resource->data.fixed_memory32.address_length = p->end - p->start + 1;
 }
 
 int pnpacpi_encode_resources(struct pnp_resource_table *res_table,
-	struct acpi_buffer *buffer)
+			     struct acpi_buffer *buffer)
 {
 	int i = 0;
 	/* pnpacpi_build_resource_template allocates extra mem */
-	int res_cnt = (buffer->length - 1)/sizeof(struct acpi_resource) - 1;
-	struct acpi_resource *resource = (struct acpi_resource*)buffer->pointer;
+	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
+	struct acpi_resource *resource =
+	    (struct acpi_resource *)buffer->pointer;
 	int port = 0, irq = 0, dma = 0, mem = 0;
 
 	pnp_dbg("res cnt %d", res_cnt);
 	while (i < res_cnt) {
-		switch(resource->type) {
+		switch (resource->type) {
 		case ACPI_RESOURCE_TYPE_IRQ:
 			pnp_dbg("Encode irq");
 			pnpacpi_encode_irq(resource,
-				&res_table->irq_resource[irq]);
+					   &res_table->irq_resource[irq]);
 			irq++;
 			break;
 
 		case ACPI_RESOURCE_TYPE_DMA:
 			pnp_dbg("Encode dma");
 			pnpacpi_encode_dma(resource,
-				&res_table->dma_resource[dma]);
+					   &res_table->dma_resource[dma]);
 			dma++;
 			break;
 		case ACPI_RESOURCE_TYPE_IO:
 			pnp_dbg("Encode io");
 			pnpacpi_encode_io(resource,
-				&res_table->port_resource[port]);
+					  &res_table->port_resource[port]);
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_IO:
 			pnp_dbg("Encode fixed io");
 			pnpacpi_encode_fixed_io(resource,
-				&res_table->port_resource[port]);
+						&res_table->
+						port_resource[port]);
 			port++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY24:
 			pnp_dbg("Encode mem24");
 			pnpacpi_encode_mem24(resource,
-				&res_table->mem_resource[mem]);
+					     &res_table->mem_resource[mem]);
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_MEMORY32:
 			pnp_dbg("Encode mem32");
 			pnpacpi_encode_mem32(resource,
-				&res_table->mem_resource[mem]);
+					     &res_table->mem_resource[mem]);
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
 			pnp_dbg("Encode fixed mem32");
 			pnpacpi_encode_fixed_mem32(resource,
-				&res_table->mem_resource[mem]);
+						   &res_table->
+						   mem_resource[mem]);
 			mem++;
 			break;
 		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 			pnp_dbg("Encode ext irq");
 			pnpacpi_encode_ext_irq(resource,
-				&res_table->irq_resource[irq]);
+					       &res_table->irq_resource[irq]);
 			irq++;
 			break;
 		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
@@ -956,7 +953,7 @@
 		case ACPI_RESOURCE_TYPE_ADDRESS64:
 		case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
 		case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
-		default: /* other type */
+		default:	/* other type */
 			pnp_warn("unknown resource type %d", resource->type);
 			return -EINVAL;
 		}

--
