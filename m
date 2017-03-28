From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 2/3] device property: Fix reading pset strings using array access functions
Date: Tue, 28 Mar 2017 15:22:18 +0300
Message-ID: <1490703739-28270-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1490703739-28270-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46974 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbdC1MWu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 08:22:50 -0400
In-Reply-To: <1490703739-28270-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

The length field value of non-array string properties is the length of the
string itself. Non-array string properties thus require specific handling.
Fix this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 19a3dc5..686e985 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -146,14 +146,36 @@ static int pset_prop_read_string_array(struct property_set *pset,
 				       const char *propname,
 				       const char **strings, size_t nval)
 {
+	const struct property_entry *prop;
 	const void *pointer;
-	size_t length = nval * sizeof(*strings);
+	size_t array_len, length;
+
+	/* Find out the array length. */
+	prop = pset_prop_get(pset, propname);
+	if (!prop)
+		return -EINVAL;
+
+	if (!prop->is_array)
+		/* The array length for a non-array string property is 1. */
+		array_len = 1;
+	else
+		/* Find the length of an array. */
+		array_len = pset_prop_count_elems_of_size(pset, propname,
+							  sizeof(const char *));
+
+	/* Return how many there are if strings is NULL. */
+	if (!strings)
+		return array_len;
+
+	array_len = min(nval, array_len);
+	length = array_len * sizeof(*strings);
 
 	pointer = pset_prop_find(pset, propname, length);
 	if (IS_ERR(pointer))
 		return PTR_ERR(pointer);
 
 	memcpy(strings, pointer, length);
+
 	return 0;
 }
 
@@ -553,12 +575,8 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
 					   val, nval);
 	else if (is_pset_node(fwnode))
-		return val ?
-			pset_prop_read_string_array(to_pset_node(fwnode),
-						    propname, val, nval) :
-			pset_prop_count_elems_of_size(to_pset_node(fwnode),
-						      propname,
-						      sizeof(const char *));
+		return pset_prop_read_string_array(to_pset_node(fwnode),
+						   propname, val, nval);
 	return -ENXIO;
 }
 
-- 
2.7.4

