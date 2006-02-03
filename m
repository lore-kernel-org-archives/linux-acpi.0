From: Thomas Renninger <trenn@suse.de>
Subject: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to ACPI_ERROR/WARNING
Date: Fri, 03 Feb 2006 22:19:55 +0100
Message-ID: <43E3C8FB.5020104@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030409000608020204090403"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:60828 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030247AbWBCVT6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2006 16:19:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI-ML <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>

This is a multi-part message in MIME format.
--------------030409000608020204090403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch lets all ACPI errors and warnings be printed
even ACPI_DEBUG is disabled.

I removed all "proc entry could not be created" messages
and returned -ENODEV.

I also removed all "Error removing/adding notify handler" messages.
I will provide a second patch (ACPICA) and add a message to 
the add/remove_handler function itself.

This should give the "non kernel debuggers" a chance to figure out
why their xy hardware does not work without the need of recompiling
kernels. And should provide as with better bug reports...

This one is on top of Len's latest 2.6.16-rc1/2 push.

    Thomas


--------------030409000608020204090403
Content-Type: text/plain;
 name="acpi_show_errors"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_show_errors"

Subject: Enables important ACPI errors even ACPI_DEBUG is not set.

Lets all ACPI errors and warnings be printed
even ACPI_DEBUG is disabled.

signed-off-by: trenn@suse.de


 ac.c                   |   12 +--------
 acpi_memhotplug.c      |   64 +++++++++++++++++++------------------------------
 battery.c              |   31 ++++++-----------------
 bus.c                  |   22 +++++++---------
 button.c               |   18 +++----------
 container.c            |    2 -
 debug.c                |    5 ---
 ec.c                   |   13 +++------
 event.c                |    5 ---
 fan.c                  |    7 +----
 hotkey.c               |   38 ++++++-----------------------
 osl.c                  |    8 +++---
 pci_bind.c             |   50 +++++++++++++++++++-------------------
 pci_irq.c              |   20 ++++++---------
 pci_link.c             |   48 ++++++++++++++++--------------------
 pci_root.c             |   15 ++++++-----
 power.c                |   22 +++++++---------
 processor_core.c       |   59 +++++++++++++++++++--------------------------
 processor_idle.c       |   14 +++-------
 processor_perflib.c    |   37 +++++++++++-----------------
 processor_thermal.c    |   10 +++----
 processor_throttling.c |    2 -
 scan.c                 |    7 ++---
 system.c               |    3 --
 thermal.c              |   58 ++++++++++++++------------------------------
 utils.c                |   50 ++++++++++++++++++--------------------
 video.c                |   54 ++++++++++++-----------------------------


Index: linux-2.6.15/drivers/acpi/ac.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/ac.c
+++ linux-2.6.15/drivers/acpi/ac.c
@@ -91,8 +91,7 @@ static int acpi_ac_get_state(struct acpi
 
 	status = acpi_evaluate_integer(ac->handle, "_PSR", NULL, &ac->state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error reading AC Adapter state\n"));
+		ACPI_ERROR((AE_INFO, "Error reading AC Adapter state\n"));
 		ac->state = ACPI_AC_STATUS_UNKNOWN;
 		return_VALUE(-ENODEV);
 	}
@@ -159,9 +158,7 @@ static int acpi_ac_add_fs(struct acpi_de
 	entry = create_proc_entry(ACPI_AC_FILE_STATE,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_AC_FILE_STATE));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_ac_fops;
 		entry->data = acpi_driver_data(device);
@@ -249,8 +246,6 @@ static int acpi_ac_add(struct acpi_devic
 					     ACPI_DEVICE_NOTIFY, acpi_ac_notify,
 					     ac);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing notify handler\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -282,9 +277,6 @@ static int acpi_ac_remove(struct acpi_de
 
 	status = acpi_remove_notify_handler(ac->handle,
 					    ACPI_DEVICE_NOTIFY, acpi_ac_notify);
-	if (ACPI_FAILURE(status))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error removing notify handler\n"));
 
 	acpi_ac_remove_fs(device);
 
Index: linux-2.6.15/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.15/drivers/acpi/acpi_memhotplug.c
@@ -153,15 +153,14 @@ acpi_memory_get_device(acpi_handle handl
 
 	status = acpi_get_parent(handle, &phandle);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_get_parent\n"));
+		ACPI_ERROR((AE_INFO, "Cannot find acpi parent\n"));
 		return_VALUE(-EINVAL);
 	}
 
 	/* Get the parent device */
 	status = acpi_bus_get_device(phandle, &pdevice);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error in acpi_bus_get_device\n"));
+		ACPI_ERROR((AE_INFO, "Cannot get acpi bus device\n"));
 		return_VALUE(-EINVAL);
 	}
 
@@ -171,7 +170,7 @@ acpi_memory_get_device(acpi_handle handl
 	 */
 	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_bus_add\n"));
+		ACPI_ERROR((AE_INFO, "Cannot add acpi bus\n"));
 		return_VALUE(-EINVAL);
 	}
       end:
@@ -219,8 +218,7 @@ static int acpi_memory_enable_device(str
 	/* Get the range from the _CRS */
 	result = acpi_memory_get_device_resources(mem_device);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "\nget_device_resources failed\n"));
+		ACPI_ERROR((AE_INFO, "\nget_device_resources failed\n"));
 		mem_device->state = MEMORY_INVALID_STATE;
 		return result;
 	}
@@ -232,7 +230,7 @@ static int acpi_memory_enable_device(str
 	result = add_memory(mem_device->start_addr,
 			    (mem_device->end_addr - mem_device->start_addr) + 1);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "\nadd_memory failed\n"));
+		ACPI_ERROR((AE_INFO, "\nadd_memory failed\n"));
 		mem_device->state = MEMORY_INVALID_STATE;
 		return result;
 	}
@@ -258,7 +256,7 @@ static int acpi_memory_powerdown_device(
 				      "_EJ0", &arg_list, NULL);
 	/* Return on _EJ0 failure */
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "_EJ0 failed.\n"));
+		ACPI_ERROR((AE_INFO, "_EJ0 failed.\n"));
 		return_VALUE(-ENODEV);
 	}
 
@@ -289,15 +287,14 @@ static int acpi_memory_disable_device(st
 	 */
 	result = remove_memory(start, len);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Hot-Remove failed.\n"));
+		ACPI_ERROR((AE_INFO, "Hot-Remove failed.\n"));
 		return_VALUE(result);
 	}
 
 	/* Power-off and eject the device */
 	result = acpi_memory_powerdown_device(mem_device);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Device Power Down failed.\n"));
+		ACPI_ERROR((AE_INFO, "Device Power Down failed.\n"));
 		/* Set the status of the device to invalid */
 		mem_device->state = MEMORY_INVALID_STATE;
 		return result;
@@ -324,15 +321,14 @@ static void acpi_memory_device_notify(ac
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "\nReceived DEVICE CHECK notification for device\n"));
 		if (acpi_memory_get_device(handle, &mem_device)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Error in finding driver data\n"));
+			ACPI_ERROR((AE_INFO, "Cannot find driver data\n"));
 			return_VOID;
 		}
 
 		if (!acpi_memory_check_device(mem_device)) {
 			if (acpi_memory_enable_device(mem_device))
-				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-						  "Error in acpi_memory_enable_device\n"));
+				ACPI_ERROR((AE_INFO,
+					    "Cannot enable memory device\n"));
 		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
@@ -340,14 +336,12 @@ static void acpi_memory_device_notify(ac
 				  "\nReceived EJECT REQUEST notification for device\n"));
 
 		if (acpi_bus_get_device(handle, &device)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Device doesn't exist\n"));
+			ACPI_ERROR((AE_INFO, "Device doesn't exist\n"));
 			break;
 		}
 		mem_device = acpi_driver_data(device);
 		if (!mem_device) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Driver Data is NULL\n"));
+			ACPI_ERROR((AE_INFO, "Driver Data is NULL\n"));
 			break;
 		}
 
@@ -358,8 +352,8 @@ static void acpi_memory_device_notify(ac
 		 *      with generic sysfs driver
 		 */
 		if (acpi_memory_disable_device(mem_device))
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Error in acpi_memory_disable_device\n"));
+			ACPI_ERROR((AE_INFO,
+				    "Cannot disable acpi memory device\n"));
 		/*
 		 * TBD: Invoke acpi_bus_remove to cleanup data structures
 		 */
@@ -463,18 +457,15 @@ acpi_memory_register_notify_handler(acpi
 	ACPI_FUNCTION_TRACE("acpi_memory_register_notify_handler");
 
 	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)){
+		ACPI_WARNING((AE_INFO, "handle is no memory device\n"));
 		return_ACPI_STATUS(AE_OK);	/* continue */
+	}
 
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 					     acpi_memory_device_notify, NULL);
-	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing notify handler\n"));
-		return_ACPI_STATUS(AE_OK);	/* continue */
-	}
-
-	return_ACPI_STATUS(status);
+	/* continue */
+	return_ACPI_STATUS(AE_OK);
 }
 
 static acpi_status
@@ -486,19 +477,16 @@ acpi_memory_deregister_notify_handler(ac
 	ACPI_FUNCTION_TRACE("acpi_memory_deregister_notify_handler");
 
 	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)){
+		ACPI_WARNING((AE_INFO, "handle is no memory device\n"));
 		return_ACPI_STATUS(AE_OK);	/* continue */
+	}
 
 	status = acpi_remove_notify_handler(handle,
 					    ACPI_SYSTEM_NOTIFY,
 					    acpi_memory_device_notify);
-	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error removing notify handler\n"));
-		return_ACPI_STATUS(AE_OK);	/* continue */
-	}
 
-	return_ACPI_STATUS(status);
+	return_ACPI_STATUS(AE_OK);	/* continue */
 }
 
 static int __init acpi_memory_device_init(void)
