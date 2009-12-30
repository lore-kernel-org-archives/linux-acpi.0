From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/6] ACPI: EC: Accelerate query execution
Date: Wed, 30 Dec 2009 02:41:21 -0500
Message-ID: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1262158615.git.len.brown@intel.com>
References: <1262158882-9713-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:51306 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbZL3Hlm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:41:42 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG00JXAG12BHOC@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:41:27 -0600 (CST)
In-reply-to: <1262158882-9713-1-git-send-email-lenb@kernel.org>
In-reply-to: <4c291b9021e33aac046ee8abeb9ea8fe76086342.1262158615.git.len.brown@intel.com>
References: <4c291b9021e33aac046ee8abeb9ea8fe76086342.1262158615.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Split EC query handling into acknowledge and execution phase.
This allows much smaller pending query lattency and lowers chances
of EC going "wild" and losing events.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=14858

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |  122 +++++++++++++++++++++++++++++++++-------------------
 1 files changed, 77 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index fd1801b..9cc3885 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -201,14 +201,13 @@ unlock:
 	spin_unlock_irqrestore(&ec->curr_lock, flags);
 }
 
-static void acpi_ec_gpe_query(void *ec_cxt);
+static int acpi_ec_sync_query(struct acpi_ec *ec);
 
-static int ec_check_sci(struct acpi_ec *ec, u8 state)
+static int ec_check_sci_sync(struct acpi_ec *ec, u8 state)
 {
 	if (state & ACPI_EC_FLAG_SCI) {
 		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
-			return acpi_os_execute(OSL_EC_BURST_HANDLER,
-				acpi_ec_gpe_query, ec);
+			return acpi_ec_sync_query(ec);
 	}
 	return 0;
 }
@@ -249,11 +248,6 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 {
 	unsigned long tmp;
 	int ret = 0;
-	pr_debug(PREFIX "transaction start\n");
-	/* disable GPE during transaction if storm is detected */
-	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-		acpi_disable_gpe(NULL, ec->gpe);
-	}
 	if (EC_FLAGS_MSI)
 		udelay(ACPI_EC_MSI_UDELAY);
 	/* start transaction */
@@ -269,16 +263,6 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	spin_lock_irqsave(&ec->curr_lock, tmp);
 	ec->curr = NULL;
 	spin_unlock_irqrestore(&ec->curr_lock, tmp);
-	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-		/* check if we received SCI during transaction */
-		ec_check_sci(ec, acpi_ec_read_status(ec));
-		/* it is safe to enable GPE outside of transaction */
-		acpi_enable_gpe(NULL, ec->gpe);
-	} else if (t->irq_count > ACPI_EC_STORM_THRESHOLD) {
-		pr_info(PREFIX "GPE storm detected, "
-			"transactions will use polling mode\n");
-		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
-	}
 	return ret;
 }
 
@@ -321,7 +305,24 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 		status = -ETIME;
 		goto end;
 	}
+	pr_debug(PREFIX "transaction start\n");
+	/* disable GPE during transaction if storm is detected */
+	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+		acpi_disable_gpe(NULL, ec->gpe);
+	}
+
 	status = acpi_ec_transaction_unlocked(ec, t);
+
+	/* check if we received SCI during transaction */
+	ec_check_sci_sync(ec, acpi_ec_read_status(ec));
+	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+		/* it is safe to enable GPE outside of transaction */
+		acpi_enable_gpe(NULL, ec->gpe);
+	} else if (t->irq_count > ACPI_EC_STORM_THRESHOLD) {
+		pr_info(PREFIX "GPE storm detected, "
+			"transactions will use polling mode\n");
+		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
+	}
 end:
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -443,7 +444,7 @@ int ec_transaction(u8 command,
 
 EXPORT_SYMBOL(ec_transaction);
 
-static int acpi_ec_query(struct acpi_ec *ec, u8 * data)
+static int acpi_ec_query_unlocked(struct acpi_ec *ec, u8 * data)
 {
 	int result;
 	u8 d;
@@ -452,20 +453,16 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 * data)
 				.wlen = 0, .rlen = 1};
 	if (!ec || !data)
 		return -EINVAL;
