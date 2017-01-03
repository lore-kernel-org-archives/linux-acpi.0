From: Lv Zheng <lv.zheng@intel.com>
Subject: [UPDATE PATCH 14/18] ACPICA: Fix for implicit result conversion for the ToXxx functions
Date: Tue,  3 Jan 2017 13:30:41 +0800
Message-ID: <e874220c57c33996ba3f744ba5010b72eb878fb3.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33116 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756457AbdACFav (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Jan 2017 00:30:51 -0500
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e1342c9f2dde37a67e916099658b65984ef8a434

Implicit result conversion was incorrectly disabled for the
following functions:
FromBCD
ToBCD
ToDecimalString
ToHexString
ToInteger
ToBuffer

Subject rephrased by Lv Zheng due to SMTP 550:
 The capital Triple-X in subject is a way too often associated with junk
 email.

Link: https://github.com/acpica/acpica/commit/e1342c9f
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acopcode.h | 14 +++++++-------
 drivers/acpi/acpica/amlcode.h  | 20 +++++++++++++++++---
 drivers/acpi/acpica/exconvrt.c |  1 -
 drivers/acpi/acpica/exresop.c  |  1 -
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index ca4bda1..84d611b 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -249,7 +249,7 @@
 #define ARGI_FIELD_OP                   ARGI_INVALID_OPCODE
 #define ARGI_FIND_SET_LEFT_BIT_OP       ARGI_LIST2 (ARGI_INTEGER,    ARGI_TARGETREF)
 #define ARGI_FIND_SET_RIGHT_BIT_OP      ARGI_LIST2 (ARGI_INTEGER,    ARGI_TARGETREF)
-#define ARGI_FROM_BCD_OP                ARGI_LIST2 (ARGI_INTEGER,    ARGI_FIXED_TARGET)
+#define ARGI_FROM_BCD_OP                ARGI_LIST2 (ARGI_INTEGER,    ARGI_TARGETREF)
 #define ARGI_IF_OP                      ARGI_INVALID_OPCODE
 #define ARGI_INCREMENT_OP               ARGI_LIST1 (ARGI_TARGETREF)
 #define ARGI_INDEX_FIELD_OP             ARGI_INVALID_OPCODE
@@ -313,12 +313,12 @@
 #define ARGI_SUBTRACT_OP                ARGI_LIST3 (ARGI_INTEGER,    ARGI_INTEGER,       ARGI_TARGETREF)
 #define ARGI_THERMAL_ZONE_OP            ARGI_INVALID_OPCODE
 #define ARGI_TIMER_OP                   ARG_NONE
-#define ARGI_TO_BCD_OP                  ARGI_LIST2 (ARGI_INTEGER,    ARGI_FIXED_TARGET)
-#define ARGI_TO_BUFFER_OP               ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_FIXED_TARGET)
-#define ARGI_TO_DEC_STR_OP              ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_FIXED_TARGET)
-#define ARGI_TO_HEX_STR_OP              ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_FIXED_TARGET)
-#define ARGI_TO_INTEGER_OP              ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_FIXED_TARGET)
-#define ARGI_TO_STRING_OP               ARGI_LIST3 (ARGI_BUFFER,     ARGI_INTEGER,       ARGI_FIXED_TARGET)
+#define ARGI_TO_BCD_OP                  ARGI_LIST2 (ARGI_INTEGER,    ARGI_TARGETREF)
+#define ARGI_TO_BUFFER_OP               ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_TARGETREF)
+#define ARGI_TO_DEC_STR_OP              ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_TARGETREF)
+#define ARGI_TO_HEX_STR_OP              ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_TARGETREF)
+#define ARGI_TO_INTEGER_OP              ARGI_LIST2 (ARGI_COMPUTEDATA,ARGI_TARGETREF)
+#define ARGI_TO_STRING_OP               ARGI_LIST3 (ARGI_BUFFER,     ARGI_INTEGER,       ARGI_TARGETREF)
 #define ARGI_UNLOAD_OP                  ARGI_LIST1 (ARGI_DDBHANDLE)
 #define ARGI_VAR_PACKAGE_OP             ARGI_LIST1 (ARGI_INTEGER)
 #define ARGI_WAIT_OP                    ARGI_LIST2 (ARGI_EVENT,      ARGI_INTEGER)
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 6bd8d4b..8a0f959 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -277,9 +277,23 @@
 #define ARGI_DEVICE_REF             0x0D
 #define ARGI_REFERENCE              0x0E
 #define ARGI_TARGETREF              0x0F	/* Target, subject to implicit conversion */
-#define ARGI_FIXED_TARGET           0x10	/* Target, no implicit conversion */
-#define ARGI_SIMPLE_TARGET          0x11	/* Name, Local, Arg -- no implicit conversion */
-#define ARGI_STORE_TARGET           0x12	/* Target for store is TARGETREF + package objects */
+#define ARGI_SIMPLE_TARGET          0x10	/* Name, Local, Arg -- no implicit conversion */
+#define ARGI_STORE_TARGET           0x11	/* Target for store is TARGETREF + package objects */
+/*
+ * #define ARGI_FIXED_TARGET           0x10     Target, no implicit conversion
+ *
+ * Removed 10/2016. ARGI_FIXED_TARGET was used for these operators:
+ *      from_BCD
+ *      to_BCD
+ *      to_decimal_string
+ *      to_hex_string
+ *      to_integer
+ *      to_buffer
+ * The purpose of this type was to disable "implicit result conversion",
+ * but this was incorrect per the ACPI spec and other ACPI implementations.
+ * These operators now have the target operand defined as a normal
+ * ARGI_TARGETREF.
+ */
 
 /* Multiple/complex types */
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 588ad14..83202db 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -592,7 +592,6 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 	 */
 	switch (GET_CURRENT_ARG_TYPE(walk_state->op_info->runtime_args)) {
 	case ARGI_SIMPLE_TARGET:
-	case ARGI_FIXED_TARGET:
 	case ARGI_INTEGER_REF:	/* Handles Increment, Decrement cases */
 
 		switch (destination_type) {
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index f29eba1..d4c386d 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -305,7 +305,6 @@ acpi_ex_resolve_operands(u16 opcode,
 		case ARGI_OBJECT_REF:
 		case ARGI_DEVICE_REF:
 		case ARGI_TARGETREF:	/* Allows implicit conversion rules before store */
-		case ARGI_FIXED_TARGET:	/* No implicit conversion before store to target */
 		case ARGI_SIMPLE_TARGET:	/* Name, Local, or arg - no implicit conversion  */
 		case ARGI_STORE_TARGET:
 
-- 
2.7.4

