From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 0/8] call _OSC support during root bridge discovery
Date: Tue, 28 Oct 2008 23:48:16 -0600
Message-ID: <20081029054815.2263.40833.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx
List-Id: linux-acpi@vger.kernel.org

I recently reported a problem where a machine with close to a 100
PCIe root bridges was taking half an hour to just call _OSC.  The
root cause is the AER code calling:

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

Some work that still needs to be done (provided by Matthew): 

o All the existing _OSC code should be moved from pci-acpi.c to
  pci_root.c.  I also think the acpi_osc_data should be made part of
  the acpi_pci_root struct, eliminating a separate allocation.

o We could also use an interface that iterates over all existing
  busses calling _OSC with new flags.  Shouldn't be hard, once it's
  integrated into pci_root.c.

o Further ahead, we don't actually check that the bits we asked for
  (in 'control') were actually granted to us.  The PCI firmware spec
  is quite explicit about interdependencies amongst the bits.

o We also need to re-evaluate _OSC when coming out of S4.

This patch series duplicates currently functionality while removing
our quadratic problem.  I believe that it can be applied now while the
above new functionality can be implemented some time in the future.

This patch series applies to the linux-next branch of pci-2.6 git
repository.  I expect it will also work with linux-next.

Matthew needs to sign-off patches 1-5.

Diff stats:

 drivers/acpi/pci_root.c            |   15 +++++++++++++++
 drivers/pci/msi.c                  |   31 +++++++++++-------------------
 drivers/pci/pci-acpi.c             |   37 +++++++++++++-----------------------
 drivers/pci/pci.c                  |    2 --
 drivers/pci/pci.h                  |    4 +---
 drivers/pci/pcie/aer/aerdrv_acpi.c |    1 -
 drivers/pci/pcie/aspm.c            |   22 ---------------------
 include/linux/pci-acpi.h           |   14 +++-----------
 include/linux/pci.h                |    5 +++++
 9 files changed, 48 insertions(+), 83 deletions(-)

Commits:

  - Include missing acpi.h file in pci-acpi.h.
  - Call _OSC support during root bridge discovery.
  - PCIe ASPM _OSC support capabilities called when root bridge added.
  - PCIe AER _OSC support capabilities called when root bridge added.
  - PCI MSI _OSC support capabilities called when root bridge added.
  - Added pci_msi_enabled which checks for pci=nomsi.
  - Check if MSI is enabled before adding _OSC support capability.
  - Remove obsolete _OSC capability support functions.

-- 
Andrew Patterson
