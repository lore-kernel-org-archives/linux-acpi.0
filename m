Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D689230264;
	Mon, 11 May 2026 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530541; cv=none; b=sTDRc4uixQ6ln31PXgLJJP4A4IV245j0+oSyvcjKlpuS4FY5jhlp8LcHwnk/EebChEt9sEDd1U1HznFpOuaOxyKRg7YveK1VkNAENfmcgXth8rmAaUy0ZJfx6/BiUOrBbZlGHkboHGsW0Ps8cWXZjzO5YggI1cFIW4+LkwfYiVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530541; c=relaxed/simple;
	bh=CcwSRKg63/oPlR3/8hmPwkUvn1FW2cAMrAFFsRqae0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFrxXkAiiixWQuDqDvOhRPXNxIWTk3wovGjDYu6rBLgea1iCbUjmHrJawaPdAqM7iLbQ6W/vJ3aMaASXZBAErGu9TFYDZk4mIw4ZKyWn1kNaEST6mDpSjQeZ21L2WZPMcGtylSu5LIy9q25yq1eHrrryWZH+5FZNepZCIztjk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwReNdDI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwReNdDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B0DC2BCB0;
	Mon, 11 May 2026 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530541;
	bh=CcwSRKg63/oPlR3/8hmPwkUvn1FW2cAMrAFFsRqae0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwReNdDI5fmpuHhX6LIvCUUbtCUeaBF8UEqGkaY1+fcleTDKT5xrp8pKVSuzAI14x
	 sp9hInGHOExZuvYzKIGKloh8GUufRp7qKwJmO7UHQOfrF7UUv887d3WDJg+6cL1lJA
	 purCIvaj/VNZMNRDq5OWA7rDpO2OKL18cIuI6FRTM6O0/4P/vJt7Hbnk2JyDBx0yAw
	 tR61bg8eYrYyMhIB3EKHYI86GHMnrDmCNIJ57OlpY29u7jem4455zQu69/gj5fpMjK
	 CE25imyPOQuwvRCAcL4Bh8Rb+TYok3WzN8qqYh1A8uF7KkpGTe3hhfYT2jOoBjP5nK
	 i2H19aJJcplPA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 09/10] platform/x86: classmate-laptop: Convert ipml driver to a
 platform one
Date: Mon, 11 May 2026 22:14:13 +0200
Message-ID: <3753883.R56niFO833@rafael.j.wysocki>
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
ACPI companions, so convert cmpc_ipml_acpi_driver in the Classmate
laptop driver from an ACPI driver to a platform one.

After this change, the backlight and rfkill devices registered by the
driver will appear under the platform device used for driver binding.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase
   * Check the ACPI handle against NULL at probe time

---
 drivers/platform/x86/classmate-laptop.c | 42 ++++++++++++++-----------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 464ab852b492..08ff4549e956 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -997,11 +997,16 @@ struct ipml200_dev {
 	struct rfkill *rf;
 };
 
-static int cmpc_ipml_add(struct acpi_device *acpi)
+static int cmpc_ipml_probe(struct platform_device *pdev)
 {
 	int retval;
 	struct ipml200_dev *ipml;
 	struct backlight_properties props;
+	acpi_handle handle;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
 
 	ipml = kmalloc_obj(*ipml);
 	if (ipml == NULL)
@@ -1010,16 +1015,16 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = 7;
-	ipml->bd = backlight_device_register("cmpc_bl", &acpi->dev,
-					     acpi->handle, &cmpc_bl_ops,
+	ipml->bd = backlight_device_register("cmpc_bl", &pdev->dev,
+					     handle, &cmpc_bl_ops,
 					     &props);
 	if (IS_ERR(ipml->bd)) {
 		retval = PTR_ERR(ipml->bd);
 		goto out_bd;
 	}
 
-	ipml->rf = rfkill_alloc("cmpc_rfkill", &acpi->dev, RFKILL_TYPE_WLAN,
-				&cmpc_rfkill_ops, acpi->handle);
+	ipml->rf = rfkill_alloc("cmpc_rfkill", &pdev->dev, RFKILL_TYPE_WLAN,
+				&cmpc_rfkill_ops, handle);
 	/*
 	 * If RFKILL is disabled, rfkill_alloc will return ERR_PTR(-ENODEV).
 	 * This is OK, however, since all other uses of the device will not
@@ -1033,7 +1038,7 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
 		}
 	}
 
-	dev_set_drvdata(&acpi->dev, ipml);
+	platform_set_drvdata(pdev, ipml);
 	return 0;
 
 out_bd:
@@ -1041,11 +1046,11 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
 	return retval;
 }
 
-static void cmpc_ipml_remove(struct acpi_device *acpi)
+static void cmpc_ipml_remove(struct platform_device *pdev)
 {
 	struct ipml200_dev *ipml;
 
-	ipml = dev_get_drvdata(&acpi->dev);
+	ipml = platform_get_drvdata(pdev);
 
 	backlight_device_unregister(ipml->bd);
 
@@ -1062,14 +1067,13 @@ static const struct acpi_device_id cmpc_ipml_device_ids[] = {
 	{"", 0}
 };
 
-static struct acpi_driver cmpc_ipml_acpi_driver = {
-	.name = "cmpc",
-	.class = "cmpc",
-	.ids = cmpc_ipml_device_ids,
-	.ops = {
-		.add = cmpc_ipml_add,
-		.remove = cmpc_ipml_remove
-	}
+static struct platform_driver cmpc_ipml_acpi_driver = {
+	.probe = cmpc_ipml_probe,
+	.remove = cmpc_ipml_remove,
+	.driver = {
+		.name = "cmpc",
+		.acpi_match_table = cmpc_ipml_device_ids,
+	},
 };
 
 
@@ -1165,7 +1169,7 @@ static int cmpc_init(void)
 	if (r)
 		goto failed_keys;
 
-	r = acpi_bus_register_driver(&cmpc_ipml_acpi_driver);
+	r = platform_driver_register(&cmpc_ipml_acpi_driver);
 	if (r)
 		goto failed_bl;
 
@@ -1190,7 +1194,7 @@ static int cmpc_init(void)
 	platform_driver_unregister(&cmpc_tablet_acpi_driver);
 
 failed_tablet:
-	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
+	platform_driver_unregister(&cmpc_ipml_acpi_driver);
 
 failed_bl:
 	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
@@ -1204,7 +1208,7 @@ static void cmpc_exit(void)
 	platform_driver_unregister(&cmpc_accel_acpi_driver_v4);
 	platform_driver_unregister(&cmpc_accel_acpi_driver);
 	platform_driver_unregister(&cmpc_tablet_acpi_driver);
-	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
+	platform_driver_unregister(&cmpc_ipml_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
 }
 



