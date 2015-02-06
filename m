From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/5] ACPI / EC: Add command flushing support.
Date: Fri,  6 Feb 2015 08:57:59 +0800
Message-ID: <991bf8b675e1a0a04ddf3af8d8dd792239ffef03.1423183648.git.lv.zheng@intel.com>
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

This patch implements the EC command flushing support.

During the grace period indicated by EC_FLAGS_STARTED and EC_FLAGS_STOP=
PED,
all submitted EC command transactions can be completed and new submissi=
ons
are prevented before suspending so that the EC hardware can be ensured =
to
be in the idle state when the system is resumed.

There is a good indicator for flush support:
All acpi_ec_submit_request() is invoked after checking driver state wit=
h
acpi_ec_started() except the first one. This means all code paths can b=
e
flushed as fast as possible by discarding the requests occurred after t=
he
flush operation. The reference increased for such kind of code path is
wrapped by acpi_ec_submit_flushable_request().

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Ortwin Gl=C3=BCck <odi@odi.ch>
---
 drivers/acpi/ec.c       |   68 +++++++++++++++++++++++++++++++++++++++=
+++++---
 drivers/acpi/internal.h |    1 +
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a6179b7..1fa1463 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -145,6 +145,11 @@ static bool acpi_ec_started(struct acpi_ec *ec)
 	       !test_bit(EC_FLAGS_STOPPED, &ec->flags);
 }
=20
+static bool acpi_ec_flushed(struct acpi_ec *ec)
+{
+	return ec->reference_count =3D=3D 1;
+}
+
 /* -------------------------------------------------------------------=
-------
  *                           EC Registers
  * -------------------------------------------------------------------=
------- */
@@ -266,6 +271,44 @@ static inline void acpi_ec_clear_gpe(struct acpi_e=
c *ec)
  *                           Transaction Management
  * -------------------------------------------------------------------=
------- */
=20
+static void acpi_ec_submit_request(struct acpi_ec *ec)
+{
+	ec->reference_count++;
+	if (ec->reference_count =3D=3D 1)
+		acpi_ec_enable_gpe(ec, true);
+}
+
+static void acpi_ec_complete_request(struct acpi_ec *ec)
+{
+	bool flushed =3D false;
+
+	ec->reference_count--;
+	if (ec->reference_count =3D=3D 0)
+		acpi_ec_disable_gpe(ec, true);
+	flushed =3D acpi_ec_flushed(ec);
+	if (flushed)
+		wake_up(&ec->wait);
+}
+
+/*
+ * acpi_ec_submit_flushable_request() - Increase the reference count u=
nless
+ *                                      the flush operation is not in
+ *                                      progress
+ * @ec: the EC device
+ *
+ * This function must be used before taking a new action that should h=
old
+ * the reference count.  If this function returns false, then the acti=
on
+ * must be discarded or it will prevent the flush operation from being
+ * completed.
+ */
+static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec)
+{
+	if (!acpi_ec_started(ec))
+		return false;
+	acpi_ec_submit_request(ec);
+	return true;
+}
+
 static void acpi_ec_submit_query(struct acpi_ec *ec)
 {
 	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
@@ -426,7 +469,8 @@ static int acpi_ec_transaction_unlocked(struct acpi=
_ec *ec,
 		udelay(ACPI_EC_MSI_UDELAY);
 	/* start transaction */
 	spin_lock_irqsave(&ec->lock, tmp);
-	if (!acpi_ec_started(ec)) {
+	/* Enable GPE for command processing (IBF=3D0/OBF=3D1) */
+	if (!acpi_ec_submit_flushable_request(ec)) {
 		ret =3D -EINVAL;
 		goto unlock;
 	}
@@ -441,6 +485,8 @@ static int acpi_ec_transaction_unlocked(struct acpi=
_ec *ec,
 	pr_debug("***** Command(%s) stopped *****\n",
 		 acpi_ec_cmd_string(t->command));
 	ec->curr =3D NULL;
+	/* Disable GPE for command processing (IBF=3D0/OBF=3D1) */
+	acpi_ec_complete_request(ec);
 unlock:
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	return ret;
@@ -614,13 +660,25 @@ static void acpi_ec_start(struct acpi_ec *ec, boo=
l resuming)
 	spin_lock_irqsave(&ec->lock, flags);
 	if (!test_and_set_bit(EC_FLAGS_STARTED, &ec->flags)) {
 		pr_debug("+++++ Starting EC +++++\n");
+		/* Enable GPE for event processing (SCI_EVT=3D1) */
 		if (!resuming)
-			acpi_ec_enable_gpe(ec, true);
+			acpi_ec_submit_request(ec);
 		pr_info("+++++ EC started +++++\n");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
=20
+static bool acpi_ec_stopped(struct acpi_ec *ec)
+{
+	unsigned long flags;
+	bool flushed;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	flushed =3D acpi_ec_flushed(ec);
+	spin_unlock_irqrestore(&ec->lock, flags);
+	return flushed;
+}
+
 static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 {
 	unsigned long flags;
@@ -629,8 +687,12 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool =
suspending)
 	if (acpi_ec_started(ec)) {
 		pr_debug("+++++ Stopping EC +++++\n");
 		set_bit(EC_FLAGS_STOPPED, &ec->flags);
+		spin_unlock_irqrestore(&ec->lock, flags);
+		wait_event(ec->wait, acpi_ec_stopped(ec));
+		spin_lock_irqsave(&ec->lock, flags);
+		/* Disable GPE for event processing (SCI_EVT=3D1) */
 		if (!suspending)
-			acpi_ec_disable_gpe(ec, true);
+			acpi_ec_complete_request(ec);
 		clear_bit(EC_FLAGS_STARTED, &ec->flags);
 		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
 		pr_info("+++++ EC stopped +++++\n");
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 63e3495..6a4420d 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -129,6 +129,7 @@ struct acpi_ec {
 	unsigned long data_addr;
 	unsigned long global_lock;
 	unsigned long flags;
+	unsigned long reference_count;
 	struct mutex mutex;
 	wait_queue_head_t wait;
 	struct list_head list;
--=20
1.7.10
