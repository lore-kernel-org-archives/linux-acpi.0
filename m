From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/42] ACPICA: Namespace: Add scope information to the simple object repair mechanism
Date: Tue, 29 Dec 2015 13:57:38 +0800
Message-ID: <266ec49a71ad7b372a8fabb1e12888219ebd4735.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54361 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362AbbL2F5n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 00:57:43 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 51cbd324420ca5e381cb2c57ce95139053518a35

The acpi_object_converter callbacks are lack in scope information to
convert name_string. This patch fixes this issue by passing the evaluation
method/object node to the converter callbacks. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/51cbd324
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/aclocal.h   |    3 ++-
 drivers/acpi/acpica/acnamesp.h  |    6 ++++--
 drivers/acpi/acpica/nsconvert.c |   12 ++++++++----
 drivers/acpi/acpica/nsrepair.c  |    4 ++--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 4fd5040..351a1cd 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -395,7 +395,8 @@ union acpi_predefined_info {
 
 /* Return object auto-repair info */
 
-typedef acpi_status(*acpi_object_converter) (union acpi_operand_object
+typedef acpi_status(*acpi_object_converter) (struct acpi_namespace_node * scope,
+					     union acpi_operand_object
 					     *original_object,
 					     union acpi_operand_object
 					     **converted_object);
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 5d261c9..1f42c3c 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -183,11 +183,13 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
 			  union acpi_operand_object **return_object);
 
 acpi_status
-acpi_ns_convert_to_unicode(union acpi_operand_object *original_object,
+acpi_ns_convert_to_unicode(struct acpi_namespace_node *scope,
+			   union acpi_operand_object *original_object,
 			   union acpi_operand_object **return_object);
 
 acpi_status
-acpi_ns_convert_to_resource(union acpi_operand_object *original_object,
+acpi_ns_convert_to_resource(struct acpi_namespace_node *scope,
+			    union acpi_operand_object *original_object,
 			    union acpi_operand_object **return_object);
 
 /*
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index 749a189..ab47a50 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -306,7 +306,8 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
  *
  * FUNCTION:    acpi_ns_convert_to_unicode
  *
- * PARAMETERS:  original_object     - ASCII String Object to be converted
+ * PARAMETERS:  scope               - Namespace node for the method/object
+ *              original_object     - ASCII String Object to be converted
  *              return_object       - Where the new converted object is returned
  *
  * RETURN:      Status. AE_OK if conversion was successful.
@@ -316,7 +317,8 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_convert_to_unicode(union acpi_operand_object *original_object,
+acpi_ns_convert_to_unicode(struct acpi_namespace_node * scope,
+			   union acpi_operand_object *original_object,
 			   union acpi_operand_object **return_object)
 {
 	union acpi_operand_object *new_object;
@@ -370,7 +372,8 @@ acpi_ns_convert_to_unicode(union acpi_operand_object *original_object,
  *
  * FUNCTION:    acpi_ns_convert_to_resource
  *
- * PARAMETERS:  original_object     - Object to be converted
+ * PARAMETERS:  scope               - Namespace node for the method/object
+ *              original_object     - Object to be converted
  *              return_object       - Where the new converted object is returned
  *
  * RETURN:      Status. AE_OK if conversion was successful
@@ -381,7 +384,8 @@ acpi_ns_convert_to_unicode(union acpi_operand_object *original_object,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_convert_to_resource(union acpi_operand_object *original_object,
+acpi_ns_convert_to_resource(struct acpi_namespace_node * scope,
+			    union acpi_operand_object *original_object,
 			    union acpi_operand_object **return_object)
 {
 	union acpi_operand_object *new_object;
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 360e3ab..4b7dbff 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -172,8 +172,8 @@ acpi_ns_simple_repair(struct acpi_evaluate_info *info,
 					      "Missing expected return value"));
 		}
 
-		status =
-		    predefined->object_converter(return_object, &new_object);
+		status = predefined->object_converter(info->node, return_object,
+						      &new_object);
 		if (ACPI_FAILURE(status)) {
 
 			/* A fatal error occurred during a conversion */
-- 
1.7.10

