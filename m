From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH v2 0/6] call _OSC support during root bridge discovery
Date: Thu, 30 Oct 2008 18:08:31 +0900
Message-ID: <4909798F.6010604@jp.fujitsu.com>
References: <20081030052746.10259.22045.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081030052746.10259.22045.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

Andrew Patterson wrote:
> This is v2 of the "call _OSC support during root bridge discovery"
> patchset.  At Bjorn Helgaas's suggestion, I have merged all the MSI
> handling patches into one patch. Kenji Kaneshige also noted that I was
> not checking aspm_disabled before setting ASPM _OSC capabilities. This
> has been fixed.
> 
> Kenji also noted that the pci_msi_enable can be changed in various
> quirks after root bridge discovery, resulting in the incorrect setting
> of the MSI _OSC capability. I do not yet have a solution for this problem.
> 

Unfortunately, I don't have good idea about it yet too. In addition,
I don't understand how to handle the case if a feature is supported
but disabled by OS, from the PCI firmware spec.

If we should not set _OSC capabilities when it is supported but
disabled by OS, maybe we need also consider what we should do for
OSC_EXT_PCI_CONFIG_SUPPORT and OSC_PCI_SEGMENT_GROUPS_SUPPORT
if mmconfig is disabled, as well as aspm_disabled and pci_msi_enable.

By the way, Taku Izumi plan to post some patches to reduce _OSC
evaluation for _OSC control soon. I'm appreciate it if you will try
it on your big server.

Thanks,
Kenji Kaneshige




> I still need Matthew Wilcox to sign off on the first two patches.
> 
> 
> I recently reported a problem where a machine with close to a 100 PCIe
> root bridges was taking half an hour to just call _OSC.  The root
> cause is the AER code calling:
> 
>         pcie_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);
> 
> for each bridge.  The pcie_osc_support_set() function also iterates
> over each bridge, so _OSC is called a quadratic number of times.
> 
> One solution to this problem would be to just move the call to
> pcie_osc_support_set() to aer_service_init(), so _OSC support is only
> called on each bridge once.
> 
> Matthew Wilcox came up with a better solution.  He says "Why should a
> driver be calling pcie_osc_support_set() anyway?  This is something
> the PCI core should be taking care of for it."
> 
> Matthew provided a patch for this solution that I massaged into the
> following patch series.
> 
> It creates a new function (pci_acpi_osc_support()) which is called
> from pci_root.c before we call any other methods on the device (as
> recommended by the ACPI spec).  Since we know what capabilities the
> system supports, individual modules do not now need to inform the core
> of their support for various capabilities.
> 
> Some work that still needs to be done (provided by Matthew): 
> 
> o All the existing _OSC code should be moved from pci-acpi.c to
>   pci_root.c.  I also think the acpi_osc_data should be made part of
>   the acpi_pci_root struct, eliminating a separate allocation.
> 
> o We could also use an interface that iterates over all existing
>   busses calling _OSC with new flags.  Shouldn't be hard, once it's
>   integrated into pci_root.c.
> 
> o Further ahead, we don't actually check that the bits we asked for
>   (in 'control') were actually granted to us.  The PCI firmware spec
>   is quite explicit about interdependencies amongst the bits.
> 
> o We also need to re-evaluate _OSC when coming out of S4.
> 
> This patch series duplicates currently functionality while removing
> our quadratic problem.  I believe that it can be applied now while the
> above new functionality can be implemented some time in the future.
> 
> This patch series applies to the linux-next branch of pci-2.6 git
> repository.  I expect it will also work with linux-next.
> 
> Diff stats:
> 
>  drivers/acpi/pci_root.c            |   12 ++++++++++++
>  drivers/pci/msi.c                  |   31 +++++++++++-------------------
>  drivers/pci/pci-acpi.c             |   37 +++++++++++++-----------------------
>  drivers/pci/pci.c                  |    2 --
>  drivers/pci/pci.h                  |    2 --
>  drivers/pci/pcie/aer/aerdrv_acpi.c |    1 -
>  drivers/pci/pcie/aspm.c            |   27 +++++++++-----------------
>  include/linux/pci-acpi.h           |   14 +++-----------
>  include/linux/pci.h                |   14 ++++++++++++++
>  9 files changed, 62 insertions(+), 78 deletions(-)
> 
> Commits:
> 
>   - Include missing acpi.h file in pci-acpi.h.
>   - Call _OSC support during root bridge discovery.
>   - PCIe ASPM _OSC support capabilities called when root bridge added.
>   - PCIe AER _OSC support capabilities called when root bridge added.
>   - PCI MSI _OSC support capabilities called when root bridge added.
>   - Remove obsolete _OSC capability support functions.
> 
