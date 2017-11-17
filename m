From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 02/15] ACPICA: Update output from ACPI_EXCEPTION macro
Date: Fri, 17 Nov 2017 15:42:17 -0800
Message-ID: <20171117234230.913-3-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759898AbdKQXqg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:36 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit b2858b2cc83e1481950a2c976f62d4e1d758bc85

Changes line prefix from "ACPI Exception" to simply "ACPI Error"
to match the ACPI_ERROR macro. ACPI_EXCEPTION takes the ACPI status
as an argument, decodes and displays it along with the error
message.

Link: https://github.com/acpica/acpica/commit/b2858b2c
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/acutils.h   | 3 ---
 drivers/acpi/acpica/utxferror.c | 8 ++++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 83b75e9db7ef..bb97a18158ec 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -118,9 +118,6 @@ extern const char *acpi_gbl_ptyp_decode[];
 #ifndef ACPI_MSG_ERROR
 #define ACPI_MSG_ERROR          "ACPI Error: "
 #endif
-#ifndef ACPI_MSG_EXCEPTION
-#define ACPI_MSG_EXCEPTION      "ACPI Exception: "
-#endif
 #ifndef ACPI_MSG_WARNING
 #define ACPI_MSG_WARNING        "ACPI Warning: "
 #endif
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index 950a1e500bfa..9da4f8ef2e77 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -96,8 +96,8 @@ ACPI_EXPORT_SYMBOL(acpi_error)
  *
  * RETURN:      None
  *
- * DESCRIPTION: Print "ACPI Exception" message with module/line/version info
- *              and decoded acpi_status.
+ * DESCRIPTION: Print an "ACPI Error" message with module/line/version
+ *              info as well as decoded acpi_status.
  *
  ******************************************************************************/
 void ACPI_INTERNAL_VAR_XFACE
@@ -111,10 +111,10 @@ acpi_exception(const char *module_name,
 	/* For AE_OK, just print the message */
 
 	if (ACPI_SUCCESS(status)) {
-		acpi_os_printf(ACPI_MSG_EXCEPTION);
+		acpi_os_printf(ACPI_MSG_ERROR);
 
 	} else {
-		acpi_os_printf(ACPI_MSG_EXCEPTION "%s, ",
+		acpi_os_printf(ACPI_MSG_ERROR "%s, ",
 			       acpi_format_exception(status));
 	}
 
-- 
2.13.6

