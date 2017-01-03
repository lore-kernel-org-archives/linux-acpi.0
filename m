From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: "Validation count is zero before decrement" from
 acpi_tb_put_table()
Date: Tue, 3 Jan 2017 10:45:25 -0800
Message-ID: <20170103184525.GX3742@linux.vnet.ibm.com>
References: <20161231203318.GA2896@linux.vnet.ibm.com>
 <4042750.P0WLOGp8vH@aspire.rjw.lan>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49911 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1759800AbdACSpd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jan 2017 13:45:33 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v03IiKVN129251
        for <linux-acpi@vger.kernel.org>; Tue, 3 Jan 2017 13:45:32 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27rdnd2vtn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Tue, 03 Jan 2017 13:45:32 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 3 Jan 2017 11:45:30 -0700
Content-Disposition: inline
In-Reply-To: <4042750.P0WLOGp8vH@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lv Zheng <lv.zheng@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 31, 2016 at 09:36:28PM +0100, Rafael J. Wysocki wrote:
> On Saturday, December 31, 2016 12:33:18 PM Paul E. McKenney wrote:
> > Hello!
> 
> Hi Paul,
> 
> > After moving to 4.10-rc1, my tests are showing the following warning
> > during very early boot, as in even before rcu_init() is invoked:
> > 
> > ACPI Warning: Table ffffffff81ffcf20, Validation count is zero before decrement
> > 
> > This warning appears to have been introduced by 174cc7187e6f0
> > ("ACPICA: Tables: Back port acpi_get_table_with_size() and
> > early_acpi_os_unmap_memory() from Linux kernel").
> > 
> > I am running on qemu version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.6).
> > Here is my qemu invocation:
> > 
> > qemu-system-x86_64 -enable-kvm -nographic -smp 1 -serial file:/home/paulmck/public_git/linux-rcu/tools/testing/selftests/rcutorture/res/2016.12.28-15:04:34/TREE09/console.log -m 512 -kernel /home/paulmck/public_git/linux-rcu/tools/testing/selftests/rcutorture/res/2016.12.28-15:04:34/TREE09/bzImage -append "noapic selinux=0 initcall_debug debug console=ttyS0 rcu_nocb_poll rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=3600 rcutorture.torture_runnable=1 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1"
> > 
> > Do I need to give qemu some special arguments to run v4.10-rc1 without
> > hitting this sort of warning?
> 
> Adding Lv who is the author of the commit in question.
> 
> Lv, can you help, please?

Thank you, Rafael!

Lv, what should I do about this warning?  I could make my scripts
ignore it, but I would really rather not -- too much chances of that
getting me in trouble later on.

							Thanx, Paul

