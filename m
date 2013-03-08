From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/21] ACPICA: Add macros to exception code definitions
Date: Fri,  8 Mar 2013 17:22:31 +0800
Message-ID: <8a9b76435214c4073e4a20de73d6de28b8561ab1.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6419 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJWn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:22:43 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Simplifies the definitions of new and existing codes.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acexcep.h |  192 ++++++++++++++++++++++++++----------------------
 1 file changed, 103 insertions(+), 89 deletions(-)

diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 9bf59d0..3e6b163 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -44,8 +44,10 @@
 #ifndef __ACEXCEP_H__
 #define __ACEXCEP_H__
 
+/* This module contains all possible exception codes for acpi_status */
+
 /*
- * Exceptions returned by external ACPI interfaces
+ * Exception code classes
  */
 #define AE_CODE_ENVIRONMENTAL           0x0000
 #define AE_CODE_PROGRAMMER              0x1000
@@ -55,6 +57,18 @@
 #define AE_CODE_MAX                     0x4000
 #define AE_CODE_MASK                    0xF000
 
+/*
+ * Macros to insert the exception code classes
+ */
+#define EXCEP_ENV(code)                 ((acpi_status) (code | AE_CODE_ENVIRONMENTAL))
+#define EXCEP_PGM(code)                 ((acpi_status) (code | AE_CODE_PROGRAMMER))
+#define EXCEP_TBL(code)                 ((acpi_status) (code | AE_CODE_ACPI_TABLES))
+#define EXCEP_AML(code)                 ((acpi_status) (code | AE_CODE_AML))
+#define EXCEP_CTL(code)                 ((acpi_status) (code | AE_CODE_CONTROL))
+
+/*
+ * Success is always zero, failure is non-zero
+ */
 #define ACPI_SUCCESS(a)                 (!(a))
 #define ACPI_FAILURE(a)                 (a)
 
@@ -64,60 +78,60 @@
 /*
  * Environmental exceptions
  */
