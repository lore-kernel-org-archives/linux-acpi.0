From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/7] ACPICA: AcpiGetSleepTypeData: Allow \_Sx to return either 1 or 2 integers
Date: Fri, 25 Jan 2013 13:41:00 +0800
Message-ID: <85ad9b2d95ea3ee61f7ce7c5693e64a9b79496e9.1358825277.git.lv.zheng@intel.com>
References: <cover.1358825277.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2982 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab3AYFlN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2013 00:41:13 -0500
In-Reply-To: <cover.1358825277.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Although the ACPI spec defines the \_Sx objects to return
a package containing one integer, most BIOS code returns two
integers and the previous code reflects that. However, we also
need to support BIOS code that actually implements to the ACPI
spec, and this change implements this.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwxface.c |  125 ++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 51 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index a4bac08..04c2e16 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -440,17 +440,41 @@ ACPI_EXPORT_SYMBOL(acpi_write_bit_register)
  *              *sleep_type_a        - Where SLP_TYPa is returned
  *              *sleep_type_b        - Where SLP_TYPb is returned
  *
- * RETURN:      status - ACPI status
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Obtain the SLP_TYPa and SLP_TYPb values for the requested
+ *              sleep state via the appropriate \_Sx object.
+ *
+ *  The sleep state package returned from the corresponding \_Sx_ object
+ *  must contain at least one integer.
+ *
+ *  March 2005:
+ *  Added support for a package that contains two integers. This
+ *  goes against the ACPI specification which defines this object as a
+ *  package with one encoded DWORD integer. However, existing practice
+ *  by many BIOS vendors is to return a package with 2 or more integer
+ *  elements, at least one per sleep type (A/B).
  *
- * DESCRIPTION: Obtain the SLP_TYPa and SLP_TYPb values for the requested sleep
- *              state.
+ *  January 2013:
+ *  Therefore, we must be prepared to accept a package with either a
+ *  single integer or multiple integers.
+ *
+ *  The single integer DWORD format is as follows:
+ *      BYTE 0 - Value for the PM1A SLP_TYP register
+ *      BYTE 1 - Value for the PM1B SLP_TYP register
+ *      BYTE 2-3 - Reserved
+ *
+ *  The dual integer format is as follows:
+ *      Integer 0 - Value for the PM1A SLP_TYP register
+ *      Integer 1 - Value for the PM1A SLP_TYP register
  *
  ******************************************************************************/
 acpi_status
 acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
 	struct acpi_evaluate_info *info;
+	union acpi_operand_object **elements;
 
 	ACPI_FUNCTION_TRACE(acpi_get_sleep_type_data);
 
@@ -467,18 +491,14 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
+	/*
+	 * Evaluate the \_Sx namespace object containing the register values
+	 * for this state
+	 */
 	info->pathname =
 	    ACPI_CAST_PTR(char, acpi_gbl_sleep_state_names[sleep_state]);
-
-	/* Evaluate the namespace object containing the values for this state */
-
 	status = acpi_ns_evaluate(info);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "%s while evaluating SleepState [%s]\n",
-				  acpi_format_exception(status),
-				  info->pathname));
-
 		goto cleanup;
 	}
 
@@ -487,64 +507,67 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 	if (!info->return_object) {
 		ACPI_ERROR((AE_INFO, "No Sleep State object returned from [%s]",
 			    info->pathname));
-		status = AE_NOT_EXIST;
+		status = AE_AML_NO_RETURN_VALUE;
+		goto cleanup;
 	}
 
-	/* It must be of type Package */
+	/* Return object must be of type Package */
 
-	else if (info->return_object->common.type != ACPI_TYPE_PACKAGE) {
+	if (info->return_object->common.type != ACPI_TYPE_PACKAGE) {
 		ACPI_ERROR((AE_INFO,
 			    "Sleep State return object is not a Package"));
 		status = AE_AML_OPERAND_TYPE;
+		goto cleanup1;
 	}
 
 	/*
-	 * The package must have at least two elements. NOTE (March 2005): This
-	 * goes against the current ACPI spec which defines this object as a
-	 * package with one encoded DWORD element. However, existing practice
-	 * by BIOS vendors seems to be to have 2 or more elements, at least
-	 * one per sleep type (A/B).
+	 * Any warnings about the package length or the object types have
+	 * already been issued by the predefined name module -- there is no
+	 * need to repeat them here.
 	 */
-	else if (info->return_object->package.count < 2) {
-		ACPI_ERROR((AE_INFO,
-			    "Sleep State return package does not have at least two elements"));
-		status = AE_AML_NO_OPERAND;
-	}
+	elements = info->return_object->package.elements;
+	switch (info->return_object->package.count) {
+	case 0:
+		status = AE_AML_PACKAGE_LIMIT;
+		break;
+
+	case 1:
+		if (elements[0]->common.type != ACPI_TYPE_INTEGER) {
+			status = AE_AML_OPERAND_TYPE;
+			break;
+		}
 
-	/* The first two elements must both be of type Integer */
+		/* A valid _Sx_ package with one integer */
 
-	else if (((info->return_object->package.elements[0])->common.type
-		  != ACPI_TYPE_INTEGER) ||
-		 ((info->return_object->package.elements[1])->common.type
-		  != ACPI_TYPE_INTEGER)) {
-		ACPI_ERROR((AE_INFO,
-			    "Sleep State return package elements are not both Integers "
-			    "(%s, %s)",
-			    acpi_ut_get_object_type_name(info->return_object->
-							 package.elements[0]),
-			    acpi_ut_get_object_type_name(info->return_object->
-							 package.elements[1])));
-		status = AE_AML_OPERAND_TYPE;
-	} else {
-		/* Valid _Sx_ package size, type, and value */
+		*sleep_type_a = (u8)elements[0]->integer.value;
+		*sleep_type_b = (u8)(elements[0]->integer.value >> 8);
+		break;
 
-		*sleep_type_a = (u8)
-		    (info->return_object->package.elements[0])->integer.value;
-		*sleep_type_b = (u8)
-		    (info->return_object->package.elements[1])->integer.value;
-	}
+	case 2:
+	default:
+		if ((elements[0]->common.type != ACPI_TYPE_INTEGER) ||
+		    (elements[1]->common.type != ACPI_TYPE_INTEGER)) {
+			status = AE_AML_OPERAND_TYPE;
+			break;
+		}
 
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"While evaluating SleepState [%s], bad Sleep object %p type %s",
-				info->pathname, info->return_object,
-				acpi_ut_get_object_type_name(info->
-							     return_object)));
+		/* A valid _Sx_ package with two integers */
+
+		*sleep_type_a = (u8)elements[0]->integer.value;
+		*sleep_type_b = (u8)elements[1]->integer.value;
+		break;
 	}
 
+      cleanup1:
 	acpi_ut_remove_reference(info->return_object);
 
       cleanup:
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"While evaluating Sleep State [%s]",
+				info->pathname));
+	}
+
 	ACPI_FREE(info);
 	return_ACPI_STATUS(status);
 }
-- 
1.7.10

