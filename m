From: Joey Crivello <icypyro-TsGEh1ee8XYAvxtiuMwx3w@public.gmane.org>
Subject: C3 State Not Detected/ Pentium M
Date: Mon, 25 Oct 2004 02:09:05 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <417CA691.8090106@wi.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hey all,

I have a Sony Vaio Z1-VA with a Pentium M 1.6 GHz CPU, and my ACPI 
package is not detecting the C3 power state (which I'm almost sure the 
P-M has... I might be wrong though?)

I don't know exactly what information is needed to troubleshoot my 
problem, so I have included quite a bit of output below from some of the 
less verbose programs that were suggested on http://acpi.sourceforge.net/.

Thanks,

Joe Crivello


# cat /proc/acpi/processor/CPU0/power
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] 
usage[00000010]
   *C2:                  promotion[--] demotion[C1] latency[001] 
usage[00176695]
    C3:                  <not supported>

# dmesg | grep -i acpi
 BIOS-e820: 000000001ff70000 - 000000001ff7c000 (ACPI data)
 BIOS-e820: 000000001ff7c000 - 000000001ff80000 (ACPI NVS)
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f69d0
ACPI: RSDT (v001   SONY       G0 0x20030724 PTL  0x00000000) @ 0x1ff7806b
ACPI: FADT (v002   SONY       G0 0x20030724 PTL  0x00000050) @ 0x1ff7bec2
ACPI: BOOT (v001   SONY       G0 0x20030724 PTL  0x00000001) @ 0x1ff7bfd8
ACPI: SSDT (v001   SONY       G0 0x20030724 PTL  0x00000000) @ 0x1ff7809b
ACPI: DSDT (v001   SONY       G0 0x20030724 PTL  0x0100000e) @ 0x00000000
ACPI: Looking for DSDT in initrd... not found!
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *3
ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 28)
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:05.1[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [ATF0] (58 C)
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:
ACPI: PCI interrupt 0000:02:05.1[B] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 9 (level, low) -> IRQ 9

# dmesg | grep -i cpu
Initializing CPU#0
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: After vendor identify, caps:  a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        a7e9f9bf 00000000 00000000 00000040
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)

# lspci
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O 
Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller 
(rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB2 
EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 Mobile PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM (ICH4-M) LPC Interface 
Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4-M) IDE Controller 
(rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
AC'97 Modem Controller (rev 03)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon 
Mobility M6 LY
0000:02:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev b8)
0000:02:05.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C551 IEEE 1394 Controller
0000:02:08.0 Ethernet controller: Intel Corp. 82801DB PRO/100 VE (MOB) 
Ethernet Controller (rev 83)
0000:02:0b.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B 
Mini PCI Adapter (rev 04)

# cat /proc/interrupts
           CPU0
  0:   15415693          XT-PIC  timer
  1:      17307          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  9:      83796          XT-PIC  acpi, yenta, ehci_hcd, uhci_hcd, 
uhci_hcd, uhci_hcd, Intel 82801DB-ICH4, ohci1394, eth2
 12:     306582          XT-PIC  i8042
 14:     151739          XT-PIC  ide0
 15:         11          XT-PIC  ide1
NMI:          0
ERR:          0


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
