From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 5/6] ACPI/EC: Fix issues related to the SCI_EVT handling
Date: Fri, 19 Dec 2014 14:00:04 +0800
Message-ID: <e2c5e229280cffdcc81f5eedd9915e1a6744c121.1418966602.git.lv.zheng@intel.com>
References: <cover.1418966602.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36748 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbaLSGAY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2014 01:00:24 -0500
In-Reply-To: <cover.1418966602.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch fixes 2 issues related to the draining behavior. But it doesn't
implement the draining support, it only cleans up code so that further
draining support is possible.

The draining behavior is expected by some platforms (for example, Samsung)
where SCI_EVT is set only once for a set of events and might be cleared for
the very first QR_EC command issued after SCI_EVT is set. EC firmware on
such platforms will return 0x00 to indicate "no outstanding event". Thus
after seeing an SCI_EVT indication, EC driver need to fetch events until
0x00 returned (see acpi_ec_clear()).

Issue 1 - acpi_ec_submit_query():
It's reported on Samsung laptops that SCI_EVT isn't checked when the
transactions are advanced in ec_poll(), which leads to SCI_EVT triggering
source lost:
 If no EC GPE IRQs are arrived after that, EC driver cannot detect this
 event and handle it.
See comment 244/247 for kernel bugzilla 44161.
This patch fixes this issue by moving SCI_EVT checks into
advance_transaction(). So that SCI_EVT is checked each time we are going to
handle the EC firmware indications. And this check will happen for both IRQ
context and task context.
Since after doing that, SCI_EVT is also checked after completing a
transaction, ec_check_sci() and ec_check_sci_sync() can be removed.

Issue 2 - acpi_ec_complete_query():
We expect to clear EC_FLAGS_QUERY_PENDING to allow queuing another draining
QR_EC after writing a QR_EC command and before reading the event. After
reading the event, SCI_EVT might be cleared by the firmware, thus it may
not be possible to queue such a draining QR_EC at that time.
But putting the EC_FLAGS_QUERY_PENDING clearing code after
start_transaction() is wrong as there are chances that after
start_transaction(), QR_EC can fail to be sent. If this happens,
EC_FLAG_QUERY_PENDING will be cleared earlier. As a consequence, the
draining QR_EC will also be queued earlier than expected.
This patch also moves this code into advance_transaction() where QR_EC is
just sent (ACPI_EC_COMMAND_POLL flagged) to fix this issue.

Notes:
1. After introducing the 2 SCI_EVT related handlings into
   advance_transaction(), a next QR_EC can be queued right after writing
   the current QR_EC command and before reading the event. But this still
   hasn't implemented the draining behavior as the draining support
   requires:
     If a previous returned event value isn't 0x00, a draining QR_EC need
     to be issued even when SCI_EVT isn't set.
2. In this patch, acpi_os_execute() is also converted into a seperate work
   item to avoid invoking kmalloc() in the atomic context. We can do this
   because of the previous global lock fix.
3. Originally, EC_FLAGS_EVENT_PENDING is also used to avoid queuing up
   multiple work items (created by acpi_os_execute()), this can be covered
   by only using a single work item. But this patch still keeps this flag
   as there are different usages in the driver initialization steps relying
   on this flag.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=44161
Reported-by: Kieran Clancy <clancy.kieran@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c       |   59 ++++++++++++++++++++---------------------------
 drivers/acpi/internal.h |    1 +
 2 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3c97122..89e89b2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -120,6 +120,8 @@ struct transaction {
 	u8 flags;
 };
 
+static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data);
+
 struct acpi_ec *boot_ec, *first_ec;
 EXPORT_SYMBOL(first_ec);
 
@@ -189,6 +191,22 @@ static const char *acpi_ec_cmd_string(u8 cmd)
 #define acpi_ec_cmd_string(cmd)		"UNDEF"
 #endif
 
