From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: [PATCH 4/4] allow multiple /proc/acpi/event readers
Date: Tue, 24 Aug 2004 01:39:33 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408240139.36616.dtor_core@ameritech.net>
References: <200408240134.16962.dtor_core@ameritech.net> <200408240136.46113.dtor_core@ameritech.net> <200408240137.55691.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408240137.55691.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
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


ChangeSet@1.1845, 2004-08-24 01:12:17-05:00, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
  ACPI: allow multiple readers for /proc/acpi/event, limit number
        of pending events to 64 so if reader is stuck ACPI won't
        consume all memory.
  
  Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>


 drivers/acpi/event.c      |  148 +++++++++++++++++++++-------------------------
 include/acpi/acpi_event.h |    1 
 2 files changed, 69 insertions(+), 80 deletions(-)


===================================================================



diff -Nru a/drivers/acpi/event.c b/drivers/acpi/event.c
--- a/drivers/acpi/event.c	2004-08-24 01:17:52 -05:00
+++ b/drivers/acpi/event.c	2004-08-24 01:17:52 -05:00
@@ -16,10 +16,20 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME		("event")
 
+#define ACPI_EVENT_BUFFER_SIZE	64
+struct acpi_event_reader {
+	struct acpi_bus_event	buffer[ACPI_EVENT_BUFFER_SIZE];
+	int			head, tail;
+	char			str[ACPI_MAX_STRING];
+	int			chars_remaining;
+	char			*ptr;
+	struct list_head	node;
+};
+
 DECLARE_WAIT_QUEUE_HEAD(acpi_event_queue);
-LIST_HEAD(acpi_event_list);
+static LIST_HEAD(acpi_event_reader_list);
 static spinlock_t	acpi_event_lock = SPIN_LOCK_UNLOCKED;
