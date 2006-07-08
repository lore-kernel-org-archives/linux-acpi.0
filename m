From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: S3 suspend fails with lockdep BUG warning (TP T60, 2.6.18-rc1)
Date: Sat, 08 Jul 2006 03:15:54 +0100
Message-ID: <E1Fz2MM-0007zz-00@skye.ra.phy.cam.ac.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:25342 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932485AbWGHCP4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jul 2006 22:15:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm trying 2.6.18-rc1, on a Thinkpad T60 (dual-core, T2400) running
Ubuntu 6.06.  The kernel is SMP, PREEMPT, and has many of the lock
validation options turned on.  It has a SATA hard drive.  During boot
the lockdep checker reports good news:

[   20.936404] Good, all 218 testcases passed! |

When I pressed Fn-F4 (for suspend-to-ram), it began to suspend,
blanked the screen, and then came back right away to the X session.  I
don't think it ever made it into suspend mode.  And this dmesg showed
up:

[  459.756000] BUG: warning at kernel/lockdep.c:1799/trace_hardirqs_on()
[  459.756000]  [<c0105aeb>] show_trace+0x1b/0x20
[  459.756000]  [<c0105b14>] dump_stack+0x24/0x30
[  459.756000]  [<c013c186>] trace_hardirqs_on+0x166/0x180
[  459.756000]  [<c010522d>] do_general_protection+0xcd/0x220
[  459.756000]  [<c0103e01>] error_code+0x39/0x40

With the Ubuntu kernel (2.6.15-25-386, which is UP and has many Ubuntu
patches), S3 suspend/resume worked almost out of the box, amazingly.
The only glitch was I had to tell it unload/load ipw3945 if I wanted
the module to work correctly on resume.  But suspend/resume worked
fine at least 50 times, with only one failure that I couldn't
reproduce.

So I'm not sure what the vanilla 2.6.18-rc1 is missing.  Here are its
dmesgs after grepping for ACPI or lockdep:

