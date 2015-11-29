From: Daniel J Blueman <daniel@numascale.com>
Subject: overriding ACPI _CRS method
Date: Sun, 29 Nov 2015 18:58:55 +0800
Message-ID: <1448794735.18592.0@outlook-emeawest.office365.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-am1on0103.outbound.protection.outlook.com ([157.56.112.103]:22112
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751224AbbK2LOY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Nov 2015 06:14:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Steffen Persvold <sp@numascale.com>, Myron Stowe <myron.stowe@redhat.com>

In firmware that is loaded after the BIOS, I need to trim the root bus 
resource (0x40000000-0xdfffffff) covering the MMIO window [1], so I can 
attach further PCI domains.

One strategy is to override the BIOS's DSDT [2] _SB.PCI0._CRS method; 
even when my firmware appends the bytecode for a new _CRS method [3], 
alas I see AE_ALREADY_EXISTS [4].

I understood methods were overrideable within the same table (eg not 
from an SSDT), but perhaps am missing something? Or any better approach 
to reduce the scope of the PCI domain 0000 root bus?

Thanks!
  Daniel

-- [1]

pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
pci_bus 0000:00: root bus resource [io  0x8000-0xdfff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xf0000000-0xffffffff window]
pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
pci_bus 0000:00: root bus resource [mem 0x40000000-0xdfffffff window]
pci_bus 0000:00: root bus resource [bus 00-04]

[2] https://resources.numascale.com/DSDT.dsl
[3] https://resources.numascale.com/DSDT-extra.dsl

-- [4]

ACPI: Core revision 20150930
ACPI Error: [_CRS] Namespace lookup failure, AE_ALREADY_EXISTS 
(20150930/dswload-378)
ACPI Exception: AE_ALREADY_EXISTS, During name lookup/catalog 
(20150930/psobject-227)
ACPI Exception: AE_ALREADY_EXISTS, [DSDT] table load failed 
(20150930/tbxfload-163)
ACPI Error: [\_PR_.P001] Namespace lookup failure, AE_NOT_FOUND 
(20150930/dswload-210)
ACPI Exception: AE_NOT_FOUND, During name lookup/catalog 
(20150930/psobject-227)
ACPI Exception: AE_NOT_FOUND, (SSDT:POWERNOW) while loading table 
(20150930/tbxfload-193)
ACPI Error: 2 table load failures, 0 successful (20150930/tbxfload-214)
-- 
Daniel J Blueman
Principal Software Engineer, Numascale

