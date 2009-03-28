From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/98] ACPICA: Remove extra write for acpi_hw_clear_acpi_status
Date: Sat, 28 Mar 2009 00:30:59 -0400
Message-ID: <227243a04d645377d09eda0dc8501e0d9c26ab89.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38046 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbZC1Ecv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:51 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700LT88MBZ0PR@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:36 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This function was writing an optional PM1B status register
twice.  The existing call to the low-level acpi_hw_register_write
automatically handles a possibly split PM1 A/B register.
ACPICA BZ 751.

http://www.acpica.org/bugzilla/show_bug.cgi?id=751

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwregs.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 41f1173..9c81621 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -71,7 +71,6 @@ acpi_hw_write_multiple(u32 value,
  * RETURN:      Status
  *
  * DESCRIPTION: Clears all fixed and general purpose status bits
- *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
 
@@ -82,13 +81,13 @@ acpi_status acpi_hw_clear_acpi_status(void)
 
 	ACPI_FUNCTION_TRACE(hw_clear_acpi_status);
 
-	ACPI_DEBUG_PRINT((ACPI_DB_IO, "About to write %04X to %04X\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_IO, "About to write %04X to %0llX\n",
 			  ACPI_BITMASK_ALL_FIXED_STATUS,
-			  (u16) acpi_gbl_xpm1a_status.address));
+			  acpi_gbl_xpm1a_status.address));
 
 	lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
 
-	/* Clear the fixed events */
+	/* Clear the fixed events in PM1 A/B */
 
 	status = acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
 					ACPI_BITMASK_ALL_FIXED_STATUS);
@@ -96,16 +95,6 @@ acpi_status acpi_hw_clear_acpi_status(void)
 		goto unlock_and_exit;
 	}
 
-	/* Write PM1B register if present */
-
-	if (acpi_gbl_xpm1b_status.address) {
-		status = acpi_write(ACPI_BITMASK_ALL_FIXED_STATUS,
-				    &acpi_gbl_xpm1b_status);
-		if (ACPI_FAILURE(status)) {
-			goto unlock_and_exit;
-		}
-	}
-
 	/* Clear the GPE Bits in all GPE registers in all GPE blocks */
 
 	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
-- 
1.6.0.6

