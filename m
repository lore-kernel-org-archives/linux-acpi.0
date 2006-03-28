From: akpm@osdl.org
Subject: [patch 25/26] Catch notification of memory add event of ACPI via container driver. (register start func for memory device)
Date: Tue, 28 Mar 2006 14:03:50 -0800
Message-ID: <200603282203.k2SM3vfn027725@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:5040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932427AbWC1WEE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 17:04:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, y-goto@jp.fujitsu.com, haveblue@us.ibm.com


From: Yasunori Goto <y-goto@jp.fujitsu.com>

This is a patch to call add_memroy() when notify reaches for new node's add
event.

When new node is added, notify of ACPI reaches container device which means
the node.

Container device driver calls acpi_bus_scan() to find and add belonging
devices (which means cpu, memory and so on).  Its function calls add and
start function of belonging devices's driver.

Howevever, current memory hotplug driver just register add function to
create sysfs file for its memory.  But, acpi_memory_enable_device() is not
called because it is considered just the case that notify reaches memory
device directly.  So, if notify reaches container device nothing can call
add_memory().

This is a patch to create start function which calls add_memory(). 
add_memory() can be called by this when notify reaches container device.

[akpm@osdl.org: coding cleanups]
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/acpi_memhotplug.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+)

diff -puN drivers/acpi/acpi_memhotplug.c~catch-notification-of-memory-add-event-of-acpi-via-container-driver-register-start-func-for-memory-device drivers/acpi/acpi_memhotplug.c
--- devel/drivers/acpi/acpi_memhotplug.c~catch-notification-of-memory-add-event-of-acpi-via-container-driver-register-start-func-for-memory-device	2006-03-28 14:03:08.000000000 -0800
+++ devel-akpm/drivers/acpi/acpi_memhotplug.c	2006-03-28 14:03:08.000000000 -0800
@@ -57,6 +57,7 @@ MODULE_LICENSE("GPL");
 
 static int acpi_memory_device_add(struct acpi_device *device);
 static int acpi_memory_device_remove(struct acpi_device *device, int type);
+static int acpi_memory_device_start(struct acpi_device *device);
 
 static struct acpi_driver acpi_memory_device_driver = {
 	.name = ACPI_MEMORY_DEVICE_DRIVER_NAME,
@@ -65,6 +66,7 @@ static struct acpi_driver acpi_memory_de
 	.ops = {
 		.add = acpi_memory_device_add,
 		.remove = acpi_memory_device_remove,
+		.start = acpi_memory_device_start,
 		},
 };
 
@@ -429,6 +431,25 @@ static int acpi_memory_device_remove(str
 	return_VALUE(0);
 }
 
+static int acpi_memory_device_start (struct acpi_device *device)
+{
+	struct acpi_memory_device *mem_device;
+	int result = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_start");
+
+	mem_device = acpi_driver_data(device);
+
+	if (!acpi_memory_check_device(mem_device)) {
+		/* call add_memory func */
+		result = acpi_memory_enable_device(mem_device);
+		if (result)
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Error in acpi_memory_enable_device\n"));
+	}
+	return_VALUE(result);
+}
+
 /*
  * Helper function to check for memory device
  */
_
