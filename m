Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809837DEA8;
	Wed, 17 Jun 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722428; cv=none; b=jLWCgdsxtXP168GB90fOcgv+sG/viRiowCd8ddfr42H2U+9FnW+G/ROu38WOagEIOp+YZL0rdYPkt76cfCoHYt1jM8T0GrhjvpJ8JWp4AmHFQ9mSaSkPsSWovTI9Bst2KVX/2O7JId2pvVnMDrVkWZkpQHsxlRZIbM2xgYK0Ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722428; c=relaxed/simple;
	bh=C9Kc5u3uGWG4kXI65SLZH2WnV7LUNytQqC6LL1av7AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvSSaNcAstd/w6NdvFgxG1xIQ0ui1Ad/1QL3IQGsq4tQsvi7uKjkcwDg9sfmQRnDuTUKzSthl+A8kAo7eESWHMWlXdr0zOCCXkmhWGYlYzXcue8X8AbkJTqJh10GiCqAORTIs46YPr4wZWiyRrFjOWfaos9gb/aFoAXlQEIStrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=N8YTvgo1; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="N8YTvgo1"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B948527832;
	Wed, 17 Jun 2026 20:53:39 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d-6ZjoQM8fI9; Wed, 17 Jun 2026 20:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781722415; bh=C9Kc5u3uGWG4kXI65SLZH2WnV7LUNytQqC6LL1av7AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N8YTvgo1Mdq4rjCz5ny5ONyfiesCtK9nU6gtIB9MfLm1hxMk6bwQjvJuvcGofDlMM
	 xJBjSOdySbJ3iYZCo+Hk3lOXBgrKuGzy6H68P6RcUIR/GiJkNy69DQbDEJQ46pzgk6
	 Z9hOy29klX6Q3rvAYIvXhiBEMkQFNAOxvuaobraRhehkWRkaQgxKrfVTbO8P7oPYco
	 c5mfaoNkEIvQeQs4lZuqQ1Mk/dPjvUASlRzeQQ1XBRRf8CfYyw6fFobVE5abcB84VR
	 /tSCY7diH+qat3L76ndvVvdYC803YGKLst7F07IbX9kpAxW1IBpy32CTy7WgO6XSLK
	 wz+m3HbpxajHw==
From: Marco Scardovi <scardracs@disroot.org>
To: bnatikar@amd.com
Cc: andriy.shevchenko@linux.intel.com,
	brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	scardracs@disroot.org,
	westeri@kernel.org
Subject: [PATCH v2 1/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614 series
Date: Wed, 17 Jun 2026 20:50:13 +0200
Message-ID: <20260617185318.11237-2-scardracs@disroot.org>
In-Reply-To: <20260617185318.11237-1-scardracs@disroot.org>
References: <221cd70d-70f9-4d01-8e8c-b4a5b347b8b9@amd.com>
 <20260617185318.11237-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASUS ROG Strix G16 G614 series laptops experience a long boot delay of
approximately 36 seconds.

On these laptops, the firmware leaves the touchpad's ActiveBoth GPIO
line asserted (logic low) at boot. Per the boot-time initial-state logic,
an ActiveBoth interrupt found low is replayed once to sync its initial state,
which calls the handler synchronously in the probe path. On these laptops
that interrupt handler is slow/hanging, so the synchronous call blocks for
~36s and stalls boot.

The touchpad itself is driven by the i2c-hid driver using a standard
GpioInt() resource defined in the touchpad device's _CRS method. The ACPI
event handler on pin 21 is distinct from this and is not required for the
touchpad's initialization or runtime operation.

Commit 3bb62e3f99a5 ("gpiolib: acpi: Only trigger ActiveBoth interrupts
on boot") restricted the boot-time replay to ActiveBoth interrupts that are
asserted (low). The pin on ASUS ROG Strix G16 G614 series laptops meets
exactly that condition, which is why it still triggers.

Fix the delay by adding a DMI quirk to set no_edge_events_on_boot to true
for the ASUS ROG Strix G16 G614 family. This prevents the boot-time
trigger of this ACPI event handler without affecting the touchpad driver
or disabling the handler for post-boot events.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index a0116f004975..3cd4cd27808a 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -392,6 +392,21 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "VEN_0488:00@355",
 		},
 	},
+	{
+		/*
+		 * ASUS ROG Strix G16 G614 series laptops experience a long boot
+		 * delay (approx. 36 seconds) because the touchpad's ActiveBoth
+		 * GPIO interrupt handler (TP_ATTN#) stalls/hangs during boot
+		 * initialization.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Strix G16 G614"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.no_edge_events_on_boot = true,
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.54.0

