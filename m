From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/65] ACPICA: Update error/warning interfaces
Date: Fri, 29 May 2009 21:41:46 -0400
Message-ID: <b74be6119e9e38390395f08767b7c84de9023b38.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:39590 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756751AbZE3BnB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:01 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00FW8ORDTV13@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:50 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Moved the module name and line number to the end of the message.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utmisc.c |   20 +++++++++-----------
 include/acpi/acpixf.h        |    5 ++++-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 1c9e250..fbe7823 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -1033,11 +1033,12 @@ acpi_error(const char *module_name, u32 line_number, const char *format, ...)
 {
 	va_list args;
 
-	acpi_os_printf("ACPI Error (%s-%04d): ", module_name, line_number);
+	acpi_os_printf("ACPI Error: ");
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
-	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
+	acpi_os_printf(" %8.8X %s-%u\n", ACPI_CA_VERSION, module_name,
+		       line_number);
 	va_end(args);
 }
 
@@ -1047,12 +1048,12 @@ acpi_exception(const char *module_name,
 {
 	va_list args;
 
-	acpi_os_printf("ACPI Exception (%s-%04d): %s, ", module_name,
-		       line_number, acpi_format_exception(status));
+	acpi_os_printf("ACPI Exception: %s, ", acpi_format_exception(status));
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
-	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
+	acpi_os_printf(" %8.8X %s-%u\n", ACPI_CA_VERSION, module_name,
+		       line_number);
 	va_end(args);
 }
 
@@ -1061,11 +1062,12 @@ acpi_warning(const char *module_name, u32 line_number, const char *format, ...)
 {
 	va_list args;
 
-	acpi_os_printf("ACPI Warning (%s-%04d): ", module_name, line_number);
+	acpi_os_printf("ACPI Warning: ");
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
-	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
+	acpi_os_printf(" %8.8X %s-%u\n", ACPI_CA_VERSION, module_name,
+		       line_number);
 	va_end(args);
 }
 
@@ -1074,10 +1076,6 @@ acpi_info(const char *module_name, u32 line_number, const char *format, ...)
 {
 	va_list args;
 
-	/*
-	 * Removed module_name, line_number, and acpica version, not needed
-	 * for info output
-	 */
 	acpi_os_printf("ACPI: ");
 
 	va_start(args, format);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 4db89e9..a868df6 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -375,7 +375,7 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state);
 acpi_status acpi_leave_sleep_state(u8 sleep_state);
 
 /*
- * Debug output
+ * Error/Warning output
  */
 void ACPI_INTERNAL_VAR_XFACE
 acpi_error(const char *module_name,
@@ -394,6 +394,9 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_info(const char *module_name,
 	  u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE(3);
 
+/*
+ * Debug output
+ */
 #ifdef ACPI_DEBUG_OUTPUT
 
 void ACPI_INTERNAL_VAR_XFACE
-- 
1.6.0.6

