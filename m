Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C33B1ED0;
	Tue, 12 May 2026 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595560; cv=none; b=HfePnsYJXTWF/8Z/xTaU6jkn7WhIMawiEnY63u1PO4rZ7I6K5N18MxvfiD1Srg5BzjT+eglhWjssrPtl3RBqRVhPMyYw+ahcn2oPAdtwBCBa2nKO+fszTbumg1y83xuQmLQIrWZq7P7tZq26ET0pYX3rCbauxUUiUNmXNBZQn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595560; c=relaxed/simple;
	bh=QVmau9GfaUT170w7Q7/p0/c+7zEQrJoUbzR2NChOmAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pd2Q+rOxxFCQ2iVIpm683ZTDIU5S4tmXVybx3IeMDd0PhnFgW6C1fBflUIq2icT8oosAkhBkxP/DaZ+66qbKXTKw1TCqR9AflB/bFeejgtTN/ZKPb8TbIRvBwPnZrL1wuNH0/dPiqXJpLKgLvAtiYN8GcSNNEAWot73aONlZkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQNvsqP2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQNvsqP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4CEC2BCF6;
	Tue, 12 May 2026 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595560;
	bh=QVmau9GfaUT170w7Q7/p0/c+7zEQrJoUbzR2NChOmAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQNvsqP2U0GC+SgiFrzJjRSlPB/3n8zHHEEx3zOStg6FaSIkd55hPJ7+Ya9BkOv7k
	 +Z4L3GBk7D0+lNRwpX5JWMg07z6Ieu+xBRKhotaxVIGGa+a4nfIKiXU0XFK0Piu4H1
	 unora3i/6u3+ckjUhde0lARKYKs9n7BBHGdlY6AfI1JtWIlkZqC58fhdXbFs9sWbv7
	 C8cMfs5S6TVVTna5pH+vgJ8tp2SaDXQKOl5rY4sAlAHWjpFFiJSBh8i2SDpoOuSfOg
	 0A0PLLsdPm4/d2wUvDrblbX2ZJcX0k/TlLKL+EXMhXw3ATYXTYpMxWSM3aURjLG2xh
	 rk0XfxFEYjx4g==
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
 [PATCH v2 02/16] platform/x86: asus-laptop: Check ACPI_COMPANION() against
 NULL
Date: Tue, 12 May 2026 16:04:23 +0200
Message-ID: <5083741.GXAFRqVoOG@rafael.j.wysocki>
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
platform/x86 asus-laptop driver.

Fixes: ba19eb10170b ("platform/x86: asus-laptop: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/asus-laptop.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index dbbb6292cd11..140ac8a10537 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1826,10 +1826,14 @@ static bool asus_device_present;
 
 static int asus_acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	struct asus_laptop *asus;
 	int result;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	pr_notice("Asus Laptop Support version %s\n",
 		  ASUS_LAPTOP_VERSION);
 	asus = kzalloc_obj(struct asus_laptop);
-- 
2.51.0




