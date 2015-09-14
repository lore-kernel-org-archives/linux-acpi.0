From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] device property: Add fwnode_property_match_string()
Date: Mon, 14 Sep 2015 17:37:35 +0300
Message-ID: <1442241456-75340-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17884 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbbINOhk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Sep 2015 10:37:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Sometimes it is useful to be able to extract an index of certain string
value from an array of strings. A typical use case is to give a name to a
DMA channel, PWM, clock and so on.

Provide an implementation using unified device property accessors that
follows of_property_match_string() but works for all supported fwnodes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/base/property.c  | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  4 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2d75366c61e0..a128db413f01 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -287,6 +287,28 @@ int device_property_read_string(struct device *dev, const char *propname,
 }
 EXPORT_SYMBOL_GPL(device_property_read_string);
 
+/**
+ * device_property_match_string - find a string in an array and return index
+ * @dev: Device to get the property of
+ * @propname: Name of the property holding the array
+ * @string: String to look for
+ *
+ * Find a given string in a string array and if it is found return the
+ * index back.
+ *
+ * Return: %0 if the property was found (success),
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the property does not have a value,
+ *	   %-EPROTO if the property is not an array of strings,
+ *	   %-ENXIO if no suitable firmware interface is present.
+ */
+int device_property_match_string(struct device *dev, const char *propname,
+				 const char *string)
+{
+	return fwnode_property_match_string(dev_fwnode(dev), propname, string);
+}
+EXPORT_SYMBOL_GPL(device_property_match_string);
+
 #define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval) \
 	(val) ? of_property_read_##type##_array((node), (propname), (val), (nval)) \
 	      : of_property_count_elems_of_size((node), (propname), sizeof(type))
@@ -479,6 +501,52 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
 
 /**
+ * fwnode_property_match_string - find a string in an array and return index
+ * @fwnode: Firmware node to get the property of
+ * @propname: Name of the property holding the array
+ * @string: String to look for
+ *
+ * Find a given string in a string array and if it is found return the
+ * index back.
+ *
+ * Return: %0 if the property was found (success),
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the property does not have a value,
+ *	   %-EPROTO if the property is not an array of strings,
+ *	   %-ENXIO if no suitable firmware interface is present.
+ */
+int fwnode_property_match_string(struct fwnode_handle *fwnode,
+	const char *propname, const char *string)
+{
+	const char **values;
+	int nval, ret, i;
+
+	nval = fwnode_property_read_string_array(fwnode, propname, NULL, 0);
+	if (nval < 0)
+		return nval;
+
+	values = kcalloc(nval, sizeof(*values), GFP_KERNEL);
+	if (!values)
+		return -ENOMEM;
+
+	ret = fwnode_property_read_string_array(fwnode, propname, values, nval);
+	if (ret < 0)
+		goto out;
+
+	ret = -ENODATA;
+	for (i = 0; i < nval; i++) {
+		if (!strcmp(values[i], string)) {
+			ret = i;
+			break;
+		}
+	}
+out:
+	kfree(values);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fwnode_property_match_string);
+
+/**
  * device_get_next_child_node - Return the next child node handle for a device
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
diff --git a/include/linux/property.h b/include/linux/property.h
index a59c6ee566c2..463de52fe891 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -40,6 +40,8 @@ int device_property_read_string_array(struct device *dev, const char *propname,
 				      const char **val, size_t nval);
 int device_property_read_string(struct device *dev, const char *propname,
 				const char **val);
+int device_property_match_string(struct device *dev,
+				 const char *propname, const char *string);
 
 bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname);
 int fwnode_property_read_u8_array(struct fwnode_handle *fwnode,
@@ -59,6 +61,8 @@ int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 				      size_t nval);
 int fwnode_property_read_string(struct fwnode_handle *fwnode,
 				const char *propname, const char **val);
+int fwnode_property_match_string(struct fwnode_handle *fwnode,
+				 const char *propname, const char *string);
 
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
-- 
2.5.1

