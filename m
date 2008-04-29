From: Len Brown <lenb@kernel.org>
Subject: [PATCH 007/171] ACPI: EC: Detect irq storm
Date: Tue, 29 Apr 2008 04:43:58 -0400
Message-ID: <fa95ba04e6ba11d71e1b87becd054b38faf546c8.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:65020 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759809AbYD2Iop (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:45 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Problem seems to be that hw fails to clear GPE after we service it and write 1
into corresponding bit. Thus, as soon as we get interrupts enabled again, we
receive a new one. Google gives too many results for "acer interrupt storm" for
this being one-broken-machine case.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9998

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index da67d22..f0e8216 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -106,6 +106,7 @@ static struct acpi_ec {
 	wait_queue_head_t wait;
 	struct list_head list;
 	struct delayed_work work;
+	atomic_t irq_count;
 	u8 handlers_installed;
 } *boot_ec, *first_ec;
 
@@ -171,6 +172,7 @@ static void ec_switch_to_poll_mode(struct acpi_ec *ec)
 
 static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 {
+	atomic_set(&ec->irq_count, 0);
 	if (likely(test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) &&
 	    likely(!force_poll)) {
 		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
@@ -489,6 +491,12 @@ static u32 acpi_ec_gpe_handler(void *data)
 	u8 state = acpi_ec_read_status(ec);
 
 	pr_debug(PREFIX "~~~> interrupt\n");
+	atomic_inc(&ec->irq_count);
+	if (atomic_read(&ec->irq_count) > 5) {
+		pr_err(PREFIX "GPE storm detected, disabling EC GPE\n");
+		ec_switch_to_poll_mode(ec);
+		goto end;
+	}
 	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
 		wake_up(&ec->wait);
@@ -507,6 +515,7 @@ static u32 acpi_ec_gpe_handler(void *data)
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 		clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 	}
+end:
 	ec_schedule_ec_poll(ec);
 	return ACPI_SUCCESS(status) ?
 	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
@@ -515,6 +524,7 @@ static u32 acpi_ec_gpe_handler(void *data)
 static void do_ec_poll(struct work_struct *work)
 {
 	struct acpi_ec *ec = container_of(work, struct acpi_ec, work.work);
+	atomic_set(&ec->irq_count, 0);
 	(void)acpi_ec_gpe_handler(ec);
 }
 
@@ -679,6 +689,7 @@ static struct acpi_ec *make_acpi_ec(void)
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
 	INIT_DELAYED_WORK_DEFERRABLE(&ec->work, do_ec_poll);
+	atomic_set(&ec->irq_count, 0);
 	return ec;
 }
 
-- 
1.5.5.1.99.gf0ec4

