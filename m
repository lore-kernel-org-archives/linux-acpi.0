From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 3/3][RFC] ACPI: WMI: Add locking to sysfs files for methods and data
Date: Sat, 10 Nov 2007 15:35:34 +0000
Message-ID: <200711101535.35552.carlos@strangeworlds.co.uk>
References: <200711101532.07531.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:43891 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbXKJPf6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Nov 2007 10:35:58 -0500
In-Reply-To: <200711101532.07531.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Nashif, Anas" <anas.nashif@intel.com>

From: Carlos Corbacho <cathectic@gmail.com>

To ensure that we don't start overwriting the method_id or input data
when executing methods, or handling data GUID's, add a mutex lock
around data read/ write and method_id write sysfs functions.

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
 drivers/acpi/wmi.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 59c3d76..e210973 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/sysfs.h>
+#include <linux/mutex.h>
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_WMI_CLASS "wmi"
@@ -50,6 +51,8 @@
 #undef PREFIX
 #define PREFIX "ACPI: WMI: "
 
+static DEFINE_MUTEX(wmi_data_lock);
+
 struct guid_block
 {
 	char guid[16];
@@ -577,6 +580,8 @@ static ssize_t wmi_data_read(struct kobject *kobj, struct bin_attribute
 
 	guid = kobject_name(kobj->parent);
 
+	mutex_lock(&wmi_data_lock);
+
 	for (i = 0; i < guids.total; i++) {
 		gkobj = &wmi_guid_kobj[i];
 		if (memcmp(kobject_name(&gkobj->guid_kobj), guid, 36) == 0) {
@@ -605,6 +610,8 @@ static ssize_t wmi_data_read(struct kobject *kobj, struct bin_attribute
 	obj = (union acpi_object *) out.pointer;
 	buf = obj->buffer.pointer;
 
+	mutex_unlock(&wmi_data_lock);
+
 	return 0;
 }
 
@@ -612,6 +619,8 @@ static ssize_t wmi_data_write(struct kobject *kobj, struct bin_attribute
 			*bin_attr, char *buf, loff_t offset, size_t count){
 	int i;
 
+	mutex_lock(&wmi_data_lock);
+
 	for (i = 0; i < guids.total; i++) {
 		if (memcmp(kobject_name(&wmi_guid_kobj[i].guid_kobj),
 				kobject_name(kobj->parent), 36) == 0) {
@@ -619,9 +628,11 @@ static ssize_t wmi_data_write(struct kobject *kobj, struct bin_attribute
 			wmi_guid_kobj[i].data = kzalloc(count, GFP_KERNEL);
 			memcpy(wmi_guid_kobj[i].data, buf, count);
 			wmi_guid_kobj[i].data_size = count;
+			mutex_unlock(&wmi_data_lock);
 			return count;
 		}
 	}
+	mutex_unlock(&wmi_data_lock);
 	return -EINVAL;
 }
 
@@ -698,13 +709,19 @@ static ssize_t set_guid_method_id(struct kobject *kobj, const char *buf,
 
 	method_id = simple_strtoul(buf, NULL, 10);
 
+	mutex_lock(&wmi_data_lock);
+
 	for (i = 0; i < guids.total; i++) {
 		if (memcmp(kobject_name(&wmi_guid_kobj[i].guid_kobj),
 			kobject_name(kobj->parent), 36) == 0) {
 			wmi_guid_kobj[i].method_id = method_id;
+			mutex_unlock(&wmi_data_lock);
 			return count;
 		}
 	}
+
+	mutex_unlock(&wmi_data_lock);
+
 	return -EINVAL;
 }
 static WMI_ATTR(method_id, S_IWUGO | S_IRUGO, show_guid_method_id,
-- 
1.5.3.4

