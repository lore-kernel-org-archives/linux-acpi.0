Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD13AEB35;
	Tue, 12 May 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595493; cv=none; b=VJiGAbt55kYgeHAmZ3xOkNYIoJXHZP3feMeZFAE89R6jnzNw2bxAG1lLKheJjymftuz25kwSBeFp/hqmnHNeVkfNshs1AAVI3MX5QBZfmNTdcVg78zXYl6Q6MNVUMVIUbsvrOfn43tgc4IBJabQZVPjnbhcxPMIZQ9WzPOhXN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595493; c=relaxed/simple;
	bh=jo3WOcAcllTnNoTN8VNGR1b0csrz2lWdCnpFRdVXLFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0Tlt4OpY0cF1V9Mcsp1LVJftXNNvxojc8mhyRd3QgGh/I2Sbg8BWWYLJI7rTQL1JuMxukqSsaPsqQ+Yv7l/JqdFfio0/QTa0uI5tm9E9x7KoIx2u/ew2wVgFh2XmEsvd6zGWkjGN3xlWVNYEUudfEfATQ2UqyjCxY3wT0zA63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0L3hqm5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0L3hqm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AB8C2BCB0;
	Tue, 12 May 2026 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595493;
	bh=jo3WOcAcllTnNoTN8VNGR1b0csrz2lWdCnpFRdVXLFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0L3hqm5JYiHsK2EtI0kfBPbodpynj7D+TcHRqEiVTaM7uAK7X4/mXss8svQgFkD4
	 bAs4szfxW00ayiv7VT/OqCTJE3cxYIAfORfDWz1KpKBrbXGFYOnzaA4cfMzp/hoHom
	 R0vFxcQoDvSMACE+9ul0co0hCGARL+eh1CAeyhcoeBGbre47+RikVN5x739nJIDCFr
	 dx59UuySyJPfquCavVTfN/A6hPw06oNKImasDZxGFJxAmtFtcR7jK9okWq54OhcMyI
	 8XO36aMTJDzR4rd6dvIxv4/q3FBALQlzTga234SkckK1JGe7EPXLhq4thU5hPT1ry9
	 GXpMsXlr0/lIw==
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
 [PATCH v2 16/16] platform/x86: wireless-hotkey: Check ACPI_COMPANION()
 against NULL
Date: Tue, 12 May 2026 16:17:44 +0200
Message-ID: <3899916.MHq7AAxBmi@rafael.j.wysocki>
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
platform/x86 wireless-hotkey driver.

Fixes: 8507277ef132 ("platform/x86: wireless-hotkey: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/wireless-hotkey.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index f680d8ff8e87..3151844d1699 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -89,9 +89,14 @@ static void wl_notify(acpi_handle handle, u32 event, void *data)
 
 static int wl_probe(struct platform_device *pdev)
 {
+	struct acpi_device *adev;
 	struct wl_button *button;
 	int err;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	button = kzalloc_obj(struct wl_button);
 	if (!button)
 		return -ENOMEM;
@@ -104,8 +109,8 @@ static int wl_probe(struct platform_device *pdev)
 		kfree(button);
 		return err;
 	}
-	err = acpi_dev_install_notify_handler(ACPI_COMPANION(&pdev->dev),
-					      ACPI_DEVICE_NOTIFY, wl_notify, button);
+	err = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+					      wl_notify, button);
 	if (err) {
 		pr_err("Failed to install ACPI notify handler\n");
 		wireless_input_destroy(&pdev->dev);
-- 
2.51.0