@@ -519,7 +507,7 @@ static int __init acpi_memory_device_ini
 				     NULL, NULL);
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "walk_namespace failed\n"));
+		ACPI_ERROR((AE_INFO, "walk_namespace failed\n"));
 		acpi_bus_unregister_driver(&acpi_memory_device_driver);
 		return_VALUE(-ENODEV);
 	}
@@ -543,7 +531,7 @@ static void __exit acpi_memory_device_ex
 				     NULL, NULL);
 
 	if (ACPI_FAILURE(status))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "walk_namespace failed\n"));
+		ACPI_ERROR((AE_INFO, "walk_namespace failed\n"));
 
 	acpi_bus_unregister_driver(&acpi_memory_device_driver);
 
Index: linux-2.6.15/drivers/acpi/battery.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/battery.c
+++ linux-2.6.15/drivers/acpi/battery.c
@@ -141,7 +141,7 @@ acpi_battery_get_info(struct acpi_batter
 
 	status = acpi_evaluate_object(battery->handle, "_BIF", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _BIF\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _BIF\n"));
 		return_VALUE(-ENODEV);
 	}
 
@@ -151,7 +151,7 @@ acpi_battery_get_info(struct acpi_batter
 
 	status = acpi_extract_package(package, &format, &data);
 	if (status != AE_BUFFER_OVERFLOW) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error extracting _BIF\n"));
+		ACPI_ERROR((AE_INFO, "Error extracting _BIF\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -165,7 +165,7 @@ acpi_battery_get_info(struct acpi_batter
 
 	status = acpi_extract_package(package, &format, &data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error extracting _BIF\n"));
+		ACPI_ERROR((AE_INFO, "Error extracting _BIF\n"));
 		kfree(data.pointer);
 		result = -ENODEV;
 		goto end;
@@ -202,7 +202,7 @@ acpi_battery_get_status(struct acpi_batt
 
 	status = acpi_evaluate_object(battery->handle, "_BST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _BST\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _BST\n"));
 		return_VALUE(-ENODEV);
 	}
 
@@ -212,7 +212,7 @@ acpi_battery_get_status(struct acpi_batt
 
 	status = acpi_extract_package(package, &format, &data);
 	if (status != AE_BUFFER_OVERFLOW) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error extracting _BST\n"));
+		ACPI_ERROR((AE_INFO, "Error extracting _BST\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -226,7 +226,7 @@ acpi_battery_get_status(struct acpi_batt
 
 	status = acpi_extract_package(package, &format, &data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error extracting _BST\n"));
+		ACPI_ERROR((AE_INFO, "Error extracting _BST\n"));
 		kfree(data.pointer);
 		result = -ENODEV;
 		goto end;
@@ -458,8 +458,6 @@ static int acpi_battery_read_state(struc
 	if ((bst->state & 0x01) && (bst->state & 0x02)) {
 		seq_printf(seq,
 			   "charging state:          charging/discharging\n");
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Battery Charging and Discharging?\n"));
 	} else if (bst->state & 0x01)
 		seq_printf(seq, "charging state:          discharging\n");
 	else if (bst->state & 0x02)
@@ -609,9 +607,7 @@ static int acpi_battery_add_fs(struct ac
 	entry = create_proc_entry(ACPI_BATTERY_FILE_INFO,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_BATTERY_FILE_INFO));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_battery_info_ops;
 		entry->data = acpi_driver_data(device);
@@ -622,9 +618,7 @@ static int acpi_battery_add_fs(struct ac
 	entry = create_proc_entry(ACPI_BATTERY_FILE_STATUS,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_BATTERY_FILE_STATUS));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_battery_state_ops;
 		entry->data = acpi_driver_data(device);
@@ -636,9 +630,7 @@ static int acpi_battery_add_fs(struct ac
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_BATTERY_FILE_ALARM));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_battery_alarm_ops;
 		entry->data = acpi_driver_data(device);
@@ -732,8 +724,6 @@ static int acpi_battery_add(struct acpi_
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_battery_notify, battery);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing notify handler\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -766,9 +756,6 @@ static int acpi_battery_remove(struct ac
 	status = acpi_remove_notify_handler(battery->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_battery_notify);
-	if (ACPI_FAILURE(status))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error removing notify handler\n"));
 
 	acpi_battery_remove_fs(device);
 
Index: linux-2.6.15/drivers/acpi/bus.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/bus.c
+++ linux-2.6.15/drivers/acpi/bus.c
@@ -69,8 +69,7 @@ int acpi_bus_get_device(acpi_handle hand
 
 	status = acpi_get_data(handle, acpi_bus_data_handler, (void **)device);
 	if (ACPI_FAILURE(status) || !*device) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "No context for object [%p]\n",
-				  handle));
+		ACPI_WARNING((AE_INFO, "No context for object [%p]\n", handle));
 		return_VALUE(-ENODEV);
 	}
 
@@ -197,8 +196,7 @@ int acpi_bus_set_power(acpi_handle handl
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Device is not power manageable\n"));
+		ACPI_INFO((AE_INFO, "Device is not power manageable\n"));
 		return_VALUE(-ENODEV);
 	}
 	/*
@@ -213,13 +211,13 @@ int acpi_bus_set_power(acpi_handle handl
 		return_VALUE(0);
 	}
 	if (!device->power.states[state].flags.valid) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Device does not support D%d\n",
-				  state));
+		ACPI_WARNING((AE_INFO, "Device does not support D%d\n", state));
 		return_VALUE(-ENODEV);
 	}
 	if (device->parent && (state < device->parent->power.state)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Cannot set device to a higher-powered state than parent\n"));
+		ACPI_WARNING((AE_INFO,
+			      "Cannot set device to a higher-powered"
+			      " state than parent\n"));
 		return_VALUE(-ENODEV);
 	}
 
@@ -262,9 +260,9 @@ int acpi_bus_set_power(acpi_handle handl
 
       end:
 	if (result)
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Error transitioning device [%s] to D%d\n",
-				  device->pnp.bus_id, state));
+		ACPI_WARNING((AE_INFO,
+			      "Error transitioning device [%s] to D%d\n",
+			      device->pnp.bus_id, state));
 	else
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Device [%s] transitioned to D%d\n",
@@ -579,7 +577,7 @@ static int __init acpi_bus_init_irq(void
 
 	status = acpi_evaluate_object(NULL, "\\_PIC", &arg_list, NULL);
 	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PIC\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _PIC\n"));
 		return_VALUE(-ENODEV);
 	}
 
Index: linux-2.6.15/drivers/acpi/button.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/button.c
+++ linux-2.6.15/drivers/acpi/button.c
@@ -207,9 +207,7 @@ static int acpi_button_add_fs(struct acp
 	entry = create_proc_entry(ACPI_BUTTON_FILE_INFO,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_BUTTON_FILE_INFO));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_button_info_fops;
 		entry->data = acpi_driver_data(device);
@@ -221,9 +219,7 @@ static int acpi_button_add_fs(struct acp
 		entry = create_proc_entry(ACPI_BUTTON_FILE_STATE,
 					  S_IRUGO, acpi_device_dir(device));
 		if (!entry)
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Unable to create '%s' fs entry\n",
-					  ACPI_BUTTON_FILE_INFO));
+			return -ENODEV;
 		else {
 			entry->proc_fops = &acpi_button_state_fops;
 			entry->data = acpi_driver_data(device);
@@ -349,8 +345,8 @@ static int acpi_button_add(struct acpi_d
 		sprintf(acpi_device_class(device), "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unsupported hid [%s]\n",
-				  acpi_device_hid(device)));
+		ACPI_ERROR((AE_INFO, "Unsupported hid [%s]\n",
+			    acpi_device_hid(device)));
 		result = -ENODEV;
 		goto end;
 	}
@@ -381,8 +377,6 @@ static int acpi_button_add(struct acpi_d
 	}
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing notify handler\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -440,10 +434,6 @@ static int acpi_button_remove(struct acp
 		break;
 	}
 
-	if (ACPI_FAILURE(status))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error removing notify handler\n"));
-
 	acpi_button_remove_fs(device);
 
 	kfree(button);
Index: linux-2.6.15/drivers/acpi/container.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/container.c
+++ linux-2.6.15/drivers/acpi/container.c
@@ -94,7 +94,7 @@ static int acpi_container_add(struct acp
 	ACPI_FUNCTION_TRACE("acpi_container_add");
 
 	if (!device) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "device is NULL\n"));
+		ACPI_ERROR((AE_INFO, "device is NULL\n"));
 		return_VALUE(-EINVAL);
 	}
 
Index: linux-2.6.15/drivers/acpi/debug.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/debug.c
+++ linux-2.6.15/drivers/acpi/debug.c
@@ -216,12 +216,9 @@ static int __init acpi_debug_init(void)
 	return_VALUE(error);
 
       Error:
-	ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-			  "Unable to create '%s' proc fs entry\n", name));
-
 	remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LEVEL, acpi_root_dir);
 	remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER, acpi_root_dir);
-	error = -EFAULT;
+	error = -ENODEV;
 	goto Done;
 }
 
Index: linux-2.6.15/drivers/acpi/ec.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/ec.c
+++ linux-2.6.15/drivers/acpi/ec.c
@@ -957,9 +957,7 @@ static int acpi_ec_add_fs(struct acpi_de
 	entry = create_proc_entry(ACPI_EC_FILE_INFO, S_IRUGO,
 				  acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_EC_FILE_INFO));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_ec_info_ops;
 		entry->data = acpi_driver_data(device);
@@ -1034,8 +1032,7 @@ static int acpi_ec_poll_add(struct acpi_
 	    acpi_evaluate_integer(ec->common.handle, "_GPE", NULL,
 				  &ec->common.gpe_bit);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error obtaining GPE bit assignment\n"));
+		ACPI_ERROR((AE_INFO, "Error obtaining GPE bit assignment\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -1108,8 +1105,7 @@ static int acpi_ec_intr_add(struct acpi_
 	    acpi_evaluate_integer(ec->common.handle, "_GPE", NULL,
 				  &ec->common.gpe_bit);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error obtaining GPE bit assignment\n"));
+		ACPI_ERROR((AE_INFO, "Error obtaining GPE bit assignment\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -1203,8 +1199,7 @@ static int acpi_ec_start(struct acpi_dev
 				     acpi_ec_io_ports, ec);
 	if (ACPI_FAILURE(status)
 	    || ec->common.command_addr.register_bit_width == 0) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error getting I/O port addresses"));
+		ACPI_ERROR((AE_INFO, "Error getting I/O port addresses"));
 		return_VALUE(-ENODEV);
 	}
 
Index: linux-2.6.15/drivers/acpi/event.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/event.c
+++ linux-2.6.15/drivers/acpi/event.c
@@ -122,10 +122,7 @@ static int __init acpi_event_init(void)
 	if (entry)
 		entry->proc_fops = &acpi_system_event_ops;
 	else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' proc fs entry\n",
-				  "event"));
-		error = -EFAULT;
+		error = -ENODEV;
 	}
 	return_VALUE(error);
 }
Index: linux-2.6.15/drivers/acpi/fan.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/fan.c
+++ linux-2.6.15/drivers/acpi/fan.c
@@ -149,9 +149,7 @@ static int acpi_fan_add_fs(struct acpi_d
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_FAN_FILE_STATE));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_fan_state_ops;
 		entry->data = acpi_driver_data(device);
@@ -201,8 +199,7 @@ static int acpi_fan_add(struct acpi_devi
 
 	result = acpi_bus_get_power(fan->handle, &state);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error reading power state\n"));
+		ACPI_ERROR((AE_INFO, "Error reading power state\n"));
 		goto end;
 	}
 
Index: linux-2.6.15/drivers/acpi/hotkey.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/hotkey.c
+++ linux-2.6.15/drivers/acpi/hotkey.c
@@ -356,9 +356,6 @@ static int create_polling_proc(union acp
 	proc = create_proc_entry(proc_name, mode, hotkey_proc_dir);
 
 	if (!proc) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Hotkey: Unable to create %s entry\n",
-				  device->poll_hotkey.poll_method));
 		return_VALUE(-ENODEV);
 	} else {
 		proc->proc_fops = &hotkey_polling_fops;
@@ -769,7 +766,7 @@ static ssize_t hotkey_write_config(struc
 
 	if (copy_from_user(config_record, buffer, count)) {
 		kfree(config_record);
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data \n"));
+		ACPI_ERROR((AE_INFO, "Invalid data \n"));
 		return_VALUE(-EINVAL);
 	}
 	config_record[count] = 0;
@@ -790,8 +787,7 @@ static ssize_t hotkey_write_config(struc
 		kfree(bus_method);
 		kfree(action_handle);
 		kfree(method);
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Invalid data format ret=%d\n", ret));
+		ACPI_ERROR((AE_INFO, "Invalid data format ret=%d\n", ret));
 		return_VALUE(-EINVAL);
 	}
 
@@ -804,7 +800,7 @@ static ssize_t hotkey_write_config(struc
 		tmp = get_hotkey_by_event(&global_hotkey_list,
 					  internal_event_num);
 		if (!tmp)
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid key"));
+			ACPI_ERROR((AE_INFO, "Invalid key"));
 		else
 			memcpy(key, tmp, sizeof(union acpi_hotkey));
 		goto cont_cmd;
@@ -826,7 +822,7 @@ static ssize_t hotkey_write_config(struc
 		else
 			free_poll_hotkey_buffer(key);
 		kfree(key);
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid hotkey \n"));
+		ACPI_ERROR((AE_INFO, "Invalid hotkey \n"));
 		return_VALUE(-EINVAL);
 	}
 
@@ -860,7 +856,7 @@ static ssize_t hotkey_write_config(struc
 	else
 		free_poll_hotkey_buffer(key);
 	kfree(key);
-	ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "invalid key\n"));
+	ACPI_ERROR((AE_INFO, "invalid key\n"));
 	return_VALUE(-EINVAL);
 }
 
@@ -905,7 +901,7 @@ static int read_acpi_int(acpi_handle han
 		val->integer.value = out_obj.integer.value;
 		val->type = out_obj.type;
 	} else
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "null val pointer"));
+		ACPI_ERROR((AE_INFO, "null val pointer"));
 	return_VALUE((status == AE_OK)
 		     && (out_obj.type == ACPI_TYPE_INTEGER));
 }
@@ -952,14 +948,14 @@ static ssize_t hotkey_execute_aml_method
 
 	if (copy_from_user(arg, buffer, count)) {
 		kfree(arg);
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument 2"));
+		ACPI_ERROR((AE_INFO, "Invalid argument 2"));
 		return_VALUE(-EINVAL);
 	}
 
 	if (sscanf(arg, "%d:%d:%d:%d", &event, &method_type, &type, &value) !=
 	    4) {
 		kfree(arg);
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument 3"));
+		ACPI_ERROR((AE_INFO, "Invalid argument 3"));
 		return_VALUE(-EINVAL);
 	}
 	kfree(arg);
@@ -985,7 +981,7 @@ static ssize_t hotkey_execute_aml_method
 
 		}
 	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Not supported"));
+		ACPI_ERROR((AE_INFO, "Not supported"));
 		return_VALUE(-EINVAL);
 	}
 	return_VALUE(count);
@@ -1011,9 +1007,6 @@ static int __init hotkey_init(void)
 
 	hotkey_proc_dir = proc_mkdir(HOTKEY_PROC, acpi_root_dir);
 	if (!hotkey_proc_dir) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Hotkey: Unable to create %s entry\n",
-				  HOTKEY_PROC));
 		return (-ENODEV);
 	}
 	hotkey_proc_dir->owner = THIS_MODULE;
@@ -1021,9 +1014,6 @@ static int __init hotkey_init(void)
 	hotkey_config =
 	    create_proc_entry(HOTKEY_EV_CONFIG, mode, hotkey_proc_dir);
 	if (!hotkey_config) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Hotkey: Unable to create %s entry\n",
-				  HOTKEY_EV_CONFIG));
 		goto do_fail1;
 	} else {
 		hotkey_config->proc_fops = &hotkey_config_fops;
@@ -1036,10 +1026,6 @@ static int __init hotkey_init(void)
 	hotkey_poll_config =
 	    create_proc_entry(HOTKEY_PL_CONFIG, mode, hotkey_proc_dir);
 	if (!hotkey_poll_config) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Hotkey: Unable to create %s entry\n",
-				  HOTKEY_EV_CONFIG));
-
 		goto do_fail2;
 	} else {
 		hotkey_poll_config->proc_fops = &hotkey_poll_config_fops;
@@ -1051,9 +1037,6 @@ static int __init hotkey_init(void)
 
 	hotkey_action = create_proc_entry(HOTKEY_ACTION, mode, hotkey_proc_dir);
 	if (!hotkey_action) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Hotkey: Unable to create %s entry\n",
-				  HOTKEY_ACTION));
 		goto do_fail3;
 	} else {
 		hotkey_action->proc_fops = &hotkey_action_fops;
@@ -1064,9 +1047,6 @@ static int __init hotkey_init(void)
 
 	hotkey_info = create_proc_entry(HOTKEY_INFO, mode, hotkey_proc_dir);
 	if (!hotkey_info) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Hotkey: Unable to create %s entry\n",
-				  HOTKEY_INFO));
 		goto do_fail4;
 	} else {
 		hotkey_info->proc_fops = &hotkey_info_fops;
Index: linux-2.6.15/drivers/acpi/osl.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/osl.c
+++ linux-2.6.15/drivers/acpi/osl.c
@@ -700,7 +700,7 @@ static void acpi_os_execute_deferred(voi
 
 	dpc = (struct acpi_os_dpc *)context;
 	if (!dpc) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) context.\n"));
+		ACPI_ERROR((AE_INFO, "Invalid (NULL) context.\n"));
 		return_VOID;
 	}
 
@@ -752,8 +752,8 @@ acpi_os_queue_for_execution(u32 priority
 	INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
 
 	if (!queue_work(kacpid_wq, task)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Call to queue_work() failed.\n"));
+		ACPI_ERROR((AE_INFO,
+			    "Call to queue_work() failed.\n"));
 		kfree(dpc);
 		status = AE_ERROR;
 	}
@@ -927,7 +927,7 @@ acpi_status acpi_os_wait_semaphore(acpi_
 	}
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+		ACPI_WARNING((AE_INFO,
 				  "Failed to acquire semaphore[%p|%d|%d], %s\n",
 				  handle, units, timeout,
 				  acpi_format_exception(status)));
Index: linux-2.6.15/drivers/acpi/pci_bind.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/pci_bind.c
+++ linux-2.6.15/drivers/acpi/pci_bind.c
@@ -75,17 +75,17 @@ acpi_status acpi_get_pci_id(acpi_handle 
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Invalid ACPI Bus context for device %s\n",
-				  acpi_device_bid(device)));
+		ACPI_ERROR((AE_INFO,
+			    "Invalid ACPI Bus context for device %s\n",
+			    acpi_device_bid(device)));
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
 	status = acpi_get_data(handle, acpi_pci_data_handler, (void **)&data);
 	if (ACPI_FAILURE(status) || !data) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Invalid ACPI-PCI context for device %s\n",
-				  acpi_device_bid(device)));
+		ACPI_ERROR((AE_INFO,
+			    "Invalid ACPI-PCI context for device %s\n",
+			    acpi_device_bid(device)));
 		return_ACPI_STATUS(status);
 	}
 
@@ -151,9 +151,9 @@ int acpi_pci_bind(struct acpi_device *de
 	status = acpi_get_data(device->parent->handle, acpi_pci_data_handler,
 			       (void **)&pdata);
 	if (ACPI_FAILURE(status) || !pdata || !pdata->bus) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Invalid ACPI-PCI context for parent device %s\n",
-				  acpi_device_bid(device->parent)));
+		ACPI_ERROR((AE_INFO,
+			    "Invalid ACPI-PCI context for parent device %s\n",
+			    acpi_device_bid(device->parent)));
 		result = -ENODEV;
 		goto end;
 	}
@@ -206,10 +206,10 @@ int acpi_pci_bind(struct acpi_device *de
 		goto end;
 	}
 	if (!data->dev->bus) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Device %02x:%02x:%02x.%02x has invalid 'bus' field\n",
-				  data->id.segment, data->id.bus,
-				  data->id.device, data->id.function));
+		ACPI_ERROR((AE_INFO,
+			    "Device %02x:%02x:%02x.%02x has invalid 'bus' field\n",
+			    data->id.segment, data->id.bus,
+			    data->id.device, data->id.function));
 		result = -ENODEV;
 		goto end;
 	}
@@ -237,9 +237,9 @@ int acpi_pci_bind(struct acpi_device *de
 	 */
 	status = acpi_attach_data(device->handle, acpi_pci_data_handler, data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to attach ACPI-PCI context to device %s\n",
-				  acpi_device_bid(device)));
+		ACPI_ERROR((AE_INFO,
+			    "Unable to attach ACPI-PCI context to device %s\n",
+			    acpi_device_bid(device)));
 		result = -ENODEV;
 		goto end;
 	}
@@ -301,18 +301,18 @@ int acpi_pci_unbind(struct acpi_device *
 	    acpi_get_data(device->handle, acpi_pci_data_handler,
 			  (void **)&data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to get data from device %s\n",
-				  acpi_device_bid(device)));
+		ACPI_ERROR((AE_INFO,
+			    "Unable to get data from device %s\n",
+			    acpi_device_bid(device)));
 		result = -ENODEV;
 		goto end;
 	}
 
 	status = acpi_detach_data(device->handle, acpi_pci_data_handler);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to detach data from device %s\n",
-				  acpi_device_bid(device)));
+		ACPI_ERROR((AE_INFO,
+			    "Unable to detach data from device %s\n",
+			    acpi_device_bid(device)));
 		result = -ENODEV;
 		goto end;
 	}
@@ -369,9 +369,9 @@ acpi_pci_bind_root(struct acpi_device *d
 
 	status = acpi_attach_data(device->handle, acpi_pci_data_handler, data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to attach ACPI-PCI context to device %s\n",
-				  pathname));
+		ACPI_ERROR((AE_INFO,
+			    "Unable to attach ACPI-PCI context to device %s\n",
+			    pathname));
 		result = -ENODEV;
 		goto end;
 	}
