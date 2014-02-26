From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/18] ACPICA: Debugger: Add missing objects; Traverse linked lists
Date: Wed, 26 Feb 2014 10:33:32 +0800
Message-ID: <b2f63a2d801259a771d96584c3d7c7f113b89ad0.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:47886 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbaBZCdp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:33:45 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change adds support for two missing objects, the "extra" and
"data" secondary objects, as well as adding support to traverse and
display linked lists related to ACPICA objects.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acinterp.h |    4 +
 drivers/acpi/acpica/exdump.c   |  229 ++++++++++++++++++++++++++++++++++------
 2 files changed, 199 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index a1d4be9..186844a 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -89,6 +89,10 @@ typedef const struct acpi_exdump_info {
 #define ACPI_EXD_PACKAGE                11
 #define ACPI_EXD_FIELD                  12
 #define ACPI_EXD_REFERENCE              13
+#define ACPI_EXD_LIST                   14	/* Operand object list */
+#define ACPI_EXD_HDLR_LIST              15	/* Address Handler list */
+#define ACPI_EXD_RGN_LIST               16	/* Region list */
+#define ACPI_EXD_NODE                   17	/* Namespace Node */
 
 /* restore default alignment */
 
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index c3e419c..973fdae 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -94,12 +94,13 @@ static struct acpi_exdump_info acpi_ex_dump_buffer[5] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_buffer), NULL},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(buffer.length), "Length"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(buffer.pointer), "Pointer"},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(buffer.node), "Parent Node"},
+	{ACPI_EXD_NODE, ACPI_EXD_OFFSET(buffer.node), "Parent Node"},
 	{ACPI_EXD_BUFFER, 0, NULL}
 };
 
-static struct acpi_exdump_info acpi_ex_dump_package[5] = {
+static struct acpi_exdump_info acpi_ex_dump_package[6] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_package), NULL},
+	{ACPI_EXD_NODE, ACPI_EXD_OFFSET(package.node), "Parent Node"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(package.flags), "Flags"},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(package.count), "Elements"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(package.elements), "Element List"},
@@ -108,11 +109,11 @@ static struct acpi_exdump_info acpi_ex_dump_package[5] = {
 
 static struct acpi_exdump_info acpi_ex_dump_device[4] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_device), NULL},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(device.handler), "Handler"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(device.notify_list[0]),
 	 "System Notify"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(device.notify_list[1]),
-	 "Device Notify"}
+	 "Device Notify"},
+	{ACPI_EXD_HDLR_LIST, ACPI_EXD_OFFSET(device.handler), "Handler"}
 };
 
 static struct acpi_exdump_info acpi_ex_dump_event[2] = {
@@ -142,17 +143,18 @@ static struct acpi_exdump_info acpi_ex_dump_mutex[5] = {
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(mutex.os_mutex), "OsMutex"}
 };
 
-static struct acpi_exdump_info acpi_ex_dump_region[7] = {
+static struct acpi_exdump_info acpi_ex_dump_region[8] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_region), NULL},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(region.space_id), "Space Id"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(region.flags), "Flags"},
+	{ACPI_EXD_NODE, ACPI_EXD_OFFSET(region.node), "Parent Node"},
 	{ACPI_EXD_ADDRESS, ACPI_EXD_OFFSET(region.address), "Address"},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(region.length), "Length"},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(region.handler), "Handler"},
+	{ACPI_EXD_HDLR_LIST, ACPI_EXD_OFFSET(region.handler), "Handler"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(region.next), "Next"}
 };
 
-static struct acpi_exdump_info acpi_ex_dump_power[5] = {
+static struct acpi_exdump_info acpi_ex_dump_power[6] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_power), NULL},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(power_resource.system_level),
 	 "System Level"},
