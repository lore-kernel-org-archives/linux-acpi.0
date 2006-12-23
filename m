From: Len Brown <lenb@kernel.org>
Subject: [PATCH] sysfs->test merge /w  bay.c
Date: Fri, 22 Dec 2006 23:31:14 -0500
Message-ID: <200612222331.14738.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49778 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbWLWEbs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Dec 2006 23:31:48 -0500
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id kBN4VKcb027280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sat, 23 Dec 2006 04:31:45 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

With Rui's patch below, I've merged sysfs back into the main test branch in the acpi git tree.

As usual, the test branch is also available as a plain patch:
http://ftp.kernel.org:/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.20/acpi-test-20060707-2.6.20-rc1.diff.gz

thanks Rui,
-Len

commit 8f750a47c8cfea621a5769bcd354de07ae0d5e05
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Fri Dec 22 00:48:00 2006 -0500

    ACPI: bay: Convert ACPI Bay driver to be compatible with sysfs update.
    
    	Set fake hid for ejectable drive bay.
    	Match bay devices by checking the hid.
    	Remove .match method of Bay driver.
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index aa1b131..667fa1d 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -49,16 +49,14 @@ MODULE_LICENSE("GPL");
 static void bay_notify(acpi_handle handle, u32 event, void *data);
 static int acpi_bay_add(struct acpi_device *device);
 static int acpi_bay_remove(struct acpi_device *device, int type);
-static int acpi_bay_match(struct acpi_device *device,
-				struct acpi_driver *driver);
 
 static struct acpi_driver acpi_bay_driver = {
 	.name = ACPI_BAY_DRIVER_NAME,
 	.class = ACPI_BAY_CLASS,
+	.ids = ACPI_BAY_HID,
 	.ops = {
 		.add = acpi_bay_add,
 		.remove = acpi_bay_remove,
-		.match = acpi_bay_match,
 		},
 };
 
@@ -347,20 +345,6 @@ static int acpi_bay_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
-static int acpi_bay_match(struct acpi_device *device,
-				struct acpi_driver *driver)
-{
-	if (!device || !driver)
-		return -EINVAL;
-
-	if (is_ejectable_bay(device->handle)) {
-		bay_dprintk(device->handle, "matching bay device");
-		return 0;
-	}
-
-	return -ENODEV;
-}
-
 /**
  * bay_create_acpi_device - add new devices to acpi
  * @handle - handle of the device to add
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index cd08bd4..40218ff 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -837,6 +837,42 @@ acpi_video_bus_match(struct acpi_device *device)
 	return -ENODEV;
 }
 
+/*
+ * acpi_bay_match - see if a device is an ejectable driver bay
+ *
+ * If an acpi object is ejectable and has one of the ACPI ATA methods defined,
+ * then we can safely call it an ejectable drive bay
+ */
+static int acpi_bay_match(struct acpi_device *device){
+	acpi_status status;
+	acpi_handle handle;
+	acpi_handle tmp;
+	acpi_handle phandle;
+
+	handle = device->handle;
+
+	status = acpi_get_handle(handle, "_EJ0", &tmp);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	if ((ACPI_SUCCESS(acpi_get_handle(handle, "_GTF", &tmp))) ||
+		(ACPI_SUCCESS(acpi_get_handle(handle, "_GTM", &tmp))) ||
+		(ACPI_SUCCESS(acpi_get_handle(handle, "_STM", &tmp))) ||
+		(ACPI_SUCCESS(acpi_get_handle(handle, "_SDD", &tmp))))
+		return 0;
+
+	if (acpi_get_parent(handle, &phandle))
+		return -ENODEV;
+
+        if ((ACPI_SUCCESS(acpi_get_handle(phandle, "_GTF", &tmp))) ||
+                (ACPI_SUCCESS(acpi_get_handle(phandle, "_GTM", &tmp))) ||
+                (ACPI_SUCCESS(acpi_get_handle(phandle, "_STM", &tmp))) ||
+                (ACPI_SUCCESS(acpi_get_handle(phandle, "_SDD", &tmp))))
+                return 0;
+
+	return -ENODEV;
+}
+
 static void acpi_device_set_id(struct acpi_device *device,
 			       struct acpi_device *parent, acpi_handle handle,
 			       int type)
@@ -872,6 +908,10 @@ static void acpi_device_set_id(struct acpi_device *device,
 			status = acpi_video_bus_match(device);
 			if(ACPI_SUCCESS(status))
 				hid = ACPI_VIDEO_HID;
+
+			status = acpi_bay_match(device);
+			if (ACPI_SUCCESS(status))
+				hid = ACPI_BAY_HID;
 		}
 		break;
 	case ACPI_BUS_TYPE_POWER:
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 2781e66..960a7d8 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -44,6 +44,7 @@
 #define ACPI_BUTTON_HID_SLEEPF		"ACPI_FSB"
 
 #define ACPI_VIDEO_HID			"ACPI_VID"
+#define ACPI_BAY_HID			"ACPI_BAY"
 /* --------------------------------------------------------------------------
                                        PCI
    -------------------------------------------------------------------------- */
