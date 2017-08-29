From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 7/8] i2c: designware: Don't resume device in the ->complete() callback
Date: Tue, 29 Aug 2017 16:56:49 +0200
Message-ID: <1504018610-10822-8-git-send-email-ulf.hansson@linaro.org>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:32821 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbdH2O5O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Aug 2017 10:57:14 -0400
Received: by mail-lf0-f41.google.com with SMTP id a126so14482257lfa.0
        for <linux-acpi@vger.kernel.org>; Tue, 29 Aug 2017 07:57:13 -0700 (PDT)
In-Reply-To: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

In case the PM core is able to use the direct_complete path during system
sleep for the i2c device, the device is runtime resumed in the ->complete()
callback. For ACPI platforms this is needed to synchronize the power state
of the device, while for non-ACPI platforms this is a waste.

To better deal with this, let's drop the ->complete() callback from the
i2c-dw-plat driver altogether, thus avoiding the runtime resume of the
device.

This change still plays well for the ACPI case, because the ACPI PM
domain's ->complete() callback, assigned to acpi_subsys_complete(), already
deals with runtime resuming the device in case it's needed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 drivers/i2c/busses/i2c-designware-platdrv.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 57248bc..38121c9 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -417,15 +417,8 @@ static int dw_i2c_plat_prepare(struct device *dev)
 {
 	return pm_runtime_suspended(dev);
 }
-
-static void dw_i2c_plat_complete(struct device *dev)
-{
-	if (dev->power.direct_complete)
-		pm_request_resume(dev);
-}
 #else
 #define dw_i2c_plat_prepare	NULL
-#define dw_i2c_plat_complete	NULL
 #endif
 
 #ifdef CONFIG_PM
@@ -461,7 +454,6 @@ static int dw_i2c_plat_suspend(struct device *dev)
 
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 	.prepare = dw_i2c_plat_prepare,
-	.complete = dw_i2c_plat_complete,
 	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
 	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
 			   dw_i2c_plat_resume,
-- 
2.7.4

