From: mochel@linux.intel.com
Subject: [PATCH 17/24] Remove unneeded debugging macros in drivers/acpi/power.c
Date: Mon, 17 Apr 2006 18:21:54 -0700
Message-ID: <11453233141558-git-send-email-mochel@linux.intel.com>
References: <11453233144190-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:45725 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932128AbWDRBZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:26 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PPer030533
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:25 GMT
In-Reply-To: <11453233144190-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/power.c |  140 ++++++++++++++++++++------------------------------
 1 files changed, 55 insertions(+), 85 deletions(-)

applies-to: bbcbce350a6c83f5c0e5d95111a3ea77adedabed
b65bba570994c73ce90561b3e260aaca41f05bb8
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 5712803..aaefc12 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -98,22 +98,20 @@ acpi_power_get_context(acpi_handle handl
 	int result = 0;
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_power_get_context");
-
 	if (!resource)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		ACPI_WARNING((AE_INFO, "Getting context [%p]", handle));
-		return_VALUE(result);
+		return result;
 	}
 
 	*resource = (struct acpi_power_resource *)acpi_driver_data(device);
 	if (!resource)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_power_get_state(struct acpi_power_resource *resource)
@@ -121,14 +119,12 @@ static int acpi_power_get_state(struct a
 	acpi_status status = AE_OK;
 	unsigned long sta = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_power_get_state");
-
 	if (!resource)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	status = acpi_evaluate_integer(resource->handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	if (sta & 0x01)
 		resource->state = ACPI_POWER_RESOURCE_STATE_ON;
@@ -138,7 +134,7 @@ static int acpi_power_get_state(struct a
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
 			  resource->name, resource->state ? "on" : "off"));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
@@ -147,20 +143,18 @@ static int acpi_power_get_list_state(str
 	struct acpi_power_resource *resource = NULL;
 	u32 i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_power_get_list_state");
-
 	if (!list || !state)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* The state of the list is 'on' IFF all resources are 'on'. */
 
 	for (i = 0; i < list->count; i++) {
 		result = acpi_power_get_context(list->handles[i], &resource);
 		if (result)
-			return_VALUE(result);
+			return result;
 		result = acpi_power_get_state(resource);
 		if (result)
-			return_VALUE(result);
+			return result;
 
 		*state = resource->state;
 
@@ -171,7 +165,7 @@ static int acpi_power_get_list_state(str
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource list is %s\n",
 			  *state ? "on" : "off"));
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_power_on(acpi_handle handle)
@@ -181,11 +175,9 @@ static int acpi_power_on(acpi_handle han
 	struct acpi_device *device = NULL;
 	struct acpi_power_resource *resource = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_power_on");
-
 	result = acpi_power_get_context(handle, &resource);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	resource->references++;
 
@@ -193,29 +185,29 @@ static int acpi_power_on(acpi_handle han
 	    || (resource->state == ACPI_POWER_RESOURCE_STATE_ON)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] already on\n",
 				  resource->name));
-		return_VALUE(0);
+		return 0;
 	}
 
 	status = acpi_evaluate_object(resource->handle, "_ON", NULL, NULL);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	result = acpi_power_get_state(resource);
 	if (result)
-		return_VALUE(result);
+		return result;
 	if (resource->state != ACPI_POWER_RESOURCE_STATE_ON)
-		return_VALUE(-ENOEXEC);
+		return -ENOEXEC;
 
 	/* Update the power resource's _device_ power state */
 	result = acpi_bus_get_device(resource->handle, &device);
 	if (result)
-		return_VALUE(result);
+		return result;
 	device->power.state = ACPI_STATE_D0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] turned on\n",
 			  resource->name));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_power_off_device(acpi_handle handle)
@@ -225,11 +217,9 @@ static int acpi_power_off_device(acpi_ha
 	struct acpi_device *device = NULL;
 	struct acpi_power_resource *resource = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_power_off_device");
-
 	result = acpi_power_get_context(handle, &resource);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	if (resource->references)
 		resource->references--;
@@ -238,35 +228,35 @@ static int acpi_power_off_device(acpi_ha
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Resource [%s] is still in use, dereferencing\n",
 				  device->pnp.bus_id));
-		return_VALUE(0);
+		return 0;
 	}
 
 	if (resource->state == ACPI_POWER_RESOURCE_STATE_OFF) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] already off\n",
 				  device->pnp.bus_id));
-		return_VALUE(0);
+		return 0;
 	}
 
 	status = acpi_evaluate_object(resource->handle, "_OFF", NULL, NULL);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	result = acpi_power_get_state(resource);
 	if (result)
-		return_VALUE(result);
+		return result;
 	if (resource->state != ACPI_POWER_RESOURCE_STATE_OFF)
-		return_VALUE(-ENOEXEC);
+		return -ENOEXEC;
 
 	/* Update the power resource's _device_ power state */
 	result = acpi_bus_get_device(resource->handle, &device);
 	if (result)
-		return_VALUE(result);
+		return result;
 	device->power.state = ACPI_STATE_D3;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] turned off\n",
 			  resource->name));
 
-	return_VALUE(0);
+	return 0;
 }
 
 /*
@@ -282,9 +272,7 @@ int acpi_enable_wakeup_device_power(stru
 	int i;
 	int ret = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device_power");
-	if (!dev || !dev->wakeup.flags.valid)
-		return_VALUE(-1);
+		return -1;
 
 	arg.integer.value = 1;
 	/* Open power resource */
@@ -293,7 +281,7 @@ int acpi_enable_wakeup_device_power(stru
 		if (ret) {
 			ACPI_ERROR((AE_INFO, "Transition power state"));
 			dev->wakeup.flags.valid = 0;
-			return_VALUE(-1);
+			return -1;
 		}
 	}
 
