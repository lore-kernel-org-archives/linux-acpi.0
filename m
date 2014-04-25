From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 part1 11/11] ACPI: Make EC depend on X86 || IA64 in Kconfig
Date: Fri, 25 Apr 2014 21:20:17 +0800
Message-ID: <1398432017-8506-12-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:58034 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbaDYNYy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2014 09:24:54 -0400
Received: by mail-pd0-f175.google.com with SMTP id fp1so973136pdb.6
        for <linux-acpi@vger.kernel.org>; Fri, 25 Apr 2014 06:24:54 -0700 (PDT)
In-Reply-To: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

Since EC (Embedded controller) needs SCI for the interupt which
is not available on ARM64, make it depend on X86 || IA64 only
in the Kconfig file.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ae45088..391325c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -49,6 +49,7 @@ config ACPI_SLEEP
 
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
+	depends on X86 || IA64
 	default n
 	help
 	  Say N to disable Embedded Controller /sys/kernel/debug interface
-- 
1.7.9.5

