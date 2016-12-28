From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/18] ACPICA: Disassembler: Add Switch/Case disassembly support
Date: Wed, 28 Dec 2016 15:29:17 +0800
Message-ID: <ea863e5a350f61c96f3a486f7d51afd85fa1d29d.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit 0f6cc80e8af519a3c31184367b0a9be7a399cf53

iasl compiles Switch/Case statements into a single iteration While
loop with If/Else statements. This patch adds support to recognize
this generated compiler output and disassemble it back to the original
Switch statement.

Linux kernel is not affected by this patch.

Link: https://github.com/acpica/acpica/commit/0f6cc80e
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 7926600..7b97801 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -770,7 +770,7 @@ union acpi_parse_value {
 	char                            *operator_symbol;/* Used for C-style operator name strings */\
 	char                            aml_op_name[16])	/* Op name (debug only) */
 
-/* Flags for disasm_flags field above */
+/* Internal opcodes for disasm_opcode field above */
 
 #define ACPI_DASM_BUFFER                0x00	/* Buffer is a simple data buffer */
 #define ACPI_DASM_RESOURCE              0x01	/* Buffer is a Resource Descriptor */
@@ -783,7 +783,10 @@ union acpi_parse_value {
 #define ACPI_DASM_LNOT_PREFIX           0x08	/* Start of a Lnot_equal (etc.) pair of opcodes */
 #define ACPI_DASM_LNOT_SUFFIX           0x09	/* End  of a Lnot_equal (etc.) pair of opcodes */
 #define ACPI_DASM_HID_STRING            0x0A	/* String is a _HID or _CID */
-#define ACPI_DASM_IGNORE                0x0B	/* Not used at this time */
+#define ACPI_DASM_IGNORE_SINGLE         0x0B	/* Ignore the opcode but not it's children */
+#define ACPI_DASM_SWITCH_PREDICATE      0x0C	/* Object is a predicate for a Switch or Case block */
+#define ACPI_DASM_CASE                  0x0D	/* If/Else is a Case in a Switch/Case block */
+#define ACPI_DASM_DEFAULT               0x0E	/* Else is a Default in a Switch/Case block */
 
 /*
  * Generic operation (for example:  If, While, Store)
-- 
2.7.4
