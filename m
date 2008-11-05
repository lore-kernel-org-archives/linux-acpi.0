From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH v3 0/7] call _OSC support during root bridge discovery
Date: Tue, 04 Nov 2008 22:29:34 -0700
Message-ID: <20081105052934.15722.98580.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

This is v3 of the "call _OSC support during root bridge discovery"
patchset.  

Kenji Kaneshige noted that OSC_EXT_PCI_CONFIG_SUPPORT should only be
set if we really can access PCI extended config space (offset greater
than 0xff). The only time this is not true is if CONFIG_PCI_MMCONFIG
is set and pci=nommconf is included on the kernel command-line. I
added a patch that introduces the pci_ext_cfg_avail function which
checks for this condition.

Matthew Wilcox has signed off on the first two patches.


I recently reported a problem where a machine with close to a 100 PCIe
root bridges was taking half an hour to just call _OSC.  The root
cause is the AER code calling:

        pcie_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);

for each bridge.  The pcie_osc_support_set() function also iterates
over each bridge, so _OSC is called a quadratic number of times.

One solution to this problem would be to just move the call to
pcie_osc_support_set() to aer_service_init(), so _OSC support is only
called on each bridge once.

Matthew Wilcox came up with a better solution.  He says "Why should a
driver be calling pcie_osc_support_set() anyway?  This is something
the PCI core should be taking care of for it."

Matthew provided a patch for this solution that I massaged into the
following patch series.

It creates a new function (pci_acpi_osc_support()) which is called
from pci_root.c before we call any other methods on the device (as
recommended by the ACPI spec).  Since we know what capabilities the
system supports, individual modules do not now need to inform the core
of their support for various capabilities.

Some work that still needs to be done (provided by Matthew with some of
my additions): 

o All the existing _OSC code should be moved from pci-acpi.c to
  pci_root.c.  I also think the acpi_osc_data should be made part of
  the acpi_pci_root struct, eliminating a separate allocation.

o We could also use an interface that iterates over all existing
  busses calling _OSC with new flags.  Shouldn't be hard, once it's
  integrated into pci_root.c. We need this to handle when
  configuration changes are made after root bridge discovery such as in
  quirk_disable_all_msi.

o Further ahead, we don't actually check that the bits we asked for
  (in 'control') were actually granted to us.  The PCI firmware spec
  is quite explicit about interdependencies amongst the bits.

o We also need to re-evaluate _OSC when coming out of S4.

This patch series duplicates currently functionality while removing
our quadratic problem.  I believe that it can be applied now while the
above new functionality can be implemented some time in the future.

This patch series applies to the linux-next branch of pci-2.6 git
repository.  I expect it will also work with linux-next.

Diff stats:

 arch/x86/pci/common.c              |    1 +
 drivers/acpi/pci_root.c            |   12 +++++++++++
 drivers/pci/msi.c                  |   31 ++++++++++-------------------
 drivers/pci/pci-acpi.c             |   37 ++++++++++++-----------------------
 drivers/pci/pci.c                  |   28 +++++++++++++++++++++++++-
 drivers/pci/pci.h                  |    2 -
 drivers/pci/pcie/aer/aerdrv_acpi.c |    1 -
 drivers/pci/pcie/aspm.c            |   27 ++++++++-----------------
 include/linux/pci-acpi.h           |   14 ++----------
 include/linux/pci.h                |   18 +++++++++++++++++
 10 files changed, 93 insertions(+), 78 deletions(-)

Commits:

  - Include missing acpi.h file in pci-acpi.h.
  - Call _OSC support during root bridge discovery.
  - PCI extended config _OSC support called when root bridge added.
  - PCIe ASPM _OSC support capabilities called when root bridge added.
  - PCIe AER _OSC support capabilities called when root bridge added.
  - PCI MSI _OSC support capabilities called when root bridge added.
  - Remove obsolete _OSC capability support functions.

-- 
Andrew Patterson
