From: mochel@linux.intel.com
Subject: [PATCH 4/24] Remove unneeded debugging macros in drivers/acpi/bus.c
Date: Mon, 17 Apr 2006 18:21:52 -0700
Message-ID: <11453233121169-git-send-email-mochel@linux.intel.com>
References: <1145323312569-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:59279 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932109AbWDRBZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:24 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1POBH025133
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:24 GMT
In-Reply-To: <1145323312569-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/bus.c |  115 +++++++++++++++++++---------------------------------
 1 files changed, 43 insertions(+), 72 deletions(-)

applies-to: d6feb0bf3c33e3c8b465b7ff6f5c515b0da5bb37
fcd1437241f3799f37ea16c9c37c415ff1b94781
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index bb7c4cb..ffee3ae 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -60,20 +60,18 @@ int acpi_bus_get_device(acpi_handle hand
 {
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_get_device");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* TBD: Support fixed-feature devices */
 
 	status = acpi_get_data(handle, acpi_bus_data_handler, (void **)device);
 	if (ACPI_FAILURE(status) || !*device) {
 		ACPI_EXCEPTION((AE_INFO, status, "No context for object [%p]", handle));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 EXPORT_SYMBOL(acpi_bus_get_device);
@@ -83,10 +81,8 @@ int acpi_bus_get_status(struct acpi_devi
 	acpi_status status = AE_OK;
 	unsigned long sta = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_get_status");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/*
 	 * Evaluate _STA if present.
@@ -95,7 +91,7 @@ int acpi_bus_get_status(struct acpi_devi
 		status =
 		    acpi_evaluate_integer(device->handle, "_STA", NULL, &sta);
 		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 		STRUCT_TO_INT(device->status) = (int)sta;
 	}
 
@@ -119,7 +115,7 @@ int acpi_bus_get_status(struct acpi_devi
 			  device->pnp.bus_id,
 			  (u32) STRUCT_TO_INT(device->status)));
 
-	return_VALUE(0);
+	return 0;
 }
 
 EXPORT_SYMBOL(acpi_bus_get_status);
@@ -135,11 +131,9 @@ int acpi_bus_get_power(acpi_handle handl
 	struct acpi_device *device = NULL;
 	unsigned long psc = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_get_power");
-
 	result = acpi_bus_get_device(handle, &device);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	*state = ACPI_STATE_UNKNOWN;
 
@@ -158,12 +152,12 @@ int acpi_bus_get_power(acpi_handle handl
 			status = acpi_evaluate_integer(device->handle, "_PSC",
 						       NULL, &psc);
 			if (ACPI_FAILURE(status))
-				return_VALUE(-ENODEV);
+				return -ENODEV;
 			device->power.state = (int)psc;
 		} else if (device->power.flags.power_resources) {
 			result = acpi_power_get_inferred_state(device);
 			if (result)
-				return_VALUE(result);
+				return result;
 		}
 
 		*state = device->power.state;
@@ -172,7 +166,7 @@ int acpi_bus_get_power(acpi_handle handl
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] power state is D%d\n",
 			  device->pnp.bus_id, device->power.state));
 
-	return_VALUE(0);
+	return 0;
 }
 
 EXPORT_SYMBOL(acpi_bus_get_power);
