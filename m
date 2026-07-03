Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D333C9EEC;
	Fri,  3 Jul 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078716; cv=none; b=oeZbD4Kk7TsQs4P1dAdnpNP9Fdx+X87YSae1Wd/v4spdgVyG+VlQa0pVtLLCYkIS+oFxnAnzuah+sGBLC8JQwhsvM/4rpJDi6ny+hMP+mDRxj0xaTJN+DRAxiOKHpb1+KhmyyDUw9GqQ/TC8KwsUYuozPASCQxRplCoB/4u0BjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078716; c=relaxed/simple;
	bh=bh625QtwTHIFC2meghTY25UUtbM1xUieSFYJxvVa7Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9tYQ52wL9U8Zc3jNCs2MNv+K9sHQkSzAdwVxdU64/dlRdaBYHNcvQh4TvcyqjgwUrYV/TommohdrpEpb79VpCT8M/ceHDSxH+CDYA82CJybXvHILKIgZnJr4XtQvzf4hV3aupXhkBcH+NZPmLB7cSQLXx+3p9V8a7fZYN7DaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fokw3ELw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fokw3ELw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79761F00A3A;
	Fri,  3 Jul 2026 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078713;
	bh=7fUQv41Tphj9cWLIFwsF14kOIUUgab4THGgL2EqOjsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fokw3ELwngHR5opLjwVnQoNGmnz+oio6bImvdhfm6NXtA45jtrZ5z9l794uGIw/Zm
	 w0GgP1+eBOaW5YvEsAaxcfXI8kUNNVhy0gxk3MpBZhqsGGrQZROjNpR4O+hWyrIx42
	 tXyQX+RncP7Yw44Uh+wc7pHf4oA6X2G9ZXvvMt2c18ZPhSla0uY65YgLINBGUFIbPJ
	 eONYy3dP3x5tzpknijP2cHKlmUIgeQ21JLVA+965UKe0J1wiClDm3hrtnuJMhnKsWP
	 +BWZa5qGsX+HrVVC9/dfT+uS9NaeIydT2xiJMxUI1EVfuS9omvRVVj1CKOeRUY3BIg
	 hPkw2xFei1g6w==
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
 [PATCH v1 09/10] platform/x86: toshiba_haps: Do not use uninitialized
 device_class
Date: Fri, 03 Jul 2026 13:36:23 +0200
Message-ID: <1987644.CQOukoFCf9@rafael.j.wysocki>
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

The pnp.device_class string in the ACPI companion of the platform
device used for binding the driver is never initialized, so passing
it to acpi_bus_generate_netlink_event() is effectively equivalent to
passing an empty string literal to that function.

Accordingly, make the driver do the latter instead of doing the former.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/toshiba_haps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86/toshiba_haps.c
index 8d12241924df..c6633b74029f 100644
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -136,9 +136,7 @@ static void toshiba_haps_notify(acpi_handle handle, u32 event, void *data)
 
 	pr_debug("Received event: 0x%x\n", event);
 
-	acpi_bus_generate_netlink_event(device->pnp.device_class,
-					dev_name(&device->dev),
-					event, 0);
+	acpi_bus_generate_netlink_event("", dev_name(&device->dev), event, 0);
 }
 
 static void toshiba_haps_remove(struct platform_device *pdev)
-- 
2.51.0




