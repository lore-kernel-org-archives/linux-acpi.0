From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 10/12] topstar-laptop: convert to module_acpi_driver()
Date: Thu, 28 Jun 2012 13:59:29 +0300
Message-ID: <1340881171-14811-11-git-send-email-mika.westerberg@linux.intel.com>
References: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/topstar-laptop.c |   22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index d528daa..d727bfe 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -186,27 +186,7 @@ static struct acpi_driver acpi_topstar_driver = {
 		.notify = acpi_topstar_notify,
 	},
 };
-
-static int __init topstar_laptop_init(void)
-{
-	int ret;
-
-	ret = acpi_bus_register_driver(&acpi_topstar_driver);
-	if (ret < 0)
-		return ret;
-
-	pr_info("ACPI extras driver loaded\n");
-
-	return 0;
-}
-
-static void __exit topstar_laptop_exit(void)
-{
-	acpi_bus_unregister_driver(&acpi_topstar_driver);
-}
-
-module_init(topstar_laptop_init);
-module_exit(topstar_laptop_exit);
+module_acpi_driver(acpi_topstar_driver);
 
 MODULE_AUTHOR("Herton Ronaldo Krzesinski");
 MODULE_DESCRIPTION("Topstar Laptop ACPI Extras driver");
-- 
1.7.10
