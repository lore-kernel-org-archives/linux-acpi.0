From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/8] thinkpad-acpi: hotkey poll fixes
Date: Sat, 12 Sep 2009 15:22:14 -0300
Message-ID: <1252779738-7459-5-git-send-email-hmh@hmh.eng.br>
References: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48415 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754559AbZILSWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Sep 2009 14:22:22 -0400
In-Reply-To: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix some locking, avoid exiting the kthread before kthread_stop() is
called on it, and clean up the hotkey poll routines a little bit.

Also, restore bits in the firmware mask after hotkey_source_mask is
changed.  Without this, we leave events disabled...

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |  108 +++++++++++++++++++++++-----------
 1 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d69ab3f..679a73b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1922,16 +1922,42 @@ struct tp_nvram_state {
        u8 volume_level;
 };
 
+/* kthread for the hotkey poller */
 static struct task_struct *tpacpi_hotkey_task;
-static u32 hotkey_source_mask;		/* bit mask 0=ACPI,1=NVRAM */
-static int hotkey_poll_freq = 10;	/* Hz */
+
+/* Acquired while the poller kthread is running, use to sync start/stop */
 static struct mutex hotkey_thread_mutex;
+
+/*
+ * Acquire mutex to write poller control variables.
+ * Increment hotkey_config_change when changing them.
+ *
+ * See HOTKEY_CONFIG_CRITICAL_START/HOTKEY_CONFIG_CRITICAL_END
+ */
 static struct mutex hotkey_thread_data_mutex;
 static unsigned int hotkey_config_change;
 
+/*
+ * hotkey poller control variables
+ *
+ * Must be atomic or readers will also need to acquire mutex
+ */
+static u32 hotkey_source_mask;		/* bit mask 0=ACPI,1=NVRAM */
+static unsigned int hotkey_poll_freq = 10; /* Hz */
+
+#define HOTKEY_CONFIG_CRITICAL_START \
+	do { \
+		mutex_lock(&hotkey_thread_data_mutex); \
+		hotkey_config_change++; \
+	} while (0);
+#define HOTKEY_CONFIG_CRITICAL_END \
+	mutex_unlock(&hotkey_thread_data_mutex);
+
 #else /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
 #define hotkey_source_mask 0U
+#define HOTKEY_CONFIG_CRITICAL_START
+#define HOTKEY_CONFIG_CRITICAL_END
 
 #endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
@@ -1956,19 +1982,6 @@ static u16 *hotkey_keycode_map;
 
 static struct attribute_set *hotkey_dev_attributes;
 
-#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
-#define HOTKEY_CONFIG_CRITICAL_START \
-	do { \
-		mutex_lock(&hotkey_thread_data_mutex); \
-		hotkey_config_change++; \
-	} while (0);
-#define HOTKEY_CONFIG_CRITICAL_END \
-	mutex_unlock(&hotkey_thread_data_mutex);
-#else
-#define HOTKEY_CONFIG_CRITICAL_START
-#define HOTKEY_CONFIG_CRITICAL_END
-#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
-
 /* HKEY.MHKG() return bits */
 #define TP_HOTKEY_TABLET_MASK (1 << 3)
 
@@ -2013,7 +2026,9 @@ static int hotkey_mask_get(void)
 		if (!acpi_evalf(hkey_handle, &m, "DHKN", "d"))
 			return -EIO;
 	}
+	HOTKEY_CONFIG_CRITICAL_START
 	hotkey_mask = m | (hotkey_source_mask & hotkey_mask);
+	HOTKEY_CONFIG_CRITICAL_END
 
 	return 0;
 }
@@ -2266,6 +2281,7 @@ static int hotkey_kthread(void *data)
 	unsigned int si, so;
 	unsigned long t;
 	unsigned int change_detector, must_reset;
+	unsigned int poll_freq;
 
 	mutex_lock(&hotkey_thread_mutex);
 
@@ -2282,12 +2298,17 @@ static int hotkey_kthread(void *data)
 	mutex_lock(&hotkey_thread_data_mutex);
 	change_detector = hotkey_config_change;
 	mask = hotkey_source_mask & hotkey_mask;
+	poll_freq = hotkey_poll_freq;
 	mutex_unlock(&hotkey_thread_data_mutex);
 	hotkey_read_nvram(&s[so], mask);
 
