Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19E3AFB0A;
	Tue, 12 May 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595551; cv=none; b=scgLDzUeEGncHLYF3dPDE/az90Yp7ftnr88xSlmj3As4VADrH+3p6Q17IqSMDd5cD9Y3gvFUxF0a/TIEYyMPxUN3+HJLxHD0Fc/SJGhfVaUcmg3fdal6oLMqg6031zhXo8VD/sHgGeE+CeVRKbwnMbOuv5NlIfbcEbxYrhwxY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595551; c=relaxed/simple;
	bh=qHMg2+039jKd7ZvEsY2tfLTrbVvkKarYmOzF79QQLFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfpQFjflfOECVIf349rKmuEREV8NQAHST31So1/sBex2h7yDCzb8RKSGVh+hVB7nyWuHRwgZsOz94SdvGuzhrgoG503LGSoyFLU5baPn9AHrzv2s78INlZvMxmaUi9L19vOVMVTNjBBVT8WL67dE31b6AsdW2GK5zN8OsDgbsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxFK3XkW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxFK3XkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE92BC2BCB0;
	Tue, 12 May 2026 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595550;
	bh=qHMg2+039jKd7ZvEsY2tfLTrbVvkKarYmOzF79QQLFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxFK3XkWCsfQQJPFzMQ5VGrCSvVIRNsgF5bhT1JrRkZvtGBY3LAWSgz2vm+PV3fg5
	 jfs7fEZUXNrUOnRXpvZP7LRDoBiNDqRQnz1RolLHTUH0tmItJtP+UPOYYbbO3Qt0WZ
	 nab22AoXzAj/HLnAS+DCLALAauqrPxO0IoMTowOkpVJ88FDXdY6CDFwykFio0aSV5j
	 +xWPBa4YLQyi+A7feQST3H5HbtRjdAsxAxaiTh0g05ApRSg0Li1jRMArdZ7148otUO
	 y9Y2ODcVG3qf1sy1IvYuPaTR7tq0yN7IgozYrA/aS+X7/iaX1unxhvu+y2fWPTvGd9
	 8tgVpkLeTiyNA==
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
 [PATCH v2 04/16] platform/x86: eeepc-laptop: Check ACPI_COMPANION() against
 NULL
Date: Tue, 12 May 2026 16:05:47 +0200
Message-ID: <3056852.e9J7NaK4W3@rafael.j.wysocki>
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
platform/x86 eeepc-laptop driver.

Fixes: 079b59fd2d79 ("platform/x86: eeepc-laptop: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/eeepc-laptop.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 02a71095920e..d18a80907611 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1363,10 +1363,14 @@ static bool eeepc_device_present;
 
 static int eeepc_acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	struct eeepc_laptop *eeepc;
 	int result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	pr_notice(EEEPC_LAPTOP_NAME "\n");
 	eeepc = kzalloc_obj(struct eeepc_laptop);
 	if (!eeepc)
-- 
2.51.0




