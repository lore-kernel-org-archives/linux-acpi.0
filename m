From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: [PATCH 2/4] event code fixes/cleanup
Date: Tue, 24 Aug 2004 01:36:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408240136.46113.dtor_core@ameritech.net>
References: <200408240134.16962.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408240134.16962.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Len Brown <len.brow-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


===================================================================


ChangeSet@1.1843, 2004-08-24 01:11:02-05:00, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
  ACPI: Move event handling code from bus.c into event.c to cut down
        amount of exported implementation details. Also:
  
        - when closing /proc/acpi/event drop all events that have not
          been read yet so next time it is opened userspace is not fed
          old events;
        - do not reimplement wait_event_interruptible, just use it;
        - do not return -EIO if an event is 'stolen', 0 is proper return
          code;
        - tidy up read procedure (ensure that list is not empty before
          fetching next event)
  
  Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>


 drivers/acpi/Makefile     |    4 -
 drivers/acpi/ac.c         |    4 -
 drivers/acpi/acpi_ksyms.c |    9 +-
 drivers/acpi/asus_acpi.c  |    5 -
 drivers/acpi/battery.c    |    3 
 drivers/acpi/bus.c        |   94 ----------------------------
 drivers/acpi/button.c     |    4 -
 drivers/acpi/event.c      |  152 ++++++++++++++++++++++++++++++++++------------
 drivers/acpi/processor.c  |    7 +-
 drivers/acpi/thermal.c    |    9 +-
 include/acpi/acpi_bus.h   |   16 ----
 include/acpi/acpi_event.h |   47 ++++++++++++++
 12 files changed, 190 insertions(+), 164 deletions(-)


===================================================================



diff -Nru a/drivers/acpi/Makefile b/drivers/acpi/Makefile
--- a/drivers/acpi/Makefile	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/Makefile	2004-08-24 01:16:54 -05:00
@@ -32,7 +32,7 @@
 # ACPI Bus and Device Drivers
 #
 obj-$(CONFIG_ACPI_BUS)		+= sleep/
-obj-$(CONFIG_ACPI_BUS)		+= bus.o
+obj-$(CONFIG_ACPI_BUS)		+= bus.o event.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
@@ -42,7 +42,7 @@
 obj-$(CONFIG_ACPI_POWER)	+= power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
+obj-$(CONFIG_ACPI_SYSTEM)	+= system.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
diff -Nru a/drivers/acpi/ac.c b/drivers/acpi/ac.c
--- a/drivers/acpi/ac.c	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/ac.c	2004-08-24 01:16:54 -05:00
@@ -29,7 +29,9 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+
 #include <acpi/acpi_bus.h>
+#include <acpi/acpi_event.h>
 #include <acpi/acpi_drivers.h>
 
 
@@ -220,7 +222,7 @@
 	switch (event) {
 	case ACPI_AC_NOTIFY_STATUS:
 		acpi_ac_get_state(ac);
-		acpi_bus_generate_event(device, event, (u32) ac->state);
+		acpi_generate_event(device, event, (u32) ac->state);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff -Nru a/drivers/acpi/acpi_ksyms.c b/drivers/acpi/acpi_ksyms.c
--- a/drivers/acpi/acpi_ksyms.c	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/acpi_ksyms.c	2004-08-24 01:16:54 -05:00
@@ -27,6 +27,7 @@
 #include <linux/acpi.h>
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
+#include <acpi/acpi_event.h>
 
 
 #ifdef CONFIG_ACPI_INTERPRETER
@@ -120,10 +121,11 @@
 #endif /*CONFIG_ACPI_INTERPRETER*/
 
 
-/* ACPI Bus Driver (acpi_bus.c) */
+/* ACPI Bus Driver */
 
 #ifdef CONFIG_ACPI_BUS
 
+/* bus.c */
 EXPORT_SYMBOL(acpi_fadt);
 EXPORT_SYMBOL(acpi_walk_namespace);
 EXPORT_SYMBOL(acpi_root_dir);
@@ -131,10 +133,11 @@
 EXPORT_SYMBOL(acpi_bus_get_status);
 EXPORT_SYMBOL(acpi_bus_get_power);
 EXPORT_SYMBOL(acpi_bus_set_power);
-EXPORT_SYMBOL(acpi_bus_generate_event);
-EXPORT_SYMBOL(acpi_bus_receive_event);
 EXPORT_SYMBOL(acpi_bus_register_driver);
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
+
+/* event.c */
+EXPORT_SYMBOL(acpi_generate_event);
 
 #endif /*CONFIG_ACPI_BUS*/
 
diff -Nru a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/asus_acpi.c	2004-08-24 01:16:54 -05:00
@@ -40,6 +40,7 @@
 #include <linux/proc_fs.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
+#include <acpi/acpi_event.h>
 #include <asm/uaccess.h>
 
 #define ASUS_ACPI_VERSION "0.28"
@@ -949,8 +950,8 @@
 		hotk->brightness = (event & ~((u32) BR_DOWN));
 	}
 
