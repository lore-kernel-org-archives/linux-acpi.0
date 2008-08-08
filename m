From: Chicu Veaceslav <slavic@chicu.ro>
Subject: acpi notify
Date: Fri, 08 Aug 2008 17:51:19 +0300
Message-ID: <489C5D67.6060704@chicu.ro>
Reply-To: slavic@chicu.ro
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hostx8.myhost.ro ([85.9.22.181]:38850 "EHLO mx8.myhost.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbYHHO57 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Aug 2008 10:57:59 -0400
Received: from localhost (hostx8.myhost.ro [127.0.0.1])
	by hostx8.myhost.ro (Postfix) with ESMTP id 6CDB657EC81
	for <linux-acpi@vger.kernel.org>; Fri,  8 Aug 2008 17:51:20 +0300 (EEST)
Received: from hostx8.myhost.ro ([127.0.0.1])
	by localhost (hostx8.myhost.ro [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id oClo3-8wD8Pd for <linux-acpi@vger.kernel.org>;
	Fri,  8 Aug 2008 17:51:20 +0300 (EEST)
Received: from slavic.zooku.ro (unknown [86.121.209.23])
	by hostx8.myhost.ro (Postfix) with ESMTP id 5350C57EC6A
	for <linux-acpi@vger.kernel.org>; Fri,  8 Aug 2008 17:51:20 +0300 (EEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[    0.000000] Entering add_active_range(0, 0, 259728) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   259728
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   259728
[    0.000000] On node 0 totalpages: 259728
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 238 pages used for memmap
[    0.000000]   HighMem zone: 30114 pages, LIFO batch:7
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F7500, 0014 (r0 PTLTD )
[    0.000000] ACPI: RSDT 3F691BD8, 0044 (r1 FUJ___ DW1_____ 20070214
LTP        0)
[    0.000000] ACPI: FACP 3F697CAA, 0074 (r1 FUJ___ DW1_____ 20070214
LOHR       5A)
[    0.000000] ACPI: DSDT 3F692626, 5684 (r1 FUJ___ DW1_____ 20070214
MSFT  100000E)
[    0.000000] ACPI: FACS 3F698FC0, 0040
[    0.000000] ACPI: APIC 3F697D1E, 0068 (r1 FUJ___ DW1_____ 20070214
LOHR       5A)
[    0.000000] ACPI: HPET 3F697D86, 0038 (r1 FUJ___ DW1_____ 20070214
LOHR       5A)
[    0.000000] ACPI: MCFG 3F697DBE, 003C (r1 FUJ___ DW1_____ 20070214
LOHR       5A)
[    0.000000] ACPI: APIC 3F697DFA, 0068 (r1 FUJ___ DW1_____ 20070214
LTP        0)
[    0.000000] ACPI: BOOT 3F697E62, 0028 (r1 FUJ___ DW1_____ 20070214
LTP        1)
[    0.000000] ACPI: SLIC 3F697E8A, 0176 (r1 FUJ___ DW1_____ 20070214
LTP        0)
[    0.000000] ACPI: SSDT 3F691C1C, 0500 (r1  PmRef    CpuPm     3000
INTL 20050228)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify
linux-acpi@vger.kernel.org
[    0.000000] ACPI: DMI detected: Fujitsu Siemens
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
