From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/15] ACPICA: Renamed some #defined flag constants for clarity
Date: Wed,  4 May 2016 13:48:49 +0800
Message-ID: <9d8a1543cc73390ab3fa0c2142c12a2543333e43.1462331121.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462331120.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 438905b205e64e742f9670a0970419c426264831

Expanded a couple of cryptic names.

Link: https://github.com/acpica/acpica/commit/438905b2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |   30 +++++++++++++++---------------
 drivers/acpi/acpica/psutils.c |    2 +-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 166a67f..13331d7 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -856,24 +856,24 @@ struct acpi_parse_state {
 
 /* Parse object flags */
 
-#define ACPI_PARSEOP_GENERIC            0x01
-#define ACPI_PARSEOP_NAMED              0x02
-#define ACPI_PARSEOP_DEFERRED           0x04
-#define ACPI_PARSEOP_BYTELIST           0x08
-#define ACPI_PARSEOP_IN_STACK           0x10
-#define ACPI_PARSEOP_TARGET             0x20
-#define ACPI_PARSEOP_IN_CACHE           0x80
+#define ACPI_PARSEOP_GENERIC                0x01
+#define ACPI_PARSEOP_NAMED_OBJECT           0x02
+#define ACPI_PARSEOP_DEFERRED               0x04
+#define ACPI_PARSEOP_BYTELIST               0x08
+#define ACPI_PARSEOP_IN_STACK               0x10
+#define ACPI_PARSEOP_TARGET                 0x20
+#define ACPI_PARSEOP_IN_CACHE               0x80
 
 /* Parse object disasm_flags */
 
-#define ACPI_PARSEOP_IGNORE             0x01
-#define ACPI_PARSEOP_PARAMLIST          0x02
-#define ACPI_PARSEOP_EMPTY_TERMLIST     0x04
-#define ACPI_PARSEOP_PREDEF_CHECKED     0x08
-#define ACPI_PARSEOP_CLOSING_PAREN      0x10
-#define ACPI_PARSEOP_COMPOUND           0x20
-#define ACPI_PARSEOP_ASSIGNMENT         0x40
-#define ACPI_PARSEOP_ELSEIF             0x80
+#define ACPI_PARSEOP_IGNORE                 0x01
+#define ACPI_PARSEOP_PARAMETER_LIST         0x02
+#define ACPI_PARSEOP_EMPTY_TERMLIST         0x04
+#define ACPI_PARSEOP_PREDEFINED_CHECKED     0x08
+#define ACPI_PARSEOP_CLOSING_PAREN          0x10
+#define ACPI_PARSEOP_COMPOUND_ASSIGNMENT    0x20
+#define ACPI_PARSEOP_ASSIGNMENT             0x40
+#define ACPI_PARSEOP_ELSEIF                 0x80
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index b28b0da..89cb4bf 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -128,7 +128,7 @@ union acpi_parse_object *acpi_ps_alloc_op(u16 opcode, u8 *aml)
 	if (op_info->flags & AML_DEFER) {
 		flags = ACPI_PARSEOP_DEFERRED;
 	} else if (op_info->flags & AML_NAMED) {
-		flags = ACPI_PARSEOP_NAMED;
+		flags = ACPI_PARSEOP_NAMED_OBJECT;
 	} else if (opcode == AML_INT_BYTELIST_OP) {
 		flags = ACPI_PARSEOP_BYTELIST;
 	}
-- 
1.7.10
