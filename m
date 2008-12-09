From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 00/20] ACPI: PCI: simplify _PRT handling
Date: Mon, 08 Dec 2008 21:30:00 -0700
Message-ID: <20081209042833.26415.24906.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:45862 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbYLIEaF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 23:30:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This series simplifies the code that handles ACPI _PRTs (PCI routing
tables).  My goal is to make this look more like the corresponding
code in other architectures, especially in terms of swizzling, e.g.,
the various implementations of common_swizzle() and simple_swizzle(),
and the x86 non-ACPI code in pirq_enable_irq().

There should be no functional changes in this series.

Comments welcome.

Bjorn

---

Bjorn Helgaas (20):
      ACPI: PCI: add HP copyright
      ACPI: PCI: whitespace and useless initialization cleanup
      ACPI: PCI: expand acpi_pci_allocate_irq() and acpi_pci_free_irq() inline
      ACPI: PCI: simplify struct acpi_prt_entry
      ACPI: PCI: simplify list of _PRT entries
      ACPI: PCI: combine lookup and derive
      ACPI: PCI: follow typical PCI INTx swizzling pattern
      ACPI: PCI: use positive logic to simplify code
      ACPI: PCI: remove callback from acpi_pci_irq_lookup & acpi_pci_irq_derive
      ACPI: PCI: tweak _PRT lookup debug
      ACPI: PCI: lookup _PRT entry by PCI dev and pin, not segment/bus/dev/pin
      ACPI: PCI: use 1-based encoding for _PRT quirks
      ACPI: PCI: always use the PCI INTx pin values, not the _PRT ones
      ACPI: PCI: add a helper to convert _PRT INTx pin number to name
      ACPI: PCI: move struct acpi_prt_entry declaration out of public header file
      ACPI: PCI: fix GSI/IRQ naming confusion
      ACPI: PCI: ignore _PRT function information
      ACPI: PCI: simplify buffer management for evaluating _PRT
      ACPI: PCI: remove unnecessary null pointer checks
      ACPI: PCI: use conventional PCI address format


 drivers/acpi/pci_bind.c |   12 +
 drivers/acpi/pci_irq.c  |  416 +++++++++++++++--------------------------------
 include/linux/acpi.h    |   16 --
 3 files changed, 136 insertions(+), 308 deletions(-)
