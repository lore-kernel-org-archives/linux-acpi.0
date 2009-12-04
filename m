From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] tc1100-wmi - switch to using attribute group
Date: Fri, 04 Dec 2009 00:36:09 -0800
Message-ID: <20091204083609.22509.73601.stgit@localhost.localdomain>
References: <20091204083422.22509.74768.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:39430 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbZLDIgG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 03:36:06 -0500
Received: by ywh12 with SMTP id 12so2356843ywh.21
        for <linux-acpi@vger.kernel.org>; Fri, 04 Dec 2009 00:36:12 -0800 (PST)
In-Reply-To: <20091204083422.22509.74768.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

Sysfs attribute group takes care of proper creation of a set of attributes
and implements proper error unwinding so the driver does not have to do it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/tc1100-wmi.c |   39 ++++++++++---------------------------
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
 

