From: malattia@linux.it
Subject: [patch 9/9 v2] sony-laptop: remove user visible camera controls as platform attributes
Date: Sat, 28 Apr 2007 23:36:40 +0900
Message-ID: <20070428143640.GI5293@inferi.kami.home>
References: <20070428141557.GA4764@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi11.ns.itscom.net ([219.110.2.181]:58732 "EHLO
	mtoichi11.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965839AbXD1OiE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Apr 2007 10:38:04 -0400
Content-Disposition: inline; filename="0016-remove-camera-platform-attributes.patch"
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Avoid giving the user the possibility to shoot his own foot and let
the meye driver enable/disable the camera wisely (PCI_ID based).

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-04-25 22:35:50.616962991 +0900
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-04-25 22:36:37.119613026 +0900
@@ -1317,40 +1317,6 @@ static int __sony_pic_camera_on(void)
 	return 0;
 }
 
-static ssize_t sony_pic_camerapower_store(struct device *dev,
-		struct device_attribute *attr,
-		const char *buffer, size_t count)
-{
-	unsigned long value;
-	int result;
-	if (count > 31)
-		return -EINVAL;
-
-	value = simple_strtoul(buffer, NULL, 10);
-
-	mutex_lock(&spic_dev.lock);
-	if (value)
-		result = __sony_pic_camera_on();
-	else
-		result = __sony_pic_camera_off();
-	mutex_unlock(&spic_dev.lock);
-
-	if (result)
-		return result;
-
-	return count;
-}
-
-static ssize_t sony_pic_camerapower_show(struct device *dev,
-		struct device_attribute *attr, char *buffer)
-{
-	ssize_t count;
-	mutex_lock(&spic_dev.lock);
-	count = snprintf(buffer, PAGE_SIZE, "%d\n", spic_dev.camera_power);
-	mutex_unlock(&spic_dev.lock);
-	return count;
-}
-
 /* External camera command (exported to the motion eye v4l driver) */
 int sony_pic_camera_command(int command, u8 value)
 {
@@ -1522,13 +1488,11 @@ struct device_attribute spic_attr_##_nam
 		_mode, sony_pic_## _name ##_show,		\
 		sony_pic_## _name ##_store)
 
-static SPIC_ATTR(camerapower, 0644);
 static SPIC_ATTR(bluetoothpower, 0644);
 static SPIC_ATTR(wwanpower, 0644);
 static SPIC_ATTR(fanspeed, 0644);
 
 static struct attribute *spic_attributes[] = {
-	&spic_attr_camerapower.attr,
 	&spic_attr_bluetoothpower.attr,
 	&spic_attr_wwanpower.attr,
 	&spic_attr_fanspeed.attr,

-- 
mattia
:wq!
