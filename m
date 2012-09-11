From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 2/5] ACPI: EC: Cleanup the member name for spinlock/mutex in struct acpi_ec
Date: Tue, 11 Sep 2012 21:10:19 +0800
Message-ID: <1347369022-10176-2-git-send-email-feng.tang@intel.com>
References: <1347369022-10176-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34072 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278Ab2IKNQV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Sep 2012 09:16:21 -0400
In-Reply-To: <1347369022-10176-1-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Renninger <trenn@suse.de>, Bob Moore <robert.moore@intel.com>, Feng Tang <feng.tang@intel.com>

Current member names for mutex/spinlock are a little confusing.

Change the
{
	struct mutex lock;
	spinlock_t curr_lock;
}
to
{
	struct mutex mutex;
	spinlock_t lock;
}

So that the code is cleaner and easier to read.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/acpi/ec.c       |   52 +++++++++++++++++++++++-----------------------
 drivers/acpi/internal.h |    4 +-
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 615264c..4efd97f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -158,10 +158,10 @@ static int ec_transaction_done(struct acpi_ec *ec)
 {
 	unsigned long flags;
 	int ret = 0;
-	spin_lock_irqsave(&ec->curr_lock, flags);
+	spin_lock_irqsave(&ec->lock, flags);
 	if (!ec->curr || ec->curr->done)
 		ret = 1;
-	spin_unlock_irqrestore(&ec->curr_lock, flags);
+	spin_unlock_irqrestore(&ec->lock, flags);
 	return ret;
 }
 
@@ -175,7 +175,7 @@ static void start_transaction(struct acpi_ec *ec)
 static void advance_transaction(struct acpi_ec *ec, u8 status)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&ec->curr_lock, flags);
+	spin_lock_irqsave(&ec->lock, flags);
 	if (!ec->curr)
 		goto unlock;
 	if (ec->curr->wlen > ec->curr->wi) {
@@ -200,7 +200,7 @@ err:
 	if (in_interrupt())
 		++ec->curr->irq_count;
 unlock:
-	spin_unlock_irqrestore(&ec->curr_lock, flags);
+	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
 static int acpi_ec_sync_query(struct acpi_ec *ec);
@@ -238,9 +238,9 @@ static int ec_poll(struct acpi_ec *ec)
 		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF)
 			break;
 		pr_debug(PREFIX "controller reset, restart transaction\n");
-		spin_lock_irqsave(&ec->curr_lock, flags);
+		spin_lock_irqsave(&ec->lock, flags);
 		start_transaction(ec);
-		spin_unlock_irqrestore(&ec->curr_lock, flags);
+		spin_unlock_irqrestore(&ec->lock, flags);
 	}
 	return -ETIME;
 }
@@ -253,17 +253,17 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	if (EC_FLAGS_MSI)
 		udelay(ACPI_EC_MSI_UDELAY);
 	/* start transaction */
-	spin_lock_irqsave(&ec->curr_lock, tmp);
+	spin_lock_irqsave(&ec->lock, tmp);
 	/* following two actions should be kept atomic */
 	ec->curr = t;
 	start_transaction(ec);
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	spin_unlock_irqrestore(&ec->curr_lock, tmp);
+	spin_unlock_irqrestore(&ec->lock, tmp);
 	ret = ec_poll(ec);
-	spin_lock_irqsave(&ec->curr_lock, tmp);
+	spin_lock_irqsave(&ec->lock, tmp);
 	ec->curr = NULL;
-	spin_unlock_irqrestore(&ec->curr_lock, tmp);
+	spin_unlock_irqrestore(&ec->lock, tmp);
 	return ret;
 }
 
@@ -292,7 +292,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 		return -EINVAL;
 	if (t->rdata)
 		memset(t->rdata, 0, t->rlen);
-	mutex_lock(&ec->lock);
+	mutex_lock(&ec->mutex);
 	if (test_bit(EC_FLAGS_BLOCKED, &ec->flags)) {
 		status = -EINVAL;
 		goto unlock;
@@ -335,7 +335,7 @@ end:
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 unlock:
-	mutex_unlock(&ec->lock);
+	mutex_unlock(&ec->mutex);
 	return status;
 }
 
