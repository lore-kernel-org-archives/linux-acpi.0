From: mochel@linux.intel.com
Subject: [PATCH 2/24] Remove unneeded debugging macros in drivers/acpi/acpi_memhotplug.c
Date: Mon, 17 Apr 2006 18:21:52 -0700
Message-ID: <11453233123014-git-send-email-mochel@linux.intel.com>
References: <11453233122841-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:63928 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932106AbWDRBZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:24 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PNlA026777
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:23 GMT
In-Reply-To: <11453233122841-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/acpi_memhotplug.c |   94 ++++++++++++++--------------------------
 1 files changed, 32 insertions(+), 62 deletions(-)

applies-to: f9df1b6ca25f80dc2ddb21f1f1deff1147a33789
8a1cb494eab655073133b2dbc5c25880f97b49b3
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index e49d327..f43ddde 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -85,12 +85,10 @@ acpi_memory_get_device_resources(struct 
 	struct acpi_resource *resource = NULL;
 	struct acpi_resource_address64 address64;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_get_device_resources");
-
 	/* Get the range from the _CRS */
 	status = acpi_get_current_resources(mem_device->handle, &buffer);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	resource = (struct acpi_resource *)buffer.pointer;
 	status = acpi_resource_to_address64(resource, &address64);
@@ -106,7 +104,7 @@ acpi_memory_get_device_resources(struct 
 	}
 
 	acpi_os_free(buffer.pointer);
-	return_VALUE(0);
+	return 0;
 }
 
 static int
