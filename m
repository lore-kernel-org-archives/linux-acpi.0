From: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Mon, 1 Feb 2016 11:58:53 -0800
Message-ID: <CADaLNDmwLCJhUdVgZRgZyOrwOD_RA1L=_hG+bAHKBoAYRKwCRQ@mail.gmail.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35160 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbcBAT7Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2016 14:59:24 -0500
Received: by mail-ob0-f173.google.com with SMTP id xk3so29387897obc.2
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2016 11:59:23 -0800 (PST)
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, okaya@codeaurora.org, Jiang Liu <jiang.liu@linux.intel.com>, Stefano.Stabellini@eu.citrix.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu Dudau <Liviu.Dudau@arm.com>, ddaney@caviumnetworks.com, Thomas Gleixner <tglx@linutronix.de>, Yijing Wang <wangyijing@huawei.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.org, Jayachandran C <jchandra@broadcom.com>, Jon Masters <jcm@redhat.com>

On Wed, Jan 13, 2016 at 5:20 AM, Tomasz Nowicki <tn@semihalf.com> wrote:
> From the functionality point of view this series might be split into the
> following logic parts:
> 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
>    PCI config regions and used when necessary.
> 2. Move non-arch specific bits to the core code.
> 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
>
> Patches has been built on top of 4.4 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
>
> NOTE, this patch set depends on Matthew's patches:
> http://www.spinics.net/lists/linux-pci/msg45950.html
> https://github.com/Vality/linux/tree/pci-fixes
>
> This has been tested on Cavium ThunderX server and QEMU.
> Any help in reviewing and testing is very appreciated.

Hi Tomasz,

I tested your tree with APM X-Gene v1 and X-Gene v2 platforms and PCIe
came up fine on both platforms (with X-Gene ECAM fixup patch that I
will post separately). Thanks for your work and please feel free to
add my Tested-by.

Regards,
Duc Dang.

>
> v2 -> v3
> - fix legacy IRQ assigning and IO ports registration
> - remove reference to arch specific companion device for ia64
> - move ACPI PCI host controller driver to pci_root.c
> - drop generic domain assignment for x86 and ia64 as I am not
>   able to run all necessary test variants
> - drop patch which cleaned legacy IRQ assignment since it belongs to
>   Mathew's series:
>   https://patchwork.ozlabs.org/patch/557504/
> - extend MCFG quirk code
> - rebased to 4.4
>
> v1 -> v2
> - moved non-arch specific piece of code to dirver/acpi/ directory
> - fixed IO resource handling
> - introduced PCI config accessors quirks matching
> - moved ACPI_COMPANION_SET to generic code
>
> Liu Jiang (1):
>   ACPI, PCI: Refine the way to handle translation_offset for ACPI
>     resources
>
> Tomasz Nowicki (20):
>   x86, pci: Reorder logic of pci_mmconfig_insert() function
>   x86, pci, acpi: Move arch-agnostic MMCONFIG (aka ECAM) and ACPI code
>     out of arch/x86/ directory
>   pci, acpi, mcfg: Provide generic implementation of MCFG code
>     initialization.
>   x86, pci: mmconfig_{32,64}.c code refactoring - remove code
>     duplication.
>   x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM
>     driver.
>   XEN / PCI: Remove the dependence on arch x86 when PCI_MMCONFIG=y
>   pci, acpi, mcfg: Provide default RAW ACPI PCI config space accessors.
>   arm64, acpi: Use empty PCI config space accessors from mcfg.c file.
>   pci, acpi, ecam: Add flag to indicate whether ECAM region was hot
>     added or not.
>   x86, pci: Cleanup platform specific MCFG data using previously added
>     ECAM hot_added flag.
>   pci, acpi: Move ACPI host bridge device companion assignment to core
>     code.
>   x86, ia64, pci: Remove ACPI companion device from platform specific
>     data.
>   pci, acpi: Provide generic way to assign bus domain number.
>   x86, ia64: Include acpi_pci_{add|remove}_bus to the default
>     pcibios_{add|remove}_bus implementation.
>   acpi, mcfg: Implement two calls that might be used to inject/remove
>     MCFG region.
>   x86, acpi, pci: Use equivalent function introduced in previous patch.
>   acpi, mcfg: Add default PCI config accessors implementation and
>     initial support for related quirks.
>   pci, acpi: Support for ACPI based generic PCI host controller init
>   pci, acpi: Match PCI config space accessors against platfrom specific
>     quirks.
>   arm64, pci, acpi: Start using ACPI based PCI host bridge driver for
>     ARM64.
>
>  arch/arm64/Kconfig                 |   7 ++
>  arch/arm64/kernel/pci.c            |  25 ----
>  arch/ia64/hp/common/sba_iommu.c    |   2 +-
>  arch/ia64/include/asm/pci.h        |   1 -
>  arch/ia64/pci/pci.c                |  52 +++-----
>  arch/ia64/sn/kernel/io_acpi_init.c |   4 +-
>  arch/x86/Kconfig                   |   4 +
>  arch/x86/include/asm/pci.h         |   3 -
>  arch/x86/include/asm/pci_x86.h     |  28 +----
>  arch/x86/pci/acpi.c                |  41 ++----
>  arch/x86/pci/common.c              |  10 --
>  arch/x86/pci/irq.c                 |  10 --
>  arch/x86/pci/mmconfig-shared.c     | 250 ++++++-------------------------------
>  arch/x86/pci/mmconfig_32.c         |  11 +-
>  arch/x86/pci/mmconfig_64.c         |  67 +---------
>  arch/x86/pci/numachip.c            |   1 +
>  drivers/acpi/Kconfig               |   5 +
>  drivers/acpi/Makefile              |   1 +
>  drivers/acpi/mcfg.c                | 201 +++++++++++++++++++++++++++++
>  drivers/acpi/pci_root.c            | 136 +++++++++++++++++++-
>  drivers/acpi/resource.c            |  12 +-
>  drivers/pci/Kconfig                |  10 ++
>  drivers/pci/Makefile               |   5 +
>  drivers/pci/ecam.c                 | 234 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c                  |  29 ++++-
>  drivers/pci/probe.c                |   5 +
>  drivers/xen/pci.c                  |   7 +-
>  include/acpi/acpi_bus.h            |   1 +
>  include/asm-generic/vmlinux.lds.h  |   7 ++
>  include/linux/acpi.h               |   2 +
>  include/linux/ecam.h               |  62 +++++++++
>  include/linux/pci-acpi.h           |  17 +++
>  32 files changed, 802 insertions(+), 448 deletions(-)
>  create mode 100644 drivers/acpi/mcfg.c
>  create mode 100644 drivers/pci/ecam.c
>  create mode 100644 include/linux/ecam.h
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
