From: Albert Cahalan <albert-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: region size computed incorrectly
Date: 16 Aug 2003 11:56:50 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1061049410.780.442.camel@cube>
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

Consider the following chunk of code, produced by
the Intel disassembler:

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {0}
                        IRQNoFlags () {8}
                        Memory32Fixed (ReadOnly, 0xFEC01000, 0x00000400)
                    })
                    OperationRegion (^LPCR, PCI_Config, 0xA0, 0x04)
                    Field (^LPCR, AnyAcc, NoLock, Preserve)
                    {
                        HPTE,   32
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        And (HPTE, 0x01, Local0)
                        If (Local0)
                        {
                            Return (0x0F)
                        }

                        Return (0x00)
                    }
                }


There we have a 4-byte OperationRegion with a 32-bit
field called HPTE. That fits. Then, in _STA, HPTE is
read, and linux-2.6.0-test3 spits out errors:


ACPI: Subsystem revision 20030714
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.........................................................................................................................................
Table [DSDT](id F004) - 446 Objects with 42 Devices 137 Methods 13 Regions
ACPI Namespace successfully loaded at root ffffffff80590780
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000005020 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 47 [_GPE] 4 regs at 00000000000050B0 on int 9
Completing Region/Field/Buffer/Package initialization:............................................................................................
Initialized 12/14 Regions 26/26 Fields 38/38 Buffers 16/16 Packages (455 nodes)
Executing all Device _STA and_INI methods:...................... exfldio-0129 [23] ex_setup_region       : Field [HPTE] access width (1 bytes) too large for region [LPCR] (length 0)
 exfldio-0140 [23] ex_setup_region       : Field [HPTE] Base+Offset+Width 0+0+1 is beyond end of region [LPCR] (length 0)
 dswexec-0422 [15] ds_exec_end_op        : [And]: Could not resolve operands, AE_AML_REGION_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.SBRG.HPET._STA] (Node 00000100081d36f0), AE_AML_REGION_LIMIT
  uteval-0098: *** Error: Method execution failed [\_SB_.PCI0.SBRG.HPET._STA] (Node 00000100081d36f0), AE_AML_REGION_LIMIT
.....................
43 Devices found containing: 42 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
 exfldio-0129 [21] ex_setup_region       : Field [HPTE] access width (1 bytes) too large for region [LPCR] (length 0)
 exfldio-0140 [21] ex_setup_region       : Field [HPTE] Base+Offset+Width 0+0+1 is beyond end of region [LPCR] (length 0)
 dswexec-0422 [13] ds_exec_end_op        : [And]: Could not resolve operands, AE_AML_REGION_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.SBRG.HPET._STA] (Node 00000100081d36f0), AE_AML_REGION_LIMIT


Somehow, the LPCR region is being seen as length 0.
This is not correct; it is 4 bytes wide. Until the
boundry checking is fixed, it should be disabled.
Even then, a minor overflow should just printk() a
warning and keep on going.

BTW, what is a PNP0103 device?




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
