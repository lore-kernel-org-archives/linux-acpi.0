Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEE23A9B3;
	Thu, 12 Mar 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315045; cv=none; b=jZgGyfHg50qSkYcKEATaJ1uX/2Z7EBXrSzT09BenzhUeq79uD6XTLVt9ZVflkZoVvyyXwC5AgNg8QmcaEEBt07jUsRUE777kp2QVeJjCuc6ANARtF0D2Qz+npn1OlitCDu7npESAYeGw0UbqysPZCNKCzo9yBxC3DIwlP+np9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315045; c=relaxed/simple;
	bh=xDiPN40MmG1UPAvwd46yOgRRrQfI46FAkmr/2/7BvPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea3HifpD/4rytwpRnWKHOM3Eol53p72ddHL5kg90FAK7l/VNY9BDqtOzRsjsus+loV+Hrv10Uf50eJXDnXmQXqF9KPC5m2HZMjef8PRW2E7yhB6IelXSDWW5dx1SETqFTgqptByJg3UtXYYvRt44ehIOpk2vtIXYsAEAuvdpLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMK1iTZd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMK1iTZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C416C19425;
	Thu, 12 Mar 2026 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773315044;
	bh=xDiPN40MmG1UPAvwd46yOgRRrQfI46FAkmr/2/7BvPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMK1iTZdmhJoNSAZLNVbdPtZdH81n0bjUy4mOsfZYB/iPnLwbkTfXAvL6NeRK+1pn
	 GYlFxDfEUjcz5YgeJOoN/yh6c7/7nWBL+9pm8zRc6yhGF+UlDeBJX3IdTZ2mi6QHuJ
	 sl/LbtCXda474/ifm4+QNSv9LjG5xWIOHLhSZS5lKNqNGN2evP5j9IDOQSfNj0NkbU
	 GEYSkuQZK6GmJr2054BCBlulLr2X6yNnYKhpDeJDSrPf+C2B/yvQ8d9x220X8VILjp
	 h6M9+B6CU0DYwVmAoCBsfgGSaprJtrQa6ESY3Ku9+K9nkLJjGkt7gyJpFPU/OhlnQq
	 zi5z5995ie1Aw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Mattia Dongili <malattia@linux.it>
Subject:
 [PATCH v1 3/3] platform/x86: sony-laptop: Convert PIC driver to a platform
 one
Date: Thu, 12 Mar 2026 12:30:27 +0100
Message-ID: <2059875.yKVeVyVuyW@rafael.j.wysocki>
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
ACPI companions, so convert the Programmable IO Control (pic) part of
the Sony laptop driver from an ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/sony-laptop.c | 51 +++++++++++++++---------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index bc9a3ae71be8..b18f00e9082f 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -4279,9 +4279,9 @@ static int sony_pic_possible_resources(struct acpi_device *device)
 /*
  *  Disable the spic device by calling its _DIS method
  */
