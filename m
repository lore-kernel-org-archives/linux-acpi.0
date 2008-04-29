From: Len Brown <lenb@kernel.org>
Subject: [PATCH 004/171] ACPI: EC: Improve debug output
Date: Tue, 29 Apr 2008 04:43:55 -0400
Message-ID: <dc0e8490fe884a9378b8ee04a5b5f905f06f4633.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:16639 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759077AbYD2Iom (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:42 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 63e0ac2..1a7949c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -248,9 +248,9 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 			udelay(ACPI_EC_UDELAY);
 		}
 	}
-	pr_err(PREFIX "acpi_ec_wait timeout,"
-			       " status = %d, expect_event = %d\n",
-			       acpi_ec_read_status(ec), event);
+	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
+		acpi_ec_read_status(ec),
+		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
 	ret = -ETIME;
       end:
 	clear_bit(EC_FLAGS_ADDRESS, &ec->flags);
@@ -264,8 +264,8 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 {
 	int result = 0;
 	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-	acpi_ec_write_cmd(ec, command);
 	pr_debug(PREFIX "transaction start\n");
+	acpi_ec_write_cmd(ec, command);
 	for (; wdata_len > 0; --wdata_len) {
 		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
 		if (result) {
-- 
1.5.5.1.99.gf0ec4