-#define AE_ERROR                        (acpi_status) (0x0001 | AE_CODE_ENVIRONMENTAL)
-#define AE_NO_ACPI_TABLES               (acpi_status) (0x0002 | AE_CODE_ENVIRONMENTAL)
-#define AE_NO_NAMESPACE                 (acpi_status) (0x0003 | AE_CODE_ENVIRONMENTAL)
-#define AE_NO_MEMORY                    (acpi_status) (0x0004 | AE_CODE_ENVIRONMENTAL)
-#define AE_NOT_FOUND                    (acpi_status) (0x0005 | AE_CODE_ENVIRONMENTAL)
-#define AE_NOT_EXIST                    (acpi_status) (0x0006 | AE_CODE_ENVIRONMENTAL)
-#define AE_ALREADY_EXISTS               (acpi_status) (0x0007 | AE_CODE_ENVIRONMENTAL)
-#define AE_TYPE                         (acpi_status) (0x0008 | AE_CODE_ENVIRONMENTAL)
-#define AE_NULL_OBJECT                  (acpi_status) (0x0009 | AE_CODE_ENVIRONMENTAL)
-#define AE_NULL_ENTRY                   (acpi_status) (0x000A | AE_CODE_ENVIRONMENTAL)
-#define AE_BUFFER_OVERFLOW              (acpi_status) (0x000B | AE_CODE_ENVIRONMENTAL)
-#define AE_STACK_OVERFLOW               (acpi_status) (0x000C | AE_CODE_ENVIRONMENTAL)
-#define AE_STACK_UNDERFLOW              (acpi_status) (0x000D | AE_CODE_ENVIRONMENTAL)
-#define AE_NOT_IMPLEMENTED              (acpi_status) (0x000E | AE_CODE_ENVIRONMENTAL)
-#define AE_SUPPORT                      (acpi_status) (0x000F | AE_CODE_ENVIRONMENTAL)
-#define AE_LIMIT                        (acpi_status) (0x0010 | AE_CODE_ENVIRONMENTAL)
-#define AE_TIME                         (acpi_status) (0x0011 | AE_CODE_ENVIRONMENTAL)
-#define AE_ACQUIRE_DEADLOCK             (acpi_status) (0x0012 | AE_CODE_ENVIRONMENTAL)
-#define AE_RELEASE_DEADLOCK             (acpi_status) (0x0013 | AE_CODE_ENVIRONMENTAL)
-#define AE_NOT_ACQUIRED                 (acpi_status) (0x0014 | AE_CODE_ENVIRONMENTAL)
-#define AE_ALREADY_ACQUIRED             (acpi_status) (0x0015 | AE_CODE_ENVIRONMENTAL)
-#define AE_NO_HARDWARE_RESPONSE         (acpi_status) (0x0016 | AE_CODE_ENVIRONMENTAL)
-#define AE_NO_GLOBAL_LOCK               (acpi_status) (0x0017 | AE_CODE_ENVIRONMENTAL)
-#define AE_ABORT_METHOD                 (acpi_status) (0x0018 | AE_CODE_ENVIRONMENTAL)
-#define AE_SAME_HANDLER                 (acpi_status) (0x0019 | AE_CODE_ENVIRONMENTAL)
-#define AE_NO_HANDLER                   (acpi_status) (0x001A | AE_CODE_ENVIRONMENTAL)
-#define AE_OWNER_ID_LIMIT               (acpi_status) (0x001B | AE_CODE_ENVIRONMENTAL)
-#define AE_NOT_CONFIGURED               (acpi_status) (0x001C | AE_CODE_ENVIRONMENTAL)
+#define AE_ERROR                        EXCEP_ENV (0x0001)
+#define AE_NO_ACPI_TABLES               EXCEP_ENV (0x0002)
+#define AE_NO_NAMESPACE                 EXCEP_ENV (0x0003)
+#define AE_NO_MEMORY                    EXCEP_ENV (0x0004)
+#define AE_NOT_FOUND                    EXCEP_ENV (0x0005)
+#define AE_NOT_EXIST                    EXCEP_ENV (0x0006)
+#define AE_ALREADY_EXISTS               EXCEP_ENV (0x0007)
+#define AE_TYPE                         EXCEP_ENV (0x0008)
+#define AE_NULL_OBJECT                  EXCEP_ENV (0x0009)
+#define AE_NULL_ENTRY                   EXCEP_ENV (0x000A)
+#define AE_BUFFER_OVERFLOW              EXCEP_ENV (0x000B)
+#define AE_STACK_OVERFLOW               EXCEP_ENV (0x000C)
+#define AE_STACK_UNDERFLOW              EXCEP_ENV (0x000D)
+#define AE_NOT_IMPLEMENTED              EXCEP_ENV (0x000E)
+#define AE_SUPPORT                      EXCEP_ENV (0x000F)
+#define AE_LIMIT                        EXCEP_ENV (0x0010)
+#define AE_TIME                         EXCEP_ENV (0x0011)
+#define AE_ACQUIRE_DEADLOCK             EXCEP_ENV (0x0012)
+#define AE_RELEASE_DEADLOCK             EXCEP_ENV (0x0013)
+#define AE_NOT_ACQUIRED                 EXCEP_ENV (0x0014)
+#define AE_ALREADY_ACQUIRED             EXCEP_ENV (0x0015)
+#define AE_NO_HARDWARE_RESPONSE         EXCEP_ENV (0x0016)
+#define AE_NO_GLOBAL_LOCK               EXCEP_ENV (0x0017)
+#define AE_ABORT_METHOD                 EXCEP_ENV (0x0018)
+#define AE_SAME_HANDLER                 EXCEP_ENV (0x0019)
+#define AE_NO_HANDLER                   EXCEP_ENV (0x001A)
+#define AE_OWNER_ID_LIMIT               EXCEP_ENV (0x001B)
+#define AE_NOT_CONFIGURED               EXCEP_ENV (0x001C)
 
 #define AE_CODE_ENV_MAX                 0x001C
 
 /*
  * Programmer exceptions
  */