+static void acpi_ec_submit_query(struct acpi_ec *ec)
+{
+	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
+		pr_debug("***** Event started *****\n");
+		schedule_work(&ec->work);
+	}
+}
+
+static void acpi_ec_complete_query(struct acpi_ec *ec)
+{
+	if (ec->curr->command == ACPI_EC_COMMAND_QUERY) {
+		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+		pr_debug("***** Event stopped *****\n");
+	}
+}
+
 static int ec_transaction_completed(struct acpi_ec *ec)
 {
 	unsigned long flags;
@@ -242,6 +260,7 @@ static void advance_transaction(struct acpi_ec *ec)
 		    !(status & ACPI_EC_FLAG_SCI) &&
 		    (t->command == ACPI_EC_COMMAND_QUERY)) {
 			t->flags |= ACPI_EC_COMMAND_POLL;
+			acpi_ec_complete_query(ec);
 			t->rdata[t->ri++] = 0x00;
 			t->flags |= ACPI_EC_COMMAND_COMPLETE;
 			pr_debug("***** Command(%s) software completion *****\n",
@@ -250,6 +269,7 @@ static void advance_transaction(struct acpi_ec *ec)
 		} else if ((status & ACPI_EC_FLAG_IBF) == 0) {
 			acpi_ec_write_cmd(ec, t->command);
 			t->flags |= ACPI_EC_COMMAND_POLL;
+			acpi_ec_complete_query(ec);
 		} else
 			goto err;
 		goto out;
@@ -264,6 +284,8 @@ err:
 			++t->irq_count;
 	}
 out:
+	if (status & ACPI_EC_FLAG_SCI)
+		acpi_ec_submit_query(ec);
 	if (wakeup && in_interrupt())
 		wake_up(&ec->wait);
 }
@@ -275,17 +297,6 @@ static void start_transaction(struct acpi_ec *ec)
 	advance_transaction(ec);
 }
 
-static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data);
-
-static int ec_check_sci_sync(struct acpi_ec *ec, u8 state)
-{
-	if (state & ACPI_EC_FLAG_SCI) {
-		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
-			return acpi_ec_sync_query(ec, NULL);
-	}
-	return 0;
-}
-
 static int ec_poll(struct acpi_ec *ec)
 {
 	unsigned long flags;
@@ -333,10 +344,6 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	pr_debug("***** Command(%s) started *****\n",
 		 acpi_ec_cmd_string(t->command));
 	start_transaction(ec);
-	if (ec->curr->command == ACPI_EC_COMMAND_QUERY) {
-		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-		pr_debug("***** Event stopped *****\n");
-	}
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	ret = ec_poll(ec);
 	spin_lock_irqsave(&ec->lock, tmp);
@@ -376,8 +383,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 
 	status = acpi_ec_transaction_unlocked(ec, t);
 
-	/* check if we received SCI during transaction */
-	ec_check_sci_sync(ec, acpi_ec_read_status(ec));
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
 		msleep(1);
 		/* It is safe to enable the GPE outside of the transaction. */
@@ -687,14 +692,12 @@ static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data)
 	return result;
 }
 
-static void acpi_ec_gpe_query(void *ec_cxt)
+static void acpi_ec_gpe_poller(struct work_struct *work)
 {
-	struct acpi_ec *ec = ec_cxt;
 	acpi_status status;
 	u32 glk;
+	struct acpi_ec *ec = container_of(work, struct acpi_ec, work);
 
-	if (!ec)
-		return;
 	mutex_lock(&ec->mutex);
 	if (ec->global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
@@ -708,18 +711,6 @@ unlock:
 	mutex_unlock(&ec->mutex);
 }
 
-static int ec_check_sci(struct acpi_ec *ec, u8 state)
-{
-	if (state & ACPI_EC_FLAG_SCI) {
-		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
-			pr_debug("***** Event started *****\n");
-			return acpi_os_execute(OSL_NOTIFY_HANDLER,
-				acpi_ec_gpe_query, ec);
-		}
-	}
-	return 0;
-}
-
 static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
 	u32 gpe_number, void *data)
 {
@@ -729,7 +720,6 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
 	spin_lock_irqsave(&ec->lock, flags);
 	advance_transaction(ec);
 	spin_unlock_irqrestore(&ec->lock, flags);
-	ec_check_sci(ec, acpi_ec_read_status(ec));
 	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
 }
 
@@ -793,6 +783,7 @@ static struct acpi_ec *make_acpi_ec(void)
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
 	spin_lock_init(&ec->lock);
+	INIT_WORK(&ec->work, acpi_ec_gpe_poller);
 	return ec;
 }
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 163e82f..dc42078 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -127,6 +127,7 @@ struct acpi_ec {
 	struct list_head list;
 	struct transaction *curr;
 	spinlock_t lock;
+	struct work_struct work;
 };
 
 extern struct acpi_ec *first_ec;
-- 
1.7.10

