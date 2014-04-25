From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 part1 03/11] ARM64 : Add dummy asm/cpu.h
Date: Fri, 25 Apr 2014 21:20:09 +0800
Message-ID: <1398432017-8506-4-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:36921 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbaDYNWG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2014 09:22:06 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so3200581pbc.23
        for <linux-acpi@vger.kernel.org>; Fri, 25 Apr 2014 06:22:05 -0700 (PDT)
In-Reply-To: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>

ACPI core requires a cpu.h, add a dummy one here temporarily.
This file will be updated in the future to add definitions for
arch_(un)register_cpu which are required for ACPI based physical
CPU hotplug when these standards have be ratified by the ASWG.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/cpu.h |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpu.h

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
new file mode 100644
index 0000000..cee7d3f
--- /dev/null
+++ b/arch/arm64/include/asm/cpu.h
@@ -0,0 +1,11 @@
+/*
+ *  Copyright (C) 2013-2014 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_CPU_H
+#define __ASM_CPU_H
+
+#endif
-- 
1.7.9.5