-#define AE_BAD_PARAMETER                (acpi_status) (0x0001 | AE_CODE_PROGRAMMER)
-#define AE_BAD_CHARACTER                (acpi_status) (0x0002 | AE_CODE_PROGRAMMER)
-#define AE_BAD_PATHNAME                 (acpi_status) (0x0003 | AE_CODE_PROGRAMMER)
-#define AE_BAD_DATA                     (acpi_status) (0x0004 | AE_CODE_PROGRAMMER)
-#define AE_BAD_HEX_CONSTANT             (acpi_status) (0x0005 | AE_CODE_PROGRAMMER)
-#define AE_BAD_OCTAL_CONSTANT           (acpi_status) (0x0006 | AE_CODE_PROGRAMMER)
-#define AE_BAD_DECIMAL_CONSTANT         (acpi_status) (0x0007 | AE_CODE_PROGRAMMER)
-#define AE_MISSING_ARGUMENTS            (acpi_status) (0x0008 | AE_CODE_PROGRAMMER)
-#define AE_BAD_ADDRESS                  (acpi_status) (0x0009 | AE_CODE_PROGRAMMER)
+#define AE_BAD_PARAMETER                EXCEP_PGM (0x0001)
+#define AE_BAD_CHARACTER                EXCEP_PGM (0x0002)
+#define AE_BAD_PATHNAME                 EXCEP_PGM (0x0003)
+#define AE_BAD_DATA                     EXCEP_PGM (0x0004)
+#define AE_BAD_HEX_CONSTANT             EXCEP_PGM (0x0005)
+#define AE_BAD_OCTAL_CONSTANT           EXCEP_PGM (0x0006)
+#define AE_BAD_DECIMAL_CONSTANT         EXCEP_PGM (0x0007)
+#define AE_MISSING_ARGUMENTS            EXCEP_PGM (0x0008)
+#define AE_BAD_ADDRESS                  EXCEP_PGM (0x0009)
 
 #define AE_CODE_PGM_MAX                 0x0009
 
 /*
  * Acpi table exceptions
  */
-#define AE_BAD_SIGNATURE                (acpi_status) (0x0001 | AE_CODE_ACPI_TABLES)
-#define AE_BAD_HEADER                   (acpi_status) (0x0002 | AE_CODE_ACPI_TABLES)
-#define AE_BAD_CHECKSUM                 (acpi_status) (0x0003 | AE_CODE_ACPI_TABLES)
-#define AE_BAD_VALUE                    (acpi_status) (0x0004 | AE_CODE_ACPI_TABLES)
-#define AE_INVALID_TABLE_LENGTH         (acpi_status) (0x0005 | AE_CODE_ACPI_TABLES)
+#define AE_BAD_SIGNATURE                EXCEP_TBL (0x0001)
+#define AE_BAD_HEADER                   EXCEP_TBL (0x0002)
+#define AE_BAD_CHECKSUM                 EXCEP_TBL (0x0003)
+#define AE_BAD_VALUE                    EXCEP_TBL (0x0004)
+#define AE_INVALID_TABLE_LENGTH         EXCEP_TBL (0x0005)
 
 #define AE_CODE_TBL_MAX                 0x0005
 
@@ -125,58 +139,58 @@
  * AML exceptions. These are caused by problems with
  * the actual AML byte stream
  */
