From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0053/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:18 +0800
Message-ID: <20160802103718.17297-1-baolex.ni@intel.com>
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
 drivers/acpi/sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 4b3a9e2..2830b21 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -161,8 +161,8 @@ static const struct kernel_param_ops param_ops_debug_level = {
 	.get = param_get_debug_level,
 };
 
-module_param_cb(debug_layer, &param_ops_debug_layer, &acpi_dbg_layer, 0644);
-module_param_cb(debug_level, &param_ops_debug_level, &acpi_dbg_level, 0644);
+module_param_cb(debug_layer, &param_ops_debug_layer, &acpi_dbg_layer, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+module_param_cb(debug_level, &param_ops_debug_level, &acpi_dbg_level, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static char trace_method_name[1024];
 
@@ -223,9 +223,9 @@ static const struct kernel_param_ops param_ops_trace_attrib = {
 	.get = param_get_uint,
 };
 
-module_param_cb(trace_method_name, &param_ops_trace_method, &trace_method_name, 0644);
-module_param_cb(trace_debug_layer, &param_ops_trace_attrib, &acpi_gbl_trace_dbg_layer, 0644);
-module_param_cb(trace_debug_level, &param_ops_trace_attrib, &acpi_gbl_trace_dbg_level, 0644);
+module_param_cb(trace_method_name, &param_ops_trace_method, &trace_method_name, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+module_param_cb(trace_debug_layer, &param_ops_trace_attrib, &acpi_gbl_trace_dbg_layer, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+module_param_cb(trace_debug_level, &param_ops_trace_attrib, &acpi_gbl_trace_dbg_level, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static int param_set_trace_state(const char *val, struct kernel_param *kp)
 {
@@ -280,14 +280,14 @@ static int param_get_trace_state(char *buffer, struct kernel_param *kp)
 }
 
 module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
-		  NULL, 0644);
+		  NULL, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 #endif /* CONFIG_ACPI_DEBUG */
 
 
 /* /sys/modules/acpi/parameters/aml_debug_output */
 
 module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
-		   byte, 0644);
+		   byte, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(aml_debug_output,
 		 "To enable/disable the ACPI Debug Object output.");
 
@@ -301,7 +301,7 @@ static int param_get_acpica_version(char *buffer, struct kernel_param *kp)
 	return result;
 }
 
-module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
+module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 
 /*
  * ACPI table sysfs I/F:
-- 
2.9.2
