From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/5] run ACPI device hot removal in kacpi_hotplug_wq
Date: Mon, 22 Jun 2009 11:31:16 +0800
Message-ID: <1245641478-31805-3-git-send-email-rui.zhang@intel.com>
References: <n>
 <1245641478-31805-1-git-send-email-rui.zhang@intel.com>
 <1245641478-31805-2-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56781 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbZFVDae (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jun 2009 23:30:34 -0400
In-Reply-To: <1245641478-31805-2-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Run the ACPI device hot removal code in kacpi_hotplug_wq
rather than a new kernel thread.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8ff510b..9c6e42e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -95,7 +95,7 @@ acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, cha
 }
 static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
 
-static int acpi_bus_hot_remove_device(void *context)
+static void acpi_bus_hot_remove_device(void *context)
 {
 	struct acpi_device *device;
 	acpi_handle handle = context;
@@ -104,10 +104,10 @@ static int acpi_bus_hot_remove_device(void *context)
 	acpi_status status = AE_OK;
 
 	if (acpi_bus_get_device(handle, &device))
-		return 0;
+		return;
 
 	if (!device)
-		return 0;
+		return;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 		"Hot-removing device %s...\n", dev_name(&device->dev)));
@@ -115,7 +115,7 @@ static int acpi_bus_hot_remove_device(void *context)
 	if (acpi_bus_trim(device, 1)) {
 		printk(KERN_ERR PREFIX
 				"Removing device failed\n");
-		return -1;
+		return;
 	}
 
 	/* power off device */
@@ -142,9 +142,10 @@ static int acpi_bus_hot_remove_device(void *context)
 	 */
 	status = acpi_evaluate_object(handle, "_EJ0", &arg_list, NULL);
 	if (ACPI_FAILURE(status))
-		return -ENODEV;
+		printk(KERN_WARNING PREFIX
+				"Eject device failed\n");
 
-	return 0;
+	return;
 }
 
 static ssize_t
@@ -155,7 +156,6 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 	acpi_status status;
 	acpi_object_type type = 0;
 	struct acpi_device *acpi_device = to_acpi_device(d);
-	struct task_struct *task;
 
 	if ((!count) || (buf[0] != '1')) {
 		return -EINVAL;
@@ -172,11 +172,7 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 		goto err;
 	}
 
-	/* remove the device in another thread to fix the deadlock issue */
-	task = kthread_run(acpi_bus_hot_remove_device,
-				acpi_device->handle, "acpi_hot_remove_device");
-	if (IS_ERR(task))
-		ret = PTR_ERR(task);
+	acpi_os_hotplug_execute(acpi_bus_hot_remove_device, acpi_device->handle);
 err:
 	return ret;
 }
-- 
1.5.4.4

