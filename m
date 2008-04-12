From: Len Brown <lenb@kernel.org>
Subject: [PATCH 49/73] ACPICA: Methods now implicitly return 0 in slack mode
Date: Sat, 12 Apr 2008 00:25:32 -0400
Message-ID: <0af0562035c1d094c562e187235bdbf4236d2904.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:45175 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753050AbYDLE2J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:09 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented an enhancement to the interpreter "slack mode". In the
absence of an explicit return or an implicitly returned object from
the last executed opcode, a control method will now implicitly
return an integer of value 0 for Microsoft compatibility. (Lin
Ming) BZ 392

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/parser/psparse.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index a8995ca..a4c4020 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -594,6 +594,30 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 				 * The object is deleted
 				 */
 				if (!previous_walk_state->return_desc) {
+					/*
+					 * In slack mode execution, if there is no return value
+					 * we should implicitly return zero (0) as a default value.
+					 */
+					if (acpi_gbl_enable_interpreter_slack &&
+					    !previous_walk_state->
+					    implicit_return_obj) {
+						previous_walk_state->
+						    implicit_return_obj =
+						    acpi_ut_create_internal_object
+						    (ACPI_TYPE_INTEGER);
+						if (!previous_walk_state->
+						    implicit_return_obj) {
+							return_ACPI_STATUS
+							    (AE_NO_MEMORY);
+						}
+
+						previous_walk_state->
+						    implicit_return_obj->
+						    integer.value = 0;
+					}
+
+					/* Restart the calling control method */
+
 					status =
 					    acpi_ds_restart_control_method
 					    (walk_state,
-- 
1.5.5.29.g7134

