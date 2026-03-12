Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE69242D7B;
	Thu, 12 Mar 2026 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314576; cv=none; b=fzZZjmygI/7ojLZIVMFjrQoqkqvgDqxsDOC/LaXKbttnISDWDPloKM6MQmgXC8LX+YZnnhFYZnMsTozIgVcFim6ny+c0QidSfvzH7/+jHH8NeLfedQmRJyzAvqrBnFbPh4RAJxtLoF7latQQnrP0Jo4bOyogKGAZwoL4VceNFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314576; c=relaxed/simple;
	bh=t41WUa/1lK45VlG2FirEAtipTt6v5cOAdIEV1hxaqdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afZnrdMCugPv/ZfHw/5Ay645bKP58p0m6OMpc86d/de+g9QIS/P5afAzQh1e4eb/LNr9ue1vUiMFOJl/yFBv1mRETegd4xfxGv5geQcEcF0vqiMsen102l94HEIS4voEZrCCrAQAjtFdgrqkf/f5cZWCnd6QmuP8MUD2qfX2iAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzp24D0r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzp24D0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60355C116C6;
	Thu, 12 Mar 2026 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314575;
	bh=t41WUa/1lK45VlG2FirEAtipTt6v5cOAdIEV1hxaqdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lzp24D0rFq1J1vLY10P5BxzQMumhbMZohK0goaf6UJxcRhJGp3LW+TI15AdIJiGeo
	 FuLALWFI0MKLSskXD+l0fmENSNYPDr+uUnYSdJfRqHeKeutEd87gDCN1rqIhTZCzWz
	 rP50XXbEcL2xO7OKml7zRdYFjcvDoHf2mqnAc19Ernr/wlcTaVKGOsOiVqGZN/VkUn
	 OpN8V0Ai1Y+ABz3O6TtOScircVgFCN4zdm0TmCCMYSEiZwa5980OP4MuN2Z8l6DzVJ
	 n0JXHCTOdeEdKCsX4QqBqlVb7yImQ9b/5efXmDtbm2e4JIYJhiATJnGULvYu1j7ldP
	 ky0rwPAwvlbqQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v1 1/3] platform/x86: panasonic-laptop: Remove redundant checks from 3
 functions
Date: Thu, 12 Mar 2026 12:20:16 +0100
Message-ID: <24311215.6Emhk5qWAg@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3616223.QJadu78ljV@rafael.j.wysocki>
References: <3616223.QJadu78ljV@rafael.j.wysocki>
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
 drivers/platform/x86/panasonic-laptop.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index d923ddaa4849..64195ff0f40e 100644
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
@@ -1123,9 +1113,6 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 {
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 
-	if (!device || !pcc)
-		return;
-
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
-- 
2.51.0




