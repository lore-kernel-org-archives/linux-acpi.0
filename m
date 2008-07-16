From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 02/11] Check for ACPI backlight support otherwise use vendor ACPI drivers
Date: Wed, 16 Jul 2008 12:52:24 +0200
Message-ID: <1216205553-8486-3-git-send-email-trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48184 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859AbYGPKwi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 06:52:38 -0400
In-Reply-To: <1216205553-8486-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Thomas Renninger <trenn@suse.de>Thomas Renninger <trenn@suse.de>

If an ACPI graphics device supports backlight brightness functions (cmp. with
latest ACPI spec Appendix B), let the ACPI video driver control backlight and
switch backlight control off in vendor specific ACPI drivers (asus_acpi,
thinkpad_acpi, eeepc, fujitsu_laptop, msi_laptop, sony_laptop, acer-wmi).

Currently it is possible to load above drivers and let both poke on the
brightness HW registers, the video and vendor specific ACPI drivers -> bad.

This patch provides the basic support to check for BIOS capabilities before
driver loading time. Driver specific modifications are in separate follow up
patches.

acpi_backlight=vendor/video
      boot params forces video.ko or vendor specific drivers to keep its
      fingers off backlight control even it would find needed functions.
      The corresponding vendor specific driver be used then.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <trenn@stravinsky.suse.de>
---
 Documentation/kernel-parameters.txt |   13 ++
 drivers/acpi/Makefile               |    5 +
 drivers/acpi/pci_root.c             |    6 +
 drivers/acpi/scan.c                 |   32 +----
 drivers/acpi/video.c                |   28 ++--
 drivers/acpi/video_detect.c         |  258 +++++++++++++++++++++++++++++++++++
 include/linux/acpi.h                |   45 ++++++
 7 files changed, 344 insertions(+), 43 deletions(-)
 create mode 100644 drivers/acpi/video_detect.c

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 6acfe8e..56392f8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -191,6 +191,19 @@ and is between 256 and 4096 characters. It is defined in the file
 			that require a timer override, but don't have
 			HPET
 
+	acpi_backlight=	[HW,ACPI]
+			acpi_backlight=vendor
+			acpi_backlight=video
+			If set to vendor, it enforces the use of a
+			vendor specific ACPI driver for backlight switching
+			(e.g. thinkpad_acpi, sony_acpi, etc.) instead
+			of the video.ko driver.
+
+	acpi_display_output=	[HW,ACPI]
+			acpi_display_output=vendor
+			acpi_display_output=video
+			See above.
+
 	acpi.debug_layer=	[HW,ACPI]
 			Format: <int>
 			Each bit of the <int> indicates an ACPI debug layer,
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 4efbe59..d91dc80 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
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
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c3fed31..0a6d5e0 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -388,6 +388,12 @@ static int __init acpi_pci_root_init(void)
 	if (acpi_bus_register_driver(&acpi_pci_root_driver) < 0)
 		return -ENODEV;
 
+	/* We must check whether the ACPI graphics device is physically plugged
+	 * in. Therefore this must be called after binding PCI and ACPI devices,
+	 * but before modules are loaded, so that we know which module should
+	 * be responsible depending on what the BIOS provides us.
+	 */
+	acpi_video_get_capabilities(NULL);
 	return 0;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5b049cd..fb8e2df 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -931,36 +931,6 @@ static void acpi_device_get_busid(struct acpi_device *device,
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
@@ -1043,7 +1013,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 		   will get autoloaded and the device might still match
 		   against another driver.
 		*/
-		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
+		if (acpi_is_video_device(device))
 			cid_add = ACPI_VIDEO_HID;
 		else if (ACPI_SUCCESS(acpi_bay_match(device)))
 			cid_add = ACPI_BAY_HID;
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 767d9b9..0533e0d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -739,7 +739,8 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		device->cap._DSS = 1;
 	}
 
