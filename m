Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57A3C4B93;
	Fri,  3 Jul 2026 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078729; cv=none; b=Djv1Ol+t8ncvJZ4KdlHJMpqu1xv32D+nS7qmLgY4lj1XYgoCd1OaHNrf8YYVDOQx2yiZbEcN8T8qznWX6/0Q8h7fAkxAUVbXfObWpAizHObm9WmVMBufejrjc2mqMpw7dMQfQWXZUMI79+tVFZXgEUh9ao0oPJ7Q/J4ozyHET38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078729; c=relaxed/simple;
	bh=JHzkAwTMIE4wy6pT6pSWGsdsxLQjr3L8P8SNn9QXRi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hn1VckDLOnatGMUczvVMD2LR6l+zIzUX2gvZpkcMCVP95rfdFx/5r9p4VBW9cwM3nE0voxLsZ14d+be+hvL1NI2r3feRfEYNzFYMXJkS+CMbogQGL7mqTh9gXlPoYI41+uwv1dtGz6ssxntcOoenY0KjXyzAikUFaN0PT0CQ1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOukbu1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOukbu1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2C31F000E9;
	Fri,  3 Jul 2026 11:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078728;
	bh=7TDYlU/zLWyRnZ0/k89b2NxMS6tSRpsOYAXYgFKlsAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOukbu1RgC2TMA1HUOS5maoeiVQsn7zNKR3Or4f0FdnaWjNVRDnEXB6wWd2Vpk9Bj
	 oJIWCHD/7VfPnMM/GVNarZKCXvBgGGNzYojch1uuvXTogyG0C+McpLXjkln7muFrS0
	 taaoYR3wfykNdLDxKhxbBmtzXE8LycaLi2NtOkv8VmYe5pg2cDeczBJAn8UUPDyNrf
	 Cy8Bqd3B7RoQjg8FDMcCDsM3bVUhfJU+rLAqNVPZwt0u1h2Xu9hfkVgpGaqTIg0d2Q
	 d8EAsz5Ob/JQPHEvjfY1WNlvpsdA6S4n0cZt3OZkMkxNxoDhGdIjE5vrAHRnDVezkv
	 zxF/H84c1hWiA==
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
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
 [PATCH v1 06/10] platform/x86: panasonic-laptop: Stop setting
 acpi_device_name/class()
Date: Fri, 03 Jul 2026 13:30:56 +0200
Message-ID: <3979672.kQq0lBPeGt@rafael.j.wysocki>
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

The driver sets acpi_device_name() and acpi_device_class() which are
never read afterward, so make it stop doing that and drop the symbols
defined specifically for this purpose.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/panasonic-laptop.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 719add753cb3..3effb11c4153 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -159,8 +159,6 @@ MODULE_LICENSE("GPL");
 #define ECO_MODE_ON		0x80
 
 #define ACPI_PCC_DRIVER_NAME	"Panasonic Laptop Support"
-#define ACPI_PCC_DEVICE_NAME	"Hotkey"
-#define ACPI_PCC_CLASS		"pcc"
 
 #define ACPI_PCC_INPUT_PHYS	"panasonic/hkey0"
 
@@ -1017,8 +1015,6 @@ static int acpi_pcc_hotkey_probe(struct platform_device *pdev)
 	pcc->device = device;
 	pcc->handle = device->handle;
 	device->driver_data = pcc;
-	strscpy(acpi_device_name(device), ACPI_PCC_DEVICE_NAME);
-	strscpy(acpi_device_class(device), ACPI_PCC_CLASS);
 
 	result = acpi_pcc_init_input(pcc);
 	if (result) {
-- 
2.51.0




