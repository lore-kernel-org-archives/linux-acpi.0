From: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Subject: Re: No battery information - Compaq Evo N800v, 2.4.20pre8, acpi 20021002
Date: Tue, 7 Jan 2003 20:00:32 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301072000.32879.bob@diamond.demon.co.uk>
References: <200210081115.21667.mark.pritchard-acpi@modus.com.au> <200301031111.21645.bob@diamond.demon.co.uk> <871y3p6qd7.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <871y3p6qd7.fsf-E1YXmAG8v4VQD7NkSvH8p9BPR1lH4CV8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Last set of boot msgs

Note I have=20
PCI0 for C03C
AGP_ for C03D
HUB_ for C04E
EC0 for C0D0

It looks like you Power Resource references might be 1 off
my COM1 was originally C140
ref to C154(me) C155(you)
etc

ACPI: Subsystem revision 20020918
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3D3
PCI: Using configuration type 1
tbget-0274: *** Info: Table [DSDT] replaced by host OS
tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:.........................................................=
=2E...
=2E......................................................................=
=2E........
=2E......................................................................=
=2E........
=2E...................
Table [DSDT] - 779 Objects with 88 Devices 241 Methods 24 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c034a0bc
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode succes=
sful
Executing all Device _STA and_INI methods:...
evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0,=20
AE_ALREADY_EXISTS
evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0,
AE_ALREADY_EXISTS
evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0,=20
AE_ALREADY_EXISTS
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 2: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:04.01 not present=
 in
PCI namespace
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: Power Resource [COM1] (off)
ACPI: Power Resource [C154] (off)
ACPI: Power Resource [C158] (off)
ACPI: Power Resource [C15B] (off)
ACPI: Power Resource [MOUS] (on)
pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.00 not present=
 in
PCI namespace
pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.01 not present=
 in
PCI namespace
pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.02 not present=
 in
PCI namespace
pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.07 not present=
 in
PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 11, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *10 11)
pci_link-0122 [14] acpi_pci_link_get_poss: Blank IRQ resource
pci_link-0122 [14] acpi_pci_link_get_poss: Blank IRQ resource
pci_link-0122 [14] acpi_pci_link_get_poss: Blank IRQ resource
ACPI: Power Resource [AUDI] (on)
[ACPI Debug] String: Status PFN1
ACPI: Power Resource [PFN1] (off)
[ACPI Debug] String: Status PFN2
ACPI: Power Resource [PFN2] (off)
[ACPI Debug] String: Status PFN3
ACPI: Power Resource [PFN3] (off)
[ACPI Debug] String: Status PFN4
ACPI: Power Resource [PFN4] (off)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: Using ACPI for IRQ routing

Last reference to ACPI

Hope this helps

Bob


On Tuesday 07 January 2003 13:28, Alexander Hoogerhuis wrote:
> What messages do you get during bootup, I get these ones with the
> somewhat working DSDT:
>
> .
> .
> .
> ACPI: Subsystem revision 20021212
> PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3D3
> PCI: Using configuration type 1
>     ACPI-0274: *** Info: Table [DSDT] replaced by host OS
>     ACPI-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
>     ACPI-0263: *** Info: GPE Block1 defined as GPE16 to GPE31
>     ACPI-0243: *** Error: Could not install Pci_config handler for C03C=
,
> AE_ALREADY_EXISTS ACPI-0243: *** Error: Could not install Pci_config
> handler for C03C, AE_ALREADY_EXISTS ACPI-0243: *** Error: Could not ins=
tall
> Pci_config handler for C03C, AE_ALREADY_EXISTS ACPI: Interpreter enable=
d
> ACPI: Using PIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S3 S4 S5)
> ACPI: PCI Root Bridge [C03C] (00:00)
> PCI: Probing PCI hardware (bus 00)
> Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
> ACPI: PCI Interrupt Routing Table [\_SB_.C03C._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C03D._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C04E._PRT]
> ACPI: Embedded Controller [C0D0] (gpe 29)
> schedule_task(): keventd has not started
> ACPI: Power Resource [C141] (off)
> ACPI: Power Resource [C155] (off)
> ACPI: Power Resource [C159] (off)
> .
> .
> .
>
> The errors from the ACPI subsystem, and a schduling problem towards
> the bottom there.
>
> mvh,
> A
>



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
