From: Len Brown <len.brown@intel.com>
Subject: [PATCH 14/20] ACPI: fix parallel port IRQ after resume from S3
Date: Fri,  9 Mar 2007 22:49:32 -0500
Message-ID: <11734985892382-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com> <1173498587849-git-send-email-len.brown@intel.com> <11734985882949-git-send-email-len.brown@intel.com> <11734985891723-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16223 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965668AbXCJDtv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:51 -0500
In-Reply-To: <11734985891723-git-send-email-len.brown@intel.com>
Message-Id: <362ea087db9d99bb0cf79479544dfafa9e18c300.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Michael Karcher <bugzilla-kernel@mkarcher.dialup.fu-berlin.de>, Len Brown <len.brown@intel.com>

From: Michael Karcher <bugzilla-kernel@mkarcher.dialup.fu-berlin.de>

The PNPACPI resource flags were broken.
This would apply to re-enabling a device any-time after boot,
not just after resume from S3.

http://bugzilla.kernel.org/show_bug.cgi?id=6316

Acked-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |  120 ++++++++++++++++++++++++----------------
 1 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 7a53554..118ac97 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -89,6 +89,7 @@ pnpacpi_parse_allocated_irqresource(struct pnp_resource_table *res, u32 gsi,
 		return;
 
 	res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+	res->irq_resource[i].flags |= irq_flags(triggering, polarity);
 	irq = acpi_register_gsi(gsi, triggering, polarity);
 	if (irq < 0) {
 		res->irq_resource[i].flags |= IORESOURCE_DISABLED;
@@ -103,8 +104,52 @@ pnpacpi_parse_allocated_irqresource(struct pnp_resource_table *res, u32 gsi,
 	pcibios_penalize_isa_irq(irq, 1);
 }
 
+static int dma_flags(int type, int bus_master, int transfer)
+{
+	int flags = 0;
+
+	if (bus_master)
+		flags |= IORESOURCE_DMA_MASTER;
+	switch (type) {
+	case ACPI_COMPATIBILITY:
+		flags |= IORESOURCE_DMA_COMPATIBLE;
+		break;
+	case ACPI_TYPE_A:
+		flags |= IORESOURCE_DMA_TYPEA;
+		break;
+	case ACPI_TYPE_B:
+		flags |= IORESOURCE_DMA_TYPEB;
+		break;
+	case ACPI_TYPE_F:
+		flags |= IORESOURCE_DMA_TYPEF;
+		break;
+	default:
+		/* Set a default value ? */
+		flags |= IORESOURCE_DMA_COMPATIBLE;
+		pnp_err("Invalid DMA type");
+	}
+	switch (transfer) {
+	case ACPI_TRANSFER_8:
+		flags |= IORESOURCE_DMA_8BIT;
+		break;
+	case ACPI_TRANSFER_8_16:
+		flags |= IORESOURCE_DMA_8AND16BIT;
+		break;
+	case ACPI_TRANSFER_16:
+		flags |= IORESOURCE_DMA_16BIT;
+		break;
+	default:
+		/* Set a default value ? */
+		flags |= IORESOURCE_DMA_8AND16BIT;
+		pnp_err("Invalid DMA transfer type");
+	}
+
+	return flags;
+}
+
 static void
-pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res, u32 dma)
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res, u32 dma,
+	int type, int bus_master, int transfer)
 {
 	int i = 0;
 	while (i < PNP_MAX_DMA &&
@@ -112,6 +157,7 @@ pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res, u32 dma)
 		i++;
 	if (i < PNP_MAX_DMA) {
 		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+		res->dma_resource[i].flags |= dma_flags(type, bus_master, transfer);
 		if (dma == -1) {
 			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
@@ -123,7 +169,7 @@ pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table *res, u32 dma)
 
 static void
 pnpacpi_parse_allocated_ioresource(struct pnp_resource_table *res,
-	u64 io, u64 len)
+	u64 io, u64 len, int io_decode)
 {
 	int i = 0;
 	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
@@ -131,6 +177,8 @@ pnpacpi_parse_allocated_ioresource(struct pnp_resource_table *res,
 		i++;
 	if (i < PNP_MAX_PORT) {
 		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+		if (io_decode == ACPI_DECODE_16)
+			res->port_resource[i].flags |= PNP_PORT_FLAG_16BITADDR;
 		if (len <= 0 || (io + len -1) >= 0x10003) {
 			res->port_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
@@ -142,7 +190,7 @@ pnpacpi_parse_allocated_ioresource(struct pnp_resource_table *res,
 
 static void
 pnpacpi_parse_allocated_memresource(struct pnp_resource_table *res,
-	u64 mem, u64 len)
+	u64 mem, u64 len, int write_protect)
 {
 	int i = 0;
 	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
@@ -154,6 +202,9 @@ pnpacpi_parse_allocated_memresource(struct pnp_resource_table *res,
 			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
+		if(write_protect == ACPI_READ_WRITE_MEMORY)
+			res->mem_resource[i].flags |= IORESOURCE_MEM_WRITEABLE;
+
 		res->mem_resource[i].start = mem;
 		res->mem_resource[i].end = mem + len - 1;
 	}
@@ -178,10 +229,11 @@ pnpacpi_parse_allocated_address_space(struct pnp_resource_table *res_table,
 
 	if (p->resource_type == ACPI_MEMORY_RANGE)
 		pnpacpi_parse_allocated_memresource(res_table,
-				p->minimum, p->address_length);
+				p->minimum, p->address_length, p->info.mem.write_protect);
 	else if (p->resource_type == ACPI_IO_RANGE)
 		pnpacpi_parse_allocated_ioresource(res_table,
-				p->minimum, p->address_length);
+				p->minimum, p->address_length,
+				p->granularity == 0xfff ? ACPI_DECODE_10 : ACPI_DECODE_16);
 }
 
 static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
@@ -208,13 +260,17 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	case ACPI_RESOURCE_TYPE_DMA:
 		if (res->data.dma.channel_count > 0)
 			pnpacpi_parse_allocated_dmaresource(res_table,
-					res->data.dma.channels[0]);
+					res->data.dma.channels[0],
+					res->data.dma.type,
+					res->data.dma.bus_master,
+					res->data.dma.transfer);
 		break;
 
 	case ACPI_RESOURCE_TYPE_IO:
 		pnpacpi_parse_allocated_ioresource(res_table,
 				res->data.io.minimum,
-				res->data.io.address_length);
+				res->data.io.address_length,
+				res->data.io.io_decode);
 		break;
 
 	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
@@ -224,7 +280,8 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	case ACPI_RESOURCE_TYPE_FIXED_IO:
 		pnpacpi_parse_allocated_ioresource(res_table,
 				res->data.fixed_io.address,
-				res->data.fixed_io.address_length);
+				res->data.fixed_io.address_length,
+				ACPI_DECODE_10);
 		break;
 
 	case ACPI_RESOURCE_TYPE_VENDOR:
@@ -236,17 +293,20 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	case ACPI_RESOURCE_TYPE_MEMORY24:
 		pnpacpi_parse_allocated_memresource(res_table,
 				res->data.memory24.minimum,
-				res->data.memory24.address_length);
+				res->data.memory24.address_length,
+				res->data.memory24.write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_MEMORY32:
 		pnpacpi_parse_allocated_memresource(res_table,
 				res->data.memory32.minimum,
-				res->data.memory32.address_length);
+				res->data.memory32.address_length,
+				res->data.memory32.write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
 		pnpacpi_parse_allocated_memresource(res_table,
 				res->data.fixed_memory32.address,
-				res->data.fixed_memory32.address_length);
+				res->data.fixed_memory32.address_length,
+				res->data.fixed_memory32.write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
@@ -304,42 +364,8 @@ static void pnpacpi_parse_dma_option(struct pnp_option *option, struct acpi_reso
 
 	for(i = 0; i < p->channel_count; i++)
 		dma->map |= 1 << p->channels[i];
-	dma->flags = 0;
-	if (p->bus_master)
-		dma->flags |= IORESOURCE_DMA_MASTER;
-	switch (p->type) {
-	case ACPI_COMPATIBILITY:
-		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
-		break;
-	case ACPI_TYPE_A:
-		dma->flags |= IORESOURCE_DMA_TYPEA;
-		break;
-	case ACPI_TYPE_B:
-		dma->flags |= IORESOURCE_DMA_TYPEB;
-		break;
-	case ACPI_TYPE_F:
-		dma->flags |= IORESOURCE_DMA_TYPEF;
-		break;
-	default:
-		/* Set a default value ? */
-		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
-		pnp_err("Invalid DMA type");
-	}
-	switch (p->transfer) {
-	case ACPI_TRANSFER_8:
-		dma->flags |= IORESOURCE_DMA_8BIT;
-		break;
-	case ACPI_TRANSFER_8_16:
-		dma->flags |= IORESOURCE_DMA_8AND16BIT;
-		break;
-	case ACPI_TRANSFER_16:
-		dma->flags |= IORESOURCE_DMA_16BIT;
-		break;
-	default:
-		/* Set a default value ? */
-		dma->flags |= IORESOURCE_DMA_8AND16BIT;
-		pnp_err("Invalid DMA transfer type");
-	}
+
+	dma->flags = dma_flags(p->type, p->bus_master, p->transfer);
 
 	pnp_register_dma_resource(option, dma);
 	return;
-- 
1.5.0.3.310.g05ef5
