Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CA39AD34;
	Tue, 12 May 2026 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595498; cv=none; b=HUkLDmtt3b4524gxKKw1WVw/CrPcFcfQsqAYD2AsP+Jn3rj888ohulQiVFyycRY/LqhlZiCloyXxoA0+6J1+Kx+itMPWeNyGSdD+sBMKiDfQSdukhEPXiBkB/1VyQr5RFLGpze/6LaEo3rO+SmBFY4WOhoXd6+NEd3kAPxCvFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595498; c=relaxed/simple;
	bh=p9MoNJvXvXTdovknxpj8ZG+72O3FvPA5sKLTMO+MyeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeVq9s1E5ZSketHVTIEQF+HUUIYxSe5MjVwwSrBsam9unDwpiRJumDtI4BnLtKLBe78obsYguEeUi0oMdwXN6puXOTp7F75x0YYaZ4ROBCeJQj9V5t8xhIqs7OeUaCCWy71pRNV1HkplYafdswiybpkpbdVQCwXYf4IjcdPWsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT7pZ61I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT7pZ61I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F021C2BCF5;
	Tue, 12 May 2026 14:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595498;
	bh=p9MoNJvXvXTdovknxpj8ZG+72O3FvPA5sKLTMO+MyeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AT7pZ61Iq0pJy/jtbZEhs+is4SDt4jpFhSVD4k5i3bHYPiKwM2q9kaExoMoA3lk7n
	 iot1vhbyCm7ueDQIv4u0N75HjulzXLYo6uzEP8xjhOQKnA7dvGuBl/fcz9Ot8R4Nou
	 IbtNYaR0Dnpz9/4uGNrQzZrDe4hjzXj8Hf4GMC11R7xoDN/kJNn+7FiwQHzR7co/NM
	 UKQGR/ZSpG5kULchpp+P3n2Pe45ZDGQPK0WxzMNSPhzdNBUMqnJvf/NEDl7r3ZkLfV
	 +lVWjA6VueP0lQ7TQO6cFGkIolTMxIRbxZaXxplF00byvsH0ze3Dv1dLgFZWe7HitR
	 uaIFmBge/jaKw==
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
 [PATCH v2 15/16] platform/x86: toshiba_haps: Check ACPI_COMPANION() against
 NULL
Date: Tue, 12 May 2026 16:17:00 +0200
Message-ID: <2285136.Mh6RI2rZIc@rafael.j.wysocki>
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
platform/x86 toshiba_haps driver.

Fixes: 3a96c7915d93 ("platform/x86: toshiba_haps: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/toshiba_haps.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86/toshiba_haps.c
index 1486252b5983..8d12241924df 100644
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -182,13 +182,17 @@ static int toshiba_haps_available(acpi_handle handle)
 
 static int toshiba_haps_probe(struct platform_device *pdev)
 {
-	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
 	struct toshiba_haps_dev *haps;
+	struct acpi_device *acpi_dev;
 	int ret;
 
 	if (toshiba_haps)
 		return -EBUSY;
 
+	acpi_dev = ACPI_COMPANION(&pdev->dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
 	if (!toshiba_haps_available(acpi_dev->handle))
 		return -ENODEV;
 
-- 
2.51.0




