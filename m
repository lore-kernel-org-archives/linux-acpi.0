Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94483AFAF4;
	Tue, 12 May 2026 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595526; cv=none; b=Xv7Jx3qmm/3vv+ASvhFsBHisNGgcXg9AJYou9w8R5rEYlXzC/+uYoRsEwJF6dG+Qjx6vwoOst2yPRmHvrJMUPlpTE3oOb0ARzlUQx1FF3ss5VzCL2qFdOj+9YIQXwzW8oYwI/8P62twM8HZPtIIcoV/K6AqTbm4ILcXwzzrC/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595526; c=relaxed/simple;
	bh=uf9DS2HbQDByZPHjb+Xk+7pcu5vyx78kmtGEQDSm32A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJqgCLQlsVI9cKcAOunJSsZ3M2fnbIVhoPfB0p9ta4GhQ0xFiPwdReJaQv1XwyD2sHGggH2QmTlHLvsNeC8liCJxzRjKiq0bt2La6NGD3FAPwvhx3efBfpzLcVxrrUolgnePd5S0adImtjmUBh6A+yDUk8OMUdxZ2KaJ6hn8g5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUe7oBcC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUe7oBcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6DFC2BCF5;
	Tue, 12 May 2026 14:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595526;
	bh=uf9DS2HbQDByZPHjb+Xk+7pcu5vyx78kmtGEQDSm32A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUe7oBcC+MCJ6z2L1Nrl20tQp7FeSkZAaJYcuTQUiHwYqlPOY0673eou4ZRM2uvsC
	 dpw/evtPMXY8khjf1VwHiybq4im9MGEpqUKUV0Y89fO7SLWVzrOKTSSUj0veXeD12o
	 Ipx8B+xUnegzojE7N81txdZwEp8LfQemyP5RZ6Uro9Oqzw7mgl2qQ28BPwu7SVjbG9
	 z+iMfIQBDQJOKc/aYBVfKL6cr3ANmEhECigerYwH43ujgMrwNlp/P+FCeJDbPmCHRN
	 e+JJyqIdHSR9PcBoWwgwIHviTHmVxqMl+Jkj6MPk6OM8azk89BRmOATCKFQ/fXNJHg
	 1IyjG9gY7IqzQ==
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
 [PATCH v2 09/16] platform/x86: lg-laptop: Check ACPI_COMPANION() against NULL
Date: Tue, 12 May 2026 16:12:27 +0200
Message-ID: <3706551.iIbC2pHGDl@rafael.j.wysocki>
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

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
platform/x86 lg-laptop driver.

Fixes: 2d9cb20610f7 ("platform/x86: lg-laptop: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/lg-laptop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 9681412d694b..a8f2f465ef3f 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -761,12 +761,11 @@ static void lg_laptop_remove_address_space_handler(void *data)
 
 static int acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct platform_device_info pdev_info = {
-		.fwnode = acpi_fwnode_handle(device),
 		.name = PLATFORM_NAME,
 		.id = PLATFORM_DEVID_NONE,
 	};
+	struct acpi_device *device;
 	acpi_status status;
 	int ret;
 	const char *product;
@@ -775,6 +774,12 @@ static int acpi_probe(struct platform_device *pdev)
 	if (pf_device)
 		return 0;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
+	pdev_info.fwnode = acpi_fwnode_handle(device),
+
 	status = acpi_install_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,
 						    &lg_laptop_address_space_handler,
 						    NULL, &pdev->dev);
-- 
2.51.0




