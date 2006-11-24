From: Len Brown <len.brown@intel.com>
Subject: [PATCH 52/65] ACPICA: _CID support for PCI Root Bridge detection.
Date: Fri, 24 Nov 2006 02:19:02 -0500
Message-ID: <11643528134106-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com> <11643528124177-git-send-email-len.brown@int
 el.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14906 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934497AbWKXHQP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:15 -0500
In-Reply-To: <11643528124177-git-send-email-len.brown@intel.com>
Message-Id: <14b975ea77e0241f7867bca815b0eec71fb155d6.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Implemented _CID support for PCI Root Bridge detection. If the _HID
does not match the predefined root bridge IDs, the _CID list (if present)
 is now obtained and also checked for an ID match

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evrgnini.c |  163 ++++++++++++++++++++++++++++++---------
 1 files changed, 125 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/events/evrgnini.c b/drivers/acpi/events/evrgnini.c
index 790d49b..6176602 100644
--- a/drivers/acpi/events/evrgnini.c
+++ b/drivers/acpi/events/evrgnini.c
@@ -48,6 +48,11 @@
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evrgnini")
 
+/* Local prototypes */
+static u8 acpi_ev_match_pci_root_bridge(char *id);
+
+static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_system_memory_region_setup
@@ -62,6 +67,7 @@ ACPI_MODULE_NAME("evrgnini")
  * DESCRIPTION: Setup a system_memory operation region
  *
  ******************************************************************************/
