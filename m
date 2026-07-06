Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0341DEF6;
	Mon,  6 Jul 2026 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340941; cv=none; b=q4v7YnU5o0Rqw/p9sAN6CgWnzEYr/kTq1DR+fmfMOdFVm/UzCuQMb6/f5c8gex/oVuU2ILQtww5h+LEZ6PKlMyNOrkSeLoLa6a1urZDqN/dJploLA6hPKw4dP6leGj/07W0o2ER31Og/70RYx4PDu2u+RyXso56O6b/5Ty6aXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340941; c=relaxed/simple;
	bh=C0aCwvS12tZknoCH+UGPLdDkEnObxzmzRIhMUekG+Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kN/Lrj2Iy27d5FRFezWhc7+FyOMQzuvaM86ZZyQfWsNFlGItN7QZv4q4BVBRWkGxEb8WcKrjclFjkdbLHgU/DyiZnrebnunpYvXRhl0IsweNe25GvWFLmO5LCwrXlt08Vii3deHNaXRnArP7ZZ8T5NbcOASJ0RRiMM6et10oFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flxCPPT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flxCPPT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3941F000E9;
	Mon,  6 Jul 2026 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783340939;
	bh=aor9E4cHqUuM93ucyRGCGyAO3ohWOeTrR/gLAVkYBFc=;
	h=From:To:Cc:Subject:Date;
	b=flxCPPT1G1D65F/LESqto7Pc+ChJkv/YPJolXHIfKn7uwRcQvbXuOpk3zFoUxULj+
	 2HXSE59B9XmTzZFUEI28VD9Q9o9ioGM8lbg8yKYAlietXUtymuGjB5S4T82yvirDHW
	 ZYdE2DSnqQFBjRb0OLIXBBSBHibXo5Acl1IvTER/frdOq24BRpdzEY5sx1HMGxDuHD
	 4UyPz6mYN4vCcP9ClUoUa7X3mKRfhNtLk94ydvGnBH5uJfHV9WpVTpucDoBqkWxLwa
	 l4hMXrQHjv/FhPydo20S9tmbFkV9DhbpLz6UNV1oV5Np+KR4XI4tOUOkuletBsuUun
	 Y7ZTE9fGi4nVA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>
Subject:
 [PATCH v1] platform/surface: surfacepro3_button: Stop setting
 acpi_device_name()
Date: Mon, 06 Jul 2026 14:28:56 +0200
Message-ID: <6036011.DvuYhMxLoT@rafael.j.wysocki>
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

Since acpi_device_name() set by the driver is only used for input
class device name initialization and printing a message on probe
success, and SURFACE_BUTTON_DEVICE_NAME can be used instead of it
directly in both cases, make the driver do so and stop setting
acpi_device_name().

No intentional functional impact.

This will facilitate the removal of device_name from struct
acpi_device_pnp in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/surface/surfacepro3_button.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -212,11 +212,10 @@ static int surface_button_probe(struct p
 		goto err_free_button;
 	}
 
-	strscpy(acpi_device_name(device), SURFACE_BUTTON_DEVICE_NAME);
 	snprintf(button->phys, sizeof(button->phys), "%s/buttons",
 		 acpi_device_hid(device));
 
-	input->name = acpi_device_name(device);
+	input->name = SURFACE_BUTTON_DEVICE_NAME;
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 	input->dev.parent = &pdev->dev;
@@ -239,7 +238,7 @@ static int surface_button_probe(struct p
 		goto err_free_button;
 	}
 
-	dev_info(&pdev->dev, "%s [%s]\n", acpi_device_name(device),
+	dev_info(&pdev->dev, SURFACE_BUTTON_DEVICE_NAME " [%s]\n",
 		 acpi_device_bid(device));
 	return 0;
 



