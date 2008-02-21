From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/26] ACPI: sparse fix, replace macro with static function
Date: Thu, 21 Feb 2008 04:25:31 -0500
Message-ID: <4fd7f5188c377c1e9aa8f224f6edf96d170a7d32.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36609 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756871AbYBUJ3R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:17 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Len Brown <len.brown@intel.com>

From: Harvey Harrison <harvey.harrison@gmail.com>

replace acpi_util_eval_error macro with static function.

Avoid these sparse warnings due to using buffer within the macro.
drivers/acpi/utils.c:273:3: warning: symbol 'buffer' shadows an earlier one
drivers/acpi/utils.c:259:21: originally declared here
drivers/acpi/utils.c:279:3: warning: symbol 'buffer' shadows an earlier one
drivers/acpi/utils.c:259:21: originally declared here
drivers/acpi/utils.c:368:3: warning: symbol 'buffer' shadows an earlier one
drivers/acpi/utils.c:348:21: originally declared here
drivers/acpi/utils.c:375:3: warning: symbol 'buffer' shadows an earlier one
drivers/acpi/utils.c:348:21: originally declared here
drivers/acpi/utils.c:382:3: warning: symbol 'buffer' shadows an earlier one
drivers/acpi/utils.c:348:21: originally declared here
drivers/acpi/utils.c:402:4: warning: symbol 'buffer' shadows an earlier one
drivers/acpi/utils.c:348:21: originally declared here

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utils.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 34f1575..eba55b7 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -36,16 +36,20 @@ ACPI_MODULE_NAME("utils");
 /* --------------------------------------------------------------------------
                             Object Evaluation Helpers
    -------------------------------------------------------------------------- */
+static void
+acpi_util_eval_error(acpi_handle h, acpi_string p, acpi_status s)
+{
 #ifdef ACPI_DEBUG_OUTPUT
-#define acpi_util_eval_error(h,p,s) {\
-	char prefix[80] = {'\0'};\
-	struct acpi_buffer buffer = {sizeof(prefix), prefix};\
-	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);\
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluate [%s.%s]: %s\n",\
-		(char *) prefix, p, acpi_format_exception(s))); }
+	char prefix[80] = {'\0'};
+	struct acpi_buffer buffer = {sizeof(prefix), prefix};
+	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluate [%s.%s]: %s\n",
+		(char *) prefix, p, acpi_format_exception(s)));
 #else
-#define acpi_util_eval_error(h,p,s)
+	return;
 #endif
+}
+
 acpi_status
 acpi_extract_package(union acpi_object *package,
 		     struct acpi_buffer *format, struct acpi_buffer *buffer)
-- 
1.5.4.2

