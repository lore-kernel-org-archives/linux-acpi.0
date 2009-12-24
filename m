From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/34] tc1100-wmi - switch to using attribute group
Date: Thu, 24 Dec 2009 01:23:32 -0500
Message-ID: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:29691 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbZLXGYO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 01:24:14 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KV500D2R8G84UP2@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 00:24:11 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Sysfs attribute group takes care of proper creation of a set of attributes
and implements proper error unwinding so the driver does not have to do it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/tc1100-wmi.c |   39 ++++++++++--------------------------
 1 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/tc1100-wmi.c b/drivers/platform/x86/tc1100-wmi.c
index 4416600..0d53d51 100644
--- a/drivers/platform/x86/tc1100-wmi.c
+++ b/drivers/platform/x86/tc1100-wmi.c
@@ -183,30 +183,15 @@ static DEVICE_ATTR(value, S_IWUGO | S_IRUGO | S_IWUSR, \
 show_set_bool(wireless, TC1100_INSTANCE_WIRELESS);
 show_set_bool(jogdial, TC1100_INSTANCE_JOGDIAL);
 
-static void remove_fs(void)
-{
-	device_remove_file(&tc1100_device->dev, &dev_attr_wireless);
-	device_remove_file(&tc1100_device->dev, &dev_attr_jogdial);
-}
-
-static int add_fs(void)
-{
-	int ret;
-
-	ret = device_create_file(&tc1100_device->dev, &dev_attr_wireless);
-	if (ret)
-		goto add_sysfs_error;
-
-	ret = device_create_file(&tc1100_device->dev, &dev_attr_jogdial);
-	if (ret)
-		goto add_sysfs_error;
-
-	return ret;
+static struct attribute *tc1100_attributes[] = {
+	&dev_attr_wireless.attr,
+	&dev_attr_jogdial.attr,
+	NULL
+};
 
-add_sysfs_error:
-	remove_fs();
-	return ret;
-}
+static struct attribute_group tc1100_attribute_group = {
+	.attrs	= tc1100_attributes,
+};
 
 /* --------------------------------------------------------------------------
 				Driver Model
@@ -214,16 +199,14 @@ add_sysfs_error:
 
 static int tc1100_probe(struct platform_device *device)
 {
-	int result = 0;
-
-	result = add_fs();
-	return result;
+	return sysfs_create_group(&device->dev.kobj, &tc1100_attribute_group);
 }
 
 
 static int tc1100_remove(struct platform_device *device)
 {
-	remove_fs();
+	sysfs_remove_group(&device->dev.kobj, &tc1100_attribute_group);
+
 	return 0;
 }
 
-- 
1.6.0.6

