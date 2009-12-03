From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 18/33] eeepc-laptop: simplify acpi initialization
Date: Thu,  3 Dec 2009 08:45:02 +0100
Message-ID: <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44217 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259AbZLCHof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:35 -0500
In-Reply-To: <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

We don't need to store init_flags after using them.  And we don't use
the result of INIT, so we don't need to allocate a buffer for it.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |   55 ++++++++++++++++------------------
 1 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 9f33e51..50ceaaf 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -136,7 +136,6 @@ struct eeepc_hotk {
 	acpi_handle handle;		/* the handle of the hotk device */
 	u32 cm_supported;		/* the control methods supported
 					   by this BIOS */
-	uint init_flag;			/* Init flags */
 	u16 event_count[128];		/* count for each event */
 	struct input_dev *inputdev;
 	u16 *keycode_map;
@@ -256,8 +255,7 @@ MODULE_LICENSE("GPL");
 /*
  * ACPI Helpers
  */
-static int write_acpi_int(acpi_handle handle, const char *method, int val,
-			  struct acpi_buffer *output)
+static int write_acpi_int(acpi_handle handle, const char *method, int val)
 {
 	struct acpi_object_list params;
 	union acpi_object in_obj;
@@ -268,7 +266,7 @@ static int write_acpi_int(acpi_handle handle, const char *method, int val,
 	in_obj.type = ACPI_TYPE_INTEGER;
 	in_obj.integer.value = val;
 
-	status = acpi_evaluate_object(handle, (char *)method, &params, output);
+	status = acpi_evaluate_object(handle, (char *)method, &params, NULL);
 	return (status == AE_OK ? 0 : -1);
 }
 
@@ -296,7 +294,7 @@ static int set_acpi(int cm, int value)
 	if ((ehotk->cm_supported & (0x1 << cm)) == 0)
 		return -ENODEV;
 
-	if (write_acpi_int(ehotk->handle, method, value, NULL))
+	if (write_acpi_int(ehotk->handle, method, value))
 		pr_warning("Error writing %s\n", method);
 	return 0;
 }
@@ -624,36 +622,36 @@ static void cmsg_quirks(void)
 	cmsg_quirk(CM_ASL_TPD, "TPD");
 }
 
-static int eeepc_hotk_check(void)
+static int eeepc_hotk_init(void)
 {
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	unsigned int init_flags;
 	int result;
 
 	result = acpi_bus_get_status(ehotk->device);
 	if (result)
 		return result;
-	if (ehotk->device->status.present) {
-		if (write_acpi_int(ehotk->handle, "INIT", ehotk->init_flag,
-				    &buffer)) {
-			pr_err("Hotkey initialization failed\n");
-			return -ENODEV;
-		} else {
-			pr_notice("Hotkey init flags 0x%x\n", ehotk->init_flag);
-		}
-		/* get control methods supported */
-		if (read_acpi_int(ehotk->handle, "CMSG"
-				   , &ehotk->cm_supported)) {
-			pr_err("Get control methods supported failed\n");
-			return -ENODEV;
-		} else {
-			cmsg_quirks();
-			pr_info("Get control methods supported: 0x%x\n",
-				ehotk->cm_supported);
-		}
-	} else {
+	if (!ehotk->device->status.present) {
 		pr_err("Hotkey device not present, aborting\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
+
+	init_flags = DISABLE_ASL_WLAN | DISABLE_ASL_DISPLAYSWITCH;
+	pr_notice("Hotkey init flags 0x%x\n", init_flags);
+
+	if (write_acpi_int(ehotk->handle, "INIT", init_flags)) {
+		pr_err("Hotkey initialization failed\n");
+		return -ENODEV;
+	}
+
+	/* get control methods supported */
+	if (read_acpi_int(ehotk->handle, "CMSG",
+				&ehotk->cm_supported)) {
+		pr_err("Get control methods supported failed\n");
+		return -ENODEV;
+	}
+	cmsg_quirks();
+	pr_info("Get control methods supported: 0x%x\n", ehotk->cm_supported);
+
 	return 0;
 }
 
@@ -1264,14 +1262,13 @@ static int __devinit eeepc_hotk_add(struct acpi_device *device)
 	ehotk = kzalloc(sizeof(struct eeepc_hotk), GFP_KERNEL);
 	if (!ehotk)
 		return -ENOMEM;
-	ehotk->init_flag = DISABLE_ASL_WLAN | DISABLE_ASL_DISPLAYSWITCH;
 	ehotk->handle = device->handle;
 	strcpy(acpi_device_name(device), EEEPC_HOTK_DEVICE_NAME);
 	strcpy(acpi_device_class(device), EEEPC_HOTK_CLASS);
 	device->driver_data = ehotk;
 	ehotk->device = device;
 
-	result = eeepc_hotk_check();
+	result = eeepc_hotk_init();
 	if (result)
 		goto fail_platform_driver;
 	eeepc_enable_camera();
-- 
1.6.5.3

