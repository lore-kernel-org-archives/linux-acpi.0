From: malattia@linux.it
Subject: [patch 3/9 v2] sony-laptop: add edge modem support (also called WWAN)
Date: Sat, 28 Apr 2007 23:21:42 +0900
Message-ID: <20070428142142.GC5293@inferi.kami.home>
References: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:46567 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbXD1OXK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:23:10 -0400
Content-Disposition: inline; filename="0010-add-edge-modem-support.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Some SZ Vaios have a gsm built-in modem. Allow powering on/off this device.
Thanks to Joshua Wise for the base code.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-04-25 18:52:14.852442141 +0900
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-04-25 18:52:28.853240001 +0900
@@ -923,6 +923,7 @@ struct sony_pic_dev {
 	int			model;
 	u8			camera_power;
 	u8			bluetooth_power;
+	u8			wwan_power;
 	struct acpi_device	*acpi_dev;
 	struct sony_pic_irq	*cur_irq;
 	struct sony_pic_ioport	*cur_ioport;
@@ -1330,6 +1331,44 @@ static ssize_t sony_pic_camerapower_show
 	return count;
 }
 
+/* gprs/edge modem (SZ460N and SZ210P), thanks to Joshua Wise */
+static void sony_pic_set_wwanpower(u8 state)
+{
+	state = !!state;
+	mutex_lock(&spic_dev.lock);
+	if (spic_dev.wwan_power == state) {
+		mutex_unlock(&spic_dev.lock);
+		return;
+	}
+	sony_pic_call2(0xB0, state);
+	spic_dev.wwan_power = state;
+	mutex_unlock(&spic_dev.lock);
+}
+
+static ssize_t sony_pic_wwanpower_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buffer, size_t count)
+{
+	unsigned long value;
+	if (count > 31)
+		return -EINVAL;
+
+	value = simple_strtoul(buffer, NULL, 10);
+	sony_pic_set_wwanpower(value);
+
+	return count;
+}
+
+static ssize_t sony_pic_wwanpower_show(struct device *dev,
+		struct device_attribute *attr, char *buffer)
+{
+	ssize_t count;
+	mutex_lock(&spic_dev.lock);
+	count = snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.wwan_power);
+	mutex_unlock(&spic_dev.lock);
+	return count;
+}
+
 /* bluetooth subsystem power state */
 static void __sony_pic_set_bluetoothpower(u8 state)
 {
@@ -1412,11 +1451,13 @@ struct device_attribute spic_attr_##_nam
 
 static SPIC_ATTR(camerapower, 0644);
 static SPIC_ATTR(bluetoothpower, 0644);
+static SPIC_ATTR(wwanpower, 0644);
 static SPIC_ATTR(fanspeed, 0644);
 
 static struct attribute *spic_attributes[] = {
 	&spic_attr_camerapower.attr,
 	&spic_attr_bluetoothpower.attr,
+	&spic_attr_wwanpower.attr,
 	&spic_attr_fanspeed.attr,
 	NULL
 };

--
mattia
:wq!
