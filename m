From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/41] ACPI: bay: remove ACPI driver struct
Date: Tue, 13 Feb 2007 00:49:19 -0500
Message-ID: <11713458062930-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:8302 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751021AbXBMFuI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:08 -0500
In-Reply-To: <11713458052158-git-send-email-lenb@kernel.org>
Message-Id: <c41458aca0defd5b16239ffd65630d1b87672ee5.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

The bay driver is a platform driver, and doesn't need to also be an acpi
driver.  Remove the acpi driver related structures and callbacks, they didn't
do anything anyway.  Switch to uevent for user space event notification.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c |   99 ++-------------------------------------------------
 1 files changed, 4 insertions(+), 95 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 667fa1d..9fdee61 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -47,18 +47,6 @@ MODULE_LICENSE("GPL");
 	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);\
 	printk(KERN_DEBUG PREFIX "%s: %s\n", prefix, s); }
 static void bay_notify(acpi_handle handle, u32 event, void *data);
-static int acpi_bay_add(struct acpi_device *device);
-static int acpi_bay_remove(struct acpi_device *device, int type);
-
-static struct acpi_driver acpi_bay_driver = {
-	.name = ACPI_BAY_DRIVER_NAME,
-	.class = ACPI_BAY_CLASS,
-	.ids = ACPI_BAY_HID,
-	.ops = {
-		.add = acpi_bay_add,
-		.remove = acpi_bay_remove,
-		},
-};
 
 struct bay {
 	acpi_handle handle;
@@ -234,14 +222,6 @@ int eject_removable_drive(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(eject_removable_drive);
 
-static int acpi_bay_add(struct acpi_device *device)
-{
-	bay_dprintk(device->handle, "adding bay device");
-	strcpy(acpi_device_name(device), "Dockable Bay");
-	strcpy(acpi_device_class(device), "bay");
-	return 0;
-}
-
 static int acpi_bay_add_fs(struct bay *bay)
 {
 	int ret;
@@ -339,52 +319,6 @@ bay_add_err:
 	return -ENODEV;
 }
 
-static int acpi_bay_remove(struct acpi_device *device, int type)
-{
-	/*** FIXME: do something here */
-	return 0;
-}
-
-/**
- * bay_create_acpi_device - add new devices to acpi
- * @handle - handle of the device to add
- *
- *  This function will create a new acpi_device for the given
- *  handle if one does not exist already.  This should cause
- *  acpi to scan for drivers for the given devices, and call
- *  matching driver's add routine.
- *
- *  Returns a pointer to the acpi_device corresponding to the handle.
- */
-static struct acpi_device * bay_create_acpi_device(acpi_handle handle)
-{
-	struct acpi_device *device = NULL;
-	struct acpi_device *parent_device;
-	acpi_handle parent;
-	int ret;
-
-	bay_dprintk(handle, "Trying to get device");
-	if (acpi_bus_get_device(handle, &device)) {
-		/*
-		 * no device created for this object,
-		 * so we should create one.
-		 */
-		bay_dprintk(handle, "No device for handle");
-		acpi_get_parent(handle, &parent);
-		if (acpi_bus_get_device(parent, &parent_device))
-			parent_device = NULL;
-
-		ret = acpi_bus_add(&device, parent_device, handle,
-			ACPI_BUS_TYPE_DEVICE);
-		if (ret) {
-			pr_debug("error adding bus, %x\n",
-				-ret);
-			return NULL;
-		}
-	}
-	return device;
-}
-
 /**
  * bay_notify - act upon an acpi bay notification
  * @handle: the bay handle
@@ -394,38 +328,19 @@ static struct acpi_device * bay_create_acpi_device(acpi_handle handle)
  */
 static void bay_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *dev;
+	struct bay *bay_dev = (struct bay *)data;
+	struct device *dev = &bay_dev->pdev->dev;
 
 	bay_dprintk(handle, "Bay event");
 
 	switch(event) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		printk("Bus Check\n");
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		printk("Device Check\n");
-		dev = bay_create_acpi_device(handle);
-		if (dev)
-			acpi_bus_generate_event(dev, event, 0);
-		else
-			printk("No device for generating event\n");
-		/* wouldn't it be a good idea to just rescan SATA
-		 * right here?
-		 */
-		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		printk("Eject request\n");
-		dev = bay_create_acpi_device(handle);
-		if (dev)
-			acpi_bus_generate_event(dev, event, 0);
-		else
-			printk("No device for generating eventn");
-
-		/* wouldn't it be a good idea to just call the
-		 * eject_device here if we were a SATA device?
-		 */
+		kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 		break;
 	default:
-		printk("unknown event %d\n", event);
+		printk(KERN_ERR PREFIX "Bay: unknown event %d\n", event);
 	}
 }
 
@@ -457,10 +372,6 @@ static int __init bay_init(void)
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 		ACPI_UINT32_MAX, find_bay, &bays, NULL);
 
-	if (bays)
-		if ((acpi_bus_register_driver(&acpi_bay_driver) < 0))
-			printk(KERN_ERR "Unable to register bay driver\n");
-
 	if (!bays)
 		return -ENODEV;
 
@@ -481,8 +392,6 @@ static void __exit bay_exit(void)
 		kfree(bay->name);
 		kfree(bay);
 	}
-
-	acpi_bus_unregister_driver(&acpi_bay_driver);
 }
 
 postcore_initcall(bay_init);
-- 
1.5.0.rc4.345.gb4d2