-static int		event_is_open;
+static int		reader_count;
 
 int
 acpi_generate_event(
@@ -27,9 +37,9 @@
 	u8			type,
 	int			data)
 {
-	struct acpi_bus_event	*event;
-	unsigned long		flags;
-	int			result = 0;
+	struct acpi_bus_event		event;
+	struct acpi_event_reader	*reader;
+	unsigned long			flags;
 
 	ACPI_FUNCTION_TRACE("acpi_generate_event");
 
@@ -38,75 +48,66 @@
 
 	spin_lock_irqsave(&acpi_event_lock, flags);
 
-	/* drop event on the floor if no one's listening */
-	if (!event_is_open)
-		goto out;
-
-	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
-	if (!event) {
-		result = -ENOMEM;
-		goto out;
+	strcpy(event.device_class, device->pnp.device_class);
+	strcpy(event.bus_id, device->pnp.bus_id);
+	event.type = type;
+	event.data = data;
+
+	list_for_each_entry(reader, &acpi_event_reader_list, node) {
+		reader->buffer[reader->head] = event;
+		reader->head = (reader->head + 1) & (ACPI_EVENT_BUFFER_SIZE - 1);
 	}
+	spin_unlock_irqrestore(&acpi_event_lock, flags);
 
-	strcpy(event->device_class, device->pnp.device_class);
-	strcpy(event->bus_id, device->pnp.bus_id);
-	event->type = type;
-	event->data = data;
-
-	list_add_tail(&event->node, &acpi_event_list);
 	wake_up_interruptible(&acpi_event_queue);
 
-out:
-	spin_unlock_irqrestore(&acpi_event_lock, flags);
-	return_VALUE(result);
+	return_VALUE(0);
 }
 
-static struct acpi_bus_event *acpi_fetch_event(void)
+static void acpi_fetch_event(struct acpi_event_reader *reader)
 {
-	struct acpi_bus_event	*event = NULL;
+	struct acpi_bus_event	*event;
 	unsigned long		flags;
 
 	ACPI_FUNCTION_TRACE("acpi_fetch_event");
 
 	spin_lock_irqsave(&acpi_event_lock, flags);
 
-	if (!list_empty(&acpi_event_list)) {
-		event = list_entry(acpi_event_list.next,
-				   struct acpi_bus_event, node);
-		list_del(&event->node);
+	if (reader->head != reader->tail) {
+		event = &reader->buffer[reader->tail];
+		reader->tail = (reader->tail + 1) & (ACPI_EVENT_BUFFER_SIZE - 1);
+
+		reader->chars_remaining =
+			snprintf(reader->str, ACPI_MAX_STRING,
+				"%s %s %08x %08x\n",
+				event->device_class ?
+					event->device_class : "<unknown>",
+				event->bus_id ? event->bus_id : "<unknown>",
+				event->type, event->data);
+
 	}
 
 	spin_unlock_irqrestore(&acpi_event_lock, flags);
 
-	return_PTR(event);
+	return_VOID;
 }
 
 static int
 acpi_system_open_event(struct inode *inode, struct file *file)
 {
-	int rc = 0;
-
-	spin_lock_irq(&acpi_event_lock);
+	struct acpi_event_reader	*reader;
 
-	if (event_is_open) {
-		rc = -EBUSY;
-		goto out;
-	}
+	if (!(reader = kmalloc(sizeof(struct acpi_event_reader), GFP_KERNEL)))
+		return -ENOMEM;
 
-	event_is_open = 1;
+	memset(reader, 0, sizeof(struct acpi_event_reader));
+	file->private_data = reader;
 
-out:
+	spin_lock_irq(&acpi_event_lock);
+	list_add_tail(&reader->node, &acpi_event_reader_list);
+	reader_count++;
 	spin_unlock_irq(&acpi_event_lock);
-	return rc;
-}
-
-static inline int
-event_to_string(struct acpi_bus_event *event, char *buffer)
-{
-	return sprintf(buffer, "%s %s %08x %08x\n",
-		       event->device_class ? event->device_class : "<unknown>",
-		       event->bus_id ? event->bus_id : "<unknown>",
-		       event->type, event->data);
+	return 0;
 }
 
 static ssize_t
@@ -116,42 +117,33 @@
 	size_t			count,
 	loff_t			*ppos)
 {
-	int			result;
-	struct acpi_bus_event	*event;
-	static char		str[ACPI_MAX_STRING];
-	static int		chars_remaining;
-	static char		*ptr;
-
+	struct acpi_event_reader	*reader = file->private_data;
+	int				result;
 
 	ACPI_FUNCTION_TRACE("acpi_system_read_event");
 
-	if (!chars_remaining) {
-		if (list_empty(&acpi_event_list) &&
-		    (file->f_flags & O_NONBLOCK))
+	if (reader->chars_remaining == 0) {
+		if (reader->head == reader->tail && (file->f_flags & O_NONBLOCK))
 			return_VALUE(-EAGAIN);
 
 		result = wait_event_interruptible(acpi_event_queue,
-					!list_empty(&acpi_event_list));
+						  reader->head != reader->tail);
 		if (result)
 			return_VALUE(result);
 
-		if ((event = acpi_fetch_event()) == NULL)
-			return_VALUE(0);
-
-		chars_remaining = event_to_string(event, str);
-		ptr = str;
-		kfree(event);
+		acpi_fetch_event(reader);
+		reader->ptr = reader->str;
 	}
 
-	if (chars_remaining < count)
-		count = chars_remaining;
+	if (reader->chars_remaining < count)
+		count = reader->chars_remaining;
 
-	if (copy_to_user(buffer, ptr, count))
+	if (copy_to_user(buffer, reader->ptr, count))
 		return_VALUE(-EFAULT);
 
 	*ppos += count;
-	chars_remaining -= count;
-	ptr += count;
+	reader->chars_remaining -= count;
+	reader->ptr += count;
 
 	return_VALUE(count);
 }
@@ -159,19 +151,15 @@
 static int
 acpi_system_close_event(struct inode *inode, struct file *file)
 {
-	struct acpi_bus_event *event, *next;
+	struct acpi_event_reader *reader = file->private_data;
 
 	spin_lock_irq(&acpi_event_lock);
+	list_del(&reader->node);
+	reader_count--;
+	spin_unlock_irq(&acpi_event_lock);
 
-	/* We won't be interested in old events, will we? */
-	list_for_each_entry_safe(event, next, &acpi_event_list, node) {
-		list_del(&event->node);
-		kfree(event);
-	}
-
-	event_is_open = 0;
+	kfree(reader);
 
-	spin_unlock_irq(&acpi_event_lock);
 	return 0;
 }
 
@@ -180,8 +168,10 @@
 	struct file		*file,
 	poll_table		*wait)
 {
+	struct acpi_event_reader *reader = file->private_data;
+
 	poll_wait(file, &acpi_event_queue, wait);
-	if (!list_empty(&acpi_event_list))
+	if (reader->head != reader->tail)
 		return POLLIN | POLLRDNORM;
 	return 0;
 }
diff -Nru a/include/acpi/acpi_event.h b/include/acpi/acpi_event.h
--- a/include/acpi/acpi_event.h	2004-08-24 01:17:52 -05:00
+++ b/include/acpi/acpi_event.h	2004-08-24 01:17:52 -05:00
@@ -31,7 +31,6 @@
 #include <acpi/acpi_bus.h>
 
 struct acpi_bus_event {
-	struct list_head	node;
 	acpi_device_class	device_class;
 	acpi_bus_id		bus_id;
 	u32			type;


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