@@ -161,7 +163,8 @@ static struct acpi_exdump_info acpi_ex_dump_power[5] = {
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(power_resource.notify_list[0]),
 	 "System Notify"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(power_resource.notify_list[1]),
-	 "Device Notify"}
+	 "Device Notify"},
+	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(power_resource.handler), "Handler"}
 };
 
 static struct acpi_exdump_info acpi_ex_dump_processor[7] = {
@@ -225,7 +228,7 @@ static struct acpi_exdump_info acpi_ex_dump_reference[8] = {
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(reference.target_type), "Target Type"},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(reference.value), "Value"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(reference.object), "Object Desc"},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(reference.node), "Node"},
+	{ACPI_EXD_NODE, ACPI_EXD_OFFSET(reference.node), "Node"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(reference.where), "Where"},
 	{ACPI_EXD_REFERENCE, 0, NULL}
 };
@@ -234,16 +237,16 @@ static struct acpi_exdump_info acpi_ex_dump_address_handler[6] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_address_handler),
 	 NULL},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(address_space.space_id), "Space Id"},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(address_space.next), "Next"},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(address_space.region_list),
+	{ACPI_EXD_HDLR_LIST, ACPI_EXD_OFFSET(address_space.next), "Next"},
+	{ACPI_EXD_RGN_LIST, ACPI_EXD_OFFSET(address_space.region_list),
 	 "Region List"},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(address_space.node), "Node"},
+	{ACPI_EXD_NODE, ACPI_EXD_OFFSET(address_space.node), "Node"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(address_space.context), "Context"}
 };
 
 static struct acpi_exdump_info acpi_ex_dump_notify[7] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_notify), NULL},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(notify.node), "Node"},
+	{ACPI_EXD_NODE, ACPI_EXD_OFFSET(notify.node), "Node"},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(notify.handler_type), "Handler Type"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(notify.handler), "Handler"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(notify.context), "Context"},
@@ -252,14 +255,31 @@ static struct acpi_exdump_info acpi_ex_dump_notify[7] = {
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(notify.next[1]), "Next Device Notify"}
 };
 
+static struct acpi_exdump_info acpi_ex_dump_extra[6] = {
+	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_extra), NULL},
+	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(extra.method_REG), "_REG Method"},
+	{ACPI_EXD_NODE, ACPI_EXD_OFFSET(extra.scope_node), "Scope Node"},
+	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(extra.region_context),
+	 "Region Context"},
+	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(extra.aml_start), "Aml Start"},
+	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(extra.aml_length), "Aml Length"}
+};
+
+static struct acpi_exdump_info acpi_ex_dump_data[3] = {
+	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_data), NULL},
+	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(data.handler), "Handler"},
+	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(data.pointer), "Raw Data"}
+};
+
 /* Miscellaneous tables */
 
-static struct acpi_exdump_info acpi_ex_dump_common[4] = {
+static struct acpi_exdump_info acpi_ex_dump_common[5] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_common), NULL},
 	{ACPI_EXD_TYPE, 0, NULL},
 	{ACPI_EXD_UINT16, ACPI_EXD_OFFSET(common.reference_count),
 	 "Reference Count"},
-	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(common.flags), "Flags"}
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(common.flags), "Flags"},
+	{ACPI_EXD_LIST, ACPI_EXD_OFFSET(common.next_object), "Object List"}
 };
 
 static struct acpi_exdump_info acpi_ex_dump_field_common[7] = {
@@ -274,15 +294,17 @@ static struct acpi_exdump_info acpi_ex_dump_field_common[7] = {
 	 "Field Bit Offset"},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(common_field.base_byte_offset),
 	 "Base Byte Offset"},
-	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(common_field.node), "Parent Node"}
+	{ACPI_EXD_NODE, ACPI_EXD_OFFSET(common_field.node), "Parent Node"}
 };
 
-static struct acpi_exdump_info acpi_ex_dump_node[5] = {
+static struct acpi_exdump_info acpi_ex_dump_node[7] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_node), NULL},
 	{ACPI_EXD_UINT8, ACPI_EXD_NSOFFSET(flags), "Flags"},
 	{ACPI_EXD_UINT8, ACPI_EXD_NSOFFSET(owner_id), "Owner Id"},
