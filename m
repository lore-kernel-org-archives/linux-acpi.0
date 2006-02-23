From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] acpi_memoryhotplug.c needs not to walk whole namespace twice to register notify handler
Date: Thu, 23 Feb 2006 06:25:57 +0100
Message-ID: <200602230625.58671.trenn@suse.de>
References: <200602230103.15673.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:16093 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750819AbWBWF0I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Feb 2006 00:26:08 -0500
In-Reply-To: <200602230103.15673.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, intel-linux-acpi@linux.intel.com
Cc: kamezawa.hiroyu@jp.fujitsu.com, "Yu, Luming" <luming.yu@intel.com>, Kristen Accardi <kristen.c.accardi@intel.com>

On Thursday 23 February 2006 01:03, Thomas Renninger wrote:
> That is how it should be:
> acpi_memoryhotplug.c invokes register_driver in it's init func.
> There the ACPI device matching HID is searched the device pointer passed
> to the driver and memoryhotplug's .add function invoked.
> There (at .add func of memhotplug) the register_notify_handler should be placed ...
> if I see things right?
> 
> This is how it is currently done in memhotplug:
> Driver_register is invoked. There the HID is searched and device pointer passed
> if a memory hotplug device is found.
> Then a second search for the same HID (by walk_namespace) is done in memhotplug
> and the notify handler is registered for those.
> 
> I couldn't find an author for acpi_memoryhotplug.c, shouldn't there someone be
> added who working most on this stuff, I have no idea whom to add into CC for that...
> Could someone please review that, the register_notify_handler stuff there looks
> somewhat insane and if I see things correctly a call like:
> acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ...)
> could be costy as it runs through all the namespace (some hundreds/thousands of objects?)
> and searches for a matching _HID. But I might have overseen something and this is really needed...
> 
> Kristen: Maybe you should make the docking driver an ACPI device driver
> with register_driver in it's init func and an .add func where the notify handler is registered.
> 
> BTW: How is this memory hotplugging supposed to work. It only reacts on ACPI notifies, my machine
> only has "Check" notify events for mem. What kind of hardware do I need to test this and
> how will the eject request be initiated?
> 
This one is better...

Subject: acpi_memoryhotplug.c needs not to walk whole namespace twice

Do not walk through whole namespace to find the memhotplug device. It
is already found by register_driver, .add is invoked if register_driver
finds a device, register the notify handler there.

signed-off-by: Thomas Renninger <trenn@suse.de>

drivers/acpi/acpi_memhotplug.c |  103 +++--------------------------------------
1 files changed, 8 insertions(+), 95 deletions(-)

Index: linux-2.6.15/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.15/drivers/acpi/acpi_memhotplug.c
@@ -394,6 +394,10 @@ static int acpi_memory_device_add(struct
 	/* Set the device state */
 	mem_device->state = MEMORY_POWER_ON_STATE;
 
+	/* register notify handler, ignore error if there could be any */
+	acpi_install_notify_handler(device->handle, ACPI_SYSTEM_NOTIFY,
+				    acpi_memory_device_notify, NULL);
+
 	printk(KERN_INFO "%s \n", acpi_device_name(device));
 
 	return_VALUE(result);
@@ -408,84 +412,16 @@ static int acpi_memory_device_remove(str
 	if (!device || !acpi_driver_data(device))
 		return_VALUE(-EINVAL);
 
+	acpi_remove_notify_handler(device->handle,
+				   ACPI_SYSTEM_NOTIFY,
+				   acpi_memory_device_notify);
+
 	mem_device = (struct acpi_memory_device *)acpi_driver_data(device);
 	kfree(mem_device);
 
 	return_VALUE(0);
 }
 
-/*
- * Helper function to check for memory device
- */
-static acpi_status is_memory_device(acpi_handle handle)
-{
-	char *hardware_id;
-	acpi_status status;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device_info *info;
-
-	ACPI_FUNCTION_TRACE("is_memory_device");
-
-	status = acpi_get_object_info(handle, &buffer);
-	if (ACPI_FAILURE(status))
-		return_ACPI_STATUS(status);
-
-	info = buffer.pointer;
-	if (!(info->valid & ACPI_VALID_HID)) {
-		acpi_os_free(buffer.pointer);
-		return_ACPI_STATUS(AE_ERROR);
-	}
-
-	hardware_id = info->hardware_id.value;
-	if ((hardware_id == NULL) ||
-	    (strcmp(hardware_id, ACPI_MEMORY_DEVICE_HID)))
-		status = AE_ERROR;
-
-	acpi_os_free(buffer.pointer);
-	return_ACPI_STATUS(status);
-}
-
-static acpi_status
-acpi_memory_register_notify_handler(acpi_handle handle,
-				    u32 level, void *ctxt, void **retv)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE("acpi_memory_register_notify_handler");
-
-	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
-		return_ACPI_STATUS(AE_OK);	/* continue */
-	}
-
-	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
-					     acpi_memory_device_notify, NULL);
-	/* continue */
-	return_ACPI_STATUS(AE_OK);
-}
-
-static acpi_status
-acpi_memory_deregister_notify_handler(acpi_handle handle,
-				      u32 level, void *ctxt, void **retv)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE("acpi_memory_deregister_notify_handler");
-
-	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
-		return_ACPI_STATUS(AE_OK);	/* continue */
-	}
-
-	status = acpi_remove_notify_handler(handle,
-					    ACPI_SYSTEM_NOTIFY,
-					    acpi_memory_device_notify);
-
-	return_ACPI_STATUS(AE_OK);	/* continue */
-}
-
 static int __init acpi_memory_device_init(void)
 {
 	int result;
@@ -498,17 +434,6 @@ static int __init acpi_memory_device_ini
 	if (result < 0)
 		return_VALUE(-ENODEV);
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX,
-				     acpi_memory_register_notify_handler,
-				     NULL, NULL);
-
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
-		acpi_bus_unregister_driver(&acpi_memory_device_driver);
-		return_VALUE(-ENODEV);
-	}
-
 	return_VALUE(0);
 }
 
@@ -518,18 +443,6 @@ static void __exit acpi_memory_device_ex
 
 	ACPI_FUNCTION_TRACE("acpi_memory_device_exit");
 
-	/*
-	 * Adding this to un-install notification handlers for all the device
-	 * handles.
-	 */
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX,
-				     acpi_memory_deregister_notify_handler,
-				     NULL, NULL);
-
-	if (ACPI_FAILURE(status))
-		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
-
 	acpi_bus_unregister_driver(&acpi_memory_device_driver);
 
 	return_VOID;
