From: "DPR" <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Subject: RE: APIC, USB mouse and errors
Date: Fri, 28 Feb 2003 23:47:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c2df7b$62cb3050$0200a8c0@brutzler>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10476BF94@cceexc19.americas.cpqcorp.net>
Reply-To: <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0001_01C2DF83.C48F9850"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD10476BF94-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Cagle, John (ISS-Houston)'" <john.cagle-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C2DF83.C48F9850
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Here are the messages the ACPI/APIC system produces during the boot =
process. Perhaps this will
provide the information you need to fix my problem :)
I don't understand why there're no IRQs above 17 ! Windows maps the IRQs =
18, 19, 21 and 23 for
my audio/IEEE 1394/USB and ethernet devices.

Besides - the latest "20030228" version doesn't fix my problem. Same =
"APIC error on CPU0 40(40)"
messages if I use the "noapic" parameter and "USB device not accepting =
new address" error if I
don't use "noapic".

Thanks for any answer in advance,

HOLGER

> What does 'cat /proc/interrupts' show when your running this=20
> new kernel?
>=20
> Regards,
> John
> --------------------------------
> John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
> Principal Member Technical Staff
>    Industry Standard Servers
>     Hewlett-Packard Company
>     http://www.hp.com/linux

------=_NextPart_000_0001_01C2DF83.C48F9850
Content-Type: text/plain;
	name="boot_msg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="boot_msg.txt"

