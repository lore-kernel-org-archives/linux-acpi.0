Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE8221F2F;
	Mon, 11 May 2026 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530549; cv=none; b=AHY2ctA0ngOLIimJ3s2kZEMEtp3wNIC2l0khZ+blU3HnJ1GaBnAQqueOhRFEklQHgXURn2JLHs/h6Z4PDDOsPrA13EkDKZRBN80MqY8R9ztrpSzwwguwausTK26EhAFzXuAKEZepJ4Wuq1YVqzFARJQ8SgjI/Trx+JDXcz/7cfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530549; c=relaxed/simple;
	bh=+0Vpl23MevXpsPKDxjG+B60ODDM6DTJ2VXNmTuOsEDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvoeKOUCktI42r0fNTI6RLlHPwnv6fT81ACQgsVGcUZVLgtP+UhmZdvGIhf+9VdZo/4j3SW02cckLlI4c+hjF11AH0x7ujVCikcjEwqvXt2tIdnTmTB436S93NSetEY3/snrTbjvl7ixiqDxfjK2y4wvqU84Q7XduPTBnMCWMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJurJZyX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJurJZyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52665C2BCB0;
	Mon, 11 May 2026 20:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530548;
	bh=+0Vpl23MevXpsPKDxjG+B60ODDM6DTJ2VXNmTuOsEDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJurJZyXQLD7GG0cGIHpzplM24lnNr2uimgpxn7ZDq23drQJ/tIEnMR0TxTHAzNd7
	 tIuBjsvS3RZSKWeQw7wsEXmGJTQgnhCxHxTZenJ2GQ5oTB/IiipMm6rapKxDmtJdTv
	 Z8Lfv/84PEyVV8B+nj/u9Wcj2DkLGCI0mFUAoaQBiATN0hHPzy+lRmyhs4RvJQeWTZ
	 zKPsjMCG+E5eO6kA+BEcyxs6iPOufHl1/edNkkL8a7QNDPY02eND/zOWDCE+ZnHEYF
	 plJ+cN4g4pvKvISbbmeT86Z30Ihx7upNBDaLgBVRMKZuJU4zKAH/c11HwOMvxWfX5b
	 YMbIxUjAOWWrA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 07/10] platform/x86: classmate-laptop: Convert accel driver to a
 platform one
Date: Mon, 11 May 2026 22:11:39 +0200
Message-ID: <24365138.6Emhk5qWAg@rafael.j.wysocki>
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
ACPI companions, so convert cmpc_accel_acpi_driver in the Classmate
laptop driver from an ACPI driver to a platform one.

After this change, the input device registered by the driver will
appear under the platform device used for driver binding, but the sysfs
attribute added by the driver under the ACPI companion of that device
will stay there in case there are utilities in user space expecting
it to be present there.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase
   * Check the ACPI companion against NULL at probe time

