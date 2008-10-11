From: Bumbl <bumbl3x3@gmail.com>
Subject: ACPI DMI - Uniwill P53IN
Date: Sat, 11 Oct 2008 15:31:33 +0200
Message-ID: <48F0AAB5.7050909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:10336 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbYJKNbi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 09:31:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so632633fgg.17
        for <linux-acpi@vger.kernel.org>; Sat, 11 Oct 2008 06:31:36 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi
I just want to send you the DMI information (a answer to ACPI: Please 
send DMI info above to linux-acpi@vger.kernel.org )
acpi_osi=Linux does not work very well (the fans won't work)
so i think you should not suggest using it as it is potentially harmful.

The notebook is based on this barebone, assembled by a local computer store

http://www.uniwill.com/products/performance/p53in/p53in.php?HL=2&P=3

If you need more information I would be happy to provide it.

Regards
    Bumbl

------------------------------------
uname -a

Linux hostname 2.6.26-gentoo-r1_stable #1 SMP PREEMPT Tue Sep 16 
17:49:18 CEST 2008 x86_64 Intel(R) Core(TM)2 CPU T7200 @ 2.00GHz 
GenuineIntel GNU/Linux

------------------------------------

lspci

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS, 943/940GML 
and 945GT Express Memory Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS, 943/940GML 
and 945GT Express PCI Express Root Port (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 1 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 3 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
Controller #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface 
Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE 
Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA 
IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller 
(rev 02)
01:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce Go 
7600] (rev a1)
04:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG 
Network Connection (rev 02)      

------------------------------------

dmesg | grep ACPI

 BIOS-e820: 000000007fe90000 - 000000007fe9b000 (ACPI data)
 BIOS-e820: 000000007fe9b000 - 000000007ff00000 (ACPI NVS)
ACPI: RSDP 000F77E0, 0014 (r0 PTLTD )
ACPI: RSDT 7FE945CD, 0048 (r1 PTLTD  PC        6040000  LTP        0)
ACPI: FACP 7FE9AE20, 0074 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: DSDT 7FE95CB6, 516A (r1  INTEL CALISTGA  6040000 INTL 20050624)
ACPI: FACS 7FE9BFC0, 0040
ACPI: APIC 7FE9AE94, 0068 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: HPET 7FE9AEFC, 0038 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: MCFG 7FE9AF34, 003C (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: APIC 7FE9AF70, 0068 (r1 FSC    PC        6040000  LTP        0)
ACPI: BOOT 7FE9AFD8, 0028 (r1 PTLTD  PC        6040000  LTP        1)
ACPI: SSDT 7FE95667, 064F (r1 SataRe  SataPri     1000 INTL 20050624)
ACPI: SSDT 7FE94FD5, 0692 (r1 SataRe  SataSec     1000 INTL 20050624)
ACPI: SSDT 7FE94615, 04F6 (r1  PmRef    CpuPm     3000 INTL 20050624)
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify 
linux-acpi@vger.kernel.org
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
ACPI: Core revision 20080321
ACPI: bus type pci registered
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: OEM
ACPI: DMI Product Name: P53IN4
ACPI: DMI Product Version: Not Applicable
ACPI: DMI Board Name: P53IN4
ACPI: DMI BIOS Vendor: OEM
ACPI: DMI BIOS Date: 02/02/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI: If "acpi_osi=Linux" works better, please notify 
linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: GPE = 0x19, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 *3 4 5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: WMI: Mapper loaded
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: AC Adapter [AC0] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: device:04 is registered as cooling_device0
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
ACPI: SSDT 7FE94D5B, 01F1 (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
ACPI: SSDT 7FE94B0B, 01CB (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: ACPI0007:00 is registered as cooling_device1
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT 7FE94F4C, 0089 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
ACPI: SSDT 7FE94CD6, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: ACPI0007:01 is registered as cooling_device2
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: LNXTHERM:01 is registered as thermal_zone0
ACPI: Thermal Zone [THRM] (59 C)
ACPI: PCI Interrupt 0000:05:05.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1f.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt for device 0000:04:00.0 disabled
ACPI: PCI Interrupt 0000:05:04.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 18 (level, low) -> IRQ 18

