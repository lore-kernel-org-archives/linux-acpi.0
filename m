From: Len Brown <lenb@kernel.org>
Subject: [PATCH 67/73] ACPICA: Fixes for external Reference Objects
Date: Sat, 12 Apr 2008 00:25:50 -0400
Message-ID: <ac9f1f2204eb7bd93d0fc3d23c42e2385131c302.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:60403 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755710AbYDLE2P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:15 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

All Reference Objects returned via the AcpiEvaluteObject interface
are now marked as type "REFERENCE" instead of "ANY". The type ANY
is now reservered for NULL objects - either NULL package elements
or unresolved named references.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utcopy.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

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
-- 
1.5.5.29.g7134

