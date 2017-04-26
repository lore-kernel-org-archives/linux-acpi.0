From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/15] ACPICA: Disassembler: Do not unconditionally remove temporary names
Date: Wed, 26 Apr 2017 16:18:55 +0800
Message-ID: <614448b520b71b65d4f36e931f8d5aba036364c1.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18240 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952819AbdDZITA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:19:00 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit c46f496df41e53a368f877f88b70bdfc9bd6fdbe

Change the Switch disassembly code to check if the conversion can be
done before removing temporary (_T_x) names. Prevents invalid
disassembly of AML created by older compilers (circa 2005).

Link: https://github.com/acpica/acpica/commit/c46f496d
Link: https://bugs.acpica.org/show_bug.cgi?id=1358
Link: https://bugs.acpica.org/show_bug.cgi?id=1360
Reported-by: racerrehabman@gmail.com
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 8fd495e..ca98426 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -784,9 +784,10 @@ union acpi_parse_value {
 #define ACPI_DASM_LNOT_SUFFIX           0x09	/* End  of a Lnot_equal (etc.) pair of opcodes */
 #define ACPI_DASM_HID_STRING            0x0A	/* String is a _HID or _CID */
 #define ACPI_DASM_IGNORE_SINGLE         0x0B	/* Ignore the opcode but not it's children */
-#define ACPI_DASM_SWITCH_PREDICATE      0x0C	/* Object is a predicate for a Switch or Case block */
-#define ACPI_DASM_CASE                  0x0D	/* If/Else is a Case in a Switch/Case block */
-#define ACPI_DASM_DEFAULT               0x0E	/* Else is a Default in a Switch/Case block */
+#define ACPI_DASM_SWITCH                0x0C	/* While is a Switch */
+#define ACPI_DASM_SWITCH_PREDICATE      0x0D	/* Object is a predicate for a Switch or Case block */
+#define ACPI_DASM_CASE                  0x0E	/* If/Else is a Case in a Switch/Case block */
+#define ACPI_DASM_DEFAULT               0x0F	/* Else is a Default in a Switch/Case block */
 
 /*
  * Generic operation (for example:  If, While, Store)
-- 
2.7.4

