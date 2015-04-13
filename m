From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/31] ACPICA: Update Resource descriptor dump module.
Date: Mon, 13 Apr 2015 11:50:08 +0800
Message-ID: <7948b3187f72576b678975dac4c00777d9f04fbb.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60354 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593AbbDMDuM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:50:12 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 184f3cc4d162a6b6b2005eacd8be2fe55f19a245

- Change global #ifdef to check for ACPI_DEBUGGER only.
- Cleanup some long lines and misaligned code.

Link: https://github.com/acpica/acpica/commit/184f3cc4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acresrc.h |    4 +-
 drivers/acpi/acpica/rsdump.c  |  229 +++++++++++++++++++++--------------------
 2 files changed, 117 insertions(+), 116 deletions(-)

diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index ac20b9d..6357efb 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -299,9 +299,9 @@ acpi_rs_set_resource_length(acpi_rsdesc_size total_length,
 			    union aml_resource *aml);
 
 /*
- * rsdump
+ * rsdump - Debugger support
  */
-#ifdef ACPI_EXEC_APP
+#ifdef ACPI_DEBUGGER
 void acpi_rs_dump_resource_list(struct acpi_resource *resource);
 
 void acpi_rs_dump_irq_list(u8 *route_table);
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 6d588d4..c428bb3 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -1,6 +1,6 @@
 /*******************************************************************************
  *
- * Module Name: rsdump - Functions to display the resource structures.
+ * Module Name: rsdump - AML debugger support for resource structures.
  *
  ******************************************************************************/
 
@@ -48,7 +48,10 @@
 #define _COMPONENT          ACPI_RESOURCES
 ACPI_MODULE_NAME("rsdump")
 
-#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
+/*
+ * All functions in this module are used by the AML Debugger only
+ */
+#if defined(ACPI_DEBUGGER)
 /* Local prototypes */
 static void acpi_rs_out_string(char *title, char *value);
 
@@ -80,6 +83,116 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table);
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_rs_dump_resource_list
+ *
+ * PARAMETERS:  resource_list       - Pointer to a resource descriptor list
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Dispatches the structure to the correct dump routine.
+ *
+ ******************************************************************************/
+
+void acpi_rs_dump_resource_list(struct acpi_resource *resource_list)
+{
+	u32 count = 0;
+	u32 type;
+
+	ACPI_FUNCTION_ENTRY();
+
+	/* Check if debug output enabled */
+
+	if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_RESOURCES, _COMPONENT)) {
+		return;
+	}
+
+	/* Walk list and dump all resource descriptors (END_TAG terminates) */
+
+	do {
+		acpi_os_printf("\n[%02X] ", count);
+		count++;
+
+		/* Validate Type before dispatch */
+
+		type = resource_list->type;
+		if (type > ACPI_RESOURCE_TYPE_MAX) {
+			acpi_os_printf
+			    ("Invalid descriptor type (%X) in resource list\n",
+			     resource_list->type);
+			return;
+		}
+
+		/* Sanity check the length. It must not be zero, or we loop forever */
+
+		if (!resource_list->length) {
+			acpi_os_printf
+			    ("Invalid zero length descriptor in resource list\n");
+			return;
+		}
+
+		/* Dump the resource descriptor */
+
+		if (type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
+			acpi_rs_dump_descriptor(&resource_list->data,
+						acpi_gbl_dump_serial_bus_dispatch
+						[resource_list->data.
+						 common_serial_bus.type]);
+		} else {
+			acpi_rs_dump_descriptor(&resource_list->data,
+						acpi_gbl_dump_resource_dispatch
+						[type]);
+		}
+
+		/* Point to the next resource structure */
+
+		resource_list = ACPI_NEXT_RESOURCE(resource_list);
+
+		/* Exit when END_TAG descriptor is reached */
+
+	} while (type != ACPI_RESOURCE_TYPE_END_TAG);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_rs_dump_irq_list
+ *
+ * PARAMETERS:  route_table     - Pointer to the routing table to dump.
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print IRQ routing table
+ *
+ ******************************************************************************/
+
+void acpi_rs_dump_irq_list(u8 *route_table)
+{
+	struct acpi_pci_routing_table *prt_element;
+	u8 count;
+
+	ACPI_FUNCTION_ENTRY();
+
+	/* Check if debug output enabled */
+
+	if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_RESOURCES, _COMPONENT)) {
+		return;
+	}
+
+	prt_element = ACPI_CAST_PTR(struct acpi_pci_routing_table, route_table);
+
+	/* Dump all table elements, Exit on zero length element */
+
+	for (count = 0; prt_element->length; count++) {
+		acpi_os_printf("\n[%02X] PCI IRQ Routing Table Package\n",
+			       count);
+		acpi_rs_dump_descriptor(prt_element, acpi_rs_dump_prt);
+
+		prt_element = ACPI_ADD_PTR(struct acpi_pci_routing_table,
+					   prt_element, prt_element->length);
+	}
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_rs_dump_descriptor
  *
  * PARAMETERS:  resource            - Buffer containing the resource
