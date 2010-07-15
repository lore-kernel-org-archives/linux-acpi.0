From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/9] ACPI: introduce module parameter acpi.aml_debug_output
Date: Thu, 15 Jul 2010 10:46:17 +0800
Message-ID: <1279161977.4537.8515.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46432 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129Ab0GOCoL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jul 2010 22:44:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Introduce module parameter acpi.aml_debug_output.

With acpi.aml_debug_output set, we can get AML debug object output
(Store (AAA, Debug)), even with CONFIG_ACPI_DEBUG cleared.

Together with the runtime custom method mechanism,
we can debug AML code problems without rebuilding the kernel.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/acpi/method-customizing.txt |    2 ++
 drivers/acpi/acpica/acglobal.h            |    2 +-
 drivers/acpi/debugfs.c                    |    8 ++++++++
 include/acpi/acpixf.h                     |    2 +-
 4 files changed, 12 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/debugfs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/debugfs.c
+++ linux-2.6/drivers/acpi/debugfs.c
@@ -11,6 +11,14 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("debugfs");
 
+
+/* /sys/modules/acpi/parameters/aml_debug_output */
+
+module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
+		   bool, 0644);
+MODULE_PARM_DESC(aml_debug_output,
+		 "To enable/disable the ACPI Debug Object output.");
+
 /* /sys/kernel/debug/acpi/custom_method */
 
 static ssize_t cm_write(struct file *file, const char __user * user_buf,
Index: linux-2.6/Documentation/acpi/method-customizing.txt
===================================================================
--- linux-2.6.orig/Documentation/acpi/method-customizing.txt
+++ linux-2.6/Documentation/acpi/method-customizing.txt
@@ -19,6 +19,8 @@ Note: Only ACPI METHOD can be overridden
       "Device", "OperationRegion", are not recognized.
 Note: The same ACPI control method can be overridden for many times,
       and it's always the latest one that used by Linux/kernel.
+Note: To get the ACPI debug object output (Store (AAAA, Debug)),
+      please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
 
 1. override an existing method
    a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
Index: linux-2.6/drivers/acpi/acpica/acglobal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acglobal.h
+++ linux-2.6/drivers/acpi/acpica/acglobal.h
@@ -108,7 +108,7 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default
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
@@ -66,7 +66,7 @@ extern u8 acpi_gbl_create_osi_method;
 extern u8 acpi_gbl_use_default_register_widths;
 extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
-extern u8 acpi_gbl_enable_aml_debug_object;
+extern u32 acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_truncate_io_addresses;
 


