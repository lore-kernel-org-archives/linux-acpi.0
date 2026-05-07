Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F6372EFA;
	Thu,  7 May 2026 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184894; cv=none; b=PvmML5FTQPsOcrRyWuzUCbmT9mQVxbQUdNnryQ7s3aghICCTP0nhFpP78QNfdsEO5jlVC6xqT7XlAzpanx3xmYZ7vRYsgkW0LVOoG94gITMVDdS2SOQxjVRIv0/l6iyvV6SOYOAXSq1udHq4lIZtqF5dCBEwv1p9N6IqX6P+m8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184894; c=relaxed/simple;
	bh=YnINZozjukJ4yXx2Kdm5hCgRyRLhQaT+jtOfY8JOspc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lckCpnCzQ6Sgj6vOX59VY6DF0HlSoI63Tbn146CiniCFUPjqLxw0DhaAHj8YGnz+x5MXyhqzd2w+DfsXiMbICvj3EH1gqtS2/qfne1wEf9hxDfvP8uS4SSeZenBRaZwczSVrqLKqzyMBBhAH8/9Tgtw/W21cm4hCN5Jvf4mKXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn3jFZtM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn3jFZtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F8DC2BCB8;
	Thu,  7 May 2026 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778184894;
	bh=YnINZozjukJ4yXx2Kdm5hCgRyRLhQaT+jtOfY8JOspc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fn3jFZtMIPxwfdqQir4+YWQYeI/s8Y/e0Hc/EercMhyuxGHS7IVXjH6QfuoE3ksAZ
	 u0qs8OlYeIFUpkgyIE6/TqsgSww09mqO4eadec3uw5aU8XB8zgXVAbJ+z1QQAX9Ga3
	 kC6vBSzcbRZ80el7LEkFz05ZSQthuC6eTxMTr54XCjIWbjU62rum15NypBu5RW3fYI
	 JZRvXywKmw1cP8z6oF1BgpNSic4a4CzP9j1ufMq+DPtf4EVwkKYwvvF2KW1/QzxWj+
	 RaSLa1DCr/sTzwyZZ40pEpsowD/1Hm766k0Dv/Pe/JOkKkx5JsgUJoau20e6RMHlK9
	 6Q2Ag/4V4OXRA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1 05/10] platform/x86: classmate-laptop: Register ACPI notify
 handlers directly
Date: Thu, 07 May 2026 22:07:37 +0200
Message-ID: <3693322.iIbC2pHGDl@rafael.j.wysocki>
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

To facilitate subsequent conversions of classmate-laptop driver
subdrivers to using struct platform_driver instead of struct
acpi_driver, make them install their ACPI notify handlers directly
instead of using .notify() callbacks in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/classmate-laptop.c | 66 +++++++++++++++++++++----
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index bb575ae2bc89..938014c0e613 100644
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
@@ -442,6 +451,8 @@ static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 	struct input_dev *inputdev = dev_get_drvdata(&acpi->dev);
 	struct cmpc_accel *accel = dev_get_drvdata(&inputdev->dev);
 
+	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+				       cmpc_accel_handler_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	cmpc_remove_notify_device(&acpi->dev);
@@ -463,7 +474,6 @@ static struct acpi_driver cmpc_accel_acpi_driver_v4 = {
 	.ops = {
 		.add = cmpc_accel_add_v4,
 		.remove = cmpc_accel_remove_v4,
-		.notify = cmpc_accel_handler_v4,
 	},
 	.drv.pm = &cmpc_accel_pm,
 };
@@ -545,8 +555,10 @@ static acpi_status cmpc_get_accel(acpi_handle handle,
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
@@ -669,10 +681,17 @@ static int cmpc_accel_add(struct acpi_device *acpi)
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
 failed_input:
@@ -685,6 +704,8 @@ static void cmpc_accel_remove(struct acpi_device *acpi)
 	struct input_dev *inputdev = dev_get_drvdata(&acpi->dev);
 	struct cmpc_accel *accel = dev_get_drvdata(&inputdev->dev);
 
+	acpi_dev_remove_notify_handler(acpi, ACPI_DEVICE_NOTIFY,
+				       cmpc_accel_handler);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 	cmpc_remove_notify_device(&acpi->dev);
 	kfree(accel);
@@ -702,7 +723,6 @@ static struct acpi_driver cmpc_accel_acpi_driver = {
 	.ops = {
 		.add = cmpc_accel_add,
 		.remove = cmpc_accel_remove,
-		.notify = cmpc_accel_handler,
 	}
 };
 
@@ -728,8 +748,9 @@ static acpi_status cmpc_get_tablet(acpi_handle handle,
 	return status;
 }
 
-static void cmpc_tablet_handler(struct acpi_device *dev, u32 event)
+static void cmpc_tablet_handler(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
 	unsigned long long val = 0;
 	struct input_dev *inputdev = dev_get_drvdata(&dev->dev);
 
@@ -758,11 +779,24 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 
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
 
@@ -794,7 +828,6 @@ static struct acpi_driver cmpc_tablet_acpi_driver = {
 	.ops = {
 		.add = cmpc_tablet_add,
 		.remove = cmpc_tablet_remove,
-		.notify = cmpc_tablet_handler,
 	},
 	.drv.pm = &cmpc_tablet_pm,
 };
@@ -1058,8 +1091,9 @@ static int cmpc_keys_codes[] = {
 	KEY_MAX
 };
 
-static void cmpc_keys_handler(struct acpi_device *dev, u32 event)
+static void cmpc_keys_handler(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
 	struct input_dev *inputdev;
 	int code = KEY_MAX;
 
@@ -1081,11 +1115,24 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
 
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
 
@@ -1101,7 +1148,6 @@ static struct acpi_driver cmpc_keys_acpi_driver = {
 	.ops = {
 		.add = cmpc_keys_add,
 		.remove = cmpc_keys_remove,
-		.notify = cmpc_keys_handler,
 	}
 };
 



