From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/6] ACPI/EC: Introduce STARTED/STOPPED flags to replace BLOCKED flag.
Date: Mon,  3 Nov 2014 13:16:14 +0800
Message-ID: <e1228a3433fbbd8448d5522bef4e080763b1c18f.1414988981.git.lv.zheng@intel.com>
References: <cover.1414988981.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1414988981.git.lv.zheng@intel.com>
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
The new period is between the point where we are about to set BLOCKED a=
nd
the point when the BLOCKED is set. The GPE is disabled during this peri=
od.
The new flags allow us to add acpi_ec_stopped() check to only check wit=
h
STOPPED flag to implement transaction flushing. This is not done in thi=
s
patch.

No functional changes except that after applying this patch, the GPE
enabling/disabling is protected by the EC specific lock. We can do this
because of recent ACPICA GPE API enhancement. This is reasonable as the=
 GPE
disabling/enabling state should only be determined by the EC driver's s=
tate
machine which is protected by the EC spinlock.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Ortwin Gl=C3=BCck <odi@odi.ch>
---
 drivers/acpi/ec.c |   56 +++++++++++++++++++++++++++++++++++++++++++++=
--------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5f9b74b..192cd11 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -79,7 +79,8 @@ enum {
 	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
 	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
 					 * OpReg are installed */
-	EC_FLAGS_BLOCKED,		/* Transactions are blocked */
+	EC_FLAGS_STARTED,		/* Driver is started */
+	EC_FLAGS_STOPPED,		/* Driver is stopped */
 };
=20
 #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
@@ -129,6 +130,16 @@ static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi=
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
  *                           Transaction Management
  * -------------------------------------------------------------------=
------- */
=20
@@ -354,7 +365,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, =
struct transaction *t)
 	if (t->rdata)
 		memset(t->rdata, 0, t->rlen);
 	mutex_lock(&ec->mutex);
-	if (test_bit(EC_FLAGS_BLOCKED, &ec->flags)) {
+	if (!acpi_ec_started(ec)) {
 		status =3D -EINVAL;
 		goto unlock;
 	}
@@ -511,6 +522,35 @@ static void acpi_ec_clear(struct acpi_ec *ec)
 		pr_info("%d stale EC events cleared\n", i);
 }
=20
+static void acpi_ec_start(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	if (!test_and_set_bit(EC_FLAGS_STARTED, &ec->flags)) {
+		pr_debug("+++++ Starting EC +++++\n");
+		acpi_enable_gpe(NULL, ec->gpe);
+		pr_info("+++++ EC started +++++\n");
+	}
+	spin_unlock_irqrestore(&ec->lock, flags);
+}
+
+static void acpi_ec_stop(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	if (acpi_ec_started(ec)) {
+		pr_debug("+++++ Stopping EC +++++\n");
+		set_bit(EC_FLAGS_STOPPED, &ec->flags);
+		acpi_disable_gpe(NULL, ec->gpe);
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
@@ -520,7 +560,7 @@ void acpi_ec_block_transactions(void)
=20
 	mutex_lock(&ec->mutex);
 	/* Prevent transactions from being carried out */
-	set_bit(EC_FLAGS_BLOCKED, &ec->flags);
+	acpi_ec_stop(ec);
 	mutex_unlock(&ec->mutex);
 }
=20
@@ -533,7 +573,7 @@ void acpi_ec_unblock_transactions(void)
=20
 	mutex_lock(&ec->mutex);
 	/* Allow transactions to be carried out again */
-	clear_bit(EC_FLAGS_BLOCKED, &ec->flags);
+	acpi_ec_start(ec);
=20
 	if (EC_FLAGS_CLEAR_ON_RESUME)
 		acpi_ec_clear(ec);
@@ -548,7 +588,7 @@ void acpi_ec_unblock_transactions_early(void)
 	 * atomic context during wakeup, so we don't need to acquire the mute=
x).
 	 */
 	if (first_ec)
-		clear_bit(EC_FLAGS_BLOCKED, &first_ec->flags);
+		acpi_ec_start(first_ec);
 }
=20
 static int acpi_ec_query_unlocked(struct acpi_ec *ec, u8 *data)
@@ -816,7 +856,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
=20
-	acpi_enable_gpe(NULL, ec->gpe);
+	acpi_ec_start(ec);
 	status =3D acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -831,7 +871,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 			pr_err("Fail in evaluating the _REG object"
 				" of EC device. Broken bios is suspected.\n");
 		} else {
-			acpi_disable_gpe(NULL, ec->gpe);
+			acpi_ec_stop(ec);
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
 			return -ENODEV;
@@ -844,7 +884,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
=20
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
-	acpi_disable_gpe(NULL, ec->gpe);
+	acpi_ec_stop(ec);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err("failed to remove space handler\n");
--=20
1.7.10
