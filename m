From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Linux sleep support differs from spec...
Date: Sun, 29 Aug 2004 14:09:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040829120927.GA2462@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: nate-Y6VGUYTwhu0@public.gmane.org, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Nate identified quite a few points where linux sleep is broken
implementation differs from specs). See "Acer TM 661 does..." mails.

I thought "oh so that's why compaq notebooks do not sleep", and tried
to fix them. It did not help. (Compaq notebooks do not even *enter*
S3).

Nate, does this address your concerns? [Or did I do something wrong?]

								Pavel

--- clean/drivers/acpi/hardware/hwsleep.c	2004-04-05 16:50:18.000000000 +0200
+++ linux/drivers/acpi/hardware/hwsleep.c	2004-08-29 01:16:23.000000000 +0200
@@ -189,11 +189,6 @@
 		return_ACPI_STATUS (status);
 	}
 
-	status = acpi_evaluate_object (NULL, METHOD_NAME__GTS, &arg_list, NULL);
-	if (ACPI_FAILURE (status) && status != AE_NOT_FOUND) {
-		return_ACPI_STATUS (status);
-	}
-
 	/* Setup the argument to _SST */
 
 	switch (sleep_state) {
@@ -250,7 +245,8 @@
 	struct acpi_bit_register_info   *sleep_enable_reg_info;
 	u32                             in_value;
 	acpi_status                     status;
-
+	union acpi_object           arg;
+	struct acpi_object_list     arg_list;
 
 	ACPI_FUNCTION_TRACE ("acpi_enter_sleep_state");
 
@@ -303,6 +299,17 @@
 	}
 	ACPI_DEBUG_PRINT ((ACPI_DB_INIT, "Entering sleep state [S%d]\n", sleep_state));
 
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = sleep_state;
+
+	status = acpi_evaluate_object (NULL, METHOD_NAME__GTS, &arg_list, NULL);
+	if (ACPI_FAILURE (status) && status != AE_NOT_FOUND) {
+		return_ACPI_STATUS (status);
+	}
+
 	/* Clear SLP_EN and SLP_TYP fields */
 
 	PM1Acontrol &= ~(sleep_type_reg_info->access_bit_mask | sleep_enable_reg_info->access_bit_mask);
@@ -311,7 +318,8 @@
 	/* Insert SLP_TYP bits */
 
 	PM1Acontrol |= (acpi_gbl_sleep_type_a << sleep_type_reg_info->bit_position);
-	PM1Bcontrol |= (acpi_gbl_sleep_type_b << sleep_type_reg_info->bit_position);
+	PM1Acontrol |= (acpi_gbl_sleep_type_b << sleep_type_reg_info->bit_position);
+	PM1Bcontrol = PM1Acontrol;
 
 	/*
 	 * We split the writes of SLP_TYP and SLP_EN to workaround
@@ -320,15 +328,17 @@
 
 	/* Write #1: fill in SLP_TYP data */
 
-	status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1A_CONTROL, PM1Acontrol);
+	status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_CONTROL, PM1Acontrol);
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
 
+#if 0
 	status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1B_CONTROL, PM1Bcontrol);
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
+#endif
 
 	/* Insert SLP_ENABLE bit */
 
@@ -339,17 +349,20 @@
 
 	ACPI_FLUSH_CPU_CACHE ();
 
-	status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1A_CONTROL, PM1Acontrol);
+	status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_CONTROL, PM1Acontrol);
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
 
+#if 0
 	status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1B_CONTROL, PM1Bcontrol);
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
+#endif
 
-	if (sleep_state > ACPI_STATE_S3) {
+//	if (sleep_state > ACPI_STATE_S3) {
+	if (1) {
 		/*
 		 * We wanted to sleep > S3, but it didn't happen (by virtue of the fact that
 		 * we are still executing!)










-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
