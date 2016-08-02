From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0049/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:02 +0800
Message-ID: <20160802103702.17033-1-baolex.ni@intel.com>
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
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 444e374..fbe3ccc 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -55,7 +55,7 @@ static int bm_check_disable __read_mostly;
 module_param(bm_check_disable, uint, 0000);
 
 static unsigned int latency_factor __read_mostly = 2;
-module_param(latency_factor, uint, 0644);
+module_param(latency_factor, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
 
-- 
2.9.2
