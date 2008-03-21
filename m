From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/6] ACPI: EC: Add poll timer
Date: Fri, 21 Mar 2008 17:07:03 +0300
Message-ID: <20080321140703.30578.3880.stgit@thinkpad.local>
References: <20080321140648.30578.73816.stgit@thinkpad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51631 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753415AbYCUOHP (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 10:07:15 -0400
In-Reply-To: <20080321140648.30578.73816.stgit@thinkpad.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

If we can not use interrupt mode of EC for some reason, start polling
EC for events periodically.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 828c752..63e0ac2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -84,6 +84,7 @@ enum {
 	EC_FLAGS_NO_WDATA_GPE,		/* Don't expect WDATA GPE event */
 	EC_FLAGS_WDATA,			/* Data is being written */
 	EC_FLAGS_NO_OBF1_GPE,		/* Don't expect GPE before read */
+	EC_FLAGS_RESCHEDULE_POLL	/* Re-schedule poll */
 };
 
 static int acpi_ec_remove(struct acpi_device *device, int type);
@@ -130,6 +131,7 @@ static struct acpi_ec {
 	struct mutex lock;
 	wait_queue_head_t wait;
 	struct list_head list;
+	struct delayed_work work;
 	u8 handlers_installed;
 } *boot_ec, *first_ec;
 
@@ -178,6 +180,20 @@ static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
 	return 0;
 }
 
+static void ec_schedule_ec_poll(struct acpi_ec *ec)
+{
+	if (test_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags))
+		schedule_delayed_work(&ec->work,
+				      msecs_to_jiffies(ACPI_EC_DELAY));
+}
+
+static void ec_switch_to_poll_mode(struct acpi_ec *ec)
+{
+	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	set_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
+}
+
 static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 {
 	int ret = 0;
@@ -218,7 +234,8 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 				if (printk_ratelimit())
 					pr_info(PREFIX "missing confirmations, "
 						"switch off interrupt mode.\n");
-				clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+				ec_switch_to_poll_mode(ec);
+				ec_schedule_ec_poll(ec);
 			}
 			goto end;
 		}
@@ -529,28 +546,37 @@ static u32 acpi_ec_gpe_handler(void *data)
 {
 	acpi_status status = AE_OK;
 	struct acpi_ec *ec = data;
+	u8 state = acpi_ec_read_status(ec);
 
 	pr_debug(PREFIX "~~~> interrupt\n");
 	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
 		wake_up(&ec->wait);
 
-	if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_SCI) {
+	if (state & ACPI_EC_FLAG_SCI) {
 		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
 			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
 				acpi_ec_gpe_query, ec);
-	} else if (unlikely(!test_bit(EC_FLAGS_GPE_MODE, &ec->flags))) {
+	} else if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
+		   in_interrupt()) {
 		/* this is non-query, must be confirmation */
 		if (printk_ratelimit())
 			pr_info(PREFIX "non-query interrupt received,"
 				" switching to interrupt mode\n");
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+		clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 	}
-
+	ec_schedule_ec_poll(ec);
 	return ACPI_SUCCESS(status) ?
 	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
 
+static void do_ec_poll(struct work_struct *work)
+{
+	struct acpi_ec *ec = container_of(work, struct acpi_ec, work.work);
+	(void)acpi_ec_gpe_handler(ec);
+}
+
 /* --------------------------------------------------------------------------
                              Address Space Management
    -------------------------------------------------------------------------- */
@@ -711,6 +737,7 @@ static struct acpi_ec *make_acpi_ec(void)
 	mutex_init(&ec->lock);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
+	INIT_DELAYED_WORK_DEFERRABLE(&ec->work, do_ec_poll);
 	return ec;
 }
 
@@ -752,8 +779,15 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	return AE_CTRL_TERMINATE;
 }
 
+static void ec_poll_stop(struct acpi_ec *ec)
+{
+	clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
+	cancel_delayed_work(&ec->work);
+}
+
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
+	ec_poll_stop(ec);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
@@ -899,6 +933,7 @@ static int acpi_ec_start(struct acpi_device *device)
 
 	/* EC is fully operational, allow queries */
 	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+	ec_schedule_ec_poll(ec);
 	return ret;
 }
 

