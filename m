From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] resend, early ACPI init
Date: Tue, 15 Feb 2005 13:02:59 -0700
Message-ID: <1108497779.7373.24.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


   This is a resend of the patch to allow ACPI namespace to be
initialized early in boot.  I originally only sent it out to the list,
so it likely got lost in the noise.  There are many uses for ACPI early
on, but the one I'm most interested in is allowing early platform
support code to discover chipset components, such as iommus, before it
has to make decisions on how memory zone are initialized (some chipsets
don't show up in PCI space).

  This patch is essentially a resurrection and update of similar code
that used to live in the ia64-linux patch back around 2.4.17.  The
seemingly extraneous chunk in evxfevnt.c below simply prevents an error
message when terminating ACPI on platforms that do not support mode
transitions.  The CONFIG_ACPI_EARLY_BOOT option can be defined for
platforms needing this functionality.  Thanks,

	Alex
   
-- 
Signed-off-by: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>

===== drivers/acpi/osl.c 1.64 vs edited =====
--- 1.64/drivers/acpi/osl.c	2004-12-23 06:09:11 -07:00
+++ edited/drivers/acpi/osl.c	2005-01-27 14:58:23 -07:00
@@ -26,6 +26,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/bootmem.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -40,6 +41,7 @@
 #include <acpi/acpi.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
+#include <acpi/acpiosxf.h>
 #include <acpi/processor.h>
 #include <asm/uaccess.h>
 
@@ -102,7 +104,7 @@
 }
 
 acpi_status
-acpi_os_terminate(void)
+acpi_os_terminate_rt(void)
 {
 	if (acpi_irq_handler) {
 		acpi_os_remove_interrupt_handler(acpi_irq_irq,
@@ -143,17 +145,16 @@
 }
 
 void *
-acpi_os_allocate(acpi_size size)
+acpi_os_allocate_rt(acpi_size size)
 {
 	return kmalloc(size, GFP_KERNEL);
 }
 
 void
-acpi_os_free(void *ptr)
+acpi_os_free_rt(void *ptr)
 {
 	kfree(ptr);
 }
-EXPORT_SYMBOL(acpi_os_free);
 
 acpi_status
 acpi_os_get_root_pointer(u32 flags, struct acpi_pointer *addr)
@@ -323,7 +324,7 @@
 EXPORT_SYMBOL(acpi_os_sleep);
 
 void
-acpi_os_stall(u32 us)
+acpi_os_stall_rt(u32 us)
 {
 	while (us) {
 		u32 delay = 1000;
@@ -335,7 +336,6 @@
 		us -= delay;
 	}
 }
-EXPORT_SYMBOL(acpi_os_stall);
 
 /*
  * Support ACPI 3.0 AML Timer operand
@@ -681,7 +681,7 @@
 }
 
 acpi_status
-acpi_os_queue_for_execution(
+acpi_os_queue_for_execution_rt(
 	u32			priority,
 	acpi_osd_exec_callback	function,
 	void			*context)
@@ -726,7 +726,6 @@
 
 	return_ACPI_STATUS (status);
 }
-EXPORT_SYMBOL(acpi_os_queue_for_execution);
 
 void
 acpi_os_wait_events_complete(
@@ -1070,6 +1069,197 @@
 	return AE_OK;
 }
 EXPORT_SYMBOL(acpi_os_signal);
+
+/*
+ * Run time OS interfaces
+ */
+struct acpi_osd {
+	void		*(*allocate)(acpi_size size);
+	void		(*free)(void *ptr);
+	acpi_status	(*queue_for_execution)(u32 priority,
+	                                       acpi_osd_exec_callback function,
+						void *context);
+	void		(*stall)(u32 us);
+	acpi_status	(*terminate)(void);
+};
+
+static struct acpi_osd acpi_osd_rt = {
+	acpi_os_allocate_rt,
+	acpi_os_free_rt,
+	acpi_os_queue_for_execution_rt,
+	acpi_os_stall_rt,
+	acpi_os_terminate_rt
+};
+
+static struct acpi_osd *acpi_osd = &acpi_osd_rt;
+
+void *
+acpi_os_allocate(acpi_size size)
+{
+	return acpi_osd->allocate(size);
+}
+
+void
+acpi_os_free(void *ptr)
+{
+	acpi_osd->free(ptr);
+}
+EXPORT_SYMBOL(acpi_os_free);
+
+void
+acpi_os_stall(u32 us)
+{
+	if (acpi_osd->stall)
+		acpi_osd->stall(us);
+	else
+		printk(KERN_ERR PREFIX "acpi_os_stall() uninitialized\n");
+}
+EXPORT_SYMBOL(acpi_os_stall);
+
+acpi_status
+acpi_os_queue_for_execution(
+	u32			priority,
+	acpi_osd_exec_callback	function,
+	void			*context)
+{
+	return acpi_osd->queue_for_execution(priority, function, context);
+}
+EXPORT_SYMBOL(acpi_os_queue_for_execution);
+
+acpi_status
+acpi_os_terminate(void)
+{
+	return acpi_osd->terminate();
+}
+
+#ifdef CONFIG_ACPI_EARLY_BOOT
+/*
+ * Boot time OS interfaces
+ */
+static void * __init
+acpi_os_allocate_bt(acpi_size size)
+{
+	void	*ptr;
+
+	size += sizeof(unsigned long);
+	ptr = alloc_bootmem(size);
+
+	if (ptr) {
+		*((unsigned long *)ptr) = (unsigned long)size;
+		ptr += sizeof(unsigned long);
+	}
+
+	return ptr;
+}
+
+static void __init
+acpi_os_free_bt(void *ptr)
+{
+	unsigned long	size;
+
+	ptr -= sizeof(size);
+	size = *((unsigned long *)ptr);
+
+	free_bootmem(__pa((unsigned long)ptr), (u32)size);
+}
+
+static acpi_status __init
+acpi_os_queue_for_execution_bt(
+	u32			priority,
+	acpi_osd_exec_callback	function,
+	void			*context)
+{
+	/* run callback immediately */
+	(*function)(context);
+	return AE_OK;
+}
+
+static acpi_status __init
+acpi_os_terminate_bt(void)
+{
+	return AE_OK;
+}
+
+static struct acpi_osd acpi_osd_bt __initdata = {
+	acpi_os_allocate_bt,
+	acpi_os_free_bt,
+	acpi_os_queue_for_execution_bt,
+	NULL, /* Need stall routine provided */
+	acpi_os_terminate_bt
+};
+
+static int	acpi_bt_initialized __initdata = 0;
+
+#define ACPI_BT_INITIALIZED()   (acpi_bt_initialized > 0)
+
+acpi_status __init
+acpi_bt_init(acpi_os_stall_t stall)
+{
+	acpi_status	status;
+
+	if (ACPI_BT_INITIALIZED())
+		return AE_OK;
+
+	acpi_osd_bt.stall = (void *)stall;
+	acpi_osd = &acpi_osd_bt;
+
+	status = acpi_initialize_subsystem();
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "Unable to initialize the boot time "
+		                       "ACPI Interpreter\n");
+		return status;
+	}
+
+	status = acpi_load_tables();
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "Unable to load the System Description "
+		                       "Tables\n");
+		return status;
+	}
+
+	status = acpi_enable_subsystem(ACPI_NO_HANDLER_INIT);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "Unable to enable ACPI subsystem\n");
+		return status;
+	}
+
+	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "Unable to initialize ACPI objects\n");
+		return status;
+	}
+
+	acpi_bt_initialized++;
+
+	return AE_OK;
+}
+
+acpi_status __init
+acpi_bt_terminate(void)
+{
+	acpi_status	status;
+
+	if (!ACPI_BT_INITIALIZED())
+		return AE_OK;
+
+	status = acpi_disable();
+	if (ACPI_FAILURE(status)) {
+		/* fall thru... */
+	}
+
+	status = acpi_terminate();
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "Unable to terminate boot time ACPI\n");
+		/* fall thru... */
+	}
+
+	acpi_osd_bt.stall = NULL;
+	acpi_osd = &acpi_osd_rt;
+	acpi_bt_initialized--;
+
+	return status;
+}
+#endif /* CONFIG_ACPI_EARLY_BOOT */
 
 int __init
 acpi_os_name_setup(char *str)
