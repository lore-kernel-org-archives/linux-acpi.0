From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 04/12] ACPI/hed: convert to module_acpi_driver()
Date: Thu, 28 Jun 2012 13:59:23 +0300
Message-ID: <1340881171-14811-5-git-send-email-mika.westerberg@linux.intel.com>
References: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/hed.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index d0c1967..20a0f2c 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -86,25 +86,7 @@ static struct acpi_driver acpi_hed_driver = {
 		.notify = acpi_hed_notify,
 	},
 };
-
-static int __init acpi_hed_init(void)
-{
-	if (acpi_disabled)
-		return -ENODEV;
-
-	if (acpi_bus_register_driver(&acpi_hed_driver) < 0)
-		return -ENODEV;
-
-	return 0;
-}
-
-static void __exit acpi_hed_exit(void)
-{
-	acpi_bus_unregister_driver(&acpi_hed_driver);
-}
-
-module_init(acpi_hed_init);
-module_exit(acpi_hed_exit);
+module_acpi_driver(acpi_hed_driver);
 
 ACPI_MODULE_NAME("hed");
 MODULE_AUTHOR("Huang Ying");
-- 
1.7.10
