From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI / LPSS: set PM domain via helper setter
Date: Mon,  1 Feb 2016 16:17:38 +0200
Message-ID: <1454336258-21933-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

The commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain") changed
acpi_lpss.c module to use PM domain setter, though it missed one assignment.
Add it here.

Fixes: 989561de9b51 (PM / Domains: add setter for dev.pm_domain)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index c570b1d..0872d5f 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -880,7 +880,7 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 		break;
 	case BUS_NOTIFY_DRIVER_NOT_BOUND:
 	case BUS_NOTIFY_UNBOUND_DRIVER:
-		pdev->dev.pm_domain = NULL;
+		dev_pm_domain_set(&pdev->dev, NULL);
 		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 		dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
-- 
2.7.0
