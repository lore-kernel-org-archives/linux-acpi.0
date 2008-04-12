From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/73] ACPICA: Added additional parameter validation for LoadTable
Date: Sat, 12 Apr 2008 00:25:14 -0400
Message-ID: <26ccbc54161f336adec2e2f21b9ed4b9222c5408.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:7534 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752481AbYDLE2I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:08 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented additional parameter validation for the LoadTable
operator. The length of the input strings SignatureString,
OemIdString, and OemTableId are now checked for maximum
lengths. (BZ 582) Lin Ming.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index b9543a7..3370aad 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -138,6 +138,14 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 	ACPI_FUNCTION_TRACE(ex_load_table_op);
 
+	/* Validate lengths for the signature_string, OEMIDString, OEMtable_iD */
+
+	if ((operand[0]->string.length > ACPI_NAME_SIZE) ||
+	    (operand[1]->string.length > ACPI_OEM_ID_SIZE) ||
+	    (operand[2]->string.length > ACPI_OEM_TABLE_ID_SIZE)) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
 	/* Find the ACPI table in the RSDT/XSDT */
 
 	status = acpi_tb_find_table(operand[0]->string.pointer,
-- 
1.5.5.29.g7134

