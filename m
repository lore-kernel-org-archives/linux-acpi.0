From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 26/53] ACPICA: Fix a type value overlap in the AML support file
Date: Mon,  5 Jun 2017 16:39:43 +0800
Message-ID: <5a4d963dcf41707209b304246ed9691aae2de054.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbdFEIjr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:39:47 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 7cb6e66982178bbc96a6f1f7969da95e9da753fa

An AML opcode type field was overlapped with values used
for the top-level dispatch. Did not cause an actual problem,
but fixed anyway.

Link: https://github.com/acpica/acpica/commit/7cb6e669
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/amlcode.h | 61 +++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 176f7e9..f54dc5a 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -313,6 +313,11 @@
  *      #A is the number of required arguments
  *      #T is the number of target operands
  *      #R indicates whether there is a return value
+ *
+ * These types are used for the top-level dispatch of the AML
+ * opcode. They group similar operators that can share common
+ * front-end code before dispatch to the final code that implements
+ * the operator.
  */
 
 /*
@@ -353,42 +358,42 @@
  * The opcode Type is used in a dispatch table, do not change
  * or add anything new without updating the table.
  */
-#define AML_TYPE_EXEC_0A_0T_1R      0x00
-#define AML_TYPE_EXEC_1A_0T_0R      0x01	/* Monadic1  */
-#define AML_TYPE_EXEC_1A_0T_1R      0x02	/* Monadic2  */
-#define AML_TYPE_EXEC_1A_1T_0R      0x03
-#define AML_TYPE_EXEC_1A_1T_1R      0x04	/* monadic2_r */
-#define AML_TYPE_EXEC_2A_0T_0R      0x05	/* Dyadic1   */
-#define AML_TYPE_EXEC_2A_0T_1R      0x06	/* Dyadic2   */
-#define AML_TYPE_EXEC_2A_1T_1R      0x07	/* dyadic2_r  */
-#define AML_TYPE_EXEC_2A_2T_1R      0x08
-#define AML_TYPE_EXEC_3A_0T_0R      0x09
-#define AML_TYPE_EXEC_3A_1T_1R      0x0A
-#define AML_TYPE_EXEC_6A_0T_1R      0x0B
+#define AML_TYPE_EXEC_0A_0T_1R      0x00	/* 0 Args, 0 Target, 1 ret_val */
+#define AML_TYPE_EXEC_1A_0T_0R      0x01	/* 1 Args, 0 Target, 0 ret_val */
+#define AML_TYPE_EXEC_1A_0T_1R      0x02	/* 1 Args, 0 Target, 1 ret_val */
+#define AML_TYPE_EXEC_1A_1T_0R      0x03	/* 1 Args, 1 Target, 0 ret_val */
+#define AML_TYPE_EXEC_1A_1T_1R      0x04	/* 1 Args, 1 Target, 1 ret_val */
+#define AML_TYPE_EXEC_2A_0T_0R      0x05	/* 2 Args, 0 Target, 0 ret_val */
+#define AML_TYPE_EXEC_2A_0T_1R      0x06	/* 2 Args, 0 Target, 1 ret_val */
+#define AML_TYPE_EXEC_2A_1T_1R      0x07	/* 2 Args, 1 Target, 1 ret_val */
+#define AML_TYPE_EXEC_2A_2T_1R      0x08	/* 2 Args, 2 Target, 1 ret_val */
+#define AML_TYPE_EXEC_3A_0T_0R      0x09	/* 3 Args, 0 Target, 0 ret_val */
+#define AML_TYPE_EXEC_3A_1T_1R      0x0A	/* 3 Args, 1 Target, 1 ret_val */
+#define AML_TYPE_EXEC_6A_0T_1R      0x0B	/* 6 Args, 0 Target, 1 ret_val */
 /* End of types used in dispatch table */
 
-#define AML_TYPE_LITERAL            0x0B
-#define AML_TYPE_CONSTANT           0x0C
-#define AML_TYPE_METHOD_ARGUMENT    0x0D
-#define AML_TYPE_LOCAL_VARIABLE     0x0E
-#define AML_TYPE_DATA_TERM          0x0F
+#define AML_TYPE_LITERAL            0x0C
+#define AML_TYPE_CONSTANT           0x0D
+#define AML_TYPE_METHOD_ARGUMENT    0x0E
+#define AML_TYPE_LOCAL_VARIABLE     0x0F
+#define AML_TYPE_DATA_TERM          0x10
 
 /* Generic for an op that returns a value */
 
-#define AML_TYPE_METHOD_CALL        0x10
+#define AML_TYPE_METHOD_CALL        0x11
 
 /* Miscellaneous types */
 
-#define AML_TYPE_CREATE_FIELD       0x11
-#define AML_TYPE_CREATE_OBJECT      0x12
-#define AML_TYPE_CONTROL            0x13
-#define AML_TYPE_NAMED_NO_OBJ       0x14
-#define AML_TYPE_NAMED_FIELD        0x15
-#define AML_TYPE_NAMED_SIMPLE       0x16
-#define AML_TYPE_NAMED_COMPLEX      0x17
-#define AML_TYPE_RETURN             0x18
-#define AML_TYPE_UNDEFINED          0x19
-#define AML_TYPE_BOGUS              0x1A
+#define AML_TYPE_CREATE_FIELD       0x12
+#define AML_TYPE_CREATE_OBJECT      0x13
+#define AML_TYPE_CONTROL            0x14
+#define AML_TYPE_NAMED_NO_OBJ       0x15
+#define AML_TYPE_NAMED_FIELD        0x16
+#define AML_TYPE_NAMED_SIMPLE       0x17
+#define AML_TYPE_NAMED_COMPLEX      0x18
+#define AML_TYPE_RETURN             0x19
+#define AML_TYPE_UNDEFINED          0x1A
+#define AML_TYPE_BOGUS              0x1B
 
 /* AML Package Length encodings */
 
-- 
2.7.4

