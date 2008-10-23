From: Len Brown <lenb@kernel.org>
Subject: [PATCH 101/122] ACPICA: Remove obsolete exception codes
Date: Thu, 23 Oct 2008 02:39:15 -0400
Message-ID: <65f4692c5220330e1ea044796c4cfa603e349c84.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbYJWGoP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:15 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:12 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed 10 exception codes (and corresponding name strings)
that were obsolete for various reasons.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acexcep.h |  128 ++++++++++++++++++++---------------------------
 1 files changed, 55 insertions(+), 73 deletions(-)

diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index e5a890f..84f5cb2 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -76,25 +76,21 @@
 #define AE_STACK_OVERFLOW               (acpi_status) (0x000C | AE_CODE_ENVIRONMENTAL)
 #define AE_STACK_UNDERFLOW              (acpi_status) (0x000D | AE_CODE_ENVIRONMENTAL)
 #define AE_NOT_IMPLEMENTED              (acpi_status) (0x000E | AE_CODE_ENVIRONMENTAL)
-#define AE_VERSION_MISMATCH             (acpi_status) (0x000F | AE_CODE_ENVIRONMENTAL)
-#define AE_SUPPORT                      (acpi_status) (0x0010 | AE_CODE_ENVIRONMENTAL)
-#define AE_SHARE                        (acpi_status) (0x0011 | AE_CODE_ENVIRONMENTAL)
-#define AE_LIMIT                        (acpi_status) (0x0012 | AE_CODE_ENVIRONMENTAL)
-#define AE_TIME                         (acpi_status) (0x0013 | AE_CODE_ENVIRONMENTAL)
-#define AE_UNKNOWN_STATUS               (acpi_status) (0x0014 | AE_CODE_ENVIRONMENTAL)
-#define AE_ACQUIRE_DEADLOCK             (acpi_status) (0x0015 | AE_CODE_ENVIRONMENTAL)
-#define AE_RELEASE_DEADLOCK             (acpi_status) (0x0016 | AE_CODE_ENVIRONMENTAL)
-#define AE_NOT_ACQUIRED                 (acpi_status) (0x0017 | AE_CODE_ENVIRONMENTAL)
-#define AE_ALREADY_ACQUIRED             (acpi_status) (0x0018 | AE_CODE_ENVIRONMENTAL)
-#define AE_NO_HARDWARE_RESPONSE         (acpi_status) (0x0019 | AE_CODE_ENVIRONMENTAL)
-#define AE_NO_GLOBAL_LOCK               (acpi_status) (0x001A | AE_CODE_ENVIRONMENTAL)
-#define AE_LOGICAL_ADDRESS              (acpi_status) (0x001B | AE_CODE_ENVIRONMENTAL)
-#define AE_ABORT_METHOD                 (acpi_status) (0x001C | AE_CODE_ENVIRONMENTAL)
-#define AE_SAME_HANDLER                 (acpi_status) (0x001D | AE_CODE_ENVIRONMENTAL)
-#define AE_WAKE_ONLY_GPE                (acpi_status) (0x001E | AE_CODE_ENVIRONMENTAL)
-#define AE_OWNER_ID_LIMIT               (acpi_status) (0x001F | AE_CODE_ENVIRONMENTAL)
+#define AE_SUPPORT                      (acpi_status) (0x000F | AE_CODE_ENVIRONMENTAL)
+#define AE_LIMIT                        (acpi_status) (0x0010 | AE_CODE_ENVIRONMENTAL)
+#define AE_TIME                         (acpi_status) (0x0011 | AE_CODE_ENVIRONMENTAL)
+#define AE_ACQUIRE_DEADLOCK             (acpi_status) (0x0012 | AE_CODE_ENVIRONMENTAL)
+#define AE_RELEASE_DEADLOCK             (acpi_status) (0x0013 | AE_CODE_ENVIRONMENTAL)
+#define AE_NOT_ACQUIRED                 (acpi_status) (0x0014 | AE_CODE_ENVIRONMENTAL)
+#define AE_ALREADY_ACQUIRED             (acpi_status) (0x0015 | AE_CODE_ENVIRONMENTAL)
+#define AE_NO_HARDWARE_RESPONSE         (acpi_status) (0x0016 | AE_CODE_ENVIRONMENTAL)
+#define AE_NO_GLOBAL_LOCK               (acpi_status) (0x0017 | AE_CODE_ENVIRONMENTAL)
+#define AE_ABORT_METHOD                 (acpi_status) (0x0018 | AE_CODE_ENVIRONMENTAL)
+#define AE_SAME_HANDLER                 (acpi_status) (0x0019 | AE_CODE_ENVIRONMENTAL)
+#define AE_WAKE_ONLY_GPE                (acpi_status) (0x001A | AE_CODE_ENVIRONMENTAL)
+#define AE_OWNER_ID_LIMIT               (acpi_status) (0x001B | AE_CODE_ENVIRONMENTAL)
 
