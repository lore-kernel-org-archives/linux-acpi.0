From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/3] ACPI: EC: Change EC noirq tuning to be an optional behavior
Date: Wed, 14 Jun 2017 13:59:24 +0800
Message-ID: <157972fa5572b0f0c157142ea151b8508e7640b4.1497418749.git.lv.zheng@intel.com>
References: <d8ac96c8fd988daec20f7a22a2acb3119ccd149b.1497418749.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d8ac96c8fd988daec20f7a22a2acb3119ccd149b.1497418749.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

According to the bug report, though the busy polling mode can make noirq
stages executed faster, it causes abnormal fan blowing in noirq stages.

This patch prepares an option so that the automatic busy polling mode
switching for noirq stages can be enabled by who wants to tune it, not all
users.
Noticed that the new global option cannot be changed during noirq stages.
There is no need to lock its value changes to sync with polling mode
settings switches.

For reporters and testers in the thread, as there are too many reporters
on the bug link, this patch only picks names from most active commenters.
Sorry for the neglet.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=191181
Reported-by: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Reported-by: Claudio Sacerdoti Coen <claudio.sacerdoticoen@unibo.it>
Tested-by: Nicolo' <nicolopiazzalunga@gmail.com>
Reported-by: Jens Axboe <axboe@kernel.dk>
Tested-by: Gjorgji Jankovski <j.gjorgji@gmail.com>
Tested-by: Damjan Georgievski <gdamjan@gmail.com>
Tested-by: Fernando Chaves <nanochaves@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f3ff591..de5dde6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -151,6 +151,10 @@ static bool ec_freeze_events __read_mostly = true;
 module_param(ec_freeze_events, bool, 0644);
 MODULE_PARM_DESC(ec_freeze_events, "Disabling event handling during suspend/resume");
 
+static bool ec_tune_noirq __read_mostly = false;
+module_param(ec_tune_noirq, bool, 0644);
+MODULE_PARM_DESC(ec_tune_noirq, "Automatic enabling busy polling to tune noirq stages faster");
+
 struct acpi_ec_query_handler {
 	struct list_head node;
 	acpi_ec_query_func func;
@@ -979,9 +983,11 @@ static void acpi_ec_enter_noirq(struct acpi_ec *ec)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ec->lock, flags);
-	ec->busy_polling = true;
-	ec->polling_guard = 0;
-	ec_log_drv("interrupt blocked");
+	if (ec_tune_noirq) {
+		ec->busy_polling = true;
+		ec->polling_guard = 0;
+		ec_log_drv("interrupt blocked");
+	}
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
@@ -990,9 +996,11 @@ static void acpi_ec_leave_noirq(struct acpi_ec *ec)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ec->lock, flags);
-	ec->busy_polling = ec_busy_polling;
-	ec->polling_guard = ec_polling_guard;
-	ec_log_drv("interrupt unblocked");
+	if (ec_tune_noirq) {
+		ec->busy_polling = ec_busy_polling;
+		ec->polling_guard = ec_polling_guard;
+		ec_log_drv("interrupt unblocked");
+	}
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
 
-- 
2.7.4
