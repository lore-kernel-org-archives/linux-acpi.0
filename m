From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 01/14] wmi: Drop "Mapper (un)loaded" messages
Date: Mon, 30 Nov 2015 17:05:51 -0800
Message-ID: <754394c43e2a38ce3a321d810e993fed5675b3d4.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

WMI is just a driver.  There's no need to announce when it's loaded.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index eb391a281833..a17c3d5effe4 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -914,7 +914,6 @@ static int __init acpi_wmi_init(void)
 		return error;
 	}
 
-	pr_info("Mapper loaded\n");
 	return 0;
 }
 
@@ -922,8 +921,6 @@ static void __exit acpi_wmi_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_wmi_driver);
 	class_unregister(&wmi_class);
-
-	pr_info("Mapper unloaded\n");
 }
 
 subsys_initcall(acpi_wmi_init);
-- 
2.5.0
