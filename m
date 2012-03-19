From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH] ACPI: Add CPU hotplug support for processor device objects
Date: Mon, 19 Mar 2012 13:08:02 -0600
Message-ID: <1332184082-426-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:29973 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032598Ab2CSTJC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2012 15:09:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>

acpi_processor_install_hotplug_notify() registers processor objects to
receive ACPI CPU hotplug event notifications. This patch additionally
registers processor device objects (ACPI0007) to receive the notifications
as well.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/processor_driver.c |   48 ++++++++++++++++++++++++++++++--------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 8ae05ce..50be277 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -68,6 +68,7 @@
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
 #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
+#define ACPI_PROCESSOR_DEVICE_HID	"ACPI0007"
 
 #define ACPI_PROCESSOR_LIMIT_USER	0
 #define ACPI_PROCESSOR_LIMIT_THERMAL	1
@@ -88,7 +89,7 @@ static int acpi_processor_start(struct acpi_processor *pr);
 
 static const struct acpi_device_id processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, 0},
-	{"ACPI0007", 0},
+	{ACPI_PROCESSOR_DEVICE_HID, 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, processor_device_ids);
@@ -741,20 +742,46 @@ static void acpi_processor_hotplug_notify(acpi_handle handle,
 	return;
 }
 
+static acpi_status is_processor_device(acpi_handle handle)
+{
+	struct acpi_device_info *info;
+	char *hid;
+	acpi_status status;
+
+	status = acpi_get_object_info(handle, &info);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	if (info->type == ACPI_TYPE_PROCESSOR) {
+		kfree(info);
+		return AE_OK;	/* found a processor object */
+	}
+
+	if (!(info->valid & ACPI_VALID_HID)) {
+		kfree(info);
+		return AE_ERROR;
+	}
+
+	hid = info->hardware_id.string;
+	if ((hid == NULL) || strcmp(hid, ACPI_PROCESSOR_DEVICE_HID)) {
+		kfree(info);
+		return AE_ERROR;
+	}
+
+	kfree(info);
+	return AE_OK;	/* found a processor device object */
+}
+
 static acpi_status
 processor_walk_namespace_cb(acpi_handle handle,
 			    u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
 	int *action = context;
-	acpi_object_type type = 0;
 
-	status = acpi_get_type(handle, &type);
+	status = is_processor_device(handle);
 	if (ACPI_FAILURE(status))
-		return (AE_OK);
-
-	if (type != ACPI_TYPE_PROCESSOR)
-		return (AE_OK);
+		return AE_OK;	/* not a processor; continue to walk */
 
 	switch (*action) {
 	case INSTALL_NOTIFY_HANDLER:
@@ -772,7 +799,8 @@ processor_walk_namespace_cb(acpi_handle handle,
 		break;
 	}
 
-	return (AE_OK);
+	/* found a processor; skip walking underneath */
+	return AE_CTRL_DEPTH;
 }
 
 static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
@@ -830,7 +858,7 @@ void acpi_processor_install_hotplug_notify(void)
 {
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 	int action = INSTALL_NOTIFY_HANDLER;
-	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
+	acpi_walk_namespace(ACPI_TYPE_ANY,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    processor_walk_namespace_cb, NULL, &action, NULL);
@@ -843,7 +871,7 @@ void acpi_processor_uninstall_hotplug_notify(void)
 {
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 	int action = UNINSTALL_NOTIFY_HANDLER;
-	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
+	acpi_walk_namespace(ACPI_TYPE_ANY,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    processor_walk_namespace_cb, NULL, &action, NULL);
-- 
1.7.7.6

