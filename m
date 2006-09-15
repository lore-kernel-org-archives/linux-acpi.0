From: Thomas Renninger <mail@renninger.de>
Subject: ACPI hotpluggable device improvements
Date: Fri, 15 Sep 2006 18:23:15 +0200
Message-ID: <1158337395.3751.87.camel@sublime.site>
Reply-To: mail@renninger.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-awCNdXIWhiS4tHT1ZeEi"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx02.qsc.de ([213.148.130.14]:3205 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1751670AbWIOQXW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Sep 2006 12:23:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI-ML <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, keith mannthey <kmannth@us.ibm.com>, Yasunori Goto <y-goto@jp.fujitsu.com>, Kristen Accardi <kristen.c.accardi@intel.com>, trenn@suse.de


--=-awCNdXIWhiS4tHT1ZeEi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I finally got some time to have a look at the additional namespace walks
and other workarounds needed for ACPI devices that may not be present at
boot or module load time.

Reading the acpi-devel mails of the last weeks, I found that the ACPI
driver model will be changed anyway. Can someone point me to a relevant
discussion what will be modified and whether it makes sense to have a
further look at this.


This it is how it is currently done (devices that may not be present at
registration time):

- Add a namespace walk in modules init function (as register_device does
not call .add func
  if device is not present)
- Find potential devices by a ACPI namespaces walk and install notifier
handlers to check
  when they may get present
- Device cannot be added as callback data to notify handler callback as
it is designed for
- ...

To get this a bit better designed I have these thoughts:

There already exist .add, .remove, .start, .stop.
IMO .add should always be called when a device with the appropriate HID
is found (present or not) and .start/.stop should be called when the
device actually gets present or vanishes.

For this the notify handler must already be installed at registration
time by the scan.c backends. The individual driver/module must not
install the notify handler itself. This is that the backend notices when
a device gets (un)present and can call .stop/.start.

It should work like that then:

  - Introduce a .notify_handler callback func in the acpi_device_ops
  - In module init func, device_register is called
  - For every device for which HID matches .add is always called
  - A generic notify handler is installed for each device, not in the
module, but in scan.c
  - In .add func the driver can assign data to acpi_driver_data(device)
which will be passed to 
    the device's notify handler (maybe it should be called just .notify)
which will be called from
    the generic one
  - The driver then can go for:
       - .stop/.start funcs if it's only interested whether the device
gets (un)present
       - assign a .notify(_handler) func if it's interested in the
specific notification reason
       - or go for both

-> Gets rid of the extra namespace walk and shortens down extra code in
hotpluggable devices like container, memory_hotplug
-> Fixes battery module in respect of not recognized added battery when
there was none in the slot 
   at boot or module load time (which otherwise would also need above
extra code)

I just had a short look at the dock code. There it should be enough to
call the generic_notify_handler() for each dependent device then.
Calling add/remove for dock/eject on each device should not be
necessary, start/stop will be called instead?

Attached/below is an example patch how I think this could work out with
only battery module adjusted. The diff patches and compiles against -rc7
but should only show the idea and is untested.
Disadvantage is that every module that makes use of the acpi device
driver model must be touched...

This is just an idea for how this could get cleaned up a bit. If I
oversaw details, please tell me.

Thanks for having a look at it,

     Thomas


Index: linux-2.6.18-rc7/drivers/acpi/battery.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/battery.c
+++ linux-2.6.18-rc7/drivers/acpi/battery.c
@@ -64,6 +64,7 @@ extern void *acpi_unlock_battery_dir(str
 
 static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
+static void acpi_battery_notify(acpi_handle handle, u32 event, void *data);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = ACPI_BATTERY_DRIVER_NAME,
@@ -72,6 +73,7 @@ static struct acpi_driver acpi_battery_d
 	.ops = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
+		.notify_handler = acpi_battery_notify,
 		},
 };
 
