From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 03/20] device property: of_property_read_string_array() returns number of strings
Date: Thu, 23 Feb 2017 19:00:59 +0200
Message-ID: <1487869276-25244-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:13125 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbdBWRK0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:10:26 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

of_property_read_string_array() returns number of strings read if the
target array of pointers is non-NULL. fwnode_property_read_string_array()
is documented to return 0 in that case. Fix this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index e42dc93..5cb270f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -539,12 +539,24 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 					       const char *propname,
 					       const char **val, size_t nval)
 {
-	if (is_of_node(fwnode))
-		return val ?
-			of_property_read_string_array(to_of_node(fwnode),
-						      propname, val, nval) :
-			of_property_count_strings(to_of_node(fwnode), propname);
-	else if (is_acpi_node(fwnode))
+	if (is_of_node(fwnode)) {
+		int rval;
+
+		if (!val)
+			return of_property_count_strings(to_of_node(fwnode),
+							 propname);
+
+		rval = of_property_read_string_array(to_of_node(fwnode),
+						     propname, val, nval);
+
+		if (rval < 0)
+			return rval;
+
+		if (rval == nval)
+			return 0;
+
+		return -EOVERFLOW;
+	} else if (is_acpi_node(fwnode))
 		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
 					   val, nval);
 	else if (is_pset_node(fwnode)) {
-- 
2.7.4

