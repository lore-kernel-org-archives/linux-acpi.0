From: Andre Messerschmidt <a.messerschmidt-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: ASUS M6800N: battery0 not present
Date: Wed, 18 Feb 2004 08:52:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402180852.16189.a.messerschmidt@gmx.net>
References: <40324F44.60006@pca.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40324F44.60006-wlebWZzHoyE@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: Markus Gaugusch <dsdt-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Dienstag, 17. Februar 2004 18:28 schrieb Luca Capello:

Hi Luca,

I don't have any errors if I use my DSDT. See the attached output from dmesg 
for how it looks here with a 2.4.21. 
I reckon that you are right with your assumption that the new DSDT table is 
not used, but I don't know why, since I have no insights in  ACPI.

regards
Andre


----- from dmesg --------------------------
...
Looking for DSDT in initrd ... found (at offset 452594)!
    ACPI-0292: *** Info: Table [DSDT] replaced by host OS
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM/DBM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: Power Resource [GFAN] (off)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 4
00:00:1f[B] -> IRQ 4 Mode 1 Trigger 1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
00:00:1f[A] -> IRQ 9 Mode 1 Trigger 1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
00:00:01[A] -> IRQ 11 Mode 1 Trigger 1
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
00:00:1d[D] -> IRQ 10 Mode 1 Trigger 1
PIC: IRQ (11) already programmed
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
00:00:1d[B] -> IRQ 5 Mode 1 Trigger 1
PIC: IRQ (9) already programmed
PIC: IRQ (4) already programmed
PIC: IRQ (11) already programmed
PIC: IRQ (9) already programmed
PIC: IRQ (4) already programmed
PIC: IRQ (4) already programmed
PIC: IRQ (5) already programmed
PIC: IRQ (11) already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
...
ACPI: AC Adapter [AC] (on-line)
Asus Laptop ACPI Extras version 0.24a
  M6N model detected, unsupported, trying default values, contact the 
developers
  Notify Handler installed successfully
  Error changing brightness
  Error changing brightness
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FN00] (on)
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (21 C)
-----------------------------------------------



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
