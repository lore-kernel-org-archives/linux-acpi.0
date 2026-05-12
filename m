Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083E3AEB26;
	Tue, 12 May 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595536; cv=none; b=L5GBCsKF/u2fgDOa4mc54X7TaA6KqGhKdlMtF553WropQhInLddvz5ovNqeYBaR0nA2nhmHO8OKbhQlS9B0MrEydOIpI4TsqzX/cbpzOopVL0us1I93gEwgE0L4repcU/Halp2/kD7tz5S8sqck0u0h6s93wNtjXQXyJJfBKCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595536; c=relaxed/simple;
	bh=f1ohu5KvCd3H/kuOsyVypZJLLbyP2v8vIcNkScJ4obs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDXXUuO7xUDQSHcza+6L/37zmoaG7IG5L5WeCN+iYzPsXDS6PJUjsmrvtaGwmOVCD1WPYSPWdfdzwynb5KAQXrZvZTUImAKXyAE27PcGRHXBt9zHatP2BEHaF0KchBRXkA7hAdfWqGJRqEVdDfRB3CgqzAji05gnV+vFi8tb4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJDZi/lQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJDZi/lQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCCAC2BCF5;
	Tue, 12 May 2026 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595536;
	bh=f1ohu5KvCd3H/kuOsyVypZJLLbyP2v8vIcNkScJ4obs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJDZi/lQZlI1K8FfrZKpgovc2Dkcc987VIIxC+oQItefNnV6/8TO2E9+hAXYWZhlZ
	 DTcNqT1flnr4sCDSV2rjQnZb2/cdxWnUHbRgVXzZshjBxiQTtqTCrPNp78tAjY8mwc
	 qb4zmFOKNRKfQj6KuQKT8/ltlE1s5gpZ45uIHBS7uBh/5uPV/FMKD8W/ArUtQWGREc
	 irPbf8LUVHiqewrG3EQpiA0Hph+y5sSOPqjQUo11BVroLdV8mlAAbPsmb+97x24/CJ
	 D3fEYWD7rSN/Fp3i+4yovXV92lonP3g8KMqTeI70ZgFpqHyGzPWf2aBSuf05dVROWe
	 a35X4EtHUpPrQ==
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
 [PATCH v2 07/16] platform/x86: intel/rst: Check ACPI_COMPANION() against NULL
Date: Tue, 12 May 2026 16:11:00 +0200
Message-ID: <2051525.PYKUYFuaPT@rafael.j.wysocki>
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
platform/x86 intel/rst driver.

Fixes: 163a68a31f74 ("platform/x86: intel/rst: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/rst.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/rst.c b/drivers/platform/x86/intel/rst.c
index 4bd10927aad9..bb19f0d89305 100644
--- a/drivers/platform/x86/intel/rst.c
+++ b/drivers/platform/x86/intel/rst.c
@@ -102,9 +102,13 @@ static struct device_attribute irst_timeout_attr = {
 
 static int irst_probe(struct platform_device *pdev)
 {
-	struct acpi_device *acpi = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *acpi;
 	int error;
 
+	acpi = ACPI_COMPANION(&pdev->dev);
+	if (!acpi)
+		return -ENODEV;
+
 	error = device_create_file(&acpi->dev, &irst_timeout_attr);
 	if (unlikely(error))
 		return error;
-- 
2.51.0




