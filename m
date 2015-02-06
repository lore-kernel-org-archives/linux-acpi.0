From: Benjamin Adler <benadler@gmx.net>
Subject: Support for Atom BayTrail/ValleyView power button
Date: Fri, 06 Feb 2015 15:52:14 +0000
Message-ID: <54D4E32E.1050304@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020606030404020209040503"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:62328 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbbBFPwU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Feb 2015 10:52:20 -0500
Received: from [192.168.5.218] ([85.177.127.99]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MJjOu-1YIfGs44s0-0017bI for
 <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2015 16:52:15 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020606030404020209040503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello list,

I'm trying to get a "Zotac ZBOX pico 320" (Intel Atom Z3735F, 64bit 
capable) to work with ubuntu linux 14.04, kernel 3.19rc6 64bit. Its been 
a rough trip because this box comes delivered with Windows 8.1 32bit 
(with bing :) and only sports a 32bit EFI, which makes things complicated.

One of the remaining issues with linux is that the power button doesn't 
work, so when I press it, linux won't shut down. Not sure if this is 
also due to its special EFI.

On other machines with working buttons, dmesg shows lines such as

[    2.365323] ACPI: Power Button [PWRB]
[    2.365350] ACPI: Power Button [PWRF]

On the zbox, there's no such output. Running "acpi_listen" and pushing 
the button doesn't do anything either.

# lspci
00:00.0 Host bridge: Intel Corporation ValleyView SSA-CUnit (rev 0f)
00:02.0 VGA compatible controller: Intel Corporation ValleyView Gen7 
(rev 0f)
00:1a.0 Encryption controller: Intel Corporation ValleyView SEC (rev 0f)
00:1d.0 USB controller: Intel Corporation ValleyView USB Enhanced Host 
Controller (rev 0f)
00:1f.0 ISA bridge: Intel Corporation ValleyView Power Control Unit (rev 0f)

A complete dmesg is also attached. My questions:

  - Is this the right list to ask my question? If no, where should I ask?

  - Why doesn't it work, and how can I help make it work?

Thank you!
Ben

--------------020606030404020209040503
Content-Type: text/plain; charset=UTF-8;
 name="zbox_uname_dmesg_lsmod.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="zbox_uname_dmesg_lsmod.txt"

# uname -a
Linux zotaczboxpi320 3.19.0-031900rc6-generic #201501261152 SMP Mon Jan 26 16:53:27 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux


# dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.19.0-031900rc6-generic (kernel@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201501261152 SMP Mon Jan 26 16:53:27 UTC 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-031900rc6-generic root=UUID=0eb830d0-4493-422e-9d21-b2dea11e96c9 ro vt.handoff=1 nosplash
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x00000000763cafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000763cb000-0x00000000763fafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000763fb000-0x0000000076425fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000076426000-0x00000000764cdfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000764ce000-0x00000000765e1fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000765e2000-0x000000007662afff] type 20
[    0.000000] BIOS-e820: [mem 0x000000007662b000-0x0000000076cfffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0x76425000  ACPI 2.0=0x76425014  SMBIOS=0x765e1390
[    0.000000] efi: mem00: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000000000-0x000000000008f000) (0MB)
[    0.000000] efi: mem01: [ACPI Memory NVS    |   |  |  |  |   |WB|WT|WC|UC] range=[0x000000000008f000-0x0000000000090000) (0MB)
[    0.000000] efi: mem02: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000090000-0x000000000009e000) (0MB)
[    0.000000] efi: mem03: [Reserved           |   |  |  |  |   |WB|WT|WC|UC] range=[0x000000000009e000-0x00000000000a0000) (0MB)
[    0.000000] efi: mem04: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000100000-0x00000000014d5000) (19MB)
[    0.000000] efi: mem05: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000014d5000-0x0000000002000000) (11MB)
[    0.000000] efi: mem06: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000002000000-0x00000000033d5000) (19MB)
[    0.000000] efi: mem07: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000033d5000-0x0000000020000000) (460MB)
[    0.000000] efi: mem08: [Reserved           |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000020000000-0x0000000020200000) (2MB)
[    0.000000] efi: mem09: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000020200000-0x0000000035ca6000) (346MB)
[    0.000000] efi: mem10: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000035ca6000-0x0000000036e4b000) (17MB)
[    0.000000] efi: mem11: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000036e4b000-0x00000000560cc000) (498MB)
[    0.000000] efi: mem12: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000560cc000-0x0000000072d00000) (460MB)
[    0.000000] efi: mem13: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000072d00000-0x0000000072d20000) (0MB)
[    0.000000] efi: mem14: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000072d20000-0x0000000072f5f000) (2MB)
[    0.000000] efi: mem15: [Loader Code        |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000072f5f000-0x0000000072f74000) (0MB)
[    0.000000] efi: mem16: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000072f74000-0x0000000075dcb000) (46MB)
[    0.000000] efi: mem17: [Conventional Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000075dcb000-0x0000000076259000) (4MB)
[    0.000000] efi: mem18: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000076259000-0x0000000076263000) (0MB)
[    0.000000] efi: mem19: [Boot Code          |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000076263000-0x00000000763cb000) (1MB)
[    0.000000] efi: mem20: [Reserved           |   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000763cb000-0x00000000763fb000) (0MB)
[    0.000000] efi: mem21: [ACPI Reclaim Memory|   |  |  |  |   |WB|WT|WC|UC] range=[0x00000000763fb000-0x0000000076426000) (0MB)
[    0.000000] efi: mem22: [ACPI Memory NVS    |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000076426000-0x00000000764ce000) (0MB)
[    0.000000] efi: mem23: [Runtime Data       |RUN|  |  |  |   |WB|WT|WC|UC] range=[0x00000000764ce000-0x00000000765e2000) (1MB)
[    0.000000] efi: mem24: [Runtime Code       |RUN|  |  |  |   |WB|WT|WC|UC] range=[0x00000000765e2000-0x000000007662b000) (0MB)
[    0.000000] efi: mem25: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x000000007662b000-0x0000000076cf6000) (6MB)
[    0.000000] efi: mem26: [Loader Data        |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000076cf6000-0x0000000076cf7000) (0MB)
[    0.000000] efi: mem27: [Boot Data          |   |  |  |  |   |WB|WT|WC|UC] range=[0x0000000076cf7000-0x0000000076d00000) (0MB)
[    0.000000] efi: mem28: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |  |UC] range=[0x00000000e00f8000-0x00000000e00f9000) (0MB)
[    0.000000] efi: mem29: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |  |UC] range=[0x00000000fed01000-0x00000000fed02000) (0MB)
[    0.000000] efi: mem30: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |  |UC] range=[0x00000000fed08000-0x00000000fed09000) (0MB)
[    0.000000] efi: mem31: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |  |UC] range=[0x00000000ffb00000-0x0000000100000000) (5MB)
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: ZOTAC ZBOX-PI320 Series/ZBOX-PI320, BIOS B253P013 10/29/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x76d00 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 040000000 mask FE0000000 write-back
[    0.000000]   2 base 060000000 mask FF0000000 write-back
[    0.000000]   3 base 070000000 mask FF8000000 write-back
[    0.000000]   4 base 070000000 mask FF8000000 write-back
[    0.000000]   5 base 077000000 mask FFF000000 uncachable
[    0.000000]   6 base 076E00000 mask FFFE00000 uncachable
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 1GB, type WB
[    0.000000] reg 1, base: 1GB, range: 512MB, type WB
[    0.000000] reg 2, base: 1536MB, range: 256MB, type WB
[    0.000000] reg 3, base: 1792MB, range: 128MB, type WB
[    0.000000] reg 4, base: 1792MB, range: 128MB, type WB
[    0.000000] reg 5, base: 1904MB, range: 16MB, type UC
[    0.000000] reg 6, base: 1902MB, range: 2MB, type UC
[    0.000000] total RAM covered: 1902M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K  chunk_size: 256M        num_reg: 4      lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 1902MB, range: 2MB, type UC
[    0.000000] reg 2, base: 1904MB, range: 16MB, type UC
[    0.000000] reg 3, base: 1920MB, range: 128MB, type UC
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02fd0000, 0x02fd0fff] PGTABLE
[    0.000000] BRK [0x02fd1000, 0x02fd1fff] PGTABLE
[    0.000000] BRK [0x02fd2000, 0x02fd2fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x76000000-0x761fffff]
[    0.000000]  [mem 0x76000000-0x761fffff] page 2M
[    0.000000] BRK [0x02fd3000, 0x02fd3fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x60000000-0x75ffffff]
[    0.000000]  [mem 0x60000000-0x75ffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x40000000-0x5fffffff]
[    0.000000]  [mem 0x40000000-0x5fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
[    0.000000]  [mem 0x20200000-0x3fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x76200000-0x763cafff]
[    0.000000]  [mem 0x76200000-0x763cafff] page 4k
[    0.000000] BRK [0x02fd4000, 0x02fd4fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7662b000-0x76cfffff]
[    0.000000]  [mem 0x7662b000-0x767fffff] page 4k
[    0.000000]  [mem 0x76800000-0x76bfffff] page 2M
[    0.000000]  [mem 0x76c00000-0x76cfffff] page 4k
[    0.000000] BRK [0x02fd5000, 0x02fd5fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x35ca6000-0x36e4afff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000076425014 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x0000000076424100 000084 (v01 ALASKA A M I    00000003 MSFT 0100000D)
[    0.000000] ACPI: FACP 0x0000000076422000 00010C (v05 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: DSDT 0x000000007640E000 00FA77 (v02 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: MSDM 0x0000000076423000 000055 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: UEFI 0x0000000076492000 000042 (v01 ALASKA A M I    00000000      00000000)
[    0.000000] ACPI: HPET 0x0000000076421000 000038 (v01 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: LPIT 0x0000000076420000 000104 (v01 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: APIC 0x000000007641F000 00006C (v03 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: MCFG 0x000000007641E000 00003C (v01 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: FPDT 0x0000000076407000 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x0000000076406000 000763 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x0000000076405000 000290 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x0000000076404000 00017A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.000000] ACPI: CSRT 0x000000007640D000 00014C (v00 ALASKA A M I    00000005 INTL 20120624)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000076cfffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x7625d000-0x76261fff]
[    0.000000]  [ffffea0000000000-ffffea0001dfffff] PMD -> [ffff880070a00000-ffff8800727fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0x76cfffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0008efff]
[    0.000000]   node   0: [mem 0x00090000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0x1fffffff]
[    0.000000]   node   0: [mem 0x20200000-0x763cafff]
[    0.000000]   node   0: [mem 0x7662b000-0x76cfffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x76cfffff]
[    0.000000] On node 0 totalpages: 485436
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7540 pages used for memmap
[    0.000000]   DMA32 zone: 481440 pages, LIFO batch:31
[    0.000000] x86/hpet: Will disable the HPET for this platform because it's not reliable
[    0.000000] Reserving Intel graphics stolen memory at 0x77000000-0x7effffff
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-86
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x763cb000-0x763fafff]
[    0.000000] PM: Registered nosave memory: [mem 0x763fb000-0x76425fff]
[    0.000000] PM: Registered nosave memory: [mem 0x76426000-0x764cdfff]
[    0.000000] PM: Registered nosave memory: [mem 0x764ce000-0x765e1fff]
[    0.000000] PM: Registered nosave memory: [mem 0x765e2000-0x7662afff]
[    0.000000] e820: [mem 0x7f000000-0xe00f7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 31 pages/cpu @ffff880076000000 s86976 r8192 d31808 u524288
[    0.000000] pcpu-alloc: s86976 r8192 d31808 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 477810
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-031900rc6-generic root=UUID=0eb830d0-4493-422e-9d21-b2dea11e96c9 ro vt.handoff=1 nosplash
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1819864K/1941744K available (8026K kernel code, 1163K rwdata, 3852K rodata, 1408K init, 1292K bss, 121880K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:16640 nr_irqs:1024 16
[    0.000000]  Offload RCU callbacks from all CPUs
[    0.000000]  Offload RCU callbacks from CPUs: 0-3.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Maximum core-clock to bus-clock ratio: 0x10
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 1331200 KHz
[    0.000000] lapic_timer_frequency = 332800
[    0.000000] tsc: Detected 1331.200 MHz processor
[    0.000059] Calibrating delay loop (skipped), value calculated using timer frequency.. 2662.40 BogoMIPS (lpj=5324800)
[    0.000077] pid_max: default: 32768 minimum: 301
[    0.000096] ACPI: Core revision 20141107
[    0.037611] ACPI: All ACPI Tables successfully acquired
[    0.039370] Security Framework initialized
[    0.039399] AppArmor: AppArmor initialized
[    0.039409] Yama: becoming mindful.
[    0.039893] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.041342] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.042003] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.042029] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.042534] Initializing cgroup subsys memory
[    0.042559] Initializing cgroup subsys devices
[    0.042574] Initializing cgroup subsys freezer
[    0.042586] Initializing cgroup subsys net_cls
[    0.042598] Initializing cgroup subsys blkio
[    0.042609] Initializing cgroup subsys perf_event
[    0.042622] Initializing cgroup subsys net_prio
[    0.042633] Initializing cgroup subsys hugetlb
[    0.042685] CPU: Physical Processor ID: 0
[    0.042695] CPU: Processor Core ID: 0
[    0.042708] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.042708] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.047657] mce: CPU supports 6 MCE banks
[    0.047676] CPU0: Thermal monitoring enabled (TM1)
[    0.047694] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.047694] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.047876] Freeing SMP alternatives memory: 28K (ffffffff81e84000 - ffffffff81e8b000)
[    0.054863] ftrace: allocating 32886 entries in 129 pages
[    0.084710] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.124409] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.124419] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.124427] ..... (found apic 0 pin 0) ...
[    0.164110] ....... works.
[    0.164118] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735F @ 1.33GHz (fam: 06, model: 37, stepping: 08)
[    0.164157] TSC deadline timer enabled
[    0.164209] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, full-width counters, Intel PMU driver.
[    0.164241] ... version:                3
[    0.164248] ... bit width:              40
[    0.164254] ... generic registers:      2
[    0.164261] ... value mask:             000000ffffffffff
[    0.164268] ... max period:             000000ffffffffff
[    0.164275] ... fixed-purpose events:   3
[    0.164282] ... event mask:             0000000700000003
[    0.166507] x86: Booting SMP configuration:
[    0.166521] .... node  #0, CPUs:      #1
[    0.184610] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.184993]  #2 #3
[    0.221203] x86: Booted up 1 node, 4 CPUs
[    0.221218] smpboot: Total of 4 processors activated (10649.60 BogoMIPS)
[    0.222643] devtmpfs: initialized
[    0.233950] evm: security.selinux
[    0.233960] evm: security.SMACK64
[    0.233966] evm: security.SMACK64EXEC
[    0.233973] evm: security.SMACK64TRANSMUTE
[    0.233979] evm: security.SMACK64MMAP
[    0.233985] evm: security.ima
[    0.233991] evm: security.capability
[    0.234153] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.234166] PM: Registering ACPI NVS region [mem 0x76426000-0x764cdfff] (688128 bytes)
[    0.234609] pinctrl core: initialized pinctrl subsystem
[    0.234884] RTC time: 15:39:05, date: 02/06/15
[    0.235241] NET: Registered protocol family 16
[    0.240534] cpuidle: using governor ladder
[    0.244545] cpuidle: using governor menu
[    0.244717] ACPI: bus type PCI registered
[    0.244727] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.244955] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.244970] PCI: not using MMCONFIG
[    0.244977] PCI: Using configuration type 1 for base access
[    0.250492] ACPI: Added _OSI(Module Device)
[    0.250505] ACPI: Added _OSI(Processor Device)
[    0.250513] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.250521] ACPI: Added _OSI(Processor Aggregator Device)
[    0.277235] ACPI: Dynamic OEM Table Load:
[    0.277274] ACPI: SSDT 0xFFFF880070333000 000501 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.279200] ACPI: Dynamic OEM Table Load:
[    0.279222] ACPI: SSDT 0xFFFF880070333800 000433 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.281788] ACPI: Dynamic OEM Table Load:
[    0.281810] ACPI: SSDT 0xFFFF880070365A00 00015F (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.283669] ACPI: Dynamic OEM Table Load:
[    0.283689] ACPI: SSDT 0xFFFF880070359840 00008D (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.287726] ACPI: Interpreter enabled
[    0.287747] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20141107/hwxface-580)
[    0.287770] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20141107/hwxface-580)
[    0.287791] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S3_] (20141107/hwxface-580)
[    0.287832] ACPI: (supports S0 S4 S5)
[    0.287841] ACPI: Using IOAPIC for interrupt routing
[    0.287910] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.299323] [Firmware Info]: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
[    0.299339] PCI: not using MMCONFIG
[    0.299388] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.305445] ACPI: Power Resource [USBC] (on)
[    0.306288] ACPI: Power Resource [WWPR] (off)
[    0.312388] ACPI: Power Resource [PLPE] (on)
[    0.323910] ACPI: Power Resource [CLK0] (on)
[    0.324050] ACPI: Power Resource [CLK1] (on)
[    0.324831] ACPI: Power Resource [P28X] (off)
[    0.324969] ACPI: Power Resource [P18X] (off)
[    0.326169] ACPI: Power Resource [P28P] (off)
[    0.326305] ACPI: Power Resource [P18P] (off)
[    0.336620] ACPI: Power Resource [P28T] (off)
[    0.336763] ACPI: Power Resource [P18T] (off)
[    0.336897] ACPI: Power Resource [P1XT] (off)
[    0.339366] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.339388] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.339523] \_SB_.PCI0:_OSC invalid UUID
[    0.339528] _OSC request data:1 1e 0
[    0.339540] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.340295] acpi PNP0A08:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.340832] PCI host bridge to bus 0000:00
[    0.340847] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.340859] pci_bus 0000:00: root bus resource [io  0x0000-0x006f]
[    0.340869] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7]
[    0.340880] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.340891] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.340902] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.340913] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff]
[    0.340924] pci_bus 0000:00: root bus resource [mem 0x90800000-0x90bfffff]
[    0.340935] pci_bus 0000:00: root bus resource [mem 0x77000001-0x7f000000]
[    0.340946] pci_bus 0000:00: root bus resource [mem 0x80000000-0x906ffffe]
[    0.340957] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40fff]
[    0.340980] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.341238] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.341261] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.341279] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.341296] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.341598] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.341634] pci 0000:00:1a.0: reg 0x10: [mem 0x90500000-0x905fffff]
[    0.341653] pci 0000:00:1a.0: reg 0x14: [mem 0x90400000-0x904fffff]
[    0.341786] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.342031] pci 0000:00:1d.0: [8086:0f34] type 00 class 0x0c0320
[    0.342068] pci 0000:00:1d.0: reg 0x10: [mem 0x9060d000-0x9060d3ff]
[    0.342215] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.342450] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.343642] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.343857] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.344078] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.344283] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.344486] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.344689] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.344893] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.345097] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.345587] platform 80860F28:00: failed to claim resource 0
[    0.345603] acpi 80860F28:00: platform device creation failed: -16
[    0.355054] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.355069] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.355082] vgaarb: loaded
[    0.355088] vgaarb: bridge control possible 0000:00:02.0
[    0.355828] SCSI subsystem initialized
[    0.355973] libata version 3.00 loaded.
[    0.356060] ACPI: bus type USB registered
[    0.356137] usbcore: registered new interface driver usbfs
[    0.356176] usbcore: registered new interface driver hub
[    0.356242] usbcore: registered new device driver usb
[    0.356792] PCI: Using ACPI for IRQ routing
[    0.356804] PCI: pci_cache_line_size set to 64 bytes
[    0.356832] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.356845] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.356850] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.356855] e820: reserve RAM buffer [mem 0x763cb000-0x77ffffff]
[    0.356860] e820: reserve RAM buffer [mem 0x76d00000-0x77ffffff]
[    0.357187] NetLabel: Initializing
[    0.357196] NetLabel:  domain hash size = 128
[    0.357202] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.357238] NetLabel:  unlabeled traffic allowed by default
[    0.357525] Switched to clocksource refined-jiffies
[    0.374848] AppArmor: AppArmor Filesystem Enabled
[    0.375048] pnp: PnP ACPI init
[    0.375202] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.375532] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.375547] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.375559] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.375571] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.375583] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.375597] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.375864] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.378997] pnp: PnP ACPI: found 3 devices
[    0.385430] pci_bus 0000:00: resource 4 [io  0x0000-0x006f]
[    0.385439] pci_bus 0000:00: resource 5 [io  0x0078-0x0cf7]
[    0.385446] pci_bus 0000:00: resource 6 [io  0x0d00-0xffff]
[    0.385452] pci_bus 0000:00: resource 7 [mem 0x000a0000-0x000bffff]
[    0.385458] pci_bus 0000:00: resource 8 [mem 0x000c0000-0x000dffff]
[    0.385464] pci_bus 0000:00: resource 9 [mem 0x000e0000-0x000fffff]
[    0.385470] pci_bus 0000:00: resource 10 [mem 0x90800000-0x90bfffff]
[    0.385477] pci_bus 0000:00: resource 11 [mem 0x77000001-0x7f000000]
[    0.385483] pci_bus 0000:00: resource 12 [mem 0x80000000-0x906ffffe]
[    0.385501] pci_bus 0000:00: resource 13 [mem 0xfed40000-0xfed40fff]
[    0.385575] NET: Registered protocol family 2
[    0.386013] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.386140] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.386264] TCP: Hash tables configured (established 16384 bind 16384)
[    0.386324] TCP: reno registered
[    0.386346] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.386384] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.386519] NET: Registered protocol family 1
[    0.386564] pci 0000:00:02.0: Video device with shadowed ROM
[    0.386936] PCI: CLS 0 bytes, default 64
[    0.387105] Trying to unpack rootfs image as initramfs...
[    1.154172] Freeing initrd memory: 18068K (ffff880035ca6000 - ffff880036e4b000)
[    1.154833] microcode: CPU0 sig=0x30678, pf=0x2, revision=0x82b
[    1.154857] microcode: CPU1 sig=0x30678, pf=0x2, revision=0x82b
[    1.154884] microcode: CPU2 sig=0x30678, pf=0x2, revision=0x82b
[    1.154911] microcode: CPU3 sig=0x30678, pf=0x2, revision=0x82b
[    1.155067] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.155200] Scanning for low memory corruption every 60 seconds
[    1.156221] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    1.156266] Initialise system trusted keyring
[    1.156338] audit: initializing netlink subsys (disabled)
[    1.156387] audit: type=2000 audit(1423237146.112:1): initialized
[    1.157141] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.162331] zpool: loaded
[    1.162343] zbud: loaded
[    1.162763] VFS: Disk quotas dquot_6.5.2
[    1.162890] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.164495] fuse init (API version 7.23)
[    1.164940] Key type big_key registered
[    1.165798] Key type asymmetric registered
[    1.165813] Asymmetric key parser 'x509' registered
[    1.165939] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.166041] io scheduler noop registered
[    1.166055] io scheduler deadline registered (default)
[    1.166167] io scheduler cfq registered
[    1.166377] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.166439] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.166567] efifb: probing for efifb
[    1.166633] efifb: framebuffer at 0x80000000, mapped to 0xffffc90000480000, using 8128k, total 8128k
[    1.166646] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    1.166653] efifb: scrolling: redraw
[    1.166662] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.185607] Console: switching to colour frame buffer device 240x67
[    1.204440] fb0: EFI VGA frame buffer device
[    1.204531] intel_idle: MWAIT substates: 0x33000020
[    1.204537] intel_idle: v0.4 model 0x37
[    1.204540] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.205229] ACPI Exception: AE_ERROR, Returned by Handler for [GeneralPurposeIo] (20141107/evregion-297)
[    1.205394] ACPI Error: Method parse/execution failed [\_SB_.ADP1._PSR] (Node ffff8800728bc9b0), AE_ERROR (20141107/psparse-536)
[    1.205601] ACPI Exception: AE_ERROR, Error reading AC Adapter state (20141107/ac-131)
[    1.210534] [Firmware Bug]: No valid trip found
[    1.210723] GHES: HEST is not enabled!
[    1.211067] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.231306] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.236035] hpet: number irqs doesn't agree with number of timers
[    1.236214] Linux agpgart interface v0.103
[    1.240571] brd: module loaded
[    1.242816] loop: module loaded
[    1.243526] libphy: Fixed MDIO Bus: probed
[    1.243600] tun: Universal TUN/TAP device driver, 1.6
[    1.243678] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.243901] PPP generic driver version 2.4.2
[    1.244183] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.244298] ehci-pci: EHCI PCI platform driver
[    1.244624] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    1.244721] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    1.244854] ehci-pci 0000:00:1d.0: debug port 2
[    1.248854] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    1.248889] ehci-pci 0000:00:1d.0: irq 23, io mem 0x9060d000
[    1.262909] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.263121] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.263229] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.263340] usb usb1: Product: EHCI Host Controller
[    1.263416] usb usb1: Manufacturer: Linux 3.19.0-031900rc6-generic ehci_hcd
[    1.263522] usb usb1: SerialNumber: 0000:00:1d.0
[    1.263929] hub 1-0:1.0: USB hub found
[    1.264014] hub 1-0:1.0: 8 ports detected
[    1.264749] ehci-platform: EHCI generic platform driver
[    1.264870] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.264978] ohci-pci: OHCI PCI platform driver
[    1.265081] ohci-platform: OHCI generic platform driver
[    1.265192] uhci_hcd: USB Universal Host Controller Interface driver
[    1.265436] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    1.989180] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.122249] usb 1-1: New USB device found, idVendor=8087, idProduct=07e6
[    2.122358] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.123007] hub 1-1:1.0: USB hub found
[    2.123171] hub 1-1:1.0: 4 ports detected
[    2.299867] i8042: No controller found
[    2.304213] Switched to clocksource tsc
[    2.304719] mousedev: PS/2 mouse device common for all mice
[    2.304994] ACPI Warning: Could not enable fixed event - RealTimeClock (4) (20141107/evxface-643)
[    2.304999] rtc_cmos 00:00: RTC can wake from S4
[    2.305088] rtc (null): invalid alarm value: 2015-2-6 15:65:63
[    2.305301] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    2.305338] rtc_cmos 00:00: alarms up to one day, 242 bytes nvram
[    2.305585] device-mapper: uevent: version 1.0.3
[    2.306007] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28) initialised: dm-devel@redhat.com
[    2.306038] Intel P-state driver initializing.
[    2.306425] ledtrig-cpu: registered to indicate activity on CPUs
[    2.306432] EFI Variables Facility v0.08 2004-May-17
[    2.312093] PCCT header not found.
[    2.312094] ACPI PCC probe failed.
[    2.312338] TCP: cubic registered
[    2.312600] NET: Registered protocol family 10
[    2.313531] NET: Registered protocol family 17
[    2.313562] Key type dns_resolver registered
[    2.315217] Loading compiled-in X.509 certificates
[    2.317275] Loaded X.509 cert 'Magrathea: Glacier signing key: 43dbbfb67f6a8fa4dcf7857f524e05f411517371'
[    2.317302] registered taskstats version 1
[    2.324981] Key type trusted registered
[    2.339256] Key type encrypted registered
[    2.339274] AppArmor: AppArmor sha1 policy hashing enabled
[    2.339280] ima: No TPM chip found, activating TPM-bypass!
[    2.339333] evm: HMAC attrs: 0x1
[    2.340578]   Magic number: 3:149:689
[    2.343088] rtc_cmos 00:00: setting system clock to 2015-02-06 15:39:08 UTC (1423237148)
[    2.343645] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    2.343646] EDD information not available.
[    2.343929] PM: Hibernation image not present or could not be loaded.
[    2.405490] Freeing unused kernel memory: 1408K (ffffffff81d24000 - ffffffff81e84000)
[    2.408900] Write protecting the kernel read-only data: 12288k
[    2.413739] Freeing unused kernel memory: 152K (ffff8800027da000 - ffff880002800000)
[    2.418053] Freeing unused kernel memory: 244K (ffff880002bc3000 - ffff880002c00000)
[    2.473114] systemd-udevd[120]: starting version 204
[    2.502407] sdhci: Secure Digital Host Controller Interface driver
[    2.506127] sdhci: Copyright(c) Pierre Ossman
[    2.514071] sdhci-acpi 80860F14:00: No vmmc regulator found
[    2.514074] sdhci-acpi 80860F14:00: No vqmmc regulator found
[    2.514124] usb 1-1.1: new high-speed USB device number 3 using ehci-pci
[    2.517346] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    2.518549] sdhci-acpi INT33BB:00: No vmmc regulator found
[    2.518551] sdhci-acpi INT33BB:00: No vqmmc regulator found
[    2.521985] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    2.523402] sdhci-acpi 80860F14:01: No vmmc regulator found
[    2.523406] sdhci-acpi 80860F14:01: No vqmmc regulator found
[    2.526943] mmc2: SDHCI controller on ACPI [80860F14:01] using ADMA
[    2.618734] usb 1-1.1: New USB device found, idVendor=1a40, idProduct=0101
[    2.623092] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.627385] usb 1-1.1: Product: USB 2.0 Hub
[    2.633381] hub 1-1.1:1.0: USB hub found
[    2.638125] hub 1-1.1:1.0: 4 ports detected
[    2.735212] mmc0: BKOPS_EN bit is not set
[    2.756324] mmc0: new HS200 MMC card at address 0001
[    2.766251] Driver 'mmcblk' needs updating - please use bus_type methods
[    2.769940] mmcblk0: mmc0:0001 BWBC3R 29.1 GiB
[    2.774069] mmcblk0boot0: mmc0:0001 BWBC3R partition 1 4.00 MiB
[    2.778496] mmcblk0boot1: mmc0:0001 BWBC3R partition 2 4.00 MiB
[    2.782461] mmcblk0rpmb: mmc0:0001 BWBC3R partition 3 4.00 MiB
[    2.795667]  mmcblk0: p1 p2 p3
[    2.844532] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.851111] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.857364] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.865921] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.936419] usb 1-1.1.1: new full-speed USB device number 4 using ehci-pci
[    2.942042] EXT4-fs (mmcblk0p3): INFO: recovery required on readonly filesystem
[    2.944488] mmc1: new high speed SDIO card at address 0001
[    2.948876] EXT4-fs (mmcblk0p3): write access will be enabled during recovery
[    3.001753] EXT4-fs (mmcblk0p3): recovery complete
[    3.007127] EXT4-fs (mmcblk0p3): mounted filesystem with ordered data mode. Opts: (null)
[    3.055350] usb 1-1.1.1: New USB device found, idVendor=045e, idProduct=0745
[    3.059631] usb 1-1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.062844] usb 1-1.1.1: Product: Microsoft\xffffffc2\xffffffae\xffffffae 2.4GHz Transceiver v7.0
[    3.066079] usb 1-1.1.1: Manufacturer: Microsoft
[    3.140665] usb 1-1.1.4: new high-speed USB device number 5 using ehci-pci
[    3.237418] usb 1-1.1.4: New USB device found, idVendor=0bda, idProduct=8152
[    3.240819] usb 1-1.1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.244168] usb 1-1.1.4: Product: USB 10/100 LAN
[    3.247467] usb 1-1.1.4: Manufacturer: Realtek
[    3.247470] usb 1-1.1.4: SerialNumber: 00012E58F054
[    3.308705] random: init urandom read with 37 bits of entropy available
[    3.394415] init: plymouth-upstart-bridge main process (181) terminated with status 1
[    3.398791] init: plymouth-upstart-bridge main process ended, respawning
[    3.417768] init: plymouth-upstart-bridge main process (191) terminated with status 1
[    3.422042] init: plymouth-upstart-bridge main process ended, respawning
[    3.439563] init: plymouth-upstart-bridge main process (195) terminated with status 1
[    3.444106] init: plymouth-upstart-bridge main process ended, respawning
[    3.461981] init: ureadahead main process (184) terminated with status 5
[    3.645462] Adding 1112060k swap on /dev/mmcblk0p2.  Priority:-1 extents:1 across:1112060k SSFS
[    3.830009] EXT4-fs (mmcblk0p3): re-mounted. Opts: errors=remount-ro
[    3.877288] systemd-udevd[324]: starting version 204
[    4.018781] lp: driver loaded but no devices found
[    4.043119] ppdev: user-space parallel port driver
[    4.183203] 80860F0A:00: ttyS4 at MMIO 0x90736000 (irq = 39, base_baud = 2764800) is a 16550A
[    4.248363] byt_gpio INT33FC:02: pin 16 cannot be used as GPIO.
[    4.255000] [drm] Initialized drm 1.1.0 20060810
[    4.334020] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    4.349506] [Firmware Bug]: No valid trip found
[    4.358506] [drm] Memory usable by graphics device = 2048M
[    4.358517] checking generic (80000000 7f0000) vs hw (80000000 10000000)
[    4.358521] fb: switching to inteldrmfb from EFI VGA
[    4.358584] Console: switching to colour dummy device 80x25
[    4.358598] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[    4.359002] [drm] Replacing VGA console driver
[    4.362146] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.362153] [drm] Driver supports precise vblank timestamp query.
[    4.386006] Bluetooth: Core ver 2.20
[    4.386096] NET: Registered protocol family 31
[    4.386101] Bluetooth: HCI device and connection manager initialized
[    4.386111] Bluetooth: HCI socket layer initialized
[    4.386118] Bluetooth: L2CAP socket layer initialized
[    4.386134] Bluetooth: SCO socket layer initialized
[    4.409688] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.409696] Bluetooth: BNEP filters: protocol multicast
[    4.409708] Bluetooth: BNEP socket layer initialized
[    4.410370] Bluetooth: RFCOMM TTY layer initialized
[    4.410389] Bluetooth: RFCOMM socket layer initialized
[    4.410404] Bluetooth: RFCOMM ver 1.11
[    4.412585] hidraw: raw HID events driver (C) Jiri Kosina
[    4.562127] init: cups main process (493) killed by HUP signal
[    4.562162] init: cups main process ended, respawning
[    4.611687] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    4.625890] usbcore: registered new interface driver r8152
[    4.641624] usbcore: registered new interface driver cdc_ether
[    4.661161] usbcore: registered new interface driver usbhid
[    4.661169] usbhid: USB HID core driver
[    4.678867] cfg80211: Calling CRDA to update world regulatory domain
[    4.699554] usb 1-1.1.4: reset high-speed USB device number 5 using ehci-pci
[    4.706811] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    4.714192] acpi device:09: registered as cooling_device4
[    4.714736] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input0
[    4.719126] [drm] Initialized i915 1.6.0 20141121 for 0000:00:02.0 on minor 0
[    4.720251] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    4.720260] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    4.773261] SSE version of gcm_enc/dec engaged.
[    4.794045] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    4.795729] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    4.797296] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    4.800152] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    4.821960] r8152 1-1.1.4:1.0 eth0: v1.07.0 (2014/10/09)
[    4.864891] [drm] GMBUS [i915 gmbus dpc] timed out, falling back to bit banging on pin 4
[    4.873485] fbcon: inteldrmfb (fb0) is primary device
[    4.873786] usbcore: registered new interface driver brcmfmac
[    4.930766] input: gpio-keys as /devices/platform/gpio-keys.0.auto/input/input1
[    4.932992] input: gpio-keys as /devices/platform/gpio-keys.1.auto/input/input2
[    4.948883] intel_soc_dts_thermal: request_threaded_irq ret -22
[    4.960926] intel_rapl: Found RAPL domain package
[    4.960930] intel_rapl: Found RAPL domain core
[    5.006856] random: nonblocking pool is initialized
[    5.016107] input: Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 2.4GHz Transceiver v7.0 as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.0/0003:045E:0745.0001/input/input3
[    5.052417] cfg80211: World regulatory domain updated:
[    5.052421] cfg80211:  DFS Master region: unset
[    5.052421] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
[    5.052436] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    5.052439] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    5.052441] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm), (N/A)
[    5.052453] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    5.052455] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    5.071996] hid-generic 0003:045E:0745.0001: input,hidraw0: USB HID v1.11 Keyboard [Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 2.4GHz Transceiver v7.0] on usb-0000:00:1d.0-1.1.1/input0
[    5.073285] input: Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 2.4GHz Transceiver v7.0 as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.1/0003:045E:0745.0002/input/input4
[    5.128115] hid-generic 0003:045E:0745.0002: input,hidraw1: USB HID v1.11 Mouse [Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 2.4GHz Transceiver v7.0] on usb-0000:00:1d.0-1.1.1/input1
[    5.139912] input: Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 2.4GHz Transceiver v7.0 as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.2/0003:045E:0745.0003/input/input5
[    5.187971] brcmf_c_preinit_dcmds: Firmware version = wl0: Jan 29 2014 01:40:06 version 5.97.39.4 FWID 01-c7b9d775
[    5.196349] hid-generic 0003:045E:0745.0003: input,hiddev0,hidraw2: USB HID v1.11 Device [Microsoft Microsoft\xffffffc2\xffffffae\xffffffae 2.4GHz Transceiver v7.0] on usb-0000:00:1d.0-1.1.1/input2
[    5.207475] Console: switching to colour frame buffer device 240x67
[    5.223909] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    5.223912] i915 0000:00:02.0: registered panic notifier
[    5.575422] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    5.885006] init: failsafe main process (612) killed by TERM signal
[    5.976522] init: network-manager main process (809) terminated with status 127
[    5.976558] init: network-manager main process ended, respawning
[    6.245461] init: Failed to spawn whoopsie main process: unable to execute: No such file or directory
[    6.505254] init: lightdm main process (988) terminated with status 127
[    6.526268] init: plymouth-ready (startup) main process (180) terminated with status 1
[    7.748178] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready



