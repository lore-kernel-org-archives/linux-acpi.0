Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3273E172D;
	Thu, 21 May 2026 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372753; cv=none; b=gZ5VGi5v3X8WjaQ7yHQpOojnJI9viqlQF3QPtBgSJkYPnLSY8+Fw/7lUhQTQq0b0ufKScZTuUpEqzYkTG0WhS0eCPZIl4pTuPzZ9ppxbp2d3viBrxyTS2kX6nu4BvpHIvUcUOgTXJeKuaITzZ4QBstzjvlSNVq3iTvU/VQSmZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372753; c=relaxed/simple;
	bh=YnjtilNEDiR5RtRSpe6Al1PPgTkEn6/3HUGUJbndw5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRDWxGaLGIhnCkbG95zy/H1TD3UzFLyawILT1I7dfzGPX4FYZAYnWb2NjiRse2QkL5r3+kx2Mn7aU5ANGLOdEP821e8WE6bd8Pamnqi/s0LjcSuHhyVXWuLyoHdOkFleH7BQu9+qcGeXFj7GgBq6Geh1nQ19evbrfbf4Fz+99QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giawKTTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giawKTTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CBE1F000E9;
	Thu, 21 May 2026 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372751;
	bh=pkBvAEYfatxNY3XtGuy8IfYiH5e7JaoDpwiEb8X7e5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=giawKTTgj4PzfY6nW7d1P37kziCn5xDGkmIDeTuE6JsV2fp7CFHv8eeOHp2SDdoZA
	 nfQwQmZrazuucdgiDhez0y3OoAtnj23yvvRGf4AEz7WQhULOP8fg+1NtjZbakXCxY5
	 3SgtcZBxnZN2h1YE0jLDEK/+LgWQnFaQ10SiY2QF4OdJFH/JqYKm37UF6NwJAm3HnS
	 LuVarHosIXUFBJOBgzR5W0jrg99QTst8mBcTy3tuA42eCxEquhfDmimvoSUhh9r0Q/
	 GNYVIu9SHeI7sr/XeCpw4EMxLzG/ntTnwTHqgDRcupNBCtm/1OuFQ2EJOve/eRCaFY
	 QB+aj6udwybBg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 06/17] ACPI: HED: Switch over to devres-based resource management
Date: Thu, 21 May 2026 16:04:03 +0200
Message-ID: <7950702.EvYhyI6sBW@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4739447.LvFx2qVVIh@rafael.j.wysocki>
References: <4739447.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Use the newly introduced devm_acpi_install_notify_handler() for
installing an ACPI notify handler and since that function checks the
ACPI companion of the owner device against NULL internally, remove the
the explicit ACPI companion check from acpi_hed_probe().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/hed.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 4b5dc95922ea..48562f53d3ab 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -50,19 +50,14 @@ static void acpi_hed_notify(acpi_handle handle, u32 event, void *data)
 
 static int acpi_hed_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device;
 	int err;
 
-	device = ACPI_COMPANION(&pdev->dev);
-	if (!device)
-		return -ENODEV;
-
 	/* Only one hardware error device */
 	if (hed_present)
 		return -EINVAL;
 
-	err = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-					      acpi_hed_notify, device);
+	err = devm_acpi_install_notify_handler(&pdev->dev, ACPI_DEVICE_NOTIFY,
+					       acpi_hed_notify, NULL);
 	if (err)
 		return err;
 
@@ -72,11 +67,7 @@ static int acpi_hed_probe(struct platform_device *pdev)
 
 static void acpi_hed_remove(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
-
 	hed_present = false;
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
-				       acpi_hed_notify);
 }
 
 static struct platform_driver acpi_hed_driver = {
-- 
2.51.0




