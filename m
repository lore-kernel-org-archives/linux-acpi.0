Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B84372EFA;
	Thu,  7 May 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184903; cv=none; b=QixxjED0s/dlan8K14vho9LzfSYrcMfqYap1e0Kw70Ko8mAnsG39gvqF6pSdTkwEedjPfEOL1ijN0d/KxvqRc5aQcUSRfhVeZtg63VqWsJFPgtadQ4s7lUhJO6mKbbEIaXM1huPeFzKu6BCNs7xHREfeNJoTXruQVQPYXFjsiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184903; c=relaxed/simple;
	bh=P25cl1ZU1eQsj52C7RPSEyVL/2SUlLbZTIyM0XPjrgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0l/Jr5rwqGHuhDeZgZhWbj6XFJH5QoVhcYKmlChx0z8HVu1GALc67kkb7U9SV2zhi4KoU46nxGirLbbdk3SBU3aZ+EFDnjzAaTjJ2MArGlNUHKqwSed7nguHAtQbB/n0Y14R/9salmaeZeT/BnwCS0NTY0ILAip8Qi/qWlhOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htyYYNMa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htyYYNMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF49C2BCC4;
	Thu,  7 May 2026 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778184903;
	bh=P25cl1ZU1eQsj52C7RPSEyVL/2SUlLbZTIyM0XPjrgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=htyYYNMazFFTh3cfJrbOEBpcHtIQzsgv7RWWQ5NAQELSNADXRkr7TMcnJh9g8wzD7
	 /0zsbnSasyC1bDRSPciNGh0/dm6WnjZfyzitAmfndqkSXfDsZq45GGmXTebO9aJPvV
	 2FrhbfEmlWCtcy7+EPNb/GCg7f9Oz0Yc6YRSKYeTMmprMCbK8QAmbR1pMA9phYzJV/
	 OsjHdb8PigMmwHi8kpLIOF/JI73Ru4yNnta2NhLRNOOwC5UKqZ3860aoilE99shL6q
	 ZSL5FPm4FBg+l2TiqtICdUoSl9fRFHjSo9DHzWe9orup0r7A04SChsglIsXBE1eobs
	 991L2qZATv23g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1 03/10] platform/x86: classmate-laptop: Pass struct device pointer
 to helpers
Date: Thu, 07 May 2026 22:03:13 +0200
Message-ID: <8678212.T7Z3S40VBb@rafael.j.wysocki>
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
 drivers/platform/x86/classmate-laptop.c | 32 ++++++++++++-------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index bc5df682d194..7784712bfabd 100644
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
 		goto failed_input;
@@ -434,7 +432,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 failed_g_select:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 failed_sensitivity:
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 failed_input:
 	kfree(accel);
 	return error;
@@ -447,7 +445,7 @@ static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 	kfree(accel);
 }
 
@@ -659,7 +657,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	if (!accel)
 		return -ENOMEM;
 
-	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel",
+	error = cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_accel",
 					    cmpc_accel_idev_init);
 	if (error)
 		goto failed_input;
@@ -678,7 +676,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	return 0;
 
 failed_file:
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 failed_input:
 	kfree(accel);
 	return error;
@@ -690,7 +688,7 @@ static void cmpc_accel_remove(struct acpi_device *acpi)
 	struct cmpc_accel *accel = dev_get_drvdata(&inputdev->dev);
 
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
-	cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(&acpi->dev);
 	kfree(accel);
 }
 
@@ -762,13 +760,13 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 
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
@@ -1086,13 +1084,13 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
 
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



