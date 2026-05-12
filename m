Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACE3ABD91;
	Tue, 12 May 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595517; cv=none; b=RMpHXTOJINpruNUyUPFUDp2Miz6Xw1oj7rcxiwi6/tFfy7W0UE/4qb380LzlmZ4HdW4FSOnKZ7Jop0nugiqcCewB6QFrac7KP9ZYqrh4VRlnkaJHsP3t8USKRUTYvWiU26qWHUFEVj2h6XJLUCQ/7YyFK1TkbkIlPR10TybWioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595517; c=relaxed/simple;
	bh=t7PNP21lIAiFfq+kGKW8cuDJZtoV4Hw8IcS+VciYa8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2v++e5nyq1sOG0pSv9DW3qz9/a6H0N+jBwePd4tIjNH/QYmiIyRFj1euG0LIPLBXCLFTf6cQS1kzpz3K6cVh/iSV5NI+yE3nX/4Vgkq7jkDnerYYtyxqW3aBGSYlS7sB75+JWspVe6SzvwUZItsoHwDpKCmzJt7BMgxdD5V3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA9xpgHk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA9xpgHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534A8C2BCF7;
	Tue, 12 May 2026 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595517;
	bh=t7PNP21lIAiFfq+kGKW8cuDJZtoV4Hw8IcS+VciYa8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA9xpgHk3rTtZstWTYDvmiG1rjwhycuXrGwzCyEIvAQZ9pDzqr36E13WRTE1wCGPB
	 5V06T8JAIgu0Qz+hDTPKmeNjInlhVZvH9QTcx75Y+YL0FQFd/VJJ9bti6oIxoUCq1f
	 SF9IDGljO5/ASoqd2eRdIy+CUVczifspJvzbBCebpVkKLXu+ySEyBWG+Vc0RCQeBih
	 71h+0H+OeyW6/cIaWgkuvmNb1bfjc0/wSDBHFVKNyrspMjD9qg8wsb9FVxnIvWq37n
	 O96pKk9Yg9bhcdX1MeomcKWM3fcqxNq3C08EuLq9tEVHMA7tVhQs4KBAmeOkhqOgMz
	 k5o/ZIS0VrKCQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <denis.benato@linux.dev>,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>,
 Matan Ziv-Av <matan@svgalib.org>, Kenneth Chan <kenneth.t.chan@gmail.com>,
 Mattia Dongili <malattia@linux.it>, Jeremy Soller <jeremy@system76.com>,
 Azael Avalos <coproscefalo@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v2 11/16] platform/x86: sony-laptop: Check ACPI_COMPANION() against
 NULL
Date: Tue, 12 May 2026 16:13:59 +0200
Message-ID: <1871155.VLH7GnMWUR@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12904885.O9o76ZdvQC@rafael.j.wysocki>
References: <12904885.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add requisite ACPI_COMPANION() checks against NULL to the
platform/x86 sony-laptop driver.

Fixes: 138db7ee58c0 ("platform/x86: sony-laptop: Convert PIC driver to a platform one")
Fixes: 14004dd31caa ("platform/x86: sony-laptop: Convert NC driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/sony-laptop.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index b18f00e9082f..67370967df6f 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -3147,11 +3147,15 @@ static void sony_nc_backlight_cleanup(void)
 
 static int sony_nc_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	acpi_status status;
 	int result = 0;
 	struct sony_nc_value *item;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	sony_nc_acpi_device = device;
 	strscpy(acpi_device_class(device), "sony/hotkey");
 
@@ -4509,11 +4513,15 @@ static void sony_pic_remove(struct platform_device *pdev)
 
 static int sony_pic_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct sony_pic_ioport *io, *tmp_io;
 	struct sony_pic_irq *irq, *tmp_irq;
+	struct acpi_device *device;
 	int result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	spic_dev.acpi_dev = device;
 	strscpy(acpi_device_class(device), "sony/hotkey");
 	sony_pic_detect_device_type(&spic_dev);
-- 
2.51.0




