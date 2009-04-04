From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: [RFC] [PATCH] ACPI: EC: Merge poll and interrupt modes
Date: Sun, 05 Apr 2009 03:35:22 +0400
Message-ID: <49D7EEBA.40203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52815 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbZDDXfZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 19:35:25 -0400
Received: by fxm2 with SMTP id 2so1418502fxm.37
        for <linux-acpi@vger.kernel.org>; Sat, 04 Apr 2009 16:35:22 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

In general, EC transaction should complete in less than 1ms, thus it is 
possible to merge wait for
1ms in poll mode and 1ms of interrupt transaction timeout.
Still, driver will wait 500ms for EC to complete transaction.

This significantly simplifies driver and makes it immune to problematic 
EC interrupt
implementations.

It also may lessen kernel start-up time by 500ms.

References: http://bugzilla.kernel.org/show_bug.cgi?id=12949

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |  125 
+++++++++++++++++++----------------------------------
 1 files changed, 45 insertions(+), 80 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2fe1506..efdc47d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -74,9 +74,6 @@ enum ec_command {
 
 enum {
     EC_FLAGS_QUERY_PENDING,        /* Query is pending */
-    EC_FLAGS_GPE_MODE,        /* Expect GPE to be sent
-                     * for status change */
-    EC_FLAGS_NO_GPE,        /* Don't use GPE mode */
     EC_FLAGS_GPE_STORM,        /* GPE storm detected */
     EC_FLAGS_HANDLERS_INSTALLED    /* Handlers for GPE and
                      * OpReg are installed */
@@ -170,7 +167,7 @@ static void start_transaction(struct acpi_ec *ec)
     acpi_ec_write_cmd(ec, ec->curr->command);
 }
 
-static void gpe_transaction(struct acpi_ec *ec, u8 status)
+static void advance_transaction(struct acpi_ec *ec, u8 status)
 {
     unsigned long flags;
     spin_lock_irqsave(&ec->curr_lock, flags);
@@ -201,29 +198,6 @@ unlock:
     spin_unlock_irqrestore(&ec->curr_lock, flags);
 }
 
-static int acpi_ec_wait(struct acpi_ec *ec)
-{
-    if (wait_event_timeout(ec->wait, ec_transaction_done(ec),
-                   msecs_to_jiffies(ACPI_EC_DELAY)))
-        return 0;
-    /* try restart command if we get any false interrupts */
-    if (ec->curr->irq_count &&
-        (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF) == 0) {
-        pr_debug(PREFIX "controller reset, restart transaction\n");
-        start_transaction(ec);
-        if (wait_event_timeout(ec->wait, ec_transaction_done(ec),
-                    msecs_to_jiffies(ACPI_EC_DELAY)))
-            return 0;
-    }
-    /* missing GPEs, switch back to poll mode */
-    if (printk_ratelimit())
-        pr_info(PREFIX "missing confirmations, "
-                "switch off interrupt mode.\n");
-    set_bit(EC_FLAGS_NO_GPE, &ec->flags);
-    clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-    return 1;
-}
-
 static void acpi_ec_gpe_query(void *ec_cxt);
 
 static int ec_check_sci(struct acpi_ec *ec, u8 state)
@@ -238,27 +212,38 @@ static int ec_check_sci(struct acpi_ec *ec, u8 state)
 
 static int ec_poll(struct acpi_ec *ec)
 {
-    unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
-    udelay(ACPI_EC_UDELAY);
-    while (time_before(jiffies, delay)) {
-        gpe_transaction(ec, acpi_ec_read_status(ec));
-        udelay(ACPI_EC_UDELAY);
-        if (ec_transaction_done(ec))
-            return 0;
+    unsigned long flags;
+    int repeat = 2; /* number of command restarts */
+    while (repeat--) {
+        unsigned long delay = jiffies +
+            msecs_to_jiffies(ACPI_EC_DELAY);
+        do {
+            if (wait_event_timeout(ec->wait,
+                        ec_transaction_done(ec),
+                        msecs_to_jiffies(1)))
+                return 0;
+            advance_transaction(ec, acpi_ec_read_status(ec));
+        } while (time_before(jiffies, delay));
+        if (!ec->curr->irq_count ||
+            (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF))
+            break;
+        /* try restart command if we get any false interrupts */
+        pr_debug(PREFIX "controller reset, restart transaction\n");
+        spin_lock_irqsave(&ec->curr_lock, flags);
+        start_transaction(ec);
+        spin_unlock_irqrestore(&ec->curr_lock, flags);
     }
     return -ETIME;
 }
 
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
-                    struct transaction *t,
-                    int force_poll)
+                    struct transaction *t)
 {
     unsigned long tmp;
     int ret = 0;
     pr_debug(PREFIX "transaction start\n");
     /* disable GPE during transaction if storm is detected */
     if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-        clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
         acpi_disable_gpe(NULL, ec->gpe);
     }
     if (EC_FLAGS_MSI)
