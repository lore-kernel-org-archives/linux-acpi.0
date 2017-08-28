From: Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: [PATCH v2] ACPI, APEI, EINJ: Subtract any matching Register Region from Trigger resources
Date: Mon, 28 Aug 2017 13:13:14 -0500
Message-ID: <1503943994-41271-1-git-send-email-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:56064
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbdH1SNi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Aug 2017 14:13:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-edac@vger.kernel.org, bp@suse.de, tony.luck@intel.com, Yazen Ghannam <yazen.ghannam@amd.com>

From: Yazen Ghannam <yazen.ghannam@amd.com>

ACPI defines a number of instructions to use for triggering errors. However
we are currently removing the address resources from the trigger resources
for only the WRITE_REGISTER_VALUE instruction. This leads to a resource
conflict for any other valid instruction.

Check that the instruction is less than or equal to the
WRITE_REGISTER_VALUE instruction. This allows all valid memory access
instructions and protects against invalid instructions.

Fixes: b4e008dc53a3 ("ACPI, APEI, EINJ, Refine the fix of resource conflict")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Acked-by: Tony Luck <tony.luck@intel.com>
---
Link:
https://lkml.kernel.org/r/1502387883-16667-1-git-send-email-Yazen.Ghannam@amd.com

v1->v2:
* Apply Tony's comment to restrict behavior to valid memory instructions.

 drivers/acpi/apei/einj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ec50c32ea3da..b38737c83a24 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -281,7 +281,7 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
 	for (i = 0; i < trigger_tab->entry_count; i++) {
 		if (entry->action == ACPI_EINJ_TRIGGER_ERROR &&
-		entry->instruction == ACPI_EINJ_WRITE_REGISTER_VALUE &&
+		entry->instruction <= ACPI_EINJ_WRITE_REGISTER_VALUE &&
 		entry->register_region.space_id ==
 			ACPI_ADR_SPACE_SYSTEM_MEMORY &&
 		(entry->register_region.address & param2) == (param1 & param2))
-- 
2.7.4