-static int sony_pic_disable(struct acpi_device *device)
+static int sony_pic_disable(struct device *dev)
 {
-	acpi_status ret = acpi_evaluate_object(device->handle, "_DIS", NULL,
+	acpi_status ret = acpi_evaluate_object(ACPI_HANDLE(dev), "_DIS", NULL,
 					       NULL);
 
 	if (ACPI_FAILURE(ret) && ret != AE_NOT_FOUND)
@@ -4297,7 +4297,7 @@ static int sony_pic_disable(struct acpi_device *device)
  *
  *  Call _SRS to set current resources
  */
-static int sony_pic_enable(struct acpi_device *device,
+static int sony_pic_enable(struct device *dev,
 		struct sony_pic_ioport *ioport, struct sony_pic_irq *irq)
 {
 	acpi_status status;
@@ -4379,7 +4379,7 @@ static int sony_pic_enable(struct acpi_device *device,
 
 	/* Attempt to set the resource */
 	dprintk("Evaluating _SRS\n");
-	status = acpi_set_current_resources(device->handle, &buffer);
+	status = acpi_set_current_resources(ACPI_HANDLE(dev), &buffer);
 
 	/* check for total failure */
 	if (ACPI_FAILURE(status)) {
@@ -4468,12 +4468,12 @@ static irqreturn_t sony_pic_irq(int irq, void *dev_id)
  *  ACPI driver
  *
  *****************/
-static void sony_pic_remove(struct acpi_device *device)
+static void sony_pic_remove(struct platform_device *pdev)
 {
 	struct sony_pic_ioport *io, *tmp_io;
 	struct sony_pic_irq *irq, *tmp_irq;
 
-	if (sony_pic_disable(device)) {
+	if (sony_pic_disable(&pdev->dev)) {
 		pr_err("Couldn't disable device\n");
 		return;
 	}
@@ -4507,11 +4507,12 @@ static void sony_pic_remove(struct acpi_device *device)
 	dprintk(SONY_PIC_DRIVER_NAME " removed.\n");
 }
 
-static int sony_pic_add(struct acpi_device *device)
+static int sony_pic_probe(struct platform_device *pdev)
 {
-	int result;
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct sony_pic_ioport *io, *tmp_io;
 	struct sony_pic_irq *irq, *tmp_irq;
+	int result;
 
 	spic_dev.acpi_dev = device;
 	strscpy(acpi_device_class(device), "sony/hotkey");
@@ -4526,7 +4527,7 @@ static int sony_pic_add(struct acpi_device *device)
 	}
 
 	/* setup input devices and helper fifo */
-	result = sony_laptop_setup_input(&device->dev);
+	result = sony_laptop_setup_input(&pdev->dev);
 	if (result) {
 		pr_err("Unable to create input devices\n");
 		goto err_free_resources;
@@ -4596,7 +4597,7 @@ static int sony_pic_add(struct acpi_device *device)
 	}
 
 	/* set resource status _SRS */
-	result = sony_pic_enable(device, spic_dev.cur_ioport, spic_dev.cur_irq);
+	result = sony_pic_enable(&pdev->dev, spic_dev.cur_ioport, spic_dev.cur_irq);
 	if (result) {
 		pr_err("Couldn't enable device\n");
 		goto err_free_irq;
@@ -4619,7 +4620,7 @@ static int sony_pic_add(struct acpi_device *device)
 	sony_pf_remove();
 
 err_disable_device:
-	sony_pic_disable(device);
+	sony_pic_disable(&pdev->dev);
 
 err_free_irq:
 	free_irq(spic_dev.cur_irq->irq.interrupts[0], &spic_dev);
@@ -4655,15 +4656,14 @@ static int sony_pic_add(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int sony_pic_suspend(struct device *dev)
 {
-	if (sony_pic_disable(to_acpi_device(dev)))
+	if (sony_pic_disable(dev))
 		return -ENXIO;
 	return 0;
 }
 
 static int sony_pic_resume(struct device *dev)
 {
-	sony_pic_enable(to_acpi_device(dev),
-			spic_dev.cur_ioport, spic_dev.cur_irq);
+	sony_pic_enable(dev, spic_dev.cur_ioport, spic_dev.cur_irq);
 	return 0;
 }
 #endif
@@ -4675,15 +4675,14 @@ static const struct acpi_device_id sony_pic_device_ids[] = {
 	{"", 0},
 };
 
-static struct acpi_driver sony_pic_driver = {
-	.name = SONY_PIC_DRIVER_NAME,
-	.class = SONY_PIC_CLASS,
-	.ids = sony_pic_device_ids,
-	.ops = {
-		.add = sony_pic_add,
-		.remove = sony_pic_remove,
-		},
-	.drv.pm = &sony_pic_pm,
+static struct platform_driver sony_pic_driver = {
+	.probe = sony_pic_probe,
+	.remove = sony_pic_remove,
+	.driver = {
+		.name = SONY_PIC_DRIVER_NAME,
+		.acpi_match_table = sony_pic_device_ids,
+		.pm = &sony_pic_pm,
+	},
 };
 
 static const struct dmi_system_id sonypi_dmi_table[] __initconst = {
@@ -4709,7 +4708,7 @@ static int __init sony_laptop_init(void)
 	int result;
 
 	if (!no_spic && dmi_check_system(sonypi_dmi_table)) {
-		result = acpi_bus_register_driver(&sony_pic_driver);
+		result = platform_driver_register(&sony_pic_driver);
 		if (result) {
 			pr_err("Unable to register SPIC driver\n");
 			goto out;
@@ -4727,7 +4726,7 @@ static int __init sony_laptop_init(void)
 
 out_unregister_pic:
 	if (spic_drv_registered)
-		acpi_bus_unregister_driver(&sony_pic_driver);
+		platform_driver_unregister(&sony_pic_driver);
 out:
 	return result;
 }
@@ -4736,7 +4735,7 @@ static void __exit sony_laptop_exit(void)
 {
 	platform_driver_unregister(&sony_nc_driver);
 	if (spic_drv_registered)
-		acpi_bus_unregister_driver(&sony_pic_driver);
+		platform_driver_unregister(&sony_pic_driver);
 }
 
 module_init(sony_laptop_init);
-- 
2.51.0




