From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 5/7] ACPICA: Disassembler: Fix for Divide() support, new support for test suite
Date: Tue, 18 Oct 2016 03:03:39 +0800
Message-ID: <214d84a471d141ac688949ee679101a57f5ca17a.1476725675.git.lv.zheng@intel.com>
References: <cover.1476725675.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34216 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934954AbcJQTDy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2016 15:03:54 -0400
Received: by mail-qk0-f195.google.com with SMTP id n189so14972942qke.1
        for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2016 12:03:54 -0700 (PDT)
In-Reply-To: <cover.1476725675.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 4b367408659af08fd44839866ec301285284e6f4

Fixes a problem with complex expressions where an illegal mix
of legacy ASL and ASL+ could be emitted.

Adds new support for ASLTS that disables some disassembler
optimizations could be changed during a conversion to ASL+.
These expressions are now emitted in legacy ASL instead
of ASL+.

Link: https://github.com/acpica/acpica/commit/4b367408
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |  1 +
 drivers/acpi/acpica/aclocal.h  | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 17f7bb8..b549e6d 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -318,6 +318,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_cstyle_disassembly, TRUE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_force_aml_disassembly, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_dm_opt_verbose, TRUE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_dm_emit_external_opcodes, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_do_disassembler_optimizations, TRUE);
 
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_disasm);
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_listing);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index dff1207..7926600 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -765,7 +765,7 @@ union acpi_parse_value {
 	union acpi_parse_value          value;          /* Value or args associated with the opcode */\
 	u8                              arg_list_length; /* Number of elements in the arg list */\
 	ACPI_DISASM_ONLY_MEMBERS (\
-	u8                              disasm_flags;   /* Used during AML disassembly */\
+	u16                             disasm_flags;   /* Used during AML disassembly */\
 	u8                              disasm_opcode;  /* Subtype used for disassembly */\
 	char                            *operator_symbol;/* Used for C-style operator name strings */\
 	char                            aml_op_name[16])	/* Op name (debug only) */
@@ -868,14 +868,15 @@ struct acpi_parse_state {
 
 /* Parse object disasm_flags */
 
-#define ACPI_PARSEOP_IGNORE                 0x01
-#define ACPI_PARSEOP_PARAMETER_LIST         0x02
-#define ACPI_PARSEOP_EMPTY_TERMLIST         0x04
-#define ACPI_PARSEOP_PREDEFINED_CHECKED     0x08
-#define ACPI_PARSEOP_CLOSING_PAREN          0x10
-#define ACPI_PARSEOP_COMPOUND_ASSIGNMENT    0x20
-#define ACPI_PARSEOP_ASSIGNMENT             0x40
-#define ACPI_PARSEOP_ELSEIF                 0x80
+#define ACPI_PARSEOP_IGNORE                 0x0001
+#define ACPI_PARSEOP_PARAMETER_LIST         0x0002
+#define ACPI_PARSEOP_EMPTY_TERMLIST         0x0004
+#define ACPI_PARSEOP_PREDEFINED_CHECKED     0x0008
+#define ACPI_PARSEOP_CLOSING_PAREN          0x0010
+#define ACPI_PARSEOP_COMPOUND_ASSIGNMENT    0x0020
+#define ACPI_PARSEOP_ASSIGNMENT             0x0040
+#define ACPI_PARSEOP_ELSEIF                 0x0080
+#define ACPI_PARSEOP_LEGACY_ASL_ONLY        0x0100
 
 /*****************************************************************************
  *
-- 
2.7.4

