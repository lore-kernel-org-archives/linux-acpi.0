Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF74657E8;
	Sat, 28 Feb 2026 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292512; cv=none; b=cwzRDRtHuspPyqUPcLQ4KmhA7rHbR94+vA6Nxll9npdq4mdUuptxmjAgYu4pBPtxflpszujPGPL5SA00L4CR3mY55rdOFwWJ2WLIHmzRNkB8RnYIf6k3ouq0Psw080ENx3pHCpCxRI4JFg2SeJsJiLkK2of1f/JE+Rb7Kl8jGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292512; c=relaxed/simple;
	bh=WAA+4Jswq8LzLLcEOF7eyHn+Y0Wrn/cOgXMCZ/evFtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2jLatf+9gURNDgrFVsFI/t7zYttW23fEXJN84l7yBe0Nq+BtT3v9QD1OUqHOY3zykzoixC3kzgmFj3QMa3GCsleU17oWFi3IPDBBG9CK0XFcpmW8dlSUz/B6pNwbNkao24hQXXe9vExMoTDGy95R9IX3N5GtC5WyqM9NFcLGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jidd/vXr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jidd/vXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AE1C19424;
	Sat, 28 Feb 2026 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772292512;
	bh=WAA+4Jswq8LzLLcEOF7eyHn+Y0Wrn/cOgXMCZ/evFtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jidd/vXrXHUcupKKOpt5Gtca9v/oP360ohxbQJhc/jb2m0YC48DEa0QLQpE99Uz+/
	 ihLjH31t+4ALsee+8SnCXp5pGA63ivCKOURfHyn9s2JPT9Mfz+Faf01LN004tQZhQj
	 QrGSfQ6p5MPBXsICn47ynwu6G/UGTkc3DRcjAUEaLsgBYkZVnCWONsaLzbbJDDXLjy
	 GBST9QulhIsOyCFfbWHUTHYHMiWi6axdGf7PUehVwJWpYZuL8tLp3CnkdrQzpD4A9j
	 nyn/+9ZFYgfQQudTXbUpqK5F23J2c518ZsK+l5rrn1CVzxjnxDTKbtKa6NO2KzRfnf
	 W9pWivCEAJ85g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 1/2] platform/x86: intel/rst: Convert ACPI driver to a platform one
Date: Sat, 28 Feb 2026 16:27:33 +0100
Message-ID: <3599223.QJadu78ljV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <8692017.NyiUUSuA9g@rafael.j.wysocki>
References: <8692017.NyiUUSuA9g@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Intel Rapid Start Technology (rst) ACPI
driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/rst.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/rst.c b/drivers/platform/x86/intel/rst.c
index f3a60e14d4c1..4bd10927aad9 100644
--- a/drivers/platform/x86/intel/rst.c
+++ b/drivers/platform/x86/intel/rst.c
@@ -5,6 +5,7 @@
 
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 MODULE_DESCRIPTION("Intel Rapid Start Technology Driver");
@@ -99,8 +100,9 @@ static struct device_attribute irst_timeout_attr = {
 	.store = irst_store_wakeup_time
 };
 
-static int irst_add(struct acpi_device *acpi)
+static int irst_probe(struct platform_device *pdev)
 {
+	struct acpi_device *acpi = ACPI_COMPANION(&pdev->dev);
 	int error;
 
 	error = device_create_file(&acpi->dev, &irst_timeout_attr);
@@ -114,8 +116,10 @@ static int irst_add(struct acpi_device *acpi)
 	return error;
 }
 
-static void irst_remove(struct acpi_device *acpi)
+static void irst_remove(struct platform_device *pdev)
 {
+	struct acpi_device *acpi = ACPI_COMPANION(&pdev->dev);
+
 	device_remove_file(&acpi->dev, &irst_wakeup_attr);
 	device_remove_file(&acpi->dev, &irst_timeout_attr);
 }
@@ -125,16 +129,15 @@ static const struct acpi_device_id irst_ids[] = {
 	{"", 0}
 };
 
-static struct acpi_driver irst_driver = {
-	.name = "intel_rapid_start",
-	.class = "intel_rapid_start",
-	.ids = irst_ids,
-	.ops = {
-		.add = irst_add,
-		.remove = irst_remove,
+static struct platform_driver irst_driver = {
+	.probe = irst_probe,
+	.remove = irst_remove,
+	.driver = {
+		.name = "intel_rapid_start",
+		.acpi_match_table = irst_ids,
 	},
 };
 
-module_acpi_driver(irst_driver);
+module_platform_driver(irst_driver);
 
 MODULE_DEVICE_TABLE(acpi, irst_ids);
-- 
2.51.0




