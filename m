Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2D3AF670;
	Tue, 12 May 2026 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595546; cv=none; b=U4Szeo2f7jwdslBHBPvL8GmLvgGSGLaFlxYQMbybQLsnc+V6vKcsb1eoeN+XD4Xwmw4Ljz+4NXQWBTgj9v19wzzSaVCSqqsMzoX23Wgcljv2esc0fTf6wYyFFBCzCS/Z4rozSa8Vmmxq52KtOQ5akHPLIBzPaBdlEzJySrvFOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595546; c=relaxed/simple;
	bh=pWAO+Hq8b4fSfixEJydrF3TT/8WHEagGoUmQlHh584I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfwnGdfUMntp3HmchtIU3CiAUs/Z4lSU1Cx4NZ5F/jnu/Vog8Q89vsYWT7UtTS7qx0CmJ0TgQFPo6nGFtcrEOPEyr5SoLAV3ZiTyQluSHWa4hKoA4Kiz79MuCiOtVkxJFTBDPUNA8/L8gbK4LtWugnA+cR7qsoGwThu4AEpiks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0lQfrtF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0lQfrtF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3E2C2BCB0;
	Tue, 12 May 2026 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595545;
	bh=pWAO+Hq8b4fSfixEJydrF3TT/8WHEagGoUmQlHh584I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0lQfrtFeifQV7dTPxgyiZcglXS3mxq0fWMW9V9QQe+MnHK7B6mxu4MAcG4zbW2Rg
	 j08HCei86McNK9viDpBm84zg0SrcUjcM89Fh/1PjEHIrR3vb5xM8cR2uQbWvRg+54u
	 B+XgXbOUNBT0nUCAIEM9rKPDoc6E1QLnk5O2Fj91G9kZMAbHvbL5riAAdn5NSdabZk
	 xkqmawbQsk6eFReNW9wN1CrjhynUX14ZzqmmtNtFxGQ40p7LT2YewqUAVAhwLcT5SZ
	 tdqVD1R1WmUDUWVNh0HbLXmhn+p2+k1ii1Ww82CKVLsYqsZ7pXk1uc0c6Jyb8O/1N7
	 YlXJSmeSP/icw==
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
 [PATCH v2 05/16] platform/x86: fujitsu: Check ACPI_COMPANION() against NULL
Date: Tue, 12 May 2026 16:08:58 +0200
Message-ID: <3430329.44csPzL39Z@rafael.j.wysocki>
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
platform/x86 fujitsu-laptop driver.

Fixes: 6da22b031a3c ("platform/x86: fujitsu: Convert laptop driver to a platform one")
Fixes: d5c9212ccfaa ("platform/x86: fujitsu: Convert backlight driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jonathan Woithe <jwoithe@just42.net>
---
 drivers/platform/x86/fujitsu-laptop.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 2e265be2267e..54d0b9cec4d3 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -530,10 +530,14 @@ static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void *data)
 
 static int acpi_fujitsu_bl_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	struct fujitsu_bl *priv;
 	int ret;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return -ENODEV;
 
@@ -993,10 +997,14 @@ static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data
 
 static int acpi_fujitsu_laptop_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct fujitsu_laptop *priv;
+	struct acpi_device *device;
 	int ret, i = 0;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.51.0




