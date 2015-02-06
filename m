From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/5] ACPI / EC: Introduce STARTED/STOPPED flags to replace BLOCKED flag.
Date: Fri,  6 Feb 2015 08:57:52 +0800
Message-ID: <aefbdd96f6594b4e7eb0c448aea4944f4806c42c.1423183648.git.lv.zheng@intel.com>
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

By using the 2 flags, we can indicate an inter-mediate state where the
current transactions should be completed while the new transactions sho=
uld
be dropped.

The comparison of the old flag and the new flags:
  Old			New
  about to set BLOCKED	STOPPED set / STARTED set
  BLOCKED set		STOPPED clear / STARTED clear
  BLOCKED clear		STOPPED clear / STARTED set
A new period can be indicated by the 2 flags. The new period is between=
 the
point where we are about to set BLOCKED and the point when the BLOCKED =
is
set. The new flags facilitate us with acpi_ec_started() check to allow =
the
EC transaction to be submitted during the new period. This period thus =
can
be used as a grace period for the EC transaction flushing.

The only functional change after applying this patch is:
1. The GPE enabling/disabling is protected by the EC specific lock. We =
can
   do this because of recent ACPICA GPE API enhancement. This is reason=
able
   as the GPE disabling/enabling state should only be determined by the=
 EC
   driver's state machine which is protected by the EC spinlock.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Ortwin Gl=C3=BCck <odi@odi.ch>
---
 drivers/acpi/ec.c |   65 ++++++++++++++++++++++++++++++++++++++++++++-=
--------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5563253..a6179b7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -80,7 +80,8 @@ enum {
 	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
 	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
 					 * OpReg are installed */
-	EC_FLAGS_BLOCKED,		/* Transactions are blocked */
+	EC_FLAGS_STARTED,		/* Driver is started */
+	EC_FLAGS_STOPPED,		/* Driver is stopped */
 };
=20
 #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
@@ -135,6 +136,16 @@ static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi=
_ec_clear() on boot/resume */
 static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EV=
T set */
=20
 /* -------------------------------------------------------------------=
-------
+ *                           Device Flags
+ * -------------------------------------------------------------------=
------- */
+
+static bool acpi_ec_started(struct acpi_ec *ec)
+{
+	return test_bit(EC_FLAGS_STARTED, &ec->flags) &&
+	       !test_bit(EC_FLAGS_STOPPED, &ec->flags);
+}
+
+/* -------------------------------------------------------------------=
-------
  *                           EC Registers
  * -------------------------------------------------------------------=
------- */
=20
@@ -415,6 +426,10 @@ static int acpi_ec_transaction_unlocked(struct acp=
i_ec *ec,
 		udelay(ACPI_EC_MSI_UDELAY);
 	/* start transaction */
 	spin_lock_irqsave(&ec->lock, tmp);
+	if (!acpi_ec_started(ec)) {
+		ret =3D -EINVAL;
+		goto unlock;
+	}
 	/* following two actions should be kept atomic */
 	ec->curr =3D t;
 	pr_debug("***** Command(%s) started *****\n",
@@ -426,6 +441,7 @@ static int acpi_ec_transaction_unlocked(struct acpi=
_ec *ec,
 	pr_debug("***** Command(%s) stopped *****\n",
 		 acpi_ec_cmd_string(t->command));
 	ec->curr =3D NULL;
+unlock:
 	spin_unlock_irqrestore(&ec->lock, tmp);
 	return ret;
 }
@@ -440,10 +456,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec,=
 struct transaction *t)
 	if (t->rdata)
 		memset(t->rdata, 0, t->rlen);
 	mutex_lock(&ec->mutex);
-	if (test_bit(EC_FLAGS_BLOCKED, &ec->flags)) {
-		status =3D -EINVAL;
-		goto unlock;
-	}
 	if (ec->global_lock) {
 		status =3D acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status)) {
@@ -595,6 +607,37 @@ static void acpi_ec_clear(struct acpi_ec *ec)
 		pr_info("%d stale EC events cleared\n", i);
 }
=20
+static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	if (!test_and_set_bit(EC_FLAGS_STARTED, &ec->flags)) {
+		pr_debug("+++++ Starting EC +++++\n");
+		if (!resuming)
+			acpi_ec_enable_gpe(ec, true);
+		pr_info("+++++ EC started +++++\n");
+	}
+	spin_unlock_irqrestore(&ec->lock, flags);
+}
+
+static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	if (acpi_ec_started(ec)) {
+		pr_debug("+++++ Stopping EC +++++\n");
+		set_bit(EC_FLAGS_STOPPED, &ec->flags);
+		if (!suspending)
+			acpi_ec_disable_gpe(ec, true);
+		clear_bit(EC_FLAGS_STARTED, &ec->flags);
+		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
+		pr_info("+++++ EC stopped +++++\n");
+	}
+	spin_unlock_irqrestore(&ec->lock, flags);
+}
+
 void acpi_ec_block_transactions(void)
 {
 	struct acpi_ec *ec =3D first_ec;
@@ -604,7 +647,7 @@ void acpi_ec_block_transactions(void)
=20
 	mutex_lock(&ec->mutex);
 	/* Prevent transactions from being carried out */
-	set_bit(EC_FLAGS_BLOCKED, &ec->flags);
+	acpi_ec_stop(ec, true);
 	mutex_unlock(&ec->mutex);
 }
=20
@@ -616,7 +659,7 @@ void acpi_ec_unblock_transactions(void)
 		return;
=20
 	/* Allow transactions to be carried out again */
-	clear_bit(EC_FLAGS_BLOCKED, &ec->flags);
+	acpi_ec_start(ec, true);
=20
 	if (EC_FLAGS_CLEAR_ON_RESUME)
 		acpi_ec_clear(ec);
@@ -629,7 +672,7 @@ void acpi_ec_unblock_transactions_early(void)
 	 * atomic context during wakeup, so we don't need to acquire the mute=
x).
 	 */
 	if (first_ec)
-		clear_bit(EC_FLAGS_BLOCKED, &first_ec->flags);
+		acpi_ec_start(first_ec, true);
 }
=20
 /* -------------------------------------------------------------------=
-------
@@ -894,7 +937,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
=20
-	acpi_ec_enable_gpe(ec, true);
+	acpi_ec_start(ec, false);
 	status =3D acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -909,7 +952,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 			pr_err("Fail in evaluating the _REG object"
 				" of EC device. Broken bios is suspected.\n");
 		} else {
-			acpi_ec_disable_gpe(ec, true);
+			acpi_ec_stop(ec, false);
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
 			return -ENODEV;
@@ -924,7 +967,7 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 {
 	if (!test_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags))
 		return;
-	acpi_ec_disable_gpe(ec, true);
+	acpi_ec_stop(ec, false);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err("failed to remove space handler\n");
--=20
1.7.10
