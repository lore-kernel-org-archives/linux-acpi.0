From: Len Brown <lenb@kernel.org>
Subject: [PATCH 56/73] ACPICA: Add va_end statements as appropriate
Date: Sat, 12 Apr 2008 00:25:39 -0400
Message-ID: <a1a3919958b5ff2ff839cd86c55a29aea37c162c.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:60403 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752095AbYDLE2M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:12 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added missing va_end statements that should correspond with each
va_start statement.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utdebug.c |    2 ++
 drivers/acpi/utilities/utmisc.c  |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index 2d6a78f..8014442 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -201,6 +201,7 @@ acpi_ut_debug_print(u32 requested_debug_level,
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
+	va_end(args);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_debug_print)
@@ -238,6 +239,7 @@ acpi_ut_debug_print_raw(u32 requested_debug_level,
 
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
+	va_end(args);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_debug_print_raw)
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 2d19f71..2f48fd6 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -1033,6 +1033,7 @@ acpi_ut_error(char *module_name, u32 line_number, char *format, ...)
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
+	va_end(args);
 }
 
 void ACPI_INTERNAL_VAR_XFACE
@@ -1061,6 +1062,8 @@ acpi_ut_warning(char *module_name, u32 line_number, char *format, ...)
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
+	va_end(args);
+	va_end(args);
 }
 
 void ACPI_INTERNAL_VAR_XFACE
@@ -1077,4 +1080,5 @@ acpi_ut_info(char *module_name, u32 line_number, char *format, ...)
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
 	acpi_os_printf("\n");
+	va_end(args);
 }
-- 
1.5.5.29.g7134

