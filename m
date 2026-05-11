Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD32EBBA4;
	Mon, 11 May 2026 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528913; cv=none; b=kdzbESZWS6S1GoJsLFo9Gs1nbUfq1PE1xUoZxgg1kTcqeVFYm9fcyJnF6oqOEyjSDBZFJe+bWcb4MSqRYoCkCB7Nbka+/y1/TnKdWPPCzxiulXMImrodb6vP8mSLNixtyDScUfMl73BLf+rXsLhCd5NrIVqyHiFBt7XrX6FYAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528913; c=relaxed/simple;
	bh=5KJhH2QE22ZyIPky79BfSY4uMykOieexCDPyoZwRHH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AZMl6AW3aoRie+2ZXr1Zj3cSmHBw+o+VBwVKjlvh1P/afKvHmr7lySJ+ky5SABJ8qzUTI3wtj5WupZXlzlHcxCpXTV5JhDnpX85OT/wAR9H2NYj47wMT6f1kiP3lICXTbYn+lXQngjoWQ9S2o+yyKi7KhdCT854Yr4QQCEA0Hzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y90YmQRi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y90YmQRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087E0C2BCB0;
	Mon, 11 May 2026 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778528912;
	bh=5KJhH2QE22ZyIPky79BfSY4uMykOieexCDPyoZwRHH4=;
	h=From:To:Cc:Subject:Date:From;
	b=Y90YmQRiIjX71Tw3pRmAnwgt4TXnlcoHNGvPmXFcD3V8Gt2gXdI+cwO1iMepNdQbW
	 iY92FVP4x9Q3F3ngMVpYI18Ee3H2iYW8F9NH64CPkNMk1iah1HL22jTNVk2MbZu/5t
	 H2s9jQUKVjmeVPAWNvFGWGh1j1RsI3NX58g7JLsMtM0hZj9TycejgsMJ5Ko2OhwWiH
	 Bpbd4uY1U/k1BOCkNnTdZerEB99JzTwUDBodBG4JEBEYOL2XgnVMZXLlZkEbFzTYE0
	 ivzWKPUCTvfETtb8OaWP1zyv7fvk9Iu7XcPnPt6f5iDNTkKYUzV0HY4UlAZvnZSoYO
	 YmsxLGguIhPKA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <denis.benato@linux.dev>,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>,
 Matan Ziv-Av <matan@svgalib.org>, Kenneth Chan <kenneth.t.chan@gmail.com>,
 Mattia Dongili <malattia@linux.it>, Jeremy Soller <jeremy@system76.com>,
 Azael Avalos <coproscefalo@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1] platform/x86: Check ACPI_COMPANION() against NULL during probe
Date: Mon, 11 May 2026 21:48:26 +0200
Message-ID: <5990022.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
against NULL to multiple platform/x86 drivers that have been converted
to platform drivers from ACPI drivers recently.

