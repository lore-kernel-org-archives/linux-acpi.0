From: Thomas Renninger <trenn@suse.de>
Subject: Re: acpi notify
Date: Fri, 8 Aug 2008 17:07:56 +0200
Message-ID: <200808081707.58412.trenn@suse.de>
References: <489C5D67.6060704@chicu.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37417 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbYHHPIC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Aug 2008 11:08:02 -0400
In-Reply-To: <489C5D67.6060704@chicu.ro>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: slavic@chicu.ro
Cc: linux-acpi@vger.kernel.org

Hi,

acpi notify?

On Friday 08 August 2008 16:51:19 Chicu Veaceslav wrote:
> [    0.000000] Entering add_active_range(0, 0, 259728) 0 entries of 256
> used [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA             0 ->     4096
> [    0.000000]   Normal       4096 ->   229376
> [    0.000000]   HighMem    229376 ->   259728
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0:        0 ->   259728
> [    0.000000] On node 0 totalpages: 259728
> [    0.000000]   DMA zone: 32 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 4064 pages, LIFO batch:0
> [    0.000000]   Normal zone: 1760 pages used for memmap
> [    0.000000]   Normal zone: 223520 pages, LIFO batch:31
> [    0.000000]   HighMem zone: 238 pages used for memmap
> [    0.000000]   HighMem zone: 30114 pages, LIFO batch:7
> [    0.000000]   Movable zone: 0 pages used for memmap
> [    0.000000] DMI present.
> [    0.000000] ACPI: RSDP 000F7500, 0014 (r0 PTLTD )
> [    0.000000] ACPI: RSDT 3F691BD8, 0044 (r1 FUJ___ DW1_____ 20070214
> LTP        0)
> [    0.000000] ACPI: FACP 3F697CAA, 0074 (r1 FUJ___ DW1_____ 20070214
> LOHR       5A)
> [    0.000000] ACPI: DSDT 3F692626, 5684 (r1 FUJ___ DW1_____ 20070214
> MSFT  100000E)
> [    0.000000] ACPI: FACS 3F698FC0, 0040
> [    0.000000] ACPI: APIC 3F697D1E, 0068 (r1 FUJ___ DW1_____ 20070214
> LOHR       5A)
> [    0.000000] ACPI: HPET 3F697D86, 0038 (r1 FUJ___ DW1_____ 20070214
> LOHR       5A)
> [    0.000000] ACPI: MCFG 3F697DBE, 003C (r1 FUJ___ DW1_____ 20070214
> LOHR       5A)
> [    0.000000] ACPI: APIC 3F697DFA, 0068 (r1 FUJ___ DW1_____ 20070214
> LTP        0)
> [    0.000000] ACPI: BOOT 3F697E62, 0028 (r1 FUJ___ DW1_____ 20070214
> LTP        1)
> [    0.000000] ACPI: SLIC 3F697E8A, 0176 (r1 FUJ___ DW1_____ 20070214
> LTP        0)
> [    0.000000] ACPI: SSDT 3F691C1C, 0500 (r1  PmRef    CpuPm     3000
> INTL 20050228)
> [    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
> [    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify
> linux-acpi@vger.kernel.org
Now I got it.
acpi_apic_instance=2 works better for you?
Could you also explain what is working better, so that others get an idea when 
to use this boot param.

Thanks,

       Thomas
