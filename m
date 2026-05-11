Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53337FF45;
	Mon, 11 May 2026 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530567; cv=none; b=OkkO5DvTL9Dws5z1AmD/eMUL2raprImrsYud1pW6HH+uZraMyXuK+gYFpBfrqbmSgpigFtvViUHqvbx2MiQzyi3x59te2c5Zlm037CnhKABYx8LBsviQMyPzy1nr7nfCMyiMatp/PPeTLIGWz2BwjkRywLpmF9YknP5zpE67KHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530567; c=relaxed/simple;
	bh=rUla0NJJi1NxSsZ0vf+tvUT3cjXbepV+ZJzdGAgPzGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHfJCOAtynfFSyYSfjlUzQxi1omjdJ0/e71fl+kWX8LM+EQUiVHMfkd0lxep7YKPmOMhej2pdn5Vejw8QJEp/C3dMz5kKDoroUW1ly/o3JTzjChiVOS2WtDVJhoc+NwYJyQBzabKpBr+qYtDxXsBxiZ1OX87jzltEKqnJrRm6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9nBXFXn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9nBXFXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D032C2BCF6;
	Mon, 11 May 2026 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530567;
	bh=rUla0NJJi1NxSsZ0vf+tvUT3cjXbepV+ZJzdGAgPzGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9nBXFXnnxkr9SoD4Cp8wmmSoZnRz5Td/CdKUknI1b2e50U1knG7Hd4GzK7NBxS/8
	 9jrRxabyDIpIEgk68YsIxgH0f4YPhpe/Gqua6GT8xLCMHS1OnQL0uNA8P4tN+RFgWR
	 onnByhc5TdDcX+QTRhteAY0D5nX6vj8cgtBLk0gSBCAHFtLdLsr6XwNZiTr718Qzvx
	 Y2PRf4jdkofWoLhJK94q0WVxzxnYKLxwRzhuRq0voIj219OrAiXH486ZqCu8IxDLct
	 4edD0zhhoQRwSYALApHibxb0Ok+el1rqlmWnWzH7o0Btuzd4+qF9VYZgoXuXitkZcg
	 0QgNa5hueJ67w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 02/10] platform/x86: classmate-laptop: Unify probe rollback and
 remove code
Date: Mon, 11 May 2026 22:04:39 +0200
Message-ID: <2036641.PYKUYFuaPT@rafael.j.wysocki>
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

To facilitate subsequent modifications, change code ordering in
cmpc_accel_add_v4(), cmpc_accel_add(), and  cmpc_accel_remove_v4()
so that the ordering of the probe rollback code is the same as the
ordering of the corresponding removal code.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase

---
 drivers/platform/x86/classmate-laptop.c | 40 +++++++++++++------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index a5fe34211afb..d1407a28c1de 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -406,12 +406,19 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 	accel->inputdev_state = CMPC_ACCEL_DEV_STATE_CLOSED;
 
+	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel_v4",
+					    cmpc_accel_idev_init_v4);
+	if (error)
+		return error;
+
+	inputdev = dev_get_drvdata(&acpi->dev);
+
 	accel->sensitivity = CMPC_ACCEL_SENSITIVITY_DEFAULT;
 	cmpc_accel_set_sensitivity_v4(acpi->handle, accel->sensitivity);
 
 	error = device_create_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	if (error)
-		return error;
+		goto failed_sensitivity;
 
 	accel->g_select = CMPC_ACCEL_G_SELECT_DEFAULT;
 	cmpc_accel_set_g_select_v4(acpi->handle, accel->g_select);
@@ -420,27 +427,21 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 	if (error)
 		goto failed_g_select;
 
-	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel_v4",
-					    cmpc_accel_idev_init_v4);
-	if (error)
-		goto failed_input;
-
-	inputdev = dev_get_drvdata(&acpi->dev);
 	dev_set_drvdata(&inputdev->dev, accel);
 
 	return 0;
 
-failed_input:
-	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 failed_g_select:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
+failed_sensitivity:
+	cmpc_remove_acpi_notify_device(acpi);
 	return error;
 }
 
 static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 {
-	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
+	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	cmpc_remove_acpi_notify_device(acpi);
 }
 
@@ -652,25 +653,26 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	if (!accel)
 		return -ENOMEM;
 
+	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel",
+					    cmpc_accel_idev_init);
+	if (error)
+		return error;
+
+	inputdev = dev_get_drvdata(&acpi->dev);
+
 	accel->sensitivity = CMPC_ACCEL_SENSITIVITY_DEFAULT;
 	cmpc_accel_set_sensitivity(acpi->handle, accel->sensitivity);
 
 	error = device_create_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 	if (error)
-		return error;
-
-	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel",
-					    cmpc_accel_idev_init);
-	if (error)
-		goto failed_input;
+		goto failed_file;
 
-	inputdev = dev_get_drvdata(&acpi->dev);
 	dev_set_drvdata(&inputdev->dev, accel);
 
 	return 0;
 
-failed_input:
-	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
+failed_file:
+	cmpc_remove_acpi_notify_device(acpi);
 	return error;
 }
 
-- 
2.51.0




