Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC653AFB06;
	Tue, 12 May 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595512; cv=none; b=PrViZHG5eTqe1rdqPxe5sRgz9NygdZcqLPSco+Blr47sYabp+b7PmLl87Fu9bcddkRY2x8l+w3z717TA+e/bC1CUfN/376opjgphZO3cPT8mmHwVd3KkfQHmWP/L9WJek671Z6Wp1Xi0szFaseuyPm4CzypRMusQL4zVFMmbtvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595512; c=relaxed/simple;
	bh=//c9zye5TzctZyA2/XixKbu53QHkacJyoz+2yhZdPB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgHp4P1XfztCA6ivmZTL6uh4df1jIKooFYR443XF+wrYotyYlukZGhqgBWGFBMcTxvvwZQPzd6CqY48PaifO0ST2nwLZp0/yz+TNbHHA+DM2U8mALmG/NQnlaGflQZU5AXWOlMyDlRE57CshjJXTJppz8nBg1q8QeqhES2h05t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB6lE0Q9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB6lE0Q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C40C2BCF6;
	Tue, 12 May 2026 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595512;
	bh=//c9zye5TzctZyA2/XixKbu53QHkacJyoz+2yhZdPB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DB6lE0Q9BXNN7LiO2N2JUADdfueVocFD2iAryNiIQvMAwPym64p36Myuhl9VVXgr3
	 Q6Sv5O7Hy3bdmrGg5ULp/btkZ/oihbyRMZNu1BkSMW5Kruj+RY/HgLUUID2KlBaLW4
	 TkvoY97avF4phdsGNL0MjJV3yB2YBeP+PS9MeIMloLPjpwy2k0wI0+LdDBFcDZoGsi
	 dv5RQVxInF01fKlkNMq0Dz7Vr6Ukvmor4nE6OqBFFiwmMmlSAUzKdBUl+FACNM4ABw
	 3M/hxI6yl4S2gOjtYKEfTiwGJ8sF873JcgPxS5ZDKaMxHrwu40qVtdB97bPkUqRgXy
	 F1JuIqgZwcfIQ==
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
 [PATCH v2 12/16] platform/x86: system76: Check ACPI_COMPANION() against NULL
Date: Tue, 12 May 2026 16:14:43 +0200
Message-ID: <2072699.usQuhbGJ8B@rafael.j.wysocki>
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
platform/x86 system76 driver.

Fixes: 80b8f68b94ab ("platform/x86: system76: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/system76_acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 693cbb461382..dd7b1b07c316 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -674,10 +674,14 @@ static void system76_notify(acpi_handle handle, u32 event, void *context)
 // Probe a System76 platform device
 static int system76_probe(struct platform_device *pdev)
 {
-	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *acpi_dev;
 	struct system76_data *data;
 	int err;
 
+	acpi_dev = ACPI_COMPANION(&pdev->dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
2.51.0