Index: linux-2.6.15/drivers/acpi/pci_irq.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/pci_irq.c
+++ linux-2.6.15/drivers/acpi/pci_irq.c
@@ -197,8 +197,8 @@ int acpi_pci_irq_add_prt(acpi_handle han
 	kfree(pathname);
 	status = acpi_get_irq_routing_table(handle, &buffer);
 	if (status != AE_BUFFER_OVERFLOW) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
-				  acpi_format_exception(status)));
+		ACPI_ERROR((AE_INFO, "Error evaluating _PRT [%s]\n",
+			    acpi_format_exception(status)));
 		return_VALUE(-ENODEV);
 	}
 
@@ -211,8 +211,8 @@ int acpi_pci_irq_add_prt(acpi_handle han
 
 	status = acpi_get_irq_routing_table(handle, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
-				  acpi_format_exception(status)));
+		ACPI_ERROR((AE_INFO, "Error evaluating _PRT [%s]\n",
+			    acpi_format_exception(status)));
 		kfree(buffer.pointer);
 		return_VALUE(-ENODEV);
 	}
@@ -269,8 +269,8 @@ acpi_pci_allocate_irq(struct acpi_prt_en
 						 entry->link.index, triggering,
 						 polarity, link);
 		if (irq < 0) {
-			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-					  "Invalid IRQ link routing entry\n"));
+			ACPI_WARNING((AE_INFO,
+				      "Invalid IRQ link routing entry\n"));
 			return_VALUE(-1);
 		}
 	} else {
@@ -379,9 +379,8 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 	}
 
 	if (irq < 0) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Unable to derive IRQ for device %s\n",
