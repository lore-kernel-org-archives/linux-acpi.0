From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 0/3] Add Error Disconnect Recover (EDR) support.
Date: Thu, 28 Feb 2019 12:49:46 -0800
Message-ID: <cover.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com, ruscur@russell.cc
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, keith.busch@intel.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

This patchset adds support for following features:

1. Error Disconnect Recover (EDR) support.
2. _OSC based negotiation support for DPC.

You can find EDR spec in the following link.

https://members.pcisig.com/wg/PCI-SIG/document/12614

Kuppuswamy Sathyanarayanan (3):
  PCI/ACPI: Add _OSC based negotiation support for DPC
  ACPI: Add Error Disconnect Recover (EDR) ACPI notifier support
  PCI/DPC: Add Error Disconnect Recover (EDR) support

 drivers/acpi/acpica/utdecode.c  |   3 +-
 drivers/acpi/bus.c              |   5 +-
 drivers/acpi/pci_root.c         |   6 +
 drivers/pci/pcie/Kconfig        |  10 +
 drivers/pci/pcie/dpc.c          | 326 ++++++++++++++++++++++++++++++--
 drivers/pci/pcie/portdrv_core.c |   8 +-
 drivers/pci/probe.c             |   1 +
 include/acpi/actypes.h          |   3 +-
 include/linux/acpi.h            |   3 +-
 include/linux/pci.h             |   1 +
 10 files changed, 347 insertions(+), 19 deletions(-)

-- 
2.20.1
