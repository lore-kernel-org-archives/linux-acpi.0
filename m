From: Len Brown <lenb@kernel.org>
Subject: [PATCH 84/94] ACPICA: FADT: Update error msgs for consistency
Date: Fri, 09 Jan 2009 04:27:26 -0500
Message-ID: <40774f7acaba897f99ceea5d7de65ee8e2bd3696.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbZAIJ2l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:41 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD70049V6BL3RQC@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:36 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Update all messages so they look consistent.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbfadt.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 7dec0af..87f22e6 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -524,7 +524,7 @@ static void acpi_tb_validate_fadt(void)
 	if (acpi_gbl_FADT.facs &&
 	    (acpi_gbl_FADT.Xfacs != (u64) acpi_gbl_FADT.facs)) {
 		ACPI_WARNING((AE_INFO,
-			      "32/64 FACS address mismatch in FADT - "
+			      "32/64X FACS address mismatch in FADT - "
 			      "two FACS tables! %8.8X/%8.8X%8.8X",
 			      acpi_gbl_FADT.facs,
 			      ACPI_FORMAT_UINT64(acpi_gbl_FADT.Xfacs)));
@@ -533,7 +533,7 @@ static void acpi_tb_validate_fadt(void)
 	if (acpi_gbl_FADT.dsdt &&
 	    (acpi_gbl_FADT.Xdsdt != (u64) acpi_gbl_FADT.dsdt)) {
 		ACPI_WARNING((AE_INFO,
-			      "32/64 DSDT address mismatch in FADT - "
+			      "32/64X DSDT address mismatch in FADT - "
 			      "two DSDT tables! %8.8X/%8.8X%8.8X",
 			      acpi_gbl_FADT.dsdt,
 			      ACPI_FORMAT_UINT64(acpi_gbl_FADT.Xdsdt)));
@@ -563,7 +563,7 @@ static void acpi_tb_validate_fadt(void)
 		 */
 		if (address64 && (address64->bit_width != ACPI_MUL_8(length))) {
 			ACPI_WARNING((AE_INFO,
-				      "32/64X bit length mismatch in %s: %d/%d",
+				      "32/64X length mismatch in %s: %d/%d",
 				      name, ACPI_MUL_8(length),
 				      address64->bit_width));
 		}
@@ -602,7 +602,7 @@ static void acpi_tb_validate_fadt(void)
 		if (address64->address && *address32 &&
 		    (address64->address != (u64) * address32)) {
 			ACPI_ERROR((AE_INFO,
-				    "32/64X address mismatch in %s: [%8.8X] [%8.8X%8.8X], using 64X",
+				    "32/64X address mismatch in %s: %8.8X/%8.8X%8.8X, using 64X",
 				    name, *address32,
 				    ACPI_FORMAT_UINT64(address64->address)));
 		}
-- 
1.5.6.6

