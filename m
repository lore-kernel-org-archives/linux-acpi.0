From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 part1 10/11] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64
Date: Fri, 25 Apr 2014 21:20:16 +0800
Message-ID: <1398432017-8506-11-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50261 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbaDYNYh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2014 09:24:37 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so3181628pab.27
        for <linux-acpi@vger.kernel.org>; Fri, 25 Apr 2014 06:24:36 -0700 (PDT)
In-Reply-To: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>

ACPI reduced hardware mode is disabled by default, but ARM64
can only run properly in ACPI hardware reduced mode, so select
ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.

Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 834a74e7..c9e21a6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,5 +1,6 @@
 config ARM64
 	def_bool y
+	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-- 
1.7.9.5

