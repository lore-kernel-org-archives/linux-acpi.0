From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/6] ACPI / EC: Add event clearing variation support.
Date: Mon,  8 Jun 2015 13:28:10 +0800
Message-ID: <2b403366740b870b5043b0c849c313ec4c0e1493.1433734431.git.lv.zheng@intel.com>
References: <cover.1433734431.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433734431.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We've been suffering from the uncertainty of the SCI_EVT clearing timing.
This patch implements 4 possible modes to handle SCI_EVT clearing
variations. The old behavior is kept in this patch.

Status: QR_EC is re-checked as early as possible after checking previous
        SCI_EVT. This always leads to 2 QR_EC transactions per SCI_EVT
        indication and the target may implement event queue which returns
        0x00 indicating "no outstanding event".
Query: QR_EC is re-checked after the target has handled the QR_EC query
       request command pushed by the host.
Event: QR_EC is re-checked after the target has noticed the query event
       response data pulled by the host.
Method: QR_EC is re-checked as late as possible after completing the _Qxx
        evaluation. The target may implement SCI_EVT like a level triggered
        interrupt.

Note that, according to the reports, there are platforms that cannot be
handled using the "Status" mode without enabling the
EC_FLAGS_QUERY_HANDSHAKE quirk. But they can be handled with the other 3
modes according to the tests. See Lenovo Z50 test result.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=94411
Link: https://bugzilla.kernel.org/show_bug.cgi?id=97381
Link: https://bugzilla.kernel.org/show_bug.cgi?id=98111
Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Reported-and-tested-by: Tigran Gabrielyan <tigrangab@gmail.com>
Reported-and-tested-by: Adrien D <ghbdtn@openmailbox.org>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |  157 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7a30f59..8477626 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -59,6 +59,49 @@
 #define ACPI_EC_FLAG_BURST	0x10	/* burst mode */
 #define ACPI_EC_FLAG_SCI	0x20	/* EC-SCI occurred */
 
