From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/4] ACPI: support ejecting device in userspace
Date: Thu, 17 Jan 2008 09:20:02 +0800
Message-ID: <1200532803.2935.70.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58411 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbYAQBOl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 20:14:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

From: Zhang Rui <rui.zhang@intel.com>

"/sys/devices/LNXSYSTM:00/.../eject" is used to evaluate _EJx method
and eject a device in user space.
But "echo 1 > eject" causes deadlock because
the device hot-removal code will try to remove the "eject" file as a result.
Queues the hot-removal function for deferred execution in this patch.
http://bugzilla.kernel.org/show_bug.cgi?id=9731

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -151,15 +151,13 @@ acpi_bus_eject_device(acpi_handle handle
 	return 0;
 }
 
+void acpi_bus_hot_remove_device(void *context);
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
 
@@ -178,17 +176,13 @@ acpi_eject_store(struct device *d, struc
 		goto err;
 	}
 
-	islockable = acpi_device->flags.lockable;
-	handle = acpi_device->handle;
+	status = acpi_os_execute(OSL_DEVICE_HOTPLUG_HANDLER,
+				 acpi_bus_hot_remove_device,
+				 acpi_device->handle);
 
-	result = acpi_bus_trim(acpi_device, 1);
-
-	if (!result)
-		result = acpi_bus_eject_device(handle, islockable);
+	if (status)
+		ret = -ENODEV;
 
-	if (result) {
-		ret = -EBUSY;
-	}
       err:
 	return ret;
 }


