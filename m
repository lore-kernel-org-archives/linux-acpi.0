From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3] ACPI / EC: Add PM operations to tune polling mode efficiency for suspend/resume noirq stage
Date: Wed,  3 Aug 2016 09:07:58 +0800
Message-ID: <4b12edb6ba5a96a7370f7ce3744932bb8b42d39d.1470186408.git.lv.zheng@intel.com>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37445 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbcHCBMA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Aug 2016 21:12:00 -0400
In-Reply-To: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

It is reported that on some platforms, resume speed is not fast. The cause
is: in noirq stage, EC driver is working in polling mode, and each state
machine advancement requires a context switch.

The context switch is not necessary to the EC driver's polling mode. This
patch implements PM hooks to automatically switch the driver to/from the
busy polling mode to eliminate the overhead caused by the context switch.

This finally contributes to the tuning result: acpi_pm_finish() execution
time is improved from 192ms to 6ms.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reported-and-tested-by: Todd E Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/acpi/ec.c       |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h |    2 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e7bd57c..6f6c7d1 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1619,6 +1619,58 @@ error:
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static void acpi_ec_enter_noirq(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	if (ec == first_ec) {
+		spin_lock_irqsave(&ec->lock, flags);
+		ec->saved_busy_polling = ec_busy_polling;
+		ec->saved_polling_guard = ec_polling_guard;
+		ec_busy_polling = true;
+		ec_polling_guard = 0;
+		ec_log_drv("interrupt blocked");
+		spin_unlock_irqrestore(&ec->lock, flags);
+	}
+}
+
+static void acpi_ec_leave_noirq(struct acpi_ec *ec)
+{
+	unsigned long flags;
+
+	if (ec == first_ec) {
+		spin_lock_irqsave(&ec->lock, flags);
+		ec_busy_polling = ec->saved_busy_polling;
+		ec_polling_guard = ec->saved_polling_guard;
+		ec_log_drv("interrupt unblocked");
+		spin_unlock_irqrestore(&ec->lock, flags);
+	}
+}
+
+static int acpi_ec_suspend_noirq(struct device *dev)
+{
+	struct acpi_ec *ec =
+		acpi_driver_data(to_acpi_device(dev));
+
+	acpi_ec_enter_noirq(ec);
+	return 0;
+}
+
+static int acpi_ec_resume_noirq(struct device *dev)
+{
+	struct acpi_ec *ec =
+		acpi_driver_data(to_acpi_device(dev));
+
+	acpi_ec_leave_noirq(ec);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops acpi_ec_pm = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(acpi_ec_suspend_noirq, acpi_ec_resume_noirq)
+};
+
 static int param_set_event_clearing(const char *val, struct kernel_param *kp)
 {
 	int result = 0;
@@ -1664,6 +1716,7 @@ static struct acpi_driver acpi_ec_driver = {
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
 		},
+	.drv.pm = &acpi_ec_pm,
 };
 
 static inline int acpi_ec_query_init(void)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 940218f..6996121 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -174,6 +174,8 @@ struct acpi_ec {
 	struct work_struct work;
 	unsigned long timestamp;
 	unsigned long nr_pending_queries;
+	bool saved_busy_polling;
+	unsigned int saved_polling_guard;
 };
 
 extern struct acpi_ec *first_ec;
-- 
1.7.10

