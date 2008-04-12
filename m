From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/73] ACPICA: Fix a fault when storing DdbHandle to Debug object
Date: Sat, 12 Apr 2008 00:25:07 -0400
Message-ID: <b681583cc6bb084317993a5b9cb8f0d1ef47ba0a.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:54694 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752811AbYDLE2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:04 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the Debug object where a store of a DdbHandle
reference object to the Debug object could cause a fault.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exstore.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index f88b181..912889e 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -123,6 +123,8 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 		return_VOID;
 	}
 
+	/* source_desc is of type ACPI_DESC_TYPE_OPERAND */
+
 	switch (ACPI_GET_OBJECT_TYPE(source_desc)) {
 	case ACPI_TYPE_INTEGER:
 
@@ -180,11 +182,19 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 					      (source_desc->reference.opcode),
 					      source_desc->reference.offset));
 		} else {
-			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[%s]\n",
+			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[%s]",
 					      acpi_ps_get_opcode_name
 					      (source_desc->reference.opcode)));
 		}
 
+		if (source_desc->reference.opcode == AML_LOAD_OP) {	/* Load and load_table */
+			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
+					      " Table OwnerId %X\n",
+					      source_desc->reference.object));
+			break;
+		}
+
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "\n"));
 		if (source_desc->reference.object) {
 			if (ACPI_GET_DESCRIPTOR_TYPE
 			    (source_desc->reference.object) ==
-- 
1.5.5.29.g7134

