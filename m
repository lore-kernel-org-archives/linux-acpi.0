From: "Miles Lane" <miles.lane@gmail.com>
Subject: 2.6.17-rc6-mm1 -- acpi_processor-0731 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
Date: Wed, 7 Jun 2006 22:32:17 -0700
Message-ID: <a44ae5cd0606072232u40998475wd24c882b56f38f68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.194]:25415 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932505AbWFHFcR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Jun 2006 01:32:17 -0400
Received: by wx-out-0102.google.com with SMTP id h28so246325wxd
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jun 2006 22:32:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Hello,

I am not sure whether this is an error that needs following up on.
My machine is a HP dv1240us (Pavillion laptop).  I ran "dmesg | grep -i acpi":

 BIOS-e820: 000000003dee0000 - 000000003deec000 (ACPI data)
 BIOS-e820: 000000003deec000 - 000000003df00000 (ACPI NVS)
ACPI: RSDP (v000 HP                                    ) @ 0x000f7e00
ACPI: RSDT (v001 HP     09B8     0x06040000  LTP 0x00000000) @ 0x3dee76bb
ACPI: FADT (v001 HP     09B8     0x06040000 PTL  0x00000050) @ 0x3deebe8c
ACPI: HPET (v001 HP     09B8     0x06040000 PTL  0x00000000) @ 0x3deebf00
ACPI: MADT (v001 HP     09B8     0x06040000 PTL  0x00000050) @ 0x3deebf38
ACPI: MADT (v001 HP     09B8     0x06040000 PTL  0x00000000) @ 0x3deebf92
ACPI: BOOT (v001 HP     09B8     0x06040000  LTP 0x00000001) @ 0x3deebfd8
ACPI: SSDT (v001 HP     09B8     0x00000001 INTL 0x20030224) @ 0x3dee7afe
ACPI: SSDT (v001 HP     09B8     0x00002000 INTL 0x20030224) @ 0x3dee76fb
ACPI: DSDT (v001 HP     09B8     0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: 2 duplicate APIC table ignored.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: HPET id: 0x8086a201 base: 0x0
Using ACPI (MADT) for SMP configuration information
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
ACPI Namespace successfully loaded at root c0682e58
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
ACPI: bus type pci registered
ACPI: Subsystem revision 20060310
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
ACPI: PCI Interrupt Link [LNKC] (IRQs *4)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3)
ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *4)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3)
ACPI: Embedded Controller [H_EC] (gpe 29) interrupt mode.
pnp: PnP ACPI init
pnp: PnP ACPI: found 7 devices
PCI: Using ACPI for IRQ routing
ACPI (acpi_bus-0192): Device [CBUS] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 20 (level, low) -> IRQ 16
apm: overridden by ACPI.
ACPI (acpi_bus-0192): Device [GFX0] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 17
ACPI (acpi_bus-0192): Device [MODM] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 18
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
ACPI (acpi_bus-0192): Device [LAN] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 19
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
ACPI (acpi_bus-0192): Device [IEEE] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:02:09.2[C] -> GSI 22 (level, low) -> IRQ 21
ACPI (acpi_bus-0192): Device [USB7] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 22
ACPI (acpi_bus-0192): Device [MINI] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 19
ACPI (acpi_bus-0192): Device [AUD0] is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 18
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Time: acpi_pm clocksource has been installed.


0000:00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
0000:00:00.1 System peripheral: Intel Corporation 82852/82855
GM/GME/PM/GMV Processor to I/O Controller (rev 02)
0000:00:00.3 System peripheral: Intel Corporation 82852/82855
GM/GME/PM/GMV Processor to I/O Controller (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corporation 82852/855GM
Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corporation 82852/855GM
Integrated Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM
(ICH4/ICH4-M) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC
Interface Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03)
0000:02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)0000:02:06.0 Network controller: Intel
Corporation PRO/Wireless 2200BG (rev 05)
0000:02:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
0000:02:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant
IEEE 1394 Host Controller
0000:02:09.3 Mass storage controller: Texas Instruments PCIxx21
Integrated FlashMedia Controller0000:02:09.4 0805: Texas Instruments
PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI7421, PCI7611, PCI7621
Secure Digital (SD) Controller
