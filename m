From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] ACPI / LPSS: allow to use specific PM domain during ->probe()
Date: Wed,  5 Nov 2014 18:34:46 +0200
Message-ID: <1415205288-3356-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22058 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755070AbaKEQgX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Nov 2014 11:36:23 -0500
In-Reply-To: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Ashcroft <scott.ashcroft@talk21.com>, Mika Westerberg <mika.westerberg@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The LPSS DMA controller would like to use the specific PM domain callbacks
during early stage, namely in ->probe(). This patch moves the specific PM
domain assignment early to be accessible during a whole life time of the device
in the system.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index f6b71af..4804ae3 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -659,19 +659,17 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 	}
 
 	switch (action) {
-	case BUS_NOTIFY_BOUND_DRIVER:
-		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
-		break;
-	case BUS_NOTIFY_UNBOUND_DRIVER:
-		pdev->dev.pm_domain = NULL;
-		break;
 	case BUS_NOTIFY_ADD_DEVICE:
+		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			return sysfs_create_group(&pdev->dev.kobj,
 						  &lpss_attr_group);
+		break;
 	case BUS_NOTIFY_DEL_DEVICE:
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
+		pdev->dev.pm_domain = NULL;
+		break;
 	default:
 		break;
 	}
-- 
2.1.1

