Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F9372EFA;
	Thu,  7 May 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184899; cv=none; b=joU9wHzaQYY8BARTBAk7mUVyEs5GW8JI3Chsu7YLKNzOAlEJHk8eI7LR3e0ZbQeQnQUoB0hweHKJselzLSC98JWk/2fjgMkaB4cWWubtofHoJxe+q0FH24FB6+xQ8u2OcvgL1zqLEy7eBoH71wL5kdFqEtLmTf+3Ac3Vt4w10dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184899; c=relaxed/simple;
	bh=w9Xl3BMEvKerqkfo7hyfaeg4+mt9PYmovxRrXMFl7do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLvgG/sb01cNIowf+nTAR/QgcgNLVViUPBAIz6j2vMJa3Ret+OipsvnxwP51gF0hFNHZmftpW+SBOMpwkBhkA50QzuWEQ8q2uebJrbzaPC1GZ49GBm3zOV5VXouHCtsgW4duJAZHZkIZF9c/Y+Ts1sDVOC5bK/Ov/VEyAPkNoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBoIzZDG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBoIzZDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72550C2BCB8;
	Thu,  7 May 2026 20:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778184899;
	bh=w9Xl3BMEvKerqkfo7hyfaeg4+mt9PYmovxRrXMFl7do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBoIzZDGy4eEEGcXVgh0zKEUAnSR/mZWkNH5r6loumva5rDP6PTLo6Zxo0AaUVm0X
	 m3Y6oRdQ8wb8Eb9CrQQZD6f0oVxbnWegRU5cWQrauKGyIu9TzbiZaHTc2a531T9TA3
	 QexZL2McLtZCRf1r0Tgko9wkLSO6E5GaYEAZObNYl1XxvS5WkTr40HvG5egCZAxrgN
	 Rrhnf8fKYfZFkqU+a7iepCoHJueO0fa3s8U3np7UVA51ooQ0zLZKL4RiRuszNKkH6i
	 us9ghb+Jzep4Z5nAB8kF9oHGdwnRZdfljJOcgicrFuMRQGpWILDZQH5twh3PfrSz3I
	 cVtE3TVAwxaEw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1 04/10] platform/x86: classmate-laptop: Rename two helper functions
Date: Thu, 07 May 2026 22:04:28 +0200
Message-ID: <23097445.EfDdHjke4D@rafael.j.wysocki>
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

Since cmpc_add_acpi_notify_device() and cmpc_remove_acpi_notify_device()
have been modified to take a plain struct device pointer as the first
argument, then have nothing to do with ACPI in principle, so rename
them to cmpc_add_notify_device() and cmpc_remove_notify_device(),
respectively, and consolidate white space around the call sites of
the former.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/classmate-laptop.c | 30 +++++++++++--------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 7784712bfabd..bb575ae2bc89 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -38,8 +38,8 @@ struct cmpc_accel {
 
 typedef void (*input_device_init)(struct input_dev *dev);
 
-static int cmpc_add_acpi_notify_device(struct device *dev, char *name,
-				       input_device_init idev_init)
+static int cmpc_add_notify_device(struct device *dev, char *name,
+				  input_device_init idev_init)
 {
 	struct input_dev *inputdev;
 	int error;
@@ -59,7 +59,7 @@ static int cmpc_add_acpi_notify_device(struct device *dev, char *name,
 	return 0;
 }
 
-static void cmpc_remove_acpi_notify_device(struct device *dev)
+static void cmpc_remove_notify_device(struct device *dev)
 {
 	input_unregister_device(dev_get_drvdata(dev));
 }
@@ -404,8 +404,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 	accel->inputdev_state = CMPC_ACCEL_DEV_STATE_CLOSED;
 
-	error = cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_accel_v4",
-					    cmpc_accel_idev_init_v4);
+	error = cmpc_add_notify_device(&acpi->dev, "cmpc_accel_v4", cmpc_accel_idev_init_v4);
 	if (error)
 		goto failed_input;
 
@@ -432,7 +431,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 failed_g_select:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 failed_sensitivity:
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 failed_input:
 	kfree(accel);
 	return error;
@@ -445,7 +444,7 @@ static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 	kfree(accel);
 }
 
@@ -657,8 +656,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	if (!accel)
 		return -ENOMEM;
 
-	error = cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_accel",
-					    cmpc_accel_idev_init);
+	error = cmpc_add_notify_device(&acpi->dev, "cmpc_accel", cmpc_accel_idev_init);
 	if (error)
 		goto failed_input;
 
@@ -676,7 +674,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	return 0;
 
 failed_file:
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 failed_input:
 	kfree(accel);
 	return error;
@@ -688,7 +686,7 @@ static void cmpc_accel_remove(struct acpi_device *acpi)
 	struct cmpc_accel *accel = dev_get_drvdata(&inputdev->dev);
 
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 	kfree(accel);
 }
 
@@ -760,13 +758,12 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 
 static int cmpc_tablet_add(struct acpi_device *acpi)
 {
-	return cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_tablet",
-					   cmpc_tablet_idev_init);
+	return cmpc_add_notify_device(&acpi->dev, "cmpc_tablet", cmpc_tablet_idev_init);
 }
 
 static void cmpc_tablet_remove(struct acpi_device *acpi)
 {
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1084,13 +1081,12 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
 
 static int cmpc_keys_add(struct acpi_device *acpi)
 {
-	return cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_keys",
-					   cmpc_keys_idev_init);
+	return cmpc_add_notify_device(&acpi->dev, "cmpc_keys", cmpc_keys_idev_init);
 }
 
 static void cmpc_keys_remove(struct acpi_device *acpi)
 {
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 }
 
 static const struct acpi_device_id cmpc_keys_device_ids[] = {



