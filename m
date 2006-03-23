From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [PATCH: 001/002] Catch notification of memory add event of ACPI via container driver. (register start func for memory device)
Date: Thu, 23 Mar 2006 22:42:47 +0900
Message-ID: <20060323224116.8A0D.Y-GOTO@jp.fujitsu.com>
References: <20060323221810.8A0B.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:28121 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751449AbWCWNnM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Mar 2006 08:43:12 -0500
In-Reply-To: <20060323221810.8A0B.Y-GOTO@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: ACPI-ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>


This is a patch to call add_memroy() when notify reaches for 
new node's add event.

When new node is added, notify of ACPI reaches container device
which means the node.
Container device driver calls acpi_bus_scan() to find and add
belonging devices (which means cpu, memory and so on).
Its function calls add and start function of belonging 
devices's driver.

Howevever, current memory hotplug driver just register add function to
create sysfs file for its memory. But, acpi_memory_enable_device()
is not called because it is considered just the case that notify reaches
memory device directly. So, if notify reaches container device 
nothing can call add_memory().

This is a patch to create start function which calls add_memory().
add_memory() can be called by this when notify reaches container device.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 drivers/acpi/acpi_memhotplug.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)

Index: pgdat9/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat9.orig/drivers/acpi/acpi_memhotplug.c	2006-03-23 19:58:48.000000000 +0900
+++ pgdat9/drivers/acpi/acpi_memhotplug.c	2006-03-23 20:20:17.000000000 +0900
@@ -57,6 +57,7 @@ MODULE_LICENSE("GPL");
 
 static int acpi_memory_device_add(struct acpi_device *device);
 static int acpi_memory_device_remove(struct acpi_device *device, int type);
+static int acpi_memory_device_start (struct acpi_device *device);
 
 static struct acpi_driver acpi_memory_device_driver = {
 	.name = ACPI_MEMORY_DEVICE_DRIVER_NAME,
@@ -65,6 +66,7 @@ static struct acpi_driver acpi_memory_de
 	.ops = {
 		.add = acpi_memory_device_add,
 		.remove = acpi_memory_device_remove,
+		.start = acpi_memory_device_start,
 		},
 };
 
@@ -429,6 +431,26 @@ static int acpi_memory_device_remove(str
 	return_VALUE(0);
 }
 
+static int
+acpi_memory_device_start (struct acpi_device *device)
+{
+	struct acpi_memory_device *mem_device;
+	int result = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_device_start");
+
+	mem_device = (struct acpi_memory_device *) acpi_driver_data(device);
+
+	if (!acpi_memory_check_device(mem_device)){
+		/* call add_memory func */
+		result = acpi_memory_enable_device(mem_device);
+		if (result)
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error in acpi_memory_enable_device\n"));
+	}
+	return_VALUE(result);
+}
+
 /*
  * Helper function to check for memory device
  */

-- 
Yasunori Goto 


