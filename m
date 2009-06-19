From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/9] ACPI: memory hotplug: remove .start() method
Date: Fri, 19 Jun 2009 15:31:39 -0600
Message-ID: <20090619213139.18001.78159.stgit@bob.kio>
References: <20090619213038.18001.16533.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:47002 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbZFSVbg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 17:31:36 -0400
In-Reply-To: <20090619213038.18001.16533.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, Alex Chiang <achiang@hp.com>, Yasunori Goto <y-goto@jp.fujitsu.com>

This patch folds the .start() method into .add().

The .start() method is called in two paths: boot-time device enumeration
and run-time node addition, currently via container_device_add().  In both
cases, .start() is called immediately after .add(), so there's no reason
to make them separate methods.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
CC: Yasunori Goto <y-goto@jp.fujitsu.com>
CC: Dave Hansen <haveblue@us.ibm.com>
---
 drivers/acpi/acpi_memhotplug.c |   40 ++++++++++++++--------------------------
 1 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 7a0f4aa..a8d9d8f 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -50,7 +50,6 @@ MODULE_LICENSE("GPL");
 
 static int acpi_memory_device_add(struct acpi_device *device);
 static int acpi_memory_device_remove(struct acpi_device *device, int type);
-static int acpi_memory_device_start(struct acpi_device *device);
 
 static const struct acpi_device_id memory_device_ids[] = {
 	{ACPI_MEMORY_DEVICE_HID, 0},
@@ -65,7 +64,6 @@ static struct acpi_driver acpi_memory_device_driver = {
 	.ops = {
 		.add = acpi_memory_device_add,
 		.remove = acpi_memory_device_remove,
-		.start = acpi_memory_device_start,
 		},
 };
 
@@ -415,28 +413,6 @@ static int acpi_memory_device_add(struct acpi_device *device)
 
 	printk(KERN_DEBUG "%s \n", acpi_device_name(device));
 
-	return result;
-}
-
-static int acpi_memory_device_remove(struct acpi_device *device, int type)
-{
-	struct acpi_memory_device *mem_device = NULL;
-
-
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
-	mem_device = acpi_driver_data(device);
-	kfree(mem_device);
-
-	return 0;
-}
-
-static int acpi_memory_device_start (struct acpi_device *device)
-{
-	struct acpi_memory_device *mem_device;
-	int result = 0;
-
 	/*
 	 * Early boot code has recognized memory area by EFI/E820.
 	 * If DSDT shows these memory devices on boot, hotplug is not necessary
@@ -446,8 +422,6 @@ static int acpi_memory_device_start (struct acpi_device *device)
 	if (!acpi_hotmem_initialized)
 		return 0;
 
-	mem_device = acpi_driver_data(device);
-
 	if (!acpi_memory_check_device(mem_device)) {
 		/* call add_memory func */
 		result = acpi_memory_enable_device(mem_device);
@@ -458,6 +432,20 @@ static int acpi_memory_device_start (struct acpi_device *device)
 	return result;
 }
 
+static int acpi_memory_device_remove(struct acpi_device *device, int type)
+{
+	struct acpi_memory_device *mem_device = NULL;
+
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	mem_device = acpi_driver_data(device);
+	kfree(mem_device);
+
+	return 0;
+}
+
 /*
  * Helper function to check for memory device
  */

