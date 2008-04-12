From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/73] ACPICA: Add error checks to prevent faults
Date: Sat, 12 Apr 2008 00:25:10 -0400
Message-ID: <e520d061266a32d17f0cc2f20934e1f3ce6a20ab.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:15947 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752933AbYDLE2F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:05 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added additional error checking to prevent run-time faults.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exstore.c  |   12 ++++++++++--
 drivers/acpi/namespace/nsnames.c |    6 ++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index 912889e..d860f9c 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -209,8 +209,16 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 							object, level + 4, 0);
 			}
 		} else if (source_desc->reference.node) {
-			acpi_ex_do_debug_object((source_desc->reference.node)->
-						object, level + 4, 0);
+			if (ACPI_GET_DESCRIPTOR_TYPE
+			    (source_desc->reference.node) !=
+			    ACPI_DESC_TYPE_NAMED) {
+				ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
+						      " %p - Not a valid namespace node\n"));
+			} else {
+				acpi_ex_do_debug_object((source_desc->reference.
+							 node)->object,
+							level + 4, 0);
+			}
 		}
 		break;
 
diff --git a/drivers/acpi/namespace/nsnames.c b/drivers/acpi/namespace/nsnames.c
index cbd94af..e14a141 100644
--- a/drivers/acpi/namespace/nsnames.c
+++ b/drivers/acpi/namespace/nsnames.c
@@ -180,6 +180,12 @@ acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node)
 	next_node = node;
 
 	while (next_node && (next_node != acpi_gbl_root_node)) {
+		if (ACPI_GET_DESCRIPTOR_TYPE(next_node) != ACPI_DESC_TYPE_NAMED) {
+			ACPI_ERROR((AE_INFO,
+				    "Invalid NS Node (%X) while traversing path",
+				    next_node));
+			return 0;
+		}
 		size += ACPI_PATH_SEGMENT_LENGTH;
 		next_node = acpi_ns_get_parent_node(next_node);
 	}
-- 
1.5.5.29.g7134