+
 acpi_status
 acpi_ev_system_memory_region_setup(acpi_handle handle,
 				   u32 function,
@@ -168,9 +174,9 @@ acpi_ev_pci_config_region_setup(acpi_han
 	union acpi_operand_object *handler_obj;
 	struct acpi_namespace_node *parent_node;
 	struct acpi_namespace_node *pci_root_node;
+	struct acpi_namespace_node *pci_device_node;
 	union acpi_operand_object *region_obj =
 	    (union acpi_operand_object *)handle;
-	struct acpi_device_id object_hID;
 
 	ACPI_FUNCTION_TRACE(ev_pci_config_region_setup);
 
@@ -215,45 +221,30 @@ acpi_ev_pci_config_region_setup(acpi_han
 
 		pci_root_node = parent_node;
 		while (pci_root_node != acpi_gbl_root_node) {
-			status =
-			    acpi_ut_execute_HID(pci_root_node, &object_hID);
-			if (ACPI_SUCCESS(status)) {
-				/*
-				 * Got a valid _HID string, check if this is a PCI root.
-				 * New for ACPI 3.0: check for a PCI Express root also.
-				 */
-				if (!
-				    (ACPI_STRNCMP
-				     (object_hID.value, PCI_ROOT_HID_STRING,
-				      sizeof(PCI_ROOT_HID_STRING)))
-				    ||
-				    !(ACPI_STRNCMP
-				      (object_hID.value,
-				       PCI_EXPRESS_ROOT_HID_STRING,
-				       sizeof(PCI_EXPRESS_ROOT_HID_STRING)))) {
-
-					/* Install a handler for this PCI root bridge */
 
-					status =
-					    acpi_install_address_space_handler((acpi_handle) pci_root_node, ACPI_ADR_SPACE_PCI_CONFIG, ACPI_DEFAULT_HANDLER, NULL, NULL);
-					if (ACPI_FAILURE(status)) {
-						if (status == AE_SAME_HANDLER) {
-							/*
-							 * It is OK if the handler is already installed on the root
-							 * bridge.  Still need to return a context object for the
-							 * new PCI_Config operation region, however.
-							 */
-							status = AE_OK;
-						} else {
-							ACPI_EXCEPTION((AE_INFO,
-									status,
-									"Could not install PciConfig handler for Root Bridge %4.4s",
-									acpi_ut_get_node_name
-									(pci_root_node)));
-						}
+			/* Get the _HID/_CID in order to detect a root_bridge */
+
+			if (acpi_ev_is_pci_root_bridge(pci_root_node)) {
+
+				/* Install a handler for this PCI root bridge */
+
+				status = acpi_install_address_space_handler((acpi_handle) pci_root_node, ACPI_ADR_SPACE_PCI_CONFIG, ACPI_DEFAULT_HANDLER, NULL, NULL);
+				if (ACPI_FAILURE(status)) {
+					if (status == AE_SAME_HANDLER) {
+						/*
+						 * It is OK if the handler is already installed on the root
+						 * bridge.  Still need to return a context object for the
+						 * new PCI_Config operation region, however.
+						 */
+						status = AE_OK;
+					} else {
+						ACPI_EXCEPTION((AE_INFO, status,
+								"Could not install PciConfig handler for Root Bridge %4.4s",
+								acpi_ut_get_node_name
+								(pci_root_node)));
 					}
-					break;
 				}
+				break;
 			}
 
 			pci_root_node = acpi_ns_get_parent_node(pci_root_node);
@@ -282,14 +273,25 @@ acpi_ev_pci_config_region_setup(acpi_han
 	/*
 	 * For PCI_Config space access, we need the segment, bus,
 	 * device and function numbers.  Acquire them here.
+	 *
+	 * Find the parent device object. (This allows the operation region to be
+	 * within a subscope under the device, such as a control method.)
 	 */
+	pci_device_node = region_obj->region.node;
+	while (pci_device_node && (pci_device_node->type != ACPI_TYPE_DEVICE)) {
+		pci_device_node = acpi_ns_get_parent_node(pci_device_node);
+	}
+
+	if (!pci_device_node) {
+		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+	}
 
 	/*
 	 * Get the PCI device and function numbers from the _ADR object
 	 * contained in the parent's scope.
 	 */
 	status =
-	    acpi_ut_evaluate_numeric_object(METHOD_NAME__ADR, parent_node,
+	    acpi_ut_evaluate_numeric_object(METHOD_NAME__ADR, pci_device_node,
 					    &pci_value);
 
 	/*
@@ -329,6 +331,91 @@ acpi_ev_pci_config_region_setup(acpi_han
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ev_match_pci_root_bridge
+ *
+ * PARAMETERS:  Id              - The HID/CID in string format
+ *
+ * RETURN:      TRUE if the Id is a match for a PCI/PCI-Express Root Bridge
+ *
+ * DESCRIPTION: Determine if the input ID is a PCI Root Bridge ID.
+ *
+ ******************************************************************************/
+
+static u8 acpi_ev_match_pci_root_bridge(char *id)
+{
+
+	/*
+	 * Check if this is a PCI root.
+	 * ACPI 3.0+: check for a PCI Express root also.
+	 */
+	if (!(ACPI_STRNCMP(id,
+			   PCI_ROOT_HID_STRING,
+			   sizeof(PCI_ROOT_HID_STRING))) ||
+	    !(ACPI_STRNCMP(id,
+			   PCI_EXPRESS_ROOT_HID_STRING,
+			   sizeof(PCI_EXPRESS_ROOT_HID_STRING)))) {
+		return (TRUE);
+	}
+
+	return (FALSE);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_is_pci_root_bridge
+ *
+ * PARAMETERS:  Node            - Device node being examined
+ *
+ * RETURN:      TRUE if device is a PCI/PCI-Express Root Bridge
+ *
+ * DESCRIPTION: Determine if the input device represents a PCI Root Bridge by
+ *              examining the _HID and _CID for the device.
+ *
+ ******************************************************************************/
+
+static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
+{
+	acpi_status status;
+	struct acpi_device_id hid;
+	struct acpi_compatible_id_list *cid;
+	acpi_native_uint i;
+
+	/*
+	 * Get the _HID and check for a PCI Root Bridge
+	 */
+	status = acpi_ut_execute_HID(node, &hid);
+	if (ACPI_FAILURE(status)) {
+		return (FALSE);
+	}
+
+	if (acpi_ev_match_pci_root_bridge(hid.value)) {
+		return (TRUE);
+	}
+
+	/*
+	 * The _HID did not match.
+	 * Get the _CID and check for a PCI Root Bridge
+	 */
+	status = acpi_ut_execute_CID(node, &cid);
+	if (ACPI_FAILURE(status)) {
+		return (FALSE);
+	}
+
+	/* Check all _CIDs in the returned list */
+
+	for (i = 0; i < cid->count; i++) {
+		if (acpi_ev_match_pci_root_bridge(cid->id[i].value)) {
+			ACPI_FREE(cid);
+			return (TRUE);
+		}
+	}
+
+	ACPI_FREE(cid);
+	return (FALSE);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_pci_bar_region_setup
  *
  * PARAMETERS:  Handle              - Region we are interested in
-- 
1.4.4.1
