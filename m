From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/5] ACPI / EC: Refine command storm prevention support.
Date: Fri,  6 Feb 2015 08:58:05 +0800
Message-ID: <c102e0e999906a7f38ad7dd6c9d8e708e33467ec.1423183648.git.lv.zheng@intel.com>
References: <20141119121615.GA2514@node.dhcp.inet.fi> <cover.1423183647.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423183647.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch refines EC command storm prevention support.

Current command storming code is wrong, when the storming condition is
detected, it only flags the condition without doing anything for the
current command but performing storming prevention for the follow-up
commands. So:
1. The first command which suffers from the storming still suffers from
   storming.
2. The follow-up commands which may not suffer from the storming are
   unconditionally forced into the storming prevention mode.
Ideally, we should only enable storm prevention immediately after detection
for the current command so that the next command can try the
power/performance efficient interrupt mode again.

This patch improves the command storm prevention by disabling GPE right
after the detection and re-enabling it right before completing the command
transaction using the GPE storming prevention APIs. This thus deploys the
following GPE handling model:
1. acpi_enable_gpe()/acpi_disable_gpe() for reference count changes:
   This set of APIs are used for EC usage reference counting.
2. acpi_set_gpe(ACPI_GPE_ENABLE)/acpi_set_gpe(ACPI_GPE_DISABLE):
   This set of APIs are used for preventing GPE storm. They must be invoked
   when the reference count > 0.
   Note that as the storming prevention should always happen when there is
   an outstanding request, or GPE enabling value will be messed up by the
   races. This patch also adds BUG_ON() to enforces this rule to prevent
   future bugs.

The msleep(1) used after completing a transaction is useless now as this
sounds like a guard time only useful for platforms that need the
EC_FLAGS_MSI quirks while we have fixed GPE race issues using the previous
raw handler mode enabling. It is kept to avoid regressions. A seperate
patch which deletes EC_FLAGS_MSI quirks should take care of deleting it.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   55 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1fa1463..982b67f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -77,11 +77,12 @@ enum ec_command {
 
 enum {
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
-	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
 	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
 					 * OpReg are installed */
 	EC_FLAGS_STARTED,		/* Driver is started */
 	EC_FLAGS_STOPPED,		/* Driver is stopped */
+	EC_FLAGS_COMMAND_STORM,		/* GPE storms occurred to the
+					 * current command processing */
 };
 
 #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
@@ -229,8 +230,10 @@ static inline void acpi_ec_enable_gpe(struct acpi_ec *ec, bool open)
 {
 	if (open)
 		acpi_enable_gpe(NULL, ec->gpe);
-	else
+	else {
+		BUG_ON(ec->reference_count < 1);
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
+	}
 	if (acpi_ec_is_gpe_raised(ec)) {
 		/*
 		 * On some platforms, EN=1 writes cannot trigger GPE. So
@@ -246,8 +249,10 @@ static inline void acpi_ec_disable_gpe(struct acpi_ec *ec, bool close)
 {
 	if (close)
 		acpi_disable_gpe(NULL, ec->gpe);
-	else
+	else {
+		BUG_ON(ec->reference_count < 1);
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
+	}
 }
 
 static inline void acpi_ec_clear_gpe(struct acpi_ec *ec)
@@ -290,6 +295,24 @@ static void acpi_ec_complete_request(struct acpi_ec *ec)
 		wake_up(&ec->wait);
 }
 
+static void acpi_ec_set_storm(struct acpi_ec *ec, u8 flag)
+{
+	if (!test_bit(flag, &ec->flags)) {
+		acpi_ec_disable_gpe(ec, false);
+		pr_debug("+++++ Polling enabled +++++\n");
+		set_bit(flag, &ec->flags);
+	}
+}
+
+static void acpi_ec_clear_storm(struct acpi_ec *ec, u8 flag)
+{
+	if (test_bit(flag, &ec->flags)) {
+		clear_bit(flag, &ec->flags);
+		acpi_ec_enable_gpe(ec, false);
+		pr_debug("+++++ Polling disabled +++++\n");
+	}
+}
+
 /*
  * acpi_ec_submit_flushable_request() - Increase the reference count unless
  *                                      the flush operation is not in
@@ -404,8 +427,13 @@ err:
 	 * otherwise will take a not handled IRQ as a false one.
 	 */
 	if (!(status & ACPI_EC_FLAG_SCI)) {
-		if (in_interrupt() && t)
-			++t->irq_count;
+		if (in_interrupt() && t) {
+			if (t->irq_count < ec_storm_threshold)
+				++t->irq_count;
+			/* Allow triggering on 0 threshold */
+			if (t->irq_count == ec_storm_threshold)
+				acpi_ec_set_storm(ec, EC_FLAGS_COMMAND_STORM);
+		}
 	}
 out:
 	if (status & ACPI_EC_FLAG_SCI)
@@ -482,6 +510,8 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	ret = ec_poll(ec);
 	spin_lock_irqsave(&ec->lock, tmp);
+	if (t->irq_count == ec_storm_threshold)
+		acpi_ec_clear_storm(ec, EC_FLAGS_COMMAND_STORM);
 	pr_debug("***** Command(%s) stopped *****\n",
 		 acpi_ec_cmd_string(t->command));
 	ec->curr = NULL;
@@ -509,24 +539,11 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 			goto unlock;
 		}
 	}
-	/* disable GPE during transaction if storm is detected */
-	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-		/* It has to be disabled, so that it doesn't trigger. */
-		acpi_ec_disable_gpe(ec, false);
-	}
 
 	status = acpi_ec_transaction_unlocked(ec, t);
 
-	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+	if (test_bit(EC_FLAGS_COMMAND_STORM, &ec->flags))
 		msleep(1);
-		/* It is safe to enable the GPE outside of the transaction. */
-		acpi_ec_enable_gpe(ec, false);
-	} else if (t->irq_count > ec_storm_threshold) {
-		pr_info("GPE storm detected(%d GPEs), "
-			"transactions will use polling mode\n",
-			t->irq_count);
-		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
-	}
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 unlock:
-- 
1.7.10
