Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7842CAE9;
	Mon,  6 Jul 2026 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341504; cv=none; b=NNOM2Opo54GgVvkxWS3iOHWwYQoW6eOCH563VUE2FtYLCYLHBj8WSAOSCVOSmK7k8gfBVEFXo5GoW5ymlGVDO8d29b7ce2pZc/JYujtz6jolfzVv9mdtXPhfJtNYFjP7oajpVDAz9XMfT7b67rPQuoOKzuc9LcTqL/n93vqrlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341504; c=relaxed/simple;
	bh=9KEIwnFk5N2fYeG9XPZO8x/wkfP09H/V48cA3rnhNlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZ0WtPBJpO3NNN+V0S4q3plHILbxAkUOaJlxnDExQ5Mykz262Zt9kEFxSDBj4d2j23qY+zJJWQnzS1h3hWk35EYWPYIO6ci11+dBFGVEggYlcXcH4ufq1tj/p05LJgI0SyRXgFdVFQP1R4aEobJm/duP/MdpJ2bq1WThpkkkgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emrPcDUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emrPcDUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18851F000E9;
	Mon,  6 Jul 2026 12:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341498;
	bh=B2CnfOU+M9i8o9euao3nHm6mdpfLKguxVTxMyTvXNPo=;
	h=From:To:Cc:Subject:Date;
	b=emrPcDUkTA5FDuqzL9qEeXiDLqNF2jy0zJaHN6Zr2ySlPS96Pli+KlEvSRp5hz4uD
	 xZGSECHS18gSfNrRUHQJJkxC5zPVx13fuqmZDKn5vR6ZBWMOejVdMmYRgrCGIYRE9o
	 WdsC3zsR41TJMyjutDKPwIKFO6JXcplmQAQIZfgdiq2d/bsxYKIofIwQBTiNyQMZV0
	 ndMMENayeQhdZ3cySJcjbIzTPAh+ry/Si5TmLTqulrjg3CXwXoicfuiR8CvXfGlEvn
	 6Duaro6tJEZq5xh84dXlPr0PzG8ApeIKqmMB4pGiVTiP65UT996H8DAiWFoMSski1b
	 8oNprQAApPJgw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Mattia Dongili <malattia@linux.it>, Arnd Bergmann <arnd@arndb.de>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1] sonypi: Stop setting acpi_device_name/class()
Date: Mon, 06 Jul 2026 14:38:15 +0200
Message-ID: <3447860.aeNJFYEL58@rafael.j.wysocki>
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

The driver sets acpi_device_name() and acpi_device_class() which are
never read afterward, so make it stop doing that.

No intentional functional impact.

This will facilitate the removal of device_name and device_class from
struct acpi_device_pnp in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/char/sonypi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 9309cfb935be..9a88d287fa09 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1125,8 +1125,6 @@ static int sonypi_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	sonypi_acpi_device = device;
-	strscpy(acpi_device_name(device), "Sony laptop hotkeys");
-	strscpy(acpi_device_class(device), "sony/hotkey");
 	return 0;
 }
 
-- 
2.51.0