@@ -355,118 +468,6 @@ static void acpi_rs_dump_address_common(union acpi_resource_data *resource)
 	acpi_rs_dump_descriptor(resource, acpi_rs_dump_general_flags);
 }
 
-#ifdef ACPI_EXEC_APP
-/*******************************************************************************
- *
- * FUNCTION:    acpi_rs_dump_resource_list
- *
- * PARAMETERS:  resource_list       - Pointer to a resource descriptor list
- *
- * RETURN:      None
- *
- * DESCRIPTION: Dispatches the structure to the correct dump routine.
- *
- ******************************************************************************/
-
-void acpi_rs_dump_resource_list(struct acpi_resource *resource_list)
-{
-	u32 count = 0;
-	u32 type;
-
-	ACPI_FUNCTION_ENTRY();
-
-	/* Check if debug output enabled */
-
-	if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_RESOURCES, _COMPONENT)) {
-		return;
-	}
-
-	/* Walk list and dump all resource descriptors (END_TAG terminates) */
-
-	do {
-		acpi_os_printf("\n[%02X] ", count);
-		count++;
-
-		/* Validate Type before dispatch */
-
-		type = resource_list->type;
-		if (type > ACPI_RESOURCE_TYPE_MAX) {
-			acpi_os_printf
-			    ("Invalid descriptor type (%X) in resource list\n",
-			     resource_list->type);
-			return;
-		}
-
-		/* Sanity check the length. It must not be zero, or we loop forever */
-
-		if (!resource_list->length) {
-			acpi_os_printf
-			    ("Invalid zero length descriptor in resource list\n");
-			return;
-		}
-
-		/* Dump the resource descriptor */
-
-		if (type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
-			acpi_rs_dump_descriptor(&resource_list->data,
-						acpi_gbl_dump_serial_bus_dispatch
-						[resource_list->data.
-						 common_serial_bus.type]);
-		} else {
-			acpi_rs_dump_descriptor(&resource_list->data,
-						acpi_gbl_dump_resource_dispatch
-						[type]);
-		}
-
-		/* Point to the next resource structure */
-
-		resource_list = ACPI_NEXT_RESOURCE(resource_list);
-
-		/* Exit when END_TAG descriptor is reached */
-
-	} while (type != ACPI_RESOURCE_TYPE_END_TAG);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_rs_dump_irq_list
- *
- * PARAMETERS:  route_table     - Pointer to the routing table to dump.
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print IRQ routing table
- *
- ******************************************************************************/
-
-void acpi_rs_dump_irq_list(u8 *route_table)
-{
-	struct acpi_pci_routing_table *prt_element;
-	u8 count;
-
-	ACPI_FUNCTION_ENTRY();
-
-	/* Check if debug output enabled */
-
-	if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_RESOURCES, _COMPONENT)) {
-		return;
-	}
-
-	prt_element = ACPI_CAST_PTR(struct acpi_pci_routing_table, route_table);
-
-	/* Dump all table elements, Exit on zero length element */
-
-	for (count = 0; prt_element->length; count++) {
-		acpi_os_printf("\n[%02X] PCI IRQ Routing Table Package\n",
-			       count);
-		acpi_rs_dump_descriptor(prt_element, acpi_rs_dump_prt);
-
-		prt_element = ACPI_ADD_PTR(struct acpi_pci_routing_table,
-					   prt_element, prt_element->length);
-	}
-}
-#endif
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_rs_out*
-- 
1.7.10

