From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/30] ACPICA: OSL: Add correct acpi_gbl_debug_timeout export to allow acpiexec to link
Date: Thu,  4 Aug 2016 16:44:11 +0800
Message-ID: <c838962d2be3a007ba989a3c1b55e9e8564f01f1.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:31644 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289AbcHDIom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:42 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 408198c8c9786f9f104ee925020c3ab1701906e4

The acpi_gbl_debug_timeout which is used by acpiexec -et option now is only
implemented in oswinxf.c and used for WIN32 builds. This makes it very
difficult to remember that we need to add this variable to other os
specific layer files in order for linking. This patch makes it a global
option dependent on ACPI_APPLICATION so that it can always be linked by the
applications. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/408198c8
Link: https://bugs.acpica.org/show_bug.cgi?id=1295
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h                         |    1 +
 tools/power/acpi/os_specific/service_layers/osunixxf.c |    3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 8c2c504..750fa82 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -383,6 +383,7 @@ ACPI_GLOBAL(const char, *acpi_gbl_pld_shape_list[]);
 
 ACPI_INIT_GLOBAL(ACPI_FILE, acpi_gbl_debug_file, NULL);
 ACPI_INIT_GLOBAL(ACPI_FILE, acpi_gbl_output_file, NULL);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_debug_timeout, FALSE);
 
 /* Print buffer */
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 88aa66e..8d8003c 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -63,10 +63,7 @@
 #define _COMPONENT          ACPI_OS_SERVICES
 ACPI_MODULE_NAME("osunixxf")
 
-u8 acpi_gbl_debug_timeout = FALSE;
-
 /* Upcalls to acpi_exec */
-
 void
 ae_table_override(struct acpi_table_header *existing_table,
 		  struct acpi_table_header **new_table);
-- 
1.7.10

