From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 4/5] ACPI / EC: Add query flushing support.
Date: Fri,  6 Feb 2015 08:58:10 +0800
Message-ID: <966dd83f2315a176bc0f5906dfcff5d9756fb888.1423183648.git.lv.zheng@intel.com>
References: <20141119121615.GA2514@node.dhcp.inet.fi> <cover.1423183647.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423183647.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch implementes the QR_EC flushing support.

Grace periods are implemented from the detection of an SCI_EVT to the
submission/completion of the QR_EC transaction. During this period, all
EC command transactions are allowed to be submitted.

Note that query periods and event periods are intentionally distiguishe=
d to
allow further improvements.
1. Query period: from the detection of an SCI_EVT to the sumission of t=
he
   QR_EC command. This period is used for storming prevention, as curre=
ntly
   QR_EC is deferred to a work queue rather than directly issued from t=
he
   IRQ context even there is no other transactions pending, so malicous
   SCI_EVT GPE can act like "level triggered" to trigger a GPE storm. W=
e
   need to be prepared for this. And in the future, we may change it to=
 be
   a part of the advance_transaction() where we will try QR_EC submissi=
on
   in appropriate positions to avoid such GPE storming.
2. Event period: from the detection of an SCI_EVT to the completion of =
the
   QR_EC command. We may extend it to the completion of _Qxx evaluation=
=2E
   This is actually a grace period for event flushing, but we only flus=
h
   queries due to the reason stated in known issue 1. That's also why w=
e
   use EC_FLAGS_EVENT_xxx. During this period, QR_EC transactions need =
to
   pass the flushable submission check.

In this patch, the following flags are implemented:
1. EC_FLAGS_EVENT_ENABLED: this is derived from the old
   EC_FLAGS_QUERY_PENDING flag which can block SCI_EVT handlings.
   With this flag, the logics implemented by the original flag are
   extended:
   1. Old logic: unless both of the flags are set, the event poller wil=
l
                 not be scheduled, and
   2. New logic: as soon as both of the flags are set, the evet poller =
will
                 be scheduled.
2. EC_FLAGS_EVENT_DETECTED: this is also derived from the old
   EC_FLAGS_QUERY_PENDING flag which can block SCI_EVT detection. It th=
us
   can be used to indicate the storming prevention period for query
   submission.
   acpi_ec_submit_request()/acpi_ec_complete_request() are invoked to
   implement this period so that acpi_set_gpe() can be invoked under th=
e
   "reference count > 0" condition.
3. EC_FLAGS_EVENT_PENDING: this is newly added to indicate the grace pe=
riod
   for event flushing (query flushing for now).
   acpi_ec_submit_request()/acpi_ec_complete_request() are invoked to
   implement this period so that the flushing process can wait until th=
e
   event handling (query transaction for now) to be completed.

Known issues:
1. Event flushing support
   Currently the EC transactions occurred for the _Qxx evaluations may =
be
   dropped during the query flushing. A better support might implement =
the
   grace period from the detection of an SCI_EVT to the completion of t=
he
   _Qxx evaluation so that the whole event handling process can run to =
a
   a graceful end.
   But doing this is dangerous as it requires not only the quality of t=
he
   EC driver state machine, but also the quality of the ACPICA interpre=
ter.
   So such aggressive approach shouldn't be done in one patch.
   As the reason, the event flushing support should be a standalone one=
 so
   that we can handle regressions easier.
2. Event draining support
   The reasons why we do not put a loop in the event poller to poll eve=
nt
   until the returned query value is 0:
   Some platforms return non 0 query value even when SCI_EVT=3D0, if we=
 put a
   loop in the poller, our command flush mechanism could never execute =
to
   an end thus the system suspending process could be blocked. One SCI_=
EVT
   triggering one QR_EC is current logic and has been proven to be work=
ing
   for so long time.
   As the reason, the event draining support should be a standalone one=
 so
   that we can handle regressions easier.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D82611
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D77431
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Ortwin Gl=C3=BCck <odi@odi.ch>
---
 drivers/acpi/ec.c |  101 ++++++++++++++++++++++++++++++++++++++++++++-=
