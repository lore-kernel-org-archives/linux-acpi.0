Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975231F988;
	Thu,  7 May 2026 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184907; cv=none; b=TTb8chujThOZQKTDB3ZKYEbmMOGBlHSXyMdZrJK7uKPZuV9XyiK45lCOQlLg7/xOegfRjxeZYLY9RJ0O5T2gOp21A4waWjy6pqOGpIknf8wahIfYl6sYXXoZHzbUuEZfjYQ4XfD5Vqi3kCJtTh3JONyyDeEpNvVkdLaPBCgjAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184907; c=relaxed/simple;
	bh=QPpPCV/UM70IYlcTkVzRfWkdYi9kUkYT+2x/MYa/3Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrXnGnged0T9jfWfPHf9J4hiTX0BPkN2BqeM4wFrWNr7HdQffk9pLnW2AcxY7J0S5n6yTPCwim0W1mNov/qNo7S5ZKmxa9rIcYl6u2FR02dxJXQ+ykVtXEb/MSJKg+ZGL/eVOMPP1jjoBYxbq1gAVhXbjndL82gI4mrwkKeUOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzIQYA9V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzIQYA9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E8CC2BCC9;
	Thu,  7 May 2026 20:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778184907;
	bh=QPpPCV/UM70IYlcTkVzRfWkdYi9kUkYT+2x/MYa/3Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzIQYA9VPG2kONwjbZtzKO05lgSMDDWXeTFkaH8Z6Pq3n+LWJS0tDMbvjOMZv5caM
	 m7XfOFIec9eiILAXZhJrwidH1gQ6/ixHx1Y4MsfodE6SZw/7GDG9KCuFlEfTzpO502
	 ttltYxMa6TVF8G8eWzHAPZiqxQaAsGNvof+Gxo3lto4fC+u+VDq+5BghSYb/1SrMlJ
	 0F8CkndyhFizF+1cHKIth+tjNaI2A9/e5+sTdHYkhgg/iYf0HlAZdFlcIfu5ZgkvEK
	 gwzRsJ2mKc13PZVCsj32Z1tja3JOyTJSdkzKcVm+zaRf9DjQ8aBlKuUFDXec+vl9id
	 s8YDUDyljwd+A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1 02/10] platform/x86: classmate-laptop: Unify probe rollback and
 remove code
Date: Thu, 07 May 2026 22:01:16 +0200
Message-ID: <3410625.aeNJFYEL58@rafael.j.wysocki>
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

To facilitate subsequent modifications, change code ordering in
cmpc_accel_add_v4(), cmpc_accel_add(), and  cmpc_accel_remove_v4()
so that the ordering of the probe rollback code is the same as the
ordering of the corresponding removal code.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/classmate-laptop.c | 36 +++++++++++++------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 218834ddddc3..bc5df682d194 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -406,6 +406,13 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 	accel->inputdev_state = CMPC_ACCEL_DEV_STATE_CLOSED;
 
+	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel_v4",
+					    cmpc_accel_idev_init_v4);
+	if (error)
+		goto failed_input;
+
+	inputdev = dev_get_drvdata(&acpi->dev);
+
 	accel->sensitivity = CMPC_ACCEL_SENSITIVITY_DEFAULT;
 	cmpc_accel_set_sensitivity_v4(acpi->handle, accel->sensitivity);
 
@@ -420,21 +427,15 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
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
 failed_sensitivity:
+	cmpc_remove_acpi_notify_device(acpi);
+failed_input:
 	kfree(accel);
 	return error;
 }
@@ -444,8 +445,8 @@ static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 	struct input_dev *inputdev = dev_get_drvdata(&acpi->dev);
 	struct cmpc_accel *accel = dev_get_drvdata(&inputdev->dev);
 
-	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
+	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	cmpc_remove_acpi_notify_device(acpi);
 	kfree(accel);
 }
@@ -658,6 +659,13 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	if (!accel)
 		return -ENOMEM;
 
+	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel",
+					    cmpc_accel_idev_init);
+	if (error)
+		goto failed_input;
+
+	inputdev = dev_get_drvdata(&acpi->dev);
+
 	accel->sensitivity = CMPC_ACCEL_SENSITIVITY_DEFAULT;
 	cmpc_accel_set_sensitivity(acpi->handle, accel->sensitivity);
 
@@ -665,19 +673,13 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	if (error)
 		goto failed_file;
 
-	error = cmpc_add_acpi_notify_device(acpi, "cmpc_accel",
-					    cmpc_accel_idev_init);
-	if (error)
-		goto failed_input;
-
-	inputdev = dev_get_drvdata(&acpi->dev);
 	dev_set_drvdata(&inputdev->dev, accel);
 
 	return 0;
 
-failed_input:
-	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 failed_file:
+	cmpc_remove_acpi_notify_device(acpi);
+failed_input:
 	kfree(accel);
 	return error;
 }



