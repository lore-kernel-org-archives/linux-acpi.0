From: Bringfried Stecklum <stecklum-1rBFpveLbu3Y+tFAy8B5R7NAH6kLmebB@public.gmane.org>
Subject: ACPI EC error
Date: Tue, 3 Dec 2002 10:28:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212030928.gB39ST314290@methusalix.tls-tautenburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bound1038907709"
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
Cc: stecklum-V+qXmaGEZO+gRAseIu28DQq3RYOAlhC/epZhswDD4dQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--bound1038907709
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've got ACPI Subsystem revision 20020918 partly working with the 2.4.19 kernel.
Since several debug messages occured during boot time, I tried Subsystem revision
20021122 together with 2.4.20. However, the result is the same as you cna see below

<4> tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
<4>Parsing Methods:..........................................................................................................................................
<4>Table [DSDT] - 519 Objects with 49 Devices 138 Methods 14 Regions
<4>ACPI Namespace successfully loaded at root c02f12bc
<4>evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
<4> evevent-0511: *** Info: GPE Block0 defined as GPE0 to GPE15
<4> evevent-0511: *** Info: GPE Block1 defined as GPE16 to GPE31
<4>Executing all Device _STA and_INI methods:.................................................
<4>49 Devices found containing: 49 _STA, 2 _INI methods
<4>Completing Region/Field/Buffer/Package initialization:..................................................
<4>Initialized 10/14 Regions 0/0 Fields 18/18 Buffers 22/22 Packages (519 nodes)
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: System [ACPI] (supports S0 S3 S4 S5)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<4>Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
<4>pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:09.00 not present in PCI namespace
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
<6>ACPI: Embedded Controller [EC] (gpe 28)
<4>[ACPI Debug] String: _____________
<4>[ACPI Debug] String: |           |
<4>[ACPI Debug] String: |  EC._REG  |
<4>[ACPI Debug] String: |  Arg0=    
<4>[ACPI Debug] Integer: 0000000000000003
<4>[ACPI Debug] String: |  Arg1=    
<4>[ACPI Debug] Integer: 0000000000000001
<4>[ACPI Debug] String: |___________|
<6>PCI: Probing PCI hardware
<6>PCI: Using ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<6>Journalled Block Device driver loaded
<6>ACPI: AC Adapter [ADP0] (on-line)
<6>ACPI: Battery Slot [BAT0] (battery present)
<6>ACPI: Battery Slot [BAT1] (battery absent)
<6>ACPI: Power Button (CM) [PWRB]
<6>ACPI: Lid Switch [LID]
<6>ACPI: Sleep Button (CM) [SLPB]
<6>ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states, 8 throttling states)
<4>acpi_thermal-0313 [13] acpi_thermal_get_trip_: Invalid passive threshold
<6>ACPI: Thermal Zone [THM0] (40 C)

There seems to be a problem with the Embedded Controller. Perhaps for this reason
not information on fans and only one trip point (S5) is available in /proc/acpi.

I can send you the disassembled DSDT dump or other ACPI information if necessary.

kind regards,

                                        Bringfried Stecklum

--bound1038907709--


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
