From: Wilfried Catteau <wcatteau-44LmMf3qItpGWvitb5QawA@public.gmane.org>
Subject: Re: PB with ACPI
Date: Wed, 9 Jun 2004 08:46:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406090648.i596m7tp001490@smtp-1.nordnet.fr>
Reply-To: wcatteau-44LmMf3qItpGWvitb5QawA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Le Dimanche 6 Juin 2004 15:27, Wilfried Catteau a =E9crit :
> Hi,
>
> I think i have a pb because these directories:
>
> /proc/acpi/fan
> /proc/acpi/thermal_zone
> /proc/acpi/battery
> /proc/acpi/power_resource
> /proc/acpi/ac_adapter
>
> are empty except for "/proc/acpi/button/power/PWRF/" and "/proc/acpi/pr=
ocessor/CPU0" which contain the file "info" like this:
>
> processor id:            0
> acpi id:                 0
> bus mastering control:   no
> power management:        no
> throttling control:      no
> performance management:  no
> limit interface:         no
>
> is-it normal ?
>
> Here are the messages relating to acpi:
>
> BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
> BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
> ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6d=
a0
> ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff30=
00
> ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff30=
40
> ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff76=
40
> ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x000000=
00
> ACPI: Subsystem revision 20040326
>  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
> acquired ACPI Namespace successfully loaded at root c043789c
> ACPI: IRQ9 SCI: Level Trigger.
> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode succ=
essful
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S3 S4 S5)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [APC1] (IRQs *16)
> ACPI: PCI Interrupt Link [APC2] (IRQs *17)
> ACPI: PCI Interrupt Link [APC3] (IRQs *18)
> ACPI: PCI Interrupt Link [APC4] (IRQs *19)
> ACPI: PCI Interrupt Link [APC5] (IRQs 16)
> ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCS] (IRQs *23)
> ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 9
> ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 5
> ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 9
> ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 9
> ACPI: PCI Interrupt Link [LACI] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 5
> ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 5
> ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 9
> ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 5
> PCI: Using ACPI for IRQ routing
> ACPI: Power Button (FF) [PWRF]
> ACPI: Processor [CPU0] (supports C1)
>
> My config: kernel 2.4.26, debian woody 3.0r2, GigaByte ga-7nnxp motherb=
oard, athlon xp 1800+.
>
> thanks,

I forget these messages:

tbget-0291: *** Info: Table [DSDT] replaced by host OS
tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquir=
ed
Parsing all Control Methods:.............................................=
..................................................
Table [DSDT](id F004) - 693 Objects with 76 Devices 262 Methods 23 Region=
s
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode succes=
sful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at =
0000000000001020 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtim=
e GPEs in this block
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 32 to 95 [_GPE] 8 regs at =
00000000000014A0 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtim=
e GPEs in this block
Completing Region/Field/Buffer/Package initialization:...................=
.................................................
Initialized 23/23 Regions 1/1 Fields 29/29 Buffers 15/23 Packages (702 no=
des)
Executing all Device _STA and_INI methods:...............................=
...............................................
78 Devices found containing: 78 _STA, 1 _INI methods
pci_link-0261 [47] acpi_pci_link_get_curr: No IRQ resource found
pci_link-0261 [49] acpi_pci_link_get_curr: No IRQ resource found
pci_link-0261 [51] acpi_pci_link_get_curr: No IRQ resource found
pci_link-0261 [53] acpi_pci_link_get_curr: No IRQ resource found
pci_link-0261 [55] acpi_pci_link_get_curr: No IRQ resource found
pci_link-0261 [60] acpi_pci_link_get_curr: No IRQ resource found
pci_link-0261 [62] acpi_pci_link_get_curr: No IRQ resource found

I recompile the dsdt file with two errors fixed but the pb is still prese=
nt: it works only with the power button.

what can i do ?

Willy.


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
