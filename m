From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: invoke acpi_device_wakeup() with correct parameters
Date: Thu, 23 Oct 2014 20:25:27 +0800
Message-ID: <1414067127.13162.43.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12082 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143AbaJWMZb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Oct 2014 08:25:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

>From f0d75284074478790a50655bf3cc1096f5f943fa Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 23 Oct 2014 20:20:00 +0800
Subject: [PATCH] ACPI: invoke acpi_device_wakeup() with correct parameters

Fix a bug that invokes acpi_device_wakeup() with wrong parameters.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/device_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 9177547..b4743d4 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -711,7 +711,7 @@ int acpi_pm_device_run_wake(struct device *phys_dev, bool enable)
 		return -ENODEV;
 	}
 
-	return acpi_device_wakeup(adev, enable, ACPI_STATE_S0);
+	return acpi_device_wakeup(adev, ACPI_STATE_S0, enable);
 }
 EXPORT_SYMBOL(acpi_pm_device_run_wake);
 #endif /* CONFIG_PM_RUNTIME */
-- 
1.9.1



