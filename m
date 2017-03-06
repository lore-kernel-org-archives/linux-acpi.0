From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 2/3] device property: Fix reading pset strings using array access functions
Date: Mon,  6 Mar 2017 15:26:30 +0200
Message-ID: <1488806791-25488-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1488806791-25488-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36416 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752832AbdCFN1x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 08:27:53 -0500
In-Reply-To: <1488806791-25488-1-git-send-email-sakari.ailus@linux.intel.com>
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
index 19a3dc5..9224541a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -552,13 +552,27 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
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

