Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25A2D97B7;
	Thu, 12 Mar 2026 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326084; cv=none; b=lDxcQan5axDB6GFlN32GowcoKLBTXgnfZ8vVuEA5QuuXDCPzsiP6BAmiPVv2H8YfMFjD5T0cSn7AGFRqkd/HeHLRtQeKnEFsOEwii7oGxKLrSA2R9ZyUcCGtcY0lA0M2c20aPXagNnkY206F2yl/TjXx8QXwtKiBFcX6QCcgJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326084; c=relaxed/simple;
	bh=ZHKHJ6EDimttyPUUTBD0APBfpx4rVO/JOG/dJKuqfgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLtLFmziwTba/hAcsrY2uMUQ8Cyrjfispaf/T0aIHzb+6XA8GaDsDU7zzRnxovjvZn29Q1VdzSMqDaU9yDTMjl0J8farMjVbHQRXC19dCv8Qc0S/ftckHRyve6hkqRkPX8ly7JWL4ogp+7zLa/5EEyBircl5n9jyykOUo3fIH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYul3Z+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYul3Z+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613B9C2BC86;
	Thu, 12 Mar 2026 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773326084;
	bh=ZHKHJ6EDimttyPUUTBD0APBfpx4rVO/JOG/dJKuqfgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYul3Z+muOj2mQ7wZkGK/JDg2F/7uisn+Yk+xd4WVSHvb01q0pFKJMb/llC1lxjQ8
	 XtGPQ+O7CeW6so562j3N9R7hZ7dhNDYpXq4TD2Ji1JYOv4OXanEcYCJNdwjbqGTBo1
	 gBrKZPVwj1i0mWakrHMGGy8VfM54hQppSmuIzM68yHx3Zluh3H4MyhNk5Sd6QIiQ/e
	 IlvMGs+iHcWn0g4kNcaGBscWaimhTN6XmFpIZmw2f1IMlTiVOXLGIZmoFVkrwJTVD2
	 HIKT5gderKwmhrZ5WozNXtH+kPwJ1ikIRosMaS4JJ+TadRsXSbG4ZQ/1FwZP7GnvRx
	 MKGQiUPeEqD7w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Herton Ronaldo Krzesinski <herton@canonical.com>
Subject:
 [PATCH v1 1/2] platform/x86: topstar-laptop: Register ACPI notify handler
 directly
Date: Thu, 12 Mar 2026 15:32:36 +0100
Message-ID: <3425557.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3053187.e9J7NaK4W3@rafael.j.wysocki>
References: <3053187.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/topstar-laptop.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index a7b4b6c8e549..695ec1d25bcd 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -232,9 +232,9 @@ static int topstar_acpi_fncx_switch(struct acpi_device *device, bool state)
 	return 0;
 }
 
-static void topstar_acpi_notify(struct acpi_device *device, u32 event)
+static void topstar_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct topstar_laptop *topstar = acpi_driver_data(device);
+	struct topstar_laptop *topstar = data;
 	static bool dup_evnt[2];
 	bool *dup;
 
@@ -313,14 +313,21 @@ static int topstar_acpi_add(struct acpi_device *device)
 	if (err)
 		goto err_platform_exit;
 
+	err = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					      topstar_acpi_notify, topstar);
+	if (err)
+		goto err_input_exit;
+
 	if (led_workaround) {
 		err = topstar_led_init(topstar);
 		if (err)
-			goto err_input_exit;
+			goto err_notify_handler_exit;
 	}
 
 	return 0;
 
+err_notify_handler_exit:
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
 err_input_exit:
 	topstar_input_exit(topstar);
 err_platform_exit:
@@ -339,6 +346,7 @@ static void topstar_acpi_remove(struct acpi_device *device)
 	if (led_workaround)
 		topstar_led_exit(topstar);
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, topstar_acpi_notify);
 	topstar_input_exit(topstar);
 	topstar_platform_exit(topstar);
 	topstar_acpi_exit(topstar);
@@ -360,7 +368,6 @@ static struct acpi_driver topstar_acpi_driver = {
 	.ops = {
 		.add = topstar_acpi_add,
 		.remove = topstar_acpi_remove,
-		.notify = topstar_acpi_notify,
 	},
 };
 
-- 
2.51.0




