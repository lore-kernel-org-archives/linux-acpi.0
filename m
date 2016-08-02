From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0042/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:36:35 +0800
Message-ID: <20160802103635.16571-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
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
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index ab23479..5fa6d51 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -70,7 +70,7 @@ static async_cookie_t async_cookie;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
 static unsigned int cache_time = 1000;
-module_param(cache_time, uint, 0644);
+module_param(cache_time, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
-- 
2.9.2
