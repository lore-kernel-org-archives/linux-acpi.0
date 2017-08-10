From: Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: [PATCH] ACPI, APEI, EINJ: Subtract any matching Register Region from Trigger resources
Date: Thu, 10 Aug 2017 12:58:03 -0500
Message-ID: <1502387883-16667-1-git-send-email-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:26304
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752756AbdHJR6S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Aug 2017 13:58:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>

From: Yazen Ghannam <yazen.ghannam@amd.com>

ACPI defines a number of instructions to use for triggering errors. However
we are currently removing the address resources from the trigger resources
for only the WRITE_REGISTER_VALUE instruction. This leads to a resource
conflict for any other valid instruction.

Remove the WRITE_REGISTER_VALUE instruction check to fix the resource
conflict with other instructions.

Fixes: b4e008dc53a3 ("ACPI, APEI, EINJ, Refine the fix of resource conflict")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/acpi/apei/einj.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ec50c32ea3da..e0f201ea161d 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -281,7 +281,6 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
 	for (i = 0; i < trigger_tab->entry_count; i++) {
 		if (entry->action == ACPI_EINJ_TRIGGER_ERROR &&
-		entry->instruction == ACPI_EINJ_WRITE_REGISTER_VALUE &&
 		entry->register_region.space_id ==
 			ACPI_ADR_SPACE_SYSTEM_MEMORY &&
 		(entry->register_region.address & param2) == (param1 & param2))
-- 
2.7.4

