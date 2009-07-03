From: yakui <yakui.zhao@intel.com>
Subject: [Patch 2/2]:ACPI: Ingore the memory block with zero block size in
	course of memory hotplug
Date: Fri, 03 Jul 2009 10:50:28 +0800
Message-ID: <1246589428.18688.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31927 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbZGCCtd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jul 2009 22:49:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

If the memory block size is zero, ignore it and don't do the memory hotplug
flowchart. Otherwise it will complain the following warning message:
  >System RAM resource 0 - ffffffffffffffff cannot be added

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/acpi_memhotplug.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpi_memhotplug.c	2009-07-03 10:22:22.000000000 +0800
+++ linux-2.6/drivers/acpi/acpi_memhotplug.c	2009-07-03 10:36:07.000000000 +0800
@@ -242,7 +242,12 @@
 			num_enabled++;
 			continue;
 		}
-
+		/*
+		 * If the memory block size is zero, please ignore it.
+		 * Don't try to do the following memory hotplug flowchart.
+		 */
+		if (!info->length)
+			continue;
 		if (node < 0)
 			node = memory_add_physaddr_to_nid(info->start_addr);
 
@@ -257,8 +262,15 @@
 		mem_device->state = MEMORY_INVALID_STATE;
 		return -EINVAL;
 	}
-
-	return result;
+	/*
+	 * Sometimes the memory device will contain several memory blocks.
+	 * When one memory block is hot-added to the system memory, it will
+	 * be regarded as a success.
+	 * Otherwise if the last memory block can't be hot-added to the system
+	 * memory, it will be failure and the memory device can't be bound with
+	 * driver.
+	 */
+	return 0;
 }
 
 static int acpi_memory_powerdown_device(struct acpi_memory_device *mem_device)


