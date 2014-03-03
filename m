From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI: Adds sysfs "ddn" attribute of the ACPI device objects to export its _DDN object.
Date: Mon,  3 Mar 2014 15:19:36 +0800
Message-ID: <663e3209957959e78611238a9679af3a2af0a600.1393549042.git.lv.zheng@intel.com>
References: <53090AC1.6030507@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18400 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbaCCHUT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Mar 2014 02:20:19 -0500
In-Reply-To: <53090AC1.6030507@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>

The information contained in _DDN (Dos Device Name) might be useful
for userspace utilities, this patch thus exports such information
using "ddn" attribute.
Note that the "ddn" attribute will be created as long as the _DDN
identifying object exists, whatever its evaluation succeeds or not.

This patch must modify the code which is using "struct acpi_buffer"
as the buffer.length must be reset to ACPI_ALLOCATE_BUFFER before
reusing it to invoke acpi_evaluate_object() again.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi |    7 +++++
 drivers/acpi/scan.c                      |   47 +++++++++++++++++++++++++++++-
 include/acpi/acpi_bus.h                  |    1 +
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
index 7fa9cbc..db376b8 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -49,6 +49,13 @@ Description:
 		This attribute contains the output of the device object's
 		_UID control method, if present.
 
+What:		/sys/bus/acpi/devices/.../ddn
+Date:		February 2014
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		This attribute contains the output of the device object's
+		_DDN control method, if present.
+
 What:		/sys/bus/acpi/devices/.../eject
 Date:		December 2006
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4789c9b..5f039a6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -662,6 +662,18 @@ static ssize_t description_show(struct device *dev,
 }
 static DEVICE_ATTR(description, 0444, description_show, NULL);
 
+/* sysfs file that shows DOS device name text from the ACPI _DDN method */
+static ssize_t ddn_show(struct device *dev, struct device_attribute *attr,
+			char *buf) {
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	if (acpi_dev->pnp.ddn == NULL)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", acpi_dev->pnp.ddn);
+}
+static DEVICE_ATTR(ddn, 0444, ddn_show, NULL);
+
 static ssize_t
 acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
 		     char *buf) {
@@ -687,10 +699,11 @@ static DEVICE_ATTR_RO(status);
 
 static int acpi_device_setup_files(struct acpi_device *dev)
 {
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer buffer;
 	acpi_status status;
 	unsigned long long sun;
 	int result = 0;
+	union acpi_object *object;
 
 	/*
 	 * Devices gotten from FADT don't have a "path" attribute
@@ -715,6 +728,8 @@ static int acpi_device_setup_files(struct acpi_device *dev)
 	 * If device has _STR, 'description' file is created
 	 */
 	if (acpi_has_method(dev->handle, "_STR")) {
+		buffer.length = ACPI_ALLOCATE_BUFFER;
+		buffer.pointer = NULL;
 		status = acpi_evaluate_object(dev->handle, "_STR",
 					NULL, &buffer);
 		if (ACPI_FAILURE(status))
@@ -725,6 +740,29 @@ static int acpi_device_setup_files(struct acpi_device *dev)
 			goto end;
 	}
 
+	/*
+	 * If device has _DDN, 'ddn' file is created
+	 */
+	if (acpi_has_method(dev->handle, "_DDN")) {
+		buffer.length = ACPI_ALLOCATE_BUFFER;
+		buffer.pointer = NULL;
+		status = acpi_evaluate_object_typed(dev->handle, "_DDN",
+						    NULL, &buffer,
+						    ACPI_TYPE_STRING);
+		if (ACPI_FAILURE(status))
+			buffer.pointer = NULL;
+		object = buffer.pointer;
+		if (object) {
+			dev->pnp.ddn = kstrndup(object->string.pointer,
+						object->string.length,
+						GFP_KERNEL);
+			kfree(object);
+		}
+		result = device_create_file(&dev->dev, &dev_attr_ddn);
+		if (result)
+			goto end;
+	}
+
 	if (dev->pnp.type.bus_address)
 		result = device_create_file(&dev->dev, &dev_attr_adr);
 	if (dev->pnp.unique_id)
@@ -787,6 +825,13 @@ static void acpi_device_remove_files(struct acpi_device *dev)
 		device_remove_file(&dev->dev, &dev_attr_description);
 	}
 	/*
+	 * If device has _DDN, remove 'ddn' file
+	 */
+	if (acpi_has_method(dev->handle, "_DDN")) {
+		device_remove_file(&dev->dev, &dev_attr_ddn);
+		kfree(dev->pnp.ddn);
+	}
+	/*
 	 * If device has _EJ0, remove 'eject' file.
 	 */
 	if (acpi_has_method(dev->handle, "_EJ0"))
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 9d82482..92cab35 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -244,6 +244,7 @@ struct acpi_device_pnp {
 	acpi_device_name device_name;	/* Driver-determined */
 	acpi_device_class device_class;	/*        "          */
 	union acpi_object *str_obj;	/* unicode string for _STR method */
+	char *ddn;			/* _DDN */
 	unsigned long sun;		/* _SUN */
 };
 
-- 
1.7.10

