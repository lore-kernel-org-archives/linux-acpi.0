Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94D350297;
	Thu, 12 Mar 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325716; cv=none; b=YfnqqymzoDVT5yNDXp0A94GP+FfLGvxTh7d3cUCGf1+NPT6teV3nbGqOmoC5gmBH0c3ayZBtx/nYkNHDmmHo3ifP0ZUi+RP1FEAWLqBH7Y9t7LIZqd6qIUZaGER3wq+2wqzSmbqAuYiTXcXlFhoH8DwFVJdAvkk1jOtKbSU+LOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325716; c=relaxed/simple;
	bh=e2U9eN122fDpVzTwQdRJ1GP/p3VBgqfcorl72q98Fwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X46MY+tcrUrOljuFQvWy2f47toXA1U4s9nYQzZajhRCKxaZBmPFHUOOigOleRlT581ADeftqexqs79CJBQM/Hvktu9ZBdLnP/QXD6OgQRwu/W9k9+oP30Fm06LWNWhR/hn36siX9JvcM2yv3XheJ6HK9iLms+pqxClDIKfpYnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIIyGEq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIIyGEq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57B3C4CEF7;
	Thu, 12 Mar 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773325716;
	bh=e2U9eN122fDpVzTwQdRJ1GP/p3VBgqfcorl72q98Fwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIIyGEq7IjRAvqHN2EKwajZUojLPZPRrFDUn6I7Ey0vGfJ9MlT251MPqoTkPxmt61
	 7pu53SYE/J1w66VWplMLn7MpSJDqZcjv66U7I3IEXO//ONKckc9DkfmQOpKAw4m/+Y
	 oSkM4RyW1IWoLlJGG03/rl0CM7XmHlGcEnpAf5OZqKGHyhSAjQjDw38DZBmt1crUu8
	 3M7nH1+XpNlc4F9iIi0IfXQUkOpzf5tsWEDHnaWJY77YsdZV5cxUczl+6RaLhZiiKj
	 3G389TumTSghtrqM46n3m70zbWRCSmN6plHzgLbX11y5kG5lII6kUdiOeBfiMA0trO
	 tcw1iR7yOaVWA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>
Subject:
 [PATCH v1 2/2] platform/x86: system76: Convert ACPI driver to a platform one
Date: Thu, 12 Mar 2026 15:28:00 +0100
Message-ID: <1968431.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2841136.mvXUDI8C0e@rafael.j.wysocki>
References: <2841136.mvXUDI8C0e@rafael.j.wysocki>
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
 drivers/platform/x86/system76_acpi.c | 52 +++++++++++++++-------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 35e294a55fa3..b3a4254156ae 100644
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
@@ -767,7 +771,7 @@ static int system76_add(struct acpi_device *acpi_dev)
 		if (err)
 			goto error;
 
-		data->therm = devm_hwmon_device_register_with_info(&acpi_dev->dev,
+		data->therm = devm_hwmon_device_register_with_info(&pdev->dev,
 			"system76_acpi", data, &thermal_chip_info, NULL);
 		err = PTR_ERR_OR_ZERO(data->therm);
 		if (err)
@@ -795,14 +799,13 @@ static int system76_add(struct acpi_device *acpi_dev)
 	return err;
 }
 
-// Remove a System76 ACPI device
-static void system76_remove(struct acpi_device *acpi_dev)
+// Remove a System76 platform device
+static void system76_remove(struct platform_device *pdev)
 {
-	struct system76_data *data;
-
-	acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY, system76_notify);
+	struct system76_data *data = platform_get_drvdata(pdev);
 
-	data = acpi_driver_data(acpi_dev);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, system76_notify);
 
 	if (data->has_open_ec) {
 		system76_battery_exit();
@@ -810,22 +813,21 @@ static void system76_remove(struct acpi_device *acpi_dev)
 		kfree(data->ntmp);
 	}
 
-	devm_led_classdev_unregister(&acpi_dev->dev, &data->ap_led);
-	devm_led_classdev_unregister(&acpi_dev->dev, &data->kb_led);
+	devm_led_classdev_unregister(&pdev->dev, &data->ap_led);
+	devm_led_classdev_unregister(&pdev->dev, &data->kb_led);
 
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




