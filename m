From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/98] ACPICA: Update comments in module header
Date: Sat, 28 Mar 2009 00:30:57 -0400
Message-ID: <d3319d1717a250e92be66a487dc3e0429112c284.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38046 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbZC1Ecu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:50 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7001C18MA3A9D@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:36 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Enhance the explanations of the various package return types
for clarity.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acpredef.h |   41 +++++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 16a9ca9..63f656a 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -52,41 +52,44 @@
  * 1) PTYPE1 packages do not contain sub-packages.
  *
  * ACPI_PTYPE1_FIXED: Fixed length, 1 or 2 object types:
- *     object type
- *     count
- *     object type
- *     count
+ *      object type
+ *      count
+ *      object type
+ *      count
  *
  * ACPI_PTYPE1_VAR: Variable length:
- *    object type (Int/Buf/Ref)
+ *      object type (Int/Buf/Ref)
  *
- * ACPI_PTYPE1_OPTION: Package has some required and some optional elements:
- *      Used for _PRW
+ * ACPI_PTYPE1_OPTION: Package has some required and some optional elements
+ *      (Used for _PRW)
  *
  *
  * 2) PTYPE2 packages contain a variable number of sub-packages. Each of the
  *    different types describe the contents of each of the sub-packages.
  *
  * ACPI_PTYPE2: Each subpackage contains 1 or 2 object types:
- *     object type
- *     count
- *     object type
- *     count
+ *      object type
+ *      count
+ *      object type
+ *      count
+ *      (Used for _ALR,_MLS,_PSS,_TRT,_TSS)
  *
  * ACPI_PTYPE2_COUNT: Each subpackage has a count as first element:
- *     object type
+ *      object type
+ *      (Used for _CSD,_PSD,_TSD)
  *
  * ACPI_PTYPE2_PKG_COUNT: Count of subpackages at start, 1 or 2 object types:
- *     object type
- *     count
- *     object type
- *     count
+ *      object type
+ *      count
+ *      object type
+ *      count
+ *      (Used for _CST)
  *
- * ACPI_PTYPE2_FIXED: Each subpackage is of fixed length:
- *      Used for _PRT
+ * ACPI_PTYPE2_FIXED: Each subpackage is of fixed length
+ *      (Used for _PRT)
  *
  * ACPI_PTYPE2_MIN: Each subpackage has a variable but minimum length
- *      Used for _HPX
+ *      (Used for _HPX)
  *
  *****************************************************************************/
 
-- 
1.6.0.6

