From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/7] ACPI: Constify acpi_get_next_subnode() fwnode argument
Date: Mon, 22 May 2017 12:07:36 +0300
Message-ID: <1495444062-23867-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:62405 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757683AbdEVJJX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 May 2017 05:09:23 -0400
In-Reply-To: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

This is preparation for making fwnode arguments const for fwnode ops.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e90f674..bfa726c 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -900,12 +900,14 @@ int acpi_node_prop_read(struct fwnode_handle *fwnode,  const char *propname,
 struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child)
 {
-	struct acpi_device *adev = to_acpi_device_node(fwnode);
-	struct list_head *head, *next;
+	const struct acpi_device *adevc = to_acpi_device_node(fwnode);
+	struct acpi_device *adev = NULL;
+	const struct list_head *head;
+	struct list_head *next;
 
 	if (!child || child->type == FWNODE_ACPI) {
-		if (adev)
-			head = &adev->children;
+		if (adevc)
+			head = &adevc->children;
 		else
 			goto nondev;
 
@@ -928,11 +930,13 @@ struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 
  nondev:
 	if (!child || child->type == FWNODE_ACPI_DATA) {
-		struct acpi_data_node *data = to_acpi_data_node(fwnode);
+		const struct acpi_data_node *data = to_acpi_data_node(fwnode);
 		struct acpi_data_node *dn;
 
 		if (adev)
 			head = &adev->data.subnodes;
+		else if (adevc)
+			head = &adevc->data.subnodes;
 		else if (data)
 			head = &data->data.subnodes;
 		else
-- 
2.7.4

