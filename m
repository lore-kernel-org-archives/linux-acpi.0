From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
Date: Wed, 29 Jul 2015 18:08:49 +0800
Message-ID: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33611 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbG2KJq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2015 06:09:46 -0400
Received: by padck2 with SMTP id ck2so3416319pad.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2015 03:09:45 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Timur Tabi <timur@codeaurora.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

When ACPI core patches were merged into mainline, there were two TODOs for
ACPI based GIC init, one is the Self-probing for GIC, the other one is to
support stacked irq domain, also the feature of GICv2m and GICv3 is missing
in that patch set.

For ACPI Self-probing for GIC, thanks to the GIC version which is introduced
in ACPI 6.0, we can match the GIC version and GIC driver, based on that,
we introduce the self-probe infrastructure similar as IRQCHIP_DECLARE(),
please see patch 1~3.

The stacked domain thing is more complicated, Marc introduced a patchset
to slove this problem (great thanks!) - Making the generic ACPI GSI layer
irqdomain aware, which is avaiable at:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gsi-irq-domain-v2

so we reworked the GICv2m and GICv3 support on top of it, and combined
them as a single patch set for review.

Note: this patchset has no ITS support for GICv3/4, it will be implmented
in the IORT patchset, which had a draft version but needs to rework it
on top of Marc's Per-device MSI domain & platform MSI patchset.

Tested on GICv2 based FVP base model and AMD Seattle platform, both wired
interrupt and MSI (with some PCI patches) work fine.

Patches are on top of Marc's branch irq/gsi-irq-domain-v2, and available
at:

git://git.linaro.org/leg/acpi/acpi.git gsi-irqdomain

Comments are warmly welcomed.

>From v3:
  - Rework GICv3 patches on top of Marc's tree
  - Add gicV2m support

Hanjun Guo (5):
  irqchip / GIC: Add GIC version support in ACPI MADT
  ACPI / irqchip: Add self-probe infrastructure to initialize IRQ
    controller
  irqchip / GIC / ACPI: Use IRQCHIP_ACPI_DECLARE to simplify GICv2 init
    code
  irqchip / GICv3: remove the useless comparision of device node in
    xlate
  irqchip / GICv3 / ACPI: Add GICR support via GICC structures

Suravee Suthikulpanit (3):
  ACPI: GIC: Add ACPI helper functions to query irq-domain tokens for
    for GIC MSI and ITS
  PCI: ACPI: Bind GIC MSI frame to PCI host bridge
  irqchip / gicv2m: Introducing gicv2m_acpi_init()

Tomasz Nowicki (2):
  irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
  irqchip / GICv3: Add ACPI support for GICv3+ initialization

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/irq.h         |  13 --
 arch/arm64/kernel/acpi.c             |  25 --
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/acpi_gic.c              | 234 +++++++++++++++++++
 drivers/irqchip/Kconfig              |   3 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-gic-acpi.c       | 175 ++++++++++++++
 drivers/irqchip/irq-gic-v2m.c        | 111 +++++++--
 drivers/irqchip/irq-gic-v3.c         | 438 +++++++++++++++++++++++++++++++----
 drivers/irqchip/irq-gic.c            |   6 +-
 drivers/pci/pci-acpi.c               |  18 ++
 drivers/pci/probe.c                  |   3 +
 include/acpi/acpi_gic.h              |  23 ++
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/acpi.h                 |  17 ++
 include/linux/acpi_irq.h             |   4 +-
 include/linux/irqchip.h              |  13 ++
 include/linux/irqchip/arm-gic-acpi.h |  10 +-
 include/linux/irqchip/arm-gic.h      |   7 +
 include/linux/mod_devicetable.h      |   8 +
 include/linux/pci-acpi.h             |   4 +
 22 files changed, 1009 insertions(+), 119 deletions(-)
 create mode 100644 drivers/acpi/acpi_gic.c
 create mode 100644 drivers/irqchip/irq-gic-acpi.c
 create mode 100644 include/acpi/acpi_gic.h

-- 
1.9.1

