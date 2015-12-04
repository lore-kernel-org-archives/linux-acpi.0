From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/9] Revert "ACPI / LPSS: allow to use specific PM domain during ->probe()"
Date: Fri,  4 Dec 2015 23:49:18 +0200
Message-ID: <1449265765-9393-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

The specific power domain can't be used in a way provided by the commit
01ac170ba29a, i.e. pointer to platform device is a subject to change during
unbound / bind cycle.

This reverts commit 01ac170ba29a9903ee590e1ef2d8e6b27b49a16c.

Fixes: 3df2da968744 (Revert "ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index f9e0d09..da0e276 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -705,8 +705,13 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 	}
 
 	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
+	case BUS_NOTIFY_BOUND_DRIVER:
 		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		pdev->dev.pm_domain = NULL;
+		break;
+	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			return sysfs_create_group(&pdev->dev.kobj,
 						  &lpss_attr_group);
@@ -714,7 +719,6 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 	case BUS_NOTIFY_DEL_DEVICE:
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
-		pdev->dev.pm_domain = NULL;
 		break;
 	default:
 		break;
-- 
2.6.2
