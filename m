Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854F9241CB7;
	Thu,  7 May 2026 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184879; cv=none; b=qF88OOE1/OAyeTx1nK6ty75mblxQ5dn5JGUi10l40m7ZvEGr147Tdu3biL2Q5brITBOJ5HFgeXNosFALL6debq3wNPtKsjAVxj8e9ynZXlfYpdgAdQwk+u9NZHrEiSHGzwknzcz1oukiaKXLhDo78xG/2hdA5t7zToAsesqeZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184879; c=relaxed/simple;
	bh=309bz5Bp2M6kWGvwUx+H9ckAEzZshVxAAlsPHALVRLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaL5mWs8iq97KvY6GPaMRCbRehIQ7N22i+1gO2KaMcKXQL6o5bGXE9Kx6sRRTYjxqsxgGkfUG5hjbNEOGQYZHIjIQurtRjf+Pj6XIdX3llLq0YA+S75coYGpZ7JKzVYB46hzbVq9MyjQaCruxn6GuKVshqPcRON0WPT7AOo1y8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUG9HMFP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUG9HMFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C493AC2BCC4;
	Thu,  7 May 2026 20:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778184879;
	bh=309bz5Bp2M6kWGvwUx+H9ckAEzZshVxAAlsPHALVRLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUG9HMFPUxB5shbV+bCFT8rddqD+PbInlmBtn3Q/Bh48IQOVdkMxBU/sITiM1WaoC
	 DMPyRxJL8VCYWxn+/vy9SOLCM/oUXUG8avlS2jUJ3Fal5SGoykFPrLsr4gyaJMkGw4
	 LZ0Ixjsa+hGNuyipgj+hyuh7L7INkrf0sIaVNl4gcpoVtDDNDaLTgzxwWUFW2tQZyz
	 rgY0gMTYuhFHhffXzax5veBZ3hs3oZo33/CHSs8d/ymt7ioTzCCFKntoctsSijVK2n
	 FRtibouxn7JZqswrCpiJnCnDk9J5Ol40a2E2uUfQ1mT/AVHN5iBhBiwzOx3Sxe3tPW
	 O/7nZuz5/BVgA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1 09/10] platform/x86: classmate-laptop: Convert ipml driver to a
 platform one
Date: Thu, 07 May 2026 22:12:59 +0200
Message-ID: <2272235.Mh6RI2rZIc@rafael.j.wysocki>
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
ACPI companions, so convert cmpc_ipml_acpi_driver in the platform
x86 classmate-laptop driver from an ACPI driver to a platform one.

After this change, the backlight and rfkill devices registered by the
driver will appear under the platform device used for driver binding.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/classmate-laptop.c | 40 ++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 0bb0359387a7..dc2b7a48435c 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -995,11 +995,12 @@ struct ipml200_dev {
 	struct rfkill *rf;
 };
 
-static int cmpc_ipml_add(struct acpi_device *acpi)
+static int cmpc_ipml_probe(struct platform_device *pdev)
 {
-	int retval;
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	struct ipml200_dev *ipml;
 	struct backlight_properties props;
+	int retval;
 
 	ipml = kmalloc_obj(*ipml);
 	if (ipml == NULL)
@@ -1008,16 +1009,16 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
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
@@ -1031,7 +1032,7 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
 		}
 	}
 
-	dev_set_drvdata(&acpi->dev, ipml);
+	platform_set_drvdata(pdev, ipml);
 	return 0;
 
 out_bd:
@@ -1039,11 +1040,11 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
 	return retval;
 }
 
-static void cmpc_ipml_remove(struct acpi_device *acpi)
+static void cmpc_ipml_remove(struct platform_device *pdev)
 {
 	struct ipml200_dev *ipml;
 
-	ipml = dev_get_drvdata(&acpi->dev);
+	ipml = platform_get_drvdata(pdev);
 
 	backlight_device_unregister(ipml->bd);
 
@@ -1060,14 +1061,13 @@ static const struct acpi_device_id cmpc_ipml_device_ids[] = {
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
 
 
@@ -1163,7 +1163,7 @@ static int cmpc_init(void)
 	if (r)
 		goto failed_keys;
 
-	r = acpi_bus_register_driver(&cmpc_ipml_acpi_driver);
+	r = platform_driver_register(&cmpc_ipml_acpi_driver);
 	if (r)
 		goto failed_bl;
 
@@ -1188,7 +1188,7 @@ static int cmpc_init(void)
 	platform_driver_unregister(&cmpc_tablet_acpi_driver);
 
 failed_tablet:
-	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
+	platform_driver_unregister(&cmpc_ipml_acpi_driver);
 
 failed_bl:
 	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
@@ -1202,7 +1202,7 @@ static void cmpc_exit(void)
 	platform_driver_unregister(&cmpc_accel_acpi_driver_v4);
 	platform_driver_unregister(&cmpc_accel_acpi_driver);
 	platform_driver_unregister(&cmpc_tablet_acpi_driver);
-	acpi_bus_unregister_driver(&cmpc_ipml_acpi_driver);
+	platform_driver_unregister(&cmpc_ipml_acpi_driver);
 	acpi_bus_unregister_driver(&cmpc_keys_acpi_driver);
 }
 



