From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 3/3] device property: fwnode_property_read_string_array() returns nr of strings
Date: Tue, 28 Mar 2017 15:22:19 +0300
Message-ID: <1490703739-28270-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1490703739-28270-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490703739-28270-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Functionally fwnode_property_read_string_array() should match
of_property_read_string_array() and work as a drop-in substitute for the
latter. of_property_read_string_array() returns the number of strings read
if the target string pointer array is non-NULL. Make
fwnode_property_read_string_array() do the same.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c | 22 +++++++++++++++++-----
 drivers/base/property.c | 12 ++++++------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 3afddcd..06f8fda 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -699,6 +699,8 @@ static int acpi_data_prop_read_single(struct acpi_device_data *data,
 			return ret;
 
 		*(char **)val = obj->string.pointer;
+
+		return 1;
 	} else {
 		ret = -EINVAL;
 	}
@@ -708,7 +710,15 @@ static int acpi_data_prop_read_single(struct acpi_device_data *data,
 int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
 			      enum dev_prop_type proptype, void *val)
 {
-	return adev ? acpi_data_prop_read_single(&adev->data, propname, proptype, val) : -EINVAL;
+	int ret;
+
+	if (!adev)
+		return -EINVAL;
+
+	ret = acpi_data_prop_read_single(&adev->data, propname, proptype, val);
+	if (ret < 0 || proptype != ACPI_TYPE_STRING)
+		return ret;
+	return 0;
 }
 
 static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
@@ -784,7 +794,7 @@ static int acpi_copy_property_array_string(const union acpi_object *items,
 
 		val[i] = items[i].string.pointer;
 	}
-	return 0;
+	return nval;
 }
 
 static int acpi_data_prop_read(struct acpi_device_data *data,
@@ -798,7 +808,7 @@ static int acpi_data_prop_read(struct acpi_device_data *data,
 
 	if (val && nval == 1) {
 		ret = acpi_data_prop_read_single(data, propname, proptype, val);
-		if (!ret)
+		if (ret >= 0)
 			return ret;
 	}
 
@@ -809,7 +819,7 @@ static int acpi_data_prop_read(struct acpi_device_data *data,
 	if (!val)
 		return obj->package.count;
 
-	if (nval > obj->package.count)
+	if (proptype != DEV_PROP_STRING && nval > obj->package.count)
 		return -EOVERFLOW;
 	else if (nval <= 0)
 		return -EINVAL;
@@ -830,7 +840,9 @@ static int acpi_data_prop_read(struct acpi_device_data *data,
 		ret = acpi_copy_property_array_u64(items, (u64 *)val, nval);
 		break;
 	case DEV_PROP_STRING:
-		ret = acpi_copy_property_array_string(items, (char **)val, nval);
+		ret = acpi_copy_property_array_string(
+			items, (char **)val,
+			min_t(u32, nval, obj->package.count));
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 686e985..b517485 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -176,7 +176,7 @@ static int pset_prop_read_string_array(struct property_set *pset,
 
 	memcpy(strings, pointer, length);
 
-	return 0;
+	return array_len;
 }
 
 static int pset_prop_read_string(struct property_set *pset,
@@ -362,8 +362,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
  * Function reads an array of string properties with @propname from the device
  * firmware description and stores them to @val if found.
  *
- * Return: number of values if @val was %NULL,
- *         %0 if the property was found (success),
+ * Return: number of values read on success if @val is non-NULL,
+ *	   number of values available on success if @val is NULL,
  *	   %-EINVAL if given arguments are not valid,
  *	   %-ENODATA if the property does not have a value,
  *	   %-EPROTO or %-EILSEQ if the property is not an array of strings,
@@ -603,8 +603,8 @@ static int __fwnode_property_read_string(struct fwnode_handle *fwnode,
  * Read an string list property @propname from the given firmware node and store
  * them to @val if found.
  *
- * Return: number of values if @val was %NULL,
- *         %0 if the property was found (success),
+ * Return: number of values read on success if @val is non-NULL,
+ *	   number of values available on success if @val is NULL,
  *	   %-EINVAL if given arguments are not valid,
  *	   %-ENODATA if the property does not have a value,
  *	   %-EPROTO or %-EILSEQ if the property is not an array of strings,
@@ -651,7 +651,7 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 	    !IS_ERR_OR_NULL(fwnode->secondary))
 		ret = __fwnode_property_read_string(fwnode->secondary,
 						    propname, val);
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
