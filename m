From: Len Brown <lenb@kernel.org>
Subject: [PATCH 52/98] ACPICA: FADT: Favor 32-bit FACS and DSDT addresses
Date: Sat, 28 Mar 2009 00:31:27 -0400
Message-ID: <f65563063375b05898a94ab71b52612cbe3a789b.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:34903 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbZC1EdM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:12 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700E8X8N9K6VH@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:10 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

If both the 32-bit and 64-bit addresses are non-null, use the
32-bit address. Provides Windows compatibility.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index f87bfb2..71e655d 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -483,18 +483,22 @@ static void acpi_tb_validate_fadt(void)
 	    (acpi_gbl_FADT.Xfacs != (u64) acpi_gbl_FADT.facs)) {
 		ACPI_WARNING((AE_INFO,
 			      "32/64X FACS address mismatch in FADT - "
-			      "two FACS tables! %8.8X/%8.8X%8.8X",
+			      "%8.8X/%8.8X%8.8X, using 32",
 			      acpi_gbl_FADT.facs,
 			      ACPI_FORMAT_UINT64(acpi_gbl_FADT.Xfacs)));
+
+		acpi_gbl_FADT.Xfacs = (u64) acpi_gbl_FADT.facs;
 	}
 
 	if (acpi_gbl_FADT.dsdt &&
 	    (acpi_gbl_FADT.Xdsdt != (u64) acpi_gbl_FADT.dsdt)) {
 		ACPI_WARNING((AE_INFO,
 			      "32/64X DSDT address mismatch in FADT - "
-			      "two DSDT tables! %8.8X/%8.8X%8.8X",
+			      "%8.8X/%8.8X%8.8X, using 32",
 			      acpi_gbl_FADT.dsdt,
 			      ACPI_FORMAT_UINT64(acpi_gbl_FADT.Xdsdt)));
+
+		acpi_gbl_FADT.Xdsdt = (u64) acpi_gbl_FADT.dsdt;
 	}
 
 	/* Examine all of the 64-bit extended address fields (X fields) */
-- 
1.6.0.6

