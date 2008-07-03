From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 3 Jul 2008 18:08:59 +0200
Message-ID: <200807031809.03172.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: ak@linux.intel.com
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

Zhang: You showed me once, how IGD detection could be enhance, but I
didn't find it anymore...
---

Check for backlight support via ACPI video.ko otherwise use vendor ACPI 
drivers

If an ACPI graphics device supports backlight brightness functions (cmp. with
latest ACPI spec Appendix B), let the ACPI video driver control backlight and
switch backlight control off in vendor specific ACPI drivers (asus_acpi,
thinkpad_acpi, eeepc, fujitsu_laptop, msi_laptop, sony_laptop, acer-wmi).
An exception is if we find an IGD device. Linux does not have a driver
for this yet. Then do not use video.ko, but allow vendor specific acpi
drivers to switch in the legacy way.

Currently it is possible to load above drivers and let both poke on the
brightness HW registers, the video and vendor specific ACPI drivers.

acpi_vendor=backlight forces video.ko to keep its fingers off backlight 
control
                      even it would find needed functions. The corresponding
                      vendor specific driver be used then.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 Documentation/kernel-parameters.txt |    7 +
 drivers/acpi/Makefile               |    5 
 drivers/acpi/pci_root.c             |    6 +
 drivers/acpi/scan.c                 |   32 -----
 drivers/acpi/video.c                |   28 ++---
 drivers/acpi/video_detect.c         |  199 
++++++++++++++++++++++++++++++++++++
 drivers/misc/acer-wmi.c             |    6 +
 drivers/misc/asus-laptop.c          |   10 +
 drivers/misc/eeepc-laptop.c         |   12 +-
 drivers/misc/fujitsu-laptop.c       |   21 +++
 drivers/misc/msi-laptop.c           |   16 +-
 drivers/misc/sony-laptop.c          |    6 -
 drivers/misc/thinkpad_acpi.c        |   66 +++++++++--
 include/linux/acpi.h                |   39 +++++++
 14 files changed, 382 insertions(+), 71 deletions(-)

Index: linux-2.6.25/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.25.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.25/Documentation/kernel-parameters.txt
@@ -196,6 +196,13 @@ and is between 256 and 4096 characters. 
 			that require a timer override, but don't have
 			HPET
 
+	acpi_vendor=	[HW,ACPI]
+			acpi_vendor=backlight
+			acpi_vendor=display_output
+			Tries to force the use of a vendor specific ACPI
+			driver for backlight and display_output
+			switching. You can add both, separated by comma.
+
 	acpi.debug_layer=	[HW,ACPI]
 			Format: <int>
 			Each bit of the <int> indicates an ACPI debug layer,
Index: linux-2.6.25/drivers/acpi/Makefile
===================================================================
--- linux-2.6.25.orig/drivers/acpi/Makefile
+++ linux-2.6.25/drivers/acpi/Makefile
@@ -46,7 +46,12 @@ obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_DOCK)		+= dock.o
 obj-$(CONFIG_ACPI_BAY)		+= bay.o
+
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
+ifdef CONFIG_ACPI_VIDEO
+obj-y				+= video_detect.o
+endif
+
 obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 obj-$(CONFIG_ACPI_POWER)	+= power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
Index: linux-2.6.25/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.25.orig/drivers/acpi/pci_root.c
+++ linux-2.6.25/drivers/acpi/pci_root.c
@@ -388,6 +388,12 @@ static int __init acpi_pci_root_init(voi
 	if (acpi_bus_register_driver(&acpi_pci_root_driver) < 0)
 		return -ENODEV;
 
+	/* We must check whether the ACPI graphics device is physically plugged
+	 * in. Therefore this must be called after binding PCI and ACPI devices,
+	 * but before modules are loaded, so that we know which module should
+	 * be responsible depending on what the BIOS provides us.
+	 */
+	acpi_video_get_capabilities();
 	return 0;
 }
 
Index: linux-2.6.25/drivers/acpi/scan.c
===================================================================
--- linux-2.6.25.orig/drivers/acpi/scan.c
+++ linux-2.6.25/drivers/acpi/scan.c
@@ -919,36 +919,6 @@ static void acpi_device_get_busid(struct
 	}
 }
 
