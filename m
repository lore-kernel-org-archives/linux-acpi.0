From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 08/12] hp_accel: convert to module_acpi_driver()
Date: Thu, 28 Jun 2012 13:59:27 +0300
Message-ID: <1340881171-14811-9-git-send-email-mika.westerberg@linux.intel.com>
References: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/hp_accel.c |   25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index 22b2dfa..7246e66 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -381,31 +381,8 @@ static struct acpi_driver lis3lv02d_driver = {
 		.resume  = lis3lv02d_resume,
 	}
 };
-
-static int __init lis3lv02d_init_module(void)
-{
-	int ret;
-
-	if (acpi_disabled)
-		return -ENODEV;
-
-	ret = acpi_bus_register_driver(&lis3lv02d_driver);
-	if (ret < 0)
-		return ret;
-
-	pr_info("driver loaded\n");
-
-	return 0;
-}
-
-static void __exit lis3lv02d_exit_module(void)
-{
-	acpi_bus_unregister_driver(&lis3lv02d_driver);
-}
+module_acpi_driver(lis3lv02d_driver);
 
 MODULE_DESCRIPTION("Glue between LIS3LV02Dx and HP ACPI BIOS and support for disk protection LED.");
 MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
 MODULE_LICENSE("GPL");
-
-module_init(lis3lv02d_init_module);
-module_exit(lis3lv02d_exit_module);
-- 
1.7.10
