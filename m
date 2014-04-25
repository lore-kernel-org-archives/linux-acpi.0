From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 part1 06/11] ARM64 / ACPI: Introduce lowlevel suspend function
Date: Fri, 25 Apr 2014 21:20:12 +0800
Message-ID: <1398432017-8506-7-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:33747 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbaDYNXJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2014 09:23:09 -0400
Received: by mail-pb0-f51.google.com with SMTP id uo5so3192425pbc.24
        for <linux-acpi@vger.kernel.org>; Fri, 25 Apr 2014 06:23:08 -0700 (PDT)
In-Reply-To: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>

acpi_wakeup_address is used on x86 as the address bios jumps into
when machine wakes up from suspend. As arm64 does not have such a
bios this mechanism will be provided by other means. But the define
is still required inside the acpi core.

Introduce a null stub for acpi_suspend_lowlevel as this is also
required by core. This will be filled in when standards are
defined for arm64 ACPI global power states.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h |    4 ++++
 drivers/acpi/plat/arm-core.c  |    7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 3ac9dfb..60e3a72 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -85,6 +85,10 @@ static inline void acpi_disable_pci(void)
  */ 
 #define cpu_physical_id(cpu) -1
 
+/* Low-level suspend routine. */
+extern int (*acpi_suspend_lowlevel)(void);
+#define acpi_wakeup_address (0)
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
index e4846fd..aeea64e 100644
--- a/drivers/acpi/plat/arm-core.c
+++ b/drivers/acpi/plat/arm-core.c
@@ -129,3 +129,10 @@ static int __init parse_acpi(char *arg)
 	return 0;
 }
 early_param("acpi", parse_acpi);
+
+/*
+ * acpi_suspend_lowlevel() - save kernel state and suspend.
+ *
+ * TBD when ARM/ARM64 starts to support suspend...
+ */
+int (*acpi_suspend_lowlevel)(void);
-- 
1.7.9.5

