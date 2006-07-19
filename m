From: "Brown, Len" <len.brown@intel.com>
Subject: FW: PnPACPI issues
Date: Wed, 19 Jul 2006 10:40:35 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601053708@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59053 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964853AbWGSOqd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2006 10:46:33 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

 

-----Original Message-----
From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
Sent: Tuesday, July 18, 2006 4:03 PM
To: Brown, Len
Subject: PnPACPI issues

Hi Len,

as promised, I'm sending you the patch.

From: Vojtech Pavlik <vojtech@suse.cz>
Date: Fri Apr  7 20:00:27 CEST 2006
Subject: Fix DMA resource allocation in ACPIPnP
Patch-mainline: Not yet
References: 116655

===================================================================

The ACPIPnP implementation had the understanding of Linux resource flags
very
wrong, resulting in a nonfunctional implementation of DMA resource
allocation. 

This was usually not a problem, since almost no on-board PnP devices use
ISA
DMA, with the exception of ECP parallel ports. Even with that, parallel
port
DMA is preconfigured by the BIOS, so this routine isn't normally called.

Except in the case where somebody does 'rmmod parport_pc; modprobe
parport_pc', where the rmmod case disables the ECP parallel port
resources,
and they need to be enabled again to initialize the module. This didn't
work, resulting in a non-printing printer.

The application doing exactly the above to force reprobing of printers
is
the YaST printer module. Thus without this fix YaST wedged the printer
when
configuring it, and was not able to print a test page.

Reported-by: Ralf Flaxa <rf@suse.de>
Reproduced-by: Jiri Dluhos <jdluhos@suse.cz>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

===================================================================

 rsparser.c |   43 ++++++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 15 deletions(-)

Index: linux/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- linux.orig/drivers/pnp/pnpacpi/rsparser.c	2006-04-07
20:40:10.000000000 +0200
+++ linux/drivers/pnp/pnpacpi/rsparser.c	2006-04-07
20:40:14.000000000 +0200
@@ -775,22 +775,35 @@
 {
 	resource->type = ACPI_RESOURCE_TYPE_DMA;
 	resource->length = sizeof(struct acpi_resource);
+
 	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags
*/
-	if (p->flags & IORESOURCE_DMA_COMPATIBLE)
-		resource->data.dma.type = ACPI_COMPATIBILITY;
-	else if (p->flags & IORESOURCE_DMA_TYPEA)
-		resource->data.dma.type = ACPI_TYPE_A;
-	else if (p->flags & IORESOURCE_DMA_TYPEB)
-		resource->data.dma.type = ACPI_TYPE_B;
-	else if (p->flags & IORESOURCE_DMA_TYPEF)
-		resource->data.dma.type = ACPI_TYPE_F;
-	if (p->flags & IORESOURCE_DMA_8BIT)
-		resource->data.dma.transfer = ACPI_TRANSFER_8;
-	else if (p->flags & IORESOURCE_DMA_8AND16BIT)
-		resource->data.dma.transfer = ACPI_TRANSFER_8_16;
-	else if (p->flags & IORESOURCE_DMA_16BIT)
-		resource->data.dma.transfer = ACPI_TRANSFER_16;
-	resource->data.dma.bus_master = p->flags &
IORESOURCE_DMA_MASTER;
+
+	switch (p->flags & IORESOURCE_DMA_SPEED_MASK) {
+		case IORESOURCE_DMA_TYPEA:
+			resource->data.dma.type = ACPI_TYPE_A;
+			break;
+		case IORESOURCE_DMA_TYPEB:
+			resource->data.dma.type = ACPI_TYPE_B;
+			break;
+		case IORESOURCE_DMA_TYPEF:
+			resource->data.dma.type = ACPI_TYPE_F;
+			break;
+		default:
+			resource->data.dma.type = ACPI_COMPATIBILITY;
+	}
+
+	switch (p->flags & IORESOURCE_DMA_TYPE_MASK) {
+		case IORESOURCE_DMA_8BIT:
+			resource->data.dma.transfer = ACPI_TRANSFER_8;
+			break;
+		case IORESOURCE_DMA_8AND16BIT:
+			resource->data.dma.transfer =
ACPI_TRANSFER_8_16;
+			break;
+		default:
+			resource->data.dma.transfer = ACPI_TRANSFER_16;
+	}
+
+	resource->data.dma.bus_master = !!(p->flags &
IORESOURCE_DMA_MASTER);
 	resource->data.dma.channel_count = 1;
 	resource->data.dma.channels[0] = p->start;
 }

-- 
Vojtech Pavlik
Director SuSE Labs