-	acpi_bus_generate_event(hotk->device, event,
-				hotk->event_count[event % 128]++);
+	acpi_generate_event(hotk->device, event,
+			    hotk->event_count[event % 128]++);
 
 	return;
 }
diff -Nru a/drivers/acpi/battery.c b/drivers/acpi/battery.c
--- a/drivers/acpi/battery.c	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/battery.c	2004-08-24 01:16:54 -05:00
@@ -31,6 +31,7 @@
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
+#include <acpi/acpi_event.h>
 #include <acpi/acpi_drivers.h>
 
 
@@ -719,7 +720,7 @@
 	case ACPI_BATTERY_NOTIFY_STATUS:
 	case ACPI_BATTERY_NOTIFY_INFO:
 		acpi_battery_check(battery);
-		acpi_bus_generate_event(device, event, battery->flags.present);
+		acpi_generate_event(device, event, battery->flags.present);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff -Nru a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/bus.c	2004-08-24 01:16:54 -05:00
@@ -272,100 +272,6 @@
 }
 
 
-
-/* --------------------------------------------------------------------------
-                                Event Management
-   -------------------------------------------------------------------------- */
-
-static spinlock_t		acpi_bus_event_lock = SPIN_LOCK_UNLOCKED;
-
-LIST_HEAD(acpi_bus_event_list);
-DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_queue);
-
-extern int			event_is_open;
-
-int
-acpi_bus_generate_event (
-	struct acpi_device	*device,
-	u8			type,
-	int			data)
-{
-	struct acpi_bus_event	*event = NULL;
-	unsigned long		flags = 0;
-
-	ACPI_FUNCTION_TRACE("acpi_bus_generate_event");
-
-	if (!device)
-		return_VALUE(-EINVAL);
-
-	/* drop event on the floor if no one's listening */
-	if (!event_is_open)
-		return_VALUE(0);
-
-	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
-	if (!event)
-		return_VALUE(-ENOMEM);
-
-	strcpy(event->device_class, device->pnp.device_class);
-	strcpy(event->bus_id, device->pnp.bus_id);
-	event->type = type;
-	event->data = data;
-
-	spin_lock_irqsave(&acpi_bus_event_lock, flags);
-	list_add_tail(&event->node, &acpi_bus_event_list);
-	spin_unlock_irqrestore(&acpi_bus_event_lock, flags);
-
-	wake_up_interruptible(&acpi_bus_event_queue);
-
-	return_VALUE(0);
-}
-
-int
-acpi_bus_receive_event (
-	struct acpi_bus_event	*event)
-{
-	unsigned long		flags = 0;
-	struct acpi_bus_event	*entry = NULL;
-
-	DECLARE_WAITQUEUE(wait, current);
-
-	ACPI_FUNCTION_TRACE("acpi_bus_receive_event");
-
-	if (!event)
-		return -EINVAL;
-
-	if (list_empty(&acpi_bus_event_list)) {
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&acpi_bus_event_queue, &wait);
-
-		if (list_empty(&acpi_bus_event_list))
-			schedule();
-
-		remove_wait_queue(&acpi_bus_event_queue, &wait);
-		set_current_state(TASK_RUNNING);
-
-		if (signal_pending(current))
-			return_VALUE(-ERESTARTSYS);
-	}
-
-	spin_lock_irqsave(&acpi_bus_event_lock, flags);
-	entry = list_entry(acpi_bus_event_list.next, struct acpi_bus_event, node);
-	if (entry)
-		list_del(&entry->node);
-	spin_unlock_irqrestore(&acpi_bus_event_lock, flags);
-
-	if (!entry)
-		return_VALUE(-ENODEV);
-
-	memcpy(event, entry, sizeof(struct acpi_bus_event));
-
-	kfree(entry);
-
-	return_VALUE(0);
-}
-
-
 /* --------------------------------------------------------------------------
                              Notification Handling
    -------------------------------------------------------------------------- */
