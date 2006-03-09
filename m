From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [BUGFIX][PATCH] fix acpi memory hotplug cannot manage _CRS with
 plural resoureces
Date: Thu, 9 Mar 2006 15:52:19 +0900
Message-ID: <20060309155219.5178799b.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:63689 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751713AbWCIGxE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:04 -0500
Received: from m7.gw.fujitsu.co.jp ([10.0.50.77])
        by fgwmail5.fujitsu.co.jp (Fujitsu Gateway)
        with ESMTP id k296r3YO030016 for <linux-acpi@vger.kernel.org>; Thu, 9 Mar 2006 15:53:03 +0900
        (envelope-from kamezawa.hiroyu@jp.fujitsu.com)
Received: from s0.gw.fujitsu.co.jp by m7.gw.fujitsu.co.jp (8.12.10/Fujitsu Domain Master)
	id k296r2Wg008593 for <linux-acpi@vger.kernel.org>; Thu, 9 Mar 2006 15:53:02 +0900
	(envelope-from kamezawa.hiroyu@jp.fujitsu.com)
Received: from s0.gw.fujitsu.co.jp (s0 [127.0.0.1])
	by s0.gw.fujitsu.co.jp (Postfix) with ESMTP id D760A32C1BC
	for <linux-acpi@vger.kernel.org>; Thu,  9 Mar 2006 15:53:01 +0900 (JST)
Received: from ml6.s.css.fujitsu.com (ml6.s.css.fujitsu.com [10.23.4.196])
	by s0.gw.fujitsu.co.jp (Postfix) with ESMTP id 28FA732C266
	for <linux-acpi@vger.kernel.org>; Thu,  9 Mar 2006 15:53:01 +0900 (JST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI <linux-acpi@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>

Hi,
Currently, I'm testing memory hot add on a big machine which supports
acpi memory hotplug.
I found there is the case which Memory Device's _CRS contains plural 
resources. This is because of requirements of Windows.
Current code cannot manage plural _CRS. This patch fixes it.

-- Kame
==
This patch fixes BUG in acpi memory hotplug.

Current acpi memory hotplug just look into the first entry of resources 
in _CRS. But, _CRS can contain plural resources.
So, if _CRS contains plural resoureces, acpi memory hot add cannot add
all memory.

By this patch, acpi memory hotplug can deal with Memory Device, whose
_CRS contains plural resources.

Tested on ia64 memory hotplug test envrionment (not emulation, uses
alpha version firmware which supports dynamic reconfiguration of NUMA.)

Note: Microsoft's Windows Server 2003 requires big (>4G)resoureces to be
      divided into small (<4G) resources. looks crazy, but not invalid.
      (See http://www.microsoft.com/whdc/system/pnppwr/hotadd/hotaddmem.mspx)
      For this reason, a firmware vendor who supports Windows writes plural
      resoureces in a _CRS even if they are contiguous.

Signed-Off-By: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

---
 drivers/acpi/acpi_memhotplug.c |  100 +++++++++++++++++++++++++++++------------
 1 files changed, 73 insertions(+), 27 deletions(-)

Index: linux-2.6.16-rc5-mm2/drivers/acpi/acpi_memhotplug.c
===================================================================
Index: linux-2.6.16-rc5-mm3/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.16-rc5-mm3.orig/drivers/acpi/acpi_memhotplug.c	2006-03-09 14:56:16.000000000 +0900
+++ linux-2.6.16-rc5-mm3/drivers/acpi/acpi_memhotplug.c	2006-03-09 14:58:29.000000000 +0900
@@ -68,44 +68,76 @@
 		},
 };
 
+struct acpi_memory_info {
+	struct list_head list;
+	u64 start_addr;		/* Memory Range start physical addr */
+	u64 length;		/* Memory Range length */
+	unsigned short caching;	/* memory cache attribute */
+	unsigned short write_protect;	/* memory read/write attribute */
+	unsigned int enabled:1;
+};
+
 struct acpi_memory_device {
 	acpi_handle handle;
 	unsigned int state;	/* State of the memory device */
-	unsigned short caching;	/* memory cache attribute */
-	unsigned short write_protect;	/* memory read/write attribute */
-	u64 start_addr;		/* Memory Range start physical addr */
-	u64 length;		/* Memory Range length */
+	struct list_head res_list;
 };
 
