Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9687409613;
	Mon,  6 Jul 2026 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340790; cv=none; b=NPi0SNDdHgItpIN6yk2skcf7jgMbl8NWu56sp7RJCcdkelM3PWAE9WGV7GGW6LFEiJvSSW/r1a9aKZHSucYKGBT1i+/P4yegB7mjV1Y9MytwCa143T1J+xOjIjkFwxU5z+bSV2Why3E7lqHQ4i1w2PLK3X4e7dZRM5p6FcvOZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340790; c=relaxed/simple;
	bh=4K+SkNdAjOyzNNHJOhbK1tSZzbkP6KVTBW1g1XOB8zU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RLYFomlgQXfhposyC/9JBTyi7vAxkyq/78dOCA633XakmqI3/vGSZ5Qr6p/acvYnQTHxZpV8z0Gp25fUpLVq70qLZYUoZshqVq5Ugh09WEK3kADXc6hYYFjvDurqBqyQor6CB/EAImO7zV81CjOx/rpveaIMhVgUu8D68tGGKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTS9jvKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTS9jvKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584C51F000E9;
	Mon,  6 Jul 2026 12:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783340786;
	bh=wR8kRwz9iMynKmvAViq9xl3G5Cs2EPaSppklJCzHvFc=;
	h=From:To:Cc:Subject:Date;
	b=WTS9jvKGSHI2fQ0MwAxRx+uSMFcdNE3nJEmVaADgndnbUPJHi3ltu+1aHXimyZyph
	 QHMFCz12RQKIOat4BaJ3Zyqd/DeSLBsZZajVgk2c4Mc80fpKTtjP7Qp9qaPYFqbVt0
	 zVpGhfbFUq1/aONZzFCSjRN4TmX5iQpgmK2Z4k5oSROGrdDa21aoFSrk3mhmc4mtM/
	 6fgJr2Ig8SecttvwZFZPljB/G8Ue6HwK1jf91HICIW2ud1znRxg/fMZ/a5r7Gzs2RQ
	 OitRl7cS+n42tuHDUol+zA2p2qAqBmsp8hp8RV3vNOJtX+kbyqVIM9iV6mcT0xNAJr
	 SgPMjUwyCS+eg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>
Subject:
 [PATCH v1] x86/platform/olpc: xo15: Stop setting acpi_device_name/class()
Date: Mon, 06 Jul 2026 14:26:23 +0200
Message-ID: <2866696.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The driver sets acpi_device_name() and acpi_device_class() which are
never read afterward, so make it stop doing that and drop the symbols
defined specifically for this purpose.

No intentional functional impact.

This will facilitate the removal of device_name and device_class from
struct acpi_device_pnp in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -18,8 +18,6 @@
 
 #define DRV_NAME			"olpc-xo15-sci"
 #define PFX				DRV_NAME ": "
-#define XO15_SCI_CLASS			DRV_NAME
-#define XO15_SCI_DEVICE_NAME		"OLPC XO-1.5 SCI"
 
 static unsigned long			xo15_sci_gpe;
 static bool				lid_wake_on_close;
@@ -148,9 +146,6 @@ static int xo15_sci_probe(struct platfor
 	if (!device)
 		return -ENODEV;
 
-	strscpy(acpi_device_name(device), XO15_SCI_DEVICE_NAME);
-	strscpy(acpi_device_class(device), XO15_SCI_CLASS);
-
 	/* Get GPE bit assignment (EC events). */
 	status = acpi_evaluate_integer(device->handle, "_GPE", NULL, &tmp);
 	if (ACPI_FAILURE(status))



