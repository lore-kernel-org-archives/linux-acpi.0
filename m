Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3F2E8B6B;
	Tue, 24 Mar 2026 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382614; cv=none; b=JryaenUSIr8CIECk++pFGB5QVPhsCcVMeGkK9glPoc0OJsjLamSFOWfqtLx5aCW7DqP1UPF6UCi5RYs+srphAShc01JTndhmwDKkdP1gjndNA9TQp3HYD5uGnt/p46W9F4cp0mon940dYJuAv1g+57pt6B/jH/mYv1Fi0f0ALGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382614; c=relaxed/simple;
	bh=OZQ+BlKhG73/XzUb2eimu1zg6x9iLUymh3aDmvib0X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIenUNJPJzsZkDDm82aj/ZoyoGXMwKJJHurXqKA0orx5foCrhVwsQY1orY8ker/LWTjnNUoJfAA2TllVWKEw6YRi/RXMTgZh7/+yebaaY2jOAprXitTWxp44s7ftiJhiJI9WH9kBdpQ3wji8C7L0vZHJXVIk4e02D4+0HtJtCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avxoAurF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avxoAurF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53B1C2BCB2;
	Tue, 24 Mar 2026 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774382614;
	bh=OZQ+BlKhG73/XzUb2eimu1zg6x9iLUymh3aDmvib0X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avxoAurFuVg6rLAPprzWCNLnjXKXwM4uQYyFCFGKZzwO+QDOaqmwNef6Tq8t5DV2O
	 OAe9Bal4d2ltqe53QnVQdvOFip8QTTZ/TP5X/Sg+TR05+HSAVTQQqWjfxQAiiF3Bc0
	 o6zybvNQ/jQ1DvduNnmsnN4Kd9h0SfOvbk6DN5Silas4bNDg5Vax0B3wAvn1dn/L1h
	 kf+vPm+nKgN/41cbLeSOUZpZbsUkcqDRy/KQFn3mBWvjl+FXZ7wl4l+aYYddF8ieXe
	 NzqkrSqTzddIb7rMKAjavwwg4Vgf+g8ozNVrIVzLczA1XMCna3+dqtuBE8MxHLdCaE
	 iZmQd2LbKjTug==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 3/7] platform/x86: toshiba_acpi: Convert ACPI driver to a platform
 one
Date: Tue, 24 Mar 2026 21:00:03 +0100
Message-ID: <2269772.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
References: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Toshiba Laptop ACPI Extras driver from
an ACPI driver to a platform one.

After this change, all of the subordinate hwmon, IIO, and LED class
devices will be registered under the platform device used for driver
binding instead of its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

However, the sysfs attributes in toshiba_attr_group will still be there
in the sysfs directory of the ACPI companion of the platform device used
for driver binding to maintain backwards compatibility with possibly
existing user space utilities depending on the presence of those
attributes.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/toshiba_acpi.c | 50 ++++++++++++++++-------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index b839f62ec9cc..35d899c01740 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -44,6 +44,7 @@
 #include <linux/rfkill.h>
 #include <linux/hwmon.h>
 #include <linux/iio/iio.h>
+#include <linux/platform_device.h>
 #include <linux/toshiba.h>
 #include <acpi/battery.h>
 #include <acpi/video.h>
@@ -3255,16 +3256,17 @@ static void toshiba_acpi_notify(acpi_handle handle, u32 event, void *data)
 					dev->last_key_event : 0);
 }
 
-static void toshiba_acpi_remove(struct acpi_device *acpi_dev)
+static void toshiba_acpi_remove(struct platform_device *pdev)
 {
-	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
+	struct toshiba_acpi_dev *dev = platform_get_drvdata(pdev);
 
 	misc_deregister(&dev->miscdev);
 
 	remove_toshiba_proc_entries(dev);
 
 	if (dev->notify_handler_installed)
-		acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY,
+		acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+					       ACPI_DEVICE_NOTIFY,
 					       toshiba_acpi_notify);
 
 #if IS_ENABLED(CONFIG_HWMON)
@@ -3306,6 +3308,8 @@ static void toshiba_acpi_remove(struct acpi_device *acpi_dev)
 	if (toshiba_acpi)
 		toshiba_acpi = NULL;
 
+	dev_set_drvdata(&dev->acpi_dev->dev, NULL);
+
 	kfree(dev);
 }
 
@@ -3368,8 +3372,9 @@ static const struct dmi_system_id toshiba_dmi_quirks[] __initconst = {
 	{ }
 };
 
-static int toshiba_acpi_add(struct acpi_device *acpi_dev)
+static int toshiba_acpi_probe(struct platform_device *pdev)
 {
+	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
@@ -3403,7 +3408,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		return ret;
 	}
 
-	acpi_dev->driver_data = dev;
+	platform_set_drvdata(pdev, dev);
 	dev_set_drvdata(&acpi_dev->dev, dev);
 
 	/* Query the BIOS for supported features */
@@ -3434,7 +3439,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->led_dev.max_brightness = 1;
 		dev->led_dev.brightness_set = toshiba_illumination_set;
 		dev->led_dev.brightness_get = toshiba_illumination_get;
