Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61C3B42E0;
	Tue, 16 Jun 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600933; cv=none; b=hTDrl3QmogyLuauFeM6Vq6qX6Zj5XG5bOC4Xx5KX6KGOdrXNtY1h2AHBCBrRqZieMdCqa3OJ/FynCxs7nD5SCF5572sXQEW4bJl3B4CkcAWemjjw9bdsy5WXCYx+wnq2oZ9o6KE+6eICaAXIfhIWzzctQC4uFFsRNbkSMVVyTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600933; c=relaxed/simple;
	bh=n0NkIV/Qx3Uk2GLJjYkZ09/aArbxPofUZwETgU7mhwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ni0uIXsDmntRhiedUJtD2gwr600In2B24ZeW5nSf+Ii0wHAnmO8aFgpMHdO/9EMBm8Y6nUIaDjMv3MNyWVkmiFeOxkGYbIWjNJrmUI0HBKOExDw3jpVhWwTxoGXMBOFNxiM7yqOc/qg0GGuXfCiRQ3f/CrnLLQO6hJ1rM1dparU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ElIeszfo; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ElIeszfo"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 71B75276FB;
	Tue, 16 Jun 2026 11:08:48 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JlPkQ8I8lPOs; Tue, 16 Jun 2026 11:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781600927; bh=n0NkIV/Qx3Uk2GLJjYkZ09/aArbxPofUZwETgU7mhwg=;
	h=From:To:Cc:Subject:Date;
	b=ElIeszfovhCsLBpW3VM5xwtWOJZqz0j7jGpSFYxydhh53qoOYFZjYCaNwgCm3mcjq
	 Aq/pXi784cnY7tBVmKX+S/BBZvY4pJl92MY2GvTnfF9dS7GKlraOqErwgZ1gdpLuQw
	 97Gg5sNEw0Ped6bDq88Uu8fuCP9nWLjzcj11TzsgXmwAZywx7oo6Y4TIBh0Mut1oRh
	 gAa2M5uuvX30r/a9+dbGnonyNLRWpA8CRaA/LJm94jAOF5bJiMTmrYDib9ErwFi6EM
	 FVX5JF54G3G/XCsg22xUyWbKwhfVRMTuJdj5Mghezuxjpo72dikZjgCoM60/5OSCRS
	 Edn4iQS9ZF9ag==
From: Marco Scardovi <scardracs@disroot.org>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <scardracs@disroot.org>
Subject: [PATCH] gpiolib: acpi: Add quirk for ASUS ROG Strix G614 series
Date: Tue, 16 Jun 2026 11:08:24 +0200
Message-ID: <20260616090824.5967-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS ROG Strix G16 G614 series laptops experience a long boot delay of
approximately 36 seconds. This happens because the system firmware triggers
a slow/hanging ActiveBoth GPIO interrupt handler at boot time.

Even though commit 3bb62e3f99a5 ("gpiolib: acpi: Only trigger ActiveBoth
interrupts on boot") restricted boot-time execution to ActiveBoth edge
events, the problematic interrupt on these laptops is configured as
ActiveBoth. Consequently, the handler is still executed at boot and
the boot process stalls.

Fix the delay by adding a DMI quirk to disable edge event execution at
boot for the ASUS ROG Strix G16 G614 family.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index a0116f004975..fa0f03bd51af 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -392,6 +392,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "VEN_0488:00@355",
 		},
 	},
+	{
+		/*
+		 * ASUS ROG Strix G614 series laptops experience a long boot
+		 * delay (approx. 36 seconds) due to a slow/hanging ActiveBoth
+		 * GPIO interrupt handler executing at boot.
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