-#define AE_CODE_ENV_MAX                 0x001F
+#define AE_CODE_ENV_MAX                 0x001B
 
 /*
  * Programmer exceptions
@@ -103,14 +99,12 @@
 #define AE_BAD_CHARACTER                (acpi_status) (0x0002 | AE_CODE_PROGRAMMER)
 #define AE_BAD_PATHNAME                 (acpi_status) (0x0003 | AE_CODE_PROGRAMMER)
 #define AE_BAD_DATA                     (acpi_status) (0x0004 | AE_CODE_PROGRAMMER)
-#define AE_BAD_ADDRESS                  (acpi_status) (0x0005 | AE_CODE_PROGRAMMER)
-#define AE_ALIGNMENT                    (acpi_status) (0x0006 | AE_CODE_PROGRAMMER)
-#define AE_BAD_HEX_CONSTANT             (acpi_status) (0x0007 | AE_CODE_PROGRAMMER)
-#define AE_BAD_OCTAL_CONSTANT           (acpi_status) (0x0008 | AE_CODE_PROGRAMMER)
-#define AE_BAD_DECIMAL_CONSTANT         (acpi_status) (0x0009 | AE_CODE_PROGRAMMER)
-#define AE_MISSING_ARGUMENTS		(acpi_status) (0x000A | AE_CODE_PROGRAMMER)
+#define AE_BAD_HEX_CONSTANT             (acpi_status) (0x0005 | AE_CODE_PROGRAMMER)
+#define AE_BAD_OCTAL_CONSTANT           (acpi_status) (0x0006 | AE_CODE_PROGRAMMER)
+#define AE_BAD_DECIMAL_CONSTANT         (acpi_status) (0x0007 | AE_CODE_PROGRAMMER)
+#define AE_MISSING_ARGUMENTS            (acpi_status) (0x0008 | AE_CODE_PROGRAMMER)
 
-#define AE_CODE_PGM_MAX 		0x000A
+#define AE_CODE_PGM_MAX                 0x0008
 
 /*
  * Acpi table exceptions
@@ -119,51 +113,48 @@
 #define AE_BAD_HEADER                   (acpi_status) (0x0002 | AE_CODE_ACPI_TABLES)
 #define AE_BAD_CHECKSUM                 (acpi_status) (0x0003 | AE_CODE_ACPI_TABLES)
 #define AE_BAD_VALUE                    (acpi_status) (0x0004 | AE_CODE_ACPI_TABLES)
-#define AE_TABLE_NOT_SUPPORTED          (acpi_status) (0x0005 | AE_CODE_ACPI_TABLES)
-#define AE_INVALID_TABLE_LENGTH         (acpi_status) (0x0006 | AE_CODE_ACPI_TABLES)
+#define AE_INVALID_TABLE_LENGTH         (acpi_status) (0x0005 | AE_CODE_ACPI_TABLES)
 
-#define AE_CODE_TBL_MAX                 0x0006
+#define AE_CODE_TBL_MAX                 0x0005
 
 /*
  * AML exceptions.  These are caused by problems with
  * the actual AML byte stream
  */
