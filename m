From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 47/53] ACPICA: Disassembler: allow conflicting external declarations to be emitted.
Date: Mon,  5 Jun 2017 16:41:55 +0800
Message-ID: <0aa2a648787cdaddcabc1532f1ae2ba54de50cb9.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:63486 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbdFEImP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:42:15 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 0ed9f2e2ccc112439eaa355b5952a05d6fdb7814

An external declaration is a conflicting declaration when a name has
been declared as an external and a named object within the same file.

Link: https://github.com/acpica/acpica/commit/0ed9f2e2
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h  |  1 +
 drivers/acpi/acpica/nsaccess.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 2a8394fe..8ddd3b2 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1181,6 +1181,7 @@ struct acpi_external_list {
 #define ACPI_EXT_INTERNAL_PATH_ALLOCATED    0x04	/* Deallocate internal path on completion */
 #define ACPI_EXT_EXTERNAL_EMITTED           0x08	/* External() statement has been emitted */
 #define ACPI_EXT_ORIGIN_FROM_OPCODE         0x10	/* External came from a External() opcode */
+#define ACPI_EXT_CONFLICTING_DECLARATION    0x20	/* External has a conflicting declaration within AML */
 
 struct acpi_external_file {
 	char *path;
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index fb265b57..e5f4fa4 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -47,6 +47,10 @@
 #include "acnamesp.h"
 #include "acdispat.h"
 
+#ifdef ACPI_ASL_COMPILER
+#include "acdisasm.h"
+#endif
+
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsaccess")
 
@@ -580,6 +584,29 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 						  (char *)&current_node->name,
 						  current_node));
 			}
+#ifdef ACPI_ASL_COMPILER
+			/*
+			 * If this ACPI name already exists within the namespace as an
+			 * external declaration, then mark the external as a conflicting
+			 * declaration and proceed to process the current node as if it did
+			 * not exist in the namespace. If this node is not processed as
+			 * normal, then it could cause improper namespace resolution
+			 * by failing to open a new scope.
+			 */
+			if (acpi_gbl_disasm_flag &&
+			    (status == AE_ALREADY_EXISTS) &&
+			    ((this_node->flags & ANOBJ_IS_EXTERNAL) ||
+			     (walk_state
+			      && walk_state->opcode == AML_EXTERNAL_OP))) {
+				this_node->flags &= ~ANOBJ_IS_EXTERNAL;
+				this_node->type = (u8)this_search_type;
+				if (walk_state->opcode != AML_EXTERNAL_OP) {
+					acpi_dm_mark_external_conflict
+					    (this_node);
+				}
+				break;
+			}
+#endif
 
 			*return_node = this_node;
 			return_ACPI_STATUS(status);
-- 
2.7.4

