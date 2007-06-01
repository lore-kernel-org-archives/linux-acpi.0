From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] ACPI: add internal event mechanism
Date: Fri,  1 Jun 2007 04:06:28 +0100 (BST)
Message-ID: <20070601030628.642207B409F@zog.reactivated.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from queue04-winn.ispmail.ntl.com ([81.103.221.58]:54171 "EHLO
	queue04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752706AbXFADZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 May 2007 23:25:33 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20070601030633.EYFE12936.mtaout01-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <linux-acpi@vger.kernel.org>; Fri, 1 Jun 2007 04:06:33 +0100
Received: from zog.reactivated.net ([86.14.211.88])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20070601030633.ZWHB29112.aamtaout04-winn.ispmail.ntl.com@zog.reactivated.net>
          for <linux-acpi@vger.kernel.org>; Fri, 1 Jun 2007 04:06:33 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This patch creates a new event system for communication between in-kernel
ACPI drivers ("ievent"). It is simple - it should only be used to infrequently
pass simple messages to a small audience.

This is used in an upcoming patch which makes the ACPI video driver listen for
lid open events from the button driver. I hope it is generic enough to be
useful to other ACPI drivers in the future.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c
+++ linux/drivers/acpi/bus.c
@@ -533,6 +533,100 @@ static void acpi_bus_notify(acpi_handle 
 }
 
 /* --------------------------------------------------------------------------
+                             Internal events
+   -------------------------------------------------------------------------- */
+
+/*
+ * This is an event implementation designed for simple communication between
+ * ACPI drivers. It is intended for infrequent events that do not have
+ * many listeners.
+ *
+ * Drivers install an ievent handler to a certain event, and unregister it
+ * later. Drivers may raise (notify) events from any point except from the
+ * context of an event handler function.
+ */
+
+static struct list_head ievent_list;
+static spinlock_t ievent_lock;
+
+struct acpi_ievent_handle {
+	struct list_head list;
+	enum acpi_ievent_code event;
+	acpi_ievent_handler handler;
+	void *user_data;
+};
+
+/* Subscribe to a specific internal event.
+ *
+ * The handler function takes 3 parameters:
+ * 1. The acpi_ievent_code of the event that was raised
+ * 2. Some event data (set when the event was raised by the code which
+ *    raised the event)
+ * 3. Some user data which you can specify in the data parameter below.
+ *
+ * This function returns a handle which you must save so that you can
+ * unsubscribe later.
+ */
+struct acpi_ievent_handle *
+acpi_install_ievent_handler(enum acpi_ievent_code event,
+			    acpi_ievent_handler handler, void *data)
+{
+	unsigned long flags;
+	struct acpi_ievent_handle *handle
+		= kmalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return NULL;
+
+	handle->event = event;
+	handle->handler = handler;
+	handle->user_data = data;
+	INIT_LIST_HEAD(&handle->list);
+
+	spin_lock_irqsave(&ievent_lock, flags);
+	list_add_tail(&handle->list, &ievent_list);
+	spin_unlock_irqrestore(&ievent_lock, flags);
+
+	return handle;
+}
+EXPORT_SYMBOL_GPL(acpi_install_ievent_handler);
+
+/*
+ * Unsubscribe from an internal event, using a handle that was returned from
+ * acpi_install_ievent_handler() earlier.
+ */
+void acpi_remove_ievent_handler(struct acpi_ievent_handle *handle)
+{
+	unsigned long flags;
+
+	if (!handle)
+		return;
+
+	spin_lock_irqsave(&ievent_lock, flags);
+	list_del(&handle->list);
+	spin_unlock_irqrestore(&ievent_lock, flags);
+	kfree(handle);
+}
+EXPORT_SYMBOL_GPL(acpi_remove_ievent_handler);
+
+/*
+ * Raise an event with some data.
+ */
+void acpi_ievent_notify(enum acpi_ievent_code event, void *event_data)
+{
+	struct acpi_ievent_handle *handle;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ievent_lock, flags);
+	list_for_each_entry(handle, &ievent_list, list) {
+		if (handle->event != event)
+			continue;
+		handle->handler(event, event_data, handle->user_data);
+	}
+	spin_unlock_irqrestore(&ievent_lock, flags);
+}
+EXPORT_SYMBOL_GPL(acpi_ievent_notify);
+
+/* --------------------------------------------------------------------------
                              Initialization/Cleanup
    -------------------------------------------------------------------------- */
 
@@ -741,6 +835,8 @@ static int __init acpi_init(void)
 {
 	int result = 0;
 
+	spin_lock_init(&ievent_lock);
+	INIT_LIST_HEAD(&ievent_list);
 
 	if (acpi_disabled) {
 		printk(KERN_INFO PREFIX "Interpreter disabled.\n");
Index: linux/include/acpi/acpi_bus.h
===================================================================
--- linux.orig/include/acpi/acpi_bus.h
+++ linux/include/acpi/acpi_bus.h
@@ -323,6 +323,26 @@ struct acpi_bus_event {
 extern struct kset acpi_subsys;
 
 /*
+ * Internal events
+ */
+
+enum acpi_ievent_code {
+	ACPI_IEVENT_LID,
+};
+
+struct acpi_ievent_handle;
+
+typedef
+void (*acpi_ievent_handler)(enum acpi_ievent_code event, void *event_data,
+			    void *user_data);
+
+struct acpi_ievent_handle *
+acpi_install_ievent_handler(enum acpi_ievent_code event,
+			    acpi_ievent_handler handler, void *data);
+void acpi_remove_ievent_handler(struct acpi_ievent_handle *handle);
+void acpi_ievent_notify(enum acpi_ievent_code event, void *event_data);
+
+/*
  * External Functions
  */
 