@@ -685,7 +687,7 @@ static void acpi_battery_notify(acpi_han
 static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = 0;
+	//	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
 
 
@@ -710,13 +712,16 @@ static int acpi_battery_add(struct acpi_
 	if (result)
 		goto end;
 
+	/* Not needed any more...
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY,
 					     acpi_battery_notify, battery);
+
 	if (ACPI_FAILURE(status)) {
 		result = -ENODEV;
 		goto end;
 	}
+	*/
 
 	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
 	       ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
@@ -733,7 +738,7 @@ static int acpi_battery_add(struct acpi_
 
 static int acpi_battery_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
+    //	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
 
 
@@ -742,9 +747,11 @@ static int acpi_battery_remove(struct ac
 
 	battery = (struct acpi_battery *)acpi_driver_data(device);
 
+	/*
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
 					    acpi_battery_notify);
+	*/
 
 	acpi_battery_remove_fs(device);
 
Index: linux-2.6.18-rc7/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/scan.c
+++ linux-2.6.18-rc7/drivers/acpi/scan.c
@@ -478,6 +478,60 @@ acpi_bus_match(struct acpi_device *devic
 	return acpi_match_ids(device, driver->ids);
 }
 
+static void acpi_generic_notify(acpi_handle handle, u32 event, void *data){
+
+	struct acpi_device *device = (struct acpi_device*)data;
+	int present = device->status.present;
+	acpi_status status;
+
+	printk (KERN_INFO "Generic notifier for %s called",
+		acpi_device_bid(device));
+	if (device->driver->ops.notify_handler){
+		printk (KERN_INFO "Calling specific notifier for %s called",
+			acpi_device_bid(device));
+		device->driver->ops.notify_handler(handle, event,
+					   acpi_driver_data(device));
+	}
+
+	/* call start/stop before or after calling notify handler
+	   or not at all if there is a handler? */
+	if (device->flags.dynamic_status){
+		status = acpi_bus_get_status(device);
+		if (ACPI_FAILURE(status)){
+			ACPI_EXCEPTION ((AE_INFO, status, "Error getting"
+					 "status of device %s",
+					 acpi_device_bid(device)));
+		}
+		if (present != device->status.present){
+			if (device->status.present && device->driver->ops.start)
+				device->driver->ops.start(device);
+			else if (device->driver->ops.start)
+				/* we might want to pass separate stop reasons...
+					   switch(event){
+				*/
+				device->driver->ops.stop(device, ACPI_BUS_REMOVAL_NORMAL);
+		}
+	}
+}
+
+int acpi_driver_install_notifier(struct acpi_device *device){
+
+	acpi_status status;
+
+	if (device->driver->ops.notify_handler){
+		status = acpi_install_notify_handler(device->handle,
+						     ACPI_ALL_NOTIFY,
+						     acpi_generic_notify,
+						     acpi_driver_data(device));
+		if (ACPI_FAILURE(status)){
+			ACPI_EXCEPTION ((AE_INFO, status, "Could not install notify"
+					 "handler for %s", acpi_device_bid(device)));
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
 /**
  * acpi_bus_driver_init - add a device to a driver
  * @device: the device to add and initialize
@@ -490,7 +544,8 @@ static int
 acpi_bus_driver_init(struct acpi_device *device, struct acpi_driver *driver)
 {
 	int result = 0;
-
+	int type;
+	acpi_status status;
 
 	if (!device || !driver)
 		return -EINVAL;
@@ -507,6 +562,21 @@ acpi_bus_driver_init(struct acpi_device 
 
 	device->driver = driver;
 
+	status = acpi_get_type(device->handle, &type);
+
+	if (ACPI_FAILURE(status)){
+		ACPI_EXCEPTION ((AE_INFO, status, "Could not get type for"
+				 "device %s will not install notify handler",
+				 acpi_device_bid(device)));
+	}
+
+	/* fixed feature stuff has extra handlers... see below */
+	if (type != ACPI_BUS_TYPE_POWER_BUTTON &&
+	    type != ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		if (driver->ops.notify_handler)
+			acpi_driver_install_notifier(device);
+	}
+
 	/*
 	 * TBD - Configuration Management: Assign resources to device based
 	 * upon possible configuration and currently allocated resources.
@@ -545,17 +615,21 @@ static void acpi_driver_attach(struct ac
 		struct acpi_device *dev =
 		    container_of(node, struct acpi_device, g_list);
 
-		if (dev->driver || !dev->status.present)
+		if (dev->driver)
 			continue;
 		spin_unlock(&acpi_device_lock);
 
 		if (!acpi_bus_match(dev, drv)) {
 			if (!acpi_bus_driver_init(dev, drv)) {
-				acpi_start_single_object(dev);
-				atomic_inc(&drv->references);
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "Found driver [%s] for device [%s]\n",
-						  drv->name, dev->pnp.bus_id));
+				if (dev->status.present){
+					acpi_start_single_object(dev);
+					atomic_inc(&drv->references);
+					ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+							  "Found driver [%s]"
+							  " for device [%s]\n",
+							  drv->name,
+							  dev->pnp.bus_id));
+				}
 			}
 		}
 		spin_lock(&acpi_device_lock);
@@ -604,7 +678,6 @@ int acpi_bus_register_driver(struct acpi
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
 	acpi_driver_attach(driver);
-
 	return 0;
 }
 
Index: linux-2.6.18-rc7/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.18-rc7.orig/include/acpi/acpi_bus.h
+++ linux-2.6.18-rc7/include/acpi/acpi_bus.h
@@ -87,18 +87,20 @@ struct acpi_device;
  * -----------
  */
 
-typedef int (*acpi_op_add) (struct acpi_device * device);
-typedef int (*acpi_op_remove) (struct acpi_device * device, int type);
-typedef int (*acpi_op_lock) (struct acpi_device * device, int type);
-typedef int (*acpi_op_start) (struct acpi_device * device);
-typedef int (*acpi_op_stop) (struct acpi_device * device, int type);
-typedef int (*acpi_op_suspend) (struct acpi_device * device, int state);
-typedef int (*acpi_op_resume) (struct acpi_device * device, int state);
-typedef int (*acpi_op_scan) (struct acpi_device * device);
-typedef int (*acpi_op_bind) (struct acpi_device * device);
-typedef int (*acpi_op_unbind) (struct acpi_device * device);
-typedef int (*acpi_op_match) (struct acpi_device * device,
+typedef int  (*acpi_op_add) (struct acpi_device * device);
+typedef int  (*acpi_op_remove) (struct acpi_device * device, int type);
+typedef int  (*acpi_op_lock) (struct acpi_device * device, int type);
+typedef int  (*acpi_op_start) (struct acpi_device * device);
+typedef int  (*acpi_op_stop) (struct acpi_device * device, int type);
+typedef int  (*acpi_op_suspend) (struct acpi_device * device, int state);
+typedef int  (*acpi_op_resume) (struct acpi_device * device, int state);
+typedef int  (*acpi_op_scan) (struct acpi_device * device);
+typedef int  (*acpi_op_bind) (struct acpi_device * device);
+typedef int  (*acpi_op_unbind) (struct acpi_device * device);
+typedef int  (*acpi_op_match) (struct acpi_device * device,
 			      struct acpi_driver * driver);
+typedef void (*acpi_op_notify_handler) (acpi_handle handle,
+				       u32 event, void *data);
 
 struct acpi_bus_ops {
 	u32 acpi_op_add:1;
@@ -112,7 +114,8 @@ struct acpi_bus_ops {
 	u32 acpi_op_bind:1;
 	u32 acpi_op_unbind:1;
 	u32 acpi_op_match:1;
-	u32 reserved:21;
+	u32 acpi_op_notify_handler:1;
+	u32 reserved:20;
 };
 
 struct acpi_device_ops {
@@ -127,6 +130,7 @@ struct acpi_device_ops {
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
 	acpi_op_match match;
+	acpi_op_notify_handler notify_handler;
 };
 
 struct acpi_driver {


--=-awCNdXIWhiS4tHT1ZeEi
Content-Disposition: attachment; filename=acpi_device_register_cleanups.patch
Content-Type: text/x-patch; name=acpi_device_register_cleanups.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.18-rc7/drivers/acpi/battery.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/battery.c
+++ linux-2.6.18-rc7/drivers/acpi/battery.c
@@ -64,6 +64,7 @@ extern void *acpi_unlock_battery_dir(str
 
 static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
+static void acpi_battery_notify(acpi_handle handle, u32 event, void *data);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = ACPI_BATTERY_DRIVER_NAME,
@@ -72,6 +73,7 @@ static struct acpi_driver acpi_battery_d
 	.ops = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
+		.notify_handler = acpi_battery_notify,
 		},
 };
 
@@ -685,7 +687,7 @@ static void acpi_battery_notify(acpi_han
 static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = 0;
+	//	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
 
 
@@ -710,13 +712,16 @@ static int acpi_battery_add(struct acpi_
 	if (result)
 		goto end;
 
+	/* Not needed any more...
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_ALL_NOTIFY,
 					     acpi_battery_notify, battery);
+
 	if (ACPI_FAILURE(status)) {
 		result = -ENODEV;
 		goto end;
 	}
+	*/
 
 	printk(KERN_INFO PREFIX "%s Slot [%s] (battery %s)\n",
 	       ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
@@ -733,7 +738,7 @@ static int acpi_battery_add(struct acpi_
 
 static int acpi_battery_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
+    //	acpi_status status = 0;
 	struct acpi_battery *battery = NULL;
 
 
@@ -742,9 +747,11 @@ static int acpi_battery_remove(struct ac
 
 	battery = (struct acpi_battery *)acpi_driver_data(device);
 
+	/*
 	status = acpi_remove_notify_handler(device->handle,
 					    ACPI_ALL_NOTIFY,
 					    acpi_battery_notify);
+	*/
 
 	acpi_battery_remove_fs(device);
 
Index: linux-2.6.18-rc7/drivers/acpi/scan.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/acpi/scan.c
+++ linux-2.6.18-rc7/drivers/acpi/scan.c
@@ -478,6 +478,60 @@ acpi_bus_match(struct acpi_device *devic
 	return acpi_match_ids(device, driver->ids);
 }
 
+static void acpi_generic_notify(acpi_handle handle, u32 event, void *data){
+
+	struct acpi_device *device = (struct acpi_device*)data;
+	int present = device->status.present;
+	acpi_status status;
+
+	printk (KERN_INFO "Generic notifier for %s called",
+		acpi_device_bid(device));
+	if (device->driver->ops.notify_handler){
+		printk (KERN_INFO "Calling specific notifier for %s called",
+			acpi_device_bid(device));
+		device->driver->ops.notify_handler(handle, event,
+					   acpi_driver_data(device));
+	}
+
+	/* call start/stop before or after calling notify handler
+	   or not at all if there is a handler? */
+	if (device->flags.dynamic_status){
+		status = acpi_bus_get_status(device);
+		if (ACPI_FAILURE(status)){
+			ACPI_EXCEPTION ((AE_INFO, status, "Error getting"
+					 "status of device %s",
+					 acpi_device_bid(device)));
+		}
+		if (present != device->status.present){
+			if (device->status.present && device->driver->ops.start)
+				device->driver->ops.start(device);
+			else if (device->driver->ops.start)
+				/* we might want to pass separate stop reasons...
+					   switch(event){
+				*/
+				device->driver->ops.stop(device, ACPI_BUS_REMOVAL_NORMAL);
+		}
+	}
+}
+
+int acpi_driver_install_notifier(struct acpi_device *device){
+
+	acpi_status status;
+
+	if (device->driver->ops.notify_handler){
+		status = acpi_install_notify_handler(device->handle,
+						     ACPI_ALL_NOTIFY,
+						     acpi_generic_notify,
+						     acpi_driver_data(device));
+		if (ACPI_FAILURE(status)){
+			ACPI_EXCEPTION ((AE_INFO, status, "Could not install notify"
+					 "handler for %s", acpi_device_bid(device)));
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
 /**
  * acpi_bus_driver_init - add a device to a driver
  * @device: the device to add and initialize
@@ -490,7 +544,8 @@ static int
 acpi_bus_driver_init(struct acpi_device *device, struct acpi_driver *driver)
 {
 	int result = 0;
-
+	int type;
+	acpi_status status;
 
 	if (!device || !driver)
 		return -EINVAL;
@@ -507,6 +562,21 @@ acpi_bus_driver_init(struct acpi_device 
 
 	device->driver = driver;
 
+	status = acpi_get_type(device->handle, &type);
+
+	if (ACPI_FAILURE(status)){
+		ACPI_EXCEPTION ((AE_INFO, status, "Could not get type for"
+				 "device %s will not install notify handler",
+				 acpi_device_bid(device)));
+	}
+
+	/* fixed feature stuff has extra handlers... see below */
+	if (type != ACPI_BUS_TYPE_POWER_BUTTON &&
+	    type != ACPI_BUS_TYPE_SLEEP_BUTTON) {
+		if (driver->ops.notify_handler)
+			acpi_driver_install_notifier(device);
+	}
+
 	/*
 	 * TBD - Configuration Management: Assign resources to device based
 	 * upon possible configuration and currently allocated resources.
@@ -545,17 +615,21 @@ static void acpi_driver_attach(struct ac
 		struct acpi_device *dev =
 		    container_of(node, struct acpi_device, g_list);
 
-		if (dev->driver || !dev->status.present)
+		if (dev->driver)
 			continue;
 		spin_unlock(&acpi_device_lock);
 
 		if (!acpi_bus_match(dev, drv)) {
 			if (!acpi_bus_driver_init(dev, drv)) {
-				acpi_start_single_object(dev);
-				atomic_inc(&drv->references);
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "Found driver [%s] for device [%s]\n",
-						  drv->name, dev->pnp.bus_id));
+				if (dev->status.present){
+					acpi_start_single_object(dev);
+					atomic_inc(&drv->references);
+					ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+							  "Found driver [%s]"
+							  " for device [%s]\n",
+							  drv->name,
+							  dev->pnp.bus_id));
+				}
 			}
 		}
 		spin_lock(&acpi_device_lock);
@@ -604,7 +678,6 @@ int acpi_bus_register_driver(struct acpi
 	list_add_tail(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
 	acpi_driver_attach(driver);
-
 	return 0;
 }
 
Index: linux-2.6.18-rc7/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.18-rc7.orig/include/acpi/acpi_bus.h
+++ linux-2.6.18-rc7/include/acpi/acpi_bus.h
@@ -87,18 +87,20 @@ struct acpi_device;
  * -----------
  */
 
-typedef int (*acpi_op_add) (struct acpi_device * device);
-typedef int (*acpi_op_remove) (struct acpi_device * device, int type);
-typedef int (*acpi_op_lock) (struct acpi_device * device, int type);
-typedef int (*acpi_op_start) (struct acpi_device * device);
-typedef int (*acpi_op_stop) (struct acpi_device * device, int type);
-typedef int (*acpi_op_suspend) (struct acpi_device * device, int state);
-typedef int (*acpi_op_resume) (struct acpi_device * device, int state);
-typedef int (*acpi_op_scan) (struct acpi_device * device);
-typedef int (*acpi_op_bind) (struct acpi_device * device);
-typedef int (*acpi_op_unbind) (struct acpi_device * device);
-typedef int (*acpi_op_match) (struct acpi_device * device,
+typedef int  (*acpi_op_add) (struct acpi_device * device);
+typedef int  (*acpi_op_remove) (struct acpi_device * device, int type);
+typedef int  (*acpi_op_lock) (struct acpi_device * device, int type);
+typedef int  (*acpi_op_start) (struct acpi_device * device);
+typedef int  (*acpi_op_stop) (struct acpi_device * device, int type);
+typedef int  (*acpi_op_suspend) (struct acpi_device * device, int state);
+typedef int  (*acpi_op_resume) (struct acpi_device * device, int state);
+typedef int  (*acpi_op_scan) (struct acpi_device * device);
+typedef int  (*acpi_op_bind) (struct acpi_device * device);
+typedef int  (*acpi_op_unbind) (struct acpi_device * device);
+typedef int  (*acpi_op_match) (struct acpi_device * device,
 			      struct acpi_driver * driver);
+typedef void (*acpi_op_notify_handler) (acpi_handle handle,
+				       u32 event, void *data);
 
 struct acpi_bus_ops {
 	u32 acpi_op_add:1;
@@ -112,7 +114,8 @@ struct acpi_bus_ops {
 	u32 acpi_op_bind:1;
 	u32 acpi_op_unbind:1;
 	u32 acpi_op_match:1;
-	u32 reserved:21;
+	u32 acpi_op_notify_handler:1;
+	u32 reserved:20;
 };
 
 struct acpi_device_ops {
@@ -127,6 +130,7 @@ struct acpi_device_ops {
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
 	acpi_op_match match;
+	acpi_op_notify_handler notify_handler;
 };
 
 struct acpi_driver {

--=-awCNdXIWhiS4tHT1ZeEi--

