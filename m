From: Nicolas Sabouret <Nicolas.Sabouret-L2FTfq7BK8M@public.gmane.org>
Subject: Several problems with sleep states
Date: Fri, 27 Feb 2004 10:19:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <403F0BA9.6060905@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

following problems:
1. echo -n "disk" > /sys/power/state => nothing happens
2. echo -n "mem" > /sys/power/state => the computer enters "suspend on 
ram" mode (the suspend light gets on, etc...) when I try to wake up the 
computer, it hangs (some noise indicating that the disks are woken up 
and then nothing but a blank screen, even starting from console).

3. It has certainly nothing to do with what I said before, but I cannot 
find a /proc/acpi/processor/CPU0/performance (I have all the other files 
you mention in your Documentation section).

Here is an output of dmesg | grep acpi :
  BIOS-e820: 000000000bf70000 - 000000000bf7c000 (ACPI data)
  BIOS-e820: 000000000bf7c000 - 000000000bf80000 (ACPI NVS)
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6c90
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0bf75dcd
ACPI: FADT (v001 ATI    Salmon   0x06040000 ATI  0x000f4240) @ 0x0bf7bf64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0bf7bfd8
ACPI: DSDT (v001    ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
Kernel command line: auto BOOT_IMAGE=Linux ro root=306 acpi=force
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10)
ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK2] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK3] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK4] (IRQs 7 11)
ACPI: PCI Interrupt Link [LNK5] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNK6] (IRQs 7 10)
ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
ACPI: PCI Interrupt Link [LNK8] (IRQs 7 10)
ACPI: Embedded Controller [EC0] (gpe 24)
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
ACPI: (supports S0 S3 S4 S5)
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Thermal Zone [THRM] (33 C)


and the output of cat /proc/interrupts:
            CPU0
   0:    2204170          XT-PIC  timer
   1:       7729          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:          0          XT-PIC  ALi Audio Accelerator
   8:          4          XT-PIC  rtc
   9:        330          XT-PIC  acpi
  10:      76313          XT-PIC  uhci_hcd, uhci_hcd, eth0
  11:          0          XT-PIC  ehci_hcd
  12:      23016          XT-PIC  i8042
  14:      51108          XT-PIC  ide0
  15:          1          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0

Thanks in advance for your help.

Nico.
-- 
Nicolas SABOURET
Laboratoire d'Informatique de Paris 6 (LIP6)
8, rue du Capitaine Scott, 75015 Paris, France
http://www-oasis.lip6.fr/~sabouret


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
