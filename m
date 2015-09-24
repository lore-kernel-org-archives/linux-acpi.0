From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/3] ACPI / EC: Fix a race issue in acpi_ec_guard_event()
Date: Thu, 24 Sep 2015 14:54:54 +0800
Message-ID: <6b9cdabe535cef5121fc82211c9b439e0adaa109.1443076693.git.lv.zheng@intel.com>
References: <cover.1443076693.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443076693.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

In acpi_ec_guard_event(), EC transaction state machine variables should be
checked with the EC spinlock locked.
The bug doesn't trigger any real issue now because this bug can only occur
when the ec_event_clearing=event mode is applied while there is no user
currently using this mode.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ddaaa9d..2687a01 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -441,17 +441,31 @@ static void acpi_ec_complete_query(struct acpi_ec *ec)
 
 static bool acpi_ec_guard_event(struct acpi_ec *ec)
 {
+	bool guarded = true;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	/*
+	 * If firmware SCI_EVT clearing timing is "event", we actually
+	 * don't know when the SCI_EVT will be cleared by firmware after
+	 * evaluating _Qxx, so we need to re-check SCI_EVT after waiting an
+	 * acceptable period.
+	 *
+	 * The guarding period begins when EC_FLAGS_QUERY_PENDING is
+	 * flagged, which means SCI_EVT check has just been performed.
+	 * But if the current transaction is ACPI_EC_COMMAND_QUERY, the
+	 * guarding should have already been performed (via
+	 * EC_FLAGS_QUERY_GUARDING) and should not be applied so that the
+	 * ACPI_EC_COMMAND_QUERY transaction can be transitioned into
+	 * ACPI_EC_COMMAND_POLL state immediately.
+	 */
 	if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS ||
 	    ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY ||
 	    !test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags) ||
 	    (ec->curr && ec->curr->command == ACPI_EC_COMMAND_QUERY))
-		return false;
-
-	/*
-	 * Postpone the query submission to allow the firmware to proceed,
-	 * we shouldn't check SCI_EVT before the firmware reflagging it.
-	 */
-	return true;
+		guarded = false;
+	spin_unlock_irqrestore(&ec->lock, flags);
+	return guarded;
 }
 
 static int ec_transaction_polled(struct acpi_ec *ec)
@@ -597,6 +611,7 @@ static int ec_guard(struct acpi_ec *ec)
 	unsigned long guard = usecs_to_jiffies(ec_polling_guard);
 	unsigned long timeout = ec->timestamp + guard;
 
+	/* Ensure guarding period before polling EC status */
 	do {
 		if (ec_busy_polling) {
 			/* Perform busy polling */
@@ -606,11 +621,13 @@ static int ec_guard(struct acpi_ec *ec)
 		} else {
 			/*
 			 * Perform wait polling
-			 *
-			 * For SCI_EVT clearing timing of "event",
-			 * performing guarding before re-checking the
-			 * SCI_EVT. Otherwise, such guarding is not needed
-			 * due to the old practices.
+			 * 1. Wait the transaction to be completed by the
+			 *    GPE handler after the transaction enters
+			 *    ACPI_EC_COMMAND_POLL state.
+			 * 2. A special guarding logic is also required
+			 *    for event clearing mode "event" before the
+			 *    transaction enters ACPI_EC_COMMAND_POLL
+			 *    state.
 			 */
 			if (!ec_transaction_polled(ec) &&
 			    !acpi_ec_guard_event(ec))
@@ -620,7 +637,6 @@ static int ec_guard(struct acpi_ec *ec)
 					       guard))
 				return 0;
 		}
-		/* Guard the register accesses for the polling modes */
 	} while (time_before(jiffies, timeout));
 	return -ETIME;
 }
-- 
1.7.10
