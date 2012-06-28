From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 05/12] ACPI/sbshc: convert to module_acpi_driver()
Date: Thu, 28 Jun 2012 13:59:24 +0300
Message-ID: <1340881171-14811-6-git-send-email-mika.westerberg@linux.intel.com>
References: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/sbshc.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index f8d2a47..cf6129a 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -310,23 +310,7 @@ static int acpi_smbus_hc_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
-static int __init acpi_smb_hc_init(void)
-{
-	int result;
-
-	result = acpi_bus_register_driver(&acpi_smb_hc_driver);
-	if (result < 0)
-		return -ENODEV;
-	return 0;
-}
-
-static void __exit acpi_smb_hc_exit(void)
-{
-	acpi_bus_unregister_driver(&acpi_smb_hc_driver);
-}
-
-module_init(acpi_smb_hc_init);
-module_exit(acpi_smb_hc_exit);
+module_acpi_driver(acpi_smb_hc_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexey Starikovskiy");
-- 
1.7.10
