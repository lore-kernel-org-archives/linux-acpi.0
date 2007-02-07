From: Len Brown <lenb@kernel.org>
Subject: [PATCH 62/140] ACPICA: Store GPE number instead of bitmask
Date: Wed,  7 Feb 2007 13:51:16 -0500
Message-ID: <117087446376-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:17574 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422792AbXBGSyc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:32 -0500
In-Reply-To: <11708744612314-git-send-email-lenb@kernel.org>
Message-Id: <69874165ab953a62f9adb3096ccd84ed2561a602.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Bob Moore <bob.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Update internal GPE data structure to simplify
debug, use gpe_number instead of register bitmask.

Signed-off-by: Bob Moore <bob.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evgpe.c       |    7 ++++---
 drivers/acpi/events/evgpeblk.c    |    3 ++-
 drivers/acpi/hardware/hwgpe.c     |   13 +++++++++++--
 drivers/acpi/utilities/utglobal.c |    2 --
 include/acpi/acglobal.h           |    1 -
 include/acpi/aclocal.h            |    2 +-
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index df92c9e..35933be 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -121,7 +121,9 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info,
 	if (!gpe_register_info) {
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
-	register_bit = gpe_event_info->register_bit;
+	register_bit = (u8)
+	    (1 <<
+	     (gpe_event_info->gpe_number - gpe_register_info->base_gpe_number));
 
 	/* 1) Disable case.  Simply clear all enable bits */
 
@@ -458,8 +460,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 
 				/* Examine one GPE bit */
 
-				if (enabled_status_byte &
-				    acpi_gbl_decode_to8bit[j]) {
+				if (enabled_status_byte & (1 << j)) {
 					/*
 					 * Found an active GPE. Dispatch the event to a handler
 					 * or method.
diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
index bb0eb50..8a6f01a 100644
--- a/drivers/acpi/events/evgpeblk.c
+++ b/drivers/acpi/events/evgpeblk.c
@@ -819,7 +819,8 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 		/* Init the event_info for each GPE within this register */
 
 		for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++) {
-			this_event->register_bit = acpi_gbl_decode_to8bit[j];
+			this_event->gpe_number =
+			    (u8) (this_register->base_gpe_number + j);
 			this_event->register_info = this_register;
 			this_event++;
 		}
diff --git a/drivers/acpi/hardware/hwgpe.c b/drivers/acpi/hardware/hwgpe.c
index 608a3a6..3d548b5 100644
--- a/drivers/acpi/hardware/hwgpe.c
+++ b/drivers/acpi/hardware/hwgpe.c
@@ -105,14 +105,20 @@ acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info *gpe_event_info)
 acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info * gpe_event_info)
 {
 	acpi_status status;
+	u8 register_bit;
 
 	ACPI_FUNCTION_ENTRY();
 
+	register_bit = (u8)
+	    (1 <<
+	     (gpe_event_info->gpe_number -
+	      gpe_event_info->register_info->base_gpe_number));
+
 	/*
 	 * Write a one to the appropriate bit in the status register to
 	 * clear this GPE.
 	 */
-	status = acpi_hw_low_level_write(8, gpe_event_info->register_bit,
+	status = acpi_hw_low_level_write(8, register_bit,
 					 &gpe_event_info->register_info->
 					 status_address);
 
@@ -155,7 +161,10 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 
 	/* Get the register bitmask for this GPE */
 
-	register_bit = gpe_event_info->register_bit;
+	register_bit = (u8)
+	    (1 <<
+	     (gpe_event_info->gpe_number -
+	      gpe_event_info->register_info->base_gpe_number));
 
 	/* GPE currently enabled? (enabled for runtime?) */
 
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 855bc8f..5b83f86 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -164,8 +164,6 @@ u32 acpi_gbl_startup_flags = 0;
 
 u8 acpi_gbl_shutdown = TRUE;
 
-const u8 acpi_gbl_decode_to8bit[8] = { 1, 2, 4, 8, 16, 32, 64, 128 };
-
 const char *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT] = {
 	"\\_S0_",
 	"\\_S1_",
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index b74cd9b..0c2e1ae 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -240,7 +240,6 @@ ACPI_EXTERN u8 acpi_gbl_system_awake_and_running;
 
 extern u8 acpi_gbl_shutdown;
 extern u32 acpi_gbl_startup_flags;
-extern const u8 acpi_gbl_decode_to8bit[8];
 extern const char *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT];
 extern const char *acpi_gbl_highest_dstate_names[4];
 extern const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES];
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index a870484..553763d 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -367,7 +367,7 @@ struct acpi_gpe_event_info {
 	union acpi_gpe_dispatch_info dispatch;	/* Either Method or Handler */
 	struct acpi_gpe_register_info *register_info;	/* Backpointer to register info */
 	u8 flags;		/* Misc info about this GPE */
-	u8 register_bit;	/* This GPE bit within the register */
+	u8 gpe_number;		/* This GPE */
 };
 
 /* Information about a GPE register pair, one per each status/enable pair in an array */
-- 
1.5.0.rc3.39.gec804