diff -Nru a/drivers/acpi/button.c b/drivers/acpi/button.c
--- a/drivers/acpi/button.c	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/button.c	2004-08-24 01:16:54 -05:00
@@ -29,7 +29,9 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+
 #include <acpi/acpi_bus.h>
+#include <acpi/acpi_event.h>
 #include <acpi/acpi_drivers.h>
 
 
@@ -290,7 +292,7 @@
 
 	switch (event) {
 	case ACPI_BUTTON_NOTIFY_STATUS:
-		acpi_bus_generate_event(button->device, event, ++button->pushed);
+		acpi_generate_event(button->device, event, ++button->pushed);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff -Nru a/drivers/acpi/event.c b/drivers/acpi/event.c
--- a/drivers/acpi/event.c	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/event.c	2004-08-24 01:16:54 -05:00
@@ -10,73 +10,141 @@
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/poll.h>
+#include <acpi/acpi_event.h>
 #include <acpi/acpi_drivers.h>
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME		("event")
 
-/* Global vars for handling event proc entry */
-static spinlock_t		acpi_system_event_lock = SPIN_LOCK_UNLOCKED;
-int				event_is_open = 0;
-extern struct list_head		acpi_bus_event_list;
-extern wait_queue_head_t	acpi_bus_event_queue;
+DECLARE_WAIT_QUEUE_HEAD(acpi_event_queue);
+LIST_HEAD(acpi_event_list);
+static spinlock_t	acpi_event_lock = SPIN_LOCK_UNLOCKED;
+static int		event_is_open;
+
+int
+acpi_generate_event(
+	struct acpi_device	*device,
+	u8			type,
+	int			data)
+{
+	struct acpi_bus_event	*event;
+	unsigned long		flags;
+	int			result = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_generate_event");
+
+	if (!device)
+		return_VALUE(-EINVAL);
+
+	spin_lock_irqsave(&acpi_event_lock, flags);
+
+	/* drop event on the floor if no one's listening */
+	if (!event_is_open)
+		goto out;
+
+	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
+	if (!event) {
+		result = -ENOMEM;
+		goto out;
+	}
+
+	strcpy(event->device_class, device->pnp.device_class);
+	strcpy(event->bus_id, device->pnp.bus_id);
+	event->type = type;
+	event->data = data;
+
+	list_add_tail(&event->node, &acpi_event_list);
+	wake_up_interruptible(&acpi_event_queue);
+
+out:
+	spin_unlock_irqrestore(&acpi_event_lock, flags);
+	return_VALUE(result);
+}
+
+static struct acpi_bus_event *acpi_fetch_event(void)
+{
+	struct acpi_bus_event	*event = NULL;
+	unsigned long		flags;
+
+	ACPI_FUNCTION_TRACE("acpi_fetch_event");
+
+	spin_lock_irqsave(&acpi_event_lock, flags);
+
+	if (!list_empty(&acpi_event_list)) {
+		event = list_entry(acpi_event_list.next,
+				   struct acpi_bus_event, node);
+		list_del(&event->node);
+	}
+
+	spin_unlock_irqrestore(&acpi_event_lock, flags);
+
+	return_PTR(event);
+}
 
 static int
 acpi_system_open_event(struct inode *inode, struct file *file)
 {
-	spin_lock_irq (&acpi_system_event_lock);
+	int rc = 0;
 
-	if(event_is_open)
-		goto out_busy;
+	spin_lock_irq(&acpi_event_lock);
+
+	if (event_is_open) {
+		rc = -EBUSY;
+		goto out;
+	}
 
 	event_is_open = 1;
 
-	spin_unlock_irq (&acpi_system_event_lock);
-	return 0;
+out:
+	spin_unlock_irq(&acpi_event_lock);
+	return rc;
+}
 
-out_busy:
-	spin_unlock_irq (&acpi_system_event_lock);
-	return -EBUSY;
+static inline int
+event_to_string(struct acpi_bus_event *event, char *buffer)
+{
+	return sprintf(buffer, "%s %s %08x %08x\n",
+		       event->device_class ? event->device_class : "<unknown>",
+		       event->bus_id ? event->bus_id : "<unknown>",
+		       event->type, event->data);
 }
 
 static ssize_t
-acpi_system_read_event (
+acpi_system_read_event(
 	struct file		*file,
 	char			__user *buffer,
 	size_t			count,
 	loff_t			*ppos)
 {
-	int			result = 0;
-	struct acpi_bus_event	event;
+	int			result;
+	struct acpi_bus_event	*event;
 	static char		str[ACPI_MAX_STRING];
-	static int		chars_remaining = 0;
+	static int		chars_remaining;
 	static char		*ptr;
 
 
 	ACPI_FUNCTION_TRACE("acpi_system_read_event");
 
 	if (!chars_remaining) {
-		memset(&event, 0, sizeof(struct acpi_bus_event));
-
-		if ((file->f_flags & O_NONBLOCK)
-		    && (list_empty(&acpi_bus_event_list)))
+		if (list_empty(&acpi_event_list) &&
+		    (file->f_flags & O_NONBLOCK))
 			return_VALUE(-EAGAIN);
 
-		result = acpi_bus_receive_event(&event);
-		if (result) {
-			return_VALUE(-EIO);
-		}
-
-		chars_remaining = sprintf(str, "%s %s %08x %08x\n", 
-			event.device_class?event.device_class:"<unknown>",
-			event.bus_id?event.bus_id:"<unknown>", 
-			event.type, event.data);
+		result = wait_event_interruptible(acpi_event_queue,
+					!list_empty(&acpi_event_list));
+		if (result)
+			return_VALUE(result);
+
+		if ((event = acpi_fetch_event()) == NULL)
+			return_VALUE(0);
+
+		chars_remaining = event_to_string(event, str);
 		ptr = str;
+		kfree(event);
 	}
 
-	if (chars_remaining < count) {
+	if (chars_remaining < count)
 		count = chars_remaining;
-	}
 
 	if (copy_to_user(buffer, ptr, count))
 		return_VALUE(-EFAULT);
@@ -91,9 +159,19 @@
 static int
 acpi_system_close_event(struct inode *inode, struct file *file)
 {
-	spin_lock_irq (&acpi_system_event_lock);
+	struct acpi_bus_event *event, *next;
+
+	spin_lock_irq(&acpi_event_lock);
+
+	/* We won't be interested in old events, will we? */
+	list_for_each_entry_safe(event, next, &acpi_event_list, node) {
+		list_del(&event->node);
+		kfree(event);
+	}
+
 	event_is_open = 0;
-	spin_unlock_irq (&acpi_system_event_lock);
+
+	spin_unlock_irq(&acpi_event_lock);
 	return 0;
 }
 
@@ -102,8 +180,8 @@
 	struct file		*file,
 	poll_table		*wait)
 {
-	poll_wait(file, &acpi_bus_event_queue, wait);
-	if (!list_empty(&acpi_bus_event_list))
+	poll_wait(file, &acpi_event_queue, wait);
+	if (!list_empty(&acpi_event_list))
 		return POLLIN | POLLRDNORM;
 	return 0;
 }
@@ -130,7 +208,7 @@
 	if (entry)
 		entry->proc_fops = &acpi_system_event_ops;
 	else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Unable to create '%s' proc fs entry\n","event" ));
 		error = -EFAULT;
 	}
diff -Nru a/drivers/acpi/processor.c b/drivers/acpi/processor.c
--- a/drivers/acpi/processor.c	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/processor.c	2004-08-24 01:16:54 -05:00
@@ -50,6 +50,7 @@
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/acpi_event.h>
 #include <acpi/processor.h>
 
 
@@ -2312,12 +2313,12 @@
 	switch (event) {
 	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
 		acpi_processor_ppc_has_changed(pr);
-		acpi_bus_generate_event(device, event, 
-			pr->performance_platform_limit);
+		acpi_generate_event(device, event,
+				    pr->performance_platform_limit);
 		break;
 	case ACPI_PROCESSOR_NOTIFY_POWER:
 		/* TBD */
-		acpi_bus_generate_event(device, event, 0);
+		acpi_generate_event(device, event, 0);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff -Nru a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c	2004-08-24 01:16:54 -05:00
+++ b/drivers/acpi/thermal.c	2004-08-24 01:16:54 -05:00
@@ -42,6 +42,7 @@
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
+#include <acpi/acpi_event.h>
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_THERMAL_COMPONENT		0x04000000
@@ -469,7 +470,7 @@
 		return_VALUE(result);
 
 	printk(KERN_EMERG "Critical temperature reached (%ld C), shutting down.\n", KELVIN_TO_CELSIUS(tz->temperature));
-	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
+	acpi_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
 
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
 
@@ -500,7 +501,7 @@
 	if (result)
 		return_VALUE(result);
 
-	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_HOT, tz->trips.hot.flags.enabled);
+	acpi_generate_event(device, ACPI_THERMAL_NOTIFY_HOT, tz->trips.hot.flags.enabled);
 
 	/* TBD: Call user-mode "sleep(S4)" function */
 
@@ -1199,12 +1200,12 @@
 	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
 		acpi_thermal_get_trip_points(tz);
 		acpi_thermal_check(tz);
-		acpi_bus_generate_event(device, event, 0);
+		acpi_generate_event(device, event, 0);
 		break;
 	case ACPI_THERMAL_NOTIFY_DEVICES:
 		if (tz->flags.devices)
 			acpi_thermal_get_devices(tz);
-		acpi_bus_generate_event(device, event, 0);
+		acpi_generate_event(device, event, 0);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff -Nru a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
--- a/include/acpi/acpi_bus.h	2004-08-24 01:16:54 -05:00
+++ b/include/acpi/acpi_bus.h	2004-08-24 01:16:54 -05:00
@@ -293,20 +293,6 @@
 
 #define acpi_driver_data(d)	((d)->driver_data)
 
-
-/*
- * Events
- * ------
- */
-
-struct acpi_bus_event {
-	struct list_head	node;
-	acpi_device_class	device_class;
-	acpi_bus_id		bus_id;
-	u32			type;
-	u32			data;
-};
-
 extern struct subsystem acpi_subsys;
 
 /*
@@ -317,8 +303,6 @@
 int acpi_bus_get_status (struct acpi_device *device);
 int acpi_bus_get_power (acpi_handle handle, int *state);
 int acpi_bus_set_power (acpi_handle handle, int state);
-int acpi_bus_generate_event (struct acpi_device *device, u8 type, int data);
-int acpi_bus_receive_event (struct acpi_bus_event *event);
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
 
diff -Nru a/include/acpi/acpi_event.h b/include/acpi/acpi_event.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/acpi/acpi_event.h	2004-08-24 01:16:54 -05:00
@@ -0,0 +1,47 @@
+/*
+ *  acpi_event.h - ACPI events to user space
+ *
+ *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#ifndef __ACPI_EVENT_H__
+#define __ACPI_EVENT_H__
+
+#include <linux/kobject.h>
+
+#include <acpi/acpi_bus.h>
+
+struct acpi_bus_event {
+	struct list_head	node;
+	acpi_device_class	device_class;
+	acpi_bus_id		bus_id;
+	u32			type;
+	u32			data;
+};
+
+/*
+ * External Functions
+ */
+
+int acpi_generate_event(struct acpi_device *device, u8 type, int data);
+
+#endif /*__ACPI_EVENT_H__*/


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
