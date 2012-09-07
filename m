From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND 10/12] topstar-laptop: convert to module_acpi_driver()
Date: Fri,  7 Sep 2012 10:31:47 +0300
Message-ID: <1347003109-26887-11-git-send-email-mika.westerberg@linux.intel.com>
References: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21417 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759908Ab2IGH3e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 03:29:34 -0400
In-Reply-To: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Herton R. Krzesinski <herton@canonical.com>
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
1.7.10.4

