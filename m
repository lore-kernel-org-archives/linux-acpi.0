From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/9] ACPI: processor: clean up in acpi_processor_start() error
	exits
Date: Fri, 19 Jun 2009 15:31:44 -0600
Message-ID: <20090619213144.18001.62638.stgit@bob.kio>
References: <20090619213038.18001.16533.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:29986 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbZFSVbl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 17:31:41 -0400
In-Reply-To: <20090619213038.18001.16533.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Alex Chiang <achiang@hp.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

We used to leave crud around if things failed in acpi_processor_start().
This patch cleans up as much as we can before returning (we still leak some
space allocated in arch_acpi_processor_init_pdc(), but there's no cleanup
path for that yet).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
CC: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 0c0996a..bc27728 100644
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
@@ -744,7 +746,7 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 						&processor_cooling_ops);
 	if (IS_ERR(pr->cdev)) {
 		result = PTR_ERR(pr->cdev);
-		goto end;
+		goto err_power_exit;
 	}
 
 	dev_info(&device->dev, "registered as cooling_device%d\n",
@@ -753,13 +755,17 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
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
@@ -768,7 +774,16 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
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

