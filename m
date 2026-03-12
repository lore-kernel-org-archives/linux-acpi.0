Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BC39900D;
	Thu, 12 Mar 2026 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326449; cv=none; b=Oqv12HtVjwbY0HBGrxqlGRs0iIsoroIKqTczGom/qN4whEKuDA7xVj24B7ekkI/Fei08ScibP988H2ynv0Hw4jkgBKty8r/qMMXG31fuJZdHvlOIS6Rw89yQzbqD4x5CfqGznnMNtDwFlzmsxXnyebwX1I6zYTe3AATYsEaDPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326449; c=relaxed/simple;
	bh=UJqTqQlkZpQ0R0oSBdc2IYOlKTSMkgyjXRPjl6LwcG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEhR3ozzG538CoHjKAlqGCXz+uVthKlBsncgEIJ9XYqH0XxTEvuE0m4+Sr1iBhlvpLnohoJuPOWjlm8E72R8Zr0+sGnyK+o3jyVp46B93Z6N8bZA1rjv6yAbLh855vbCgiHv+TAJ6l46BAu4jzp2pYViQZFGCeaCNS0xu5etMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5MN6h84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5MN6h84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B356C4CEF7;
	Thu, 12 Mar 2026 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773326448;
	bh=UJqTqQlkZpQ0R0oSBdc2IYOlKTSMkgyjXRPjl6LwcG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5MN6h847X5J/6bbhy815QkKCDP7hUfk+x/BMo0RSVOpoUjlq3YDkXLLQCgV5SVTT
	 18kq/YbX4lKA/NXCYR5C4VoP4sASxUn++w6pOeTF0gXTgzBdI5zm6MicAYuvYiRm4H
	 rnXzsae+viMX8dAh9ih+JFJPDWu09JSxtfkg4auoR2VtihBTyMrZ9eU6L4+SQgM2Sp
	 C2L6uTftAr+XxFppDEdL02SOZLlFmnHHuSI2gWdK/qHvsCdlUBUptYBsO49PT1vvu6
	 FuYtmljyQP5YSpEKgCXZf5NsyWrI0OVFY9zobkMQrNOpvem4E5dd4hh3WZgcD6jUMw
	 JftwnFvekR5bw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 2/2] platform/x86: wireless-hotkey: Convert ACPI driver to a
 platform one
Date: Thu, 12 Mar 2026 15:40:36 +0100
Message-ID: <9607409.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <23052072.EfDdHjke4D@rafael.j.wysocki>
References: <23052072.EfDdHjke4D@rafael.j.wysocki>
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
ACPI companions, so convert the airplane mode button for AMD, HP and
Xiaomi laptops driver from an ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/wireless-hotkey.c | 44 ++++++++++++++------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index a0ae757a277e..f680d8ff8e87 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -35,16 +35,17 @@ static const struct acpi_device_id wl_ids[] = {
 	{"", 0},
 };
 
-static int wireless_input_setup(struct acpi_device *device)
+static int wireless_input_setup(struct device *dev)
 {
-	struct wl_button *button = acpi_driver_data(device);
+	struct wl_button *button = dev_get_drvdata(dev);
 	int err;
 
 	button->input_dev = input_allocate_device();
 	if (!button->input_dev)
 		return -ENOMEM;
 
-	snprintf(button->phys, sizeof(button->phys), "%s/input0", acpi_device_hid(device));
+	snprintf(button->phys, sizeof(button->phys), "%s/input0",
+		 acpi_device_hid(ACPI_COMPANION(dev)));
 
 	button->input_dev->name = "Wireless hotkeys";
 	button->input_dev->phys = button->phys;
@@ -63,9 +64,9 @@ static int wireless_input_setup(struct acpi_device *device)
 	return err;
 }
 
-static void wireless_input_destroy(struct acpi_device *device)
+static void wireless_input_destroy(struct device *dev)
 {
-	struct wl_button *button = acpi_driver_data(device);
+	struct wl_button *button = dev_get_drvdata(dev);
 
 	input_unregister_device(button->input_dev);
 	kfree(button);
@@ -86,7 +87,7 @@ static void wl_notify(acpi_handle handle, u32 event, void *data)
 	input_sync(button->input_dev);
 }
 
-static int wl_add(struct acpi_device *device)
+static int wl_probe(struct platform_device *pdev)
 {
 	struct wl_button *button;
 	int err;
@@ -95,37 +96,38 @@ static int wl_add(struct acpi_device *device)
 	if (!button)
 		return -ENOMEM;
 
-	device->driver_data = button;
+	platform_set_drvdata(pdev, button);
 
-	err = wireless_input_setup(device);
+	err = wireless_input_setup(&pdev->dev);
 	if (err) {
 		pr_err("Failed to setup wireless hotkeys\n");
 		kfree(button);
 		return err;
 	}
-	err = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-					      wl_notify, button);
+	err = acpi_dev_install_notify_handler(ACPI_COMPANION(&pdev->dev),
+					      ACPI_DEVICE_NOTIFY, wl_notify, button);
 	if (err) {
 		pr_err("Failed to install ACPI notify handler\n");
-		wireless_input_destroy(device);
+		wireless_input_destroy(&pdev->dev);
 	}
 
 	return err;
 }
 
-static void wl_remove(struct acpi_device *device)
+static void wl_remove(struct platform_device *pdev)
 {
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, wl_notify);
-	wireless_input_destroy(device);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, wl_notify);
+	wireless_input_destroy(&pdev->dev);
 }
 
-static struct acpi_driver wl_driver = {
-	.name	= "wireless-hotkey",
-	.ids	= wl_ids,
-	.ops	= {
-		.add	= wl_add,
-		.remove	= wl_remove,
+static struct platform_driver wl_driver = {
+	.probe = wl_probe,
+	.remove = wl_remove,
+	.driver = {
+		.name = "wireless-hotkey",
+		.acpi_match_table = wl_ids,
 	},
 };
 
-module_acpi_driver(wl_driver);
+module_platform_driver(wl_driver);
-- 
2.51.0




