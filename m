From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/49] toshiba_bluetooth: convert to module_acpi_driver()
Date: Sat,  6 Oct 2012 16:09:50 -0400
Message-ID: <01d1775301f950ea463e2184b67b6bc9b68f5bae.1349554106.git.len.brown@intel.com>
References: <1349554210-29978-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35485 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab2JFUSm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Oct 2012 16:18:42 -0400
In-Reply-To: <1349554210-29978-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/toshiba_bluetooth.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index 5e5d631..e95be0b 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -122,30 +122,10 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 	return result;
 }
 
-static int __init toshiba_bt_rfkill_init(void)
-{
-	int result;
-
-	result = acpi_bus_register_driver(&toshiba_bt_rfkill_driver);
-	if (result < 0) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error registering driver\n"));
-		return result;
-	}
-
-	return 0;
-}
-
 static int toshiba_bt_rfkill_remove(struct acpi_device *device, int type)
 {
 	/* clean up */
 	return 0;
 }
 
-static void __exit toshiba_bt_rfkill_exit(void)
-{
-	acpi_bus_unregister_driver(&toshiba_bt_rfkill_driver);
-}
-
-module_init(toshiba_bt_rfkill_init);
-module_exit(toshiba_bt_rfkill_exit);
+module_acpi_driver(toshiba_bt_rfkill_driver);
-- 
1.8.0.rc0.18.gf84667d

