From: Ville =?ISO-8859-1?Q?P=E4tsi?= <drc-dZkOyQknF4g@public.gmane.org>
Subject: Acer 233xc dsdt table broken?
Date: 18 Jun 2003 12:36:12 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1055928971.2970.14.camel@corsair>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

I get no compile errors with the current dsdt table, but sleep mode S1
or cooling_mode aren't supported. Throttle works fine, and the fan seems
to adapt to the temperature. At ~23C the fan is almost silent, and at
~46C+ it blows with full speed. /proc/acpi/fan is empty. The original
dsdt table is available here:

http://mail.ramk.fi/~drc/dsdt-acer-233xc.dsl.gz

I personally have no programming knowledge.

ACPI bootup messages (2.4.21-rc1): 

ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f5c60
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0f7698d1
ACPI: FADT (v001 INTEL  NBGV     01540.00000) @ 0x0f76df14
ACPI: MADT (v001 PTLTD           APIC   01540.00000) @ 0x0f76df88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0f76dfd8
ACPI: DSDT (v001   WIST  PELICAN 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Subsystem revision 20030522
    ACPI-0286: *** Error: No installed handler for fixed event
[00000000]
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs *11)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (23 C)
    ACPI-0286: *** Error: No installed handler for fixed event
[00000000]
    ACPI-0286: *** Error: No installed handler for fixed event
[00000000]





-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
