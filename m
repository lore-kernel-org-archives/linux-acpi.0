From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/7] ACPI / LPSS: allow to use specific PM domain during ->probe()
Date: Thu, 26 Nov 2015 17:19:08 +0200
Message-ID: <1448551153-84719-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60047 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbbKZPTT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2015 10:19:19 -0500
In-Reply-To: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is an amendment to previously pushed commit 01ac170ba29a (ACPI / LPSS:
allow to use specific PM domain during ->probe()). We can't assign anything to
the platform device on ADD_DEVICE stage since it might be changed during
unbound / bind cycle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index f9e0d09..e840229 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -705,8 +705,14 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 	}
 
 	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
+	case BUS_NOTIFY_BIND_DRIVER:
 		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
+		break;
+	case BUS_NOTIFY_BIND_DRIVER_ERROR:
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		pdev->dev.pm_domain = NULL;
+		break;
+	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			return sysfs_create_group(&pdev->dev.kobj,
 						  &lpss_attr_group);
@@ -714,7 +720,6 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 	case BUS_NOTIFY_DEL_DEVICE:
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
-		pdev->dev.pm_domain = NULL;
 		break;
 	default:
 		break;
-- 
2.6.2

