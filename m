From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 09/12] ideapad: convert to module_acpi_driver()
Date: Thu, 28 Jun 2012 13:59:28 +0300
Message-ID: <1340881171-14811-10-git-send-email-mika.westerberg@linux.intel.com>
References: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/ideapad-laptop.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 4f20f8d..b469654 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -813,20 +813,8 @@ static struct acpi_driver ideapad_acpi_driver = {
 	.ops.notify = ideapad_acpi_notify,
 	.owner = THIS_MODULE,
 };
-
-static int __init ideapad_acpi_module_init(void)
-{
-	return acpi_bus_register_driver(&ideapad_acpi_driver);
-}
-
-static void __exit ideapad_acpi_module_exit(void)
-{
-	acpi_bus_unregister_driver(&ideapad_acpi_driver);
-}
+module_acpi_driver(ideapad_acpi_driver);
 
 MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
 MODULE_DESCRIPTION("IdeaPad ACPI Extras");
 MODULE_LICENSE("GPL");
-
-module_init(ideapad_acpi_module_init);
-module_exit(ideapad_acpi_module_exit);
-- 
1.7.10
