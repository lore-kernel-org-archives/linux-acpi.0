From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 01/20] device property: fwnode_property_read_string_array() may return -EILSEQ
Date: Thu, 23 Feb 2017 19:00:57 +0200
Message-ID: <1487869276-25244-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:3520 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbdBWRId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:08:33 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

fwnode_property_read_string_array() may return -EILSEQ through
of_property_read_string_array(). Document this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 88e9f80..04c2174 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -584,7 +584,7 @@ static int __fwnode_property_read_string(struct fwnode_handle *fwnode,
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

