From: Len Brown <lenb@kernel.org>
Subject: [PATCH 65/140] ACPICA: Cleanup of FADT verification function.
Date: Wed,  7 Feb 2007 13:51:19 -0500
Message-ID: <11708744692041-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:17574 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422797AbXBGSyc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:32 -0500
In-Reply-To: <11708744674050-git-send-email-lenb@kernel.org>
Message-Id: <b89b71a0019660d73e3c9671205c49e443d7085c.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed offset display, not needed.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utinit.c |   65 ++++++++++++++-------------------------
 1 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/utilities/utinit.c b/drivers/acpi/utilities/utinit.c
index 2d2c4a3..5079f19 100644
--- a/drivers/acpi/utilities/utinit.c
+++ b/drivers/acpi/utilities/utinit.c
@@ -50,8 +50,7 @@
 ACPI_MODULE_NAME("utinit")
 
 /* Local prototypes */
-static void
-acpi_ut_fadt_register_error(char *register_name, u32 value, u8 offset);
+static void acpi_ut_fadt_register_error(char *register_name, u32 value);
 
 static void acpi_ut_terminate(void);
 
@@ -61,21 +60,18 @@ static void acpi_ut_terminate(void);
  *
  * PARAMETERS:  register_name           - Pointer to string identifying register
  *              Value                   - Actual register contents value
- *              Offset                  - Byte offset in the FADT
  *
- * RETURN:      AE_BAD_VALUE
+ * RETURN:      None
  *
  * DESCRIPTION: Display failure message
  *
  ******************************************************************************/
 
-static void
-acpi_ut_fadt_register_error(char *register_name, u32 value, u8 offset)
+static void acpi_ut_fadt_register_error(char *register_name, u32 value)
 {
 
-	ACPI_WARNING((AE_INFO,
-		      "Invalid FADT value %s=%X at offset %X in FADT=%p",
-		      register_name, value, offset, &acpi_gbl_FADT));
+	ACPI_WARNING((AE_INFO, "Invalid FADT value %s = %X",
+		      register_name, value));
 }
 
 /******************************************************************************
@@ -98,69 +94,54 @@ acpi_status acpi_ut_validate_fadt(void)
 	 * but don't abort on any problems, just display error
 	 */
 	if (acpi_gbl_FADT.pm1_event_length < 4) {
-		acpi_ut_fadt_register_error("PM1_EVT_LEN",
+		acpi_ut_fadt_register_error("Pm1EventLength",
 					    (u32) acpi_gbl_FADT.
-					    pm1_event_length,
-					    ACPI_FADT_OFFSET(pm1_event_length));
+					    pm1_event_length);
+	}
+
+	if (acpi_gbl_FADT.pm_timer_length < 4) {
+		acpi_ut_fadt_register_error("PmTimerLength",
+					    (u32) acpi_gbl_FADT.
+					    pm_timer_length);
 	}
 
 	if (!acpi_gbl_FADT.pm1_control_length) {
-		acpi_ut_fadt_register_error("PM1_CNT_LEN", 0,
-					    ACPI_FADT_OFFSET
-					    (pm1_control_length));
+		acpi_ut_fadt_register_error("Pm1ControlLength", 0);
 	}
 
 	if (!acpi_gbl_FADT.xpm1a_event_block.address) {
-		acpi_ut_fadt_register_error("X_PM1a_EVT_BLK", 0,
-					    ACPI_FADT_OFFSET(xpm1a_event_block.
-							     address));
+		acpi_ut_fadt_register_error("XPm1aEventBlock.Address", 0);
 	}
 
 	if (!acpi_gbl_FADT.xpm1a_control_block.address) {
-		acpi_ut_fadt_register_error("X_PM1a_CNT_BLK", 0,
-					    ACPI_FADT_OFFSET
-					    (xpm1a_control_block.address));
+		acpi_ut_fadt_register_error("XPm1aControlBlock.Address", 0);
 	}
 
 	if (!acpi_gbl_FADT.xpm_timer_block.address) {
-		acpi_ut_fadt_register_error("X_PM_TMR_BLK", 0,
-					    ACPI_FADT_OFFSET(xpm_timer_block.
-							     address));
+		acpi_ut_fadt_register_error("XPmTimerBlock.Address", 0);
 	}
 
 	if ((acpi_gbl_FADT.xpm2_control_block.address &&
 	     !acpi_gbl_FADT.pm2_control_length)) {
-		acpi_ut_fadt_register_error("PM2_CNT_LEN",
+		acpi_ut_fadt_register_error("Pm2ControlLength",
 					    (u32) acpi_gbl_FADT.
-					    pm2_control_length,
-					    ACPI_FADT_OFFSET
-					    (pm2_control_length));
-	}
-
-	if (acpi_gbl_FADT.pm_timer_length < 4) {
-		acpi_ut_fadt_register_error("PM_TM_LEN",
-					    (u32) acpi_gbl_FADT.pm_timer_length,
-					    ACPI_FADT_OFFSET(pm_timer_length));
+					    pm2_control_length);
 	}
 
 	/* Length of GPE blocks must be a multiple of 2 */
 
 	if (acpi_gbl_FADT.xgpe0_block.address &&
 	    (acpi_gbl_FADT.gpe0_block_length & 1)) {
-		acpi_ut_fadt_register_error("(x)GPE0_BLK_LEN",
+		acpi_ut_fadt_register_error("Gpe0BlockLength",
 					    (u32) acpi_gbl_FADT.
-					    gpe0_block_length,
-					    ACPI_FADT_OFFSET
-					    (gpe0_block_length));
+					    gpe0_block_length);
 	}
 
 	if (acpi_gbl_FADT.xgpe1_block.address &&
 	    (acpi_gbl_FADT.gpe1_block_length & 1)) {
-		acpi_ut_fadt_register_error("(x)GPE1_BLK_LEN",
+		acpi_ut_fadt_register_error("Gpe1BlockLength",
 					    (u32) acpi_gbl_FADT.
-					    gpe1_block_length,
-					    ACPI_FADT_OFFSET
-					    (gpe1_block_length));
+					    gpe1_block_length);
 	}
 
 	return (AE_OK);
-- 
1.5.0.rc3.39.gec804
