From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/73] ACPICA: Fix for namespace lookup problem
Date: Sat, 12 Apr 2008 00:25:03 -0400
Message-ID: <7ecc6501ac48eb3367052f6bab268ff2ad5b282f.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20142 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752505AbYDLE2A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:00 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem where objects of certain types (Device,
ThermalZone, Processor, PowerResource) can be not found if they
are declared and referenced from within the same control method
(Lin Ming) BZ 341.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/parser/psargs.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/parser/psargs.c b/drivers/acpi/parser/psargs.c
index c2b9835..442880f 100644
--- a/drivers/acpi/parser/psargs.c
+++ b/drivers/acpi/parser/psargs.c
@@ -230,12 +230,11 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 			  struct acpi_parse_state *parser_state,
 			  union acpi_parse_object *arg, u8 possible_method_call)
 {
+	acpi_status status;
 	char *path;
 	union acpi_parse_object *name_op;
-	acpi_status status;
 	union acpi_operand_object *method_desc;
 	struct acpi_namespace_node *node;
-	union acpi_generic_state scope_info;
 
 	ACPI_FUNCTION_TRACE(ps_get_next_namepath);
 
@@ -249,25 +248,18 @@ acpi_ps_get_next_namepath(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	/* Setup search scope info */
-
-	scope_info.scope.node = NULL;
-	node = parser_state->start_node;
-	if (node) {
-		scope_info.scope.node = node;
-	}
-
 	/*
-	 * Lookup the name in the internal namespace. We don't want to add
-	 * anything new to the namespace here, however, so we use MODE_EXECUTE.
+	 * Lookup the name in the internal namespace, starting with the current
+	 * scope. We don't want to add anything new to the namespace here,
+	 * however, so we use MODE_EXECUTE.
 	 * Allow searching of the parent tree, but don't open a new scope -
 	 * we just want to lookup the object (must be mode EXECUTE to perform
 	 * the upsearch)
 	 */
-	status =
-	    acpi_ns_lookup(&scope_info, path, ACPI_TYPE_ANY, ACPI_IMODE_EXECUTE,
-			   ACPI_NS_SEARCH_PARENT | ACPI_NS_DONT_OPEN_SCOPE,
-			   NULL, &node);
+	status = acpi_ns_lookup(walk_state->scope_info, path,
+				ACPI_TYPE_ANY, ACPI_IMODE_EXECUTE,
+				ACPI_NS_SEARCH_PARENT | ACPI_NS_DONT_OPEN_SCOPE,
+				NULL, &node);
 
 	/*
 	 * If this name is a control method invocation, we must
-- 
1.5.5.29.g7134