> Thanks,
> Rafael
> 
> 
> > PS.  Relevant lines of dmesg below.  I get this warning on a wide range
> >      of .config files, but let me know if you want that information.
> > 
> > ------------------------------------------------------------------------
> > 
> > [    0.000000] Linux version 4.10.0-rc1+ (paulmck@kernel.stglabs.ibm.com) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4) ) #1 PREEMPT Wed Dec 28 17:28:37 PST 2016
> > [    0.000000] Command line: noapic selinux=0 initcall_debug debug
> > [    0.000000] console=ttyS0 rcu_nocb_poll rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=3600 rcutorture.torture_runnable=1 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1
> > [    0.000000] x86/fpu: Legacy x87 FPU detected.
> > [    0.000000] e820: BIOS-provided physical RAM map:
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> > [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffdffff] usable
> > [    0.000000] BIOS-e820: [mem 0x000000001ffe0000-0x000000001fffffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> > [    0.000000] NX (Execute Disable) protection: active
> > [    0.000000] SMBIOS 2.8 present.
> > [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> > [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> > [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> > [    0.000000] e820: last_pfn = 0x1ffe0 max_arch_pfn = 0x400000000
> > [    0.000000] MTRR default type: write-back
> > [    0.000000] MTRR fixed ranges enabled:
> > [    0.000000]   00000-9FFFF write-back
> > [    0.000000]   A0000-BFFFF uncachable
> > [    0.000000]   C0000-FFFFF write-protect
> > [    0.000000] MTRR variable ranges enabled:
> > [    0.000000]   0 base 0080000000 mask FF80000000 uncachable
> > [    0.000000]   1 disabled
> > [    0.000000]   2 disabled
> > [    0.000000]   3 disabled
> > [    0.000000]   4 disabled
> > [    0.000000]   5 disabled
> > [    0.000000]   6 disabled
> > [    0.000000]   7 disabled
> > [    0.000000] x86/PAT: PAT not supported by CPU.
> > [    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
> > [    0.000000] found SMP MP-table at [mem 0x000f6640-0x000f664f] mapped at [ffff8800000f6640]
> > [    0.000000] Scanning 1 areas for low memory corruption
> > [    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
> > [    0.000000] BRK [0x031b0000, 0x031b0fff] PGTABLE
> > [    0.000000] BRK [0x031b1000, 0x031b1fff] PGTABLE
> > [    0.000000] BRK [0x031b2000, 0x031b2fff] PGTABLE
> > [    0.000000] BRK [0x031b3000, 0x031b3fff] PGTABLE
> > [    0.000000] ACPI: Early table checksum verification disabled
> > [    0.000000] ACPI: RSDP 0x00000000000F6460 000014 (v00 BOCHS )
> > [    0.000000] ACPI: RSDT 0x000000001FFE16EE 000034 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
> > [    0.000000] ACPI: FACP 0x000000001FFE0C14 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> > [    0.000000] ACPI: DSDT 0x000000001FFE0040 000BD4 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
> > [    0.000000] ACPI: FACS 0x000000001FFE0000 000040
> > [    0.000000] ACPI: SSDT 0x000000001FFE0C88 0009B6 (v01 BOCHS  BXPCSSDT 00000001 BXPC 00000001)
> > [    0.000000] ACPI: APIC 0x000000001FFE163E 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
> > [    0.000000] ACPI: HPET 0x000000001FFE16B6 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
> > [    0.000000] ACPI: Local APIC address 0xfee00000
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > [    0.000000]   DMA32    [mem 0x0000000001000000-0x000000001ffdffff]
> > [    0.000000]   Normal   empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> > [    0.000000]   node   0: [mem 0x0000000000100000-0x000000001ffdffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdffff]
> > [    0.000000] On node 0 totalpages: 130942
> > [    0.000000]   DMA zone: 64 pages used for memmap
> > [    0.000000]   DMA zone: 21 pages reserved
> > [    0.000000]   DMA zone: 3998 pages, LIFO batch:0
> > [    0.000000]   DMA32 zone: 1984 pages used for memmap
> > [    0.000000]   DMA32 zone: 126944 pages, LIFO batch:31
> > [    0.000000] ACPI: PM-Timer IO Port: 0x608
> > [    0.000000] ACPI: Local APIC address 0xfee00000
> > [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> > [    0.000000] ACPI: Skipping IOAPIC probe due to 'noapic' option.
> > [    0.000000] Using ACPI for processor (LAPIC) configuration information
> > [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> > [    0.000000] Intel MultiProcessor Specification v1.4
> > [    0.000000] MPTABLE: OEM ID: BOCHSCPU
> > [    0.000000] MPTABLE: Product ID: 0.1         
> > [    0.000000] MPTABLE: APIC at: 0xFEE00000
> > [    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
> > [    0.000000] Processors: 1
> > [    0.000000] e820: [mem 0x20000000-0xfeffbfff] available for PCI devices
> > [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> > [    0.000000] pcpu-alloc: [0] 0 
> > [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 128873
> > [    0.000000] Kernel command line: noapic selinux=0 initcall_debug debug
> > [    0.000000] console=ttyS0 rcu_nocb_poll rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=3600 rcutorture.torture_runnable=1 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1
> > [    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
> > [    0.000000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> > [    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> > [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> > [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> > [    0.000000] ACPI Warning: Table ffffffff81ffcf20, Validation count is zero before decrement
> > [    0.000000]  (20160930/tbutils-455)
> > [    0.000000] Memory: 480128K/523768K available (9143K kernel code, 1251K rwdata, 2788K rodata, 18204K init, 696K bss, 43640K reserved, 0K cma-reserved)
> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> > [    0.000000] Preemptible hierarchical RCU implementation.
> > [    0.000000] 	Build-time adjustment of leaf fanout to 64.
> > [    0.000000] NR_IRQS:4352 nr_irqs:256 16
> > [    0.000000] Console: colour VGA+ 80x25
> > [    0.000000] console [ttyS0] enabled
> > [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
> > [    0.000000] hpet clockevent registered
> > [    0.000000] tsc: Fast TSC calibration using PIT
> > [    0.000000] tsc: Detected 1995.009 MHz processor
> > [    0.003015] Calibrating delay loop (skipped), value calculated using timer frequency.. 3990.01 BogoMIPS (lpj=1995009)
> > [    0.004005] pid_max: default: 32768 minimum: 301
> > 
> 