Fixes: 578bc2a53ae2 ("platform/wmi: Convert drivers to use wmidev_invoke_procedure()")
Fixes: f7e648027d7e ("platform/x86: asus-wireless: Convert ACPI driver to a platform one")
Fixes: ba19eb10170b ("platform/x86: asus-laptop: Convert ACPI driver to a platform one")
Fixes: 3a96c7915d93 ("platform/x86: toshiba_haps: Convert ACPI driver to a platform one")
Fixes: 553b2ac59fbb ("platform/x86: toshiba_bluetooth: Convert ACPI driver to a platform one")
Fixes: 246d6cefe525 ("platform/x86: toshiba_acpi: Convert ACPI driver to a platform one")
Fixes: 19ebacfb442b ("platform/x86: dell/dell-rbtn: Convert ACPI driver to a platform one")
Fixes: 80b8f68b94ab ("platform/x86: system76: Convert ACPI driver to a platform one")
Fixes: de6837243af0 ("platform/x86: panasonic-laptop: Convert ACPI driver to a platform one")
Fixes: 6da22b031a3c ("platform/x86: fujitsu: Convert laptop driver to a platform one")
Fixes: d5c9212ccfaa ("platform/x86: fujitsu: Convert backlight driver to a platform one")
Fixes: bd13b265d386 ("platform/x86: fujitsu-tablet: Convert ACPI driver to a platform one")
Fixes: 8507277ef132 ("platform/x86: wireless-hotkey: Convert ACPI driver to a platform one")
Fixes: 3471415c8186 ("platform/x86: topstar-laptop: Convert ACPI driver to a platform one")
Fixes: 138db7ee58c0 ("platform/x86: sony-laptop: Convert PIC driver to a platform one")
Fixes: 14004dd31caa ("platform/x86: sony-laptop: Convert NC driver to a platform one")
Fixes: 2d9cb20610f7 ("platform/x86: lg-laptop: Convert ACPI driver to a platform one")
Fixes: 8a44bd3ffdb2 ("platform/x86: intel/smartconnect: Convert ACPI driver to a platform one")
Fixes: 163a68a31f74 ("platform/x86: intel/rst: Convert ACPI driver to a platform one")
Fixes: 079b59fd2d79 ("platform/x86: eeepc-laptop: Convert ACPI driver to a platform one")
Fixes: b30a462720ad ("platform/x86: acer-wireless: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/acer-wireless.c      |    8 ++++++--
 drivers/platform/x86/asus-laptop.c        |    6 +++++-
 drivers/platform/x86/dell/dell-rbtn.c     |    6 +++++-
 drivers/platform/x86/eeepc-laptop.c       |    6 +++++-
 drivers/platform/x86/fujitsu-laptop.c     |   12 ++++++++++--
 drivers/platform/x86/fujitsu-tablet.c     |    6 +++++-
 drivers/platform/x86/intel/rst.c          |    6 +++++-
 drivers/platform/x86/intel/smartconnect.c |    6 +++++-
 drivers/platform/x86/lg-laptop.c          |    9 +++++++--
 drivers/platform/x86/panasonic-laptop.c   |    6 +++++-
 drivers/platform/x86/sony-laptop.c        |   12 ++++++++++--
 drivers/platform/x86/system76_acpi.c      |    6 +++++-
 drivers/platform/x86/toshiba_acpi.c       |    6 +++++-
 drivers/platform/x86/toshiba_bluetooth.c  |    6 +++++-
 drivers/platform/x86/toshiba_haps.c       |    6 +++++-
 drivers/platform/x86/wireless-hotkey.c    |    9 +++++++--
 16 files changed, 95 insertions(+), 21 deletions(-)

--- a/drivers/platform/x86/acer-wireless.c
+++ b/drivers/platform/x86/acer-wireless.c
@@ -37,9 +37,14 @@ static void acer_wireless_notify(acpi_ha
 
 static int acer_wireless_probe(struct platform_device *pdev)
 {
+	struct acpi_device *adev;
 	struct input_dev *idev;
 	int ret;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	idev = devm_input_allocate_device(&pdev->dev);
 	if (!idev)
 		return -ENOMEM;
@@ -57,8 +62,7 @@ static int acer_wireless_probe(struct pl
 	if (ret)
 		return ret;
 
-	return acpi_dev_install_notify_handler(ACPI_COMPANION(&pdev->dev),
-					       ACPI_DEVICE_NOTIFY,
+	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
 					       acer_wireless_notify,
 					       &pdev->dev);
 }
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1826,10 +1826,14 @@ static bool asus_device_present;
 
 static int asus_acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	struct asus_laptop *asus;
 	int result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	pr_notice("Asus Laptop Support version %s\n",
 		  ASUS_LAPTOP_VERSION);
 	asus = kzalloc_obj(struct asus_laptop);
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -396,11 +396,15 @@ static void rbtn_cleanup(struct device *
 
 static int rbtn_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct rbtn_data *rbtn_data;
+	struct acpi_device *device;
 	enum rbtn_type type;
 	int ret = 0;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	type = rbtn_check(device);
 	if (type == RBTN_UNKNOWN) {
 		dev_info(&pdev->dev, "Unknown device type\n");
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1363,10 +1363,14 @@ static bool eeepc_device_present;
 
 static int eeepc_acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	struct eeepc_laptop *eeepc;
 	int result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	pr_notice(EEEPC_LAPTOP_NAME "\n");
 	eeepc = kzalloc_obj(struct eeepc_laptop);
 	if (!eeepc)
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -530,10 +530,14 @@ static void acpi_fujitsu_bl_notify(acpi_
 
 static int acpi_fujitsu_bl_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	struct fujitsu_bl *priv;
 	int ret;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return -ENODEV;
 
@@ -993,10 +997,14 @@ static void acpi_fujitsu_laptop_notify(a
 
 static int acpi_fujitsu_laptop_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct fujitsu_laptop *priv;
+	struct acpi_device *device;
 	int ret, i = 0;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
--- a/drivers/platform/x86/fujitsu-tablet.c
+++ b/drivers/platform/x86/fujitsu-tablet.c
@@ -445,10 +445,14 @@ static acpi_status fujitsu_walk_resource
 
 static int acpi_fujitsu_probe(struct platform_device *pdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev;
 	acpi_status status;
 	int error;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
 			fujitsu_walk_resources, NULL);
 	if (ACPI_FAILURE(status) || !fujitsu.irq || !fujitsu.io_base)
--- a/drivers/platform/x86/intel/rst.c
+++ b/drivers/platform/x86/intel/rst.c
@@ -102,9 +102,13 @@ static struct device_attribute irst_time
 
 static int irst_probe(struct platform_device *pdev)
 {
-	struct acpi_device *acpi = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *acpi;
 	int error;
 
+	acpi = ACPI_COMPANION(&pdev->dev);
+	if (!acpi)
+		return -ENODEV;
+
 	error = device_create_file(&acpi->dev, &irst_timeout_attr);
 	if (unlikely(error))
 		return error;
--- a/drivers/platform/x86/intel/smartconnect.c
+++ b/drivers/platform/x86/intel/smartconnect.c
@@ -12,10 +12,14 @@ MODULE_LICENSE("GPL");
 
 static int smartconnect_acpi_probe(struct platform_device *pdev)
 {
-	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	unsigned long long value;
+	acpi_handle handle;
 	acpi_status status;
 
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
 	status = acpi_evaluate_integer(handle, "GAOS", NULL, &value);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -761,12 +761,11 @@ static void lg_laptop_remove_address_spa
 
 static int acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct platform_device_info pdev_info = {
-		.fwnode = acpi_fwnode_handle(device),
 		.name = PLATFORM_NAME,
 		.id = PLATFORM_DEVID_NONE,
 	};
+	struct acpi_device *device;
 	acpi_status status;
 	int ret;
 	const char *product;
@@ -775,6 +774,12 @@ static int acpi_probe(struct platform_de
 	if (pf_device)
 		return 0;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
+	pdev_info.fwnode = acpi_fwnode_handle(device),
+
 	status = acpi_install_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,
 						    &lg_laptop_address_space_handler,
 						    NULL, &pdev->dev);
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -981,11 +981,15 @@ static int acpi_pcc_hotkey_resume(struct
 
 static int acpi_pcc_hotkey_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct backlight_properties props;
+	struct acpi_device *device;
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	num_sifr = acpi_pcc_get_sqty(device);
 
 	/*
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -3147,11 +3147,15 @@ static void sony_nc_backlight_cleanup(vo
 
 static int sony_nc_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	acpi_status status;
 	int result = 0;
 	struct sony_nc_value *item;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	sony_nc_acpi_device = device;
 	strscpy(acpi_device_class(device), "sony/hotkey");
 
@@ -4509,11 +4513,15 @@ static void sony_pic_remove(struct platf
 
 static int sony_pic_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct sony_pic_ioport *io, *tmp_io;
 	struct sony_pic_irq *irq, *tmp_irq;
+	struct acpi_device *device;
 	int result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	spic_dev.acpi_dev = device;
 	strscpy(acpi_device_class(device), "sony/hotkey");
 	sony_pic_detect_device_type(&spic_dev);
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -674,10 +674,14 @@ static void system76_notify(acpi_handle
 // Probe a System76 platform device
 static int system76_probe(struct platform_device *pdev)
 {
-	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *acpi_dev;
 	struct system76_data *data;
 	int err;
 
+	acpi_dev = ACPI_COMPANION(&pdev->dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3374,7 +3374,7 @@ static const struct dmi_system_id toshib
 
 static int toshiba_acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *acpi_dev;
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
@@ -3383,6 +3383,10 @@ static int toshiba_acpi_probe(struct pla
 	if (toshiba_acpi)
 		return -EBUSY;
 
+	acpi_dev = ACPI_COMPANION(&pdev->dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
 	pr_info("Toshiba Laptop ACPI Extras version %s\n",
 	       TOSHIBA_ACPI_VERSION);
 
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -230,10 +230,14 @@ static int toshiba_bt_resume(struct devi
 
 static int toshiba_bt_rfkill_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct toshiba_bluetooth_dev *bt_dev;
+	struct acpi_device *device;
 	int result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	result = toshiba_bluetooth_present(device->handle);
 	if (result)
 		return result;
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -182,13 +182,17 @@ static int toshiba_haps_available(acpi_h
 
 static int toshiba_haps_probe(struct platform_device *pdev)
 {
-	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
 	struct toshiba_haps_dev *haps;
+	struct acpi_device *acpi_dev;
 	int ret;
 
 	if (toshiba_haps)
 		return -EBUSY;
 
+	acpi_dev = ACPI_COMPANION(&pdev->dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
 	if (!toshiba_haps_available(acpi_dev->handle))
 		return -ENODEV;
 
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -89,9 +89,14 @@ static void wl_notify(acpi_handle handle
 
 static int wl_probe(struct platform_device *pdev)
 {
+	struct acpi_device *adev;
 	struct wl_button *button;
 	int err;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	button = kzalloc_obj(struct wl_button);
 	if (!button)
 		return -ENOMEM;
@@ -104,8 +109,8 @@ static int wl_probe(struct platform_devi
 		kfree(button);
 		return err;
 	}
-	err = acpi_dev_install_notify_handler(ACPI_COMPANION(&pdev->dev),
-					      ACPI_DEVICE_NOTIFY, wl_notify, button);
+	err = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+					      wl_notify, button);
 	if (err) {
 		pr_err("Failed to install ACPI notify handler\n");
 		wireless_input_destroy(&pdev->dev);



