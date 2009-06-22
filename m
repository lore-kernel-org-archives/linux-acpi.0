From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/9] ACPI: processor: remove .start() method
Date: Mon, 22 Jun 2009 14:41:19 -0600
Message-ID: <20090622204119.32761.60404.stgit@bob.kio>
References: <20090622204016.32761.47464.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:47175 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbZFVUlR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 16:41:17 -0400
In-Reply-To: <20090622204016.32761.47464.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Alex Chiang <achiang@hp.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

This patch folds the .start() method into .add().

acpi_processor_start() is always called immediately after
acpi_processor_add(), so there's really no point in having them be
separate methods.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
CC: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |   44 +++++++----------------------------------
 1 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 393695f..af292bf 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -79,7 +79,6 @@ MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
 
 static int acpi_processor_add(struct acpi_device *device);
-static int acpi_processor_start(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
 static int acpi_processor_info_open_fs(struct inode *inode, struct file *file);
 static void acpi_processor_notify(struct acpi_device *device, u32 event);
@@ -101,7 +100,6 @@ static struct acpi_driver acpi_processor_driver = {
 	.ops = {
 		.add = acpi_processor_add,
 		.remove = acpi_processor_remove,
-		.start = acpi_processor_start,
 		.suspend = acpi_processor_suspend,
 		.resume = acpi_processor_resume,
 		.notify = acpi_processor_notify,
@@ -751,10 +749,8 @@ static struct notifier_block acpi_cpu_notifier =
 static int acpi_processor_add(struct acpi_device *device)
 {
 	struct acpi_processor *pr = NULL;
-
-
-	if (!device)
-		return -EINVAL;
+	int result = 0;
+	struct sys_device *sysdev;
 
 	pr = kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
 	if (!pr)
@@ -770,17 +766,6 @@ static int acpi_processor_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
 	device->driver_data = pr;
 
-	return 0;
-}
-
-static int __cpuinit acpi_processor_start(struct acpi_device *device)
-{
-	int result = 0;
-	struct acpi_processor *pr;
-	struct sys_device *sysdev;
-
-	pr = acpi_driver_data(device);
-
 	result = acpi_processor_get_info(device);
 	if (result) {
 		/* Processor is physically not present */
@@ -798,7 +783,8 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 	    per_cpu(processor_device_array, pr->id) != device) {
 		printk(KERN_WARNING "BIOS reported wrong ACPI id "
 			"for the processor\n");
-		return -ENODEV;
+		result = -ENODEV;
+		goto err_free_cpumask;
 	}
 	per_cpu(processor_device_array, pr->id) = device;
 
@@ -806,7 +792,7 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 
 	result = acpi_processor_add_fs(device);
 	if (result)
-		return result;
+		goto err_free_cpumask;
 
 	sysdev = get_cpu_sysdev(pr->id);
 	if (sysfs_create_link(&device->dev.kobj, &sysdev->kobj, "sysdev")) {
@@ -870,6 +856,8 @@ err_power_exit:
 	acpi_processor_power_exit(pr, device);
 err_remove_fs:
 	acpi_processor_remove_fs(device);
+err_free_cpumask:
+	free_cpumask_var(pr->throttling.shared_cpu_map);
 
 	return result;
 }
@@ -948,7 +936,6 @@ int acpi_processor_device_add(acpi_handle handle, struct acpi_device **device)
 {
 	acpi_handle phandle;
 	struct acpi_device *pdev;
-	struct acpi_processor *pr;
 
 
 	if (acpi_get_parent(handle, &phandle)) {
@@ -963,12 +950,6 @@ int acpi_processor_device_add(acpi_handle handle, struct acpi_device **device)
 		return -ENODEV;
 	}
 
-	acpi_bus_start(*device);
-
-	pr = acpi_driver_data(*device);
-	if (!pr)
-		return -ENODEV;
-
 	return 0;
 }
 
@@ -998,17 +979,6 @@ static void __ref acpi_processor_hotplug_notify(acpi_handle handle,
 					    "Unable to add the device\n");
 			break;
 		}
-
-		pr = acpi_driver_data(device);
-		if (!pr) {
-			printk(KERN_ERR PREFIX "Driver data is NULL\n");
-			break;
-		}
-
-		result = acpi_processor_start(device);
-		if (result)
-			printk(KERN_ERR PREFIX "Device [%s] failed to start\n",
-				    acpi_device_bid(device));
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,

