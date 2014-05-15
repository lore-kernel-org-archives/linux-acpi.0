From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] acpi-video: Don't register acpi_video_resume notifier without backlight devices
Date: Thu, 15 May 2014 13:22:33 +0200
Message-ID: <1400152956-9053-2-git-send-email-hdegoede@redhat.com>
References: <1400152956-9053-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1400152956-9053-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Lee Chun-Yi <jlee@suse.com>, Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, Massimiliano <massi.ergosum@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

If we're not going to be registering any backlight devices then
acpi_video_resume is always nop, so don't register it in that case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--

Note to reviewers the changes to acpi_video_dev_register_backlight() only
remove the "if (!acpi_video_verify_backlight_support()) {" which surrounded
the entire body of the function, as that is checked earlier now.
---
 drivers/acpi/video.c | 139 +++++++++++++++++++++++++++------------------------
 1 file changed, 74 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 6a2099d..f767eba 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -150,6 +150,7 @@ struct acpi_video_enumerated_device {
 
 struct acpi_video_bus {
 	struct acpi_device *device;
+	bool backlight_registered;
 	u8 dos_setting;
 	struct acpi_video_enumerated_device *attached_array;
 	u8 attached_count;
@@ -1770,88 +1771,89 @@ acpi_video_bus_match(acpi_handle handle, u32 level, void *context,
 
 static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 {
-	if (acpi_video_verify_backlight_support()) {
-		struct backlight_properties props;
-		struct pci_dev *pdev;
-		acpi_handle acpi_parent;
-		struct device *parent = NULL;
-		int result;
-		static int count;
-		char *name;
-
-		result = acpi_video_init_brightness(device);
-		if (result)
-			return;
-		name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
-		if (!name)
-			return;
-		count++;
+	struct backlight_properties props;
+	struct pci_dev *pdev;
+	acpi_handle acpi_parent;
+	struct device *parent = NULL;
+	int result;
+	static int count;
+	char *name;
 
-		acpi_get_parent(device->dev->handle, &acpi_parent);
+	result = acpi_video_init_brightness(device);
+	if (result)
+		return;
+	name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
+	if (!name)
+		return;
+	count++;
 
-		pdev = acpi_get_pci_dev(acpi_parent);
-		if (pdev) {
-			parent = &pdev->dev;
-			pci_dev_put(pdev);
-		}
+	acpi_get_parent(device->dev->handle, &acpi_parent);
 
-		memset(&props, 0, sizeof(struct backlight_properties));
-		props.type = BACKLIGHT_FIRMWARE;
-		props.max_brightness = device->brightness->count - 3;
-		device->backlight = backlight_device_register(name,
-							      parent,
-							      device,
-							      &acpi_backlight_ops,
-							      &props);
-		kfree(name);
-		if (IS_ERR(device->backlight))
-			return;
+	pdev = acpi_get_pci_dev(acpi_parent);
+	if (pdev) {
+		parent = &pdev->dev;
+		pci_dev_put(pdev);
+	}
 
-		/*
-		 * Save current brightness level in case we have to restore it
-		 * before acpi_video_device_lcd_set_level() is called next time.
-		 */
-		device->backlight->props.brightness =
-				acpi_video_get_brightness(device->backlight);
+	memset(&props, 0, sizeof(struct backlight_properties));
+	props.type = BACKLIGHT_FIRMWARE;
+	props.max_brightness = device->brightness->count - 3;
+	device->backlight = backlight_device_register(name,
+						      parent,
+						      device,
+						      &acpi_backlight_ops,
+						      &props);
+	kfree(name);
+	if (IS_ERR(device->backlight))
+		return;
 
-		device->cooling_dev = thermal_cooling_device_register("LCD",
-					device->dev, &video_cooling_ops);
-		if (IS_ERR(device->cooling_dev)) {
-			/*
-			 * Set cooling_dev to NULL so we don't crash trying to
-			 * free it.
-			 * Also, why the hell we are returning early and
-			 * not attempt to register video output if cooling
-			 * device registration failed?
-			 * -- dtor
-			 */
-			device->cooling_dev = NULL;
-			return;
-		}
+	/*
+	 * Save current brightness level in case we have to restore it
+	 * before acpi_video_device_lcd_set_level() is called next time.
+	 */
+	device->backlight->props.brightness =
+			acpi_video_get_brightness(device->backlight);
 
-		dev_info(&device->dev->dev, "registered as cooling_device%d\n",
-			 device->cooling_dev->id);
-		result = sysfs_create_link(&device->dev->dev.kobj,
-				&device->cooling_dev->device.kobj,
-				"thermal_cooling");
-		if (result)
-			printk(KERN_ERR PREFIX "Create sysfs link\n");
-		result = sysfs_create_link(&device->cooling_dev->device.kobj,
-				&device->dev->dev.kobj, "device");
-		if (result)
-			printk(KERN_ERR PREFIX "Create sysfs link\n");
+	device->cooling_dev = thermal_cooling_device_register("LCD",
+				device->dev, &video_cooling_ops);
+	if (IS_ERR(device->cooling_dev)) {
+		/*
+		 * Set cooling_dev to NULL so we don't crash trying to free it.
+		 * Also, why the hell we are returning early and not attempt to
+		 * register video output if cooling device registration failed?
+		 * -- dtor
+		 */
+		device->cooling_dev = NULL;
+		return;
 	}
+
+	dev_info(&device->dev->dev, "registered as cooling_device%d\n",
+		 device->cooling_dev->id);
+	result = sysfs_create_link(&device->dev->dev.kobj,
+			&device->cooling_dev->device.kobj,
+			"thermal_cooling");
+	if (result)
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
+	result = sysfs_create_link(&device->cooling_dev->device.kobj,
+			&device->dev->dev.kobj, "device");
+	if (result)
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
 }
 
 static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
 {
 	struct acpi_video_device *dev;
 
+	if (!acpi_video_verify_backlight_support())
+		return 0;
+
 	mutex_lock(&video->device_list_lock);
 	list_for_each_entry(dev, &video->video_device_list, entry)
 		acpi_video_dev_register_backlight(dev);
 	mutex_unlock(&video->device_list_lock);
 
+	video->backlight_registered = true;
+
 	video->pm_nb.notifier_call = acpi_video_resume;
 	video->pm_nb.priority = 0;
 	return register_pm_notifier(&video->pm_nb);
@@ -1879,13 +1881,20 @@ static void acpi_video_dev_unregister_backlight(struct acpi_video_device *device
 static int acpi_video_bus_unregister_backlight(struct acpi_video_bus *video)
 {
 	struct acpi_video_device *dev;
-	int error = unregister_pm_notifier(&video->pm_nb);
+	int error;
+
+	if (!video->backlight_registered)
+		return 0;
+
+	error = unregister_pm_notifier(&video->pm_nb);
 
 	mutex_lock(&video->device_list_lock);
 	list_for_each_entry(dev, &video->video_device_list, entry)
 		acpi_video_dev_unregister_backlight(dev);
 	mutex_unlock(&video->device_list_lock);
 
+	video->backlight_registered = false;
+
 	return error;
 }
 
-- 
1.9.0
