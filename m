Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796A3A7D78;
	Tue, 12 May 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595508; cv=none; b=UWVe6DIvsRH0ICJWcLBn9CN+hwfkEMAwzMFs7y774BK83q/q3xuG8RU+Tr81DjmFzrsD496zLedFlCsXzuuGRtKXparYDShLURuexxLbqbm/wfpHg9llKKzX6jFTnhX1U9uMwPhUpBCwI6OEOOiKGjSmDBLkPy+JAsZPATJsL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595508; c=relaxed/simple;
	bh=cXVgoJYIJNGuVpl7BTWmLi4F4WKx3XAXg5bsGo4UBJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRs7FvJKGb0ik+kvUyaB2xWOcFzj88gmfSEerbSCWCwZupgJmD+Nrmki6yw74VDfM7iftO0U85LbKU1vh7YNHrx9RUcXuiNUOtcCtN04wrRcaGGgMZ5vN1s2vhKyQKmsdH/8osFKnHSepYtQNdJBFv3BbffIh24+sv3CShsl5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRLJDQXn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRLJDQXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12B7C2BCF5;
	Tue, 12 May 2026 14:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595507;
	bh=cXVgoJYIJNGuVpl7BTWmLi4F4WKx3XAXg5bsGo4UBJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRLJDQXngK2AdcinpLQxbT5TMgv2ilbbppdvgTItypqaRm9WFEi/w/PsbK2nVfbNK
	 cUDwdt9+uqZ8BYB81j4WLhpwDt8Znu2eTXjZiP8Ebgfb6pV+gy/eU2CISdeYY6DWQi
	 89gmqkaAs2rg3bDCajPs6n4jp8s9sxMl/cUNKn0M9qI6FTi4Xy381KBWpI4UuAP/1F
	 Iw2J89n15NihtP2KDug2rnsEkfvzMCocWf9W6nm4h8tf4SBu7uZkzRRIFNxX45abIr
	 28XkZP/ZyHCyBuFhItP2nnTIu9sf0nwy6AaWKxCi+rI8XGxXHDM1pXUX01lMgkKhP+
	 QIoNqUoOZzdKA==
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
 [PATCH v2 13/16] platform/x86: toshiba_acpi: Check ACPI_COMPANION() against
 NULL
Date: Tue, 12 May 2026 16:15:31 +0200
Message-ID: <1973170.CQOukoFCf9@rafael.j.wysocki>
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
platform/x86 toshiba_acpi driver.

Fixes: 246d6cefe525 ("platform/x86: toshiba_acpi: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/toshiba_acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 35d899c01740..7cecb3a70b9c 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3374,7 +3374,7 @@ static const struct dmi_system_id toshiba_dmi_quirks[] __initconst = {
 
 static int toshiba_acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *acpi_dev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *acpi_dev;
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
@@ -3383,6 +3383,10 @@ static int toshiba_acpi_probe(struct platform_device *pdev)
 	if (toshiba_acpi)
 		return -EBUSY;
 
+	acpi_dev = ACPI_COMPANION(&pdev->dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
 	pr_info("Toshiba Laptop ACPI Extras version %s\n",
 	       TOSHIBA_ACPI_VERSION);
 
-- 
2.51.0