-	max_level = acpi_video_init_brightness(device);
+	if (acpi_video_backlight_support())
+		max_level = acpi_video_init_brightness(device);
 
 	if (device->cap._BCL && device->cap._BCM && device->cap._BQC && max_level > 0){
 		int result;
@@ -776,18 +777,21 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
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
+		if (device->cap._DCS && device->cap._DSS) {
+			static int count;
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
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
new file mode 100644
index 0000000..68abba7
--- /dev/null
+++ b/drivers/acpi/video_detect.c
@@ -0,0 +1,258 @@
+/*
+ * video_detect.c:
+ * Provides acpi_is_video_device() for early scanning of ACPI devices in scan.c
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
+/* If video.ko is not selected, we do not need to protect vendor acpi drivers */
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+
+ACPI_MODULE_NAME("video");
+#define ACPI_VIDEO_COMPONENT		0x08000000
+#define _COMPONENT		ACPI_VIDEO_COMPONENT
+
+static long acpi_video_support;
+static bool acpi_video_caps_checked;
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
+	/* IGD detection is not perfect. It should use the same method as done
+	 * to identify an IGD device in the dri parts or video.ko
+	*/
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
+	if (acpi_bus_get_device(handle, &acpi_dev))
+		return AE_OK;
+
+	if (!acpi_match_device_ids(acpi_dev, video_ids)) {
+		dev = acpi_get_physical_pci_device(handle);
+		if (!dev)
+			return AE_OK;
+		put_device(dev);
+		*cap |= acpi_is_video_device(acpi_dev);
+	}
+	return AE_OK;
+}
+
+/* Returns the video capabilities of a specific ACPI graphics device
+ *
+ * if NULL is passed as argument all ACPI devices are enumerated and
+ * all graphics capabilities of physically present devices are
+ * summerized and returned. This is cached and done only once.
+ */
+long acpi_video_get_capabilities(acpi_handle graphics_handle)
+{
+	long caps = 0;
+	struct acpi_device *tmp_dev;
+	acpi_status status;
+
+	if (acpi_video_caps_checked && graphics_handle == NULL)
+		return acpi_video_support;
+
+	if (!graphics_handle) {
+		/* Only do the global walk through all graphics devices once */
+		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				    ACPI_UINT32_MAX, find_video,
+				    &caps, NULL);
+		/* There might be boot param flags set already... */
+		acpi_video_support |= caps;
+		acpi_video_caps_checked = 1;
+		/* Add blacklists here. Be careful to use the right *DMI* bits
+		 * to still be able to override logic via boot params, e.g.:
+		 *
+		 *   if (dmi_name_in_vendors("XY")) {
+		 *	acpi_video_support |=
+		 *		ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR;
+		 *	acpi_video_support |=
+		 *		ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
+		 *}
+		 */
+	} else {
+		status = acpi_bus_get_device(graphics_handle, &tmp_dev);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status, "Invalid device"));
+			return 0;
+		}
+		acpi_walk_namespace(ACPI_TYPE_DEVICE, graphics_handle,
+				    ACPI_UINT32_MAX, find_video,
+				    &caps, NULL);
+	}
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "We have 0x%lX video support %s %s\n",
+			  graphics_handle ? caps : acpi_video_support,
+			  graphics_handle ? "on device " : "in general",
+			  graphics_handle ? acpi_device_bid(tmp_dev) : ""));
+	return caps;
+}
+EXPORT_SYMBOL(acpi_video_get_capabilities);
+
+/* Returns true if video.ko can do backlight switching
+ *
+ */
+int acpi_video_backlight_support(void)
+{
+
+	/* First check for boot param -> highest prio */
+	if (acpi_video_support & ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR)
+		return 0;
+	else if (acpi_video_support & ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO)
+		return 1;
+
+	/* Then check for DMI blacklist -> second highest prio */
+	if (acpi_video_support & ACPI_VIDEO_BACKLIGHT_DMI_VENDOR)
+		return 0;
+	else if (acpi_video_support & ACPI_VIDEO_BACKLIGHT_DMI_VIDEO)
+		return 1;
+
+	/* Then go the default way */
+	return acpi_video_support & ACPI_VIDEO_BACKLIGHT;
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
+	if (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR)
+		return 0;
+	else if (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO)
+		return 1;
+
+	if (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR)
+		return 0;
+	else if (acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VIDEO)
+		return 1;
+
+	return acpi_video_support & ACPI_VIDEO_OUTPUT_SWITCHING;
+}
+EXPORT_SYMBOL(acpi_video_display_switch_support);
+
+/* Use acpi_display_output=vendor/video or acpi_backlight=vendor/video
+ * To force that backlight or display output switching is processed by vendor
+ * specific acpi drivers or video.ko driver.
+ */
+int __init acpi_backlight(char *str)
+{
+	if (str == NULL || *str == '\0')
+		return 1;
+	else {
+		if (!strcmp("vendor", str))
+			acpi_video_support |=
+				ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR;
+		if (!strcmp("video", str))
+			acpi_video_support |=
+				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO;
+	}
+	return 1;
+}
+__setup("acpi_backlight=", acpi_backlight);
+
+int __init acpi_display_output(char *str)
+{
+	if (str == NULL || *str == '\0')
+		return 1;
+	else {
+		if (!strcmp("vendor", str))
+			acpi_video_support |=
+				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR;
+		if (!strcmp("video", str))
+			acpi_video_support |=
+				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO;
+	}
+	return 1;
+}
+__setup("acpi_display_output=", acpi_display_output);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 41f7ce7..7e4e5bc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -201,6 +201,51 @@ extern bool wmi_has_guid(const char *guid);
 
 #endif	/* CONFIG_ACPI_WMI */
 
+#define ACPI_VIDEO_OUTPUT_SWITCHING			1
+#define ACPI_VIDEO_DEVICE_POSTING			2
+#define ACPI_VIDEO_ROM_AVAILABLE			4
+#define ACPI_VIDEO_BACKLIGHT				8
+#define ACPI_VIDEO_IGD					16
+#define ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR		32
+#define ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO		64
+#define ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VENDOR	128
+#define ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO		256
+#define ACPI_VIDEO_BACKLIGHT_DMI_VENDOR			512
+#define ACPI_VIDEO_BACKLIGHT_DMI_VIDEO			1024
+#define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR		2048
+#define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VIDEO		4096
+
+#if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
+
+extern long acpi_video_get_capabilities(acpi_handle graphics_dev_handle);
+extern long acpi_is_video_device(struct acpi_device *device);
+extern int acpi_video_backlight_support(void);
+extern int acpi_video_display_switch_support(void);
+
+#else
+
+static inline long acpi_video_get_capabilities(acpi_handle graphics_dev_handle)
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
-- 
1.5.4.5

