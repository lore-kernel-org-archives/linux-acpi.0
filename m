Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F3241CB7;
	Thu,  7 May 2026 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184883; cv=none; b=oR9AhwcnpiiU20jVl82wUBnfJUHZsRmtQBoKBVEzKwhEYxAjlyQsXY7hiBEH3QkYqSHR94xDDEQdAe+yCV8gyC1+zXnYXOOvC30Ql2/SZo5N/Y3BunRqfG4qI54oZlgWoUtxnO2dm5EFyiggV0o7cnD1TZdmlSDO3z5FSkOwaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184883; c=relaxed/simple;
	bh=EB2vuEOS5N98kf/KTz5I0TBgqLP+f9ewsKbhyJXafKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gG4labCbWhomJfTUTLmYHpaHM3Ikj/L4AiLZ8bTzpjf5kgBfUiV40BhXHi7pTPQ5qNE9DUCWMmo5EKnRVUIjcb64a4bhZOWsCTc0CsBiKFZYTDZbMcSOsVR7IronkkF/F3AmTa2MQdITf7dCkGNHHz4w8miiwmdBPyTKZZ0yOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bg5dWtHC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bg5dWtHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547BCC2BCB8;
	Thu,  7 May 2026 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778184882;
	bh=EB2vuEOS5N98kf/KTz5I0TBgqLP+f9ewsKbhyJXafKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bg5dWtHCQ3iSNzH4k/leimIFYLYai8zpaYeTYo3fUb3ks05NEqAH3MAaTnOANeDgL
	 W6OhEX943CHNWreJkmmHPmkxNRxucw6DbAogsKQ1dy9xGtWOq3/sswk1wlY/gubAxW
	 HvU6kRjAvlGwD5OD5hrygfYmc6VSm0NAduxBxvSLLTDDg88r6GOmfHKM5HQ6vpvopP
	 6YyHybqd2L7MT9eso0O3bLHu7BYhjG7kn4p3HwuVxHHBJcMkveGW33plvPmbaSsj93
	 k7dd3RwyjjKHE2LBeMJA3Xqv98qf+32/57lYWv3u+d4TRo7k4NKcW1Gx1i504Q5IdA
	 jJ5HBpI42Jntw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1 08/10] platform/x86: classmate-laptop: Convert tablet driver to a
 platform one
Date: Thu, 07 May 2026 22:11:46 +0200
Message-ID: <2702450.Lt9SDvczpP@rafael.j.wysocki>
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
ACPI companions, so convert cmpc_tablet_acpi_driver in the platform
x86 classmate-laptop driver from an ACPI driver to a platform one.

After this change, the input device registered by the driver will appear
under the platform device used for driver binding.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/classmate-laptop.c | 53 ++++++++++++-------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 06040e69eb31..0bb0359387a7 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -750,12 +750,12 @@ static acpi_status cmpc_get_tablet(acpi_handle handle,
 
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
@@ -764,40 +764,40 @@ static void cmpc_tablet_handler(acpi_handle handle, u32 event, void *data)
 
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
 	int error;
 
-	error = cmpc_add_notify_device(&acpi->dev, "cmpc_tablet", cmpc_tablet_idev_init);
+	error = cmpc_add_notify_device(&pdev->dev, "cmpc_tablet", cmpc_tablet_idev_init);
 	if (error)
 		return error;
 
-	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
-						cmpc_tablet_handler, acpi);
+	error = acpi_dev_install_notify_handler(ACPI_COMPANION(&pdev->dev),
+						ACPI_DEVICE_NOTIFY,
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
@@ -806,7 +806,7 @@ static int cmpc_tablet_resume(struct device *dev)
 	struct input_dev *inputdev = dev_get_drvdata(dev);
 
 	unsigned long long val = 0;
-	if (ACPI_SUCCESS(cmpc_get_tablet(to_acpi_device(dev)->handle, &val))) {
+	if (ACPI_SUCCESS(cmpc_get_tablet(ACPI_HANDLE(dev), &val))) {
 		input_report_switch(inputdev, SW_TABLET_MODE, !val);
 		input_sync(inputdev);
 	}
@@ -821,15 +821,14 @@ static const struct acpi_device_id cmpc_tablet_device_ids[] = {
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
 
 
@@ -1168,7 +1167,7 @@ static int cmpc_init(void)
 	if (r)
 		goto failed_bl;
 
-	r = acpi_bus_register_driver(&cmpc_tablet_acpi_driver);
+	r = platform_driver_register(&cmpc_tablet_acpi_driver);
 	if (r)
 		goto failed_tablet;
 
@@ -1186,7 +1185,7 @@ static int cmpc_init(void)
 	platform_driver_unregister(&cmpc_accel_acpi_driver);
 
 failed_accel:
-	acpi_bus_unregister_driver(&cmpc_tablet_acpi_driver);
+	platform_driver_unregister(&cmpc_tablet_acpi_driver);
 
 failed_tablet:
 	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
@@ -1202,7 +1201,7 @@ static void cmpc_exit(void)
 {
 	platform_driver_unregister(&cmpc_accel_acpi_driver_v4);
 	platform_driver_unregister(&cmpc_accel_acpi_driver);
-	acpi_bus_unregister_driver(&cmpc_tablet_acpi_driver);
+	platform_driver_unregister(&cmpc_tablet_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
 }