@@ -468,10 +468,10 @@ void acpi_ec_block_transactions(void)
 	if (!ec)
 		return;
 
-	mutex_lock(&ec->lock);
+	mutex_lock(&ec->mutex);
 	/* Prevent transactions from being carried out */
 	set_bit(EC_FLAGS_BLOCKED, &ec->flags);
-	mutex_unlock(&ec->lock);
+	mutex_unlock(&ec->mutex);
 }
 
 void acpi_ec_unblock_transactions(void)
@@ -481,10 +481,10 @@ void acpi_ec_unblock_transactions(void)
 	if (!ec)
 		return;
 
-	mutex_lock(&ec->lock);
+	mutex_lock(&ec->mutex);
 	/* Allow transactions to be carried out again */
 	clear_bit(EC_FLAGS_BLOCKED, &ec->flags);
-	mutex_unlock(&ec->lock);
+	mutex_unlock(&ec->mutex);
 }
 
 void acpi_ec_unblock_transactions_early(void)
@@ -536,9 +536,9 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 	handler->handle = handle;
 	handler->func = func;
 	handler->data = data;
-	mutex_lock(&ec->lock);
+	mutex_lock(&ec->mutex);
 	list_add(&handler->node, &ec->list);
-	mutex_unlock(&ec->lock);
+	mutex_unlock(&ec->mutex);
 	return 0;
 }
 
@@ -547,14 +547,14 @@ EXPORT_SYMBOL_GPL(acpi_ec_add_query_handler);
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	struct acpi_ec_query_handler *handler, *tmp;
-	mutex_lock(&ec->lock);
+	mutex_lock(&ec->mutex);
 	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
 		if (query_bit == handler->query_bit) {
 			list_del(&handler->node);
 			kfree(handler);
 		}
 	}
-	mutex_unlock(&ec->lock);
+	mutex_unlock(&ec->mutex);
 }
 
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
@@ -601,9 +601,9 @@ static void acpi_ec_gpe_query(void *ec_cxt)
 	struct acpi_ec *ec = ec_cxt;
 	if (!ec)
 		return;
-	mutex_lock(&ec->lock);
+	mutex_lock(&ec->mutex);
 	acpi_ec_sync_query(ec);
-	mutex_unlock(&ec->lock);
+	mutex_unlock(&ec->mutex);
 }
 
 static int ec_check_sci(struct acpi_ec *ec, u8 state)
@@ -691,10 +691,10 @@ static struct acpi_ec *make_acpi_ec(void)
 	if (!ec)
 		return NULL;
 	ec->flags = 1 << EC_FLAGS_QUERY_PENDING;
-	mutex_init(&ec->lock);
+	mutex_init(&ec->mutex);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
-	spin_lock_init(&ec->curr_lock);
+	spin_lock_init(&ec->lock);
 	return ec;
 }
 
@@ -853,12 +853,12 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 
 	ec = acpi_driver_data(device);
 	ec_remove_handlers(ec);
-	mutex_lock(&ec->lock);
+	mutex_lock(&ec->mutex);
 	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
 		list_del(&handler->node);
 		kfree(handler);
 	}
-	mutex_unlock(&ec->lock);
+	mutex_unlock(&ec->mutex);
 	release_region(ec->data_addr, 1);
 	release_region(ec->command_addr, 1);
 	device->driver_data = NULL;
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ca75b9c..509dcaa 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -58,11 +58,11 @@ struct acpi_ec {
 	unsigned long data_addr;
 	unsigned long global_lock;
 	unsigned long flags;
-	struct mutex lock;
+	struct mutex mutex;
 	wait_queue_head_t wait;
 	struct list_head list;
 	struct transaction *curr;
-	spinlock_t curr_lock;
+	spinlock_t lock;
 };
 
 extern struct acpi_ec *first_ec;
-- 
1.7.1

