From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND 06/12] i2c-scmi: convert to module_acpi_driver()
Date: Fri,  7 Sep 2012 10:31:43 +0300
Message-ID: <1347003109-26887-7-git-send-email-mika.westerberg@linux.intel.com>
References: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/i2c-scmi.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index 388cbdc..6aafa3d 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -426,19 +426,7 @@ static struct acpi_driver acpi_smbus_cmi_driver = {
 		.remove = acpi_smbus_cmi_remove,
 	},
 };
-
-static int __init acpi_smbus_cmi_init(void)
-{
-	return acpi_bus_register_driver(&acpi_smbus_cmi_driver);
-}
-
-static void __exit acpi_smbus_cmi_exit(void)
-{
-	acpi_bus_unregister_driver(&acpi_smbus_cmi_driver);
-}
-
-module_init(acpi_smbus_cmi_init);
-module_exit(acpi_smbus_cmi_exit);
+module_acpi_driver(acpi_smbus_cmi_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Crane Cai <crane.cai@amd.com>");
-- 
1.7.10.4
