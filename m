Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72250351C17;
	Thu, 12 Mar 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326080; cv=none; b=a2ZKfkid6+/SJxI0lhoq7/XdSDZfsspiRcexhhL0PUpE1uggH8pdnDID43WrbH9kMBSCTmTJUMZFlYP2dQylXSjlNcfMhADWtKw9G9nGI8Ze4NPblRA3cQyQL0MECDhPRCca19HL1TFylY/Ym/hh8ksC0LuObJXC9UEXhnXwXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326080; c=relaxed/simple;
	bh=KeNWQ4VFqwi7jIhLZ08MJH4KZ/1JcdRZBaObz3Q8F1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eY3hrH9f/HbnQsSUR/YvjALtOx/LjtXisr79nfDSuYS2LeIaphkFu+bBgP09IwP+KyoK4g95018t5kIzf3eRRAtxNbBCIirv2Vl8G4GVu3JGMQ17PyZpu/Yq95Zt6ATK85BddIKcXJqlVqtApJ3w83B91yZbM7byUrOhurkjBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MogFyEgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MogFyEgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF32C4CEF7;
	Thu, 12 Mar 2026 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773326080;
	bh=KeNWQ4VFqwi7jIhLZ08MJH4KZ/1JcdRZBaObz3Q8F1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MogFyEgImXnYyModaX59VxpkI1EkE6IosEJ7bwXF0ywykuqMVAdsKVZSKr19S4+u3
	 wflMb4i0zZj/1ysxSR6Ke84OMtLE3Cmu0wTER7RJVtxLNgSSETSkzdwlwoUKkbeRoe
	 krG3OjRNx7+WivJW0aqg98tpjXRG4NBsL0AI9hMsVFLZlEKj9DhoNxfTGtvrvRc2PH
	 ZbTh+2KWMYhktS3NYApmTpvKNrAjJwX2tKYXqc4sZ4lECcHQAqPu3FAhkUQfGPKCR2
	 j2wgw8iUOYc94ksKOvFM8gc0OHBKkrDF8sySc0fryFU4ikbzXAJryEAK32j9F2BjZm
	 ZcFpnqEyGKANg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Herton Ronaldo Krzesinski <herton@canonical.com>
Subject:
 [PATCH v1 2/2] platform/x86: topstar-laptop: Convert ACPI driver to a
 platform one
Date: Thu, 12 Mar 2026 15:34:25 +0100
Message-ID: <10834824.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3053187.e9J7NaK4W3@rafael.j.wysocki>
References: <3053187.e9J7NaK4W3@rafael.j.wysocki>
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
ACPI companions, so convert the Topstar Laptop ACPI Extras driver from
an ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/topstar-laptop.c | 30 ++++++++++++++-------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 695ec1d25bcd..e09d7f8ce45f 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -285,8 +285,9 @@ static const struct dmi_system_id topstar_dmi_ids[] = {
 	{}
 };
 
-static int topstar_acpi_add(struct acpi_device *device)
+static int topstar_acpi_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct topstar_laptop *topstar;
 	int err;
 
@@ -296,9 +297,10 @@ static int topstar_acpi_add(struct acpi_device *device)
 	if (!topstar)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, topstar);
+
 	strscpy(acpi_device_name(device), "Topstar TPSACPI");
 	strscpy(acpi_device_class(device), TOPSTAR_LAPTOP_CLASS);
-	device->driver_data = topstar;
 	topstar->device = device;
 
 	err = topstar_acpi_init(topstar);
@@ -339,14 +341,15 @@ static int topstar_acpi_add(struct acpi_device *device)
 	return err;
 }
 
-static void topstar_acpi_remove(struct acpi_device *device)
+static void topstar_acpi_remove(struct platform_device *pdev)
 {
-	struct topstar_laptop *topstar = acpi_driver_data(device);
+	struct topstar_laptop *topstar = platform_get_drvdata(pdev);
 
 	if (led_workaround)
 		topstar_led_exit(topstar);
 
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
 	topstar_input_exit(topstar);
 	topstar_platform_exit(topstar);
 	topstar_acpi_exit(topstar);
@@ -361,13 +364,12 @@ static const struct acpi_device_id topstar_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, topstar_device_ids);
 
-static struct acpi_driver topstar_acpi_driver = {
-	.name = "Topstar laptop ACPI driver",
-	.class = TOPSTAR_LAPTOP_CLASS,
-	.ids = topstar_device_ids,
-	.ops = {
-		.add = topstar_acpi_add,
-		.remove = topstar_acpi_remove,
+static struct platform_driver topstar_acpi_driver = {
+	.probe = topstar_acpi_probe,
+	.remove = topstar_acpi_remove,
+	.driver = {
+		.name = "Topstar laptop ACPI driver",
+		.acpi_match_table = topstar_device_ids,
 	},
 };
 
@@ -379,7 +381,7 @@ static int __init topstar_laptop_init(void)
 	if (ret < 0)
 		return ret;
 
-	ret = acpi_bus_register_driver(&topstar_acpi_driver);
+	ret = platform_driver_register(&topstar_acpi_driver);
 	if (ret < 0)
 		goto err_driver_unreg;
 
@@ -393,7 +395,7 @@ static int __init topstar_laptop_init(void)
 
 static void __exit topstar_laptop_exit(void)
 {
-	acpi_bus_unregister_driver(&topstar_acpi_driver);
+	platform_driver_unregister(&topstar_acpi_driver);
 	platform_driver_unregister(&topstar_platform_driver);
 }
 
-- 
2.51.0




