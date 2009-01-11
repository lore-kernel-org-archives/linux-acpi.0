From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 07/13] ACPI: thinkpad-acpi: use killable instead of interruptible mutexes
Date: Sun, 11 Jan 2009 03:01:04 -0200
Message-ID: <1231650070-21722-8-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56221 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750749AbZAKFBR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Unfortunately, POSIX in all of its braindamage, do not state that userspace has
to deal with EINTR in read/write and friends... so, lesser code just doesn't.

Switch from *_interruptible to *_killable on the sysfs- and procfs-related
mutexes.  This closes this possible can of worms.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c1d4041..7670c8e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1878,7 +1878,7 @@ static ssize_t hotkey_mask_show(struct device *dev,
 {
 	int res;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 	res = hotkey_mask_get();
 	mutex_unlock(&hotkey_mutex);
@@ -1897,7 +1897,7 @@ static ssize_t hotkey_mask_store(struct device *dev,
 	if (parse_strtoul(buf, 0xffffffffUL, &t))
 		return -EINVAL;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
 	res = hotkey_mask_set(t);
@@ -1983,7 +1983,7 @@ static ssize_t hotkey_source_mask_store(struct device *dev,
 		((t & ~TPACPI_HKEY_NVRAM_KNOWN_MASK) != 0))
 		return -EINVAL;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
 	HOTKEY_CONFIG_CRITICAL_START
@@ -2018,7 +2018,7 @@ static ssize_t hotkey_poll_freq_store(struct device *dev,
 	if (parse_strtoul(buf, 25, &t))
 		return -EINVAL;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
 	hotkey_poll_freq = t;
@@ -2754,7 +2754,7 @@ static int hotkey_read(char *p)
 		return len;
 	}
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 	res = hotkey_status_get(&status);
 	if (!res)
@@ -2785,7 +2785,7 @@ static int hotkey_write(char *buf)
 	if (!tp_features.hotkey)
 		return -ENODEV;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
 	status = -1;
@@ -5311,7 +5311,7 @@ static int brightness_set(int value)
 	    value < 0)
 		return -EINVAL;
 
-	res = mutex_lock_interruptible(&brightness_mutex);
+	res = mutex_lock_killable(&brightness_mutex);
 	if (res < 0)
 		return res;
 
@@ -5849,7 +5849,7 @@ static int fan_get_status_safe(u8 *status)
 	int rc;
 	u8 s;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 	rc = fan_get_status(&s);
 	if (!rc)
@@ -5932,7 +5932,7 @@ static int fan_set_level_safe(int level)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	if (level == TPACPI_FAN_LAST_LEVEL)
@@ -5954,7 +5954,7 @@ static int fan_set_enable(void)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	switch (fan_control_access_mode) {
@@ -6009,7 +6009,7 @@ static int fan_set_disable(void)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	rc = 0;
@@ -6047,7 +6047,7 @@ static int fan_set_speed(int speed)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	rc = 0;
@@ -6249,7 +6249,7 @@ static ssize_t fan_pwm1_store(struct device *dev,
 	/* scale down from 0-255 to 0-7 */
 	newlevel = (s >> 5) & 0x07;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	rc = fan_get_status(&status);
-- 
1.5.6.5

