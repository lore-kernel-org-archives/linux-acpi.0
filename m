From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] ACPICA: Log failing to find symbols in the tables as warnings
Date: Fri, 12 Jan 2018 12:37:07 +0100
Message-ID: <20180112113707.3833-2-hdegoede@redhat.com>
References: <20180112113707.3833-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754403AbeALLhN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jan 2018 06:37:13 -0500
In-Reply-To: <20180112113707.3833-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, devel@acpica.org

Many ACPI tables reference missing symbols, there is nothing the ACPICA
code can do about this, nor can the user. Getting manufacturers to issue
firmware updates to fix this is near impossible and even then most users
never update their BIOS.

Logging AE_NOT_FOUND errors as warnings is important because many desktop
and embedded applicance Linux use-cases have a hard requirement of not
showing any (scary) text messages during system bootup, which get broken
by logging these as errors.

This has been tested on an Asrock B150M Pro4S/D3, which throws similar
errors as those reported in bko109511 and on an Asus T100HA, which throws
similar errors as those reported in bko198167. "dmesg --level=err" is
silent on both boards after this commit.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=109511
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=198167
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/tbxfload.c  |  2 +-
 drivers/acpi/acpica/uterror.c   | 12 ++++++++++--
 drivers/acpi/acpica/utxferror.c | 15 +++++++--------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index d81f442228b8..f04f6c134f01 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -241,7 +241,7 @@ acpi_status acpi_tb_load_namespace(void)
 	if (!tables_failed) {
 		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded", tables_loaded));
 	} else {
-		ACPI_ERROR((AE_INFO,
+		ACPI_WARNING((AE_INFO,
 			    "%u table load failures, %u successful",
 			    tables_failed, tables_loaded));
 
diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterror.c
index e3368186e1c1..f17f961618b8 100644
--- a/drivers/acpi/acpica/uterror.c
+++ b/drivers/acpi/acpica/uterror.c
@@ -205,7 +205,11 @@ acpi_ut_namespace_error(const char *module_name,
 	char *name = NULL;
 
 	ACPI_MSG_REDIRECT_BEGIN;
-	acpi_os_printf(ACPI_MSG_ERROR);
+	/* Many ACPI tables reference missing symbols, log this as warnings */
+	if (lookup_status == AE_NOT_FOUND)
+		acpi_os_printf(ACPI_MSG_WARNING);
+	else
+		acpi_os_printf(ACPI_MSG_ERROR);
 
 	if (lookup_status == AE_BAD_CHARACTER) {
 
@@ -269,7 +273,11 @@ acpi_ut_method_error(const char *module_name,
 	struct acpi_namespace_node *node = prefix_node;
 
 	ACPI_MSG_REDIRECT_BEGIN;
-	acpi_os_printf(ACPI_MSG_ERROR);
+	/* Many ACPI tables reference missing symbols, log this as warnings */
+	if (method_status == AE_NOT_FOUND)
+		acpi_os_printf(ACPI_MSG_WARNING);
+	else
+		acpi_os_printf(ACPI_MSG_ERROR);
 
 	if (path) {
 		status = acpi_ns_get_node(prefix_node, path,
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index 950a1e500bfa..cae580671392 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -107,16 +107,15 @@ acpi_exception(const char *module_name,
 	va_list arg_list;
 
 	ACPI_MSG_REDIRECT_BEGIN;
-
-	/* For AE_OK, just print the message */
-
-	if (ACPI_SUCCESS(status)) {
+	/* Many ACPI tables reference missing symbols, log this as warnings */
+	if (status == AE_NOT_FOUND)
+		acpi_os_printf(ACPI_MSG_WARNING);
+	else
 		acpi_os_printf(ACPI_MSG_EXCEPTION);
 
-	} else {
-		acpi_os_printf(ACPI_MSG_EXCEPTION "%s, ",
-			       acpi_format_exception(status));
-	}
+	/* For failures append the formatted exception */
+	if (ACPI_FAILURE(status))
+		acpi_os_printf("%s, ", acpi_format_exception(status));
 
 	va_start(arg_list, format);
 	acpi_os_vprintf(format, arg_list);
-- 
2.14.3

