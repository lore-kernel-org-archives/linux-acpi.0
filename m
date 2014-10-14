From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/5] ACPI/EC: Refine event/query debugging messages.
Date: Tue, 14 Oct 2014 14:23:55 +0800
Message-ID: <a3b73700637c92cfc1bfde11e27f58946334a68f.1413267704.git.lv.zheng@intel.com>
References: <cover.1413267704.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61206 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431AbaJNGYB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Oct 2014 02:24:01 -0400
In-Reply-To: <cover.1413267704.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch refines event/query debugging messages to use a unified format
as commands. Developers can clearly find different processes by checking
different log seperators. No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8957d51..d993df6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -332,8 +332,10 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	ret = ec_poll(ec);
 	spin_lock_irqsave(&ec->lock, tmp);
-	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
+	if (ec->curr->command == ACPI_EC_COMMAND_QUERY) {
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+		pr_debug("***** Event stopped *****\n");
+	}
 	pr_debug("***** Command(%s) stopped *****\n",
 		 acpi_ec_cmd_string(t->command));
 	ec->curr = NULL;
@@ -617,12 +619,12 @@ static void acpi_ec_run(void *cxt)
 	struct acpi_ec_query_handler *handler = cxt;
 	if (!handler)
 		return;
-	pr_debug("start query execution\n");
+	pr_debug("##### Query(0x%02x) started #####\n", handler->query_bit);
 	if (handler->func)
 		handler->func(handler->data);
 	else if (handler->handle)
 		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
-	pr_debug("stop query execution\n");
+	pr_debug("##### Query(0x%02x) stopped #####\n", handler->query_bit);
 	kfree(handler);
 }
 
@@ -645,8 +647,8 @@ static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data)
 			if (!copy)
 				return -ENOMEM;
 			memcpy(copy, handler, sizeof(*copy));
-			pr_debug("push query execution (0x%2x) on queue\n",
-				value);
+			pr_debug("##### Query(0x%02x) scheduled #####\n",
+				 handler->query_bit);
 			return acpi_os_execute((copy->func) ?
 				OSL_NOTIFY_HANDLER : OSL_GPE_HANDLER,
 				acpi_ec_run, copy);
@@ -669,7 +671,7 @@ static int ec_check_sci(struct acpi_ec *ec, u8 state)
 {
 	if (state & ACPI_EC_FLAG_SCI) {
 		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
-			pr_debug("push gpe query to the queue\n");
+			pr_debug("***** Event started *****\n");
 			return acpi_os_execute(OSL_NOTIFY_HANDLER,
 				acpi_ec_gpe_query, ec);
 		}
-- 
1.7.10

