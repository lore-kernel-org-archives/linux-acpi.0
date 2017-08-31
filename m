From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 1/3] ACPI / EC: Fix possible driver order issue by moving EC event handling earlier
Date: Thu, 31 Aug 2017 16:10:26 +0800
Message-ID: <e91f745f0d8b8f37ffcae6dacd6808c714416b70.1504166863.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1504166863.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504166863.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch tries to detect EC events earlier after resume, so that if an
event occurred before invoking acpi_ec_unblock_transactions(), it could be
detected by acpi_ec_unblock_transactions() which is the earliest EC driver
call after resume.

However after the noirq stage, if an event ocurred after
acpi_ec_unblock_transactions() and before acpi_ec_resume(), there was no
mean to detect and trigger it, finally it could cause EC event handling
stuck. Thus this patch also adds a detection in acpi_ec_resume(), trying to
recover from the affection of the noirq stage.

The background of the affection:
  EC IRQs contain transaction IRQs (OBF/IBF) and event IRQ (SCI_EVT).
  1. Transactions are initiated by hosts. The earliest OSPMs execution of
     EC transactions is from acpi_ec_transaction(), where the common EC IRQ
     handling procedure - advance_transaction() - is initiated from the
     task context.
  2. Events are initiated by targets. The earliest OSPMs execution of EC
     events is from acpi_ec_gpe_handler(), where the common EC IRQ handling
     procedure - advance_transaction() - is initiated from the IRQ context.
  During suspend/resume noirq stage, IRQ is disabled, advance_transaction()
  which detects SCI_EVT can only be invoked from task context - ec_poll().
  Thus if there is no EC transaction occurring in this stage, EC driver
  cannot detect SCI_EVT. And the worst case is if there is no EC
  transaction after resume, EC event handling will stuck (FW flags SCI_EVT,
  but there is no triggering source for OS SW to detect it).

Now the final logic is:
1. If ec_freeze_events=Y, event handling is stopped in acpi_ec_suspend(),
   restarted in acpi_ec_resume();
2. If ec_freeze_events=N, event handling is stopped in
   acpi_ec_block_transactions(), restarted in
   acpi_ec_unblock_transactions();
3. In order to handling the conflict of the edge-trigger nature of EC IRQ
   and the Linux noirq stage, advance_transaction() is invoked where the
   event handling is enabled and the noirq stage is ended.

Known issue:
1. Event ocurred between acpi_ec_unblock_transactions() and
   acpi_ec_resume() may still lead to the order issue. This can only be
   fixed by adding a periodic detection mechanism during the noirq stage.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
---
 drivers/acpi/ec.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index fdfae6f..3dc4205 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -486,8 +486,11 @@ static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
 {
 	if (!test_and_set_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags))
 		ec_log_drv("event unblocked");
-	if (!test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
-		advance_transaction(ec);
+	/*
+	 * Unconditionally invoke this once after enabling the event
+	 * handling mechanism to detect the pending events.
+	 */
+	advance_transaction(ec);
 }
 
 static inline void __acpi_ec_disable_event(struct acpi_ec *ec)
@@ -945,7 +948,8 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 		if (!resuming) {
 			acpi_ec_submit_request(ec);
 			ec_dbg_ref(ec, "Increase driver");
-		}
+		} else if (!ec_freeze_events)
+			__acpi_ec_enable_event(ec);
 		ec_log_drv("EC started");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
@@ -1929,7 +1933,18 @@ static int acpi_ec_resume(struct device *dev)
 	struct acpi_ec *ec =
 		acpi_driver_data(to_acpi_device(dev));
 
-	acpi_ec_enable_event(ec);
+	if (ec_freeze_events)
+		acpi_ec_enable_event(ec);
+	else {
+		/*
+		 * Though whether there is an event pending has been
+		 * checked in acpi_ec_unblock_transactions() when
+		 * ec_freeze_events=N, check it one more time after noirq
+		 * stage to detect events occurred after
+		 * acpi_ec_unblock_transactions().
+		 */
+		advance_transaction(ec);
+	}
 	return 0;
 }
 #endif
-- 
2.7.4
