From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/7] PCI, PNP: print resources consistently
Date: Tue, 06 Oct 2009 15:33:24 -0600
Message-ID: <20091006213259.4272.68068.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:17811 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933148AbZJFVeB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Oct 2009 17:34:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

These enhance %pR so we can print resource types and flags more easily.
This doesn't really add anything (other than a couple new messages
about host bridge apertures), but hopefully it will make things more
consistent and a bit easier to debug.  Sample change (with "pci=use_crs"):

    -pci 0000:00:03.0: reg 10 32bit mmio: [0xf6000000-0xf6ffffff]
    -pci 0000:00:03.0: reg 14 io port: [0x2400-0x24ff]
    -pci 0000:00:03.0: reg 18 32bit mmio: [0xf5ff0000-0xf5ff0fff]
    -pci 0000:00:03.0: reg 30 32bit mmio pref: [0x000000-0x01ffff]
    +pci_root PNP0A03:00: host bridge window: [io  0x0000-0x0cff]
    +pci_root PNP0A03:00: host bridge window: [io  0x0000-0x2cfe]
    +pci_root PNP0A03:00: host bridge window: [io  0x03b0-0x03bb]
    +pci_root PNP0A03:00: host bridge window: [io  0x03c0-0x03df]
    +pci_root PNP0A03:00: host bridge window: [mem 0xf5d00000-0xf6ffffff]
    +pci_root PNP0A03:00: host bridge window: [mem 0x000a0000-0x000bffff]
    +pci 0000:00:03.0: reg 10: [mem 0xf6000000-0xf6ffffff]
    +pci 0000:00:03.0: reg 14: [io  0x2400-0x24ff]
    +pci 0000:00:03.0: reg 18: [mem 0xf5ff0000-0xf5ff0fff]
    +pci 0000:00:03.0: reg 30: [mem 0x00000000-0x0001ffff pref]

---

Bjorn Helgaas (7):
      vsprintf: fix io/mem resource width
      vsprintf: add %pR support for IRQ and DMA resources
      vsprintf: add %pRt, %pRf to print struct resource details
      PCI: print resources consistently with %pRt
      x86/PCI: print resources consistently with %pRt
      ia64/PCI: print resources consistently with %pRt
      PNP: print resources consistently with %pRt


 arch/ia64/pci/pci.c     |   21 +++++++++---
 arch/x86/pci/acpi.c     |   14 ++++++--
 arch/x86/pci/i386.c     |   12 +++----
 drivers/pci/pci.c       |    4 +-
 drivers/pci/probe.c     |   26 +++++----------
 drivers/pci/setup-bus.c |    9 ++---
 drivers/pci/setup-res.c |   28 +++++++---------
 drivers/pnp/quirks.c    |   12 ++-----
 drivers/pnp/resource.c  |   10 ++----
 drivers/pnp/support.c   |   43 +++----------------------
 drivers/pnp/system.c    |   14 ++++----
 lib/vsprintf.c          |   80 ++++++++++++++++++++++++++++++++++++++---------
 12 files changed, 138 insertions(+), 135 deletions(-)

-- 
Bjorn