---
 drivers/platform/x86/classmate-laptop.c | 63 +++++++++++++------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 454ba2823b51..0d5ad89d0f24 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -558,15 +558,15 @@ static acpi_status cmpc_get_accel(acpi_handle handle,
 
 static void cmpc_accel_handler(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *dev = data;
+	struct device *dev = data;
 
 	if (event == 0x81) {
 		unsigned char x, y, z;
 		acpi_status status;
 
-		status = cmpc_get_accel(dev->handle, &x, &y, &z);
+		status = cmpc_get_accel(ACPI_HANDLE(dev), &x, &y, &z);
 		if (ACPI_SUCCESS(status)) {
-			struct input_dev *inputdev = dev_get_drvdata(&dev->dev);
+			struct input_dev *inputdev = dev_get_drvdata(dev);
 
 			input_report_abs(inputdev, ABS_X, x);
 			input_report_abs(inputdev, ABS_Y, y);
@@ -633,20 +633,14 @@ static struct device_attribute cmpc_accel_sensitivity_attr = {
 
 static int cmpc_accel_open(struct input_dev *input)
 {
-	struct acpi_device *acpi;
-
-	acpi = to_acpi_device(input->dev.parent);
-	if (ACPI_SUCCESS(cmpc_start_accel(acpi->handle)))
+	if (ACPI_SUCCESS(cmpc_start_accel(ACPI_HANDLE(input->dev.parent))))
 		return 0;
 	return -EIO;
 }
 
 static void cmpc_accel_close(struct input_dev *input)
 {
-	struct acpi_device *acpi;
-
-	acpi = to_acpi_device(input->dev.parent);
-	cmpc_stop_accel(acpi->handle);
+	cmpc_stop_accel(ACPI_HANDLE(input->dev.parent));
 }
 
 static void cmpc_accel_idev_init(struct input_dev *inputdev)
@@ -659,21 +653,27 @@ static void cmpc_accel_idev_init(struct input_dev *inputdev)
 	inputdev->close = cmpc_accel_close;
 }
 
-static int cmpc_accel_add(struct acpi_device *acpi)
+static int cmpc_accel_probe(struct platform_device *pdev)
 {
 	int error;
 	struct input_dev *inputdev;
 	struct cmpc_accel *accel;
+	struct acpi_device *acpi;
 
-	accel = devm_kzalloc(&acpi->dev, sizeof(*accel), GFP_KERNEL);
+	acpi = ACPI_COMPANION(&pdev->dev);
+	if (!acpi)
+		return -ENODEV;
+
+	accel = devm_kzalloc(&pdev->dev, sizeof(*accel), GFP_KERNEL);
 	if (!accel)
 		return -ENOMEM;
 
-	error = cmpc_add_notify_device(&acpi->dev, "cmpc_accel", cmpc_accel_idev_init);
+	error = cmpc_add_notify_device(&pdev->dev, "cmpc_accel", cmpc_accel_idev_init);
 	if (error)
 		return error;
 
-	inputdev = dev_get_drvdata(&acpi->dev);
+	inputdev = dev_get_drvdata(&pdev->dev);
+	dev_set_drvdata(&acpi->dev, inputdev);
 
 	accel->sensitivity = CMPC_ACCEL_SENSITIVITY_DEFAULT;
 	cmpc_accel_set_sensitivity(acpi->handle, accel->sensitivity);
@@ -683,7 +683,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 		goto failed_file;
 
 	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
-						cmpc_accel_handler, acpi);
+						cmpc_accel_handler, &pdev->dev);
 	if (error)
 		goto failed_notify_handler;
 
@@ -694,16 +694,20 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 failed_notify_handler:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 failed_file:
-	cmpc_remove_notify_device(&acpi->dev);
+	dev_set_drvdata(&acpi->dev, NULL);
+	cmpc_remove_notify_device(&pdev->dev);
 	return error;
 }
 
-static void cmpc_accel_remove(struct acpi_device *acpi)
+static void cmpc_accel_remove(struct platform_device *pdev)
 {
+	struct acpi_device *acpi = ACPI_COMPANION(&pdev->dev);
+
 	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
 				       cmpc_accel_handler);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
-	cmpc_remove_notify_device(&acpi->dev);
+	dev_set_drvdata(&acpi->dev, NULL);
+	cmpc_remove_notify_device(&pdev->dev);
 }
 
 static const struct acpi_device_id cmpc_accel_device_ids[] = {
@@ -711,14 +715,13 @@ static const struct acpi_device_id cmpc_accel_device_ids[] = {
 	{"", 0}
 };
 
-static struct acpi_driver cmpc_accel_acpi_driver = {
-	.name = "cmpc_accel",
-	.class = "cmpc_accel",
-	.ids = cmpc_accel_device_ids,
-	.ops = {
-		.add = cmpc_accel_add,
-		.remove = cmpc_accel_remove,
-	}
+static struct platform_driver cmpc_accel_acpi_driver = {
+	.probe = cmpc_accel_probe,
+	.remove = cmpc_accel_remove,
+	.driver = {
+		.name = "cmpc_accel",
+		.acpi_match_table = cmpc_accel_device_ids,
+	},
 };
 
 
@@ -1167,7 +1170,7 @@ static int cmpc_init(void)
 	if (r)
 		goto failed_tablet;
 
-	r = acpi_bus_register_driver(&cmpc_accel_acpi_driver);
+	r = platform_driver_register(&cmpc_accel_acpi_driver);
 	if (r)
 		goto failed_accel;
 
@@ -1178,7 +1181,7 @@ static int cmpc_init(void)
 	return r;
 
 failed_accel_v4:
-	acpi_bus_unregister_driver(&cmpc_accel_acpi_driver);
+	platform_driver_unregister(&cmpc_accel_acpi_driver);
 
 failed_accel:
 	acpi_bus_unregister_driver(&cmpc_tablet_acpi_driver);
@@ -1196,7 +1199,7 @@ static int cmpc_init(void)
 static void cmpc_exit(void)
 {
 	platform_driver_unregister(&cmpc_accel_acpi_driver_v4);
-	acpi_bus_unregister_driver(&cmpc_accel_acpi_driver);
+	platform_driver_unregister(&cmpc_accel_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_tablet_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
-- 
2.51.0




