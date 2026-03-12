Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC6372B3D;
	Thu, 12 Mar 2026 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315049; cv=none; b=grMB6ODsqJxGSlzmguZG6pYZgOKhJJwESsv2x0d3DxkjyWadm+8AUoTq5sVuE5405XKmPHqixqx7jCUZNdwBHtaG9K/i6On77+tjC/h6vJtvuz1kFRIB3QZvh25m4hqBSKd0rWC41Tgt9p4nes2hz1b+9/gyEPUpKg2d0EKMrRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315049; c=relaxed/simple;
	bh=MY9n/GGQh0kL7mITnqGGQxMGq5fETLWrK0OqcXRxmrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtdowHjYdra/9aSM/SoVDn2X8fM454e495uq+5dqRNL7BsphvO6wCiZSBahDqnHUAojkm/C89VcdQBnHNJaop8EwSrtJchTJdpncSNdtMFJYOhF7U1pmHFmA1wWck6OLhEZ5wajd0U1yoKmoQd4h4rmHxdfFyvuZ4AW+O8Whecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7G0eikh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7G0eikh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13183C4CEF7;
	Thu, 12 Mar 2026 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773315048;
	bh=MY9n/GGQh0kL7mITnqGGQxMGq5fETLWrK0OqcXRxmrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7G0eikhC6OXSMllAqmcfWftAlDKizn7xWauYFHyDertIezOfReFTvwSerqN1Cpjp
	 vfFeUFfwY0wjjMjplXak//iLZ6U+5nN1eQmZFQWqctkIAfq03DhP4tsVzaF1nLfhzz
	 QmanwLRTA5IXo8i1ridq7bgpIxfBKplKv1EI0MVgPffqM9cWM/Lc7dfHx9d9EhKaCT
	 0+72ZPn4YZLrfiTOkZvOQ/Y5G0y7uV734EL6lQH+Cb1r1V0av/Sd3kQfVXyy8a1w+d
	 ZvtNgxkWOPr27Pq7/mqzZCyJ6DR+5Fk/YB9vqoJPmdbsq+As9S5uvn6BZnOWcHfaiN
	 kaY+lxp2a68hg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Mattia Dongili <malattia@linux.it>
Subject:
 [PATCH v1 2/3] platform/x86: sony-laptop: Convert NC driver to a platform one
Date: Thu, 12 Mar 2026 12:29:44 +0100
Message-ID: <886676729.0ifERbkFSE@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2284006.Icojqenx9y@rafael.j.wysocki>
References: <2284006.Icojqenx9y@rafael.j.wysocki>
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
ACPI companions, so convert the Notebook Control (nc) part of the Sony
laptop driver from an ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/sony-laptop.c | 65 ++++++++++++++----------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 6f417b5cdfe2..bc9a3ae71be8 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -178,8 +178,7 @@ enum sony_nc_rfkill {
 static int sony_rfkill_handle;
 static struct rfkill *sony_rfkill_devices[N_SONY_RFKILL];
 static int sony_rfkill_address[N_SONY_RFKILL] = {0x300, 0x500, 0x700, 0x900};
-static int sony_nc_rfkill_setup(struct acpi_device *device,
-		unsigned int handle);
+static int sony_nc_rfkill_setup(struct device *dev, unsigned int handle);
 static void sony_nc_rfkill_cleanup(void);
 static void sony_nc_rfkill_update(void);
 
@@ -435,7 +434,7 @@ static void sony_laptop_report_input_event(u8 event)
 		dprintk("unknown input event %.2x\n", event);
 }
 
