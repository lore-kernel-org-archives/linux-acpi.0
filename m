From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND 12/12] xo15-ebook: convert to module_acpi_driver()
Date: Fri,  7 Sep 2012 10:31:49 +0300
Message-ID: <1347003109-26887-13-git-send-email-mika.westerberg@linux.intel.com>
References: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347003109-26887-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/xo15-ebook.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 38ba39d..16d340c 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -170,16 +170,4 @@ static struct acpi_driver xo15_ebook_driver = {
 	},
 	.drv.pm = &ebook_switch_pm,
 };
-
-static int __init xo15_ebook_init(void)
-{
-	return acpi_bus_register_driver(&xo15_ebook_driver);
-}
-
-static void __exit xo15_ebook_exit(void)
-{
-	acpi_bus_unregister_driver(&xo15_ebook_driver);
-}
-
-module_init(xo15_ebook_init);
-module_exit(xo15_ebook_exit);
+module_acpi_driver(xo15_ebook_driver);
-- 
1.7.10.4
