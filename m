From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [RFT PATCH 2/2] tc1100-wmi: Remove wireless sysfs entry
Date: Fri, 10 Oct 2008 19:00:09 +0100
Message-ID: <20081010180009.12879.14866.stgit@localhost>
References: <20081010175958.12879.26768.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:43411 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1759930AbYJJSAR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Oct 2008 14:00:17 -0400
In-Reply-To: <20081010175958.12879.26768.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

With the addition of the rfkill interface, this is no longer required.
Also, clean up the custom suspend/ resume handling for wireless while
we're at it.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/tc1100-wmi.c |   77 +++++++++++++--------------------------------
 1 files changed, 23 insertions(+), 54 deletions(-)


diff --git a/drivers/misc/tc1100-wmi.c b/drivers/misc/tc1100-wmi.c
index ed49269..492f591 100644
--- a/drivers/misc/tc1100-wmi.c
+++ b/drivers/misc/tc1100-wmi.c
@@ -69,7 +69,6 @@ static struct platform_driver tc1100_driver = {
 static struct platform_device *tc1100_device;
 
 struct tc1100_data {
-	u32 wireless;
 	u32 jogdial;
 };
 
@@ -226,37 +225,32 @@ static void tc1100_rfkill_exit(void)
 /*
  * Read/ write bool sysfs macro
  */
-#define show_set_bool(value, instance) \
-static ssize_t \
-show_bool_##value(struct device *dev, struct device_attribute *attr, \
-	char *buf) \
-{ \
-	u32 result; \
-	acpi_status status = get_state(&result, instance); \
-	if (ACPI_SUCCESS(status)) \
-		return sprintf(buf, "%d\n", result); \
-	return sprintf(buf, "Read error\n"); \
-} \
-\
-static ssize_t \
-set_bool_##value(struct device *dev, struct device_attribute *attr, \
-	const char *buf, size_t count) \
-{ \
-	u32 tmp = simple_strtoul(buf, NULL, 10); \
-	acpi_status status = set_state(&tmp, instance); \
-		if (ACPI_FAILURE(status)) \
-			return -EINVAL; \
-	return count; \
-} \
-static DEVICE_ATTR(value, S_IWUGO | S_IRUGO | S_IWUSR, \
-	show_bool_##value, set_bool_##value);
-
-show_set_bool(wireless, TC1100_INSTANCE_WIRELESS);
-show_set_bool(jogdial, TC1100_INSTANCE_JOGDIAL);
+static ssize_t
+show_bool_jogdial(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	u32 result;
+	acpi_status status = get_state(&result, TC1100_INSTANCE_JOGDIAL);
+	if (ACPI_SUCCESS(status))
+		return sprintf(buf, "%d\n", result);
+	return sprintf(buf, "Read error\n");
+}
+
+static ssize_t
+set_bool_jogdial(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	u32 tmp = simple_strtoul(buf, NULL, 10);
+	acpi_status status = set_state(&tmp, TC1100_INSTANCE_JOGDIAL);
+		if (ACPI_FAILURE(status))
+			return -EINVAL;
+	return count;
+}
+static DEVICE_ATTR(jogdial, S_IWUGO | S_IRUGO | S_IWUSR,
+	show_bool_jogdial, set_bool_jogdial);
 
 static void remove_fs(void)
 {
-	device_remove_file(&tc1100_device->dev, &dev_attr_wireless);
 	device_remove_file(&tc1100_device->dev, &dev_attr_jogdial);
 }
 
@@ -264,18 +258,7 @@ static int add_fs(void)
 {
 	int ret;
 
-	ret = device_create_file(&tc1100_device->dev, &dev_attr_wireless);
-	if (ret)
-		goto add_sysfs_error;
-
 	ret = device_create_file(&tc1100_device->dev, &dev_attr_jogdial);
-	if (ret)
-		goto add_sysfs_error;
-
-	return ret;
-
-add_sysfs_error:
-	remove_fs();
 	return ret;
 }
 
@@ -307,14 +290,7 @@ static int tc1100_suspend(struct platform_device *dev, pm_message_t state)
 {
 	int ret;
 
-	ret = get_state(&suspend_data.wireless, TC1100_INSTANCE_WIRELESS);
-	if (ret)
-		return ret;
-
 	ret = get_state(&suspend_data.jogdial, TC1100_INSTANCE_JOGDIAL);
-	if (ret)
-		return ret;
-
 	return ret;
 }
 
@@ -322,14 +298,7 @@ static int tc1100_resume(struct platform_device *dev)
 {
 	int ret;
 
-	ret = set_state(&suspend_data.wireless, TC1100_INSTANCE_WIRELESS);
-	if (ret)
-		return ret;
-
 	ret = set_state(&suspend_data.jogdial, TC1100_INSTANCE_JOGDIAL);
-	if (ret)
-		return ret;
-
 	return ret;
 }
 

