Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE437FF45;
	Mon, 11 May 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530564; cv=none; b=bqwhjm6N/hjbIQeOBiC+eeQ+gIf8QbaHCP6IJ4pwpd1dz0BhGyS+3u9kzP8+DX8PCl+s7Oiea+q+zobqb7HoTUnFq5h+WGmZVgPxFeqXVANT3vnO2GUPqzYwRI0M8p2cRXOVsUmCa6UVtjIloHWUq+RkEpdzdJH1qpqkHofEFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530564; c=relaxed/simple;
	bh=SeBkkLzGPCvo7nKnWj54c+MRgwDl5dw54Bzsq9RbpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lboz9qoxdev+z5SHRO6geCJXRUk3zwb8W69/HTnvInM9XjjrPf92Whombd0WY/v9h734AmGDIaR4DDXZ0wP/NBuvlyKfrTeeNVI902XKkbO6vuR7daLsscDVQpCn7siyug2feM7l+v9b7NLt90w/+8fPwszphckjRaDmIy3V5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns/FOoQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns/FOoQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7891DC2BCB0;
	Mon, 11 May 2026 20:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530564;
	bh=SeBkkLzGPCvo7nKnWj54c+MRgwDl5dw54Bzsq9RbpCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ns/FOoQlVBw0bacWHz+0UkRdYNCjUPZBHKz0AokkJ8Ku6ya6zSPRLdSR9WMMSwUzL
	 VmpfFUmcycYZ159rx5wcznXcpC+ryAfnSHbocbbQAc/JoDp+HPQ5uzTwVrnzCfUscB
	 j5jfgO3ZRLW3vZKbIEDCxUw6PwW79SXFjd3Pk/6vV2FIYbkueTI1lYMp37J20fm/ka
	 xEYpsrVQMMW+8fmyu+bUPKnhWqodBK5gNZZLv+8zK28M+c+MxkQyxnEMU+WGQ5CvdB
	 SsSb2g5hHy2uL5W82oNuhHB2jporBHY9M+4B8cYlquAPGsDu6bQc5LO+77Pp3Wv8Ho
	 1p79g/xRxZ5Mg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 03/10] platform/x86: classmate-laptop: Pass struct device pointer
 to helpers
Date: Mon, 11 May 2026 22:06:59 +0200
Message-ID: <9615385.CDJkKcVGEf@rafael.j.wysocki>
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

To facilitate subsequent conversion of the driver to using struct
platform_driver instead of struct acpi_driver, modify two helper
functions in it, cmpc_add_acpi_notify_device() and
cmpc_remove_acpi_notify_device(), to take a struct device pointer
argument instead of a struct acpi_device pointer argument and update
their callers accordingly.

While at it, change the return type of cmpc_remove_acpi_notify_device()
to void because its return value is never checked.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase

---
 drivers/platform/x86/classmate-laptop.c | 32 ++++++++++++-------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index d1407a28c1de..6521d42f8204 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -38,7 +38,7 @@ struct cmpc_accel {
 
 typedef void (*input_device_init)(struct input_dev *dev);
 
-static int cmpc_add_acpi_notify_device(struct acpi_device *acpi, char *name,
+static int cmpc_add_acpi_notify_device(struct device *dev, char *name,
 				       input_device_init idev_init)
 {
 	struct input_dev *inputdev;
@@ -48,22 +48,20 @@ static int cmpc_add_acpi_notify_device(struct acpi_device *acpi, char *name,
 	if (!inputdev)
 		return -ENOMEM;
 	inputdev->name = name;
-	inputdev->dev.parent = &acpi->dev;
+	inputdev->dev.parent = dev;
 	idev_init(inputdev);
 	error = input_register_device(inputdev);
 	if (error) {
 		input_free_device(inputdev);
 		return error;
 	}
-	dev_set_drvdata(&acpi->dev, inputdev);
+	dev_set_drvdata(dev, inputdev);
 	return 0;
 }
 
-static int cmpc_remove_acpi_notify_device(struct acpi_device *acpi)
+static void cmpc_remove_acpi_notify_device(struct device *dev)
 {
-	struct input_dev *inputdev = dev_get_drvdata(&acpi->dev);
-	input_unregister_device(inputdev);
-	return 0;
+	input_unregister_device(dev_get_drvdata(dev));
 }
 
 /*
@@ -406,7 +404,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 	accel->inputdev_state = CMPC_ACCEL_DEV_STATE_CLOSED;
 
-	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel_v4",
+	error = cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_accel_v4",
 					    cmpc_accel_idev_init_v4);
 	if (error)
 		return error;
@@ -434,7 +432,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 failed_g_select:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 failed_sensitivity:
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 	return error;
 }
 
@@ -442,7 +440,7 @@ static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 {
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 }
 
 static SIMPLE_DEV_PM_OPS(cmpc_accel_pm, cmpc_accel_suspend_v4,
@@ -653,7 +651,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	if (!accel)
 		return -ENOMEM;
 
-	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel",
+	error = cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_accel",
 					    cmpc_accel_idev_init);
 	if (error)
 		return error;
@@ -672,14 +670,14 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	return 0;
 
 failed_file:
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 	return error;
 }
 
 static void cmpc_accel_remove(struct acpi_device *acpi)
 {
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 }
 
 static const struct acpi_device_id cmpc_accel_device_ids[] = {
@@ -750,13 +748,13 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 
 static int cmpc_tablet_add(struct acpi_device *acpi)
 {
-	return cmpc_add_acpi_notify_device(acpi, "cmpc_tablet",
+	return cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_tablet",
 					   cmpc_tablet_idev_init);
 }
 
 static void cmpc_tablet_remove(struct acpi_device *acpi)
 {
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1074,13 +1072,13 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
 
 static int cmpc_keys_add(struct acpi_device *acpi)
 {
-	return cmpc_add_acpi_notify_device(acpi, "cmpc_keys",
+	return cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_keys",
 					   cmpc_keys_idev_init);
 }
 
 static void cmpc_keys_remove(struct acpi_device *acpi)
 {
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 }
 
 static const struct acpi_device_id cmpc_keys_device_ids[] = {
-- 
2.51.0




