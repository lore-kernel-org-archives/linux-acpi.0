From: Wilfried Catteau <wcatteau-44LmMf3qItpGWvitb5QawA@public.gmane.org>
Subject: PB with ACPI
Date: Sun, 6 Jun 2004 15:27:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406061329.i56DTZVg003339@smtp-1.nordnet.fr>
Reply-To: wcatteau-44LmMf3qItpGWvitb5QawA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
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

Hi,

I think i have a pb because these directories:

/proc/acpi/fan
/proc/acpi/thermal_zone
/proc/acpi/battery
/proc/acpi/power_resource
/proc/acpi/ac_adapter

are empty except for "/proc/acpi/button/power/PWRF/" and 
"/proc/acpi/processor/CPU0" which contain the file "info" like this:

processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
performance management:  no
limit interface:         no

is-it normal ?

Here are the messages relating to acpi:

BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6da0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff7640
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Subsystem revision 20040326
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
ACPI Namespace successfully loaded at root c043789c
ACPI: IRQ9 SCI: Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs *17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs 16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 9
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 9
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 11
ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)

My config: kernel 2.4.26, debian woody 3.0r2, GigaByte ga-7nnxp motherboard, 
athlon xp 1800+.

thanks,

Willy.



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
