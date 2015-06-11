From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/5] ACPI / EC: Cleanup transaction state transition.
Date: Thu, 11 Jun 2015 13:21:23 +0800
Message-ID: <c727d05c1f727e2e90df86311eb9dc73e96719cd.1433999639.git.lv.zheng@intel.com>
References: <cover.1433734431.git.lv.zheng@intel.com> <cover.1433999639.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:9622 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529AbbFKFVb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jun 2015 01:21:31 -0400
In-Reply-To: <cover.1433999639.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch collects transaction state transition code into one function. We
then could have a single function to maintain transaction transition
related behaviors. No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Tested-by: Tigran Gabrielyan <tigrangab@gmail.com>
Tested-by: Adrien D <ghbdtn@openmailbox.org>
---
 drivers/acpi/ec.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 149b5e7..0ce8b6e8 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -391,7 +391,7 @@ static void acpi_ec_submit_query(struct acpi_ec *ec)
 
 static void acpi_ec_complete_query(struct acpi_ec *ec)
 {
-	if (ec->curr->command == ACPI_EC_COMMAND_QUERY) {
+	if (test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 		ec_dbg_req("Event stopped");
 	}
@@ -421,6 +421,15 @@ static int ec_transaction_completed(struct acpi_ec *ec)
 	return ret;
 }
 
+static inline void ec_transaction_transition(struct acpi_ec *ec, unsigned long flag)
+{
+	ec->curr->flags |= flag;
+	if (ec->curr->command == ACPI_EC_COMMAND_QUERY) {
+		if (flag == ACPI_EC_COMMAND_POLL)
+			acpi_ec_complete_query(ec);
+	}
+}
+
 static void advance_transaction(struct acpi_ec *ec)
 {
 	struct transaction *t;
@@ -449,7 +458,7 @@ static void advance_transaction(struct acpi_ec *ec)
 			if ((status & ACPI_EC_FLAG_OBF) == 1) {
 				t->rdata[t->ri++] = acpi_ec_read_data(ec);
 				if (t->rlen == t->ri) {
-					t->flags |= ACPI_EC_COMMAND_COMPLETE;
+					ec_transaction_transition(ec, ACPI_EC_COMMAND_COMPLETE);
 					if (t->command == ACPI_EC_COMMAND_QUERY)
 						ec_dbg_req("Command(%s) hardware completion",
 							   acpi_ec_cmd_string(t->command));
@@ -459,7 +468,7 @@ static void advance_transaction(struct acpi_ec *ec)
 				goto err;
 		} else if (t->wlen == t->wi &&
 			   (status & ACPI_EC_FLAG_IBF) == 0) {
-			t->flags |= ACPI_EC_COMMAND_COMPLETE;
+			ec_transaction_transition(ec, ACPI_EC_COMMAND_COMPLETE);
 			wakeup = true;
 		}
 		goto out;
@@ -467,17 +476,15 @@ static void advance_transaction(struct acpi_ec *ec)
 		if (EC_FLAGS_QUERY_HANDSHAKE &&
 		    !(status & ACPI_EC_FLAG_SCI) &&
 		    (t->command == ACPI_EC_COMMAND_QUERY)) {
-			t->flags |= ACPI_EC_COMMAND_POLL;
-			acpi_ec_complete_query(ec);
+			ec_transaction_transition(ec, ACPI_EC_COMMAND_POLL);
 			t->rdata[t->ri++] = 0x00;
-			t->flags |= ACPI_EC_COMMAND_COMPLETE;
+			ec_transaction_transition(ec, ACPI_EC_COMMAND_COMPLETE);
 			ec_dbg_req("Command(%s) software completion",
 				   acpi_ec_cmd_string(t->command));
 			wakeup = true;
 		} else if ((status & ACPI_EC_FLAG_IBF) == 0) {
 			acpi_ec_write_cmd(ec, t->command);
-			t->flags |= ACPI_EC_COMMAND_POLL;
-			acpi_ec_complete_query(ec);
+			ec_transaction_transition(ec, ACPI_EC_COMMAND_POLL);
 		} else
 			goto err;
 		goto out;
-- 
1.7.10

