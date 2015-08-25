From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/20] ACPICA: Disassembler: Cleanup acpi_gbl_db_opt_disasm.
Date: Tue, 25 Aug 2015 10:30:27 +0800
Message-ID: <d3c33a186a85ee4b3ae3a218e5d4c3c5a5f7f301.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 969989cf7f85e2a2a0cd048cd25fc706246a48a2

This patch cleans up the following global variable - acpi_gbl_db_opt_disasm:
The setting is used to control the full disassembly feature for iasl. ACPI
debugger (acpiexec) shall have nothing to do with it. Actually, acpiexec
never links to ad_aml_disassemble().

This patch thus renames this global option to acpi_gbl_dm_opt_disasm and
removes all acpiexec and debugger references on it. Lv Zheng.

This patch doesn't affect Linux kernel.

Link: https://github.com/acpica/acpica/commit/969989cf
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 03c443b..0007eb7 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -313,7 +313,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_ignore_noop_operator, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_cstyle_disassembly, TRUE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_force_aml_disassembly, FALSE);
 
-ACPI_GLOBAL(u8, acpi_gbl_db_opt_disasm);
+ACPI_GLOBAL(u8, acpi_gbl_dm_opt_disasm);
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_listing);
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_verbose);
 ACPI_GLOBAL(u8, acpi_gbl_num_external_methods);
-- 
1.7.10
