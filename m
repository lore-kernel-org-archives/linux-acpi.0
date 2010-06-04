From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/16] ACPICA: Expand device initialization counters to 32 bits
Date: Fri, 04 Jun 2010 15:51:38 -0400
Message-ID: <2fdfdf41617e315d219f0d2dd0fc82eb86720a29.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:56531 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab0FDTvw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:51:52 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I00LSU9UD7LQ2@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:51:51 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Expand the various device initialization counters from 16-bit
to 32-bit.  Allows for very large namespaces.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acstruct.h |    6 +++---
 drivers/acpi/acpica/nsinit.c   |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 0e2c66a..6e5dd97 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -201,11 +201,11 @@ struct acpi_evaluate_info {
 /* Info used by acpi_ns_initialize_devices */
 
 struct acpi_device_walk_info {
-	u16 device_count;
-	u16 num_STA;
-	u16 num_INI;
 	struct acpi_table_desc *table_desc;
 	struct acpi_evaluate_info *evaluate_info;
+	u32 device_count;
+	u32 num_STA;
+	u32 num_INI;
 };
 
 /* TBD: [Restructure] Merge with struct above */
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index b3d88d8..8009e71 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -199,8 +199,8 @@ acpi_status acpi_ns_initialize_devices(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nExecuted %hd _INI methods requiring %hd _STA executions "
-			      "(examined %hd objects)\n",
+			      "\nExecuted %u _INI methods requiring %u _STA executions "
+			      "(examined %u objects)\n",
 			      info.num_INI, info.num_STA, info.device_count));
 
 	return_ACPI_STATUS(status);
-- 
1.6.0.6

