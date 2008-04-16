From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 7/7] Who controls brightness functionality: vendor specific
	or generic video driver
Date: Wed, 16 Apr 2008 21:02:52 +0200
Message-ID: <1208372572.1784.352.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41862 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbYDPTCx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2008 15:02:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

Who controls brightness functionality: vendor specific or generic video driver

Depending on the capablity of ACPI graphics devices and whether they implement
all necessary functions so that the generic ACPI video driver can control
them, decide at driver load time whether a vendor specific device driver or
the ACPI video driver should control the brighntess functionality.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/misc/acer-wmi.c       |   15 +++++++++++----
 drivers/misc/asus-laptop.c    |    6 ++++++
 drivers/misc/fujitsu-laptop.c |   27 +++++++++++++++++++--------
 drivers/misc/msi-laptop.c     |   16 +++++++++++-----
 drivers/misc/sony-laptop.c    |   14 +++++++++-----
 drivers/misc/thinkpad_acpi.c  |    7 +++++++
 6 files changed, 63 insertions(+), 22 deletions(-)

Index: linux-acpi-2.6_video_native_vs_vendor/drivers/misc/asus-laptop.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/misc/asus-laptop.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/misc/asus-laptop.c
@@ -1105,6 +1105,12 @@ static int asus_backlight_init(struct de
 {
 	struct backlight_device *bd;
 
+	if (acpi_video_support & ACPI_VIDEO_BRIGHTNESS &&
+	    !(acpi_video_support & ACPI_VIDEO_FORCE_VENDOR_SPECIFIC)) {
+		printk(ASUS_INFO "Brightness ignored, must be controlled by "
+		       "ACPI video driver\n");
+		return -ENODEV;
+	}
 	if (brightness_set_handle && lcd_switch_handle) {
 		bd = backlight_device_register(ASUS_HOTK_FILE, dev,
 					       NULL, &asusbl_ops);
Index: linux-acpi-2.6_video_native_vs_vendor/drivers/misc/thinkpad_acpi.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/misc/thinkpad_acpi.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/misc/thinkpad_acpi.c
@@ -4381,6 +4381,13 @@ static int __init brightness_init(struct
 			   "module parameter\n");
 		return 1;
 	} else if (brightness_enable > 1) {
+		if ((acpi_video_support & ACPI_VIDEO_BRIGHTNESS) &&
+		    !(acpi_video_support & ACPI_VIDEO_FORCE_VENDOR_SPECIFIC)) {
+			printk(TPACPI_INFO "Brightness ignored, must be "
+			       "controlled by ACPI video driver\n");
+			return 1;
+		}
+		/* Above, generic approach should make this check obsolete */
 		if (brightness_check_std_acpi_support()) {
 			printk(TPACPI_NOTICE
 			       "standard ACPI backlight interface "
Index: linux-acpi-2.6_video_native_vs_vendor/drivers/misc/fujitsu-laptop.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/misc/fujitsu-laptop.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/misc/fujitsu-laptop.c
@@ -273,13 +273,21 @@ static int __init fujitsu_init(void)
 
 	/* Register backlight stuff */
 
-	fujitsu->bl_device =
-	    backlight_device_register("fujitsu-laptop", NULL, NULL,
-				      &fujitsubl_ops);
-	if (IS_ERR(fujitsu->bl_device))
-		return PTR_ERR(fujitsu->bl_device);
+	if (acpi_video_support & ACPI_VIDEO_BRIGHTNESS &&
+	    !(acpi_video_support & ACPI_VIDEO_FORCE_VENDOR_SPECIFIC)) {
+		printk(KERN_INFO "Brightness ignored, must be controlled by "
+		       "ACPI video driver\n");
+	} else {
+		fujitsu->bl_device =
+			backlight_device_register("fujitsu-laptop", NULL, NULL,
+						  &fujitsubl_ops);
+		if (IS_ERR(fujitsu->bl_device))
+			return PTR_ERR(fujitsu->bl_device);
+
+		fujitsu->bl_device->props.max_brightness =
+			FUJITSU_LCD_N_LEVELS - 1;
+	}
 
-	fujitsu->bl_device->props.max_brightness = FUJITSU_LCD_N_LEVELS - 1;
 	ret = platform_driver_register(&fujitsupf_driver);
 	if (ret)
 		goto fail_backlight;
@@ -321,7 +329,8 @@ static int __init fujitsu_init(void)
 
       fail_backlight:
 
-	backlight_device_unregister(fujitsu->bl_device);
+	if (fujitsu->bl_device)
+		backlight_device_unregister(fujitsu->bl_device);
 
       fail_acpi:
 
@@ -336,9 +345,11 @@ static void __exit fujitsu_cleanup(void)
 			   &fujitsupf_attribute_group);
 	platform_device_unregister(fujitsu->pf_device);
 	platform_driver_unregister(&fujitsupf_driver);
+
 	backlight_device_unregister(fujitsu->bl_device);
 
-	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
+	if (fujitsu->bl_device)
+		acpi_bus_unregister_driver(&acpi_fujitsu_driver);
 
 	kfree(fujitsu);
 
Index: linux-acpi-2.6_video_native_vs_vendor/drivers/misc/acer-wmi.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/misc/acer-wmi.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/misc/acer-wmi.c
@@ -837,7 +837,8 @@ static int __devinit acer_backlight_init
 
 static void acer_backlight_exit(void)
 {
-	backlight_device_unregister(acer_backlight_device);
+	if (acer_backlight_device)
+		backlight_device_unregister(acer_backlight_device);
 }
 
 /*
@@ -907,9 +908,15 @@ static int __devinit acer_platform_probe
 	}
 
 	if (has_cap(ACER_CAP_BRIGHTNESS)) {
-		err = acer_backlight_init(&device->dev);
-		if (err)
-			goto error_brightness;
+		if (acpi_video_support & ACPI_VIDEO_BRIGHTNESS &&
+		    !(acpi_video_support & ACPI_VIDEO_FORCE_VENDOR_SPECIFIC))
+			printk(ACER_INFO "Brightness must be controlled by "
+			       "generic video driver\n");
+		else {
+			err = acer_backlight_init(&device->dev);
+			if (err)
+				goto error_brightness;
+		}
 	}
 
 	return 0;
Index: linux-acpi-2.6_video_native_vs_vendor/drivers/misc/sony-laptop.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/misc/sony-laptop.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/misc/sony-laptop.c
@@ -1037,7 +1037,12 @@ static int sony_nc_add(struct acpi_devic
 		goto outinput;
 	}
 
-	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT", &handle))) {
+	if (acpi_video_support & ACPI_VIDEO_BRIGHTNESS &&
+	    !(acpi_video_support & ACPI_VIDEO_FORCE_VENDOR_SPECIFIC)) {
+		printk(KERN_INFO DRV_PFX "Sony: Brightness ignored, must be "
+		       "controlled by ACPI video driver\n");
+	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",
+						&handle))) {
 		sony_backlight_device = backlight_device_register("sony", NULL,
 								  NULL,
 								  &sony_backlight_ops);
@@ -1047,12 +1052,11 @@ static int sony_nc_add(struct acpi_devic
 			sony_backlight_device = NULL;
 		} else {
 			sony_backlight_device->props.brightness =
-			    sony_backlight_get_brightness
-			    (sony_backlight_device);
+				sony_backlight_get_brightness
+				(sony_backlight_device);
 			sony_backlight_device->props.max_brightness =
-			    SONY_MAX_BRIGHTNESS - 1;
+				SONY_MAX_BRIGHTNESS - 1;
 		}
-
 	}
 
 	/* initialize models with specific requirements */
Index: linux-acpi-2.6_video_native_vs_vendor/drivers/misc/msi-laptop.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/misc/msi-laptop.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/misc/msi-laptop.c
@@ -347,12 +347,18 @@ static int __init msi_init(void)
 
 	/* Register backlight stuff */
 
-	msibl_device = backlight_device_register("msi-laptop-bl", NULL, NULL,
-						&msibl_ops);
-	if (IS_ERR(msibl_device))
-		return PTR_ERR(msibl_device);
+	if ((acpi_video_support & ACPI_VIDEO_BRIGHTNESS) &&
+	    !(acpi_video_support & ACPI_VIDEO_FORCE_VENDOR_SPECIFIC)) {
+		printk(KERN_INFO "MSI: Brightness ignored, must be controlled "
+		       "by ACPI video driver\n");
+	} else {
+		msibl_device = backlight_device_register("msi-laptop-bl", NULL,
+							 NULL, &msibl_ops);
+		if (IS_ERR(msibl_device))
+			return PTR_ERR(msibl_device);
 
-	msibl_device->props.max_brightness = MSI_LCD_LEVEL_MAX-1;
+		msibl_device->props.max_brightness = MSI_LCD_LEVEL_MAX-1;
+	}
 
 	ret = platform_driver_register(&msipf_driver);
 	if (ret)