-#define AE_AML_ERROR                    (acpi_status) (0x0001 | AE_CODE_AML)
-#define AE_AML_PARSE                    (acpi_status) (0x0002 | AE_CODE_AML)
-#define AE_AML_BAD_OPCODE               (acpi_status) (0x0003 | AE_CODE_AML)
-#define AE_AML_NO_OPERAND               (acpi_status) (0x0004 | AE_CODE_AML)
-#define AE_AML_OPERAND_TYPE             (acpi_status) (0x0005 | AE_CODE_AML)
-#define AE_AML_OPERAND_VALUE            (acpi_status) (0x0006 | AE_CODE_AML)
-#define AE_AML_UNINITIALIZED_LOCAL      (acpi_status) (0x0007 | AE_CODE_AML)
-#define AE_AML_UNINITIALIZED_ARG        (acpi_status) (0x0008 | AE_CODE_AML)
-#define AE_AML_UNINITIALIZED_ELEMENT    (acpi_status) (0x0009 | AE_CODE_AML)
-#define AE_AML_NUMERIC_OVERFLOW         (acpi_status) (0x000A | AE_CODE_AML)
-#define AE_AML_REGION_LIMIT             (acpi_status) (0x000B | AE_CODE_AML)
-#define AE_AML_BUFFER_LIMIT             (acpi_status) (0x000C | AE_CODE_AML)
-#define AE_AML_PACKAGE_LIMIT            (acpi_status) (0x000D | AE_CODE_AML)
-#define AE_AML_DIVIDE_BY_ZERO           (acpi_status) (0x000E | AE_CODE_AML)
-#define AE_AML_BAD_NAME                 (acpi_status) (0x000F | AE_CODE_AML)
-#define AE_AML_NAME_NOT_FOUND           (acpi_status) (0x0010 | AE_CODE_AML)
-#define AE_AML_INTERNAL                 (acpi_status) (0x0011 | AE_CODE_AML)
-#define AE_AML_INVALID_SPACE_ID         (acpi_status) (0x0012 | AE_CODE_AML)
-#define AE_AML_STRING_LIMIT             (acpi_status) (0x0013 | AE_CODE_AML)
-#define AE_AML_NO_RETURN_VALUE          (acpi_status) (0x0014 | AE_CODE_AML)
-#define AE_AML_METHOD_LIMIT             (acpi_status) (0x0015 | AE_CODE_AML)
-#define AE_AML_NOT_OWNER                (acpi_status) (0x0016 | AE_CODE_AML)
-#define AE_AML_MUTEX_ORDER              (acpi_status) (0x0017 | AE_CODE_AML)
-#define AE_AML_MUTEX_NOT_ACQUIRED       (acpi_status) (0x0018 | AE_CODE_AML)
-#define AE_AML_INVALID_RESOURCE_TYPE    (acpi_status) (0x0019 | AE_CODE_AML)
-#define AE_AML_INVALID_INDEX            (acpi_status) (0x001A | AE_CODE_AML)
-#define AE_AML_REGISTER_LIMIT           (acpi_status) (0x001B | AE_CODE_AML)
-#define AE_AML_NO_WHILE                 (acpi_status) (0x001C | AE_CODE_AML)
-#define AE_AML_ALIGNMENT                (acpi_status) (0x001D | AE_CODE_AML)
-#define AE_AML_NO_RESOURCE_END_TAG      (acpi_status) (0x001E | AE_CODE_AML)
-#define AE_AML_BAD_RESOURCE_VALUE       (acpi_status) (0x001F | AE_CODE_AML)
-#define AE_AML_CIRCULAR_REFERENCE       (acpi_status) (0x0020 | AE_CODE_AML)
-#define AE_AML_BAD_RESOURCE_LENGTH      (acpi_status) (0x0021 | AE_CODE_AML)
-#define AE_AML_ILLEGAL_ADDRESS          (acpi_status) (0x0022 | AE_CODE_AML)
+#define AE_AML_BAD_OPCODE               (acpi_status) (0x0001 | AE_CODE_AML)
+#define AE_AML_NO_OPERAND               (acpi_status) (0x0002 | AE_CODE_AML)
+#define AE_AML_OPERAND_TYPE             (acpi_status) (0x0003 | AE_CODE_AML)
+#define AE_AML_OPERAND_VALUE            (acpi_status) (0x0004 | AE_CODE_AML)
+#define AE_AML_UNINITIALIZED_LOCAL      (acpi_status) (0x0005 | AE_CODE_AML)
+#define AE_AML_UNINITIALIZED_ARG        (acpi_status) (0x0006 | AE_CODE_AML)
+#define AE_AML_UNINITIALIZED_ELEMENT    (acpi_status) (0x0007 | AE_CODE_AML)
+#define AE_AML_NUMERIC_OVERFLOW         (acpi_status) (0x0008 | AE_CODE_AML)
+#define AE_AML_REGION_LIMIT             (acpi_status) (0x0009 | AE_CODE_AML)
+#define AE_AML_BUFFER_LIMIT             (acpi_status) (0x000A | AE_CODE_AML)
+#define AE_AML_PACKAGE_LIMIT            (acpi_status) (0x000B | AE_CODE_AML)
+#define AE_AML_DIVIDE_BY_ZERO           (acpi_status) (0x000C | AE_CODE_AML)
+#define AE_AML_BAD_NAME                 (acpi_status) (0x000D | AE_CODE_AML)
+#define AE_AML_NAME_NOT_FOUND           (acpi_status) (0x000E | AE_CODE_AML)
+#define AE_AML_INTERNAL                 (acpi_status) (0x000F | AE_CODE_AML)
+#define AE_AML_INVALID_SPACE_ID         (acpi_status) (0x0010 | AE_CODE_AML)
+#define AE_AML_STRING_LIMIT             (acpi_status) (0x0011 | AE_CODE_AML)
+#define AE_AML_NO_RETURN_VALUE          (acpi_status) (0x0012 | AE_CODE_AML)
+#define AE_AML_METHOD_LIMIT             (acpi_status) (0x0013 | AE_CODE_AML)
+#define AE_AML_NOT_OWNER                (acpi_status) (0x0014 | AE_CODE_AML)
+#define AE_AML_MUTEX_ORDER              (acpi_status) (0x0015 | AE_CODE_AML)
+#define AE_AML_MUTEX_NOT_ACQUIRED       (acpi_status) (0x0016 | AE_CODE_AML)
+#define AE_AML_INVALID_RESOURCE_TYPE    (acpi_status) (0x0017 | AE_CODE_AML)
+#define AE_AML_INVALID_INDEX            (acpi_status) (0x0018 | AE_CODE_AML)
+#define AE_AML_REGISTER_LIMIT           (acpi_status) (0x0019 | AE_CODE_AML)
+#define AE_AML_NO_WHILE                 (acpi_status) (0x001A | AE_CODE_AML)
+#define AE_AML_ALIGNMENT                (acpi_status) (0x001B | AE_CODE_AML)
+#define AE_AML_NO_RESOURCE_END_TAG      (acpi_status) (0x001C | AE_CODE_AML)
+#define AE_AML_BAD_RESOURCE_VALUE       (acpi_status) (0x001D | AE_CODE_AML)
+#define AE_AML_CIRCULAR_REFERENCE       (acpi_status) (0x001E | AE_CODE_AML)
+#define AE_AML_BAD_RESOURCE_LENGTH      (acpi_status) (0x001F | AE_CODE_AML)
+#define AE_AML_ILLEGAL_ADDRESS          (acpi_status) (0x0020 | AE_CODE_AML)
 
