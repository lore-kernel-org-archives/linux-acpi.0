From: "Geoffrey Hausheer" <iw3r96f6j1h-jEt0PViQLFVB+phRjrLsidBPR1lH4CV8@public.gmane.org>
Subject: More sleeping woes
Date: Sat, 7 Sep 2002 10:08:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209071008.46766.ghausheer@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I've been playing around more with acpi, and stil have no luck getting sleep 
to work on my laptop (using either the .24 or 2.5 kernels)

I've pulled the latest 2.4 from linux-2.4-acpi bitkeeper.
I enabled acpi without modules.

I decompiled my dsdt, fixed one of these:
Error 1051 - Access width of Field Unit extends beyond region limit

and one of these:
Warning 2026 - Reserved method must return a value

added the required patches to build in my own dsdt table, and rebuilt the 
kernel.

Now when I do:
echo -n "1" > /proc/acpi/sleep
I just get:
hwsleep-0239 [02] Acpi_enter_sleep_state: Entering S1

and the system freezes solid (I get the same result if I don't use my own 
dsdt)

Besides this, acpi seems to work fine.  All button presses generate correct 
events, and the battery and ac adapter are correctly identified/

I've included the relevant portions of my syslog below.

I then tried using the 2.5 kernel (linux-2.5-acpi), which turned into a major 
pain, since the drivers for my laptop don't compile.

Anyhow, I got it running, but I don't see /proc/acpi/sleep even though my 
syslog shows
ACPI: System [ACPI] (supports S0 S1 S4 S5)

and /proc/acpi/info shows:
states: S0 S1 S4 S5

By the way, the laptop is a twinhead n2380 which uses the sis630st chipset,
and has a PIII (tualatin) mobile processor.

Any other suggestions would be appreciated,
Thanks.
Geoff

Syslog for 2.4.20-pre5 with latest acpi code:
-------------------------------------------------------
 BIOS-e820: 0000000015ff0000 - 0000000015ff8000 (ACPI data)
 BIOS-e820: 0000000015ff8000 - 0000000016000000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 AMI                        ) @ 0x000fd450
ACPI: RSDT (v001 AMIINT AMIINT09 00000.04096) @ 0x15ff0000
ACPI: FADT (v001 AMIINT AMIINT09 00000.04096) @ 0x15ff0030
ACPI: MADT not present
ACPI: Subsystem revision 20020829
   tbget-0272: *** Info: Table [DSDT] replaced by host OS
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing 
Methods:.....................................................................................
Table [DSDT] - 343 Objects with 35 Devices 85 Methods 16 Regions
ACPI Namespace successfully loaded at root c02f295c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:...................................
35 Devices found containing: 35 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package 
initialization:..........................................................
Initialized 11/16 Regions 6/6 Fields 21/21 Buffers 20/20 Packages (343 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 6 7 *10 11 14 15)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKB] (IRQs 6 7, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11, disabled)
pci_link-0245 [08] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7, disabled)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 6
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: AC Adapter [AC0] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LIDD]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
