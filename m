From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] PNPACPI: remove some code duplication
Date: Thu, 2 Feb 2006 14:57:10 -0700
Message-ID: <200602021457.10884.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:36323 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932327AbWBBV5P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2006 16:57:15 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Factor out the duplicated switch from pnpacpi_count_resources() and
pnpacpi_type_resources().  Remove the unnecessary re-initialization of
resource->type and length from all the encode functions (id and length are
originally set in the pnpacpi_build_resource_template() ->
pnpacpi_type_resources() path).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-mm4.orig/drivers/pnp/pnpacpi/rsparser.c	2006-02-02 10:35:54.000000000 -0700
+++ work-mm4/drivers/pnp/pnpacpi/rsparser.c	2006-02-02 14:22:10.000000000 -0700
@@ -647,13 +647,8 @@
 	return status;
 }
 
-/*
- * Set resource
- */
-static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
-	void *data)
+static int pnpacpi_supported_resource(struct acpi_resource *res)
 {
-	int *res_cnt = (int *)data;
 	switch (res->type) {
 	case ACPI_RESOURCE_TYPE_IRQ:
 	case ACPI_RESOURCE_TYPE_DMA:
@@ -666,15 +661,21 @@
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
-		(*res_cnt) ++;
-	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
-	case ACPI_RESOURCE_TYPE_END_DEPENDENT:
-	case ACPI_RESOURCE_TYPE_VENDOR:
-	case ACPI_RESOURCE_TYPE_END_TAG:
-	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
-	default:
-		return AE_OK;
+		return 1;
 	}
+	return 0;
+}
+
+/*
+ * Set resource
+ */
+static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
+	void *data)
+{
+	int *res_cnt = (int *)data;
+
+	if (pnpacpi_supported_resource(res))
+		(*res_cnt)++;
 	return AE_OK;
 }
 
@@ -682,27 +683,11 @@
 	void *data)
 {
 	struct acpi_resource **resource = (struct acpi_resource **)data;	
-	switch (res->type) {
-	case ACPI_RESOURCE_TYPE_IRQ:
-	case ACPI_RESOURCE_TYPE_DMA:
-	case ACPI_RESOURCE_TYPE_IO:
-	case ACPI_RESOURCE_TYPE_FIXED_IO:
-	case ACPI_RESOURCE_TYPE_MEMORY24:
-	case ACPI_RESOURCE_TYPE_MEMORY32:
-	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
-	case ACPI_RESOURCE_TYPE_ADDRESS16:
-	case ACPI_RESOURCE_TYPE_ADDRESS32:
-	case ACPI_RESOURCE_TYPE_ADDRESS64:
-	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+
+	if (pnpacpi_supported_resource(res)) {
 		(*resource)->type = res->type;
+		(*resource)->length = sizeof(struct acpi_resource);
 		(*resource)++;
-	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
-	case ACPI_RESOURCE_TYPE_END_DEPENDENT:
-	case ACPI_RESOURCE_TYPE_VENDOR:
-	case ACPI_RESOURCE_TYPE_END_TAG:
-	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
-	default:
-		return AE_OK;
 	}
 
 	return AE_OK;
@@ -749,8 +734,6 @@
 	
 	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering,
 		&polarity);
-	resource->type = ACPI_RESOURCE_TYPE_IRQ;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.irq.triggering = triggering;
 	resource->data.irq.polarity = polarity;
 	if (triggering == ACPI_EDGE_SENSITIVE)
@@ -768,8 +751,6 @@
 	
 	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering,
 		&polarity);
-	resource->type = ACPI_RESOURCE_TYPE_EXTENDED_IRQ;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.extended_irq.producer_consumer = ACPI_CONSUMER;
 	resource->data.extended_irq.triggering = triggering;
 	resource->data.extended_irq.polarity = polarity;
@@ -784,8 +765,6 @@
 static void pnpacpi_encode_dma(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_DMA;
-	resource->length = sizeof(struct acpi_resource);
 	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags */
 	if (p->flags & IORESOURCE_DMA_COMPATIBLE)
 		resource->data.dma.type = ACPI_COMPATIBILITY;
@@ -809,8 +788,6 @@
 static void pnpacpi_encode_io(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_IO;
-	resource->length = sizeof(struct acpi_resource);
 	/* Note: pnp_assign_port will copy pnp_port->flags into p->flags */
 	resource->data.io.io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR)?
 		ACPI_DECODE_16 : ACPI_DECODE_10;
@@ -823,8 +800,6 @@
 static void pnpacpi_encode_fixed_io(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_FIXED_IO;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.fixed_io.address = p->start;
 	resource->data.fixed_io.address_length = p->end - p->start + 1;
 }
@@ -832,8 +807,6 @@
 static void pnpacpi_encode_mem24(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_MEMORY24;
-	resource->length = sizeof(struct acpi_resource);
 	/* Note: pnp_assign_mem will copy pnp_mem->flags into p->flags */
 	resource->data.memory24.write_protect =
 		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
@@ -847,8 +820,6 @@
 static void pnpacpi_encode_mem32(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_MEMORY32;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.memory32.write_protect =
 		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
 		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
@@ -861,8 +832,6 @@
 static void pnpacpi_encode_fixed_mem32(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_FIXED_MEMORY32;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.fixed_memory32.write_protect =
 		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
 		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
