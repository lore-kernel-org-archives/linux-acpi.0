From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 1/7 v2] fix memory leak when memory device is unbound from
 the module acpi_memhotplug
Date: Wed, 11 Jul 2012 15:47:02 +0800
Message-ID: <4FFD2F76.9000508@cn.fujitsu.com>
References: <4FFD2F1E.10006@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:30134 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756490Ab2GKHm1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jul 2012 03:42:27 -0400
In-Reply-To: <4FFD2F1E.10006@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

We allocate memory to store acpi_memory_info, so we should free it before
freeing mem_device.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index d985713..fe699ec 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -125,12 +125,20 @@ acpi_memory_get_resource(struct acpi_resource *resource, void *context)
 	return AE_OK;
 }
 
+static void
+acpi_memory_free_device_resources(struct acpi_memory_device *mem_device)
+{
+	struct acpi_memory_info *info, *n;
+
+	list_for_each_entry_safe(info, n, &mem_device->res_list, list)
+		kfree(info);
+	INIT_LIST_HEAD(&mem_device->res_list);
+}
+
 static int
 acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)
 {
 	acpi_status status;
-	struct acpi_memory_info *info, *n;
-
 
 	if (!list_empty(&mem_device->res_list))
 		return 0;
@@ -138,9 +146,7 @@ acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)
 	status = acpi_walk_resources(mem_device->device->handle, METHOD_NAME__CRS,
 				     acpi_memory_get_resource, mem_device);
 	if (ACPI_FAILURE(status)) {
-		list_for_each_entry_safe(info, n, &mem_device->res_list, list)
-			kfree(info);
-		INIT_LIST_HEAD(&mem_device->res_list);
+		acpi_memory_free_device_resources(mem_device);
 		return -EINVAL;
 	}
 
@@ -399,6 +405,15 @@ static void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
 	return;
 }
 
+static void acpi_memory_device_free(struct acpi_memory_device *mem_device)
+{
+	if (!mem_device)
+		return;
+
+	acpi_memory_free_device_resources(mem_device);
+	kfree(mem_device);
+}
+
 static int acpi_memory_device_add(struct acpi_device *device)
 {
 	int result;
@@ -451,14 +466,10 @@ static int acpi_memory_device_add(struct acpi_device *device)
 
 static int acpi_memory_device_remove(struct acpi_device *device, int type)
 {
-	struct acpi_memory_device *mem_device = NULL;
-
-
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
-	mem_device = acpi_driver_data(device);
-	kfree(mem_device);
+	acpi_memory_device_free(acpi_driver_data(device));
 
 	return 0;
 }
-- 
1.7.1