-				  pci_name(dev)));
+		ACPI_WARNING((AE_INFO, "Unable to derive IRQ for device %s\n",
+			      pci_name(dev)));
 		return_VALUE(-1);
 	}
 
@@ -421,8 +420,7 @@ int acpi_pci_irq_enable(struct pci_dev *
 	pin--;
 
 	if (!dev->bus) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Invalid (NULL) 'bus' field\n"));
+		ACPI_ERROR((AE_INFO, "Invalid (NULL) 'bus' field\n"));
 		return_VALUE(-ENODEV);
 	}
 
Index: linux-2.6.15/drivers/acpi/pci_link.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/pci_link.c
+++ linux-2.6.15/drivers/acpi/pci_link.c
@@ -115,7 +115,7 @@ acpi_pci_link_check_possible(struct acpi
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
 			if (!p || !p->interrupt_count) {
-				ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				ACPI_WARNING((AE_INFO,
 						  "Blank IRQ resource\n"));
 				return_ACPI_STATUS(AE_OK);
 			}
@@ -123,7 +123,7 @@ acpi_pci_link_check_possible(struct acpi
 			     (i < p->interrupt_count
 			      && i < ACPI_PCI_LINK_MAX_POSSIBLE); i++) {
 				if (!p->interrupts[i]) {
-					ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+					ACPI_WARNING((AE_INFO,
 							  "Invalid IRQ %d\n",
 							  p->interrupts[i]));
 					continue;
@@ -141,7 +141,7 @@ acpi_pci_link_check_possible(struct acpi
 			struct acpi_resource_extended_irq *p =
 			    &resource->data.extended_irq;
 			if (!p || !p->interrupt_count) {
-				ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				ACPI_WARNING((AE_INFO,
 						  "Blank EXT IRQ resource\n"));
 				return_ACPI_STATUS(AE_OK);
 			}
@@ -149,7 +149,7 @@ acpi_pci_link_check_possible(struct acpi
 			     (i < p->interrupt_count
 			      && i < ACPI_PCI_LINK_MAX_POSSIBLE); i++) {
 				if (!p->interrupts[i]) {
-					ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+					ACPI_WARNING((AE_INFO,
 							  "Invalid IRQ %d\n",
 							  p->interrupts[i]));
 					continue;
@@ -163,8 +163,7 @@ acpi_pci_link_check_possible(struct acpi
 			break;
 		}
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Resource is not an IRQ entry\n"));
+		ACPI_ERROR((AE_INFO, "Resource is not an IRQ entry\n"));
 		return_ACPI_STATUS(AE_OK);
 	}
 
@@ -183,7 +182,7 @@ static int acpi_pci_link_get_possible(st
 	status = acpi_walk_resources(link->handle, METHOD_NAME__PRS,
 				     acpi_pci_link_check_possible, link);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRS\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _PRS\n"));
 		return_VALUE(-ENODEV);
 	}
 
@@ -226,7 +225,7 @@ acpi_pci_link_check_current(struct acpi_
 				 * extended IRQ descriptors must
 				 * return at least 1 IRQ
 				 */
-				ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				ACPI_WARNING((AE_INFO,
 						  "Blank EXT IRQ resource\n"));
 				return_ACPI_STATUS(AE_OK);
 			}
@@ -235,7 +234,7 @@ acpi_pci_link_check_current(struct acpi_
 		}
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Resource %d isn't an IRQ\n", resource->type));
+		ACPI_ERROR((AE_INFO, "Resource %d isn't an IRQ\n", resource->type));
 	case ACPI_RESOURCE_TYPE_END_TAG:
 		return_ACPI_STATUS(AE_OK);
 	}
@@ -267,8 +266,7 @@ static int acpi_pci_link_get_current(str
 		/* Query _STA, set link->device->status */
 		result = acpi_bus_get_status(link->device);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Unable to read status\n"));
+			ACPI_ERROR((AE_INFO, "Unable to read status\n"));
 			goto end;
 		}
 
@@ -285,13 +283,13 @@ static int acpi_pci_link_get_current(str
 	status = acpi_walk_resources(link->handle, METHOD_NAME__CRS,
 				     acpi_pci_link_check_current, &irq);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _CRS\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _CRS\n"));
 		result = -ENODEV;
 		goto end;
 	}
 
 	if (acpi_strict && !irq) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "_CRS returned 0\n"));
+		ACPI_ERROR((AE_INFO, "_CRS returned 0\n"));
 		result = -ENODEV;
 	}
 
@@ -373,7 +371,7 @@ static int acpi_pci_link_set(struct acpi
 
 	/* check for total failure */
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _SRS\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -381,7 +379,7 @@ static int acpi_pci_link_set(struct acpi
 	/* Query _STA, set device->status */
 	result = acpi_bus_get_status(link->device);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unable to read status\n"));
+		ACPI_ERROR((AE_INFO, "Unable to read status\n"));
 		goto end;
 	}
 	if (!link->device->status.enabled) {
@@ -500,8 +498,7 @@ int __init acpi_irq_penalty_init(void)
 
 		link = list_entry(node, struct acpi_pci_link, node);
 		if (!link) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Invalid link context\n"));
+			ACPI_ERROR((AE_INFO, "Invalid link context\n"));
 			continue;
 		}
 
@@ -625,19 +622,19 @@ acpi_pci_link_allocate_irq(acpi_handle h
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link device\n"));
+		ACPI_ERROR((AE_INFO, "Invalid link device\n"));
 		return_VALUE(-1);
 	}
 
 	link = (struct acpi_pci_link *)acpi_driver_data(device);
 	if (!link) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+		ACPI_ERROR((AE_INFO, "Invalid link context\n"));
 		return_VALUE(-1);
 	}
 
 	/* TBD: Support multiple index (IRQ) entries per Link Device */
 	if (index) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid index %d\n", index));
+		ACPI_ERROR((AE_INFO, "Invalid index %d\n", index));
 		return_VALUE(-1);
 	}
 
