From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/20] ACPICA: Add safe versions of common string functions.
Date: Tue, 29 Oct 2013 09:29:21 +0800
Message-ID: <c3764f75043c8a31eb3cca5c38a2c05543cc6adc.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13323 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757171Ab3J2B3d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:33 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This change adds and deploys "safe" versions of strcpy and strcat that
ensure that the target buffer does not overflow. These safe functions
are only helpful for processing user input and command lines. For most
ACPICA code however, the required buffer length is precisely calculated
before buffer allocation, so the use of these functions is unnecessary.
ACPICA BZ 1043.

This change only applies to the ACPICA utilities and the debugger
implementation, both of them are not shipped in the kernel yet.  So no
kernel behavior is changed by this commit.

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1043
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h  |    2 +-
 drivers/acpi/acpica/acutils.h  |   11 +++++++
 drivers/acpi/acpica/utstring.c |   62 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index dafa0f6..53ed1a8 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1072,7 +1072,7 @@ struct acpi_db_method_info {
 	char *name;
 	u32 flags;
 	u32 num_loops;
-	char pathname[128];
+	char pathname[ACPI_DB_LINE_BUFFER_SIZE];
 	char **args;
 	acpi_object_type *types;
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index d5a62a6..4f25e8f 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -628,6 +628,17 @@ u8 acpi_ut_valid_acpi_char(char character, u32 position);
 
 void acpi_ut_repair_name(char *name);
 
+#if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION)
+u8 acpi_ut_safe_strcpy(char *dest, acpi_size dest_size, char *source);
+
+u8 acpi_ut_safe_strcat(char *dest, acpi_size dest_size, char *source);
+
+u8
+acpi_ut_safe_strncat(char *dest,
+		     acpi_size dest_size,
+		     char *source, acpi_size max_transfer_length);
+#endif
+
 /*
  * utmutex - mutex support
  */
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index cb1e9cc..5ef41ff 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -584,3 +584,65 @@ void ut_convert_backslashes(char *pathname)
 	}
 }
 #endif
+
+#if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_safe_strcpy, acpi_ut_safe_strcat, acpi_ut_safe_strncat
+ *
+ * PARAMETERS:  Adds a "DestSize" parameter to each of the standard string
+ *              functions. This is the size of the Destination buffer.
+ *
+ * RETURN:      TRUE if the operation would overflow the destination buffer.
+ *
+ * DESCRIPTION: Safe versions of standard Clib string functions. Ensure that
+ *              the result of the operation will not overflow the output string
+ *              buffer.
+ *
+ * NOTE:        These functions are typically only helpful for processing
+ *              user input and command lines. For most ACPICA code, the
+ *              required buffer length is precisely calculated before buffer
+ *              allocation, so the use of these functions is unnecessary.
+ *
+ ******************************************************************************/
+
+u8 acpi_ut_safe_strcpy(char *dest, acpi_size dest_size, char *source)
+{
+
+	if (ACPI_STRLEN(source) >= dest_size) {
+		return (TRUE);
+	}
+
+	ACPI_STRCPY(dest, source);
+	return (FALSE);
+}
+
+u8 acpi_ut_safe_strcat(char *dest, acpi_size dest_size, char *source)
+{
+
+	if ((ACPI_STRLEN(dest) + ACPI_STRLEN(source)) >= dest_size) {
+		return (TRUE);
+	}
+
+	ACPI_STRCAT(dest, source);
+	return (FALSE);
+}
+
+u8
+acpi_ut_safe_strncat(char *dest,
+		     acpi_size dest_size,
+		     char *source, acpi_size max_transfer_length)
+{
+	acpi_size actual_transfer_length;
+
+	actual_transfer_length =
+	    ACPI_MIN(max_transfer_length, ACPI_STRLEN(source));
+
+	if ((ACPI_STRLEN(dest) + actual_transfer_length) >= dest_size) {
+		return (TRUE);
+	}
+
+	ACPI_STRNCAT(dest, source, max_transfer_length);
+	return (FALSE);
+}
+#endif
-- 
1.7.10

