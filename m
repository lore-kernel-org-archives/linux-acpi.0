From: mochel@linux.intel.com
Subject: [PATCH 6/24] Remove unneeded debugging macros in drivers/acpi/container.c
Date: Mon, 17 Apr 2006 18:21:53 -0700
Message-ID: <11453233133413-git-send-email-mochel@linux.intel.com>
References: <11453233132637-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:59535 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932111AbWDRBZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:24 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1POBH025137
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:24 GMT
In-Reply-To: <11453233132637-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/container.c |   38 ++++++++++++--------------------------
 1 files changed, 12 insertions(+), 26 deletions(-)

applies-to: 73d9b0c49efb5a10ba623dadd70e60b2b2b78e7b
8aa5c2456d03e6bcdc829259e69f36e2977fcd06
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 53625fc..f6fe32a 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -73,17 +73,15 @@ static int is_device_present(acpi_handle
 	acpi_status status;
 	unsigned long sta;
 
-	ACPI_FUNCTION_TRACE("is_device_present");
-
 	status = acpi_get_handle(handle, "_STA", &temp);
 	if (ACPI_FAILURE(status))
-		return_VALUE(1);	/* _STA not found, assmue device present */
+		return 1;	/* _STA not found, assmue device present */
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status))
-		return_VALUE(0);	/* Firmware error */
+		return 0;	/* Firmware error */
 
-	return_VALUE((sta & ACPI_STA_PRESENT) == ACPI_STA_PRESENT);
+	return (sta & ACPI_STA_PRESENT) == ACPI_STA_PRESENT;
 }
 
 /*******************************************************************/
@@ -91,16 +89,14 @@ static int acpi_container_add(struct acp
 {
 	struct acpi_container *container;
 
-	ACPI_FUNCTION_TRACE("acpi_container_add");
-
 	if (!device) {
 		ACPI_ERROR((AE_INFO, "device is NULL"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
 	container = kmalloc(sizeof(struct acpi_container), GFP_KERNEL);
 	if (!container)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 
 	memset(container, 0, sizeof(struct acpi_container));
 	container->handle = device->handle;
@@ -111,7 +107,7 @@ static int acpi_container_add(struct acp
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device <%s> bid <%s>\n",
 			  acpi_device_name(device), acpi_device_bid(device)));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_container_remove(struct acpi_device *device, int type)
@@ -130,23 +126,21 @@ static int container_device_add(struct a
 	struct acpi_device *pdev;
 	int result;
 
-	ACPI_FUNCTION_TRACE("container_device_add");
-
 	if (acpi_get_parent(handle, &phandle)) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	if (acpi_bus_get_device(phandle, &pdev)) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	if (acpi_bus_add(device, pdev, handle, ACPI_BUS_TYPE_DEVICE)) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	result = acpi_bus_start(*device);
 
-	return_VALUE(result);
+	return result;
 }
 
 static void container_notify_cb(acpi_handle handle, u32 type, void *context)
@@ -156,8 +150,6 @@ static void container_notify_cb(acpi_han
 	int present;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("container_notify_cb");
-
 	present = is_device_present(handle);
 
 	switch (type) {
@@ -192,7 +184,6 @@ static void container_notify_cb(acpi_han
 	default:
 		break;
 	}
-	return_VOID;
 }
 
 static acpi_status
@@ -205,11 +196,9 @@ container_walk_namespace_cb(acpi_handle 
 	acpi_status status;
 	int *action = context;
 
-	ACPI_FUNCTION_TRACE("container_walk_namespace_cb");
-
 	status = acpi_get_object_info(handle, &buffer);
 	if (ACPI_FAILURE(status) || !buffer.pointer) {
-		return_ACPI_STATUS(AE_OK);
+		return AE_OK;
 	}
 
 	info = buffer.pointer;
@@ -243,7 +232,7 @@ container_walk_namespace_cb(acpi_handle 
       end:
 	acpi_os_free(buffer.pointer);
 
-	return_ACPI_STATUS(AE_OK);
+	return AE_OK;
 }
 
 static int __init acpi_container_init(void)
@@ -269,8 +258,6 @@ static void __exit acpi_container_exit(v
 {
 	int action = UNINSTALL_NOTIFY_HANDLER;
 
-	ACPI_FUNCTION_TRACE("acpi_container_exit");
-
 	acpi_walk_namespace(ACPI_TYPE_DEVICE,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
@@ -278,7 +265,6 @@ static void __exit acpi_container_exit(v
 
 	acpi_bus_unregister_driver(&acpi_container_driver);
 
-	return_VOID;
 }
 
 module_init(acpi_container_init);
---
0.99.9.GIT


