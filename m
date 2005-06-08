From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: GPE block driver update
Date: Wed, 8 Jun 2005 15:02:10 +0800
Message-ID: <200506081502.10773.luming.yu@intel.com>
Reply-To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
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
To: matthew-Ztpu424NOJ8@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi

If you missed the comments Len made for you latest gpe-block-driver patch several weeks ago.
I did it for you. The following patch is the incremental patch.

Thanks,
Luming

 Kconfig     |    4 ++--
 gpe-block.c |   24 ++++++++++++++++
 osl.c       |   21 +++++++++++
 3 files changed, 33 insertions(+), 16 deletions(-)
diff -BruN 0/drivers/acpi/gpe-block.c 1/drivers/acpi/gpe-block.c
--- 0/drivers/acpi/gpe-block.c	2005-06-08 15:21:41.000000000 +0800
+++ 1/drivers/acpi/gpe-block.c	2005-06-08 15:19:06.000000000 +0800
@@ -1,6 +1,8 @@
 /*
  * drivers/acpi/gpe-block.c
  *
+ *
+ * Copyright (c) Yu Luming for Intel 2005
  * Copyright (c) Matthew Wilcox for Hewlett Packard 2004
  *
  * This program is free software; you can redistribute it and/or modify
@@ -19,14 +21,14 @@
 
 MODULE_AUTHOR("Matthew Wilcox <willy-VXdhtT5mjnY@public.gmane.org>");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("0.3");
+MODULE_VERSION("0.4");
 
 #define NAME "gpe-block"
 
 struct gpe_block {
 	struct acpi_generic_address address;
 	u32 register_count;
-	u32 interrupt_level;
+	u32 interrupt_number;
 };
 
 static acpi_status acpi_gpe_block_crs_irq(struct acpi_resource_ext_irq *irq,
@@ -34,7 +36,7 @@
 {
 	acpi_register_gsi(irq->interrupts[0], irq->edge_level,
 			irq->active_high_low);
-	data->interrupt_level = irq->interrupts[0];
+	data->interrupt_number= irq->interrupts[0];
 	return AE_OK;
 }
 
@@ -88,15 +90,20 @@
 	if (res->id != ACPI_RSTYPE_ADDRESS16 &&
 	    res->id != ACPI_RSTYPE_ADDRESS32 &&
 	    res->id != ACPI_RSTYPE_ADDRESS64)
-		return AE_OK;
+		return AE_BAD_ADDRESS;
 
 	acpi_resource_to_address64(res, &addr);
 
 	size = addr.max_address_range - addr.min_address_range + 1;
-	if (addr.resource_type == ACPI_MEMORY_RANGE) {
+	switch (addr.resource_type) {
+	case ACPI_MEMORY_RANGE:
 		release_mem_region(addr.min_address_range, size);
-	} else if (addr.resource_type == ACPI_IO_RANGE) {
+		break;
+	case ACPI_IO_RANGE:
 		release_region(addr.min_address_range, size);
+		break;
+	default:
+		return AE_BAD_ADDRESS;
 	}
 	return AE_OK;
 }
@@ -114,7 +121,7 @@
 		return -ENODEV;
 
 	acpi_install_gpe_block(device->handle, &block.address,
-			block.register_count, block.interrupt_level);
+			block.register_count, block.interrupt_number);
 
 	return AE_OK;
 }
@@ -131,7 +138,10 @@
 	if(!obj_desc)
 		goto Exit;
 	acpi_hw_disable_gpe_block(NULL, obj_desc->device.gpe_block);
+
+	/* Wait for the work queues to flush bfore we remove block*/
 	acpi_os_sleep(1);
+
 	acpi_os_wait_events_complete(NULL);
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 			acpi_gpe_block_crs_remove, NULL);
diff -BruN 0/drivers/acpi/Kconfig 1/drivers/acpi/Kconfig
--- 0/drivers/acpi/Kconfig	2005-06-08 15:21:41.000000000 +0800
+++ 1/drivers/acpi/Kconfig	2005-06-08 15:14:30.000000000 +0800
@@ -146,10 +146,10 @@
 	  applications to perform basic fan control (on, off, status).
 
 config ACPI_GPE_BLOCK
-	tristate "GPE block"
+	bool "GPE block"
 	depends on ACPI_INTERPRETER
 	depends on !IA64_SGI_SN
-	default m
+	default n
 	help
 	  GPE block devices are used to expand the number of ACPI events
 	  available to the system.  Common uses include expansion chassis
diff -BruN 0/drivers/acpi/osl.c 1/drivers/acpi/osl.c
--- 0/drivers/acpi/osl.c	2005-06-08 15:21:35.000000000 +0800
+++ 1/drivers/acpi/osl.c	2005-06-08 15:14:09.000000000 +0800
@@ -279,16 +279,19 @@
 	return (*handler)(context) ? IRQ_HANDLED : IRQ_NONE;
 }
 
-struct acpi_dev_id *dev_id_list;
+static struct acpi_dev_id *dev_id_list;
 
 static void *alloc_dev_id(acpi_osd_handler handler, void *context, int irq)
 {
 	struct acpi_dev_id *irq_ctx = kmalloc(sizeof(*irq_ctx), GFP_KERNEL);
-	irq_ctx->handler = handler;
-	irq_ctx->context = context;
-	irq_ctx->irq = irq;
-	irq_ctx->next = dev_id_list;
-	dev_id_list = irq_ctx;
+	if (irq_ctx > 0) {
+		irq_ctx->handler = handler;
+		irq_ctx->context = context;
+		irq_ctx->irq = irq;
+		irq_ctx->next = dev_id_list;
+		dev_id_list = irq_ctx;
+	} else 
+		irq_ctx = NULL;
 	return irq_ctx;
 }
 
@@ -347,7 +350,11 @@
 	}
 
 	dev_id = alloc_dev_id(handler, context, irq);
-	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", dev_id)) {
+
+	if (!dev_id) {
+		printk(KERN_ERR PREFIX "alloc_dev_id failed\n");
+		return AE_NOT_ACQUIRED;
+	} else if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", dev_id)) {
 		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
 		free_dev_id(dev_id);
 		return AE_NOT_ACQUIRED;


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
