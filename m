From: Ronald Hitz <Ronald.Hitz-1NtEGJHV5g0@public.gmane.org>
Subject: Re: 2.6.8 using 2.6.7 dsdt in initrd patch won't load dsdt
Date: Wed, 15 Sep 2004 07:58:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1C7Snq-00023D-00@mail1.isc.de>
References: <200408310955.28391.destynova@esatclear.ie>
Reply-To: Ronald.Hitz-1NtEGJHV5g0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200408310955.28391.destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oisin,

since I've compiled my DSDT yesterday and load successfully,
I tell You, that with 2.6.8.1 there is an option in the kernel to load
an custom dsdt, where have to tell exactly( full path), where the dsdt
is and it was loaded successfully.

Maybe that helps You.


Regards

Ronald Hitz

On Tue, Aug 31, 2004 at 09:55:28AM +0100, Ois=EDn Mac Fheara=ED wrote:
> Hi all, sorry to bring more mundanity to the list, but this has been real=
ly=20
> annoying me for the last day or two.
>=20
> I (probably) fixed my DSDT, compiled it successfully, and have tried nume=
rous=20
> ways of loading it at boot through an initrd patch (I couldn't find a 2.6=
=2E8=20
> patch, but the 2.6.7 patch I found seemed to apply well enough, without m=
uch=20
> fuzzing...).
> The machine appears to find it, but it doesn't actually load it.
> If anyone knows why not, or if I did something obviously wrong, please le=
t me=20
> know.
>=20
> thanks,
> Ois=EDn
>=20
> here's the relevant output in dmesg - I believe if it had loaded the tabl=
es=20
> from the custom DSDT, it would have said so just after the "ACPI: Subsyst=
em=20
> revision nnnn" line (and I can tell that it hasn't, as it refers to an er=
ror=20
> in the DSDT I had fixed, by changing both references to Z00D to Z00C):
>=20
> ACPI: Looking for DSDT in initrd ... found (at offset 26218)!
>  found customized DSDT with 16040 bytes!
> Freeing initrd memory: 41k freed
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfd9c6, last bus=3D1
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040816
> evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs at=
=20
> 0000000000008020 on int 0x9
> evgpeblk-0989 [07] ev_create_gpe_block   : Found 5 Wake, Enabled 0 Runtim=
e=20
> GPEs in this block
> evgpeblk-0980 [07] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs at=
=20
> 0000000000008030 on int 0x9
> evgpeblk-0989 [07] ev_create_gpe_block   : Found 1 Wake, Enabled 1 Runtim=
e=20
> GPEs in this block
> Completing Region/Field/Buffer/Package=20
> initialization:.................................................. =20
> psargs-0352: *** Error: Looking up [Z00D] in namespace, AE_NOT_FOUND
> search_node dfda3228 start_node dfda3228 return_node 00000000
>  psparse-1133: *** Error: [NULL NAME], AE_NOT_FOUND
>=20
>   nsinit-0301 [07] ns_init_one_object    : Could not execute arguments fo=
r=20
> [PBST] (Package), AE_NOT_FOUND
> .........
> Initialized 11/11 Regions 5/5 Fields 20/20 Buffers 23/29 Packages (514 no=
des)
> Executing all Device _STA and_INI=20
> methods:......................................................
> 54 Devices found containing: 54 _STA, 2 _INI methods
> ACPI: Interpreter enabled

