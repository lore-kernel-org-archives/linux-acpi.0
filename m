From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/1] device properties: Fix return codes for __acpi_node_get_property_reference
Date: Thu,  5 Oct 2017 09:04:24 +0300
Message-ID: <20171005060424.16780-1-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:44726 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750860AbdJEGE0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Oct 2017 02:04:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, mika.westerberg@intel.com, hyungwoo.yang@intel.com

Fix more return codes for device property: Align return codes of
__acpi_node_get_property_reference. In particular what was missed
previously:

-EPROTO could be returned in certain cases, now -EINVAL;
-EINVAL was returned if the property was not found, now -ENOENT;
-EINVAL was returned also if the index was higher than the number of
entries in a package, now -ENOENT.

Fixes: ("device property: Align return codes of __acpi_node_get_property_reference")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
---
Hi Rafael,

Unfortunately the patch I posted the previous time to remedy the issue
("device property: Align return codes of
_acpi_node_get_property_reference") did not fully fix the issue.

 drivers/acpi/property.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 5a8ac5e1081b..8c28c516e7ec 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -592,8 +592,16 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	ret = acpi_data_get_property(data, propname, ACPI_TYPE_ANY, &obj);
-	if (ret)
-		return ret;
+	switch (ret) {
+	case -EINVAL:
+		return -ENOENT;
+	case -EPROTO:
+		return -EINVAL;
+	default:
+		if (ret)
+			return ret;
+		break;
+	}
 
 	/*
 	 * The simplest case is when the value is a single reference.  Just
@@ -605,7 +613,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 		ret = acpi_bus_get_device(obj->reference.handle, &device);
 		if (ret)
-			return ret;
+			return ret == -ENODEV ? -EINVAL : ret;
 
 		args->adev = device;
 		args->nargs = 0;
@@ -621,8 +629,10 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 	 * The index argument is then used to determine which reference
 	 * the caller wants (along with the arguments).
 	 */
-	if (obj->type != ACPI_TYPE_PACKAGE || index >= obj->package.count)
-		return -EPROTO;
+	if (obj->type != ACPI_TYPE_PACKAGE)
+		return -EINVAL;
+	if (index >= obj->package.count)
+		return -ENOENT;
 
 	element = obj->package.elements;
 	end = element + obj->package.count;
-- 
2.11.0

