Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849F42CB09;
	Mon,  6 Jul 2026 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341818; cv=none; b=kTvPui5JeWemexP8FIUcFNrQytJ/cEY4R9EnaUqw39yf2g+jXaylC58GkNCKWLjV6KO/n1SF8OB9pATKL/BatPNKYTOc9tFICCOZ/NpZFuLhFYgNJoxWL+Pv3tW94ul4bBRhcjnRUhvwd0sZdCZUaZvujumWYGapBKLlCI8j3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341818; c=relaxed/simple;
	bh=DW65YkhDIuy2jlAqAb0vbbXAnOlSTVjbqKAzU6ukzZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KwQg3FfMfcI/b701AgSqVuVxv4q+zaKAzvPVeRca2H2dI+j28rRbTp72QeSVNx9G3IGYktmXFuhstObqaVV17OtHKrv0/EqBreFpOVZCD4l3CLaFVSPSIW0mnTdxLhf/mo69DdJhkZ+cdlXO3R6fcdLNGX5tGTBT1C2AMo6Tzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juGKkDqW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juGKkDqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265DD1F000E9;
	Mon,  6 Jul 2026 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341814;
	bh=p7h+dayyKzxUdWB/BCNqQQG+yOIulrPkClHfijXkCoo=;
	h=From:To:Cc:Subject:Date;
	b=juGKkDqWzK/NrRvQWri1xf8Ce/mCVPq25mAln+ytnSGbzcYG2z3dqAW9Kq7OYhz+5
	 khhJBGsgbdDCXLDbdbOTaJtCAJOgOOaPMxp+A1LLzuuM7js81hy4kAs54t9ANFAGnR
	 fY3RjthKxt8BhUczjkwUaaQYz26LnqhiDms+hmw/vbf2hg/vVSAROjuFGTogw92wTQ
	 FKQ5Dq6mA0orNXtmQa946DlZajD9JAHsp6Rx0b5tq/HBz46pEnFFIBxPvMAFc6LEpy
	 r9o/2r31FW9OoLBk6YQ/TZrbMAXTNkjl/1Hqijf8YE9dnFDySZvKEtsGVXK7KwkCc1
	 dwFkZHeIIPj8w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] PNP: ACPI: Stop using acpi_device_name()
Date: Mon, 06 Jul 2026 14:43:32 +0200
Message-ID: <23191780.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Since acpi_device_name() checked by pnpacpi_add_device() is never
populated, its length is always zero and the codition checking it
is always false.

Accordingly, drop that condition and use acpi_device_bid(device) for
setting dev->name in pnpacpi_add_device() unconditionally.

No intentional functional impact.

This will facilitate the removal of device_name from struct
acpi_device_pnp in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pnp/pnpacpi/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index fbf03ff007eb..d8ec0ad2ab4e 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -248,10 +248,7 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	if (acpi_has_method(device->handle, "_DIS"))
 		dev->capabilities |= PNP_DISABLE;
 
-	if (strlen(acpi_device_name(device)))
-		strscpy(dev->name, acpi_device_name(device), sizeof(dev->name));
-	else
-		strscpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
+	strscpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
 
 	if (dev->active)
 		pnpacpi_parse_allocated_resource(dev);
-- 
2.51.0




