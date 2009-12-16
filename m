From: Len Brown <lenb@kernel.org>
Subject: [PATCH 071/103] ACPICA: Update function headers and comments,
 no functional change
Date: Wed, 16 Dec 2009 03:36:22 -0500
Message-ID: <43420bbb892268b5fc42cb80c3bc31dedbad3ac9.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761997AbZLPLGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:09 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:59 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Update comments for repair of _FDE and _GTM methods.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsrepair.c  |    5 +++++
 drivers/acpi/acpica/nsrepair2.c |   11 +++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 907f60c..4fd1bdb 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -399,6 +399,11 @@ acpi_ns_convert_to_buffer(union acpi_operand_object *original_object,
 		break;
 
 	case ACPI_TYPE_PACKAGE:
+		/*
+		 * This case is often seen for predefined names that must return a
+		 * Buffer object with multiple DWORD integers within. For example,
+		 * _FDE and _GTM. The Package can be converted to a Buffer.
+		 */
 
 		/* All elements of the Package must be integers */
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 1993338..e7373eb 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -111,8 +111,8 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  * As necessary:
  *
  * _ALR: Sort the list ascending by ambient_illuminance
- * _FDE: Convert a Package or Buffer of BYTEs to a Buffer of DWORDs
- * _GTM: Convert a Package or Buffer of BYTEs to a Buffer of DWORDs
+ * _FDE: Convert Buffer of BYTEs to a Buffer of DWORDs
+ * _GTM: Convert Buffer of BYTEs to a Buffer of DWORDs
  * _PSS: Sort the list descending by Power
  * _TSS: Sort the list descending by Power
  */
@@ -238,10 +238,9 @@ acpi_ns_repair_ALR(struct acpi_predefined_data *data,
  * RETURN:      Status. AE_OK if object is OK or was repaired successfully
  *
  * DESCRIPTION: Repair for the _FDE and _GTM objects. The expected return
- *              value is a Buffer of 5 DWORDs. This function repairs two
- *              possible problems:
- *              1) The return value is a Buffer of BYTEs, not DWORDs
- *              2) The return value is a Package of Integer objects
+ *              value is a Buffer of 5 DWORDs. This function repairs a common
+ *              problem where the return value is a Buffer of BYTEs, not
+ *              DWORDs.
  *
  *****************************************************************************/
 
-- 
1.6.0.6

