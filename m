From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Rework GPE handling slightly
Date: Wed, 5 Feb 2003 21:57:12 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030205215712.C32277@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This patch modularises the ACPI code a little by reducing use of
acpi_gbl_gpe_register_info and eliminating use of acpi_gbl_gpe_number_info
in hardware/ .  It also reduces compiled code size by 110 bytes on x86.
This patch is against 2.5.59 -- would it be better to prepare against
a different tree?

diff -urpNX dontdiff linux-2.5.59/drivers/acpi/events/evmisc.c linux-2.5.59-acpi/drivers/acpi/events/evmisc.c
--- linux-2.5.59/drivers/acpi/events/evmisc.c	2003-02-05 13:41:04.000000000 -0500
+++ linux-2.5.59-acpi/drivers/acpi/events/evmisc.c	2003-02-05 16:38:28.000000000 -0500
@@ -67,27 +67,55 @@ acpi_ev_is_notify_object (
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_get_gpe_register_index
+ * FUNCTION:    acpi_ev_get_gpe_register_info
  *
  * PARAMETERS:  gpe_number      - Raw GPE number
  *
  * RETURN:      None.
  *
- * DESCRIPTION: Returns the register index (index into the GPE register info
- *              table) associated with this GPE.
+ * DESCRIPTION: Returns the register info entry associated with this GPE.
  *
  ******************************************************************************/
 
-u32
-acpi_ev_get_gpe_register_index (
+struct acpi_gpe_register_info *
+acpi_ev_get_gpe_register_info (
 	u32                             gpe_number)
 {
+	u32 register_index;
 
 	if (gpe_number > acpi_gbl_gpe_number_max) {
-		return (ACPI_GPE_INVALID);
+		return NULL;
+	}
+
+	register_index = ACPI_DIV_8 (acpi_gbl_gpe_number_to_index[gpe_number].number_index);
+	return &acpi_gbl_gpe_register_info[register_index];
+}
+
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_get_gpe_number_info
+ *
+ * PARAMETERS:  gpe_number      - Raw GPE number
+ *
+ * RETURN:      None.
+ *
+ * DESCRIPTION: Returns the number info entry associated with this GPE.
+ *
+ ******************************************************************************/
+
+struct acpi_gpe_number_info *
+acpi_ev_get_gpe_number_info (
+	u32                             gpe_number)
+{
+	u32 register_index;
+
+	if (gpe_number > acpi_gbl_gpe_number_max) {
+		return NULL;
 	}
 
-	return (ACPI_DIV_8 (acpi_gbl_gpe_number_to_index[gpe_number].number_index));
+	register_index = ACPI_DIV_8 (acpi_gbl_gpe_number_to_index[gpe_number].number_index);
+	return &acpi_gbl_gpe_number_info[register_index];
 }
 
 
diff -urpNX dontdiff linux-2.5.59/drivers/acpi/hardware/hwgpe.c linux-2.5.59-acpi/drivers/acpi/hardware/hwgpe.c
--- linux-2.5.59/drivers/acpi/hardware/hwgpe.c	2003-02-05 13:41:04.000000000 -0500
+++ linux-2.5.59-acpi/drivers/acpi/hardware/hwgpe.c	2003-02-05 16:41:25.000000000 -0500
@@ -32,26 +32,6 @@
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_hw_get_gpe_bit_mask
- *
- * PARAMETERS:  gpe_number      - The GPE
- *
- * RETURN:      Gpe register bitmask for this gpe level
- *
- * DESCRIPTION: Get the bitmask for this GPE
- *
- ******************************************************************************/
-
-u8
-acpi_hw_get_gpe_bit_mask (
-	u32                             gpe_number)
-{
-	return (acpi_gbl_gpe_number_info [acpi_ev_get_gpe_number_index (gpe_number)].bit_mask);
-}
-
-
-/******************************************************************************
- *
  * FUNCTION:    acpi_hw_enable_gpe
  *
  * PARAMETERS:  gpe_number      - The GPE
@@ -67,34 +47,32 @@ acpi_hw_enable_gpe (
 	u32                             gpe_number)
 {
 	u32                             in_byte;
-	u32                             register_index;
+	struct acpi_gpe_register_info	*register_info;
 	u8                              bit_mask;
 	acpi_status                     status;
+	struct acpi_generic_address	*enable_address;
 
 
 	ACPI_FUNCTION_ENTRY ();
 
 
-	/* Translate GPE number to index into global registers array. */
-
-	register_index = acpi_ev_get_gpe_register_index (gpe_number);
-
-	/* Get the register bitmask for this GPE */
+	/* Get the register info for this GPE */
 
-	bit_mask = acpi_hw_get_gpe_bit_mask (gpe_number);
+	register_info = acpi_ev_get_gpe_register_info (gpe_number);
+	bit_mask = acpi_ev_get_gpe_number_info(gpe_number)->bit_mask;
+	enable_address = &register_info->enable_address;
 
 	/*
 	 * Read the current value of the register, set the appropriate bit
 	 * to enable the GPE, and write out the new register.
 	 */
-	status = acpi_hw_low_level_read (8, &in_byte,
-			  &acpi_gbl_gpe_register_info[register_index].enable_address, 0);
+	status = acpi_hw_low_level_read (8, &in_byte, enable_address, 0);
 	if (ACPI_FAILURE (status)) {
 		return (status);
 	}
 
 	status = acpi_hw_low_level_write (8, (in_byte | bit_mask),
-			  &acpi_gbl_gpe_register_info[register_index].enable_address, 0);
+			  enable_address, 0);
 
 	return (status);
 }