-		led_classdev_register(&acpi_dev->dev, &dev->led_dev);
+		led_classdev_register(&pdev->dev, &dev->led_dev);
 	}
 
 	toshiba_eco_mode_available(dev);
@@ -3443,7 +3448,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->eco_led.max_brightness = 1;
 		dev->eco_led.brightness_set = toshiba_eco_mode_set_status;
 		dev->eco_led.brightness_get = toshiba_eco_mode_get_status;
-		led_classdev_register(&dev->acpi_dev->dev, &dev->eco_led);
+		led_classdev_register(&pdev->dev, &dev->eco_led);
 	}
 
 	toshiba_kbd_illum_available(dev);
@@ -3459,7 +3464,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->kbd_led.max_brightness = 1;
 		dev->kbd_led.brightness_set = toshiba_kbd_backlight_set;
 		dev->kbd_led.brightness_get = toshiba_kbd_backlight_get;
-		led_classdev_register(&dev->acpi_dev->dev, &dev->kbd_led);
+		led_classdev_register(&pdev->dev, &dev->kbd_led);
 	}
 
 	ret = toshiba_touchpad_get(dev, &dummy);
@@ -3467,7 +3472,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 
 	toshiba_accelerometer_available(dev);
 	if (dev->accelerometer_supported) {
-		dev->indio_dev = iio_device_alloc(&acpi_dev->dev, sizeof(*dev));
+		dev->indio_dev = iio_device_alloc(&pdev->dev, sizeof(*dev));
 		if (!dev->indio_dev) {
 			pr_err("Unable to allocate iio device\n");
 			goto iio_error;
@@ -3516,7 +3521,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 #if IS_ENABLED(CONFIG_HWMON)
 	if (dev->fan_rpm_supported) {
 		dev->hwmon_device = hwmon_device_register_with_info(
-			&dev->acpi_dev->dev, "toshiba_acpi_sensors", NULL,
+			&pdev->dev, "toshiba_acpi_sensors", NULL,
 			&toshiba_acpi_hwmon_chip_info, NULL);
 		if (IS_ERR(dev->hwmon_device)) {
 			dev->hwmon_device = NULL;
@@ -3564,14 +3569,14 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	return 0;
 
 error:
-	toshiba_acpi_remove(acpi_dev);
+	toshiba_acpi_remove(pdev);
 	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP
 static int toshiba_acpi_suspend(struct device *device)
 {
-	struct toshiba_acpi_dev *dev = acpi_driver_data(to_acpi_device(device));
+	struct toshiba_acpi_dev *dev = dev_get_drvdata(device);
 
 	if (dev->hotkey_dev) {
 		u32 result;
@@ -3586,7 +3591,7 @@ static int toshiba_acpi_suspend(struct device *device)
 
 static int toshiba_acpi_resume(struct device *device)
 {
-	struct toshiba_acpi_dev *dev = acpi_driver_data(to_acpi_device(device));
+	struct toshiba_acpi_dev *dev = dev_get_drvdata(device);
 
 	if (dev->hotkey_dev) {
 		if (toshiba_acpi_enable_hotkeys(dev))
@@ -3608,15 +3613,14 @@ static int toshiba_acpi_resume(struct device *device)
 static SIMPLE_DEV_PM_OPS(toshiba_acpi_pm,
 			 toshiba_acpi_suspend, toshiba_acpi_resume);
 
-static struct acpi_driver toshiba_acpi_driver = {
-	.name	= "Toshiba ACPI driver",
-	.ids	= toshiba_device_ids,
-	.flags	= ACPI_DRIVER_ALL_NOTIFY_EVENTS,
-	.ops	= {
-		.add		= toshiba_acpi_add,
-		.remove		= toshiba_acpi_remove,
+static struct platform_driver toshiba_acpi_driver = {
+	.probe = toshiba_acpi_probe,
+	.remove = toshiba_acpi_remove,
+	.driver = {
+		.name = "Toshiba ACPI driver",
+		.acpi_match_table = toshiba_device_ids,
+		.pm = &toshiba_acpi_pm,
 	},
-	.drv.pm	= &toshiba_acpi_pm,
 };
 
 static void __init toshiba_dmi_init(void)
@@ -3646,7 +3650,7 @@ static int __init toshiba_acpi_init(void)
 		return -ENODEV;
 	}
 
-	ret = acpi_bus_register_driver(&toshiba_acpi_driver);
+	ret = platform_driver_register(&toshiba_acpi_driver);
 	if (ret) {
 		pr_err("Failed to register ACPI driver: %d\n", ret);
 		remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
@@ -3657,7 +3661,7 @@ static int __init toshiba_acpi_init(void)
 
 static void __exit toshiba_acpi_exit(void)
 {
-	acpi_bus_unregister_driver(&toshiba_acpi_driver);
+	platform_driver_unregister(&toshiba_acpi_driver);
 	if (toshiba_proc_dir)
 		remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
 }
-- 
2.51.0




