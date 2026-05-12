Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B93AEB25;
	Tue, 12 May 2026 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595503; cv=none; b=fWEMJHJMDsyfHTtlbXJsX8H9neT4bK6EpYerbmcU/MfD4St+l440V6+ZEuSlt+QuTJf6tqet81VhF0I5Ff1DQE3pI2xixgP2BUvLo/oij5V9AtQVVaP9sRsgkox5t6ZXd9Xa0NoOFPsHgqL6EATpm24XtoDsTA05CcRfBaWXgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595503; c=relaxed/simple;
	bh=n44nubHrNg3awGDNtuuvzGBlIPxAp0mxlmnyKzO1UOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K05MXIiakDjnmvhBvS8IUByu8tf9vWwEUSsTr7gSQOzeh2xJdwl49gMsYm2bozHVcS7/B95F6Zu6drd86Sn/Gj3/+ybqdeWYi4SBfp6pPPwWv+gIx5PuJ36h6PGj07QIGB4stIGHbKzzO8DPKilnnkcEfl/ljxxLSypWtpfqRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt1WCWkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt1WCWkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1853FC2BCF6;
	Tue, 12 May 2026 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595502;
	bh=n44nubHrNg3awGDNtuuvzGBlIPxAp0mxlmnyKzO1UOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qt1WCWkR92376MFRjLjNW8kpVcSo3WjnFLbK+ts+a1x9ybKFLRP7hC9+BqJZS9P2N
	 kepn40u7emXFi/w4XD+tRkNKVs5srvfj/4qxqjMFHJd5MgGhSSBWRKxkCXd9JYAmT3
	 JxXk73JIxZkCE3RdhdY3GII+dzfkJ43O3hwuzwJRLPDx3oPYNjuaNIB+6KGxA80MLA
	 8p63de883+vjxC2p1C00KM19DRWjRE/VGD0y2gVF8eDEFX/stvlkbGkwIP6g5QnUaG
	 U0fDBvdFxXQPhim0hfbWFLBsmfnAJtQyR6yVQz29XhJChj5wbdNkZQgX/8XSwGz2va
	 RQS0Qj2LYqAmA==
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
 [PATCH v2 14/16] platform/x86: toshiba_bluetooth: Check ACPI_COMPANION()
 against NULL
Date: Tue, 12 May 2026 16:16:18 +0200
Message-ID: <2715450.Lt9SDvczpP@rafael.j.wysocki>
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
platform/x86 toshiba_bluetooth driver.

Fixes: 553b2ac59fbb ("platform/x86: toshiba_bluetooth: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/toshiba_bluetooth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index e50d4fc1e603..e00abba58c7c 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -230,10 +230,14 @@ static int toshiba_bt_resume(struct device *dev)
 
 static int toshiba_bt_rfkill_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct toshiba_bluetooth_dev *bt_dev;
+	struct acpi_device *device;
 	int result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	result = toshiba_bluetooth_present(device->handle);
 	if (result)
 		return result;
-- 
2.51.0




