From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Remove bool usage from ACPICA.
Date: Fri, 24 Jan 2014 08:49:51 +0800
Message-ID: <bbf879481c03cab54f534d8fe55d860b8ec84a57.1390524535.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40882 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbaAXAuf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jan 2014 19:50:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The use of "bool" is not safe for ACPICA code where it is originally using
a "BOOLEAN" defined as "unsigned char".

This patch removes the only "bool" usage from kernel source tree to reduce
the source code differences between Linux and ACPICA upstream.

The sysfs accesses of /sys/modules/acpi/aml_debug_output should be changed
from "Y/N" to "1/0".  Fortunately no kernel documentation need to be
changed to reflect this modification, there is originally
"echo 1 > /sys/modules/acpi/aml_debug_output" documented.

This patch is required by future acpidump release automation.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/sysfs.c           |    2 +-
 include/acpi/acpixf.h          |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index ad23dc2..b88771b 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -108,7 +108,7 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default_register_widths, TRUE);
 /*
  * Optionally enable output from the AML Debug Object.
  */
-bool ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
+u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
 
 /*
  * Optionally copy the entire DSDT to local memory (instead of simply
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 443dc93..91a32ce 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -226,7 +226,7 @@ module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
 /* /sys/modules/acpi/parameters/aml_debug_output */
 
 module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
-		   bool, 0644);
+		   byte, 0644);
 MODULE_PARM_DESC(aml_debug_output,
 		 "To enable/disable the ACPI Debug Object output.");
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1936be5..51cdf1b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -77,7 +77,7 @@ extern u8 acpi_gbl_create_osi_method;
 extern u8 acpi_gbl_disable_auto_repair;
 extern u8 acpi_gbl_disable_ssdt_table_load;
 extern u8 acpi_gbl_do_not_use_xsdt;
-extern bool acpi_gbl_enable_aml_debug_object;
+extern u8 acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_enable_interpreter_slack;
 extern u32 acpi_gbl_trace_flags;
 extern acpi_name acpi_gbl_trace_method_name;
-- 
1.7.10

