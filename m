From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0054/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:21 +0800
Message-ID: <20160802103721.17363-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com
List-Id: linux-acpi@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/acpi/thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 82707f9..5657f46 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -64,15 +64,15 @@ MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
 MODULE_LICENSE("GPL");
 
 static int act;
-module_param(act, int, 0644);
+module_param(act, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(act, "Disable or override all lowest active trip points.");
 
 static int crt;
-module_param(crt, int, 0644);
+module_param(crt, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(crt, "Disable or lower all critical trip points.");
 
 static int tzp;
-module_param(tzp, int, 0444);
+module_param(tzp, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
 
 static int nocrt;
@@ -84,7 +84,7 @@ module_param(off, int, 0);
 MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
 
 static int psv;
-module_param(psv, int, 0644);
+module_param(psv, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(psv, "Disable or override all passive trip points.");
 
 static struct workqueue_struct *acpi_thermal_pm_queue;
-- 
2.9.2
