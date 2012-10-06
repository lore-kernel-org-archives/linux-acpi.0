From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/49] i2c-scmi: convert to module_acpi_driver()
Date: Sat,  6 Oct 2012 16:09:45 -0400
Message-ID: <20420500cb553793f64c885a51024686e74b9819.1349554106.git.len.brown@intel.com>
References: <1349554210-29978-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48071 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756982Ab2JFURO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Oct 2012 16:17:14 -0400
In-Reply-To: <1349554210-29978-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/i2c/busses/i2c-scmi.c | 14 +-------------
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
1.8.0.rc0.18.gf84667d

