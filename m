From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [RFC PATCH 0/9] Add self-probe infrastructure and stacked irqdomain support for ACPI based GICv2/3 init
Date: Tue,  5 May 2015 21:50:48 +0800
Message-ID: <1430833857-30736-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33445 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992653AbbEENvt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2015 09:51:49 -0400
Received: by pdbnk13 with SMTP id nk13so196705044pdb.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2015 06:51:49 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

This patch set introduce self-probe infrastructure to init IRQ
controllers and stacked irqdomain support for ACPI based GICv2/3
init.

The self-probe infrastructure for ACPI GIC init is similar as
IRQCHIP_DECLARE() and based on the GIC version support in ACPI
MADT table.

We introduce acpi_irq_domain for GICv2/3 core domain to support
stacked irqdomain, and pass the gsi (global system interrupt) as
the agument (void *arg) for gic_irq_domain_alloc(), then we can
alloc virqs via acpi_register_gsi() with stacked irqdomain.

I already compiled this patch set ok with both ACPI=on/off on
ARM64 and also compiled ok on x86, tested with GICv2 init on
FVP model and it boot successfully.

Next step I would consolidate all the ACPI GIC init into one
file -- drivers/irqchip/irq-gic-acpi.c, and introduce ITS and
IORT support.

please comment on this patchset to see if we are on the right
direction.

Hanjun Guo (6):
  irqchip / gic: Add GIC version support in ACPI MADT
  irqchip: gic: ACPI: Use IRQCHIP_ACPI_DECLARE to simplify GICv2 init
    code
  irqchip / gic: Add stacked irqdomain support for ACPI based GICv2 init
  ACPI / gsi: Add gsi_mutex to synchronize
    acpi_register_gsi()/acpi_unregister_gsi()
  irqchip / GICv3: Add ACPI support for GICv3+ initialization
  irqchip / GICv3: Add stacked irqdomain support for ACPI based init

Tomasz Nowicki (3):
  ACPICA: Introduce GIC version for arm based system
  ACPI / irqchip: Add self-probe infrastructure to initialize IRQ
    controller
  irqchip / GICv3: Refactor gic_of_init() for GICv3 driver

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/irq.h         |  13 --
 arch/arm64/kernel/acpi.c             |  25 ----
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/gsi.c                   |  39 ++---
 drivers/acpi/irq.c                   |  40 ++++++
 drivers/irqchip/Kconfig              |   3 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-gic-acpi.c       | 116 +++++++++++++++
 drivers/irqchip/irq-gic-v3.c         | 267 ++++++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic.c            |  38 ++---
 drivers/irqchip/irqchip.h            |  12 ++
 include/acpi/actbl1.h                |  17 ++-
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/acpi.h                 |  14 ++
 include/linux/acpi_irq.h             |   4 +-
 include/linux/irqchip/arm-gic-acpi.h |  12 +-
 include/linux/mod_devicetable.h      |   7 +
 18 files changed, 489 insertions(+), 134 deletions(-)
 create mode 100644 drivers/acpi/irq.c
 create mode 100644 drivers/irqchip/irq-gic-acpi.c

-- 
1.9.1

