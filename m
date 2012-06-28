From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 03/12] ACPI/fan: convert to module_acpi_driver()
Date: Thu, 28 Jun 2012 13:59:22 +0300
Message-ID: <1340881171-14811-4-git-send-email-mika.westerberg@linux.intel.com>
References: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/fan.c |   22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 0f0356c..b142797 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -207,24 +207,4 @@ static int acpi_fan_resume(struct acpi_device *device)
 	return result;
 }
 
-static int __init acpi_fan_init(void)
-{
-	int result = 0;
-
-	result = acpi_bus_register_driver(&acpi_fan_driver);
-	if (result < 0)
-		return -ENODEV;
-
-	return 0;
-}
-
-static void __exit acpi_fan_exit(void)
-{
-
-	acpi_bus_unregister_driver(&acpi_fan_driver);
-
-	return;
-}
-
-module_init(acpi_fan_init);
-module_exit(acpi_fan_exit);
+module_acpi_driver(acpi_fan_driver);
-- 
1.7.10
