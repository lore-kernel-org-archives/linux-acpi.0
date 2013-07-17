From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/6] ACPICA: Disassembler: Expand maximum output string length to 64K
Date: Wed, 17 Jul 2013 09:48:40 +0800
Message-ID: <07786ae76b91195b1551bbf97be0c39340e20b5b.1374025121.git.lv.zheng@intel.com>
References: <cover.1374025121.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31746 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab3GQBsw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jul 2013 21:48:52 -0400
In-Reply-To: <cover.1374025121.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Was 256 bytes max. The original purpose of this constraint was to
limit the amount of debug output. However, the string function in
question (UtPrintString) is now used for the disassembler also,
where 256 bytes is insufficient. Reported by RehabMan@GitHub.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    2 +-
 drivers/acpi/acpica/utstring.c |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 3c76ede..4c081c4 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -616,7 +616,7 @@ int acpi_ut_stricmp(char *string1, char *string2);
 
 acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer);
 
-void acpi_ut_print_string(char *string, u8 max_length);
+void acpi_ut_print_string(char *string, u16 max_length);
 
 void ut_convert_backslashes(char *pathname);
 
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index c53759b..cb1e9cc 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -333,7 +333,8 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
  * FUNCTION:    acpi_ut_print_string
  *
  * PARAMETERS:  string          - Null terminated ASCII string
- *              max_length      - Maximum output length
+ *              max_length      - Maximum output length. Used to constrain the
+ *                                length of strings during debug output only.
  *
  * RETURN:      None
  *
@@ -342,7 +343,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
  *
  ******************************************************************************/
 
-void acpi_ut_print_string(char *string, u8 max_length)
+void acpi_ut_print_string(char *string, u16 max_length)
 {
 	u32 i;
 
-- 
1.7.10

