From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 6/6] ACPI: EC: Detect irq storm
Date: Fri, 21 Mar 2008 17:07:27 +0300
Message-ID: <20080321140727.30578.54215.stgit@thinkpad.local>
References: <20080321140648.30578.73816.stgit@thinkpad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51714 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754126AbYCUOHp (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 10:07:45 -0400
In-Reply-To: <20080321140648.30578.73816.stgit@thinkpad.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Problem seems to be that hw fails to clear GPE after we service it and write 1
into corresponding bit. Thus, as soon as we get interrupts enabled again, we
receive a new one. Google gives too many results for "acer interrupt storm" for
this being one-broken-machine case.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=9998

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index da67d22..284d421 100644
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
@@ -679,6 +688,7 @@ static struct acpi_ec *make_acpi_ec(void)
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
 	INIT_DELAYED_WORK_DEFERRABLE(&ec->work, do_ec_poll);
+	atomic_set(&ec->irq_count, 0);
 	return ec;
 }
 

