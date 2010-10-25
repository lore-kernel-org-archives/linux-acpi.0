From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/60] ACPICA: Eliminate duplicate code in acpi_ut_execute_*
 functions
Date: Mon, 25 Oct 2010 02:20:39 -0400
Message-ID: <34cf66e724a2bf0a406d59b18f5bfeed746d7979.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38309 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab0JYJLF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:05 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:04 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Now that the nsrepair code automatically repairs _HID-related
strings, this type of code is no longer needed in acpi_ut_execute_HID,
acpi_ut_execute_CID, and acpi_ut_execute_UID. ACPICA BZ 878.

http://www.acpica.org/bugzilla/show_bug.cgi?id=878

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utids.c |   45 +++---------------------------------------
 1 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 1397fad..d290632 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -48,42 +48,6 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utids")
 
-/* Local prototypes */
-static void acpi_ut_copy_id_string(char *destination, char *source);
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_copy_id_string
- *
- * PARAMETERS:  Destination         - Where to copy the string
- *              Source              - Source string
- *
- * RETURN:      None
- *
- * DESCRIPTION: Copies an ID string for the _HID, _CID, and _UID methods.
- *              Performs removal of a leading asterisk if present -- workaround
- *              for a known issue on a bunch of machines.
- *
- ******************************************************************************/
-
-static void acpi_ut_copy_id_string(char *destination, char *source)
-{
-
-	/*
-	 * Workaround for ID strings that have a leading asterisk. This construct
-	 * is not allowed by the ACPI specification  (ID strings must be
-	 * alphanumeric), but enough existing machines have this embedded in their
-	 * ID strings that the following code is useful.
-	 */
-	if (*source == '*') {
-		source++;
-	}
-
-	/* Do the actual copy */
-
-	ACPI_STRCPY(destination, source);
-}
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_execute_HID
@@ -101,7 +65,6 @@ static void acpi_ut_copy_id_string(char *destination, char *source)
  *              NOTE: Internal function, no parameter validation
  *
  ******************************************************************************/
-
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
 		    struct acpica_device_id **return_id)
@@ -147,7 +110,7 @@ acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
 	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 		acpi_ex_eisa_id_to_string(hid->string, obj_desc->integer.value);
 	} else {
-		acpi_ut_copy_id_string(hid->string, obj_desc->string.pointer);
+		ACPI_STRCPY(hid->string, obj_desc->string.pointer);
 	}
 
 	hid->length = length;
@@ -224,7 +187,7 @@ acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
 	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 		acpi_ex_integer_to_string(uid->string, obj_desc->integer.value);
 	} else {
-		acpi_ut_copy_id_string(uid->string, obj_desc->string.pointer);
+		ACPI_STRCPY(uid->string, obj_desc->string.pointer);
 	}
 
 	uid->length = length;
@@ -357,8 +320,8 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 
 			/* Copy the String CID from the returned object */
 
-			acpi_ut_copy_id_string(next_id_string,
-					       cid_objects[i]->string.pointer);
+			ACPI_STRCPY(next_id_string,
+				    cid_objects[i]->string.pointer);
 			length = cid_objects[i]->string.length + 1;
 		}
 
-- 
1.7.3.2.90.gd4c43

