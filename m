From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/1] device property: Read strings using string array reading functions
Date: Tue, 28 Mar 2017 15:26:22 +0300
Message-ID: <1490703982-28334-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Always read strings using of_property_read_string_array() instead of
of_property_read_string(). This allows using a single operation struct
callback for accessing strings.

Same for pset_prop_read_string_array() and pset_prop_read_string().

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Depends-on: ("device property: Make dev_fwnode() public")
Depends-on: ("device property: fwnode_property_read_string_array() returns nr of strings")
Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
since v1:

- Rebase on most recent version of "device property:
  fwnode_property_read_string_array() returns nr of strings"; there was a
  trivial conflict.

- Add dependency information to the commit message, i.e. this patch
  applies on top of the two patchsets but not on either alone: "ACPI graph
  support" and "Fwnode property API fixes for OF, pset and ACPI".

 drivers/base/property.c | 45 +--------------------------------------------
 1 file changed, 1 insertion(+), 44 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7152045..149de31 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -180,31 +180,6 @@ static int pset_prop_read_string_array(struct property_set *pset,
 	return array_len;
 }
 
-static int pset_prop_read_string(struct property_set *pset,
-				 const char *propname, const char **strings)
-{
-	const struct property_entry *prop;
-	const char * const *pointer;
-
-	prop = pset_prop_get(pset, propname);
-	if (!prop)
-		return -EINVAL;
-	if (!prop->is_string)
-		return -EILSEQ;
-	if (prop->is_array) {
-		pointer = prop->pointer.str;
-		if (!pointer)
-			return -ENODATA;
-	} else {
-		pointer = &prop->value.str;
-		if (*pointer && strnlen(*pointer, prop->length) >= prop->length)
-			return -EILSEQ;
-	}
-
-	*strings = *pointer;
-	return 0;
-}
-
 struct fwnode_handle *dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
@@ -582,19 +557,6 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static int __fwnode_property_read_string(struct fwnode_handle *fwnode,
-					 const char *propname, const char **val)
-{
-	if (is_of_node(fwnode))
-		return of_property_read_string(to_of_node(fwnode), propname, val);
-	else if (is_acpi_node(fwnode))
-		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
-					   val, 1);
-	else if (is_pset_node(fwnode))
-		return pset_prop_read_string(to_pset_node(fwnode), propname, val);
-	return -ENXIO;
-}
-
 /**
  * fwnode_property_read_string_array - return string array property of a node
  * @fwnode: Firmware node to get the property of
@@ -646,13 +608,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
 int fwnode_property_read_string(struct fwnode_handle *fwnode,
 				const char *propname, const char **val)
 {
-	int ret;
+	int ret = fwnode_property_read_string_array(fwnode, propname, val, 1);
 
-	ret = __fwnode_property_read_string(fwnode, propname, val);
-	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = __fwnode_property_read_string(fwnode->secondary,
-						    propname, val);
 	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
