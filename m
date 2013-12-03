From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [RFC part1 PATCH 2/7] ARM64 : Add dummy asm/cpu.h
Date: Wed,  4 Dec 2013 00:36:46 +0800
Message-ID: <1386088611-2801-3-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>
List-Id: linux-acpi@vger.kernel.org

ACPI requires a cpu.h, add a dummy one copied from arm. This will need
updated or replaced as ACPI based cpu hotplug for armv8 is worked out.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/cpu.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpu.h

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
new file mode 100644
index 0000000..dbeb98d
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
+	u32		cpuid;
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
