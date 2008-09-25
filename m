From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [Patch 4/4] ACPI: Cleanup some useless code in EC driver
Date: Thu, 25 Sep 2008 11:58:42 +0800
Message-ID: <1222315122.4023.40.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50094 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbYIYDyM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Sep 2008 23:54:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Subject: ACPI: Cleanup some useless code in EC driver
From: Zhao Yakui <yakui.zhao@intel.com>

Cleanup some useless code in EC driver

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/ec.c |   24 ------------------------
 1 file changed, 24 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -82,7 +82,6 @@ enum {
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_MODE,		/* Expect GPE to be sent for status change */
 	EC_FLAGS_NO_GPE,		/* Don't use GPE mode */
-	EC_FLAGS_RESCHEDULE_POLL	/* Re-schedule poll */
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -192,21 +191,6 @@ static inline int acpi_ec_check_status(s
 	return 0;
 }
 
-static void ec_schedule_ec_poll(struct acpi_ec *ec)
-{
-	if (test_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags))
-		schedule_delayed_work(&ec->work,
-				      msecs_to_jiffies(ACPI_EC_DELAY));
-}
-
-static void ec_switch_to_poll_mode(struct acpi_ec *ec)
-{
-	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
-	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-	set_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
-}
-
 static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 {
 	atomic_set(&ec->irq_count, 0);
@@ -613,13 +597,6 @@ static u32 acpi_ec_gpe_handler(void *dat
 	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
 
-static void do_ec_poll(struct work_struct *work)
-{
-	struct acpi_ec *ec = container_of(work, struct acpi_ec, work.work);
-	atomic_set(&ec->irq_count, 0);
-	(void)acpi_ec_gpe_handler(ec);
-}
-
 /* --------------------------------------------------------------------------
                              Address Space Management
    -------------------------------------------------------------------------- */
@@ -771,7 +748,6 @@ static struct acpi_ec *make_acpi_ec(void
 	mutex_init(&ec->lock);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
-	INIT_DELAYED_WORK_DEFERRABLE(&ec->work, do_ec_poll);
 	atomic_set(&ec->irq_count, 0);
 	ec->pre_jiffies = jiffies;
 	atomic_set(&ec->ec_irq_count, 0);


