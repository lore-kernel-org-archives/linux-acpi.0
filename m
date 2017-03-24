From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/1] device property: Read strings using string array reading functions
Date: Fri, 24 Mar 2017 11:24:46 +0200
Message-ID: <1490347486-9604-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:15816 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965479AbdCXJZj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Mar 2017 05:25:39 -0400
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
Hi folks,

I picked this patch out of the "Move firmware specific code to firmware
specific locations" patchset. The rest is either squashed to other patches
in the ACPI graph support patchset or not applicable after addressing
all review comments and developments in devicetree tree.

The patches are on top of v5 (v5.1 on some patches) of the ACPI graph
support patchset:

<URL:http://www.spinics.net/lists/linux-acpi/msg72641.html>

The original set with all patches is here:

<URL:http://www.spinics.net/lists/linux-acpi/msg72647.html>

There are no changes to the patch itself.

Regards,
Sakari

 drivers/base/property.c | 47 ++---------------------------------------------
 1 file changed, 2 insertions(+), 45 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 0a120e3..325dd7f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -158,31 +158,6 @@ static int pset_prop_read_string_array(struct property_set *pset,
 	return 0;
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
@@ -606,19 +581,6 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
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
@@ -670,14 +632,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
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
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
 
-- 
2.7.4

