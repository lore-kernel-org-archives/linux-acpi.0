From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPI / EC: Add PM operations to tune polling mode efficiency
Date: Thu, 21 Jul 2016 17:36:06 +0800
Message-ID: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

When the PM code disables all IRQs, EC will be in polling mode, it is
efficient to use busy polling with zero timeout in such cases.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c       |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h |    2 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 999a109..c2d135d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1613,6 +1613,58 @@ error:
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
@@ -1658,6 +1710,7 @@ static struct acpi_driver acpi_ec_driver = {
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
 		},
+	.drv.pm = &acpi_ec_pm,
 };
 
 int __init acpi_ec_init(void)
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
