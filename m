From: Hanna Hawa <hhhawa@amazon.com>
Subject: [PATCH 0/7] al-msi: Rename driver and add support for ACPI
Date: Sun, 31 Mar 2019 15:34:08 +0300
Message-ID: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: ronenk@amazon.com, dwmw@amazon.co.uk, vaerov@amazon.com, zeev@amazon.com, alisaidi@amazon.com, talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com, barakw@amazon.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This series includes three major changes:
1. IOMMU DMA mapping MSI message fix.
2. Re-name the AL-MSIx driver to new name convention.
3. Add ACPI support for the driver.

Alpine is the name of the SoC family, while AL stands for Annapurna
Labs. Rename to the latter since the driver will appear in other SoC
families other than Alpine.

The AL-MSIx controller is not standard, is not included in the UEFI
specification, and will not be added. The driver ACPI binding is
performed when the following conditions are true:
- OEM ID is AMAZON
- MADT table type is 0x80 (part of the OEM reserved range).

GICv2m driver is called from context of parent interrupt controller,
which ensures that the parent interrupt domain exists and holds valid
information. As calling AL-MSIx driver from GICv3 driver would not make
sense, a new API was added, to get the GSI IRQ domain that was registered
by GICv3 driver in the ACPI framework.

Hanna Hawa (7):
  irqchip/alpine-msi: Call IOMMU DMA mapping MSI message hook
  irqchip/alpine-msi: Update driver license to use SPDX
  irqchip/al-msi: Rename AL-MSIx driver
  irqchip/al-msi: Update wrong parameter naming
  ACPI / irq: Add GSI IRQ domain getter function
  irqchip/al-msi: Refactor in preparation to add ACPI support
  irqchip/al-msi: Add ACPI support

 arch/arm/mach-alpine/Kconfig                       |   2 +-
 arch/arm64/Kconfig.platforms                       |   2 +-
 drivers/acpi/irq.c                                 |  13 +
 drivers/irqchip/Kconfig                            |   2 +-
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/{irq-alpine-msi.c => irq-al-msi.c} | 320 ++++++++++++++-------
 include/linux/acpi.h                               |   1 +
 7 files changed, 236 insertions(+), 106 deletions(-)
 rename drivers/irqchip/{irq-alpine-msi.c => irq-al-msi.c} (40%)

-- 
2.7.4
