Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25C3C3456;
	Fri,  3 Jul 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078744; cv=none; b=qW9xD0qyuvV6PTdW70Ly7CIrwF2PpBzkYXay4rJwEhgplfetzqjT9620gS2jpuuWpZuj3Vhj77Lc8RB/DAD5AKIKcWNZbMXvAr9WwxQtap8JhE2h+84KvMDzh7xQY/3DqPkwpxVRlveiYuMzOYzOigi4sGyipo/89L4kQ2LYGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078744; c=relaxed/simple;
	bh=24nHoMeDnM+SI1pgPp8ZRR8O6Xsi9MD3ngM2Irq61nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T594s96enO9r+5zQSHo82wWPEekgrFdWR1u51SYbFWzH+6m1kvUhvpwFuK2nErxKFdhsCvo8x9C8nOUq51J2nLiiPsaOEI/9c9VKlTGHbjerJy38BKe1xEDjV+2zmavq94mLyFNZ4oTMs1YyWfQ4naUmmoGxCyw7f7dU+XYudtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkBw8nvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkBw8nvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8441F000E9;
	Fri,  3 Jul 2026 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078743;
	bh=4/m3rEKA3k6NSZLpTDcyUpVh3VOoXQBgioiPrw6lREY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YkBw8nvGqNKvCdnNBIeQ0V63bFWv7j1mUtXVKZySvZLlEyqeBuazIbCLayFKzeTez
	 7flEE9L9AysiHmLzBL+0eO5n82HCz8O93UGchjCBWo54i5zkRy1j15o0AMFRQQJaRn
	 wsrCzB9w8Qweq8jv5sdJHNrHFOUXra6we5qqbQjHwnWHpXuvTkRG/Ihy1FnhnxAuAP
	 /3ryPxvVBkMdslSDOYD+/r5/E9XeGLrZU/l21eThcCH9aKiIqzZC69whFUlB07LMpK
	 peu8RdIgO2Uf+S2ugUTgljb5M635S88ax2oDNdGnPafVVksixse2N9TEZXiHaSP7SJ
	 pf/YM5WMmEF6g==
From: "Rafael J.  Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <denis.benato@linux.dev>, Jonathan Woithe <jwoithe@just42.net>,
 Robert Gerlach <khnz@gmx.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, Mattia Dongili <malattia@linux.it>,
 Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 03/10] platform/x86: fujitsu-laptop: Stop setting
 acpi_device_name/class()
Date: Fri, 03 Jul 2026 13:23:31 +0200
Message-ID: <3441919.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5135166.31r3eYUQgx@rafael.j.wysocki>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The driver sets acpi_device_name() that are only used for printing
messages and initializing input class device names.  Since
ACPI_FUJITSU_BL_DEVICE_NAME and ACPI_FUJITSU_LAPTOP_DEVICE_NAME can
be used directly in all of those cases, make the driver do so and
stop setting acpi_device_name() in it.

Likewise, acpi_device_class() set by the driver are never read
afterward, so make the driver stop setting it and drop the symbol
defined specifically for this purpose.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/fujitsu-laptop.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 54d0b9cec4d3..ea543deef68f 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -56,7 +56,6 @@
 
 #define FUJITSU_LCD_N_LEVELS		8
 
-#define ACPI_FUJITSU_CLASS		"fujitsu"
 #define ACPI_FUJITSU_BL_HID		"FUJ02B1"
 #define ACPI_FUJITSU_BL_DRIVER_NAME	"Fujitsu laptop FUJ02B1 ACPI brightness driver"
 #define ACPI_FUJITSU_BL_DEVICE_NAME	"Fujitsu FUJ02B1"
@@ -466,7 +465,7 @@ static int acpi_fujitsu_bl_input_setup(struct device *dev)
 	snprintf(priv->phys, sizeof(priv->phys), "%s/video/input0",
 		 acpi_device_hid(device));
 
-	priv->input->name = acpi_device_name(device);
+	priv->input->name = ACPI_FUJITSU_BL_DEVICE_NAME;
 	priv->input->phys = priv->phys;
 	priv->input->id.bustype = BUS_HOST;
 	priv->input->id.product = 0x06;
@@ -546,13 +545,11 @@ static int acpi_fujitsu_bl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	fujitsu_bl = priv;
-	strscpy(acpi_device_name(device), ACPI_FUJITSU_BL_DEVICE_NAME);
-	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
 
 	platform_set_drvdata(pdev, priv);
 
-	pr_info("ACPI: %s [%s]\n",
-		acpi_device_name(device), acpi_device_bid(device));
+	pr_info("ACPI: %s [%s]\n", ACPI_FUJITSU_BL_DEVICE_NAME,
+		acpi_device_bid(device));
 
 	if (get_max_brightness(&pdev->dev) <= 0)
 		priv->max_brightness = FUJITSU_LCD_N_LEVELS;
@@ -681,7 +678,7 @@ static int acpi_fujitsu_laptop_input_setup(struct device *dev)
 	snprintf(priv->phys, sizeof(priv->phys), "%s/input0",
 		 acpi_device_hid(device));
 
-	priv->input->name = acpi_device_name(device);
+	priv->input->name = ACPI_FUJITSU_LAPTOP_DEVICE_NAME;
 	priv->input->phys = priv->phys;
 	priv->input->id.bustype = BUS_HOST;
 
@@ -1012,9 +1009,6 @@ static int acpi_fujitsu_laptop_probe(struct platform_device *pdev)
 	WARN_ONCE(fext, "More than one FUJ02E3 ACPI device was found.  Driver may not work as intended.");
 	fext = &pdev->dev;
 
-	strscpy(acpi_device_name(device), ACPI_FUJITSU_LAPTOP_DEVICE_NAME);
-	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
-
 	platform_set_drvdata(pdev, priv);
 
 	/* kfifo */
@@ -1024,8 +1018,8 @@ static int acpi_fujitsu_laptop_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pr_info("ACPI: %s [%s]\n",
-		acpi_device_name(device), acpi_device_bid(device));
+	pr_info("ACPI: %s [%s]\n", ACPI_FUJITSU_LAPTOP_DEVICE_NAME,
+		acpi_device_bid(device));
 
 	while (call_fext_func(fext, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0 &&
 	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE)
-- 
2.51.0




