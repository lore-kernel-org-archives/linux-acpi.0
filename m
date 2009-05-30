From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/65] ACPI: allow drivers to request both device and system
 notify events
Date: Fri, 29 May 2009 21:42:19 -0400
Message-ID: <c7d8348a8f2252e11ae050dfb34a36af6a89754b.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50006 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495AbZE3BnM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:12 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF007CCORM7OX2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:58 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

System notify events (0x00-0x7f) are common across all device types
and should be handled in Linux/ACPI, not in drivers.  However, some
BIOSes use system notify events in device-specific ways that require
the driver to be involved.

This patch adds a ACPI_DRIVER_ALL_NOTIFY_EVENTS driver flag.  When a
driver sets this flag and supplies a .notify method, Linux/ACPI calls
the .notify method for ALL notify events on the device, not just the
device-specific (0x80-0xff) events.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    6 +++++-
 include/acpi/acpi_bus.h |    3 +++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index ae862f1..cdfecc0 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -549,6 +549,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 {
 	int result = 0;
 	struct acpi_device *device = NULL;
+	struct acpi_driver *driver;
 
 	blocking_notifier_call_chain(&acpi_bus_notify_list,
 		type, (void *)handle);
@@ -629,7 +630,10 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 		break;
 	}
 
-	return;
+	driver = device->driver;
+	if (driver && driver->ops.notify &&
+	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
+		driver->ops.notify(device, type);
 }
 
 /* --------------------------------------------------------------------------
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c34b110..84e35d5 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -114,10 +114,13 @@ struct acpi_device_ops {
 	acpi_op_notify notify;
 };
 
+#define ACPI_DRIVER_ALL_NOTIFY_EVENTS	0x1	/* system AND device events */
+
 struct acpi_driver {
 	char name[80];
 	char class[80];
 	const struct acpi_device_id *ids; /* Supported Hardware IDs */
+	unsigned int flags;
 	struct acpi_device_ops ops;
 	struct device_driver drv;
 	struct module *owner;
-- 
1.6.0.6