-static int sony_laptop_setup_input(struct acpi_device *acpi_device)
+static int sony_laptop_setup_input(struct device *parent)
 {
 	struct input_dev *jog_dev;
 	struct input_dev *key_dev;
@@ -468,7 +467,7 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 	key_dev->name = "Sony Vaio Keys";
 	key_dev->id.bustype = BUS_ISA;
 	key_dev->id.vendor = PCI_VENDOR_ID_SONY;
-	key_dev->dev.parent = &acpi_device->dev;
+	key_dev->dev.parent = parent;
 
 	/* Initialize the Input Drivers: special keys */
 	input_set_capability(key_dev, EV_MSC, MSC_SCAN);
@@ -497,7 +496,7 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 	jog_dev->name = "Sony Vaio Jogdial";
 	jog_dev->id.bustype = BUS_ISA;
 	jog_dev->id.vendor = PCI_VENDOR_ID_SONY;
-	jog_dev->dev.parent = &acpi_device->dev;
+	jog_dev->dev.parent = parent;
 
 	input_set_capability(jog_dev, EV_KEY, BTN_MIDDLE);
 	input_set_capability(jog_dev, EV_REL, REL_WHEEL);
@@ -1287,7 +1286,7 @@ static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
 /*
  * ACPI device
  */
-static void sony_nc_function_setup(struct acpi_device *device,
+static void sony_nc_function_setup(struct device *dev,
 		struct platform_device *pf_device)
 {
 	unsigned int i, result, bitmask, arg;
@@ -1360,7 +1359,7 @@ static void sony_nc_function_setup(struct acpi_device *device,
 			break;
 		case 0x0124:
 		case 0x0135:
-			result = sony_nc_rfkill_setup(device, handle);
+			result = sony_nc_rfkill_setup(dev, handle);
 			if (result)
 				pr_err("couldn't set up rfkill support (%d)\n",
 						result);
@@ -1600,8 +1599,7 @@ static const struct rfkill_ops sony_rfkill_ops = {
 	.set_block = sony_nc_rfkill_set,
 };
 
-static int sony_nc_setup_rfkill(struct acpi_device *device,
-				enum sony_nc_rfkill nc_type)
+static int sony_nc_setup_rfkill(struct device *parent, enum sony_nc_rfkill nc_type)
 {
 	int err;
 	struct rfkill *rfk;
@@ -1631,8 +1629,7 @@ static int sony_nc_setup_rfkill(struct acpi_device *device,
 		return -EINVAL;
 	}
 
-	rfk = rfkill_alloc(name, &device->dev, type,
-			   &sony_rfkill_ops, (void *)nc_type);
+	rfk = rfkill_alloc(name, parent, type, &sony_rfkill_ops, (void *)nc_type);
 	if (!rfk)
 		return -ENOMEM;
 
@@ -1692,8 +1689,7 @@ static void sony_nc_rfkill_update(void)
 	}
 }
 
-static int sony_nc_rfkill_setup(struct acpi_device *device,
-		unsigned int handle)
+static int sony_nc_rfkill_setup(struct device *parent, unsigned int handle)
 {
 	u64 offset;
 	int i;
@@ -1734,18 +1730,18 @@ static int sony_nc_rfkill_setup(struct acpi_device *device,
 		dprintk("Radio devices, found 0x%.2x\n", buffer[i]);
 
 		if (buffer[i] == 0 && !sony_rfkill_devices[SONY_WIFI])
-			sony_nc_setup_rfkill(device, SONY_WIFI);
+			sony_nc_setup_rfkill(parent, SONY_WIFI);
 
 		if (buffer[i] == 0x10 && !sony_rfkill_devices[SONY_BLUETOOTH])
-			sony_nc_setup_rfkill(device, SONY_BLUETOOTH);
+			sony_nc_setup_rfkill(parent, SONY_BLUETOOTH);
 
 		if (((0xf0 & buffer[i]) == 0x20 ||
 					(0xf0 & buffer[i]) == 0x50) &&
 				!sony_rfkill_devices[SONY_WWAN])
-			sony_nc_setup_rfkill(device, SONY_WWAN);
+			sony_nc_setup_rfkill(parent, SONY_WWAN);
 
 		if (buffer[i] == 0x30 && !sony_rfkill_devices[SONY_WIMAX])
-			sony_nc_setup_rfkill(device, SONY_WIMAX);
+			sony_nc_setup_rfkill(parent, SONY_WIMAX);
 	}
 	return 0;
 }
@@ -3149,8 +3145,9 @@ static void sony_nc_backlight_cleanup(void)
 	backlight_device_unregister(sony_bl_props.dev);
 }
 
-static int sony_nc_add(struct acpi_device *device)
+static int sony_nc_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 	int result = 0;
 	struct sony_nc_value *item;
@@ -3184,7 +3181,7 @@ static int sony_nc_add(struct acpi_device *device)
 		}
 	}
 
-	result = sony_laptop_setup_input(device);
+	result = sony_laptop_setup_input(&pdev->dev);
 	if (result) {
 		pr_err("Unable to create input devices\n");
 		goto outplatform;
@@ -3201,7 +3198,7 @@ static int sony_nc_add(struct acpi_device *device)
 		/* retrieve the available handles */
 		result = sony_nc_handles_setup(sony_pf_device);
 		if (!result)
-			sony_nc_function_setup(device, sony_pf_device);
+			sony_nc_function_setup(&pdev->dev, sony_pf_device);
 	}
 
 	if (acpi_video_get_backlight_type() == acpi_backlight_vendor)
@@ -3271,11 +3268,12 @@ static int sony_nc_add(struct acpi_device *device)
 	return result;
 }
 
-static void sony_nc_remove(struct acpi_device *device)
+static void sony_nc_remove(struct platform_device *pdev)
 {
 	struct sony_nc_value *item;
 
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, sony_nc_notify);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, sony_nc_notify);
 
 	sony_nc_backlight_cleanup();
 
@@ -3304,15 +3302,14 @@ static const struct acpi_device_id sony_nc_device_ids[] = {
 	{"", 0},
 };
 
-static struct acpi_driver sony_nc_driver = {
-	.name = SONY_NC_DRIVER_NAME,
-	.class = SONY_NC_CLASS,
-	.ids = sony_nc_device_ids,
-	.ops = {
-		.add = sony_nc_add,
-		.remove = sony_nc_remove,
-		},
-	.drv.pm = &sony_nc_pm,
+static struct platform_driver sony_nc_driver = {
+	.probe = sony_nc_probe,
+	.remove = sony_nc_remove,
+	.driver = {
+		.name = SONY_NC_DRIVER_NAME,
+		.acpi_match_table = sony_nc_device_ids,
+		.pm = &sony_nc_pm,
+	},
 };
 
 /*********** SPIC (SNY6001) Device ***********/
@@ -4529,7 +4526,7 @@ static int sony_pic_add(struct acpi_device *device)
 	}
 
 	/* setup input devices and helper fifo */
-	result = sony_laptop_setup_input(device);
+	result = sony_laptop_setup_input(&device->dev);
 	if (result) {
 		pr_err("Unable to create input devices\n");
 		goto err_free_resources;
@@ -4720,7 +4717,7 @@ static int __init sony_laptop_init(void)
 		spic_drv_registered = 1;
 	}
 
-	result = acpi_bus_register_driver(&sony_nc_driver);
+	result = platform_driver_register(&sony_nc_driver);
 	if (result) {
 		pr_err("Unable to register SNC driver\n");
 		goto out_unregister_pic;
@@ -4737,7 +4734,7 @@ static int __init sony_laptop_init(void)
 
 static void __exit sony_laptop_exit(void)
 {
-	acpi_bus_unregister_driver(&sony_nc_driver);
+	platform_driver_unregister(&sony_nc_driver);
 	if (spic_drv_registered)
 		acpi_bus_unregister_driver(&sony_pic_driver);
 }
-- 
2.51.0




