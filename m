From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [update][PATCH 4/4] ACPI / scan: Rework modalias creation when "compatible" is present
Date: Fri, 10 Apr 2015 14:34:44 +0200
Message-ID: <5371556.t424ylyKHo@vostro.rjw.lan>
References: <4378053.gHTT51U7FJ@vostro.rjw.lan> <1584233.lpv5odbKkI@vostro.rjw.lan> <20150410081224.GO1734@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64934 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754863AbbDJMKS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Apr 2015 08:10:18 -0400
In-Reply-To: <20150410081224.GO1734@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, April 10, 2015 11:12:24 AM Mika Westerberg wrote:
> On Thu, Apr 09, 2015 at 11:13:56PM +0200, Rafael J. Wysocki wrote:
> > @@ -236,61 +264,89 @@ static struct acpi_device *acpi_companio
> >  	return adev;
> >  }
> >  
> > -/*
> > - * Creates uevent modalias field for ACPI enumerated devices.
> > - * Because the other buses does not support ACPI HIDs & CIDs.
> > - * e.g. for a device with hid:IBM0001 and cid:ACPI0001 you get:
> > - * "acpi:IBM0001:ACPI0001"
> > - */
> > -int acpi_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
> > +int __acpi_device_uevent_modalias(struct acpi_device *adev,
> > +				  struct kobj_uevent_env *env)
> >  {
> >  	int len;
> >  
> > -	if (!acpi_companion_match(dev))
> > +	if (!adev)
> >  		return -ENODEV;
> >  
> >  	if (add_uevent_var(env, "MODALIAS="))
> >  		return -ENOMEM;
> > -	len = create_modalias(ACPI_COMPANION(dev), &env->buf[env->buflen - 1],
> > -				sizeof(env->buf) - env->buflen);
> > -	if (len <= 0)
> > +
> > +	len = create_pnp_modalias(adev, &env->buf[env->buflen - 1],
> > +				  sizeof(env->buf) - env->buflen);
> > +	if (len < 0) {
> > +		return len;
> > +	} else if (len > 0) {
> > +		env->buflen += len;
> > +
> > +		if (add_uevent_var(env, "MODALIAS="))
> > +			return -ENOMEM;
> 
> If the device does not have compatible property the below will result
> an empty MODALIAS= line in the uevent file:
> 
> 	# cat /sys/bus/i2c/devices/i2c-MSFT0002\:00/uevent
> 	MODALIAS=acpi:MSFT0002:PNP0C50:
> 	MODALIAS=
> 
> 	# cat /sys/bus/platform/devices/80860F0E\:00/uevent
> 	DRIVER=pxa2xx-spi
> 	MODALIAS=acpi:80860F0E:80860F0E:
> 	MODALIAS=

Ouch.

> > +	}
> > +	len = create_of_modalias(adev, &env->buf[env->buflen - 1],
> > +				 sizeof(env->buf) - env->buflen);
> > +	if (len < 0)
> >  		return len;
> > +
> >  	env->buflen += len;
> > +
> >  	return 0;
> >  }
> 
> Following patch got rid of those. Not sure if that's the best place.
> Perhaps we could move this to create_*_modalias() functions instead.

Well, we don't pass env to those and we don't need to in one case.

I've rearranged the code a bit and moved the checks around to avoid
doing the same ones for multiple times in the same code paths.  Below is
what I've got.

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 40b0a1b7f6f9..e0eb8161149c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -282,6 +282,9 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
>  	} else if (len > 0) {
>  		env->buflen += len;
>  
> +		if (!adev->data.of_compatible)
> +			return 0;
> +
>  		if (add_uevent_var(env, "MODALIAS="))
>  			return -ENOMEM;
>  	}

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / scan: Rework modalias creation when "compatible" is present

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
device has a non-empty list of ACPI/PNP IDs (other than PRP0001)
and a valid "compatible" property at the same time.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |  247 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 154 insertions(+), 93 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -114,7 +114,12 @@ int acpi_scan_add_handler_with_hotplug(s
 	return 0;
 }
 
