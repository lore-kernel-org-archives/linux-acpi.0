From: Len Brown <lenb@kernel.org>
Subject: [PATCH 003/171] ACPI: EC: Add poll timer
Date: Tue, 29 Apr 2008 04:43:54 -0400
Message-ID: <845625cdcb17119d5f6c5c8dbe586f2f36e8008a.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:5527 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758125AbYD2Iok (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:40 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

If we can not use interrupt mode of EC for some reason, start polling
EC for events periodically.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
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
 
-- 
1.5.5.1.99.gf0ec4

