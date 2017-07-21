From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 3/8] ACPI: Prepare for constifying acpi_get_next_subnode() fwnode argument
Date: Fri, 21 Jul 2017 14:39:32 +0300
Message-ID: <1500637177-16095-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:39791 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbdGULli (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 07:41:38 -0400
In-Reply-To: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, erik.veijola@intel.com, andriy.shevchenko@linux.intel.com

Make local variables const (head) or add new variables; adev was used for
two purposes: to refer the root device node and its children. The two
purposes are separated by this patch.

This is preparation for making fwnode arguments const for fwnode ops.
Don't constify the argument itself quite yet as this is used as a callback
function.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index cb6a3b3..04c60a2 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -899,8 +899,10 @@ int acpi_node_prop_read(struct fwnode_handle *fwnode,  const char *propname,
 struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child)
 {
-	struct acpi_device *adev = to_acpi_device_node(fwnode);
-	struct list_head *head, *next;
+	const struct acpi_device *adev = to_acpi_device_node(fwnode);
+	struct acpi_device *child_adev = NULL;
+	const struct list_head *head;
+	struct list_head *next;
 
 	if (!child || is_acpi_device_node(child)) {
 		if (adev)
@@ -912,26 +914,27 @@ struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 			goto nondev;
 
 		if (child) {
-			adev = to_acpi_device_node(child);
-			next = adev->node.next;
+			child_adev = to_acpi_device_node(child);
+			next = child_adev->node.next;
 			if (next == head) {
 				child = NULL;
 				goto nondev;
 			}
-			adev = list_entry(next, struct acpi_device, node);
+			child_adev = list_entry(next, struct acpi_device, node);
 		} else {
-			adev = list_first_entry(head, struct acpi_device, node);
+			child_adev = list_first_entry(head, struct acpi_device,
+						      node);
 		}
-		return acpi_fwnode_handle(adev);
+		return acpi_fwnode_handle(child_adev);
 	}
 
  nondev:
 	if (!child || is_acpi_data_node(child)) {
-		struct acpi_data_node *data = to_acpi_data_node(fwnode);
+		const struct acpi_data_node *data = to_acpi_data_node(fwnode);
 		struct acpi_data_node *dn;
 
-		if (adev)
-			head = &adev->data.subnodes;
+		if (child_adev)
+			head = &child_adev->data.subnodes;
 		else if (data)
 			head = &data->data.subnodes;
 		else
-- 
2.7.4