-static int
-acpi_video_bus_match(struct acpi_device *device)
-{
-	acpi_handle h_dummy;
-
-	if (!device)
-		return -EINVAL;
-
-	/* Since there is no HID, CID for ACPI Video drivers, we have
-	 * to check well known required nodes for each feature we support.
-	 */
-
-	/* Does this device able to support video switching ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy)))
-		return 0;
-
-	/* Does this device able to retrieve a video ROM ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy)))
-		return 0;
-
-	/* Does this device able to configure which video head to be POSTed ? */
-	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy)) &&
-	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy)))
-		return 0;
-
-	return -ENODEV;
-}
-
 /*
  * acpi_bay_match - see if a device is an ejectable driver bay
  *
@@ -1031,7 +1001,7 @@ static void acpi_device_set_id(struct ac
 		   will get autoloaded and the device might still match
 		   against another driver.
 		*/
-		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
+		if (acpi_is_video_device(device))
 			cid_add = ACPI_VIDEO_HID;
 		else if (ACPI_SUCCESS(acpi_bay_match(device)))
 			cid_add = ACPI_BAY_HID;
Index: linux-2.6.25/drivers/misc/acer-wmi.c
===================================================================
--- linux-2.6.25.orig/drivers/misc/acer-wmi.c
+++ linux-2.6.25/drivers/misc/acer-wmi.c
@@ -1100,6 +1100,12 @@ static int __init acer_wmi_init(void)
 		return -ENODEV;
 	}
 
