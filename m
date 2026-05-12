Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAF3AFB01;
	Tue, 12 May 2026 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595522; cv=none; b=MiIxvXCcrd3SFJucmJUC+XULHM9jOiofIk7fxlEVLS+Xw9eO9CR6M4jDdbdw05EXtgUUESYAQXbno72vygYj1I5rMbQU0UNaF27wrkqvoms0Sdv36XfRUHETYMSxPJLuzHtr4+VF5zB0XmGZSSlv7u7GyZgdz1O/O5GEu4uDw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595522; c=relaxed/simple;
	bh=U7k6IrQDCHj0S1fRjuWAWaxTgzck0ioVtXZf9Mz6Vqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEy3TjnzypnYRlgZuNtVwJckQ5DXA5Yp1UjD41VkiIsYyLtbIsFVeowyw92aMNP6QRAXlq5ZQ/FLtEPcCv9lruFyML+rpUqaU3t6qb9QR7LjGwQStbDoEuXclqWbXeeoksKF32jpVvkxcElTizljQOgnBwF8mWrL/ZES9BMMHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVf77GD6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVf77GD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E4BC2BCB0;
	Tue, 12 May 2026 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595521;
	bh=U7k6IrQDCHj0S1fRjuWAWaxTgzck0ioVtXZf9Mz6Vqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVf77GD66k4xOvkSJgeHF5SKxoyeZ2ZIZLjQfmeOupn4QfhbfLAv3PeLUlk5VL3cW
	 QoBuBu9uV0exqsUMuMJd6a5jCXDlWrOS0WzO23DoyAjsxIKi0xjIQRdh5gUhTj3bdv
	 tp2SNeBALLnbcfwdvfakQ46Eau6FCNfkSxAnD+Bj5Zb5uACkRp9dH4M+PAk9Ln96Xx
	 2i2UOXZsUvrjjlsRwg3WHfvokYYcIFrD7kUPT4PSRiQ0kXZu5Bq/Vgxv6rLjW2vBHZ
	 NKMhrWg6a3URcpOB5a82MoeaAZxNzQAM0u2khz28e1X/ZmkIn+6MyB/O1/qDJbGxVk
	 0M2A8exQEfx2Q==
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
 [PATCH v2 10/16] platform/x86: panasonic-laptop: Check ACPI_COMPANION()
 against NULL
Date: Tue, 12 May 2026 16:13:13 +0200
Message-ID: <3353471.5fSG56mABF@rafael.j.wysocki>
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
platform/x86 panasonic-laptop driver.

Fixes: de6837243af0 ("platform/x86: panasonic-laptop: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/panasonic-laptop.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 1337f7c49805..b83113c26f88 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -981,11 +981,15 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 
 static int acpi_pcc_hotkey_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct backlight_properties props;
+	struct acpi_device *device;
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	num_sifr = acpi_pcc_get_sqty(device);
 
 	/*
-- 
2.51.0




