From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPICA: Log Exceptions and Errors as warning while loading extra tables
Date: Wed,  1 Mar 2017 11:36:53 +0100
Message-ID: <20170301103653.2296-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752147AbdCAKzU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Mar 2017 05:55:20 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, devel@acpica.org

Honor the "Ignore errors while loading tables, get as many as possible"
comment in the tbxfload.c code and log any exceptions and errors during
loading extra tables as warnings.

This is important because many desktop and embedded applicance Linux
use-cases have a hard requirement of not showing any (scary) text
messages during system bootup, which get broken by errors reported
by attempts to load the extra tables, as messaged logged at a KERN_ERR
level are always shown even if the quiet kernel cmdline option is used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/acglobal.h  |  1 +
 drivers/acpi/acpica/tbxfload.c  |  4 +++-
 drivers/acpi/acpica/uterror.c   | 10 ++++++++--
 drivers/acpi/acpica/utxferror.c | 19 ++++++++++---------
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index edbb42e..5ae9eee 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -146,6 +146,7 @@ ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_operand_cache);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_startup_flags, 0);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_shutdown, TRUE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_early_initialization, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_log_errors_exceptions_as_warnings, FALSE);
 
 /* Global handlers */
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 1971cd7..b0c5478 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -256,6 +256,7 @@ acpi_status acpi_tb_load_namespace(void)
 		}
 
 		/* Ignore errors while loading tables, get as many as possible */
+		acpi_gbl_log_errors_exceptions_as_warnings = TRUE;
 
 		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 		status = acpi_ns_load_table(i, acpi_gbl_root_node);
@@ -276,11 +277,12 @@ acpi_status acpi_tb_load_namespace(void)
 			tables_loaded++;
 		}
 	}
+	acpi_gbl_log_errors_exceptions_as_warnings = FALSE;
 
 	if (!tables_failed) {
 		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded", tables_loaded));
 	} else {
-		ACPI_ERROR((AE_INFO,
+		ACPI_WARNING((AE_INFO,
 			    "%u table load failures, %u successful",
 			    tables_failed, tables_loaded));
 
diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterror.c
index 475932c..e01ff1f 100644
--- a/drivers/acpi/acpica/uterror.c
+++ b/drivers/acpi/acpica/uterror.c
@@ -205,7 +205,10 @@ acpi_ut_namespace_error(const char *module_name,
 	char *name = NULL;
 
 	ACPI_MSG_REDIRECT_BEGIN;
-	acpi_os_printf(ACPI_MSG_ERROR);
+	if (acpi_gbl_log_errors_exceptions_as_warnings)
+		acpi_os_printf(ACPI_MSG_WARNING);
+	else
+		acpi_os_printf(ACPI_MSG_ERROR);
 
 	if (lookup_status == AE_BAD_CHARACTER) {
 
@@ -269,7 +272,10 @@ acpi_ut_method_error(const char *module_name,
 	struct acpi_namespace_node *node = prefix_node;
 
 	ACPI_MSG_REDIRECT_BEGIN;
-	acpi_os_printf(ACPI_MSG_ERROR);
+	if (acpi_gbl_log_errors_exceptions_as_warnings)
+		acpi_os_printf(ACPI_MSG_WARNING);
+	else
+		acpi_os_printf(ACPI_MSG_ERROR);
 
 	if (path) {
 		status = acpi_ns_get_node(prefix_node, path,
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index d9f15cb..c8ca25af 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -73,7 +73,10 @@ acpi_error(const char *module_name, u32 line_number, const char *format, ...)
 	va_list arg_list;
 
 	ACPI_MSG_REDIRECT_BEGIN;
-	acpi_os_printf(ACPI_MSG_ERROR);
+	if (acpi_gbl_log_errors_exceptions_as_warnings)
+		acpi_os_printf(ACPI_MSG_WARNING);
+	else
+		acpi_os_printf(ACPI_MSG_ERROR);
 
 	va_start(arg_list, format);
 	acpi_os_vprintf(format, arg_list);
@@ -107,16 +110,14 @@ acpi_exception(const char *module_name,
 	va_list arg_list;
 
 	ACPI_MSG_REDIRECT_BEGIN;
-
-	/* For AE_OK, just print the message */
-
-	if (ACPI_SUCCESS(status)) {
+	if (acpi_gbl_log_errors_exceptions_as_warnings)
+		acpi_os_printf(ACPI_MSG_WARNING);
+	else
 		acpi_os_printf(ACPI_MSG_EXCEPTION);
 
-	} else {
-		acpi_os_printf(ACPI_MSG_EXCEPTION "%s, ",
-			       acpi_format_exception(status));
-	}
+	/* For AE_OK, just print the message */
+	if (ACPI_FAILURE(status))
+		acpi_os_printf("%s, ", acpi_format_exception(status));
 
 	va_start(arg_list, format);
 	acpi_os_vprintf(format, arg_list);
-- 
2.9.3

