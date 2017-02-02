From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 13/16] device property: Get endpoint index from the ACPI tables
Date: Thu,  2 Feb 2017 18:22:23 +0200
Message-ID: <1486052546-19257-14-git-send-email-sakari.ailus@linux.intel.com>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:56976 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbdBBQYA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 11:24:00 -0500
In-Reply-To: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On ACPI, find the child node index instead of relying on the "endpoint"
property.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 3f77404..28125a5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1266,8 +1266,14 @@ int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 	 * If they don't then the default value 0 is used.
 	 */
 	if (is_acpi_node(port_fwnode)) {
+		struct fwnode_handle *iter;
+
 		fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
-		fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
+
+		for (iter = fwnode_get_next_child_node(port_fwnode, NULL);
+		     iter != fwnode;
+		     iter = fwnode_get_next_child_node(port_fwnode, iter))
+			endpoint->id++;
 	} else {
 		fwnode_property_read_u32(port_fwnode, "reg", &endpoint->port);
 		fwnode_property_read_u32(fwnode, "reg", &endpoint->id);
-- 
2.7.4

