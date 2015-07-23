From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/22] ACPICA: iASL/Disassembler: Add prototype verbose mode.
Date: Thu, 23 Jul 2015 12:54:23 +0800
Message-ID: <62269b571989786372fd89fa12bb07acd4c48eff.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit add72dca18ab5d02f1bf9b08027570e58da520e8

This mode will emit AML byte code after each ASL statement.
This is a prototype only and requires additional development.

This patch only affects ACPICA disassembler which is not in the kernel
source tree.

Link: https://github.com/acpica/acpica/commit/add72dca
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 5342300..79eb35d 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -307,6 +307,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_no_resource_disassembly, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_ignore_noop_operator, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_cstyle_disassembly, TRUE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_force_aml_disassembly, FALSE);
+ACPI_INIT_GLOBAL(union acpi_parse_object *, acpi_gbl_previous_op, NULL);
 
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_disasm);
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_verbose);
-- 
1.7.10
