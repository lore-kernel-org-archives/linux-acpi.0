Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4B3AFB0A;
	Tue, 12 May 2026 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595555; cv=none; b=gwB7CzqUQl1Jper4VWA6okurRySaLLj9f6sya0USUmkTnKMwNfqK2Q8Yjw7fF0XhZE4ANxTblMgeyYsaCxKgwAJbpuSgVHxckhqbzMp692vcK50PRdTiB0YT0ymAxXSaQmTzYtu5AVqSiERdp6ZJub8pBd62eq0/vgaq30wXa3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595555; c=relaxed/simple;
	bh=S7Bw079dUK7p08dhks4JZveMAQRlAqspNYw42nFkADU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYTrXsrT+TVIhPpbTgbIx48GVm+dp12vaG175mB9AJnWPITGpbQv0AuLoWOM6u++dp3lAYOvKaAD6fl4rvBkgqKS9/E/FWP8uQb6VT9oKjfxWrvGW4ZE+7AW5xosoqY1JrULYTppeuIY8RVIzTmffcrRdNtl1/HwyzktbEykGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvHNlicp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvHNlicp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D3DC2BCB0;
	Tue, 12 May 2026 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595555;
	bh=S7Bw079dUK7p08dhks4JZveMAQRlAqspNYw42nFkADU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvHNlicpmq/5zgi0Ku6asm0MnjttpFyDj8GtABP9rwjZhTRRys5t+rQjqaN6xBIHb
	 HdEURecbrytw3zHf71KvSBmXIxSw+BNYexLE2eneO9TJm0KeN3apJ1kdZk0kfMAFHF
	 /j07bK7RVINaQuIx86ZGPsX5AnHKlXsAQfGLET/aBLW87+QyJCRnVvzCLn6iiMgFDt
	 QM5Ub0CGT22DY+A3tBR7NeOHf4T8wLpX9QrUqgz0S8/sLI3OsgyF3QrTDr6lOX+SOd
	 cHJ7c6bNpkFAqNc8IbD4eccyNnYQ8fQaty0FMXJnv8/z+RQMN0jT3rq0zWT5Qv2rUe
	 /kpeDgLb8/rTA==
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
 [PATCH v2 03/16] platform/x86: dell/dell-rbtn: Check ACPI_COMPANION() against
 NULL
Date: Tue, 12 May 2026 16:05:07 +0200
Message-ID: <2276487.irdbgypaU6@rafael.j.wysocki>
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
platform/x86 dell-rbtn driver.

Fixes: 19ebacfb442b ("platform/x86: dell/dell-rbtn: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/dell/dell-rbtn.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index 34af9f4ff741..180b8c6720e6 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -396,11 +396,15 @@ static void rbtn_cleanup(struct device *dev)
 
 static int rbtn_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct rbtn_data *rbtn_data;
+	struct acpi_device *device;
 	enum rbtn_type type;
 	int ret = 0;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	type = rbtn_check(device);
 	if (type == RBTN_UNKNOWN) {
 		dev_info(&pdev->dev, "Unknown device type\n");
-- 
2.51.0




