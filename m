Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999537756A;
	Tue, 12 May 2026 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599025; cv=none; b=bomLt0swO2ATsrxLW8jw7/bxpW7h1UXkpB379Af8ZVp2dErur1jsPX2yrD/2T4dnxBntZ/XkFana3/WUj8eRJ3i4K1/3JdpUrETsWPDe9zeTQCJ6Qm8LMTXMC2JrxgE4eOSqYdS4i3kCe0TLryhzESiIl8Z7uwj7hVwc8+38jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599025; c=relaxed/simple;
	bh=78xU2byLb9Mfm09ahPQLgg9W5crd6gTt6m6YWQ40rvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMoxQtO/APDB6DtSNdrR+9E+dAbzx56guyMPnbu7DLypF20MVcX4AAXed8qNRZB+6Cp5EIJ+aJEYPDThrNqL+Qvh2yCpsCQEsGSlN9UcGEqDt1xaUFD0eQaDjsUyKnHmntp/eDVWwle5jhqlrwengVrRONThh19WWTmXw92IGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llPGT/OQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llPGT/OQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31D7C2BCB8;
	Tue, 12 May 2026 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599024;
	bh=78xU2byLb9Mfm09ahPQLgg9W5crd6gTt6m6YWQ40rvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llPGT/OQV7vr0I9Xu1gIoiln5WiyUPsHFvwYz1DVyXHquUSQ2OMuZBrHjkLZW/rF0
	 H9HJ/gNtiBY9ZRbOA/7TGLV/LM1fcMXvf5i3vogI72xhYf/2jOhIQiN3lq3jlFsonQ
	 X3vzj9k8EFiCouApNDvd5pvEkJ43qs6UnU5sD6GwZiCd50nj+VbWHlWi1XjrtSY+rq
	 Gtb+twoi0IYwfsu9V0bk5k+RVdCPkxkMOW63pnuJp6yGscdJtziXJ6yo40ej8r6oPR
	 H79mQrxxfdsXIj7zcFcAmOc514e3OCAyUG+VwNpzGYPofYtt76l/KO9MCQQDn/FNFx
	 ESWX3y37nY2rw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, Andrea Ho <Andrea.Ho@advantech.com.tw>,
 Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>,
 Shravan Sudhakar <s.shravan@intel.com>, AceLan Kao <acelan.kao@canonical.com>
Subject:
 [PATCH v2 1/5] platform/x86: adv_swbutton: Check ACPI_HANDLE() against NULL
Date: Tue, 12 May 2026 17:11:49 +0200
Message-ID: <5115425.31r3eYUQgx@rafael.j.wysocki>
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
platform/x86 adv_swbutton driver.

Fixes: 3d904005f686 ("platform/x86: add support for Advantech software defined button")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/adv_swbutton.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/adv_swbutton.c
+++ b/drivers/platform/x86/adv_swbutton.c
@@ -48,10 +48,14 @@ static int adv_swbutton_probe(struct pla
 {
 	struct adv_swbutton *button;
 	struct input_dev *input;
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	acpi_handle handle;
 	acpi_status status;
 	int error;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	button = devm_kzalloc(&device->dev, sizeof(*button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;



