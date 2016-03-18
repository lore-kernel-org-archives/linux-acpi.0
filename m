From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / util: cast data to u64 before shifting to fix sign extension
Date: Fri, 18 Mar 2016 15:08:01 +0000
Message-ID: <1458313681-24239-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36151 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbcCRPIE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2016 11:08:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

obj->buffer.pointer[i] should be cast to u64 to prevent an unintentional
sign extension.  For example, if pointer[7] is 0x80, then the value
0xffffffffff000000 is or'd into mask rather than the intended value
0xff00000000000000

Detected with static analysis by CoverityScan

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index f12a724..050673f 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -692,7 +692,7 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs)
 		mask = obj->integer.value;
 	else if (obj->type == ACPI_TYPE_BUFFER)
 		for (i = 0; i < obj->buffer.length && i < 8; i++)
-			mask |= (((u8)obj->buffer.pointer[i]) << (i * 8));
+			mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));
 	ACPI_FREE(obj);
 
 	/*
-- 
2.7.3

