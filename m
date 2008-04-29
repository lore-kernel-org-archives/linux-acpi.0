From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH] acpi: synchronize wireless power state for Sony laptops
Date: Tue, 29 Apr 2008 16:38:55 +0300
Message-ID: <1209476335-7902-1-git-send-email-ynvich@gmail.com>
References: <1208558495-22792-3-git-send-email-ynvich@gmail.com> <1208562682-25934-1-git-send-email-ynvich@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:23590 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060AbYD2NjA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 09:39:00 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3598fgb.17
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 06:38:59 -0700 (PDT)
In-Reply-To: <1208562682-25934-1-git-send-email-ynvich@gmail.com>
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

Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
---
 drivers/misc/sony-laptop.c |   36 ++++++++++++++++++++++++++++++++----
 1 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index e5b8709..bd97e1c 100644
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
+		/* fall through here */
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
@@ -1832,7 +1845,7 @@ static ssize_t sony_pic_wifipower_show(struct device *dev,
 static void __sony_pic_set_bluetoothpower(u8 state)
 {
 	state = !!state;
-	if (spic_dev.bluetooth_power == state)
+	if (spic_dev.rfkill || spic_dev.bluetooth_power == state)
 		return;
 	sony_pic_call2(0x96, state);
 	sony_pic_call1(0x82);
@@ -1865,6 +1878,20 @@ static ssize_t sony_pic_bluetoothpower_show(struct device *dev,
 	return count;
 }
 
+static void sony_pic_rfkill_event(u8 is_on)
+{
+	if (spic_dev.control->model != SONYPI_DEVICE_TYPE4)
+		return;
+
+	mutex_lock(&spic_dev.lock);
+	spic_dev.rfkill = !is_on;
+	spic_dev.bluetooth_power = is_on;
+	spic_dev.wifi_power = is_on;
+	if (!is_on)
+		spic_dev.wwan_power = 0;
+	mutex_unlock(&spic_dev.lock);
+}
+
 /* fan speed */
 /* FAN0 information (reverse engineered from ACPI tables) */
 #define SONY_PIC_FAN0_STATUS	0x93
@@ -2683,7 +2710,8 @@ static int sony_pic_add(struct acpi_device *device)
 		goto err_free_irq;
 	}
 
-	spic_dev.bluetooth_power = -1;
+	spic_dev.bluetooth_power = 1;
+	spic_dev.wifi_power = 1;
 	/* create device attributes */
 	result = sony_pf_add();
 	if (result)
-- 
1.5.5.1

