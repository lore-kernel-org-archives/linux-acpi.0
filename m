Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94597241CB7;
	Thu,  7 May 2026 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184886; cv=none; b=lKXrCFDLPDiKnOVQ9D51AiufqkLYFVSPWKu5nmVIJdVsYrqXs4Wtok/Jl6rag/BIOhqXqmrgVqTD0TLgSFCF4Nxfmqhdb/04Ls7VChZCCjmUyPMIzxxYLdvEZl5YRXkMkpT5iZzuq2ANPIQAIk06ZqbzmApDksYap8y14UkPA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184886; c=relaxed/simple;
	bh=pq0teXiG5MbiICbpbgaCqOq9h8B+64IAfH/m0PSq/Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjsWTaLMx+yksNqoi0gFUOvXuyEyhmOSlI4KhW6ntnYksYX8m89sA8ZVHakAt9bzQPYvnl7LSLgQTcJO1y6XtSqntFlHB5qlCnazqhbXR4NBnpLbHCeF+yIJIoavoDFUwFiYzO2D1vZj8Qi38AZbX7FBQrd40P++EOZsNWTkxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnFmsDqL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnFmsDqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DAEC2BCB8;
	Thu,  7 May 2026 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778184886;
	bh=pq0teXiG5MbiICbpbgaCqOq9h8B+64IAfH/m0PSq/Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnFmsDqLojx3sEAyx7WMJ3/JBEhocKoRe4JqQaJSD1Gsjvu817wT0NOhTUamKcqkh
	 rjDgBnowLZq8PG5vCdfB3bqRIFWaC0hyKB0LpPDtcHoi2sartU/NLuIhQZEg7I8JCw
	 ueqtE+zmB20+cl23UgfOt9nkz2W1PlBffsSNQjocLnCZF/8xY9gVf8Sz1pZFrm1TNx
	 68s2xhktC3dNjO4HivFzQWMD9goXnBg/uoExuFYI9ztz9G6bxrROJoFT7G7FHIoSpW
	 Cgk7SEM7k/4/4ILaVvrHz3CeAQbNMXUMQbLT6+OBt9DXua0WbeSmc0LFF7b6VELyps
	 gPAGX5vrValzQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1 07/10] platform/x86: classmate-laptop: Convert accel driver to a
 platform one
Date: Thu, 07 May 2026 22:10:55 +0200
Message-ID: <24362836.6Emhk5qWAg@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <1956046.tdWV9SEqCh@rafael.j.wysocki>
References: <1956046.tdWV9SEqCh@rafael.j.wysocki>
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
ACPI companions, so convert cmpc_accel_acpi_driver in the platform
x86 classmate-laptop driver from an ACPI driver to a platform one.

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
 drivers/platform/x86/classmate-laptop.c | 60 ++++++++++++-------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index a19082267f41..06040e69eb31 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -559,15 +559,15 @@ static acpi_status cmpc_get_accel(acpi_handle handle,
 
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
@@ -634,20 +634,14 @@ static struct device_attribute cmpc_accel_sensitivity_attr = {
 
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
@@ -660,21 +654,23 @@ static void cmpc_accel_idev_init(struct input_dev *inputdev)
 	inputdev->close = cmpc_accel_close;
 }
 
-static int cmpc_accel_add(struct acpi_device *acpi)
+static int cmpc_accel_probe(struct platform_device *pdev)
 {
-	int error;
+	struct acpi_device *acpi = ACPI_COMPANION(&pdev->dev);
 	struct input_dev *inputdev;
 	struct cmpc_accel *accel;
+	int error;
 
 	accel = kmalloc_obj(*accel);
 	if (!accel)
 		return -ENOMEM;
 
-	error = cmpc_add_notify_device(&acpi->dev, "cmpc_accel", cmpc_accel_idev_init);
+	error = cmpc_add_notify_device(&pdev->dev, "cmpc_accel", cmpc_accel_idev_init);
 	if (error)
 		goto failed_input;
 
-	inputdev = dev_get_drvdata(&acpi->dev);
+	inputdev = dev_get_drvdata(&pdev->dev);
+	dev_set_drvdata(&acpi->dev, inputdev);
 
 	accel->sensitivity = CMPC_ACCEL_SENSITIVITY_DEFAULT;
 	cmpc_accel_set_sensitivity(acpi->handle, accel->sensitivity);
@@ -684,7 +680,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 		goto failed_file;
 
 	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
-						cmpc_accel_handler, acpi);
+						cmpc_accel_handler, &pdev->dev);
 	if (error)
 		goto failed_notify_handler;
 
@@ -695,21 +691,24 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 failed_notify_handler:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 failed_file:
-	cmpc_remove_notify_device(&acpi->dev);
+	dev_set_drvdata(&acpi->dev, NULL);
+	cmpc_remove_notify_device(&pdev->dev);
 failed_input:
 	kfree(accel);
 	return error;
 }
 
-static void cmpc_accel_remove(struct acpi_device *acpi)
+static void cmpc_accel_remove(struct platform_device *pdev)
 {
-	struct input_dev *inputdev = dev_get_drvdata(&acpi->dev);
+	struct input_dev *inputdev = dev_get_drvdata(&pdev->dev);
 	struct cmpc_accel *accel = dev_get_drvdata(&inputdev->dev);
+	struct acpi_device *acpi = ACPI_COMPANION(&pdev->dev);
 
 	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
 				       cmpc_accel_handler);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
-	cmpc_remove_notify_device(&acpi->dev);
+	dev_set_drvdata(&acpi->dev, NULL);
+	cmpc_remove_notify_device(&pdev->dev);
 	kfree(accel);
 }
 
@@ -718,14 +717,13 @@ static const struct acpi_device_id cmpc_accel_device_ids[] = {
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
 
 
@@ -1174,7 +1172,7 @@ static int cmpc_init(void)
 	if (r)
 		goto failed_tablet;
 
-	r = acpi_bus_register_driver(&cmpc_accel_acpi_driver);
+	r = platform_driver_register(&cmpc_accel_acpi_driver);
 	if (r)
 		goto failed_accel;
 
@@ -1185,7 +1183,7 @@ static int cmpc_init(void)
 	return r;
 
 failed_accel_v4:
-	acpi_bus_unregister_driver(&cmpc_accel_acpi_driver);
+	platform_driver_unregister(&cmpc_accel_acpi_driver);
 
 failed_accel:
 	acpi_bus_unregister_driver(&cmpc_tablet_acpi_driver);
@@ -1203,7 +1201,7 @@ static int cmpc_init(void)
 static void cmpc_exit(void)
 {
 	platform_driver_unregister(&cmpc_accel_acpi_driver_v4);
-	acpi_bus_unregister_driver(&cmpc_accel_acpi_driver);
+	platform_driver_unregister(&cmpc_accel_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_tablet_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
 
2.51.0




