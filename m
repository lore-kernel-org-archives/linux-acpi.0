From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 0/8] Add self-probe infrastructure and stacked irqdomain support for ACPI based GICv2/3 init
Date: Fri, 10 Jul 2015 18:45:06 +0800
Message-ID: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33302 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbbGJKpZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jul 2015 06:45:25 -0400
Received: by pdbqm3 with SMTP id qm3so38644353pdb.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2015 03:45:25 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

This patch set introduce self-probe infrastructure to init IRQ
controllers and stacked irqdomain support for ACPI based GICv2/3
init.

This patch set add its support for GIC verion which is introduced
in ACPI 6.0, based on that, we introduce the self-probe infrastructure,
the self-probe infrastructure for ACPI GIC init is similar as
IRQCHIP_DECLARE() and based on the GIC version support in ACPI
MADT table. we match the GIC version and GIC driver and load
it.

After the self-probe infrastructure is ready, I cleanuped the GICv2
code to use the framework.

Patch 4 implement the stacked irqdomain support for GICv2 based on
the model of mapping interrupt and device in ACPI.

Patch 5~8 are ACPI based GICv3 init.

Any comments are warmly welcomed.

v2->v3:
 - Introduced a mechanism to match the GSI with its irqdomain instead of
   referring to the acpi_irq_domain in previous version

 - Add finding GICR base address in GICC structures in GICv3 code.

 - Address the comments from Lorenzo and Marc

 - Rebased on top of 4.2-rc1, since ACPICA patches were pushed to
   4.2 by Rafael, I removed ACPICA patches in previous version.

v1->v2:
 - Remove the gicv2/v3 related driver code in drivers/irqchip/irq-gic-acpi.c
   which I was trying to consolidate them in one file, then arm-gic.h and
   arm-gic-v3.h will be used separately within parent driver only

 - Drop the gsi_mutex patch

 - Use the GIC version to match the GIC driver, then no need to test
   for the version in each driver

 - Move acpi_irq_init() to drivers/irqchip/irq-gic-acpi.c instead of
   in drivers/acpi/irq.c. maybe we need to rename acpi_irq_init() as
   acpi_gic_init() but I keep that name to accommodate of_irq_init(),
   any objections please let me know.

update from RFC version:
 - Consolidate all the GIC init code into drivers/irqchip/irq-gic-acpi.c


Hanjun Guo (6):
  irqchip / GIC: Add GIC version support in ACPI MADT
  ACPI / irqchip: Add self-probe infrastructure to initialize IRQ
    controller
  irqchip / GIC / ACPI: Use IRQCHIP_ACPI_DECLARE to simplify GICv2 init
    code
  irqchip / gic: Add stacked irqdomain support for ACPI based GICv2 init
  irqchip / GICv3: Add stacked irqdomain support for ACPI based init
  irqchip / gicv3 / ACPI: Add GICR support via GICC structures

Tomasz Nowicki (2):
  irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
  irqchip / GICv3: Add ACPI support for GICv3+ initialization

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/acpi.h        |   1 -
 arch/arm64/include/asm/irq.h         |  13 --
 arch/arm64/kernel/acpi.c             |  25 --
 drivers/acpi/gsi.c                   |  78 +++++--
 drivers/irqchip/Kconfig              |   3 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-gic-acpi.c       | 171 ++++++++++++++
 drivers/irqchip/irq-gic-v3.c         | 427 ++++++++++++++++++++++++++++++-----
 drivers/irqchip/irq-gic.c            |  40 ++--
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/acpi.h                 |  21 ++
 include/linux/acpi_irq.h             |   4 +-
 include/linux/irqchip.h              |  13 ++
 include/linux/irqchip/arm-gic-acpi.h |  10 +-
 include/linux/mod_devicetable.h      |   8 +
 16 files changed, 695 insertions(+), 134 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-acpi.c

-- 
1.9.1

