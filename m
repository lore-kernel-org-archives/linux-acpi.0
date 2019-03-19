From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 0/2] Add Error Disconnect Recover (EDR) support.
Date: Tue, 19 Mar 2019 13:47:27 -0700
Message-ID: <cover.1553027719.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, keith.busch@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

This patchset adds support for following features:

1. Error Disconnect Recover (EDR) support.
2. _OSC based negotiation support for DPC.

You can find EDR spec in the following link.

https://members.pcisig.com/wg/PCI-SIG/document/12614

Changes since v1:
 * Rebased on top of v5.1-rc1

Kuppuswamy Sathyanarayanan (2):
  PCI/ACPI: Add _OSC based negotiation support for DPC
  PCI/DPC: Add Error Disconnect Recover (EDR) support

 drivers/acpi/pci_root.c         |   6 +
 drivers/pci/pcie/Kconfig        |  10 +
 drivers/pci/pcie/dpc.c          | 326 ++++++++++++++++++++++++++++++--
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/probe.c             |   1 +
 include/linux/acpi.h            |   3 +-
 include/linux/pci.h             |   1 +
 7 files changed, 339 insertions(+), 16 deletions(-)

-- 
2.20.1
