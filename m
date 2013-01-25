From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/7] ACPICA: iASL/Disassembler: Add option to ignore NOOP opcodes/operators
Date: Fri, 25 Jan 2013 13:41:08 +0800
Message-ID: <ba25685dd5de5c59db1bbb0e1e50f75aec5627fd.1358825277.git.lv.zheng@intel.com>
References: <cover.1358825277.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59845 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab3AYFlX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2013 00:41:23 -0500
In-Reply-To: <cover.1358825277.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented for both the compiler and the disassembler.  Often,
the NOOP opcode is used as padding for packages that are changed
dynamically by the BIOS. When disassembled, these NOOPs will
cause syntax errors. This option causes the disassembler to ignore
the NOOP opcode, and it also causes the compiler to ignore NOOP
statements as well.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Tested-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 7f6a9a9..ecb4992 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -405,7 +405,7 @@ ACPI_EXTERN u32 acpi_gbl_trace_dbg_layer;
 
 /*****************************************************************************
  *
- * Debugger globals
+ * Debugger and Disassembler globals
  *
  ****************************************************************************/
 
@@ -413,6 +413,8 @@ ACPI_EXTERN u8 acpi_gbl_db_output_flags;
 
 #ifdef ACPI_DISASSEMBLER
 
+u8 ACPI_INIT_GLOBAL(acpi_gbl_ignore_noop_operator, FALSE);
+
 ACPI_EXTERN u8 acpi_gbl_db_opt_disasm;
 ACPI_EXTERN u8 acpi_gbl_db_opt_verbose;
 ACPI_EXTERN struct acpi_external_list *acpi_gbl_external_list;
-- 
1.7.10

