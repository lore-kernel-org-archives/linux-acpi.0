From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPI: EC: Drop EC noirq hooks to fix a regression
Date: Wed, 12 Jul 2017 11:09:09 +0800
Message-ID: <26498770711bbb36ca2888b33b56a0a56dc29083.1499828705.git.lv.zheng@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Stable # all applicable <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

According to the bug report, though the busy polling mode can make noirq
stages executed faster, it causes abnormal fan blowing up after a system
resume (see link #1 for a video demonstration) on Lenovo ThinkPad X1 Carbon
 - the 5th Generation. The problem can be fixed by an upgraded EC firmware.

However many reporters can also confirm that the problem can be fixed by
stopping busy polling during suspend/resume.

This patch drops noirq stage hooks so that the regression can be fixed
without upgrading the EC firmware.

Fixes: c3a696b6e8f8 ("ACPI / EC: Use busy polling mode when GPE is not enabled")
Link: https://youtu.be/9NQ9x-Jm99Q                       [#1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=196129
Reported-by: Andreas Lindhe <andreas@lindhe.io>
Tested-by: Gjorgji Jankovski <j.gjorgji@gmail.com>
Tested-by: Damjan Georgievski <gdamjan@gmail.com>
Tested-by: Fernando Chaves <nanochaves@gmail.com>
Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
Tested-by: Denis P. <theoriginal.skullburner@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Stable <stable@vger.kernel.org> # all applicable
---
 drivers/acpi/ec.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 854d428..05e4eb5 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1870,24 +1870,6 @@ int __init acpi_ec_ecdt_probe(void)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int acpi_ec_suspend_noirq(struct device *dev)
-{
-	struct acpi_ec *ec =
-		acpi_driver_data(to_acpi_device(dev));
-
-	acpi_ec_enter_noirq(ec);
-	return 0;
-}
-
-static int acpi_ec_resume_noirq(struct device *dev)
-{
-	struct acpi_ec *ec =
-		acpi_driver_data(to_acpi_device(dev));
-
-	acpi_ec_leave_noirq(ec);
-	return 0;
-}
-
 static int acpi_ec_suspend(struct device *dev)
 {
 	struct acpi_ec *ec =
@@ -1909,7 +1891,6 @@ static int acpi_ec_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops acpi_ec_pm = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend_noirq, acpi_ec_resume_noirq)
 	SET_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend, acpi_ec_resume)
 };
 
-- 
2.7.4
