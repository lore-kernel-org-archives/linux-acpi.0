From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/15] ACPICA: Debugger: Improve support for Alias objects
Date: Thu,  3 Aug 2017 14:27:15 +0800
Message-ID: <67ebcae9420730756e13fb88405db0d39c6a17d1.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:51154 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdHCG1T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:27:19 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 916993dbcd45b46e01f6c9b8337a01513f5d8dcc

Properly resolve alias objects for display.
General cleanup of related output.

Link: https://github.com/acpica/acpica/commit/916993db
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbdisply.c | 37 ++++++++++++++++++++++++++++++++-----
 drivers/acpi/acpica/exdump.c   | 34 ++++++++++++++++++++++++++--------
 2 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index 46bf270..5a606ea 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -310,7 +310,7 @@ void acpi_db_decode_and_display_object(char *target, char *output_type)
 	}
 
 	else {
-		acpi_os_printf("Object (%p) Pathname: %s\n",
+		acpi_os_printf("Object %p: Namespace Node - Pathname: %s\n",
 			       node, (char *)ret_buf.pointer);
 	}
 
@@ -326,7 +326,7 @@ void acpi_db_decode_and_display_object(char *target, char *output_type)
 
 	obj_desc = acpi_ns_get_attached_object(node);
 	if (obj_desc) {
-		acpi_os_printf("\nAttached Object (%p):\n", obj_desc);
+		acpi_os_printf("\nAttached Object %p:", obj_desc);
 		if (!acpi_os_readable
 		    (obj_desc, sizeof(union acpi_operand_object))) {
 			acpi_os_printf
@@ -335,9 +335,36 @@ void acpi_db_decode_and_display_object(char *target, char *output_type)
 			return;
 		}
 
-		acpi_ut_debug_dump_buffer((void *)obj_desc,
-					  sizeof(union acpi_operand_object),
-					  display, ACPI_UINT32_MAX);
+		if (ACPI_GET_DESCRIPTOR_TYPE(((struct acpi_namespace_node *)
+					      obj_desc)) ==
+		    ACPI_DESC_TYPE_NAMED) {
+			acpi_os_printf(" Namespace Node - ");
+			status =
+			    acpi_get_name((struct acpi_namespace_node *)
+					  obj_desc,
+					  ACPI_FULL_PATHNAME_NO_TRAILING,
+					  &ret_buf);
+			if (ACPI_FAILURE(status)) {
+				acpi_os_printf
+				    ("Could not convert name to pathname\n");
+			} else {
+				acpi_os_printf("Pathname: %s",
+					       (char *)ret_buf.pointer);
+			}
+
+			acpi_os_printf("\n");
+			acpi_ut_debug_dump_buffer((void *)obj_desc,
+						  sizeof(struct
+							 acpi_namespace_node),
+						  display, ACPI_UINT32_MAX);
+		} else {
+			acpi_os_printf("\n");
+			acpi_ut_debug_dump_buffer((void *)obj_desc,
+						  sizeof(union
+							 acpi_operand_object),
+						  display, ACPI_UINT32_MAX);
+		}
+
 		acpi_ex_dump_object_descriptor(obj_desc, 1);
 	}
 }
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 44092f7..83398dc 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -102,7 +102,7 @@ static struct acpi_exdump_info acpi_ex_dump_package[6] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_package), NULL},
 	{ACPI_EXD_NODE, ACPI_EXD_OFFSET(package.node), "Parent Node"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(package.flags), "Flags"},
-	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(package.count), "Elements"},
+	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(package.count), "Element Count"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(package.elements), "Element List"},
 	{ACPI_EXD_PACKAGE, 0, NULL}
 };
@@ -384,6 +384,10 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 	count = info->offset;
 
 	while (count) {
+		if (!obj_desc) {
+			return;
+		}
+
 		target = ACPI_ADD_PTR(u8, obj_desc, info->offset);
 		name = info->name;
 
@@ -469,9 +473,9 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 			start = *ACPI_CAST_PTR(void *, target);
 			next = start;
 
-			acpi_os_printf("%20s : %p", name, next);
+			acpi_os_printf("%20s : %p ", name, next);
 			if (next) {
-				acpi_os_printf("(%s %2.2X)",
+				acpi_os_printf("%s (Type %2.2X)",
 					       acpi_ut_get_object_type_name
 					       (next), next->common.type);
 
@@ -493,6 +497,8 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 						break;
 					}
 				}
+			} else {
+				acpi_os_printf("- No attached objects");
 			}
 
 			acpi_os_printf("\n");
@@ -1129,7 +1135,9 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 
 	default:
 
-		acpi_os_printf("[Unknown Type] %X\n", obj_desc->common.type);
+		acpi_os_printf("[%s] Type: %2.2X\n",
+			       acpi_ut_get_type_name(obj_desc->common.type),
+			       obj_desc->common.type);
 		break;
 	}
 }
@@ -1167,11 +1175,17 @@ acpi_ex_dump_object_descriptor(union acpi_operand_object *obj_desc, u32 flags)
 		acpi_ex_dump_namespace_node((struct acpi_namespace_node *)
 					    obj_desc, flags);
 
-		acpi_os_printf("\nAttached Object (%p):\n",
-			       ((struct acpi_namespace_node *)obj_desc)->
-			       object);
-
 		obj_desc = ((struct acpi_namespace_node *)obj_desc)->object;
+		if (!obj_desc) {
+			return_VOID;
+		}
+
+		acpi_os_printf("\nAttached Object %p", obj_desc);
+		if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) == ACPI_DESC_TYPE_NAMED) {
+			acpi_os_printf(" - Namespace Node");
+		}
+
+		acpi_os_printf(":\n");
 		goto dump_object;
 	}
 
@@ -1191,6 +1205,10 @@ acpi_ex_dump_object_descriptor(union acpi_operand_object *obj_desc, u32 flags)
 
 dump_object:
 
+	if (!obj_desc) {
+		return_VOID;
+	}
+
 	/* Common Fields */
 
 	acpi_ex_dump_object(obj_desc, acpi_ex_dump_common);
-- 
2.7.4