===== drivers/acpi/events/evxfevnt.c 1.25 vs edited =====
--- 1.25/drivers/acpi/events/evxfevnt.c	2004-12-05 22:09:54 -07:00
+++ edited/drivers/acpi/events/evxfevnt.c	2005-01-24 16:49:11 -07:00
@@ -127,7 +127,7 @@
 	if (acpi_hw_get_mode() == ACPI_SYS_MODE_LEGACY) {
 		ACPI_DEBUG_PRINT ((ACPI_DB_INIT, "System is already in legacy (non-ACPI) mode\n"));
 	}
-	else {
+	else if (acpi_gbl_FADT->smi_cmd) {
 		/* Transition to LEGACY mode */
 
 		status = acpi_hw_set_mode (ACPI_SYS_MODE_LEGACY);
===== include/acpi/acpiosxf.h 1.38 vs edited =====
--- 1.38/include/acpi/acpiosxf.h	2004-11-11 23:29:47 -07:00
+++ edited/include/acpi/acpiosxf.h	2005-01-27 14:05:09 -07:00
@@ -385,5 +385,18 @@
 	u32                             line_number,
 	char                            *message);
 
+#ifdef CONFIG_ACPI_EARLY_BOOT
+
+typedef void *(acpi_os_stall_t)(u32 us);
+
+acpi_status
+acpi_bt_init (
+	acpi_os_stall_t			stall);
+
+acpi_status
+acpi_bt_terminate (
+	void);
+
+#endif /* CONFIG_ACPI_EARLY_BOOT */
 
 #endif /* __ACPIOSXF_H__ */




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
