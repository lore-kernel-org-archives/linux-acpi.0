From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 09/10] ACPI/EC: Add event storm prevention support.
Date: Tue, 15 Jul 2014 11:15:20 +0800
Message-ID: <03047f5e7b63f4044af37920ad234d03a0ee29f3.1405391679.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1405391678.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1405391678.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

There are cases that BIOS doesn't provide _Qxx handler for the returned
query value, in this case, acpi_set_gpe(ACPI_GPE_DISABLE) need to be
invoked to prevent event IRQ storms.

This patch implements such storm prevention using new GPE APIs.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 936424a..b98474f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -80,6 +80,10 @@ enum {
 					 * OpReg are installed */
 	EC_FLAGS_STARTED,		/* Driver is started */
 	EC_FLAGS_STOPPED,		/* Driver is stopped */
+	EC_FLAGS_COMMAND_STORM,		/* GPE storms occurred to the
+					 * current command processing */
+	EC_FLAGS_EVENT_STORM,		/* GPE storms occurred to the
+					 * current event processing */
 };
 
 #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
@@ -158,6 +162,31 @@ static void acpi_ec_disable_gpe(struct acpi_ec *ec)
 		wake_up(&ec->wait);
 }
 
+static void acpi_ec_set_storm(struct acpi_ec *ec, u8 flag)
+{
+	if (!test_bit(flag, &ec->flags)) {
+		if (!test_bit(EC_FLAGS_EVENT_STORM, &ec->flags) &&
+		    !test_bit(EC_FLAGS_COMMAND_STORM, &ec->flags)) {
+			acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
+			pr_debug("+++++ Polling enabled +++++\n");
+		}
+		set_bit(flag, &ec->flags);
+	}
+}
+
+
+static void acpi_ec_clear_storm(struct acpi_ec *ec, u8 flag)
+{
+	if (test_bit(flag, &ec->flags)) {
+		clear_bit(flag, &ec->flags);
+		if (!test_bit(EC_FLAGS_EVENT_STORM, &ec->flags) &&
+		    !test_bit(EC_FLAGS_COMMAND_STORM, &ec->flags)) {
+			acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
+			pr_debug("+++++ Polling disabled +++++\n");
+		}
+	}
+}
+
 /* --------------------------------------------------------------------------
                              Transaction Management
    -------------------------------------------------------------------------- */
@@ -276,10 +305,8 @@ err:
 		if (in_interrupt() && t) {
 			if (t->irq_count < ec_storm_threshold)
 				++t->irq_count;
-			if (t->irq_count == ec_storm_threshold) {
-				pr_debug("+++++ Polling enabled +++++\n");
-				acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
-			}
+			if (t->irq_count == ec_storm_threshold)
+				acpi_ec_set_storm(ec, EC_FLAGS_COMMAND_STORM);
 		}
 	}
 	return wakeup;
@@ -362,10 +389,8 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	ret = ec_poll(ec);
 	spin_lock_irqsave(&ec->lock, tmp);
-	if (t->irq_count == ec_storm_threshold) {
-		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
-		pr_debug("+++++ Polling disabled +++++\n");
-	}
+	if (t->irq_count == ec_storm_threshold)
+		acpi_ec_clear_storm(ec, EC_FLAGS_COMMAND_STORM);
 	pr_debug("***** Command(%s) stopped *****\n",
 		 acpi_ec_cmd_string(t->command));
 	/* Disable GPE for command processing (IBF=0/OBF=1) */
@@ -563,6 +588,8 @@ static void acpi_ec_stop(struct acpi_ec *ec)
 		spin_unlock_irqrestore(&ec->lock, flags);
 		wait_event(ec->wait, acpi_ec_stopped(ec));
 		spin_lock_irqsave(&ec->lock, flags);
+		/* Event storm may still be indicated */
+		acpi_ec_clear_storm(ec, EC_FLAGS_EVENT_STORM);
 		/* Disable GPE for event processing (EVT_SCI=1) */
 		acpi_ec_disable_gpe(ec);
 		clear_bit(EC_FLAGS_STARTED, &ec->flags);
@@ -714,10 +741,14 @@ static void acpi_ec_run(void *cxt)
 
 static int acpi_ec_notify_query_handlers(struct acpi_ec *ec, u8 query_bit)
 {
+	unsigned long flags;
 	struct acpi_ec_query_handler *handler;
 
 	list_for_each_entry(handler, &ec->list, node) {
 		if (query_bit == handler->query_bit) {
+			spin_lock_irqsave(&ec->lock, flags);
+			acpi_ec_clear_storm(ec, EC_FLAGS_EVENT_STORM);
+			spin_unlock_irqrestore(&ec->lock, flags);
 			/* have custom handler for this bit */
 			handler = acpi_ec_get_query_handler(handler);
 			pr_debug("##### Query(0x%02x) scheduled #####\n",
@@ -728,6 +759,9 @@ static int acpi_ec_notify_query_handlers(struct acpi_ec *ec, u8 query_bit)
 		}
 	}
 	pr_warn_once("BIOS bug: no handler for query (0x%02x)\n", query_bit);
+	spin_lock_irqsave(&ec->lock, flags);
+	acpi_ec_set_storm(ec, EC_FLAGS_EVENT_STORM);
+	spin_unlock_irqrestore(&ec->lock, flags);
 	return 0;
 }
 
-- 
1.7.10
