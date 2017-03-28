From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 1/3] device property: fwnode_property_read_string_array() may return -EILSEQ
Date: Tue, 28 Mar 2017 15:22:17 +0300
Message-ID: <1490703739-28270-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1490703739-28270-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59536 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751542AbdC1MXp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 08:23:45 -0400
In-Reply-To: <1490703739-28270-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

fwnode_property_read_string_array() may return -EILSEQ through
of_property_read_string_array(). Document this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c458c63..19a3dc5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -589,7 +589,7 @@ static int __fwnode_property_read_string(struct fwnode_handle *fwnode,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
  *	   %-ENODATA if the property does not have a value,
- *	   %-EPROTO if the property is not an array of strings,
+ *	   %-EPROTO or %-EILSEQ if the property is not an array of strings,
  *	   %-EOVERFLOW if the size of the property is not as expected,
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-- 
2.7.4

