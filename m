From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 1/9] misc cleanups
Date: Wed, 18 Jan 2006 22:26:13 +0100
Message-ID: <20060118212613.GB7199@hell.org.pl>
References: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:5648 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S964931AbWARV0Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 16:26:16 -0500
Content-Disposition: inline
In-Reply-To: <20060118212110.GA7199@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This patch updates the version string, copyright notices and does
whitespace cleanup (it looks weird, blame Lindent).

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2006-01-18 17:21:37.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2006-01-18 18:31:18.000000000 +0100
@@ -2,7 +2,7 @@
  *  asus_acpi.c - Asus Laptop ACPI Extras
  *
  *
- *  Copyright (C) 2002, 2003, 2004 Julien Lerouge, Karol Kozimor
+ *  Copyright (C) 2002-2005 Julien Lerouge, 2003-2006 Karol Kozimor
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -27,10 +27,6 @@
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting point.
  *
- *  TODO:
- *  add Fn key status
- *  Add mode selection on module loading (parameter) -> still necessary?
- *  Complete display switching -- may require dirty hacks or calling _DOS?
  */
 
 #include <linux/kernel.h>
@@ -42,7 +38,7 @@
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 
-#define ASUS_ACPI_VERSION "0.29"
+#define ASUS_ACPI_VERSION "0.30"
 
 #define PROC_ASUS       "asus"	//the directory
 #define PROC_MLED       "mled"
@@ -149,17 +145,8 @@
 
 static struct model_data model_conf[END_MODEL] = {
 	/*
-	 * Those pathnames are relative to the HOTK / ATKD device :
-	 *       - mt_mled
-	 *       - mt_wled
-	 *       - brightness_set
-	 *       - brightness_get
-	 *       - display_set
-	 *       - display_get
-	 *
 	 * TODO I have seen a SWBX and AIBX method on some models, like L1400B,
 	 * it seems to be a kind of switch, but what for ?
-	 *
 	 */
 
 	{
@@ -993,7 +980,7 @@
 	if (buffer.pointer == NULL)
 		return -EINVAL;
 
-	model = (union acpi_object *) buffer.pointer;
+	model = (union acpi_object *)buffer.pointer;
 	/*
 	 * Samsung P30 has a device with a valid _HID whose INIT does not 
 	 * return anything. It used to be possible to catch this exception,
@@ -1002,7 +989,8 @@
 	 * identifier but it's still possible to get completely bogus data.
 	 */
 	if (model->type == ACPI_TYPE_STRING) {
-		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
+		printk(KERN_NOTICE "  %s model detected, ",
+		       model->string.pointer);
 	} else {
 		if (asus_info &&	/* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
@@ -1016,7 +1004,7 @@
 			       "the developers with your DSDT\n");
 		}
 		hotk->methods = &model_conf[hotk->model];
-		
+
 		acpi_os_free(model);
 
 		return AE_OK;
@@ -1162,8 +1150,7 @@
 	/* For laptops without GPLV: init the hotk->brightness value */
 	if ((!hotk->methods->brightness_get)
 	    && (!hotk->methods->brightness_status)
-	    && (hotk->methods->brightness_up
-		&& hotk->methods->brightness_down)) {
+	    && (hotk->methods->brightness_up && hotk->methods->brightness_down)) {
 		status =
 		    acpi_evaluate_object(NULL, hotk->methods->brightness_down,
 					 NULL, NULL);
