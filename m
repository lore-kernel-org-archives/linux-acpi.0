From: Werner Schweer <ws-XKvGbLkbjOk@public.gmane.org>
Subject: Samsung T10
Date: Sat, 23 Nov 2002 12:56:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211231256.09644.ws@seh.de>
Reply-To: ws-XKvGbLkbjOk@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

i did not get any battery information on my samsung t10
(/proc/acpi/battery is empty).

The startup log says:

...
Linux version 2.5.49 (ws@t10) (gcc version 3.1.1) #19 Sat Nov 23 11:28:24 CET 2002
...
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f62d0
ACPI: RSDT (v001 PTLTD  Sheeks   01540.00000) @ 0x0fefa8cb
ACPI: FADT (v001 INTEL  845MP    01540.00000) @ 0x0fefee1a
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0fefee8e
ACPI: SSDT (v001 SEC    ST10     01540.00000) @ 0x0fefeeb6
ACPI: DSDT (v001   SEC   SENS    01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux-2.5 root=302 hdc=scsi
ide_setup: hdc=scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1694.034 MHz processor.
...
ACPI: Subsystem revision 20021115
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
Parsing Methods:......................................................................................................................................................................
Table [DSDT] - 558 Objects with 54 Devices 166 Methods 19 Regions
Parsing Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c04bfefc
evxfevn
t-0074 [04] Acpi_enable           : Transition to ACPI mode successful
 evevent-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
 evevent-0508: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI methods:......................................................
54 Devices found containing: 54 _STA, 3 _INI methods
Completing Region/Field/Buffer/Package initialization:.......................................................
Initialized 11/19 Regions 0/0 Fields 28/28 Buffers 16/16 Packages (561 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: (supports S0 S3 S4 S5)
evregion-0236 [21] Ev_address_space_dispa: no handler for region(c12f14a8) [Embedded_control]
 exfldio-0217 [20] Ex_access_region      : Region Embedded_control(3) has no handler
 dswexec-0403 [13] Ds_exec_end_op        : [AE_NOT_CONFIGURED]: Could not resolve operands, AE_NOT_EXIST
dswstate-0252 [15] Ds_result_pop_from_bot: No result objects! State=c135f428

 dsutils-0495 [15] Ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
 psparse-1103: *** Error: Method execution failed, AE_AML_NO_RETURN_VALUE
Method pathname:  \_SB_.ADP1._STA (Node c12f96a8)
evregion-0236 [21] Ev_address_space_dispa: no handler for region(c12f14a8) [Embedded_control]
 exfldio-0217 [20] Ex_access_region      : Region Embedded_control(3) has no handler
 dswexec-0403 [13] Ds_exec_end_op        : [AE_NOT_CONFIGURED]: Could not resolve operands, AE_NOT_EXIST
dswstate-0252 [15] Ds_result_pop_from_bot: No result objects! State=c135f428
 dsutils-0495 [15] Ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
 psparse-1103: *** Error: Method execution failed, AE_AML_NO_RETURN_VALUE
Method pathname:  \_SB_.BAT1._STA (Node c12f9aa8)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
 Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
pci_bind-0191 [04] acpi_pci_bind         : Device 00:02:05.00 not present in PCI namespace
pci_bind-0191 [04] acpi_pci_bind         : Device 00:02:09.01 not present in PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
pci_link-0126 [07] acpi_pci_link_get_poss: Blank IRQ resource
last message repeated 2 times
ACPI: Embedded Controller [H_EC] (gpe 28)
ACPI: Power Resource [PFAN] (on)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
