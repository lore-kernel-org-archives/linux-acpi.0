Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4038836F;
	Thu, 19 Mar 2026 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920018; cv=none; b=QvoA+khZeRKEK0cmL3EG3Yb899X+UmLDLryiQZ6IlPw5jyS1bwfvvvQa3nRLjuh7AMhdfdjY/BPq8p+s5V4VhL1oGBgCtt59amMKzjXRTVBjJmzmp1+r8rQmvIInuy+PkwtP9SWNh/EtGNlrVwAl1q8gADkZyQ/nq6XcuI+a2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920018; c=relaxed/simple;
	bh=v8AA7Vg1/rIz4igS5+r0zdPNdlVQmIfSKsqU4DgEFas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eK2GL7azrjVJei66bn3VleGaio3JWA+qMWKiihmFqO2lIjJHf8DHP25xza30wdRjDXXGWHBdL0u20t+hQcXBHVN0JKwMDIwR8GdXt9ZzSzZ/Kd3Ypr00zFbOmsVIik1i4Uw4Mfo23bT5tdngV6l3I21t23GlGnhB/cd120N2lmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHh13tSP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHh13tSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665FBC2BCB3;
	Thu, 19 Mar 2026 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920017;
	bh=v8AA7Vg1/rIz4igS5+r0zdPNdlVQmIfSKsqU4DgEFas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHh13tSPQn5n9Tem0HILy4uxEys9J+821XWmGaZYn8QB3Z2l1UEF7SkqTITbh+bxE
	 1U6N3vvfpCxNGziTs55FrS0yy+H3hGX8/iIcgQEhl6K9g2QxdmDyoYAZadWFu6W7mI
	 aehMtXQL+phvZX4FdsiKIatD51hd+0wEWqubzgKyswXVe9gp1vxNrcL1AFT+tj7VSy
	 qNWrLULR+R3/2fgao3UI5/zEgrb8U6Rx36UhEZaqJ0NL3RtbzizGP0xi8cQtBe64VE
	 yK8XQteot4YR4d0Hc7lNkxxpt8Ou/22n08bf3PhVEPVgJuy8h/rBGgwZjWEQpl+EZU
	 4L2MLoWV7bkaA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v3 3/5] platform/x86: panasonic-laptop: Remove redundant checks from 3
 functions
Date: Thu, 19 Mar 2026 12:29:41 +0100
Message-ID: <3041099.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12863246.O9o76ZdvQC@rafael.j.wysocki>
References: <12863246.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The device pointer cannot be NULL in acpi_pcc_hotkey_add() and
acpi_pcc_hotkey_remove() because these functions are ACPI driver
callbacks and NULL is never passed to any of them as an argument.

Likewise, acpi_pcc_hotkey_resume() is a resume callback of a
device driver and NULL is never passed to it as an argument, so
the dev pointer in it cannot be NULL.

Moreover, since acpi_pcc_hotkey_remove() and acpi_pcc_hotkey_resume()
can only run after acpi_pcc_hotkey_add() has completed successfully,
the acpi_driver_data() of the device object used by them cannot be
NULL when they run.

Drop all of the redundant NULL checks of the pointers mentioned above.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3: No changes

---
 drivers/platform/x86/panasonic-laptop.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 56b4e61d7e5c..188ec597a14e 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -965,14 +965,7 @@ static int acpi_pcc_init_input(struct pcc_acpi *pcc)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_pcc_hotkey_resume(struct device *dev)
 {
-	struct pcc_acpi *pcc;
-
-	if (!dev)
-		return -EINVAL;
-
-	pcc = acpi_driver_data(to_acpi_device(dev));
-	if (!pcc)
-		return -EINVAL;
+	struct pcc_acpi *pcc = acpi_driver_data(to_acpi_device(dev));
 
 	if (pcc->num_sifr > SINF_MUTE)
 		acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
@@ -994,9 +987,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
 
-	if (!device)
-		return -EINVAL;
-
 	num_sifr = acpi_pcc_get_sqty(device);
 
 	/*
@@ -1121,9 +1111,6 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 {
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 
-	if (!device || !pcc)
-		return;
-
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
-- 
2.51.0




