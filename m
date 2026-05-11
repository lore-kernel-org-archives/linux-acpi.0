Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716A2877F6;
	Mon, 11 May 2026 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530556; cv=none; b=T+vUAePeHRVSbibEcUIf3xGVsP25vcBBswrVAYgZQBeqQDSaNvPxfTaIiuIgfliXoy0IEZvmmxPjnE8UWCSLNjONz1kQ5QQO66o1Oq6c0LCpeI/QtLX3BofvBisa1Y7V/sJEaMBIl4pIEAIZPmSjKSGEDuuq4gDCtrplHnAE66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530556; c=relaxed/simple;
	bh=B+XA7xPYMAw7vMyPP1mqEmWQGWLqIdASclisRh4JlLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rH7yeqZT52qlgj6x7cSLid+ZhZRpI+jY32UQJWRvSPs4tJOVFUnkIqvczEvQOb3CtsCZILQTqT3x8bUlQ0XsT9WRQ2U0ramUUsfF0qThXbA5gY8Jp3UqpkTRA9SbKwt93IeludTmchVTRUMXXpmmSYXSPQn12ZgRIDZR6tVqVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pukiufme; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pukiufme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04541C2BCF5;
	Mon, 11 May 2026 20:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530556;
	bh=B+XA7xPYMAw7vMyPP1mqEmWQGWLqIdASclisRh4JlLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pukiufmepbxAMQHRpcpCqzzDZpma3DcGlkdrrBXNBN+Mw9qq5Rbt1Ci95aanRJSDm
	 r1AMb6QZQ32otHGYrAmcpiuPDnqSeaBw+zRDllCZyGN/QbSWkr/fswy3W0eB/smgTb
	 gJuFDVVK4ZC8PMR0ZJumVZbJJPHVP96gT67/WB3Pgab4+PkmMUyZmH24NfMYEeklaI
	 ftaph2QaL3HuxGxQZhCqDH9RdjvXrSgsUpQt/fUysY5s5q6gGTs/R8IQVNk7sLcKg0
	 y0O1rner7zyHPM8s7gVuwiB+FMWnDWBrwpQhSluTofiSf4X720Lbb/dyYlT6pXdCxt
	 YCJx/z3n2q04g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 05/10] platform/x86: classmate-laptop: Register ACPI notify
 handlers directly
Date: Mon, 11 May 2026 22:08:22 +0200
Message-ID: <1856277.VLH7GnMWUR@rafael.j.wysocki>
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
platform_driver instead of struct acpi_driver, make it install its ACPI
notify handlers directly instead of using struct acpi_driver .notify()
callbacks.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase

---
 drivers/platform/x86/classmate-laptop.c | 66 +++++++++++++++++++++----
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index bc229771e7ba..8507483b23f9 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -177,8 +177,10 @@ static acpi_status cmpc_get_accel_v4(acpi_handle handle,
 	return status;
 }
 