-#define AE_AML_BAD_OPCODE               (acpi_status) (0x0001 | AE_CODE_AML)
-#define AE_AML_NO_OPERAND               (acpi_status) (0x0002 | AE_CODE_AML)
-#define AE_AML_OPERAND_TYPE             (acpi_status) (0x0003 | AE_CODE_AML)
-#define AE_AML_OPERAND_VALUE            (acpi_status) (0x0004 | AE_CODE_AML)
-#define AE_AML_UNINITIALIZED_LOCAL      (acpi_status) (0x0005 | AE_CODE_AML)
-#define AE_AML_UNINITIALIZED_ARG        (acpi_status) (0x0006 | AE_CODE_AML)
-#define AE_AML_UNINITIALIZED_ELEMENT    (acpi_status) (0x0007 | AE_CODE_AML)
-#define AE_AML_NUMERIC_OVERFLOW         (acpi_status) (0x0008 | AE_CODE_AML)
-#define AE_AML_REGION_LIMIT             (acpi_status) (0x0009 | AE_CODE_AML)
-#define AE_AML_BUFFER_LIMIT             (acpi_status) (0x000A | AE_CODE_AML)
-#define AE_AML_PACKAGE_LIMIT            (acpi_status) (0x000B | AE_CODE_AML)
-#define AE_AML_DIVIDE_BY_ZERO           (acpi_status) (0x000C | AE_CODE_AML)
-#define AE_AML_BAD_NAME                 (acpi_status) (0x000D | AE_CODE_AML)
-#define AE_AML_NAME_NOT_FOUND           (acpi_status) (0x000E | AE_CODE_AML)
-#define AE_AML_INTERNAL                 (acpi_status) (0x000F | AE_CODE_AML)
-#define AE_AML_INVALID_SPACE_ID         (acpi_status) (0x0010 | AE_CODE_AML)
-#define AE_AML_STRING_LIMIT             (acpi_status) (0x0011 | AE_CODE_AML)
-#define AE_AML_NO_RETURN_VALUE          (acpi_status) (0x0012 | AE_CODE_AML)
-#define AE_AML_METHOD_LIMIT             (acpi_status) (0x0013 | AE_CODE_AML)
-#define AE_AML_NOT_OWNER                (acpi_status) (0x0014 | AE_CODE_AML)
-#define AE_AML_MUTEX_ORDER              (acpi_status) (0x0015 | AE_CODE_AML)
-#define AE_AML_MUTEX_NOT_ACQUIRED       (acpi_status) (0x0016 | AE_CODE_AML)
-#define AE_AML_INVALID_RESOURCE_TYPE    (acpi_status) (0x0017 | AE_CODE_AML)
-#define AE_AML_INVALID_INDEX            (acpi_status) (0x0018 | AE_CODE_AML)
-#define AE_AML_REGISTER_LIMIT           (acpi_status) (0x0019 | AE_CODE_AML)
-#define AE_AML_NO_WHILE                 (acpi_status) (0x001A | AE_CODE_AML)
-#define AE_AML_ALIGNMENT                (acpi_status) (0x001B | AE_CODE_AML)
-#define AE_AML_NO_RESOURCE_END_TAG      (acpi_status) (0x001C | AE_CODE_AML)
-#define AE_AML_BAD_RESOURCE_VALUE       (acpi_status) (0x001D | AE_CODE_AML)
-#define AE_AML_CIRCULAR_REFERENCE       (acpi_status) (0x001E | AE_CODE_AML)
-#define AE_AML_BAD_RESOURCE_LENGTH      (acpi_status) (0x001F | AE_CODE_AML)
-#define AE_AML_ILLEGAL_ADDRESS          (acpi_status) (0x0020 | AE_CODE_AML)
-#define AE_AML_INFINITE_LOOP            (acpi_status) (0x0021 | AE_CODE_AML)
+#define AE_AML_BAD_OPCODE               EXCEP_AML (0x0001)
+#define AE_AML_NO_OPERAND               EXCEP_AML (0x0002)
+#define AE_AML_OPERAND_TYPE             EXCEP_AML (0x0003)
+#define AE_AML_OPERAND_VALUE            EXCEP_AML (0x0004)
+#define AE_AML_UNINITIALIZED_LOCAL      EXCEP_AML (0x0005)
+#define AE_AML_UNINITIALIZED_ARG        EXCEP_AML (0x0006)
+#define AE_AML_UNINITIALIZED_ELEMENT    EXCEP_AML (0x0007)
+#define AE_AML_NUMERIC_OVERFLOW         EXCEP_AML (0x0008)
+#define AE_AML_REGION_LIMIT             EXCEP_AML (0x0009)
+#define AE_AML_BUFFER_LIMIT             EXCEP_AML (0x000A)
+#define AE_AML_PACKAGE_LIMIT            EXCEP_AML (0x000B)
+#define AE_AML_DIVIDE_BY_ZERO           EXCEP_AML (0x000C)
+#define AE_AML_BAD_NAME                 EXCEP_AML (0x000D)
+#define AE_AML_NAME_NOT_FOUND           EXCEP_AML (0x000E)
+#define AE_AML_INTERNAL                 EXCEP_AML (0x000F)
+#define AE_AML_INVALID_SPACE_ID         EXCEP_AML (0x0010)
+#define AE_AML_STRING_LIMIT             EXCEP_AML (0x0011)
+#define AE_AML_NO_RETURN_VALUE          EXCEP_AML (0x0012)
+#define AE_AML_METHOD_LIMIT             EXCEP_AML (0x0013)
+#define AE_AML_NOT_OWNER                EXCEP_AML (0x0014)
+#define AE_AML_MUTEX_ORDER              EXCEP_AML (0x0015)
+#define AE_AML_MUTEX_NOT_ACQUIRED       EXCEP_AML (0x0016)
+#define AE_AML_INVALID_RESOURCE_TYPE    EXCEP_AML (0x0017)
+#define AE_AML_INVALID_INDEX            EXCEP_AML (0x0018)
+#define AE_AML_REGISTER_LIMIT           EXCEP_AML (0x0019)
+#define AE_AML_NO_WHILE                 EXCEP_AML (0x001A)
+#define AE_AML_ALIGNMENT                EXCEP_AML (0x001B)
+#define AE_AML_NO_RESOURCE_END_TAG      EXCEP_AML (0x001C)
+#define AE_AML_BAD_RESOURCE_VALUE       EXCEP_AML (0x001D)
+#define AE_AML_CIRCULAR_REFERENCE       EXCEP_AML (0x001E)
+#define AE_AML_BAD_RESOURCE_LENGTH      EXCEP_AML (0x001F)
+#define AE_AML_ILLEGAL_ADDRESS          EXCEP_AML (0x0020)
+#define AE_AML_INFINITE_LOOP            EXCEP_AML (0x0021)
 
 #define AE_CODE_AML_MAX                 0x0021
 
 /*
  * Internal exceptions used for control
  */
