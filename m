From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 67/73] ACPICA: Fixes for external Reference Objects
Date: Tue, 22 Apr 2008 19:15:38 -0400
Message-ID: <200804221915.38530.lenb@kernel.org>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <ac9f1f2204eb7bd93d0fc3d23c42e2385131c302.1207973800.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37128 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbYDVXP6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2008 19:15:58 -0400
In-Reply-To: <ac9f1f2204eb7bd93d0fc3d23c42e2385131c302.1207973800.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Lin Ming <ming.m.lin@intel.com>

commit cd0b2248241f4146152fb04a6bf4bccb6ce0478a
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Apr 10 19:06:43 2008 +0400

ACPICA: Fixes for external Reference Objects
    
All Reference Objects returned via the AcpiEvaluteObject interface
are now marked as type "REFERENCE" instead of "ANY". The type ANY
is now reservered for NULL objects - either NULL package elements
or unresolved named references.
    
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>

---
updated patch:
utils.c update from Alexey Starikovskiy
scan.c update from Lin Ming:

 scan.c             |    3 +--
 utilities/utcopy.c |   32 ++++++++++++++++++++++++--------
 utils.c            |    2 +-
 3 files changed, 26 insertions(+), 11 deletions(-)


diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e6ce262..464ee6e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -677,9 +677,8 @@ acpi_bus_extract_wakeup_device_power_package(struct acpi_device *device,
 	device->wakeup.resources.count = package->package.count - 2;
 	for (i = 0; i < device->wakeup.resources.count; i++) {
 		element = &(package->package.elements[i + 2]);
-		if (element->type != ACPI_TYPE_ANY) {
+		if (element->type != ACPI_TYPE_LOCAL_REFERENCE)
 			return AE_BAD_DATA;
-		}
 
 		device->wakeup.resources.handles[i] = element->reference.handle;
 	}
diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/utilities/utcopy.c
index 4e9a62b..2a57c2c 100644
--- a/drivers/acpi/utilities/utcopy.c
+++ b/drivers/acpi/utilities/utcopy.c
@@ -43,6 +43,8 @@
 
 #include <acpi/acpi.h>
 #include <acpi/amlcode.h>
+#include <acpi/acnamesp.h>
+
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utcopy")
@@ -172,22 +174,21 @@ acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
 
-		/*
-		 * This is an object reference.  Attempt to dereference it.
-		 */
+		/* This is an object reference. */
+
 		switch (internal_object->reference.opcode) {
 		case AML_INT_NAMEPATH_OP:
 
 			/* For namepath, return the object handle ("reference") */
 
 		default:
-			/*
-			 * Use the object type of "Any" to indicate a reference
-			 * to object containing a handle to an ACPI named object.
-			 */
-			external_object->type = ACPI_TYPE_ANY;
+
+			/* We are referring to the namespace node */
+
 			external_object->reference.handle =
 			    internal_object->reference.node;
+			external_object->reference.actual_type =
+			    acpi_ns_get_type(internal_object->reference.node);
 			break;
 		}
 		break;
@@ -460,6 +461,7 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 	case ACPI_TYPE_STRING:
 	case ACPI_TYPE_BUFFER:
 	case ACPI_TYPE_INTEGER:
+	case ACPI_TYPE_LOCAL_REFERENCE:
 
 		internal_object = acpi_ut_create_internal_object((u8)
 								 external_object->
@@ -469,6 +471,11 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 		}
 		break;
 
+	case ACPI_TYPE_ANY:	/* This is the case for a NULL object */
+
+		*ret_internal_object = NULL;
+		return_ACPI_STATUS(AE_OK);
+
 	default:
 		/* All other types are not supported */
 
@@ -522,6 +529,15 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 		internal_object->integer.value = external_object->integer.value;
 		break;
 
+	case ACPI_TYPE_LOCAL_REFERENCE:
+
+		/* TBD: should validate incoming handle */
+
+		internal_object->reference.opcode = AML_INT_NAMEPATH_OP;
+		internal_object->reference.node =
+		    external_object->reference.handle;
+		break;
+
 	default:
 		/* Other types can't get here */
 		break;
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 44ea60c..1009261 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -398,7 +398,7 @@ acpi_evaluate_reference(acpi_handle handle,
 
 		element = &(package->package.elements[i]);
 
-		if (element->type != ACPI_TYPE_ANY) {
+		if (element->type != ACPI_TYPE_LOCAL_REFERENCE) {
 			status = AE_BAD_DATA;
 			printk(KERN_ERR PREFIX
 				    "Expecting a [Reference] package element, found type %X\n",