--------
 1 file changed, 85 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 982b67f..40002ae 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -76,7 +76,9 @@ enum ec_command {
 					 * when trying to clear the EC */
=20
 enum {
-	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
+	EC_FLAGS_EVENT_ENABLED,		/* Event is enabled */
+	EC_FLAGS_EVENT_PENDING,		/* Event is pending */
+	EC_FLAGS_EVENT_DETECTED,	/* Event is detected */
 	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
 					 * OpReg are installed */
 	EC_FLAGS_STARTED,		/* Driver is started */
@@ -151,6 +153,12 @@ static bool acpi_ec_flushed(struct acpi_ec *ec)
 	return ec->reference_count =3D=3D 1;
 }
=20
+static bool acpi_ec_has_pending_event(struct acpi_ec *ec)
+{
+	return test_bit(EC_FLAGS_EVENT_DETECTED, &ec->flags) ||
+	       test_bit(EC_FLAGS_EVENT_PENDING, &ec->flags);
+}
+
 /* -------------------------------------------------------------------=
-------
  *                           EC Registers
  * -------------------------------------------------------------------=
------- */
@@ -318,36 +326,93 @@ static void acpi_ec_clear_storm(struct acpi_ec *e=
c, u8 flag)
  *                                      the flush operation is not in
  *                                      progress
  * @ec: the EC device
+ * @allow_event: whether event should be handled
  *
  * This function must be used before taking a new action that should h=
old
  * the reference count.  If this function returns false, then the acti=
on
  * must be discarded or it will prevent the flush operation from being
  * completed.
+ *
+ * During flushing, QR_EC command need to pass this check when there i=
s a
+ * pending event, so that the reference count held for the pending eve=
nt
+ * can be decreased by the completion of the QR_EC command.
  */
-static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec)
+static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec,
+					     bool allow_event)
 {
-	if (!acpi_ec_started(ec))
-		return false;
+	if (!acpi_ec_started(ec)) {
+		if (!allow_event || !acpi_ec_has_pending_event(ec))
+			return false;
+	}
 	acpi_ec_submit_request(ec);
 	return true;
 }
=20
-static void acpi_ec_submit_query(struct acpi_ec *ec)
+static void acpi_ec_submit_event(struct acpi_ec *ec)
 {
-	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
-		pr_debug("***** Event started *****\n");
+	if (!test_bit(EC_FLAGS_EVENT_DETECTED, &ec->flags) ||
+	    !test_bit(EC_FLAGS_EVENT_ENABLED, &ec->flags))
+		return;
+	/* Hold reference for pending event */
+	if (!acpi_ec_submit_flushable_request(ec, true))
+		return;
+	if (!test_and_set_bit(EC_FLAGS_EVENT_PENDING, &ec->flags)) {
+		pr_debug("***** Event query started *****\n");
 		schedule_work(&ec->work);
+		return;
+	}
+	acpi_ec_complete_request(ec);
+}
+
+static void acpi_ec_complete_event(struct acpi_ec *ec)
+{
+	if (ec->curr->command =3D=3D ACPI_EC_COMMAND_QUERY) {
+		clear_bit(EC_FLAGS_EVENT_PENDING, &ec->flags);
+		pr_debug("***** Event query stopped *****\n");
+		/* Unhold reference for pending event */
+		acpi_ec_complete_request(ec);
+		/* Check if there is another SCI_EVT detected */
+		acpi_ec_submit_event(ec);
+	}
+}
+
+static void acpi_ec_submit_detection(struct acpi_ec *ec)
+{
+	/* Hold reference for query submission */
+	if (!acpi_ec_submit_flushable_request(ec, false))
+		return;
+	if (!test_and_set_bit(EC_FLAGS_EVENT_DETECTED, &ec->flags)) {
+		pr_debug("***** Event detection blocked *****\n");
+		acpi_ec_submit_event(ec);
+		return;
 	}
+	acpi_ec_complete_request(ec);
 }
=20
-static void acpi_ec_complete_query(struct acpi_ec *ec)
+static void acpi_ec_complete_detection(struct acpi_ec *ec)
 {
 	if (ec->curr->command =3D=3D ACPI_EC_COMMAND_QUERY) {
-		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-		pr_debug("***** Event stopped *****\n");
+		clear_bit(EC_FLAGS_EVENT_DETECTED, &ec->flags);
+		pr_debug("***** Event detetion unblocked *****\n");
+		/* Unhold reference for query submission */
+		acpi_ec_complete_request(ec);
 	}
 }
