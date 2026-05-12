Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBA37C0FF;
	Tue, 12 May 2026 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599013; cv=none; b=CMoRJa2iYccJ5ajzfjbO/xvIGxAAocP9RzvN2L1xtT4RdUbAnHbQN3CPVqeGgKqch1YDdXczPhxpAIF5kU0v6jjqrWy9XbaQK+Tm2sT2lT2E5y/CfueUlsMqWbIoblGZItfyV8yVMRWxyTjf9rmnnMXLydezP1EbqyA/MonaUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599013; c=relaxed/simple;
	bh=xXpMc8TmRFiV5sVYOy6UEfm84AndNxSa7cCsgrC2t2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfRrFQgzweuctQHsv4TYvgggtqx7Up+Lj1gcy4HCfNGEbSY3rms1gNz7jGKXFIQgx3jxOvzJBgx+0cRBcZ2DX0k44bPNijRXIQk9L6xGysSBIqmiMoNcJSJm88ZNG+ZUp+ZB6XyMcrqajHzQyKJHFKYsl2XLMLKJf6PievveEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLEtI0AR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLEtI0AR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42903C2BCB0;
	Tue, 12 May 2026 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599013;
	bh=xXpMc8TmRFiV5sVYOy6UEfm84AndNxSa7cCsgrC2t2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLEtI0ARfO0iMhICfViVlwG8XgVev000dhs0X5T9BhGNzOV38IkZdNU8O3OCjgwyC
	 6sfwZZAaJHC4rWuKthqzS3xlq1gGhSpJYAQjG21o8nalcwELG/ZQathU8Hu3m0zqPi
	 LPWLUA9k9xCUYUyFxQFOiBV1sbTJhRuv6LKCYlm1t+lOxNMUoZ1vbJNNNhomotybQk
	 L0GS2FUq1/eEtPVkyQoKgXFzq98d4BOgN4IgFCWpglwYJSJ6R8kBXvSNsaHto7Jz4d
	 +Je9LUzRbo0X5EjQKHxPx1Wp0YFaZWkuVRVAV2d1uo5rTFCUekb1lFD/OP7hn8kVJT
	 9K7/KOFXNixBw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, Andrea Ho <Andrea.Ho@advantech.com.tw>,
 Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>,
 Shravan Sudhakar <s.shravan@intel.com>, AceLan Kao <acelan.kao@canonical.com>
Subject:
 [PATCH v2 4/5] platform/x86: intel_sar: Check ACPI_HANDLE() against NULL
Date: Tue, 12 May 2026 17:15:32 +0200
Message-ID: <14023870.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6007701.DvuYhMxLoT@rafael.j.wysocki>
References: <6007701.DvuYhMxLoT@rafael.j.wysocki>
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

Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
platform/x86 intel_sar driver.

Fixes: dcfbd31ef4bc ("platform/x86: BIOS SAR driver for Intel M.2 Modem")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/int1092/intel_sar.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -245,15 +245,20 @@ static void sar_get_data(int reg, struct
 static int sar_probe(struct platform_device *device)
 {
 	struct wwan_sar_context *context;
+	acpi_handle handle;
 	int reg;
 	int result;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	context = kzalloc_obj(*context);
 	if (!context)
 		return -ENOMEM;
 
 	context->sar_device = device;
-	context->handle = ACPI_HANDLE(&device->dev);
+	context->handle = handle;
 	dev_set_drvdata(&device->dev, context);
 
 	result = guid_parse(SAR_DSM_UUID, &context->guid);



