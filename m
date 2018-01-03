From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 10/12] ACPICA: Fix a couple memory leaks during package object resolution
Date: Wed,  3 Jan 2018 15:06:29 -0800
Message-ID: <20180103230631.15939-11-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43375 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeACXHn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:43 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 69d4415360446b4a1826dab76ba0cd6d24710ddd

A couple memory leaks during resolution of individual
package elements.

Link: https://github.com/acpica/acpica/commit/69d44153
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/dspkginit.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/dspkginit.c b/drivers/acpi/acpica/dspkginit.c
index 6d487edfe2de..5a602b75084e 100644
--- a/drivers/acpi/acpica/dspkginit.c
+++ b/drivers/acpi/acpica/dspkginit.c
@@ -297,8 +297,10 @@ acpi_ds_init_package_element(u8 object_type,
 {
 	union acpi_operand_object **element_ptr;
 
+	ACPI_FUNCTION_TRACE(ds_init_package_element);
+
 	if (!source_object) {
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/*
@@ -329,7 +331,7 @@ acpi_ds_init_package_element(u8 object_type,
 		source_object->package.flags |= AOPOBJ_DATA_VALID;
 	}
 
-	return (AE_OK);
+	return_ACPI_STATUS(AE_OK);
 }
 
 /*******************************************************************************
@@ -352,6 +354,7 @@ acpi_ds_resolve_package_element(union acpi_operand_object **element_ptr)
 	union acpi_generic_state scope_info;
 	union acpi_operand_object *element = *element_ptr;
 	struct acpi_namespace_node *resolved_node;
+	struct acpi_namespace_node *original_node;
 	char *external_path = NULL;
 	acpi_object_type type;
 
@@ -441,6 +444,7 @@ acpi_ds_resolve_package_element(union acpi_operand_object **element_ptr)
 	 * will remain as named references. This behavior is not described
 	 * in the ACPI spec, but it appears to be an oversight.
 	 */
+	original_node = resolved_node;
 	status = acpi_ex_resolve_node_to_value(&resolved_node, NULL);
 	if (ACPI_FAILURE(status)) {
 		return_VOID;
@@ -468,26 +472,27 @@ acpi_ds_resolve_package_element(union acpi_operand_object **element_ptr)
 		 */
 	case ACPI_TYPE_DEVICE:
 	case ACPI_TYPE_THERMAL:
-
-		/* TBD: This may not be necesssary */
-
-		acpi_ut_add_reference(resolved_node->object);
+	case ACPI_TYPE_METHOD:
 		break;
 
 	case ACPI_TYPE_MUTEX:
-	case ACPI_TYPE_METHOD:
 	case ACPI_TYPE_POWER:
 	case ACPI_TYPE_PROCESSOR:
 	case ACPI_TYPE_EVENT:
 	case ACPI_TYPE_REGION:
 
+		/* acpi_ex_resolve_node_to_value gave these an extra reference */
+
+		acpi_ut_remove_reference(original_node->object);
 		break;
 
 	default:
 		/*
 		 * For all other types - the node was resolved to an actual
-		 * operand object with a value, return the object
+		 * operand object with a value, return the object. Remove
+		 * a reference on the existing object.
 		 */
+		acpi_ut_remove_reference(element);
 		*element_ptr = (union acpi_operand_object *)resolved_node;
 		break;
 	}
-- 
2.14.3

