Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A83806D9;
	Mon, 11 May 2026 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530571; cv=none; b=oumDJ8FfbuzrcGkN5MIw8qpr23U4/TbvZtLygUrWAdXxtLMjIrdvr/1W+YK6mKR9jY0b0NUwbeYArNWgEZ9yI+etQRZPRg7VeyURgyVTxszBm3iDF6qQDBkUkLQU2hawiGk2ow2DB1YNQSiY60jxm0NEuo7e+IFZfjRpm9BS84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530571; c=relaxed/simple;
	bh=AK81KBqbkzwdNsm0t0V+pgvx0Qw9IgSNQtUVRyjCI+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4G9vochD8yYrTINH0kwowsphUC/cuwIqoWTyD+iulRx7UHtr4/AVxFHAtTczkTid23Ui2aQavb3SQlaAoYMM0ZuQH+xTozprDfX9KTS/ybkNWBdo/wqDaoqtjHxb+fDQJaE86+naAubGBUPpsBCEoHA8+15BI7QhgGHoHln9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlW8a/eF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlW8a/eF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1246AC2BCB0;
	Mon, 11 May 2026 20:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530571;
	bh=AK81KBqbkzwdNsm0t0V+pgvx0Qw9IgSNQtUVRyjCI+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlW8a/eFQhacPBNpUsgVoUQ1cNWSLnppyGWkexF5pbuNcLpjvaa0zBu9G7AaobkF4
	 1ol5qTwIlMdhjfUGLbeC+Kj2npUVDO85arL2TqGgMv2AC56aiLOQGwCCs4E8TzV3TQ
	 9BetcrXi6rA7Nw45wMbU1G59l0CKICsRsc6bbPALU6iQB7nWtPdr4NpOXoueRCx22G
	 kq07U4iUip4+TePcbOzV2U21HqV+3hIQ5UU+Y9bjALi8OcN0no5kAM3qpdBtdHG9d6
	 vawg7BugBTzZu1ZNe4yiZnkzr/5fXObAO17GScdb+e6ppGLS6rIONrNZ3HSV1LWeDP
	 ngp7pSD+xb9Mg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v2 01/10] platform/x86: classmate-laptop: Address memory leaks on
 driver removal
Date: Mon, 11 May 2026 22:03:34 +0200
Message-ID: <10846403.nUPlyArG6x@rafael.j.wysocki>
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

Switch over cmpc_accel_add_v4() and cmpc_accel_add() to using
devm_kzalloc() for allocating the accel object which will cause it
to be freed automatically on device removal, so it won't be leaked
any more.

This also simplifies the rollback paths in these functions somewhat.

Fixes: 529aa8cb0a59 ("classmate-laptop: add support for Classmate PC ACPI devices")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Use devm_kzalloc() for allocating memory at probe time instead of adding
     kfree() calls to remove callbacks.

---
 drivers/platform/x86/classmate-laptop.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index e6eed3d65580..a5fe34211afb 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -400,7 +400,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 	struct input_dev *inputdev;
 	struct cmpc_accel *accel;
 
-	accel = kmalloc_obj(*accel);
+	accel = devm_kzalloc(&acpi->dev, sizeof(*accel), GFP_KERNEL);
 	if (!accel)
 		return -ENOMEM;
 
@@ -411,7 +411,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 	error = device_create_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	if (error)
-		goto failed_sensitivity;
+		return error;
 
 	accel->g_select = CMPC_ACCEL_G_SELECT_DEFAULT;
 	cmpc_accel_set_g_select_v4(acpi->handle, accel->g_select);
@@ -434,8 +434,6 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 failed_g_select:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
-failed_sensitivity:
-	kfree(accel);
 	return error;
 }
 
@@ -650,7 +648,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	struct input_dev *inputdev;
 	struct cmpc_accel *accel;
 
-	accel = kmalloc_obj(*accel);
+	accel = devm_kzalloc(&acpi->dev, sizeof(*accel), GFP_KERNEL);
 	if (!accel)
 		return -ENOMEM;
 
@@ -659,7 +657,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 
 	error = device_create_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 	if (error)
-		goto failed_file;
+		return error;
 
 	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel",
 					    cmpc_accel_idev_init);
@@ -673,8 +671,6 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 
 failed_input:
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
-failed_file:
-	kfree(accel);
 	return error;
 }
 



