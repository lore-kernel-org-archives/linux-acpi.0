Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314B38F62A;
	Thu, 12 Mar 2026 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314099; cv=none; b=RSC39dLbxlpArCaZ2OQXCIh8gAIy2nOdXnHXZXii5sVXILK3uuAapPqqrF1LuVkPHcOC/fkz5ju4FqqPdKGzHYK1Ubxob1qRVds5zzEOhSwLxHhcLCP/tJmdGupU5230bgmhZB6ZpZvcSWYEL7SA7BwY/UUPLh3iBOsmrBEl9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314099; c=relaxed/simple;
	bh=RLrEVnlpjgZjN1YXR5sqd847zlm3KfJoLgJ57yBsbFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCWLo85uWH0HeJbPKUbbWHJ1JgKqCxwRpByDqyV0KCIeb+3ZFtb/NWCHikVWnG6HXWP3psm80v3NG8tnE8FLCzwB7fKRpk8JA0g0rY/3Y4rB/tiP2YBN5VNHoeW7VMHbG2ONzMG28Ych90XL+qA7IJpFLQmluedIPtI2dQir9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+nsK245; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+nsK245"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCF6C4CEF7;
	Thu, 12 Mar 2026 11:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314098;
	bh=RLrEVnlpjgZjN1YXR5sqd847zlm3KfJoLgJ57yBsbFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+nsK245W9unxq7sytkxjsJzZmvgglw0QSQUgk1zW90p1HNjNYQyjIijgd5PEMbO8
	 4EzQEqa+OoHkXCpQZvOZf6UvgOaPW+Kts9mzdNWNsrev8amVjn+74DtOME1kBK5UH1
	 Kpm85iv4zDq8kPJqsMk0ZRVoWU0o85ujS7tqFCy7dvZfRBkdfoF5o6NVbAJX804ID6
	 bjDZDU7D9BT7dPwo6fIgi1/MLoXQnyiEW4DvpxkCpAqoxukQn4fKW91Y22sapr8F1K
	 MqnMZHBv0EXMOcI3j4kQTaWsipqV1Ct95rW8clFmUED/vLF9ynDUpngHT3Juj1sb+Z
	 q3VisMHAq2CTQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Matan Ziv-Av <matan@svgalib.org>
Subject:
 [PATCH v1 2/2] platform/x86: lg-laptop: Convert ACPI driver to a platform one
Date: Thu, 12 Mar 2026 12:14:47 +0100
Message-ID: <1868365.VLH7GnMWUR@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3698311.iIbC2pHGDl@rafael.j.wysocki>
References: <3698311.iIbC2pHGDl@rafael.j.wysocki>
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
ACPI companions, so convert the LG Gram ACPI features and hotkeys driver
from an ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/lg-laptop.c | 45 +++++++++-----------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 7122d96abf86..9681412d694b 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -759,8 +759,9 @@ static void lg_laptop_remove_address_space_handler(void *data)
 					  &lg_laptop_address_space_handler);
 }
 
-static int acpi_add(struct acpi_device *device)
+static int acpi_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct platform_device_info pdev_info = {
 		.fwnode = acpi_fwnode_handle(device),
 		.name = PLATFORM_NAME,
@@ -776,11 +777,11 @@ static int acpi_add(struct acpi_device *device)
 
 	status = acpi_install_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,
 						    &lg_laptop_address_space_handler,
-						    NULL, &device->dev);
+						    NULL, &pdev->dev);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	ret = devm_add_action_or_reset(&device->dev, lg_laptop_remove_address_space_handler,
+	ret = devm_add_action_or_reset(&pdev->dev, lg_laptop_remove_address_space_handler,
 				       device);
 	if (ret < 0)
 		return ret;
@@ -874,7 +875,7 @@ static int acpi_add(struct acpi_device *device)
 	return ret;
 }
 
-static void acpi_remove(struct acpi_device *device)
+static void acpi_remove(struct platform_device *pdev)
 {
 	sysfs_remove_group(&pf_device->dev.kobj, &dev_attribute_group);
 
@@ -894,33 +895,13 @@ static const struct acpi_device_id device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
 
-static struct acpi_driver acpi_driver = {
-	.name = "LG Gram Laptop Support",
-	.class = "lg-laptop",
-	.ids = device_ids,
-	.ops = {
-		.add = acpi_add,
-		.remove = acpi_remove,
-		},
+static struct platform_driver acpi_driver = {
+	.probe = acpi_probe,
+	.remove = acpi_remove,
+	.driver = {
+		.name = "LG Gram Laptop Support",
+		.acpi_match_table = device_ids,
+	},
 };
 
-static int __init acpi_init(void)
-{
-	int result;
-
-	result = acpi_bus_register_driver(&acpi_driver);
-	if (result < 0) {
-		pr_debug("Error registering driver\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static void __exit acpi_exit(void)
-{
-	acpi_bus_unregister_driver(&acpi_driver);
-}
-
-module_init(acpi_init);
-module_exit(acpi_exit);
+module_platform_driver(acpi_driver);
-- 
2.51.0




