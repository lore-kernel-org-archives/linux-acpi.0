From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 2/3] eeepc-wmi: Use acpi_dev_found()
Date: Thu, 24 Mar 2016 13:15:20 +0100
Message-ID: <9751b66a01955b23fdabe8e53d27310e0e7ae736.1458813034.git.lukas@wunner.de>
References: <cover.1458813034.git.lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:44052 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcCXMOW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Mar 2016 08:14:22 -0400
In-Reply-To: <cover.1458813034.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

Use shiny new acpi_dev_found() and remove all the boilerplate
to search for a particular ACPI device. No functional change.

Cc: Corentin Chary <corentin.chary@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Darren Hart <dvhart@linux.intel.com>
---
 drivers/platform/x86/eeepc-wmi.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/eeepc-wmi.c b/drivers/platform/x86/eeepc-wmi.c
index 14fd2ec..17b365f 100644
--- a/drivers/platform/x86/eeepc-wmi.c
+++ b/drivers/platform/x86/eeepc-wmi.c
@@ -204,30 +204,10 @@ static void eeepc_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 	}
 }
 
-static acpi_status eeepc_wmi_parse_device(acpi_handle handle, u32 level,
-						 void *context, void **retval)
-{
-	pr_warn("Found legacy ATKD device (%s)\n", EEEPC_ACPI_HID);
-	*(bool *)context = true;
-	return AE_CTRL_TERMINATE;
-}
-
-static int eeepc_wmi_check_atkd(void)
-{
-	acpi_status status;
-	bool found = false;
-
-	status = acpi_get_devices(EEEPC_ACPI_HID, eeepc_wmi_parse_device,
-				  &found, NULL);
-
-	if (ACPI_FAILURE(status) || !found)
-		return 0;
-	return -1;
-}
-
 static int eeepc_wmi_probe(struct platform_device *pdev)
 {
-	if (eeepc_wmi_check_atkd()) {
+	if (acpi_dev_found(EEEPC_ACPI_HID)) {
+		pr_warn("Found legacy ATKD device (%s)\n", EEEPC_ACPI_HID);
 		pr_warn("WMI device present, but legacy ATKD device is also "
 			"present and enabled\n");
 		pr_warn("You probably booted with acpi_osi=\"Linux\" or "
-- 
2.8.0.rc3

