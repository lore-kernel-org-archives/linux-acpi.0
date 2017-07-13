From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 3/7] ACPI: Prepare for constifying acpi_get_next_subnode() fwnode argument
Date: Thu, 13 Jul 2017 16:27:03 +0300
Message-ID: <1499952427-16130-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1499952427-16130-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499952427-16130-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Make local variables const (head) or add new variables; adev was used for
two purposes: to refer the root device node and its children. The two
purposes are separated by this patch.

This is preparation for making fwnode arguments const for fwnode ops.
Don't constify the argument itself quite yet as this is used as a callback
function.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
