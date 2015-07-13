From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 0/8] Introducing ACPI support for GICv2m
Date: Mon, 13 Jul 2015 16:14:16 +0700
Message-ID: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0128.outbound.protection.outlook.com ([65.55.169.128]:9660
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750724AbbGMJOu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Jul 2015 05:14:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org
Cc: rjw@rjwysocki.net, al.stone@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, msalter@redhat.com, grant.likely@linaro.org, leo.duran@amd.com, sherry.hurwitz@amd.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

ACPI core patches for ARM64 are now upstreamed in 4.1. The PCI support
patches for ARM64 ACPI are also in progress. I am sending out this RFC to
introduce ACPI support for GICv2m. This would allow MSI to work when
booting ACPI.

There are some modifications to the irq_domain and acpi/gsi code.

Due to a large number of prerequisite patches, I have put together a branch
on GitHub for review and testing:

	https://github.com/ssuthiku/linux.git acpi-pci-msi-rfc2

This branch has been tested on AMD Seattle Platform. Any feedback and
comments are appreciated.

Thank you in advance,

Suravee

Changes in RFC2:
    - Rebased to V3 of Introducing per-device MSI domain
      (from Marc Zyngier)
    - Rebased to V2 of Add seld-probe infrastructure and stacked
      irqdomain support for APCI based GICv2/3 init
      (from Hanjun Guo)
    - Introduce GIC MSI frame handle.

Suravee Suthikulpanit (8):
  irqdomain: Introduce irq_domain_ops.init_alloc_info
  gic: Introduce gic_init_irq_alloc_info()
  gicv2m: Convert to use GIC irq_domain_ops.init_alloc_info
  acpi: gsi: Adding acpi_init_irq_alloc_info() hook
  arm64: Adding arch-specific acpi_init_irq_alloc_info
  gic: acpi: Introduce GIC MSI frame handle and helper functions
  gicv2m: Introducing gicv2m_acpi_init()
  pci: acpi: Bind GICv2m MSI frame to PCI host bridge

 arch/arm64/kernel/acpi.c             |  13 ++++
 drivers/acpi/gsi.c                   |  36 ++++++++--
 drivers/irqchip/irq-gic-acpi.c       |  78 +++++++++++++++++++++
 drivers/irqchip/irq-gic-v2m.c        | 129 ++++++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic.c            |  85 +++++++++++++++++++----
 drivers/pci/pci-acpi.c               |  35 ++++++++++
 drivers/pci/probe.c                  |   2 +
 include/linux/irqchip/arm-gic-acpi.h |   3 +
 include/linux/irqchip/arm-gic.h      |  24 +++++++
 include/linux/irqdomain.h            |   2 +
 include/linux/pci-acpi.h             |   1 +
 kernel/irq/irqdomain.c               |  10 ++-
 12 files changed, 372 insertions(+), 46 deletions(-)

-- 
2.1.0