<6>ACPI: RSDP (v000 VIA694                     ) @ 0x000f7850=0A=
<6>ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3000=0A=
<6>ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3040=0A=
<6>ACPI: MADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff7200=0A=
<6>ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000=0A=
<5>ACPI: BIOS passes blacklist=0A=
<6>ACPI: Local APIC address 0xfee00000=0A=
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)=0A=
<4>Processor #0 Pentium(tm) Pro APIC version 16=0A=
<6>ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])=0A=
<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])=0A=
<6>IOAPIC[0]: Assigned apic_id 2=0A=
<4>IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23=0A=
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] =
trigger[0x0])=0A=
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] =
trigger[0x0])=0A=
<6>Using ACPI (MADT) for SMP configuration information=0A=
=0A=
<SNIP>=0A=
=0A=
<4>ENABLING IO-APIC IRQs=0A=
<7>init IO_APIC IRQs=0A=
<7> IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, =
2-23 not connected.=0A=
<6>..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0=0A=
<7>number of MP IRQ sources: 16.=0A=
<7>number of IO-APIC #2 registers: 24.=0A=
<6>testing the IO APIC.......................=0A=
<4>=0A=
<7>IO APIC #2......=0A=
<7>.... register #00: 02000000=0A=
<7>.......    : physical APIC id: 02=0A=
<7>.... register #01: 00178003=0A=
<7>.......     : max redirection entries: 0017=0A=
<7>.......     : PRQ implemented: 1=0A=
<7>.......     : IO APIC version: 0003=0A=
<7>.... IRQ redirection table:=0A=
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   =0A=
<7> 00 000 00  1    0    0   0   0    0    0    00=0A=
<7> 01 0FF 0F  0    0    0   0   0    1    1    39=0A=
<7> 02 0FF 0F  0    0    0   0   0    1    1    31=0A=
<7> 03 0FF 0F  0    0    0   0   0    1    1    41=0A=
<7> 04 0FF 0F  0    0    0   0   0    1    1    49=0A=
<7> 05 0FF 0F  0    0    0   0   0    1    1    51=0A=
<7> 06 0FF 0F  0    0    0   0   0    1    1    59=0A=
<7> 07 0FF 0F  0    0    0   0   0    1    1    61=0A=
<7> 08 0FF 0F  0    0    0   0   0    1    1    69=0A=
<7> 09 0FF 0F  0    0    0   0   0    1    1    71=0A=
<7> 0a 0FF 0F  0    0    0   0   0    1    1    79=0A=
<7> 0b 0FF 0F  0    0    0   0   0    1    1    81=0A=
<7> 0c 0FF 0F  0    0    0   0   0    1    1    89=0A=
<7> 0d 0FF 0F  0    0    0   0   0    1    1    91=0A=
<7> 0e 0FF 0F  0    0    0   0   0    1    1    99=0A=
<7> 0f 0FF 0F  0    0    0   0   0    1    1    A1=0A=
<7> 10 000 00  1    0    0   0   0    0    0    00=0A=
<7> 11 000 00  1    0    0   0   0    0    0    00=0A=
<7> 12 000 00  1    0    0   0   0    0    0    00=0A=
<7> 13 000 00  1    0    0   0   0    0    0    00=0A=
<7> 14 000 00  1    0    0   0   0    0    0    00=0A=
<7> 15 000 00  1    0    0   0   0    0    0    00=0A=
<7> 16 000 00  1    0    0   0   0    0    0    00=0A=
<7> 17 000 00  1    0    0   0   0    0    0    00=0A=
<7>IRQ to pin mappings:=0A=
<7>IRQ0 -> 0:2=0A=
<7>IRQ1 -> 0:1=0A=
<7>IRQ3 -> 0:3=0A=
<7>IRQ4 -> 0:4=0A=
<7>IRQ5 -> 0:5=0A=
<7>IRQ6 -> 0:6=0A=
<7>IRQ7 -> 0:7=0A=
<7>IRQ8 -> 0:8=0A=
<7>IRQ9 -> 0:9=0A=
<7>IRQ10 -> 0:10=0A=
<7>IRQ11 -> 0:11=0A=
<7>IRQ12 -> 0:12=0A=
<7>IRQ13 -> 0:13=0A=
<7>IRQ14 -> 0:14=0A=
<7>IRQ15 -> 0:15=0A=
<6>.................................... done.=0A=
<4>Using local APIC timer interrupts.=0A=
<4>calibrating APIC timer ...=0A=
<4>..... CPU clock speed is 1670.5134 MHz.=0A=
<4>..... host bus clock speed is 267.2820 MHz.=0A=
<4>cpu: 0, clocks: 2672820, slice: 1336410=0A=
<4>CPU0<T0:2672816,T1:1336400,D:6,S:1336410,C:2672820>=0A=
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)=0A=
<4>mtrr: detected mtrr type: Intel=0A=
<6>ACPI: Subsystem revision 20030122=0A=
<6>PCI: PCI BIOS revision 2.10 entry at 0xfb3d0, last bus=3D1=0A=
<6>PCI: Using configuration type 1=0A=
<6>ACPI: Interpreter enabled=0A=
<6>ACPI: Using IOAPIC for interrupt routing=0A=
<6>ACPI: System [ACPI] (supports S0 S3 S4 S5)=0A=
<6>ACPI: PCI Root Bridge [PCI0] (00:00)=0A=
<4>PCI: Probing PCI hardware (bus 00)=0A=
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]=0A=
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)=0A=
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)=0A=
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)=0A=
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 *14 15)=0A=
<4>ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)=0A=
<4>ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)=0A=
<4>ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)=0A=
<4>ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)=0A=
<6>PCI: Probing PCI hardware=0A=
<4>ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0=0A=
<4>ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0=0A=
<4>ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0=0A=
<4>ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0=0A=
<7>IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)=0A=
<7>00:00:08[A] -> 2-16 -> IRQ 16=0A=
<7>IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)=0A=
<7>00:00:08[B] -> 2-17 -> IRQ 17=0A=
<7>IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)=0A=
<7>00:00:08[C] -> 2-18 -> IRQ 18=0A=
<7>IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)=0A=
<7>00:00:08[D] -> 2-19 -> IRQ 19=0A=
<7>Pin 2-17 already programmed=0A=
<7>Pin 2-18 already programmed=0A=
<7>Pin 2-19 already programmed=0A=
<7>Pin 2-16 already programmed=0A=
<7>Pin 2-18 already programmed=0A=
<7>Pin 2-19 already programmed=0A=
<7>Pin 2-16 already programmed=0A=
<7>Pin 2-17 already programmed=0A=
<7>Pin 2-19 already programmed=0A=
<7>Pin 2-16 already programmed=0A=
<7>Pin 2-17 already programmed=0A=
<7>Pin 2-18 already programmed=0A=
<7>Pin 2-18 already programmed=0A=
<7>Pin 2-19 already programmed=0A=
<7>Pin 2-16 already programmed=0A=
<7>Pin 2-17 already programmed=0A=
<7>Pin 2-19 already programmed=0A=
<7>Pin 2-16 already programmed=0A=
<7>Pin 2-17 already programmed=0A=
<7>Pin 2-18 already programmed=0A=
<7>Pin 2-17 already programmed=0A=
<7>Pin 2-18 already programmed=0A=
<7>Pin 2-19 already programmed=0A=
<7>Pin 2-16 already programmed=0A=
<7>Pin 2-16 already programmed=0A=
<7>Pin 2-17 already programmed=0A=
<7>Pin 2-18 already programmed=0A=
<7>Pin 2-19 already programmed=0A=
<4>PCI: No IRQ known for interrupt pin A of device 00:10.0=0A=
<4>PCI: No IRQ known for interrupt pin B of device 00:10.1=0A=
<4>PCI: No IRQ known for interrupt pin C of device 00:10.2=0A=
<4>PCI: No IRQ known for interrupt pin D of device 00:10.3=0A=
<4>PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ =
255=0A=
<4>PCI: No IRQ known for interrupt pin A of device 00:12.0=0A=
<6>PCI: Using ACPI for IRQ routing=0A=
<6>PCI: if you experience problems, try using option 'pci=3Dnoacpi' or =
even 'acpi=3Doff'=0A=
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe80=0A=
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbeb0, dseg 0xf0000=0A=
<6>PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver=0A=
<6>PnPBIOS: PNP0c02: ioport range 0x3f0-0x3f1 has been reserved=0A=
=0A=
<SNIP>
------=_NextPart_000_0001_01C2DF83.C48F9850--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
