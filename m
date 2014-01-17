From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 02/20] ARM64 : Add dummy asm/cpu.h
Date: Fri, 17 Jan 2014 20:24:56 +0800
Message-ID: <1389961514-13562-3-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:42047 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbaAQM2q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jan 2014 07:28:46 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so2495194pab.7
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jan 2014 04:28:46 -0800 (PST)
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com, Hanjun Guo <hanjun.guo@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>

ACPI requires a cpu.h, add a dummy one copied from arm. This will need
updated or replaced as ACPI based cpu hotplug or cpu topology for armv8
is worked out.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/cpu.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpu.h

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
new file mode 100644
index 0000000..8625eb1
--- /dev/null
+++ b/arch/arm64/include/asm/cpu.h
@@ -0,0 +1,25 @@
+/*
+ *  Copyright (C) 2004-2005 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARM_CPU_H
+#define __ASM_ARM_CPU_H
+
+#include <linux/percpu.h>
+#include <linux/cpu.h>
+#include <linux/topology.h>
+
+struct cpuinfo_arm {
+	struct cpu	cpu;
+	u64		cpuid;
+#ifdef CONFIG_SMP
+	unsigned int	loops_per_jiffy;
+#endif
+};
+
+DECLARE_PER_CPU(struct cpuinfo_arm, cpu_data);
+
+#endif
-- 
1.7.9.5

