From: Tomi Sarvela <tomi.p.sarvela@intel.com>
Subject: ILK ACPI boot-up problem on HP 8100 SFF, bisected
Date: Mon, 09 Jan 2017 18:01:27 +0200
Message-ID: <2435796.hnfxsDQFWV@fractal.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:48247 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761473AbdAIQCI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Jan 2017 11:02:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lv.zheng@intel.com, robert.moore@intel.com
Cc: intel-gfx-ci@eclists.intel.com

Hello there,

We have couple of Iron Lake machines here, and one started hanging around Christmas in early boot on ACPI initialization. Dmesg below, full dmesgs available on request.

Exact model of the machine is HP Compaq 8100 Elite Small Form Factor PC. BIOS update from 2010 to 2011 (newest) didn't change anything.
HP Elite laptop (ILK m540) or Dell SFF PC (ILK 650) don't have this particular problem.

I've bisected the problem to the following commit:

----
commit 174cc7187e6f088942c8e74daa7baff7b44b33c9
Author: Lv Zheng <lv.zheng@intel.com>
Date:   Wed Dec 14 15:04:25 2016 +0800

    ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel
    
    ACPICA commit cac6790954d4d752a083e6122220b8a22febcd07
----

The affected machine is a testhost and readily available for any patches that might help pinpoint this bug.

If you need any more information, you can contact me directly to this address.

Best regards,

Tomi Sarvela

Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo



Bad kernel hard hangs to the point:

[    0.851020] ACPI: Added _OSI(Module Device)
[    0.855257] ACPI: Added _OSI(Processor Device)
[    0.859753] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.864509] ACPI: Added _OSI(Processor Aggregator Device)
[    0.888923] ACPI: Dynamic OEM Table Load:
[    0.893050] ACPI: SSDT 0xFFFF880212313A78 0003BA (v01 COMPAQ CPU_TM2  00000001 MSFT 0100000E)

Good kernel looks like this:

[    0.216085] ACPI: Added _OSI(Module Device)
[    0.216087] ACPI: Added _OSI(Processor Device)
[    0.216088] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.216089] ACPI: Added _OSI(Processor Aggregator Device)
[    0.217988] ACPI: Dynamic OEM Table Load:
[    0.217993] ACPI: SSDT 0xFFFF880211DE2400 0003BA (v01 COMPAQ CPU_TM2  00000001 MSFT 0100000E)
[    0.218238] ACPI: Dynamic OEM Table Load:
[    0.218241] ACPI: SSDT 0xFFFF880211DE2800 0003D8 (v01 COMPAQ CST      00000001 MSFT 0100000E)
[    0.218693] ACPI: Interpreter enabled
[    0.218708] ACPI: (supports S0 S3 S4 S5)
[    0.218709] ACPI: Using IOAPIC for interrupt routing
[    0.218726] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.221751] acpi LNXCPU:00: Invalid PBLK length [7]
[    0.221758] acpi LNXCPU:01: Invalid PBLK length [7]
[    0.221763] acpi LNXCPU:02: Invalid PBLK length [7]
[    0.221768] acpi LNXCPU:03: Invalid PBLK length [7]
[    0.221898] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.221903] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.221906] ACPI BIOS Error (bug): \_SB_.PCI0._OSC: Excess arguments - ASL declared 5, ACPI requires 4 (20150930/nsarguments-189)
[    0.221938] ACPI Error: [CAPD] Namespace lookup failure, AE_ALREADY_EXISTS (20150930/dsfield-211)
[    0.221942] ACPI Error: Method parse/execution failed [\_SB.PCI0._OSC] (Node ffff8802130b1668), AE_ALREADY_EXISTS (20150930/psparse-542)
[    0.221948] acpi PNP0A08:00: _OSC failed (AE_ALREADY_EXISTS); disabling ASPM
[    0.222162] PCI host bridge to bus 0000:00


