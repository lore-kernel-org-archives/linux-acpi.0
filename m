From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 6/6] ACPI/EC: Cleanup QR_EC related code
Date: Wed, 14 Jan 2015 19:28:53 +0800
Message-ID: <6ad483d819ef1f2d5516512056968a0df2b2cf77.1421234254.git.lv.zheng@intel.com>
References: <cover.1418966602.git.lv.zheng@intel.com> <cover.1421234254.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34787 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbbAND2z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Jan 2015 22:28:55 -0500
In-Reply-To: <cover.1421234254.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The QR_EC related code pieces have redundants, this patch merges them into
acpi_ec_query() which invokes acpi_ec_transaction() where EC mutex and the
global lock are already held. After doing so, query handler traversal still
need to be locked by EC mutex after invoking acpi_ec_transaction().

Note that EC event handling is sequential. We fetch one event from firmware
event queue and process it until 0x00 or error returned. So we don't need
to hold mutex for whole acpi_ec_clear() process to determine whether we
should continue to drain. And for the same reason, we don't need to hold
mutex for the whole procedure from the QR_EC transaction to the query
handler traversal.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   70 +++++++++++++++--------------------------------------
 1 file changed, 20 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 89e89b2..c385606 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -120,7 +120,7 @@ struct transaction {
 	u8 flags;
 };
 
-static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data);
+static int acpi_ec_query(struct acpi_ec *ec, u8 *data);
 
 struct acpi_ec *boot_ec, *first_ec;
 EXPORT_SYMBOL(first_ec);
@@ -508,7 +508,7 @@ static void acpi_ec_clear(struct acpi_ec *ec)
 	u8 value = 0;
 
 	for (i = 0; i < ACPI_EC_CLEAR_MAX; i++) {
-		status = acpi_ec_sync_query(ec, &value);
+		status = acpi_ec_query(ec, &value);
 		if (status || !value)
 			break;
 	}
@@ -539,14 +539,11 @@ void acpi_ec_unblock_transactions(void)
 	if (!ec)
 		return;
 
-	mutex_lock(&ec->mutex);
 	/* Allow transactions to be carried out again */
 	clear_bit(EC_FLAGS_BLOCKED, &ec->flags);
 
 	if (EC_FLAGS_CLEAR_ON_RESUME)
 		acpi_ec_clear(ec);
-
-	mutex_unlock(&ec->mutex);
 }
 
 void acpi_ec_unblock_transactions_early(void)
@@ -559,30 +556,6 @@ void acpi_ec_unblock_transactions_early(void)
 		clear_bit(EC_FLAGS_BLOCKED, &first_ec->flags);
 }
 
-static int acpi_ec_query_unlocked(struct acpi_ec *ec, u8 *data)
-{
-	int result;
-	u8 d;
-	struct transaction t = {.command = ACPI_EC_COMMAND_QUERY,
-				.wdata = NULL, .rdata = &d,
-				.wlen = 0, .rlen = 1};
-
-	if (!ec || !data)
-		return -EINVAL;
-	/*
-	 * Query the EC to find out which _Qxx method we need to evaluate.
-	 * Note that successful completion of the query causes the ACPI_EC_SCI
-	 * bit to be cleared (and thus clearing the interrupt source).
-	 */
-	result = acpi_ec_transaction_unlocked(ec, &t);
-	if (result)
-		return result;
-	if (!d)
-		return -ENODATA;
-	*data = d;
-	return 0;
-}
-
 /* --------------------------------------------------------------------------
                                 Event Management
    -------------------------------------------------------------------------- */
@@ -662,19 +635,30 @@ static void acpi_ec_run(void *cxt)
 	acpi_ec_put_query_handler(handler);
 }
 
-static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data)
+static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 {
 	u8 value = 0;
 	int result;
 	acpi_status status;
 	struct acpi_ec_query_handler *handler;
+	struct transaction t = {.command = ACPI_EC_COMMAND_QUERY,
+				.wdata = NULL, .rdata = &value,
+				.wlen = 0, .rlen = 1};
 
-	result = acpi_ec_query_unlocked(ec, &value);
-	if (data)
-		*data = value;
+	/*
+	 * Query the EC to find out which _Qxx method we need to evaluate.
+	 * Note that successful completion of the query causes the ACPI_EC_SCI
+	 * bit to be cleared (and thus clearing the interrupt source).
+	 */
+	result = acpi_ec_transaction(ec, &t);
 	if (result)
 		return result;
+	if (data)
+		*data = value;
+	if (!value)
+		return -ENODATA;
 
+	mutex_lock(&ec->mutex);
 	list_for_each_entry(handler, &ec->list, node) {
 		if (value == handler->query_bit) {
 			/* have custom handler for this bit */
@@ -689,26 +673,15 @@ static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data)
 			break;
 		}
 	}
+	mutex_unlock(&ec->mutex);
 	return result;
 }
 
 static void acpi_ec_gpe_poller(struct work_struct *work)
 {
-	acpi_status status;
-	u32 glk;
 	struct acpi_ec *ec = container_of(work, struct acpi_ec, work);
 
-	mutex_lock(&ec->mutex);
-	if (ec->global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			goto unlock;
-	}
-	acpi_ec_sync_query(ec, NULL);
-	if (ec->global_lock)
-		acpi_release_global_lock(glk);
-unlock:
-	mutex_unlock(&ec->mutex);
+	acpi_ec_query(ec, NULL);
 }
 
 static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
@@ -932,11 +905,8 @@ static int acpi_ec_add(struct acpi_device *device)
 	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 
 	/* Clear stale _Q events if hardware might require that */
-	if (EC_FLAGS_CLEAR_ON_RESUME) {
-		mutex_lock(&ec->mutex);
+	if (EC_FLAGS_CLEAR_ON_RESUME)
 		acpi_ec_clear(ec);
-		mutex_unlock(&ec->mutex);
-	}
 	return ret;
 }
 
-- 
1.7.10