-/*
+/**
+ * create_pnp_modalias - Create hid/cid(s) string for modalias and uevent
+ * @acpi_dev: ACPI device object.
+ * @modalias: Buffer to print into.
+ * @size: Size of the buffer.
+ *
  * Creates hid/cid(s) string needed for modalias and uevent
  * e.g. on a device with hid:IBM0001 and cid:ACPI0001 you get:
  * char *modalias: "acpi:IBM0001:ACPI0001"
@@ -122,68 +127,98 @@ int acpi_scan_add_handler_with_hotplug(s
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
 	struct acpi_hardware_id *id;
 
-	if (list_empty(&acpi_dev->pnp.ids))
-		return 0;
-
 	/*
-	 * If the device has PRP0001 we expose DT compatible modalias
-	 * instead in form of of:NnameTCcompatible.
+	 * Since we skip PRP0001 from the modalias below, 0 should be returned
+	 * if PRP0001 is the only ACPI/PNP ID in the device's list.
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
+	count = 0;
+	list_for_each_entry(id, &acpi_dev->pnp.ids, list)
+		if (strcmp(id->id, "PRP0001"))
+			count++;
 
-			len += count;
-			size -= count;
-		}
-	} else {
-		len = snprintf(modalias, size, "acpi:");
-		size -= len;
+	if (!count)
+		return 0;
 
-		list_for_each_entry(id, &acpi_dev->pnp.ids, list) {
-			count = snprintf(&modalias[len], size, "%s:", id->id);
-			if (count < 0)
-				return -EINVAL;
-			if (count >= size)
-				return -ENOMEM;
-			len += count;
-			size -= count;
-		}
+	len = snprintf(modalias, size, "acpi:");
+	if (len <= 0)
+		return len;
+
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
+/**
+ * create_of_modalias - Creates DT compatible string for modalias and uevent
+ * @acpi_dev: ACPI device object.
+ * @modalias: Buffer to print into.
+ * @size: Size of the buffer.
+ *
+ * Expose DT compatible modalias as of:NnameTCcompatible.  This function should
+ * only be called for devices having PRP0001 in their list of ACPI/PNP IDs.
+ */
+static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
+			      int size)
+{
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
+	const union acpi_object *of_compatible, *obj;
+	int len, count;
+	int i, nval;
+	char *c;
+
+	acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &buf);
+	/* DT strings are all in lower case */
+	for (c = buf.pointer; *c != '\0'; c++)
+		*c = tolower(*c);
+
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
@@ -236,61 +271,100 @@ static struct acpi_device *acpi_companio
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
 
+	if (list_empty(&adev->pnp.ids))
+		return 0;
+
 	if (add_uevent_var(env, "MODALIAS="))
 		return -ENOMEM;
-	len = create_modalias(ACPI_COMPANION(dev), &env->buf[env->buflen - 1],
-				sizeof(env->buf) - env->buflen);
-	if (len <= 0)
+
+	len = create_pnp_modalias(adev, &env->buf[env->buflen - 1],
+				  sizeof(env->buf) - env->buflen);
+	if (len < 0)
 		return len;
+
+	env->buflen += len;
+	if (!adev->data.of_compatible)
+		return 0;
+
+	if (len > 0 && add_uevent_var(env, "MODALIAS="))
+		return -ENOMEM;
+
+	len = create_of_modalias(adev, &env->buf[env->buflen - 1],
+				 sizeof(env->buf) - env->buflen);
+	if (len < 0)
+		return len;
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
+	if (list_empty(&adev->pnp.ids))
+		return 0;
+
+	len = create_pnp_modalias(adev, buf, size - 1);
+	if (len < 0) {
 		return len;
-	buf[len++] = '\n';
+	} else if (len > 0) {
+		buf[len++] = '\n';
+		size -= len;
+	}
+	if (!adev->data.of_compatible)
+		return len;
+
+	count = create_of_modalias(adev, buf + len, size - 1);
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
 
@@ -1050,20 +1124,7 @@ static int acpi_bus_match(struct device
 
 static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	int len;
-
-	if (list_empty(&acpi_dev->pnp.ids))
-		return 0;
-
-	if (add_uevent_var(env, "MODALIAS="))
-		return -ENOMEM;
-	len = create_modalias(acpi_dev, &env->buf[env->buflen - 1],
-			      sizeof(env->buf) - env->buflen);
-	if (len <= 0)
-		return len;
-	env->buflen += len;
-	return 0;
+	return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
 }
 
 static void acpi_device_notify(acpi_handle handle, u32 event, void *data)

