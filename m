From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / video: only register backlight for LCD device
Date: Wed, 28 Oct 2015 15:09:23 +0800
Message-ID: <563074A3.8090807@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47323 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964824AbbJ1HH2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Oct 2015 03:07:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Christian Scharl <zahlsum-kernelbugs@yahoo.de>

The firmware of ESPRIMO Mobile M9410 has two video output devices that
have _BCM control method, one is the type of "External Digital Monitor"
while the other is the type of "Internal/Integrated Digital Flat Panel".
Only the 2nd video output device's _BCM control method works, but
since we have created two and the 1st one got picked up by user space,
the backlight functionality is broken. To solve this problem, only
register backlight interface for "Internal/Integrated Digital Flat Panel"
type video output device on this laptop.

Another problem of this laptop is that the IDs listed by the _DOD method
doesn't have bit 31 set, which means it doesn't follow the format
specified by ACPI spec. But the value indicates that it actually follows
that format so I've added a DMI quirk and a module level parameter to
force use the device_id_scheme so that we can get the video output
device's type to do the decision if we should register backlight
interface.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=104121
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reported-and-tested-by: Christian Scharl <zahlsum-kernelbugs@yahoo.de>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/acpi_video.c | 78 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 5778e8e4313a..3405f7a41e25 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -77,6 +77,12 @@ module_param(allow_duplicates, bool, 0644);
 static int disable_backlight_sysfs_if = -1;
 module_param(disable_backlight_sysfs_if, int, 0444);
 
+static bool device_id_scheme = false;
+module_param(device_id_scheme, bool, 0444);
+
+static bool only_lcd = false;
+module_param(only_lcd, bool, 0444);
+
 static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
 static struct mutex video_list_lock;
@@ -394,6 +400,18 @@ static int video_disable_backlight_sysfs_if(
 	return 0;
 }
 
+static int video_set_device_id_scheme(const struct dmi_system_id *d)
+{
+	device_id_scheme = true;
+	return 0;
+}
+
+static int video_enable_only_lcd(const struct dmi_system_id *d)
+{
+	only_lcd = true;
+	return 0;
+}
+
 static struct dmi_system_id video_dmi_table[] = {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
@@ -455,6 +473,33 @@ static struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R830"),
 		},
 	},
+	/*
+	 * Some machine's _DOD IDs don't have bit 31(Device ID Scheme) set
+	 * but the IDs actually follow the Device ID Scheme.
+	 */
+	{
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=104121 */
+	 .callback = video_set_device_id_scheme,
+	 .ident = "ESPRIMO Mobile M9410",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile M9410"),
+		},
+	},
+	/*
+	 * Some machines have multiple video output devices, but only the one
+	 * that is the type of LCD can do the backlight control so we should not
+	 * register backlight interface for other video output devices.
+	 */
+	{
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=104121 */
+	 .callback = video_enable_only_lcd,
+	 .ident = "ESPRIMO Mobile M9410",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile M9410"),
+		},
+	},
 	{}
 };
 
@@ -1003,7 +1048,7 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 
 	attribute = acpi_video_get_device_attr(video, device_id);
 
-	if (attribute && attribute->device_id_scheme) {
+	if (attribute && (attribute->device_id_scheme || device_id_scheme)) {
 		switch (attribute->display_type) {
 		case ACPI_VIDEO_DISPLAY_CRT:
 			data->flags.crt = 1;
@@ -1568,15 +1613,6 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 	static int count;
 	char *name;
 
-	/*
-	 * Do not create backlight device for video output
-	 * device that is not in the enumerated list.
-	 */
-	if (!acpi_video_device_in_dod(device)) {
-		dev_dbg(&device->dev->dev, "not in _DOD list, ignore\n");
-		return;
-	}
-
 	result = acpi_video_init_brightness(device);
 	if (result)
 		return;
@@ -1657,6 +1693,22 @@ static void acpi_video_run_bcl_for_osi(struct acpi_video_bus *video)
 	mutex_unlock(&video->device_list_lock);
 }
 
+static bool acpi_video_should_register_backlight(struct acpi_video_device *dev)
+{
+	/*
+	 * Do not create backlight device for video output
+	 * device that is not in the enumerated list.
+	 */
+	if (!acpi_video_device_in_dod(dev)) {
+		dev_dbg(&dev->dev->dev, "not in _DOD list, ignore\n");
+		return false;
+	}
+
+	if (only_lcd)
+		return dev->flags.lcd;
+	return true;
+}
+
 static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
 {
 	struct acpi_video_device *dev;
@@ -1670,8 +1722,10 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
 		return 0;
 
 	mutex_lock(&video->device_list_lock);
-	list_for_each_entry(dev, &video->video_device_list, entry)
-		acpi_video_dev_register_backlight(dev);
+	list_for_each_entry(dev, &video->video_device_list, entry) {
+		if (acpi_video_should_register_backlight(dev))
+			acpi_video_dev_register_backlight(dev);
+	}
 	mutex_unlock(&video->device_list_lock);
 
 	video->backlight_registered = true;
-- 
2.4.3

