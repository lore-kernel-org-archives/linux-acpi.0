From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/49] Input: atlas_btns - convert to module_acpi_driver()
Date: Sat,  6 Oct 2012 16:09:46 -0400
Message-ID: <f06efccf4d4162db957983bc8a66073ec4735a38.1349554106.git.len.brown@intel.com>
References: <1349554210-29978-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349554210-29978-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/input/misc/atlas_btns.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 601f737..26f1313 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -151,22 +151,7 @@ static struct acpi_driver atlas_acpi_driver = {
 		.remove	= atlas_acpi_button_remove,
 	},
 };
-
-static int __init atlas_acpi_init(void)
-{
-	if (acpi_disabled)
-		return -ENODEV;
-
-	return acpi_bus_register_driver(&atlas_acpi_driver);
-}
-
-static void __exit atlas_acpi_exit(void)
-{
-	acpi_bus_unregister_driver(&atlas_acpi_driver);
-}
-
-module_init(atlas_acpi_init);
-module_exit(atlas_acpi_exit);
+module_acpi_driver(atlas_acpi_driver);
 
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
-- 
1.8.0.rc0.18.gf84667d