# lsmod
Module                  Size  Used by
joydev                 17587  0
mac_hid                13275  0
hid_generic            12559  0
intel_rapl             19714  0
intel_powerclamp       19099  0
coretemp               13638  0
kvm_intel             154139  0
gpio_keys              17976  0
kvm                   480978  1 kvm_intel
crct10dif_pclmul       14268  0
crc32_pclmul           13180  0
ghash_clmulni_intel    13230  0
aesni_intel           169686  0
aes_x86_64             17131  1 aesni_intel
lrw                    13323  1 aesni_intel
gf128mul               14951  1 lrw
brcmfmac              286568  0
glue_helper            14095  1 aesni_intel
ablk_helper            13597  1 aesni_intel
brcmutil               15781  1 brcmfmac
cryptd                 20531  3 ghash_clmulni_intel,aesni_intel,ablk_helper
cdc_ether              14459  0
usbnet                 44043  1 cdc_ether
usbhid                 53155  0
r8152                  41840  0
mii                    13981  2 r8152,usbnet
cfg80211              551291  1 brcmfmac
snd_intel_sst_acpi     13194  0
snd_intel_sst_core     72022  1 snd_intel_sst_acpi
snd_soc_sst_mfld_platform    76644  1 snd_intel_sst_core
snd_seq_midi           13564  0
snd_seq_midi_event     14899  1 snd_seq_midi
lpc_ich                21176  0
mei_txe                19808  0
snd_rawmidi            31197  1 snd_seq_midi
snd_soc_rt5640         93325  0
mei                    88864  1 mei_txe
snd_soc_rl6231         13037  1 snd_soc_rt5640
snd_soc_core          196850  2 snd_soc_rt5640,snd_soc_sst_mfld_platform
snd_compress           19395  1 snd_soc_core
snd_pcm_dmaengine      15229  1 snd_soc_core
bmc150_accel           23476  0
industrialio_triggered_buffer    12882  1 bmc150_accel
snd_pcm               106365  4 snd_soc_rt5640,snd_soc_core,snd_soc_sst_mfld_platform,snd_pcm_dmaengine
kfifo_buf              13432  1 industrialio_triggered_buffer
i2c_hid                19065  0
industrialio           55454  3 industrialio_triggered_buffer,kfifo_buf,bmc150_accel
snd_seq                63540  2 snd_seq_midi_event,snd_seq_midi
hid                   110883  3 i2c_hid,hid_generic,usbhid
bnep                   23980  2
rfcomm                 75100  0
goodix                 13173  0
bluetooth             510653  10 bnep,rfcomm
snd_seq_device         14875  3 snd_seq,snd_rawmidi,snd_seq_midi
8250_fintek            12924  0
i915                 1087482  2
snd_timer              30118  2 snd_pcm,snd_seq
video                  24803  1 i915
drm_kms_helper        119701  1 i915
snd                    84025  8 snd_soc_core,snd_timer,snd_pcm,snd_seq,snd_rawmidi,snd_soc_sst_mfld_platform,snd_seq_device,snd_compress
dw_dmac                12835  0
i2c_designware_platform    13025  0
drm                   341532  4 i915,drm_kms_helper
soc_button_array       12771  0
dw_dmac_core           28558  1 dw_dmac
i2c_designware_core    14990  1 i2c_designware_platform
soundcore              15091  1 snd
i2c_algo_bit           13564  1 i915
rfkill_gpio            12886  0
acpi_pad               18183  0
snd_soc_sst_acpi       13007  0
spi_pxa2xx_platform    23453  0
8250_dw                13474  0
pwm_lpss_platform      12703  0
pwm_lpss               13281  1 pwm_lpss_platform
iosf_mbi               13865  1 intel_rapl
parport_pc             32909  0
ppdev                  17711  0
nls_iso8859_1          12713  1
lp                     17799  0
parport                42481  3 lp,ppdev,parport_pc
mmc_block              36635  4
sdhci_acpi             13502  0
sdhci                  44021  1 sdhci_acpi
--------------020606030404020209040503--
