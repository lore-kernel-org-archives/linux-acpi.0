From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/4] usb: Bind devices to ACPI devices when possible
Date: Mon, 12 Mar 2012 19:58:54 -0400
Message-ID: <1331596735-3690-3-git-send-email-mjg@redhat.com>
References: <1331596735-3690-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37465 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756947Ab2CLT6x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Mar 2012 15:58:53 -0400
In-Reply-To: <1331596735-3690-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-usb@vger.kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org, Matthew Garrett <mjg@redhat.com>

Built-in USB devices will typically have a representation in the system
ACPI tables. Add support for binding the two together so the USB code can
make use of the associated methods.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/usb/core/Makefile   |    1 +
 drivers/usb/core/usb-acpi.c |   53 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c      |    6 +++++
 drivers/usb/core/usb.h      |    7 ++++++
 4 files changed, 67 insertions(+)
 create mode 100644 drivers/usb/core/usb-acpi.c

diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 507a4e1..9268ddb 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -10,5 +10,6 @@ usbcore-y += devio.o notify.o generic.o quirks.o devices.o
 
 usbcore-$(CONFIG_PCI)		+= hcd-pci.o
 usbcore-$(CONFIG_USB_DEVICEFS)	+= inode.o
+usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
 
 obj-$(CONFIG_USB)		+= usbcore.o
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
new file mode 100644
index 0000000..1224c50
--- /dev/null
+++ b/drivers/usb/core/usb-acpi.c
@@ -0,0 +1,53 @@
+/*
+ * USB-ACPI glue code
+ *
+ * Copyright 2011 Red Hat <mjg@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation, version 2.
+ *
+ */
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include <acpi/acpi_bus.h>
+
+#include "usb.h"
+
+static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
+{
+	struct usb_device *udev = to_usb_device(dev);
+	struct device *parent = dev->parent;
+	acpi_handle *parent_handle = DEVICE_ACPI_HANDLE(parent);
+
+	if (!parent_handle)
+		return -ENODEV;
+
+	*handle = acpi_get_child(parent_handle, udev->portnum);
+
+	if (!*handle)
+		return -ENODEV;
+
+	return 0;
+}
+
+static struct acpi_bus_type usb_acpi_bus = {
+	.bus = &usb_bus_type,
+	.find_bridge = NULL,
+	.find_device = usb_acpi_find_device,
+};
+
+int usb_acpi_register(void)
+{
+	return register_acpi_bus_type(&usb_acpi_bus);
+}
+
+void usb_acpi_unregister(void)
+{
+	unregister_acpi_bus_type(&usb_acpi_bus);
+}
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 8ca9f99..ce47e3f 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1015,6 +1015,9 @@ static int __init usb_init(void)
 	if (retval)
 		goto out;
 
+	retval = usb_acpi_register();
+	if (retval)
+		goto acpi_register_failed;
 	retval = bus_register(&usb_bus_type);
 	if (retval)
 		goto bus_register_failed;
@@ -1054,6 +1057,8 @@ major_init_failed:
 bus_notifier_failed:
 	bus_unregister(&usb_bus_type);
 bus_register_failed:
+	usb_acpi_unregister();
+acpi_register_failed:
 	usb_debugfs_cleanup();
 out:
 	return retval;
@@ -1076,6 +1081,7 @@ static void __exit usb_exit(void)
 	usb_hub_cleanup();
 	bus_unregister_notifier(&usb_bus_type, &usb_bus_nb);
 	bus_unregister(&usb_bus_type);
+	usb_acpi_unregister();
 	usb_debugfs_cleanup();
 }
 
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 45e8479..636d98e 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -155,3 +155,10 @@ extern void usb_notify_remove_device(struct usb_device *udev);
 extern void usb_notify_add_bus(struct usb_bus *ubus);
 extern void usb_notify_remove_bus(struct usb_bus *ubus);
 
+#ifdef CONFIG_ACPI
+extern int usb_acpi_register(void);
+extern void usb_acpi_unregister(void);
+#else
+static inline int usb_acpi_register(void) { return 0; };
+static inline void usb_acpi_unregister(void) { };
+#endif
-- 
1.7.9.3