@@ -271,11 +256,7 @@ static int acpi_ec_transaction_unlocked(struct 
acpi_ec *ec,
     if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
         clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
     spin_unlock_irqrestore(&ec->curr_lock, tmp);
-    /* if we selected poll mode or failed in GPE-mode do a poll loop */
-    if (force_poll ||
-        !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
-        acpi_ec_wait(ec))
-        ret = ec_poll(ec);
+    ret = ec_poll(ec);
     pr_debug(PREFIX "transaction end\n");
     spin_lock_irqsave(&ec->curr_lock, tmp);
     ec->curr = NULL;
@@ -285,8 +266,7 @@ static int acpi_ec_transaction_unlocked(struct 
acpi_ec *ec,
         ec_check_sci(ec, acpi_ec_read_status(ec));
         /* it is safe to enable GPE outside of transaction */
         acpi_enable_gpe(NULL, ec->gpe);
-    } else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
-           t->irq_count > ACPI_EC_STORM_THRESHOLD) {
+    } else if (t->irq_count > ACPI_EC_STORM_THRESHOLD) {
         pr_info(PREFIX "GPE storm detected, "
             "transactions will use polling mode\n");
         set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
@@ -304,16 +284,14 @@ static int ec_wait_ibf0(struct acpi_ec *ec)
 {
     unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
     /* interrupt wait manually if GPE mode is not active */
-    unsigned long timeout = test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ?
-        msecs_to_jiffies(ACPI_EC_DELAY) : msecs_to_jiffies(1);
     while (time_before(jiffies, delay))
-        if (wait_event_timeout(ec->wait, ec_check_ibf0(ec), timeout))
+        if (wait_event_timeout(ec->wait, ec_check_ibf0(ec),
+                    msecs_to_jiffies(1)))
             return 0;
     return -ETIME;
 }
 
-static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t,
-                   int force_poll)
+static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 {
     int status;
     u32 glk;
@@ -335,7 +313,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, 
struct transaction *t,
         status = -ETIME;
         goto end;
     }
-    status = acpi_ec_transaction_unlocked(ec, t, force_poll);
+    status = acpi_ec_transaction_unlocked(ec, t);
 end:
     if (ec->global_lock)
         acpi_release_global_lock(glk);
@@ -355,7 +333,7 @@ static int acpi_ec_burst_enable(struct acpi_ec *ec)
                 .wdata = NULL, .rdata = &d,
                 .wlen = 0, .rlen = 1};
 
-    return acpi_ec_transaction(ec, &t, 0);
+    return acpi_ec_transaction(ec, &t);
 }
 
 static int acpi_ec_burst_disable(struct acpi_ec *ec)
@@ -365,7 +343,7 @@ static int acpi_ec_burst_disable(struct acpi_ec *ec)
                 .wlen = 0, .rlen = 0};
 
     return (acpi_ec_read_status(ec) & ACPI_EC_FLAG_BURST) ?