@@ -117,25 +95,22 @@ void
 acpi_hw_enable_gpe_for_wakeup (
 	u32                             gpe_number)
 {
-	u32                             register_index;
+	struct acpi_gpe_register_info	*register_info;
 	u8                              bit_mask;
 
 
 	ACPI_FUNCTION_ENTRY ();
 
 
-	/* Translate GPE number to index into global registers array. */
+	/* Get the register info for this GPE */
 
-	register_index = acpi_ev_get_gpe_register_index (gpe_number);
-
-	/* Get the register bitmask for this GPE */
-
-	bit_mask = acpi_hw_get_gpe_bit_mask (gpe_number);
+	register_info = acpi_ev_get_gpe_register_info (gpe_number);
+	bit_mask = acpi_ev_get_gpe_number_info(gpe_number)->bit_mask;
 
 	/*
 	 * Set the bit so we will not disable this when sleeping
 	 */
-	acpi_gbl_gpe_register_info[register_index].wake_enable |= bit_mask;
+	register_info->wake_enable |= bit_mask;
 }
 
 
@@ -156,34 +131,32 @@ acpi_hw_disable_gpe (
 	u32                             gpe_number)
 {
 	u32                             in_byte;
-	u32                             register_index;
+	struct acpi_gpe_register_info	*register_info;
 	u8                              bit_mask;
 	acpi_status                     status;
+	struct acpi_generic_address	*enable_address;
 
 
 	ACPI_FUNCTION_ENTRY ();
 
 
-	/* Translate GPE number to index into global registers array. */
-
-	register_index = acpi_ev_get_gpe_register_index (gpe_number);
-
-	/* Get the register bitmask for this GPE */
+	/* Get the register info for this GPE */
 
-	bit_mask = acpi_hw_get_gpe_bit_mask (gpe_number);
+	register_info = acpi_ev_get_gpe_register_info (gpe_number);
+	bit_mask = acpi_ev_get_gpe_number_info(gpe_number)->bit_mask;
+	enable_address = &register_info->enable_address;
 
 	/*
 	 * Read the current value of the register, clear the appropriate bit,
 	 * and write out the new register value to disable the GPE.
 	 */
-	status = acpi_hw_low_level_read (8, &in_byte,
-			  &acpi_gbl_gpe_register_info[register_index].enable_address, 0);
+	status = acpi_hw_low_level_read (8, &in_byte, enable_address, 0);
 	if (ACPI_FAILURE (status)) {
 		return (status);
 	}
 
 	status = acpi_hw_low_level_write (8, (in_byte & ~bit_mask),
-			  &acpi_gbl_gpe_register_info[register_index].enable_address, 0);
+			  enable_address, 0);
 	if (ACPI_FAILURE (status)) {
 		return (status);
 	}
@@ -210,25 +183,22 @@ void
 acpi_hw_disable_gpe_for_wakeup (
 	u32                             gpe_number)
 {
-	u32                             register_index;
+	struct acpi_gpe_register_info	*register_info;
 	u8                              bit_mask;
 
 
 	ACPI_FUNCTION_ENTRY ();
 
 
-	/* Translate GPE number to index into global registers array. */
+	/* Get the register info for this GPE */
 
-	register_index = acpi_ev_get_gpe_register_index (gpe_number);
-
-	/* Get the register bitmask for this GPE */
-
-	bit_mask = acpi_hw_get_gpe_bit_mask (gpe_number);
+	register_info = acpi_ev_get_gpe_register_info (gpe_number);
+	bit_mask = acpi_ev_get_gpe_number_info(gpe_number)->bit_mask;
 
 	/*
 	 * Clear the bit so we will disable this when sleeping
 	 */
-	acpi_gbl_gpe_register_info[register_index].wake_enable &= ~bit_mask;
+	register_info->wake_enable &= ~bit_mask;
 }
 
 
@@ -248,28 +218,26 @@ acpi_status
 acpi_hw_clear_gpe (
 	u32                             gpe_number)
 {
-	u32                             register_index;
+	struct acpi_gpe_register_info	*register_info;
 	u8                              bit_mask;
 	acpi_status                     status;
+	struct acpi_generic_address	*status_address;
 
 
 	ACPI_FUNCTION_ENTRY ();
 
 
-	/* Translate GPE number to index into global registers array. */
-
-	register_index = acpi_ev_get_gpe_register_index (gpe_number);
-
-	/* Get the register bitmask for this GPE */
+	/* Get the register info for this GPE */
 
-	bit_mask = acpi_hw_get_gpe_bit_mask (gpe_number);
+	register_info = acpi_ev_get_gpe_register_info (gpe_number);
+	bit_mask = acpi_ev_get_gpe_number_info(gpe_number)->bit_mask;
+	status_address = &register_info->status_address;
 
 	/*
 	 * Write a one to the appropriate bit in the status register to
 	 * clear this GPE.
 	 */
-	status = acpi_hw_low_level_write (8, bit_mask,
-			  &acpi_gbl_gpe_register_info[register_index].status_address, 0);
+	status = acpi_hw_low_level_write (8, bit_mask, status_address, 0);
 
 	return (status);
 }
