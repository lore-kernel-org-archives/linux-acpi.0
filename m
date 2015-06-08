From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/6] ACPI / EC: Cleanup _Qxx evaluation work item.
Date: Mon,  8 Jun 2015 13:27:58 +0800
Message-ID: <b22fecda477d8883bb7aa055ba35d46123756368.1433734431.git.lv.zheng@intel.com>
References: <cover.1433734431.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:58074 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbbFHF2E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2015 01:28:04 -0400
In-Reply-To: <cover.1433734431.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The _Qxx evaluation work item can be eliminated and _Qxx can be evaluated
right in the same work item as the QR_EC transaction. This patch cleans up
the code to achieve this.

Originally, QR_EC transaction and _Qxx evaluation were all done in the same
work queue flushed by acpi_os_wait_events_complete(). Though the QR_EC
transaction (previous commit) and _Qxx evaluation (this commmit) are now
moved to the work queue that is not covered by
acpi_os_wait_events_complete(), there is no issue can be seen in the
suspend/resume tests.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 0ce8b6e8..b956dbc 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -904,27 +904,12 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-static void acpi_ec_run(void *cxt)
-{
-	struct acpi_ec_query_handler *handler = cxt;
-
-	if (!handler)
-		return;
-	ec_dbg_evt("Query(0x%02x) started", handler->query_bit);
-	if (handler->func)
-		handler->func(handler->data);
-	else if (handler->handle)
-		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
-	ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);
-	acpi_ec_put_query_handler(handler);
-}
-
 static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 {
 	u8 value = 0;
 	int result;
-	acpi_status status;
 	struct acpi_ec_query_handler *handler;
+	bool handler_found = false;
 	struct transaction t = {.command = ACPI_EC_COMMAND_QUERY,
 				.wdata = NULL, .rdata = &value,
 				.wlen = 0, .rlen = 1};
@@ -947,17 +932,21 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 		if (value == handler->query_bit) {
 			/* have custom handler for this bit */
 			handler = acpi_ec_get_query_handler(handler);
-			ec_dbg_evt("Query(0x%02x) scheduled",
-				   handler->query_bit);
-			status = acpi_os_execute((handler->func) ?
-				OSL_NOTIFY_HANDLER : OSL_GPE_HANDLER,
-				acpi_ec_run, handler);
-			if (ACPI_FAILURE(status))
-				result = -EBUSY;
+			handler_found = true;
 			break;
 		}
 	}
 	mutex_unlock(&ec->mutex);
+
+	if (handler_found) {
+		ec_dbg_evt("Query(0x%02x) started", handler->query_bit);
+		if (handler->func)
+			handler->func(handler->data);
+		else if (handler->handle)
+			acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
+		ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);
+		acpi_ec_put_query_handler(handler);
+	}
 	return result;
 }
 
-- 
1.7.10

