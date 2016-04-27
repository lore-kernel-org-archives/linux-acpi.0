From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] device property: fix a potential oops
Date: Wed, 27 Apr 2016 14:04:20 +0300
Message-ID: <1461755060-138091-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50303 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbcD0LEY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Apr 2016 07:04:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Since fwnode may hold ERR_PTR(-ENODEV) or it may point to
NULL, the fwnode type checks is_of_node(), is_acpi_node()
and is is_pset_node() need to consider it. Using
IS_ERR_OR_NULL() to check it.

Fixes: 0d67e0fa1664 ("device property: fix for a case of use-after-free")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c | 2 +-
 include/acpi/acpi_bus.h | 4 ++--
 include/linux/of.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 210423d..f38c21d 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -26,7 +26,7 @@ struct property_set {
 
 static inline bool is_pset_node(struct fwnode_handle *fwnode)
 {
-	return fwnode && fwnode->type == FWNODE_PDATA;
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_PDATA;
 }
 
 static inline struct property_set *to_pset_node(struct fwnode_handle *fwnode)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a84fd15..4d40e9b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -394,13 +394,13 @@ struct acpi_data_node {
 
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
 {
-	return fwnode && (fwnode->type == FWNODE_ACPI
+	return !IS_ERR_OR_NULL(fwnode) && (fwnode->type == FWNODE_ACPI
 		|| fwnode->type == FWNODE_ACPI_DATA);
 }
 
 static inline bool is_acpi_device_node(struct fwnode_handle *fwnode)
 {
-	return fwnode && fwnode->type == FWNODE_ACPI;
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_ACPI;
 }
 
 static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
diff --git a/include/linux/of.h b/include/linux/of.h
index 520cf2d..c7292e8 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -150,7 +150,7 @@ void of_core_init(void);
 
 static inline bool is_of_node(struct fwnode_handle *fwnode)
 {
-	return fwnode && fwnode->type == FWNODE_OF;
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_OF;
 }
 
 static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
-- 
2.8.0.rc3