-                acpi_ec_transaction(ec, &t, 0) : 0;
+                acpi_ec_transaction(ec, &t) : 0;
 }
 
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 * data)
@@ -376,7 +354,7 @@ static int acpi_ec_read(struct acpi_ec *ec, u8 
address, u8 * data)
                 .wdata = &address, .rdata = &d,
                 .wlen = 1, .rlen = 1};
 
-    result = acpi_ec_transaction(ec, &t, 0);
+    result = acpi_ec_transaction(ec, &t);
     *data = d;
     return result;
 }
@@ -388,7 +366,7 @@ static int acpi_ec_write(struct acpi_ec *ec, u8 
address, u8 data)
                 .wdata = wdata, .rdata = NULL,
                 .wlen = 2, .rlen = 0};
 
-    return acpi_ec_transaction(ec, &t, 0);
+    return acpi_ec_transaction(ec, &t);
 }
 
 /*
@@ -456,7 +434,7 @@ int ec_transaction(u8 command,
     if (!first_ec)
         return -ENODEV;
 
-    return acpi_ec_transaction(first_ec, &t, force_poll);
+    return acpi_ec_transaction(first_ec, &t);
 }
 
 EXPORT_SYMBOL(ec_transaction);
@@ -477,7 +455,7 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 * data)
      * bit to be cleared (and thus clearing the interrupt source).
      */
 
-    result = acpi_ec_transaction(ec, &t, 0);
+    result = acpi_ec_transaction(ec, &t);
     if (result)
         return result;
 
@@ -560,27 +538,19 @@ static u32 acpi_ec_gpe_handler(void *data)
     pr_debug(PREFIX "~~~> interrupt\n");
     status = acpi_ec_read_status(ec);
 
-    if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) {
-        gpe_transaction(ec, status);
-        if (ec_transaction_done(ec) &&
-            (status & ACPI_EC_FLAG_IBF) == 0)
-            wake_up(&ec->wait);
-    }
-
+    advance_transaction(ec, status);
+    if (ec_transaction_done(ec) && (status & ACPI_EC_FLAG_IBF) == 0)
+        wake_up(&ec->wait);
     ec_check_sci(ec, status);
-    if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
-        !test_bit(EC_FLAGS_NO_GPE, &ec->flags)) {
-        /* this is non-query, must be confirmation */
-        if (!test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-            if (printk_ratelimit())
-                pr_info(PREFIX "non-query interrupt received,"
-                    " switching to interrupt mode\n");
-        } else {
-            /* hush, STORM switches the mode every transaction */
-            pr_debug(PREFIX "non-query interrupt received,"
+    /* this is non-query, must be confirmation */
+    if (!test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+        if (printk_ratelimit())
+            pr_info(PREFIX "non-query interrupt received,"
                 " switching to interrupt mode\n");
-        }
-        set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+    } else {
+        /* hush, STORM switches the mode every transaction */
+        pr_debug(PREFIX "non-query interrupt received,"
+            " switching to interrupt mode\n");
     }
     return ACPI_INTERRUPT_HANDLED;
 }
@@ -823,8 +793,6 @@ static int acpi_ec_add(struct acpi_device *device)
     acpi_ec_add_fs(device);
     pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 
0x%lx\n",
               ec->gpe, ec->command_addr, ec->data_addr);
-    pr_info(PREFIX "driver started in %s mode\n",
-        (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))?"interrupt":"poll");
     return 0;
 }
 
@@ -1040,8 +1008,6 @@ static int acpi_ec_suspend(struct acpi_device 
*device, pm_message_t state)
 {
     struct acpi_ec *ec = acpi_driver_data(device);
     /* Stop using GPE */
-    set_bit(EC_FLAGS_NO_GPE, &ec->flags);
-    clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
     acpi_disable_gpe(NULL, ec->gpe);
     return 0;
 }
@@ -1050,7 +1016,6 @@ static int acpi_ec_resume(struct acpi_device *device)
 {
     struct acpi_ec *ec = acpi_driver_data(device);
     /* Enable use of GPE back */
-    clear_bit(EC_FLAGS_NO_GPE, &ec->flags);
     acpi_enable_gpe(NULL, ec->gpe);
     return 0;
 }

