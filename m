From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 6/7] [sony-laptop] add control over wifi power in Sony laptops
Date: Mon,  3 Nov 2008 18:41:19 +0900
Message-ID: <1225705280-12775-7-git-send-email-malattia@linux.it>
References: <1225705280-12775-1-git-send-email-malattia@linux.it>
 <1225705280-12775-2-git-send-email-malattia@linux.it>
 <1225705280-12775-3-git-send-email-malattia@linux.it>
 <1225705280-12775-4-git-send-email-malattia@linux.it>
 <1225705280-12775-5-git-send-email-malattia@linux.it>
 <1225705280-12775-6-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48107
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754943AbYKCJlY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 04:41:24 -0500
In-Reply-To: <1225705280-12775-6-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Sergey Yanovich <ynvich@gmail.com>, Mattia Dongili <malattia@linux.it>

From: Sergey Yanovich <ynvich@gmail.com>

Sony laptops have a single hardware rfkill switch, which controls
several wireless devices: wifi, bluetooth, wwan. The code to
selectively control bluetooth and wwan is already present. This
patch adds handling of wifi.

Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 31f84ce..77fe584 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1241,6 +1241,7 @@ struct sony_pic_dev {
 	u8			camera_power;
 	u8			bluetooth_power;
 	u8			wwan_power;
+	u8			wifi_power;
 };
 
 static struct sony_pic_dev spic_dev = {
@@ -1806,6 +1807,44 @@ static ssize_t sony_pic_wwanpower_show(struct device *dev,
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
+	if (strict_strtoul(buffer, 10, &value))
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
@@ -1888,11 +1927,13 @@ struct device_attribute spic_attr_##_name = __ATTR(_name,	\
 
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
1.5.6.5

