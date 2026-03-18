Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D83D5254;
	Wed, 18 Mar 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842240; cv=none; b=IOao7ms0CyH265TLGDVkCsVkRFs4LxoSfXA6owFVs8Zhj9gvWQ8BdpOIPXFpNxZ2xRhhivTo1dc1apSnllVeDXq5UbGosy8IPx863LKV1cL2U6FxrqbJEquIKZWeS1EF5nisccJIJpkxiZow7iwhXJTcoy9V98DxWz+WlG8L4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842240; c=relaxed/simple;
	bh=OGSzkPDTrsLqaDFDAqTsRYy4F9/t+0a9NghXVnMTJUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac9+OaksAAufWdW+2CbQobHrZJOvvDQW2AJJz0NP/2A/f+p4ct2DthGyAGu68lZL5NvqZciE8h0COPo2qu005Gw8eKfFmYBoaKDImAwWICOnlXqVAvt9LslzGfpRHIa+YJlW9bip5NKX/l99LrCkulziunL5y4HAMDpbzTHVFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwyFnOZ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwyFnOZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B021C19421;
	Wed, 18 Mar 2026 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773842240;
	bh=OGSzkPDTrsLqaDFDAqTsRYy4F9/t+0a9NghXVnMTJUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwyFnOZ7ykJudLKusPznZ8fq9YO6oEyqPjr8VGkdYB8W8Io909+3tlqhKJZCmvmjl
	 +Cc/NtBwZSz2U9JQtiQSzI+/Jo+Y2Y57m33brLRbeP5H4NtGF/QfPgNz33fyNSsb+N
	 xn8Cva4CO9jRBfQrUj4oH19lcxXbEMrDrIEmbr+nKASzcKJJsxefKlioE6Hvdb15By
	 /paTUYVIG0BA/+ASG5cpzR7l2xTn/gMhzV1ThqI4ecnKMwQ0a0GK2uNcZpxZvvZCmh
	 BV2hH34Kpux73y85ds7ZyWP49UOmZU5m066wXtNdDoR4jA6/14g/M+mxPM7+V3OtQg
	 T4hNs5tyGg0Xw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>
Subject:
 [PATCH v2 3/3] platform/x86: system76: Convert ACPI driver to a platform one
Date: Wed, 18 Mar 2026 14:54:45 +0100
Message-ID: <3401648.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4721148.LvFx2qVVIh@rafael.j.wysocki>
References: <4721148.LvFx2qVVIh@rafael.j.wysocki>
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
ACPI companions, so convert the System76 ACPI driver to a platform one.

After this change, the subordinate hwmon, input and LED class devices
will be registered under the platform device used for driver binding
instead of its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase on top of the new [1/3] and the updated [2/3].

---
 drivers/platform/x86/system76_acpi.c | 48 +++++++++++++++-------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index fc11427c36a5..693cbb461382 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -18,6 +18,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/pci_ids.h>
+#include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -670,16 +671,19 @@ static void system76_notify(acpi_handle handle, u32 event, void *context)
 	}
 }
 
-// Add a System76 ACPI device
-static int system76_add(struct acpi_device *acpi_dev)
+// Probe a System76 platform device
+static int system76_probe(struct platform_device *pdev)
 {
+	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
 	struct system76_data *data;
 	int err;
 
-	data = devm_kzalloc(&acpi_dev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	acpi_dev->driver_data = data;
+
+	platform_set_drvdata(pdev, data);
+
 	data->acpi_dev = acpi_dev;
 
 	// Some models do not run open EC firmware. Check for an ACPI method
@@ -695,7 +699,7 @@ static int system76_add(struct acpi_device *acpi_dev)
 	data->ap_led.brightness_set_blocking = ap_led_set;
 	data->ap_led.max_brightness = 1;
 	data->ap_led.default_trigger = "rfkill-none";
-	err = devm_led_classdev_register(&acpi_dev->dev, &data->ap_led);
+	err = devm_led_classdev_register(&pdev->dev, &data->ap_led);
 	if (err)
 		return err;
 
@@ -739,19 +743,19 @@ static int system76_add(struct acpi_device *acpi_dev)
 	}
 
 	if (data->kbled_type != KBLED_NONE) {
-		err = devm_led_classdev_register(&acpi_dev->dev, &data->kb_led);
+		err = devm_led_classdev_register(&pdev->dev, &data->kb_led);
 		if (err)
 			return err;
 	}
 
-	data->input = devm_input_allocate_device(&acpi_dev->dev);
+	data->input = devm_input_allocate_device(&pdev->dev);
 	if (!data->input)
 		return -ENOMEM;
 
 	data->input->name = "System76 ACPI Hotkeys";
 	data->input->phys = "system76_acpi/input0";
 	data->input->id.bustype = BUS_HOST;
-	data->input->dev.parent = &acpi_dev->dev;
+	data->input->dev.parent = &pdev->dev;
 	input_set_capability(data->input, EV_KEY, KEY_SCREENLOCK);
 
 	err = input_register_device(data->input);
@@ -772,7 +776,7 @@ static int system76_add(struct acpi_device *acpi_dev)
 		if (err)
 			goto error;
 
-		data->therm = devm_hwmon_device_register_with_info(&acpi_dev->dev,
+		data->therm = devm_hwmon_device_register_with_info(&pdev->dev,
 			"system76_acpi", data, &thermal_chip_info, NULL);
 		err = PTR_ERR_OR_ZERO(data->therm);
 		if (err)
@@ -792,12 +796,10 @@ static int system76_add(struct acpi_device *acpi_dev)
 	return err;
 }
 
-// Remove a System76 ACPI device
-static void system76_remove(struct acpi_device *acpi_dev)
+// Remove a System76 platform device
+static void system76_remove(struct platform_device *pdev)
 {
-	struct system76_data *data;
-
-	data = acpi_driver_data(acpi_dev);
+	struct system76_data *data = platform_get_drvdata(pdev);
 
 	if (data->has_open_ec) {
 		system76_battery_exit();
@@ -805,21 +807,21 @@ static void system76_remove(struct acpi_device *acpi_dev)
 		kfree(data->ntmp);
 	}
 
-	acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY, system76_notify);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, system76_notify);
 
 	system76_get(data, "FINI");
 }
 
-static struct acpi_driver system76_driver = {
-	.name = "System76 ACPI Driver",
-	.class = "hotkey",
-	.ids = device_ids,
-	.ops = {
-		.add = system76_add,
-		.remove = system76_remove,
+static struct platform_driver system76_driver = {
+	.probe = system76_probe,
+	.remove = system76_remove,
+	.driver = {
+		.name = "System76 ACPI Driver",
+		.acpi_match_table = device_ids,
 	},
 };
-module_acpi_driver(system76_driver);
+module_platform_driver(system76_driver);
 
 MODULE_DESCRIPTION("System76 ACPI Driver");
 MODULE_AUTHOR("Jeremy Soller <jeremy@system76.com>");
-- 
2.51.0




