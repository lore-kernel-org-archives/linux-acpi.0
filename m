From: Len Brown <len.brown@intel.com>
Subject: [PATCH 21/65] ACPICA: Store GPE number instead of bitmask
Date: Fri, 24 Nov 2006 02:18:31 -0500
Message-ID: <11643527832869-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59186 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934467AbWKXHPp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:45 -0500
In-Reply-To: <11643527821346-git-send-email-len.brown@intel.com>
Message-Id: <50ae4c050de1b4052c93bb7c2501877e2ae2d383.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Bob Moore <bob.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

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
@@ -121,7 +121,9 @@ acpi_ev_update_gpe_enable_masks(struct a
 	if (!gpe_register_info) {
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
-	register_bit = gpe_event_info->register_bit;
+	register_bit = (u8)
+	    (1 <<
+	     (gpe_event_info->gpe_number - gpe_register_info->base_gpe_number));
 
 	/* 1) Disable case.  Simply clear all enable bits */
 
@@ -458,8 +460,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 
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
@@ -819,7 +819,8 @@ acpi_ev_create_gpe_info_blocks(struct ac
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
@@ -105,14 +105,20 @@ acpi_hw_write_gpe_enable_reg(struct acpi
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
 
@@ -155,7 +161,10 @@ acpi_hw_get_gpe_status(struct acpi_gpe_e
 
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
index a2b8340..3ebf42d 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -239,7 +239,6 @@ ACPI_EXTERN u8 acpi_gbl_system_awake_and
 
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
1.4.4.1