-#define AE_CTRL_RETURN_VALUE            (acpi_status) (0x0001 | AE_CODE_CONTROL)
-#define AE_CTRL_PENDING                 (acpi_status) (0x0002 | AE_CODE_CONTROL)
-#define AE_CTRL_TERMINATE               (acpi_status) (0x0003 | AE_CODE_CONTROL)
-#define AE_CTRL_TRUE                    (acpi_status) (0x0004 | AE_CODE_CONTROL)
-#define AE_CTRL_FALSE                   (acpi_status) (0x0005 | AE_CODE_CONTROL)
-#define AE_CTRL_DEPTH                   (acpi_status) (0x0006 | AE_CODE_CONTROL)
-#define AE_CTRL_END                     (acpi_status) (0x0007 | AE_CODE_CONTROL)
-#define AE_CTRL_TRANSFER                (acpi_status) (0x0008 | AE_CODE_CONTROL)
-#define AE_CTRL_BREAK                   (acpi_status) (0x0009 | AE_CODE_CONTROL)
-#define AE_CTRL_CONTINUE                (acpi_status) (0x000A | AE_CODE_CONTROL)
-#define AE_CTRL_SKIP                    (acpi_status) (0x000B | AE_CODE_CONTROL)
-#define AE_CTRL_PARSE_CONTINUE          (acpi_status) (0x000C | AE_CODE_CONTROL)
-#define AE_CTRL_PARSE_PENDING           (acpi_status) (0x000D | AE_CODE_CONTROL)
+#define AE_CTRL_RETURN_VALUE            EXCEP_CTL (0x0001)
+#define AE_CTRL_PENDING                 EXCEP_CTL (0x0002)
+#define AE_CTRL_TERMINATE               EXCEP_CTL (0x0003)
+#define AE_CTRL_TRUE                    EXCEP_CTL (0x0004)
+#define AE_CTRL_FALSE                   EXCEP_CTL (0x0005)
+#define AE_CTRL_DEPTH                   EXCEP_CTL (0x0006)
+#define AE_CTRL_END                     EXCEP_CTL (0x0007)
+#define AE_CTRL_TRANSFER                EXCEP_CTL (0x0008)
+#define AE_CTRL_BREAK                   EXCEP_CTL (0x0009)
+#define AE_CTRL_CONTINUE                EXCEP_CTL (0x000A)
+#define AE_CTRL_SKIP                    EXCEP_CTL (0x000B)
+#define AE_CTRL_PARSE_CONTINUE          EXCEP_CTL (0x000C)
+#define AE_CTRL_PARSE_PENDING           EXCEP_CTL (0x000D)
 
 #define AE_CODE_CTRL_MAX                0x000D
 
-- 
1.7.10

