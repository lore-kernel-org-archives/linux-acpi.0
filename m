From: andy-gRfBfDTKyCbR7s880joybQ@public.gmane.org
Subject: Re: ACPI patches updated (20021111)
Date: Wed, 13 Nov 2002 00:33:21 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0211130026080.6089-100000@tweek.neosouth.net>
References: <Pine.LNX.4.44.0211121706300.5656-100000@tweek.neosouth.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0211121706300.5656-100000-ngKEbFOxXuyOOqyHHM4PTqxOck334EZe@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org" <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 12 Nov 2002, andy-gRfBfDTKyCbR7s880joybQ@public.gmane.org wrote:

> On my Compaq Presario 2700T (currently running 2.5.47), it makes the ACPI
> actually work correctly with the stock (bogus) DSDT. I can actually see
> the battery and thermal zone now. Previously the battery would not show up
> and often the thermal zone initialization croaked on an uninitialized
> variable.

Well I jinxed it. On one reboot, it froze during initialization (_STA and
_INI methods, I think).  On another, it was back to it's old behavior. Is
it possible that some of the initialization occurs in a non-deterministic
order?

DSDT at http://neosouth.net/compaq-presario-2700T-dsdt

ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6180
ACPI: RSDT (v001 PTLTD  	 RSDT   01540.00000) @ 0x0ff6d127
ACPI: FADT (v001 INTEL  Almador  01540.00000) @ 0x0ff73b64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0ff73bd8
ACPI: DSDT (v001  INTEL  ALMADOR 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
...
ACPI: Subsystem revision 20021111
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:.............................................................................................................................................................................................................................
Table [DSDT] - 679 Objects with 57 Devices 221 Methods 25 Regions
ACPI Namespace successfully loaded at root c0449bdc
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
 evevent-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
 evevent-0508: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI methods:.........................................................
57 Devices found containing: 57 _STA, 5 _INI methods
Completing Region/Field/Buffer/Package initialization:........................................................................
Initialized 16/25 Regions 0/0 Fields 28/28 Buffers 28/28 Packages (679 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 12 14 15, disabled)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PLPC] (on)
pci_bind-0191 [17] acpi_pci_bind         : Device 00:00:1f.06 not present in PCI namespace
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
...
[ACPI Debug] String: INIT BATO in acad.psr
[ACPI Debug] String: INIT BATO in acad.psr
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
[ACPI Debug] String: ========= BAT1 UPBI =========
dsmthdat-0433 [34] Ds_method_data_get_val: Uninitialized Local[3] at node cfecc950
 psparse-1155: *** Error: Method execution failed, AE_AML_UNINITIALIZED_LOCAL
Method pathname:  \_TZ_.THRM._TMP (Node cfeb6dec)
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
[ACPI Debug] Integer: 0000000000000014
[ACPI Debug] String: BATD=
[ACPI Debug] Integer: 00000000000010F1
[ACPI Debug] String: BATO=
[ACPI Debug] Integer: 00000000000000C0
[ACPI Debug] String: Notify Bat1 00
[ACPI Debug] String: Skip init BATO
[ACPI Debug] String: Skip init BATO
[ACPI Debug] String: ========= BAT1 UPBI =========




-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
