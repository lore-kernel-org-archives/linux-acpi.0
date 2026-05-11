Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F9230264;
	Mon, 11 May 2026 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530538; cv=none; b=E7pI9lthfqpwMHkiuZbbc/eJ1CcWGbSP1axwCGfTU1aG9HEHpkMedvl1wISp2uHBQFxG+D3NdW3cREu0lXAWfgTtayep6I/JgFItoevksDp8lnr4M/CaZxoGR4by7XLp5j40kRVdHka4CJHsjF2cv52xYRrgA6zxg/qAUGBBuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530538; c=relaxed/simple;
	bh=mw8u+hKWbeVjj45WqEk7aORI6wuF0G/qXP+Lbmptmbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smVYLvNCm3xPgut75FZkD31ziKZnVsNRUcBK3pzZYF8uf5F7z8EQE+tm5fCvRE692xfOYYutlasST0LVk3TTgsOv612nylnftbfx4SuUYGLpUS3G/HiKd4iYB6O0u3+oznW3AzM1K5aIuvZsjH1jg9jpZQCx6hE901SRq2W7i00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP9RF/95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP9RF/95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15437C2BCC9;
	Mon, 11 May 2026 20:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530537;
	bh=mw8u+hKWbeVjj45WqEk7aORI6wuF0G/qXP+Lbmptmbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JP9RF/9539rUwfC2smcYDilgYX6b0pCnA7EU97cQWvTnbFnGZzuVOaGUfwcBqoX2B
	 zD/VlNjVna5aCxqJzNB0XesAHoZlBy5OLyj71zETfy3oWDoebGsQV06x90jLQlEAcr
	 5hO92nqFSypl+Ho2bSbK1bO2VLN4Xx6tftjZrDf9yNoSr0g1Yu7R/13aJEdZS9VsEC
	 4JRW30ZBvAuWorGiVX8SiUyKeP4kL7ijLwX960PTAQb5bY8NMU3PBlm9L396CQqKQf
	 arLu/SPDIH7+iPuVJAHLAstCm/bpBz/LnzCcyAmsoaXY4r66I3TWd1kAd5FUa1CNXB
	 ciODFR/K/j8pg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 10/10] platform/x86: classmate-laptop: Convert keys driver to a
 platform one
Date: Mon, 11 May 2026 22:15:18 +0200
Message-ID: <2002306.taCxCBeP46@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3415394.44csPzL39Z@rafael.j.wysocki>
References: <3415394.44csPzL39Z@rafael.j.wysocki>
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
ACPI companions, so convert cmpc_keys_acpi_driver in the Classmate
laptop driver from an ACPI driver to a platform one.

After this change, the input device registered by the driver will appear
under the platform device used for driver binding.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase
   * Check the ACPI companion against NULL at probe time

---
 drivers/platform/x86/classmate-laptop.c | 46 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 08ff4549e956..05890815795d 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -1098,13 +1098,13 @@ static int cmpc_keys_codes[] = {
 
 static void cmpc_keys_handler(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *dev = data;
+	struct device *dev = data;
 	struct input_dev *inputdev;
 	int code = KEY_MAX;
 
 	if ((event & 0x0F) < ARRAY_SIZE(cmpc_keys_codes))
 		code = cmpc_keys_codes[event & 0x0F];
-	inputdev = dev_get_drvdata(&dev->dev);
+	inputdev = dev_get_drvdata(dev);
 	input_report_key(inputdev, code, !(event & 0x10));
 	input_sync(inputdev);
 }
@@ -1118,27 +1118,32 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
 		set_bit(cmpc_keys_codes[i], inputdev->keybit);
 }
 
-static int cmpc_keys_add(struct acpi_device *acpi)
+static int cmpc_keys_probe(struct platform_device *pdev)
 {
+	struct acpi_device *acpi;
 	int error;
 
-	error = cmpc_add_notify_device(&acpi->dev, "cmpc_keys", cmpc_keys_idev_init);
+	acpi = ACPI_COMPANION(&pdev->dev);
+	if (!acpi)
+		return -ENODEV;
+
+	error = cmpc_add_notify_device(&pdev->dev, "cmpc_keys", cmpc_keys_idev_init);
 	if (error)
 		return error;
 
 	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
-						cmpc_keys_handler, acpi);
+						cmpc_keys_handler, &pdev->dev);
 	if (error)
-		cmpc_remove_notify_device(&acpi->dev);
+		cmpc_remove_notify_device(&pdev->dev);
 
 	return error;
 }
 
-static void cmpc_keys_remove(struct acpi_device *acpi)
+static void cmpc_keys_remove(struct platform_device *pdev)
 {
-	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
-				       cmpc_keys_handler);
-	cmpc_remove_notify_device(&acpi->dev);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, cmpc_keys_handler);
+	cmpc_remove_notify_device(&pdev->dev);
 }
 
 static const struct acpi_device_id cmpc_keys_device_ids[] = {
@@ -1146,14 +1151,13 @@ static const struct acpi_device_id cmpc_keys_device_ids[] = {
 	{"", 0}
 };
 
-static struct acpi_driver cmpc_keys_acpi_driver = {
-	.name = "cmpc_keys",
-	.class = "cmpc_keys",
-	.ids = cmpc_keys_device_ids,
-	.ops = {
-		.add = cmpc_keys_add,
-		.remove = cmpc_keys_remove,
-	}
+static struct platform_driver cmpc_keys_acpi_driver = {
+	.probe = cmpc_keys_probe,
+	.remove = cmpc_keys_remove,
+	.driver = {
+		.name = "cmpc_keys",
+		.acpi_match_table = cmpc_keys_device_ids,
+	},
 };
 
 
@@ -1165,7 +1169,7 @@ static int cmpc_init(void)
 {
 	int r;
 
-	r = acpi_bus_register_driver(&cmpc_keys_acpi_driver);
+	r = platform_driver_register(&cmpc_keys_acpi_driver);
 	if (r)
 		goto failed_keys;
 
@@ -1197,7 +1201,7 @@ static int cmpc_init(void)
 	platform_driver_unregister(&cmpc_ipml_acpi_driver);
 
 failed_bl:
-	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
+	platform_driver_unregister(&cmpc_keys_acpi_driver);
 
 failed_keys:
 	return r;
@@ -1209,7 +1213,7 @@ static void cmpc_exit(void)
 	platform_driver_unregister(&cmpc_accel_acpi_driver);
 	platform_driver_unregister(&cmpc_tablet_acpi_driver);
 	platform_driver_unregister(&cmpc_ipml_acpi_driver);
-	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
+	platform_driver_unregister(&cmpc_keys_acpi_driver);
 }
 
 module_init(cmpc_init);
-- 
2.51.0




