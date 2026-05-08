Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D32EB874;
	Fri,  8 May 2026 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262346; cv=none; b=YTYa7B6FibIYpjn9E7y/7fnnX4BVG/hkfvZ74Hj23ibx15sTBTJURhAZ0weibHtN72Y8YvLXzgizLrYH/LbXLNeJdPe9vWoCL6Ac8IyqUb8HixuWahSb506D1aJ2YGeLr8oh0dr99a//Aw8lmkRSvAoS77iyHHKGa6lQMhRSNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262346; c=relaxed/simple;
	bh=zxEYDc4N9MT9ytOD9OkBJ/XYwr341dqBrcmIb6EG6gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIhdhfbEodFpmGDkZEb9UKRCN4W6XzIgil93vEqTbadBu0qDogS74OZaBovgxVyZ471VupzR0qwNIwlpXDOAvK7v5GeyfyqLVOquk9NZ28a/RfnW6PX+R8v7KByGV7TAndipEC+gMFpI4ZjGRFJetYNyqSOwPFWxLWyyin6/7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9vhQ/QJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9vhQ/QJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAA7C2BCB0;
	Fri,  8 May 2026 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262346;
	bh=zxEYDc4N9MT9ytOD9OkBJ/XYwr341dqBrcmIb6EG6gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9vhQ/QJ8yPhpmSW9fI0doJURf+2FMrVgj9L8wVbY6KJ7Sc3/4kPrq3AFMVbHOgBk
	 GKIVZ6SQRwdI+K03BH5Ua15pNUZDD5QdEKeUoxsuPSoSA5IEaLbhlH2y35N95Zy/6I
	 drzBEOYpaYHYGbrOS+MS8ZKsFDBLSk8RSQla35jNHXf2N0fImfcixHZW/2I8/wf5aj
	 7r9ZuPCwo82UqjCklO2z6qXM0dNVp4G4If9JEf2AnKqIVyNZ8QencexDy893s+93bQ
	 GcSDsYkQ4SEe6zicCYinEc3CiozMPfUPcTNU94ngRcUOG8S3jQxh8yinFF9oJBhcGg
	 nxB/l1PuuOsWw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 4/4] platform/x86: xo15-ebook: Convert ACPI driver to a platform
 one
Date: Fri, 08 May 2026 19:44:58 +0200
Message-ID: <8688586.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2420444.ElGaqSPkdT@rafael.j.wysocki>
References: <2420444.ElGaqSPkdT@rafael.j.wysocki>
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
ACPI companions, so convert the OLPC XO-1.5 ebook switch driver from an
ACPI driver to a platform one.

After this change, the input device registered by the driver will appear
under the platform device used for driver binding.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/xo15-ebook.c | 44 ++++++++++++++++---------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 8af1b9078db8..2ca15f04b2d9 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/input.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 
 #define MODULE_NAME "xo15-ebook"
 
@@ -41,13 +42,13 @@ struct ebook_switch {
 	bool gpe_enabled;
 };
 
-static int ebook_send_state(struct acpi_device *device)
+static int ebook_send_state(struct device *dev)
 {
-	struct ebook_switch *button = acpi_driver_data(device);
+	struct ebook_switch *button = dev_get_drvdata(dev);
 	unsigned long long state;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(device->handle, "EBK", NULL, &state);
+	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "EBK", NULL, &state);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -73,14 +74,15 @@ static void ebook_switch_notify(acpi_handle handle, u32 event, void *data)
 #ifdef CONFIG_PM_SLEEP
 static int ebook_switch_resume(struct device *dev)
 {
-	return ebook_send_state(to_acpi_device(dev));
+	return ebook_send_state(dev);
 }
 #endif
 
 static SIMPLE_DEV_PM_OPS(ebook_switch_pm, NULL, ebook_switch_resume);
 
-static int ebook_switch_add(struct acpi_device *device)
+static int ebook_switch_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	const struct acpi_device_id *id;
 	struct ebook_switch *button;
 	struct input_dev *input;
@@ -90,7 +92,7 @@ static int ebook_switch_add(struct acpi_device *device)
 	if (!button)
 		return -ENOMEM;
 
-	device->driver_data = button;
+	platform_set_drvdata(pdev, button);
 
 	button->input = input = input_allocate_device();
 	if (!input) {
@@ -100,7 +102,7 @@ static int ebook_switch_add(struct acpi_device *device)
 
 	id = acpi_match_acpi_device(ebook_device_ids, device);
 	if (!id) {
-		dev_err(&device->dev, "Unsupported hid\n");
+		dev_err(&pdev->dev, "Unsupported hid\n");
 		error = -ENODEV;
 		goto err_free_input;
 	}
@@ -113,7 +115,7 @@ static int ebook_switch_add(struct acpi_device *device)
 	input->name = acpi_device_name(device);
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
-	input->dev.parent = &device->dev;
+	input->dev.parent = &pdev->dev;
 
 	input->evbit[0] = BIT_MASK(EV_SW);
 	set_bit(SW_TABLET_MODE, input->swbit);
@@ -123,11 +125,11 @@ static int ebook_switch_add(struct acpi_device *device)
 		goto err_free_input;
 
 	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						ebook_switch_notify, device);
+						ebook_switch_notify, &pdev->dev);
 	if (error)
 		goto err_unregister_input;
 
-	ebook_send_state(device);
+	ebook_send_state(&pdev->dev);
 
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */
@@ -149,9 +151,10 @@ static int ebook_switch_add(struct acpi_device *device)
 	goto err_free_button;
 }
 
-static void ebook_switch_remove(struct acpi_device *device)
+static void ebook_switch_remove(struct platform_device *pdev)
 {
-	struct ebook_switch *button = acpi_driver_data(device);
+	struct ebook_switch *button = platform_get_drvdata(pdev);
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
 	if (button->gpe_enabled)
 		acpi_disable_gpe(device->wakeup.gpe_device,
@@ -163,14 +166,13 @@ static void ebook_switch_remove(struct acpi_device *device)
 	kfree(button);
 }
 
-static struct acpi_driver xo15_ebook_driver = {
-	.name = MODULE_NAME,
-	.class = XO15_EBOOK_CLASS,
-	.ids = ebook_device_ids,
-	.ops = {
-		.add = ebook_switch_add,
-		.remove = ebook_switch_remove,
+static struct platform_driver xo15_ebook_driver = {
+	.probe = ebook_switch_probe,
+	.remove = ebook_switch_remove,
+	.driver = {
+		.name = MODULE_NAME,
+		.acpi_match_table = ebook_device_ids,
+		.pm = &ebook_switch_pm,
 	},
-	.drv.pm = &ebook_switch_pm,
 };
-module_acpi_driver(xo15_ebook_driver);
+module_platform_driver(xo15_ebook_driver);



