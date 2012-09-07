From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND 11/12] toshiba_bluetooth: convert to module_acpi_driver()
Date: Fri,  7 Sep 2012 10:31:48 +0300
Message-ID: <1347003109-26887-12-git-send-email-mika.westerberg@linux.intel.com>
References: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/toshiba_bluetooth.c |   22 +---------------------
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
1.7.10.4
