From: =?iso-8859-1?q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Subject: 2.6.8 using 2.6.7 dsdt in initrd patch won't load dsdt
Date: Tue, 31 Aug 2004 09:55:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408310955.28391.destynova@esatclear.ie>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A0DNB0F/9bThLt0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_A0DNB0F/9bThLt0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hermes.netfonds.no id i8E74HOn011055

Hi all, sorry to bring more mundanity to the list, but this has been real=
ly=20
annoying me for the last day or two.

I (probably) fixed my DSDT, compiled it successfully, and have tried nume=
rous=20
ways of loading it at boot through an initrd patch (I couldn't find a 2.6=
.8=20
patch, but the 2.6.7 patch I found seemed to apply well enough, without m=
uch=20
fuzzing...).
The machine appears to find it, but it doesn't actually load it.
If anyone knows why not, or if I did something obviously wrong, please le=
t me=20
know.

thanks,
Ois=EDn

here's the relevant output in dmesg - I believe if it had loaded the tabl=
es=20
from the custom DSDT, it would have said so just after the "ACPI: Subsyst=
em=20
revision nnnn" line (and I can tell that it hasn't, as it refers to an er=
ror=20
in the DSDT I had fixed, by changing both references to Z00D to Z00C):

ACPI: Looking for DSDT in initrd ... found (at offset 26218)!
 found customized DSDT with 16040 bytes!
Freeing initrd memory: 41k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9c6, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs at=20
0000000000008020 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 5 Wake, Enabled 0 Runtim=
e=20
GPEs in this block
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs at=20
0000000000008030 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 1 Wake, Enabled 1 Runtim=
e=20
GPEs in this block
Completing Region/Field/Buffer/Package=20
initialization:.................................................. =20
psargs-0352: *** Error: Looking up [Z00D] in namespace, AE_NOT_FOUND
search_node dfda3228 start_node dfda3228 return_node 00000000
 psparse-1133: *** Error: [NULL NAME], AE_NOT_FOUND

  nsinit-0301 [07] ns_init_one_object    : Could not execute arguments fo=
r=20
[PBST] (Package), AE_NOT_FOUND
.........
Initialized 11/11 Regions 5/5 Fields 20/20 Buffers 23/29 Packages (514 no=
des)
Executing all Device _STA and_INI=20
methods:......................................................
54 Devices found containing: 54 _STA, 2 _INI methods
ACPI: Interpreter enabled

--Boundary-00=_A0DNB0F/9bThLt0
Content-Type: text/x-dsl;
  charset="iso-8859-1";
  name="dsdt.dsl"
Content-Disposition: attachment;
	filename="dsdt.dsl"
