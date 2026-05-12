Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729213AFB1A;
	Tue, 12 May 2026 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595541; cv=none; b=m5Mb5XFxtkxIUpQaNskJLsKkL57HEIQTkeY1gbTbdVrH72WeblKJ+xV6GwWwrm566TykU0EhxrwvyDUGrbMgOLQN3C8kMHebe37uWl+LAZ+2d9ua1ivKorLya7IqeSAERJPGPWoQpT4u3ALUpBUvg1cMfsgp/7EPUJwN0dkZFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595541; c=relaxed/simple;
	bh=ahzPT6UAWDbT7PALDgngC3gqR2efUL5mfqacmRL5TfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLia0VySgF/I/IKUz48fczlIqSRS1r+6CgcVXzhBuLmj3pZ0TNt1H9rfBzaTDcXfDNYleIGWBVIfrfo+mfKsRa9n4W0LEGHtrm7jLBXtuc227yzgfJo5DWKV2btES73CLRvPDfOpVO90fZTfkq1SrvG2RnusDjYgjsATgaYKQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilm0tbUZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilm0tbUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519B7C2BCF5;
	Tue, 12 May 2026 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595541;
	bh=ahzPT6UAWDbT7PALDgngC3gqR2efUL5mfqacmRL5TfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilm0tbUZzH1xLGosU3LviWQa+k73qSaXwMhA+ymoh4DE8Oi+oN4njs2DNikQPrlMq
	 4GP4/x8CCq3LdKljnJBUwkjf8OWpzG03Iho+ZjqNhACuyENAjIu+s1qRUuN/MZ2E8e
	 0/oZ4fEbIXOlTvmzclu5+p8sG1N49FeLPDy0NqgDZ7ZfVL2UXghWbKXs5Qsroa5KW+
	 PQOeYi61K/N/gKzZPqFgyLj1/5k0QmsaHd1NpW24PGnDKRZswtacacm7pkjzHxeK7r
	 WE1tgAyaUR9mPyprJsPfXmltE8ak8ecd8Tk64kNIJn+NTXYVEVLQLeWGhVfA+EP+O6
	 Hlfz3mh0ED8og==
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
 [PATCH v2 06/16] platform/x86: fujitsu-tablet: Check ACPI_COMPANION() against
 NULL
Date: Tue, 12 May 2026 16:09:58 +0200
Message-ID: <10861611.nUPlyArG6x@rafael.j.wysocki>
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

Accordingly, add requisite ACPI_COMPANION() checks against NULL to the
platform/x86 fujitsu-tablet driver.

Fixes: bd13b265d386 ("platform/x86: fujitsu-tablet: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/fujitsu-tablet.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/fujitsu-tablet.c b/drivers/platform/x86/fujitsu-tablet.c
index 8319df28e9b8..2f8c1b89cbca 100644
--- a/drivers/platform/x86/fujitsu-tablet.c
+++ b/drivers/platform/x86/fujitsu-tablet.c
@@ -445,10 +445,14 @@ static acpi_status fujitsu_walk_resources(struct acpi_resource *res, void *data)
 
 static int acpi_fujitsu_probe(struct platform_device *pdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev;
 	acpi_status status;
 	int error;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
 			fujitsu_walk_resources, NULL);
 	if (ACPI_FAILURE(status) || !fujitsu.irq || !fujitsu.io_base)
-- 
2.51.0




