From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/10] ACPICA: Update the conditions to enable the utility resource dump strings.
Date: Sat,  8 Feb 2014 09:42:46 +0800
Message-ID: <e5b7b83f25a568835c33b7172a7ba2a0c082f326.1390440748.git.lv.zheng@intel.com>
References: <cover.1390438466.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40178 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaBHBmw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 20:42:52 -0500
In-Reply-To: <cover.1390438466.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch enables resource dump functions for debugging purpose where
ACPI_DEBUG_OUTPUT is enabled.  Such functions are useful for developers
to track kernel issues when composing debugging patches.  They will be
optimized out during link stage for normal builds.

This patch updates the compilation condition used for the resource dump
related string tables to match the compilation environment used for
rsdump.c and rsdumpinfo.c.

This patch can help to improve the ACPICA release automation.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/Makefile     |    4 ++--
 drivers/acpi/acpica/acutils.h    |    2 +-
 drivers/acpi/acpica/rsdump.c     |    3 ++-
 drivers/acpi/acpica/rsdumpinfo.c |    2 +-
 drivers/acpi/acpica/rsinfo.c     |    4 +---
 drivers/acpi/acpica/utresrc.c    |    3 ++-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 4383040..b7ed86a 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -122,6 +122,8 @@ acpi-y +=		\
 	rsaddr.o	\
 	rscalc.o	\
 	rscreate.o	\
+	rsdump.o	\
+	rsdumpinfo.o	\
 	rsinfo.o	\
 	rsio.o		\
 	rsirq.o		\
@@ -132,8 +134,6 @@ acpi-y +=		\
 	rsutils.o	\
 	rsxface.o
 
-acpi-$(ACPI_FUTURE_USAGE) += rsdump.o rsdumpinfo.o
-
 acpi-y +=		\
 	tbfadt.o	\
 	tbfind.o	\
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 24735eb..ceeec0b 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -49,7 +49,7 @@ extern const u8 acpi_gbl_resource_aml_serial_bus_sizes[];
 
 /* Strings used by the disassembler and debugger resource dump routines */
 
-#if defined(ACPI_DISASSEMBLER) || defined (ACPI_DEBUGGER)
+#if defined(ACPI_DEBUG_OUTPUT) || defined (ACPI_DISASSEMBLER) || defined (ACPI_DEBUGGER)
 
 extern const char *acpi_gbl_bm_decode[];
 extern const char *acpi_gbl_config_decode[];
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 7e84008..524c5a5 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -47,7 +47,8 @@
 
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsdump")
-#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
+
+#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBER) || defined(ACPI_DEBUGGER)
 /* Local prototypes */
 static void acpi_rs_out_string(char *title, char *value);
 
diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index 60a852e..2f9332d 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -48,7 +48,7 @@
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsdumpinfo")
 
-#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
+#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
 #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_data,f)
 #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_routing_table,f)
 #define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rsdump_info))
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index d984d45..9d3f8a9 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -132,8 +132,7 @@ struct acpi_rsconvert_info *acpi_gbl_convert_resource_serial_bus_dispatch[] = {
 	acpi_rs_convert_uart_serial_bus,
 };
 
-#ifdef ACPI_FUTURE_USAGE
-#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
+#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
 
 /* Dispatch table for resource dump functions */
 
@@ -168,7 +167,6 @@ struct acpi_rsdump_info *acpi_gbl_dump_serial_bus_dispatch[] = {
 };
 #endif
 
-#endif				/* ACPI_FUTURE_USAGE */
 /*
  * Base sizes for external AML resource descriptors, indexed by internal type.
  * Includes size of the descriptor header (1 byte for small descriptors,
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index e71a4d8..14cb6c0 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -47,7 +47,8 @@
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utresrc")
-#if defined(ACPI_DISASSEMBLER) || defined (ACPI_DEBUGGER)
+
+#if defined(ACPI_DEBUG_OUTPUT) || defined (ACPI_DISASSEMBLER) || defined (ACPI_DEBUGGER)
 /*
  * Strings used to decode resource descriptors.
  * Used by both the disassembler and the debugger resource dump routines
-- 
1.7.10

