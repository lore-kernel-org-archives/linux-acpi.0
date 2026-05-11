Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70C230264;
	Mon, 11 May 2026 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530545; cv=none; b=TbQYCDRugx3mFiAaH+ReRQALB4Svd5g0JYIUPkSJ+kKJ7KjPb02QIfgK6FGHUzhfVG0cCMYt9Ii9FTJr3gNhAqKNnYXnRb6v+VRQyqfodYujB/IckQbZNq+uQy+fVvQbZW/u1tXSebeuyExWQHd8U2U1uOSrQHyomLTsYT9enV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530545; c=relaxed/simple;
	bh=YFJzo12wIJY/44Pg9VRxR8K1o55N0qM0kqFzjGxRddo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U78b77qiNOIO9tsU6DgFQYX88KQ4umau9s96k6SF3nYs8+GkMceK8h7MVHhFrZkmGV/Kv4Uazu80m1zGM/lNDfZrJs0qvRnvmU26Diusoa2pzdl5S+6MRljjCdHWm29B0Xcx7K8J32AiVQqJoxD+Vr7jOqCE/KN/JnKsdWOEhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGLuECsz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGLuECsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD5FC2BCB0;
	Mon, 11 May 2026 20:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530544;
	bh=YFJzo12wIJY/44Pg9VRxR8K1o55N0qM0kqFzjGxRddo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGLuECsz0Jvt7t9u6HKzXnJknUyW0RwZltLYTC7UMDN/UJlsA4dw+MZvibWSc+Qil
	 ZXMm0tsLo+d6XQBg+mG7dDEL9u7ZXDGoKnsf0T5Hz3ZG92kvAMed/q1SNrY6KPGmpv
	 M0NsxRfKj/jD7YDBUfj5mMNowRlLqhzQywlFM6CL0OA2lvlXqDyGih9wtfOxsdDVAv
	 +hI/SDq+pp8cDgbpzXOzJcwyw4fmrMH6h8fj+KT7Z0rmFk1nO9jPvNRuOJCGg16/Qf
	 MzZAdq3WuDQsk99R8V26ZhxZLlnnqar0/2gX4/6ndCKs2iqwluPnnZOyihdJ0oJxDA
	 R45BjZdlkvblg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 08/10] platform/x86: classmate-laptop: Convert tablet driver to a
 platform one