+/*
+ * The SCI_EVT clearing timing is not defined by the ACPI specification.
+ * This leads to lots of practical timing issues for the host EC driver.
+ * The following variations are defined (from the target EC firmware's
+ * perspective):
+ * STATUS: After indicating SCI_EVT edge triggered IRQ to the host, the
+ *         target can clear SCI_EVT at any time so long as the host can see
+ *         the indication by reading the status register (EC_SC). So the
+ *         host should re-check SCI_EVT after the first time the SCI_EVT
+ *         indication is seen, which is the same time the query request
+ *         (QR_EC) is written to the command register (EC_CMD). SCI_EVT set
+ *         at any later time could indicate another event. Normally such
+ *         kind of EC firmware has implemented an event queue and will
+ *         return 0x00 to indicate "no outstanding event".
+ * QUERY: After seeing the query request (QR_EC) written to the command
+ *        register (EC_CMD) by the host and having prepared the responding
+ *        event value in the data register (EC_DATA), the target can safely
+ *        clear SCI_EVT because the target can confirm that the current
+ *        event is being handled by the host. The host then should check
+ *        SCI_EVT right after reading the event response from the data
+ *        register (EC_DATA).
+ * EVENT: After seeing the event response read from the data register
+ *        (EC_DATA) by the host, the target can clear SCI_EVT. As the
+ *        target requires time to notice the change in the data register
+ *        (EC_DATA), the host may be required to wait additional guarding
+ *        time before checking the SCI_EVT again. Such guarding may not be
+ *        necessary if the host is notified via another IRQ.
+ * METHOD: After the event has been handled via the host _Qxx evaluation,
+ *         the target can clear SCI_EVT. Normally such kind of EC firmware
+ *         flags SCI_EVT in a level triggered way, so the host can wait
+ *         another IRQ instead of checking SCI_EVT again right after _Qxx
+ *         evaluation completes. This case can thus be covered by any of
+ *         the above modes except the overheads caused by the unwanted
+ *         queries. But if the firmware doesn't keep on raising IRQs to the
+ *         host, the host have to wait an additional guarding time and
+ *         check the SCI_EVT again. Such guarding may not be necessary
+ *         if the host is notified via another IRQ.
+ */
+#define ACPI_EC_EVT_TIMING_STATUS	0x00
+#define ACPI_EC_EVT_TIMING_QUERY	0x01
+#define ACPI_EC_EVT_TIMING_EVENT	0x02
+#define ACPI_EC_EVT_TIMING_METHOD	0x03
+
 /* EC commands */
 enum ec_command {
 	ACPI_EC_COMMAND_READ = 0x80,
@@ -76,6 +119,7 @@ enum ec_command {
 
 enum {
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
+	EC_FLAGS_QUERY_GUARDING,	/* Guard for SCI_EVT check */
 	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
 					 * OpReg are installed */
 	EC_FLAGS_STARTED,		/* Driver is started */
@@ -100,6 +144,8 @@ static unsigned int ec_polling_guard __read_mostly = ACPI_EC_UDELAY_POLL;
 module_param(ec_polling_guard, uint, 0644);
 MODULE_PARM_DESC(ec_polling_guard, "Guard time(us) between EC accesses in polling modes");
 
+static unsigned int ec_event_clearing __read_mostly = ACPI_EC_EVT_TIMING_STATUS;
+
 /*
  * If the number of false interrupts per one transaction exceeds
  * this threshold, will think there is a GPE storm happened and
@@ -400,6 +446,21 @@ static void acpi_ec_complete_query(struct acpi_ec *ec)
 	}
 }
 
+static bool acpi_ec_guard_event(struct acpi_ec *ec)
+{
+	if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS ||
+	    ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY ||
+	    !test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags) ||
+	    (ec->curr && ec->curr->command == ACPI_EC_COMMAND_QUERY))
+		return false;
+
+	/*
+	 * Postpone the query submission to allow the firmware to proceed,
+	 * we shouldn't check SCI_EVT before the firmware reflagging it.
+	 */
+	return true;
+}
+
 static int ec_transaction_polled(struct acpi_ec *ec)
 {
 	unsigned long flags;
@@ -428,8 +489,15 @@ static inline void ec_transaction_transition(struct acpi_ec *ec, unsigned long f
 {
 	ec->curr->flags |= flag;
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY) {
-		if (flag == ACPI_EC_COMMAND_POLL)
+		if (ec_event_clearing == ACPI_EC_EVT_TIMING_STATUS &&
+		    flag == ACPI_EC_COMMAND_POLL)
+			acpi_ec_complete_query(ec);
+		if (ec_event_clearing == ACPI_EC_EVT_TIMING_QUERY &&
+		    flag == ACPI_EC_COMMAND_COMPLETE)
 			acpi_ec_complete_query(ec);
+		if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
+		    flag == ACPI_EC_COMMAND_COMPLETE)
+			set_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags);
 	}
 }
 
@@ -449,6 +517,20 @@ static void advance_transaction(struct acpi_ec *ec)
 	acpi_ec_clear_gpe(ec);
 	status = acpi_ec_read_status(ec);
 	t = ec->curr;
+	/*
+	 * Another IRQ or a guarded polling mode advancement is detected,
+	 * the next QR_EC submission is then allowed.
+	 */
+	if (!t || !(t->flags & ACPI_EC_COMMAND_POLL)) {
+		if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT &&
+		    test_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags)) {
+			clear_bit(EC_FLAGS_QUERY_GUARDING, &ec->flags);
+			acpi_ec_complete_query(ec);
+		}
+		if (ec_event_clearing == ACPI_EC_EVT_TIMING_METHOD &&
+		    !ec->nr_pending_queries)
+			acpi_ec_complete_query(ec);
+	}
 	if (!t)
 		goto err;
 	if (t->flags & ACPI_EC_COMMAND_POLL) {
@@ -534,11 +616,13 @@ static int ec_guard(struct acpi_ec *ec)
 			/*
 			 * Perform wait polling
 			 *
-			 * The following check is there to keep the old
-			 * logic - no inter-transaction guarding for the
-			 * wait polling mode.
+			 * For SCI_EVT clearing timing of "event",
+			 * performing guarding before re-checking the
+			 * SCI_EVT. Otherwise, such guarding is not needed
+			 * due to the old practices.
 			 */
-			if (!ec_transaction_polled(ec))
+			if (!ec_transaction_polled(ec) &&
+			    !acpi_ec_guard_event(ec))
 				break;
 			if (wait_event_timeout(ec->wait,
 					       ec_transaction_completed(ec),
@@ -953,6 +1037,25 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 	return result;
 }
 
+static void acpi_ec_check_event(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	if (ec_event_clearing == ACPI_EC_EVT_TIMING_EVENT ||
+	    ec_event_clearing == ACPI_EC_EVT_TIMING_METHOD) {
+		if (ec_guard(ec)) {
+			spin_lock_irqsave(&ec->lock, flags);
+			/*
+			 * Take care of the SCI_EVT unless no one else is
+			 * taking care of it.
+			 */
+			if (!ec->curr)
+				advance_transaction(ec);
+			spin_unlock_irqrestore(&ec->lock, flags);
+		}
+	}
+}
+
 static void acpi_ec_event_handler(struct work_struct *work)
 {
 	unsigned long flags;
@@ -970,6 +1073,8 @@ static void acpi_ec_event_handler(struct work_struct *work)
 	spin_unlock_irqrestore(&ec->lock, flags);
 
 	ec_dbg_evt("Event stopped");
+
+	acpi_ec_check_event(ec);
 }
 
 static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
@@ -1426,6 +1531,48 @@ error:
 	return -ENODEV;
 }
 
+static int param_set_event_clearing(const char *val, struct kernel_param *kp)
+{
+	int result = 0;
+
+	if (!strncmp(val, "status", sizeof("status") - 1)) {
+		ec_event_clearing = ACPI_EC_EVT_TIMING_STATUS;
+		pr_info("Assuming SCI_EVT clearing on EC_SC accesses\n");
+	} else if (!strncmp(val, "query", sizeof("query") - 1)) {
+		ec_event_clearing = ACPI_EC_EVT_TIMING_QUERY;
+		pr_info("Assuming SCI_EVT clearing on QR_EC writes\n");
+	} else if (!strncmp(val, "event", sizeof("event") - 1)) {
+		ec_event_clearing = ACPI_EC_EVT_TIMING_EVENT;
+		pr_info("Assuming SCI_EVT clearing on event reads\n");
+	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
+		ec_event_clearing = ACPI_EC_EVT_TIMING_METHOD;
+		pr_info("Assuming SCI_EVT clearing on _Qxx method evaluations\n");
+	} else
+		result = -EINVAL;
+	return result;
+}
+
+static int param_get_event_clearing(char *buffer, struct kernel_param *kp)
+{
+	switch (ec_event_clearing) {
+	case ACPI_EC_EVT_TIMING_STATUS:
+		return sprintf(buffer, "status");
+	case ACPI_EC_EVT_TIMING_QUERY:
+		return sprintf(buffer, "query");
+	case ACPI_EC_EVT_TIMING_EVENT:
+		return sprintf(buffer, "event");
+	case ACPI_EC_EVT_TIMING_METHOD:
+		return sprintf(buffer, "method");
+	default:
+		return sprintf(buffer, "invalid");
+	}
+	return 0;
+}
+
+module_param_call(ec_event_clearing, param_set_event_clearing, param_get_event_clearing,
+		  NULL, 0644);
+MODULE_PARM_DESC(ec_event_clearing, "Assumed SCI_EVT clearing timing");
+
 static struct acpi_driver acpi_ec_driver = {
 	.name = "ec",
 	.class = ACPI_EC_CLASS,
-- 
1.7.10
