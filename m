Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75589381AEA;
	Mon, 11 May 2026 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530560; cv=none; b=kQor/VGy471d2JjmpT8PEKHpH5L9KkAqQY6bTDYvKnxA8wTGa6QL7Sy7Pe2JEdbDIXS1bLlI1dynSQ5x3BEtgsW46X9uUpcCnTSKknEFuKTbG3cyTTjcPG/V0M0MkY+nmkXck4WM0nlTXDCJacg0eSMJB+i+0f2pWarjpTSQU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530560; c=relaxed/simple;
	bh=kypkexAsgJ7SzZSvBo5lBZUs1K+k9Rz6QFmWNI70fRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTcNdB1dsAXvhPqOQlhXjZzLwxjb2BxJd+sgsBMwTzpRzt8FBH64NQklys9jbSGKvCLtYf3KYaMYSLNgYPdUmXWFgEEZjrCdPjO9w5mLdKfMiYL5AgvEaDEUwPKtkf0A7v8FonsOBQ2/UWCqByRwY8YzzTcbmr4i57lvmlS6n9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlzUuq2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlzUuq2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4635C2BCC9;
	Mon, 11 May 2026 20:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530560;
	bh=kypkexAsgJ7SzZSvBo5lBZUs1K+k9Rz6QFmWNI70fRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SlzUuq2OkqRWoSIDHfoi2ZkW93l00tqQLx3oxk3Wa0IY8iZUARustQpyGI2baSECv
	 D4v90HGvqAPXVtw6a3jL1H2KRZdaYYaMTZ7meT5WVmjz+AayWpGCQAL/56di4+GkQH
	 ILStG9O2xfV9nblRAFIcINOK8eELLCQfioBlzCJbt3KSCJXsJquys8J36uW9oOIPtp
	 Wqz7qX2xJrf3FkRlVH0+jLoECItUmOVzlspudOHJM/LBgLurA3PDXa3npraGEZmNfZ
	 es1jJwjPSZBOgUXqhaB8k45/vMUdz78ADZssWpGpodMFaro6rgdK5mOH7h2SEfikVc
	 eugHAL/KW1E4w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 04/10] platform/x86: classmate-laptop: Rename two helper functions
Date: Mon, 11 May 2026 22:07:31 +0200
Message-ID: <3338539.5fSG56mABF@rafael.j.wysocki>
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

Since cmpc_add_acpi_notify_device() and cmpc_remove_acpi_notify_device()
have been modified to take a plain struct device pointer as the first
argument, then have nothing to do with ACPI in principle, so rename
them to cmpc_add_notify_device() and cmpc_remove_notify_device(),
respectively, and consolidate white space around the call sites of
the former.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase

---
 drivers/platform/x86/classmate-laptop.c | 30 +++++++++++--------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 6521d42f8204..bc229771e7ba 100644
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
 		return error;
 
@@ -432,7 +431,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 failed_g_select:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 failed_sensitivity:
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 	return error;
 }
 
@@ -440,7 +439,7 @@ static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 {
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 }
 
 static SIMPLE_DEV_PM_OPS(cmpc_accel_pm, cmpc_accel_suspend_v4,
@@ -651,8 +650,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	if (!accel)
 		return -ENOMEM;
 
-	error = cmpc_add_acpi_notify_device(&acpi->dev, "cmpc_accel",
-					    cmpc_accel_idev_init);
+	error = cmpc_add_notify_device(&acpi->dev, "cmpc_accel", cmpc_accel_idev_init);
 	if (error)
 		return error;
 
@@ -670,14 +668,14 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	return 0;
 
 failed_file:
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 	return error;
 }
 
 static void cmpc_accel_remove(struct acpi_device *acpi)
 {
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
-	cmpc_remove_acpi_notify_device(&acpi->dev);
+	cmpc_remove_notify_device(&acpi->dev);
 }
 
 static const struct acpi_device_id cmpc_accel_device_ids[] = {
@@ -748,13 +746,12 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 
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
@@ -1072,13 +1069,12 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
 
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
-- 
2.51.0




