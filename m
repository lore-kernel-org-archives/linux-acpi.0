From: Len Brown <lenb@kernel.org>
Subject: [PATCH 138/140] ACPI: bay: Convert ACPI Bay driver to be compatible with sysfs update.
Date: Wed,  7 Feb 2007 13:52:32 -0500
Message-ID: <11708745562901-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <547352660506ab99d6b0bad58dea495bf3718cee.1170873819.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:22414 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422889AbXBGS4A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:56:00 -0500
In-Reply-To: <1170874555557-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

	Set fake hid for ejectable drive bay.
	Match bay devices by checking the hid.
	Remove .match method of Bay driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c  |   18 +-----------------
 drivers/acpi/scan.c |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)

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
index 5049230..0a13d95 100644
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
-- 
1.5.0.rc3.39.gec804
