From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/49] topstar-laptop: convert to module_acpi_driver()
Date: Sat,  6 Oct 2012 16:09:49 -0400
Message-ID: <15165594da65f7b6c70fd47f27c2d3b0a23c9ca8.1349554106.git.len.brown@intel.com>
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
Acked-by: Herton R. Krzesinski <herton@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/topstar-laptop.c | 22 +---------------------
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
1.8.0.rc0.18.gf84667d
