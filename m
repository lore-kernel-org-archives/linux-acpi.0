From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 3/3] Synchronize wireless power state with hardware for Sony laptops
Date: Sat, 19 Apr 2008 01:41:35 +0300
Message-ID: <1208558495-22792-3-git-send-email-ynvich@gmail.com>
References: <1208558495-22792-1-git-send-email-ynvich@gmail.com>
 <1208558495-22792-2-git-send-email-ynvich@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:64911 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbYDRWmF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Apr 2008 18:42:05 -0400
Received: by ug-out-1314.google.com with SMTP id z38so174968ugc.16
        for <linux-acpi@vger.kernel.org>; Fri, 18 Apr 2008 15:42:02 -0700 (PDT)
In-Reply-To: <1208558495-22792-2-git-send-email-ynvich@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: malattia@linux.it, Sergey Yanovich <ynvich@gmail.com>

The drivers stores own representation of wireless power states. Since
hardware switch takes presedence over software controls, internal
data goes out of sync with device state, after the hardware switch
is toggled.

This patch safeguards itself against possible conflicts with earlier
models, and will only have any effect on the latest Type 4 devices.
---
 drivers/misc/sony-laptop.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 1e9377e..6678f45 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -281,12 +281,15 @@ static void do_sony_laptop_release_key(struct work_struct *work)
 static DECLARE_WORK(sony_laptop_release_key_work,
 		do_sony_laptop_release_key);
 
+static void sony_pic_rfkill_event(u8 is_on);
+
 /* forward event to the input subsystem */
 static void sony_laptop_report_input_event(u8 event)
 {
 	struct input_dev *jog_dev = sony_laptop_input.jog_dev;
 	struct input_dev *key_dev = sony_laptop_input.key_dev;
 	struct sony_laptop_keypress kp = { NULL };
+	u8 is_on = 0;
 
 	if (event == SONYPI_EVENT_FNKEY_RELEASED) {
 		/* Nothing, not all VAIOs generate this event */
@@ -314,6 +317,15 @@ static void sony_laptop_report_input_event(u8 event)
 		kp.dev = jog_dev;
 		break;
 
+	case SONYPI_EVENT_WIRELESS_ON:
+		is_on = 1;
+		// fall through here
+	case SONYPI_EVENT_WIRELESS_OFF:
+		kp.key = KEY_WLAN;
+		kp.dev = key_dev;
+		sony_pic_rfkill_event(is_on);
+		break;
+
 	default:
 		if (event >= ARRAY_SIZE(sony_laptop_input_index)) {
 			dprintk("sony_laptop_report_input_event, event not known: %d\n", event);
@@ -1228,6 +1240,7 @@ struct sony_pic_dev {
 	u8			bluetooth_power;
 	u8			wwan_power;
 	u8			wifi_power;
+	u8			rfkill;
 };
 
 static struct sony_pic_dev spic_dev = {
@@ -1756,7 +1769,7 @@ static void sony_pic_set_wwanpower(u8 state)
 {
 	state = !!state;
 	mutex_lock(&spic_dev.lock);
-	if (spic_dev.wwan_power == state) {
+	if (spic_dev.rfkill || spic_dev.wwan_power == state) {
 		mutex_unlock(&spic_dev.lock);
 		return;
 	}
@@ -1795,7 +1808,7 @@ static void sony_pic_set_wifipower(u8 state)
 {
 	state = !!state;
 	mutex_lock(&spic_dev.lock);
-	if (spic_dev.wifi_power == state) {
+	if (spic_dev.rfkill || spic_dev.wifi_power == state) {
 		mutex_unlock(&spic_dev.lock);
 		return;
 	}
@@ -1833,11 +1846,15 @@ static ssize_t sony_pic_wifipower_show(struct device *dev,
 static void __sony_pic_set_bluetoothpower(u8 state)
 {
 	state = !!state;
-	if (spic_dev.bluetooth_power == state)
+	mutex_lock(&spic_dev.lock);
+	if (spic_dev.rfkill || spic_dev.bluetooth_power == state) {
+		mutex_unlock(&spic_dev.lock);
 		return;
+	}
 	sony_pic_call2(0x96, state);
 	sony_pic_call1(0x82);
 	spic_dev.bluetooth_power = state;
+	mutex_unlock(&spic_dev.lock);
 }
 
 static ssize_t sony_pic_bluetoothpower_store(struct device *dev,
@@ -1866,6 +1883,20 @@ static ssize_t sony_pic_bluetoothpower_show(struct device *dev,
 	return count;
 }
 
+static void sony_pic_rfkill_event(u8 is_on)
+{
+	if (spic_dev.control->model != SONYPI_DEVICE_TYPE4)
+		return;
+
+	mutex_lock(&spic_dev.lock);
+	spic_dev.rfkill = ! is_on;
+	spic_dev.bluetooth_power = is_on;
+	spic_dev.wifi_power = is_on;
+	if (! is_on)
+		spic_dev.wwan_power = 0;
+	mutex_unlock(&spic_dev.lock);
+}
+
 /* fan speed */
 /* FAN0 information (reverse engineered from ACPI tables) */
 #define SONY_PIC_FAN0_STATUS	0x93
-- 
1.5.5