@@ -649,7 +646,7 @@ acpi_pci_link_allocate_irq(acpi_handle h
 
 	if (!link->irq.active) {
 		up(&acpi_link_lock);
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link active IRQ is 0!\n"));
+		ACPI_ERROR((AE_INFO, "Link active IRQ is 0!\n"));
 		return_VALUE(-1);
 	}
 	link->refcnt++;
@@ -681,20 +678,20 @@ int acpi_pci_link_free_irq(acpi_handle h
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link device\n"));
+		ACPI_ERROR((AE_INFO, "Invalid link device\n"));
 		return_VALUE(-1);
 	}
 
 	link = (struct acpi_pci_link *)acpi_driver_data(device);
 	if (!link) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+		ACPI_ERROR((AE_INFO, "Invalid link context\n"));
 		return_VALUE(-1);
 	}
 
 	down(&acpi_link_lock);
 	if (!link->irq.initialized) {
 		up(&acpi_link_lock);
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link isn't initialized\n"));
+		ACPI_ERROR((AE_INFO, "Link isn't initialized\n"));
 		return_VALUE(-1);
 	}
 #ifdef	FUTURE_USE
@@ -816,8 +813,7 @@ static int irqrouter_resume(struct sys_d
 	list_for_each(node, &acpi_link.entries) {
 		link = list_entry(node, struct acpi_pci_link, node);
 		if (!link) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Invalid link context\n"));
+			ACPI_ERROR((AE_INFO, "Invalid link context\n"));
 			continue;
 		}
 		acpi_pci_link_resume(link);
Index: linux-2.6.15/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/pci_root.c
+++ linux-2.6.15/drivers/acpi/pci_root.c
@@ -198,7 +198,7 @@ static int acpi_pci_root_add(struct acpi
 		root->id.segment = 0;
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SEG\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _SEG\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -219,7 +219,7 @@ static int acpi_pci_root_add(struct acpi
 		root->id.bus = 0;
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _BBN\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _BBN\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -231,8 +231,9 @@ static int acpi_pci_root_add(struct acpi
 			int bus = 0;
 			acpi_status status;
 
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Wrong _BBN value, please reboot and using option 'pci=noacpi'\n"));
+			ACPI_ERROR((AE_INFO,
+				    "Wrong _BBN value, please reboot"
+				    " and using option 'pci=noacpi'\n"));
 
 			status = try_get_root_bridge_busnr(root->handle, &bus);
 			if (ACPI_FAILURE(status))
@@ -273,9 +274,9 @@ static int acpi_pci_root_add(struct acpi
 	 */
 	root->bus = pci_acpi_scan_root(device, root->id.segment, root->id.bus);
 	if (!root->bus) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Bus %04x:%02x not present in PCI namespace\n",
-				  root->id.segment, root->id.bus));
+		ACPI_ERROR((AE_INFO,
+			    "Bus %04x:%02x not present in PCI namespace\n",
+			    root->id.segment, root->id.bus));
 		result = -ENODEV;
 		goto end;
 	}
Index: linux-2.6.15/drivers/acpi/power.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/power.c
+++ linux-2.6.15/drivers/acpi/power.c
@@ -105,8 +105,8 @@ acpi_power_get_context(acpi_handle handl
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Error getting context [%p]\n",
-				  handle));
+		ACPI_WARNING((AE_INFO, "Getting context [%p]\n",
+			      handle));
 		return_VALUE(result);
 	}
 
@@ -292,7 +292,7 @@ int acpi_enable_wakeup_device_power(stru
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
 		ret = acpi_power_on(dev->wakeup.resources.handles[i]);
 		if (ret) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			ACPI_ERROR((AE_INFO,
 					  "Error transition power state\n"));
 			dev->wakeup.flags.valid = 0;
 			return_VALUE(-1);
@@ -302,7 +302,7 @@ int acpi_enable_wakeup_device_power(stru
 	/* Execute PSW */
 	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
 	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluate _PSW\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluate _PSW\n"));
 		dev->wakeup.flags.valid = 0;
 		ret = -1;
 	}
@@ -332,7 +332,7 @@ int acpi_disable_wakeup_device_power(str
 	/* Execute PSW */
 	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
 	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluate _PSW\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluate _PSW\n"));
 		dev->wakeup.flags.valid = 0;
 		return_VALUE(-1);
 	}
@@ -341,7 +341,7 @@ int acpi_disable_wakeup_device_power(str
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
 		ret = acpi_power_off_device(dev->wakeup.resources.handles[i]);
 		if (ret) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			ACPI_ERROR((AE_INFO,
 					  "Error transition power state\n"));
 			dev->wakeup.flags.valid = 0;
 			return_VALUE(-1);
@@ -444,9 +444,9 @@ int acpi_power_transition(struct acpi_de
 	device->power.state = state;
       end:
 	if (result)
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Error transitioning device [%s] to D%d\n",
-				  device->pnp.bus_id, state));
+		ACPI_WARNING((AE_INFO,
+			      "Transitioning device [%s] to D%d\n",
+			      device->pnp.bus_id, state));
 
 	return_VALUE(result);
 }
@@ -516,9 +516,7 @@ static int acpi_power_add_fs(struct acpi
 	entry = create_proc_entry(ACPI_POWER_FILE_STATUS,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_POWER_FILE_STATUS));
+		return_VALUE(-EIO);
 	else {
 		entry->proc_fops = &acpi_power_fops;
 		entry->data = acpi_driver_data(device);
Index: linux-2.6.15/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/processor_core.c
+++ linux-2.6.15/drivers/acpi/processor_core.c
@@ -328,8 +328,7 @@ static int acpi_processor_add_fs(struct 
 	entry = create_proc_entry(ACPI_PROCESSOR_FILE_INFO,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
+		ACPI_ERROR((AE_INFO, "Unable to create '%s' fs entry\n",
 				  ACPI_PROCESSOR_FILE_INFO));
 	else {
 		entry->proc_fops = &acpi_processor_info_fops;
@@ -342,9 +341,7 @@ static int acpi_processor_add_fs(struct 
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_PROCESSOR_FILE_THROTTLING));
+		return_VALUE(-EIO);
 	else {
 		entry->proc_fops = &acpi_processor_throttling_fops;
 		entry->data = acpi_driver_data(device);
@@ -356,9 +353,7 @@ static int acpi_processor_add_fs(struct 
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_PROCESSOR_FILE_LIMIT));
+		return_VALUE( -EIO);
 	else {
 		entry->proc_fops = &acpi_processor_limit_fops;
 		entry->data = acpi_driver_data(device);
@@ -459,8 +454,7 @@ static int acpi_processor_get_info(struc
 	 */
 	status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error evaluating processor object\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating processor object\n"));
 		return_VALUE(-ENODEV);
 	}
 
@@ -490,9 +484,9 @@ static int acpi_processor_get_info(struc
 	if (cpu_index >= NR_CPUS) {
 		if (ACPI_FAILURE
 		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Error getting cpuindex for acpiid 0x%x\n",
-					  pr->acpi_id));
+			ACPI_ERROR((AE_INFO,
+				    "Error getting cpuindex for acpiid 0x%x\n",
+				    pr->acpi_id));
 			return_VALUE(-ENODEV);
 		}
 	}
@@ -503,8 +497,8 @@ static int acpi_processor_get_info(struc
 	if (!object.processor.pblk_address)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
 	else if (object.processor.pblk_length != 6)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid PBLK length [%d]\n",
-				  object.processor.pblk_length));
+		ACPI_ERROR((AE_INFO, "Invalid PBLK length [%d]\n",
+			    object.processor.pblk_length));
 	else {
 		pr->throttling.address = object.processor.pblk_address;
 		pr->throttling.duty_offset = acpi_fadt.duty_offset;
@@ -558,8 +552,8 @@ static int acpi_processor_start(struct a
 	 */
 	if (processor_device_array[pr->id] != NULL &&
 	    processor_device_array[pr->id] != (void *)device) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "BIOS reporting wrong ACPI id"
-			"for the processor\n"));
+		ACPI_WARNING((AE_INFO, "BIOS reporting wrong ACPI id"
+			    "for the processor\n"));
 		return_VALUE(-ENODEV);
 	}
 	processor_device_array[pr->id] = (void *)device;
@@ -573,8 +567,8 @@ static int acpi_processor_start(struct a
 	status = acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 					     acpi_processor_notify, pr);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing device notify handler\n"));
+		ACPI_ERROR((AE_INFO,
+			    "Error installing device notify handler\n"));
 	}
 
 	/* _PDC call should be done before doing anything else (if reqd.). */
@@ -676,8 +670,8 @@ static int acpi_processor_remove(struct 
 	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 					    acpi_processor_notify);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error removing notify handler\n"));
+		ACPI_ERROR((AE_INFO,
+			    "Error removing notify handler\n"));
 	}
 
 	acpi_processor_remove_fs(device);
