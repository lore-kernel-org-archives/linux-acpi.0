From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/10] ACPICA: iASL/Disassembler: Add support for hardware summary mapfiles.
Date: Fri, 10 Oct 2014 10:40:11 +0800
Message-ID: <fc23e112b2104f59f922a164efc18b89587952dd.1412907188.git.lv.zheng@intel.com>
References: <cover.1412907188.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48088 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaJJCkT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2014 22:40:19 -0400
In-Reply-To: <cover.1412907188.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Adds support for both iASL and the disassembler to create a hardware
and connection summary mapfile (via the -lm option.)

Linux isn't affected by this patch because iASL is not in the Linux
upstream.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/amlresrc.h |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index f3f8344..3a0beeb 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -117,6 +117,12 @@ struct asl_resource_node {
 	struct asl_resource_node *next;
 };
 
+struct asl_resource_info {
+	union acpi_parse_object *descriptor_type_op;	/* Resource descriptor parse node */
+	union acpi_parse_object *mapping_op;	/* Used for mapfile support */
+	u32 current_byte_offset;	/* Offset in resource template */
+};
+
 /* Macros used to generate AML resource length fields */
 
 #define ACPI_AML_SIZE_LARGE(r)      (sizeof (r) - sizeof (struct aml_resource_large_header))
@@ -449,4 +455,32 @@ union aml_resource {
 	u8 byte_item;
 };
 
+/* Interfaces used by both the disassembler and compiler */
+
+void
+mp_save_gpio_info(union acpi_parse_object *op,
+		  union aml_resource *resource,
+		  u32 pin_count, u16 *pin_list, char *device_name);
+
+void
+mp_save_serial_info(union acpi_parse_object *op,
+		    union aml_resource *resource, char *device_name);
+
+char *mp_get_hid_from_parse_tree(struct acpi_namespace_node *hid_node);
+
+char *mp_get_hid_via_namestring(char *device_name);
+
+char *mp_get_connection_info(union acpi_parse_object *op,
+			     u32 pin_index,
+			     struct acpi_namespace_node **target_node,
+			     char **target_name);
+
+char *mp_get_parent_device_hid(union acpi_parse_object *op,
+			       struct acpi_namespace_node **target_node,
+			       char **parent_device_name);
+
+char *mp_get_ddn_value(char *device_name);
+
+char *mp_get_hid_value(struct acpi_namespace_node *device_node);
+
 #endif
-- 
1.7.10

