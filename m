From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/9] ACPI: processor: clean up in acpi_processor_start() error
	exits
Date: Mon, 22 Jun 2009 14:41:09 -0600
Message-ID: <20090622204109.32761.20391.stgit@bob.kio>
References: <20090622204016.32761.47464.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:17822 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbZFVUlH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 16:41:07 -0400
In-Reply-To: <20090622204016.32761.47464.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Alex Chiang <achiang@hp.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

We used to leave crud around if things failed in acpi_processor_start().
This patch cleans up as much as we can before returning.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
CC: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index d8e210a..7f082b6 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -722,11 +722,13 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 
 	result = acpi_processor_add_fs(device);
 	if (result)
-		goto end;
+		return result;
 
 	sysdev = get_cpu_sysdev(pr->id);
-	if (sysfs_create_link(&device->dev.kobj, &sysdev->kobj, "sysdev"))
-		return -EFAULT;
+	if (sysfs_create_link(&device->dev.kobj, &sysdev->kobj, "sysdev")) {
+		result = -EFAULT;
+		goto err_remove_fs;
+	}
 
 	/* _PDC call should be done before doing anything else (if reqd.). */
 	arch_acpi_processor_init_pdc(pr);
@@ -746,7 +748,7 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 						&processor_cooling_ops);
 	if (IS_ERR(pr->cdev)) {
 		result = PTR_ERR(pr->cdev);
-		goto end;
+		goto err_power_exit;
 	}
 
 	dev_info(&device->dev, "registered as cooling_device%d\n",
@@ -755,13 +757,17 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 	result = sysfs_create_link(&device->dev.kobj,
 				   &pr->cdev->device.kobj,
 				   "thermal_cooling");
-	if (result)
+	if (result) {
 		printk(KERN_ERR PREFIX "Create sysfs link\n");
+		goto err_thermal_unregister;
+	}
 	result = sysfs_create_link(&pr->cdev->device.kobj,
 				   &device->dev.kobj,
 				   "device");
-	if (result)
+	if (result) {
 		printk(KERN_ERR PREFIX "Create sysfs link\n");
+		goto err_remove_sysfs;
+	}
 
 	if (pr->flags.throttling) {
 		printk(KERN_INFO PREFIX "%s [%s] (supports",
@@ -770,7 +776,16 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 		printk(")\n");
 	}
 
-      end:
+	return 0;
+
+err_remove_sysfs:
+	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+err_thermal_unregister:
+	thermal_cooling_device_unregister(pr->cdev);
+err_power_exit:
+	acpi_processor_power_exit(pr, device);
+err_remove_fs:
+	acpi_processor_remove_fs(device);
 
 	return result;
 }

