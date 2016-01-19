From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V3 00/10] Introduce ACPI world to GICv3 & ITS irqchip
Date: Tue, 19 Jan 2016 14:11:13 +0100
Message-ID: <1453209083-3358-1-git-send-email-tn@semihalf.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36981 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcASNL0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2016 08:11:26 -0500
Received: by mail-wm0-f41.google.com with SMTP id n5so111232220wmn.0
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jan 2016 05:11:25 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com, Tomasz Nowicki <tn@semihalf.com>

Patches base on Suravee's ACPI GICv2m support:
https://lkml.org/lkml/2015/12/10/475

The following git branch contains submitted patches along with
the useful patches from the test point of view (mainly ACPI ARM64 PCI support).
https://github.com/semihalf-nowicki-tomasz/linux.git (gicv3-its-acpi-v3)

Series has been tested on Cavium ThunderX server.

v2 -> v3
- rebased on top of 4.4
- fixes and improvements for redistributor init via GICC structures
- fixes as per kbuild reports

v1 -> v2
- rebased on top of 4.4-rc4
- use pci_msi_domain_get_msi_rid for requester ID to device ID translation

Hanjun Guo (1):
  irqchip / GICv3: remove gic root node in ITS

Tomasz Nowicki (9):
  irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
  irqchip / GICv3: Add ACPI support for GICv3+ initialization
  irqchip,GICv3,ACPI: Add redistributor support via GICC structures.
  irqchip, gicv3, its: Mark its_init() and its children as __init
  irqchip, GICv3, ITS: Refator ITS dt init code to prepare for ACPI.
  ARM64, ACPI, PCI: I/O Remapping Table (IORT) initial support.
  irqchip, gicv3, its: Probe ITS in the ACPI way.
  acpi, gicv3, msi: Factor out code that might be reused for ACPI
    equivalent.
  acpi, gicv3, its: Use MADT ITS subtable to do PCI/MSI domain
    initialization.

 drivers/acpi/Kconfig                     |   3 +
 drivers/acpi/Makefile                    |   1 +
 drivers/acpi/iort.c                      | 326 +++++++++++++++++++++++++++++
 drivers/irqchip/Kconfig                  |   1 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c |  85 ++++++--
 drivers/irqchip/irq-gic-v3-its.c         | 143 +++++++++----
 drivers/irqchip/irq-gic-v3.c             | 344 ++++++++++++++++++++++++++-----
 drivers/pci/msi.c                        |   3 +
 include/linux/iort.h                     |  38 ++++
 include/linux/irqchip/arm-gic-v3.h       |   2 +-
 10 files changed, 845 insertions(+), 101 deletions(-)
 create mode 100644 drivers/acpi/iort.c
 create mode 100644 include/linux/iort.h

-- 
1.9.1

