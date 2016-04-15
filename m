From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ACPI / ARM64: Don't enable ACPI by default on ARM64
Date: Fri, 15 Apr 2016 08:53:41 +0100
Message-ID: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:43566 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbcDOHyK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Apr 2016 03:54:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org, Mark Brown <broonie@kernel.org>

If ACPI is selectable it is enabled by default.  This is a good choice
for architectures where the overwhelming majority of systems use ACPI
like x86 and IA-64 but is less clear for architectures where it's less
common like ARM64.  Change the default selection so that it's only done
explicitly on those architectures where ACPI is universally used.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 82b96ee8624c..2fcf87a6d270 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -8,7 +8,7 @@ menuconfig ACPI
 	depends on IA64 || X86 || (ARM64 && EXPERT)
 	depends on PCI
 	select PNP
-	default y
+	default y if (IA64 || X86)
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
 	  Linux requires an ACPI-compliant platform (hardware/firmware),
-- 
2.8.0.rc3

