From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: acpi debug messages from compaq presario 2800...
Date: Wed, 7 Aug 2002 16:54:19 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807225425.5804.qmail@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Here are the debug boot up messages from my compaq presario. This is
using a modified dsdt that I changed the *PNP to PNP. 

A few issues: 

 BIOS-e820: 000000002fff0c00 - 000000002fffc000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 COMPAQ                     ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ CPQ004A  12549.00544) @ 0x2fff0c84
ACPI: FADT (v002 COMPAQ CPQ004A  00000.00002) @ 0x2fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 00000.04097) @ 0x2fff64c3
ACPI: SSDT (v001 COMPAQ   CPQMag 00000.04097) @ 0x2fff65d1
ACPI: Subsystem revision 20020725
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
   tbget-0272: *** Info: Table [DSDT] replaced by host OS
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:.............................................................................................
.............................................................................................................
.......................................
Table [DSDT] - 780 Objects with 88 Devices 241 Methods 24 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c034b61c
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:...evrgnini-0243: *** Error:
Could not install Pci_config handler for C03C, AE_ALREADY_EXISTS 
....evrgnini-0243: *** Error: Could not install Pci_config handler for
C03C, AE_ALREADY_EXISTS

Is this a problem? Any ideas what C03C is? 

.............................................................evrgnini-0243: *** Error: Could not install Pci_
config handler for C03C, AE_ALREADY_EXISTS
....................
88 Devices found containing: 88 _STA, 5 _INI methods
Completing Region/Field/Buffer/Package initialization:.......................................................
......................................
Initialized 14/24 Regions 0/0 Fields 25/26 Buffers 54/63 Packages (796 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
dsopcode-0497 [19] Ds_init_buffer_field  : Field size 1184 exceeds Buffer size 1088 (bits)
dswstate-0252 [19] Ds_result_pop_from_bot: No result objects! State=effc3828
 dsutils-0462 [19] Ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
 dsutils-0555 [18] Ds_create_operands    : While creating Arg 1 - AE_AML_NO_RETURN_VALUE
dswstate-0252 [19] Ds_result_pop_from_bot: No result objects! State=effc3428
 dsutils-0462 [19] Ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
 dsutils-0555 [18] Ds_create_operands    : While creating Arg 1 - AE_AML_NO_RETURN_VALUE
 rsutils-0153 [10] Rs_get_crs_method_data: No object was returned from _CRS

Are any of these bad? Anything I can do to help fix them?

ACPI: PCI Root Bridge [C03C] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.C03C._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C03D._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C04E._PRT]
pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:04.01 not present in PCI namespace

What device isn't present?

ACPI: Embedded Controller [C0D0] (gpe 29)
ACPI: Power Resource [C140] (off)
ACPI: Power Resource [C154] (off)
ACPI: Power Resource [C158] (off)
ACPI: Power Resource [C15B] (off)
ACPI: Power Resource [C164] (on)
pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.00 not present in PCI namespace
pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.01 not present in PCI namespace
pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.02 not present in PCI namespace
pci_bind-0194 [11] acpi_pci_bind         : Device 00:00:1d.07 not present in PCI namespace

more no devices. Any way to track them down?

ACPI: PCI Interrupt Link [C0B6] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0B7] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [C0B8] (IRQs 5 10 11, disabled)
ACPI: PCI Interrupt Link [C0B9] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BA] (IRQs 5 *10 11)
pci_link-0122 [14] acpi_pci_link_get_poss: Blank IRQ resource
pci_link-0122 [14] acpi_pci_link_get_poss: Blank IRQ resource
pci_link-0122 [14] acpi_pci_link_get_poss: Blank IRQ resource
ACPI: Power Resource [C0CF] (on)
ACPI: Power Resource [C1D0] (off)
ACPI: Power Resource [C1D1] (off)
ACPI: Power Resource [C1D2] (off)
ACPI: Power Resource [C1D3] (off)
ACPI: PCI Interrupt Link [C0B8] enabled at IRQ 5

Let me know if I can provide any more information to helping to track
these down. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE9UaUh3imCezTjY0ERAqYVAJ9aRicrUb0MqQhwIuPz4pc++eAq5gCdHbZu
ELCS5p2OzgBrc2K/NqvLL3k=
=05Fi
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
