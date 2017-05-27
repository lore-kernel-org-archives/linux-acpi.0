From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 14/16] platform/x86: wmi: Require query for data blocks, rename writable to setable
Date: Fri, 26 May 2017 22:31:28 -0700
Message-ID: <f0af98813a0e37b26b42733f3e871b9435bacfe7.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Darren Hart (VMware)" <dvhart@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: "Darren Hart (VMware)" <dvhart@infradead.org>

The Microsoft WMI documentation requires all data blocks to implement
the Query Control Method (WQxx). If we encounter a data block not
implementing this control method, issue a warning, and ignore the data
block. Remove the "readable" attribute as all data blocks must be
readable (query-able).

Be consistent with the language in the documentation, replace the
"writable" attribute with "setable".

Simplify (flatten) the control flow of wmi_create_device a bit while
we are updating it for the above changes.

Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
---
 drivers/platform/x86/wmi.c | 117 +++++++++++++++++++++++----------------------
 include/linux/wmi.h        |   7 +--
 2 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 8dd9988..cc55952 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -69,7 +69,7 @@ struct wmi_block {
 	wmi_notify_handler handler;
 	void *handler_data;
 
-	bool read_takes_no_args;	/* only defined if readable */
+	bool read_takes_no_args;
 };
 
 
@@ -694,28 +694,18 @@ static ssize_t object_id_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(object_id);
 
-static ssize_t readable_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t setable_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct wmi_device *wdev = dev_to_wdev(dev);
 
-	return sprintf(buf, "%d\n", (int)wdev->readable);
+	return sprintf(buf, "%d\n", (int)wdev->setable);
 }
-static DEVICE_ATTR_RO(readable);
-
-static ssize_t writeable_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
-{
-	struct wmi_device *wdev = dev_to_wdev(dev);
-
-	return sprintf(buf, "%d\n", (int)wdev->writeable);
-}
-static DEVICE_ATTR_RO(writeable);
+static DEVICE_ATTR_RO(setable);
 
 static struct attribute *wmi_data_attrs[] = {
 	&dev_attr_object_id.attr,
-	&dev_attr_readable.attr,
-	&dev_attr_writeable.attr,
+	&dev_attr_setable.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(wmi_data);
@@ -833,63 +823,74 @@ static struct device_type wmi_type_data = {
 	.release = wmi_dev_release,
 };
 
-static void wmi_create_device(struct device *wmi_bus_dev,
+static int wmi_create_device(struct device *wmi_bus_dev,
 			     const struct guid_block *gblock,
 			     struct wmi_block *wblock,
 			     struct acpi_device *device)
 {
-	wblock->dev.dev.bus = &wmi_bus_type;
-	wblock->dev.dev.parent = wmi_bus_dev;
-
-	dev_set_name(&wblock->dev.dev, "%pUL", gblock->guid);
+	struct acpi_device_info *info;
+	char method[5];
+	int result;
 
 	if (gblock->flags & ACPI_WMI_EVENT) {
 		wblock->dev.dev.type = &wmi_type_event;
-	} else if (gblock->flags & ACPI_WMI_METHOD) {
+		goto out_init;
+	}
+
+	if (gblock->flags & ACPI_WMI_METHOD) {
 		wblock->dev.dev.type = &wmi_type_method;
-	} else {
-		struct acpi_device_info *info;
-		char method[5];
-		int result;
+		goto out_init;
+	}
 
-		wblock->dev.dev.type = &wmi_type_data;
+	/*
+	 * Data Block Query Control Method (WQxx by convention) is
+	 * required per the WMI documentation. If it is not present,
+	 * we ignore this data block.
+	 */
+	strcpy(method, "WQ");
+	strncat(method, wblock->gblock.object_id, 2);
+	result = get_subobj_info(device->handle, method, &info);
+
+	if (result) {
+		dev_warn(wmi_bus_dev,
+			 "%s data block query control method not found",
+			 method);
+		return result;
+	}
 
-		strcpy(method, "WQ");
-		strncat(method, wblock->gblock.object_id, 2);
-		result = get_subobj_info(device->handle, method, &info);
+	wblock->dev.dev.type = &wmi_type_data;
 
-		if (result == 0) {
-			wblock->dev.readable = true;
+	/*
+	 * The Microsoft documentation specifically states:
+	 *
+	 *   Data blocks registered with only a single instance
+	 *   can ignore the parameter.
+	 *
+	 * ACPICA will get mad at us if we call the method with the wrong number
+	 * of arguments, so check what our method expects.  (On some Dell
+	 * laptops, WQxx may not be a method at all.)
+	 */
+	if (info->type != ACPI_TYPE_METHOD || info->param_count == 0)
+		wblock->read_takes_no_args = true;
 
-			/*
-			 * The Microsoft documentation specifically states:
-			 *
-			 *   Data blocks registered with only a single instance
-			 *   can ignore the parameter.
-			 *
-			 * ACPICA will get mad at us if we call the method
-			 * with the wrong number of arguments, so check what
-			 * our method expects.  (On some Dell laptops, WQxx
-			 * may not be a method at all.)
-			 */
-			if (info->type != ACPI_TYPE_METHOD ||
-			    info->param_count == 0)
-				wblock->read_takes_no_args = true;
+	kfree(info);
 
-			kfree(info);
-		}
+	strcpy(method, "WS");
+	strncat(method, wblock->gblock.object_id, 2);
+	result = get_subobj_info(device->handle, method, NULL);
 
-		strcpy(method, "WS");
-		strncat(method, wblock->gblock.object_id, 2);
-		result = get_subobj_info(device->handle, method, NULL);
+	if (result == 0)
+		wblock->dev.setable = true;
 
-		if (result == 0) {
-			wblock->dev.writeable = true;
-		}
+ out_init:
+	wblock->dev.dev.bus = &wmi_bus_type;
+	wblock->dev.dev.parent = wmi_bus_dev;
 
-	}
+	dev_set_name(&wblock->dev.dev, "%pUL", gblock->guid);
 
 	device_initialize(&wblock->dev.dev);
+
+	return 0;
 }
 
 static void wmi_free_devices(struct acpi_device *device)
@@ -985,7 +986,11 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		wblock->acpi_device = device;
 		wblock->gblock = gblock[i];
 
-		wmi_create_device(wmi_bus_dev, &gblock[i], wblock, device);
+		retval = wmi_create_device(wmi_bus_dev, &gblock[i], wblock, device);
+		if (retval) {
+			kfree(wblock);
+			continue;
+		}
 
 		list_add_tail(&wblock->list, &wmi_block_list);
 
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index a283768..cd0d773 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -22,11 +22,8 @@
 struct wmi_device {
 	struct device dev;
 
-	/*
-	 * These are true for data objects that support reads and writes,
-	 * respectively.
-	 */
-	bool readable, writeable;
+	 /* True for data blocks implementing the Set Control Method */
+	bool setable;
 };
 
 /* Caller must kfree the result. */
-- 
2.9.4
