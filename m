From: yakui <yakui.zhao@intel.com>
Subject: [Patch 1/2]:ACPI: Don't treat generic error as ACPI error code in
	acpi memory hotplug driver
Date: Tue, 07 Jul 2009 10:55:51 +0800
Message-ID: <1246935351.14188.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40702 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230AbZGGCzC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Jul 2009 22:55:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

Don't regard the generic error as ACPI error code. Otherwise when the generic
code is returned, it will complain the following warning messag:
   >ACPI Exception (acpi_memhotplug-0171): UNKNOWN_STATUS_CODE, 
		Cannot get acpi bus device [20080609]
   >ACPI: Cannot find driver data
   > ACPI Error (utglobal-0127): Unknown exception code: 0xFFFFFFED [20080609]
   > Pid: 85, comm: kacpi_notify Not tainted 2.6.27.19-5-default #1
     Call Trace:
     [<ffffffff8020da29>] show_trace_log_lvl+0x41/0x58
     [<ffffffff8049a3da>] dump_stack+0x69/0x6f
    .....

At the same time when the generic error code is returned, the ACPI_EXCEPTION
is replaced by the printk.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/acpi_memhotplug.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpi_memhotplug.c	2009-07-06 13:32:36.000000000 +0800
+++ linux-2.6/drivers/acpi/acpi_memhotplug.c	2009-07-07 10:33:43.000000000 +0800
@@ -38,6 +38,9 @@
 
 #define _COMPONENT		ACPI_MEMORY_DEVICE_COMPONENT
 
+#undef PREFIX
+#define 	PREFIX		"ACPI:memory_hp:"
+
 ACPI_MODULE_NAME("acpi_memhotplug");
 MODULE_AUTHOR("Naveen B S <naveen.b.s@intel.com>");
 MODULE_DESCRIPTION("Hotplug Mem Driver");
@@ -153,6 +156,7 @@
 	acpi_handle phandle;
 	struct acpi_device *device = NULL;
 	struct acpi_device *pdevice = NULL;
+	int result;
 
 
 	if (!acpi_bus_get_device(handle, &device) && device)
@@ -165,9 +169,10 @@
 	}
 
 	/* Get the parent device */
-	status = acpi_bus_get_device(phandle, &pdevice);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Cannot get acpi bus device"));
+	result = acpi_bus_get_device(phandle, &pdevice);
+	if (result) {
+		printk(KERN_WARNING PREFIX "Cannot get acpi bus device, "
+						"ret = %d\n", result);
 		return -EINVAL;
 	}
 
@@ -175,9 +180,10 @@
 	 * Now add the notified device.  This creates the acpi_device
 	 * and invokes .add function
 	 */
-	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Cannot add acpi bus"));
+	result = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
+	if (result) {
+		printk(KERN_WARNING PREFIX "Cannot add acpi bus, "
+						"ret = %d\n", result);
 		return -EINVAL;
 	}
 


