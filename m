Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA72230264;
	Mon, 11 May 2026 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530552; cv=none; b=nKzSbk0SapbP0g+L+nY58GbPOQ1hlvBlvfA1CLfyx072QPzXlxH42nemiI/q9ROFxOdk7lZLt92AevN5gbzTGfawrvUJsuvBOAL6wefnjdwkCnQeZDRfvLM307o5Urvn6okJqsBmcQdR5tWf5CkPOdmt6fpgnBaBkM1b8Z1HLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530552; c=relaxed/simple;
	bh=Wc4ON144xbzItqJMaiSqRE02vO+ckzmUP4eiTxSEF/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzhrnqKCJqzYLOSbygVYSaKIES0HsLg4+ZKKexWHs5U0jdJSLRJ9k8TTc1PdbLqryQThbc/BeE2InclnkgMxChB8dcCtNompgFkt8Tw2dH+d/RngCC72QDP3Lqtlacy3SKcLB+p2O8WNDMfXk7HFHc92qwt5uezwJ2HzFVZFbbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+5e8ijE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+5e8ijE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380A2C2BCC9;
	Mon, 11 May 2026 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530552;
	bh=Wc4ON144xbzItqJMaiSqRE02vO+ckzmUP4eiTxSEF/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+5e8ijEvmbCYFSnr/d7I0kKOobhYq3CFChObqezlzJhS9BLPs+CnHDD6nLqrajXq
	 +lXz8bFMkUkqaFXctg+Oe4TKcd6h2/FxdX+qh/CwUlhLT0srtd0G3br6ztlTfWB57/
	 zBFyZMTHcOXxvUUSnH1XyZQmDPkE+1PuDJyMZ5+5KsOZ4YZ3gKlu8p+4RmVs/iqx0l
	 K9I8DDhxaRuA1yaucSjscyELbAqCtxkBR9iCxdiBHABGIeTT/FTtNHCKGiC3YBjoXF
	 VtHugz/zcUb67a2tKM7Sx1NcZ0Sw6+X1ay03CtLw1xRk9iSPuHidhcil6KqiwKecac
	 veJGBTO1WDm9w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 06/10] platform/x86: classmate-laptop: Convert v4 accel driver to a
 platform one
Date: Mon, 11 May 2026 22:10:32 +0200
Message-ID: <3609276.QJadu78ljV@rafael.j.wysocki>
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
ACPI companions, so convert cmpc_accel_acpi_driver_v4 in the Classmate
laptop driver from an ACPI driver to a platform one.

After this change, the input device registered by the driver will
appear under the platform device used for driver binding, but the sysfs
attributes added by the driver under the ACPI companion of that device
will stay there in case there are utilities in user space expecting
them to be present there.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase
   * Check the ACPI companion against NULL at probe time

---
 drivers/platform/x86/classmate-laptop.c | 77 ++++++++++++++-----------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 8507483b23f9..454ba2823b51 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -13,6 +13,7 @@
 #include <linux/input.h>
 #include <linux/rfkill.h>
 #include <linux/sysfs.h>
