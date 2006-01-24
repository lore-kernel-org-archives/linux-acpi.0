From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/2] Implement ACPI event delivery upon subscription.
Date: Wed, 25 Jan 2006 00:14:28 +0100
Message-ID: <1138144468374-git-send-email-malattia@linux.it>
References: <1138144468337-git-send-email-malattia@linux.it>
Reply-To: Mattia Dongili <malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:10984 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750821AbWAXXNi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jan 2006 18:13:38 -0500
In-Reply-To: <1138144468337-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Mattia Dongili <malattia@linux.it>

[PATCH 1/2] Implement ACPI event delivery upon subscription.

Drivers can register their listener to receive events instead of
using a single event queue.
Limit the number of pending events to 32 so if a reader is stuck
it won't consume all memory.

Signed-off-by: Mattia Dongili <malattia@linux.it>


---

 drivers/acpi/bus.c      |   92 ++++++++++++++++++++---------------------------
 include/acpi/acpi_bus.h |   10 +++++
 2 files changed, 50 insertions(+), 52 deletions(-)

0933a109f7da68a80a9a4137c486db17f8bfb9b6
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 606f873..c4d5412 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -280,91 +280,79 @@ EXPORT_SYMBOL(acpi_bus_set_power);
    -------------------------------------------------------------------------- */
 
 static DEFINE_SPINLOCK(acpi_bus_event_lock);
-
-LIST_HEAD(acpi_bus_event_list);
+LIST_HEAD(acpi_event_listener_list);
 DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_queue);
 
-extern int event_is_open;
-
-int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
+int acpi_bus_register_event_listener(struct acpi_event_listener *listener)
 {
-	struct acpi_bus_event *event = NULL;
 	unsigned long flags = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_generate_event");
+	ACPI_FUNCTION_TRACE("acpi_bus_add_listener");
 
-	if (!device)
+	if (!listener)
 		return_VALUE(-EINVAL);
 
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
 	spin_lock_irqsave(&acpi_bus_event_lock, flags);
-	list_add_tail(&event->node, &acpi_bus_event_list);
+	list_add_tail(&listener->node, &acpi_event_listener_list);
 	spin_unlock_irqrestore(&acpi_bus_event_lock, flags);
 
-	wake_up_interruptible(&acpi_bus_event_queue);
-
 	return_VALUE(0);
 }
 
-EXPORT_SYMBOL(acpi_bus_generate_event);
+EXPORT_SYMBOL(acpi_bus_register_event_listener);
 
-int acpi_bus_receive_event(struct acpi_bus_event *event)
+int acpi_bus_unregister_event_listener(struct acpi_event_listener *listener)
 {
 	unsigned long flags = 0;
-	struct acpi_bus_event *entry = NULL;
 
-	DECLARE_WAITQUEUE(wait, current);
+	ACPI_FUNCTION_TRACE("acpi_bus_remove_listener");
 
-	ACPI_FUNCTION_TRACE("acpi_bus_receive_event");
-
-	if (!event)
+	if (!listener)
 		return_VALUE(-EINVAL);
 
-	if (list_empty(&acpi_bus_event_list)) {
+	spin_lock_irqsave(&acpi_bus_event_lock, flags);
+	list_del(&listener->node);
+	spin_unlock_irqrestore(&acpi_bus_event_lock, flags);
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&acpi_bus_event_queue, &wait);
+	return_VALUE(0);
+}
 
-		if (list_empty(&acpi_bus_event_list))
-			schedule();
+EXPORT_SYMBOL(acpi_bus_unregister_event_listener);
 
-		remove_wait_queue(&acpi_bus_event_queue, &wait);
-		set_current_state(TASK_RUNNING);
+int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
+{
+	struct acpi_bus_event *event;
+	struct acpi_event_listener *listener = NULL;
+	unsigned long flags = 0;
 
-		if (signal_pending(current))
-			return_VALUE(-ERESTARTSYS);
-	}
+	ACPI_FUNCTION_TRACE("acpi_bus_generate_event");
 
-	spin_lock_irqsave(&acpi_bus_event_lock, flags);
-	entry =
-	    list_entry(acpi_bus_event_list.next, struct acpi_bus_event, node);
-	if (entry)
-		list_del(&entry->node);
-	spin_unlock_irqrestore(&acpi_bus_event_lock, flags);
+	if (!device)
+		return_VALUE(-EINVAL);
 
-	if (!entry)
-		return_VALUE(-ENODEV);
+	spin_lock_irqsave(&acpi_bus_event_lock, flags);
+	/* drop event on the floor if no one's listening */
+	if (list_empty(&acpi_event_listener_list)) {
+		spin_unlock_irqrestore(&acpi_bus_event_lock, flags);
+		return_VALUE(0);
+	}
 
-	memcpy(event, entry, sizeof(struct acpi_bus_event));
+	list_for_each_entry(listener, &acpi_event_listener_list, node) {
+		event = &listener->buffer[listener->head];
+		listener->head = (listener->head + 1) & (ACPI_EVENT_BUFFER_SIZE - 1);
+		strcpy(event->device_class, device->pnp.device_class);
+		strcpy(event->bus_id, device->pnp.bus_id);
+		event->type = type;
+		event->data = data;
+	}
+	spin_unlock_irqrestore(&acpi_bus_event_lock, flags);
 
-	kfree(entry);
+	wake_up_interruptible(&acpi_bus_event_queue);
 
 	return_VALUE(0);
 }
 
-EXPORT_SYMBOL(acpi_bus_receive_event);
+EXPORT_SYMBOL(acpi_bus_generate_event);
 
 /* --------------------------------------------------------------------------
                              Notification Handling
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 0b54e9a..4ae8d07 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -313,6 +313,14 @@ struct acpi_bus_event {
 	u32 data;
 };
 
+#define ACPI_EVENT_BUFFER_SIZE 32
+struct acpi_event_listener {
+	struct acpi_bus_event	buffer[ACPI_EVENT_BUFFER_SIZE];
+	int			head;
+	int			tail;
+	struct list_head	node;
+};
+
 extern struct subsystem acpi_subsys;
 
 /*
@@ -324,6 +332,8 @@ void acpi_bus_data_handler(acpi_handle h
 int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
+int acpi_bus_register_event_listener(struct acpi_event_listener *listener);
+int acpi_bus_unregister_event_listener(struct acpi_event_listener *listener);
 int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data);
 int acpi_bus_receive_event(struct acpi_bus_event *event);
 int acpi_bus_register_driver(struct acpi_driver *driver);
-- 
1.1.GIT

