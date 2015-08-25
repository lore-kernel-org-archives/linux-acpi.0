From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/20] ACPICA: Disassembler: Update for new listing mode.
Date: Tue, 25 Aug 2015 10:28:47 +0800
Message-ID: <476d4934374733805a6d5f1301c2f4077a4e2b3d.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 2ed09bb7619d25f5a5c065c33a8a775a6db3a856
ACPICA commit 2fefacf73825b0ec96bbfc4f70a256735b715d6c

This mode emits AML code along with the ASL code.
A new global was needed to ensure the listing mode is
completely separate from the debugger verbose mode.

Emits the correct AML offset for the AML code.
The -l option now works for both the compiler and disassembler.

Linux kernel is not affected by this commit.

Link: https://github.com/acpica/acpica/commit/2fefacf7
Link: https://github.com/acpica/acpica/commit/2ed09bb7
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 79eb35d..1283b19 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -307,9 +307,9 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_no_resource_disassembly, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_ignore_noop_operator, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_cstyle_disassembly, TRUE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_force_aml_disassembly, FALSE);
-ACPI_INIT_GLOBAL(union acpi_parse_object *, acpi_gbl_previous_op, NULL);
 
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_disasm);
+ACPI_GLOBAL(u8, acpi_gbl_dm_opt_listing);
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_verbose);
 ACPI_GLOBAL(u8, acpi_gbl_num_external_methods);
 ACPI_GLOBAL(u32, acpi_gbl_resolved_external_methods);
-- 
1.7.10
