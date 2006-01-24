From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/2] Support multiple readers for /proc/acpi/event.
Date: Wed, 25 Jan 2006 00:14:28 +0100
Message-ID: <1138144468745-git-send-email-malattia@linux.it>
References: <1138144468374-git-send-email-malattia@linux.it>
Reply-To: Mattia Dongili <malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:32472 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750823AbWAXXNi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jan 2006 18:13:38 -0500
In-Reply-To: <1138144468374-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Mattia Dongili <malattia@linux.it>

[PATCH 2/2] Support multiple readers for /proc/acpi/event.

Each reader registers itself as an ACPI Event listener to get
notified of events.

Signed-off-by: Mattia Dongili <malattia@linux.it>


---

 drivers/acpi/event.c |   83 +++++++++++++++++++++++++++-----------------------
 1 files changed, 45 insertions(+), 38 deletions(-)

05c7c439c5c09f3f690144e79824b24329121e91
diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 2dbb1b0..ffb6835 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -15,87 +15,93 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("event")
 
+struct acpi_event_reader {
+	char	str[ACPI_MAX_STRING];
+	int	chars_remaining;
+	char	*ptr;
+	struct	acpi_event_listener listener;
+};
+
 /* Global vars for handling event proc entry */
-static DEFINE_SPINLOCK(acpi_system_event_lock);
-int event_is_open = 0;
-extern struct list_head acpi_bus_event_list;
 extern wait_queue_head_t acpi_bus_event_queue;
 
 static int acpi_system_open_event(struct inode *inode, struct file *file)
 {
-	spin_lock_irq(&acpi_system_event_lock);
+	struct acpi_event_reader *reader =
+		kzalloc(sizeof(struct acpi_event_reader), GFP_KERNEL);
 
-	if (event_is_open)
-		goto out_busy;
+	if (!reader)
+		return -ENOMEM;
 
-	event_is_open = 1;
+	acpi_bus_register_event_listener(&reader->listener);
+	file->private_data = reader;
 
-	spin_unlock_irq(&acpi_system_event_lock);
 	return 0;
-
-      out_busy:
-	spin_unlock_irq(&acpi_system_event_lock);
-	return -EBUSY;
 }
 
 static ssize_t
 acpi_system_read_event(struct file *file, char __user * buffer, size_t count,
 		       loff_t * ppos)
 {
-	int result = 0;
-	struct acpi_bus_event event;
-	static char str[ACPI_MAX_STRING];
-	static int chars_remaining = 0;
-	static char *ptr;
+	int				result;
+	struct acpi_bus_event		*event;
+	struct acpi_event_reader	*reader = file->private_data;
+	struct acpi_event_listener	*listener = &reader->listener;
 
 	ACPI_FUNCTION_TRACE("acpi_system_read_event");
 
-	if (!chars_remaining) {
-		memset(&event, 0, sizeof(struct acpi_bus_event));
+	if (!reader->chars_remaining) {
 
-		if ((file->f_flags & O_NONBLOCK)
-		    && (list_empty(&acpi_bus_event_list)))
+		if (listener->head == listener->tail &&
+				(file->f_flags & O_NONBLOCK)) {
 			return_VALUE(-EAGAIN);
+		}
 
-		result = acpi_bus_receive_event(&event);
+ 		result = wait_event_interruptible(acpi_bus_event_queue,
+						  listener->head != listener->tail);
 		if (result)
 			return_VALUE(result);
 
-		chars_remaining = sprintf(str, "%s %s %08x %08x\n",
-					  event.device_class ? event.
-					  device_class : "<unknown>",
-					  event.bus_id ? event.
-					  bus_id : "<unknown>", event.type,
-					  event.data);
-		ptr = str;
+		event = &listener->buffer[listener->tail];
+		listener->tail = (listener->tail + 1) & (ACPI_EVENT_BUFFER_SIZE - 1);
+
+		reader->chars_remaining = sprintf(reader->str, "%s %s %08x %08x\n",
+					  event->device_class ?
+						event->device_class : "<unknown>",
+					  event->bus_id ?  event->bus_id : "<unknown>",
+					  event->type, event->data);
+		reader->ptr = reader->str;
 	}
 
-	if (chars_remaining < count) {
-		count = chars_remaining;
+	if (reader->chars_remaining < count) {
+		count = reader->chars_remaining;
 	}
 
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
 
 static int acpi_system_close_event(struct inode *inode, struct file *file)
 {
-	spin_lock_irq(&acpi_system_event_lock);
-	event_is_open = 0;
-	spin_unlock_irq(&acpi_system_event_lock);
+	struct acpi_event_reader *reader = file->private_data;
+
+	if (!acpi_bus_unregister_event_listener(&reader->listener))
+		kfree(reader);
+
 	return 0;
 }
 
 static unsigned int acpi_system_poll_event(struct file *file, poll_table * wait)
 {
+	struct acpi_event_reader *reader = file->private_data;
 	poll_wait(file, &acpi_bus_event_queue, wait);
-	if (!list_empty(&acpi_bus_event_list))
+	if (reader->listener.head != reader->listener.tail)
 		return POLLIN | POLLRDNORM;
 	return 0;
 }
@@ -131,3 +137,4 @@ static int __init acpi_event_init(void)
 }
 
 subsys_initcall(acpi_event_init);
+
-- 
1.1.GIT

