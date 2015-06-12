From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 10/32] acpi-video: Port to new backlight interface selection API
Date: Fri, 12 Jun 2015 13:23:29 +0200
Message-ID: <1434108231-12323-11-git-send-email-hdegoede@redhat.com>
References: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Most of the patch is moving the dmi quirks for forcing use of the
acpi-video / the native backlight interface to video_detect.c.

What remains is a nice cleanup.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c   | 178 +++-----------------------------------------
 drivers/acpi/video_detect.c | 130 ++++++++++++++++++++++++++++++++
 include/acpi/video.h        |   2 -
 3 files changed, 141 insertions(+), 169 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 6249968..1bbe9b1 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -78,20 +78,6 @@ module_param(brightness_switch_enabled, bool, 0644);
 static bool allow_duplicates;
 module_param(allow_duplicates, bool, 0644);
 
-/*
- * For Windows 8 systems: used to decide if video module
- * should skip registering backlight interface of its own.
- */
-enum {
-	NATIVE_BACKLIGHT_NOT_SET = -1,
-	NATIVE_BACKLIGHT_OFF,
-	NATIVE_BACKLIGHT_ON,
-};
-
-static int use_native_backlight_param = NATIVE_BACKLIGHT_NOT_SET;
-module_param_named(use_native_backlight, use_native_backlight_param, int, 0444);
-static int use_native_backlight_dmi = NATIVE_BACKLIGHT_NOT_SET;
-
 static int register_count;
 static struct mutex video_list_lock;
 static struct list_head video_bus_head;
@@ -241,24 +227,6 @@ static int acpi_video_get_next_level(struct acpi_video_device *device,
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct work_struct *work);
 
-static bool acpi_video_use_native_backlight(void)
-{
-	if (use_native_backlight_param != NATIVE_BACKLIGHT_NOT_SET)
-		return use_native_backlight_param;
-	else if (use_native_backlight_dmi != NATIVE_BACKLIGHT_NOT_SET)
-		return use_native_backlight_dmi;
-	return acpi_osi_is_win8();
-}
-
-bool acpi_video_verify_backlight_support(void)
-{
-	if (acpi_video_use_native_backlight() &&
-	    backlight_device_registered(BACKLIGHT_RAW))
-		return false;
-	return acpi_video_backlight_support();
-}
-EXPORT_SYMBOL_GPL(acpi_video_verify_backlight_support);
-
 /* backlight device sysfs support */
 static int acpi_video_get_brightness(struct backlight_device *bd)
 {
@@ -419,18 +387,6 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int __init video_disable_native_backlight(const struct dmi_system_id *d)
-{
-	use_native_backlight_dmi = NATIVE_BACKLIGHT_OFF;
-	return 0;
-}
-
-static int __init video_enable_native_backlight(const struct dmi_system_id *d)
-{
-	use_native_backlight_dmi = NATIVE_BACKLIGHT_ON;
-	return 0;
-}
-
 static struct dmi_system_id video_dmi_table[] __initdata = {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
@@ -475,123 +431,6 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720"),
 		},
 	},
