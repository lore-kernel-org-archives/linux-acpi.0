From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: region size computed incorrectly
Date: Mon, 18 Aug 2003 12:49:49 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EEDA@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Albert Cahalan <albert-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I was able to reproduce this. Putting LPCR in the HPET scope instead of
the parent scope (by removing the ^s) seems to be a temporary
workaround. We appear to be creating 2 LPCR objects, 1 of which is
initialized correctly and 1 which is zeroed out. We look at the
not-initialized one, and throw errors.

BTW PNP0103 is the HPET, High Precision Event Timer. I don't know how
people are supposed to request PNP IDs these days, but the HPET spec
says 0103, so I guess they got it. :)

Regards -- Andy

> -----Original Message-----
> From: Albert Cahalan [mailto:albert-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]=20
> Sent: Saturday, August 16, 2003 8:57 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] region size computed incorrectly
>=20
>=20
> Consider the following chunk of code, produced by
> the Intel disassembler:
>=20
>                 Device (HPET)
>                 {
>                     Name (_HID, EisaId ("PNP0103"))
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IRQNoFlags () {0}
>                         IRQNoFlags () {8}
>                         Memory32Fixed (ReadOnly, 0xFEC01000,=20
> 0x00000400)
>                     })
>                     OperationRegion (^LPCR, PCI_Config, 0xA0, 0x04)
>                     Field (^LPCR, AnyAcc, NoLock, Preserve)
>                     {
>                         HPTE,   32
>                     }
>=20
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         And (HPTE, 0x01, Local0)
>                         If (Local0)
>                         {
>                             Return (0x0F)
>                         }
>=20
>                         Return (0x00)
>                     }
>                 }
>=20
>=20
> There we have a 4-byte OperationRegion with a 32-bit
> field called HPTE. That fits. Then, in _STA, HPTE is
> read, and linux-2.6.0-test3 spits out errors:
>=20
>=20
> ACPI: Subsystem revision 20030714
>  tbxface-0117 [03] acpi_load_tables      : ACPI Tables=20
> successfully acquired
> Parsing all Control=20
> Methods:......................................................
> ..............................................................
> .....................
> Table [DSDT](id F004) - 446 Objects with 42 Devices 137=20
> Methods 13 Regions
> ACPI Namespace successfully loaded at root ffffffff80590780
> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI=20
> mode successful
> evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15=20
> [_GPE] 2 regs at 0000000000005020 on int 9
> evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 47=20
> [_GPE] 4 regs at 00000000000050B0 on int 9
> Completing Region/Field/Buffer/Package=20
> initialization:...............................................
> .............................................
> Initialized 12/14 Regions 26/26 Fields 38/38 Buffers 16/16=20
> Packages (455 nodes)
> Executing all Device _STA and_INI=20
> methods:...................... exfldio-0129 [23]=20
> ex_setup_region       : Field [HPTE] access width (1 bytes)=20
> too large for region [LPCR] (length 0)
>  exfldio-0140 [23] ex_setup_region       : Field [HPTE]=20
> Base+Offset+Width 0+0+1 is beyond end of region [LPCR] (length 0)
>  dswexec-0422 [15] ds_exec_end_op        : [And]: Could not=20
> resolve operands, AE_AML_REGION_LIMIT
>  psparse-1121: *** Error: Method execution failed=20
> [\_SB_.PCI0.SBRG.HPET._STA] (Node 00000100081d36f0),=20
> AE_AML_REGION_LIMIT
>   uteval-0098: *** Error: Method execution failed=20
> [\_SB_.PCI0.SBRG.HPET._STA] (Node 00000100081d36f0),=20
> AE_AML_REGION_LIMIT
> .....................
> 43 Devices found containing: 42 _STA, 0 _INI methods
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
>  exfldio-0129 [21] ex_setup_region       : Field [HPTE]=20
> access width (1 bytes) too large for region [LPCR] (length 0)
>  exfldio-0140 [21] ex_setup_region       : Field [HPTE]=20
> Base+Offset+Width 0+0+1 is beyond end of region [LPCR] (length 0)
>  dswexec-0422 [13] ds_exec_end_op        : [And]: Could not=20
> resolve operands, AE_AML_REGION_LIMIT
>  psparse-1121: *** Error: Method execution failed=20
> [\_SB_.PCI0.SBRG.HPET._STA] (Node 00000100081d36f0),=20
> AE_AML_REGION_LIMIT
>=20
>=20
> Somehow, the LPCR region is being seen as length 0.
> This is not correct; it is 4 bytes wide. Until the
> boundry checking is fixed, it should be disabled.
> Even then, a minor overflow should just printk() a
> warning and keep on going.
>=20
> BTW, what is a PNP0103 device?
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet
> _072303_01/01
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
