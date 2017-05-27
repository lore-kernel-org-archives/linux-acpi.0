From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 03/16] platform/x86: wmi: Clean up acpi_wmi_add
Date: Fri, 26 May 2017 22:31:17 -0700
Message-ID: <f6afef556cadd0d6976e78754207cf74000b12e2.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-acpi@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

Rearrange acpi_wmi_add to use Linux's error handling conventions.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/wmi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index c6e11b5..ac60a51 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -803,20 +803,24 @@ static int acpi_wmi_add(struct acpi_device *device)
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
2.9.4
