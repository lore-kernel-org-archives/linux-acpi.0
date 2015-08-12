From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2] ACPI / EC: Fix an issue caused by the serialized _Qxx evaluations.
Date: Wed, 12 Aug 2015 11:12:02 +0800
Message-ID: <05a5a68b209d57c2b2e9e8aba1fa6365ec40c52c.1438924516.git.lv.zheng@intel.com>
References: <d2029b78c1e914d0c05b28c406a88057858b8a42.1434001323.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40215 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530AbbHLDMh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Aug 2015 23:12:37 -0400
In-Reply-To: <d2029b78c1e914d0c05b28c406a88057858b8a42.1434001323.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

It is proven that Windows evaluates _Qxx handlers in a parallel way. This
patch follows this fact, splits _Qxx evaluations from the NOTIFY queue to
form a separate queue, so that _Qxx evaluations can be queued up on
different CPUs rather than being queued up on a CPU0 bound queue.
Event handling related callbacks are also renamed and sorted in this patch.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=94411
Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   76 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 21 deletions(-)

Index: linux-acpica/drivers/acpi/ec.c
===================================================================
--- linux-acpica.orig/drivers/acpi/ec.c
+++ linux-acpica/drivers/acpi/ec.c
@@ -161,8 +161,16 @@ struct transaction {
 	u8 flags;
 };
 
+struct acpi_ec_query {
+	struct transaction transaction;
+	struct work_struct work;
+	struct acpi_ec_query_handler *handler;
+};
+
 static int acpi_ec_query(struct acpi_ec *ec, u8 *data);
 static void advance_transaction(struct acpi_ec *ec);
+static void acpi_ec_event_handler(struct work_struct *work);
+static void acpi_ec_event_processor(struct work_struct *work);
 
 struct acpi_ec *boot_ec, *first_ec;
 EXPORT_SYMBOL(first_ec);
@@ -974,60 +982,90 @@ void acpi_ec_remove_query_handler(struct
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-static void acpi_ec_run(void *cxt)
+static struct acpi_ec_query *acpi_ec_create_query(u8 *pval)
 {
-	struct acpi_ec_query_handler *handler = cxt;
+	struct acpi_ec_query *q;
+	struct transaction *t;
+
+	q = kzalloc(sizeof (struct acpi_ec_query), GFP_KERNEL);
+	if (!q)
+		return NULL;
+	INIT_WORK(&q->work, acpi_ec_event_processor);
+	t = &q->transaction;
+	t->command = ACPI_EC_COMMAND_QUERY;
+	t->rdata = pval;
+	t->rlen = 1;
+	return q;
+}
+
+static void acpi_ec_delete_query(struct acpi_ec_query *q)
+{
+	if (q) {
+		if (q->handler)
+			acpi_ec_put_query_handler(q->handler);
+		kfree(q);
+	}
+}
+
+static void acpi_ec_event_processor(struct work_struct *work)
+{
+	struct acpi_ec_query *q = container_of(work, struct acpi_ec_query, work);
+	struct acpi_ec_query_handler *handler = q->handler;
 
-	if (!handler)
-		return;
 	ec_dbg_evt("Query(0x%02x) started", handler->query_bit);
 	if (handler->func)
 		handler->func(handler->data);
 	else if (handler->handle)
 		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
 	ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);
-	acpi_ec_put_query_handler(handler);
+	acpi_ec_delete_query(q);
 }
 
 static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 {
 	u8 value = 0;
 	int result;
-	acpi_status status;
 	struct acpi_ec_query_handler *handler;
-	struct transaction t = {.command = ACPI_EC_COMMAND_QUERY,
-				.wdata = NULL, .rdata = &value,
-				.wlen = 0, .rlen = 1};
+	struct acpi_ec_query *q;
+
+	q = acpi_ec_create_query(&value);
+	if (!q)
+		return -ENOMEM;
 
 	/*
 	 * Query the EC to find out which _Qxx method we need to evaluate.
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	result = acpi_ec_transaction(ec, &t);
-	if (result)
-		return result;
-	if (data)
-		*data = value;
+	result = acpi_ec_transaction(ec, &q->transaction);
 	if (!value)
-		return -ENODATA;
+		result = -ENODATA;
+	if (result)
+		goto err_exit;
 
 	mutex_lock(&ec->mutex);
 	list_for_each_entry(handler, &ec->list, node) {
 		if (value == handler->query_bit) {
-			/* have custom handler for this bit */
-			handler = acpi_ec_get_query_handler(handler);
+			q->handler = acpi_ec_get_query_handler(handler);
 			ec_dbg_evt("Query(0x%02x) scheduled",
-				   handler->query_bit);
-			status = acpi_os_execute((handler->func) ?
-				OSL_NOTIFY_HANDLER : OSL_GPE_HANDLER,
-				acpi_ec_run, handler);
-			if (ACPI_FAILURE(status))
+				   q->handler->query_bit);
+			/*
+			 * It is reported that _Qxx are evaluated in a
+			 * parallel way on Windows:
+			 * https://bugzilla.kernel.org/show_bug.cgi?id=94411
+			 */
+			if (!schedule_work(&q->work))
 				result = -EBUSY;
 			break;
 		}
 	}
 	mutex_unlock(&ec->mutex);
+
+err_exit:
+	if (result && q)
+		acpi_ec_delete_query(q);
+	if (data)
+		*data = value;
 	return result;
 }
 
