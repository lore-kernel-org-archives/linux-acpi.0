From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 14/35] acpi-video: Move backlight notifier to video_detect.c
Date: Tue, 16 Jun 2015 16:27:52 +0200
Message-ID: <1434464893-3529-15-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37321 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756363AbbFPO3T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2015 10:29:19 -0400
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>

Move the unregistering of the acpi backlight interface on registering of a
native backlight from video.c to video_detect.c where it belongs.

Note this removes support for re-registering the acpi backlight interface
when the native interface goes away. In practice this never happens and
it needlessly complicates the code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c   | 59 ++-------------------------------------------
 drivers/acpi/video_detect.c | 27 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 57 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index bba0d87..23490f0 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -87,6 +87,7 @@ static struct list_head video_bus_head;
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device);
 static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
+void acpi_video_detect_exit(void);
 
 static const struct acpi_device_id video_device_ids[] = {
 	{ACPI_VIDEO_HID, 0},
@@ -146,7 +147,6 @@ struct acpi_video_enumerated_device {
 struct acpi_video_bus {
 	struct acpi_device *device;
 	bool backlight_registered;
-	bool backlight_notifier_registered;
 	u8 dos_setting;
 	struct acpi_video_enumerated_device *attached_array;
 	u8 attached_count;
@@ -159,7 +159,6 @@ struct acpi_video_bus {
 	struct input_dev *input;
 	char phys[32];	/* for input device */
 	struct notifier_block pm_nb;
-	struct notifier_block backlight_nb;
 };
 
 struct acpi_video_device_flags {
@@ -1814,59 +1813,6 @@ static void acpi_video_bus_remove_notify_handler(struct acpi_video_bus *video)
 	video->input = NULL;
 }
 
-static int acpi_video_backlight_notify(struct notifier_block *nb,
-					unsigned long val, void *bd)
-{
-	struct backlight_device *backlight = bd;
-	struct acpi_video_bus *video;
-	enum acpi_backlight_type type;
-
-	/* A raw bl (un)registering may change native <-> video */
-	if (backlight->props.type != BACKLIGHT_RAW)
-		return NOTIFY_DONE;
-
-	video = container_of(nb, struct acpi_video_bus, backlight_nb);
-	type = acpi_video_get_backlight_type();
-
-	switch (val) {
-	case BACKLIGHT_REGISTERED:
-		if (type != acpi_backlight_video)
-			acpi_video_bus_unregister_backlight(video);
-		break;
-	case BACKLIGHT_UNREGISTERED:
-		if (type == acpi_backlight_video)
-			acpi_video_bus_register_backlight(video);
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-static int acpi_video_bus_add_backlight_notify_handler(
-						struct acpi_video_bus *video)
-{
-	int error;
-
-	video->backlight_nb.notifier_call = acpi_video_backlight_notify;
-	video->backlight_nb.priority = 0;
-	error = backlight_register_notifier(&video->backlight_nb);
-	if (error == 0)
-		video->backlight_notifier_registered = true;
-
-	return error;
-}
-
-static int acpi_video_bus_remove_backlight_notify_handler(
-						struct acpi_video_bus *video)
-{
-	if (!video->backlight_notifier_registered)
-		return 0;
-
-	video->backlight_notifier_registered = false;
-
-	return backlight_unregister_notifier(&video->backlight_nb);
-}
-
 static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 {
 	struct acpi_video_device *dev, *next;
@@ -1948,7 +1894,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 	acpi_video_bus_register_backlight(video);
 	acpi_video_bus_add_notify_handler(video);
-	acpi_video_bus_add_backlight_notify_handler(video);
 
 	return 0;
 
@@ -1972,7 +1917,6 @@ static int acpi_video_bus_remove(struct acpi_device *device)
 
 	video = acpi_driver_data(device);
 
-	acpi_video_bus_remove_backlight_notify_handler(video);
 	acpi_video_bus_remove_notify_handler(video);
 	acpi_video_bus_unregister_backlight(video);
 	acpi_video_bus_put_devices(video);
@@ -2108,6 +2052,7 @@ static int __init acpi_video_init(void)
 
 static void __exit acpi_video_exit(void)
 {
+	acpi_video_detect_exit();
 	acpi_video_unregister();
 
 	return;
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index d024ea0..0df1567 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -37,6 +37,9 @@
 ACPI_MODULE_NAME("video");
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 
+static bool backlight_notifier_registered;
+static struct notifier_block backlight_nb;
+
 static enum acpi_backlight_type acpi_backlight_cmdline = acpi_backlight_undef;
 static enum acpi_backlight_type acpi_backlight_dmi = acpi_backlight_undef;
 
@@ -257,6 +260,20 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{ },
 };
 
+static int acpi_video_backlight_notify(struct notifier_block *nb,
+				       unsigned long val, void *bd)
+{
+	struct backlight_device *backlight = bd;
+
+	/* A raw bl registering may change video -> native */
+	if (backlight->props.type == BACKLIGHT_RAW &&
+	    val == BACKLIGHT_REGISTERED &&
+	    acpi_video_get_backlight_type() != acpi_backlight_video)
+		acpi_video_unregister_backlight();
+
+	return NOTIFY_OK;
+}
+
 /*
  * Determine which type of backlight interface to use on this system,
  * First check cmdline, then dmi quirks, then do autodetect.
@@ -285,6 +302,10 @@ enum acpi_backlight_type acpi_video_get_backlight_type(void)
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				    ACPI_UINT32_MAX, find_video, NULL,
 				    &video_caps, NULL);
+		backlight_nb.notifier_call = acpi_video_backlight_notify;
+		backlight_nb.priority = 0;
+		if (backlight_register_notifier(&backlight_nb) == 0)
+			backlight_notifier_registered = true;
 		init_done = true;
 	}
 	mutex_unlock(&init_mutex);
@@ -349,3 +370,9 @@ int acpi_video_backlight_support(void)
 	return acpi_video_get_backlight_type() != acpi_backlight_vendor;
 }
 EXPORT_SYMBOL(acpi_video_backlight_support);
+
+void __exit acpi_video_detect_exit(void)
+{
+	if (backlight_notifier_registered)
+		backlight_unregister_notifier(&backlight_nb);
+}
-- 
2.3.6