-
-	/*
-	 * These models have a working acpi_video backlight control, and using
-	 * native backlight causes a regression where backlight does not work
-	 * when userspace is not handling brightness key events. Disable
-	 * native_backlight on these to fix this:
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=81691
-	 */
-	{
-	 .callback = video_disable_native_backlight,
-	 .ident = "ThinkPad T420",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T420"),
-		},
-	},
-	{
-	 .callback = video_disable_native_backlight,
-	 .ident = "ThinkPad T520",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T520"),
-		},
-	},
-	{
-	 .callback = video_disable_native_backlight,
-	 .ident = "ThinkPad X201s",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
-		},
-	},
-
-	/* The native backlight controls do not work on some older machines */
-	{
-	 /* https://bugs.freedesktop.org/show_bug.cgi?id=81515 */
-	 .callback = video_disable_native_backlight,
-	 .ident = "HP ENVY 15 Notebook",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP ENVY 15 Notebook PC"),
-		},
-	},
-
-	{
-	 .callback = video_disable_native_backlight,
-	 .ident = "SAMSUNG 870Z5E/880Z5E/680Z5E",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "870Z5E/880Z5E/680Z5E"),
-		},
-	},
-	{
-	 .callback = video_disable_native_backlight,
-	 .ident = "SAMSUNG 370R4E/370R4V/370R5E/3570RE/370R5V",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "370R4E/370R4V/370R5E/3570RE/370R5V"),
-		},
-	},
-	{
-	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1186097 */
-	 .callback = video_disable_native_backlight,
-	 .ident = "SAMSUNG 3570R/370R/470R/450R/510R/4450RV",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "3570R/370R/470R/450R/510R/4450RV"),
-		},
-	},
-	{
-	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
-	 .callback = video_disable_native_backlight,
-	 .ident = "SAMSUNG 730U3E/740U3E",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
-		},
-	},
-	{
-	 /* https://bugs.freedesktop.org/show_bug.cgi?id=87286 */
-	 .callback = video_disable_native_backlight,
-	 .ident = "SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "900X3C/900X3D/900X3E/900X4C/900X4D"),
-		},
-	},
-
-	{
-	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
-	 .callback = video_disable_native_backlight,
-	 .ident = "Dell XPS15 L521X",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
-		},
-	},
-
-	/* Non win8 machines which need native backlight nevertheless */
-	{
-	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
-	 .callback = video_enable_native_backlight,
-	 .ident = "Lenovo Ideapad Z570",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
-		},
-	},
-	{
-	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
-	 .callback = video_enable_native_backlight,
-	 .ident = "Apple MacBook Pro 12,1",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
-		},
-	},
 	{}
 };
 
@@ -1391,7 +1230,7 @@ acpi_video_switch_brightness(struct work_struct *work)
 	int result = -EINVAL;
 
 	/* no warning message if acpi_backlight=vendor or a quirk is used */
-	if (!acpi_video_verify_backlight_support())
+	if (!device->backlight)
 		return;
 
 	if (!device->brightness)
@@ -1738,8 +1577,10 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 						      &acpi_backlight_ops,
 						      &props);
 	kfree(name);
-	if (IS_ERR(device->backlight))
+	if (IS_ERR(device->backlight)) {
+		device->backlight = NULL;
 		return;
+	}
 
 	/*
 	 * Save current brightness level in case we have to restore it
@@ -1796,7 +1637,7 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
 
 	acpi_video_run_bcl_for_osi(video);
 
-	if (!acpi_video_verify_backlight_support())
+	if (acpi_video_get_backlight_type() != acpi_backlight_video)
 		return 0;
 
 	mutex_lock(&video->device_list_lock);
@@ -1945,20 +1786,23 @@ static int acpi_video_backlight_notify(struct notifier_block *nb,
 {
 	struct backlight_device *backlight = bd;
 	struct acpi_video_bus *video;
+	enum acpi_backlight_type type;
 
-	/* acpi_video_verify_backlight_support only cares about raw devices */
+	/* A raw bl (un)registering may change native <-> video */
 	if (backlight->props.type != BACKLIGHT_RAW)
 		return NOTIFY_DONE;
 
 	video = container_of(nb, struct acpi_video_bus, backlight_nb);