-#define AE_CODE_AML_MAX                 0x0022
+#define AE_CODE_AML_MAX                 0x0020
 
 /*
  * Internal exceptions used for control
@@ -206,19 +197,15 @@ char const *acpi_gbl_exception_names_env[] = {
 	"AE_STACK_OVERFLOW",
 	"AE_STACK_UNDERFLOW",
 	"AE_NOT_IMPLEMENTED",
-	"AE_VERSION_MISMATCH",
 	"AE_SUPPORT",
-	"AE_SHARE",
 	"AE_LIMIT",
 	"AE_TIME",
-	"AE_UNKNOWN_STATUS",
 	"AE_ACQUIRE_DEADLOCK",
 	"AE_RELEASE_DEADLOCK",
 	"AE_NOT_ACQUIRED",
 	"AE_ALREADY_ACQUIRED",
 	"AE_NO_HARDWARE_RESPONSE",
 	"AE_NO_GLOBAL_LOCK",
-	"AE_LOGICAL_ADDRESS",
 	"AE_ABORT_METHOD",
 	"AE_SAME_HANDLER",
 	"AE_WAKE_ONLY_GPE",
@@ -231,8 +218,6 @@ char const *acpi_gbl_exception_names_pgm[] = {
 	"AE_BAD_CHARACTER",
 	"AE_BAD_PATHNAME",
 	"AE_BAD_DATA",
-	"AE_BAD_ADDRESS",
-	"AE_ALIGNMENT",
 	"AE_BAD_HEX_CONSTANT",
 	"AE_BAD_OCTAL_CONSTANT",
 	"AE_BAD_DECIMAL_CONSTANT",
@@ -245,14 +230,11 @@ char const *acpi_gbl_exception_names_tbl[] = {
 	"AE_BAD_HEADER",
 	"AE_BAD_CHECKSUM",
 	"AE_BAD_VALUE",
-	"AE_TABLE_NOT_SUPPORTED",
 	"AE_INVALID_TABLE_LENGTH"
 };
 
 char const *acpi_gbl_exception_names_aml[] = {
 	NULL,
-	"AE_AML_ERROR",
-	"AE_AML_PARSE",
 	"AE_AML_BAD_OPCODE",
 	"AE_AML_NO_OPERAND",
 	"AE_AML_OPERAND_TYPE",
@@ -284,7 +266,7 @@ char const *acpi_gbl_exception_names_aml[] = {
 	"AE_AML_BAD_RESOURCE_VALUE",
 	"AE_AML_CIRCULAR_REFERENCE",
 	"AE_AML_BAD_RESOURCE_LENGTH",
-	"AE_AML_ILLEGAL_ADDRESS"
+	"AE_AML_ILLEGAL_ADDRESS",
 };
 
 char const *acpi_gbl_exception_names_ctrl[] = {
-- 
1.5.5.1

