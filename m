From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v4 05/18] ARM64 / ACPI: Introduce sleep-arm.c
Date: Fri, 12 Sep 2014 22:00:03 +0800
Message-ID: <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Graeme Gregory <graeme.gregory@linaro.org>

ACPI 5.1 does not currently support S states for ARM64 hardware but
ACPI code will call acpi_target_system_state() for device power
managment, so introduce sleep-arm.c to allow other drivers to function
until S states are defined.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Makefile    |    4 ++++
 drivers/acpi/sleep-arm.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 drivers/acpi/sleep-arm.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 505d4d7..89837f8 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -23,7 +23,11 @@ acpi-y				+= nvs.o
 
 # Power management related files
 acpi-y				+= wakeup.o
+ifeq ($(ARCH), arm64)
+acpi-y				+= sleep-arm.o
+else # X86, IA64
 acpi-y				+= sleep.o
+endif
 acpi-y				+= device_pm.o
 acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
 
diff --git a/drivers/acpi/sleep-arm.c b/drivers/acpi/sleep-arm.c
new file mode 100644
index 0000000..54578ef
--- /dev/null
+++ b/drivers/acpi/sleep-arm.c
@@ -0,0 +1,28 @@
+/*
+ *  ARM64 Specific Sleep Functionality
+ *
+ *  Copyright (C) 2013-2014, Linaro Ltd.
+ *      Author: Graeme Gregory <graeme.gregory@linaro.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+
+/*
+ * Currently the ACPI 5.1 standard does not define S states in a
+ * manner which is usable for ARM64. These two stubs are sufficient
+ * that system initialises and device PM works.
+ */
+u32 acpi_target_system_state(void)
+{
+	return ACPI_STATE_S0;
+}
+EXPORT_SYMBOL_GPL(acpi_target_system_state);
+
+int __init acpi_sleep_init(void)
+{
+	return -ENOSYS;
+}
-- 
1.7.9.5