-	{ACPI_EXD_POINTER, ACPI_EXD_NSOFFSET(child), "Child List"},
-	{ACPI_EXD_POINTER, ACPI_EXD_NSOFFSET(peer), "Next Peer"}
+	{ACPI_EXD_LIST, ACPI_EXD_NSOFFSET(object), "Object List"},
+	{ACPI_EXD_NODE, ACPI_EXD_NSOFFSET(parent), "Parent"},
+	{ACPI_EXD_NODE, ACPI_EXD_NSOFFSET(child), "Child"},
+	{ACPI_EXD_NODE, ACPI_EXD_NSOFFSET(peer), "Peer"}
 };
 
 /* Dispatch table, indexed by object type */
@@ -315,7 +337,9 @@ static struct acpi_exdump_info *acpi_ex_dump_info[] = {
 	acpi_ex_dump_address_handler,
 	NULL,
 	NULL,
-	NULL
+	NULL,
+	acpi_ex_dump_extra,
+	acpi_ex_dump_data
 };
 
 /*******************************************************************************
@@ -340,6 +364,10 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 	char *name;
 	const char *reference_name;
 	u8 count;
+	union acpi_operand_object *start;
+	union acpi_operand_object *data = NULL;
+	union acpi_operand_object *next;
+	struct acpi_namespace_node *node;
 
 	if (!info) {
 		acpi_os_printf
@@ -363,9 +391,9 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 
 		case ACPI_EXD_TYPE:
 
-			acpi_ex_out_string("Type",
-					   acpi_ut_get_object_type_name
-					   (obj_desc));
+			acpi_os_printf("%20s : %2.2X [%s]\n", "Type",
+				       obj_desc->common.type,
+				       acpi_ut_get_object_type_name(obj_desc));
 			break;
 
 		case ACPI_EXD_UINT8:
@@ -433,6 +461,121 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 			acpi_ex_dump_reference_obj(obj_desc);
 			break;
 
+		case ACPI_EXD_LIST:
+
+			start = *ACPI_CAST_PTR(void *, target);
+			next = start;
+
+			acpi_os_printf("%20s : %p", name, next);
+			if (next) {
+				acpi_os_printf("(%s %2.2X)",
+					       acpi_ut_get_object_type_name
+					       (next), next->common.type);
+
+				while (next->common.next_object) {
+					if ((next->common.type ==
+					     ACPI_TYPE_LOCAL_DATA) && !data) {
+						data = next;
+					}
+
+					next = next->common.next_object;
+					acpi_os_printf("->%p(%s %2.2X)", next,
+						       acpi_ut_get_object_type_name
+						       (next),
+						       next->common.type);
+
+					if ((next == start) || (next == data)) {
+						acpi_os_printf
+						    ("\n**** Error: Object list appears to be circular linked");
+						break;
+					}
+				}
+			}
+
+			acpi_os_printf("\n", next);
+			break;
+
+		case ACPI_EXD_HDLR_LIST:
+
+			start = *ACPI_CAST_PTR(void *, target);
+			next = start;
+
+			acpi_os_printf("%20s : %p", name, next);
+			if (next) {
+				acpi_os_printf("(%s %2.2X)",
+					       acpi_ut_get_object_type_name
+					       (next), next->common.type);
+
+				while (next->address_space.next) {
+					if ((next->common.type ==
+					     ACPI_TYPE_LOCAL_DATA) && !data) {
+						data = next;
+					}
+
+					next = next->address_space.next;
+					acpi_os_printf("->%p(%s %2.2X)", next,
+						       acpi_ut_get_object_type_name
+						       (next),
+						       next->common.type);
+
+					if ((next == start) || (next == data)) {
+						acpi_os_printf
+						    ("\n**** Error: Handler list appears to be circular linked");
+						break;
+					}
+				}
+			}
+
+			acpi_os_printf("\n", next);
+			break;
+
+		case ACPI_EXD_RGN_LIST:
+
+			start = *ACPI_CAST_PTR(void *, target);
+			next = start;
+
+			acpi_os_printf("%20s : %p", name, next);
+			if (next) {
+				acpi_os_printf("(%s %2.2X)",
+					       acpi_ut_get_object_type_name
+					       (next), next->common.type);
+
+				while (next->region.next) {
+					if ((next->common.type ==
+					     ACPI_TYPE_LOCAL_DATA) && !data) {
+						data = next;
+					}
+
+					next = next->region.next;
+					acpi_os_printf("->%p(%s %2.2X)", next,
+						       acpi_ut_get_object_type_name
+						       (next),
+						       next->common.type);
+
+					if ((next == start) || (next == data)) {
+						acpi_os_printf
+						    ("\n**** Error: Region list appears to be circular linked");
+						break;
+					}
+				}
+			}
+
+			acpi_os_printf("\n", next);
+			break;
+
+		case ACPI_EXD_NODE:
+
+			node =
+			    *ACPI_CAST_PTR(struct acpi_namespace_node *,
+					   target);
+
+			acpi_os_printf("%20s : %p", name, node);
+			if (node) {
+				acpi_os_printf(" [%4.4s]", node->name.ascii);
+			}
+			acpi_os_printf("\n");
+			break;
+
 		default:
 
 			acpi_os_printf("**** Invalid table opcode [%X] ****\n",
@@ -821,10 +964,8 @@ void acpi_ex_dump_namespace_node(struct acpi_namespace_node *node, u32 flags)
 	}
 
 	acpi_os_printf("%20s : %4.4s\n", "Name", acpi_ut_get_node_name(node));
-	acpi_ex_out_string("Type", acpi_ut_get_type_name(node->type));
-	acpi_ex_out_pointer("Attached Object",
-			    acpi_ns_get_attached_object(node));
-	acpi_ex_out_pointer("Parent", node->parent);
+	acpi_os_printf("%20s : %2.2X [%s]\n", "Type",
+		       node->type, acpi_ut_get_type_name(node->type));
 
 	acpi_ex_dump_object(ACPI_CAST_PTR(union acpi_operand_object, node),
 			    acpi_ex_dump_node);
@@ -1017,22 +1158,26 @@ acpi_ex_dump_object_descriptor(union acpi_operand_object *obj_desc, u32 flags)
 			       ((struct acpi_namespace_node *)obj_desc)->
 			       object);
 
-		acpi_ex_dump_object_descriptor(((struct acpi_namespace_node *)
-						obj_desc)->object, flags);
-		return_VOID;
+		obj_desc = ((struct acpi_namespace_node *)obj_desc)->object;
+		goto dump_object;
 	}
 
 	if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) != ACPI_DESC_TYPE_OPERAND) {
-		acpi_os_printf
-		    ("ExDumpObjectDescriptor: %p is not an ACPI operand object: [%s]\n",
-		     obj_desc, acpi_ut_get_descriptor_name(obj_desc));
+		acpi_os_printf("%p is not an ACPI operand object: [%s]\n",
+			       obj_desc, acpi_ut_get_descriptor_name(obj_desc));
 		return_VOID;
 	}
 
-	if (obj_desc->common.type > ACPI_TYPE_NS_NODE_MAX) {
+	/* Validate the object type */
+
+	if (obj_desc->common.type > ACPI_TYPE_LOCAL_MAX) {
+		acpi_os_printf("Not a known object type: %2.2X\n",
+			       obj_desc->common.type);
 		return_VOID;
 	}
 
+dump_object:
+
 	/* Common Fields */
 
 	acpi_ex_dump_object(obj_desc, acpi_ex_dump_common);
@@ -1040,6 +1185,22 @@ acpi_ex_dump_object_descriptor(union acpi_operand_object *obj_desc, u32 flags)
 	/* Object-specific fields */
 
 	acpi_ex_dump_object(obj_desc, acpi_ex_dump_info[obj_desc->common.type]);
+
+	if (obj_desc->common.type == ACPI_TYPE_REGION) {
+		obj_desc = obj_desc->common.next_object;
+		if (obj_desc->common.type > ACPI_TYPE_LOCAL_MAX) {
+			acpi_os_printf
+			    ("Secondary object is not a known object type: %2.2X\n",
+			     obj_desc->common.type);
+
+			return_VOID;
+		}
+
+		acpi_os_printf("\nExtra attached Object (%p):\n", obj_desc);
+		acpi_ex_dump_object(obj_desc,
+				    acpi_ex_dump_info[obj_desc->common.type]);
+	}
+
 	return_VOID;
 }
 
-- 
1.7.10

