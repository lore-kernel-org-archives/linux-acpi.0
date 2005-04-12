From: willy-6jwH94ZQLHl74goWV3ctuw@public.gmane.org (Matthew Wilcox)
Subject: [PATCH 1/2] Allow multiple GPE interrupts
Date: Tue, 12 Apr 2005 15:58:31 -0600 (MDT)
Message-ID: <20050412215831.1A7CA49677B@palinux.hppa>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, matthew-Ztpu424NOJ8@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Allow multiple GPE interrupts

If we have multiple GPE blocks, they can (and do) have independent
interrupts.  Remove the assumptions in OSL that there is only one GPE
interrupt.

Index: ./drivers/acpi/osl.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/acpi/osl.c,v
retrieving revision 1.16
diff -u -p -r1.16 osl.c
--- ./drivers/acpi/osl.c	12 Jan 2005 20:16:09 -0000	1.16
+++ ./drivers/acpi/osl.c	26 Jan 2005 19:16:52 -0000
@@ -71,9 +71,6 @@ EXPORT_SYMBOL(acpi_in_debugger);
 extern char line_buf[80];
 #endif /*ENABLE_DEBUGGER*/
 
-static unsigned int acpi_irq_irq;
-static acpi_osd_handler acpi_irq_handler;
-static void *acpi_irq_context;
 static struct workqueue_struct *kacpid_wq;
 
 acpi_status
@@ -101,13 +98,12 @@ acpi_os_initialize1(void)
 	return AE_OK;
 }
 
+static void acpi_os_remove_interrupt_handlers(void);
+
 acpi_status
 acpi_os_terminate(void)
 {
-	if (acpi_irq_handler) {
-		acpi_os_remove_interrupt_handler(acpi_irq_irq,
-						 acpi_irq_handler);
-	}
+	acpi_os_remove_interrupt_handlers();
 
 	destroy_workqueue(kacpid_wq);
 
@@ -264,50 +260,127 @@ acpi_os_table_override (struct acpi_tabl
 	return AE_OK;
 }
 
+struct acpi_dev_id {
+	acpi_osd_handler handler;
+	void *context;
+	int irq;
+	struct acpi_dev_id *next;
+};
+
 static irqreturn_t
 acpi_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
-	return (*acpi_irq_handler)(acpi_irq_context) ? IRQ_HANDLED : IRQ_NONE;
+	struct acpi_dev_id *irq_ctx = dev_id;
+	acpi_osd_handler handler = irq_ctx->handler;
+	void *context = irq_ctx->context;
+	return (*handler)(context) ? IRQ_HANDLED : IRQ_NONE;
+}
+
+struct acpi_dev_id *dev_id_list;
+
+static void *alloc_dev_id(acpi_osd_handler handler, void *context, int irq)
+{
+	struct acpi_dev_id *irq_ctx = kmalloc(sizeof(*irq_ctx), GFP_KERNEL);
+	irq_ctx->handler = handler;
+	irq_ctx->context = context;
+	irq_ctx->irq = irq;
+	irq_ctx->next = dev_id_list;
+	dev_id_list = irq_ctx;
+	return irq_ctx;
+}
+
+/*
+ * XXX: Ideally, we would match the context too, but that information
+ * isn't passed to the acpi_os_remove_interrupt_handler() function.
+ */
+static void *find_dev_id(int irq, acpi_osd_handler handler)
+{
+	struct acpi_dev_id *irq_ctx = dev_id_list;
+	for (irq_ctx = dev_id_list; irq_ctx; irq_ctx = irq_ctx->next) {
+		if ((irq_ctx->handler == handler) && (irq_ctx->irq == irq))
+			return irq_ctx;
+	}
+	printk("find_dev_id: handler %p for irq %d not found\n", handler, irq);
+	return NULL;
+}
+
+static void free_dev_id(struct acpi_dev_id *dev_id)
+{
+	struct acpi_dev_id **pprev = &dev_id_list;
+	for (;;) {
+		struct acpi_dev_id *irq_ctx = *pprev;
+		if (!irq_ctx)
+			break;
+		if (irq_ctx != dev_id) {
+			pprev = &irq_ctx->next;
+			continue;
+		}
+
+		*pprev = irq_ctx->next;
+		kfree(irq_ctx);
+		return;
+	}
+	printk("free_dev_id: dev_id %p not found\n", dev_id);
 }
 
 acpi_status
 acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler, void *context)
 {
 	unsigned int irq;
+	void *dev_id;
 
 	/*
-	 * Ignore the GSI from the core, and use the value in our copy of the
-	 * FADT. It may not be the same if an interrupt source override exists
-	 * for the SCI.
+	 * If this is the FADT interrupt, ignore the GSI from the core and
+	 * use the value in our copy of the FADT instead.  It may not be the
+	 * same if an interrupt source override exists for the SCI.
 	 */
-	gsi = acpi_fadt.sci_int;
+	if (gsi == acpi_gbl_FADT->sci_int)
+		gsi = acpi_fadt.sci_int;
+
 	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
 		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
 		       gsi);
 		return AE_OK;
 	}
 
-	acpi_irq_handler = handler;
-	acpi_irq_context = context;
-	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
+	dev_id = alloc_dev_id(handler, context, irq);
+	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", dev_id)) {
 		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
+		free_dev_id(dev_id);
 		return AE_NOT_ACQUIRED;
 	}
-	acpi_irq_irq = irq;
 
 	return AE_OK;
 }
 
 acpi_status
-acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
+acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
 {
-	if (irq) {
-		free_irq(irq, acpi_irq);
-		acpi_irq_handler = NULL;
-		acpi_irq_irq = 0;
+	int irq;
+	void *dev_id;
+
+	if (gsi == acpi_gbl_FADT->sci_int)
+		gsi = acpi_fadt.sci_int;
+
+	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
+		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
+		       gsi);
+		return AE_OK;
 	}
 
+	dev_id = find_dev_id(irq, handler);
+	free_irq(irq, dev_id);
+	free_dev_id(dev_id);
+
 	return AE_OK;
+}
+
+static void acpi_os_remove_interrupt_handlers(void)
+{
+	while (dev_id_list) {
+		acpi_os_remove_interrupt_handler(dev_id_list->irq,
+				dev_id_list->handler);
+	}
 }
 
 /*


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
