From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND 05/12] ACPI/sbshc: convert to module_acpi_driver()
Date: Fri,  7 Sep 2012 10:31:42 +0300
Message-ID: <1347003109-26887-6-git-send-email-mika.westerberg@linux.intel.com>
References: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21417 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759702Ab2IGH3d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 03:29:33 -0400
In-Reply-To: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

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
1.7.10.4

