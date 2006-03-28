From: akpm@osdl.org
Subject: [patch 05/26] PNPACPI: remove some code duplication
Date: Tue, 28 Mar 2006 14:03:31 -0800
Message-ID: <200603282203.k2SM3bGX027662@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:48047 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932410AbWC1WDm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 17:03:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Factor out the duplicated switch from pnpacpi_count_resources() and
pnpacpi_type_resources().  Remove the unnecessary re-initialization of
resource->type and length from all the encode functions (id and length are
originally set in the pnpacpi_build_resource_template() ->
pnpacpi_type_resources() path).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pnp/pnpacpi/rsparser.c |   67 ++++++++-----------------------
 1 files changed, 18 insertions(+), 49 deletions(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-remove-some-code-duplication drivers/pnp/pnpacpi/rsparser.c
--- devel/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-remove-some-code-duplication	2006-03-28 14:03:01.000000000 -0800
+++ devel-akpm/drivers/pnp/pnpacpi/rsparser.c	2006-03-28 14:03:01.000000000 -0800
@@ -647,13 +647,8 @@ acpi_status pnpacpi_parse_resource_optio
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
@@ -666,15 +661,21 @@ static acpi_status pnpacpi_count_resourc
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
 
@@ -682,27 +683,11 @@ static acpi_status pnpacpi_type_resource
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
@@ -749,8 +734,6 @@ static void pnpacpi_encode_irq(struct ac
 	
 	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering,
 		&polarity);
-	resource->type = ACPI_RESOURCE_TYPE_IRQ;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.irq.triggering = triggering;
 	resource->data.irq.polarity = polarity;
 	if (triggering == ACPI_EDGE_SENSITIVE)
@@ -768,8 +751,6 @@ static void pnpacpi_encode_ext_irq(struc
 	
 	decode_irq_flags(p->flags & IORESOURCE_BITS, &triggering,
 		&polarity);
-	resource->type = ACPI_RESOURCE_TYPE_EXTENDED_IRQ;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.extended_irq.producer_consumer = ACPI_CONSUMER;
 	resource->data.extended_irq.triggering = triggering;
 	resource->data.extended_irq.polarity = polarity;
@@ -784,8 +765,6 @@ static void pnpacpi_encode_ext_irq(struc
 static void pnpacpi_encode_dma(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_DMA;
-	resource->length = sizeof(struct acpi_resource);
 	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags */
 	if (p->flags & IORESOURCE_DMA_COMPATIBLE)
 		resource->data.dma.type = ACPI_COMPATIBILITY;
@@ -809,8 +788,6 @@ static void pnpacpi_encode_dma(struct ac
 static void pnpacpi_encode_io(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_IO;
-	resource->length = sizeof(struct acpi_resource);
 	/* Note: pnp_assign_port will copy pnp_port->flags into p->flags */
 	resource->data.io.io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR)?
 		ACPI_DECODE_16 : ACPI_DECODE_10;
@@ -823,8 +800,6 @@ static void pnpacpi_encode_io(struct acp
 static void pnpacpi_encode_fixed_io(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_FIXED_IO;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.fixed_io.address = p->start;
 	resource->data.fixed_io.address_length = p->end - p->start + 1;
 }
@@ -832,8 +807,6 @@ static void pnpacpi_encode_fixed_io(stru
 static void pnpacpi_encode_mem24(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_MEMORY24;
-	resource->length = sizeof(struct acpi_resource);
 	/* Note: pnp_assign_mem will copy pnp_mem->flags into p->flags */
 	resource->data.memory24.write_protect =
 		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
@@ -847,8 +820,6 @@ static void pnpacpi_encode_mem24(struct 
 static void pnpacpi_encode_mem32(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_MEMORY32;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.memory32.write_protect =
 		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
 		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
@@ -861,8 +832,6 @@ static void pnpacpi_encode_mem32(struct 
 static void pnpacpi_encode_fixed_mem32(struct acpi_resource *resource,
 	struct resource *p)
 {
-	resource->type = ACPI_RESOURCE_TYPE_FIXED_MEMORY32;
-	resource->length = sizeof(struct acpi_resource);
 	resource->data.fixed_memory32.write_protect =
 		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
 		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
_
