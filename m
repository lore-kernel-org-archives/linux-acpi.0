From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 13/15] ACPICA: Update linkage for get mutex name interface
Date: Fri, 17 Nov 2017 15:42:28 -0800
Message-ID: <20171117234230.913-14-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39440 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161069AbdKQXqo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:44 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit cb9a3906ec35da7a6e0b8972f8e6e7895e59c208

Always enable the function.

Link: https://github.com/acpica/acpica/commit/cb9a3906
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/acutils.h  |  4 ++--
 drivers/acpi/acpica/utdecode.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index d38187ee11c8..8bb46d8623ca 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -230,10 +230,10 @@ u64 acpi_ut_implicit_strtoul64(char *string);
  */
 acpi_status acpi_ut_init_globals(void);
 
-#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
-
 const char *acpi_ut_get_mutex_name(u32 mutex_id);
 
+#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
+
 const char *acpi_ut_get_notify_name(u32 notify_value, acpi_object_type type);
 #endif
 
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 02cd2c2d961a..55debbad487d 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -395,11 +395,6 @@ const char *acpi_ut_get_reference_name(union acpi_operand_object *object)
 	return (acpi_gbl_ref_class_names[object->reference.class]);
 }
 
-#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
-/*
- * Strings and procedures used for debug only
- */
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_get_mutex_name
@@ -433,6 +428,12 @@ const char *acpi_ut_get_mutex_name(u32 mutex_id)
 	return (acpi_gbl_mutex_names[mutex_id]);
 }
 
+#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
+
+/*
+ * Strings and procedures used for debug only
+ */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_get_notify_name
-- 
2.13.6

