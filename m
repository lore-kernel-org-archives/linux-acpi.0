From: akpm@osdl.org
Subject: [patch 05/13] acpi memory hotplug cannot manage _CRS with plural resoureces
Date: Mon, 10 Apr 2006 23:16:54 -0700
Message-ID: <200604110717.k3B7HZPG014908@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:35204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932308AbWDKHRk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Apr 2006 03:17:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, kamezawa.hiroyu@jp.fujitsu.com, kaneshige.kenji@jp.fujitsu.com


From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Current acpi memory hotplug just looks into the first entry of resources in
_CRS.  But, _CRS can contain plural resources.  So, if _CRS contains plural
resoureces, acpi memory hot add cannot add all memory.

With this patch, acpi memory hotplug can deal with Memory Device, whose
_CRS contains plural resources.

Tested on ia64 memory hotplug test envrionment (not emulation, uses alpha
version firmware which supports dynamic reconfiguration of NUMA.)

Note: Microsoft's Windows Server 2003 requires big (>4G)resoureces to be
      divided into small (<4G) resources. looks crazy, but not invalid.
      (See http://www.microsoft.com/whdc/system/pnppwr/hotadd/hotaddmem.mspx)
      For this reason, a firmware vendor who supports Windows writes plural
      resources in a _CRS even if they are contiguous.

[akpm@osdl.org: export acpi_os_allocate]
Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/acpi_memhotplug.c |  108 ++++++++++++++++++++++---------
 drivers/acpi/osl.c             |    1 
 2 files changed, 78 insertions(+), 31 deletions(-)

diff -puN drivers/acpi/acpi_memhotplug.c~acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces drivers/acpi/acpi_memhotplug.c
--- devel/drivers/acpi/acpi_memhotplug.c~acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces	2006-04-10 23:16:20.000000000 -0700
+++ devel-akpm/drivers/acpi/acpi_memhotplug.c	2006-04-10 23:16:20.000000000 -0700
@@ -68,44 +68,75 @@ static struct acpi_driver acpi_memory_de
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
+	new = kzalloc(sizeof(struct acpi_memory_info), GFP_KERNEL);
+	if (!new)
+		return AE_ERROR;
+
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
+			kfree(info);
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
 
@@ -180,7 +211,8 @@ static int acpi_memory_check_device(stru
 
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
-	int result;
+	int result, num_enabled = 0;
+	struct acpi_memory_info *info;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
 
@@ -195,12 +227,21 @@ static int acpi_memory_enable_device(str
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
@@ -244,8 +285,7 @@ static int acpi_memory_powerdown_device(
 static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
 {
 	int result;
-	u64 start = mem_device->start_addr;
-	u64 len = mem_device->length;
+	struct acpi_memory_info *info, *n;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
 
@@ -253,9 +293,14 @@ static int acpi_memory_disable_device(st
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
+		kfree(info);
+	}
 
 	/* Power-off and eject the device */
 	result = acpi_memory_powerdown_device(mem_device);
@@ -347,6 +392,7 @@ static int acpi_memory_device_add(struct
 		return_VALUE(-ENOMEM);
 	memset(mem_device, 0, sizeof(struct acpi_memory_device));
 
+	INIT_LIST_HEAD(&mem_device->res_list);
 	mem_device->handle = device->handle;
 	sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
 	sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
diff -puN drivers/acpi/osl.c~acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces drivers/acpi/osl.c
--- devel/drivers/acpi/osl.c~acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces	2006-04-10 23:16:20.000000000 -0700
+++ devel-akpm/drivers/acpi/osl.c	2006-04-10 23:16:20.000000000 -0700
@@ -145,6 +145,7 @@ void *acpi_os_allocate(acpi_size size)
 	else
 		return kmalloc(size, GFP_KERNEL);
 }
+EXPORT_SYMBOL(acpi_os_allocate);
 
 void acpi_os_free(void *ptr)
 {
_
