From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/5] ACPI: introduce module parameter acpi.aml_debug
Date: Fri, 11 Jun 2010 13:48:06 +0800
Message-ID: <1276235286.19052.15875.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6699 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161Ab0FKFrn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 01:47:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Lin Ming <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>


Introduce module parameter acpi.aml_debug.

With acpi.aml_debug set, we can get AML debug object
output (Store (AAA, Debug)), even with CONFIG_ACPI_DEBUG
cleared.

Together with the runtime custom method,
we can debug AML code problems without rebuilding the kernel.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/sysfs.c           |    4 ++++
 include/acpi/acpixf.h          |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/sysfs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sysfs.c
+++ linux-2.6/drivers/acpi/sysfs.c
@@ -219,6 +219,10 @@ static int param_get_acpica_version(char
 
 module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
 
+/* /sys/module/acpi/parameters/aml_debug */
+
+module_param_named(aml_debug, acpi_gbl_enable_aml_debug_object, uint, 0644);
+
 /* /sys/firmware/acpi/tables/ */
 static LIST_HEAD(acpi_table_attr_list);
 static struct kobject *tables_kobj;
Index: linux-2.6/drivers/acpi/acpica/acglobal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acglobal.h
+++ linux-2.6/drivers/acpi/acpica/acglobal.h
@@ -115,7 +115,7 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default
 /*
  * Optionally enable output from the AML Debug Object.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
+u32 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
 
 /*
  * Optionally copy the entire DSDT to local memory (instead of simply
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -67,7 +67,7 @@ extern u8 acpi_gbl_leave_wake_gpes_disab
 extern u8 acpi_gbl_use_default_register_widths;
 extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
-extern u8 acpi_gbl_enable_aml_debug_object;
+extern u32 acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_copy_dsdt_locally;
 
 extern u32 acpi_current_gpe_count;