@@ -705,8 +699,7 @@ static int is_processor_present(acpi_han
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_PRESENT)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Processor Device is not present\n"));
+		ACPI_WARNING((AE_INFO, "Processor Device is not present\n"));
 		return_VALUE(0);
 	}
 	return_VALUE(1);
@@ -767,15 +760,14 @@ acpi_processor_hotplug_notify(acpi_handl
 		if (acpi_bus_get_device(handle, &device)) {
 			result = acpi_processor_device_add(handle, &device);
 			if (result)
-				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-						  "Unable to add the device\n"));
+				ACPI_ERROR((AE_INFO,
+					    "Unable to add the device\n"));
 			break;
 		}
 
 		pr = acpi_driver_data(device);
 		if (!pr) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Driver data is NULL\n"));
+			ACPI_ERROR((AE_INFO, "Driver data is NULL\n"));
 			break;
 		}
 
@@ -788,9 +780,8 @@ acpi_processor_hotplug_notify(acpi_handl
 		if ((!result) && ((pr->id >= 0) && (pr->id < NR_CPUS))) {
 			kobject_uevent(&device->kobj, KOBJ_ONLINE);
 		} else {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Device [%s] failed to start\n",
-					  acpi_device_bid(device)));
+			ACPI_ERROR((AE_INFO, "Device [%s] failed to start\n",
+				    acpi_device_bid(device)));
 		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
@@ -798,14 +789,14 @@ acpi_processor_hotplug_notify(acpi_handl
 				  "received ACPI_NOTIFY_EJECT_REQUEST\n"));
 
 		if (acpi_bus_get_device(handle, &device)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Device don't exist, dropping EJECT\n"));
+			ACPI_ERROR((AE_INFO,
+				    "Device don't exist, dropping EJECT\n"));
 			break;
 		}
 		pr = acpi_driver_data(device);
 		if (!pr) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Driver data is NULL, dropping EJECT\n"));
+			ACPI_ERROR((AE_INFO,
+				    "Driver data is NULL, dropping EJECT\n"));
 			return_VOID;
 		}
 
Index: linux-2.6.15/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.15/drivers/acpi/processor_idle.c
@@ -663,8 +663,7 @@ static int acpi_processor_get_power_info
 
 	/* There must be at least 2 elements */
 	if (!cst || (cst->type != ACPI_TYPE_PACKAGE) || cst->package.count < 2) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "not enough elements in _CST\n"));
+		ACPI_ERROR((AE_INFO, "not enough elements in _CST\n"));
 		status = -EFAULT;
 		goto end;
 	}
@@ -673,8 +672,7 @@ static int acpi_processor_get_power_info
 
 	/* Validate number of power states. */
 	if (count < 1 || count != cst->package.count - 1) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "count given by _CST is not valid\n"));
+		ACPI_ERROR((AE_INFO, "count given by _CST is not valid\n"));
 		status = -EFAULT;
 		goto end;
 	}
@@ -1094,8 +1092,8 @@ int acpi_processor_power_init(struct acp
 		status =
 		    acpi_os_write_port(acpi_fadt.smi_cmd, acpi_fadt.cst_cnt, 8);
 		if (ACPI_FAILURE(status)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Notifying BIOS of _CST ability failed\n"));
+			ACPI_ERROR((AE_INFO,
+				    "Notifying BIOS of _CST ability failed\n"));
 		}
 	}
 
@@ -1124,9 +1122,7 @@ int acpi_processor_power_init(struct acp
 	entry = create_proc_entry(ACPI_PROCESSOR_FILE_POWER,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_PROCESSOR_FILE_POWER));
+		return -EIO;
 	else {
 		entry->proc_fops = &acpi_processor_power_fops;
 		entry->data = acpi_driver_data(device);
Index: linux-2.6.15/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/processor_perflib.c
+++ linux-2.6.15/drivers/acpi/processor_perflib.c
@@ -122,7 +122,7 @@ static int acpi_processor_get_platform_l
 		acpi_processor_ppc_status |= PPC_IN_USE;
 
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PPC\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _PPC\n"));
 		return_VALUE(-ENODEV);
 	}
 
@@ -171,14 +171,14 @@ static int acpi_processor_get_performanc
 
 	status = acpi_evaluate_object(pr->handle, "_PCT", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PCT\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _PCT\n"));
 		return_VALUE(-ENODEV);
 	}
 
 	pct = (union acpi_object *)buffer.pointer;
 	if (!pct || (pct->type != ACPI_TYPE_PACKAGE)
 	    || (pct->package.count != 2)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PCT data\n"));
+		ACPI_ERROR((AE_INFO, "Invalid _PCT data\n"));
 		result = -EFAULT;
 		goto end;
 	}
@@ -192,8 +192,7 @@ static int acpi_processor_get_performanc
 	if ((obj.type != ACPI_TYPE_BUFFER)
 	    || (obj.buffer.length < sizeof(struct acpi_pct_register))
 	    || (obj.buffer.pointer == NULL)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Invalid _PCT data (control_register)\n"));
+		ACPI_ERROR((AE_INFO, "Invalid _PCT data (control_register)\n"));
 		result = -EFAULT;
 		goto end;
 	}
@@ -209,8 +208,7 @@ static int acpi_processor_get_performanc
 	if ((obj.type != ACPI_TYPE_BUFFER)
 	    || (obj.buffer.length < sizeof(struct acpi_pct_register))
 	    || (obj.buffer.pointer == NULL)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Invalid _PCT data (status_register)\n"));
+		ACPI_ERROR((AE_INFO, "Invalid _PCT data (status_register)\n"));
 		result = -EFAULT;
 		goto end;
 	}
@@ -238,13 +236,13 @@ static int acpi_processor_get_performanc
 
 	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PSS\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _PSS\n"));
 		return_VALUE(-ENODEV);
 	}
 
 	pss = (union acpi_object *)buffer.pointer;
 	if (!pss || (pss->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSS data\n"));
+		ACPI_ERROR((AE_INFO, "Invalid _PSS data\n"));
 		result = -EFAULT;
 		goto end;
 	}
@@ -273,8 +271,7 @@ static int acpi_processor_get_performanc
 		status = acpi_extract_package(&(pss->package.elements[i]),
 					      &format, &state);
 		if (ACPI_FAILURE(status)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Invalid _PSS data\n"));
+			ACPI_ERROR((AE_INFO, "Invalid _PSS data\n"));
 			result = -EFAULT;
 			kfree(pr->performance->states);
 			goto end;
@@ -290,8 +287,8 @@ static int acpi_processor_get_performanc
 				  (u32) px->control, (u32) px->status));
 
 		if (!px->core_frequency) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Invalid _PSS data: freq is zero\n"));
+			ACPI_ERROR((AE_INFO,
+				    "Invalid _PSS data: freq is zero\n"));
 			result = -EFAULT;
 			kfree(pr->performance->states);
 			goto end;
@@ -386,10 +383,10 @@ int acpi_processor_notify_smm(struct mod
 	status = acpi_os_write_port(acpi_fadt.smi_cmd,
 				    (u32) acpi_fadt.pstate_cnt, 8);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Failed to write pstate_cnt [0x%x] to "
-				  "smi_cmd [0x%x]\n", acpi_fadt.pstate_cnt,
-				  acpi_fadt.smi_cmd));
+		ACPI_ERROR((AE_INFO,
+			    "Failed to write pstate_cnt [0x%x] to "
+			    "smi_cmd [0x%x]\n", acpi_fadt.pstate_cnt,
+			    acpi_fadt.smi_cmd));
 		module_put(calling_module);
 		return_VALUE(status);
 	}
@@ -513,11 +510,7 @@ static void acpi_cpufreq_add_file(struct
 	entry = create_proc_entry(ACPI_PROCESSOR_FILE_PERFORMANCE,
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
-	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_PROCESSOR_FILE_PERFORMANCE));
-	else {
+	if (entry)
 		acpi_processor_perf_fops.write = acpi_processor_write_performance;
 		entry->proc_fops = &acpi_processor_perf_fops;
 		entry->data = acpi_driver_data(device);
Index: linux-2.6.15/drivers/acpi/processor_thermal.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/processor_thermal.c
+++ linux-2.6.15/drivers/acpi/processor_thermal.c
@@ -82,7 +82,7 @@ static int acpi_processor_apply_limit(st
 
       end:
 	if (result)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unable to set limit\n"));
+		ACPI_ERROR((AE_INFO, "Unable to set limit\n"));
 
 	return_VALUE(result);
 }
@@ -289,7 +289,7 @@ int acpi_processor_set_thermal_limit(acp
 
 		result = acpi_processor_apply_limit(pr);
 		if (result)
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			ACPI_ERROR((AE_INFO,
 					  "Unable to set thermal limit\n"));
 
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Thermal limit now (P%d:T%d)\n",
@@ -362,25 +362,23 @@ static ssize_t acpi_processor_write_limi
 	ACPI_FUNCTION_TRACE("acpi_processor_write_limit");
 
 	if (!pr || (count > sizeof(limit_string) - 1)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));
 		return_VALUE(-EINVAL);
 	}
 
 	if (copy_from_user(limit_string, buffer, count)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data\n"));
 		return_VALUE(-EFAULT);
 	}
 
 	limit_string[count] = '\0';
 
 	if (sscanf(limit_string, "%d:%d", &px, &tx) != 2) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data format\n"));
+		ACPI_ERROR((AE_INFO, "Invalid data format\n"));
 		return_VALUE(-EINVAL);
 	}
 
 	if (pr->flags.throttling) {
 		if ((tx < 0) || (tx > (pr->throttling.state_count - 1))) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid tx\n"));
+			ACPI_ERROR((AE_INFO, "Invalid tx\n"));
 			return_VALUE(-EINVAL);
 		}
 		pr->limit.user.tx = tx;
