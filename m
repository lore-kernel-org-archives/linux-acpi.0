From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] ACPI: Remove tpacpi_acpi_handle_locate_callback and make use of the global implementation
Date: Fri, 16 Dec 2011 01:26:47 +0100
Message-ID: <1323995207-54686-2-git-send-email-trenn@suse.de>
References: <1323995207-54686-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43345 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab1LPA1a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Dec 2011 19:27:30 -0500
In-Reply-To: <1323995207-54686-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, seth.forshee@canonical.com, Azael Avalos <coproscefalo@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Matthew Garrett <mjg@redhat.com>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
CC: seth.forshee@canonical.com
CC: Azael Avalos <coproscefalo@gmail.com>
CC: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   48 ++++-----------------------------
 1 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 7b82868..c95a3af 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -698,43 +698,6 @@ static void __init drv_acpi_handle_init(const char *name,
 	*handle = NULL;
 }
 
-static acpi_status __init tpacpi_acpi_handle_locate_callback(acpi_handle handle,
-			u32 level, void *context, void **return_value)
-{
-	*(acpi_handle *)return_value = handle;
-
-	return AE_CTRL_TERMINATE;
-}
-
-static void __init tpacpi_acpi_handle_locate(const char *name,
-		const char *hid,
-		acpi_handle *handle)
-{
-	acpi_status status;
-	acpi_handle device_found;
-
-	BUG_ON(!name || !hid || !handle);
-	vdbg_printk(TPACPI_DBG_INIT,
-			"trying to locate ACPI handle for %s, using HID %s\n",
-			name, hid);
-
-	memset(&device_found, 0, sizeof(device_found));
-	status = acpi_get_devices(hid, tpacpi_acpi_handle_locate_callback,
-				  (void *)name, &device_found);
-
-	*handle = NULL;
-
-	if (ACPI_SUCCESS(status)) {
-		*handle = device_found;
-		dbg_printk(TPACPI_DBG_INIT,
-			   "Found ACPI handle for %s\n", name);
-	} else {
-		vdbg_printk(TPACPI_DBG_INIT,
-			    "Could not locate an ACPI handle for %s: %s\n",
-			    name, acpi_format_exception(status));
-	}
-}
-
 static void dispatch_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ibm_struct *ibm = data;
@@ -6142,9 +6105,10 @@ static unsigned int __init tpacpi_check_std_acpi_brightness_support(void)
 {
 	acpi_handle video_device;
 	int bcl_levels = 0;
+	int ret;
 
-	tpacpi_acpi_handle_locate("video", ACPI_VIDEO_HID, &video_device);
-	if (video_device)
+	ret = acpi_get_device_handle(ACPI_VIDEO_HID, &video_device);
+	if (!ret)
 		bcl_levels = tpacpi_query_bcl_levels(video_device);
 
 	tp_features.bright_acpimode = (bcl_levels > 0);
@@ -8677,7 +8641,7 @@ static int __must_check __init get_thinkpad_model_data(
 
 static int __init probe_for_thinkpad(void)
 {
-	int is_thinkpad;
+	int is_thinkpad, ret;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -8695,8 +8659,8 @@ static int __init probe_for_thinkpad(void)
 		      tpacpi_is_fw_known();
 
 	/* The EC handler is required */
-	tpacpi_acpi_handle_locate("ec", TPACPI_ACPI_EC_HID, &ec_handle);
-	if (!ec_handle) {
+	ret = acpi_get_device_handle(TPACPI_ACPI_EC_HID, &ec_handle);
+	if (ret) {
 		if (is_thinkpad)
 			pr_err("Not yet supported ThinkPad detected!\n");
 		return -ENODEV;
-- 
1.7.6.1

