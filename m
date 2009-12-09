From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/14] ACPICA: Add repair for bad _BIF/_BIX packages
Date: Wed, 09 Dec 2009 12:22:02 -0500
Message-ID: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:52594 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZLIRW0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:22:26 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE004NYAX5R3JB@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:22:23 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add a repair for the "Oem Information" field which is often
mistakenly returned as an integer. It should always be a string.
ACPICA BZ 807.

http://www.acpica.org/bugzilla/show_bug.cgi?id=807

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsrepair.c |   91 ++++++++++++++++++++++++++++-----------
 1 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index db2b2a9..dfa31c5 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -77,6 +77,11 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 	union acpi_operand_object *new_object;
 	acpi_size length;
 
+	/*
+	 * At this point, we know that the type of the returned object was not
+	 * one of the expected types for this predefined name. Attempt to
+	 * repair the object. Only a limited number of repairs are possible.
+	 */
 	switch (return_object->common.type) {
 	case ACPI_TYPE_BUFFER:
 
@@ -111,43 +116,77 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 		 */
 		ACPI_MEMCPY(new_object->string.pointer,
 			    return_object->buffer.pointer, length);
+		break;
 
-		/*
-		 * If the original object is a package element, we need to:
-		 * 1. Set the reference count of the new object to match the
-		 *    reference count of the old object.
-		 * 2. Decrement the reference count of the original object.
-		 */
-		if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
-			new_object->common.reference_count =
-			    return_object->common.reference_count;
+	case ACPI_TYPE_INTEGER:
+
+		/* Does the method/object legally return a string? */
 
-			if (return_object->common.reference_count > 1) {
-				return_object->common.reference_count--;
+		if (expected_btypes & ACPI_RTYPE_STRING) {
+			/*
+			 * The only supported Integer-to-String conversion is to convert
+			 * an integer of value 0 to a NULL string. The last element of
+			 * _BIF and _BIX packages occasionally need this fix.
+			 */
+			if (return_object->integer.value != 0) {
+				return (AE_AML_OPERAND_TYPE);
 			}
 
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
-					      data->node_flags,
-					      "Converted Buffer to expected String at index %u",
-					      package_index));
+			/* Allocate a new NULL string object */
+
+			new_object = acpi_ut_create_string_object(0);
+			if (!new_object) {
+				return (AE_NO_MEMORY);
+			}
 		} else {
-			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
-					      data->node_flags,
-					      "Converted Buffer to expected String"));
+			return (AE_AML_OPERAND_TYPE);
 		}
+		break;
 
-		/* Delete old object, install the new return object */
+	default:
 
-		acpi_ut_remove_reference(return_object);
-		*return_object_ptr = new_object;
-		data->flags |= ACPI_OBJECT_REPAIRED;
-		return (AE_OK);
+		/* We cannot repair this object */
 
-	default:
-		break;
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	/* Object was successfully repaired */
+
+	/*
+	 * If the original object is a package element, we need to:
+	 * 1. Set the reference count of the new object to match the
+	 *    reference count of the old object.
+	 * 2. Decrement the reference count of the original object.
+	 */
+	if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
+		new_object->common.reference_count =
+		    return_object->common.reference_count;
+
+		if (return_object->common.reference_count > 1) {
+			return_object->common.reference_count--;
+		}
+
+		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Converted %s to expected %s at index %u",
+				      acpi_ut_get_object_type_name
+				      (return_object),
+				      acpi_ut_get_object_type_name(new_object),
+				      package_index));
+	} else {
+		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "Converted %s to expected %s",
+				      acpi_ut_get_object_type_name
+				      (return_object),
+				      acpi_ut_get_object_type_name
+				      (new_object)));
 	}
 
-	return (AE_AML_OPERAND_TYPE);
+	/* Delete old object, install the new return object */
+
+	acpi_ut_remove_reference(return_object);
+	*return_object_ptr = new_object;
+	data->flags |= ACPI_OBJECT_REPAIRED;
+	return (AE_OK);
 }
 
 /*******************************************************************************
-- 
1.6.0.6