@@ -305,7 +293,7 @@ int acpi_enable_wakeup_device_power(stru
 		ret = -1;
 	}
 
-	return_VALUE(ret);
+	return ret;
 }
 
 /*
@@ -321,10 +309,8 @@ int acpi_disable_wakeup_device_power(str
 	int i;
 	int ret = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_disable_wakeup_device_power");
-
 	if (!dev || !dev->wakeup.flags.valid)
-		return_VALUE(-1);
+		return -1;
 
 	arg.integer.value = 0;
 	/* Execute PSW */
@@ -332,7 +318,7 @@ int acpi_disable_wakeup_device_power(str
 	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
 		ACPI_ERROR((AE_INFO, "Evaluate _PSW"));
 		dev->wakeup.flags.valid = 0;
-		return_VALUE(-1);
+		return -1;
 	}
 
 	/* Close power resource */
@@ -341,11 +327,11 @@ int acpi_disable_wakeup_device_power(str
 		if (ret) {
 			ACPI_ERROR((AE_INFO, "Transition power state"));
 			dev->wakeup.flags.valid = 0;
-			return_VALUE(-1);
+			return -1;
 		}
 	}
 
-	return_VALUE(ret);
+	return ret;
 }
 
 /* --------------------------------------------------------------------------
@@ -359,10 +345,8 @@ int acpi_power_get_inferred_state(struct
 	int list_state = 0;
 	int i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_power_get_inferred_state");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	device->power.state = ACPI_STATE_UNKNOWN;
 
@@ -377,17 +361,17 @@ int acpi_power_get_inferred_state(struct
 
 		result = acpi_power_get_list_state(list, &list_state);
 		if (result)
-			return_VALUE(result);
+			return result;
 
 		if (list_state == ACPI_POWER_RESOURCE_STATE_ON) {
 			device->power.state = i;
-			return_VALUE(0);
+			return 0;
 		}
 	}
 
 	device->power.state = ACPI_STATE_D3;
 
-	return_VALUE(0);
+	return 0;
 }
 
 int acpi_power_transition(struct acpi_device *device, int state)
@@ -397,14 +381,12 @@ int acpi_power_transition(struct acpi_de
 	struct acpi_handle_list *tl = NULL;	/* Target Resources */
 	int i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_power_transition");
-
 	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if ((device->power.state < ACPI_STATE_D0)
 	    || (device->power.state > ACPI_STATE_D3))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	cl = &device->power.states[device->power.state].resources;
 	tl = &device->power.states[state].resources;
@@ -444,7 +426,7 @@ int acpi_power_transition(struct acpi_de
 		ACPI_WARNING((AE_INFO, "Transitioning device [%s] to D%d",
 			      device->pnp.bus_id, state));
 
-	return_VALUE(result);
+	return result;
 }
 
 /* --------------------------------------------------------------------------
@@ -457,8 +439,6 @@ static int acpi_power_seq_show(struct se
 {
 	struct acpi_power_resource *resource = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_power_seq_show");
-
 	resource = (struct acpi_power_resource *)seq->private;
 
 	if (!resource)
@@ -484,7 +464,7 @@ static int acpi_power_seq_show(struct se
 		   resource->order, resource->references);
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_power_open_fs(struct inode *inode, struct file *file)
@@ -496,35 +476,31 @@ static int acpi_power_add_fs(struct acpi
 {
 	struct proc_dir_entry *entry = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_power_add_fs");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_power_dir);
 		if (!acpi_device_dir(device))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 	}
 
 	/* 'status' [R] */
 	entry = create_proc_entry(ACPI_POWER_FILE_STATUS,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-EIO);
+		return -EIO;
 	else {
 		entry->proc_fops = &acpi_power_fops;
 		entry->data = acpi_driver_data(device);
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_power_remove_fs(struct acpi_device *device)
 {
-	ACPI_FUNCTION_TRACE("acpi_power_remove_fs");
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(ACPI_POWER_FILE_STATUS,
 				  acpi_device_dir(device));
@@ -532,7 +508,7 @@ static int acpi_power_remove_fs(struct a
 		acpi_device_dir(device) = NULL;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* --------------------------------------------------------------------------
@@ -547,14 +523,12 @@ static int acpi_power_add(struct acpi_de
 	union acpi_object acpi_object;
 	struct acpi_buffer buffer = { sizeof(acpi_object), &acpi_object };
 
-	ACPI_FUNCTION_TRACE("acpi_power_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	resource = kmalloc(sizeof(struct acpi_power_resource), GFP_KERNEL);
 	if (!resource)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(resource, 0, sizeof(struct acpi_power_resource));
 
 	resource->handle = device->handle;
@@ -599,17 +573,15 @@ static int acpi_power_add(struct acpi_de
 	if (result)
 		kfree(resource);
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_power_remove(struct acpi_device *device, int type)
 {
 	struct acpi_power_resource *resource = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_power_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	resource = (struct acpi_power_resource *)acpi_driver_data(device);
 
@@ -617,31 +589,29 @@ static int acpi_power_remove(struct acpi
 
 	kfree(resource);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int __init acpi_power_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_power_init");
-
 	if (acpi_disabled)
-		return_VALUE(0);
+		return 0;
 
 	INIT_LIST_HEAD(&acpi_power_resource_list);
 
 	acpi_power_dir = proc_mkdir(ACPI_POWER_CLASS, acpi_root_dir);
 	if (!acpi_power_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	result = acpi_bus_register_driver(&acpi_power_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_POWER_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 subsys_initcall(acpi_power_init);
---
0.99.9.GIT


