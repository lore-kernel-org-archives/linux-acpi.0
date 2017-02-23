From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 10/20] device property: Read strings using string array reading functions
Date: Thu, 23 Feb 2017 19:01:06 +0200
Message-ID: <1487869276-25244-11-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:22850 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbdBWRId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:08:33 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Always read strings using of_property_read_string_array() instead of
of_property_read_string(). This allows using a single operation struct
callback for accessing strings.

Same for pset_prop_read_string_array() and pset_prop_read_string().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 47 +----------------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c2068a..b251525 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -158,31 +158,6 @@ static int pset_prop_read_string_array(struct property_set *pset,
 	return 0;
 }
 
-static int pset_prop_read_string(struct property_set *pset,
-				 const char *propname, const char **strings)
-{
-	struct property_entry *prop;
-	const char **pointer;
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
 static bool pset_fwnode_property_present(struct fwnode_handle *fwnode,
 					 const char *propname)
 {
@@ -586,19 +561,6 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
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
@@ -650,14 +612,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
 int fwnode_property_read_string(struct fwnode_handle *fwnode,
 				const char *propname, const char **val)
 {
-	int ret;
-
-	ret = __fwnode_property_read_string(fwnode, propname, val);
-	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = __fwnode_property_read_string(fwnode->secondary,
-						    propname, val);
-	return ret;
+	return fwnode_property_read_string_array(fwnode, propname, val, 1);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
 
-- 
2.7.4