Index: linux-2.6.15/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6.15/drivers/acpi/processor_throttling.c
@@ -196,7 +196,7 @@ int acpi_processor_get_throttling_info(s
 	}
 	/* TBD: Support duty_cycle values that span bit 4. */
 	else if ((pr->throttling.duty_offset + pr->throttling.duty_width) > 4) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "duty_cycle spans bit 4\n"));
+		ACPI_WARNING((AE_INFO, "duty_cycle spans bit 4\n"));
 		return_VALUE(0);
 	}
 
Index: linux-2.6.15/drivers/acpi/scan.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/scan.c
+++ linux-2.6.15/drivers/acpi/scan.c
@@ -321,15 +321,14 @@ static int acpi_bus_get_wakeup_device_fl
 	/* _PRW */
 	status = acpi_evaluate_object(device->handle, "_PRW", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRW\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _PRW\n"));
 		goto end;
 	}
 
 	package = (union acpi_object *)buffer.pointer;
 	status = acpi_bus_extract_wakeup_device_power_package(device, package);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error extracting _PRW package\n"));
+		ACPI_ERROR((AE_INFO, "Error extracting _PRW package\n"));
 		goto end;
 	}
 
@@ -1001,7 +1000,7 @@ acpi_add_single_object(struct acpi_devic
 
 	device = kmalloc(sizeof(struct acpi_device), GFP_KERNEL);
 	if (!device) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Memory allocation error\n"));
+		ACPI_ERROR((AE_INFO, "Memory allocation error\n"));
 		return_VALUE(-ENOMEM);
 	}
 	memset(device, 0, sizeof(struct acpi_device));
Index: linux-2.6.15/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/thermal.c
+++ linux-2.6.15/drivers/acpi/thermal.c
@@ -323,7 +323,7 @@ static int acpi_thermal_get_trip_points(
 				       &tz->trips.critical.temperature);
 	if (ACPI_FAILURE(status)) {
 		tz->trips.critical.flags.valid = 0;
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No critical threshold\n"));
+		ACPI_ERROR((AE_INFO, "No critical threshold\n"));
 		return_VALUE(-ENODEV);
 	} else {
 		tz->trips.critical.flags.valid = 1;
@@ -382,8 +382,7 @@ static int acpi_thermal_get_trip_points(
 			tz->trips.passive.flags.valid = 0;
 
 		if (!tz->trips.passive.flags.valid)
-			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-					  "Invalid passive threshold\n"));
+			ACPI_WARNING((AE_INFO, "Invalid passive threshold\n"));
 		else
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "Found passive threshold [%lu]\n",
@@ -412,9 +411,8 @@ static int acpi_thermal_get_trip_points(
 					  "Found active threshold [%d]:[%lu]\n",
 					  i, tz->trips.active[i].temperature));
 		} else
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Invalid active threshold [%d]\n",
-					  i));
+			ACPI_ERROR((AE_INFO,
+				    "Invalid active threshold [%d]\n", i));
 	}
 
 	return_VALUE(0);
@@ -469,7 +467,7 @@ static int acpi_thermal_critical(struct 
 		return_VALUE(-EINVAL);
 
 	if (tz->temperature >= tz->trips.critical.temperature) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
+		ACPI_WARNING((AE_INFO, "Critical trip point\n"));
 		tz->trips.critical.flags.enabled = 1;
 	} else if (tz->trips.critical.flags.enabled)
 		tz->trips.critical.flags.enabled = 0;
@@ -500,7 +498,7 @@ static int acpi_thermal_hot(struct acpi_
 		return_VALUE(-EINVAL);
 
 	if (tz->temperature >= tz->trips.hot.temperature) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Hot trip point\n"));
+		ACPI_WARNING((AE_INFO, "Hot trip point\n"));
 		tz->trips.hot.flags.enabled = 1;
 	} else if (tz->trips.hot.flags.enabled)
 		tz->trips.hot.flags.enabled = 0;
@@ -640,10 +638,10 @@ static void acpi_thermal_active(struct a
 						       handles[j],
 						       ACPI_STATE_D0);
 				if (result) {
-					ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-							  "Unable to turn cooling device [%p] 'on'\n",
-							  active->devices.
-							  handles[j]));
+					ACPI_WARNING((AE_INFO,
+						      "Unable to turn cooling device [%p] 'on'\n",
+						      active->devices.
+						      handles[j]));
 					continue;
 				}
 				active->flags.enabled = 1;
@@ -665,9 +663,9 @@ static void acpi_thermal_active(struct a
 			result = acpi_bus_set_power(active->devices.handles[j],
 						    ACPI_STATE_D3);
 			if (result) {
-				ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-						  "Unable to turn cooling device [%p] 'off'\n",
-						  active->devices.handles[j]));
+				ACPI_WARNING((AE_INFO,
+					      "Unable to turn cooling device [%p] 'off'\n",
+					      active->devices.handles[j]));
 				continue;
 			}
 			active->flags.enabled = 0;
@@ -699,7 +697,7 @@ static void acpi_thermal_check(void *dat
 	ACPI_FUNCTION_TRACE("acpi_thermal_check");
 
 	if (!tz) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) context.\n"));
+		ACPI_ERROR((AE_INFO, "Invalid (NULL) context.\n"));
 		return_VOID;
 	}
 
@@ -946,13 +944,11 @@ acpi_thermal_write_trip_points(struct fi
 		return_VALUE(-ENOMEM);
 
 	if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));
 		count = -EINVAL;
 		goto end;
 	}
 
 	if (copy_from_user(limit_string, buffer, count)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data\n"));
 		count = -EFAULT;
 		goto end;
 	}
@@ -965,7 +961,6 @@ acpi_thermal_write_trip_points(struct fi
 		     &active[5], &active[6], &active[7], &active[8],
 		     &active[9]);
 	if (!(num >= 5 && num < (ACPI_THERMAL_MAX_ACTIVE + 3))) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data format\n"));
 		count = -EINVAL;
 		goto end;
 	}
@@ -1125,9 +1120,7 @@ static int acpi_thermal_add_fs(struct ac
 	entry = create_proc_entry(ACPI_THERMAL_FILE_STATE,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_THERMAL_FILE_STATE));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_thermal_state_fops;
 		entry->data = acpi_driver_data(device);
@@ -1138,9 +1131,7 @@ static int acpi_thermal_add_fs(struct ac
 	entry = create_proc_entry(ACPI_THERMAL_FILE_TEMPERATURE,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_THERMAL_FILE_TEMPERATURE));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_thermal_temp_fops;
 		entry->data = acpi_driver_data(device);
@@ -1152,9 +1143,7 @@ static int acpi_thermal_add_fs(struct ac
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_THERMAL_FILE_TRIP_POINTS));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_thermal_trip_fops;
 		entry->data = acpi_driver_data(device);
@@ -1166,9 +1155,7 @@ static int acpi_thermal_add_fs(struct ac
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_THERMAL_FILE_COOLING_MODE));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_thermal_cooling_fops;
 		entry->data = acpi_driver_data(device);
@@ -1180,9 +1167,7 @@ static int acpi_thermal_add_fs(struct ac
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create '%s' fs entry\n",
-				  ACPI_THERMAL_FILE_POLLING_FREQ));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_thermal_polling_fops;
 		entry->data = acpi_driver_data(device);
@@ -1352,8 +1337,6 @@ static int acpi_thermal_add(struct acpi_
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_thermal_notify, tz);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing notify handler\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -1395,9 +1378,6 @@ static int acpi_thermal_remove(struct ac
 	status = acpi_remove_notify_handler(tz->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_thermal_notify);
-	if (ACPI_FAILURE(status))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error removing notify handler\n"));
 
 	/* Terminate policy */
 	if (tz->trips.passive.flags.valid && tz->trips.passive.flags.enabled) {
Index: linux-2.6.15/drivers/acpi/utils.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/utils.c
+++ linux-2.6.15/drivers/acpi/utils.c
@@ -62,26 +62,25 @@ acpi_extract_package(union acpi_object *
 
 	if (!package || (package->type != ACPI_TYPE_PACKAGE)
 	    || (package->package.count < 1)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Invalid 'package' argument\n"));
+		ACPI_WARNING((AE_INFO, "Invalid 'package' argument\n"));
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
 	if (!format || !format->pointer || (format->length < 1)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid 'format' argument\n"));
+		ACPI_WARNING((AE_INFO, "Invalid 'format' argument\n"));
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
 	if (!buffer) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid 'buffer' argument\n"));
+		ACPI_WARNING((AE_INFO, "Invalid 'buffer' argument\n"));
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
 	format_count = (format->length / sizeof(char)) - 1;
 	if (format_count > package->package.count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Format specifies more objects [%d] than exist in package [%d].",
-				  format_count, package->package.count));
+		ACPI_WARNING((AE_INFO, "Format specifies more objects [%d]"
+			      " than exist in package [%d].",
+			      format_count, package->package.count));
 		return_ACPI_STATUS(AE_BAD_DATA);
 	}
 
@@ -113,9 +112,10 @@ acpi_extract_package(union acpi_object *
 				tail_offset += sizeof(char *);
 				break;
 			default:
-				ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-						  "Invalid package element [%d]: got number, expecing [%c].\n",
-						  i, format_string[i]));
+				ACPI_WARNING((AE_INFO, "Invalid package element"
+					      " [%d]: got number, expecing"
+					      " [%c].\n",
+					      i, format_string[i]));
 				return_ACPI_STATUS(AE_BAD_DATA);
 				break;
 			}
@@ -138,9 +138,10 @@ acpi_extract_package(union acpi_object *
 				tail_offset += sizeof(u8 *);
 				break;
 			default:
-				ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-						  "Invalid package element [%d] got string/buffer, expecing [%c].\n",
-						  i, format_string[i]));
+				ACPI_WARNING((AE_INFO, "Invalid package element"
+					      " [%d] got string/buffer,"
+					      " expecing [%c].\n",
+					      i, format_string[i]));
 				return_ACPI_STATUS(AE_BAD_DATA);
 				break;
 			}
