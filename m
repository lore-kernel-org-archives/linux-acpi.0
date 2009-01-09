From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/94] ACPICA: Emit warning if two FACS or DSDT tables found in
 the FADT
Date: Fri, 09 Jan 2009 04:26:28 -0500
Message-ID: <c87609f31a8641009641fc1d19dac75e6de06fd4.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbZAIJ2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:04 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700HRN68AX1F2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:35 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Checks if there are two valid but different addresses for the
FACS and DSDT within the FADT (mismatch between the 32-bit and
64-bit fields.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbfadt.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index d2e60a8..14661a8 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -286,14 +286,27 @@ static void acpi_tb_convert_fadt(void)
 
 	acpi_gbl_FADT.header.length = sizeof(struct acpi_table_fadt);
 
-	/* Expand the 32-bit FACS and DSDT addresses to 64-bit as necessary */
-
+	/*
+	 * Expand the 32-bit FACS and DSDT addresses to 64-bit as necessary.
+	 * Later code will always use the X 64-bit field. Also, check for an
+	 * address mismatch between the 32-bit and 64-bit address fields
+	 * (FIRMWARE_CTRL/X_FIRMWARE_CTRL, DSDT/X_DSDT) which would indicate
+	 * the presence of two FACS or two DSDT tables.
+	 */
 	if (!acpi_gbl_FADT.Xfacs) {
 		acpi_gbl_FADT.Xfacs = (u64) acpi_gbl_FADT.facs;
+	} else if (acpi_gbl_FADT.facs &&
+		   (acpi_gbl_FADT.Xfacs != (u64) acpi_gbl_FADT.facs)) {
+		ACPI_WARNING((AE_INFO,
+		    "32/64 FACS address mismatch in FADT - two FACS tables!"));
 	}
 
 	if (!acpi_gbl_FADT.Xdsdt) {
 		acpi_gbl_FADT.Xdsdt = (u64) acpi_gbl_FADT.dsdt;
+	} else if (acpi_gbl_FADT.dsdt &&
+		   (acpi_gbl_FADT.Xdsdt != (u64) acpi_gbl_FADT.dsdt)) {
+		ACPI_WARNING((AE_INFO,
+		    "32/64 DSDT address mismatch in FADT - two DSDT tables!"));
 	}
 
 	/*
-- 
1.5.6.6

