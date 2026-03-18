Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20213F23D1;
	Wed, 18 Mar 2026 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862917; cv=none; b=oavry7UE1W69a8A8LY4N6idSvzApBMAjoUbYFvU9KLTvGU1gqSlyG5exG0aYx56TGDTwow12fY3IKkU2Rcy0n+MScTQ8Of25OREVfum2j5iyJIrxSoiSuEx3aYbxW7RWq5Fg+kiafd5Ym5XIYvsU6Q7LR+qACE19dbv8wXLqlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862917; c=relaxed/simple;
	bh=A3//JCulLF4tpwwOTdTkC9xjIupLUCp2RwPFdEA4aGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLpZYb9rdgxUy5Ly5kFXW3YoGMJGMDqVBznuRavVAE+z/zslq2IcJ9j1bz6aDV3LFUKB9z4BORpfoe46gmLLc8pVx63f8aYP4VA3rZh0Mq2ZuGlUSTeMH5hqQ91DM7WCKYVsX+jvQgv7bdHeHGDP2rcLhmMf1xRXA0nxlcDwIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDMKVQiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDMKVQiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A11C19421;
	Wed, 18 Mar 2026 19:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773862917;
	bh=A3//JCulLF4tpwwOTdTkC9xjIupLUCp2RwPFdEA4aGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDMKVQivrgvjJlseOVNwzwOtkMItWhEHsjlyJmLehdQzTHTtm5oSzBzOS1Nyauyit
	 tJoYRE/b4fN6Lf6t36IXO8EsyF2pyYq/Ts1W///nlpwUhsnIFF7/RMPpKVjb9tE8M8
	 pqT6D/sWj5/hkQ61E3VokyPViKkBvCuJO7Ycj2YhhwFNg2R1lr5pbv3nJE/EZ15boZ
	 x95xw34+/KqdxrYxVd70mavfwH4uAzhU45m3X6pziTua6tlF342vRSzpI0NtaNvSZV
	 laakWLr8xFZPcp7ShAV9+Eq1Nx7BWqvFyJU7ebwDXHaLEq1kdiAp6+66KwUw2NzF3S
	 ifsKf/2QvXV+g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v2 2/4] platform/x86: panasonic-laptop: Remove redundant checks from 3
 functions
Date: Wed, 18 Mar 2026 20:38:11 +0100
Message-ID: <2260826.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5979471.DvuYhMxLoT@rafael.j.wysocki>
References: <5979471.DvuYhMxLoT@rafael.j.wysocki>
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

v1 -> v2: No changes

---
 drivers/platform/x86/panasonic-laptop.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index debab5916782..8825142ea9de 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -968,14 +968,7 @@ static int acpi_pcc_init_input(struct pcc_acpi *pcc)
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
@@ -997,9 +990,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
 
-	if (!device)
-		return -EINVAL;
-
 	num_sifr = acpi_pcc_get_sqty(device);
 
 	/*
@@ -1128,9 +1118,6 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 {
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 
-	if (!device || !pcc)
-		return;
-
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
-- 
2.51.0




