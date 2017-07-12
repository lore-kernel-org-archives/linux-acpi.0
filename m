From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPI: EC: Revert "ACPI / EC: Enable event freeze mode..." to fix a regression
Date: Wed, 12 Jul 2017 11:09:17 +0800
Message-ID: <c649e0a8ced621d0577d48a2b400f1a21a3a20ee.1499828705.git.lv.zheng@intel.com>
References: <26498770711bbb36ca2888b33b56a0a56dc29083.1499828705.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26498770711bbb36ca2888b33b56a0a56dc29083.1499828705.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Stable # 4 . 9+" <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Lenovo ThinkPad X1 Carbon - the 5th Generation, enabling an earlier EC
event freezing timing causes acpitz-virtual-0 to report a stucked 48C
temparature. And with EC firmware revisioned as 1.14, without reverting
back to old EC event freezing timing, the fan still blows up after a system
resume (see comment 168 on link #1).

This reverts the culprit change so that the regression can be fixed without
upgrading the EC firmware.

Fixes: d30283057ecd ("ACPI / EC: Enable event freeze mode to improve event handling")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=191181 [#1]
Tested-by: Damjan Georgievski <gdamjan@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Stable <stable@vger.kernel.org> # 4.9+
---
 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 05e4eb5..ddb01e9 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -147,7 +147,7 @@ static unsigned int ec_storm_threshold  __read_mostly = 8;
 module_param(ec_storm_threshold, uint, 0644);
 MODULE_PARM_DESC(ec_storm_threshold, "Maxim false GPE numbers not considered as GPE storm");
 
-static bool ec_freeze_events __read_mostly = true;
+static bool ec_freeze_events __read_mostly = false;
 module_param(ec_freeze_events, bool, 0644);
 MODULE_PARM_DESC(ec_freeze_events, "Disabling event handling during suspend/resume");
 
-- 
2.7.4
