From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [Bugme-new] [Bug 5693] New: Hyperthreading processor shows only 1 CPU
Date: Fri, 20 Jan 2006 09:31:49 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F1016C97DA@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:20144 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030456AbWATBbz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2006 20:31:55 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

It appears he didn't enable ACPI, so no HT support.

Thanks,
Shaohua

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Andrew Morton
>Sent: Thursday, January 19, 2006 6:48 PM
>To: linux-acpi@vger.kernel.org
>Subject: Fw: [Bugme-new] [Bug 5693] New: Hyperthreading processor shows
>only 1 CPU
>
>
>Is this an APCI problem?
>
>Begin forwarded message:
>
>Date: Fri, 2 Dec 2005 12:32:33 -0800
>From: bugme-daemon@bugzilla.kernel.org
>To: bugme-new@lists.osdl.org
>Subject: [Bugme-new] [Bug 5693] New: Hyperthreading processor shows
only 1
>CPU
>
>
>http://bugzilla.kernel.org/show_bug.cgi?id=5693
>
>           Summary: Hyperthreading processor shows only 1 CPU
>    Kernel Version: 2.6.14.3
>            Status: NEW
>          Severity: normal
>             Owner: platform_i386@kernel-bugs.osdl.org
>         Submitter: stephen@revealed.net
>
>
>Most recent kernel where this bug did not occur:
>   (that I'm aware of and have tested) 2.6.10
>
>Distribution: LFS
>
>Hardware Environment:
>  Intel S875WP1-E Entry Server Board
>  Intel(R) Pentium(R) 4 CPU 3.40GHz
>  1 Gig Ram
>  250 Gig sata drive
>
>(Output from lspci)
>00:00.0 Host bridge: Intel Corp.: Unknown device 2578 (rev 02)
>00:01.0 PCI bridge: Intel Corp.: Unknown device 2579 (rev 02)
>00:03.0 PCI bridge: Intel Corp.: Unknown device 257b (rev 02)
>00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02)
>00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02)
>00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02)
>00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02)
>00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02)
>00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2)
>00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
>00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02)
>00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02)
>00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
>02:01.0 Ethernet controller: Intel Corp.: Unknown device 1019
>03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
27)
>03:07.0 RAID bus controller: Promise Technology, Inc.: Unknown device
3319
>(rev 02)
>03:08.0 Ethernet controller: Intel Corp.: Unknown device 1050 (rev 01)
>
>Software Environment:
>  Console based server set up.  Based off of LFS 5.1  Running apache,
qmail,
>mysql.
>
>Problem Description:
>  Upgraded to the 2.6.14.3 kernel because of SMP based eip errors on
the
>previous kernel (2.6.10) when the system was under heavy load.  With
SMP
>and SMT
>turned on, and the kernel set for Pentium-4/Celeron(P4-based)/Pentium-4
>M/Xeon
>as the Processor Family.  The 3.4ghz hyperthreading processor only
shows 1
>CPU
>in /proc/cpuinfo, and in the boot.log/dmesg output.
>
>(Output of /proc/cpuinfo)
>processor       : 0
>vendor_id       : GenuineIntel
>cpu family      : 15
>model           : 3
>model name      : Intel(R) Pentium(R) 4 CPU 3.40GHz
>stepping        : 4
>cpu MHz         : 3392.200
>cache size      : 1024 KB
>physical id     : 0
>siblings        : 2
>core id         : 0
>cpu cores       : 1
>fdiv_bug        : no
>hlt_bug         : no
>f00f_bug        : no
>coma_bug        : no
>fpu             : yes
>fpu_exception   : yes
>cpuid level     : 5
>wp              : yes
>flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca
>cmov
>pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor
>ds_cpl cid
>xtpr
>bogomips        : 6792.41
>
>(dmesg information)
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000003fe30000 (usable)
> BIOS-e820: 000000003fe30000 - 000000003fe414a0 (ACPI NVS)
> BIOS-e820: 000000003fe414a0 - 000000003ff30000 (usable)
> BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
> BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
> BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
> BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
> BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
>127MB HIGHMEM available.
>896MB LOWMEM available.
>found SMP MP-table at 000ff780
>On node 0 totalpages: 261936
>  DMA zone: 4096 pages, LIFO batch:1
>  Normal zone: 225280 pages, LIFO batch:31
>  HighMem zone: 32560 pages, LIFO batch:15
>DMI 2.3 present.
>Intel MultiProcessor Specification v1.4
>    Virtual Wire compatibility mode.
>OEM ID:  Product ID: Canterwood-P APIC at: 0xFEE00000
>Processor #0 15:3 APIC version 20
>I/O APIC #2 Version 32 at 0xFEC00000.
>Enabling APIC mode:  Flat.  Using 1 I/O APICs
>Processors: 1
>Allocating PCI resources starting at 50000000 (gap: 40000000:becf0000)
>Built 1 zonelists
>Kernel command line: root=/dev/sda2
>mapped APIC to ffffd000 (fee00000)
>mapped IOAPIC to ffffc000 (fec00000)
>Initializing CPU#0
>PID hash table entries: 4096 (order: 12, 65536 bytes)
>Detected 3392.200 MHz processor.
>Using tsc for high-res timesource
>Console: colour VGA+ 80x25
>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>Memory: 1032496k/1047744k available (2816k kernel code, 14400k
reserved,
>1007k
>data, 216k init, 130168k highmem)
>Checking if this processor honours the WP bit even in supervisor
mode... Ok.
>Calibrating delay using timer specific routine.. 6792.41 BogoMIPS
>(lpj=13584833)
>Mount-cache hash table entries: 512
>CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
>0000441d
>00000000 00000000
>CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
>0000441d
>00000000 00000000
>monitor/mwait feature present.
>using mwait in idle threads.
>CPU: Trace cache: 12K uops, L1 D cache: 16K
>CPU: L2 cache: 1024K
>CPU: Physical Processor ID: 0
>CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080
0000441d
>00000000 00000000
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU0: Thermal monitoring enabled
>mtrr: v2.0 (20020519)
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>CPU0: Intel(R) Pentium(R) 4 CPU 3.40GHz stepping 04
>Total of 1 processors activated (6792.41 BogoMIPS).
>ENABLING IO-APIC IRQs
>..TIMER: vector=0x31 pin1=2 pin2=0
>Brought up 1 CPUs
><<<Snip>>>
>
>
>Steps to reproduce:
>  I've personally reproduced this issue on two boxes with almost
duplicate
>hardware setups.  I compiled the kernel with these options in the
config
>for the
>CPU:
>
>CONFIG_X86_PC=y
>CONFIG_MPENTIUM4=y
>CONFIG_X86_CMPXCHG=y
>CONFIG_X86_XADD=y
>CONFIG_X86_L1_CACHE_SHIFT=7
>CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>CONFIG_GENERIC_CALIBRATE_DELAY=y
>CONFIG_X86_WP_WORKS_OK=y
>CONFIG_X86_INVLPG=y
>CONFIG_X86_BSWAP=y
>CONFIG_X86_POPAD_OK=y
>CONFIG_X86_GOOD_APIC=y
>CONFIG_X86_INTEL_USERCOPY=y
>CONFIG_X86_USE_PPRO_CHECKSUM=y
>CONFIG_HPET_TIMER=y
>CONFIG_HPET_EMULATE_RTC=y
>CONFIG_SMP=y
>CONFIG_NR_CPUS=32
>CONFIG_SCHED_SMT=y
>CONFIG_PREEMPT=y
>CONFIG_PREEMPT_BKL=y
>CONFIG_X86_LOCAL_APIC=y
>CONFIG_X86_IO_APIC=y
>CONFIG_X86_TSC=y
>CONFIG_X86_MCE=y
>CONFIG_X86_MCE_NONFATAL=y
>CONFIG_X86_MCE_P4THERMAL=y
>
>------- You are receiving this mail because: -------
>You are on the CC list for the bug, or are watching someone who is.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
