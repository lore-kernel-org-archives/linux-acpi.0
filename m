From: Nikolaus Filus <NFilus-hi6Y0CQ0nG0@public.gmane.org>
Subject: S1 resume failes at hdc with Toshiba Satellite 3000
Date: Sat, 4 Oct 2003 14:19:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031004121942.GA2866@wsc-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

finally I can suspend into S1 with a 2.6 kernel, namely 2.6.0-test6 plus
acpi-2.6.0-test6.patch
I made some tests from commandline with almost everything as module and no
modules loaded. But the problem arrises with the resume of hdc, my DVD
drive. I plugged it out and resume worked, except that my USB mouse doesn't
work anymore, but I will investigate more.
I had a good working S1 in 2.4.21, which I used before switching to 2.6

Oct  4 13:55:30 mobile kernel: Stopping tasks: =====================|
Oct  4 13:55:30 mobile kernel: hda: start_power_step(step: 0)
Oct  4 13:55:30 mobile kernel: hda: start_power_step(step: 1)
Oct  4 13:55:30 mobile kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
Oct  4 13:55:30 mobile kernel: hda: completing PM request, suspend
Oct  4 13:55:30 mobile kernel:  hwsleep-0257 [480] acpi_enter_sleep_state: Entering sleep state [S1]
Oct  4 13:55:30 mobile kernel: hda: Wakeup request inited, waiting for !BSY...
Oct  4 13:55:30 mobile kernel: hda: start_power_step(step: 1000)
Oct  4 13:55:30 mobile kernel: hda: completing PM request, resume
Oct  4 13:55:30 mobile kernel: Restarting tasks... done

hdc would stop at !BSY and the fan goes on without any further reaction.

Oct  4 13:50:07 mobile kernel: Control Methods:..............................................................................................................................................................................................
Oct  4 13:50:07 mobile kernel: Table [DSDT](id F004) - 588 Objects with 56 Devices 190 Methods 17 Regions
Oct  4 13:50:07 mobile kernel: ACPI Namespace successfully loaded at root c04e63fc
Oct  4 13:50:07 mobile kernel: evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
Oct  4 13:50:07 mobile kernel: evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000001028 on int9
Oct  4 13:50:07 mobile kernel: evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000102C on int9
Oct  4 13:50:07 mobile kernel: Completing Region/Field/Buffer/Package initialization:.........................................................................
Oct  4 13:50:07 mobile kernel: Initialized 17/17 Regions 0/0 Fields 32/32 Buffers 24/24 Packages (596 nodes)
Oct  4 13:50:07 mobile kernel: Executing all Device _STA and_INI methods:.....[ACPI Debug] String: Linux OS detected
Oct  4 13:50:07 mobile kernel: ....................................................
Oct  4 13:50:07 mobile kernel: 57 Devices found containing: 57 _STA, 1 _INI methods
Oct  4 13:50:07 mobile kernel: ACPI: Interpreter enabled
Oct  4 13:50:07 mobile kernel: ACPI: Using PIC for interrupt routing
Oct  4 13:50:07 mobile kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Oct  4 13:50:07 mobile kernel: PCI: Probing PCI hardware (bus 00)
Oct  4 13:50:07 mobile kernel: Transparent bridge - 0000:00:1e.0
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15)
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15)
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12 14 15)
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 12 14 15)
Oct  4 13:50:07 mobile kernel: ACPI: Embedded Controller [EC0] (gpe 28)
Oct  4 13:50:07 mobile kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Oct  4 13:50:07 mobile kernel: SCSI subsystem initialized

Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Oct  4 13:50:07 mobile kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Oct  4 13:50:07 mobile kernel: PCI: Using ACPI for IRQ routing
Oct  4 13:50:07 mobile kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Oct  4 13:50:07 mobile kernel: ikconfig 0.7 with /proc/config*
Oct  4 13:50:07 mobile kernel: [ACPI Debug] String: =====QUERY_60=====
Oct  4 13:50:07 mobile kernel: ACPI: AC Adapter [ACAD] (on-line)
Oct  4 13:50:07 mobile kernel: ACPI: Battery Slot [BAT1] (battery present)
Oct  4 13:50:07 mobile kernel: ACPI: Battery Slot [BAT2] (battery absent)
Oct  4 13:50:07 mobile kernel: ACPI: Power Button (FF) [PWRF]
Oct  4 13:50:07 mobile kernel: ACPI: Lid Switch [LID]
Oct  4 13:50:07 mobile kernel: ACPI: Processor [CPU0] (supports C1)
Oct  4 13:50:07 mobile kernel: ACPI: Thermal Zone [THM0] (60 C)

Oct  4 13:50:07 mobile kernel: ICH3M: IDE controller at PCI slot 0000:00:1f.1
Oct  4 13:50:07 mobile kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Oct  4 13:50:07 mobile kernel: ICH3M: chipset revision 1
Oct  4 13:50:07 mobile kernel: ICH3M: not 100%% native mode: will probe irqs later
Oct  4 13:50:07 mobile kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Oct  4 13:50:07 mobile kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Oct  4 13:50:07 mobile kernel: hda: TOSHIBA MK6021GAS, ATA DISK drive
Oct  4 13:50:07 mobile kernel: Using anticipatory io scheduler
Oct  4 13:50:07 mobile kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct  4 13:50:07 mobile kernel: hda: max request size: 128KiB
Oct  4 13:50:07 mobile kernel: hda: 117210240 sectors (60011 MB), CHS=65535/16/63, UDMA(100)
Oct  4 13:50:07 mobile kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3

Oct  4 13:50:07 mobile kernel: cpufreq: No CPUs supporting ACPI performance management found.
Oct  4 13:50:07 mobile kernel: BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Oct  4 13:50:07 mobile kernel: ACPI: (supports S0 S1 S3 S4 S5)


BTW: I have a P3 Mobile CPU, why doesn't it support cpufreq?

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III Mobile CPU      1133MHz
stepping        : 1
cpu MHz         : 1129.813


Thanks,

Nikolaus


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
