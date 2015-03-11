From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Wed, 11 Mar 2015 20:39:26 +0800
Message-ID: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:37723 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbbCKMkm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2015 08:40:42 -0400
Received: by pdbnh10 with SMTP id nh10so10989789pdb.4
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2015 05:40:41 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

This patch set already tested on multi platforms:
 - AMD Seattle board;
 - Cavium Thunder board;
 - Huawei D02 board;
 - Qualcomm ARM64 platform

This version 10 patch set address some minor comments and collect ACKs and
Reviewed-bys for v9:

 - new Acks from Rafael, Olof, Grant, Lorenzo
 - new way to handle typdef phys_cpuid_t which suggested by Rafael,
   but no functional change
 - Remove if(!phys) for early ioremappings
 - Rework sleep function for ARM64
 - Introduce linux/acpi_irq.h to hold acpi_irq_init()
 - Disable ACPI if not HW_REDUCED_ACPI compliant
 - Remove the doc of why ACPI on ARM

Thanks
Hanjun

Al Stone (4):
  ARM64 / ACPI: Get RSDP and ACPI boot-time tables
  ARM64 / ACPI: Introduce early_param "acpi=" to enable/disable ACPI
  ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on
    ARM64
  ARM64 / ACPI: additions of ACPI documentation for arm64

Graeme Gregory (6):
  ACPI: add arm64 to the platforms that use ioremap
  ACPI / sleep: Introduce CONFIG_ACPI_GENERIC_SLEEP
  ARM64 / ACPI: If we chose to boot from acpi then disable FDT
  ARM64 / ACPI: Get PSCI flags in FADT for PSCI init
  ARM64 / ACPI: Enable ARM64 in Kconfig
  Documentation: ACPI for ARM64

Hanjun Guo (8):
  ACPI / table: Use pr_debug() instead of pr_info() for MADT table
    scanning
  ARM64 / ACPI: Introduce PCI stub functions for ACPI
  ACPI / table: Print GIC information when MADT is parsed
  ARM64 / ACPI: Parse MADT for SMP initialization
  ACPI / processor: Introduce phys_cpuid_t for CPU hardware ID
  ACPI / processor: Make it possible to get CPU hardware ID via GICC
  ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and register device's gsi
  clocksource / arch_timer: Parse GTDT to initialize arch timer

Mark Salter (2):
  ARM64: allow late use of early_ioremap
  ACPI: fix acpi_os_ioremap for arm64

Tomasz Nowicki (1):
  irqchip: Add GICv2 specific ACPI boot support

 Documentation/arm64/acpi_object_usage.txt | 593 ++++++++++++++++++++++++++++++
 Documentation/arm64/arm-acpi.txt          | 505 +++++++++++++++++++++++++
 Documentation/kernel-parameters.txt       |   3 +-
 arch/arm64/Kconfig                        |   3 +
 arch/arm64/include/asm/acenv.h            |  18 +
 arch/arm64/include/asm/acpi.h             |  96 +++++
 arch/arm64/include/asm/cpu_ops.h          |   1 +
 arch/arm64/include/asm/fixmap.h           |   3 +
 arch/arm64/include/asm/irq.h              |  13 +
 arch/arm64/include/asm/pci.h              |   6 +
 arch/arm64/include/asm/psci.h             |   3 +-
 arch/arm64/include/asm/smp.h              |   5 +-
 arch/arm64/kernel/Makefile                |   1 +
 arch/arm64/kernel/acpi.c                  | 392 ++++++++++++++++++++
 arch/arm64/kernel/cpu_ops.c               |   2 +-
 arch/arm64/kernel/pci.c                   |  25 ++
 arch/arm64/kernel/psci.c                  |  78 ++--
 arch/arm64/kernel/setup.c                 |  21 +-
 arch/arm64/kernel/smp.c                   |   2 +-
 arch/arm64/kernel/time.c                  |   7 +
 arch/ia64/Kconfig                         |   1 +
 arch/ia64/kernel/acpi.c                   |   2 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/kernel/acpi/boot.c               |   2 +-
 drivers/acpi/Kconfig                      |   7 +-
 drivers/acpi/Makefile                     |   2 +-
 drivers/acpi/acpi_processor.c             |   7 +-
 drivers/acpi/bus.c                        |   3 +
 drivers/acpi/internal.h                   |   4 +
 drivers/acpi/osl.c                        |   6 +-
 drivers/acpi/processor_core.c             |  60 ++-
 drivers/acpi/tables.c                     |  52 ++-
 drivers/clocksource/arm_arch_timer.c      | 132 +++++--
 drivers/irqchip/irq-gic.c                 | 102 +++++
 drivers/irqchip/irqchip.c                 |   3 +
 include/acpi/acpi_io.h                    |   4 +
 include/acpi/processor.h                  |   6 +-
 include/linux/acpi.h                      |   8 +-
 include/linux/acpi_irq.h                  |  10 +
 include/linux/clocksource.h               |   6 +
 include/linux/irqchip/arm-gic-acpi.h      |  31 ++
 41 files changed, 2121 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/arm64/acpi_object_usage.txt
 create mode 100644 Documentation/arm64/arm-acpi.txt
 create mode 100644 arch/arm64/include/asm/acenv.h
 create mode 100644 arch/arm64/include/asm/acpi.h
 create mode 100644 arch/arm64/kernel/acpi.c
 create mode 100644 include/linux/acpi_irq.h
 create mode 100644 include/linux/irqchip/arm-gic-acpi.h

-- 
1.9.1

