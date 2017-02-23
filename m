From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 02/20] device property: Fix reading pset strings using array access functions
Date: Thu, 23 Feb 2017 19:00:58 +0200
Message-ID: <1487869276-25244-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:51767 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbdBWRId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:08:33 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

The length field value of non-array string properties is the length of the
string itself. Non-array string properties thus require specific handling.
Fix this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 04c2174..e42dc93 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -547,13 +547,27 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 	else if (is_acpi_node(fwnode))
 		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
 					   val, nval);
-	else if (is_pset_node(fwnode))
-		return val ?
-			pset_prop_read_string_array(to_pset_node(fwnode),
-						    propname, val, nval) :
-			pset_prop_count_elems_of_size(to_pset_node(fwnode),
-						      propname,
-						      sizeof(const char *));
+	else if (is_pset_node(fwnode)) {
+		struct property_set *node = to_pset_node(fwnode);
+		struct property_entry *prop;
+
+		/* Read properties if val is non-NULL */
+		if (val)
+			return pset_prop_read_string_array(node, propname,
+							   val, nval);
+
+		prop = pset_prop_get(node, propname);
+		if (!prop)
+			return -EINVAL;
+
+		/* The array length for a non-array string property is 1. */
+		if (!prop->is_array)
+			return 1;
+
+		/* Return the length of an array. */
+		return pset_prop_count_elems_of_size(node, propname,
+						     sizeof(const char *));
+	}
 	return -ENXIO;
 }
 
-- 
2.7.4

