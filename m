From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/70] fix a deadlock issue when poking "eject" file
Date: Fri, 20 Jun 2008 03:43:03 -0400
Message-ID: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:53286 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYFTHoS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:18 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R007OP3ULDNE3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:37:34 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

"/sys/devices/LNXSYSTM:00/.../eject" is used to evaluate _EJx method
and eject a device in user space.
But system hangs when poking the "eject" file because that
the device hot-removal code invoke the driver .remove method which will
try to remove the "eject" file as a result.

Queues the hot-removal function for deferred execution in this patch.
http://bugzilla.kernel.org/show_bug.cgi?id=9772

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   56 +++++++++++++++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e6ce262..00ba4af 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <asm/signal.h>
 
 #include <acpi/acpi_drivers.h>
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
@@ -92,17 +93,37 @@ acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, cha
 }
 static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
 
-static int acpi_eject_operation(acpi_handle handle, int lockable)
+static int acpi_bus_hot_remove_device(void *context)
 {
+	struct acpi_device *device;
+	acpi_handle handle = context;
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status = AE_OK;
 
-	/*
-	 * TBD: evaluate _PS3?
-	 */
+	if (acpi_bus_get_device(handle, &device))
+		return 0;
 
-	if (lockable) {
+	if (!device)
+		return 0;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		"Hot-removing device %s...\n", device->dev.bus_id));
+
+
+	if (acpi_bus_trim(device, 1)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Removing device failed\n"));
+		return -1;
+	}
+
+	/* power off device */
+	status = acpi_evaluate_object(handle, "_PS3", NULL, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				"Power-off device failed\n"));
+
+	if (device->flags.lockable) {
 		arg_list.count = 1;
 		arg_list.pointer = &arg;
 		arg.type = ACPI_TYPE_INTEGER;
@@ -118,24 +139,19 @@ static int acpi_eject_operation(acpi_handle handle, int lockable)
 	/*
 	 * TBD: _EJD support.
 	 */
-
 	status = acpi_evaluate_object(handle, "_EJ0", &arg_list, NULL);
-	if (ACPI_FAILURE(status)) {
-		return (-ENODEV);
-	}
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
 
-	return (0);
+	return 0;
 }
 
 static ssize_t
 acpi_eject_store(struct device *d, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	int result;
 	int ret = count;
-	int islockable;
 	acpi_status status;
-	acpi_handle handle;
 	acpi_object_type type = 0;
 	struct acpi_device *acpi_device = to_acpi_device(d);
 
@@ -154,17 +170,9 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 		goto err;
 	}
 
-	islockable = acpi_device->flags.lockable;
-	handle = acpi_device->handle;
-
-	result = acpi_bus_trim(acpi_device, 1);
-
-	if (!result)
-		result = acpi_eject_operation(handle, islockable);
-
-	if (result) {
-		ret = -EBUSY;
-	}
+	/* remove the device in another thread to fix the deadlock issue */
+	ret = kernel_thread(acpi_bus_hot_remove_device,
+				acpi_device->handle, SIGCHLD);
       err:
 	return ret;
 }
-- 
1.5.6

