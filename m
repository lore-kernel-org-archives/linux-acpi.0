From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/16] ACPICA: Update interface to AcpiUtValidAcpiName
Date: Sat,  8 Jun 2013 08:59:44 +0800
Message-ID: <7443abecbf977754957f6c8af61add225a9f09a6.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52227 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab3FHBAG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 21:00:06 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Clean up the interface by making the input argument a char *
string instead of a UINT32 name. This is easier to use for all
callers and eliminates casting to *(UINT32*)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    2 +-
 drivers/acpi/acpica/tbinstal.c |    3 +--
 drivers/acpi/acpica/utstring.c |    8 ++++----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index d552036..3c76ede 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -620,7 +620,7 @@ void acpi_ut_print_string(char *string, u8 max_length);
 
 void ut_convert_backslashes(char *pathname);
 
-u8 acpi_ut_valid_acpi_name(u32 name);
+u8 acpi_ut_valid_acpi_name(char *name);
 
 u8 acpi_ut_valid_acpi_char(char character, u32 position);
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index a04e54d..42a13c0 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -141,8 +141,7 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 		ACPI_BIOS_ERROR((AE_INFO,
 				 "Table has invalid signature [%4.4s] (0x%8.8X), "
 				 "must be SSDT or OEMx",
-				 acpi_ut_valid_acpi_name(*(u32 *)table_desc->
-							 pointer->
+				 acpi_ut_valid_acpi_name(table_desc->pointer->
 							 signature) ?
 				 table_desc->pointer->signature : "????",
 				 *(u32 *)table_desc->pointer->signature));
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 31a06a1..c53759b 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -462,7 +462,8 @@ u8 acpi_ut_valid_acpi_char(char character, u32 position)
  *
  * FUNCTION:    acpi_ut_valid_acpi_name
  *
- * PARAMETERS:  name            - The name to be examined
+ * PARAMETERS:  name            - The name to be examined. Does not have to
+ *                                be NULL terminated string.
  *
  * RETURN:      TRUE if the name is valid, FALSE otherwise
  *
@@ -473,15 +474,14 @@ u8 acpi_ut_valid_acpi_char(char character, u32 position)
  *
  ******************************************************************************/
 
-u8 acpi_ut_valid_acpi_name(u32 name)
+u8 acpi_ut_valid_acpi_name(char *name)
 {
 	u32 i;
 
 	ACPI_FUNCTION_ENTRY();
 
 	for (i = 0; i < ACPI_NAME_SIZE; i++) {
-		if (!acpi_ut_valid_acpi_char
-		    ((ACPI_CAST_PTR(char, &name))[i], i)) {
+		if (!acpi_ut_valid_acpi_char(name[i], i)) {
 			return (FALSE);
 		}
 	}
-- 
1.7.10