-	while (!kthread_should_stop() && hotkey_poll_freq) {
-		if (t == 0)
-			t = 1000/hotkey_poll_freq;
+	while (!kthread_should_stop()) {
+		if (t == 0) {
+			if (likely(poll_freq))
+				t = 1000/poll_freq;
+			else
+				t = 100;	/* should never happen... */
+		}
 		t = msleep_interruptible(t);
 		if (unlikely(kthread_should_stop()))
 			break;
@@ -2303,6 +2324,7 @@ static int hotkey_kthread(void *data)
 			change_detector = hotkey_config_change;
 		}
 		mask = hotkey_source_mask & hotkey_mask;
+		poll_freq = hotkey_poll_freq;
 		mutex_unlock(&hotkey_thread_data_mutex);
 
 		if (likely(mask)) {
@@ -2322,6 +2344,7 @@ exit:
 	return 0;
 }
 
+/* call with hotkey_mutex held */
 static void hotkey_poll_stop_sync(void)
 {
 	if (tpacpi_hotkey_task) {
@@ -2338,10 +2361,11 @@ static void hotkey_poll_stop_sync(void)
 }
 
 /* call with hotkey_mutex held */
-static void hotkey_poll_setup(int may_warn)
+static void hotkey_poll_setup(bool may_warn)
 {
-	if ((hotkey_source_mask & hotkey_mask) != 0 &&
-	    hotkey_poll_freq > 0 &&
+	u32 hotkeys_to_poll = hotkey_source_mask & hotkey_mask;
+
+	if (hotkeys_to_poll != 0 && hotkey_poll_freq > 0 &&
 	    (tpacpi_inputdev->users > 0 || hotkey_report_mode < 2)) {
 		if (!tpacpi_hotkey_task) {
 			tpacpi_hotkey_task = kthread_run(hotkey_kthread,
@@ -2355,26 +2379,37 @@ static void hotkey_poll_setup(int may_warn)
 		}
 	} else {
 		hotkey_poll_stop_sync();
-		if (may_warn &&
-		    hotkey_source_mask != 0 && hotkey_poll_freq == 0) {
+		if (may_warn && hotkeys_to_poll != 0 &&
+		    hotkey_poll_freq == 0) {
 			printk(TPACPI_NOTICE
 				"hot keys 0x%08x require polling, "
 				"which is currently disabled\n",
-				hotkey_source_mask);
+				hotkeys_to_poll);
 		}
 	}
 }
 
-static void hotkey_poll_setup_safe(int may_warn)
+static void hotkey_poll_setup_safe(bool may_warn)
 {
 	mutex_lock(&hotkey_mutex);
 	hotkey_poll_setup(may_warn);
 	mutex_unlock(&hotkey_mutex);
 }
 
+/* call with hotkey_mutex held */
+static void hotkey_poll_set_freq(unsigned int freq)
+{
+	if (!freq)
+		hotkey_poll_stop_sync();
+
+	HOTKEY_CONFIG_CRITICAL_START
+	hotkey_poll_freq = freq;
+	HOTKEY_CONFIG_CRITICAL_END
+}
+
 #else /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
-static void hotkey_poll_setup_safe(int __unused)
+static void hotkey_poll_setup_safe(bool __unused)
 {
 }
 
@@ -2392,7 +2427,7 @@ static int hotkey_inputdev_open(struct input_dev *dev)
 	case TPACPI_LIFE_EXITING:
 		return -EBUSY;
 	case TPACPI_LIFE_RUNNING:
-		hotkey_poll_setup_safe(0);
+		hotkey_poll_setup_safe(false);
 		return 0;
 	}
 
@@ -2405,7 +2440,7 @@ static void hotkey_inputdev_close(struct input_dev *dev)
 {
 	/* disable hotkey polling when possible */
 	if (tpacpi_lifecycle == TPACPI_LIFE_RUNNING)
-		hotkey_poll_setup_safe(0);
+		hotkey_poll_setup_safe(false);
 }
 
 /* sysfs hotkey enable ------------------------------------------------- */
@@ -2479,7 +2514,7 @@ static ssize_t hotkey_mask_store(struct device *dev,
 	res = hotkey_mask_set(t);
 
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
-	hotkey_poll_setup(1);
+	hotkey_poll_setup(true);
 #endif
 
 	mutex_unlock(&hotkey_mutex);
@@ -2568,7 +2603,8 @@ static ssize_t hotkey_source_mask_store(struct device *dev,
 	hotkey_source_mask = t;
 	HOTKEY_CONFIG_CRITICAL_END
 
-	hotkey_poll_setup(1);
+	hotkey_poll_setup(true);
+	hotkey_mask_set(hotkey_mask);
 
 	mutex_unlock(&hotkey_mutex);
 
@@ -2601,9 +2637,9 @@ static ssize_t hotkey_poll_freq_store(struct device *dev,
 	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
-	hotkey_poll_freq = t;
+	hotkey_poll_set_freq(t);
+	hotkey_poll_setup(true);
 
-	hotkey_poll_setup(1);
 	mutex_unlock(&hotkey_mutex);
 
 	tpacpi_disclose_usertask("hotkey_poll_freq", "set to %lu\n", t);
@@ -2794,7 +2830,9 @@ static void tpacpi_send_radiosw_update(void)
 static void hotkey_exit(void)
 {
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+	mutex_lock(&hotkey_mutex);
 	hotkey_poll_stop_sync();
+	mutex_unlock(&hotkey_mutex);
 #endif
 
 	if (hotkey_dev_attributes)
@@ -3031,7 +3069,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	}
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
-		    "hotkey source mask 0x%08x, polling freq %d\n",
+		    "hotkey source mask 0x%08x, polling freq %u\n",
 		    hotkey_source_mask, hotkey_poll_freq);
 #endif
 
@@ -3169,7 +3207,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	tpacpi_inputdev->open = &hotkey_inputdev_open;
 	tpacpi_inputdev->close = &hotkey_inputdev_close;
 
-	hotkey_poll_setup_safe(1);
+	hotkey_poll_setup_safe(true);
 	tpacpi_send_radiosw_update();
 	tpacpi_input_send_tabletsw();
 
@@ -3457,7 +3495,7 @@ static void hotkey_resume(void)
 	hotkey_tablet_mode_notify_change();
 	hotkey_wakeup_reason_notify_change();
 	hotkey_wakeup_hotunplug_complete_notify_change();
-	hotkey_poll_setup_safe(0);
+	hotkey_poll_setup_safe(false);
 }
 
 /* procfs -------------------------------------------------------------- */
-- 
1.6.3.3

