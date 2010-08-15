From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/20] ACPI: introduce module parameter acpi.aml_debug_output
Date: Sun, 15 Aug 2010 01:23:17 -0400
Message-ID: <c637e4861c7db8165d0f438db3829e7878c96059.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57554 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab0HOFaH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:30:07 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600HN2HY5RHB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:30:07 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Introduce module parameter acpi.aml_debug_output.

With acpi.aml_debug_output set, we can get AML debug object output
(Store (AAA, Debug)), even with CONFIG_ACPI_DEBUG cleared.

Together with the runtime custom method mechanism,
we can debug AML code problems without rebuilding the kernel.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/acpi/method-customizing.txt |    2 ++
 drivers/acpi/acpica/acglobal.h            |    2 +-
 drivers/acpi/debugfs.c                    |    8 ++++++++
 include/acpi/acpixf.h                     |    2 +-
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
index e628cd2..3e1d25a 100644
--- a/Documentation/acpi/method-customizing.txt
+++ b/Documentation/acpi/method-customizing.txt
@@ -19,6 +19,8 @@ Note: Only ACPI METHOD can be overridden, any other object types like
       "Device", "OperationRegion", are not recognized.
 Note: The same ACPI control method can be overridden for many times,
       and it's always the latest one that used by Linux/kernel.
+Note: To get the ACPI debug object output (Store (AAAA, Debug)),
+      please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
 
 1. override an existing method
    a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 899d68a..9212229 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -115,7 +115,7 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default_register_widths, TRUE);
 /*
  * Optionally enable output from the AML Debug Object.
  */
-u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
+u32 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
 
 /*
  * Optionally copy the entire DSDT to local memory (instead of simply
diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
index abfcf9f..7de27d4 100644
--- a/drivers/acpi/debugfs.c
+++ b/drivers/acpi/debugfs.c
@@ -12,6 +12,14 @@
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
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1371cc9..a6ea2ac 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -67,7 +67,7 @@ extern u8 acpi_gbl_leave_wake_gpes_disabled;
 extern u8 acpi_gbl_use_default_register_widths;
 extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
-extern u8 acpi_gbl_enable_aml_debug_object;
+extern u32 acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_truncate_io_addresses;
 
-- 
1.7.2.1.95.g3d045

