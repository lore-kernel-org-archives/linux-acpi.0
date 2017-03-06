From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/3] device property: fwnode_property_read_string_array() may return -EILSEQ
Date: Mon,  6 Mar 2017 15:26:29 +0200
Message-ID: <1488806791-25488-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1488806791-25488-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:50760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753010AbdCFN07 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 08:26:59 -0500
In-Reply-To: <1488806791-25488-1-git-send-email-sakari.ailus@linux.intel.com>
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

