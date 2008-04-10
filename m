From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 11/13] ACPI: thinkpad-acpi: use a private workqueue
Date: Thu, 10 Apr 2008 00:53:03 -0300
Message-ID: <1207799585-10112-12-git-send-email-hmh@hmh.eng.br>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58155 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754993AbYDJDxN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2008 23:53:13 -0400
In-Reply-To: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Switch all task workers to a private thinkpad-acpi workqueue.

This way, we don't risk causing trouble for other tasks scheduled to the
default work queue, as our workers end up needing to access the ACPI EC,
run ACPI AML code, trigger SMI traps... and none of those are exactly known
to be fast, simple operations.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 0d05719..22ba93c 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -140,6 +140,7 @@ enum {
 #define TPACPI_HWMON_DRVR_NAME TPACPI_NAME "_hwmon"
 
 #define TPACPI_NVRAM_KTHREAD_NAME "ktpacpi_nvramd"
+#define TPACPI_WORKQUEUE_NAME "ktpacpid"
 
 #define TPACPI_MAX_ACPI_ARGS 3
 
@@ -272,6 +273,8 @@ static enum {
 static int experimental;
 static u32 dbg_level;
 
+static struct workqueue_struct *tpacpi_wq;
+
 /* Special LED class that can defer work */
 struct tpacpi_led_classdev {
 	struct led_classdev led_classdev;
@@ -3297,7 +3300,7 @@ static void light_sysfs_set(struct led_classdev *led_cdev,
 			     struct tpacpi_led_classdev,
 			     led_classdev);
 	data->new_brightness = brightness;
-	schedule_work(&data->work);
+	queue_work(tpacpi_wq, &data->work);
 }
 
 static enum led_brightness light_sysfs_get(struct led_classdev *led_cdev)
@@ -3354,7 +3357,7 @@ static void light_exit(void)
 {
 	led_classdev_unregister(&tpacpi_led_thinklight.led_classdev);
 	if (work_pending(&tpacpi_led_thinklight.work))
-		flush_scheduled_work();
+		flush_workqueue(tpacpi_wq);
 }
 
 static int light_read(char *p)
@@ -3924,7 +3927,7 @@ static void led_sysfs_set(struct led_classdev *led_cdev,
 			     struct tpacpi_led_classdev, led_classdev);
 
 	data->new_brightness = brightness;
-	schedule_work(&data->work);
+	queue_work(tpacpi_wq, &data->work);
 }
 
 static int led_sysfs_blink_set(struct led_classdev *led_cdev,
@@ -3942,7 +3945,7 @@ static int led_sysfs_blink_set(struct led_classdev *led_cdev,
 		return -EINVAL;
 
 	data->new_brightness = TPACPI_LED_BLINK;
-	schedule_work(&data->work);
+	queue_work(tpacpi_wq, &data->work);
 
 	return 0;
 }
@@ -5407,11 +5410,11 @@ static void fan_watchdog_reset(void)
 	if (fan_watchdog_maxinterval > 0 &&
 	    tpacpi_lifecycle != TPACPI_LIFE_EXITING) {
 		fan_watchdog_active = 1;
-		if (!schedule_delayed_work(&fan_watchdog_task,
+		if (!queue_delayed_work(tpacpi_wq, &fan_watchdog_task,
 				msecs_to_jiffies(fan_watchdog_maxinterval
 						 * 1000))) {
 			printk(TPACPI_ERR
-			       "failed to schedule the fan watchdog, "
+			       "failed to queue the fan watchdog, "
 			       "watchdog will not trigger\n");
 		}
 	} else
@@ -5781,7 +5784,7 @@ static void fan_exit(void)
 			   &driver_attr_fan_watchdog);
 
 	cancel_delayed_work(&fan_watchdog_task);
-	flush_scheduled_work();
+	flush_workqueue(tpacpi_wq);
 }
 
 static int fan_read(char *p)
@@ -6435,6 +6438,9 @@ static void thinkpad_acpi_module_exit(void)
 	if (proc_dir)
 		remove_proc_entry(TPACPI_PROC_DIR, acpi_root_dir);
 
+	if (tpacpi_wq)
+		destroy_workqueue(tpacpi_wq);
+
 	kfree(thinkpad_id.bios_version_str);
 	kfree(thinkpad_id.ec_version_str);
 	kfree(thinkpad_id.model_str);
@@ -6465,6 +6471,12 @@ static int __init thinkpad_acpi_module_init(void)
 	TPACPI_ACPIHANDLE_INIT(ecrd);
 	TPACPI_ACPIHANDLE_INIT(ecwr);
 
+	tpacpi_wq = create_singlethread_workqueue(TPACPI_WORKQUEUE_NAME);
+	if (!tpacpi_wq) {
+		thinkpad_acpi_module_exit();
+		return -ENOMEM;
+	}
+
 	proc_dir = proc_mkdir(TPACPI_PROC_DIR, acpi_root_dir);
 	if (!proc_dir) {
 		printk(TPACPI_ERR
-- 
1.5.4.4

