From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/30] ACPICA: Fix table entry truncation calculation
Date: Sat, 07 Feb 2009 01:41:36 -0500
Message-ID: <386e4a8358239f90275e1f93d5ad11cdc93c6453.1233988827.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:44724 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZBGGmH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:07 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00DVJNPXPV22@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:37:10 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

During early boot, ACPI RSDT/XSDT table entries are gathered into the
'initial_tables[]' array.  This array is currently statically defined (see
./drivers/acpi/tables.c).  When there are more table entries than can be
held in the 'initial_tables[]' array, the message "Truncating N table
entries!" is output.  As currently implemented, this message will always
erroneously calculate N as 0.

This patch fixes the calculation that determines how many table entries
will be missing (truncated).

This modification may be used under either the GPL or the BSD-style
license used for Intel ACPI CA code.

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbutils.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 9684cc8..22ce489 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -538,10 +538,9 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 			if (ACPI_FAILURE(status)) {
 				ACPI_WARNING((AE_INFO,
 					      "Truncating %u table entries!",
-					      (unsigned)
-					      (acpi_gbl_root_table_list.size -
-					       acpi_gbl_root_table_list.
-					       count)));
+					      (unsigned) (table_count -
+					       (acpi_gbl_root_table_list.
+					       count - 2))));
 				break;
 			}
 		}
-- 
1.5.6.6

