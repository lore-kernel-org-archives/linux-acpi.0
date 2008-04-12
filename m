From: Len Brown <lenb@kernel.org>
Subject: [PATCH 62/73] ACPICA: Update behavior of CopyObject to match ACPI spec
Date: Sat, 12 Apr 2008 00:25:45 -0400
Message-ID: <3a061b523d4c02d0b1dac9ee1681465ee8140ae6.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:54694 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756434AbYDLE2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:16 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem where a CopyObject to RegionField, BankField, and
IndexField objects did not perform an implicit conversion as it
should. These types must retain their initial type permanently as
per the ACPI specification. However, a CopyObject to all other
object types should not perform an implicit conversion, as per
the ACPI specification. (Lin Ming, Bob Moore) BZ 388

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exstore.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index 725614e..36c0fcc 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -603,10 +603,17 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 
 	/* If no implicit conversion, drop into the default case below */
 
-	if ((!implicit_conversion) || (walk_state->opcode == AML_COPY_OP)) {
-
-		/* Force execution of default (no implicit conversion) */
-
+	if ((!implicit_conversion) ||
+	    ((walk_state->opcode == AML_COPY_OP) &&
+	     (target_type != ACPI_TYPE_LOCAL_REGION_FIELD) &&
+	     (target_type != ACPI_TYPE_LOCAL_BANK_FIELD) &&
+	     (target_type != ACPI_TYPE_LOCAL_INDEX_FIELD))) {
+		/*
+		 * Force execution of default (no implicit conversion). Note:
+		 * copy_object does not perform an implicit conversion, as per the ACPI
+		 * spec -- except in case of region/bank/index fields -- because these
+		 * objects must retain their original type permanently.
+		 */
 		target_type = ACPI_TYPE_ANY;
 	}
 
-- 
1.5.5.29.g7134

