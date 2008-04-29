From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH] acpi: add control over wifi power in Sony laptops
Date: Tue, 29 Apr 2008 16:36:49 +0300
Message-ID: <1209476209-7809-1-git-send-email-ynvich@gmail.com>
References: <1208558495-22792-2-git-send-email-ynvich@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:19088 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbYD2Ngz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 09:36:55 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2923fgb.17
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2008 06:36:54 -0700 (PDT)
In-Reply-To: <1208558495-22792-2-git-send-email-ynvich@gmail.com>
In-Reply-To: <1208558495-22792-2-git-send-email-ynvich@gmail.com>
References: <1208558495-22792-2-git-send-email-ynvich@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: malattia@linux.it, Sergey Yanovich <ynvich@gmail.com>

Sony laptops have a single hardware rfkill switch, which controls
several wireless devices: wifi, bluetooth, wwan. The code to
selectively control bluetooth and wwan is already present. This
paths adds handling of wifi.

Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
---
 drivers/misc/sony-laptop.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index be70153..e5b8709 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1227,6 +1227,7 @@ struct sony_pic_dev {
 	u8			camera_power;
 	u8			bluetooth_power;
 	u8			wwan_power;
+	u8			wifi_power;
 };
 
 static struct sony_pic_dev spic_dev = {
@@ -1760,6 +1761,7 @@ static void sony_pic_set_wwanpower(u8 state)
 		return;
 	}
 	sony_pic_call2(0xB0, state);
+	sony_pic_call1(0x82);
 	spic_dev.wwan_power = state;
 	mutex_unlock(&spic_dev.lock);
 }
@@ -1788,6 +1790,44 @@ static ssize_t sony_pic_wwanpower_show(struct device *dev,
 	return count;
 }
 
+/* wifi power (TX series) */
+static void sony_pic_set_wifipower(u8 state)
+{
+	state = !!state;
+	mutex_lock(&spic_dev.lock);
+	if (spic_dev.wifi_power == state) {
+		mutex_unlock(&spic_dev.lock);
+		return;
+	}
+	sony_pic_call2(0x98, -state);
+	sony_pic_call1(0x82);
+	spic_dev.wifi_power = state;
+	mutex_unlock(&spic_dev.lock);
+}
+
+static ssize_t sony_pic_wifipower_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buffer, size_t count)
+{
+	unsigned long value;
+	if (!strict_strtoul(buffer, 10, &value))
+		return -EINVAL;
+
+	sony_pic_set_wifipower(value);
+
+	return count;
+}
+
+static ssize_t sony_pic_wifipower_show(struct device *dev,
+		struct device_attribute *attr, char *buffer)
+{
+	ssize_t count;
+	mutex_lock(&spic_dev.lock);
+	count = snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.wifi_power);
+	mutex_unlock(&spic_dev.lock);
+	return count;
+}
+
 /* bluetooth subsystem power state */
 static void __sony_pic_set_bluetoothpower(u8 state)
 {
@@ -1870,11 +1910,13 @@ struct device_attribute spic_attr_##_name = __ATTR(_name,	\
 
 static SPIC_ATTR(bluetoothpower, 0644);
 static SPIC_ATTR(wwanpower, 0644);
+static SPIC_ATTR(wifipower, 0644);
 static SPIC_ATTR(fanspeed, 0644);
 
 static struct attribute *spic_attributes[] = {
 	&spic_attr_bluetoothpower.attr,
 	&spic_attr_wwanpower.attr,
+	&spic_attr_wifipower.attr,
 	&spic_attr_fanspeed.attr,
 	NULL
 };
-- 
1.5.5.1

