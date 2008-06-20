From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/70] ACPICA: Workaround for reversed _PRT entries from BIOS
Date: Fri, 20 Jun 2008 03:43:25 -0400
Message-ID: <deade3c973eb9c98d2a6cfed658bbb49e693894a.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:62806 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbYFTHou (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:50 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00AKF4678VP2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:32 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Some BIOSs erroneously reverse the _PRT SourceName and the
SourceIndex.  Detect and repair this problem. MS ACPI also allows
and repairs this problem, thus ACPICA must also.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/resources/rscreate.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/resources/rscreate.c b/drivers/acpi/resources/rscreate.c
index faddaee..70c84ec 100644
--- a/drivers/acpi/resources/rscreate.c
+++ b/drivers/acpi/resources/rscreate.c
@@ -285,6 +285,23 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		}
 
 		/*
+		 * If the BIOS has erroneously reversed the _PRT source_name (index 2)
+		 * and the source_index (index 3), fix it. _PRT is important enough to
+		 * workaround this BIOS error. This also provides compatibility with
+		 * other ACPI implementations.
+		 */
+		obj_desc = sub_object_list[3];
+		if (!obj_desc
+		    || (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER)) {
+			sub_object_list[3] = sub_object_list[2];
+			sub_object_list[2] = obj_desc;
+
+			ACPI_WARNING((AE_INFO,
+				      "(PRT[%X].Source) SourceName and SourceIndex are reversed, fixed",
+				      index));
+		}
+
+		/*
 		 * 3) Third subobject: Dereference the PRT.source_name
 		 * The name may be unresolved (slack mode), so allow a null object
 		 */
-- 
1.5.6

