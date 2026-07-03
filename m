Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E93D5666;
	Fri,  3 Jul 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082516; cv=none; b=RungEiDU1t2/0qnVVtNfrt67fzNgwkeVw+tas30bs90D084bsvF40Z5UvL/vG2GJkS8RvnKjcgClZpu7THRk8hnmOA91/7zx+pH02JD9HikQI7ICBDm/KKdV8EaylF+t39kt99erXJGLVLGN/DMs2ly5r5ApVbgnBpY+Mw8YJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082516; c=relaxed/simple;
	bh=t1IfXPN8n97yjog3+j/xh0SADq/YuC9VBvHUYEJDR50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OxPanbz3cIFXyxnvEvnw5jc6BFPAA1tUbt3Jt4PGpjSY+yyzz51iB/RXLzXaFCNyBMGxRWGgqr/777LZQuY1W0oRdsy1VL3tpQT/i2eDwx/p+dCp6d3vNfdx8pD8rrNkWMNTXEsFNig3TlKcF9KpM8q2FjGNTqOprc/AJbzExPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYcnxHDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYcnxHDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379941F000E9;
	Fri,  3 Jul 2026 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082514;
	bh=K4CGwtNMhh4ePAGdQw4XUhro7qNtNoMljhdGSIEm7tM=;
	h=From:To:Cc:Subject:Date;
	b=kYcnxHDOLorEdwphGQcdvrM3z3j6t0OrKS9r2PNc5Xf3VkspazrumJXph6Idy1MpY
	 z+p1XaiNrOAPSElwsTvu2XCUvUahzlIf/8obEOJDKvVhzBtyECCsE2xPdVU+kMlJZF
	 4UrIjOByYUzNPlX/brHutB0koJbmw7RZeluVCRN76Sci5V1FzKqwJj0FU06HK7kpR6
	 u3/7nKzIRu6UCzZFDNkXyplONpBaq5GbmcdjIu+uG3Gmv6g2OlsChoEDX8xeik/VCf
	 7i9vgC+xQZx/gWXal5kQ3c8IEh7zmX8sq3pKm6tOj4Nbn0st/BrJ7asJQQdmawX5R+
	 K5Ly2rPWlIf3A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Herton Ronaldo Krzesinski <herton@canonical.com>
Subject:
 [PATCH v1] platform/x86: topstar-laptop: Stop setting
 acpi_device_name/class()
Date: Fri, 03 Jul 2026 14:41:51 +0200
Message-ID: <12951216.O9o76ZdvQC@rafael.j.wysocki>
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
never read afterward, so make it stop doing that.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This should have been included in

https://lore.kernel.org/linux-acpi/5135166.31r3eYUQgx@rafael.j.wysocki/

but it was missed.

That doesn't matter though too much because it does not depend on
any patches in that series, so it may as well go alone.

---
 drivers/platform/x86/topstar-laptop.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -299,8 +299,6 @@ static int topstar_acpi_probe(struct pla
 
 	platform_set_drvdata(pdev, topstar);
 
-	strscpy(acpi_device_name(device), "Topstar TPSACPI");
-	strscpy(acpi_device_class(device), TOPSTAR_LAPTOP_CLASS);
 	topstar->device = device;
 
 	err = topstar_acpi_init(topstar);



