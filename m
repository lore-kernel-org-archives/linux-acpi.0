From: Richard Knutsson <ricknu-0@student.ltu.se>
Subject: [PATCH] utilities/: Compliment va_start() with va_end().
Date: Sat, 24 Nov 2007 21:43:59 +0100 (MET)
Message-ID: <20071124203227.6370.5923.sendpatchset@thinktank.campus.ltu.se>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:49791 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbXKXUoF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Nov 2007 15:44:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Knutsson <ricknu-0@student.ltu.se>

Compliment va_start() with va_end().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
Compile-tested on i386 with allyesconfig & allmodconfig.

 utdebug.c |    2 ++
 utmisc.c  |    4 ++++
 2 files changed, 6 insertions(+)


diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index c7e128e..f45e3d5 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -203,6 +203,7 @@ acpi_ut_debug_print(u32 requested_debug_level,
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
+	va_end(args);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_debug_print)
@@ -240,6 +241,7 @@ acpi_ut_debug_print_raw(u32 requested_debug_level,
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
+	va_end(args);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_debug_print_raw)
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 2d19f71..ca4904c 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -1032,6 +1032,7 @@ acpi_ut_error(char *module_name, u32 line_number, char *format, ...)
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
+	va_end(args);
 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
 }
 
@@ -1046,6 +1047,7 @@ acpi_ut_exception(char *module_name,
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
+	va_end(args);
 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
 }
 
@@ -1060,6 +1062,7 @@ acpi_ut_warning(char *module_name, u32 line_number, char *format, ...)
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
+	va_end(args);
 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
 }
 
@@ -1076,5 +1079,6 @@ acpi_ut_info(char *module_name, u32 line_number, char *format, ...)
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
+	va_end(args);
 	acpi_os_printf("\n");
 }