+	type = acpi_video_get_backlight_type();
 
 	switch (val) {
 	case BACKLIGHT_REGISTERED:
-		if (!acpi_video_verify_backlight_support())
+		if (type != acpi_backlight_video)
 			acpi_video_bus_unregister_backlight(video);
 		break;
 	case BACKLIGHT_UNREGISTERED:
-		acpi_video_bus_register_backlight(video);
+		if (type == acpi_backlight_video)
+			acpi_video_bus_register_backlight(video);
 		break;
 	}
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 2807bbf..f9934dc 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -84,6 +84,18 @@ static int video_detect_force_vendor(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int video_detect_force_video(const struct dmi_system_id *d)
+{
+	acpi_backlight_dmi = acpi_backlight_video;
+	return 0;
+}
+
+static int video_detect_force_native(const struct dmi_system_id *d)
+{
+	acpi_backlight_dmi = acpi_backlight_native;
+	return 0;
+}
+
 static struct dmi_system_id video_detect_dmi_table[] = {
 	/* On Samsung X360, the BIOS will set a flag (VDRV) if generic
 	 * ACPI backlight device is used. This flag will definitively break
@@ -124,6 +136,124 @@ static struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5737"),
 		},
 	},
+
+	/*
+	 * These models have a working acpi_video backlight control, and using
+	 * native backlight causes a regression where backlight does not work
+	 * when userspace is not handling brightness key events. Disable
+	 * native_backlight on these to fix this:
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=81691
+	 */
+	{
+	 .callback = video_detect_force_video,
+	 .ident = "ThinkPad T420",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T420"),
+		},
+	},
+	{
+	 .callback = video_detect_force_video,
+	 .ident = "ThinkPad T520",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T520"),
+		},
+	},
+	{
+	 .callback = video_detect_force_video,
+	 .ident = "ThinkPad X201s",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
+		},
+	},
+
+	/* The native backlight controls do not work on some older machines */
+	{
+	 /* https://bugs.freedesktop.org/show_bug.cgi?id=81515 */
+	 .callback = video_detect_force_video,
+	 .ident = "HP ENVY 15 Notebook",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP ENVY 15 Notebook PC"),
+		},
+	},
+	{
+	 .callback = video_detect_force_video,
+	 .ident = "SAMSUNG 870Z5E/880Z5E/680Z5E",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "870Z5E/880Z5E/680Z5E"),
+		},
+	},
+	{
+	 .callback = video_detect_force_video,
+	 .ident = "SAMSUNG 370R4E/370R4V/370R5E/3570RE/370R5V",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME,
+			  "370R4E/370R4V/370R5E/3570RE/370R5V"),
+		},
+	},
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1186097 */
+	 .callback = video_detect_force_video,
+	 .ident = "SAMSUNG 3570R/370R/470R/450R/510R/4450RV",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME,
+			  "3570R/370R/470R/450R/510R/4450RV"),
+		},
+	},
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
+	 .callback = video_detect_force_video,
+	 .ident = "SAMSUNG 730U3E/740U3E",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
+		},
+	},
+	{
+	 /* https://bugs.freedesktop.org/show_bug.cgi?id=87286 */
+	 .callback = video_detect_force_video,
+	 .ident = "SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME,
+			  "900X3C/900X3D/900X3E/900X4C/900X4D"),
+		},
+	},
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
+	 .callback = video_detect_force_video,
+	 .ident = "Dell XPS15 L521X",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
+		},
+	},
+
+	/* Non win8 machines which need native backlight nevertheless */
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
+	 .callback = video_detect_force_native,
+	 .ident = "Lenovo Ideapad Z570",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
+		},
+	},
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
+	 .callback = video_detect_force_native,
+	 .ident = "Apple MacBook Pro 12,1",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
+		},
+	},
 	{ },
 };
 
diff --git a/include/acpi/video.h b/include/acpi/video.h
index 01b5cc7..47c7ad6 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -30,7 +30,6 @@ extern void acpi_video_unregister(void);
 extern void acpi_video_unregister_backlight(void);
 extern int acpi_video_get_edid(struct acpi_device *device, int type,
 			       int device_id, void **edid);
-extern bool acpi_video_verify_backlight_support(void);
 extern enum acpi_backlight_type acpi_video_get_backlight_type(void);
 extern void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type);
 #else
@@ -42,7 +41,6 @@ static inline int acpi_video_get_edid(struct acpi_device *device, int type,
 {
 	return -ENODEV;
 }
-static inline bool acpi_video_verify_backlight_support(void) { return false; }
 static inline enum acpi_backlight_type acpi_video_get_backlight_type(void)
 {
 	return acpi_backlight_vendor;
-- 
2.4.2
