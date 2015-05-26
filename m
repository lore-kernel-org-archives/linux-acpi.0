From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 00/11] ARM64 PCI hostbridge init based on ACPI
Date: Tue, 26 May 2015 20:49:13 +0800
Message-ID: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>, Yijing Wang <wangyijing@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

This patch set is introducing ARM64 PCI hostbridge init based on ACPI,
which based on Jiang Liu's patch set "Consolidate ACPI PCI root common
code into ACPI core":

https://lkml.org/lkml/2015/5/14/98

This patch set including three parts:

  - the first part is PATCH 1, which should be merged into Jiang Liu's 
    patch set to fix the compile error on ARM64 when ACPI enabled.

  - the senconed part is the refactoring of mmconfig to let that mechanism
    can be used for ARM64 too, it's Tomasz's work but he is moving to other
    work and pretty busy for now, so I will take care of those patches, 
    Tomasz will show up when some comments need to be addressed :)

    In this version of mmconfig refactor patches, I removed the rename
    of mmconfig -> ecam patch, because mmconfig is in multi places, and need
    much more effort to convert them all to ecam, Bjorn, if you don't
    like it, I can add them back.

  - The third part is about the ARM64 PCI hostbridge init based on ACPI,
    first I fixed a compile error for XEN PCI on ARM64 when PCI_MMCONFIG=y,
    and then introduce PCI init based on Jiang Liu and Tomasz's patch set.

patch for ARM64 ACPI PCI still reserve the bus sysdata to get the domain
number, because Yijing's patch set is still under review, will be removed
when Yijing's patch set hits upstream.

This patch set was tested by Suravee on Seattle board with legacy interrupt
(not MSI), and it works, also tested on qemu by Graeme.

You can get the code from:
git://git.linaro.org/leg/acpi/acpi.git, devel branch

Comments are welcomed.

Thanks
Hanjun


Hanjun Guo (3):
  ARM64 / PCI: introduce struct pci_controller for ACPI
  XEN / PCI: Remove the dependence on arch x86 when PCI_MMCONFIG=y
  ARM64 / PCI / ACPI: support for ACPI based PCI hostbridge init

Tomasz Nowicki (8):
  x86, pci: Clean up comment about buggy MMIO config space access for
    AMD Fam10h CPUs.
  x86, pci: Abstract PCI config accessors and use AMD Fam10h workaround
    exclusively.
  x86, pci: Reorder logic of pci_mmconfig_insert() function
  x86, pci, acpi: Move arch-agnostic MMCONFIG (aka ECAM) and ACPI code
    out of arch/x86/ directory
  pci, acpi, mcfg: Provide generic implementation of MCFG code
    initialization.
  x86, pci: mmconfig_{32,64}.c code refactoring - remove code
    duplication.
  x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM
    driver.
  pci, acpi, mcfg: Share ACPI PCI config space accessors.

 arch/arm64/Kconfig             |   7 +
 arch/arm64/include/asm/pci.h   |  10 ++
 arch/arm64/kernel/pci.c        | 245 ++++++++++++++++++++++++++--
 arch/x86/Kconfig               |   4 +
 arch/x86/include/asm/pci_x86.h |  34 +---
 arch/x86/pci/Makefile          |   4 +-
 arch/x86/pci/acpi.c            |   1 +
 arch/x86/pci/mmconfig-shared.c | 301 +++++++++++-----------------------
 arch/x86/pci/mmconfig_32.c     |  35 +---
 arch/x86/pci/mmconfig_64.c     | 153 ------------------
 arch/x86/pci/numachip.c        |  25 +--
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/mcfg.c            | 103 ++++++++++++
 drivers/pci/Kconfig            |  10 ++
 drivers/pci/Makefile           |   5 +
 drivers/pci/ecam.c             | 358 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c              |  26 +--
 drivers/xen/pci.c              |   7 +-
 include/linux/acpi.h           |   2 +
 include/linux/ecam.h           |  56 +++++++
 20 files changed, 923 insertions(+), 464 deletions(-)
 delete mode 100644 arch/x86/pci/mmconfig_64.c
 create mode 100644 drivers/acpi/mcfg.c
 create mode 100644 drivers/pci/ecam.c
 create mode 100644 include/linux/ecam.h

-- 
1.9.1