+	if (!acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
+		interface->capability &= ~ACER_CAP_BRIGHTNESS;
+		printk(ACER_INFO "Brightness must be controlled by "
+		       "generic video driver\n");
+	}
+
 	if (platform_driver_register(&acer_platform_driver)) {
 		printk(ACER_ERR "Unable to register platform driver.\n");
 		goto error_platform_register;
Index: linux-2.6.25/drivers/misc/asus-laptop.c
===================================================================
--- linux-2.6.25.orig/drivers/misc/asus-laptop.c
+++ linux-2.6.25/drivers/misc/asus-laptop.c
@@ -1207,9 +1207,13 @@ static int __init asus_laptop_init(void)
 
 	dev = acpi_get_physical_device(hotk->device->handle);
 
-	result = asus_backlight_init(dev);
-	if (result)
-		goto fail_backlight;
+	if (!acpi_video_backlight_support()) {
+		result = asus_backlight_init(dev);
+		if (result)
+			goto fail_backlight;
+	} else
+		printk(ASUS_INFO "Brightness ignored, must be controlled by "
+		       "ACPI video driver\n");
 
 	result = asus_led_init(dev);
 	if (result)
Index: linux-2.6.25/drivers/misc/eeepc-laptop.c
===================================================================
--- linux-2.6.25.orig/drivers/misc/eeepc-laptop.c
+++ linux-2.6.25/drivers/misc/eeepc-laptop.c
@@ -625,9 +625,15 @@ static int __init eeepc_laptop_init(void
 		return -ENODEV;
 	}
 	dev = acpi_get_physical_device(ehotk->device->handle);
-	result = eeepc_backlight_init(dev);
-	if (result)
-		goto fail_backlight;
+
+	if (!acpi_video_backlight_support()) {
+		result = eeepc_backlight_init(dev);
+		if (result)
+			goto fail_backlight;
+	} else
+		printk(EEEPC_INFO "Backlight controlled by ACPI video "
+		       "driver\n");
+
 	result = eeepc_hwmon_init(dev);
 	if (result)
 		goto fail_hwmon;
Index: linux-2.6.25/drivers/misc/fujitsu-laptop.c
===================================================================
--- linux-2.6.25.orig/drivers/misc/fujitsu-laptop.c
+++ linux-2.6.25/drivers/misc/fujitsu-laptop.c
@@ -279,7 +279,20 @@ static int __init fujitsu_init(void)
 	if (IS_ERR(fujitsu->bl_device))
 		return PTR_ERR(fujitsu->bl_device);
 
-	fujitsu->bl_device->props.max_brightness = FUJITSU_LCD_N_LEVELS - 1;
+	if (acpi_video_backlight_support()) {
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
+
 	ret = platform_driver_register(&fujitsupf_driver);
 	if (ret)
 		goto fail_backlight;
@@ -321,7 +334,8 @@ static int __init fujitsu_init(void)
 
       fail_backlight:
 
-	backlight_device_unregister(fujitsu->bl_device);
+	if (fujitsu->bl_device)
+		backlight_device_unregister(fujitsu->bl_device);
 
       fail_acpi:
 
@@ -336,7 +350,8 @@ static void __exit fujitsu_cleanup(void)
 			   &fujitsupf_attribute_group);
 	platform_device_unregister(fujitsu->pf_device);
 	platform_driver_unregister(&fujitsupf_driver);
-	backlight_device_unregister(fujitsu->bl_device);
+	if (fujitsu->bl_device)
+		backlight_device_unregister(fujitsu->bl_device);
 
 	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
 
Index: linux-2.6.25/drivers/misc/msi-laptop.c
===================================================================
--- linux-2.6.25.orig/drivers/misc/msi-laptop.c
+++ linux-2.6.25/drivers/misc/msi-laptop.c
@@ -347,12 +347,16 @@ static int __init msi_init(void)
 
 	/* Register backlight stuff */
 
-	msibl_device = backlight_device_register("msi-laptop-bl", NULL, NULL,
-						&msibl_ops);
-	if (IS_ERR(msibl_device))
-		return PTR_ERR(msibl_device);
-
-	msibl_device->props.max_brightness = MSI_LCD_LEVEL_MAX-1;
+	if (acpi_video_backlight_support()) {
+		printk(KERN_INFO "MSI: Brightness ignored, must be controlled "
+		       "by ACPI video driver\n");
+	} else {
+		msibl_device = backlight_device_register("msi-laptop-bl", NULL,
+							 NULL, &msibl_ops);
+		if (IS_ERR(msibl_device))
+			return PTR_ERR(msibl_device);
+		msibl_device->props.max_brightness = MSI_LCD_LEVEL_MAX-1;
+	}
 
 	ret = platform_driver_register(&msipf_driver);
 	if (ret)
Index: linux-2.6.25/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.25.orig/drivers/misc/sony-laptop.c
+++ linux-2.6.25/drivers/misc/sony-laptop.c
@@ -1037,7 +1037,11 @@ static int sony_nc_add(struct acpi_devic
 		goto outinput;
 	}
 
-	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT", &handle))) {
+	if (!acpi_video_backlight_support()) {
+		printk(KERN_INFO DRV_PFX "Sony: Brightness ignored, must be "
+		       "controlled by ACPI video driver\n");
+	} else if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "GBRT",
+						&handle))) {
 		sony_backlight_device = backlight_device_register("sony", NULL,
 								  NULL,
 								  &sony_backlight_ops);
Index: linux-2.6.25/drivers/misc/thinkpad_acpi.c
===================================================================
--- linux-2.6.25.orig/drivers/misc/thinkpad_acpi.c
+++ linux-2.6.25/drivers/misc/thinkpad_acpi.c
@@ -233,6 +233,7 @@ static struct {
 	u32 light_status:1;
 	u32 bright_16levels:1;
 	u32 bright_acpimode:1;
+	u32 bright_igdmode:1;
 	u32 wan:1;
 	u32 fan_ctrl_status_undef:1;
 	u32 input_device_registered:1;
@@ -2299,6 +2300,9 @@ err_exit:
 	return (res < 0)? res : 1;
 }
 
+static struct backlight_device *ibm_backlight_device;
+static int brightness_update_status(struct backlight_device *bd);
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
@@ -2337,6 +2341,28 @@ static void hotkey_notify(struct ibm_str
 		case 1:
 			/* 0x1000-0x1FFF: key presses */
 			scancode = hkey & 0xfff;
+			if (tp_features.bright_igdmode) {
+				/* ToDo:
+				 * Is there an already defined key?
+				 */
+				if (hkey == 0x1011) {
+					if (ibm_backlight_device->
+					    props.brightness > 0) {
+						ibm_backlight_device->
+							props.brightness--;
+					}
+				} else if (hkey == 0x1010) {
+					if (ibm_backlight_device->
+					    props.brightness <
+					    ibm_backlight_device->
+					    props.max_brightness) {
+						ibm_backlight_device->
+							props.brightness++;
+					}
+				}
+				brightness_update_status(ibm_backlight_device);
+			}
+
 			if (scancode > 0 && scancode < 0x21) {
 				scancode--;
 				if (!(hotkey_source_mask & (1 << scancode))) {
@@ -4599,7 +4625,6 @@ enum {
 	TP_EC_BACKLIGHT_MAPSW = 0x20,
 };
 
-static struct backlight_device *ibm_backlight_device;
 static int brightness_mode;
 static unsigned int brightness_enable = 2; /* 2 = auto, 0 = no, 1 = yes */
 
@@ -4738,7 +4763,7 @@ static struct backlight_ops ibm_backligh
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
-
+	long acpi_video_support;
 	vdbg_printk(TPACPI_DBG_INIT, "initializing brightness subdriver\n");
 
 	mutex_init(&brightness_mutex);
@@ -4750,16 +4775,33 @@ static int __init brightness_init(struct
 	 */
 	b = tpacpi_check_std_acpi_brightness_support();
 	if (b > 0) {
-		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
-			printk(TPACPI_NOTICE
-			       "Lenovo BIOS switched to ACPI backlight "
-			       "control mode\n");
-		}
-		if (brightness_enable > 1) {
-			printk(TPACPI_NOTICE
-			       "standard ACPI backlight interface "
-			       "available, not loading native one...\n");
-			return 1;
+
+		if (acpi_video_backlight_support()) {
+			if (brightness_enable > 1) {
+				printk(TPACPI_NOTICE
+				       "standard ACPI backlight interface "
+				       "available, not loading native one.\n");
+				return 1;
+			} else if (brightness_enable == 1) {
+				printk(TPACPI_NOTICE
+				       "Backlight control force, even standard "
+				       "ACPI backlight interface available\n");
+			}
+		} else {
+			if (brightness_enable > 1) {
+				printk(TPACPI_NOTICE
+				       "Standard, but not supported ACPI "
+				       "backlight interface available,"
+				       " probably an IGD device - handled in"
+				       " legacy way\n");
+			}
+			/* We have an Integrated Graphics Device
+			 * BIOS won't switch, we have to do it ourselves
+			 * as long as no IGD driver exists
+			*/
+			acpi_video_support = acpi_video_get_capabilities();
+			if (acpi_video_support & ACPI_VIDEO_IGD)
+				tp_features.bright_igdmode = 1;
 		}
 	}
 
Index: linux-2.6.25/include/linux/acpi.h
===================================================================
--- linux-2.6.25.orig/include/linux/acpi.h
+++ linux-2.6.25/include/linux/acpi.h
@@ -201,6 +201,45 @@ extern bool wmi_has_guid(const char *gui
 
 #endif	/* CONFIG_ACPI_WMI */
 
+#define ACPI_VIDEO_OUTPUT_SWITCHING			1
+#define ACPI_VIDEO_DEVICE_POSTING			2
+#define ACPI_VIDEO_ROM_AVAILABLE			4
+#define ACPI_VIDEO_BACKLIGHT				8
+#define ACPI_VIDEO_IGD					16
+#define ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR		32
+#define ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR	64
+
+#if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
+
+extern long acpi_video_get_capabilities(void);
+extern long acpi_is_video_device(struct acpi_device *device);
+extern int acpi_video_backlight_support(void);
+extern int acpi_video_display_switch_support(void);
+
+#else
+
+static inline long acpi_video_get_capabilities(void)
+{
+	return 0;
+}
+
+static inline long acpi_is_video_device(struct acpi_device *device)
+{
+	return 0;
+}
+
+static inline int acpi_video_backlight_support(void)
+{
+	return 0;
+}
+
+static inline int acpi_video_display_switch_support(void)
+{
+	return 0;
+}
+
+#endif /* defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE) */
+
 extern int acpi_blacklisted(void);
 #ifdef CONFIG_DMI
 extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
Index: linux-2.6.25/drivers/acpi/video_detect.c
===================================================================
--- /dev/null
+++ linux-2.6.25/drivers/acpi/video_detect.c
@@ -0,0 +1,199 @@
+/*
+ * video_detect.c:
+ * Provides acpi_is_video_device() for early scanning of ACPI devices in 
scan.c
+ * There a Linux specific (Spec does not provide a HID for video devices) is
+ * assinged
+ *
+ * After PCI devices are glued with ACPI devices
+ * acpi_get_physical_pci_device() can be called to identify ACPI graphics
+ * devices for which a real graphics card is plugged in
+ *
+ * Now acpi_video_get_capabilities() can be called to check which
+ * capabilities the graphics cards plugged in support.
+ *
+ * Depending on whether ACPI graphics extensions (cmp. ACPI spec Appendix B)
+ * are available, video.ko should be used to handle the device.
+ *
+ * Otherwise vendor specific drivers like thinkpad_acpi, asus_acpi,
+ * sony_acpi,... can take care about backlight brightness and display output
+ * switching.
+ *
+ * Copyright 2008   Thomas Renninger <trenn@suse.de>
+ */
+
+/* If video.ko is not selected, we do not need to protect vendor acpi drivers 
*/
+
+#include <linux/acpi.h>
+
+ACPI_MODULE_NAME("video");
+#define ACPI_VIDEO_COMPONENT		0x08000000
+#define _COMPONENT		ACPI_VIDEO_COMPONENT
+
+/* video/backlight support */
+#define ACPI_VIDEO_OUTPUT_SWITCHING			1
+#define ACPI_VIDEO_DEVICE_POSTING			2
+#define ACPI_VIDEO_ROM_AVAILABLE			4
+#define ACPI_VIDEO_BACKLIGHT				8
+#define ACPI_VIDEO_IGD					16
+#define ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR		32
+#define ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR	64
+
+static long acpi_video_support = -1;
+
+static acpi_status
+acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
+			  void **retyurn_value)
+{
+	long *cap = context;
+	acpi_handle h_dummy;
+
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy))) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
+				  "support\n"));
+		*cap |= ACPI_VIDEO_BACKLIGHT;
+		return 0;
+	}
+	return -ENODEV;
+}
+
+/* Returns true if the device is a video device which can be handled by
+ * video.ko.
+ * The device will get a Linux specific CID added in scan.c to
+ * identify the device as an ACPI graphics device
+ * Be aware that the graphics device may not be physically present
+ * Use acpi_video_get_capabilities() to detect general ACPI video
+ * capabilities of present cards
+ */
+long acpi_is_video_device(struct acpi_device *device)
+{
+	acpi_handle h_dummy;
+	long video_caps = 0;
+
+	if (!device)
+		return 0;
+
+	/* Since there is no HID, CID for ACPI Video drivers, we have
+	 * to check well known required nodes for each feature we support.
+	 */
+
+	/* Does this device able to support video switching ? */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS", &h_dummy)))
+		video_caps |= ACPI_VIDEO_OUTPUT_SWITCHING;
+
+	/* Does this device able to retrieve a video ROM ? */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM", &h_dummy)))
+		video_caps |= ACPI_VIDEO_ROM_AVAILABLE;
+
+	/* Does this device able to configure which video head to be POSTed ? */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD", &h_dummy)))
+		video_caps |= ACPI_VIDEO_DEVICE_POSTING;
+
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "DRDY", &h_dummy))) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IGD device\n"));
+		video_caps |= ACPI_VIDEO_IGD;
+	}
+
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle, ACPI_UINT32_MAX,
+			    acpi_backlight_cap_match, &video_caps, NULL);
+
+	return video_caps;
+}
+EXPORT_SYMBOL(acpi_is_video_device);
+
+static acpi_status
+find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	long *cap = context;
+	struct device *dev;
+	struct acpi_device *acpi_dev;
+
+	const struct acpi_device_id video_ids[] = {
+		{ACPI_VIDEO_HID, 0},
+		{"", 0},
+	};
+	acpi_bus_get_device(handle, &acpi_dev);
+
+	if (!acpi_match_device_ids(acpi_dev, video_ids)) {
+		dev = acpi_get_physical_pci_device(handle);
+		if (!dev)
+			return AE_OK;
+		put_device(dev);
+		*cap |= acpi_is_video_device(acpi_dev);
+		printk(KERN_INFO "We have 0x%lX vid support\n", *cap);
+	}
+	return AE_OK;
+}
+
+long acpi_video_get_capabilities(void)
+{
+	/* already detected video capabilities as long as grahpics cards
+	 * hotplugging is not an issue check once should be ok.
+	 */
+	if (acpi_video_support >= 0)
+		return acpi_video_support;
+	acpi_video_support = 0;
+
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			    ACPI_UINT32_MAX, find_video, &acpi_video_support, NULL);
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "We have 0x%lX video support\n",
+			  acpi_video_support));
+	return acpi_video_support;
+}
+EXPORT_SYMBOL(acpi_video_get_capabilities);
+
+/* Returns true if video.ko can do backlight switching
+ *
+ * ToDo: Remove the IGD check as soon as there is a working driver
+ * for it available
+ */
+int acpi_video_backlight_support(void)
+{
+
+	if (acpi_video_support & ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR)
+		return 0;
+
+	return (acpi_video_support & ACPI_VIDEO_BACKLIGHT) &&
+		!(acpi_video_support & ACPI_VIDEO_IGD);
+}
+EXPORT_SYMBOL(acpi_video_backlight_support);
+
+/* Returns true if video.ko can do display output switching.
+ * This does not work well/at all with binary graphics drivers
+ * which disable system io ranges and do it on their own.
+ *
+ * It should work well when we have an IGD driver for Intel
+ * graphics cards.
+ */
+int acpi_video_display_switch_support(void)
+{
+
+	if (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR)
+		return 0;
+	return (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING) &&
+		!(acpi_video_support & ACPI_VIDEO_IGD);
+}
+EXPORT_SYMBOL(acpi_video_display_switch_support);
+
+/* Use acpi_video_vendor=backlight,display_output
+ * To force that backlight or display output switching is processed by vendor
+ * specific acpi drivers instead of the ACPI video.ko driver
+ */
+int __init acpi_vendor(char *str)
+{
+	if (str == NULL || *str == '\0')
+		return 1;
+	else {
+		if (!strcmp("backlight", str))
+			acpi_video_support &=
+				ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR;
+		if (!strcmp("display_output", str))
+			acpi_video_support &=
+				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR;
+	}
+	return 1;
+}
+__setup("acpi_vendor=", acpi_vendor);
Index: linux-2.6.25/drivers/acpi/video.c
===================================================================
--- linux-2.6.25.orig/drivers/acpi/video.c
+++ linux-2.6.25/drivers/acpi/video.c
@@ -739,7 +739,8 @@ static void acpi_video_device_find_cap(s
 		device->cap._DSS = 1;
 	}
 
-	max_level = acpi_video_init_brightness(device);
+	if (acpi_video_backlight_support())
+		max_level = acpi_video_init_brightness(device);
 
 	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 
0){
 		int result;
@@ -776,18 +777,21 @@ static void acpi_video_device_find_cap(s
 			printk(KERN_ERR PREFIX "Create sysfs link\n");
 
 	}
-	if (device->cap._DCS && device->cap._DSS){
-		static int count = 0;
-		char *name;
-		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
-		if (!name)
-			return;
-		sprintf(name, "acpi_video%d", count++);
-		device->output_dev = video_output_register(name,
-				NULL, device, &acpi_output_properties);
-		kfree(name);
+
+	if (acpi_video_display_switch_support()) {
+
+		if (device->cap._DCS && device->cap._DSS){
+			static int count = 0;
+			char *name;
+			name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+			if (!name)
+				return;
+			sprintf(name, "acpi_video%d", count++);
+			device->output_dev = video_output_register(name,
+					NULL, device, &acpi_output_properties);
+			kfree(name);
+		}
 	}
-	return;
 }
 
 /*