@@ -323,7 +324,7 @@ acpi_evaluate_string(acpi_handle handle,
 
 	*data = kmalloc(element->string.length + 1, GFP_KERNEL);
 	if (!data) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Memory allocation error\n"));
+		ACPI_ERROR((AE_INFO, "Memory allocation error\n"));
 		return_VALUE(-ENOMEM);
 	}
 	memset(*data, 0, element->string.length + 1);
@@ -365,25 +366,22 @@ acpi_evaluate_reference(acpi_handle hand
 	package = (union acpi_object *)buffer.pointer;
 
 	if ((buffer.length == 0) || !package) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "No return object (len %X ptr %p)\n",
-				  (unsigned)buffer.length, package));
+		ACPI_ERROR((AE_INFO, "No return object (len %X ptr %p)\n",
+			    (unsigned)buffer.length, package));
 		status = AE_BAD_DATA;
 		acpi_util_eval_error(handle, pathname, status);
 		goto end;
 	}
 	if (package->type != ACPI_TYPE_PACKAGE) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Expecting a [Package], found type %X\n",
-				  package->type));
+		ACPI_ERROR((AE_INFO, "Expecting a [Package], found type %X\n",
+			    package->type));
 		status = AE_BAD_DATA;
 		acpi_util_eval_error(handle, pathname, status);
 		goto end;
 	}
 	if (!package->package.count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "[Package] has zero elements (%p)\n",
-				  package));
+		ACPI_ERROR((AE_INFO, "[Package] has zero elements (%p)\n",
+			    package));
 		status = AE_BAD_DATA;
 		acpi_util_eval_error(handle, pathname, status);
 		goto end;
@@ -402,9 +400,9 @@ acpi_evaluate_reference(acpi_handle hand
 
 		if (element->type != ACPI_TYPE_ANY) {
 			status = AE_BAD_DATA;
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Expecting a [Reference] package element, found type %X\n",
-					  element->type));
+			ACPI_ERROR((AE_INFO,
+				    "Expecting a [Reference] package element, found type %X\n",
+				    element->type));
 			acpi_util_eval_error(handle, pathname, status);
 			break;
 		}
Index: linux-2.6.15/drivers/acpi/video.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/video.c
+++ linux-2.6.15/drivers/acpi/video.c
@@ -324,7 +324,7 @@ acpi_video_device_lcd_query_levels(struc
 		return_VALUE(status);
 	obj = (union acpi_object *)buffer.pointer;
 	if (!obj && (obj->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _BCL data\n"));
+		ACPI_ERROR((AE_INFO, "Invalid _BCL data\n"));
 		status = -EFAULT;
 		goto err;
 	}
@@ -399,7 +399,7 @@ acpi_video_device_EDID(struct acpi_video
 	if (obj && obj->type == ACPI_TYPE_BUFFER)
 		*edid = obj;
 	else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _DDC data\n"));
+		ACPI_ERROR((AE_INFO, "Invalid _DDC data\n"));
 		status = -EFAULT;
 		kfree(obj);
 	}
@@ -560,8 +560,7 @@ static void acpi_video_device_find_cap(s
 				o = (union acpi_object *)&obj->package.
 				    elements[i];
 				if (o->type != ACPI_TYPE_INTEGER) {
-					ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-							  "Invalid data\n"));
+					ACPI_ERROR((AE_INFO, "Invalid data\n"));
 					continue;
 				}
 				br->levels[count] = (u32) o->integer.value;
@@ -904,8 +903,7 @@ static int acpi_video_device_add_fs(stru
 	/* 'info' [R] */
 	entry = create_proc_entry("info", S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create 'info' fs entry\n"));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_video_device_info_fops;
 		entry->data = acpi_driver_data(device);
@@ -917,8 +915,7 @@ static int acpi_video_device_add_fs(stru
 	    create_proc_entry("state", S_IFREG | S_IRUGO | S_IWUSR,
 			      acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create 'state' fs entry\n"));
+		return_VALUE(-ENODEV);
 	else {
 		acpi_video_device_state_fops.write = acpi_video_device_write_state;
 		entry->proc_fops = &acpi_video_device_state_fops;
@@ -931,8 +928,7 @@ static int acpi_video_device_add_fs(stru
 	    create_proc_entry("brightness", S_IFREG | S_IRUGO | S_IWUSR,
 			      acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create 'brightness' fs entry\n"));
+		return_VALUE(-ENODEV);
 	else {
 		acpi_video_device_brightness_fops.write = acpi_video_device_write_brightness;
 		entry->proc_fops = &acpi_video_device_brightness_fops;
@@ -943,8 +939,7 @@ static int acpi_video_device_add_fs(stru
 	/* 'EDID' [R] */
 	entry = create_proc_entry("EDID", S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create 'brightness' fs entry\n"));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_video_device_EDID_fops;
 		entry->data = acpi_driver_data(device);
@@ -1200,8 +1195,7 @@ static int acpi_video_bus_add_fs(struct 
 	/* 'info' [R] */
 	entry = create_proc_entry("info", S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create 'info' fs entry\n"));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_video_bus_info_fops;
 		entry->data = acpi_driver_data(device);
@@ -1211,8 +1205,7 @@ static int acpi_video_bus_add_fs(struct 
 	/* 'ROM' [R] */
 	entry = create_proc_entry("ROM", S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create 'ROM' fs entry\n"));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_video_bus_ROM_fops;
 		entry->data = acpi_driver_data(device);
@@ -1223,8 +1216,7 @@ static int acpi_video_bus_add_fs(struct 
 	entry =
 	    create_proc_entry("POST_info", S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create 'POST_info' fs entry\n"));
+		return_VALUE(-ENODEV);
 	else {
 		entry->proc_fops = &acpi_video_bus_POST_info_fops;
 		entry->data = acpi_driver_data(device);
@@ -1236,8 +1228,7 @@ static int acpi_video_bus_add_fs(struct 
 	    create_proc_entry("POST", S_IFREG | S_IRUGO | S_IRUSR,
 			      acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create 'POST' fs entry\n"));
+		return_VALUE(-ENODEV);
 	else {
 		acpi_video_bus_POST_fops.write = acpi_video_bus_write_POST;
 		entry->proc_fops = &acpi_video_bus_POST_fops;
@@ -1250,8 +1241,7 @@ static int acpi_video_bus_add_fs(struct 
 	    create_proc_entry("DOS", S_IFREG | S_IRUGO | S_IRUSR,
 			      acpi_device_dir(device));
 	if (!entry)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to create 'DOS' fs entry\n"));
+		return_VALUE(-ENODEV);
 	else {
 		acpi_video_bus_DOS_fops.write = acpi_video_bus_write_DOS;
 		entry->proc_fops = &acpi_video_bus_DOS_fops;
@@ -1344,8 +1334,6 @@ acpi_video_bus_get_one_device(struct acp
 						     acpi_video_device_notify,
 						     data);
 		if (ACPI_FAILURE(status)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Error installing notify handler\n"));
 			result = -ENODEV;
 			goto end;
 		}
@@ -1444,13 +1432,13 @@ static int acpi_video_device_enumerate(s
 
 	status = acpi_evaluate_object(video->handle, "_DOD", NULL, &buffer);
 	if (!ACPI_SUCCESS(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _DOD\n"));
+		ACPI_ERROR((AE_INFO, "Error evaluating _DOD\n"));
 		return_VALUE(status);
 	}
 
 	dod = (union acpi_object *)buffer.pointer;
 	if (!dod || (dod->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _DOD data\n"));
+		ACPI_ERROR((AE_INFO, "Invalid _DOD data\n"));
 		status = -EFAULT;
 		goto out;
 	}
@@ -1474,8 +1462,7 @@ static int acpi_video_device_enumerate(s
 		obj = (union acpi_object *)&dod->package.elements[i];
 
 		if (obj->type != ACPI_TYPE_INTEGER) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Invalid _DOD data\n"));
+			ACPI_ERROR((AE_INFO, "Invalid _DOD data\n"));
 			active_device_list[i].value.int_val =
 			    ACPI_VIDEO_HEAD_INVALID;
 		}
@@ -1589,8 +1576,7 @@ acpi_video_bus_get_devices(struct acpi_v
 
 		status = acpi_video_bus_get_one_device(dev, video);
 		if (ACPI_FAILURE(status)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Cant attach device\n"));
+			ACPI_ERROR((AE_INFO, "Cant attach device\n"));
 			continue;
 		}
 
@@ -1618,9 +1604,6 @@ static int acpi_video_bus_put_one_device
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
-	if (ACPI_FAILURE(status))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error removing notify handler\n"));
 
 	return_VALUE(0);
 }
@@ -1783,8 +1766,6 @@ static int acpi_video_bus_add(struct acp
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_video_bus_notify, video);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing notify handler\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -1821,9 +1802,6 @@ static int acpi_video_bus_remove(struct 
 	status = acpi_remove_notify_handler(video->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_bus_notify);
-	if (ACPI_FAILURE(status))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error removing notify handler\n"));
 
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
Index: linux-2.6.15/drivers/acpi/system.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/system.c
+++ linux-2.6.15/drivers/acpi/system.c
@@ -161,9 +161,6 @@ static int __init acpi_system_init(void)
 	return_VALUE(error);
 
       Error:
-	ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-			  "Unable to create '%s' proc fs entry\n", name));
-
 	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
 	remove_proc_entry(ACPI_SYSTEM_FILE_DSDT, acpi_root_dir);
 	remove_proc_entry(ACPI_SYSTEM_FILE_INFO, acpi_root_dir);

--------------030409000608020204090403--
