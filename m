From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 03/20] ARM64 / ACPI: Introduce the skeleton of _PDC related for ARM64
Date: Fri, 17 Jan 2014 20:24:57 +0800
Message-ID: <1389961514-13562-4-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63697 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaAQM3j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jan 2014 07:29:39 -0500
Received: by mail-pb0-f46.google.com with SMTP id ma3so4030230pbc.19
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jan 2014 04:29:39 -0800 (PST)
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>

The _PDC (Processor Driver Capabilities) object provides OSPM a
mechanism to convey to the platform the capabilities supported
by OSPM for processor power management.

OSPM evaluates _PDC prior to evaluating any other processor
power management objects returning configuration information.

This patch introduces the skeleton of _PDC related file to make
ACPI core can be compiled on ARM64.

Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h      |   32 ++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/processor.h |    2 ++
 arch/arm64/kernel/process.c        |    3 +++
 3 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/include/asm/acpi.h

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
new file mode 100644
index 0000000..cf19dc6
--- /dev/null
+++ b/arch/arm64/include/asm/acpi.h
@@ -0,0 +1,32 @@
+/*
+ *  Copyright (C) 2013, Al Stone <al.stone@linaro.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#ifndef _ASM_ARM64_ACPI_H
+#define _ASM_ARM64_ACPI_H
+
+static inline bool arch_has_acpi_pdc(void)
+{
+	return false;	/* always false for now */
+}
+
+static inline void arch_acpi_set_pdc_bits(u32 *buf)
+{
+	return;
+}
+
+#endif /*_ASM_ARM64_ACPI_H*/
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 45b20cd..50ce951 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -162,6 +162,8 @@ static inline void spin_lock_prefetch(const void *x)
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
+extern unsigned long    boot_option_idle_override;
+
 #endif
 
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index de17c89..13d3d7f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -89,6 +89,9 @@ void arch_cpu_idle_prepare(void)
 	local_fiq_enable();
 }
 
+unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
+EXPORT_SYMBOL(boot_option_idle_override);
+
 /*
  * This is our default idle handler.
  */
-- 
1.7.9.5