@@ -292,11 +260,13 @@ acpi_hw_get_gpe_status (
 	u32                             gpe_number,
 	acpi_event_status               *event_status)
 {
-	u32                             in_byte = 0;
-	u32                             register_index = 0;
-	u8                              bit_mask = 0;
-	struct acpi_gpe_register_info   *gpe_register_info;
+	u32                             in_byte;
+	struct acpi_gpe_register_info   *register_info;
+	u8                              bit_mask;
+	struct acpi_generic_address	*enable_address;
+	struct acpi_generic_address	*status_address;
 	acpi_status                     status;
+	acpi_event_status		ev_status = 0;
 
 
 	ACPI_FUNCTION_ENTRY ();
@@ -306,44 +276,42 @@ acpi_hw_get_gpe_status (
 		return (AE_BAD_PARAMETER);
 	}
 
-	(*event_status) = 0;
-
-	/* Translate GPE number to index into global registers array. */
+	/* Get the register info for this GPE */
 
-	register_index = acpi_ev_get_gpe_register_index (gpe_number);
-	gpe_register_info = &acpi_gbl_gpe_register_info[register_index];
-
-	/* Get the register bitmask for this GPE */
-
-	bit_mask = acpi_hw_get_gpe_bit_mask (gpe_number);
+	register_info = acpi_ev_get_gpe_register_info (gpe_number);
+	bit_mask = acpi_ev_get_gpe_number_info(gpe_number)->bit_mask;
+	enable_address = &register_info->enable_address;
+	status_address = &register_info->status_address;
 
 	/* GPE Enabled? */
 
-	status = acpi_hw_low_level_read (8, &in_byte, &gpe_register_info->enable_address, 0);
+	status = acpi_hw_low_level_read (8, &in_byte, enable_address, 0);
 	if (ACPI_FAILURE (status)) {
 		return (status);
 	}
 
 	if (bit_mask & in_byte) {
-		(*event_status) |= ACPI_EVENT_FLAG_ENABLED;
+		ev_status |= ACPI_EVENT_FLAG_ENABLED;
 	}
 
 	/* GPE Enabled for wake? */
 
-	if (bit_mask & gpe_register_info->wake_enable) {
-		(*event_status) |= ACPI_EVENT_FLAG_WAKE_ENABLED;
+	if (bit_mask & register_info->wake_enable) {
+		ev_status |= ACPI_EVENT_FLAG_WAKE_ENABLED;
 	}
 
 	/* GPE active (set)? */
 
-	status = acpi_hw_low_level_read (8, &in_byte, &gpe_register_info->status_address, 0);
+	status = acpi_hw_low_level_read (8, &in_byte, status_address, 0);
 	if (ACPI_FAILURE (status)) {
 		return (status);
 	}
 
 	if (bit_mask & in_byte) {
-		(*event_status) |= ACPI_EVENT_FLAG_SET;
+		ev_status |= ACPI_EVENT_FLAG_SET;
 	}
+
+	*event_status = ev_status;
 	return (AE_OK);
 }
 
diff -urpNX dontdiff linux-2.5.59/drivers/acpi/include/acevents.h linux-2.5.59-acpi/drivers/acpi/include/acevents.h
--- linux-2.5.59/drivers/acpi/include/acevents.h	2003-02-05 13:41:04.000000000 -0500
+++ linux-2.5.59-acpi/drivers/acpi/include/acevents.h	2003-02-05 16:39:34.000000000 -0500
@@ -72,8 +72,12 @@ acpi_status
 acpi_ev_init_global_lock_handler (
 	void);
 
-u32
-acpi_ev_get_gpe_register_index (
+struct acpi_gpe_register_info *
+acpi_ev_get_gpe_register_info (
+	u32                             gpe_number);
+
+struct acpi_gpe_number_info *
+acpi_ev_get_gpe_number_info (
 	u32                             gpe_number);
 
 u32
diff -urpNX dontdiff linux-2.5.59/drivers/acpi/include/achware.h linux-2.5.59-acpi/drivers/acpi/include/achware.h
--- linux-2.5.59/drivers/acpi/include/achware.h	2003-02-05 13:41:04.000000000 -0500
+++ linux-2.5.59-acpi/drivers/acpi/include/achware.h	2003-02-05 14:44:17.000000000 -0500
@@ -96,10 +96,6 @@ acpi_hw_clear_acpi_status (
 
 /* GPE support */
 
-u8
-acpi_hw_get_gpe_bit_mask (
-	u32                             gpe_number);
-
 acpi_status
 acpi_hw_enable_gpe (
 	u32                             gpe_number);

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
