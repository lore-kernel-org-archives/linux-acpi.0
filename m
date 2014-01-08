From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/21] ACPICA: Cleanup the option of forcing the use of the RSDT.
Date: Wed,  8 Jan 2014 13:43:40 +0800
Message-ID: <3a1fe16128e18f762064d0b927d533540eb1d939.1387505702.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30806 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaAHFnt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:43:49 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This option is already in the Linux kernel.  When it is back ported to
ACPICA, code is re-written to follow ACPICA coding style.  This patch
is the generation of the integration.

This change adds a runtime option that will force ACPICA to use the
RSDT instead of the XSDT. Although the ACPI spec requires that an XSDT
be used instead of the RSDT, the XSDT has been found to be corrupt or
ill-formed on some machines.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 arch/ia64/kernel/acpi.c        |    1 -
 arch/x86/kernel/acpi/boot.c    |    3 +--
 drivers/acpi/acpica/acglobal.h |    8 ++++++++
 drivers/acpi/acpica/tbutils.c  |   10 +++++-----
 include/acpi/acpixf.h          |   16 ++++++++--------
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 59d52e3..28dc6ba 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -61,7 +61,6 @@
 
 #define PREFIX			"ACPI: "
 
-u32 acpi_rsdt_forced;
 unsigned int acpi_cpei_override;
 unsigned int acpi_cpei_phys_cpuid;
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 6c0b43b..0b0b91b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -46,7 +46,6 @@
 
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force = 0;
-u32 acpi_rsdt_forced;
 int acpi_disabled;
 EXPORT_SYMBOL(acpi_disabled);
 
@@ -1564,7 +1563,7 @@ static int __init parse_acpi(char *arg)
 	}
 	/* acpi=rsdt use RSDT instead of XSDT */
 	else if (strcmp(arg, "rsdt") == 0) {
-		acpi_rsdt_forced = 1;
+		acpi_gbl_do_not_use_xsdt = TRUE;
 	}
 	/* "acpi=noirq" disables ACPI interrupt routing */
 	else if (strcmp(arg, "noirq") == 0) {
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index e9f1fc7..cffb457 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -119,6 +119,14 @@ bool ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
 u8 ACPI_INIT_GLOBAL(acpi_gbl_copy_dsdt_locally, FALSE);
 
 /*
+ * Optionally ignore an XSDT if present and use the RSDT instead.
+ * Although the ACPI specification requires that an XSDT be used instead
+ * of the RSDT, the XSDT has been found to be corrupt or ill-formed on
+ * some machines. Default behavior is to use the XSDT if present.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_do_not_use_xsdt, FALSE);
+
+/*
  * Optionally truncate I/O addresses to 16 bits. Provides compatibility
  * with other ACPI implementations. NOTE: During ACPICA initialization,
  * this value is set to TRUE if any Windows OSI strings have been
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index ee60670..6412d3c 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -478,10 +478,10 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 				   ACPI_CAST_PTR(struct acpi_table_header,
 						 rsdp));
 
-	/* Differentiate between RSDT and XSDT root tables */
+	/* Use XSDT if present and not overridden. Otherwise, use RSDT */
 
-	if ((rsdp->revision > 1) && rsdp->xsdt_physical_address
-			&& !acpi_rsdt_forced) {
+	if ((rsdp->revision > 1) &&
+	    rsdp->xsdt_physical_address && !acpi_gbl_do_not_use_xsdt) {
 		/*
 		 * RSDP contains an XSDT (64-bit physical addresses). We must use
 		 * the XSDT if the revision is > 1 and the XSDT pointer is present,
@@ -503,8 +503,8 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 	acpi_os_unmap_memory(rsdp, sizeof(struct acpi_table_rsdp));
 
 	/*
-	 * If it is present, validate the XSDT for access/size and ensure
-	 * that all table entries are at least non-NULL
+	 * If it is present and used, validate the XSDT for access/size
+	 * and ensure that all table entries are at least non-NULL
 	 */
 	if (table_entry_size == ACPI_XSDT_ENTRY_SIZE) {
 		status = acpi_tb_validate_xsdt(address);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 4278aba9..30b01f8 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -54,7 +54,6 @@
 #include <acpi/acbuffer.h>
 
 extern u8 acpi_gbl_permanent_mmap;
-extern u32 acpi_rsdt_forced;
 
 /*
  * Globals that are publically available
@@ -72,17 +71,18 @@ extern u32 acpi_dbg_layer;
 
 /* ACPICA runtime options */
 
-extern u8 acpi_gbl_enable_interpreter_slack;
 extern u8 acpi_gbl_all_methods_serialized;
-extern u8 acpi_gbl_create_osi_method;
-extern u8 acpi_gbl_use_default_register_widths;
-extern acpi_name acpi_gbl_trace_method_name;
-extern u32 acpi_gbl_trace_flags;
-extern bool acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_copy_dsdt_locally;
-extern u8 acpi_gbl_truncate_io_addresses;
+extern u8 acpi_gbl_create_osi_method;
 extern u8 acpi_gbl_disable_auto_repair;
 extern u8 acpi_gbl_disable_ssdt_table_load;
+extern u8 acpi_gbl_do_not_use_xsdt;
+extern bool acpi_gbl_enable_aml_debug_object;
+extern u8 acpi_gbl_enable_interpreter_slack;
+extern u32 acpi_gbl_trace_flags;
+extern acpi_name acpi_gbl_trace_method_name;
+extern u8 acpi_gbl_truncate_io_addresses;
+extern u8 acpi_gbl_use_default_register_widths;
 
 /*
  * Hardware-reduced prototypes. All interfaces that use these macros will
-- 
1.7.10

