From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch 4/4]  ACPI : EC cleanup:Delete the unused function and data
	declaration
Date: Mon, 03 Nov 2008 16:58:34 +0800
Message-ID: <1225702714.26020.57.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42405 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817AbYKCIvm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Nov 2008 03:51:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Subject: ACPI: EC cleanup:Delete the unused function and data declaration
>From :Zhao Yakui <yakui.zhao@intel.com>

Delete the unused function and data declaration.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/ec.c |   89 ------------------------------------------------------
 1 file changed, 89 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -105,15 +105,6 @@ struct acpi_ec_query_handler {
 	u8 query_bit;
 };
 
-struct transaction {
-	const u8 *wdata;
-	u8 *rdata;
-	unsigned short irq_count;
-	u8 command;
-	u8 wlen;
-	u8 rlen;
-};
-
 static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long gpe;
@@ -126,8 +117,6 @@ static struct acpi_ec {
 	struct mutex lock;
 	wait_queue_head_t wait;
 	struct list_head list;
-	struct transaction *curr;
-	spinlock_t curr_lock;
 	u8 pre_state;
 	/* record the EC status when last EC interrrupt happens */
 	atomic_t ec_irq_count;
@@ -193,43 +182,6 @@ static inline void acpi_ec_write_data(st
 	outb(data, ec->data_addr);
 }
 
-static int ec_transaction_done(struct acpi_ec *ec)
-{
-	unsigned long flags;
-	int ret = 0;
-	spin_lock_irqsave(&ec->curr_lock, flags);
-	if (!ec->curr || (!ec->curr->wlen && !ec->curr->rlen))
-		ret = 1;
-	spin_unlock_irqrestore(&ec->curr_lock, flags);
-	return ret;
-}
-
-static void gpe_transaction(struct acpi_ec *ec, u8 status)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&ec->curr_lock, flags);
-	if (!ec->curr)
-		goto unlock;
-	if (ec->curr->wlen > 0) {
-		if ((status & ACPI_EC_FLAG_IBF) == 0) {
-			acpi_ec_write_data(ec, *(ec->curr->wdata++));
-			--ec->curr->wlen;
-		} else
-			/* false interrupt, state didn't change */
-			++ec->curr->irq_count;
-
-	} else if (ec->curr->rlen > 0) {
-		if ((status & ACPI_EC_FLAG_OBF) == 1) {
-			*(ec->curr->rdata++) = acpi_ec_read_data(ec);
-			--ec->curr->rlen;
-		} else
-			/* false interrupt, state didn't change */
-			++ec->curr->irq_count;
-	}
-unlock:
-	spin_unlock_irqrestore(&ec->curr_lock, flags);
-}
-
 static inline int acpi_ec_check_status(struct acpi_ec *ec,
 			enum ec_event event)
 {
@@ -288,30 +240,7 @@ static int acpi_ec_wait(struct acpi_ec *
 	return -ETIME;
 }
 
-static void acpi_ec_gpe_query(void *ec_cxt);
 
-static int ec_check_sci(struct acpi_ec *ec, u8 state)
-{
-	if (state & ACPI_EC_FLAG_SCI) {
-		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
-			return acpi_os_execute(OSL_EC_BURST_HANDLER,
-				acpi_ec_gpe_query, ec);
-	}
-	return 0;
-}
-
-static int ec_poll(struct acpi_ec *ec)
-{
-	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
-	msleep(1);
-	while (time_before(jiffies, delay)) {
-		gpe_transaction(ec, acpi_ec_read_status(ec));
-		msleep(1);
-		if (ec_transaction_done(ec))
-			return 0;
-	}
-	return -ETIME;
-}
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 					const u8 *wdata, unsigned wdata_len,
 					u8 *rdata, unsigned rdata_len,
@@ -359,23 +288,6 @@ end:
 	return result;
 }
 
-static int ec_check_ibf0(struct acpi_ec *ec)
-{
-	u8 status = acpi_ec_read_status(ec);
-	return (status & ACPI_EC_FLAG_IBF) == 0;
-}
-
-static int ec_wait_ibf0(struct acpi_ec *ec)
-{
-	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
-	/* interrupt wait manually if GPE mode is not active */
-	unsigned long timeout = test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ?
-		msecs_to_jiffies(ACPI_EC_DELAY) : msecs_to_jiffies(1);
-	while (time_before(jiffies, delay))
-		if (wait_event_timeout(ec->wait, ec_check_ibf0(ec), timeout))
-			return 0;
-	return -ETIME;
-}
 
 static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
 			       const u8 *wdata, unsigned wdata_len,
@@ -850,7 +762,6 @@ static struct acpi_ec *make_acpi_ec(void
 	mutex_init(&ec->lock);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
-	spin_lock_init(&ec->curr_lock);
 	ec->pre_jiffies = jiffies;
 	atomic_set(&ec->ec_irq_count, 0);
 	return ec;


