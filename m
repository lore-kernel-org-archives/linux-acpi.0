From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/1] ACPI: device property: Fix node lookup in acpi_graph_get_child_prop_value
Date: Tue, 22 Aug 2017 10:01:17 +0300
Message-ID: <1503385277-1944-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754565AbdHVHDm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Aug 2017 03:03:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: hyungwoo.yang@intel.com, mika.westerberg@intel.com, rafael@kernel.org

acpi_graph_get_child_prop_value() is intended to find a child node with a
certain property value pair. The check

	if (!fwnode_property_read_u32(fwnode, prop_name, &nr))
		continue;

is faulty: fwnode_property_read_u32() returns zero on success, not on
failure, leading to comparing values only if the searched property was not
found.

Fixes: 79389a83bc38 ("ACPI / property: Add support for remote endpoints")
Reported-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a65c09c..3963098 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1052,7 +1052,7 @@ static struct fwnode_handle *acpi_graph_get_child_prop_value(
 	fwnode_for_each_child_node(fwnode, child) {
 		u32 nr;
 
-		if (!fwnode_property_read_u32(fwnode, prop_name, &nr))
+		if (fwnode_property_read_u32(fwnode, prop_name, &nr))
 			continue;
 
 		if (val == nr)
-- 
2.7.4