=20
+static void acpi_ec_enable_event(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	set_bit(EC_FLAGS_EVENT_ENABLED, &ec->flags);
+	/*
+	 * An event may be pending even with SCI_EVT=3D0, so QR_EC should
+	 * always be issued right after started.
+	 */
+	acpi_ec_submit_detection(ec);
+	spin_unlock_irqrestore(&ec->lock, flags);
+}
+
 static int ec_transaction_completed(struct acpi_ec *ec)
 {
 	unsigned long flags;
@@ -389,6 +454,7 @@ static void advance_transaction(struct acpi_ec *ec)
 				t->rdata[t->ri++] =3D acpi_ec_read_data(ec);
 				if (t->rlen =3D=3D t->ri) {
 					t->flags |=3D ACPI_EC_COMMAND_COMPLETE;
+					acpi_ec_complete_event(ec);
 					if (t->command =3D=3D ACPI_EC_COMMAND_QUERY)
 						pr_debug("***** Command(%s) hardware completion *****\n",
 							 acpi_ec_cmd_string(t->command));
@@ -399,6 +465,7 @@ static void advance_transaction(struct acpi_ec *ec)
 		} else if (t->wlen =3D=3D t->wi &&
 			   (status & ACPI_EC_FLAG_IBF) =3D=3D 0) {
 			t->flags |=3D ACPI_EC_COMMAND_COMPLETE;
+			acpi_ec_complete_event(ec);
 			wakeup =3D true;
 		}
 		goto out;
@@ -407,16 +474,17 @@ static void advance_transaction(struct acpi_ec *e=
c)
 		    !(status & ACPI_EC_FLAG_SCI) &&
 		    (t->command =3D=3D ACPI_EC_COMMAND_QUERY)) {
 			t->flags |=3D ACPI_EC_COMMAND_POLL;
-			acpi_ec_complete_query(ec);
+			acpi_ec_complete_detection(ec);
 			t->rdata[t->ri++] =3D 0x00;
 			t->flags |=3D ACPI_EC_COMMAND_COMPLETE;
+			acpi_ec_complete_event(ec);
 			pr_debug("***** Command(%s) software completion *****\n",
 				 acpi_ec_cmd_string(t->command));
 			wakeup =3D true;
 		} else if ((status & ACPI_EC_FLAG_IBF) =3D=3D 0) {
 			acpi_ec_write_cmd(ec, t->command);
 			t->flags |=3D ACPI_EC_COMMAND_POLL;
-			acpi_ec_complete_query(ec);
+			acpi_ec_complete_detection(ec);
 		} else
 			goto err;
 		goto out;
@@ -437,7 +505,7 @@ err:
 	}
 out:
 	if (status & ACPI_EC_FLAG_SCI)
-		acpi_ec_submit_query(ec);
+		acpi_ec_submit_detection(ec);
 	if (wakeup && in_interrupt())
 		wake_up(&ec->wait);
 }
@@ -498,7 +566,7 @@ static int acpi_ec_transaction_unlocked(struct acpi=
_ec *ec,
 	/* start transaction */
 	spin_lock_irqsave(&ec->lock, tmp);
 	/* Enable GPE for command processing (IBF=3D0/OBF=3D1) */
-	if (!acpi_ec_submit_flushable_request(ec)) {
+	if (!acpi_ec_submit_flushable_request(ec, true)) {
 		ret =3D -EINVAL;
 		goto unlock;
 	}
@@ -879,7 +947,9 @@ static void acpi_ec_gpe_poller(struct work_struct *=
work)
 {
 	struct acpi_ec *ec =3D container_of(work, struct acpi_ec, work);
=20
+	pr_debug("***** Event poller started *****\n");
 	acpi_ec_query(ec, NULL);
+	pr_debug("***** Event poller stopped *****\n");
 }
=20
 static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
@@ -949,7 +1019,6 @@ static struct acpi_ec *make_acpi_ec(void)
=20
 	if (!ec)
 		return NULL;
-	ec->flags =3D 1 << EC_FLAGS_QUERY_PENDING;
 	mutex_init(&ec->mutex);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
@@ -1100,7 +1169,7 @@ static int acpi_ec_add(struct acpi_device *device=
)
 	ret =3D ec_install_handlers(ec);
=20
 	/* EC is fully operational, allow queries */
-	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
+	acpi_ec_enable_event(ec);
=20
 	/* Clear stale _Q events if hardware might require that */
 	if (EC_FLAGS_CLEAR_ON_RESUME)
--=20
1.7.10
