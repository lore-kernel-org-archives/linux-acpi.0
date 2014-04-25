From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 part1 00/11] Enable ACPI on ARM64 in Kconfig
Date: Fri, 25 Apr 2014 21:20:06 +0800
Message-ID: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:54887 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbaDYNUk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2014 09:20:40 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so3201733pbc.18
        for <linux-acpi@vger.kernel.org>; Fri, 25 Apr 2014 06:20:40 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

This patch set is the first part of ARM64 ACPI core patches to
running ACPI on ARM64, it just handle some compile errors when
ACPI is introduced to ARM64 platform and enable ACPI on ARM64
in Kconfig.

Following core patch sets for ACPI based SMP/GIC/Arch Timer
initialization to enable ACPI on ARM64 are still waited untill
some ACPI proposals approved by ASWG.

This patch set is based on 3.15-rc2 and PCI patches for ARM64 from
Liviu:
Support for creating generic host_bridge from device tree
https://lkml.org/lkml/2014/3/14/279

Add support for PCI in AArch64
http://comments.gmane.org/gmane.linux.ports.arm.kernel/309392

We did 3 review cycles inside linaro ACPI team, and I had compiled
all the patches ok on arm64 with:
- CONFIG_ACPI=n and CONFIG_PCI=n;
- CONFIG_ACPI=n and CONFIG_PCI=y;
- CONFIG_ACPI=y and CONFIG_PCI=y;
And compiled ok on x86.

Changes since v2:
- Make ACPI depend on PCI on ARM64
- rework all the patches and seperate some of the patches
  into fine-grained, and add some comments and changelog to
  make it easier for review.

Hanjun Guo (11):
  ACPI / processor: Rework _PDC related stuff to make it more
    arch-independent
  ARM64 / ACPI: Introduce the skeleton of _PDC related for ARM64
  ARM64 : Add dummy asm/cpu.h
  ARM64 / ACPI: Introduce arm-core.c and its related head file
  ARM64 / ACPI: Introduce early_param for "acpi"
  ARM64 / ACPI: Introduce lowlevel suspend function
  ARM64 / ACPI: Introduce arch_fix_phys_package_id() for cpu topology
  ARM64 / ACPI: Introduce PCI functions for ACPI on ARM64
  ARM64 / ACPI: Enable ARM64 in Kconfig
  ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on
    ARM64
  ACPI: Make EC depend on X86 || IA64 in Kconfig

 arch/arm64/Kconfig                |    3 +
 arch/arm64/include/asm/acpi.h     |   94 +++++++++++++++++++++++++
 arch/arm64/include/asm/cpu.h      |   11 +++
 arch/arm64/include/asm/pci.h      |   11 +++
 arch/arm64/include/asm/topology.h |    2 +
 arch/arm64/kernel/pci.c           |   34 +++++++++
 arch/arm64/kernel/setup.c         |    4 ++
 arch/arm64/kernel/topology.c      |   14 ++++
 arch/ia64/include/asm/acpi.h      |    5 +-
 arch/ia64/kernel/acpi.c           |   15 ++++
 arch/x86/include/asm/acpi.h       |   19 +----
 arch/x86/kernel/acpi/cstate.c     |   27 ++++++++
 drivers/acpi/Kconfig              |    6 +-
 drivers/acpi/Makefile             |    2 +
 drivers/acpi/plat/Makefile        |    1 +
 drivers/acpi/plat/arm-core.c      |  138 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/processor_core.c     |   19 +----
 17 files changed, 363 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm64/include/asm/acpi.h
 create mode 100644 arch/arm64/include/asm/cpu.h
 create mode 100644 drivers/acpi/plat/Makefile
 create mode 100644 drivers/acpi/plat/arm-core.c

-- 
1.7.9.5

