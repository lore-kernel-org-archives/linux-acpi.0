From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH v2 6/7] ACPICA: Add option to disable Package object name resolution errors
Date: Thu, 15 Feb 2018 13:09:31 -0800
Message-ID: <20180215210932.15490-7-erik.schmauss@intel.com>
References: <20180215210932.15490-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43731 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbeBOVJ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Feb 2018 16:09:59 -0500
In-Reply-To: <20180215210932.15490-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a6c3c725c44dd44ad9d3f2b2a64351fdbe6e0014

For the kernel-resident ACPICA, optionally be silent about the
NOT_FOUND case. Although this is potentially a serious problem,
it can generate a lot of noise/errors on platforms whose
firmware carries around a bunch of unused Package objects.
To disable these errors, define ACPI_IGNORE_PACKAGE_RESOLUTION_ERRORS
in the OS-specific header.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198167
Link: https://github.com/acpica/acpica/commit/a6c3c725
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/dspkginit.c | 38 +++++++++++++++++++++++++++++++-------
 include/acpi/platform/aclinux.h |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/dspkginit.c b/drivers/acpi/acpica/dspkginit.c
index a307a07aeacd..7d48525b5e52 100644
--- a/drivers/acpi/acpica/dspkginit.c
+++ b/drivers/acpi/acpica/dspkginit.c
@@ -389,11 +389,12 @@ static void
 acpi_ds_resolve_package_element(union acpi_operand_object **element_ptr)
 {
 	acpi_status status;
+	acpi_status status2;
 	union acpi_generic_state scope_info;
 	union acpi_operand_object *element = *element_ptr;
 	struct acpi_namespace_node *resolved_node;
 	struct acpi_namespace_node *original_node;
-	char *external_path = NULL;
+	char *external_path = "";
 	acpi_object_type type;
 
 	ACPI_FUNCTION_TRACE(ds_resolve_package_element);
@@ -417,17 +418,40 @@ acpi_ds_resolve_package_element(union acpi_operand_object **element_ptr)
 				ACPI_NS_SEARCH_PARENT | ACPI_NS_DONT_OPEN_SCOPE,
 				NULL, &resolved_node);
 	if (ACPI_FAILURE(status)) {
-		status = acpi_ns_externalize_name(ACPI_UINT32_MAX,
-						  (char *)element->reference.
-						  aml, NULL, &external_path);
+#if defined ACPI_IGNORE_PACKAGE_RESOLUTION_ERRORS && !defined ACPI_APPLICATION
+		/*
+		 * For the kernel-resident ACPICA, optionally be silent about the
+		 * NOT_FOUND case. Although this is potentially a serious problem,
+		 * it can generate a lot of noise/errors on platforms whose
+		 * firmware carries around a bunch of unused Package objects.
+		 * To disable these errors, define ACPI_IGNORE_PACKAGE_RESOLUTION_ERRORS
+		 * in the OS-specific header.
+		 *
+		 * All errors are always reported for ACPICA applications such as
+		 * acpi_exec.
+		 */
+		if (status == AE_NOT_FOUND) {
+
+			/* Reference name not found, set the element to NULL */
+
+			acpi_ut_remove_reference(*element_ptr);
+			*element_ptr = NULL;
+			return_VOID;
+		}
+#endif
+		status2 = acpi_ns_externalize_name(ACPI_UINT32_MAX,
+						   (char *)element->reference.
+						   aml, NULL, &external_path);
 
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Could not find/resolve named package element: %s",
+				"While resolving a named reference package element - %s",
 				external_path));
+		if (ACPI_SUCCESS(status2)) {
+			ACPI_FREE(external_path);
+		}
 
-		/* Not found, set the element to NULL */
+		/* Could not resolve name, set the element to NULL */
 
-		ACPI_FREE(external_path);
 		acpi_ut_remove_reference(*element_ptr);
 		*element_ptr = NULL;
 		return_VOID;
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index adee92c38c43..e6e757254138 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -58,6 +58,7 @@
 
 #define ACPI_USE_SYSTEM_CLIBRARY
 #define ACPI_USE_DO_WHILE_0
+#define ACPI_IGNORE_PACKAGE_RESOLUTION_ERRORS
 
 #ifdef __KERNEL__
 
-- 
2.14.3

