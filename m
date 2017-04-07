From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] acpi: pci: don't ignore function ID of bridge device in _PRT
Date: Fri,  7 Apr 2017 14:22:22 +0100
Message-ID: <20170407132222.28300-1-ard.biesheuvel@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35626 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756127AbdDGNWh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2017 09:22:37 -0400
Received: by mail-wr0-f179.google.com with SMTP id o21so79438731wrb.2
        for <linux-acpi@vger.kernel.org>; Fri, 07 Apr 2017 06:22:36 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: graeme.gregory@linaro.org, al.stone@linaro.org, bhelgaas@google.com
Cc: leif.lindholm@linaro.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, marc.zyngier@arm.com, mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

We currently derive legacy interrupt routing by matching _PRT
entries on the PCI device only, presumably under the assumption
that PRT entries always have a value of 0xffff in the function
field, meaning 'match all functions'.

This no longer holds for modern PCIe topologies, where the
legacy interrupts for different slots may be wired to different
functions on the same bridge device. For instance, on AMD Seattle,
we may have something like

-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 1a00
           +-02.0  Advanced Micro Devices, Inc. [AMD] Device 1a01
           +-02.2-[01]----00.0  Renesas uPD720202 USB 3.0 Host Controller
           \-02.3-[02]----00.0  Realtek RTL8169 PCIe Gigabit Ethernet

where the _PRT describes the legacy interrupt routing as

    Name (_PRT, Package ()  // _PRT: PCI Routing Table
    {
        // slot 1: dev 2 fn 1
        Package () { 0x20001, 0x0, 0x0, 0x140 },
        Package () { 0x20001, 0x1, 0x0, 0x141 },
        Package () { 0x20001, 0x2, 0x0, 0x142 },
        Package () { 0x20001, 0x3, 0x0, 0x143 },

        // slot 1: dev 2 fn 2
        Package () { 0x20002, 0x0, 0x0, 0x144 },
        Package () { 0x20002, 0x1, 0x0, 0x145 },
        Package () { 0x20002, 0x2, 0x0, 0x146 },
        Package () { 0x20002, 0x3, 0x0, 0x147 },

        // slot 1: dev 2 fn 3
        Package () { 0x20003, 0x0, 0x0, 0x148 },
        Package () { 0x20003, 0x1, 0x0, 0x149 },
        Package () { 0x20003, 0x2, 0x0, 0x14a },
        Package () { 0x20003, 0x3, 0x0, 0x14b }
    }) // _PRT

The current code always matches on the first entry when trying to
derive the legacy interrupt routing for the USB and Ethernet controllers
behind bridges 02.2 and 02.3, which results in the wrong entry to
be selected.

So fix this by matching the function ID to the value in the _PRT entry
if the _PRT entries are not using 0xffff in the lower word to match
all functions.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/pci_irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index c576a6fe4ebb..caac4ac94418 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -160,6 +160,8 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
 	struct acpi_prt_entry *entry;
 
 	if (((prt->address >> 16) & 0xffff) != device ||
+	    ((prt->address & 0xffff) != 0xffff &&
+	     (prt->address & 0xffff) != PCI_FUNC(dev->devfn)) ||
 	    prt->pin + 1 != pin)
 		return -ENODEV;
 
-- 
2.9.3

