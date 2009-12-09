From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/14] ACPICA: Remove possibility of executing _REG methods
 twice
Date: Wed, 09 Dec 2009 12:22:04 -0500
Message-ID: <74d3ec77a5e0633b0c7a8490941432c2e4789037.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:41177 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbZLIRWc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:22:32 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE00EXLAX67B56@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:22:32 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

If a custom address space handler is installed by the host
before the "initialize operation regions" phase of the ACPICA
initialization, any _REG methods for that address space could
be executed twice. This change fixes the problem.
ACPICA BZ 427.

http://www.acpica.org/bugzilla/show_bug.cgi?id=427

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evregion.c |   64 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 98c7f9c..c9fa040 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -51,6 +51,10 @@
 ACPI_MODULE_NAME("evregion")
 
 /* Local prototypes */
+static u8
+acpi_ev_has_default_handler(struct acpi_namespace_node *node,
+			    acpi_adr_space_type space_id);
+
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -142,6 +146,50 @@ acpi_status acpi_ev_install_region_handlers(void)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ev_has_default_handler
+ *
+ * PARAMETERS:  Node                - Namespace node for the device
+ *              space_id            - The address space ID
+ *
+ * RETURN:      TRUE if default handler is installed, FALSE otherwise
+ *
+ * DESCRIPTION: Check if the default handler is installed for the requested
+ *              space ID.
+ *
+ ******************************************************************************/
+
+static u8
+acpi_ev_has_default_handler(struct acpi_namespace_node *node,
+			    acpi_adr_space_type space_id)
+{
+	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *handler_obj;
+
+	/* Must have an existing internal object */
+
+	obj_desc = acpi_ns_get_attached_object(node);
+	if (obj_desc) {
+		handler_obj = obj_desc->device.handler;
+
+		/* Walk the linked list of handlers for this object */
+
+		while (handler_obj) {
+			if (handler_obj->address_space.space_id == space_id) {
+				if (handler_obj->address_space.handler_flags &
+				    ACPI_ADDR_HANDLER_DEFAULT_INSTALLED) {
+					return (TRUE);
+				}
+			}
+
+			handler_obj = handler_obj->address_space.next;
+		}
+	}
+
+	return (FALSE);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_initialize_op_regions
  *
  * PARAMETERS:  None
@@ -169,12 +217,18 @@ acpi_status acpi_ev_initialize_op_regions(void)
 
 	for (i = 0; i < ACPI_NUM_DEFAULT_SPACES; i++) {
 		/*
-		 * TBD: Make sure handler is the DEFAULT handler, otherwise
-		 * _REG will have already been run.
+		 * Make sure the installed handler is the DEFAULT handler. If not the
+		 * default, the _REG methods will have already been run (when the
+		 * handler was installed)
 		 */
-		status = acpi_ev_execute_reg_methods(acpi_gbl_root_node,
-						     acpi_gbl_default_address_spaces
-						     [i]);
+		if (acpi_ev_has_default_handler(acpi_gbl_root_node,
+						acpi_gbl_default_address_spaces
+						[i])) {
+			status =
+			    acpi_ev_execute_reg_methods(acpi_gbl_root_node,
+							acpi_gbl_default_address_spaces
+							[i]);
+		}
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-- 
1.6.0.6