Content-Transfer-Encoding: 7bit

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of dsdt, Mon Aug 30 08:05:46 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "PTLTD ", "650M", 100925440)
{
    OperationRegion (P80G, SystemIO, 0x80, 0x01)
    Field (P80G, ByteAcc, NoLock, Preserve)
    {
        DBPG,   8
    }

    OperationRegion (FANC, SystemIO, 0x0500, 0xFF)
    Field (FANC, ByteAcc, NoLock, Preserve)
    {
        Offset (0x56), 
        FANR,   8, 
        Offset (0x58), 
        F1CR,   8
    }

    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06) {}
    }

    Name (_S0, Package (0x02)
    {
        0x00, 
        0x00
    })
    Name (_S3, Package (0x02)
    {
        0x03, 
        0x03
    })
    Name (_S4, Package (0x02)
    {
        0x04, 
        0x04
    })
    Name (_S5, Package (0x02)
    {
        0x05, 
        0x05
    })
    Name (PICF, 0x00)
    Method (_PIC, 1, NotSerialized)
    {
        Store (Arg0, PICF)
    }

    Scope (\_SB)
    {
        Name (OSTB, Ones)
        Name (FWSO, "FWSO")
        Name (ECEN, 0x00)
        Name (ACST, 0x01)
        Device (PCI0)
        {
            Method (_PRT, 0, NotSerialized)
            {
                If (LNot (\PICF))
                {
                    Return (PICM)
                }
                Else
                {
                    Return (APIC)
                }
            }

            Name (PICM, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0002FFFF, 
                    0x01, 
                    \_SB.PCI0.LPCB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x02, 
                    \_SB.PCI0.LPCB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x00, 
                    \_SB.PCI0.LPCB.LNKE, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x01, 
                    \_SB.PCI0.LPCB.LNKF, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x02, 
                    \_SB.PCI0.LPCB.LNKG, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x03, 
                    \_SB.PCI0.LPCB.LNKH, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x00, 
                    \_SB.PCI0.LPCB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    \_SB.PCI0.LPCB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    \_SB.PCI0.LPCB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x01, 
                    \_SB.PCI0.LPCB.LNKD, 
                    0x00
                }
            })
            Name (APIC, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0002FFFF, 
                    0x01, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x00, 
                    0x00, 
                    0x14
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x01, 
                    0x00, 
                    0x15
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x02, 
                    0x00, 
                    0x16
                }, 

                Package (0x04)
                {
                    0x0003FFFF, 
                    0x03, 
                    0x00, 
                    0x17
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x00, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x01, 
                    0x00, 
                    0x13
                }
            })
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            Name (_UID, 0x00)
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }

            Method (_INI, 0, NotSerialized)
            {
            }

            OperationRegion (MA, PCI_Config, 0x00, 0xFF)
            Field (MA, ByteAcc, NoLock, Preserve)
            {
                Offset (0x70), 
                SHC0,   1, 
                SHC4,   1, 
                SHC8,   1, 
                SHCC,   1, 
                SHD0,   1, 
                SHD4,   1, 
                SHD8,   1, 
                SHDC,   1, 
                SHE0,   1, 
                SHE4,   1, 
                SHE8,   1, 
                SHEC,   1, 
                Offset (0xAE), 
                MAL,    8, 
                MAH,    8
            }

            Name (CRES, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100, 0x00)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0000,
                    0x0CF7,
                    0x0000,
                    0x0CF8, 0x00)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x04000000,
                    0xFFEDFFFF,
                    0x00000000,
                    0x00000000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000C0000,
                    0x000C3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000C4000,
                    0x000C7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000C8000,
                    0x000CBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000CC000,
                    0x000CFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000D0000,
                    0x000D3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000D4000,
                    0x000D7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000D8000,
                    0x000DBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000DC000,
                    0x000DFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000E0000,
                    0x000E3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000E4000,
                    0x000E7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000E8000,
                    0x000EBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000EC000,
                    0x000EFFFF,
                    0x00000000,
                    0x00004000, 0x00)
            })
            Method (_CRS, 0, NotSerialized)
            {
                CreateBitField (CRES, 0x03B0, C0RW)
                CreateDWordField (CRES, 0x87, C0LN)
                Store (One, C0RW)
                Store (0x4000, C0LN)
                If (SHC0)
                {
                    Store (0x00, C0LN)
                }

                CreateBitField (CRES, 0x0488, C4RW)
                CreateDWordField (CRES, 0xA2, C4LN)
                Store (One, C4RW)
                Store (0x4000, C4LN)
                If (SHC4)
                {
                    Store (0x00, C4LN)
                }

                CreateBitField (CRES, 0x0560, C8RW)
                CreateDWordField (CRES, 0xBD, C8LN)
                Store (One, C8RW)
                Store (0x4000, C8LN)
                If (SHC8)
                {
                    Store (0x00, C8LN)
                }

                CreateBitField (CRES, 0x0638, CCRW)
                CreateDWordField (CRES, 0xD8, CCLN)
                Store (One, CCRW)
                Store (0x4000, CCLN)
                If (SHCC)
                {
                    Store (0x00, CCLN)
                }

                CreateBitField (CRES, 0x0710, D0RW)
                CreateDWordField (CRES, 0xF3, D0LN)
                Store (One, D0RW)
                Store (0x4000, D0LN)
                If (SHD0)
                {
                    Store (0x00, D0LN)
                }

                CreateBitField (CRES, 0x07E8, D4RW)
                CreateDWordField (CRES, 0x010E, D4LN)
                Store (One, D4RW)
                Store (0x4000, D4LN)
                If (SHD4)
                {
                    Store (0x00, D4LN)
                }

                CreateBitField (CRES, 0x08C0, D8RW)
                CreateDWordField (CRES, 0x0129, D8LN)
                Store (One, D8RW)
                Store (0x4000, D8LN)
                If (SHD8)
                {
                    Store (0x00, D8LN)
                }

                CreateBitField (CRES, 0x0998, DCRW)
                CreateDWordField (CRES, 0x0144, DCLN)
                Store (One, DCRW)
                Store (0x4000, DCLN)
                If (SHDC)
                {
                    Store (0x00, DCLN)
                }

                CreateBitField (CRES, 0x0A70, E0RW)
                CreateDWordField (CRES, 0x015F, E0LN)
                Store (One, E0RW)
                Store (0x4000, E0LN)
                If (SHE0)
                {
                    Store (0x00, E0LN)
                }

                CreateBitField (CRES, 0x0B48, E4RW)
                CreateDWordField (CRES, 0x017A, E4LN)
                Store (One, E4RW)
                Store (0x4000, E4LN)
                If (SHE4)
                {
                    Store (0x00, E4LN)
                }

                CreateBitField (CRES, 0x0C20, E8RW)
                CreateDWordField (CRES, 0x0195, E8LN)
                Store (One, E8RW)
                Store (0x4000, E8LN)
                If (SHE8)
                {
                    Store (0x00, E8LN)
                }

                CreateBitField (CRES, 0x0CF8, ECRW)
                CreateDWordField (CRES, 0x01B0, ECLN)
                Store (One, ECRW)
                Store (0x4000, ECLN)
                If (SHEC)
                {
                    Store (0x00, ECLN)
                }

                CreateDWordField (CRES, 0x60, RAMT)
                CreateDWordField (CRES, 0x6C, RAMR)
                ShiftLeft (\_SB.PCI0.MAH, 0x1C, Local0)
                ShiftLeft (\_SB.PCI0.MAL, 0x14, Local1)
                Add (Local1, Local0, Local2)
                Store (Local2, RAMT)
                Subtract (0xFFEE0000, RAMT, RAMR)
                Return (CRES)
            }

            Device (AGPB)
            {
                Name (_ADR, 0x00010000)
                Method (_PRT, 0, NotSerialized)
                {
                    If (LNot (\PICF))
                    {
                        Return (AGPP)
                    }
                    Else
                    {
                        Return (AGPA)
                    }
                }

                Name (AGPP, Package (0x02)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.PCI0.LPCB.LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        \_SB.PCI0.LPCB.LNKC, 
                        0x00
                    }
                })
                Name (AGPA, Package (0x02)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x12
                    }
                })
                Device (VGA)
                {
                    Name (_ADR, 0x00)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPCB.Z000)
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }

                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS1, 0, NotSerialized)
                    {
                        Store (0x01, _PSC)
                    }

                    Method (_PS2, 0, NotSerialized)
                    {
                        Store (0x02, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Name (DISW, 0x01)
                    Name (NDSP, 0x00)
                    Name (VRSM, 0x00)
                    Name (PDSP, 0x00)
                    Name (CDSP, 0x00)
                    Name (TGLT, Package (0x04)
                    {
                        Package (0x08)
                        {
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }, 

                        Package (0x08)
                        {
                            0x01, 
                            0x02, 
                            0x03, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }, 

                        Package (0x08)
                        {
                            0x01, 
                            0x05, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }, 

                        Package (0x08)
                        {
                            0x01, 
                            0x02, 
                            0x03, 
                            0x05, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }
                    })
                    Name (TGLP, 0x00)
                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Name (_PSC, 0x00)
                        Name (_S3D, 0x03)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Name (_DGS, 0x00)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("LCD._DSS(1) called", Debug)
                                Or (NDSP, 0x01, NDSP)
                            }
                            Else
                            {
                                Store ("LCD._DSS(0) called", Debug)
                                And (NDSP, 0xFE, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("LCD._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And (NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And (NDSP, 0x04), 0x01), ^^TV._DCS)
                                UDGS ()
                            }
                        }
                    }

                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Name (_DGS, 0x00)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("CRT._DSS(1) called", Debug)
                                Or (NDSP, 0x02, NDSP)
                            }
                            Else
                            {
                                Store ("CRT._DSS(0) called", Debug)
                                And (NDSP, 0xFD, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("CRT._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And (NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And (NDSP, 0x04), 0x01), ^^TV._DCS)
                                UDGS ()
                            }
                        }
                    }

                    Device (TV)
                    {
                        Name (_ADR, 0x0200)
                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Name (_DGS, 0x00)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("TV_._DSS(1) called", Debug)
                                Or (NDSP, 0x04, NDSP)
                            }
                            Else
                            {
                                Store ("TV_._DSS(0) called", Debug)
                                And (NDSP, 0xFB, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("TV_._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And (NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And (NDSP, 0x04), 0x01), ^^TV._DCS)
                                UDGS ()
                            }
                        }
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        USTA ()
                        Store (CDSP, PDSP)
                        Store (CDSP, Local1)
                        Or (ShiftRight (And (Local1, 0x10), 0x03), 0x1D, ^LCD._DCS)
                        Or (Or (ShiftLeft (And (Local1, 0x02), 0x03), ShiftRight (And (Local1, 0x20), 0x04)), 0x0D, ^CRT._DCS)
                        Or (Or (ShiftLeft (And (Local1, 0x04), 0x02), ShiftRight (And (Local1, 0x40), 0x05)), 0x0D, ^TV._DCS)
                        ShiftRight (Local1, 0x04, NDSP)
                        Store (ShiftRight (And (^LCD._DCS, 0x02), 0x01), ^LCD._DGS)
                        Store (ShiftRight (And (^CRT._DCS, 0x02), 0x01), ^CRT._DGS)
                        Store (ShiftRight (And (^TV._DCS, 0x02), 0x01), ^TV._DGS)
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (Arg0, DISW)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x03)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x00010200
                        })
                    }

                    Method (DRUL, 1, NotSerialized)
                    {
                        USTA ()
                        If (LNot (LEqual (And (PDSP, 0x07), And (CDSP, 0x07))))
                        {
                            UDGS ()
                            Store (CDSP, PDSP)
                        }

                        Store (CDSP, Local2)
                        Store (^CRT._DCS, Local1)
                        Or (Or (ShiftLeft (And (Local2, 0x02), 0x03), ShiftRight (And (Local2, 0x20), 0x04)), And (Local1, 0x0D), ^CRT._DCS)
                        Store (^TV._DCS, Local3)
                        Or (Or (ShiftLeft (And (Local2, 0x04), 0x02), ShiftRight (And (Local2, 0x40), 0x05)), And (Local3, 0x0D), ^TV._DCS)
                        If (LEqual (Arg0, 0x01))
                        {
                            If (LOr (LAnd (^CRT._DGS, LNot (And (^CRT._DCS, 0x10))), LAnd (^TV._DGS, LNot (And (^TV._DCS, 0x10)))))
                            {
                                UDGS ()
                                Return (0x00)
                            }
                            Else
                            {
                                Notify (VGA, 0x80)
                                Return (0x00)
                            }
                        }
		    	Return (0x00)
                    }

                    Method (USTA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.LPCB.Z000, 0x00))
                        {
                            Store (\_SB.PCI0.LPCB.PHSR (0x00, 0x00), CDSP)
                        }
                        Else
                        {
                            Store (0x11, CDSP)
                        }

                        And (CDSP, 0x0F, Local1)
                        If (LEqual (Local1, 0x03))
                        {
                            Store (0x01, TGLP)
                        }
                        Else
                        {
                            If (LEqual (Local1, 0x05))
                            {
                                Store (0x02, TGLP)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x07))
                                {
                                    Store (0x03, TGLP)
                                }
                                Else
                                {
                                    Store (0x00, TGLP)
                                }
                            }
                        }
                    }

                    Method (UDGS, 0, NotSerialized)
                    {
                        And (^LCD._DGS, 0x01, Local0)
                        Or (Local0, ShiftLeft (And (^CRT._DGS, 0x01), 0x01), Local0)
                        Or (Local0, ShiftLeft (And (^TV._DGS, 0x01), 0x02), Local0)
                        Store (DerefOf (Index (DerefOf (Index (TGLT, TGLP)), Local0)), Local1)
                        And (Local1, 0x01, ^LCD._DGS)
                        ShiftRight (And (Local1, 0x02), 0x01, ^CRT._DGS)
                        ShiftRight (And (Local1, 0x04), 0x02, ^TV._DGS)
                    }
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x00020000)
                OperationRegion (PCFG, PCI_Config, 0x00, 0x80)
                Field (PCFG, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x41), 
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    Offset (0x60), 
                    PIRE,   8, 
                    PIRF,   8, 
                    PIRG,   8, 
                    PIRH,   8, 
                    Offset (0x74), 
                    Z001,   16
                }

                OperationRegion (SOW, SystemIO, 0x8000, 0x90)
                Field (SOW, WordAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                        ,   1, 
                    TDCC,   3, 
                    TFEN,   1, 
                    Offset (0x1A), 
                        ,   1, 
                    RLSL,   1, 
                    Offset (0x20), 
                        ,   2, 
                    SLP,    1, 
                    WK,     1, 
                    Offset (0x2B), 
                        ,   5, 
                    SSL,    1, 
                    SWK,    1, 
                    Z002,   1, 
                    Offset (0x3E), 
                        ,   7, 
                    LIDP,   1, 
                    Offset (0x49), 
                    LGMS,   1, 
                    Offset (0x62), 
                        ,   6, 
                    ALED,   2, 
                    Offset (0x64), 
                        ,   7, 
                    LIDS,   1, 
                        ,   3, 
                    BLIT,   1
                }

                OperationRegion (SMB, SystemIO, 0x8100, 0x20)
                Field (SMB, AnyAcc, NoLock, Preserve)
                {
                    BSTS,   8, 
                    BEN,    8, 
                    BCNT,   8, 
                    HCNT,   8, 
                    BADR,   8, 
                    BCOD,   8, 
                    BCOU,   8, 
                    SBY0,   8, 
                    SBY1,   8, 
                    SBY2,   8, 
                    SBY3,   8, 
                    SBY4,   8, 
                    SBY5,   8, 
                    SBY6,   8, 
                    SBY7,   8, 
                    DADR,   8, 
                    SBD0,   8, 
                    SBD1,   8, 
                    BSAA,   8
                }

                Method (THRL, 1, NotSerialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        \_SB.PCI0.LPCB.PHSR (0x07, 0x00)
                    }
                    Else
                    {
                        \_SB.PCI0.LPCB.PHSR (0x07, 0x01)
                    }
                }

                OperationRegion (SMI0, SystemIO, 0x0000FE00, 0x00000002)
                Field (SMI0, AnyAcc, NoLock, Preserve)
                {
                    SMIC,   8
                }

                OperationRegion (SMI1, SystemMemory, 0x1FDFBE2D, 0x00000120)
                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    BCMD,   8, 
                    DID,    32, 
                    INFO,   2008
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    DMY,    40, 
                    INF,    8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x110), 
                    Z000,   1, 
                    Z003,   1, 
                    Z004,   1, 
                    Z005,   1, 
                    Z006,   1, 
                    Z007,   1, 
                    Offset (0x111), 
                    Z008,   8
                }

                Mutex (PSMX, 0x00)
                Method (PHSR, 2, NotSerialized)
                {
                    Acquire (\_SB.PCI0.LPCB.PSMX, 0xFFFF)
                    Store (0x90, BCMD)
                    Store (Arg0, DID)
                    Store (Arg1, INFO)
                    Store (Zero, SMIC)
                    Store (INF, Local0)
                    Release (\_SB.PCI0.LPCB.PSMX)
                    Return (Local0)
                }

                Name (Z009, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {5}
                })
                Name (Z00A, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {3}
                })
                Name (Z00B, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {7,10}
                })
                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z00B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRA, 0x80, \_SB.PCI0.LPCB.PIRA)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z00B, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRA, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRA, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRA, 0x70), \_SB.PCI0.LPCB.PIRA)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRA, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z00A)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRB, 0x80, \_SB.PCI0.LPCB.PIRB)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z00A, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRB, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRB, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRB, 0x70), \_SB.PCI0.LPCB.PIRB)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRB, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z009)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRC, 0x80, \_SB.PCI0.LPCB.PIRC)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z009, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRC, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRC, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRC, 0x70), \_SB.PCI0.LPCB.PIRC)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRC, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z00B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRD, 0x80, \_SB.PCI0.LPCB.PIRD)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z00B, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRD, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRD, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRD, 0x70), \_SB.PCI0.LPCB.PIRD)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRD, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z00B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRE, 0x80, \_SB.PCI0.LPCB.PIRE)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z00B, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRE, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRE, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRE, 0x70), \_SB.PCI0.LPCB.PIRE)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRE, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z00B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRF, 0x80, \_SB.PCI0.LPCB.PIRF)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z00B, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRF, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRF, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRF, 0x70), \_SB.PCI0.LPCB.PIRF)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRF, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z00B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRG, 0x80, \_SB.PCI0.LPCB.PIRG)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z00B, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRG, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRG, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRG, 0x70), \_SB.PCI0.LPCB.PIRG)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRG, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (Z00B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (\_SB.PCI0.LPCB.PIRH, 0x80, \_SB.PCI0.LPCB.PIRH)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z00B, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRH, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRH, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        FindSetRightBit (IRA0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (\_SB.PCI0.LPCB.PIRH, 0x70), \_SB.PCI0.LPCB.PIRH)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (\_SB.PCI0.LPCB.PIRH, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (SIO)
                {
                    Name (_HID, EisaId ("PNP0A05"))
                    Mutex (S192, 0x00)
                    OperationRegion (SMC1, SystemIO, 0x2E, 0x02)
                    Field (SMC1, ByteAcc, Lock, Preserve)
                    {
                        INDX,   8, 
                        DATA,   8
                    }

                    IndexField (INDX, DATA, AnyAcc, NoLock, Preserve)
                    {
                        AccessAs (ByteAcc, 0x00), 
                        Offset (0x02), 
                        CFG,    8, 
                        Offset (0x07), 
                        LDN,    8, 
                        Offset (0x22), 
                        PWC,    8, 
                        LPWC,   8, 
                        Offset (0x30), 
                        ACTR,   1, 
                        Offset (0x60), 
                        IOAH,   8, 
                        IOAL,   8, 
                        Offset (0x70), 
                        INTR,   8, 
                        Offset (0x74), 
                        DMCH,   8, 
                        Offset (0xF0), 
                        OPT1,   8, 
                        OPT2,   8, 
                        OPT3,   8
                    }

                    IndexField (INDX, DATA, AnyAcc, NoLock, WriteAsOnes)
                    {
                        Offset (0xF0), 
                        LPTM,   3
                    }

                    Method (ENFG, 1, NotSerialized)
                    {
                        Acquire (S192, 0xFFFF)
                        Store (0x55, INDX)
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                    }

                    Method (EXFG, 0, NotSerialized)
                    {
                        Store (0xAA, INDX)
                        Release (S192)
                    }

                    Device (COM1)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            ENFG (0x04)
                            If (\_SB.PCI0.LPCB.Z004)
                            {
                                If (ACTR)
                                {
                                    Store (0x0F, Local1)
                                }
                                Else
                                {
                                    Store (0x0D, Local1)
                                }
                            }
                            Else
                            {
                                Store (0x00, Local1)
                            }

                            EXFG ()
                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (0x04)
                            Store (Zero, ACTR)
                            Store (Zero, INTR)
                            Store (Zero, IOAL)
                            Store (Zero, IOAH)
                            EXFG ()
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (RSRC, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {}
                            })
                            CreateByteField (RSRC, 0x02, IO1)
                            CreateByteField (RSRC, 0x03, IO2)
                            CreateByteField (RSRC, 0x04, IO3)
                            CreateByteField (RSRC, 0x05, IO4)
                            CreateWordField (RSRC, 0x09, IRQV)
                            ENFG (0x04)
                            If (ACTR)
                            {
                                Store (IOAL, IO1)
                                Store (IOAH, IO2)
                                Store (IOAL, IO3)
                                Store (IOAH, IO4)
                                Store (0x01, Local0)
                                ShiftLeft (Local0, INTR, IRQV)
                            }

                            EXFG ()
                            Return (RSRC)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            }
                            EndDependentFn ()
                        })
                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, IO1)
                            CreateByteField (Arg0, 0x03, IO2)
                            CreateWordField (Arg0, 0x09, IRQV)
                            ENFG (0x04)
                            Store (IO1, IOAL)
                            Store (IO2, IOAH)
                            FindSetRightBit (IRQV, Local0)
                            Subtract (Local0, 0x01, INTR)
                            Store (0x01, ACTR)
                            EXFG ()
                        }
                    }

                    Device (FDC)
                    {
                        Name (_HID, EisaId ("PNP0700"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            ENFG (0x00)
                            If (ACTR)
                            {
                                Store (0x0F, Local1)
                            }
                            Else
                            {
                                Store (0x0D, Local1)
                            }

                            EXFG ()
                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (0x00)
                            Store (0x00, ACTR)
                            Store (Zero, INTR)
                            Store (Zero, IOAH)
                            Store (Zero, IOAL)
                            Store (Zero, DMCH)
                            EXFG ()
                        }

                        Name (RSRC, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        })
                        Method (_CRS, 0, NotSerialized)
                        {
                            CreateWordField (RSRC, 0x02, IO1L)
                            CreateWordField (RSRC, 0x04, IO1H)
                            CreateWordField (RSRC, 0x0A, IO2L)
                            CreateWordField (RSRC, 0x0C, IO2H)
                            CreateWordField (RSRC, 0x11, IRQX)
                            CreateByteField (RSRC, 0x14, DMAX)
                            Store (Zero, IO1L)
                            Store (Zero, IO1H)
                            Store (Zero, IO2L)
                            Store (Zero, IO2H)
                            Store (Zero, IRQX)
                            Store (Zero, DMAX)
                            ENFG (0x00)
                            Store (ACTR, Local0)
                            EXFG ()
                            If (Local0)
                            {
                                Store (_PRS, RSRC)
                            }

                            Return (RSRC)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        })
                        Method (_SRS, 1, NotSerialized)
                        {
                            Store (Arg0, RSRC)
                            CreateWordField (RSRC, 0x02, IOX)
                            CreateWordField (RSRC, 0x11, IRQX)
                            CreateByteField (RSRC, 0x14, DMAX)
                            ENFG (0x00)
                            And (IOX, 0xFF, IOAL)
                            ShiftRight (IOX, 0x08, IOAH)
                            FindSetRightBit (IRQX, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, INTR)
                            FindSetRightBit (DMAX, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, DMCH)
                            Store (0x01, ACTR)
                            EXFG ()
                        }
                    }

                    Device (ECP)
                    {
                        Method (_HID, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.LPCB.Z006)
                            {
                                Return (0x0104D041)
                            }
                            Else
                            {
                                Return (0x0004D041)
                            }
                        }

                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (\_SB.PCI0.LPCB.Z005, 0x01))
                            {
                                ENFG (0x03)
                                If (ACTR)
                                {
                                    Store (0x0F, Local1)
                                }
                                Else
                                {
                                    Store (0x0D, Local1)
                                }

                                EXFG ()
                            }
                            Else
                            {
                                Store (0x00, Local1)
                            }

                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (0x03)
                            Store (0x00, ACTR)
                            Store (0x00, IOAL)
                            Store (0x00, IOAH)
                            Store (0x00, INTR)
                            Store (0x00, DMCH)
                            EXFG ()
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            ENFG (0x03)
                            Name (CRSD, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {}
                            })
                            CreateByteField (CRSD, 0x02, IOD1)
                            CreateByteField (CRSD, 0x03, IOD2)
                            CreateByteField (CRSD, 0x04, IOD3)
                            CreateByteField (CRSD, 0x05, IOD4)
                            CreateByteField (CRSD, 0x06, ALD1)
                            CreateByteField (CRSD, 0x07, LND1)
                            CreateWordField (CRSD, 0x09, IRQD)
                            Name (CRSB, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfer16) {}
                            })
                            CreateByteField (CRSB, 0x02, IOB1)
                            CreateByteField (CRSB, 0x03, IOB2)
                            CreateByteField (CRSB, 0x04, IOB3)
                            CreateByteField (CRSB, 0x05, IOB4)
                            CreateByteField (CRSB, 0x06, ALB1)
                            CreateByteField (CRSB, 0x07, LNB1)
                            CreateByteField (CRSB, 0x0A, IOB5)
                            CreateByteField (CRSB, 0x0B, IOB6)
                            CreateByteField (CRSB, 0x0C, IOB7)
                            CreateByteField (CRSB, 0x0D, IOB8)
                            CreateByteField (CRSB, 0x0E, ALB2)
                            CreateByteField (CRSB, 0x0F, LNB2)
                            CreateWordField (CRSB, 0x11, IRQB)
                            CreateWordField (CRSB, 0x14, DMAV)
                            If (ACTR)
                            {
                                If (\_SB.PCI0.LPCB.Z006)
                                {
                                    Store (IOAL, IOB1)
                                    Store (IOAH, IOB2)
                                    Store (IOAL, IOB3)
                                    Store (IOAH, IOB4)
                                    Store (IOAL, IOB5)
                                    Add (IOAH, 0x04, IOB6)
                                    Store (IOAL, IOB7)
                                    Add (IOAH, 0x04, IOB8)
                                    If (LEqual (IOAL, 0xBC))
                                    {
                                        Store (0x08, ALB1)
                                        Store (0x03, LNB1)
                                        Store (0x08, ALB2)
                                        Store (0x03, LNB2)
                                    }

                                    Store (INTR, Local1)
                                    If (Local1)
                                    {
                                        ShiftLeft (One, Local1, IRQB)
                                    }

                                    Store (0x01, Local0)
                                    ShiftLeft (Local0, DMCH, DMAV)
                                }
                                Else
                                {
                                    Store (IOAL, IOD1)
                                    Store (IOAH, IOD2)
                                    Store (IOAL, IOD3)
                                    Store (IOAH, IOD4)
                                    If (LEqual (IOAL, 0xBC))
                                    {
                                        Store (0x08, ALD1)
                                        Store (0x03, LND1)
                                    }

                                    Store (INTR, Local1)
                                    If (Local1)
                                    {
                                        ShiftLeft (One, Local1, IRQD)
                                    }
                                }
                            }

                            EXFG ()
                            If (\_SB.PCI0.LPCB.Z006)
                            {
                                Return (CRSB)
                            }
                            Else
                            {
                                Return (CRSD)
                            }
                        }

                        Name (PRSD, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                            }
                            EndDependentFn ()
                        })
                        Name (PRSB, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer16) {1,3}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.LPCB.Z006)
                            {
                                Return (PRSB)
                            }
                            Else
                            {
                                Return (PRSD)
                            }
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            ENFG (0x03)
                            If (\_SB.PCI0.LPCB.Z006)
                            {
                                CreateByteField (Arg0, 0x02, IOB1)
                                CreateByteField (Arg0, 0x03, IOB2)
                                CreateByteField (Arg0, 0x04, IOB3)
                                CreateByteField (Arg0, 0x05, IOB4)
                                CreateByteField (Arg0, 0x06, ALB1)
                                CreateByteField (Arg0, 0x07, LNB1)
                                CreateByteField (Arg0, 0x0A, IOB5)
                                CreateByteField (Arg0, 0x0B, IOB6)
                                CreateByteField (Arg0, 0x0C, IOB7)
                                CreateByteField (Arg0, 0x0D, IOB8)
                                CreateByteField (Arg0, 0x0E, ALB2)
                                CreateByteField (Arg0, 0x0F, LNB2)
                                CreateWordField (Arg0, 0x11, IRQB)
                                CreateWordField (Arg0, 0x14, DMAV)
                                Store (IOB1, IOAL)
                                Store (IOB2, IOAH)
                                FindSetRightBit (IRQB, Local0)
                                If (Local0)
                                {
                                    Decrement (Local0)
                                }

                                Store (Local0, INTR)
                                FindSetRightBit (DMAV, Local0)
                                If (Local0)
                                {
                                    Decrement (Local0)
                                }

                                Store (Local0, DMCH)
                            }
                            Else
                            {
                                CreateByteField (Arg0, 0x02, IOD1)
                                CreateByteField (Arg0, 0x03, IOD2)
                                CreateByteField (Arg0, 0x04, IOD3)
                                CreateByteField (Arg0, 0x05, IOD4)
                                CreateByteField (Arg0, 0x06, ALD1)
                                CreateByteField (Arg0, 0x07, LND1)
                                CreateWordField (Arg0, 0x09, IRQD)
                                Store (IOD1, IOAL)
                                Store (IOD2, IOAH)
                                FindSetRightBit (IRQD, Local0)
                                If (Local0)
                                {
                                    Decrement (Local0)
                                }

                                Store (Local0, INTR)
                            }

                            Store (0x01, ACTR)
                            EXFG ()
                        }
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        IO (Decode16, 0x0480, 0x0480, 0x01, 0x10)
                        DMA (Compatibility, NotBusMaster, Transfer16) {4}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IRQ (Edge, ActiveHigh, Exclusive) {2}
                    })
                }

                Device (TIME)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQNoFlags () {0}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x02)
                        IRQNoFlags () {8}
                    })
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                    })
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x1000, 0x1000, 0x01, 0x90)
                        IO (Decode16, 0x8090, 0x8090, 0x01, 0x70)
                        IO (Decode16, 0x8100, 0x8100, 0x01, 0x20)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0xFE00, 0xFE00, 0x01, 0x01)
                        IO (Decode16, 0x002E, 0x002E, 0x01, 0x01)
                        IO (Decode16, 0x002F, 0x002F, 0x01, 0x01)
                        Memory32Fixed (ReadOnly, 0xFEC00000, 0x00100000)
                        Memory32Fixed (ReadOnly, 0xFEE00000, 0x00100000)
                        Memory32Fixed (ReadOnly, 0xFFC00000, 0x00001000)
                        Memory32Fixed (ReadOnly, 0xFFE00000, 0x00001000)
                        Memory32Fixed (ReadOnly, 0xFFE80000, 0x00080000)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x01C0, 0x01C0, 0x01, 0x10)
                        IO (Decode16, 0x0500, 0x0500, 0x01, 0x80)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x02, PMMN)
                        CreateWordField (RSRC, 0x04, PMMX)
                        And (\_SB.PCI0.LPCB.Z001, 0xFF80, PMMN)
                        Store (PMMN, PMMX)
                        Return (RSRC)
                    }
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0B)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x10)
                        IRQNoFlags () {13}
                    })
                }

                Device (KBC)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_UID, 0x01)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQNoFlags () {1}
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (_UID, 0x00)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive) {12}
                    })
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x19)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, Local0)
                            If (Local0)
                            {
                                Store (0x01, ECEN)
                            }
                            Else
                            {
                                Store (0x00, ECEN)
                            }
                        }
                    }

                    Mutex (MUT0, 0x00)
                    Mutex (MUT1, 0x00)
                    OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x60), 
                        SMPR,   8, 
                        SMST,   8, 
                        SMAD,   8, 
                        SMCM,   8, 
                        SMD0,   256, 
                        BCNT,   8, 
                        SMAA,   8, 
                        BATD,   16, 
                        Offset (0x91), 
                            ,   4, 
                        ACST,   1, 
                        Offset (0x9C), 
                        THRL,   8, 
                        BTMD,   8, 
                        BTCS,   8, 
                        BTMN,   8, 
                        BTSN,   16, 
                        BTDV,   16, 
                        BTDC,   16, 
                        LFCC,   16, 
                        BATV,   16, 
                        BATC,   16, 
                        BATT,   16, 
                        BTRC,   16, 
                        BTST,   16, 
                        OBTS,   7, 
                        BATF,   1
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        SMW0,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        SMB0,   8
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        FLD0,   64
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        FLD1,   128
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        FLD2,   192
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        FLD3,   256
                    }

                    Method (SMRD, 4, NotSerialized)
                    {
                        If (LNot (\_SB.ECEN))
                        {
                            Return (0xFF)
                        }

                        If (LNot (LEqual (Arg0, 0x07)))
                        {
                            If (LNot (LEqual (Arg0, 0x09)))
                            {
                                If (LNot (LEqual (Arg0, 0x0B)))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            Store (0x00, Local3)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                                Increment (Local3)
                                If (LEqual (Local3, 0x32))
                                {
                                    And (SMST, 0x40, SMST)
                                    Store (Arg2, SMCM)
                                    Store (Arg1, SMAD)
                                    Store (Arg0, SMPR)
                                    Store (0x00, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x07))
                            {
                                Store (SMB0, Arg3)
                            }

                            If (LEqual (Arg0, 0x09))
                            {
                                Store (SMW0, Arg3)
                            }

                            If (LEqual (Arg0, 0x0B))
                            {
                                Store (BCNT, Local3)
                                ShiftRight (0x0100, 0x03, Local2)
                                If (LGreater (Local3, Local2))
                                {
                                    Store (Local2, Local3)
                                }

                                If (LLess (Local3, 0x09))
                                {
                                    Store (FLD0, Local2)
                                }
                                Else
                                {
                                    If (LLess (Local3, 0x11))
                                    {
                                        Store (FLD1, Local2)
                                    }
                                    Else
                                    {
                                        If (LLess (Local3, 0x19))
                                        {
                                            Store (FLD2, Local2)
                                        }
                                        Else
                                        {
                                            Store (FLD3, Local2)
                                        }
                                    }
                                }

                                Increment (Local3)
                                Store (Buffer (Local3) {}, Local4)
                                Decrement (Local3)
                                Store (Zero, Local5)
                                While (LGreater (Local3, Local5))
                                {
                                    GBFE (Local2, Local5, RefOf (Local6))
                                    PBFE (Local4, Local5, Local6)
                                    Increment (Local5)
                                }

                                PBFE (Local4, Local5, 0x00)
                                Store (Local4, Arg3)
                            }
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (SMWR, 4, NotSerialized)
                    {
                        If (LNot (\_SB.ECEN))
                        {
                            Return (0xFF)
                        }

                        If (LNot (LEqual (Arg0, 0x06)))
                        {
                            If (LNot (LEqual (Arg0, 0x08)))
                            {
                                If (LNot (LEqual (Arg0, 0x0A)))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            If (LEqual (Arg0, 0x06))
                            {
                                Store (Arg3, SMB0)
                            }

                            If (LEqual (Arg0, 0x08))
                            {
                                Store (Arg3, SMW0)
                            }

                            If (LEqual (Arg0, 0x0A))
                            {
                                Store (Arg3, SMD0)
                            }

                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            Store (0x00, Local3)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                                Increment (Local3)
                                If (LEqual (Local3, 0x32))
                                {
                                    And (SMST, 0x40, SMST)
                                    Store (Arg2, SMCM)
                                    Store (Arg1, SMAD)
                                    Store (Arg0, SMPR)
                                    Store (0x00, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (GBFE, 3, NotSerialized)
                    {
                        CreateByteField (Arg0, Arg1, TIDX)
                        Store (TIDX, Arg2)
                    }

                    Method (PBFE, 3, NotSerialized)
                    {
                        CreateByteField (Arg0, Arg1, TIDX)
                        Store (Arg2, TIDX)
                    }

                    Method (_Q0D, 0, NotSerialized)
                    {
                        Notify (\_SB.SLPB, 0x80)
                    }

                    Method (_Q0E, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPCB.Z000)
                        {
                            \_SB.PCI0.LPCB.PHSR (0x01, 0x00)
                        }
                        Else
                        {
                            \_SB.PCI0.AGPB.VGA.DRUL (0x01)
                        }
                    }

                    Method (_Q0F, 0, NotSerialized)
                    {
                        XOr (\_SB.PCI0.LPCB.BLIT, 0x01, \_SB.PCI0.LPCB.BLIT)
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        Notify (\_SB.ACAD, 0x80)
                        Sleep (0x01F4)
                        \_SB.BAT1.Z00C ()
                        Notify (\_SB.BAT1, 0x80)
                        If (\_SB.BAT1.BTCH)
                        {
                            \_SB.BAT1.UBIF ()
                            Notify (\_SB.BAT1, 0x81)
                            Store (0x00, \_SB.BAT1.BTCH)
                        }
                    }
                }
            }

            Device (IEEE)
            {
                Name (_ADR, 0x00020003)
            }

            Device (IDE)
            {
                Name (_ADR, 0x00020005)
                Name (IO5T, Package (0x03)
                {
                    Package (0x07)
                    {
                        0x78, 
                        0xB4, 
                        0x014A, 
                        0x0186, 
                        0x0258, 
                        0x78, 
                        0x96
                    }, 

                    Package (0x07)
                    {
                        0x06, 
                        0x07, 
                        0x1C, 
                        0x1C, 
                        0x1C, 
                        0x06, 
                        0x07
                    }, 

                    Package (0x07)
                    {
                        0x04, 
                        0x09, 
                        0x03, 
                        0x09, 
                        0x1E, 
                        0x04, 
                        0x06
                    }
                })
                Name (IO6T, Package (0x03)
                {
                    Package (0x07)
                    {
                        0x78, 
                        0xB4, 
                        0x014A, 
                        0x0186, 
                        0x0258, 
                        0x78, 
                        0xB4
                    }, 

                    Package (0x07)
                    {
                        0x09, 
                        0x0A, 
                        0x26, 
                        0x26, 
                        0x26, 
                        0x09, 
                        0x0A
                    }, 

                    Package (0x07)
                    {
                        0x05, 
                        0x0C, 
                        0x04, 
                        0x0C, 
                        0x28, 
                        0x05, 
                        0x0C
                    }
                })
                Name (UM5T, Package (0x06)
                {
                    0x0B, 
                    0x07, 
                    0x05, 
                    0x04, 
                    0x02, 
                    0x01
                })
                Name (UM6T, Package (0x07)
                {
                    0x0F, 
                    0x0A, 
                    0x07, 
                    0x05, 
                    0x03, 
                    0x02, 
                    0x01
                })
                Name (PIO5, Package (0x05)
                {
                    0x3A, 
                    0x25, 
                    0x1F, 
                    0x10, 
                    0x0A
                })
                Name (PIO6, Package (0x05)
                {
                    0x4E, 
                    0x32, 
                    0x2A, 
                    0x16, 
                    0x0E
                })
                Name (CRCT, Package (0x07)
                {
                    0x06, 
                    0x04, 
                    0x03, 
                    0x01, 
                    0x01, 
                    0x01, 
                    0x01
                })
                Name (INTT, Package (0x05)
                {
                    0x02, 
                    0x02, 
                    0x02, 
                    0x04, 
                    0x06
                })
                Name (DMAT, Package (0x05)
                {
                    0x00, 
                    0x01, 
                    0x01, 
                    0x01, 
                    0x02
                })
                Name (RMFL, 0x01)
                OperationRegion (CF40, PCI_Config, 0x40, 0x18)
                Field (CF40, WordAcc, NoLock, Preserve)
                {
                        ,   1, 
                    IOR0,   1, 
                    UDM0,   1, 
                    UM60,   1, 
                    UCT0,   4, 
                    CRC0,   4, 
                    INI0,   4, 
                    ATT0,   6, 
                    Offset (0x03), 
                    RCT0,   6, 
                    Offset (0x04), 
                        ,   1, 
                    IOR1,   1, 
                    UDM1,   1, 
                    UM61,   1, 
                    UCT1,   4, 
                    CRC1,   4, 
                    INI1,   4, 
                    ATT1,   6, 
                    Offset (0x07), 
                    RCT1,   6, 
                    Offset (0x08), 
                        ,   1, 
                    IOR2,   1, 
                    UDM2,   1, 
                    UM62,   1, 
                    UCT2,   4, 
                    CRC2,   4, 
                    INI2,   4, 
                    ATT2,   6, 
                    Offset (0x0B), 
                    RCT2,   6, 
                    Offset (0x0C), 
                        ,   1, 
                    IOR3,   1, 
                    UDM3,   1, 
                    UM63,   1, 
                    UCT3,   4, 
                    CRC3,   4, 
                    INI3,   4, 
                    ATT3,   6, 
                    Offset (0x0F), 
                    RCT3,   6, 
                    Offset (0x10), 
                        ,   1, 
                    CHE0,   1, 
                    Offset (0x12), 
                        ,   1, 
                    CHE1,   1, 
                    Offset (0x14), 
                        ,   30, 
                    REMP,   1, 
                    Offset (0x18)
                }

                Name (IDEP, Buffer (0x14) {})
                CreateDWordField (IDEP, 0x00, GTM0)
                CreateDWordField (IDEP, 0x04, GTM1)
                CreateDWordField (IDEP, 0x08, GTM2)
                CreateDWordField (IDEP, 0x0C, GTM3)
                CreateDWordField (IDEP, 0x10, GTM4)
                Device (IDE0)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (0xFFFFFFFF, Local0)
                        Store (0xFFFFFFFF, Local1)
                        Store (0xFFFFFFFF, Local2)
                        Store (0xFFFFFFFF, Local3)
                        Store (0x10, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (CHE0)
                        {
                            If (LNot (LEqual (ATT0, 0x00)))
                            {
                                Add (RCT0, 0x01, Local5)
                                Add (ATT0, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM60, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local0)
                                ShiftRight (Local0, 0x01, Local0)
                                If (LNot (LGreater (Local0, 0xB4)))
                                {
                                    Store (Local0, Local1)
                                }

                                If (IOR0)
                                {
                                    Or (Local4, 0x02, Local4)
                                }

                                If (UDM0)
                                {
                                    Add (UCT0, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local1)
                                    Or (Local4, 0x01, Local4)
                                }
                            }

                            If (LNot (LEqual (ATT1, 0x00)))
                            {
                                Add (RCT1, 0x01, Local5)
                                Add (ATT1, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM61, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local2)
                                ShiftRight (Local2, 0x01, Local2)
                                If (LNot (LGreater (Local2, 0xB4)))
                                {
                                    Store (Local2, Local3)
                                }

                                If (IOR1)
                                {
                                    Or (Local4, 0x08, Local4)
                                }

                                If (UDM1)
                                {
                                    Add (UCT1, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local3)
                                    Or (Local4, 0x04, Local4)
                                }
                            }
                        }

                        Store (RMFL, REMP)
                        Store (Local0, GTM0)
                        Store (Local1, GTM1)
                        Store (Local2, GTM2)
                        Store (Local3, GTM3)
                        Store (Local4, GTM4)
                        Return (IDEP)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, IDEP)
                        Store (GTM0, Local0)
                        Store (GTM1, Local1)
                        Store (GTM2, Local2)
                        Store (GTM3, Local3)
                        Store (GTM4, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (LAnd (LNot (LEqual (Local1, 0xFFFFFFFF)), LNot (LEqual (Local1, 0x00))))
                        {
                            If (And (Local4, 0x01))
                            {
                                Store (0x01, UDM0)
                                If (LLess (Local1, 0x14))
                                {
                                    Store (0x01, UM60)
                                    Store (0x01, UCT0)
                                }
                                Else
                                {
                                    Store (0x00, UM60)
                                    Divide (Local1, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT0)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC0)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local0, 0xFFFFFFFF)), LNot (LEqual (Local0, 0x00))))
                        {
                            If (UM60)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT0)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT0)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT0)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT0)
                                Store (DerefOf (Index (INTT, Local6)), INI0)
                            }
                        }

                        If (LAnd (LNot (LEqual (Local3, 0xFFFFFFFF)), LNot (LEqual (Local3, 0x00))))
                        {
                            If (And (Local4, 0x04))
                            {
                                Store (0x01, UDM1)
                                If (LLess (Local3, 0x14))
                                {
                                    Store (0x01, UM61)
                                    Store (0x01, UCT1)
                                }
                                Else
                                {
                                    Store (0x00, UM61)
                                    Divide (Local3, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT1)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC1)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local2, 0xFFFFFFFF)), LNot (LEqual (Local2, 0x00))))
                        {
                            If (UM61)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT1)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT1)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT1)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT1)
                                Store (DerefOf (Index (INTT, Local6)), INI1)
                            }
                        }

                        Store (RMFL, REMP)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT0, 0x00)))
                            {
                                Add (ATT0, RCT0, Local5)
                                If (UM60)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM0)
                                {
                                    If (UM60)
                                    {
                                        Store (Match (UM6T, MEQ, UCT0, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT0, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT1, 0x00)))
                            {
                                Add (ATT1, RCT1, Local5)
                                If (UM61)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM1)
                                {
                                    If (UM61)
                                    {
                                        Store (Match (UM6T, MEQ, UCT1, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT1, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }
                }

                Device (IDE1)
                {
                    Name (_ADR, 0x01)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (0xFFFFFFFF, Local0)
                        Store (0xFFFFFFFF, Local1)
                        Store (0xFFFFFFFF, Local2)
                        Store (0xFFFFFFFF, Local3)
                        Store (0x10, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (CHE1)
                        {
                            If (LNot (LEqual (ATT2, 0x00)))
                            {
                                Add (RCT2, 0x01, Local5)
                                Add (ATT2, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM62, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local0)
                                ShiftRight (Local0, 0x01, Local0)
                                If (LNot (LGreater (Local0, 0xB4)))
                                {
                                    Store (Local0, Local1)
                                }

                                If (IOR2)
                                {
                                    Or (Local4, 0x02, Local4)
                                }

                                If (UDM2)
                                {
                                    Add (UCT2, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local1)
                                    Or (Local4, 0x01, Local4)
                                }
                            }

                            If (LNot (LEqual (ATT3, 0x00)))
                            {
                                Add (RCT3, 0x01, Local5)
                                Add (ATT3, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM63, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local2)
                                ShiftRight (Local2, 0x01, Local2)
                                If (LNot (LGreater (Local2, 0xB4)))
                                {
                                    Store (Local2, Local3)
                                }

                                If (IOR3)
                                {
                                    Or (Local4, 0x08, Local4)
                                }

                                If (UDM3)
                                {
                                    Add (UCT3, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local3)
                                    Or (Local4, 0x04, Local4)
                                }
                            }
                        }

                        Store (RMFL, REMP)
                        Store (Local0, GTM0)
                        Store (Local1, GTM1)
                        Store (Local2, GTM2)
                        Store (Local3, GTM3)
                        Store (Local4, GTM4)
                        Return (IDEP)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, IDEP)
                        Store (GTM0, Local0)
                        Store (GTM1, Local1)
                        Store (GTM2, Local2)
                        Store (GTM3, Local3)
                        Store (GTM4, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (LAnd (LNot (LEqual (Local1, 0xFFFFFFFF)), LNot (LEqual (Local1, 0x00))))
                        {
                            If (And (Local4, 0x01))
                            {
                                Store (0x01, UDM2)
                                If (LLess (Local1, 0x14))
                                {
                                    Store (0x01, UM62)
                                    Store (0x01, UCT2)
                                }
                                Else
                                {
                                    Store (0x00, UM62)
                                    Divide (Local1, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT2)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC2)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local0, 0xFFFFFFFF)), LNot (LEqual (Local0, 0x00))))
                        {
                            If (UM62)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT2)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT2)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT2)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT2)
                                Store (DerefOf (Index (INTT, Local6)), INI2)
                            }
                        }

                        If (LAnd (LNot (LEqual (Local3, 0xFFFFFFFF)), LNot (LEqual (Local3, 0x00))))
                        {
                            If (And (Local4, 0x04))
                            {
                                Store (0x01, UDM3)
                                If (LLess (Local3, 0x14))
                                {
                                    Store (0x01, UM63)
                                    Store (0x01, UCT3)
                                }
                                Else
                                {
                                    Store (0x00, UM63)
                                    Divide (Local3, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT3)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC3)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local2, 0xFFFFFFFF)), LNot (LEqual (Local2, 0x00))))
                        {
                            If (UM63)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT3)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT3)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT3)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT3)
                                Store (DerefOf (Index (INTT, Local6)), INI3)
                            }
                        }

                        Store (RMFL, REMP)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT2, 0x00)))
                            {
                                Add (ATT2, RCT2, Local5)
                                If (UM62)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM2)
                                {
                                    If (UM62)
                                    {
                                        Store (Match (UM6T, MEQ, UCT2, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT2, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }

                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                            \_SB.PCI0.LPCB.PHSR (0x09, 0x00)
                            Sleep (0x01F4)
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT3, 0x00)))
                            {
                                Add (ATT3, RCT3, Local5)
                                If (UM63)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM3)
                                {
                                    If (UM63)
                                    {
                                        Store (Match (UM6T, MEQ, UCT3, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT3, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }
                }
            }

            Device (MDEM)
            {
                Name (_ADR, 0x00020006)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x03
                })
            }

            Device (AUDI)
            {
                Name (_ADR, 0x00020007)
            }

            Device (USB1)
            {
                Name (_ADR, 0x00030000)
                Name (_PRW, Package (0x02)
                {
                    0x0E, 
                    0x03
                })
            }

            Device (USB2)
            {
                Name (_ADR, 0x00030001)
                Name (_PRW, Package (0x02)
                {
                    0x04, 
                    0x03
                })
            }

            Device (USB3)
            {
                Name (_ADR, 0x00030002)
                Name (_PRW, Package (0x02)
                {
                    0x07, 
                    0x03
                })
            }

            Device (USB4)
            {
                Name (_ADR, 0x00030003)
            }

            Device (LAN)
            {
                Name (_ADR, 0x00040000)
                Name (_PRW, Package (0x02)
                {
                    0x0C, 
                    0x04
                })
            }

            Device (CBUS)
            {
                Name (_ADR, 0x000A0000)
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (_PRW, Package (0x02)
            {
                0x17, 
                0x03
            })
            Method (_LID, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPCB.LIDS)
                {
                    Store (0x00, \_SB.PCI0.LPCB.LIDP)
                    Return (0x01)
                }
                Else
                {
                    Store (0x01, \_SB.PCI0.LPCB.LIDP)
                    Return (0x00)
                }
            }
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
        }

        Device (ACAD)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (ACST, 0x00)
            Method (_PSR, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.LPCB.EC0.ACST, Local0)
                Release (\_SB.PCI0.LPCB.EC0.MUT1)
                If (Local0)
                {
                    Store (0x01, ACST)
                    If (LEqual (\_TZ.THRM.HOTE, 0x00))
                    {
                        \_SB.PCI0.LPCB.THRL (0x00)
                    }

                    Return (0x01)
                }
                Else
                {
                    Store (0x00, ACST)
                    \_SB.PCI0.LPCB.THRL (0x01)
                    Return (0x00)
                }
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Name (CBTI, 0x00)
            Name (PBTI, 0x00)
            Name (BTIN, 0x00)
            Name (BTCH, 0x00)
            Name (BIFI, 0x00)
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0x1932, 
                0x1932, 
                0x01, 
                0x2B5C, 
                0x012C, 
                0x14, 
                0x20, 
                0x20, 
                "BAT1      ", 
                "          ", 
                "          ", 
                "          "
            })
            Name (PBST, Package (0x04)
            {
                0x00, 
                Z00C, 
                Z00C, 
                0x2710
            })
            Name (ERRC, 0x00)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Method (_STA, 0, NotSerialized)
            {
                Z00C ()
                If (BTIN)
                {
                    Return (0x1F)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (LEqual (BIFI, 0x00))
                {
                    \_SB.BAT1.UBIF ()
                    Store (0x01, BIFI)
                }

                Return (PBIF)
            }

            Method (UBIF, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.LPCB.EC0.BTDC, Local0)
                Store (\_SB.PCI0.LPCB.EC0.LFCC, Local1)
                Store (\_SB.PCI0.LPCB.EC0.BTDV, Local2)
                Store (\_SB.PCI0.LPCB.EC0.BTMD, Local3)
                Store (\_SB.PCI0.LPCB.EC0.BTMN, Local4)
                Store (\_SB.PCI0.LPCB.EC0.BTSN, Local5)
                If (LEqual (Local1, 0x00))
                {
                    Store (0x01, \_SB.PCI0.LPCB.EC0.BATF)
                }

                Release (\_SB.PCI0.LPCB.EC0.MUT1)
                Store (Local0, Index (PBIF, 0x01))
                Store (Local1, Index (PBIF, 0x02))
                Store (Local2, Index (PBIF, 0x04))
                Store ("LION", Index (PBIF, 0x0B))
                If (LEqual (Local3, 0x01))
                {
                    Store ("01DTR", Index (PBIF, 0x09))
                }
                Else
                {
                    If (LEqual (Local3, 0x02))
                    {
                        Store ("02DTR", Index (PBIF, 0x09))
                    }
                    Else
                    {
                        If (LEqual (Local3, 0x03))
                        {
                            Store ("03DTR", Index (PBIF, 0x09))
                        }
                        Else
                        {
                            If (LEqual (Local3, 0x04))
                            {
                                Store ("04DTR", Index (PBIF, 0x09))
                            }
                        }
                    }
                }

                If (LEqual (Local4, 0x01))
                {
                    Store ("MOTOROLA", Index (PBIF, 0x0C))
                }
                Else
                {
                    If (LEqual (Local4, 0x02))
                    {
                        Store ("SIMPLO", Index (PBIF, 0x0C))
                    }
                    Else
                    {
                        If (LEqual (Local4, 0x03))
                        {
                            Store ("SANYO", Index (PBIF, 0x0C))
                        }
                        Else
                        {
                            If (LEqual (Local4, 0x04))
                            {
                                Store ("SONY", Index (PBIF, 0x0C))
                            }
                        }
                    }
                }

                Store (ITOS (ToBCD (Local5)), Index (PBIF, 0x0A))
            }

            Method (_BST, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.LPCB.EC0.OBTS, Local0)
                Store (\_SB.PCI0.LPCB.EC0.BTRC, Local1)
                Store (\_SB.PCI0.LPCB.EC0.BATC, Local2)
                Store (\_SB.PCI0.LPCB.EC0.BATV, Local3)
                Store (\_SB.PCI0.LPCB.EC0.ACST, Local4)
                Release (\_SB.PCI0.LPCB.EC0.MUT1)
                Store (CBTI, PBTI)
                Store (Local0, CBTI)
                Store (Local1, DBPG)
                If (LEqual (And (Local0, 0x01), 0x00))
                {
                    Store (0x00, Index (PBST, 0x00))
                    Store (0xFFFFFFFF, Index (PBST, 0x01))
                    Store (0xFFFFFFFF, Index (PBST, 0x02))
                    Store (0xFFFFFFFF, Index (PBST, 0x03))
                    If (LEqual (BTIN, 0x01))
                    {
                        Store (0x01, BTCH)
                        Store (0x00, BIFI)
                    }

                    Store (0x00, BTIN)
                    Return (PBST)
                }
                Else
                {
                    If (LEqual (BTIN, 0x00))
                    {
                        Store (0x01, BTCH)
                        Store (0x00, BIFI)
                    }

                    Store (0x01, BTIN)
                }

                Store (0x00, Index (PBST, 0x00))
                Store (0x00, Index (PBST, 0x01))
                Store (0x00, Index (PBST, 0x02))
                Store (0x00, Index (PBST, 0x03))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (Local1, Index (PBST, 0x02))
                Store (Local3, Index (PBST, 0x03))
                Store (0x00, Local5)
                If (Local4)
                {
                    If (LEqual (And (Local0, 0x08), 0x00))
                    {
                        Store (0x02, Local5)
                    }
                }
                Else
                {
                    Store (0x01, Local5)
                    If (LAnd (Local0, 0x20))
                    {
                        Or (0x04, Local5)
                    }
                }

                Store (Local5, Index (PBST, 0x00))
                Return (PBST)
            }

            Method (Z00C, 0, NotSerialized)
            {
                If (\_SB.ECEN)
                {
                    Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPCB.EC0.OBTS, Local0)
                    Store (0x01, \_SB.PCI0.LPCB.EC0.BATF)
                    Release (\_SB.PCI0.LPCB.EC0.MUT1)
                    And (Local0, 0x01, Local0)
                    If (LEqual (Local0, 0x00))
                    {
                        If (LEqual (\_SB.BAT1.BTIN, 0x01))
                        {
                            Store (0x01, \_SB.BAT1.BTCH)
                            Store (0x00, BIFI)
                        }

                        Store (0x00, \_SB.BAT1.BTIN)
                    }
                    Else
                    {
                        If (LEqual (\_SB.BAT1.BTIN, 0x00))
                        {
                            Store (0x01, \_SB.BAT1.BTCH)
                            Store (0x00, BIFI)
                        }

                        Store (0x01, \_SB.BAT1.BTIN)
                    }
                }
            }

            Method (ITOS, 1, NotSerialized)
            {
                Store (Buffer (0x09)
                    {
                        0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                        0x00
                    }, Local0)
                Store (Buffer (0x11)
                    {
                        "0123456789ABCDEF"
                    }, Local7)
                Store (0x08, Local1)
                Store (0x00, Local2)
                Store (0x00, Local3)
                While (Local1)
                {
                    Decrement (Local1)
                    And (ShiftRight (Arg0, ShiftLeft (Local1, 0x02)), 0x0F, Local4)
                    If (Local4)
                    {
                        Store (Ones, Local3)
                    }

                    If (Local3)
                    {
                        GBFE (Local7, Local4, RefOf (Local5))
                        PBFE (Local0, Local2, Local5)
                        Increment (Local2)
                    }
                }

                Return (Local0)
            }

            Method (GBFE, 3, NotSerialized)
            {
                CreateByteField (Arg0, Arg1, TIDX)
                Store (TIDX, Arg2)
            }

            Method (PBFE, 3, NotSerialized)
            {
                CreateByteField (Arg0, Arg1, TIDX)
                Store (Arg2, TIDX)
            }

            Method (Z00E, 0, NotSerialized)
            {
                If (LNot (ECEN))
                {
                    Return (0x00)
                }

                Store (0x0C, Local1)
                Store (Buffer (0x0D)
                    {
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                        0x00, 0x00, 0x00, 0x22, 0x00
                    }, Local2)
                While (LGreater (Local1, 0x08))
                {
                    \_SB.PCI0.LPCB.EC0.GBFE (Local2, Local1, RefOf (Local3))
                    If (Local3)
                    {
                        If (LNot (LEqual (\_SB.PCI0.LPCB.EC0.SMRD (0x0B, 0x16, Local3, RefOf (Local4)), 0xFF)))
                        {
                            Store (\_SB.PCI0.LPCB.EC0.BCNT, Local5)
                            Store (Zero, Local3)
                            Store (Zero, ERRC)
                            While (LGreater (Local5, Local3))
                            {
                                \_SB.PCI0.LPCB.EC0.GBFE (Local4, Local3, RefOf (Local6))
                                Increment (Local3)
                                If (And (Local6, 0x80))
                                {
                                    Increment (ERRC)
                                }
                            }

                            If (LEqual (ERRC, 0x00))
                            {
                                Store (Local4, Index (PBIF, Local1))
                                Store (Ones, Local0)
                            }
                        }
                    }
                }

                Decrement (Local1)
		Return (0x0)
            }
        }

        Scope (\_TZ)
        {
            ThermalZone (THRM)
            {
                Name (HOTE, 0x00)
                Method (_TMP, 0, NotSerialized)
                {
                    If (\_SB.PCI0.LPCB.Z003)
                    {
                        Store (0x00, \_SB.PCI0.LPCB.Z003)
                        \_SB.PCI0.LPCB.PHSR (0x03, 0x00)
                    }

                    \_SB.PCI0.LPCB.PHSR (0x02, 0x00)
                    Store (\_SB.PCI0.LPCB.Z008, Local0)
                    If (LNot (LLess (Local0, 0x43)))
                    {
                        \_SB.PCI0.LPCB.THRL (0x01)
                        Store (0x01, HOTE)
                    }

                    If (LAnd (LNot (LGreater (Local0, 0x3D)), LEqual (\_SB.ACAD.ACST, 0x01)))
                    {
                        \_SB.PCI0.LPCB.THRL (0x00)
                        Store (0x00, HOTE)
                    }

                    Store (FANR, Local1)
                    Store (Local1, FANR)
                    Sleep (0x01F4)
                    Store (F1CR, Local2)
                    Store (Local2, F1CR)
                    Return (Add (Multiply (Local0, 0x0A), 0x0AAC))
                }

                Method (_PSV, 0, NotSerialized)
                {
                    Return (Add (Multiply (0x50, 0x0A), 0x0AAC))
                }

                Name (_PSL, Package (0x01)
                {
                    \_PR.CPU0
                })
                Name (_TSP, 0x28)
                Name (_TC1, 0x02)
                Name (_TC2, 0x03)
                Method (_CRT, 0, NotSerialized)
                {
                    If (\_SB.PCI0.LPCB.Z007)
                    {
                        Return (Add (Multiply (0x4B, 0x0A), 0x0AAC))
                    }
                    Else
                    {
                        Return (Add (Multiply (0x50, 0x0A), 0x0AAC))
                    }
                }
            }
        }
    }

    Method (_PTS, 1, NotSerialized)
    {
        Add (Arg0, 0x50, Local0)
        Store (Local0, DBPG)
        If (LEqual (Arg0, 0x01)) {}
        If (LEqual (Arg0, 0x03))
        {
            Store (0x01, \_SB.PCI0.LPCB.Z003)
        }

        If (LEqual (Arg0, 0x04))
        {
            \_SB.PCI0.LPCB.PHSR (0x05, 0x00)
        }

        If (LEqual (Arg0, 0x05))
        {
            \_SB.PCI0.LPCB.PHSR (0x08, 0x00)
        }

        Store (0x11, DBPG)
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (0x55, DBPG)
        Store (0x00, \_SB.PCI0.LPCB.ALED)
        If (LEqual (Arg0, 0x01)) {}
        If (LEqual (Arg0, 0x03))
        {
            Notify (\_SB.PCI0.USB1, 0x00)
            Notify (\_SB.PCI0.USB2, 0x00)
            Notify (\_SB.PCI0.USB3, 0x00)
            Notify (\_SB.PCI0.USB4, 0x00)
        }

        If (LEqual (Arg0, 0x04))
        {
            \_SB.PCI0.LPCB.PHSR (0x06, 0x00)
        }

        If (LEqual (Arg0, 0x05))
        {
            \_SB.PCI0.LPCB.PHSR (0x06, 0x00)
        }
	Return(Package(2){0, 0})
    }

    Scope (\_GPE)
    {
        Method (_L17, 0, NotSerialized)
        {
            Notify (\_SB.LID, 0x80)
        }

        Method (_L12, 0, NotSerialized)
        {
            \_SB.PCI0.LPCB.PHSR (0x03, 0x00)
            Notify (\_TZ.THRM, 0x80)
        }

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L0E, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L07, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L04, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }
    }
}


--Boundary-00=_A0DNB0F/9bThLt0--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
