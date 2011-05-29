From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/18] ACPICA: Move ACPI_NUM_PREDEFINED_REGIONS to a more
 appropriate place
Date: Sun, 29 May 2011 05:44:05 -0400
Message-ID: <07aa99e9df2184e78068f7d5414e29e4a5a1b452.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:55532 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab1E2J57 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:57:59 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY0094DBOGA0E2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:57:58 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Moved to where the predefined regions are actually defined.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acconfig.h |    1 -
 include/acpi/actypes.h         |    4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index c115bb9..bc533dd 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -187,7 +187,6 @@
 
 /* Operation regions */
 
-#define ACPI_NUM_PREDEFINED_REGIONS     8
 #define ACPI_USER_REGION_BEGIN          0x80
 
 /* Maximum space_ids for Operation Regions */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ad77c61..f3b29fa 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -713,8 +713,10 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ADR_SPACE_PCI_BAR_TARGET   (acpi_adr_space_type) 6
 #define ACPI_ADR_SPACE_IPMI             (acpi_adr_space_type) 7
 
+#define ACPI_NUM_PREDEFINED_REGIONS     8
+
 /*
- * Special region types
+ * Special Address Spaces
  *
  * Note: A Data Table region is a special type of operation region
  * that has its own AML opcode. However, internally, the AML
-- 
1.7.5.3.367.ga9930.dirty