> /*
>  * Intel ACPI Component Architecture
>  * AML Disassembler version 20030918
>  *
>  * Disassembly of dsdt, Mon Aug 30 08:05:46 2004
>  */
> DefinitionBlock ("DSDT.aml", "DSDT", 1, "PTLTD ", "650M", 100925440)
> {
>     OperationRegion (P80G, SystemIO, 0x80, 0x01)
>     Field (P80G, ByteAcc, NoLock, Preserve)
>     {
>         DBPG,   8
>     }
>=20
>     OperationRegion (FANC, SystemIO, 0x0500, 0xFF)
>     Field (FANC, ByteAcc, NoLock, Preserve)
>     {
>         Offset (0x56),=20
>         FANR,   8,=20
>         Offset (0x58),=20
>         F1CR,   8
>     }
>=20
>     Scope (\_PR)
>     {
>         Processor (CPU0, 0x00, 0x00008010, 0x06) {}
>     }
>=20
>     Name (_S0, Package (0x02)
>     {
>         0x00,=20
>         0x00
>     })
>     Name (_S3, Package (0x02)
>     {
>         0x03,=20
>         0x03
>     })
>     Name (_S4, Package (0x02)
>     {
>         0x04,=20
>         0x04
>     })
>     Name (_S5, Package (0x02)
>     {
>         0x05,=20
>         0x05
>     })
>     Name (PICF, 0x00)
>     Method (_PIC, 1, NotSerialized)
>     {
>         Store (Arg0, PICF)
>     }
>=20
>     Scope (\_SB)
>     {
>         Name (OSTB, Ones)
>         Name (FWSO, "FWSO")
>         Name (ECEN, 0x00)
>         Name (ACST, 0x01)
>         Device (PCI0)
>         {
>             Method (_PRT, 0, NotSerialized)
>             {
>                 If (LNot (\PICF))
>                 {
>                     Return (PICM)
>                 }
>                 Else
>                 {
>                     Return (APIC)
>                 }
>             }
>=20
>             Name (PICM, Package (0x0A)
>             {
>                 Package (0x04)
>                 {
>                     0x0002FFFF,=20
>                     0x01,=20
>                     \_SB.PCI0.LPCB.LNKB,=20
>                     0x00
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0002FFFF,=20
>                     0x02,=20
>                     \_SB.PCI0.LPCB.LNKC,=20
>                     0x00
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0003FFFF,=20
>                     0x00,=20
>                     \_SB.PCI0.LPCB.LNKE,=20
>                     0x00
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0003FFFF,=20
>                     0x01,=20
>                     \_SB.PCI0.LPCB.LNKF,=20
>                     0x00
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0003FFFF,=20
>                     0x02,=20
>                     \_SB.PCI0.LPCB.LNKG,=20
>                     0x00
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0003FFFF,=20
>                     0x03,=20
>                     \_SB.PCI0.LPCB.LNKH,=20
>                     0x00
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0004FFFF,=20
>                     0x00,=20
>                     \_SB.PCI0.LPCB.LNKD,=20
>                     0x00
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x000AFFFF,=20
>                     0x00,=20
>                     \_SB.PCI0.LPCB.LNKB,=20
>                     0x00
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x000BFFFF,=20
>                     0x00,=20
>                     \_SB.PCI0.LPCB.LNKC,=20
>                     0x00
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x000BFFFF,=20
>                     0x01,=20
>                     \_SB.PCI0.LPCB.LNKD,=20
>                     0x00
>                 }
>             })
>             Name (APIC, Package (0x0A)
>             {
>                 Package (0x04)
>                 {
>                     0x0002FFFF,=20
>                     0x01,=20
>                     0x00,=20
>                     0x11
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0002FFFF,=20
>                     0x02,=20
>                     0x00,=20
>                     0x12
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0003FFFF,=20
>                     0x00,=20
>                     0x00,=20
>                     0x14
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0003FFFF,=20
>                     0x01,=20
>                     0x00,=20
>                     0x15
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0003FFFF,=20
>                     0x02,=20
>                     0x00,=20
>                     0x16
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0003FFFF,=20
>                     0x03,=20
>                     0x00,=20
>                     0x17
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x0004FFFF,=20
>                     0x00,=20
>                     0x00,=20
>                     0x13
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x000AFFFF,=20
>                     0x00,=20
>                     0x00,=20
>                     0x11
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x000BFFFF,=20
>                     0x00,=20
>                     0x00,=20
>                     0x12
>                 },=20
>=20
>                 Package (0x04)
>                 {
>                     0x000BFFFF,=20
>                     0x01,=20
>                     0x00,=20
>                     0x13
>                 }
>             })
>             Name (_HID, EisaId ("PNP0A03"))
>             Name (_ADR, 0x00)
>             Name (_BBN, 0x00)
>             Name (_UID, 0x00)
>             Method (_STA, 0, NotSerialized)
>             {
>                 Return (0x0F)
>             }
>=20
>             Method (_INI, 0, NotSerialized)
>             {
>             }
>=20
>             OperationRegion (MA, PCI_Config, 0x00, 0xFF)
>             Field (MA, ByteAcc, NoLock, Preserve)
>             {
>                 Offset (0x70),=20
>                 SHC0,   1,=20
>                 SHC4,   1,=20
>                 SHC8,   1,=20
>                 SHCC,   1,=20
>                 SHD0,   1,=20
>                 SHD4,   1,=20
>                 SHD8,   1,=20
>                 SHDC,   1,=20
>                 SHE0,   1,=20
>                 SHE4,   1,=20
>                 SHE8,   1,=20
>                 SHEC,   1,=20
>                 Offset (0xAE),=20
>                 MAL,    8,=20
>                 MAH,    8
>             }
>=20
>             Name (CRES, ResourceTemplate ()
>             {
>                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosD=
ecode,
>                     0x0000,
>                     0x0000,
>                     0x00FF,
>                     0x0000,
>                     0x0100, 0x00)
>                 IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
>                 WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, =
EntireRange,
>                     0x0000,
>                     0x0000,
>                     0x0CF7,
>                     0x0000,
>                     0x0CF8, 0x00)
>                 WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, =
EntireRange,
>                     0x0000,
>                     0x0D00,
>                     0xFFFF,
>                     0x0000,
>                     0xF300, 0x00)
>                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFi=
xed, Cacheable, ReadWrite,
>                     0x00000000,
>                     0x000A0000,
>                     0x000BFFFF,
>                     0x00000000,
>                     0x00020000, 0x00)
>                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFi=
xed, Cacheable, ReadWrite,
>                     0x00000000,
>                     0x04000000,
>                     0xFFEDFFFF,
>                     0x00000000,
>                     0x00000000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000C0000,
>                     0x000C3FFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000C4000,
>                     0x000C7FFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000C8000,
>                     0x000CBFFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000CC000,
>                     0x000CFFFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000D0000,
>                     0x000D3FFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000D4000,
>                     0x000D7FFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000D8000,
>                     0x000DBFFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000DC000,
>                     0x000DFFFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000E0000,
>                     0x000E3FFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000E4000,
>                     0x000E7FFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000E8000,
>                     0x000EBFFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>                 DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFi=
xed, NonCacheable, ReadWrite,
>                     0x00000000,
>                     0x000EC000,
>                     0x000EFFFF,
>                     0x00000000,
>                     0x00004000, 0x00)
>             })
>             Method (_CRS, 0, NotSerialized)
>             {
>                 CreateBitField (CRES, 0x03B0, C0RW)
>                 CreateDWordField (CRES, 0x87, C0LN)
>                 Store (One, C0RW)
>                 Store (0x4000, C0LN)
>                 If (SHC0)
>                 {
>                     Store (0x00, C0LN)
>                 }
>=20
>                 CreateBitField (CRES, 0x0488, C4RW)
>                 CreateDWordField (CRES, 0xA2, C4LN)
>                 Store (One, C4RW)
>                 Store (0x4000, C4LN)
>                 If (SHC4)
>                 {
>                     Store (0x00, C4LN)
>                 }
>=20
>                 CreateBitField (CRES, 0x0560, C8RW)
>                 CreateDWordField (CRES, 0xBD, C8LN)
>                 Store (One, C8RW)
>                 Store (0x4000, C8LN)
>                 If (SHC8)
>                 {
>                     Store (0x00, C8LN)
>                 }
>=20
>                 CreateBitField (CRES, 0x0638, CCRW)
>                 CreateDWordField (CRES, 0xD8, CCLN)
>                 Store (One, CCRW)
>                 Store (0x4000, CCLN)
>                 If (SHCC)
>                 {
>                     Store (0x00, CCLN)
>                 }
>=20
>                 CreateBitField (CRES, 0x0710, D0RW)
>                 CreateDWordField (CRES, 0xF3, D0LN)
>                 Store (One, D0RW)
>                 Store (0x4000, D0LN)
>                 If (SHD0)
>                 {
>                     Store (0x00, D0LN)
>                 }
>=20
>                 CreateBitField (CRES, 0x07E8, D4RW)
>                 CreateDWordField (CRES, 0x010E, D4LN)
>                 Store (One, D4RW)
>                 Store (0x4000, D4LN)
>                 If (SHD4)
>                 {
>                     Store (0x00, D4LN)
>                 }
>=20
>                 CreateBitField (CRES, 0x08C0, D8RW)
>                 CreateDWordField (CRES, 0x0129, D8LN)
>                 Store (One, D8RW)
>                 Store (0x4000, D8LN)
>                 If (SHD8)
>                 {
>                     Store (0x00, D8LN)
>                 }
>=20
>                 CreateBitField (CRES, 0x0998, DCRW)
>                 CreateDWordField (CRES, 0x0144, DCLN)
>                 Store (One, DCRW)
>                 Store (0x4000, DCLN)
>                 If (SHDC)
>                 {
>                     Store (0x00, DCLN)
>                 }
>=20
>                 CreateBitField (CRES, 0x0A70, E0RW)
>                 CreateDWordField (CRES, 0x015F, E0LN)
>                 Store (One, E0RW)
>                 Store (0x4000, E0LN)
>                 If (SHE0)
>                 {
>                     Store (0x00, E0LN)
>                 }
>=20
>                 CreateBitField (CRES, 0x0B48, E4RW)
>                 CreateDWordField (CRES, 0x017A, E4LN)
>                 Store (One, E4RW)
>                 Store (0x4000, E4LN)
>                 If (SHE4)
>                 {
>                     Store (0x00, E4LN)
>                 }
>=20
>                 CreateBitField (CRES, 0x0C20, E8RW)
>                 CreateDWordField (CRES, 0x0195, E8LN)
>                 Store (One, E8RW)
>                 Store (0x4000, E8LN)
>                 If (SHE8)
>                 {
>                     Store (0x00, E8LN)
>                 }
>=20
>                 CreateBitField (CRES, 0x0CF8, ECRW)
>                 CreateDWordField (CRES, 0x01B0, ECLN)
>                 Store (One, ECRW)
>                 Store (0x4000, ECLN)
>                 If (SHEC)
>                 {
>                     Store (0x00, ECLN)
>                 }
>=20
>                 CreateDWordField (CRES, 0x60, RAMT)
>                 CreateDWordField (CRES, 0x6C, RAMR)
>                 ShiftLeft (\_SB.PCI0.MAH, 0x1C, Local0)
>                 ShiftLeft (\_SB.PCI0.MAL, 0x14, Local1)
>                 Add (Local1, Local0, Local2)
>                 Store (Local2, RAMT)
>                 Subtract (0xFFEE0000, RAMT, RAMR)
>                 Return (CRES)
>             }
>=20
>             Device (AGPB)
>             {
>                 Name (_ADR, 0x00010000)
>                 Method (_PRT, 0, NotSerialized)
>                 {
>                     If (LNot (\PICF))
>                     {
>                         Return (AGPP)
>                     }
>                     Else
>                     {
>                         Return (AGPA)
>                     }
>                 }
>=20
>                 Name (AGPP, Package (0x02)
>                 {
>                     Package (0x04)
>                     {
>                         0xFFFF,=20
>                         0x00,=20
>                         \_SB.PCI0.LPCB.LNKA,=20
>                         0x00
>                     },=20
>=20
>                     Package (0x04)
>                     {
>                         0xFFFF,=20
>                         0x01,=20
>                         \_SB.PCI0.LPCB.LNKC,=20
>                         0x00
>                     }
>                 })
>                 Name (AGPA, Package (0x02)
>                 {
>                     Package (0x04)
>                     {
>                         0xFFFF,=20
>                         0x00,=20
>                         0x00,=20
>                         0x10
>                     },=20
>=20
>                     Package (0x04)
>                     {
>                         0xFFFF,=20
>                         0x01,=20
>                         0x00,=20
>                         0x12
>                     }
>                 })
>                 Device (VGA)
>                 {
>                     Name (_ADR, 0x00)
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         If (\_SB.PCI0.LPCB.Z000)
>                         {
>                             Return (0x00)
>                         }
>                         Else
>                         {
>                             Return (0x0F)
>                         }
>                     }
>=20
>                     Name (_PSC, 0x00)
>                     Method (_PS0, 0, NotSerialized)
>                     {
>                         Store (0x00, _PSC)
>                     }
>=20
>                     Method (_PS1, 0, NotSerialized)
>                     {
>                         Store (0x01, _PSC)
>                     }
>=20
>                     Method (_PS2, 0, NotSerialized)
>                     {
>                         Store (0x02, _PSC)
>                     }
>=20
>                     Method (_PS3, 0, NotSerialized)
>                     {
>                         Store (0x03, _PSC)
>                     }
>=20
>                     Name (DISW, 0x01)
>                     Name (NDSP, 0x00)
>                     Name (VRSM, 0x00)
>                     Name (PDSP, 0x00)
>                     Name (CDSP, 0x00)
>                     Name (TGLT, Package (0x04)
>                     {
>                         Package (0x08)
>                         {
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01
>                         },=20
>=20
>                         Package (0x08)
>                         {
>                             0x01,=20
>                             0x02,=20
>                             0x03,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01
>                         },=20
>=20
>                         Package (0x08)
>                         {
>                             0x01,=20
>                             0x05,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01
>                         },=20
>=20
>                         Package (0x08)
>                         {
>                             0x01,=20
>                             0x02,=20
>                             0x03,=20
>                             0x05,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01,=20
>                             0x01
>                         }
>                     })
>                     Name (TGLP, 0x00)
>                     Device (LCD)
>                     {
>                         Name (_ADR, 0x0110)
>                         Name (_PSC, 0x00)
>                         Name (_S3D, 0x03)
>                         Method (_PS0, 0, NotSerialized)
>                         {
>                             Store (0x00, _PSC)
>                         }
>=20
>                         Method (_PS1, 0, NotSerialized)
>                         {
>                             Store (0x01, _PSC)
>                         }
>=20
>                         Method (_PS3, 0, NotSerialized)
>                         {
>                             Store (0x03, _PSC)
>                         }
>=20
>                         Name (_DCS, 0x1B)
>                         Name (_DGS, 0x00)
>                         Method (_DSS, 1, NotSerialized)
>                         {
>                             Store (Arg0, Local0)
>                             If (And (Local0, 0x01))
>                             {
>                                 Store ("LCD._DSS(1) called", Debug)
>                                 Or (NDSP, 0x01, NDSP)
>                             }
>                             Else
>                             {
>                                 Store ("LCD._DSS(0) called", Debug)
>                                 And (NDSP, 0xFE, NDSP)
>                             }
>=20
>                             And (Local0, 0xC0000000, Local0)
>                             And (Local0, 0x80000000, Local0)
>                             If (LNot (LEqual (Local0, 0x00)))
>                             {
>                                 Store ("LCD._DSS, update next _DGS", Debu=
g)
>                                 Or (And (^^LCD._DCS, 0xFD), ShiftLeft (An=
d (NDSP, 0x01), 0x01), ^^LCD._DCS)
>                                 Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x=
02), ^^CRT._DCS)
>                                 Or (And (^^TV._DCS, 0xFD), ShiftRight (An=
d (NDSP, 0x04), 0x01), ^^TV._DCS)
>                                 UDGS ()
>                             }
>                         }
>                     }
>=20
>                     Device (CRT)
>                     {
>                         Name (_ADR, 0x0100)
>                         Name (_PSC, 0x00)
>                         Method (_PS0, 0, NotSerialized)
>                         {
>                             Store (0x00, _PSC)
>                         }
>=20
>                         Method (_PS1, 0, NotSerialized)
>                         {
>                             Store (0x01, _PSC)
>                         }
>=20
>                         Method (_PS3, 0, NotSerialized)
>                         {
>                             Store (0x03, _PSC)
>                         }
>=20
>                         Name (_DCS, 0x1B)
>                         Name (_DGS, 0x00)
>                         Method (_DSS, 1, NotSerialized)
>                         {
>                             Store (Arg0, Local0)
>                             If (And (Local0, 0x01))
>                             {
>                                 Store ("CRT._DSS(1) called", Debug)
>                                 Or (NDSP, 0x02, NDSP)
>                             }
>                             Else
>                             {
>                                 Store ("CRT._DSS(0) called", Debug)
>                                 And (NDSP, 0xFD, NDSP)
>                             }
>=20
>                             And (Local0, 0xC0000000, Local0)
>                             And (Local0, 0x80000000, Local0)
>                             If (LNot (LEqual (Local0, 0x00)))
>                             {
>                                 Store ("CRT._DSS, update next _DGS", Debu=
g)
>                                 Or (And (^^LCD._DCS, 0xFD), ShiftLeft (An=
d (NDSP, 0x01), 0x01), ^^LCD._DCS)
>                                 Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x=
02), ^^CRT._DCS)
>                                 Or (And (^^TV._DCS, 0xFD), ShiftRight (An=
d (NDSP, 0x04), 0x01), ^^TV._DCS)
>                                 UDGS ()
>                             }
>                         }
>                     }
>=20
>                     Device (TV)
>                     {
>                         Name (_ADR, 0x0200)
>                         Name (_PSC, 0x00)
>                         Method (_PS0, 0, NotSerialized)
>                         {
>                             Store (0x00, _PSC)
>                         }
>=20
>                         Method (_PS1, 0, NotSerialized)
>                         {
>                             Store (0x01, _PSC)
>                         }
>=20
>                         Method (_PS3, 0, NotSerialized)
>                         {
>                             Store (0x03, _PSC)
>                         }
>=20
>                         Name (_DCS, 0x1B)
>                         Name (_DGS, 0x00)
>                         Method (_DSS, 1, NotSerialized)
>                         {
>                             Store (Arg0, Local0)
>                             If (And (Local0, 0x01))
>                             {
>                                 Store ("TV_._DSS(1) called", Debug)
>                                 Or (NDSP, 0x04, NDSP)
>                             }
>                             Else
>                             {
>                                 Store ("TV_._DSS(0) called", Debug)
>                                 And (NDSP, 0xFB, NDSP)
>                             }
>=20
>                             And (Local0, 0xC0000000, Local0)
>                             And (Local0, 0x80000000, Local0)
>                             If (LNot (LEqual (Local0, 0x00)))
>                             {
>                                 Store ("TV_._DSS, update next _DGS", Debu=
g)
>                                 Or (And (^^LCD._DCS, 0xFD), ShiftLeft (An=
d (NDSP, 0x01), 0x01), ^^LCD._DCS)
>                                 Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x=
02), ^^CRT._DCS)
>                                 Or (And (^^TV._DCS, 0xFD), ShiftRight (An=
d (NDSP, 0x04), 0x01), ^^TV._DCS)
>                                 UDGS ()
>                             }
>                         }
>                     }
>=20
>                     Method (_INI, 0, NotSerialized)
>                     {
>                         USTA ()
>                         Store (CDSP, PDSP)
>                         Store (CDSP, Local1)
>                         Or (ShiftRight (And (Local1, 0x10), 0x03), 0x1D, =
^LCD._DCS)
>                         Or (Or (ShiftLeft (And (Local1, 0x02), 0x03), Shi=
ftRight (And (Local1, 0x20), 0x04)), 0x0D, ^CRT._DCS)
>                         Or (Or (ShiftLeft (And (Local1, 0x04), 0x02), Shi=
ftRight (And (Local1, 0x40), 0x05)), 0x0D, ^TV._DCS)
>                         ShiftRight (Local1, 0x04, NDSP)
>                         Store (ShiftRight (And (^LCD._DCS, 0x02), 0x01), =
^LCD._DGS)
>                         Store (ShiftRight (And (^CRT._DCS, 0x02), 0x01), =
^CRT._DGS)
>                         Store (ShiftRight (And (^TV._DCS, 0x02), 0x01), ^=
TV._DGS)
>                     }
>=20
>                     Method (_DOS, 1, NotSerialized)
>                     {
>                         Store (Arg0, DISW)
>                     }
>=20
>                     Method (_DOD, 0, NotSerialized)
>                     {
>                         Return (Package (0x03)
>                         {
>                             0x00010100,=20
>                             0x00010110,=20
>                             0x00010200
>                         })
>                     }
>=20
>                     Method (DRUL, 1, NotSerialized)
>                     {
>                         USTA ()
>                         If (LNot (LEqual (And (PDSP, 0x07), And (CDSP, 0x=
07))))
>                         {
>                             UDGS ()
>                             Store (CDSP, PDSP)
>                         }
>=20
>                         Store (CDSP, Local2)
>                         Store (^CRT._DCS, Local1)
>                         Or (Or (ShiftLeft (And (Local2, 0x02), 0x03), Shi=
ftRight (And (Local2, 0x20), 0x04)), And (Local1, 0x0D), ^CRT._DCS)
>                         Store (^TV._DCS, Local3)
>                         Or (Or (ShiftLeft (And (Local2, 0x04), 0x02), Shi=
ftRight (And (Local2, 0x40), 0x05)), And (Local3, 0x0D), ^TV._DCS)
>                         If (LEqual (Arg0, 0x01))
>                         {
>                             If (LOr (LAnd (^CRT._DGS, LNot (And (^CRT._DC=
S, 0x10))), LAnd (^TV._DGS, LNot (And (^TV._DCS, 0x10)))))
>                             {
>                                 UDGS ()
>                                 Return (0x00)
>                             }
>                             Else
>                             {
>                                 Notify (VGA, 0x80)
>                                 Return (0x00)
>                             }
>                         }
> 		    	Return (0x00)
>                     }
>=20
>                     Method (USTA, 0, NotSerialized)
>                     {
>                         If (LEqual (\_SB.PCI0.LPCB.Z000, 0x00))
>                         {
>                             Store (\_SB.PCI0.LPCB.PHSR (0x00, 0x00), CDSP)
>                         }
>                         Else
>                         {
>                             Store (0x11, CDSP)
>                         }
>=20
>                         And (CDSP, 0x0F, Local1)
>                         If (LEqual (Local1, 0x03))
>                         {
>                             Store (0x01, TGLP)
>                         }
>                         Else
>                         {
>                             If (LEqual (Local1, 0x05))
>                             {
>                                 Store (0x02, TGLP)
>                             }
>                             Else
>                             {
>                                 If (LEqual (Local1, 0x07))
>                                 {
>                                     Store (0x03, TGLP)
>                                 }
>                                 Else
>                                 {
>                                     Store (0x00, TGLP)
>                                 }
>                             }
>                         }
>                     }
>=20
>                     Method (UDGS, 0, NotSerialized)
>                     {
>                         And (^LCD._DGS, 0x01, Local0)
>                         Or (Local0, ShiftLeft (And (^CRT._DGS, 0x01), 0x0=
1), Local0)
>                         Or (Local0, ShiftLeft (And (^TV._DGS, 0x01), 0x02=
), Local0)
>                         Store (DerefOf (Index (DerefOf (Index (TGLT, TGLP=
)), Local0)), Local1)
>                         And (Local1, 0x01, ^LCD._DGS)
>                         ShiftRight (And (Local1, 0x02), 0x01, ^CRT._DGS)
>                         ShiftRight (And (Local1, 0x04), 0x02, ^TV._DGS)
>                     }
>                 }
>             }
>=20
>             Device (LPCB)
>             {
>                 Name (_ADR, 0x00020000)
>                 OperationRegion (PCFG, PCI_Config, 0x00, 0x80)
>                 Field (PCFG, ByteAcc, NoLock, Preserve)
>                 {
>                     Offset (0x41),=20
>                     PIRA,   8,=20
>                     PIRB,   8,=20
>                     PIRC,   8,=20
>                     PIRD,   8,=20
>                     Offset (0x60),=20
>                     PIRE,   8,=20
>                     PIRF,   8,=20
>                     PIRG,   8,=20
>                     PIRH,   8,=20
>                     Offset (0x74),=20
>                     Z001,   16
>                 }
>=20
>                 OperationRegion (SOW, SystemIO, 0x8000, 0x90)
>                 Field (SOW, WordAcc, NoLock, Preserve)
>                 {
>                     Offset (0x10),=20
>                         ,   1,=20
>                     TDCC,   3,=20
>                     TFEN,   1,=20
>                     Offset (0x1A),=20
>                         ,   1,=20
>                     RLSL,   1,=20
>                     Offset (0x20),=20
>                         ,   2,=20
>                     SLP,    1,=20
>                     WK,     1,=20
>                     Offset (0x2B),=20
>                         ,   5,=20
>                     SSL,    1,=20
>                     SWK,    1,=20
>                     Z002,   1,=20
>                     Offset (0x3E),=20
>                         ,   7,=20
>                     LIDP,   1,=20
>                     Offset (0x49),=20
>                     LGMS,   1,=20
>                     Offset (0x62),=20
>                         ,   6,=20
>                     ALED,   2,=20
>                     Offset (0x64),=20
>                         ,   7,=20
>                     LIDS,   1,=20
>                         ,   3,=20
>                     BLIT,   1
>                 }
>=20
>                 OperationRegion (SMB, SystemIO, 0x8100, 0x20)
>                 Field (SMB, AnyAcc, NoLock, Preserve)
>                 {
>                     BSTS,   8,=20
>                     BEN,    8,=20
>                     BCNT,   8,=20
>                     HCNT,   8,=20
>                     BADR,   8,=20
>                     BCOD,   8,=20
>                     BCOU,   8,=20
>                     SBY0,   8,=20
>                     SBY1,   8,=20
>                     SBY2,   8,=20
>                     SBY3,   8,=20
>                     SBY4,   8,=20
>                     SBY5,   8,=20
>                     SBY6,   8,=20
>                     SBY7,   8,=20
>                     DADR,   8,=20
>                     SBD0,   8,=20
>                     SBD1,   8,=20
>                     BSAA,   8
>                 }
>=20
>                 Method (THRL, 1, NotSerialized)
>                 {
>                     If (LEqual (Arg0, 0x00))
>                     {
>                         \_SB.PCI0.LPCB.PHSR (0x07, 0x00)
>                     }
>                     Else
>                     {
>                         \_SB.PCI0.LPCB.PHSR (0x07, 0x01)
>                     }
>                 }
>=20
>                 OperationRegion (SMI0, SystemIO, 0x0000FE00, 0x00000002)
>                 Field (SMI0, AnyAcc, NoLock, Preserve)
>                 {
>                     SMIC,   8
>                 }
>=20
>                 OperationRegion (SMI1, SystemMemory, 0x1FDFBE2D, 0x000001=
20)
>                 Field (SMI1, AnyAcc, NoLock, Preserve)
>                 {
>                     BCMD,   8,=20
>                     DID,    32,=20
>                     INFO,   2008
>                 }
>=20
>                 Field (SMI1, AnyAcc, NoLock, Preserve)
>                 {
>                     DMY,    40,=20
>                     INF,    8
>                 }
>=20
>                 Field (SMI1, AnyAcc, NoLock, Preserve)
>                 {
>                     Offset (0x110),=20
>                     Z000,   1,=20
>                     Z003,   1,=20
>                     Z004,   1,=20
>                     Z005,   1,=20
>                     Z006,   1,=20
>                     Z007,   1,=20
>                     Offset (0x111),=20
>                     Z008,   8
>                 }
>=20
>                 Mutex (PSMX, 0x00)
>                 Method (PHSR, 2, NotSerialized)
>                 {
>                     Acquire (\_SB.PCI0.LPCB.PSMX, 0xFFFF)
>                     Store (0x90, BCMD)
>                     Store (Arg0, DID)
>                     Store (Arg1, INFO)
>                     Store (Zero, SMIC)
>                     Store (INF, Local0)
>                     Release (\_SB.PCI0.LPCB.PSMX)
>                     Return (Local0)
>                 }
>=20
>                 Name (Z009, ResourceTemplate ()
>                 {
>                     IRQ (Level, ActiveLow, Shared) {5}
>                 })
>                 Name (Z00A, ResourceTemplate ()
>                 {
>                     IRQ (Level, ActiveLow, Shared) {3}
>                 })
>                 Name (Z00B, ResourceTemplate ()
>                 {
>                     IRQ (Level, ActiveLow, Shared) {7,10}
>                 })
>                 Device (LNKA)
>                 {
>                     Name (_HID, EisaId ("PNP0C0F"))
>                     Name (_UID, 0x01)
>                     Method (_PRS, 0, NotSerialized)
>                     {
>                         Return (Z00B)
>                     }
>=20
>                     Method (_DIS, 0, NotSerialized)
>                     {
>                         Or (\_SB.PCI0.LPCB.PIRA, 0x80, \_SB.PCI0.LPCB.PIR=
A)
>                     }
>=20
>                     Method (_CRS, 0, NotSerialized)
>                     {
>                         Store (Z00B, Local0)
>                         CreateWordField (Local0, 0x01, IRA0)
>                         If (LEqual (And (\_SB.PCI0.LPCB.PIRA, 0x80), Zero=
))
>                         {
>                             And (\_SB.PCI0.LPCB.PIRA, 0x0F, Local0)
>                             ShiftLeft (0x01, Local0, IRA0)
>                         }
>                         Else
>                         {
>                             Store (0x00, IRA0)
>                         }
>=20
>                         Return (Local0)
>                     }
>=20
>                     Method (_SRS, 1, NotSerialized)
>                     {
>                         CreateWordField (Arg0, 0x01, IRA0)
>                         FindSetRightBit (IRA0, Local0)
>                         Decrement (Local0)
>                         Or (Local0, And (\_SB.PCI0.LPCB.PIRA, 0x70), \_SB=
=2EPCI0.LPCB.PIRA)
>                     }
>=20
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         If (And (\_SB.PCI0.LPCB.PIRA, 0x80))
>                         {
>                             Return (0x09)
>                         }
>=20
>                         Return (0x0B)
>                     }
>                 }
>=20
>                 Device (LNKB)
>                 {
>                     Name (_HID, EisaId ("PNP0C0F"))
>                     Name (_UID, 0x02)
>                     Method (_PRS, 0, NotSerialized)
>                     {
>                         Return (Z00A)
>                     }
>=20
>                     Method (_DIS, 0, NotSerialized)
>                     {
>                         Or (\_SB.PCI0.LPCB.PIRB, 0x80, \_SB.PCI0.LPCB.PIR=
B)
>                     }
>=20
>                     Method (_CRS, 0, NotSerialized)
>                     {
>                         Store (Z00A, Local0)
>                         CreateWordField (Local0, 0x01, IRA0)
>                         If (LEqual (And (\_SB.PCI0.LPCB.PIRB, 0x80), Zero=
))
>                         {
>                             And (\_SB.PCI0.LPCB.PIRB, 0x0F, Local0)
>                             ShiftLeft (0x01, Local0, IRA0)
>                         }
>                         Else
>                         {
>                             Store (0x00, IRA0)
>                         }
>=20
>                         Return (Local0)
>                     }
>=20
>                     Method (_SRS, 1, NotSerialized)
>                     {
>                         CreateWordField (Arg0, 0x01, IRA0)
>                         FindSetRightBit (IRA0, Local0)
>                         Decrement (Local0)
>                         Or (Local0, And (\_SB.PCI0.LPCB.PIRB, 0x70), \_SB=
=2EPCI0.LPCB.PIRB)
>                     }
>=20
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         If (And (\_SB.PCI0.LPCB.PIRB, 0x80))
>                         {
>                             Return (0x09)
>                         }
>=20
>                         Return (0x0B)
>                     }
>                 }
>=20
>                 Device (LNKC)
>                 {
>                     Name (_HID, EisaId ("PNP0C0F"))
>                     Name (_UID, 0x03)
>                     Method (_PRS, 0, NotSerialized)
>                     {
>                         Return (Z009)
>                     }
>=20
>                     Method (_DIS, 0, NotSerialized)
>                     {
>                         Or (\_SB.PCI0.LPCB.PIRC, 0x80, \_SB.PCI0.LPCB.PIR=
C)
>                     }
>=20
>                     Method (_CRS, 0, NotSerialized)
>                     {
>                         Store (Z009, Local0)
>                         CreateWordField (Local0, 0x01, IRA0)
>                         If (LEqual (And (\_SB.PCI0.LPCB.PIRC, 0x80), Zero=
))
>                         {
>                             And (\_SB.PCI0.LPCB.PIRC, 0x0F, Local0)
>                             ShiftLeft (0x01, Local0, IRA0)
>                         }
>                         Else
>                         {
>                             Store (0x00, IRA0)
>                         }
>=20
>                         Return (Local0)
>                     }
>=20
>                     Method (_SRS, 1, NotSerialized)
>                     {
>                         CreateWordField (Arg0, 0x01, IRA0)
>                         FindSetRightBit (IRA0, Local0)
>                         Decrement (Local0)
>                         Or (Local0, And (\_SB.PCI0.LPCB.PIRC, 0x70), \_SB=
=2EPCI0.LPCB.PIRC)
>                     }
>=20
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         If (And (\_SB.PCI0.LPCB.PIRC, 0x80))
>                         {
>                             Return (0x09)
>                         }
>=20
>                         Return (0x0B)
>                     }
>                 }
>=20
>                 Device (LNKD)
>                 {
>                     Name (_HID, EisaId ("PNP0C0F"))
>                     Name (_UID, 0x04)
>                     Method (_PRS, 0, NotSerialized)
>                     {
>                         Return (Z00B)
>                     }
>=20
>                     Method (_DIS, 0, NotSerialized)
>                     {
>                         Or (\_SB.PCI0.LPCB.PIRD, 0x80, \_SB.PCI0.LPCB.PIR=
D)
>                     }
>=20
>                     Method (_CRS, 0, NotSerialized)
>                     {
>                         Store (Z00B, Local0)
>                         CreateWordField (Local0, 0x01, IRA0)
>                         If (LEqual (And (\_SB.PCI0.LPCB.PIRD, 0x80), Zero=
))
>                         {
>                             And (\_SB.PCI0.LPCB.PIRD, 0x0F, Local0)
>                             ShiftLeft (0x01, Local0, IRA0)
>                         }
>                         Else
>                         {
>                             Store (0x00, IRA0)
>                         }
>=20
>                         Return (Local0)
>                     }
>=20
>                     Method (_SRS, 1, NotSerialized)
>                     {
>                         CreateWordField (Arg0, 0x01, IRA0)
>                         FindSetRightBit (IRA0, Local0)
>                         Decrement (Local0)
>                         Or (Local0, And (\_SB.PCI0.LPCB.PIRD, 0x70), \_SB=
=2EPCI0.LPCB.PIRD)
>                     }
>=20
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         If (And (\_SB.PCI0.LPCB.PIRD, 0x80))
>                         {
>                             Return (0x09)
>                         }
>=20
>                         Return (0x0B)
>                     }
>                 }
>=20
>                 Device (LNKE)
>                 {
>                     Name (_HID, EisaId ("PNP0C0F"))
>                     Name (_UID, 0x05)
>                     Method (_PRS, 0, NotSerialized)
>                     {
>                         Return (Z00B)
>                     }
>=20
>                     Method (_DIS, 0, NotSerialized)
>                     {
>                         Or (\_SB.PCI0.LPCB.PIRE, 0x80, \_SB.PCI0.LPCB.PIR=
E)
>                     }
>=20
>                     Method (_CRS, 0, NotSerialized)
>                     {
>                         Store (Z00B, Local0)
>                         CreateWordField (Local0, 0x01, IRA0)
>                         If (LEqual (And (\_SB.PCI0.LPCB.PIRE, 0x80), Zero=
))
>                         {
>                             And (\_SB.PCI0.LPCB.PIRE, 0x0F, Local0)
>                             ShiftLeft (0x01, Local0, IRA0)
>                         }
>                         Else
>                         {
>                             Store (0x00, IRA0)
>                         }
>=20
>                         Return (Local0)
>                     }
>=20
>                     Method (_SRS, 1, NotSerialized)
>                     {
>                         CreateWordField (Arg0, 0x01, IRA0)
>                         FindSetRightBit (IRA0, Local0)
>                         Decrement (Local0)
>                         Or (Local0, And (\_SB.PCI0.LPCB.PIRE, 0x70), \_SB=
=2EPCI0.LPCB.PIRE)
>                     }
>=20
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         If (And (\_SB.PCI0.LPCB.PIRE, 0x80))
>                         {
>                             Return (0x09)
>                         }
>=20
>                         Return (0x0B)
>                     }
>                 }
>=20
>                 Device (LNKF)
>                 {
>                     Name (_HID, EisaId ("PNP0C0F"))
>                     Name (_UID, 0x06)
>                     Method (_PRS, 0, NotSerialized)
>                     {
>                         Return (Z00B)
>                     }
>=20
>                     Method (_DIS, 0, NotSerialized)
>                     {
>                         Or (\_SB.PCI0.LPCB.PIRF, 0x80, \_SB.PCI0.LPCB.PIR=
F)
>                     }
>=20
>                     Method (_CRS, 0, NotSerialized)
>                     {
>                         Store (Z00B, Local0)
>                         CreateWordField (Local0, 0x01, IRA0)
>                         If (LEqual (And (\_SB.PCI0.LPCB.PIRF, 0x80), Zero=
))
>                         {
>                             And (\_SB.PCI0.LPCB.PIRF, 0x0F, Local0)
>                             ShiftLeft (0x01, Local0, IRA0)
>                         }
>                         Else
>                         {
>                             Store (0x00, IRA0)
>                         }
>=20
>                         Return (Local0)
>                     }
>=20
>                     Method (_SRS, 1, NotSerialized)
>                     {
>                         CreateWordField (Arg0, 0x01, IRA0)
>                         FindSetRightBit (IRA0, Local0)
>                         Decrement (Local0)
>                         Or (Local0, And (\_SB.PCI0.LPCB.PIRF, 0x70), \_SB=
=2EPCI0.LPCB.PIRF)
>                     }
>=20
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         If (And (\_SB.PCI0.LPCB.PIRF, 0x80))
>                         {
>                             Return (0x09)
>                         }
>=20
>                         Return (0x0B)
>                     }
>                 }
>=20
>                 Device (LNKG)
>                 {
>                     Name (_HID, EisaId ("PNP0C0F"))
>                     Name (_UID, 0x07)
>                     Method (_PRS, 0, NotSerialized)
>                     {
>                         Return (Z00B)
>                     }
>=20
>                     Method (_DIS, 0, NotSerialized)
>                     {
>                         Or (\_SB.PCI0.LPCB.PIRG, 0x80, \_SB.PCI0.LPCB.PIR=
G)
>                     }
>=20
>                     Method (_CRS, 0, NotSerialized)
>                     {
>                         Store (Z00B, Local0)
>                         CreateWordField (Local0, 0x01, IRA0)
>                         If (LEqual (And (\_SB.PCI0.LPCB.PIRG, 0x80), Zero=
))
>                         {
>                             And (\_SB.PCI0.LPCB.PIRG, 0x0F, Local0)
>                             ShiftLeft (0x01, Local0, IRA0)
>                         }
>                         Else
>                         {
>                             Store (0x00, IRA0)
>                         }
>=20
>                         Return (Local0)
>                     }
>=20
>                     Method (_SRS, 1, NotSerialized)
>                     {
>                         CreateWordField (Arg0, 0x01, IRA0)
>                         FindSetRightBit (IRA0, Local0)
>                         Decrement (Local0)
>                         Or (Local0, And (\_SB.PCI0.LPCB.PIRG, 0x70), \_SB=
=2EPCI0.LPCB.PIRG)
>                     }
>=20
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         If (And (\_SB.PCI0.LPCB.PIRG, 0x80))
>                         {
>                             Return (0x09)
>                         }
>=20
>                         Return (0x0B)
>                     }
>                 }
>=20
>                 Device (LNKH)
>                 {
>                     Name (_HID, EisaId ("PNP0C0F"))
>                     Name (_UID, 0x08)
>                     Method (_PRS, 0, NotSerialized)
>                     {
>                         Return (Z00B)
>                     }
>=20
>                     Method (_DIS, 0, NotSerialized)
>                     {
>                         Or (\_SB.PCI0.LPCB.PIRH, 0x80, \_SB.PCI0.LPCB.PIR=
H)
>                     }
>=20
>                     Method (_CRS, 0, NotSerialized)
>                     {
>                         Store (Z00B, Local0)
>                         CreateWordField (Local0, 0x01, IRA0)
>                         If (LEqual (And (\_SB.PCI0.LPCB.PIRH, 0x80), Zero=
))
>                         {
>                             And (\_SB.PCI0.LPCB.PIRH, 0x0F, Local0)
>                             ShiftLeft (0x01, Local0, IRA0)
>                         }
>                         Else
>                         {
>                             Store (0x00, IRA0)
>                         }
>=20
>                         Return (Local0)
>                     }
>=20
>                     Method (_SRS, 1, NotSerialized)
>                     {
>                         CreateWordField (Arg0, 0x01, IRA0)
>                         FindSetRightBit (IRA0, Local0)
>                         Decrement (Local0)
>                         Or (Local0, And (\_SB.PCI0.LPCB.PIRH, 0x70), \_SB=
=2EPCI0.LPCB.PIRH)
>                     }
>=20
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         If (And (\_SB.PCI0.LPCB.PIRH, 0x80))
>                         {
>                             Return (0x09)
>                         }
>=20
>                         Return (0x0B)
>                     }
>                 }
>=20
>                 Device (SIO)
>                 {
>                     Name (_HID, EisaId ("PNP0A05"))
>                     Mutex (S192, 0x00)
>                     OperationRegion (SMC1, SystemIO, 0x2E, 0x02)
>                     Field (SMC1, ByteAcc, Lock, Preserve)
>                     {
>                         INDX,   8,=20
>                         DATA,   8
>                     }
>=20
>                     IndexField (INDX, DATA, AnyAcc, NoLock, Preserve)
>                     {
>                         AccessAs (ByteAcc, 0x00),=20
>                         Offset (0x02),=20
>                         CFG,    8,=20
>                         Offset (0x07),=20
>                         LDN,    8,=20
>                         Offset (0x22),=20
>                         PWC,    8,=20
>                         LPWC,   8,=20
>                         Offset (0x30),=20
>                         ACTR,   1,=20
>                         Offset (0x60),=20
>                         IOAH,   8,=20
>                         IOAL,   8,=20
>                         Offset (0x70),=20
>                         INTR,   8,=20
>                         Offset (0x74),=20
>                         DMCH,   8,=20
>                         Offset (0xF0),=20
>                         OPT1,   8,=20
>                         OPT2,   8,=20
>                         OPT3,   8
>                     }
>=20
>                     IndexField (INDX, DATA, AnyAcc, NoLock, WriteAsOnes)
>                     {
>                         Offset (0xF0),=20
>                         LPTM,   3
>                     }
>=20
>                     Method (ENFG, 1, NotSerialized)
>                     {
>                         Acquire (S192, 0xFFFF)
>                         Store (0x55, INDX)
>                         Store (0x07, INDX)
>                         Store (Arg0, DATA)
>                     }
>=20
>                     Method (EXFG, 0, NotSerialized)
>                     {
>                         Store (0xAA, INDX)
>                         Release (S192)
>                     }
>=20
>                     Device (COM1)
>                     {
>                         Name (_HID, EisaId ("PNP0501"))
>                         Name (_UID, 0x01)
>                         Method (_STA, 0, NotSerialized)
>                         {
>                             ENFG (0x04)
>                             If (\_SB.PCI0.LPCB.Z004)
>                             {
>                                 If (ACTR)
>                                 {
>                                     Store (0x0F, Local1)
>                                 }
>                                 Else
>                                 {
>                                     Store (0x0D, Local1)
>                                 }
>                             }
>                             Else
>                             {
>                                 Store (0x00, Local1)
>                             }
>=20
>                             EXFG ()
>                             Return (Local1)
>                         }
>=20
>                         Method (_DIS, 0, NotSerialized)
>                         {
>                             ENFG (0x04)
>                             Store (Zero, ACTR)
>                             Store (Zero, INTR)
>                             Store (Zero, IOAL)
>                             Store (Zero, IOAH)
>                             EXFG ()
>                         }
>=20
>                         Method (_CRS, 0, NotSerialized)
>                         {
>                             Name (RSRC, ResourceTemplate ()
>                             {
>                                 IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
>                                 IRQNoFlags () {}
>                             })
>                             CreateByteField (RSRC, 0x02, IO1)
>                             CreateByteField (RSRC, 0x03, IO2)
>                             CreateByteField (RSRC, 0x04, IO3)
>                             CreateByteField (RSRC, 0x05, IO4)
>                             CreateWordField (RSRC, 0x09, IRQV)
>                             ENFG (0x04)
>                             If (ACTR)
>                             {
>                                 Store (IOAL, IO1)
>                                 Store (IOAH, IO2)
>                                 Store (IOAL, IO3)
>                                 Store (IOAH, IO4)
>                                 Store (0x01, Local0)
>                                 ShiftLeft (Local0, INTR, IRQV)
>                             }
>=20
>                             EXFG ()
>                             Return (RSRC)
>                         }
>=20
>                         Name (_PRS, ResourceTemplate ()
>                         {
>                             StartDependentFn (0x00, 0x00)
>                             {
>                                 IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
>                                 IRQNoFlags () {4}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
>                                 IRQNoFlags () {3}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
>                                 IRQNoFlags () {4}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
>                                 IRQNoFlags () {3}
>                             }
>                             StartDependentFn (0x02, 0x02)
>                             {
>                                 IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
>                                 IRQNoFlags () {3}
>                             }
>                             StartDependentFn (0x02, 0x02)
>                             {
>                                 IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
>                                 IRQNoFlags () {4}
>                             }
>                             StartDependentFn (0x02, 0x02)
>                             {
>                                 IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
>                                 IRQNoFlags () {3}
>                             }
>                             StartDependentFn (0x02, 0x02)
>                             {
>                                 IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
>                                 IRQNoFlags () {4}
>                             }
>                             EndDependentFn ()
>                         })
>                         Method (_SRS, 1, NotSerialized)
>                         {
>                             CreateByteField (Arg0, 0x02, IO1)
>                             CreateByteField (Arg0, 0x03, IO2)
>                             CreateWordField (Arg0, 0x09, IRQV)
>                             ENFG (0x04)
>                             Store (IO1, IOAL)
>                             Store (IO2, IOAH)
>                             FindSetRightBit (IRQV, Local0)
>                             Subtract (Local0, 0x01, INTR)
>                             Store (0x01, ACTR)
>                             EXFG ()
>                         }
>                     }
>=20
>                     Device (FDC)
>                     {
>                         Name (_HID, EisaId ("PNP0700"))
>                         Name (_UID, 0x01)
>                         Method (_STA, 0, NotSerialized)
>                         {
>                             ENFG (0x00)
>                             If (ACTR)
>                             {
>                                 Store (0x0F, Local1)
>                             }
>                             Else
>                             {
>                                 Store (0x0D, Local1)
>                             }
>=20
>                             EXFG ()
>                             Return (Local1)
>                         }
>=20
>                         Method (_DIS, 0, NotSerialized)
>                         {
>                             ENFG (0x00)
>                             Store (0x00, ACTR)
>                             Store (Zero, INTR)
>                             Store (Zero, IOAH)
>                             Store (Zero, IOAL)
>                             Store (Zero, DMCH)
>                             EXFG ()
>                         }
>=20
>                         Name (RSRC, ResourceTemplate ()
>                         {
>                             IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
>                             IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
>                             IRQNoFlags () {6}
>                             DMA (Compatibility, NotBusMaster, Transfer8) =
{2}
>                         })
>                         Method (_CRS, 0, NotSerialized)
>                         {
>                             CreateWordField (RSRC, 0x02, IO1L)
>                             CreateWordField (RSRC, 0x04, IO1H)
>                             CreateWordField (RSRC, 0x0A, IO2L)
>                             CreateWordField (RSRC, 0x0C, IO2H)
>                             CreateWordField (RSRC, 0x11, IRQX)
>                             CreateByteField (RSRC, 0x14, DMAX)
>                             Store (Zero, IO1L)
>                             Store (Zero, IO1H)
>                             Store (Zero, IO2L)
>                             Store (Zero, IO2H)
>                             Store (Zero, IRQX)
>                             Store (Zero, DMAX)
>                             ENFG (0x00)
>                             Store (ACTR, Local0)
>                             EXFG ()
>                             If (Local0)
>                             {
>                                 Store (_PRS, RSRC)
>                             }
>=20
>                             Return (RSRC)
>                         }
>=20
>                         Name (_PRS, ResourceTemplate ()
>                         {
>                             IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
>                             IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
>                             IRQNoFlags () {6}
>                             DMA (Compatibility, NotBusMaster, Transfer8) =
{2}
>                         })
>                         Method (_SRS, 1, NotSerialized)
>                         {
>                             Store (Arg0, RSRC)
>                             CreateWordField (RSRC, 0x02, IOX)
>                             CreateWordField (RSRC, 0x11, IRQX)
>                             CreateByteField (RSRC, 0x14, DMAX)
>                             ENFG (0x00)
>                             And (IOX, 0xFF, IOAL)
>                             ShiftRight (IOX, 0x08, IOAH)
>                             FindSetRightBit (IRQX, Local0)
>                             If (Local0)
>                             {
>                                 Decrement (Local0)
>                             }
>=20
>                             Store (Local0, INTR)
>                             FindSetRightBit (DMAX, Local0)
>                             If (Local0)
>                             {
>                                 Decrement (Local0)
>                             }
>=20
>                             Store (Local0, DMCH)
>                             Store (0x01, ACTR)
>                             EXFG ()
>                         }
>                     }
>=20
>                     Device (ECP)
>                     {
>                         Method (_HID, 0, NotSerialized)
>                         {
>                             If (\_SB.PCI0.LPCB.Z006)
>                             {
>                                 Return (0x0104D041)
>                             }
>                             Else
>                             {
>                                 Return (0x0004D041)
>                             }
>                         }
>=20
>                         Name (_UID, 0x01)
>                         Method (_STA, 0, NotSerialized)
>                         {
>                             If (LEqual (\_SB.PCI0.LPCB.Z005, 0x01))
>                             {
>                                 ENFG (0x03)
>                                 If (ACTR)
>                                 {
>                                     Store (0x0F, Local1)
>                                 }
>                                 Else
>                                 {
>                                     Store (0x0D, Local1)
>                                 }
>=20
>                                 EXFG ()
>                             }
>                             Else
>                             {
>                                 Store (0x00, Local1)
>                             }
>=20
>                             Return (Local1)
>                         }
>=20
>                         Method (_DIS, 0, NotSerialized)
>                         {
>                             ENFG (0x03)
>                             Store (0x00, ACTR)
>                             Store (0x00, IOAL)
>                             Store (0x00, IOAH)
>                             Store (0x00, INTR)
>                             Store (0x00, DMCH)
>                             EXFG ()
>                         }
>=20
>                         Method (_CRS, 0, NotSerialized)
>                         {
>                             ENFG (0x03)
>                             Name (CRSD, ResourceTemplate ()
>                             {
>                                 IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
>                                 IRQNoFlags () {}
>                             })
>                             CreateByteField (CRSD, 0x02, IOD1)
>                             CreateByteField (CRSD, 0x03, IOD2)
>                             CreateByteField (CRSD, 0x04, IOD3)
>                             CreateByteField (CRSD, 0x05, IOD4)
>                             CreateByteField (CRSD, 0x06, ALD1)
>                             CreateByteField (CRSD, 0x07, LND1)
>                             CreateWordField (CRSD, 0x09, IRQD)
>                             Name (CRSB, ResourceTemplate ()
>                             {
>                                 IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
>                                 IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
>                                 IRQNoFlags () {}
>                                 DMA (Compatibility, NotBusMaster, Transfe=
r16) {}
>                             })
>                             CreateByteField (CRSB, 0x02, IOB1)
>                             CreateByteField (CRSB, 0x03, IOB2)
>                             CreateByteField (CRSB, 0x04, IOB3)
>                             CreateByteField (CRSB, 0x05, IOB4)
>                             CreateByteField (CRSB, 0x06, ALB1)
>                             CreateByteField (CRSB, 0x07, LNB1)
>                             CreateByteField (CRSB, 0x0A, IOB5)
>                             CreateByteField (CRSB, 0x0B, IOB6)
>                             CreateByteField (CRSB, 0x0C, IOB7)
>                             CreateByteField (CRSB, 0x0D, IOB8)
>                             CreateByteField (CRSB, 0x0E, ALB2)
>                             CreateByteField (CRSB, 0x0F, LNB2)
>                             CreateWordField (CRSB, 0x11, IRQB)
>                             CreateWordField (CRSB, 0x14, DMAV)
>                             If (ACTR)
>                             {
>                                 If (\_SB.PCI0.LPCB.Z006)
>                                 {
>                                     Store (IOAL, IOB1)
>                                     Store (IOAH, IOB2)
>                                     Store (IOAL, IOB3)
>                                     Store (IOAH, IOB4)
>                                     Store (IOAL, IOB5)
>                                     Add (IOAH, 0x04, IOB6)
>                                     Store (IOAL, IOB7)
>                                     Add (IOAH, 0x04, IOB8)
>                                     If (LEqual (IOAL, 0xBC))
>                                     {
>                                         Store (0x08, ALB1)
>                                         Store (0x03, LNB1)
>                                         Store (0x08, ALB2)
>                                         Store (0x03, LNB2)
>                                     }
>=20
>                                     Store (INTR, Local1)
>                                     If (Local1)
>                                     {
>                                         ShiftLeft (One, Local1, IRQB)
>                                     }
>=20
>                                     Store (0x01, Local0)
>                                     ShiftLeft (Local0, DMCH, DMAV)
>                                 }
>                                 Else
>                                 {
>                                     Store (IOAL, IOD1)
>                                     Store (IOAH, IOD2)
>                                     Store (IOAL, IOD3)
>                                     Store (IOAH, IOD4)
>                                     If (LEqual (IOAL, 0xBC))
>                                     {
>                                         Store (0x08, ALD1)
>                                         Store (0x03, LND1)
>                                     }
>=20
>                                     Store (INTR, Local1)
>                                     If (Local1)
>                                     {
>                                         ShiftLeft (One, Local1, IRQD)
>                                     }
>                                 }
>                             }
>=20
>                             EXFG ()
>                             If (\_SB.PCI0.LPCB.Z006)
>                             {
>                                 Return (CRSB)
>                             }
>                             Else
>                             {
>                                 Return (CRSD)
>                             }
>                         }
>=20
>                         Name (PRSD, ResourceTemplate ()
>                         {
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
>                                 IRQNoFlags () {7}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
>                                 IRQNoFlags () {5}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
>                                 IRQNoFlags () {7}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
>                                 IRQNoFlags () {5}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
>                                 IRQNoFlags () {7}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
>                                 IRQNoFlags () {5}
>                             }
>                             EndDependentFn ()
>                         })
>                         Name (PRSB, ResourceTemplate ()
>                         {
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
>                                 IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
>                                 IRQNoFlags () {7}
>                                 DMA (Compatibility, NotBusMaster, Transfe=
r16) {1,3}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
>                                 IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
>                                 IRQNoFlags () {5}
>                                 DMA (Compatibility, NotBusMaster, Transfe=
r16) {1,3}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
>                                 IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
>                                 IRQNoFlags () {7}
>                                 DMA (Compatibility, NotBusMaster, Transfe=
r16) {1,3}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
>                                 IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
>                                 IRQNoFlags () {5}
>                                 DMA (Compatibility, NotBusMaster, Transfe=
r16) {1,3}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
>                                 IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
>                                 IRQNoFlags () {7}
>                                 DMA (Compatibility, NotBusMaster, Transfe=
r16) {1,3}
>                             }
>                             StartDependentFnNoPri ()
>                             {
>                                 IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
>                                 IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
>                                 IRQNoFlags () {5}
>                                 DMA (Compatibility, NotBusMaster, Transfe=
r16) {1,3}
>                             }
>                             EndDependentFn ()
>                         })
>                         Method (_PRS, 0, NotSerialized)
>                         {
>                             If (\_SB.PCI0.LPCB.Z006)
>                             {
>                                 Return (PRSB)
>                             }
>                             Else
>                             {
>                                 Return (PRSD)
>                             }
>                         }
>=20
>                         Method (_SRS, 1, NotSerialized)
>                         {
>                             ENFG (0x03)
>                             If (\_SB.PCI0.LPCB.Z006)
>                             {
>                                 CreateByteField (Arg0, 0x02, IOB1)
>                                 CreateByteField (Arg0, 0x03, IOB2)
>                                 CreateByteField (Arg0, 0x04, IOB3)
>                                 CreateByteField (Arg0, 0x05, IOB4)
>                                 CreateByteField (Arg0, 0x06, ALB1)
>                                 CreateByteField (Arg0, 0x07, LNB1)
>                                 CreateByteField (Arg0, 0x0A, IOB5)
>                                 CreateByteField (Arg0, 0x0B, IOB6)
>                                 CreateByteField (Arg0, 0x0C, IOB7)
>                                 CreateByteField (Arg0, 0x0D, IOB8)
>                                 CreateByteField (Arg0, 0x0E, ALB2)
>                                 CreateByteField (Arg0, 0x0F, LNB2)
>                                 CreateWordField (Arg0, 0x11, IRQB)
>                                 CreateWordField (Arg0, 0x14, DMAV)
>                                 Store (IOB1, IOAL)
>                                 Store (IOB2, IOAH)
>                                 FindSetRightBit (IRQB, Local0)
>                                 If (Local0)
>                                 {
>                                     Decrement (Local0)
>                                 }
>=20
>                                 Store (Local0, INTR)
>                                 FindSetRightBit (DMAV, Local0)
>                                 If (Local0)
>                                 {
>                                     Decrement (Local0)
>                                 }
>=20
>                                 Store (Local0, DMCH)
>                             }
>                             Else
>                             {
>                                 CreateByteField (Arg0, 0x02, IOD1)
>                                 CreateByteField (Arg0, 0x03, IOD2)
>                                 CreateByteField (Arg0, 0x04, IOD3)
>                                 CreateByteField (Arg0, 0x05, IOD4)
>                                 CreateByteField (Arg0, 0x06, ALD1)
>                                 CreateByteField (Arg0, 0x07, LND1)
>                                 CreateWordField (Arg0, 0x09, IRQD)
>                                 Store (IOD1, IOAL)
>                                 Store (IOD2, IOAH)
>                                 FindSetRightBit (IRQD, Local0)
>                                 If (Local0)
>                                 {
>                                     Decrement (Local0)
>                                 }
>=20
>                                 Store (Local0, INTR)
>                             }
>=20
>                             Store (0x01, ACTR)
>                             EXFG ()
>                         }
>                     }
>                 }
>=20
>                 Device (DMAC)
>                 {
>                     Name (_HID, EisaId ("PNP0200"))
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
>                         IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
>                         IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
>                         IO (Decode16, 0x0480, 0x0480, 0x01, 0x10)
>                         DMA (Compatibility, NotBusMaster, Transfer16) {4}
>                     })
>                 }
>=20
>                 Device (PIC)
>                 {
>                     Name (_HID, EisaId ("PNP0000"))
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
>                         IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
>                         IRQ (Edge, ActiveHigh, Exclusive) {2}
>                     })
>                 }
>=20
>                 Device (TIME)
>                 {
>                     Name (_HID, EisaId ("PNP0100"))
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
>                         IRQNoFlags () {0}
>                     })
>                 }
>=20
>                 Device (RTC)
>                 {
>                     Name (_HID, EisaId ("PNP0B00"))
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x0070, 0x0070, 0x01, 0x02)
>                         IRQNoFlags () {8}
>                     })
>                 }
>=20
>                 Device (SPKR)
>                 {
>                     Name (_HID, EisaId ("PNP0800"))
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
>                     })
>                 }
>=20
>                 Device (SYSR)
>                 {
>                     Name (_HID, EisaId ("PNP0C02"))
>                     Name (RSRC, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x1000, 0x1000, 0x01, 0x90)
>                         IO (Decode16, 0x8090, 0x8090, 0x01, 0x70)
>                         IO (Decode16, 0x8100, 0x8100, 0x01, 0x20)
>                         IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
>                         IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
>                         IO (Decode16, 0xFE00, 0xFE00, 0x01, 0x01)
>                         IO (Decode16, 0x002E, 0x002E, 0x01, 0x01)
>                         IO (Decode16, 0x002F, 0x002F, 0x01, 0x01)
>                         Memory32Fixed (ReadOnly, 0xFEC00000, 0x00100000)
>                         Memory32Fixed (ReadOnly, 0xFEE00000, 0x00100000)
>                         Memory32Fixed (ReadOnly, 0xFFC00000, 0x00001000)
>                         Memory32Fixed (ReadOnly, 0xFFE00000, 0x00001000)
>                         Memory32Fixed (ReadOnly, 0xFFE80000, 0x00080000)
>                         IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
>                         IO (Decode16, 0x01C0, 0x01C0, 0x01, 0x10)
>                         IO (Decode16, 0x0500, 0x0500, 0x01, 0x80)
>                     })
>                     Method (_CRS, 0, NotSerialized)
>                     {
>                         CreateWordField (RSRC, 0x02, PMMN)
>                         CreateWordField (RSRC, 0x04, PMMX)
>                         And (\_SB.PCI0.LPCB.Z001, 0xFF80, PMMN)
>                         Store (PMMN, PMMX)
>                         Return (RSRC)
>                     }
>                 }
>=20
>                 Device (COPR)
>                 {
>                     Name (_HID, EisaId ("PNP0C04"))
>                     Method (_STA, 0, NotSerialized)
>                     {
>                         Return (0x0B)
>                     }
>=20
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x10)
>                         IRQNoFlags () {13}
>                     })
>                 }
>=20
>                 Device (KBC)
>                 {
>                     Name (_HID, EisaId ("PNP0303"))
>                     Name (_UID, 0x01)
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
>                         IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
>                         IRQNoFlags () {1}
>                     })
>                 }
>=20
>                 Device (PS2M)
>                 {
>                     Name (_HID, EisaId ("PNP0F13"))
>                     Name (_UID, 0x00)
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IRQ (Edge, ActiveHigh, Exclusive) {12}
>                     })
>                 }
>=20
>                 Device (EC0)
>                 {
>                     Name (_HID, EisaId ("PNP0C09"))
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
>                         IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
>                     })
>                     Name (_GPE, 0x19)
>                     Method (_REG, 2, NotSerialized)
>                     {
>                         If (LEqual (Arg0, 0x03))
>                         {
>                             Store (Arg1, Local0)
>                             If (Local0)
>                             {
>                                 Store (0x01, ECEN)
>                             }
>                             Else
>                             {
>                                 Store (0x00, ECEN)
>                             }
>                         }
>                     }
>=20
>                     Mutex (MUT0, 0x00)
>                     Mutex (MUT1, 0x00)
>                     OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
>                     Field (ERAM, ByteAcc, NoLock, Preserve)
>                     {
>                         Offset (0x60),=20
>                         SMPR,   8,=20
>                         SMST,   8,=20
>                         SMAD,   8,=20
>                         SMCM,   8,=20
>                         SMD0,   256,=20
>                         BCNT,   8,=20
>                         SMAA,   8,=20
>                         BATD,   16,=20
>                         Offset (0x91),=20
>                             ,   4,=20
>                         ACST,   1,=20
>                         Offset (0x9C),=20
>                         THRL,   8,=20
>                         BTMD,   8,=20
>                         BTCS,   8,=20
>                         BTMN,   8,=20
>                         BTSN,   16,=20
>                         BTDV,   16,=20
>                         BTDC,   16,=20
>                         LFCC,   16,=20
>                         BATV,   16,=20
>                         BATC,   16,=20
>                         BATT,   16,=20
>                         BTRC,   16,=20
>                         BTST,   16,=20
>                         OBTS,   7,=20
>                         BATF,   1
>                     }
>=20
>                     Field (ERAM, ByteAcc, NoLock, Preserve)
>                     {
>                         Offset (0x64),=20
>                         SMW0,   16
>                     }
>=20
>                     Field (ERAM, ByteAcc, NoLock, Preserve)
>                     {
>                         Offset (0x64),=20
>                         SMB0,   8
>                     }
>=20
>                     Field (ERAM, ByteAcc, NoLock, Preserve)
>                     {
>                         Offset (0x64),=20
>                         FLD0,   64
>                     }
>=20
>                     Field (ERAM, ByteAcc, NoLock, Preserve)
>                     {
>                         Offset (0x64),=20
>                         FLD1,   128
>                     }
>=20
>                     Field (ERAM, ByteAcc, NoLock, Preserve)
>                     {
>                         Offset (0x64),=20
>                         FLD2,   192
>                     }
>=20
>                     Field (ERAM, ByteAcc, NoLock, Preserve)
>                     {
>                         Offset (0x64),=20
>                         FLD3,   256
>                     }
>=20
>                     Method (SMRD, 4, NotSerialized)
>                     {
>                         If (LNot (\_SB.ECEN))
>                         {
>                             Return (0xFF)
>                         }
>=20
>                         If (LNot (LEqual (Arg0, 0x07)))
>                         {
>                             If (LNot (LEqual (Arg0, 0x09)))
>                             {
>                                 If (LNot (LEqual (Arg0, 0x0B)))
>                                 {
>                                     Return (0x19)
>                                 }
>                             }
>                         }
>=20
>                         Acquire (MUT0, 0xFFFF)
>                         Store (0x04, Local0)
>                         While (LGreater (Local0, 0x01))
>                         {
>                             And (SMST, 0x40, SMST)
>                             Store (Arg2, SMCM)
>                             Store (Arg1, SMAD)
>                             Store (Arg0, SMPR)
>                             Store (0x00, Local3)
>                             While (LNot (And (SMST, 0xBF, Local1)))
>                             {
>                                 Sleep (0x02)
>                                 Increment (Local3)
>                                 If (LEqual (Local3, 0x32))
>                                 {
>                                     And (SMST, 0x40, SMST)
>                                     Store (Arg2, SMCM)
>                                     Store (Arg1, SMAD)
>                                     Store (Arg0, SMPR)
>                                     Store (0x00, Local3)
>                                 }
>                             }
>=20
>                             If (LEqual (Local1, 0x80))
>                             {
>                                 Store (0x00, Local0)
>                             }
>                             Else
>                             {
>                                 Decrement (Local0)
>                             }
>                         }
>=20
>                         If (Local0)
>                         {
>                             Store (And (Local1, 0x1F), Local0)
>                         }
>                         Else
>                         {
>                             If (LEqual (Arg0, 0x07))
>                             {
>                                 Store (SMB0, Arg3)
>                             }
>=20
>                             If (LEqual (Arg0, 0x09))
>                             {
>                                 Store (SMW0, Arg3)
>                             }
>=20
>                             If (LEqual (Arg0, 0x0B))
>                             {
>                                 Store (BCNT, Local3)
>                                 ShiftRight (0x0100, 0x03, Local2)
>                                 If (LGreater (Local3, Local2))
>                                 {
>                                     Store (Local2, Local3)
>                                 }
>=20
>                                 If (LLess (Local3, 0x09))
>                                 {
>                                     Store (FLD0, Local2)
>                                 }
>                                 Else
>                                 {
>                                     If (LLess (Local3, 0x11))
>                                     {
>                                         Store (FLD1, Local2)
>                                     }
>                                     Else
>                                     {
>                                         If (LLess (Local3, 0x19))
>                                         {
>                                             Store (FLD2, Local2)
>                                         }
>                                         Else
>                                         {
>                                             Store (FLD3, Local2)
>                                         }
>                                     }
>                                 }
>=20
>                                 Increment (Local3)
>                                 Store (Buffer (Local3) {}, Local4)
>                                 Decrement (Local3)
>                                 Store (Zero, Local5)
>                                 While (LGreater (Local3, Local5))
>                                 {
>                                     GBFE (Local2, Local5, RefOf (Local6))
>                                     PBFE (Local4, Local5, Local6)
>                                     Increment (Local5)
>                                 }
>=20
>                                 PBFE (Local4, Local5, 0x00)
>                                 Store (Local4, Arg3)
>                             }
>                         }
>=20
>                         Release (MUT0)
>                         Return (Local0)
>                     }
>=20
>                     Method (SMWR, 4, NotSerialized)
>                     {
>                         If (LNot (\_SB.ECEN))
>                         {
>                             Return (0xFF)
>                         }
>=20
>                         If (LNot (LEqual (Arg0, 0x06)))
>                         {
>                             If (LNot (LEqual (Arg0, 0x08)))
>                             {
>                                 If (LNot (LEqual (Arg0, 0x0A)))
>                                 {
>                                     Return (0x19)
>                                 }
>                             }
>                         }
>=20
>                         Acquire (MUT0, 0xFFFF)
>                         Store (0x04, Local0)
>                         While (LGreater (Local0, 0x01))
>                         {
>                             If (LEqual (Arg0, 0x06))
>                             {
>                                 Store (Arg3, SMB0)
>                             }
>=20
>                             If (LEqual (Arg0, 0x08))
>                             {
>                                 Store (Arg3, SMW0)
>                             }
>=20
>                             If (LEqual (Arg0, 0x0A))
>                             {
>                                 Store (Arg3, SMD0)
>                             }
>=20
>                             And (SMST, 0x40, SMST)
>                             Store (Arg2, SMCM)
>                             Store (Arg1, SMAD)
>                             Store (Arg0, SMPR)
>                             Store (0x00, Local3)
>                             While (LNot (And (SMST, 0xBF, Local1)))
>                             {
>                                 Sleep (0x02)
>                                 Increment (Local3)
>                                 If (LEqual (Local3, 0x32))
>                                 {
>                                     And (SMST, 0x40, SMST)
>                                     Store (Arg2, SMCM)
>                                     Store (Arg1, SMAD)
>                                     Store (Arg0, SMPR)
>                                     Store (0x00, Local3)
>                                 }
>                             }
>=20
>                             If (LEqual (Local1, 0x80))
>                             {
>                                 Store (0x00, Local0)
>                             }
>                             Else
>                             {
>                                 Decrement (Local0)
>                             }
>                         }
>=20
>                         If (Local0)
>                         {
>                             Store (And (Local1, 0x1F), Local0)
>                         }
>=20
>                         Release (MUT0)
>                         Return (Local0)
>                     }
>=20
>                     Method (GBFE, 3, NotSerialized)
>                     {
>                         CreateByteField (Arg0, Arg1, TIDX)
>                         Store (TIDX, Arg2)
>                     }
>=20
>                     Method (PBFE, 3, NotSerialized)
>                     {
>                         CreateByteField (Arg0, Arg1, TIDX)
>                         Store (Arg2, TIDX)
>                     }
>=20
>                     Method (_Q0D, 0, NotSerialized)
>                     {
>                         Notify (\_SB.SLPB, 0x80)
>                     }
>=20
>                     Method (_Q0E, 0, NotSerialized)
>                     {
>                         If (\_SB.PCI0.LPCB.Z000)
>                         {
>                             \_SB.PCI0.LPCB.PHSR (0x01, 0x00)
>                         }
>                         Else
>                         {
>                             \_SB.PCI0.AGPB.VGA.DRUL (0x01)
>                         }
>                     }
>=20
>                     Method (_Q0F, 0, NotSerialized)
>                     {
>                         XOr (\_SB.PCI0.LPCB.BLIT, 0x01, \_SB.PCI0.LPCB.BL=
IT)
>                     }
>=20
>                     Method (_Q20, 0, NotSerialized)
>                     {
>                         Notify (\_SB.ACAD, 0x80)
>                         Sleep (0x01F4)
>                         \_SB.BAT1.Z00C ()
>                         Notify (\_SB.BAT1, 0x80)
>                         If (\_SB.BAT1.BTCH)
>                         {
>                             \_SB.BAT1.UBIF ()
>                             Notify (\_SB.BAT1, 0x81)
>                             Store (0x00, \_SB.BAT1.BTCH)
>                         }
>                     }
>                 }
>             }
>=20
>             Device (IEEE)
>             {
>                 Name (_ADR, 0x00020003)
>             }
>=20
>             Device (IDE)
>             {
>                 Name (_ADR, 0x00020005)
>                 Name (IO5T, Package (0x03)
>                 {
>                     Package (0x07)
>                     {
>                         0x78,=20
>                         0xB4,=20
>                         0x014A,=20
>                         0x0186,=20
>                         0x0258,=20
>                         0x78,=20
>                         0x96
>                     },=20
>=20
>                     Package (0x07)
>                     {
>                         0x06,=20
>                         0x07,=20
>                         0x1C,=20
>                         0x1C,=20
>                         0x1C,=20
>                         0x06,=20
>                         0x07
>                     },=20
>=20
>                     Package (0x07)
>                     {
>                         0x04,=20
>                         0x09,=20
>                         0x03,=20
>                         0x09,=20
>                         0x1E,=20
>                         0x04,=20
>                         0x06
>                     }
>                 })
>                 Name (IO6T, Package (0x03)
>                 {
>                     Package (0x07)
>                     {
>                         0x78,=20
>                         0xB4,=20
>                         0x014A,=20
>                         0x0186,=20
>                         0x0258,=20
>                         0x78,=20
>                         0xB4
>                     },=20
>=20
>                     Package (0x07)
>                     {
>                         0x09,=20
>                         0x0A,=20
>                         0x26,=20
>                         0x26,=20
>                         0x26,=20
>                         0x09,=20
>                         0x0A
>                     },=20
>=20
>                     Package (0x07)
>                     {
>                         0x05,=20
>                         0x0C,=20
>                         0x04,=20
>                         0x0C,=20
>                         0x28,=20
>                         0x05,=20
>                         0x0C
>                     }
>                 })
>                 Name (UM5T, Package (0x06)
>                 {
>                     0x0B,=20
>                     0x07,=20
>                     0x05,=20
>                     0x04,=20
>                     0x02,=20
>                     0x01
>                 })
>                 Name (UM6T, Package (0x07)
>                 {
>                     0x0F,=20
>                     0x0A,=20
>                     0x07,=20
>                     0x05,=20
>                     0x03,=20
>                     0x02,=20
>                     0x01
>                 })
>                 Name (PIO5, Package (0x05)
>                 {
>                     0x3A,=20
>                     0x25,=20
>                     0x1F,=20
>                     0x10,=20
>                     0x0A
>                 })
>                 Name (PIO6, Package (0x05)
>                 {
>                     0x4E,=20
>                     0x32,=20
>                     0x2A,=20
>                     0x16,=20
>                     0x0E
>                 })
>                 Name (CRCT, Package (0x07)
>                 {
>                     0x06,=20
>                     0x04,=20
>                     0x03,=20
>                     0x01,=20
>                     0x01,=20
>                     0x01,=20
>                     0x01
>                 })
>                 Name (INTT, Package (0x05)
>                 {
>                     0x02,=20
>                     0x02,=20
>                     0x02,=20
>                     0x04,=20
>                     0x06
>                 })
>                 Name (DMAT, Package (0x05)
>                 {
>                     0x00,=20
>                     0x01,=20
>                     0x01,=20
>                     0x01,=20
>                     0x02
>                 })
>                 Name (RMFL, 0x01)
>                 OperationRegion (CF40, PCI_Config, 0x40, 0x18)
>                 Field (CF40, WordAcc, NoLock, Preserve)
>                 {
>                         ,   1,=20
>                     IOR0,   1,=20
>                     UDM0,   1,=20
>                     UM60,   1,=20
>                     UCT0,   4,=20
>                     CRC0,   4,=20
>                     INI0,   4,=20
>                     ATT0,   6,=20
>                     Offset (0x03),=20
>                     RCT0,   6,=20
>                     Offset (0x04),=20
>                         ,   1,=20
>                     IOR1,   1,=20
>                     UDM1,   1,=20
>                     UM61,   1,=20
>                     UCT1,   4,=20
>                     CRC1,   4,=20
>                     INI1,   4,=20
>                     ATT1,   6,=20
>                     Offset (0x07),=20
>                     RCT1,   6,=20
>                     Offset (0x08),=20
>                         ,   1,=20
>                     IOR2,   1,=20
>                     UDM2,   1,=20
>                     UM62,   1,=20
>                     UCT2,   4,=20
>                     CRC2,   4,=20
>                     INI2,   4,=20
>                     ATT2,   6,=20
>                     Offset (0x0B),=20
>                     RCT2,   6,=20
>                     Offset (0x0C),=20
>                         ,   1,=20
>                     IOR3,   1,=20
>                     UDM3,   1,=20
>                     UM63,   1,=20
>                     UCT3,   4,=20
>                     CRC3,   4,=20
>                     INI3,   4,=20
>                     ATT3,   6,=20
>                     Offset (0x0F),=20
>                     RCT3,   6,=20
>                     Offset (0x10),=20
>                         ,   1,=20
>                     CHE0,   1,=20
>                     Offset (0x12),=20
>                         ,   1,=20
>                     CHE1,   1,=20
>                     Offset (0x14),=20
>                         ,   30,=20
>                     REMP,   1,=20
>                     Offset (0x18)
>                 }
>=20
>                 Name (IDEP, Buffer (0x14) {})
>                 CreateDWordField (IDEP, 0x00, GTM0)
>                 CreateDWordField (IDEP, 0x04, GTM1)
>                 CreateDWordField (IDEP, 0x08, GTM2)
>                 CreateDWordField (IDEP, 0x0C, GTM3)
>                 CreateDWordField (IDEP, 0x10, GTM4)
>                 Device (IDE0)
>                 {
>                     Name (_ADR, 0x00)
>                     Method (_GTM, 0, NotSerialized)
>                     {
>                         Store (0xFFFFFFFF, Local0)
>                         Store (0xFFFFFFFF, Local1)
>                         Store (0xFFFFFFFF, Local2)
>                         Store (0xFFFFFFFF, Local3)
>                         Store (0x10, Local4)
>                         Store (REMP, RMFL)
>                         Store (0x00, REMP)
>                         If (CHE0)
>                         {
>                             If (LNot (LEqual (ATT0, 0x00)))
>                             {
>                                 Add (RCT0, 0x01, Local5)
>                                 Add (ATT0, 0x01, Local6)
>                                 Add (Local5, Local6, Local5)
>                                 Multiply (UM60, 0x05, Local6)
>                                 Subtract (0x14, Local6, Local7)
>                                 Multiply (Local5, Local7, Local0)
>                                 ShiftRight (Local0, 0x01, Local0)
>                                 If (LNot (LGreater (Local0, 0xB4)))
>                                 {
>                                     Store (Local0, Local1)
>                                 }
>=20
>                                 If (IOR0)
>                                 {
>                                     Or (Local4, 0x02, Local4)
>                                 }
>=20
>                                 If (UDM0)
>                                 {
>                                     Add (UCT0, 0x01, Local5)
>                                     Multiply (Local5, Local7, Local6)
>                                     ShiftRight (Local6, 0x01, Local1)
>                                     Or (Local4, 0x01, Local4)
>                                 }
>                             }
>=20
>                             If (LNot (LEqual (ATT1, 0x00)))
>                             {
>                                 Add (RCT1, 0x01, Local5)
>                                 Add (ATT1, 0x01, Local6)
>                                 Add (Local5, Local6, Local5)
>                                 Multiply (UM61, 0x05, Local6)
>                                 Subtract (0x14, Local6, Local7)
>                                 Multiply (Local5, Local7, Local2)
>                                 ShiftRight (Local2, 0x01, Local2)
>                                 If (LNot (LGreater (Local2, 0xB4)))
>                                 {
>                                     Store (Local2, Local3)
>                                 }
>=20
>                                 If (IOR1)
>                                 {
>                                     Or (Local4, 0x08, Local4)
>                                 }
>=20
>                                 If (UDM1)
>                                 {
>                                     Add (UCT1, 0x01, Local5)
>                                     Multiply (Local5, Local7, Local6)
>                                     ShiftRight (Local6, 0x01, Local3)
>                                     Or (Local4, 0x04, Local4)
>                                 }
>                             }
>                         }
>=20
>                         Store (RMFL, REMP)
>                         Store (Local0, GTM0)
>                         Store (Local1, GTM1)
>                         Store (Local2, GTM2)
>                         Store (Local3, GTM3)
>                         Store (Local4, GTM4)
>                         Return (IDEP)
>                     }
>=20
>                     Method (_STM, 3, NotSerialized)
>                     {
>                         Store (Arg0, IDEP)
>                         Store (GTM0, Local0)
>                         Store (GTM1, Local1)
>                         Store (GTM2, Local2)
>                         Store (GTM3, Local3)
>                         Store (GTM4, Local4)
>                         Store (REMP, RMFL)
>                         Store (0x00, REMP)
>                         If (LAnd (LNot (LEqual (Local1, 0xFFFFFFFF)), LNo=
t (LEqual (Local1, 0x00))))
>                         {
>                             If (And (Local4, 0x01))
>                             {
>                                 Store (0x01, UDM0)
>                                 If (LLess (Local1, 0x14))
>                                 {
>                                     Store (0x01, UM60)
>                                     Store (0x01, UCT0)
>                                 }
>                                 Else
>                                 {
>                                     Store (0x00, UM60)
>                                     Divide (Local1, 0x0A, Local6, Local5)
>                                     Decrement (Local5)
>                                     Store (Local5, UCT0)
>                                     Store (Match (UM5T, MEQ, Local5, MTR,=
 0x00, 0x00), Local5)
>                                     Store (DerefOf (Index (CRCT, Local5))=
, CRC0)
>                                 }
>                             }
>                         }
>=20
>                         If (LAnd (LNot (LEqual (Local0, 0xFFFFFFFF)), LNo=
t (LEqual (Local0, 0x00))))
>                         {
>                             If (UM60)
>                             {
>                                 Store (Match (DerefOf (Index (IO6T, 0x00)=
), MEQ, Local0, MTR, 0x00, 0x00), Local6)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
6T, 0x01)), Local6)), ATT0)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
6T, 0x02)), Local6)), RCT0)
>                             }
>                             Else
>                             {
>                                 Store (Match (DerefOf (Index (IO5T, 0x00)=
), MEQ, Local0, MTR, 0x00, 0x00), Local6)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
5T, 0x01)), Local6)), ATT0)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
5T, 0x02)), Local6)), RCT0)
>                                 Store (DerefOf (Index (INTT, Local6)), IN=
I0)
>                             }
>                         }
>=20
>                         If (LAnd (LNot (LEqual (Local3, 0xFFFFFFFF)), LNo=
t (LEqual (Local3, 0x00))))
>                         {
>                             If (And (Local4, 0x04))
>                             {
>                                 Store (0x01, UDM1)
>                                 If (LLess (Local3, 0x14))
>                                 {
>                                     Store (0x01, UM61)
>                                     Store (0x01, UCT1)
>                                 }
>                                 Else
>                                 {
>                                     Store (0x00, UM61)
>                                     Divide (Local3, 0x0A, Local6, Local5)
>                                     Decrement (Local5)
>                                     Store (Local5, UCT1)
>                                     Store (Match (UM5T, MEQ, Local5, MTR,=
 0x00, 0x00), Local5)
>                                     Store (DerefOf (Index (CRCT, Local5))=
, CRC1)
>                                 }
>                             }
>                         }
>=20
>                         If (LAnd (LNot (LEqual (Local2, 0xFFFFFFFF)), LNo=
t (LEqual (Local2, 0x00))))
>                         {
>                             If (UM61)
>                             {
>                                 Store (Match (DerefOf (Index (IO6T, 0x00)=
), MEQ, Local2, MTR, 0x00, 0x00), Local6)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
6T, 0x01)), Local6)), ATT1)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
6T, 0x02)), Local6)), RCT1)
>                             }
>                             Else
>                             {
>                                 Store (Match (DerefOf (Index (IO5T, 0x00)=
), MEQ, Local2, MTR, 0x00, 0x00), Local6)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
5T, 0x01)), Local6)), ATT1)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
5T, 0x02)), Local6)), RCT1)
>                                 Store (DerefOf (Index (INTT, Local6)), IN=
I1)
>                             }
>                         }
>=20
>                         Store (RMFL, REMP)
>                     }
>=20
>                     Device (DRV0)
>                     {
>                         Name (_ADR, 0x00)
>                         Method (_GTF, 0, NotSerialized)
>                         {
>                             Store (Buffer (0x07)
>                                 {
>                                     0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0=
xEF
>                                 }, Local6)
>                             Store (Buffer (0x07)
>                                 {
>                                     0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0=
xEF
>                                 }, Local7)
>                             CreateByteField (Local6, 0x01, MODE)
>                             CreateByteField (Local7, 0x01, UMOD)
>                             Store (REMP, RMFL)
>                             Store (0x00, REMP)
>                             If (LNot (LEqual (ATT0, 0x00)))
>                             {
>                                 Add (ATT0, RCT0, Local5)
>                                 If (UM60)
>                                 {
>                                     Store (Match (PIO6, MEQ, Local5, MTR,=
 0x00, 0x00), MODE)
>                                 }
>                                 Else
>                                 {
>                                     Store (Match (PIO5, MEQ, Local5, MTR,=
 0x00, 0x00), MODE)
>                                 }
>=20
>                                 If (UDM0)
>                                 {
>                                     If (UM60)
>                                     {
>                                         Store (Match (UM6T, MEQ, UCT0, MT=
R, 0x00, 0x00), UMOD)
>                                     }
>                                     Else
>                                     {
>                                         Store (Match (UM5T, MEQ, UCT0, MT=
R, 0x00, 0x00), UMOD)
>                                     }
>=20
>                                     Or (UMOD, 0x40, UMOD)
>                                 }
>                                 Else
>                                 {
>                                     Store (DerefOf (Index (DMAT, MODE)), =
UMOD)
>                                     Or (UMOD, 0x20, UMOD)
>                                 }
>=20
>                                 Or (MODE, 0x08, MODE)
>                             }
>=20
>                             Store (RMFL, REMP)
>                             Concatenate (Local6, Local7, Local5)
>                             Return (Local5)
>                         }
>                     }
>=20
>                     Device (DRV1)
>                     {
>                         Name (_ADR, 0x01)
>                         Method (_GTF, 0, NotSerialized)
>                         {
>                             Store (Buffer (0x07)
>                                 {
>                                     0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0=
xEF
>                                 }, Local6)
>                             Store (Buffer (0x07)
>                                 {
>                                     0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0=
xEF
>                                 }, Local7)
>                             CreateByteField (Local6, 0x01, MODE)
>                             CreateByteField (Local7, 0x01, UMOD)
>                             Store (REMP, RMFL)
>                             Store (0x00, REMP)
>                             If (LNot (LEqual (ATT1, 0x00)))
>                             {
>                                 Add (ATT1, RCT1, Local5)
>                                 If (UM61)
>                                 {
>                                     Store (Match (PIO6, MEQ, Local5, MTR,=
 0x00, 0x00), MODE)
>                                 }
>                                 Else
>                                 {
>                                     Store (Match (PIO5, MEQ, Local5, MTR,=
 0x00, 0x00), MODE)
>                                 }
>=20
>                                 If (UDM1)
>                                 {
>                                     If (UM61)
>                                     {
>                                         Store (Match (UM6T, MEQ, UCT1, MT=
R, 0x00, 0x00), UMOD)
>                                     }
>                                     Else
>                                     {
>                                         Store (Match (UM5T, MEQ, UCT1, MT=
R, 0x00, 0x00), UMOD)
>                                     }
>=20
>                                     Or (UMOD, 0x40, UMOD)
>                                 }
>                                 Else
>                                 {
>                                     Store (DerefOf (Index (DMAT, MODE)), =
UMOD)
>                                     Or (UMOD, 0x20, UMOD)
>                                 }
>=20
>                                 Or (MODE, 0x08, MODE)
>                             }
>=20
>                             Store (RMFL, REMP)
>                             Concatenate (Local6, Local7, Local5)
>                             Return (Local5)
>                         }
>                     }
>                 }
>=20
>                 Device (IDE1)
>                 {
>                     Name (_ADR, 0x01)
>                     Method (_GTM, 0, NotSerialized)
>                     {
>                         Store (0xFFFFFFFF, Local0)
>                         Store (0xFFFFFFFF, Local1)
>                         Store (0xFFFFFFFF, Local2)
>                         Store (0xFFFFFFFF, Local3)
>                         Store (0x10, Local4)
>                         Store (REMP, RMFL)
>                         Store (0x00, REMP)
>                         If (CHE1)
>                         {
>                             If (LNot (LEqual (ATT2, 0x00)))
>                             {
>                                 Add (RCT2, 0x01, Local5)
>                                 Add (ATT2, 0x01, Local6)
>                                 Add (Local5, Local6, Local5)
>                                 Multiply (UM62, 0x05, Local6)
>                                 Subtract (0x14, Local6, Local7)
>                                 Multiply (Local5, Local7, Local0)
>                                 ShiftRight (Local0, 0x01, Local0)
>                                 If (LNot (LGreater (Local0, 0xB4)))
>                                 {
>                                     Store (Local0, Local1)
>                                 }
>=20
>                                 If (IOR2)
>                                 {
>                                     Or (Local4, 0x02, Local4)
>                                 }
>=20
>                                 If (UDM2)
>                                 {
>                                     Add (UCT2, 0x01, Local5)
>                                     Multiply (Local5, Local7, Local6)
>                                     ShiftRight (Local6, 0x01, Local1)
>                                     Or (Local4, 0x01, Local4)
>                                 }
>                             }
>=20
>                             If (LNot (LEqual (ATT3, 0x00)))
>                             {
>                                 Add (RCT3, 0x01, Local5)
>                                 Add (ATT3, 0x01, Local6)
>                                 Add (Local5, Local6, Local5)
>                                 Multiply (UM63, 0x05, Local6)
>                                 Subtract (0x14, Local6, Local7)
>                                 Multiply (Local5, Local7, Local2)
>                                 ShiftRight (Local2, 0x01, Local2)
>                                 If (LNot (LGreater (Local2, 0xB4)))
>                                 {
>                                     Store (Local2, Local3)
>                                 }
>=20
>                                 If (IOR3)
>                                 {
>                                     Or (Local4, 0x08, Local4)
>                                 }
>=20
>                                 If (UDM3)
>                                 {
>                                     Add (UCT3, 0x01, Local5)
>                                     Multiply (Local5, Local7, Local6)
>                                     ShiftRight (Local6, 0x01, Local3)
>                                     Or (Local4, 0x04, Local4)
>                                 }
>                             }
>                         }
>=20
>                         Store (RMFL, REMP)
>                         Store (Local0, GTM0)
>                         Store (Local1, GTM1)
>                         Store (Local2, GTM2)
>                         Store (Local3, GTM3)
>                         Store (Local4, GTM4)
>                         Return (IDEP)
>                     }
>=20
>                     Method (_STM, 3, NotSerialized)
>                     {
>                         Store (Arg0, IDEP)
>                         Store (GTM0, Local0)
>                         Store (GTM1, Local1)
>                         Store (GTM2, Local2)
>                         Store (GTM3, Local3)
>                         Store (GTM4, Local4)
>                         Store (REMP, RMFL)
>                         Store (0x00, REMP)
>                         If (LAnd (LNot (LEqual (Local1, 0xFFFFFFFF)), LNo=
t (LEqual (Local1, 0x00))))
>                         {
>                             If (And (Local4, 0x01))
>                             {
>                                 Store (0x01, UDM2)
>                                 If (LLess (Local1, 0x14))
>                                 {
>                                     Store (0x01, UM62)
>                                     Store (0x01, UCT2)
>                                 }
>                                 Else
>                                 {
>                                     Store (0x00, UM62)
>                                     Divide (Local1, 0x0A, Local6, Local5)
>                                     Decrement (Local5)
>                                     Store (Local5, UCT2)
>                                     Store (Match (UM5T, MEQ, Local5, MTR,=
 0x00, 0x00), Local5)
>                                     Store (DerefOf (Index (CRCT, Local5))=
, CRC2)
>                                 }
>                             }
>                         }
>=20
>                         If (LAnd (LNot (LEqual (Local0, 0xFFFFFFFF)), LNo=
t (LEqual (Local0, 0x00))))
>                         {
>                             If (UM62)
>                             {
>                                 Store (Match (DerefOf (Index (IO6T, 0x00)=
), MEQ, Local0, MTR, 0x00, 0x00), Local6)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
6T, 0x01)), Local6)), ATT2)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
6T, 0x02)), Local6)), RCT2)
>                             }
>                             Else
>                             {
>                                 Store (Match (DerefOf (Index (IO5T, 0x00)=
), MEQ, Local0, MTR, 0x00, 0x00), Local6)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
5T, 0x01)), Local6)), ATT2)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
5T, 0x02)), Local6)), RCT2)
>                                 Store (DerefOf (Index (INTT, Local6)), IN=
I2)
>                             }
>                         }
>=20
>                         If (LAnd (LNot (LEqual (Local3, 0xFFFFFFFF)), LNo=
t (LEqual (Local3, 0x00))))
>                         {
>                             If (And (Local4, 0x04))
>                             {
>                                 Store (0x01, UDM3)
>                                 If (LLess (Local3, 0x14))
>                                 {
>                                     Store (0x01, UM63)
>                                     Store (0x01, UCT3)
>                                 }
>                                 Else
>                                 {
>                                     Store (0x00, UM63)
>                                     Divide (Local3, 0x0A, Local6, Local5)
>                                     Decrement (Local5)
>                                     Store (Local5, UCT3)
>                                     Store (Match (UM5T, MEQ, Local5, MTR,=
 0x00, 0x00), Local5)
>                                     Store (DerefOf (Index (CRCT, Local5))=
, CRC3)
>                                 }
>                             }
>                         }
>=20
>                         If (LAnd (LNot (LEqual (Local2, 0xFFFFFFFF)), LNo=
t (LEqual (Local2, 0x00))))
>                         {
>                             If (UM63)
>                             {
>                                 Store (Match (DerefOf (Index (IO6T, 0x00)=
), MEQ, Local2, MTR, 0x00, 0x00), Local6)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
6T, 0x01)), Local6)), ATT3)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
6T, 0x02)), Local6)), RCT3)
>                             }
>                             Else
>                             {
>                                 Store (Match (DerefOf (Index (IO5T, 0x00)=
), MEQ, Local2, MTR, 0x00, 0x00), Local6)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
5T, 0x01)), Local6)), ATT3)
>                                 Store (DerefOf (Index (DerefOf (Index (IO=
5T, 0x02)), Local6)), RCT3)
>                                 Store (DerefOf (Index (INTT, Local6)), IN=
I3)
>                             }
>                         }
>=20
>                         Store (RMFL, REMP)
>                     }
>=20
>                     Device (DRV0)
>                     {
>                         Name (_ADR, 0x00)
>                         Method (_GTF, 0, NotSerialized)
>                         {
>                             Store (Buffer (0x07)
>                                 {
>                                     0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0=
xEF
>                                 }, Local6)
>                             Store (Buffer (0x07)
>                                 {
>                                     0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0=
xEF
>                                 }, Local7)
>                             CreateByteField (Local6, 0x01, MODE)
>                             CreateByteField (Local7, 0x01, UMOD)
>                             Store (REMP, RMFL)
>                             Store (0x00, REMP)
>                             If (LNot (LEqual (ATT2, 0x00)))
>                             {
>                                 Add (ATT2, RCT2, Local5)
>                                 If (UM62)
>                                 {
>                                     Store (Match (PIO6, MEQ, Local5, MTR,=
 0x00, 0x00), MODE)
>                                 }
>                                 Else
>                                 {
>                                     Store (Match (PIO5, MEQ, Local5, MTR,=
 0x00, 0x00), MODE)
>                                 }
>=20
>                                 If (UDM2)
>                                 {
>                                     If (UM62)
>                                     {
>                                         Store (Match (UM6T, MEQ, UCT2, MT=
R, 0x00, 0x00), UMOD)
>                                     }
>                                     Else
>                                     {
>                                         Store (Match (UM5T, MEQ, UCT2, MT=
R, 0x00, 0x00), UMOD)
>                                     }
>=20
>                                     Or (UMOD, 0x40, UMOD)
>                                 }
>                                 Else
>                                 {
>                                     Store (DerefOf (Index (DMAT, MODE)), =
UMOD)
>                                     Or (UMOD, 0x20, UMOD)
>                                 }
>=20
>                                 Or (MODE, 0x08, MODE)
>                             }
>=20
>                             Store (RMFL, REMP)
>                             Concatenate (Local6, Local7, Local5)
>                             Return (Local5)
>                         }
>=20
>                         Name (_PSC, 0x00)
>                         Method (_PS0, 0, NotSerialized)
>                         {
>                             Store (0x00, _PSC)
>                         }
>=20
>                         Method (_PS3, 0, NotSerialized)
>                         {
>                             Store (0x03, _PSC)
>                             \_SB.PCI0.LPCB.PHSR (0x09, 0x00)
>                             Sleep (0x01F4)
>                         }
>                     }
>=20
>                     Device (DRV1)
>                     {
>                         Name (_ADR, 0x01)
>                         Method (_GTF, 0, NotSerialized)
>                         {
>                             Store (Buffer (0x07)
>                                 {
>                                     0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0=
xEF
>                                 }, Local6)
>                             Store (Buffer (0x07)
>                                 {
>                                     0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0=
xEF
>                                 }, Local7)
>                             CreateByteField (Local6, 0x01, MODE)
>                             CreateByteField (Local7, 0x01, UMOD)
>                             Store (REMP, RMFL)
>                             Store (0x00, REMP)
>                             If (LNot (LEqual (ATT3, 0x00)))
>                             {
>                                 Add (ATT3, RCT3, Local5)
>                                 If (UM63)
>                                 {
>                                     Store (Match (PIO6, MEQ, Local5, MTR,=
 0x00, 0x00), MODE)
>                                 }
>                                 Else
>                                 {
>                                     Store (Match (PIO5, MEQ, Local5, MTR,=
 0x00, 0x00), MODE)
>                                 }
>=20
>                                 If (UDM3)
>                                 {
>                                     If (UM63)
>                                     {
>                                         Store (Match (UM6T, MEQ, UCT3, MT=
R, 0x00, 0x00), UMOD)
>                                     }
>                                     Else
>                                     {
>                                         Store (Match (UM5T, MEQ, UCT3, MT=
R, 0x00, 0x00), UMOD)
>                                     }
>=20
>                                     Or (UMOD, 0x40, UMOD)
>                                 }
>                                 Else
>                                 {
>                                     Store (DerefOf (Index (DMAT, MODE)), =
UMOD)
>                                     Or (UMOD, 0x20, UMOD)
>                                 }
>=20
>                                 Or (MODE, 0x08, MODE)
>                             }
>=20
>                             Store (RMFL, REMP)
>                             Concatenate (Local6, Local7, Local5)
>                             Return (Local5)
>                         }
>                     }
>                 }
>             }
>=20
>             Device (MDEM)
>             {
>                 Name (_ADR, 0x00020006)
>                 Name (_PRW, Package (0x02)
>                 {
>                     0x05,=20
>                     0x03
>                 })
>             }
>=20
>             Device (AUDI)
>             {
>                 Name (_ADR, 0x00020007)
>             }
>=20
>             Device (USB1)
>             {
>                 Name (_ADR, 0x00030000)
>                 Name (_PRW, Package (0x02)
>                 {
>                     0x0E,=20
>                     0x03
>                 })
>             }
>=20
>             Device (USB2)
>             {
>                 Name (_ADR, 0x00030001)
>                 Name (_PRW, Package (0x02)
>                 {
>                     0x04,=20
>                     0x03
>                 })
>             }
>=20
>             Device (USB3)
>             {
>                 Name (_ADR, 0x00030002)
>                 Name (_PRW, Package (0x02)
>                 {
>                     0x07,=20
>                     0x03
>                 })
>             }
>=20
>             Device (USB4)
>             {
>                 Name (_ADR, 0x00030003)
>             }
>=20
>             Device (LAN)
>             {
>                 Name (_ADR, 0x00040000)
>                 Name (_PRW, Package (0x02)
>                 {
>                     0x0C,=20
>                     0x04
>                 })
>             }
>=20
>             Device (CBUS)
>             {
>                 Name (_ADR, 0x000A0000)
>             }
>         }
>=20
>         Device (PWRB)
>         {
>             Name (_HID, EisaId ("PNP0C0C"))
>         }
>=20
>         Device (LID)
>         {
>             Name (_HID, EisaId ("PNP0C0D"))
>             Name (_PRW, Package (0x02)
>             {
>                 0x17,=20
>                 0x03
>             })
>             Method (_LID, 0, NotSerialized)
>             {
>                 If (\_SB.PCI0.LPCB.LIDS)
>                 {
>                     Store (0x00, \_SB.PCI0.LPCB.LIDP)
>                     Return (0x01)
>                 }
>                 Else
>                 {
>                     Store (0x01, \_SB.PCI0.LPCB.LIDP)
>                     Return (0x00)
>                 }
>             }
>         }
>=20
>         Device (SLPB)
>         {
>             Name (_HID, EisaId ("PNP0C0E"))
>         }
>=20
>         Device (ACAD)
>         {
>             Name (_HID, "ACPI0003")
>             Name (_PCL, Package (0x01)
>             {
>                 \_SB
>             })
>             Name (ACST, 0x00)
>             Method (_PSR, 0, NotSerialized)
>             {
>                 Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
>                 Store (\_SB.PCI0.LPCB.EC0.ACST, Local0)
>                 Release (\_SB.PCI0.LPCB.EC0.MUT1)
>                 If (Local0)
>                 {
>                     Store (0x01, ACST)
>                     If (LEqual (\_TZ.THRM.HOTE, 0x00))
>                     {
>                         \_SB.PCI0.LPCB.THRL (0x00)
>                     }
>=20
>                     Return (0x01)
>                 }
>                 Else
>                 {
>                     Store (0x00, ACST)
>                     \_SB.PCI0.LPCB.THRL (0x01)
>                     Return (0x00)
>                 }
>             }
>         }
>=20
>         Device (BAT1)
>         {
>             Name (_HID, EisaId ("PNP0C0A"))
>             Name (_UID, 0x01)
>             Name (CBTI, 0x00)
>             Name (PBTI, 0x00)
>             Name (BTIN, 0x00)
>             Name (BTCH, 0x00)
>             Name (BIFI, 0x00)
>             Name (PBIF, Package (0x0D)
>             {
>                 0x01,=20
>                 0x1932,=20
>                 0x1932,=20
>                 0x01,=20
>                 0x2B5C,=20
>                 0x012C,=20
>                 0x14,=20
>                 0x20,=20
>                 0x20,=20
>                 "BAT1      ",=20
>                 "          ",=20
>                 "          ",=20
>                 "          "
>             })
>             Name (PBST, Package (0x04)
>             {
>                 0x00,=20
>                 Z00C,=20
>                 Z00C,=20
>                 0x2710
>             })
>             Name (ERRC, 0x00)
>             Name (_PCL, Package (0x01)
>             {
>                 \_SB
>             })
>             Method (_STA, 0, NotSerialized)
>             {
>                 Z00C ()
>                 If (BTIN)
>                 {
>                     Return (0x1F)
>                 }
>                 Else
>                 {
>                     Return (0x0F)
>                 }
>             }
>=20
>             Method (_BIF, 0, NotSerialized)
>             {
>                 If (LEqual (BIFI, 0x00))
>                 {
>                     \_SB.BAT1.UBIF ()
>                     Store (0x01, BIFI)
>                 }
>=20
>                 Return (PBIF)
>             }
>=20
>             Method (UBIF, 0, NotSerialized)
>             {
>                 Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
>                 Store (\_SB.PCI0.LPCB.EC0.BTDC, Local0)
>                 Store (\_SB.PCI0.LPCB.EC0.LFCC, Local1)
>                 Store (\_SB.PCI0.LPCB.EC0.BTDV, Local2)
>                 Store (\_SB.PCI0.LPCB.EC0.BTMD, Local3)
>                 Store (\_SB.PCI0.LPCB.EC0.BTMN, Local4)
>                 Store (\_SB.PCI0.LPCB.EC0.BTSN, Local5)
>                 If (LEqual (Local1, 0x00))
>                 {
>                     Store (0x01, \_SB.PCI0.LPCB.EC0.BATF)
>                 }
>=20
>                 Release (\_SB.PCI0.LPCB.EC0.MUT1)
>                 Store (Local0, Index (PBIF, 0x01))
>                 Store (Local1, Index (PBIF, 0x02))
>                 Store (Local2, Index (PBIF, 0x04))
>                 Store ("LION", Index (PBIF, 0x0B))
>                 If (LEqual (Local3, 0x01))
>                 {
>                     Store ("01DTR", Index (PBIF, 0x09))
>                 }
>                 Else
>                 {
>                     If (LEqual (Local3, 0x02))
>                     {
>                         Store ("02DTR", Index (PBIF, 0x09))
>                     }
>                     Else
>                     {
>                         If (LEqual (Local3, 0x03))
>                         {
>                             Store ("03DTR", Index (PBIF, 0x09))
>                         }
>                         Else
>                         {
>                             If (LEqual (Local3, 0x04))
>                             {
>                                 Store ("04DTR", Index (PBIF, 0x09))
>                             }
>                         }
>                     }
>                 }
>=20
>                 If (LEqual (Local4, 0x01))
>                 {
>                     Store ("MOTOROLA", Index (PBIF, 0x0C))
>                 }
>                 Else
>                 {
>                     If (LEqual (Local4, 0x02))
>                     {
>                         Store ("SIMPLO", Index (PBIF, 0x0C))
>                     }
>                     Else
>                     {
>                         If (LEqual (Local4, 0x03))
>                         {
>                             Store ("SANYO", Index (PBIF, 0x0C))
>                         }
>                         Else
>                         {
>                             If (LEqual (Local4, 0x04))
>                             {
>                                 Store ("SONY", Index (PBIF, 0x0C))
>                             }
>                         }
>                     }
>                 }
>=20
>                 Store (ITOS (ToBCD (Local5)), Index (PBIF, 0x0A))
>             }
>=20
>             Method (_BST, 0, NotSerialized)
>             {
>                 Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
>                 Store (\_SB.PCI0.LPCB.EC0.OBTS, Local0)
>                 Store (\_SB.PCI0.LPCB.EC0.BTRC, Local1)
>                 Store (\_SB.PCI0.LPCB.EC0.BATC, Local2)
>                 Store (\_SB.PCI0.LPCB.EC0.BATV, Local3)
>                 Store (\_SB.PCI0.LPCB.EC0.ACST, Local4)
>                 Release (\_SB.PCI0.LPCB.EC0.MUT1)
>                 Store (CBTI, PBTI)
>                 Store (Local0, CBTI)
>                 Store (Local1, DBPG)
>                 If (LEqual (And (Local0, 0x01), 0x00))
>                 {
>                     Store (0x00, Index (PBST, 0x00))
>                     Store (0xFFFFFFFF, Index (PBST, 0x01))
>                     Store (0xFFFFFFFF, Index (PBST, 0x02))
>                     Store (0xFFFFFFFF, Index (PBST, 0x03))
>                     If (LEqual (BTIN, 0x01))
>                     {
>                         Store (0x01, BTCH)
>                         Store (0x00, BIFI)
>                     }
>=20
>                     Store (0x00, BTIN)
>                     Return (PBST)
>                 }
>                 Else
>                 {
>                     If (LEqual (BTIN, 0x00))
>                     {
>                         Store (0x01, BTCH)
>                         Store (0x00, BIFI)
>                     }
>=20
>                     Store (0x01, BTIN)
>                 }
>=20
>                 Store (0x00, Index (PBST, 0x00))
>                 Store (0x00, Index (PBST, 0x01))
>                 Store (0x00, Index (PBST, 0x02))
>                 Store (0x00, Index (PBST, 0x03))
>                 Store (0xFFFFFFFF, Index (PBST, 0x01))
>                 Store (Local1, Index (PBST, 0x02))
>                 Store (Local3, Index (PBST, 0x03))
>                 Store (0x00, Local5)
>                 If (Local4)
>                 {
>                     If (LEqual (And (Local0, 0x08), 0x00))
>                     {
>                         Store (0x02, Local5)
>                     }
>                 }
>                 Else
>                 {
>                     Store (0x01, Local5)
>                     If (LAnd (Local0, 0x20))
>                     {
>                         Or (0x04, Local5)
>                     }
>                 }
>=20
>                 Store (Local5, Index (PBST, 0x00))
>                 Return (PBST)
>             }
>=20
>             Method (Z00C, 0, NotSerialized)
>             {
>                 If (\_SB.ECEN)
>                 {
>                     Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
>                     Store (\_SB.PCI0.LPCB.EC0.OBTS, Local0)
>                     Store (0x01, \_SB.PCI0.LPCB.EC0.BATF)
>                     Release (\_SB.PCI0.LPCB.EC0.MUT1)
>                     And (Local0, 0x01, Local0)
>                     If (LEqual (Local0, 0x00))
>                     {
>                         If (LEqual (\_SB.BAT1.BTIN, 0x01))
>                         {
>                             Store (0x01, \_SB.BAT1.BTCH)
>                             Store (0x00, BIFI)
>                         }
>=20
>                         Store (0x00, \_SB.BAT1.BTIN)
>                     }
>                     Else
>                     {
>                         If (LEqual (\_SB.BAT1.BTIN, 0x00))
>                         {
>                             Store (0x01, \_SB.BAT1.BTCH)
>                             Store (0x00, BIFI)
>                         }
>=20
>                         Store (0x01, \_SB.BAT1.BTIN)
>                     }
>                 }
>             }
>=20
>             Method (ITOS, 1, NotSerialized)
>             {
>                 Store (Buffer (0x09)
>                     {
>                         0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,=
=20
>                         0x00
>                     }, Local0)
>                 Store (Buffer (0x11)
>                     {
>                         "0123456789ABCDEF"
>                     }, Local7)
>                 Store (0x08, Local1)
>                 Store (0x00, Local2)
>                 Store (0x00, Local3)
>                 While (Local1)
>                 {
>                     Decrement (Local1)
>                     And (ShiftRight (Arg0, ShiftLeft (Local1, 0x02)), 0x0=
F, Local4)
>                     If (Local4)
>                     {
>                         Store (Ones, Local3)
>                     }
>=20
>                     If (Local3)
>                     {
>                         GBFE (Local7, Local4, RefOf (Local5))
>                         PBFE (Local0, Local2, Local5)
>                         Increment (Local2)
>                     }
>                 }
>=20
>                 Return (Local0)
>             }
>=20
>             Method (GBFE, 3, NotSerialized)
>             {
>                 CreateByteField (Arg0, Arg1, TIDX)
>                 Store (TIDX, Arg2)
>             }
>=20
>             Method (PBFE, 3, NotSerialized)
>             {
>                 CreateByteField (Arg0, Arg1, TIDX)
>                 Store (Arg2, TIDX)
>             }
>=20
>             Method (Z00E, 0, NotSerialized)
>             {
>                 If (LNot (ECEN))
>                 {
>                     Return (0x00)
>                 }
>=20
>                 Store (0x0C, Local1)
>                 Store (Buffer (0x0D)
>                     {
>                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,=
=20
>                         0x00, 0x00, 0x00, 0x22, 0x00
>                     }, Local2)
>                 While (LGreater (Local1, 0x08))
>                 {
>                     \_SB.PCI0.LPCB.EC0.GBFE (Local2, Local1, RefOf (Local=
3))
>                     If (Local3)
>                     {
>                         If (LNot (LEqual (\_SB.PCI0.LPCB.EC0.SMRD (0x0B, =
0x16, Local3, RefOf (Local4)), 0xFF)))
>                         {
>                             Store (\_SB.PCI0.LPCB.EC0.BCNT, Local5)
>                             Store (Zero, Local3)
>                             Store (Zero, ERRC)
>                             While (LGreater (Local5, Local3))
>                             {
>                                 \_SB.PCI0.LPCB.EC0.GBFE (Local4, Local3, =
RefOf (Local6))
>                                 Increment (Local3)
>                                 If (And (Local6, 0x80))
>                                 {
>                                     Increment (ERRC)
>                                 }
>                             }
>=20
>                             If (LEqual (ERRC, 0x00))
>                             {
>                                 Store (Local4, Index (PBIF, Local1))
>                                 Store (Ones, Local0)
>                             }
>                         }
>                     }
>                 }
>=20
>                 Decrement (Local1)
> 		Return (0x0)
>             }
>         }
>=20
>         Scope (\_TZ)
>         {
>             ThermalZone (THRM)
>             {
>                 Name (HOTE, 0x00)
>                 Method (_TMP, 0, NotSerialized)
>                 {
>                     If (\_SB.PCI0.LPCB.Z003)
>                     {
>                         Store (0x00, \_SB.PCI0.LPCB.Z003)
>                         \_SB.PCI0.LPCB.PHSR (0x03, 0x00)
>                     }
>=20
>                     \_SB.PCI0.LPCB.PHSR (0x02, 0x00)
>                     Store (\_SB.PCI0.LPCB.Z008, Local0)
>                     If (LNot (LLess (Local0, 0x43)))
>                     {
>                         \_SB.PCI0.LPCB.THRL (0x01)
>                         Store (0x01, HOTE)
>                     }
>=20
>                     If (LAnd (LNot (LGreater (Local0, 0x3D)), LEqual (\_S=
B.ACAD.ACST, 0x01)))
>                     {
>                         \_SB.PCI0.LPCB.THRL (0x00)
>                         Store (0x00, HOTE)
>                     }
>=20
>                     Store (FANR, Local1)
>                     Store (Local1, FANR)
>                     Sleep (0x01F4)
>                     Store (F1CR, Local2)
>                     Store (Local2, F1CR)
>                     Return (Add (Multiply (Local0, 0x0A), 0x0AAC))
>                 }
>=20
>                 Method (_PSV, 0, NotSerialized)
>                 {
>                     Return (Add (Multiply (0x50, 0x0A), 0x0AAC))
>                 }
>=20
>                 Name (_PSL, Package (0x01)
>                 {
>                     \_PR.CPU0
>                 })
>                 Name (_TSP, 0x28)
>                 Name (_TC1, 0x02)
>                 Name (_TC2, 0x03)
>                 Method (_CRT, 0, NotSerialized)
>                 {
>                     If (\_SB.PCI0.LPCB.Z007)
>                     {
>                         Return (Add (Multiply (0x4B, 0x0A), 0x0AAC))
>                     }
>                     Else
>                     {
>                         Return (Add (Multiply (0x50, 0x0A), 0x0AAC))
>                     }
>                 }
>             }
>         }
>     }
>=20
>     Method (_PTS, 1, NotSerialized)
>     {
>         Add (Arg0, 0x50, Local0)
>         Store (Local0, DBPG)
>         If (LEqual (Arg0, 0x01)) {}
>         If (LEqual (Arg0, 0x03))
>         {
>             Store (0x01, \_SB.PCI0.LPCB.Z003)
>         }
>=20
>         If (LEqual (Arg0, 0x04))
>         {
>             \_SB.PCI0.LPCB.PHSR (0x05, 0x00)
>         }
>=20
>         If (LEqual (Arg0, 0x05))
>         {
>             \_SB.PCI0.LPCB.PHSR (0x08, 0x00)
>         }
>=20
>         Store (0x11, DBPG)
>     }
>=20
>     Method (_WAK, 1, NotSerialized)
>     {
>         Store (0x55, DBPG)
>         Store (0x00, \_SB.PCI0.LPCB.ALED)
>         If (LEqual (Arg0, 0x01)) {}
>         If (LEqual (Arg0, 0x03))
>         {
>             Notify (\_SB.PCI0.USB1, 0x00)
>             Notify (\_SB.PCI0.USB2, 0x00)
>             Notify (\_SB.PCI0.USB3, 0x00)
>             Notify (\_SB.PCI0.USB4, 0x00)
>         }
>=20
>         If (LEqual (Arg0, 0x04))
>         {
>             \_SB.PCI0.LPCB.PHSR (0x06, 0x00)
>         }
>=20
>         If (LEqual (Arg0, 0x05))
>         {
>             \_SB.PCI0.LPCB.PHSR (0x06, 0x00)
>         }
> 	Return(Package(2){0, 0})
>     }
>=20
>     Scope (\_GPE)
>     {
>         Method (_L17, 0, NotSerialized)
>         {
>             Notify (\_SB.LID, 0x80)
>         }
>=20
>         Method (_L12, 0, NotSerialized)
>         {
>             \_SB.PCI0.LPCB.PHSR (0x03, 0x00)
>             Notify (\_TZ.THRM, 0x80)
>         }
>=20
>         Method (_L0C, 0, NotSerialized)
>         {
>             Notify (\_SB.PWRB, 0x02)
>         }
>=20
>         Method (_L05, 0, NotSerialized)
>         {
>             Notify (\_SB.PWRB, 0x02)
>         }
>=20
>         Method (_L0E, 0, NotSerialized)
>         {
>             Notify (\_SB.PWRB, 0x02)
>         }
>=20
>         Method (_L07, 0, NotSerialized)
>         {
>             Notify (\_SB.PWRB, 0x02)
>         }
>=20
>         Method (_L04, 0, NotSerialized)
>         {
>             Notify (\_SB.PWRB, 0x02)
>         }
>     }
> }
>=20


--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBR9nsIZtySvzDl4oRAvQDAJ9e9niQmNIMZdwmxLUQ/NKMObfiVgCgqcHg
lxSE7H2d03HffXeoik6B4d0=
=gcT4
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