+#include <linux/platform_device.h>
 
 struct cmpc_accel {
 	int sensitivity;
@@ -179,15 +180,15 @@ static acpi_status cmpc_get_accel_v4(acpi_handle handle,
 
 static void cmpc_accel_handler_v4(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *dev = data;
+	struct device *dev = data;
 
 	if (event == 0x81) {
 		int16_t x, y, z;
 		acpi_status status;
 
-		status = cmpc_get_accel_v4(dev->handle, &x, &y, &z);
+		status = cmpc_get_accel_v4(ACPI_HANDLE(dev), &x, &y, &z);
 		if (ACPI_SUCCESS(status)) {
-			struct input_dev *inputdev = dev_get_drvdata(&dev->dev);
+			struct input_dev *inputdev = dev_get_drvdata(dev);
 
 			input_report_abs(inputdev, ABS_X, x);
 			input_report_abs(inputdev, ABS_Y, y);
@@ -317,18 +318,17 @@ static struct device_attribute cmpc_accel_g_select_attr_v4 = {
 
 static int cmpc_accel_open_v4(struct input_dev *input)
 {
-	struct acpi_device *acpi;
+	acpi_handle handle = ACPI_HANDLE(input->dev.parent);
 	struct cmpc_accel *accel;
 
-	acpi = to_acpi_device(input->dev.parent);
 	accel = dev_get_drvdata(&input->dev);
 	if (!accel)
 		return -ENXIO;
 
-	cmpc_accel_set_sensitivity_v4(acpi->handle, accel->sensitivity);
-	cmpc_accel_set_g_select_v4(acpi->handle, accel->g_select);
+	cmpc_accel_set_sensitivity_v4(handle, accel->sensitivity);
+	cmpc_accel_set_g_select_v4(handle, accel->g_select);
 
-	if (ACPI_SUCCESS(cmpc_start_accel_v4(acpi->handle))) {
+	if (ACPI_SUCCESS(cmpc_start_accel_v4(handle))) {
 		accel->inputdev_state = CMPC_ACCEL_DEV_STATE_OPEN;
 		return 0;
 	}
@@ -337,13 +337,11 @@ static int cmpc_accel_open_v4(struct input_dev *input)
 
 static void cmpc_accel_close_v4(struct input_dev *input)
 {
-	struct acpi_device *acpi;
 	struct cmpc_accel *accel;
 
-	acpi = to_acpi_device(input->dev.parent);
 	accel = dev_get_drvdata(&input->dev);
 
-	cmpc_stop_accel_v4(acpi->handle);
+	cmpc_stop_accel_v4(ACPI_HANDLE(input->dev.parent));
 	accel->inputdev_state = CMPC_ACCEL_DEV_STATE_CLOSED;
 }
 
@@ -367,7 +365,7 @@ static int cmpc_accel_suspend_v4(struct device *dev)
 	accel = dev_get_drvdata(&inputdev->dev);
 
 	if (accel->inputdev_state == CMPC_ACCEL_DEV_STATE_OPEN)
-		return cmpc_stop_accel_v4(to_acpi_device(dev)->handle);
+		return cmpc_stop_accel_v4(ACPI_HANDLE(dev));
 
 	return 0;
 }
@@ -381,12 +379,12 @@ static int cmpc_accel_resume_v4(struct device *dev)
 	accel = dev_get_drvdata(&inputdev->dev);
 
 	if (accel->inputdev_state == CMPC_ACCEL_DEV_STATE_OPEN) {
-		cmpc_accel_set_sensitivity_v4(to_acpi_device(dev)->handle,
-					      accel->sensitivity);
-		cmpc_accel_set_g_select_v4(to_acpi_device(dev)->handle,
-					   accel->g_select);
+		acpi_handle handle = ACPI_HANDLE(dev);
+
+		cmpc_accel_set_sensitivity_v4(handle, accel->sensitivity);
+		cmpc_accel_set_g_select_v4(handle, accel->g_select);
 
-		if (ACPI_FAILURE(cmpc_start_accel_v4(to_acpi_device(dev)->handle)))
+		if (ACPI_FAILURE(cmpc_start_accel_v4(handle)))
 			return -EIO;
 	}
 
@@ -394,23 +392,29 @@ static int cmpc_accel_resume_v4(struct device *dev)
 }
 #endif
 
-static int cmpc_accel_add_v4(struct acpi_device *acpi)
+static int cmpc_accel_probe_v4(struct platform_device *pdev)
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
 
 	accel->inputdev_state = CMPC_ACCEL_DEV_STATE_CLOSED;
 
-	error = cmpc_add_notify_device(&acpi->dev, "cmpc_accel_v4", cmpc_accel_idev_init_v4);
+	error = cmpc_add_notify_device(&pdev->dev, "cmpc_accel_v4", cmpc_accel_idev_init_v4);
 	if (error)
 		return error;
 
-	inputdev = dev_get_drvdata(&acpi->dev);
+	inputdev = dev_get_drvdata(&pdev->dev);
+	dev_set_drvdata(&acpi->dev, inputdev);
 
 	accel->sensitivity = CMPC_ACCEL_SENSITIVITY_DEFAULT;
 	cmpc_accel_set_sensitivity_v4(acpi->handle, accel->sensitivity);
@@ -427,7 +431,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 		goto failed_g_select;
 
 	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
-						cmpc_accel_handler_v4, acpi);
+						cmpc_accel_handler_v4, &pdev->dev);
 	if (error)
 		goto failed_notify_handler;
 
@@ -440,17 +444,21 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 failed_g_select:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 failed_sensitivity:
-	cmpc_remove_notify_device(&acpi->dev);
+	dev_set_drvdata(&acpi->dev, NULL);
+	cmpc_remove_notify_device(&pdev->dev);
 	return error;
 }
 
-static void cmpc_accel_remove_v4(struct acpi_device *acpi)
+static void cmpc_accel_remove_v4(struct platform_device *pdev)
 {
+	struct acpi_device *acpi = ACPI_COMPANION(&pdev->dev);
+
 	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
 				       cmpc_accel_handler_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
-	cmpc_remove_notify_device(&acpi->dev);
+	dev_set_drvdata(&acpi->dev, NULL);
+	cmpc_remove_notify_device(&pdev->dev);
 }
 
 static SIMPLE_DEV_PM_OPS(cmpc_accel_pm, cmpc_accel_suspend_v4,
@@ -461,15 +469,14 @@ static const struct acpi_device_id cmpc_accel_device_ids_v4[] = {
 	{"", 0}
 };
 
-static struct acpi_driver cmpc_accel_acpi_driver_v4 = {
-	.name = "cmpc_accel_v4",
-	.class = "cmpc_accel_v4",
-	.ids = cmpc_accel_device_ids_v4,
-	.ops = {
-		.add = cmpc_accel_add_v4,
-		.remove = cmpc_accel_remove_v4,
+static struct platform_driver cmpc_accel_acpi_driver_v4 = {
+	.probe = cmpc_accel_probe_v4,
+	.remove = cmpc_accel_remove_v4,
+	.driver = {
+		.name = "cmpc_accel_v4",
+		.acpi_match_table = cmpc_accel_device_ids_v4,
+		.pm = &cmpc_accel_pm,
 	},
-	.drv.pm = &cmpc_accel_pm,
 };
 
 
@@ -1164,7 +1171,7 @@ static int cmpc_init(void)
 	if (r)
 		goto failed_accel;
 
-	r = acpi_bus_register_driver(&cmpc_accel_acpi_driver_v4);
+	r = platform_driver_register(&cmpc_accel_acpi_driver_v4);
 	if (r)
 		goto failed_accel_v4;
 
@@ -1188,7 +1195,7 @@ static int cmpc_init(void)
 
 static void cmpc_exit(void)
 {
-	acpi_bus_unregister_driver(&cmpc_accel_acpi_driver_v4);
+	platform_driver_unregister(&cmpc_accel_acpi_driver_v4);
 	acpi_bus_unregister_driver(&cmpc_accel_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_tablet_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
-- 
2.51.0




