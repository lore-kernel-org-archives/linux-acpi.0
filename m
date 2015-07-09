From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v7 3/8] ACPI: Decouple ACPI idle and ACPI processor drivers
Date: Thu,  9 Jul 2015 14:04:19 -0400
Message-ID: <da1eb99c0e128a4c8160537295045164d8fde00d.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35690 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbbGISEe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2015 14:04:34 -0400
Received: by qkbp125 with SMTP id p125so191103023qkb.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2015 11:04:34 -0700 (PDT)
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

This patch introduces a new Kconfig symbol, ACPI_PROCESSOR_IDLE,
which is auto selected by architectures which support the ACPI
based C states for CPU Idle management.

The processor_idle driver in its present form contains declarations
specific to X86 and IA64. Since there are no reasonable defaults
for other architectures e.g. ARM64, the driver is selected only by
the arch/x86/Kconfig.

This helps in decoupling the ACPI processor_driver from the ACPI
processor_idle driver which is useful for the upcoming alternative
patchwork for controlling CPU Performance (CPPC) and CPU Idle (LPI).

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/Kconfig     |  6 +++++-
 drivers/acpi/Makefile    |  3 ++-
 include/acpi/processor.h | 26 ++++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 00748dc..8a60b6e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -177,9 +177,13 @@ config ACPI_CPU_FREQ_PSS
 	  monitoring. It is required by several flavors of cpufreq
 	  performance-state drivers.
 
+config ACPI_PROCESSOR_IDLE
+	def_bool y
+	depends on X86 || IA64
+
 config ACPI_PROCESSOR
 	tristate "Processor"
-	select CPU_IDLE
+	select CPU_IDLE if ACPI_PROCESSOR_IDLE
 	depends on X86 || IA64
 	default y
 	help
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 62e32bd..0633af6 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -82,7 +82,8 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 
 # processor has its own "processor." module_param namespace
-processor-y			:= processor_driver.o processor_idle.o
+processor-y			:= processor_driver.o
+processor-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= processor_idle.o
 processor-$(CONFIG_ACPI_CPU_FREQ_PSS)	+= processor_perflib.o	\
 	processor_throttling.o processor_thermal.o
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index bedcab3..c071a92 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -369,13 +369,35 @@ static inline void acpi_processor_throttling_init(void) {}
 #endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
 
 /* in processor_idle.c */
+extern struct cpuidle_driver acpi_idle_driver;
+#ifdef CONFIG_ACPI_PROCESSOR_IDLE
 int acpi_processor_power_init(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr);
 int acpi_processor_cst_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
-extern struct cpuidle_driver acpi_idle_driver;
+#else
+static inline int acpi_processor_power_init(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_processor_power_exit(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_processor_cst_has_changed(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_processor_hotplug(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
-#ifdef CONFIG_PM_SLEEP
+#if defined(CONFIG_PM_SLEEP) & defined(CONFIG_ACPI_PROCESSOR_IDLE)
 void acpi_processor_syscore_init(void);
 void acpi_processor_syscore_exit(void);
 #else
-- 
1.9.1

