From: akpm@osdl.org
Subject: [patch 04/18] Catch notification of memory add event of ACPI via container driver. (avoid redundant call add_memory)
Date: Sat, 24 Jun 2006 16:36:22 -0700
Message-ID: <200606242336.k5ONaNb3008034@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:22429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751259AbWFXXsQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 19:48:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, y-goto@jp.fujitsu.com, haveblue@us.ibm.com


From: Yasunori Goto <y-goto@jp.fujitsu.com>

When acpi_memory_device_init() is called at boottime to register struct
memory acpi_memory_device, acpi_bus_add() are called via
acpi_driver_attach().

But it also calls ops->start() function.  It is called even if the memory
blocks are initialized at early boottime.  In this case add_memory() return
-EEXIST, and the memory blocks becomes INVALID state even if it is normal.

This is patch to avoid calling add_memory() for already available memory.

[akpm@osdl.org: coding cleanups]
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/acpi_memhotplug.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff -puN drivers/acpi/acpi_memhotplug.c~catch-notification-of-memory-add-event-of-acpi-via-container-driveravoid-redundant-call-add_memory drivers/acpi/acpi_memhotplug.c
--- a/drivers/acpi/acpi_memhotplug.c~catch-notification-of-memory-add-event-of-acpi-via-container-driveravoid-redundant-call-add_memory
+++ a/drivers/acpi/acpi_memhotplug.c
@@ -234,6 +234,17 @@ static int acpi_memory_enable_device(str
 	 * (i.e. memory-hot-remove function)
 	 */
 	list_for_each_entry(info, &mem_device->res_list, list) {
+		u64 start_pfn, end_pfn;
+
+		start_pfn = info->start_addr >> PAGE_SHIFT;
+		end_pfn = (info->start_addr + info->length - 1) >> PAGE_SHIFT;
+
+		if (pfn_valid(start_pfn) || pfn_valid(end_pfn)) {
+			/* already enabled. try next area */
+			num_enabled++;
+			continue;
+		}
+
 		result = add_memory(info->start_addr, info->length);
 		if (result)
 			continue;
_
