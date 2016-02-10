From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH] ACPI / fan: Make struct dev_pm_ops const
Date: Wed, 10 Feb 2016 15:23:27 -0800
Message-ID: <1455146607-66183-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Kaiyen Chang <kaiyen.chang@intel.com>, Brian Norris <briannorris@chromium.org>
List-Id: linux-acpi@vger.kernel.org

From: Kaiyen Chang <kaiyen.chang@intel.com>

Silence the following checkpatch warning:
WARNING: struct dev_pm_ops should normally be const.

Signed-off-by: Kaiyen Chang <kaiyen.chang@intel.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/acpi/fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 6322db64b4a4..384cfc3083e1 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -46,7 +46,7 @@ MODULE_DEVICE_TABLE(acpi, fan_device_ids);
 #ifdef CONFIG_PM_SLEEP
 static int acpi_fan_suspend(struct device *dev);
 static int acpi_fan_resume(struct device *dev);
-static struct dev_pm_ops acpi_fan_pm = {
+static const struct dev_pm_ops acpi_fan_pm = {
 	.resume = acpi_fan_resume,
 	.freeze = acpi_fan_suspend,
 	.thaw = acpi_fan_resume,
-- 
2.7.0.rc3.207.g0ac5344
