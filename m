From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 03/14] wmi: Clean up acpi_wmi_add
Date: Mon, 30 Nov 2015 17:05:53 -0800
Message-ID: <808744392feff94ee8f22c8ba7a5e35ba29b0ddf.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Rearrange acpi_wmi_add to use Linux's error handling conventions.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 383efb8260c7..fc1f339b7431 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -881,20 +881,24 @@ static int acpi_wmi_add(struct acpi_device *device)
 						    &acpi_wmi_ec_space_handler,
 						    NULL, NULL);
 	if (ACPI_FAILURE(status)) {
-		pr_err("Error installing EC region handler\n");
+		dev_err(&device->dev, "Error installing EC region handler\n");
 		return -ENODEV;
 	}
 
 	error = parse_wdg(device);
 	if (error) {
-		acpi_remove_address_space_handler(device->handle,
-						  ACPI_ADR_SPACE_EC,
-						  &acpi_wmi_ec_space_handler);
 		pr_err("Failed to parse WDG method\n");
-		return error;
+		goto err_remove_handler;
 	}
 
 	return 0;
+
+err_remove_handler:
+	acpi_remove_address_space_handler(device->handle,
+					  ACPI_ADR_SPACE_EC,
+					  &acpi_wmi_ec_space_handler);
+
+	return error;
 }
 
 static int __init acpi_wmi_init(void)
-- 
2.5.0
