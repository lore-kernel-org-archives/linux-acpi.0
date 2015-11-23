From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 2/5] eeepc-wmi: Use acpi_dev_present
Date: Mon, 23 Nov 2015 15:34:55 +0100
Message-ID: <bdff67293ead344ccec77f55437085561b1ad88d.1448282995.git.lukas@wunner.de>
References: <cover.1448282995.git.lukas@wunner.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448282995.git.lukas@wunner.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, devel@acpica.org
Cc: platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Use shiny new acpi_dev_present and remove all the boilerplate to search
for a particular ACPI device. No functional change.

Cc: Corentin Chary <corentin.chary@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/platform/x86/eeepc-wmi.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/eeepc-wmi.c b/drivers/platform/x86/eeepc-wmi.c
index 14fd2ec..e1490db 100644
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
+	if (acpi_dev_present(EEEPC_ACPI_HID)) {
+		pr_warn("Found legacy ATKD device (%s)\n", EEEPC_ACPI_HID);
 		pr_warn("WMI device present, but legacy ATKD device is also "
 			"present and enabled\n");
 		pr_warn("You probably booted with acpi_osi=\"Linux\" or "
-- 
1.8.5.2 (Apple Git-48)