-static void cmpc_accel_handler_v4(struct acpi_device *dev, u32 event)
+static void cmpc_accel_handler_v4(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
+
 	if (event == 0x81) {
 		int16_t x, y, z;
 		acpi_status status;
@@ -424,10 +426,17 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 	if (error)
 		goto failed_g_select;
 
+	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+						cmpc_accel_handler_v4, acpi);
+	if (error)
+		goto failed_notify_handler;
+
 	dev_set_drvdata(&inputdev->dev, accel);
 
 	return 0;
 
+failed_notify_handler:
+	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 failed_g_select:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 failed_sensitivity:
@@ -437,6 +446,8 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 {
+	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+				       cmpc_accel_handler_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	cmpc_remove_notify_device(&acpi->dev);
@@ -457,7 +468,6 @@ static struct acpi_driver cmpc_accel_acpi_driver_v4 = {
 	.ops = {
 		.add = cmpc_accel_add_v4,
 		.remove = cmpc_accel_remove_v4,
-		.notify = cmpc_accel_handler_v4,
 	},
 	.drv.pm = &cmpc_accel_pm,
 };
@@ -539,8 +549,10 @@ static acpi_status cmpc_get_accel(acpi_handle handle,
 	return status;
 }
 
-static void cmpc_accel_handler(struct acpi_device *dev, u32 event)
+static void cmpc_accel_handler(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
+
 	if (event == 0x81) {
 		unsigned char x, y, z;
 		acpi_status status;
@@ -663,10 +675,17 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	if (error)
 		goto failed_file;
 
+	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+						cmpc_accel_handler, acpi);
+	if (error)
+		goto failed_notify_handler;
+
 	dev_set_drvdata(&inputdev->dev, accel);
 
 	return 0;
 
+failed_notify_handler:
+	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 failed_file:
 	cmpc_remove_notify_device(&acpi->dev);
 	return error;
@@ -674,6 +693,8 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 
 static void cmpc_accel_remove(struct acpi_device *acpi)
 {
+	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+				       cmpc_accel_handler);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 	cmpc_remove_notify_device(&acpi->dev);
 }
@@ -690,7 +711,6 @@ static struct acpi_driver cmpc_accel_acpi_driver = {
 	.ops = {
 		.add = cmpc_accel_add,
 		.remove = cmpc_accel_remove,
-		.notify = cmpc_accel_handler,
 	}
 };
 
@@ -716,8 +736,9 @@ static acpi_status cmpc_get_tablet(acpi_handle handle,
 	return status;
 }
 
-static void cmpc_tablet_handler(struct acpi_device *dev, u32 event)
+static void cmpc_tablet_handler(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
 	unsigned long long val = 0;
 	struct input_dev *inputdev = dev_get_drvdata(&dev->dev);
 
@@ -746,11 +767,24 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 
 static int cmpc_tablet_add(struct acpi_device *acpi)
 {
-	return cmpc_add_notify_device(&acpi->dev, "cmpc_tablet", cmpc_tablet_idev_init);
+	int error;
+
+	error = cmpc_add_notify_device(&acpi->dev, "cmpc_tablet", cmpc_tablet_idev_init);
+	if (error)
+		return error;
+
+	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+						cmpc_tablet_handler, acpi);
+	if (error)
+		cmpc_remove_notify_device(&acpi->dev);
+
+	return error;
 }
 
 static void cmpc_tablet_remove(struct acpi_device *acpi)
 {
+	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+				       cmpc_tablet_handler);
 	cmpc_remove_notify_device(&acpi->dev);
 }
 
@@ -782,7 +816,6 @@ static struct acpi_driver cmpc_tablet_acpi_driver = {
 	.ops = {
 		.add = cmpc_tablet_add,
 		.remove = cmpc_tablet_remove,
-		.notify = cmpc_tablet_handler,
 	},
 	.drv.pm = &cmpc_tablet_pm,
 };
@@ -1046,8 +1079,9 @@ static int cmpc_keys_codes[] = {
 	KEY_MAX
 };
 
-static void cmpc_keys_handler(struct acpi_device *dev, u32 event)
+static void cmpc_keys_handler(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
 	struct input_dev *inputdev;
 	int code = KEY_MAX;
 
@@ -1069,11 +1103,24 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
 
 static int cmpc_keys_add(struct acpi_device *acpi)
 {
-	return cmpc_add_notify_device(&acpi->dev, "cmpc_keys", cmpc_keys_idev_init);
+	int error;
+
+	error = cmpc_add_notify_device(&acpi->dev, "cmpc_keys", cmpc_keys_idev_init);
+	if (error)
+		return error;
+
+	error = acpi_dev_install_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+						cmpc_keys_handler, acpi);
+	if (error)
+		cmpc_remove_notify_device(&acpi->dev);
+
+	return error;
 }
 
 static void cmpc_keys_remove(struct acpi_device *acpi)
 {
+	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+				       cmpc_keys_handler);
 	cmpc_remove_notify_device(&acpi->dev);
 }
 
@@ -1089,7 +1136,6 @@ static struct acpi_driver cmpc_keys_acpi_driver = {
 	.ops = {
 		.add = cmpc_keys_add,
 		.remove = cmpc_keys_remove,
-		.notify = cmpc_keys_handler,
 	}
 };
 
-- 
2.51.0




