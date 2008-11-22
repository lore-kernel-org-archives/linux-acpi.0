From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 07/11] ACPI: thinkpad-acpi: use killable instead of interruptible mutexes
Date: Sat, 22 Nov 2008 09:48:49 -0200
Message-ID: <1227354533-19788-8-git-send-email-hmh@hmh.eng.br>
References: <1227354533-19788-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39274 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757376AbYKVLtB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Nov 2008 06:49:01 -0500
In-Reply-To: <1227354533-19788-1-git-send-email-hmh@hmh.eng.br>
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
 drivers/misc/thinkpad_acpi.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 651ea9d..50cdcf1 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1879,7 +1879,7 @@ static ssize_t hotkey_mask_show(struct device *dev,
 {
 	int res;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 	res = hotkey_mask_get();
 	mutex_unlock(&hotkey_mutex);
@@ -1898,7 +1898,7 @@ static ssize_t hotkey_mask_store(struct device *dev,
 	if (parse_strtoul(buf, 0xffffffffUL, &t))
 		return -EINVAL;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
 	res = hotkey_mask_set(t);
@@ -1984,7 +1984,7 @@ static ssize_t hotkey_source_mask_store(struct device *dev,
 		((t & ~TPACPI_HKEY_NVRAM_KNOWN_MASK) != 0))
 		return -EINVAL;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
 	HOTKEY_CONFIG_CRITICAL_START
@@ -2019,7 +2019,7 @@ static ssize_t hotkey_poll_freq_store(struct device *dev,
 	if (parse_strtoul(buf, 25, &t))
 		return -EINVAL;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
 	hotkey_poll_freq = t;
@@ -2755,7 +2755,7 @@ static int hotkey_read(char *p)
 		return len;
 	}
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 	res = hotkey_status_get(&status);
 	if (!res)
@@ -2786,7 +2786,7 @@ static int hotkey_write(char *buf)
 	if (!tp_features.hotkey)
 		return -ENODEV;
 
-	if (mutex_lock_interruptible(&hotkey_mutex))
+	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
 	status = -1;
@@ -5312,7 +5312,7 @@ static int brightness_set(int value)
 	    value < 0)
 		return -EINVAL;
 
-	res = mutex_lock_interruptible(&brightness_mutex);
+	res = mutex_lock_killable(&brightness_mutex);
 	if (res < 0)
 		return res;
 
@@ -5850,7 +5850,7 @@ static int fan_get_status_safe(u8 *status)
 	int rc;
 	u8 s;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 	rc = fan_get_status(&s);
 	if (!rc)
@@ -5933,7 +5933,7 @@ static int fan_set_level_safe(int level)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	if (level == TPACPI_FAN_LAST_LEVEL)
@@ -5955,7 +5955,7 @@ static int fan_set_enable(void)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	switch (fan_control_access_mode) {
@@ -6010,7 +6010,7 @@ static int fan_set_disable(void)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	rc = 0;
@@ -6048,7 +6048,7 @@ static int fan_set_speed(int speed)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	rc = 0;
@@ -6250,7 +6250,7 @@ static ssize_t fan_pwm1_store(struct device *dev,
 	/* scale down from 0-255 to 0-7 */
 	newlevel = (s >> 5) & 0x07;
 
-	if (mutex_lock_interruptible(&fan_mutex))
+	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 
 	rc = fan_get_status(&status);
-- 
1.5.6.5

