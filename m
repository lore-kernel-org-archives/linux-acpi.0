From: shadowcat45-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org (Adrian)
Subject: ACPI on a Travelmate 420 - no battery load status
Date: Mon, 11 Nov 2002 23:29:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211112329.19136.udtx@rz.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi

I have some problems with ACPI on a Acer Travelmate 420 DLC.
First, ACPI works in some manner, /proc/acpi exists and gives me Info, a echo 
-n 0:2 > /proc/acpi/processor/CPU0/limit or an echo -n 3 > 
/proc/acpi/processor/CPU0/throttling does the job. The Fan is working, too.
However, 
cat /proc/acpi/battery/BAT1/state

gives me:

present:                 yes
ERROR: Unable to read battery status



It occurs with SuSE Kernel 2.4.19 (with ACPI patch 20020829) and also with 
the, today tested
Kernel 2.4.20-rc1 and the 20021101 patch
Here some additional Info:

> cat /proc/acpi/battery/BAT1/info

present:                 yes
design capacity:         6300 mAh
last full capacity:      6300 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 585 mAh
design capacity low:     175 mAh
capacity granularity 1:  64 mAh
capacity granularity 2:  64 mAh
model number:            GC86508SAT0
serial number:
battery type:            LiON
OEM info:                SANYO 

> cat /proc/acpi/info

version:                 20021101
states:                  S0 S3 S4 S5

> cat /proc/acpi/embedded_controller/EC0/info

gpe bit:                 0x1c
ports:                   0x66, 0x62
use global lock:         no

> cat /proc/acpi/processor/CPU0/info

processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      yes
performance management:  no
limit interface:         yes

> dmesg | grep ACPI

BIOS-e820: 000000000fef0000 - 000000000fefc000 (ACPI data)
 BIOS-e820: 000000000fefc000 - 000000000ff00000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6d20
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0fef65bc
ACPI: FADT (v001 INTEL  845M     01540.00000) @ 0x0fefbf8c
ACPI: DSDT (v001 COMPAL 845M     01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
ACPI: Subsystem revision 20021101
    ACPI-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0508: *** Info: GPE Block1 defined as GPE16 to GPE31
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 9, disabled)
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
apm: overridden by ACPI.
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]

I don't know what additional Info can help to investigate a more or less 
working ACPI, I have here also output from acpidmp and dmidecode (taken from 
ftp://ftp.suse.com/pub/people/ak/acpi/ ), however, this will make the mail a 
little bigger.
And the kernel panick-ed, when I tried to compile it with ACPI debugging on 
(the 2.4.20-rc1), so at the moment I can't show this. 
fadt contains at beginning FACP and a bit latter INTEL 845 M.
And the Notebook has  a Phoenix BIOS, ver 1.03c, the CPU is a Celeron 1700 
(also this should not matter the battery).

Is there a chance I can fix this or a latter upcoming patch can help ? It 
works on the (shipped with) Win XP and besides the battery, the rest is ok, 
so maybe this is a minor change.

Adrian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
