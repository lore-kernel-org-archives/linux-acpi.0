From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/31] ACPICA: iASL/Disassembler: Add option to assume table contains valid AML.
Date: Mon, 13 Apr 2015 11:50:21 +0800
Message-ID: <fa0cd3ff758dadd3ef64c4982eaaee88e64d13f3.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit f5d2ff3fa05341d9fe27250fcb2e14c7f871432c

For dynamically loaded tables that have unknown ACPI signatures,
this option (-df) forces the disassembler to treat the table as if
it contains valid AML code (like a DSDT or SSDT). Otherwise, the
disassembler will treat the table as an unkown data table and
simply do a hex dump of the table.

Linux kernel is not affected by this patch.

Link: https://github.com/acpica/acpica/commit/f5d2ff3f
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 8a99dcb..a0c4787 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -306,6 +306,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_db_output_flags, ACPI_DB_CONSOLE_OUTPUT);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_no_resource_disassembly, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_ignore_noop_operator, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_cstyle_disassembly, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_force_aml_disassembly, FALSE);
 
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_disasm);
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_verbose);
-- 
1.7.10
