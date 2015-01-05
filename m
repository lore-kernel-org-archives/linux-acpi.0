From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH v6 14/17] ARM64 / ACPI: Parse GTDT to initialize arch
 timer
Date: Mon, 5 Jan 2015 07:55:30 +0000
Message-ID: <D0CF9C94.CD69%suravee.suthikulpanit@amd.com>
References: <1420368918-5086-15-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1on0114.outbound.protection.outlook.com ([157.56.110.114]:44608
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751087AbbAEHzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jan 2015 02:55:36 -0500
In-Reply-To: <1420368918-5086-15-git-send-email-hanjun.guo@linaro.org>
Content-Language: en-US
Content-ID: <49B6EEC1D45AFD488824FE419745F1DC@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Charles.Garcia-Tobin@arm.com" <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 1/4/15, 04:55, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:

>Using the information presented by GTDT to initialize the arch
>timer (not memory-mapped).
>
>Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>---
> arch/arm64/kernel/time.c             |   7 ++
> drivers/clocksource/arm_arch_timer.c | 132
>++++++++++++++++++++++++++++-------
> include/linux/clocksource.h          |   6 ++
> 3 files changed, 118 insertions(+), 27 deletions(-)
>
>diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
>index 1a7125c..42f9195 100644
>--- a/arch/arm64/kernel/time.c
>+++ b/arch/arm64/kernel/time.c
>@@ -35,6 +35,7 @@
> #include <linux/delay.h>
> #include <linux/clocksource.h>
> #include <linux/clk-provider.h>
>+#include <linux/acpi.h>
> 
> #include <clocksource/arm_arch_timer.h>
> 
>@@ -72,6 +73,12 @@ void __init time_init(void)
> 
> 	tick_setup_hrtimer_broadcast();
> 
>+	/*
>+	 * Since ACPI or FDT will only one be available in the system,
>+	 * we can use acpi_generic_timer_init() here safely
>+	 */
>+	acpi_generic_timer_init();
>+
> 	arch_timer_rate = arch_timer_get_rate();
> 	if (!arch_timer_rate)
> 		panic("Unable to initialise architected timer.\n");
>diff --git a/drivers/clocksource/arm_arch_timer.c
>b/drivers/clocksource/arm_arch_timer.c
>index 6a79fc4..612f2a0 100644
>--- a/drivers/clocksource/arm_arch_timer.c
>+++ b/drivers/clocksource/arm_arch_timer.c
>@@ -21,6 +21,7 @@
> #include <linux/io.h>
> #include <linux/slab.h>
> #include <linux/sched_clock.h>
>+#include <linux/acpi.h>
> 
> #include <asm/arch_timer.h>
> #include <asm/virt.h>
>@@ -370,8 +371,12 @@ arch_timer_detect_rate(void __iomem *cntbase, struct
>device_node *np)
> 	if (arch_timer_rate)
> 		return;
> 
>-	/* Try to determine the frequency from the device tree or CNTFRQ */
>-	if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
>+	/*
>+	 * Try to determine the frequency from the device tree or CNTFRQ,
>+	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
>+	 */
>+	if (!acpi_disabled ||
>+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
> 		if (cntbase)
> 			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
> 		else
>@@ -690,28 +695,8 @@ static void __init arch_timer_common_init(void)
> 	arch_timer_arch_init();
> }
> 
>-static void __init arch_timer_init(struct device_node *np)
>+static void __init arch_timer_init(void)
> {
>-	int i;
>-
>-	if (arch_timers_present & ARCH_CP15_TIMER) {
>-		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
>-		return;
>-	}
>-
>-	arch_timers_present |= ARCH_CP15_TIMER;
>-	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
>-		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
>-	arch_timer_detect_rate(NULL, np);
>-
>-	/*
>-	 * If we cannot rely on firmware initializing the timer registers then
>-	 * we should use the physical timers instead.
>-	 */
>-	if (IS_ENABLED(CONFIG_ARM) &&
>-	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
>-			arch_timer_use_virtual = false;
>-
> 	/*
> 	 * If HYP mode is available, we know that the physical timer
> 	 * has been configured to be accessible from PL1. Use it, so
>@@ -730,13 +715,39 @@ static void __init arch_timer_init(struct
>device_node *np)
> 		}
> 	}
> 
>-	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>-
> 	arch_timer_register();
> 	arch_timer_common_init();
> }
>-CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer",
>arch_timer_init);
>-CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer",
>arch_timer_init);
>+
>+static void __init arch_timer_of_init(struct device_node *np)
>+{
>+	int i;
>+
>+	if (arch_timers_present & ARCH_CP15_TIMER) {
>+		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
>+		return;
>+	}
>+
>+	arch_timers_present |= ARCH_CP15_TIMER;
>+	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
>+		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
>+
>+	arch_timer_detect_rate(NULL, np);
>+
>+	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>+
>+	/*
>+	 * If we cannot rely on firmware initializing the timer registers then
>+	 * we should use the physical timers instead.
>+	 */
>+	if (IS_ENABLED(CONFIG_ARM) &&
>+	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
>+			arch_timer_use_virtual = false;
>+
>+	arch_timer_init();
>+}
>+CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer",
>arch_timer_of_init);
>+CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer",
>arch_timer_of_init);

Hanjun,

FYI, it seems that the tree that you have rebased the patch series has an
issue determining clocksource in ARM64 introduced by this commit.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0
b46b8a718c6e90910a1b1b0fe797be3c167e186

Here is the fix from Catalin that already went upstream:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drive
rs/clocksource/arm_arch_timer.c?id=d6ad36913083d683aad4e02e53580c995f1a6ede

Thanks,

Suravee