@@ -118,22 +116,20 @@ acpi_memory_get_device(acpi_handle handl
 	struct acpi_device *device = NULL;
 	struct acpi_device *pdevice = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_get_device");
-
 	if (!acpi_bus_get_device(handle, &device) && device)
 		goto end;
 
 	status = acpi_get_parent(handle, &phandle);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Cannot find acpi parent"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
 	/* Get the parent device */
 	status = acpi_bus_get_device(phandle, &pdevice);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Cannot get acpi bus device"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
 	/*
@@ -143,29 +139,27 @@ acpi_memory_get_device(acpi_handle handl
 	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Cannot add acpi bus"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
       end:
 	*mem_device = acpi_driver_data(device);
 	if (!(*mem_device)) {
 		printk(KERN_ERR "\n driver data not found");
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_memory_check_device(struct acpi_memory_device *mem_device)
 {
 	unsigned long current_status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_check_device");
-
 	/* Get device present/absent information from the _STA */
 	if (ACPI_FAILURE(acpi_evaluate_integer(mem_device->handle, "_STA",
 					       NULL, &current_status)))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	/*
 	 * Check for device status. Device should be
 	 * present/enabled/functioning.
@@ -173,17 +167,15 @@ static int acpi_memory_check_device(stru
 	if (!((current_status & ACPI_MEMORY_STA_PRESENT)
 	      && (current_status & ACPI_MEMORY_STA_ENABLED)
 	      && (current_status & ACPI_MEMORY_STA_FUNCTIONAL)))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
 	int result;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
-
 	/* Get the range from the _CRS */
 	result = acpi_memory_get_device_resources(mem_device);
 	if (result) {
@@ -213,8 +205,6 @@ static int acpi_memory_powerdown_device(
 	union acpi_object arg;
 	unsigned long current_status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_powerdown_device");
-
 	/* Issue the _EJ0 command */
 	arg_list.count = 1;
 	arg_list.pointer = &arg;
@@ -225,20 +215,20 @@ static int acpi_memory_powerdown_device(
 	/* Return on _EJ0 failure */
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "_EJ0 failed"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	/* Evalute _STA to check if the device is disabled */
 	status = acpi_evaluate_integer(mem_device->handle, "_STA",
 				       NULL, &current_status);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	/* Check for device status.  Device should be disabled */
 	if (current_status & ACPI_MEMORY_STA_ENABLED)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
@@ -247,15 +237,13 @@ static int acpi_memory_disable_device(st
 	u64 start = mem_device->start_addr;
 	u64 len = mem_device->length;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
-
 	/*
 	 * Ask the VM to offline this memory range.
 	 * Note: Assume that this function returns zero on success
 	 */
 	result = remove_memory(start, len);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	/* Power-off and eject the device */
 	result = acpi_memory_powerdown_device(mem_device);
@@ -274,8 +262,6 @@ static void acpi_memory_device_notify(ac
 	struct acpi_memory_device *mem_device;
 	struct acpi_device *device;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_device_notify");
-
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -287,7 +273,7 @@ static void acpi_memory_device_notify(ac
 					  "\nReceived DEVICE CHECK notification for device\n"));
 		if (acpi_memory_get_device(handle, &mem_device)) {
 			ACPI_ERROR((AE_INFO, "Cannot find driver data"));
-			return_VOID;
+			return;
 		}
 
 		if (!acpi_memory_check_device(mem_device)) {
@@ -329,7 +315,6 @@ static void acpi_memory_device_notify(ac
 		break;
 	}
 
-	return_VOID;
 }
 
 static int acpi_memory_device_add(struct acpi_device *device)
@@ -337,14 +322,12 @@ static int acpi_memory_device_add(struct
 	int result;
 	struct acpi_memory_device *mem_device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_device_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
 	if (!mem_device)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(mem_device, 0, sizeof(struct acpi_memory_device));
 
 	mem_device->handle = device->handle;
@@ -356,7 +339,7 @@ static int acpi_memory_device_add(struct
 	result = acpi_memory_get_device_resources(mem_device);
 	if (result) {
 		kfree(mem_device);
-		return_VALUE(result);
+		return result;
 	}
 
 	/* Set the device state */
@@ -364,22 +347,20 @@ static int acpi_memory_device_add(struct
 
 	printk(KERN_INFO "%s \n", acpi_device_name(device));
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_memory_device_remove(struct acpi_device *device, int type)
 {
 	struct acpi_memory_device *mem_device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_device_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	mem_device = (struct acpi_memory_device *)acpi_driver_data(device);
 	kfree(mem_device);
 
-	return_VALUE(0);
+	return 0;
 }
 
 /*
@@ -392,16 +373,14 @@ static acpi_status is_memory_device(acpi
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_device_info *info;
 
-	ACPI_FUNCTION_TRACE("is_memory_device");
-
 	status = acpi_get_object_info(handle, &buffer);
 	if (ACPI_FAILURE(status))
-		return_ACPI_STATUS(status);
+		return status;
 
 	info = buffer.pointer;
 	if (!(info->valid & ACPI_VALID_HID)) {
 		acpi_os_free(buffer.pointer);
-		return_ACPI_STATUS(AE_ERROR);
+		return AE_ERROR;
 	}
 
 	hardware_id = info->hardware_id.value;
@@ -410,7 +389,7 @@ static acpi_status is_memory_device(acpi
 		status = AE_ERROR;
 
 	acpi_os_free(buffer.pointer);
-	return_ACPI_STATUS(status);
+	return status;
 }
 
 static acpi_status
@@ -419,18 +398,16 @@ acpi_memory_register_notify_handler(acpi
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_register_notify_handler");
-
 	status = is_memory_device(handle);
 	if (ACPI_FAILURE(status)){
 		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
-		return_ACPI_STATUS(AE_OK);	/* continue */
+		return AE_OK;	/* continue */
 	}
 
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 					     acpi_memory_device_notify, NULL);
 	/* continue */
-	return_ACPI_STATUS(AE_OK);
+	return AE_OK;
 }
 
 static acpi_status
@@ -439,19 +416,17 @@ acpi_memory_deregister_notify_handler(ac
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_deregister_notify_handler");
-
 	status = is_memory_device(handle);
 	if (ACPI_FAILURE(status)){
 		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
-		return_ACPI_STATUS(AE_OK);	/* continue */
+		return AE_OK;	/* continue */
 	}
 
 	status = acpi_remove_notify_handler(handle,
 					    ACPI_SYSTEM_NOTIFY,
 					    acpi_memory_device_notify);
 
-	return_ACPI_STATUS(AE_OK);	/* continue */
+	return AE_OK;	/* continue */
 }
 
 static int __init acpi_memory_device_init(void)
@@ -459,12 +434,10 @@ static int __init acpi_memory_device_ini
 	int result;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_device_init");
-
 	result = acpi_bus_register_driver(&acpi_memory_device_driver);
 
 	if (result < 0)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
@@ -474,18 +447,16 @@ static int __init acpi_memory_device_ini
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
 		acpi_bus_unregister_driver(&acpi_memory_device_driver);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_memory_device_exit(void)
 {
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("acpi_memory_device_exit");
-
 	/*
 	 * Adding this to un-install notification handlers for all the device
 	 * handles.
@@ -500,7 +471,6 @@ static void __exit acpi_memory_device_ex
 
 	acpi_bus_unregister_driver(&acpi_memory_device_driver);
 
-	return_VOID;
 }
 
 module_init(acpi_memory_device_init);
---
0.99.9.GIT


