From: Len Brown <lenb@kernel.org>
Subject: [PATCH 53/98] ACPICA: Fix index value in package warning message
Date: Sat, 28 Mar 2009 00:31:28 -0400
Message-ID: <03ef132b7258bbea4858be4b1bd6cb6c3fdd3253.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49737 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbZC1EdM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:12 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7009GK8NAWWYH@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:11 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

For predefined method validation. Index value in warning message
could be off by one.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nspredef.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 0d0b4ee..d9e8cbc 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -79,7 +79,9 @@ acpi_ns_check_package(char *pathname,
 static acpi_status
 acpi_ns_check_package_elements(char *pathname,
 			       union acpi_operand_object **elements,
-			       u8 type1, u32 count1, u8 type2, u32 count2);
+			       u8 type1,
+			       u32 count1,
+			       u8 type2, u32 count2, u32 start_index);
 
 static acpi_status
 acpi_ns_check_object_type(char *pathname,
@@ -473,7 +475,7 @@ acpi_ns_check_package(char *pathname,
 							package->ret_info.
 							object_type2,
 							package->ret_info.
-							count2);
+							count2, 0);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -624,7 +626,7 @@ acpi_ns_check_package(char *pathname,
 								   object_type2,
 								   package->
 								   ret_info.
-								   count2);
+								   count2, 0);
 				if (ACPI_FAILURE(status)) {
 					return (status);
 				}
@@ -673,7 +675,8 @@ acpi_ns_check_package(char *pathname,
 								   object_type1,
 								   sub_package->
 								   package.
-								   count, 0, 0);
+								   count, 0, 0,
+								   0);
 				if (ACPI_FAILURE(status)) {
 					return (status);
 				}
@@ -711,7 +714,8 @@ acpi_ns_check_package(char *pathname,
 								   ret_info.
 								   object_type1,
 								   (expected_count
-								    - 1), 0, 0);
+								    - 1), 0, 0,
+								   1);
 				if (ACPI_FAILURE(status)) {
 					return (status);
 				}
@@ -759,6 +763,7 @@ acpi_ns_check_package(char *pathname,
  *              Count1          - Count for first group
  *              Type2           - Object type for second group
  *              Count2          - Count for second group
+ *              start_index     - Start of the first group of elements
  *
  * RETURN:      Status
  *
@@ -770,7 +775,9 @@ acpi_ns_check_package(char *pathname,
 static acpi_status
 acpi_ns_check_package_elements(char *pathname,
 			       union acpi_operand_object **elements,
-			       u8 type1, u32 count1, u8 type2, u32 count2)
+			       u8 type1,
+			       u32 count1,
+			       u8 type2, u32 count2, u32 start_index)
 {
 	union acpi_operand_object **this_element = elements;
 	acpi_status status;
@@ -783,7 +790,7 @@ acpi_ns_check_package_elements(char *pathname,
 	 */
 	for (i = 0; i < count1; i++) {
 		status = acpi_ns_check_object_type(pathname, this_element,
-						   type1, i);
+						   type1, i + start_index);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -792,7 +799,8 @@ acpi_ns_check_package_elements(char *pathname,
 
 	for (i = 0; i < count2; i++) {
 		status = acpi_ns_check_object_type(pathname, this_element,
-						   type2, (i + count1));
+						   type2,
+						   (i + count1 + start_index));
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
-- 
1.6.0.6

