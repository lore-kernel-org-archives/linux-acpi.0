From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 3/5] ACPI / EC: Add PM operations to improve event handling for resume process
Date: Wed,  3 Aug 2016 16:01:36 +0800
Message-ID: <5c03ecd25ac597f807b2c2dd9935e6a2aca629f8.1470205312.git.lv.zheng@intel.com>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com> <cover.1470205312.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31535 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755055AbcHCILT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Aug 2016 04:11:19 -0400
In-Reply-To: <cover.1470205312.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch makes 2 changes:

1. Restore old behavior
Originally, EC driver stops handling both events and transactions in
acpi_ec_block_transactions(), and restarts to handle transactions in
acpi_ec_unblock_transactions_early(), restarts to handle both events and
transactions in acpi_ec_unblock_transactions().
While currently, EC driver still stops handling both events and
transactions in acpi_ec_block_transactions(), but restarts to handle both
events and transactions in acpi_ec_unblock_transactions_early().
This patch tries to restore the old behavior by dropping
__acpi_ec_enable_event() from acpi_unblock_transactions_early().

2. Improve old behavior
However this still cannot fix the real issue as both of the
acpi_ec_unblock_xxx() functions are invoked in the noirq stage. Since the
EC driver actually doesn't implement the event handling in the polling
mode, re-enabling the event handling too early in the noirq stage could
result in the problem that if there is no triggering source causing
advance_transaction() to be invoked, pending SCI_EVT cannot be detected by
the EC driver and _Qxx cannot be triggered.
It actually makes sense to restart the event handling in any point during
resuming after the noirq stage. Just like the boot stage where the event
handling is enabled in .add(), this patch further moves
acpi_ec_enable_event() to .resume(). After doing that, the following 2
functions can be combined:
acpi_ec_unblock_transactions_early()/acpi_ec_unblock_transactions().

The differences of the event handling availability between the old behavior
(this patch isn't applied) and the new behavior (this patch is applied) are
as follows:
                        !Applied        Applied
before suspend          Y               Y
suspend before EC       Y               Y
suspend after EC        Y               Y
suspend_late            Y               Y
suspend_noirq           Y (actually N)  Y (actually N)
resume_noirq            Y (actually N)  Y (actually N)
resume_late             Y (actually N)  Y (actually N)
resume before EC        Y (actually N)  Y (actually N)
resume after EC         Y (actually N)  Y
after resume            Y (actually N)  Y
Where "actually N" means if there is no triggering source, the EC driver
is actually not able to notice the pending SCI_EVT occurred in the noirq
stage. So we can clearly see that this patch has improved the situation.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Todd E Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/acpi/ec.c       |   26 +++++++++++---------------
 drivers/acpi/internal.h |    1 -
 drivers/acpi/sleep.c    |    4 ++--
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 79305be..8d5444d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -909,8 +909,7 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 		if (!resuming) {
 			acpi_ec_submit_request(ec);
 			ec_dbg_ref(ec, "Increase driver");
-		} else
-			__acpi_ec_enable_event(ec);
+		}
 		ec_log_drv("EC started");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
@@ -966,19 +965,6 @@ void acpi_ec_block_transactions(void)
 
 void acpi_ec_unblock_transactions(void)
 {
-	struct acpi_ec *ec = first_ec;
-
-	if (!ec)
-		return;
-
-	/* Allow transactions to be carried out again */
-	acpi_ec_start(ec, true);
-
-	acpi_ec_enable_event(ec);
-}
-
-void acpi_ec_unblock_transactions_early(void)
-{
 	/*
 	 * Allow transactions to happen again (this function is called from
 	 * atomic context during wakeup, so we don't need to acquire the mutex).
@@ -1706,10 +1692,20 @@ static int acpi_ec_resume_noirq(struct device *dev)
 	acpi_ec_leave_noirq(ec);
 	return 0;
 }
+
+static int acpi_ec_resume(struct device *dev)
+{
+	struct acpi_ec *ec =
+		acpi_driver_data(to_acpi_device(dev));
+
+	acpi_ec_enable_event(ec);
+	return 0;
+}
 #endif
 
 static const struct dev_pm_ops acpi_ec_pm = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend_noirq, acpi_ec_resume_noirq)
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, acpi_ec_resume)
 };
 
 static int param_set_event_clearing(const char *val, struct kernel_param *kp)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 6996121..29f2063 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -189,7 +189,6 @@ int acpi_ec_ecdt_probe(void);
 int acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
-void acpi_ec_unblock_transactions_early(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 9788663..deb0ff7 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -586,7 +586,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	 */
 	acpi_disable_all_gpes();
 	/* Allow EC transactions to happen. */
-	acpi_ec_unblock_transactions_early();
+	acpi_ec_unblock_transactions();
 
 	suspend_nvs_restore();
 
@@ -784,7 +784,7 @@ static void acpi_hibernation_leave(void)
 	/* Restore the NVS memory area */
 	suspend_nvs_restore();
 	/* Allow EC transactions to happen. */
-	acpi_ec_unblock_transactions_early();
+	acpi_ec_unblock_transactions();
 }
 
 static void acpi_pm_thaw(void)
-- 
1.7.10