+static acpi_status
+acpi_memory_get_resource(struct acpi_resource *resource, void *context)
+{
+	struct acpi_memory_device *mem_device = context;
+	struct acpi_resource_address64 address64;
+	struct acpi_memory_info *info, *new;
+	acpi_status status;
+
+	status = acpi_resource_to_address64(resource, &address64);
+	if (ACPI_FAILURE(status) ||
+	    (address64.resource_type != ACPI_MEMORY_RANGE))
+		return AE_OK;
+
+	list_for_each_entry(info, &mem_device->res_list, list) {
+		/* Can we combine the resource range information? */
+		if ((info->caching == address64.info.mem.caching) &&
+		    (info->write_protect == address64.info.mem.write_protect) &&
+		    (info->start_addr + info->length == address64.minimum)) {
+			info->length += address64.address_length;
+			return AE_OK;
+		}
+	}
+
+	new = acpi_os_allocate(sizeof(struct acpi_memory_info));
+	if (!new)
+		return AE_ERROR;
+
+	memset(new, 0, sizeof(*new));
+	INIT_LIST_HEAD(&new->list);
+	new->caching = address64.info.mem.caching;
+	new->write_protect = address64.info.mem.write_protect;
+	new->start_addr = address64.minimum;
+	new->length = address64.address_length;
+	list_add_tail(&new->list, &mem_device->res_list);
+
+	return AE_OK;
+}
+
 static int
 acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)
 {
 	acpi_status status;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_resource *resource = NULL;
-	struct acpi_resource_address64 address64;
+	struct acpi_memory_info *info, *n;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_get_device_resources");
 
 	/* Get the range from the _CRS */
-	status = acpi_get_current_resources(mem_device->handle, &buffer);
-	if (ACPI_FAILURE(status))
+	status = acpi_walk_resources(mem_device->handle, METHOD_NAME__CRS,
+				     acpi_memory_get_resource, mem_device);
+	if (ACPI_FAILURE(status)) {
+		list_for_each_entry_safe(info, n, &mem_device->res_list, list)
+			acpi_os_free(info);
 		return_VALUE(-EINVAL);
-
-	resource = (struct acpi_resource *)buffer.pointer;
-	status = acpi_resource_to_address64(resource, &address64);
-	if (ACPI_SUCCESS(status)) {
-		if (address64.resource_type == ACPI_MEMORY_RANGE) {
-			/* Populate the structure */
-			mem_device->caching = address64.info.mem.caching;
-			mem_device->write_protect =
-			    address64.info.mem.write_protect;
-			mem_device->start_addr = address64.minimum;
-			mem_device->length = address64.address_length;
-		}
 	}
 
-	acpi_os_free(buffer.pointer);
 	return_VALUE(0);
 }
 
@@ -180,7 +212,8 @@
 
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
-	int result;
+	int result, num_enabled = 0;
+	struct acpi_memory_info *info;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
 
@@ -195,12 +228,21 @@
 	/*
 	 * Tell the VM there is more memory here...
 	 * Note: Assume that this function returns zero on success
+    	 * We don't have memory-hot-add rollback function,now.
+         * (i.e. memory-hot-remove function)
 	 */
-	result = add_memory(mem_device->start_addr, mem_device->length);
-	if (result) {
+	list_for_each_entry(info, &mem_device->res_list, list) {
+		result = add_memory(info->start_addr, info->length);
+		if (result)
+			continue;
+		info->enabled = 1;
+		num_enabled++;
+	}
+
+	if (!num_enabled) {
 		ACPI_ERROR((AE_INFO, "add_memory failed"));
 		mem_device->state = MEMORY_INVALID_STATE;
-		return result;
+		return -EINVAL;
 	}
 
 	return result;
@@ -244,8 +286,7 @@
 static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
 {
 	int result;
-	u64 start = mem_device->start_addr;
-	u64 len = mem_device->length;
+	struct acpi_memory_info *info, *n;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
 
@@ -253,9 +294,14 @@
 	 * Ask the VM to offline this memory range.
 	 * Note: Assume that this function returns zero on success
 	 */
-	result = remove_memory(start, len);
-	if (result)
-		return_VALUE(result);
+	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
+		if (info->enabled) {
+			result = remove_memory(info->start_addr, info->length);
+			if (result)
+				return_VALUE(result);
+		}
+		acpi_os_free(info);
+	}
 
 	/* Power-off and eject the device */
 	result = acpi_memory_powerdown_device(mem_device);
@@ -347,6 +393,7 @@
 		return_VALUE(-ENOMEM);
 	memset(mem_device, 0, sizeof(struct acpi_memory_device));
 
+	INIT_LIST_HEAD(&mem_device->res_list);
 	mem_device->handle = device->handle;
 	sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
 	sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
