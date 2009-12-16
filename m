From: Len Brown <lenb@kernel.org>
Subject: [PATCH 067/103] ACPICA: Update function headers, no functional change
Date: Wed, 16 Dec 2009 03:36:18 -0500
Message-ID: <90434c1c7c61ce7dd349f17f003b8813421aeadc.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762016AbZLPLGM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:12 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:06:01 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a few errors with the headers in utcopy.c

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utcopy.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 0f0c64b..f857c5e 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -323,11 +323,11 @@ acpi_ut_copy_ielement_to_eelement(u8 object_type,
  * RETURN:      Status
  *
  * DESCRIPTION: This function is called to place a package object in a user
- *              buffer.  A package object by definition contains other objects.
+ *              buffer. A package object by definition contains other objects.
  *
  *              The buffer is assumed to have sufficient space for the object.
- *              The caller must have verified the buffer length needed using the
- *              acpi_ut_get_object_size function before calling this function.
+ *              The caller must have verified the buffer length needed using
+ *              the acpi_ut_get_object_size function before calling this function.
  *
  ******************************************************************************/
 
@@ -382,12 +382,12 @@ acpi_ut_copy_ipackage_to_epackage(union acpi_operand_object *internal_object,
  * FUNCTION:    acpi_ut_copy_iobject_to_eobject
  *
  * PARAMETERS:  internal_object     - The internal object to be converted
- *              buffer_ptr          - Where the object is returned
+ *              ret_buffer          - Where the object is returned
  *
  * RETURN:      Status
  *
- * DESCRIPTION: This function is called to build an API object to be returned to
- *              the caller.
+ * DESCRIPTION: This function is called to build an API object to be returned
+ *              to the caller.
  *
  ******************************************************************************/
 
@@ -626,7 +626,7 @@ acpi_ut_copy_epackage_to_ipackage(union acpi_object *external_object,
  * PARAMETERS:  external_object     - The external object to be converted
  *              internal_object     - Where the internal object is returned
  *
- * RETURN:      Status              - the status of the call
+ * RETURN:      Status
  *
  * DESCRIPTION: Converts an external object to an internal object.
  *
@@ -665,7 +665,7 @@ acpi_ut_copy_eobject_to_iobject(union acpi_object *external_object,
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Simple copy of one internal object to another.  Reference count
+ * DESCRIPTION: Simple copy of one internal object to another. Reference count
  *              of the destination object is preserved.
  *
  ******************************************************************************/
@@ -897,10 +897,11 @@ acpi_ut_copy_ielement_to_ielement(u8 object_type,
  *
  * FUNCTION:    acpi_ut_copy_ipackage_to_ipackage
  *
- * PARAMETERS:  *source_obj     - Pointer to the source package object
- *              *dest_obj       - Where the internal object is returned
+ * PARAMETERS:  source_obj      - Pointer to the source package object
+ *              dest_obj        - Where the internal object is returned
+ *              walk_state      - Current Walk state descriptor
  *
- * RETURN:      Status          - the status of the call
+ * RETURN:      Status
  *
  * DESCRIPTION: This function is called to copy an internal package object
  *              into another internal package object.
@@ -953,9 +954,9 @@ acpi_ut_copy_ipackage_to_ipackage(union acpi_operand_object *source_obj,
  *
  * FUNCTION:    acpi_ut_copy_iobject_to_iobject
  *
- * PARAMETERS:  walk_state          - Current walk state
- *              source_desc         - The internal object to be copied
+ * PARAMETERS:  source_desc         - The internal object to be copied
  *              dest_desc           - Where the copied object is returned
+ *              walk_state          - Current walk state
  *
  * RETURN:      Status
  *
-- 
1.6.0.6

