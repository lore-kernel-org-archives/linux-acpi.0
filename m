From: Len Brown <lenb@kernel.org>
Subject: [PATCH 93/140] ACPICA: _CID support for PCI Root Bridge detection.
Date: Wed,  7 Feb 2007 13:51:47 -0500
Message-ID: <11708745072908-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <b7a69806308600711589e4ca306d18dd029ef0cf.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:24742 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422790AbXBGSzN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:13 -0500
In-Reply-To: <11708745063772-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
@@ -168,9 +174,9 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 	union acpi_operand_object *handler_obj;
 	struct acpi_namespace_node *parent_node;
 	struct acpi_namespace_node *pci_root_node;
+	struct acpi_namespace_node *pci_device_node;
 	union acpi_operand_object *region_obj =
 	    (union acpi_operand_object *)handle;
-	struct acpi_device_id object_hID;
 
 	ACPI_FUNCTION_TRACE(ev_pci_config_region_setup);
 
@@ -215,45 +221,30 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 
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
@@ -282,14 +273,25 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
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
@@ -329,6 +331,91 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 
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
1.5.0.rc3.39.gec804
