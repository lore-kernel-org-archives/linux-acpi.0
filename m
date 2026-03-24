Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC92DB7BE;
	Tue, 24 Mar 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382598; cv=none; b=FkEjrqJI4E2KZd5SgvQWTJQLv5maquanVJlm3LWgzht4Wrcvi9zy1GCsSNn0R7Kbm761BqwGIX+z+/vPxwcXeood7dpyWZgMvk7lZpPlE4l4/etPRDnS+EFj7OmHizuz3iBmFdGItjfeE1z8Ll+1VT9hx1XS+ARMHAaKCjfz7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382598; c=relaxed/simple;
	bh=waU2ZjHjpmbtT2bBne1NFGVPliNCzUudD/WuwcfSraM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DF1rLy1VXct87iTBb4KwBivGldJbfy2V4XrmDiQ/OuUPKPgdf7qPB9gIQ23mFPZHQfzR24oG/BNJEAItgxpSIGcDrWqZthh0TjlVJVBY8dZgJDavc/aVZjfaANEPt7+BW6EFzzj8sAexj9oNgVcGWwoS55id50w/fcP/1qVr4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDVxBQJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDVxBQJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01D6C2BCB1;
	Tue, 24 Mar 2026 20:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774382598;
	bh=waU2ZjHjpmbtT2bBne1NFGVPliNCzUudD/WuwcfSraM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDVxBQJH0C5mU/39RE+Imb6jU3rfseCQO2lFwzxlaUYMq+IiqCZs2d/dzrjYRCDpe
	 LxBQo73jkcXzDO801O9t/5NFl71MkS+B+Pi9iasnbic/SWmh3yual9mdiyxH6+gCSj
	 jaqhbEZtcIil+C83PQrlX5eBghgJh6LgMn0CliGZUQD5oz9D0EV0x7osIy5Y1q6PEa
	 Lm0rXsRFSSRaMe40qGQLgsoIMuoVqms/jMILEH03eOXSJnRdXdigwzUAc9CfXWW9uQ
	 iNJhHjaEcutMgsU7uOumdeLAIVpe/19GVqZza6/tONZAnWZFZFCZUOMFUBRhzsrJt6
	 aKV4Goh6dj1RQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 7/7] platform/x86: toshiba_haps: Convert ACPI driver to a platform
 one
Date: Tue, 24 Mar 2026 21:03:01 +0100
Message-ID: <2045343.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
References: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
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
ACPI companions, so convert the Toshiba HDD Active Protection Sensor
driver from an ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Note that the sysfs attributes in haps_attr_group will still be there
in the sysfs directory of the ACPI companion of the platform device
used for driver binding in case there are tools in user space expecting
them to be present there.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/toshiba_haps.c | 40 +++++++++++++++--------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86/toshiba_haps.c
index 6eac306cf92a..1486252b5983 100644
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 
 MODULE_AUTHOR("Azael Avalos <coproscefalo@gmail.com>");
 MODULE_DESCRIPTION("Toshiba HDD Active Protection Sensor");
@@ -140,8 +141,10 @@ static void toshiba_haps_notify(acpi_handle handle, u32 event, void *data)
 					event, 0);
 }
 
-static void toshiba_haps_remove(struct acpi_device *device)
+static void toshiba_haps_remove(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       toshiba_haps_notify);
 
@@ -149,6 +152,8 @@ static void toshiba_haps_remove(struct acpi_device *device)
 
 	if (toshiba_haps)
 		toshiba_haps = NULL;
+
+	dev_set_drvdata(&device->dev, NULL);
 }
 
 /* Helper function */
@@ -175,8 +180,9 @@ static int toshiba_haps_available(acpi_handle handle)
 	return 1;
 }
 
-static int toshiba_haps_add(struct acpi_device *acpi_dev)
+static int toshiba_haps_probe(struct platform_device *pdev)
 {
+	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
 	struct toshiba_haps_dev *haps;
 	int ret;
 
@@ -188,14 +194,15 @@ static int toshiba_haps_add(struct acpi_device *acpi_dev)
 
 	pr_info("Toshiba HDD Active Protection Sensor device\n");
 
-	haps = devm_kzalloc(&acpi_dev->dev, sizeof(*haps), GFP_KERNEL);
+	haps = devm_kzalloc(&pdev->dev, sizeof(*haps), GFP_KERNEL);
 	if (!haps)
 		return -ENOMEM;
 
 	haps->acpi_dev = acpi_dev;
 	haps->protection_level = 2;
-	acpi_dev->driver_data = haps;
+
 	dev_set_drvdata(&acpi_dev->dev, haps);
+	platform_set_drvdata(pdev, haps);
 
 	/* Set the protection level, currently at level 2 (Medium) */
 	ret = toshiba_haps_protection_level(acpi_dev->handle, 2);
@@ -223,11 +230,9 @@ static int toshiba_haps_add(struct acpi_device *acpi_dev)
 #ifdef CONFIG_PM_SLEEP
 static int toshiba_haps_suspend(struct device *device)
 {
-	struct toshiba_haps_dev *haps;
+	struct toshiba_haps_dev *haps = dev_get_drvdata(device);
 	int ret;
 
-	haps = acpi_driver_data(to_acpi_device(device));
-
 	/* Deactivate the protection on suspend */
 	ret = toshiba_haps_protection_level(haps->acpi_dev->handle, 0);
 
@@ -236,11 +241,9 @@ static int toshiba_haps_suspend(struct device *device)
 
 static int toshiba_haps_resume(struct device *device)
 {
-	struct toshiba_haps_dev *haps;
+	struct toshiba_haps_dev *haps = dev_get_drvdata(device);
 	int ret;
 
-	haps = acpi_driver_data(to_acpi_device(device));
-
 	/* Set the stored protection level */
 	ret = toshiba_haps_protection_level(haps->acpi_dev->handle,
 					    haps->protection_level);
@@ -263,15 +266,14 @@ static const struct acpi_device_id haps_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, haps_device_ids);
 
-static struct acpi_driver toshiba_haps_driver = {
-	.name = "Toshiba HAPS",
-	.ids = haps_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
-	.ops = {
-		.add =		toshiba_haps_add,
-		.remove =	toshiba_haps_remove,
+static struct platform_driver toshiba_haps_driver = {
+	.probe = toshiba_haps_probe,
+	.remove = toshiba_haps_remove,
+	.driver = {
+		.name = "Toshiba HAPS",
+		.acpi_match_table = haps_device_ids,
+		.pm = &toshiba_haps_pm,
 	},
-	.drv.pm = &toshiba_haps_pm,
 };
 
-module_acpi_driver(toshiba_haps_driver);
+module_platform_driver(toshiba_haps_driver);
-- 
2.51.0




