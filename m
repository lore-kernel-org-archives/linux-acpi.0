From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/4] ACPI / scan: Rework modalias creation when "compatible" is present
Date: Thu, 09 Apr 2015 02:22:10 +0200
Message-ID: <1630931.9AX0JeoSOf@vostro.rjw.lan>
References: <4378053.gHTT51U7FJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4378053.gHTT51U7FJ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, the ACPI modalias creation covers two mutually exclusive
cases: If the PRP0001 device ID is present in the device's list of
ACPI/PNP IDs and the "compatible" property is present in _DSD, the
created modalias will follow the OF rules of modalias creation.
Otherwise, ACPI rules are used.

However, that is not really desirable, because the presence of PRP0001
in the list of device IDs generally does not preclude using other
ACPI/PNP IDs with that device and those other IDs may be of higher
priority.  In those cases, the other IDs should take preference over
PRP0001 and therefore they also should be present in the modalias.

For this reason, rework the modalias creation for ACPI so that it
shows both the ACPI-style and OF-style modalias strings if the
device has a non-empty list of ACPI/PNP IDs (other than PNP0001)
and a valid "compatible" property at the same time.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |  204 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 120 insertions(+), 84 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -122,8 +122,8 @@ int acpi_scan_add_handler_with_hotplug(s
  *         -EINVAL: output error
  *         -ENOMEM: output is truncated
 */
-static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
-			   int size)
+static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
+			       int size)
 {
 	int len;
 	int count;
@@ -132,58 +132,74 @@ static int create_modalias(struct acpi_d
 	if (list_empty(&acpi_dev->pnp.ids))
 		return 0;
 
+	len = snprintf(modalias, size, "acpi:");
+	size -= len;
+
+	list_for_each_entry(id, &acpi_dev->pnp.ids, list) {
+		if (!strcmp(id->id, "PRP0001"))
+			continue;
+
+		count = snprintf(&modalias[len], size, "%s:", id->id);
+		if (count < 0)
+			return -EINVAL;
+
+		if (count >= size)
+			return -ENOMEM;
+
+		len += count;
+		size -= count;
+	}
+	modalias[len] = '\0';
+	return len;
+}
+
+static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
+			      int size)
+{
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
+	const union acpi_object *of_compatible, *obj;
+	int len, count;
+	int i, nval;
+	char *c;
+
 	/*
-	 * If the device has PRP0001 we expose DT compatible modalias
-	 * instead in form of of:NnameTCcompatible.
+	 * If the device has PRP0001 we expose DT compatible modalias as
+	 * of:NnameTCcompatible.
 	 */
-	if (acpi_dev->data.of_compatible) {
-		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
-		const union acpi_object *of_compatible, *obj;
-		int i, nval;
-		char *c;
-
-		acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &buf);
-		/* DT strings are all in lower case */
-		for (c = buf.pointer; *c != '\0'; c++)
-			*c = tolower(*c);
-
-		len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
-		ACPI_FREE(buf.pointer);
-
-		of_compatible = acpi_dev->data.of_compatible;
-		if (of_compatible->type == ACPI_TYPE_PACKAGE) {
-			nval = of_compatible->package.count;
-			obj = of_compatible->package.elements;
-		} else { /* Must be ACPI_TYPE_STRING. */
-			nval = 1;
-			obj = of_compatible;
-		}
-		for (i = 0; i < nval; i++, obj++) {
-			count = snprintf(&modalias[len], size, "C%s",
-					 obj->string.pointer);
-			if (count < 0)
-				return -EINVAL;
-			if (count >= size)
-				return -ENOMEM;
+	if (!acpi_dev->data.of_compatible)
+		return 0;
 
-			len += count;
-			size -= count;
-		}
-	} else {
-		len = snprintf(modalias, size, "acpi:");
-		size -= len;
+	acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &buf);
+	/* DT strings are all in lower case */
+	for (c = buf.pointer; *c != '\0'; c++)
+		*c = tolower(*c);
 
-		list_for_each_entry(id, &acpi_dev->pnp.ids, list) {
-			count = snprintf(&modalias[len], size, "%s:", id->id);
-			if (count < 0)
-				return -EINVAL;
-			if (count >= size)
-				return -ENOMEM;
-			len += count;
-			size -= count;
-		}
+	len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
+	ACPI_FREE(buf.pointer);
+
+	if (len <= 0)
+		return len;
+
+	of_compatible = acpi_dev->data.of_compatible;
+	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
+		nval = of_compatible->package.count;
+		obj = of_compatible->package.elements;
+	} else { /* Must be ACPI_TYPE_STRING. */
+		nval = 1;
+		obj = of_compatible;
 	}
