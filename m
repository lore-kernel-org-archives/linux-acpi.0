From: Len Brown <lenb@kernel.org>
Subject: [PATCH 093/122] ACPICA: Add function to decode reference obj types to
 strings
Date: Thu, 23 Oct 2008 02:39:07 -0400
Message-ID: <f02a99ac66748f8b62477c86f6df04d3ec6169fd.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58094 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbYJWGk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600JW3IJ4BNY9@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:17 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Created for improved error messages.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utglobal.c |   36 ++++++++++++++++++++++++++++++++++++
 include/acpi/acutils.h            |    2 ++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 248eefc..bcace57 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -45,6 +45,7 @@
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
+#include <acpi/amlcode.h>
 
 ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 #define _COMPONENT          ACPI_UTILITIES
@@ -575,6 +576,41 @@ char *acpi_ut_get_descriptor_name(void *object)
 
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_get_reference_name
+ *
+ * PARAMETERS:  Object               - An ACPI reference object
+ *
+ * RETURN:      Pointer to a string
+ *
+ * DESCRIPTION: Decode a reference object sub-type to a string.
+ *
+ ******************************************************************************/
+
+/* Printable names of reference object sub-types */
+
+const char *acpi_ut_get_reference_name(union acpi_operand_object *object)
+{
+
+	switch (object->reference.opcode) {
+	case AML_INT_NAMEPATH_OP:
+		return "Name";
+
+	case AML_LOAD_OP:
+		return "DDB-Handle";
+
+	case AML_REF_OF_OP:
+		return "RefOf";
+
+	case AML_INDEX_OP:
+		return "Index";
+
+	default:
+		return "Unknown";
+	}
+}
+
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
 /*
  * Strings and procedures used for debug only
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index 10ce814..d8307b2 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -126,6 +126,8 @@ char *acpi_ut_get_node_name(void *object);
 
 char *acpi_ut_get_descriptor_name(void *object);
 
+const char *acpi_ut_get_reference_name(union acpi_operand_object *object);
+
 char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc);
 
 char *acpi_ut_get_region_name(u8 space_id);
-- 
1.5.5.1

