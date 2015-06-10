From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v3 0/4] Introduce a mechanism to allocate PCI IRQ on demand
Date: Wed, 10 Jun 2015 16:54:57 +0800
Message-ID: <1433926501-22956-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49000 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbbFJIxA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jun 2015 04:53:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>

Hi Bjorn,
	I have verified that this patch set could be applied to the
mainstream kernel without dependency on other patches, so could you
please help to merge it?

This patch set introduces a mechanism to allocate PCI IRQ on demand and
free it when not used anymore by hooking pci_device_probe() and
pci_device_remove().

It will be used to track IOAPIC pin usage on x86 so we could support
IOAPIC hot-removal.

The patch set passes Fengguang's 0day test suite.

V2->V3:
1) Change the default pcibios_alloc_irq() to always return 0, as
   suggested by Bjorn.
2) Refine comments.

V1->V2:
1) Refine pci_device_probe() to optimize for mainline code as suggested
   by Bjorn
2) Reorder patch set to put optional patch as the last (Patch 4)


Jiang Liu (4):
  PCI: Add hooks to allocate/free IRQ resources when binding/unbinding
    driver
  PCI, x86: Allocate PCI IRQ on demand and free it when not used
    anymore
  PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed
  PCI, MSI: Free legacy PCI IRQ when enabling MSI/MSI-X

 arch/x86/include/asm/pci_x86.h |    2 --
 arch/x86/pci/common.c          |   20 +++++++++-----------
 arch/x86/pci/intel_mid_pci.c   |    9 ++++++---
 arch/x86/pci/irq.c             |   23 ++++-------------------
 drivers/acpi/pci_irq.c         |   17 ++++-------------
 drivers/pci/msi.c              |    6 +++++-
 drivers/pci/pci-driver.c       |   26 ++++++++++++++++++++------
 include/linux/pci.h            |   19 +++++++++++++++++++
 8 files changed, 67 insertions(+), 55 deletions(-)

-- 
1.7.10.4

