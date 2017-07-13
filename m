From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 1/7] ACPI: Use IS_ERR_OR_NULL() instead of non-NULL check in is_acpi_data_node
Date: Thu, 13 Jul 2017 16:27:01 +0300
Message-ID: <1499952427-16130-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1499952427-16130-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:18051 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751267AbdGMN3b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Jul 2017 09:29:31 -0400
In-Reply-To: <1499952427-16130-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

The is_acpi_data_node() function takes a struct fwnode_handle pointer as
its argument. The validity of the pointer is first checked. Extend the
check to cover error values as is done by similar is_acpi_node() and
is_acpi_device_node() functions.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/acpi/acpi_bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 68bc6be..7569123 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -414,7 +414,7 @@ static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwno
 
 static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
 {
-	return fwnode && fwnode->type == FWNODE_ACPI_DATA;
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_ACPI_DATA;
 }
 
 static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
-- 
2.7.4