Date: Mon, 11 May 2026 22:12:55 +0200
Message-ID: <4504318.ejJDZkT8p0@rafael.j.wysocki>
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
ACPI companions, so convert cmpc_tablet_acpi_driver in the Classmate
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
 drivers/platform/x86/classmate-laptop.c | 55 +++++++++++++------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 0d5ad89d0f24..464ab852b492 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -748,12 +748,12 @@ static acpi_status cmpc_get_tablet(acpi_handle handle,
 
 static void cmpc_tablet_handler(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *dev = data;
+	struct device *dev = data;
 	unsigned long long val = 0;
-	struct input_dev *inputdev = dev_get_drvdata(&dev->dev);
+	struct input_dev *inputdev = dev_get_drvdata(dev);
 
 	if (event == 0x81) {
-		if (ACPI_SUCCESS(cmpc_get_tablet(dev->handle, &val))) {
+		if (ACPI_SUCCESS(cmpc_get_tablet(ACPI_HANDLE(dev), &val))) {
 			input_report_switch(inputdev, SW_TABLET_MODE, !val);
 			input_sync(inputdev);
 		}
@@ -762,40 +762,44 @@ static void cmpc_tablet_handler(acpi_handle handle, u32 event, void *data)
 
 static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 {
+	acpi_handle handle = ACPI_HANDLE(inputdev->dev.parent);
 	unsigned long long val = 0;
-	struct acpi_device *acpi;
 
 	set_bit(EV_SW, inputdev->evbit);
 	set_bit(SW_TABLET_MODE, inputdev->swbit);
 
-	acpi = to_acpi_device(inputdev->dev.parent);
-	if (ACPI_SUCCESS(cmpc_get_tablet(acpi->handle, &val))) {
+	if (ACPI_SUCCESS(cmpc_get_tablet(handle, &val))) {
 		input_report_switch(inputdev, SW_TABLET_MODE, !val);
 		input_sync(inputdev);
 	}
 }
 
-static int cmpc_tablet_add(struct acpi_device *acpi)
+static int cmpc_tablet_probe(struct platform_device *pdev)
 {
+	struct acpi_device *acpi;
 	int error;
 
-	error = cmpc_add_notify_device(&acpi->dev, "cmpc_tablet", cmpc_tablet_idev_init);
+	acpi = ACPI_COMPANION(&pdev->dev);
+	if (!acpi)
+		return -ENODEV;
+
+	error = cmpc_add_notify_device(&pdev->dev, "cmpc_tablet", cmpc_tablet_idev_init);
 	if (error)
 		return error;
 
 	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
-						cmpc_tablet_handler, acpi);
+						cmpc_tablet_handler, &pdev->dev);
 	if (error)
-		cmpc_remove_notify_device(&acpi->dev);
+		cmpc_remove_notify_device(&pdev->dev);
 
 	return error;
 }
 
-static void cmpc_tablet_remove(struct acpi_device *acpi)
+static void cmpc_tablet_remove(struct platform_device *pdev)
 {
-	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
-				       cmpc_tablet_handler);
-	cmpc_remove_notify_device(&acpi->dev);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, cmpc_tablet_handler);
+	cmpc_remove_notify_device(&pdev->dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -804,7 +808,7 @@ static int cmpc_tablet_resume(struct device *dev)
 	struct input_dev *inputdev = dev_get_drvdata(dev);
 
 	unsigned long long val = 0;
-	if (ACPI_SUCCESS(cmpc_get_tablet(to_acpi_device(dev)->handle, &val))) {
+	if (ACPI_SUCCESS(cmpc_get_tablet(ACPI_HANDLE(dev), &val))) {
 		input_report_switch(inputdev, SW_TABLET_MODE, !val);
 		input_sync(inputdev);
 	}
@@ -819,15 +823,14 @@ static const struct acpi_device_id cmpc_tablet_device_ids[] = {
 	{"", 0}
 };
 
-static struct acpi_driver cmpc_tablet_acpi_driver = {
-	.name = "cmpc_tablet",
-	.class = "cmpc_tablet",
-	.ids = cmpc_tablet_device_ids,
-	.ops = {
-		.add = cmpc_tablet_add,
-		.remove = cmpc_tablet_remove,
+static struct platform_driver cmpc_tablet_acpi_driver = {
+	.probe = cmpc_tablet_probe,
+	.remove = cmpc_tablet_remove,
+	.driver = {
+		.name = "cmpc_tablet",
+		.acpi_match_table = cmpc_tablet_device_ids,
+		.pm = &cmpc_tablet_pm,
 	},
-	.drv.pm = &cmpc_tablet_pm,
 };
 
 
@@ -1166,7 +1169,7 @@ static int cmpc_init(void)
 	if (r)
 		goto failed_bl;
 
-	r = acpi_bus_register_driver(&cmpc_tablet_acpi_driver);
+	r = platform_driver_register(&cmpc_tablet_acpi_driver);
 	if (r)
 		goto failed_tablet;
 
@@ -1184,7 +1187,7 @@ static int cmpc_init(void)
 	platform_driver_unregister(&cmpc_accel_acpi_driver);
 
 failed_accel:
-	acpi_bus_unregister_driver(&cmpc_tablet_acpi_driver);
+	platform_driver_unregister(&cmpc_tablet_acpi_driver);
 
 failed_tablet:
 	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
@@ -1200,7 +1203,7 @@ static void cmpc_exit(void)
 {
 	platform_driver_unregister(&cmpc_accel_acpi_driver_v4);
 	platform_driver_unregister(&cmpc_accel_acpi_driver);
-	acpi_bus_unregister_driver(&cmpc_tablet_acpi_driver);
+	platform_driver_unregister(&cmpc_tablet_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
 }
-- 
2.51.0




