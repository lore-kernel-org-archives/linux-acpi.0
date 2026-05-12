Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D293128B8;
	Tue, 12 May 2026 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603126; cv=none; b=s6paL3Be6PkL/PyMEL27lQK+ZUHqKe3NNSGX/HP5sT2YhMs9wB9a/Jw+cwddm8ys/HbkSVfEaF3faz+fpNi9BF4V86wPK0YRTL/IS77npy2VMCjz8LhM3xk9zpKq0nEXNV0rTgorA888Ej7+oYZM0JWuhpOCj9ETUJ4Qxob1wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603126; c=relaxed/simple;
	bh=3sq6NnFrdKT6Lxa2zu6hUHrilzo/IxR+ScNbJa7Es54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IF+Dd6WOX5/MZjjhcATg9SQG7og3WqoBzWpAyJO+/j7/5UVafpaLdnc0sZuLEe4VRXHf5EH71D4z62LCmy87tyvb54m70vqXpKTTsPLv8VJPc4cnLl22kPL1KD04t8luf4gRhjvAqDJvz62wrh6tB31+E6DOviTPyG28v3DbYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI7o6JJI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI7o6JJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979E2C2BCB0;
	Tue, 12 May 2026 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778603125;
	bh=3sq6NnFrdKT6Lxa2zu6hUHrilzo/IxR+ScNbJa7Es54=;
	h=From:To:Cc:Subject:Date:From;
	b=jI7o6JJIpvCuCLDLqekxygCerIV/8/UU3l8YG3XQvf/0iHhTe8Ta5GS5BDjznReLz
	 I1Y0xUNibxofCGvhsHUrvcKQHY+ZNtiznOx02OfbAtI7jo/iOkUebMZ/Ns349HCQK0
	 5r0sZeyeLEJg9JjaAVC3hafkl5MRqygWmyHiU5UKkOerLDwmx8kIAcZhliZW3xeV7o
	 j91bB5aKJwqwg2X2J3/X+br/dVaAmFhV7bSz5Qj6cR+SMmhvl0mKxqv0vUytmUCu08
	 f4Nhstqwm8kAH8TjyiboyfTN/hCth9H0HgT59cCE3njQvJZKIfB8yyy3/eITZphlgK
	 deTcWQokHshQw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI: PAD: xen: Check ACPI_COMPANION() against NULL
Date: Tue, 12 May 2026 18:25:17 +0200
Message-ID: <3427762.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
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
Xen variant of the ACPI processor aggregator device (PAD) driver.

Fixes: 112b2f978afe ("ACPI: PAD: xen: Convert to a platform driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/xen/xen-acpi-pad.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/xen/xen-acpi-pad.c
+++ b/drivers/xen/xen-acpi-pad.c
@@ -110,9 +110,13 @@ static void acpi_pad_notify(acpi_handle
 
 static int acpi_pad_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	acpi_status status;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 



