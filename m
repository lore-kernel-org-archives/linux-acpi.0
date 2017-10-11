From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 1/1] device properties: Fix return codes for __acpi_node_get_property_reference
Date: Wed, 11 Oct 2017 11:06:13 +0300
Message-ID: <20171011080613.19688-1-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:56970 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757152AbdJKIGP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Oct 2017 04:06:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, rafael@kernel.org
Cc: mika.westerberg@intel.com, hyungwoo.yang@intel.com

Fix more return codes for device property: Align return codes of
__acpi_node_get_property_reference. In particular what was missed
previously:

-EPROTO could be returned in certain cases, now -EINVAL;
-EINVAL was returned if the property was not found, now -ENOENT;
-EINVAL was returned also if the index was higher than the number of
entries in a package, now -ENOENT.

Reported-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
Fixes: ("device property: Align return codes of __acpi_node_get_property_reference")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
---
since v1:

- Remove the ugly switch from acpi_data_get_property() return value
  handling. Only -EINVAL and -EPROTO are returned by the function.

 drivers/acpi/property.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 5a8ac5e1081b..e26ea209b63e 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -593,7 +593,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 	ret = acpi_data_get_property(data, propname, ACPI_TYPE_ANY, &obj);
 	if (ret)
-		return ret;
+		return ret == -EINVAL ? -ENOENT : -EINVAL;
 
 	/*
 	 * The simplest case is when the value is a single reference.  Just
@@ -605,7 +605,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 		ret = acpi_bus_get_device(obj->reference.handle, &device);
 		if (ret)
-			return ret;
+			return ret == -ENODEV ? -EINVAL : ret;
 
 		args->adev = device;
 		args->nargs = 0;
@@ -621,8 +621,10 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
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