+	for (i = 0; i < nval; i++, obj++) {
+		count = snprintf(&modalias[len], size, "C%s",
+				 obj->string.pointer);
+		if (count < 0)
+			return -EINVAL;
+
+		if (count >= size)
+			return -ENOMEM;
 
+		len += count;
+		size -= count;
+	}
 	modalias[len] = '\0';
 	return len;
 }
@@ -236,61 +252,89 @@ static struct acpi_device *acpi_companio
 	return adev;
 }
 
-/*
- * Creates uevent modalias field for ACPI enumerated devices.
- * Because the other buses does not support ACPI HIDs & CIDs.
- * e.g. for a device with hid:IBM0001 and cid:ACPI0001 you get:
- * "acpi:IBM0001:ACPI0001"
- */
-int acpi_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
+int __acpi_device_uevent_modalias(struct acpi_device *adev,
+				  struct kobj_uevent_env *env)
 {
 	int len;
 
-	if (!acpi_companion_match(dev))
+	if (!adev)
 		return -ENODEV;
 
 	if (add_uevent_var(env, "MODALIAS="))
 		return -ENOMEM;
-	len = create_modalias(ACPI_COMPANION(dev), &env->buf[env->buflen - 1],
-				sizeof(env->buf) - env->buflen);
-	if (len <= 0)
+
+	len = create_pnp_modalias(adev, &env->buf[env->buflen - 1],
+				  sizeof(env->buf) - env->buflen);
+	if (len < 0)
+		return len;
+
+	env->buflen += len;
+
+	if (add_uevent_var(env, "MODALIAS="))
+		return -ENOMEM;
+
+	len = create_of_modalias(adev, &env->buf[env->buflen - 1],
+				 sizeof(env->buf) - env->buflen);
+	if (len < 0)
 		return len;
+
 	env->buflen += len;
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(acpi_device_uevent_modalias);
 
 /*
- * Creates modalias sysfs attribute for ACPI enumerated devices.
+ * Creates uevent modalias field for ACPI enumerated devices.
  * Because the other buses does not support ACPI HIDs & CIDs.
  * e.g. for a device with hid:IBM0001 and cid:ACPI0001 you get:
  * "acpi:IBM0001:ACPI0001"
  */
-int acpi_device_modalias(struct device *dev, char *buf, int size)
+int acpi_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 {
-	int len;
+	return __acpi_device_uevent_modalias(acpi_companion_match(dev), env);
+}
+EXPORT_SYMBOL_GPL(acpi_device_uevent_modalias);
+
+static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
+{
+	int len, count;
 
-	if (!acpi_companion_match(dev))
+	if (!adev)
 		return -ENODEV;
 
-	len = create_modalias(ACPI_COMPANION(dev), buf, size -1);
-	if (len <= 0)
+	len = create_pnp_modalias(adev, buf, size - 1);
+	if (len < 0) {
 		return len;
-	buf[len++] = '\n';
+	} else if (len > 0) {
+		buf[len++] = '\n';
+		size -= len;
+	}
+	count = create_of_modalias(adev, buf, size - 1);
+	if (count < 0) {
+		return count;
+	} else if (count > 0) {
+		len += count;
+		buf[len++] = '\n';
+	}
+
 	return len;
 }
+
+/*
+ * Creates modalias sysfs attribute for ACPI enumerated devices.
+ * Because the other buses does not support ACPI HIDs & CIDs.
+ * e.g. for a device with hid:IBM0001 and cid:ACPI0001 you get:
+ * "acpi:IBM0001:ACPI0001"
+ */
+int acpi_device_modalias(struct device *dev, char *buf, int size)
+{
+	return __acpi_device_modalias(acpi_companion_match(dev), buf, size);
+}
 EXPORT_SYMBOL_GPL(acpi_device_modalias);
 
 static ssize_t
 acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, char *buf) {
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	int len;
-
-	len = create_modalias(acpi_dev, buf, 1024);
-	if (len <= 0)
-		return len;
-	buf[len++] = '\n';
-	return len;
+	return __acpi_device_modalias(to_acpi_device(dev), buf, 1024);
 }
 static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
 
@@ -1051,19 +1095,11 @@ static int acpi_bus_match(struct device
 static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	int len;
 
 	if (list_empty(&acpi_dev->pnp.ids))
 		return 0;
 
-	if (add_uevent_var(env, "MODALIAS="))
-		return -ENOMEM;
-	len = create_modalias(acpi_dev, &env->buf[env->buflen - 1],
-			      sizeof(env->buf) - env->buflen);
-	if (len <= 0)
-		return len;
-	env->buflen += len;
-	return 0;
+	return __acpi_device_uevent_modalias(acpi_dev, env);
 }
 
 static void acpi_device_notify(acpi_handle handle, u32 event, void *data)