@@ -184,20 +178,18 @@ int acpi_bus_set_power(acpi_handle handl
 	struct acpi_device *device = NULL;
 	char object_name[5] = { '_', 'P', 'S', '0' + state, '\0' };
 
-	ACPI_FUNCTION_TRACE("acpi_bus_set_power");
-
 	result = acpi_bus_get_device(handle, &device);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	if ((state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
 		ACPI_INFO((AE_INFO, "Device is not power manageable"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 	/*
 	 * Get device's current power state if it's unknown
@@ -208,17 +200,17 @@ int acpi_bus_set_power(acpi_handle handl
 	if (state == device->power.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
 				  state));
-		return_VALUE(0);
+		return 0;
 	}
 	if (!device->power.states[state].flags.valid) {
 		ACPI_WARNING((AE_INFO, "Device does not support D%d", state));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 	if (device->parent && (state < device->parent->power.state)) {
 		ACPI_WARNING((AE_INFO,
 			      "Cannot set device to a higher-powered"
 			      " state than parent"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	/*
@@ -268,7 +260,7 @@ int acpi_bus_set_power(acpi_handle handl
 				  "Device [%s] transitioned to D%d\n",
 				  device->pnp.bus_id, state));
 
-	return_VALUE(result);
+	return result;
 }
 
 EXPORT_SYMBOL(acpi_bus_set_power);
@@ -289,18 +281,16 @@ int acpi_bus_generate_event(struct acpi_
 	struct acpi_bus_event *event = NULL;
 	unsigned long flags = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_generate_event");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* drop event on the floor if no one's listening */
 	if (!event_is_open)
-		return_VALUE(0);
+		return 0;
 
 	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
 	if (!event)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 
 	strcpy(event->device_class, device->pnp.device_class);
 	strcpy(event->bus_id, device->pnp.bus_id);
@@ -313,7 +303,7 @@ int acpi_bus_generate_event(struct acpi_
 
 	wake_up_interruptible(&acpi_bus_event_queue);
 
-	return_VALUE(0);
+	return 0;
 }
 
 EXPORT_SYMBOL(acpi_bus_generate_event);
@@ -325,10 +315,8 @@ int acpi_bus_receive_event(struct acpi_b
 
 	DECLARE_WAITQUEUE(wait, current);
 
-	ACPI_FUNCTION_TRACE("acpi_bus_receive_event");
-
 	if (!event)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (list_empty(&acpi_bus_event_list)) {
 
@@ -342,7 +330,7 @@ int acpi_bus_receive_event(struct acpi_b
 		set_current_state(TASK_RUNNING);
 
 		if (signal_pending(current))
-			return_VALUE(-ERESTARTSYS);
+			return -ERESTARTSYS;
 	}
 
 	spin_lock_irqsave(&acpi_bus_event_lock, flags);
@@ -353,13 +341,13 @@ int acpi_bus_receive_event(struct acpi_b
 	spin_unlock_irqrestore(&acpi_bus_event_lock, flags);
 
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	memcpy(event, entry, sizeof(struct acpi_bus_event));
 
 	kfree(entry);
 
-	return_VALUE(0);
+	return 0;
 }
 
 EXPORT_SYMBOL(acpi_bus_receive_event);
@@ -374,10 +362,8 @@ acpi_bus_check_device(struct acpi_device
 	acpi_status status = 0;
 	struct acpi_device_status old_status;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_check_device");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (status_changed)
 		*status_changed = 0;
@@ -394,15 +380,15 @@ acpi_bus_check_device(struct acpi_device
 			if (status_changed)
 				*status_changed = 1;
 		}
-		return_VALUE(0);
+		return 0;
 	}
 
 	status = acpi_bus_get_status(device);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	if (STRUCT_TO_INT(old_status) == STRUCT_TO_INT(device->status))
-		return_VALUE(0);
+		return 0;
 
 	if (status_changed)
 		*status_changed = 1;
@@ -418,7 +404,7 @@ acpi_bus_check_device(struct acpi_device
 		/* TBD: Handle device removal */
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_bus_check_scope(struct acpi_device *device)
@@ -426,25 +412,23 @@ static int acpi_bus_check_scope(struct a
 	int result = 0;
 	int status_changed = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_check_scope");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* Status Change? */
 	result = acpi_bus_check_device(device, &status_changed);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	if (!status_changed)
-		return_VALUE(0);
+		return 0;
 
 	/*
 	 * TBD: Enumerate child devices within this device's scope and
 	 *       run acpi_bus_check_device()'s on them.
 	 */
 
-	return_VALUE(0);
+	return 0;
 }
 
 /**
@@ -457,10 +441,8 @@ static void acpi_bus_notify(acpi_handle 
 	int result = 0;
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_notify");
-
 	if (acpi_bus_get_device(handle, &device))
-		return_VOID;
+		return;
 
 	switch (type) {
 
@@ -535,7 +517,6 @@ static void acpi_bus_notify(acpi_handle 
 		break;
 	}
 
-	return_VOID;
 }
 
 /* --------------------------------------------------------------------------
@@ -549,8 +530,6 @@ static int __init acpi_bus_init_irq(void
 	struct acpi_object_list arg_list = { 1, &arg };
 	char *message = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_init_irq");
-
 	/* 
 	 * Let the system know what interrupt model we are using by
 	 * evaluating the \_PIC object, if exists.
@@ -568,7 +547,7 @@ static int __init acpi_bus_init_irq(void
 		break;
 	default:
 		printk(KERN_WARNING PREFIX "Unknown interrupt routing model\n");
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	printk(KERN_INFO PREFIX "Using %s for interrupt routing\n", message);
@@ -578,10 +557,10 @@ static int __init acpi_bus_init_irq(void
 	status = acpi_evaluate_object(NULL, "\\_PIC", &arg_list, NULL);
 	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PIC"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 void __init acpi_early_init(void)
@@ -589,10 +568,8 @@ void __init acpi_early_init(void)
 	acpi_status status = AE_OK;
 	struct acpi_buffer buffer = { sizeof(acpi_fadt), &acpi_fadt };
 
-	ACPI_FUNCTION_TRACE("acpi_early_init");
-
 	if (acpi_disabled)
-		return_VOID;
+		return;
 
 	/* enable workarounds, unless strict ACPI spec. compliance */
 	if (!acpi_strict)
@@ -650,11 +627,9 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-	return_VOID;
 
       error0:
 	disable_acpi();
-	return_VOID;
 }
 
 static int __init acpi_bus_init(void)
@@ -663,8 +638,6 @@ static int __init acpi_bus_init(void)
 	acpi_status status = AE_OK;
 	extern acpi_status acpi_os_initialize1(void);
 
-	ACPI_FUNCTION_TRACE("acpi_bus_init");
-
 	status = acpi_os_initialize1();
 
 	status =
@@ -725,12 +698,12 @@ static int __init acpi_bus_init(void)
 	 */
 	acpi_root_dir = proc_mkdir(ACPI_BUS_FILE_ROOT, NULL);
 
-	return_VALUE(0);
+	return 0;
 
 	/* Mimic structured exception handling */
       error1:
 	acpi_terminate();
-	return_VALUE(-ENODEV);
+	return -ENODEV;
 }
 
 decl_subsys(acpi, NULL, NULL);
@@ -739,13 +712,11 @@ static int __init acpi_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_init");
-
 	printk(KERN_INFO PREFIX "Subsystem revision %08x\n", ACPI_CA_VERSION);
 
 	if (acpi_disabled) {
 		printk(KERN_INFO PREFIX "Interpreter disabled.\n");
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	firmware_register(&acpi_subsys);
@@ -766,7 +737,7 @@ static int __init acpi_init(void)
 	} else
 		disable_acpi();
 
-	return_VALUE(result);
+	return result;
 }
 
 subsys_initcall(acpi_init);
---
0.99.9.GIT


