From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/4] Reduce regression between ACPICA fix and Linux upstream
Date: Fri, 15 Jan 2016 08:16:57 +0800
Message-ID: <22e986677e5f026782a415d1f574733c25b2ad97.1452741211.git.lv.zheng@intel.com>
References: <cover.1452741211.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1452741211.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Linux has been fixed during 20151218 release cycle by reverting wrong code
in the following commit:
  ACPICA commit: 071eff738c59eda1792ac24b3b688b61691d7e7c
  Subject: Add per-table execution of module-level code, early region
           handlers
While upstream ACPICA fixes later in the following commit:
  ACPICA commit: bf6cfddb4784c349f781758981b207253b5a1252
  Subject: Fix for module-level-code regression introduced in 20151218

This results in the divergences and this patch is meant to reduce such
divergences. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nseval.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 15e0b2e..28dc7e6 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -418,7 +418,8 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 	 * Get the parent node. We cheat by using the next_object field
 	 * of the method object descriptor.
 	 */
-	parent_node = ACPI_CAST_PTR(struct acpi_namespace_node,
+	parent_node =
+	    ACPI_CAST_PTR(struct acpi_namespace_node,
 				    method_obj->method.next_object);
 	type = acpi_ns_get_type(parent_node);
 
@@ -444,9 +445,9 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 	info->prefix_node = parent_node;
 
 	/*
-	 * Get the currently attached parent object. Add a reference, because the
-	 * ref count will be decreased when the method object is installed to
-	 * the parent node.
+	 * Get the currently attached parent object. Add a reference,
+	 * because the ref count will be decreased when the method object
+	 * is installed to the parent node.
 	 */
 	parent_obj = acpi_ns_get_attached_object(parent_node);
 	if (parent_obj) {
@@ -455,8 +456,8 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 
 	/* Install the method (module-level code) in the parent node */
 
-	status = acpi_ns_attach_object(parent_node, method_obj,
-				       ACPI_TYPE_METHOD);
+	status =
+	    acpi_ns_attach_object(parent_node, method_obj, ACPI_TYPE_METHOD);
 	if (ACPI_FAILURE(status)) {
 		goto exit;
 	}
-- 
1.7.10
