From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v4 0/2] pci_root: track downstream bus range
Date: Thu, 11 Mar 2010 12:20:00 -0700
Message-ID: <20100311191936.17859.3619.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:20929 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab0CKTUD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Mar 2010 14:20:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

These patches keep track of both the beginning and end of the bus number
range under a PCI host bridge (previously we only kept the beginning) and
make that range available to the arch code, which will need it so support
the _CBA mechanism for reporting MMCONFIG regions.

Changes from v3 to v4:
    - Cleanup secondary.start init (Kenji).

Changes from v2 to v3:
    - Rework to use struct resource with IORESOURCE_BUS.
---

Bjorn Helgaas (2):
      ACPI: pci_root: save downstream bus range
      ACPI: pci_root: pass acpi_pci_root to arch-specific scan


 arch/ia64/pci/pci.c         |    5 +++
 arch/x86/pci/acpi.c         |    5 +++
 drivers/acpi/pci_root.c     |   67 ++++++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h     |    2 +
 include/acpi/acpi_drivers.h |    3 +-
 5 files changed, 50 insertions(+), 32 deletions(-)
