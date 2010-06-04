From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/16] ACPICA: Add comment: _BCL cannot be sorted on the fly
Date: Fri, 04 Jun 2010 15:51:32 -0400
Message-ID: <60382f787bb867916c16b914b121dc0df163f156.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:51099 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498Ab0FDTwE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:52:04 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I005AO9UCDUV5@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:51:54 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Because of package index values used for _BQC and _BCM.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsrepair2.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 61bd0f6..4009498 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -112,6 +112,13 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  * _GTM: Convert Buffer of BYTEs to a Buffer of DWORDs
  * _PSS: Sort the list descending by Power
  * _TSS: Sort the list descending by Power
+ *
+ * Names that must be packages, but cannot be sorted:
+ *
+ * _BCL: Values are tied to the Package index where they appear, and cannot
+ * be moved or sorted. These index values are used for _BQC and _BCM.
+ * However, we can fix the case where a buffer is returned, by converting
+ * it to a Package of integers.
  */
 static const struct acpi_repair_info acpi_ns_repairable_names[] = {
 	{"_ALR", acpi_ns_repair_ALR},
-- 
1.6.0.6

