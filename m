From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/15] ACPICA: Namespace: Update/fix an error message
Date: Thu,  3 Aug 2017 14:26:31 +0800
Message-ID: <ef8a51456e769d57785d9eb82375f062e0163995.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14704 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbdHCG0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:26:36 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 8b7fa979ef81469e70f501f582466a265d6f595b

Was emitting an internal namestring without converting it to
the external format.

Link: https://github.com/acpica/acpica/commit/8b7fa979
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsaccess.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 14be12f..f2733f5 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -292,6 +292,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 {
 	acpi_status status;
 	char *path = pathname;
+	char *external_path;
 	struct acpi_namespace_node *prefix_node;
 	struct acpi_namespace_node *current_node = NULL;
 	struct acpi_namespace_node *this_node = NULL;
@@ -427,13 +428,22 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 				num_carats++;
 				this_node = this_node->parent;
 				if (!this_node) {
+					/*
+					 * Current scope has no parent scope. Externalize
+					 * the internal path for error message.
+					 */
+					status =
+					    acpi_ns_externalize_name
+					    (ACPI_UINT32_MAX, pathname, NULL,
+					     &external_path);
+					if (ACPI_SUCCESS(status)) {
+						ACPI_ERROR((AE_INFO,
+							    "%s: Path has too many parent prefixes (^)",
+							    external_path));
+
+						ACPI_FREE(external_path);
+					}
 
-					/* Current scope has no parent scope */
-
-					ACPI_ERROR((AE_INFO,
-						    "%s: Path has too many parent prefixes (^) "
-						    "- reached beyond root node",
-						    pathname));
 					return_ACPI_STATUS(AE_NOT_FOUND);
 				}
 			}
-- 
2.7.4