[    0.000000]  BIOS-e820: 000000005f6e0000 - 000000005f6f3000 (ACPI data)
[    0.000000]  BIOS-e820: 000000005f6f3000 - 000000005f700000 (ACPI NVS)
[    0.000000] ACPI: RSDP (v002 LENOVO                                ) @ 0x000f68a0
[    0.000000] ACPI: XSDT (v001 LENOVO TP-79    0x00001060  LTP 0x00000000) @ 0x5f6e6342
[    0.000000] ACPI: FADT (v003 LENOVO TP-79    0x00001060 LNVO 0x00000001) @ 0x5f6e6400
[    0.000000] ACPI: SSDT (v001 LENOVO TP-79    0x00001060 MSFT 0x0100000e) @ 0x5f6e65b4
[    0.000000] ACPI: ECDT (v001 LENOVO TP-79    0x00001060 LNVO 0x00000001) @ 0x5f6f2d29
[    0.000000] ACPI: TCPA (v002 LENOVO TP-79    0x00001060 LNVO 0x00000001) @ 0x5f6f2d7b
[    0.000000] ACPI: MADT (v001 LENOVO TP-79    0x00001060 LNVO 0x00000001) @ 0x5f6f2dad
[    0.000000] ACPI: MCFG (v001 LENOVO TP-79    0x00001060 LNVO 0x00000001) @ 0x5f6f2e15
[    0.000000] ACPI: HPET (v001 LENOVO TP-79    0x00001060 LNVO 0x00000001) @ 0x5f6f2e53
[    0.000000] ACPI: BOOT (v001 LENOVO TP-79    0x00001060  LTP 0x00000001) @ 0x5f6f2fd8
[    0.000000] ACPI: SSDT (v001 LENOVO TP-79    0x00001060 INTL 0x20050513) @ 0x5f6e58fd
[    0.000000] ACPI: SSDT (v001 LENOVO TP-79    0x00001060 INTL 0x20050513) @ 0x5f6e5725
[    0.000000] ACPI: DSDT (v001 LENOVO TP-79    0x00001060 MSFT 0x0100000e) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[   21.102981] ACPI: Core revision 20060623
[   21.133796] lockdep: not fixing up alternatives.
[    0.144425] ACPI: ACPI Dock Station Driver 
[    0.144620] ACPI: bus type pci registered
[    0.148737] ACPI: Found ECDT
[    0.160892] ACPI: Interpreter enabled
[    0.160895] ACPI: Using IOAPIC for interrupt routing
[    0.162537] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[    0.163439] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
[    0.164374] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
[    0.165269] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[    0.166165] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[    0.167064] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[    0.167999] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
[    0.168900] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[    0.169673] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.178417] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.188993] ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
[    0.189526] ACPI: Power Resource [PUBS] (on)
[    0.191989] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
[    0.192314] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.192618] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
[    0.193040] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
[    0.193469] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[    0.198367] PCI: Using ACPI for IRQ routing
[    0.200857] Device `[EXP0]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 16
[    0.200905] Device `[EXP1]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 17
[    0.200948] Device `[EXP2]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 18
[    0.200992] Device `[EXP3]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 19
[    0.201050] Device `[CDBS]' is not power manageable<6>ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[    0.338721] ACPI: PCI Interrupt 0000:00:1f.1[C] -> GSI 16 (level, low) -> IRQ 20
[    2.122212] Device `[SATA]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
[   19.755384] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
[   19.863701] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
[   19.971301] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
[   20.079171] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
[   20.187571] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
[   20.409593] Device `[HDEF]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 21
[   20.985265] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[   32.864500] ACPI: AC Adapter [AC] (on-line)
[   32.919981] ACPI: Battery Slot [BAT0] (battery present)
[   32.953968] ACPI: Power Button (FF) [PWRF]
[   32.954003] ACPI: Lid Switch [LID]
[   32.954022] ACPI: Sleep Button (CM) [SLPB]
[   33.053362] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[   33.116020] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060623]
[   33.116608] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060623]
[   33.118064] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   33.118072] ACPI: Processor [CPU0] (supports 8 throttling states)
[   33.118967] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060623]
[   33.119362] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060623]
[   33.120617] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   33.120624] ACPI: Processor [CPU1] (supports 8 throttling states)
[   33.448000] ACPI: Thermal Zone [THM0] (46 C)
[   33.452000] ACPI: Thermal Zone [THM1] (48 C)
[   33.492000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   33.492000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   39.940000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 20
/* Here's where I do the first suspend (fn-F4) */
[  459.756000] BUG: warning at kernel/lockdep.c:1799/trace_hardirqs_on()
[  459.756000]  [<c0105aeb>] show_trace+0x1b/0x20
[  459.756000]  [<c0105b14>] dump_stack+0x24/0x30
[  459.756000]  [<c013c186>] trace_hardirqs_on+0x166/0x180
[  459.756000]  [<c010522d>] do_general_protection+0xcd/0x220
[  459.756000]  [<c0103e01>] error_code+0x39/0x40
[  461.980000] ACPI: Power Button (FF) [PWRF]
[  461.980000] ACPI: Lid Switch [LID]
[  461.980000] ACPI: Sleep Button (CM) [SLPB]
[  461.996000] ACPI: Thermal Zone [THM0] (44 C)
[  462.000000] ACPI: Thermal Zone [THM1] (47 C)
[  462.004000] ACPI Exception (evxface-0537): AE_BAD_PARAMETER, Removing notify handler [20060623]
[  462.012000] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[  462.032000] ACPI: AC Adapter [AC] (on-line)
[  462.052000] ACPI: Battery Slot [BAT0] (battery present)
/* I try again, which also fails and bounces back to the X session,
   but no lockdep warning this time */
[  626.012000] ACPI: Power Button (FF) [PWRF]
[  626.012000] ACPI: Lid Switch [LID]
[  626.012000] ACPI: Sleep Button (CM) [SLPB]
[  626.032000] ACPI: Thermal Zone [THM0] (44 C)
[  626.032000] ACPI: Thermal Zone [THM1] (46 C)
[  626.036000] ACPI Exception (evxface-0537): AE_BAD_PARAMETER, Removing notify handler [20060623]
[  626.056000] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[  626.076000] ACPI: AC Adapter [AC] (on-line)
[  626.100000] ACPI: Battery Slot [BAT0] (battery present)
