From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [Resend PATCH V2 2/7] usb: Bind devices to ACPI devices when possible
Date: Fri,  4 May 2012 11:06:38 +0800
Message-ID: <1336100803-28353-3-git-send-email-tianyu.lan@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22324 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350Ab2EDDMu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2012 23:12:50 -0400
In-Reply-To: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

From: Matthew Garrett <mjg@redhat.com>

Built-in USB devices will typically have a representation in the system
ACPI tables. Add support for binding the two together so the USB code can
make use of the associated methods.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/usb/core/Makefile   |    1 +
 drivers/usb/core/usb-acpi.c |   60 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c      |    6 ++++
 drivers/usb/core/usb.h      |    7 +++++
 4 files changed, 74 insertions(+), 0 deletions(-)
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
index 0000000..cab5cb7
--- /dev/null
+++ b/drivers/usb/core/usb-acpi.c
@@ -0,0 +1,60 @@
+/*
+ * USB-ACPI glue code
+ *
+ * Copyright 2012 Red Hat <mjg@redhat.com>
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
+	struct usb_device *udev;
+	struct device *parent;
+	acpi_handle *parent_handle;
+
+	if (!is_usb_device(dev))
+		return -ENODEV;
+
+	udev = to_usb_device(dev);
+	parent = dev->parent;
+	parent_handle = DEVICE_ACPI_HANDLE(parent);
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
index c74ba7b..84e8c20 100644
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
index 71648dc..5c5c538 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -156,3 +156,10 @@ extern void usb_notify_remove_device(struct usb_device *udev);
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
1.7.6.rc2.8.g28eb

