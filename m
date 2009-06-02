From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 00/10] Dynamic ACPI-PCI binding
Date: Tue, 02 Jun 2009 09:24:36 -0600
Message-ID: <20090602152351.7346.48697.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch series eliminates static boot-time binding of ACPI
and PCI devices, and introduces an API to perform this lookup
during runtime.

This change has the following advantages:

	- eliminates struct acpi_device vs struct pci_dev lifetime issues
	- lays groundwork for eliminating .bind/.unbind from acpi_device_ops
	- lays more groundwork for eliminating .start from acpi_device_ops
	  and thus simplifying ACPI drivers
	- whacks out a lot of code

This patchset is based on lenb/test (66c74fa1d4).
---

Alex Chiang (10):
      ACPI: acpi_pci_unbind should clean up properly after acpi_pci_bind
      ACPI: simplify acpi_pci_irq_del_prt() API
      ACPI: simplify acpi_pci_irq_add_prt() API
      ACPI: eviscerate pci_bind.c
      ACPI: kill acpi_get_pci_id
      PCI Hotplug: acpiphp: convert to acpi_get_pci_dev
      ACPI: Introduce acpi_get_pci_dev()
      ACPI: export acpi_pci_find_root()
      ACPI: Introduce acpi_is_root_bridge()
      ACPI: make acpi_pci_bind() static


 drivers/acpi/pci_bind.c            |  374 +++++++++++-------------------------
 drivers/acpi/pci_irq.c             |   17 +-
 drivers/acpi/pci_root.c            |   83 +++++---
 drivers/pci/hotplug/acpi_pcihp.c   |   40 ----
 drivers/pci/hotplug/acpiphp_glue.c |   26 +--
 include/acpi/acpi_bus.h            |   14 +
 include/acpi/acpi_drivers.h        |   10 -
 include/linux/pci_hotplug.h        |    1 
 8 files changed, 202 insertions(+), 363 deletions(-)
