From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 08/12] ACPICA: DT compiler: prevent error if optional field at the end of table is not present
Date: Wed,  3 Jan 2018 15:06:27 -0800
Message-ID: <20180103230631.15939-9-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43368 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeACXHn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:43 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

ACPICA commit a7f73af9003bf4e730db5a133300c01ba7992a01

The data table compiler throws under the following conditions:
1.) there is a table with a last field that is optional
2.) if the optional field is not present
3.) the optional field is the last line of the data table

A change was made to dt_compile_table to return an AE_EOF under these conditions.
This AE_EOF means that we are at the end of the file. The caller to dt_compile_table
is responsible for handling this case. For DBG2 table, we will complete the
compilation of this subtable. For other tables, this could be different.

Link: https://github.com/acpica/acpica/commit/a7f73af9
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acexcep.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index e1f9fe47f69e..3c46f0ef5f7a 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -130,8 +130,9 @@ struct acpi_exception_info {
 #define AE_HEX_OVERFLOW                 EXCEP_ENV (0x0020)
 #define AE_DECIMAL_OVERFLOW             EXCEP_ENV (0x0021)
 #define AE_OCTAL_OVERFLOW               EXCEP_ENV (0x0022)
+#define AE_END_OF_TABLE                 EXCEP_ENV (0x0023)
 
-#define AE_CODE_ENV_MAX                 0x0022
+#define AE_CODE_ENV_MAX                 0x0023
 
 /*
  * Programmer exceptions
@@ -275,7 +276,8 @@ static const struct acpi_exception_info acpi_gbl_exception_names_env[] = {
 	EXCEP_TXT("AE_DECIMAL_OVERFLOW",
 		  "Overflow during ASCII decimal-to-binary conversion"),
 	EXCEP_TXT("AE_OCTAL_OVERFLOW",
-		  "Overflow during ASCII octal-to-binary conversion")
+		  "Overflow during ASCII octal-to-binary conversion"),
+	EXCEP_TXT("AE_END_OF_TABLE", "Reached the end of table")
 };
 
 static const struct acpi_exception_info acpi_gbl_exception_names_pgm[] = {
-- 
2.14.3