-
 	/*
 	 * Query the EC to find out which _Qxx method we need to evaluate.
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-
-	result = acpi_ec_transaction(ec, &t);
+	result = acpi_ec_transaction_unlocked(ec, &t);
 	if (result)
 		return result;
-
 	if (!d)
 		return -ENODATA;
-
 	*data = d;
 	return 0;
 }
@@ -509,43 +506,78 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-static void acpi_ec_gpe_query(void *ec_cxt)
+static void acpi_ec_run(void *cxt)
 {
-	struct acpi_ec *ec = ec_cxt;
-	u8 value = 0;
-	struct acpi_ec_query_handler *handler, copy;
-
-	if (!ec || acpi_ec_query(ec, &value))
+	struct acpi_ec_query_handler *handler = cxt;
+	if (!handler)
 		return;
-	mutex_lock(&ec->lock);
+	pr_debug(PREFIX "start query execution\n");
+	if (handler->func)
+		handler->func(handler->data);
+	else if (handler->handle)
+		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
+	pr_debug(PREFIX "stop query execution\n");
+	kfree(handler);
+}
+
+static int acpi_ec_sync_query(struct acpi_ec *ec)
+{
+	u8 value = 0;
+	int status;
+	struct acpi_ec_query_handler *handler, *copy;
+	if ((status = acpi_ec_query_unlocked(ec, &value)))
+		return status;
 	list_for_each_entry(handler, &ec->list, node) {
 		if (value == handler->query_bit) {
 			/* have custom handler for this bit */
-			memcpy(&copy, handler, sizeof(copy));
-			mutex_unlock(&ec->lock);
-			if (copy.func) {
-				copy.func(copy.data);
-			} else if (copy.handle) {
-				acpi_evaluate_object(copy.handle, NULL, NULL, NULL);
-			}
-			return;
+			copy = kmalloc(sizeof(*handler), GFP_KERNEL);
+			if (!copy)
+				return -ENOMEM;
+			memcpy(copy, handler, sizeof(*copy));
+			pr_debug(PREFIX "push query execution (0x%2x) on queue\n", value);
+			return acpi_os_execute(OSL_GPE_HANDLER,
+				acpi_ec_run, copy);
 		}
 	}
+	return 0;
+}
+
+static void acpi_ec_gpe_query(void *ec_cxt)
+{
+	struct acpi_ec *ec = ec_cxt;
+	if (!ec)
+		return;
+	mutex_lock(&ec->lock);
+	acpi_ec_sync_query(ec);
 	mutex_unlock(&ec->lock);
 }
 
+static void acpi_ec_gpe_query(void *ec_cxt);
+
+static int ec_check_sci(struct acpi_ec *ec, u8 state)
+{
+	if (state & ACPI_EC_FLAG_SCI) {
+		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
+			pr_debug(PREFIX "push gpe query to the queue\n");
+			return acpi_os_execute(OSL_NOTIFY_HANDLER,
+				acpi_ec_gpe_query, ec);
+		}
+	}
+	return 0;
+}
+
 static u32 acpi_ec_gpe_handler(void *data)
 {
 	struct acpi_ec *ec = data;
-	u8 status;
 
 	pr_debug(PREFIX "~~~> interrupt\n");
-	status = acpi_ec_read_status(ec);
 
-	advance_transaction(ec, status);
-	if (ec_transaction_done(ec) && (status & ACPI_EC_FLAG_IBF) == 0)
+	advance_transaction(ec, acpi_ec_read_status(ec));
+	if (ec_transaction_done(ec) &&
+	    (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF) == 0) {
 		wake_up(&ec->wait);
-	ec_check_sci(ec, status);
+		ec_check_sci(ec, acpi_ec_read_status(ec));
+	}
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-- 
1.6.0.6

