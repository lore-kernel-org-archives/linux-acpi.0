From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPI / EC: Fix query handler related issues
Date: Thu, 24 Sep 2015 14:54:48 +0800
Message-ID: <99ca634310ba07f3f8e06ebdabc3c5631eb0dd47.1443076693.git.lv.zheng@intel.com>
References: <cover.1443076693.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443076693.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

1. acpi_ec_remove_query_handlers()
This patch refines the query handler removal logic implemented in
acpi_ec_remove_query_handler(), making it to invoke new
acpi_ec_remove_query_handlers() API, and ensuring all other removal code
paths to invoke the new API to honor the reference count of the query
handlers.

2. acpi_ec_get_query_handler_by_value()
This patch also refines the query handler search logic originally
implemented in acpi_ec_query(), collecting it into
acpi_ec_get_query_handler_by_value(). And since schedule_work() can ensure
the serilization of acpi_ec_event_handler(), we needn't put the
mutex_lock() around schedule_work().

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   73 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 42c66b6..ddaaa9d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -929,6 +929,23 @@ acpi_ec_get_query_handler(struct acpi_ec_query_handler *handler)
 	return handler;
 }
 
+static struct acpi_ec_query_handler *
+acpi_ec_get_query_handler_by_value(struct acpi_ec *ec, u8 value)
+{
+	struct acpi_ec_query_handler *handler;
+	bool found = false;
+
+	mutex_lock(&ec->mutex);
+	list_for_each_entry(handler, &ec->list, node) {
+		if (value == handler->query_bit) {
+			found = true;
+			break;
+		}
+	}
+	mutex_unlock(&ec->mutex);
+	return found ? acpi_ec_get_query_handler(handler) : NULL;
+}
+
 static void acpi_ec_query_handler_release(struct kref *kref)
 {
 	struct acpi_ec_query_handler *handler =
@@ -964,14 +981,15 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 }
 EXPORT_SYMBOL_GPL(acpi_ec_add_query_handler);
 
-void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
+static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
+					  bool remove_all, u8 query_bit)
 {
 	struct acpi_ec_query_handler *handler, *tmp;
 	LIST_HEAD(free_list);
 
 	mutex_lock(&ec->mutex);
 	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
-		if (query_bit == handler->query_bit) {
+		if (remove_all || query_bit == handler->query_bit) {
 			list_del_init(&handler->node);
 			list_add(&handler->node, &free_list);
 		}
@@ -980,6 +998,11 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 	list_for_each_entry_safe(handler, tmp, &free_list, node)
 		acpi_ec_put_query_handler(handler);
 }
+
+void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
+{
+	acpi_ec_remove_query_handlers(ec, false, query_bit);
+}
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
 static struct acpi_ec_query *acpi_ec_create_query(u8 *pval)
@@ -1025,7 +1048,6 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 {
 	u8 value = 0;
 	int result;
-	struct acpi_ec_query_handler *handler;
 	struct acpi_ec_query *q;
 
 	q = acpi_ec_create_query(&value);
@@ -1043,25 +1065,26 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 	if (result)
 		goto err_exit;
 
-	mutex_lock(&ec->mutex);
-	result = -ENODATA;
-	list_for_each_entry(handler, &ec->list, node) {
-		if (value == handler->query_bit) {
-			result = 0;
-			q->handler = acpi_ec_get_query_handler(handler);
-			ec_dbg_evt("Query(0x%02x) scheduled",
-				   q->handler->query_bit);
-			/*
-			 * It is reported that _Qxx are evaluated in a
-			 * parallel way on Windows:
-			 * https://bugzilla.kernel.org/show_bug.cgi?id=94411
-			 */
-			if (!schedule_work(&q->work))
-				result = -EBUSY;
-			break;
-		}
+	q->handler = acpi_ec_get_query_handler_by_value(ec, value);
+	if (!q->handler) {
+		result = -ENODATA;
+		goto err_exit;
+	}
+
+	/*
+	 * It is reported that _Qxx are evaluated in a parallel way on
+	 * Windows:
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=94411
+	 *
+	 * Put this log entry before schedule_work() in order to make
+	 * it appearing before any other log entries occurred during the
+	 * work queue execution.
+	 */
+	ec_dbg_evt("Query(0x%02x) scheduled", value);
+	if (!schedule_work(&q->work)) {
+		ec_dbg_evt("Query(0x%02x) overlapped", value);
+		result = -EBUSY;
 	}
-	mutex_unlock(&ec->mutex);
 
 err_exit:
 	if (result && q)
@@ -1354,19 +1377,13 @@ static int acpi_ec_add(struct acpi_device *device)
 static int acpi_ec_remove(struct acpi_device *device)
 {
 	struct acpi_ec *ec;
-	struct acpi_ec_query_handler *handler, *tmp;
 
 	if (!device)
 		return -EINVAL;
 
 	ec = acpi_driver_data(device);
 	ec_remove_handlers(ec);
-	mutex_lock(&ec->mutex);
-	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
-		list_del(&handler->node);
-		kfree(handler);
-	}
-	mutex_unlock(&ec->mutex);
+	acpi_ec_remove_query_handlers(ec, true, 0);
 	release_region(ec->data_addr, 1);
 	release_region(ec->command_addr, 1);
 	device->driver_data = NULL;
-- 
1.7.10
