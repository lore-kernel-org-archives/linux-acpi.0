From: =?iso-8859-1?Q?S=E9bastien_Bernard?= <sbernard-T/o0Z7lmwKpeoWH0uzbU5w@public.gmane.org>
Subject: n800v : fixing the DSDT for the F18F rom
Date: Fri, 5 Mar 2004 15:21:26 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <54063.213.223.188.125.1078496486.squirrel@webmail.nerim.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040305152126_44785"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

------=_20040305152126_44785
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi.
I'm trying to fix the DSDT from the new ROM compaq posted to its site.
(Yes I did upgrade, my mistake)
I was able to dissassemble the beast but when recompiling I got a bunch o=
f
errors I am unable to understand.

They all looks like :
4992:             Subtract (C1D4, 0x0AAC, Local1)
Error    1022 -              Object does not exist ^  (C1D4)
This error is not yet described in the FAQ.
Obviously, something is missing. But I can't see what. I found some
message telling just to add an external reference. But are those missing
symbols really external reference as _OSI are.

I include as attachments the DSDT already modified to reduce the number o=
f
errors (aka remove the '*' from the strings) and the output of the iasl
compiler.






------=_20040305152126_44785
Content-Type: text/x-dsl; name="evo-n800v.dsdt.dsl"
Content-Disposition: attachment; filename="evo-n800v.dsdt.dsl"
Content-Transfer-Encoding: quoted-printable

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030509
 *
 * Disassembly of evo-n800v.dsdt.dump, Fri Mar  5 14:48:31 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "COMPAQ", "EVON800", 65536)
{
    Processor (\_PR.C000, 0x01, 0x00001010, 0x06)
    {
        Method (_CST, 0, NotSerialized)
        {
            If (LEqual (\_SB.C001, 0x00))
            {
                Return (C002)
            }
            Else
            {
                Return (C003)
            }
        }
    }

    Name (C002, Package (0x04)
    {
        0x03,=20
        Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 0x00, 0x00, 0x0000000000000000)
            },=20

            0x01,=20
            0x01,=20
            0x03E8
        },=20

        Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 0x08, 0x00, 0x0000000000001014)
            },=20

            0x02,=20
            0x02,=20
            0x01F4
        },=20

        Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 0x08, 0x00, 0x0000000000001015)
            },=20

            0x03,=20
            0xB9,=20
            0xFA
        }
    })
    Name (\C004, Package (0x10)
    {
        "0",=20
        "1",=20
        "2",=20
        "3",=20
        "4",=20
        "5",=20
        "6",=20
        "7",=20
        "8",=20
        "9",=20
        "A",=20
        "B",=20
        "C",=20
        "D",=20
        "E",=20
        "F"
    })
    Method (\C005, 2, NotSerialized)
    {
        Store (Arg0, Local0)
        Store ("", Local7)
        Store (Arg1, Local4)
        While (LGreater (Local4, 0x00))
        {
            And (Local0, 0x0F, Local1)
            Store (DerefOf (Index (\C004, Local1)), Local2)
            Concatenate (Local2, Local7, Local3)
            Store (Local3, Local7)
            ShiftRight (Local0, 0x04, Local0)
            Decrement (Local4)
        }

        Return (Local7)
    }

    Method (\C006, 2, NotSerialized)
    {
        Store (SizeOf (Arg0), Local7)
        If (LNot (LEqual (Local7, SizeOf (Arg1))))
        {
            Return (0x00)
        }

        Name (C007, Buffer (Local7) {})
        Name (C008, Buffer (Local7) {})
        Store (Arg0, C007)
        Store (Arg1, C008)
        Store (0x00, Local6)
        Store (0x01, Local0)
        While (LAnd (LNot (LEqual (Local6, Local7)), Local0))
        {
            Store (DerefOf (Index (C007, Local6)), Local2)
            Store (DerefOf (Index (C008, Local6)), Local3)
            Increment (Local6)
            If (LNot (LEqual (Local2, Local3)))
            {
                Store (0x00, Local0)
            }
        }

        Return (Local0)
    }

    Name (C009, 0xFFFFFFFD)
    Name (C00A, Package (0x03)
    {
        "Microsoft Windows",=20
        "Microsoft WindowsME: Millennium Edition",=20
        "Microsoft Windows NT"
    })
    Method (C00B, 0, Serialized)
    {
        If (LEqual (C009, 0xFFFFFFFD))
        {
            Store (\_OS, Local0)
            Store (SizeOf (C00A), Local7)
            Store (0x00, Local1)
            While (LAnd (LLess (Local1, Local7), LEqual (C009, 0xFFFFFFFD=
)))
            {
                Store (\C006 (Local0, DerefOf (Index (C00A, Local1))), Lo=
cal2)
                If (Local2)
                {
                    Add (Local1, 0x01, C009)
                }
                Else
                {
                    Increment (Local1)
                }
            }

            If (LEqual (C009, 0xFFFFFFFD))
            {
                Store (0x00, C009)
            }

            If (LOr (LEqual (C009, 0x00), LEqual (C009, 0x03)))
            {
                If (CondRefOf (\_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x04, C009)
                    }
                }
            }

            Store (C009, \_SB.C00B)
        }

        Return (C009)
    }

    Method (\_SB._INI, 0, NotSerialized)
    {
        \C00B ()
    }

    Scope (\_SB)
    {
        Device (C00C)
        {
            Name (_HID, "PNP0C01")
            Method (_CRS, 0, NotSerialized)
            {
                Name (C00D, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0x00000000, 0x000A0000)
                    Memory32Fixed (ReadOnly, 0x000F0000, 0x00100000)
                    Memory32Fixed (ReadWrite, 0x00100000, 0x00F00000)
                })
                CreateDWordField (C00D, 0x20, C010)
                CreateDWordField (C00D, 0x1C, C011)
                Subtract (\_SB.C012 (), C011, C010)
                CreateDWordField (C00D, 0x14, C013)
                CreateDWordField (C00D, 0x10, C014)
                Store (ShiftLeft (\_SB.C015, 0x04), C014)
                Subtract (C011, C014, C013)
                Return (C00D)
            }
        }

        Method (C012, 0, NotSerialized)
        {
            Store (C016, Local0)
            Return (Local0)
        }

        Method (C017, 0, NotSerialized)
        {
            Store (C018, Local0)
            Return (Local0)
        }

        Method (C019, 0, NotSerialized)
        {
            Add (C017 (), 0x0002BEC0, Local0)
            Return (Local0)
        }

        OperationRegion (C01A, SystemMemory, 0x000F8000, 0x2C)
        Field (C01A, WordAcc, NoLock, Preserve)
        {
            C01B,   16,=20
            Offset (0x08),=20
            C01C,   16,=20
            Offset (0x0E),=20
            C018,   32
        }

        OperationRegion (C01D, SystemMemory, C017, 0x00020200)
        Field (C01D, AnyAcc, NoLock, Preserve)
        {
            C01E,   1048576,=20
            C01F,   2048,=20
            C020,   2048
        }

        OperationRegion (C021, SystemMemory, C019, 0x0140)
        Field (C021, AnyAcc, NoLock, Preserve)
        {
            C022,   32,=20
            C023,   4,=20
            C024,   1,=20
            C00B,   4,=20
            C025,   5,=20
            C026,   1,=20
            C027,   1,=20
            C028,   2,=20
            C001,   1,=20
            C029,   1,=20
            C02A,   1,=20
            C02B,   11,=20
            C02C,   32,=20
            C015,   16,=20
            C02D,   16,=20
            C02E,   16,=20
            C02F,   16,=20
            C030,   16,=20
            C031,   16,=20
            C032,   16,=20
            C016,   32,=20
            C033,   8,=20
            C034,   8,=20
            C035,   8,=20
            C036,   8,=20
            C037,   8,=20
            C038,   8,=20
            Offset (0x68),=20
            C039,   32,=20
            C03A,   32,=20
            C03B,   32,=20
            C03C,   32,=20
            Offset (0x8C),=20
            C03D,   32
        }

        Method (C03E, 0, NotSerialized)
        {
            Add (C01B, 0x000F0000, Local0)
            Return (Local0)
        }

        OperationRegion (C03F, SystemMemory, C03E, 0x06)
        Field (C03F, AnyAcc, NoLock, Preserve)
        {
            C040,   8,=20
            C041,   8,=20
            C042,   8,=20
            C043,   8,=20
            C044,   8,=20
            C045,   8
        }

        Method (C046, 2, Serialized)
        {
            Store (Arg0, Local0)
            If (LEqual (Local0, 0x01))
            {
                Store (\_SB.C02C, Local1)
                Or (Local1, Arg1, Local1)
                Store (Local1, \_SB.C02C)
            }
            Else
            {
                Store (\_SB.C02C, Local1)
                Not (Arg1, Local2)
                And (Local1, Local2, Local1)
                Store (Local1, \_SB.C02C)
            }
        }

        Device (C047)
        {
            Name (_HID, "PNP0A03")
            Name (_ADR, 0x00)
            Device (C048)
            {
                Name (_ADR, 0x00010000)
            }

            OperationRegion (C049, PCI_Config, 0x91, 0x06)
            Field (C049, AnyAcc, NoLock, Preserve)
            {
                C04A,   48
            }

            Alias (C04A, \_SB.C04A)
            Scope (\_SB)
            {
                Name (C04B, Package (0x0C)
                {
                    0x4000,=20
                    0x4000,=20
                    0x4000,=20
                    0x4000,=20
                    0x4000,=20
                    0x4000,=20
                    0x4000,=20
                    0x4000,=20
                    0x4000,=20
                    0x4000,=20
                    0x4000,=20
                    0x4000
                })
                Method (C04C, 0, NotSerialized)
                {
                    Acquire (C04D, 0xFFFF)
                    If (LEqual (C04E, 0xFFFFFFFD))
                    {
                        Store (0x00, Local0)
                        Store (Local0, C04E)
                        Store (Local0, Local2)
                        Store (C04A, Local5)
                        Store (DerefOf (Index (Local5, Local0)), Local1)
                        Store (0x000C0000, Local4)
                        Store (ShiftLeft (C015, 0x04), Local3)
                        While (LAnd (LNot (LGreater (Local4, Local3)), LL=
ess (C04E, 0x06)))
                        {
                            If (LEqual (And (Local1, 0x03), 0x00))
                            {
                                If (LEqual (Local2, 0x00))
                                {
                                    Store (Local4, Index (C04F, C04E))
                                }

                                Store (0x01, Local2)
                            }
                            Else
                            {
                                If (Local2)
                                {
                                    Subtract (Local4, 0x01, Index (C050, =
C04E))
                                    Increment (C04E)
                                }

                                Store (0x00, Local2)
                            }

                            If (LLess (Local4, Local3))
                            {
                                Add (Local4, DerefOf (Index (C04B, Local0=
)), Local4)
                                ShiftRight (Local1, 0x04, Local1)
                                If (And (Local0, 0x01))
                                {
                                    Store (0x01, Local1)
                                    If (LLess (Local4, Local3))
                                    {
                                        ShiftRight (Local0, 0x01, Local6)
                                        Increment (Local6)
                                        Store (DerefOf (Index (Local5, Lo=
cal6)), Local1)
                                    }
                                }
                            }
                            Else
                            {
                                Increment (Local4)
                            }

                            Increment (Local0)
                        }
                    }

                    Release (C04D)
                }
            }

            Method (_INI, 0, NotSerialized)
            {
                C04C ()
            }

            Name (C051, ResourceTemplate ()
            {
                WordBusNumber (ResourceConsumer, MinFixed, MaxFixed, PosD=
ecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, =
EntireRange,
                    0x0000,
                    0x0000,
                    0x0CF7,
                    0x0000,
                    0x0CF8)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, =
EntireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFi=
xed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFi=
xed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0xFFFFFFFF,
                    0x00000000,
                    0x00000000)
            })
            Scope (\_SB)
            {
                Name (C04F, Package (0x07) {})
                Name (C050, Package (0x07) {})
                Name (C04E, 0xFFFFFFFD)
                Mutex (C04D, 0x00)
            }

            Method (C053, 4, NotSerialized)
            {
                Store (Arg1, Local2)
                Store (Arg3, Local4)
                Add (Local4, 0x1A, Local5)
                While (LLess (Local4, Local5))
                {
                    Store (DerefOf (Index (C051, Local4)), Index (Arg0, L=
ocal2))
                    Increment (Local4)
                    Increment (Local2)
                }

                Store (Arg1, Local2)
                Add (Local2, 0x0A, Local2)
                CreateDWordField (Arg0, Local2, C054)
                Add (Local2, 0x04, Local2)
                CreateDWordField (Arg0, Local2, C055)
                Add (Local2, 0x08, Local2)
                CreateDWordField (Arg0, Local2, C056)
                Store (DerefOf (Index (C04F, Arg2)), C054)
                Store (DerefOf (Index (C050, Arg2)), C055)
                Subtract (C055, C054, Local3)
                Add (Local3, 0x01, C056)
                Add (Local2, 0x04, Local2)
                Return (Local2)
            }

            Method (C057, 0, NotSerialized)
            {
                Acquire (C04D, 0xFFFF)
                Multiply (C04E, 0x1A, Local1)
                Add (SizeOf (C051), Local1, Local2)
                Store (Buffer (Local2) {}, Local0)
                Store (0x00, Local1)
                Store (0x00, Local2)
                While (LLess (Local1, SizeOf (C051)))
                {
                    Store (DerefOf (Index (C051, Local1)), Index (Local0,=
 Local2))
                    Increment (Local2)
                    Increment (Local1)
                }

                Store (0x00, Local1)
                Subtract (Local2, 0x02, Local2)
                Subtract (Local2, 0x1A, Local3)
                While (LLess (Local1, C04E))
                {
                    Store (C053 (Local0, Local2, Local1, Local3), Local2)
                    Increment (Local1)
                }

                CreateWordField (Local0, Local2, C058)
                Store (0x79, C058)
                Release (C04D)
                Return (Local0)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (C051, 0x5C, C054)
                CreateDWordField (C051, 0x68, C056)
                CreateDWordField (C051, 0x60, C055)
                Store (\_SB.C012 (), Local1)
                Store (Local1, C054)
                Subtract (C055, Local1, Local1)
                Add (Local1, 0x01, C056)
                Store (C057 (), Local2)
                Return (Local2)
            }

            Name (_S3D, 0x02)
            Name (_S4D, 0x03)
            Device (C059)
            {
                Name (_ADR, 0x001E0000)
                Name (_PRW, Package (0x02)
                {
                    0x0B,=20
                    0x05
                })
            }

            Device (C05A)
            {
                Name (_ADR, 0x001F0000)
                OperationRegion (C05B, PCI_Config, 0x60, 0xA0)
                Field (C05B, AnyAcc, NoLock, Preserve)
                {
                    C05C,   8,=20
                    C05D,   8,=20
                    C05E,   8,=20
                    C05F,   8,=20
                    Offset (0x08),=20
                    C060,   8,=20
                    C061,   8,=20
                    C062,   8,=20
                    C063,   8,=20
                    Offset (0x30),=20
                    C064,   16,=20
                    Offset (0x40),=20
                        ,   7,=20
                    C065,   1,=20
                    Offset (0x58),=20
                    C066,   32,=20
                    Offset (0x60),=20
                        ,   4,=20
                    C067,   4,=20
                    Offset (0x64),=20
                    C068,   64,=20
                    C069,   16,=20
                    Offset (0x80),=20
                    C06A,   3,=20
                        ,   1,=20
                    C06B,   3,=20
                    Offset (0x81),=20
                    C06C,   2,=20
                        ,   2,=20
                    C06D,   1,=20
                    Offset (0x84),=20
                    C06E,   16,=20
                    C06F,   1,=20
                    C070,   1,=20
                    C071,   1,=20
                    C072,   1
                }

                OperationRegion (C073, SystemIO, 0xB2, 0x01)
                Field (C073, AnyAcc, NoLock, Preserve)
                {
                    C074,   8
                }

                OperationRegion (C075, SystemIO, 0x1000, 0x36)
                Field (C075, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x2A),=20
                        ,   2,=20
                    C076,   1,=20
                    Offset (0x2C),=20
                    C077,   16,=20
                    Offset (0x30),=20
                    C078,   1,=20
                    C079,   1,=20
                        ,   2,=20
                    C07A,   1,=20
                    Offset (0x34),=20
                        ,   4,=20
                    C07B,   1
                }

                OperationRegion (C07C, SystemIO, 0x1060, 0x11)
                Field (C07C, ByteAcc, NoLock, Preserve)
                {
                    C07D,   8,=20
                    C07E,   8,=20
                    Offset (0x04),=20
                        ,   3,=20
                    C07F,   1,=20
                    Offset (0x06),=20
                        ,   1,=20
                    C080,   1,=20
                    Offset (0x08),=20
                        ,   11,=20
                    C081,   1
                }

                OperationRegion (C082, SystemMemory, 0xFFBC0100, 0x01)
                Field (C082, ByteAcc, NoLock, Preserve)
                {
                    C083,   5
                }

                OperationRegion (C084, SystemIO, 0x1100, 0x3C)
                Field (C084, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x0C),=20
                    C085,   32,=20
                    Offset (0x2C),=20
                    C086,   32,=20
                    Offset (0x38),=20
                    C087,   16
                }

                OperationRegion (C088, SystemIO, 0x1200, 0x06)
                Field (C088, ByteAcc, NoLock, Preserve)
                {
                    C089,   8,=20
                    Offset (0x02),=20
                    C08A,   8,=20
                    C08B,   8,=20
                    C08C,   8,=20
                    C08D,   8
                }

                Method (C08E, 3, Serialized)
                {
                    Acquire (\_GL, 0xFFFF)
                    Store (0x00, Local2)
                    Store (0xFA, Local0)
                    While (LAnd (And (C089, 0x01), LGreater (Local0, 0x00=
)))
                    {
                        Stall (0x64)
                        Decrement (Local0)
                    }

                    If (Local0)
                    {
                        Store (Arg1, C08B)
                        Store (Arg0, C08C)
                        If (LEqual (And (Arg0, 0x01), 0x00))
                        {
                            Store (Arg2, C08D)
                        }

                        Store (0xFF, C089)
                        Store (0x48, C08A)
                        Store (0xFA, Local0)
                        While (LAnd (LEqual (And (C089, 0x1E), 0x00), LGr=
eater (Local0, 0x00)))
                        {
                            Stall (0x64)
                            Decrement (Local0)
                        }

                        And (C089, 0x1C, Local1)
                        Store (0xFF, C089)
                        If (LAnd (LEqual (Local1, 0x00), And (Arg0, 0x01)=
))
                        {
                            Store (C08D, Local2)
                        }
                    }
                    Else
                    {
                        Store (0x01, Local1)
                    }

                    Release (\_GL)
                    If (And (Arg0, 0x01))
                    {
                        ShiftLeft (Local1, 0x08, Local3)
                        Or (Local3, Local2, Local1)
                    }

                    Return (Local1)
                }

                Method (C08F, 2, Serialized)
                {
                    If (And (Arg0, 0xEF))
                    {
                        FindSetRightBit (Arg0, Local4)
                        Decrement (Local4)
                        Multiply (Local4, 0x02, Local0)
                        ShiftLeft (0x03, Local0, Local1)
                        ShiftLeft (Arg1, Local0, Local2)
                        Store (C064, Local3)
                        And (Local3, Not (Local1), Local3)
                        Or (Local3, Local2, Local3)
                        Store (Local3, C064)
                    }
                }

                Name (C090, Package (0x08)
                {
                    0x03F8,=20
                    0x02F8,=20
                    0x0220,=20
                    0x0228,=20
                    0x0238,=20
                    0x02E8,=20
                    0x0338,=20
                    0x03E8
                })
                Name (C091, Package (0x03)
                {
                    0x0378,=20
                    0x0278,=20
                    0x03BC
                })
                Method (C092, 3, NotSerialized)
                {
                    Store (0x00, Local1)
                    Store (Match (Arg0, MEQ, Arg1, MTR, 0x00, 0x00), Loca=
l0)
                    If (LNot (LEqual (Local0, Ones)))
                    {
                        ShiftLeft (Local0, Arg2, Local1)
                    }

                    Return (Local1)
                }

                Method (C093, 3, Serialized)
                {
                    Store (C068, Local0)
                    CreateWordField (Local0, Multiply (Arg0, 0x02), C094)
                    Store (Arg1, C094)
                    Store (Local0, C068)
                    Multiply (Arg0, 0x04, Local1)
                    ShiftLeft (Arg2, Local1, Local2)
                    ShiftLeft (0x0F, Local1, Local3)
                    And (C069, Not (Local3), Local4)
                    Or (Local4, Local2, C069)
                }

                Method (C095, 3, Serialized)
                {
                    If (Arg1)
                    {
                        Store (0x00, Local0)
                        Store (0x00, Local1)
                        Store (0x00, Local3)
                        And (C067, 0x0F, Local2)
                        While (Local2)
                        {
                            If (And (Local2, 0x01))
                            {
                                Multiply (Local3, 0x02, Local5)
                                Store (C068, Local6)
                                Store (DerefOf (Index (Local6, Local5)), =
Local4)
                                Or (ShiftLeft (DerefOf (Index (Local6, Ad=
d (Local5, 0x01))), 0x08), Local4, Local4)
                                If (LEqual (Arg1, Local4))
                                {
                                    If (LEqual (Arg0, 0x00))
                                    {
                                        ShiftLeft (0x01, Local3, Local5)
                                        And (C067, Not (Local5), C067)
                                        C093 (Local3, 0x00, 0x00)
                                    }

                                    Add (Local3, 0x01, Local1)
                                }
                            }
                            Else
                            {
                                If (LAnd (Arg0, LEqual (Local0, 0x00)))
                                {
                                    Add (Local3, 0x01, Local0)
                                }
                            }

                            ShiftRight (Local2, 0x01, Local2)
                            Increment (Local3)
                        }

                        If (LAnd (Arg0, LEqual (Local1, 0x00)))
                        {
                            If (LEqual (Local0, 0x00))
                            {
                                Add (Local3, 0x01, Local0)
                            }

                            Decrement (Local0)
                            If (LLess (Local0, 0x04))
                            {
                                C093 (Local0, Arg1, Arg2)
                                Or (C067, ShiftLeft (0x01, Local0), C067)
                            }
                        }
                    }
                }

                Method (C096, 2, Serialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Store (0x00, C072)
                    }
                    Else
                    {
                        If (LEqual (Arg0, 0x01))
                        {
                            Store (0x00, C071)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x03))
                            {
                                Store (0x00, C06F)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x02))
                                {
                                    Store (0x00, C070)
                                    C095 (0x00, Arg1, 0x00)
                                }
                            }
                        }
                    }
                }

                Method (C097, 3, Serialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Store (0x00, Local0)
                        If (LEqual (Arg1, 0x0370))
                        {
                            Store (0x01, Local0)
                        }

                        Store (Local0, C06D)
                        Store (0x01, C072)
                    }
                    Else
                    {
                        If (LEqual (Arg0, 0x01))
                        {
                            Store (C092 (C091, Arg1, 0x00), C06C)
                            Store (0x01, C071)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x03))
                            {
                                Store (C092 (C090, Arg1, 0x00), C06A)
                                Store (0x01, C06F)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x02))
                                {
                                    Store (C092 (C090, Arg1, 0x00), C06B)
                                    Store (0x01, C070)
                                    C095 (0x01, Arg2, 0x07)
                                }
                            }
                        }
                    }
                }
            }

            Device (C098)
            {
                Name (_ADR, 0x001F0001)
                OperationRegion (C099, PCI_Config, 0x40, 0x18)
                Field (C099, AnyAcc, NoLock, Preserve)
                {
                    C09A,   16,=20
                    C09B,   16,=20
                    C09C,   8,=20
                    Offset (0x08),=20
                    C09D,   8,=20
                    Offset (0x0A),=20
                    C09E,   16,=20
                    Offset (0x14),=20
                    C09F,   32
                }

                Method (C0A0, 2, Serialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Store (C09A, Local0)
                    }
                    Else
                    {
                        Store (C09B, Local0)
                    }

                    If (LEqual (And (Local0, 0x09), 0x00))
                    {
                        Return (0x0384)
                    }

                    If (LEqual (Arg1, 0x00))
                    {
                        If (LEqual (And (Local0, 0x09), 0x08))
                        {
                            Return (0x0384)
                        }

                        ShiftRight (And (Local0, 0x0300), 0x08, Local1)
                        ShiftRight (And (Local0, 0x3000), 0x0C, Local2)
                        Return (Multiply (0x1E, Subtract (0x09, Add (Loca=
l1, Local2))))
                    }
                    Else
                    {
                        If (And (Local0, 0x4000))
                        {
                            If (LEqual (And (Local0, 0x90), 0x80))
                            {
                                Return (0x0384)
                            }

                            Store (C09C, Local0)
                            If (LEqual (Arg0, 0x01))
                            {
                                ShiftRight (Local0, 0x04, Local0)
                            }

                            Return (Multiply (0x1E, Subtract (0x09, Add (=
And (ShiftRight (Local0, 0x02), 0x03), And (Local0, 0x03)))))
                        }

                        Return (0xFFFFFFFF)
                    }
                }

                Name (C0A1, Buffer (0x05)
                {
                    0x70, 0x49, 0x36, 0x27, 0x19
                })
                Method (C0A2, 2, Serialized)
                {
                    ShiftLeft (0x01, Add (Multiply (Arg0, 0x02), Arg1), L=
ocal0)
                    If (And (C09D, Local0))
                    {
                        Store (C09F, Local1)
                        If (And (ShiftRight (Local1, 0x0C), Local0))
                        {
                            Return (0x11)
                        }

                        Store (And (ShiftRight (C09E, Add (Multiply (Arg0=
, 0x08), Multiply (Arg1, 0x04))), 0x03), Local2)
                        If (And (Local1, Local0))
                        {
                            Add (Local2, 0x02, Local2)
                        }

                        Return (DerefOf (Index (C0A1, Local2)))
                    }

                    Return (0xFFFFFFFF)
                }

                Method (C0A3, 1, Serialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Store (C09A, Local0)
                    }
                    Else
                    {
                        Store (C09B, Local0)
                    }

                    Store (ShiftRight (C09D, Multiply (0x02, Arg0)), Loca=
l1)
                    Store (0x00, Local3)
                    If (And (Local1, 0x01))
                    {
                        Or (Local3, 0x01, Local3)
                    }

                    If (And (Local1, 0x02))
                    {
                        Or (Local3, 0x04, Local3)
                    }

                    If (And (Local0, 0x02))
                    {
                        Or (Local3, 0x02, Local3)
                    }

                    If (And (Local0, 0x20))
                    {
                        Or (Local3, 0x08, Local3)
                    }

                    If (And (Local0, 0x4000))
                    {
                        Or (Local3, 0x10, Local3)
                    }

                    Return (Local3)
                }

                Method (C0A4, 5, Serialized)
                {
                    CreateWordField (Arg4, 0x02, C0A5)
                    CreateWordField (Arg4, 0x04, C0A6)
                    CreateWordField (Arg4, 0x08, C0A7)
                    Store (0x0C, Local0)
                    Store (0x00, Local1)
                    Store (0x00, Local2)
                    Store (0x01, Local5)
                    If (LAnd (And (Arg3, ShiftLeft (0x02, Multiply (Arg1,=
 0x02))), And (C0A5, 0x0800)))
                    {
                        Or (Local0, 0x02, Local0)
                        Store (0x08, Local5)
                    }

                    If (LAnd (LNot (LGreater (Arg2, 0xF0)), And (C0A6, 0x=
02)))
                    {
                        Or (And (Local0, 0xFFFFFFF7), 0x01, Local0)
                        If (LAnd (LNot (LGreater (Arg2, 0x78)), And (C0A7=
, 0x02)))
                        {
                            Store (0x2300, Local1)
                            Store (0x0B, Local2)
                            Or (Local5, 0x04, Local5)
                        }
                        Else
                        {
                            If (LAnd (LNot (LGreater (Arg2, 0xB4)), And (=
C0A7, 0x01)))
                            {
                                Store (0x2100, Local1)
                                Store (0x09, Local2)
                                Or (Local5, 0x03, Local5)
                            }
                            Else
                            {
                                Store (0x0100, Local1)
                                Store (0x04, Local2)
                                Or (Local5, 0x02, Local5)
                            }
                        }
                    }

                    If (LEqual (Arg1, 0x00))
                    {
                        Or (Local0, Local1, Local0)
                        Store (0x40F0, Local4)
                    }
                    Else
                    {
                        ShiftLeft (Local0, 0x04, Local0)
                        If (And (Arg3, 0x10))
                        {
                            Or (Local0, 0x4000, Local0)
                            If (LEqual (Arg0, 0x00))
                            {
                                Or (And (C09C, 0xF0), Local2, C09C)
                            }
                            Else
                            {
                                Or (And (C09C, 0x0F), ShiftLeft (Local2, =
0x04), C09C)
                            }
                        }

                        Store (0x3F0F, Local4)
                    }

                    Or (Local0, 0x8000, Local0)
                    If (LEqual (Arg0, 0x00))
                    {
                        Or (And (C09A, Local4), Local0, C09A)
                    }
                    Else
                    {
                        Or (And (C09B, Local4), Local0, C09B)
                    }

                    Return (Local5)
                }

                Method (C0A8, 5, Serialized)
                {
                    CreateWordField (Arg4, 0x0C, C0A9)
                    Store (0x00, Local0)
                    Store (0x00, Local1)
                    Store (0x00, Local2)
                    Add (Multiply (Arg0, 0x02), Arg1, Local3)
                    Store (0x00, Local4)
                    ShiftLeft (0x1011, Local3, Local5)
                    If (And (Arg3, ShiftLeft (0x01, Multiply (Arg1, 0x02)=
)))
                    {
                        Store (0x01, Local1)
                        Store (C0AA (Arg0, Arg1), Local6)
                        If (LAnd (LNot (LLess (Local6, 0x05)), LAnd (LLes=
s (Arg2, 0x19), And (C0A9, 0x20))))
                        {
                            Store (0x01, Local0)
                            Store (0x45, Local2)
                            ShiftLeft (0x1011, Local3, Local4)
                        }
                        Else
                        {
                            If (LAnd (LNot (LLess (Local6, 0x04)), LAnd (=
LLess (Arg2, 0x27), And (C0A9, 0x10))))
                            {
                                Store (0x02, Local0)
                                Store (0x44, Local2)
                                ShiftLeft (0x11, Local3, Local4)
                            }
                            Else
                            {
                                If (LAnd (LNot (LLess (Local6, 0x03)), LA=
nd (LLess (Arg2, 0x36), And (C0A9, 0x08))))
                                {
                                    Store (0x01, Local0)
                                    Store (0x43, Local2)
                                    ShiftLeft (0x11, Local3, Local4)
                                }
                                Else
                                {
                                    If (LAnd (LNot (LLess (Local6, 0x02))=
, LAnd (LLess (Arg2, 0x49), And (C0A9, 0x04))))
                                    {
                                        Store (0x02, Local0)
                                        Store (0x42, Local2)
                                    }
                                    Else
                                    {
                                        If (LAnd (LNot (LLess (Local6, 0x=
01)), LAnd (LLess (Arg2, 0x70), And (C0A9, 0x02))))
                                        {
                                            Store (0x01, Local0)
                                            Store (0x41, Local2)
                                        }
                                        Else
                                        {
                                            Store (0x00, Local0)
                                            Store (0x40, Local2)
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Or (And (C09D, Not (ShiftLeft (0x01, Local3))), Shift=
Left (Local1, Local3), C09D)
                    Multiply (Local3, 0x04, Local3)
                    Or (And (C09E, Not (ShiftLeft (0x03, Local3))), Shift=
Left (Local0, Local3), C09E)
                    Or (And (C09F, Not (Local5)), Local4, C09F)
                    Return (Local2)
                }
            }

            Device (C0AB)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (C0AC, PCI_Config, 0xC4, 0x04)
                Field (C0AC, AnyAcc, NoLock, Preserve)
                {
                    C0AD,   1,=20
                    C0AE,   1
                }

                Device (C0AF)
                {
                    Name (_ADR, 0x00)
                    Device (C0B0)
                    {
                        Name (_ADR, 0x00)
                    }
                }
            }

            Device (C0B1)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (C0AC, PCI_Config, 0xC4, 0x04)
                Field (C0AC, AnyAcc, NoLock, Preserve)
                {
                    C0AD,   1,=20
                    C0AE,   1
                }

                Device (C0AF)
                {
                    Name (_ADR, 0x00)
                    Device (C0B0)
                    {
                        Name (_ADR, 0x00)
                    }

                    Device (C0B2)
                    {
                        Name (_ADR, 0x01)
                    }
                }
            }

            Device (C0B3)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (C0AC, PCI_Config, 0xC4, 0x01)
                Field (C0AC, AnyAcc, NoLock, Preserve)
                {
                    C0AD,   1,=20
                    C0AE,   1
                }

                Device (C0AF)
                {
                    Name (_ADR, 0x00)
                    Device (C0B0)
                    {
                        Name (_ADR, 0x00)
                    }

                    Device (C0B2)
                    {
                        Name (_ADR, 0x01)
                    }
                }
            }

            Device (C0B4)
            {
                Name (_ADR, 0x001D0007)
                Device (C0AF)
                {
                    Name (_ADR, 0x00)
                    Device (C0B0)
                    {
                        Name (_ADR, 0x00)
                    }

                    Device (C0B2)
                    {
                        Name (_ADR, 0x01)
                    }

                    Device (C0B5)
                    {
                        Name (_ADR, 0x02)
                    }

                    Device (C0B6)
                    {
                        Name (_ADR, 0x03)
                    }

                    Device (C0B7)
                    {
                        Name (_ADR, 0x04)
                    }

                    Device (C0B8)
                    {
                        Name (_ADR, 0x05)
                    }
                }
            }

            Method (C0B9, 1, Serialized)
            {
                Name (C0BA, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {}
                })
                CreateWordField (C0BA, 0x01, C0BC)
                Store (0x00, Local1)
                Store (Arg0, Local0)
                And (Local0, 0x8F, Local0)
                If (LLess (Local0, 0x80))
                {
                    And (Local0, 0x0F, Local0)
                    ShiftLeft (0x01, Local0, Local1)
                }

                Store (Local1, C0BC)
                Return (C0BA)
            }

            Method (C0BD, 1, Serialized)
            {
                Store (Arg0, Local0)
                And (Local0, 0x80, Local0)
                If (LEqual (Local0, 0x00))
                {
                    Store (0x0B, Local0)
                }
                Else
                {
                    Store (0x09, Local0)
                }

                Return (Local0)
            }

            Method (C0BE, 1, Serialized)
            {
                Store (Arg0, Local0)
                And (Local0, 0xF0, Local0)
                Or (Local0, 0x80, Local0)
                Return (Local0)
            }

            Method (C0BF, 1, Serialized)
            {
                CreateWordField (Arg0, 0x01, C0C0)
                If (LEqual (C0C0, 0x00))
                {
                    Store (0x00, Local0)
                }
                Else
                {
                    FindSetRightBit (C0C0, Local0)
                    Decrement (Local0)
                }

                Return (Local0)
            }

            Device (C0C1)
            {
                Name (_HID, "PNP0C0F")
                Name (_UID, 0x60)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BD (^^C05A.C05C))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BE (^^C05A.C05C), ^^C05A.C05C)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BF (Arg0), ^^C05A.C05C)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B9 (^^C05A.C05C))
                }
            }

            Device (C0C2)
            {
                Name (_HID, "PNP0C0F")
                Name (_UID, 0x61)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BD (^^C05A.C05D))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BE (^^C05A.C05D), ^^C05A.C05D)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BF (Arg0), ^^C05A.C05D)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B9 (^^C05A.C05D))
                }
            }

            Device (C0C3)
            {
                Name (_HID, "PNP0C0F")
                Name (_UID, 0x62)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BD (^^C05A.C05E))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BE (^^C05A.C05E), ^^C05A.C05E)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BF (Arg0), ^^C05A.C05E)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B9 (^^C05A.C05E))
                }
            }

            Device (C0C4)
            {
                Name (_HID, "PNP0C0F")
                Name (_UID, 0x63)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BD (^^C05A.C05F))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BE (^^C05A.C05F), ^^C05A.C05F)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BF (Arg0), ^^C05A.C05F)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B9 (^^C05A.C05F))
                }
            }

            Device (C0C5)
            {
                Name (_HID, "PNP0C0F")
                Name (_UID, 0x68)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BD (^^C05A.C060))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BE (^^C05A.C060), ^^C05A.C060)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BF (Arg0), ^^C05A.C060)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B9 (^^C05A.C060))
                }
            }

            Device (C0C6)
            {
                Name (_HID, "PNP0C0F")
                Name (_UID, 0x69)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BD (^^C05A.C061))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BE (^^C05A.C061), ^^C05A.C061)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BF (Arg0), ^^C05A.C061)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B9 (^^C05A.C061))
                }
            }

            Device (C0C7)
            {
                Name (_HID, "PNP0C0F")
                Name (_UID, 0x6A)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BD (^^C05A.C062))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BE (^^C05A.C062), ^^C05A.C062)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BF (Arg0), ^^C05A.C062)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B9 (^^C05A.C062))
                }
            }

            Device (C0C8)
            {
                Name (_HID, "PNP0C0F")
                Name (_UID, 0x6B)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BD (^^C05A.C063))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BE (^^C05A.C063), ^^C05A.C063)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BF (Arg0), ^^C05A.C063)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B9 (^^C05A.C063))
                }
            }

            Method (C0C9, 1, NotSerialized)
            {
                While (^C05A.C07B)
                {
                    Stall (0x01)
                }

                Store (0xF3, ^C05A.C074)
                Stall (0x32)
                While (^C05A.C07B)
                {
                    Stall (0x01)
                }
            }

            Mutex (C0CA, 0x00)
            Name (C0CB, 0x00)
            Name (C0CC, 0x00)
            Method (C0CD, 0, NotSerialized)
            {
                Acquire (C0CA, 0xFFFF)
                If (LEqual (C0CC, 0x00))
                {
                    Store (0x00, ^C05A.C078)
                    Store (0x00, ^C05A.C079)
                }

                Increment (C0CC)
                Release (C0CA)
            }

            Method (C0CE, 0, NotSerialized)
            {
                Acquire (C0CA, 0xFFFF)
                Decrement (C0CC)
                If (LEqual (C0CC, 0x00))
                {
                    Store (0x01, ^C05A.C079)
                    Store (0x01, ^C05A.C078)
                }

                Release (C0CA)
            }

            Scope (C048)
            {
                Device (C0CF)
                {
                    Name (_ADR, 0x00)
                    Name (C0D0, 0x00)
                    OperationRegion (C0D1, PCI_Config, 0x2C, 0x04)
                    Field (C0D1, DWordAcc, NoLock, Preserve)
                    {
                        C0D2,   32
                    }

                    OperationRegion (C0D3, PCI_Config, 0x4C, 0x04)
                    Field (C0D3, DWordAcc, NoLock, Preserve)
                    {
                        C0D4,   32
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LAnd (LEqual (Arg0, 0x02), LEqual (Arg1, 0x01=
)))
                        {
                            Store (C0D2, Local0)
                            If (LEqual (C0D0, 0x00))
                            {
                                Store (Local0, C0D0)
                            }
                            Else
                            {
                                If (LNot (LEqual (Local0, C0D0)))
                                {
                                    Store (C0D0, C0D4)
                                }
                            }
                        }
                    }

                    Name (_S1D, 0x03)
                    Name (_S3D, 0x03)
                    Name (_S4D, 0x03)
                    Method (C0D5, 1, Serialized)
                    {
                        Store (0x00, Local0)
                        If (And (C0D6 (0x00), Arg0))
                        {
                            Store (0x01, Local0)
                            If (And (C035, Arg0))
                            {
                                Store (0x1D, Local0)
                                If (And (C034, Arg0))
                                {
                                    Store (0x1F, Local0)
                                }
                            }
                        }

                        Return (Local0)
                    }

                    Method (C0D7, 1, Serialized)
                    {
                        Store (0x00, Local0)
                        If (And (C036, Arg0))
                        {
                            Store (0x01, Local0)
                        }

                        Return (Local0)
                    }

                    Method (C0D8, 2, Serialized)
                    {
                        Store (C037, Local0)
                        If (And (Arg1, 0x01))
                        {
                            Or (Local0, Arg0, Local0)
                        }
                        Else
                        {
                            And (Local0, Not (Arg0), Local0)
                        }

                        Store (Local0, C037)
                        If (And (Arg1, 0x40000000))
                        {
                            Store (Local0, C034)
                        }

                        If (LEqual (And (Arg1, 0xC0000000), 0x80000000))
                        {
                            \_SB.C0D9 (0xEA74, 0x01, 0x00, 0x00, 0x00)
                        }
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        And (C033, 0xF8, Local0)
                        Or (Local0, Arg0, C033)
                    }

                    Device (C0DA)
                    {
                        Name (_ADR, 0x0100)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Return (C0D5 (0x02))
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (C0D7 (0x02))
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            C0D8 (0x02, Arg0)
                        }
                    }

                    Device (C0DB)
                    {
                        Name (_ADR, 0x0110)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Return (C0D5 (0x01))
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (C0D7 (0x01))
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            C0D8 (0x01, Arg0)
                        }
                    }

                    Device (C0DC)
                    {
                        Name (_ADR, 0x0200)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Return (C0D5 (0x04))
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (C0D7 (0x04))
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            C0D8 (0x04, Arg0)
                        }
                    }

                    Device (C0DD)
                    {
                        Name (_ADR, 0x0210)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Return (C0D5 (0x08))
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (C0D7 (0x08))
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            C0D8 (0x08, Arg0)
                        }
                    }

                    Name (C0DE, 0xFFFFFFFD)
                    Method (C0D6, 1, Serialized)
                    {
                        If (LAnd (Arg0, LEqual (C0DE, 0xFFFFFFFD)))
                        {
                            Store (0x07, Local0)
                            If (And (\_SB.C047.C05A.C086, 0x10))
                            {
                                Or (Local0, 0x08, Local0)
                            }

                            Store (Local0, C0DE)
                        }

                        Return (C0DE)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x04)
                        {
                            0x00010100,=20
                            0x00010110,=20
                            0x00010200,=20
                            0x00010210
                        })
                    }
                }
            }

            Method (\C0C9, 1, NotSerialized)
            {
                \_SB.C047.C0C9 (Arg0)
            }

            Method (\C0CD, 0, NotSerialized)
            {
                \_SB.C047.C0CD ()
            }

            Method (\C0CE, 0, NotSerialized)
            {
                \_SB.C047.C0CE ()
            }

            Scope (C05A)
            {
                Method (C0DF, 5, Serialized)
                {
                    If (LEqual (Arg1, 0x00))
                    {
                        ^C096 (Arg0, Arg2)
                        Store (0x01, Local0)
                    }
                    Else
                    {
                        ^C097 (Arg0, Arg1, Arg2)
                        Store (0x03, Local0)
                    }

                    ^C08F (Arg4, Local0)
                }

                Method (C0E0, 1, Serialized)
                {
                    Store (0x00, Local0)
                    If (LOr (C07F, Arg0))
                    {
                        Store (0x01, C081)
                        Store (0x01, C080)
                        Store (0x01, C07F)
                        Store (0x04, C07E)
                        Store (0x00, C07D)
                        Store (0x00, C081)
                        Store (0x01, Local0)
                    }

                    Return (Local0)
                }
            }

            Method (\_SB.C0E1, 5, Serialized)
            {
                ^C047.C05A.C0DF (Arg0, Arg1, Arg2, Arg3, Arg4)
            }

            Method (\_SB.C0E2, 0, NotSerialized)
            {
                If (And (\_SB.C047.C05A.C086, 0x80))
                {
                    Store (0x07, Local0)
                }
                Else
                {
                    And (\_SB.C047.C05A.C087, 0x0300, Local0)
                    ShiftRight (Local0, 0x08, Local0)
                }

                Return (Local0)
            }

            Device (C0E3)
            {
                Name (_ADR, 0x001F0005)
                PowerResource (C0E4, 0x00, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (0x01, Local1)
                        And (\_SB.C047.C05A.C087, 0x80, Local0)
                        If (Local0)
                        {
                            Store (0x01, Local1)
                        }

                        Return (Local1)
                    }

                    Method (_ON, 0, NotSerialized)
                    {
                        And (\_SB.C047.C05A.C087, 0xFFFFFF7F, Local0)
                        Store (Local0, \_SB.C047.C05A.C087)
                    }

                    Method (_OFF, 0, NotSerialized)
                    {
                        Or (\_SB.C047.C05A.C087, 0x80, Local0)
                        Store (Local0, \_SB.C047.C05A.C087)
                    }
                }

                Name (_PR0, Package (0x01)
                {
                    C0E4
                })
            }

            Scope (C05A)
            {
                Device (C0E5)
                {
                    Name (_HID, "PNP0C09")
                    Name (_GPE, 0x1D)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Mutex (C0E6, 0x00)
                    Name (C0E7, 0x00)
                    Name (C0E8, 0x00)
                    Method (C0E9, 0, Serialized)
                    {
                        C0EA (0x07, 0xFF)
                        Store (C0EB (), Local0)
                        C0EC (Local0, 0x81)
                        And (C0E7, 0x01, C0ED)
                        And (ShiftRight (C0E7, 0x01), 0x01, C0EE)
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, C0E8)
                            If (LAnd (Arg1, LNot (LLess (\C00B (), 0x03))=
))
                            {
                                C0E9 ()
                            }
                        }
                    }

                    OperationRegion (C0EF, EmbeddedControl, 0x00, 0xFF)
                    Field (C0EF, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x80),=20
                        Offset (0x81),=20
                            ,   4,=20
                        C0F0,   4,=20
                            ,   1,=20
                        C0ED,   1,=20
                        C0F1,   1,=20
                            ,   1,=20
                        C0EE,   1,=20
                            ,   1,=20
                            ,   1,=20
                        C0F2,   1,=20
                        C0F3,   1,=20
                        C0F4,   1,=20
                            ,   1,=20
                            ,   1,=20
                            ,   1,=20
                        C0F5,   1,=20
                        C0F6,   1,=20
                        C0F7,   1,=20
                        C0F8,   1,=20
                            ,   1,=20
                            ,   1,=20
                        C0F9,   1,=20
                        C0FA,   4,=20
                        C0FB,   1,=20
                        Offset (0x86),=20
                        C0FC,   4,=20
                        Offset (0x89),=20
                        C0FD,   16,=20
                        Offset (0x8D),=20
                        C0FE,   16,=20
                        Offset (0x91),=20
                        C0FF,   1,=20
                        Offset (0x95),=20
                        C100,   16,=20
                        Offset (0x99),=20
                        C101,   4,=20
                        Offset (0x9D),=20
                        C102,   16,=20
                        Offset (0xA1),=20
                        C103,   16,=20
                        Offset (0xA5),=20
                        C104,   16,=20
                        Offset (0xA9),=20
                        C105,   16,=20
                        Offset (0xAD),=20
                        C106,   16,=20
                        Offset (0xB1),=20
                        C107,   16,=20
                        Offset (0xB5),=20
                        C108,   8,=20
                        Offset (0xB9),=20
                        C109,   8,=20
                        Offset (0xBD),=20
                        C10A,   8,=20
                        Offset (0xC1),=20
                        C10B,   64,=20
                        C10C,   64,=20
                        C10D,   32,=20
                        C10E,   8,=20
                        C10F,   8,=20
                        C110,   8,=20
                        C111,   8,=20
                        C112,   8,=20
                        C113,   8,=20
                        C114,   8,=20
                        C115,   8,=20
                        C116,   4,=20
                        C117,   4,=20
                        C118,   16,=20
                        C119,   16,=20
                        Offset (0xE3),=20
                        C11A,   4
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        If (LLess (\C00B (), 0x03))
                        {
                            C0E9 ()
                        }
                    }

                    Name (C11B, 0xFF)
                    Name (C11C, 0xFF)
                    Name (C11D, 0x07)
                    Name (C11E, 0x01)
                    Name (C11F, 0x00)
                    Name (C120, 0x01)
                    Name (C121, 0x00)
                    Mutex (C122, 0x00)
                    Name (C123, Package (0x08)
                    {
                        "Unknown",=20
                        "NiMH",=20
                        "LiIon"
                    })
                    Method (C124, 0, Serialized)
                    {
                        Acquire (C122, 0xFFFF)
                        If (And (C11D, 0x01))
                        {
                            And (C11D, 0x06, C11D)
                            Release (C122)
                            Store (0x01, Local0)
                            If (And (\_SB.C047.C05A.C086, 0x08))
                            {
                                Store (0x00, Local0)
                            }

                            Store (Local0, C11E)
                        }
                        Else
                        {
                            Release (C122)
                            Store (C11E, Local0)
                        }

                        Return (Local0)
                    }

                    Method (C0EB, 0, Serialized)
                    {
                        Acquire (C122, 0xFFFF)
                        If (And (C11D, 0x02))
                        {
                            And (C11D, 0x05, C11D)
                            Release (C122)
                            Acquire (C0E6, 0xFFFF)
                            If (C0E8)
                            {
                                Store (C0FA, C11F)
                            }

                            Release (C0E6)
                        }
                        Else
                        {
                            Release (C122)
                        }

                        Return (C11F)
                    }

                    Method (C0EA, 2, Serialized)
                    {
                        Store (0x00, Local0)
                        Acquire (C122, 0xFFFF)
                        Or (Arg0, C11D, Local1)
                        And (Local1, 0x07, C11D)
                        If (And (C11D, 0x02))
                        {
                            Or (C11B, Arg1, C11B)
                        }

                        If (And (C11D, 0x04))
                        {
                            If (LNot (LEqual (C11C, 0xFF)))
                            {
                                Store (0x01, Local0)
                            }

                            Or (C11C, Arg1, C11C)
                        }

                        Release (C122)
                        Return (Local0)
                    }

                    Method (C125, 1, Serialized)
                    {
                        If (LEqual (Arg0, 0x01))
                        {
                            Store (0x01, C120)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x00))
                            {
                                Store (0x00, C120)
                            }
                        }

                        Return (C120)
                    }

                    Method (C126, 1, Serialized)
                    {
                        C125 (0x01)
                        Store (C0EB (), Local0)
                        Store (0x0F, Local1)
                        If (And (Local0, Arg0))
                        {
                            Store (0x1F, Local1)
                        }

                        Return (Local1)
                    }

                    Method (C127, 1, Serialized)
                    {
                        ShiftLeft (0x01, Arg0, Local7)
                        C125 (0x01)
                        If (LEqual (C126 (Local7), 0x0F))
                        {
                            Return (0xFFFFFFFD)
                        }

                        Acquire (C122, 0xFFFF)
                        Store (C11B, Local0)
                        Release (C122)
                        If (LEqual (And (Local0, Local7), 0x00))
                        {
                            Return (0x00)
                        }

                        Store (C128, Index (C129, Arg0))
                        Acquire (C0E6, 0xFFFF)
                        If (C0E8)
                        {
                            Store (Arg0, C0FC)
                            Store (C0FE, Local0)
                            Store (Local0, Index (DerefOf (Index (C12A, A=
rg0)), 0x01))
                            Store (Local0, Index (DerefOf (Index (C12A, A=
rg0)), 0x02))
                            Store (C100, Index (DerefOf (Index (C12A, Arg=
0)), 0x04))
                            Multiply (Local0, 0x0A, Local1)
                            Divide (Add (Local1, 0x32), 0x64, Local3, Loc=
al2)
                            Store (Local2, Index (DerefOf (Index (C12A, A=
rg0)), 0x05))
                            Name (C12B, 0x00)
                            Name (C12C, "     ")
                            Store (C10C, Local0)
                            Store (0x00, Index (Local0, 0x04))
                            Store (Local0, C12C)
                            Store (C12C, Index (DerefOf (Index (C12A, Arg=
0)), 0x0A))
                            Store (C10D, C12C)
                            Store (C12C, Index (DerefOf (Index (C12A, Arg=
0)), 0x0B))
                        }

                        Release (C0E6)
                        Acquire (C122, 0xFFFF)
                        And (C11B, Not (Local7), C11B)
                        Release (C122)
                        Return (0x00)
                    }

                    Method (C12D, 2, Serialized)
                    {
                        ShiftLeft (0x01, Arg0, Local7)
                        C125 (0x01)
                        If (LEqual (C126 (Local7), 0x0F))
                        {
                            Store (Package (0x04)
                                {
                                    0x00,=20
                                    0xFFFFFFFF,=20
                                    0xFFFFFFFF,=20
                                    0xFFFFFFFF
                                }, Index (C129, Arg0))
                            Return (0xFFFFFFFD)
                        }

                        Acquire (C122, 0xFFFF)
                        If (Arg1)
                        {
                            Store (0xFF, C11C)
                        }

                        Store (C11C, Local0)
                        Release (C122)
                        If (LEqual (And (Local0, Local7), 0x00))
                        {
                            Return (0x00)
                        }

                        Acquire (C0E6, 0xFFFF)
                        If (C0E8)
                        {
                            Store (Arg0, C0FC)
                            Store (C101, Local0)
                            Store (C102, Local3)
                            Store (C103, Index (DerefOf (Index (C129, Arg=
0)), 0x02))
                            Store (C104, Index (DerefOf (Index (C129, Arg=
0)), 0x03))
                        }

                        Release (C0E6)
                        If (LEqual (C124 (), 0x01))
                        {
                            And (0xFFFFFFFE, Local0, Local0)
                        }
                        Else
                        {
                            And (0xFFFFFFFD, Local0, Local0)
                        }

                        If (And (Local0, 0x01))
                        {
                            Acquire (C122, 0xFFFF)
                            Store (Local7, C121)
                            Release (C122)
                        }

                        Store (Local0, Index (DerefOf (Index (C129, Arg0)=
), 0x00))
                        If (And (Local0, 0x01))
                        {
                            If (LOr (LLess (Local3, 0x0320), LGreater (Lo=
cal3, 0x07D0)))
                            {
                                Store (DerefOf (Index (DerefOf (Index (C1=
29, Arg0)), 0x01)), Local5)
                                If (LOr (LLess (Local5, 0x0320), LGreater=
 (Local5, 0x07D0)))
                                {
                                    Store (0x0578, Local3)
                                }
                                Else
                                {
                                    Store (Local5, Local3)
                                }
                            }
                        }

                        Store (Local3, Index (DerefOf (Index (C129, Arg0)=
), 0x01))
                        Acquire (C122, 0xFFFF)
                        And (C11C, Not (Local7), C11C)
                        Release (C122)
                        Return (0x00)
                    }

                    Method (_Q03, 0, NotSerialized)
                    {
                        Acquire (C122, 0xFFFF)
                        Store (C121, Local0)
                        Release (C122)
                        C0EA (0x04, Local0)
                        C0EC (Local0, 0x80)
                    }

                    Method (_Q04, 0, NotSerialized)
                    {
                        Acquire (C122, 0xFFFF)
                        Store (C121, Local0)
                        Release (C122)
                        If (LEqual (\C00B (), 0x03))
                        {
                            Store (0x81, Local1)
                            Store (C0EB (), Local0)
                        }
                        Else
                        {
                            Store (0x80, Local1)
                        }

                        C0EA (0x04, Local0)
                        C0EC (Local0, Local1)
                    }

                    Method (_Q05, 0, NotSerialized)
                    {
                        Acquire (\_TZ.C12F, 0xFFFF)
                        Store (0x04, \_TZ.C130)
                        Release (\_TZ.C12F)
                        Notify (\_TZ.TZ3, 0x80)
                    }

                    Method (_Q06, 0, NotSerialized)
                    {
                        If (C125 (0x02))
                        {
                            C0EA (0x05, 0x03)
                            Notify (\_SB.C131, 0x80)
                            Notify (\_PR.C000, 0x80)
                            Notify (\_TZ.TZ1, 0x81)
                        }
                    }

                    Method (_Q07, 0, NotSerialized)
                    {
                        Acquire (\_TZ.C12F, 0xFFFF)
                        Store (0x04, \_TZ.C130)
                        Release (\_TZ.C12F)
                        Notify (\_TZ.TZ1, 0x80)
                    }

                    Method (_Q08, 0, NotSerialized)
                    {
                        If (C125 (0x02))
                        {
                            C0EA (0x06, 0x01)
                            Store (C0EB (), Local0)
                            If (LNot (LEqual (Local0, 0x02)))
                            {
                                C0EA (0x04, 0x02)
                                Notify (\_SB.C132, 0x80)
                            }

                            Notify (\_SB.C133, 0x81)
                        }
                    }

                    Method (_Q09, 0, NotSerialized)
                    {
                        If (C125 (0x02))
                        {
                            C0EA (0x04, 0x01)
                            Notify (\_SB.C133, 0x80)
                        }
                    }

                    Method (_Q0A, 0, NotSerialized)
                    {
                        Notify (\_SB.C134, 0x80)
                    }

                    Method (_Q0B, 0, NotSerialized)
                    {
                        Notify (\_SB.C135, 0x80)
                    }

                    Method (_Q0E, 0, NotSerialized)
                    {
                        Notify (\_SB.C047, 0x02)
                    }

                    Method (_Q10, 0, NotSerialized)
                    {
                        If (LEqual (And (C033, 0x03), 0x00))
                        {
                            \_SB.C0D9 (0xEA74, 0x00, 0x00, 0x00, 0x00)
                            If (\_SB.C02A)
                            {
                                Notify (\_SB.C047.C048.C0CF, 0x80)
                            }
                        }
                        Else
                        {
                            \_SB.C0D9 (0xEA2D, 0x04, 0x00, 0x00, 0x00)
                        }
                    }

                    Method (_Q18, 0, NotSerialized)
                    {
                        If (C125 (0x02))
                        {
                            C0EA (0x06, 0x02)
                            Store (C0EB (), Local0)
                            If (LNot (LEqual (Local0, 0x01)))
                            {
                                C0EA (0x04, 0x01)
                                Notify (\_SB.C133, 0x80)
                            }

                            Notify (\_SB.C132, 0x81)
                        }
                    }

                    Method (_Q19, 0, NotSerialized)
                    {
                        If (C125 (0x02))
                        {
                            C0EA (0x04, 0x02)
                            Notify (\_SB.C132, 0x80)
                        }
                    }

                    Method (C0EC, 2, Serialized)
                    {
                        If (And (Arg0, 0x01))
                        {
                            Notify (\_SB.C133, Arg1)
                        }

                        If (And (Arg0, 0x02))
                        {
                            Notify (\_SB.C132, Arg1)
                        }
                    }
                }

                Device (C136)
                {
                    Name (_HID, "PNP0A06")
                    OperationRegion (C137, SystemIO, 0x2E, 0x02)
                    Field (C137, ByteAcc, NoLock, Preserve)
                    {
                        C138,   8,=20
                        C139,   8
                    }

                    OperationRegion (C13A, SystemIO, 0x2E, 0x01)
                    Field (C13A, ByteAcc, NoLock, Preserve)
                    {
                        C13B,   8
                    }

                    Mutex (C13C, 0x00)
                    Mutex (C13D, 0x00)
                    Name (C13E, 0x00)
                    Name (C13F, 0x00)
                    Method (C140, 2, NotSerialized)
                    {
                        Acquire (C13C, 0xFFFF)
                        Acquire (\_GL, 0xFFFF)
                        Store (0x07, C138)
                        Store (Arg0, C139)
                        Store (Arg1, C138)
                        Store (C139, Local0)
                        Release (\_GL)
                        Release (C13C)
                        Return (Local0)
                    }

                    Method (C141, 3, NotSerialized)
                    {
                        Acquire (C13C, 0xFFFF)
                        Acquire (\_GL, 0xFFFF)
                        Store (0x07, C138)
                        Store (Arg0, C139)
                        Store (Arg1, C138)
                        Store (Arg2, C139)
                        Release (\_GL)
                        Release (C13C)
                    }

                    Method (C142, 4, Serialized)
                    {
                        Store (C140 (Arg0, Arg1), Local0)
                        And (Arg2, Local0, Local1)
                        Or (Arg3, Local1, Local2)
                        C141 (Arg0, Arg1, Local2)
                    }

                    Method (C143, 1, NotSerialized)
                    {
                        Store (C140 (Arg0, 0x61), Local0)
                        Store (C140 (Arg0, 0x60), Local1)
                        Or (Local0, ShiftLeft (Local1, 0x08), Local0)
                        If (Local0)
                        {
                            If (LEqual (C140 (Arg0, 0x30), 0x00))
                            {
                                Acquire (C13D, 0xFFFF)
                                Store (C13E, Local1)
                                Store (C13F, Local2)
                                Release (C13D)
                                And (Local1, Local2, Local1)
                                ShiftRight (Local1, Arg0, Local1)
                                If (LEqual (And (Local1, 0x01), 0x00))
                                {
                                    Store (0x00, Local0)
                                }
                            }
                        }

                        Return (Local0)
                    }

                    Method (C144, 1, NotSerialized)
                    {
                        Name (C145, Package (0x04)
                        {
                            0x00,=20
                            0x00,=20
                            0x00,=20
                            0x00
                        })
                        Store (C140 (Arg0, 0x61), Local0)
                        Store (C140 (Arg0, 0x60), Local1)
                        ShiftLeft (Local1, 0x08, Local1)
                        Or (Local0, Local1, Index (C145, 0x00))
                        If (LEqual (Arg0, 0x02))
                        {
                            Store (C140 (Arg0, 0x63), Local0)
                            Store (C140 (Arg0, 0x62), Local1)
                            ShiftLeft (Local1, 0x08, Local1)
                            Or (Local0, Local1, Index (C145, 0x01))
                        }

                        Store (C140 (Arg0, 0x70), Local0)
                        Store (0x00, Local1)
                        If (LLess (Local0, 0x10))
                        {
                            ShiftLeft (0x01, Local0, Local1)
                        }

                        Store (Local1, Index (C145, 0x02))
                        If (LNot (LEqual (Arg0, 0x03)))
                        {
                            Store (C140 (Arg0, 0x74), Local0)
                            Store (0x00, Local1)
                            If (LLess (Local0, 0x04))
                            {
                                ShiftLeft (0x01, Local0, Local1)
                            }

                            Store (Local1, Index (C145, 0x03))
                        }

                        Return (C145)
                    }

                    Method (C146, 5, NotSerialized)
                    {
                        If (LEqual (Arg1, 0x00))
                        {
                            C141 (Arg0, 0x30, 0x00)
                        }

                        FindSetRightBit (Arg3, Local1)
                        If (LAnd (LGreater (Local1, 0x01), LLess (Local1,=
 0x11)))
                        {
                            Decrement (Local1)
                        }
                        Else
                        {
                            Store (0x00, Local1)
                        }

                        FindSetRightBit (Arg4, Local2)
                        If (LAnd (LGreater (Local2, 0x00), LLess (Local2,=
 0x05)))
                        {
                            Decrement (Local2)
                        }
                        Else
                        {
                            Store (0x04, Local2)
                        }

                        C141 (Arg0, 0x61, Arg1)
                        ShiftRight (Arg1, 0x08, Local0)
                        C141 (Arg0, 0x60, Local0)
                        If (LEqual (Arg0, 0x02))
                        {
                            C141 (Arg0, 0x63, Arg2)
                            ShiftRight (Arg2, 0x08, Local0)
                            C141 (Arg0, 0x62, Local0)
                        }

                        C142 (Arg0, 0x70, 0xF0, Local1)
                        If (LNot (LEqual (Arg0, 0x03)))
                        {
                            C142 (Arg0, 0x74, 0xF0, Local2)
                        }

                        If (LNot (LEqual (Arg1, 0x00)))
                        {
                            C141 (Arg0, 0x30, 0x01)
                        }
                    }

                    Method (C147, 1, Serialized)
                    {
                        Acquire (C13D, 0xFFFF)
                        Store (C13E, Local0)
                        Release (C13D)
                        ShiftRight (Local0, Arg0, Local1)
                        Return (And (One, Local1, Local1))
                    }

                    Method (C148, 2, Serialized)
                    {
                        ShiftLeft (0x01, Arg0, Local0)
                        ShiftLeft (And (Arg1, 0x01), Arg0, Local1)
                        Acquire (C13D, 0xFFFF)
                        Or (C13F, Local0, C13F)
                        Store (C13E, Local2)
                        And (Local2, Not (Local0), Local2)
                        Or (Local2, Local1, Local2)
                        Store (Local2, C13E)
                        Release (C13D)
                    }

                    Method (C149, 2, Serialized)
                    {
                        And (C025, 0x10, Local0)
                        And (Not (C025), Arg1, Local1)
                        If (LOr (Local0, Local1))
                        {
                            Store (0x00, Local0)
                        }
                        Else
                        {
                            Store (C143 (Arg0), Local1)
                            Store (0x0D, Local0)
                            If (Local1)
                            {
                                Store (0x0F, Local0)
                            }
                        }

                        Return (Local0)
                    }

                    Method (C14A, 1, Serialized)
                    {
                        If (C143 (Arg0))
                        {
                            Store (C144 (Arg0), Local0)
                            Store (DerefOf (Index (Local0, 0x01)), Local1=
)
                            Store (DerefOf (Index (Local0, 0x02)), Local2=
)
                            Store (DerefOf (Index (Local0, 0x03)), Local3=
)
                            \_SB.C0E1 (Arg0, 0x00, Local1, Local2, Local3=
)
                            C146 (Arg0, 0x00, 0x00, 0x00, 0x00)
                        }
                    }

                    Method (C14B, 0, NotSerialized)
                    {
                        Store (^^C14C, Local3)
                        If (\_SB.C14D ())
                        {
                            If (C143 (0x03))
                            {
                                Name (C14E, ResourceTemplate ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x01, 0=
x08)
                                })
                                CreateWordField (C14E, 0x02, C150)
                                CreateWordField (C14E, 0x04, C151)
                                Store (C144 (0x03), Local1)
                                Store (DerefOf (Index (Local1, 0x00)), C1=
50)
                                Store (C150, C151)
                                Add (SizeOf (C14E), SizeOf (Local3), Loca=
l1)
                                Subtract (Local1, 0x02, Local1)
                                Store (Buffer (Local1) {}, Local0)
                                Store (0x00, Local1)
                                While (LLess (Local1, SizeOf (Local3)))
                                {
                                    Store (DerefOf (Index (Local3, Local1=
)), Index (Local0, Local1))
                                    Increment (Local1)
                                }

                                Subtract (Local1, 0x02, Local1)
                                Store (0x00, Local2)
                                While (LLess (Local2, SizeOf (C14E)))
                                {
                                    Store (DerefOf (Index (C14E, Local2))=
, Index (Local0, Local1))
                                    Increment (Local1)
                                    Increment (Local2)
                                }

                                Store (Local0, Local3)
                            }
                        }

                        Return (Local3)
                    }

                    Device (C152)
                    {
                        Name (_HID, "PNP0501")
                        Name (_CID, 0x0005D041)
                        Name (_DDN, "COM1")
                        Name (C153, 0x00)
                        Name (C154, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (C154)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            If (C153)
                            {
                                Store (0x0D, Local0)
                            }
                            Else
                            {
                                Store (C149 (0x03, 0x02), Local0)
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            If (LOr (\_SB.C024, LEqual (0x00, 0x01)))
                            {
                                Store (0x01, C153)
                                Return (0x00)
                            }

                            C14A (0x03)
                            Return (0x00)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x02, C150)
                            CreateWordField (Arg0, 0x09, C155)
                            If (C149 (0x03, 0x02))
                            {
                                _DIS ()
                                \_SB.C0E1 (0x03, C150, 0x00, C155, 0x00)
                                C146 (0x03, C150, 0x00, C155, 0x00)
                            }

                            Store (0x00, C153)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (C00D, ResourceTemplate ()
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                            })
                            CreateWordField (C00D, 0x02, C150)
                            CreateWordField (C00D, 0x04, C151)
                            CreateWordField (C00D, 0x09, C155)
                            If (C153)
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Store (C149 (0x03, 0x02), Local0)
                            }

                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, C150)
                                Store (0x00, C151)
                                Store (0x00, C155)
                                Return (C00D)
                            }

                            Store (C144 (0x03), Local1)
                            Store (DerefOf (Index (Local1, 0x00)), C150)
                            Store (C150, C151)
                            Store (DerefOf (Index (Local1, 0x02)), C155)
                            Return (C00D)
                        }

                        PowerResource (C156, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)
                            {
                                Return (C147 (0x03))
                            }

                            Method (_ON, 0, NotSerialized)
                            {
                                C148 (0x03, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)
                            {
                                If (LOr (\_SB.C024, LEqual (0x00, 0x01)))
                                {
                                    Return (0x00)
                                }

                                C148 (0x03, 0x00)
                            }
                        }

                        Name (_PR0, Package (0x01)
                        {
                            C156
                        })
                    }

                    Device (C157)
                    {
                        Name (_HID, "PNP0700")
                        Device (C158)
                        {
                            Name (_ADR, 0x00)
                            Name (_FDI, Package (0x10)
                            {
                                0x00,=20
                                0x04,=20
                                0x4F,=20
                                0x12,=20
                                0x01,=20
                                0xDF,=20
                                0x02,=20
                                0x25,=20
                                0x02,=20
                                0x12,=20
                                0x1B,=20
                                0xFF,=20
                                0x65,=20
                                0xF6,=20
                                0x0F,=20
                                0x08
                            })
                        }

                        Device (C159)
                        {
                            Name (_ADR, 0x01)
                            Name (_FDI, Package (0x10)
                            {
                                0x01,=20
                                0x04,=20
                                0x4F,=20
                                0x12,=20
                                0x01,=20
                                0xDF,=20
                                0x02,=20
                                0x25,=20
                                0x02,=20
                                0x12,=20
                                0x1B,=20
                                0xFF,=20
                                0x65,=20
                                0xF6,=20
                                0x0F,=20
                                0x08
                            })
                        }

                        Name (C154, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) =
{2}
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (C154)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            Store (C149 (0x00, 0x08), Local0)
                            If (LEqual (And (C025, 0x08), 0x00))
                            {
                                If (LOr (LEqual (C00B, 0x01), LEqual (C00=
B, 0x02)))
                                {
                                    Store (0x0F, Local0)
                                }
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            C14A (0x00)
                        }

                        OperationRegion (C15A, SystemIO, 0x03F0, 0x08)
                        Field (C15A, AnyAcc, NoLock, Preserve)
                        {
                            C15B,   8,=20
                            C15C,   8,=20
                            C15D,   8,=20
                            C15E,   8,=20
                            C15F,   8,=20
                            C160,   8,=20
                            C161,   8,=20
                            C162,   8
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x02, C150)
                            CreateWordField (Arg0, 0x0A, C163)
                            CreateWordField (Arg0, 0x11, C155)
                            CreateWordField (Arg0, 0x14, C164)
                            If (C149 (0x00, 0x08))
                            {
                                _DIS ()
                                \_SB.C0E1 (0x00, C150, C163, C155, C164)
                                C146 (0x00, C150, C163, C155, C164)
                                \_SB.C165 (0x01)
                                If (LOr (LEqual (C00B, 0x01), LEqual (C00=
B, 0x02)))
                                {
                                    Store (Or (C15D, 0x04), C15D)
                                }
                            }
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (C00D, ResourceTemplate ()
                            {
                                IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                                IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                                IRQNoFlags () {6}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {2}
                            })
                            CreateWordField (C00D, 0x02, C150)
                            CreateWordField (C00D, 0x04, C151)
                            CreateWordField (C00D, 0x0A, C163)
                            CreateWordField (C00D, 0x0C, C169)
                            CreateWordField (C00D, 0x11, C155)
                            CreateWordField (C00D, 0x14, C164)
                            If (LEqual (C149 (0x00, 0x08), 0x00))
                            {
                                If (LEqual (And (C025, 0x08), 0x00))
                                {
                                    If (LOr (LEqual (C00B, 0x01), LEqual =
(C00B, 0x02)))
                                    {
                                        Return (C00D)
                                    }
                                }
                                Else
                                {
                                    Store (0x00, C150)
                                    Store (0x00, C151)
                                    Store (0x00, C163)
                                    Store (0x00, C169)
                                    Store (0x00, C155)
                                    Store (0x00, C164)
                                    Return (C00D)
                                }
                            }

                            Store (C144 (0x00), Local1)
                            Store (DerefOf (Index (Local1, 0x00)), C150)
                            Store (C150, C151)
                            Add (C150, 0x07, C163)
                            Store (C163, C169)
                            Store (DerefOf (Index (Local1, 0x02)), C155)
                            Store (DerefOf (Index (Local1, 0x03)), C164)
                            Return (C00D)
                        }

                        PowerResource (C16A, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)
                            {
                                Return (C147 (0x00))
                            }

                            Method (_ON, 0, NotSerialized)
                            {
                                C148 (0x00, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)
                            {
                                C148 (0x00, 0x00)
                            }
                        }

                        Name (_PR0, Package (0x01)
                        {
                            C16A
                        })
                        Scope (C158)
                        {
                            Method (_STA, 0, NotSerialized)
                            {
                                If (LEqual (\_SB.C028, 0x00))
                                {
                                    Store (0x00, Local0)
                                    If (LEqual (\_SB.C0E2 (), 0x02))
                                    {
                                        Store (0x0F, Local0)
                                    }

                                    Return (Local0)
                                }
                                Else
                                {
                                    Return (0x0F)
                                }
                            }
                        }

                        Method (_FDE, 0, NotSerialized)
                        {
                            Name (C16B, Buffer (0x14)
                            {
                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,=
 0x00,=20
                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,=
 0x00,=20
                                0x02, 0x00, 0x00, 0x00
                            })
                            CreateDWordField (C16B, 0x00, C16C)
                            Store (^C158._STA (), Local0)
                            If (LEqual (Local0, 0x0F))
                            {
                                Store (0x01, C16C)
                            }

                            Return (C16B)
                        }
                    }

                    Device (C16D)
                    {
                        Name (_HID, "NSC6001")
                        Name (_CID, 0x1105D041)
                        Name (C154, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {3,4,5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {3,4,5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {3,4,5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {3,4,5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {1,3}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (C154)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            Return (C149 (0x02, 0x01))
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            C14A (0x02)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x02, C150)
                            CreateWordField (Arg0, 0x09, C155)
                            CreateWordField (Arg0, 0x0C, C164)
                            If (C149 (0x02, 0x01))
                            {
                                ^_DIS ()
                                \_SB.C0E1 (0x02, C150, 0x00, C155, C164)
                                ^^C146 (0x02, C150, 0x00, C155, C164)
                            }
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (C00D, ResourceTemplate ()
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {1}
                            })
                            CreateWordField (C00D, 0x02, C150)
                            CreateWordField (C00D, 0x04, C151)
                            CreateWordField (C00D, 0x09, C155)
                            CreateWordField (C00D, 0x0C, C164)
                            If (LEqual (C149 (0x02, 0x01), 0x00))
                            {
                                Store (0x00, C150)
                                Store (0x00, C151)
                                Store (0x00, C155)
                                Store (0x00, C164)
                                Return (C00D)
                            }

                            Store (C144 (0x02), Local1)
                            Store (DerefOf (Index (Local1, 0x00)), C150)
                            Store (C150, C151)
                            Store (DerefOf (Index (Local1, 0x02)), C155)
                            Store (DerefOf (Index (Local1, 0x03)), C164)
                            Return (C00D)
                        }

                        PowerResource (C16E, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)
                            {
                                Return (C147 (0x02))
                            }

                            Method (_ON, 0, NotSerialized)
                            {
                                C148 (0x02, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)
                            {
                                C148 (0x02, 0x00)
                            }
                        }

                        Name (_PR0, Package (0x01)
                        {
                            C16E
                        })
                    }

                    Device (C16F)
                    {
                        Name (_HID, "PNP0401")
                        Name (C170, 0x00)
                        Name (C154, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {1,3}
                            }
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (C154)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            If (C170)
                            {
                                Store (0x0D, Local0)
                            }
                            Else
                            {
                                Store (C149 (0x01, 0x04), Local0)
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            If (\_SB.C027)
                            {
                                Store (0x01, C170)
                                Return (0x00)
                            }

                            C14A (0x01)
                            Return (0x00)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x02, C150)
                            CreateWordField (Arg0, 0x0A, C163)
                            CreateWordField (Arg0, 0x11, C155)
                            CreateWordField (Arg0, 0x14, C164)
                            If (C149 (0x01, 0x04))
                            {
                                _DIS ()
                                \_SB.C0E1 (0x01, C150, C163, C155, C164)
                                C146 (0x01, C150, C163, C155, C164)
                            }

                            Store (0x00, C170)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (C00D, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x03)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfe=
r8) {3}
                            })
                            CreateWordField (C00D, 0x02, C150)
                            CreateWordField (C00D, 0x04, C151)
                            CreateByteField (C00D, 0x07, C171)
                            CreateWordField (C00D, 0x0A, C163)
                            CreateWordField (C00D, 0x0C, C169)
                            CreateWordField (C00D, 0x11, C155)
                            CreateWordField (C00D, 0x14, C164)
                            If (C170)
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Store (C149 (0x01, 0x04), Local0)
                            }

                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, C150)
                                Store (0x00, C151)
                                Store (0x00, C163)
                                Store (0x00, C169)
                                Store (0x00, C155)
                                Store (0x00, C164)
                                Return (C00D)
                            }

                            Store (C144 (0x01), Local1)
                            Store (DerefOf (Index (Local1, 0x00)), C150)
                            Store (C150, C151)
                            If (LEqual (C150, 0x03BC))
                            {
                                Store (0x04, C171)
                            }

                            Add (C150, 0x0400, C163)
                            Store (C163, C169)
                            Store (DerefOf (Index (Local1, 0x02)), C155)
                            Store (DerefOf (Index (Local1, 0x03)), C164)
                            Return (C00D)
                        }

                        PowerResource (C172, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)
                            {
                                Return (C147 (0x01))
                            }

                            Method (_ON, 0, NotSerialized)
                            {
                                C148 (0x01, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)
                            {
                                If (LOr (\_SB.C027, LEqual (0x00, 0x01)))
                                {
                                    Return (0x00)
                                }

                                C148 (0x01, 0x00)
                            }
                        }

                        Name (_PR0, Package (0x01)
                        {
                            C172
                        })
                    }

                    Method (\_SB.C173, 0, NotSerialized)
                    {
                        Store (\_SB.C047.C05A.C136.C143 (0x03), Local0)
                        Return (Local0)
                    }

                    Method (\_SB.C14D, 0, NotSerialized)
                    {
                        Store (0x01, Local0)
                        If (Not (And (\_SB.C025, 0x10)))
                        {
                            Store (0x00, Local0)
                        }

                        Return (Local0)
                    }

                    Method (\_SB.C165, 1, NotSerialized)
                    {
                        Return (0x00)
                    }
                }

                Device (C174)
                {
                    Name (_HID, "PNP0C04")
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x10)
                        IRQNoFlags () {13}
                    })
                }

                Device (C175)
                {
                    Name (_HID, "PNP0100")
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQNoFlags () {0}
                    })
                }

                Device (C164)
                {
                    Name (_HID, "PNP0200")
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x10)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer16) {4}
                    })
                }

                Device (C176)
                {
                    Name (_HID, "PNP0800")
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                    })
                }

                Device (C177)
                {
                    Name (_HID, "PNP0B00")
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x02)
                        IO (Decode16, 0x0072, 0x0072, 0x01, 0x02)
                        IRQNoFlags () {8}
                    })
                }

                Device (C178)
                {
                    Name (_HID, "PNP0303")
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQNoFlags () {1}
                    })
                }

                Device (C179)
                {
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Name (C17A, 0x01)
                    PowerResource (C17B, 0x00, 0x0000)
                    {
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (C17A)
                        }

                        Method (_ON, 0, NotSerialized)
                        {
                            Store (0x01, C17A)
                        }

                        Method (_OFF, 0, NotSerialized)
                        {
                            Store (0x00, C17A)
                        }
                    }

                    Name (_PR0, Package (0x01)
                    {
                        C17B
                    })
                }

                Scope (C178)
                {
                    Name (_PRW, Package (0x02)
                    {
                        0x1C,=20
                        0x03
                    })
                    Method (_PSW, 1, NotSerialized)
                    {
                        Acquire (\_SB.C047.C05A.C0E5.C0E6, 0xFFFF)
                        And (\_SB.C047.C05A.C0E5.C0E7, 0xFE, Local0)
                        And (Arg0, 0x01, Local1)
                        Or (Local0, Local1, \_SB.C047.C05A.C0E5.C0E7)
                        If (\_SB.C047.C05A.C0E5.C0E8)
                        {
                            Store (Arg0, \_SB.C047.C05A.C0E5.C0ED)
                        }

                        Release (\_SB.C047.C05A.C0E5.C0E6)
                    }
                }

                Scope (C179)
                {
                    Name (_HID, "SYN0100")
                    Name (_CID, Package (0x02)
                    {
                        0x02002E4F,=20
                        0x130FD041
                    })
                    Name (_PRW, Package (0x02)
                    {
                        0x1C,=20
                        0x03
                    })
                    Method (_PSW, 1, NotSerialized)
                    {
                        Acquire (\_SB.C047.C05A.C0E5.C0E6, 0xFFFF)
                        And (\_SB.C047.C05A.C0E5.C0E7, 0xFD, Local0)
                        ShiftLeft (And (Arg0, 0x01), 0x01, Local1)
                        Or (Local0, Local1, \_SB.C047.C05A.C0E5.C0E7)
                        If (\_SB.C047.C05A.C0E5.C0E8)
                        {
                            Store (Arg0, \_SB.C047.C05A.C0E5.C0EE)
                        }

                        Release (\_SB.C047.C05A.C0E5.C0E6)
                    }
                }

                Device (C17C)
                {
                    Name (_HID, "PNP0000")
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IRQNoFlags () {2}
                    })
                }
            }

            Scope (C059)
            {
                Device (C17D)
                {
                    Name (_ADR, 0x00060000)
                    OperationRegion (C17E, PCI_Config, 0x44, 0x04)
                    Field (C17E, AnyAcc, NoLock, Preserve)
                    {
                        C17F,   32
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Store (0x00, C17F)
                    }
                }

                Device (C180)
                {
                    Name (_ADR, 0x00040000)
                }

                Device (C181)
                {
                    Name (_ADR, 0x00040001)
                }

                Device (C0AB)
                {
                    Name (_ADR, 0x000E0000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,=20
                        0x03
                    })
                    Name (_S3D, 0x03)
                    Device (C0AF)
                    {
                        Name (_ADR, 0x00)
                        Device (C0B0)
                        {
                            Name (_ADR, 0x00)
                        }

                        Device (C0B2)
                        {
                            Name (_ADR, 0x01)
                        }

                        Device (C0B5)
                        {
                            Name (_ADR, 0x02)
                        }
                    }
                }

                Device (C0B1)
                {
                    Name (_ADR, 0x000E0001)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,=20
                        0x03
                    })
                    Name (_S3D, 0x03)
                    Device (C0AF)
                    {
                        Name (_ADR, 0x00)
                        Device (C0B0)
                        {
                            Name (_ADR, 0x00)
                        }

                        Device (C0B2)
                        {
                            Name (_ADR, 0x01)
                        }
                    }
                }

                Device (C0B4)
                {
                    Name (_ADR, 0x000E0002)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,=20
                        0x03
                    })
                    Name (_S3D, 0x03)
                    Device (C0AF)
                    {
                        Name (_ADR, 0x00)
                        Device (C0B0)
                        {
                            Name (_ADR, 0x00)
                        }

                        Device (C0B2)
                        {
                            Name (_ADR, 0x01)
                        }

                        Device (C0B5)
                        {
                            Name (_ADR, 0x02)
                        }

                        Device (C0B6)
                        {
                            Name (_ADR, 0x03)
                        }

                        Device (C0B7)
                        {
                            Name (_ADR, 0x04)
                        }
                    }
                }

                Device (C182)
                {
                    Name (_ADR, 0x00080000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,=20
                        0x05
                    })
                    OperationRegion (C183, PCI_Config, 0x00, 0xFF)
                    Field (C183, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0xE0),=20
                        Offset (0xE1),=20
                        C184,   1
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (\_SB.C047.C059.C182.C184, Local0)
                        Acquire (\_SB.C047.C05A.C0E5.C0E6, 0xFFFF)
                        If (\_SB.C047.C05A.C0E5.C0E8)
                        {
                            Store (Local0, \_SB.C047.C05A.C0E5.C0F4)
                        }

                        Release (\_SB.C047.C05A.C0E5.C0E6)
                    }

                    Method (_PS0, 0, NotSerialized)
                    {
                    }
                }
            }

            Scope (C098)
            {
                Device (C185)
                {
                    Name (_ADR, 0x00)
                    Name (C186, Package (0x05)
                    {
                        0x00,=20
                        0x00,=20
                        0x00,=20
                        0x00,=20
                        0x00
                    })
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (Buffer (0x14)
                            {
                                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,=
 0xFF,=20
                                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,=
 0xFF,=20
                                0xFF, 0xFF, 0xFF, 0xFF
                            }, Local0)
                        CreateDWordField (Local0, 0x00, C187)
                        CreateDWordField (Local0, 0x04, C188)
                        CreateDWordField (Local0, 0x10, C189)
                        Store (C0A0 (0x00, 0x00), C187)
                        Store (C0A3 (0x00), C189)
                        If (And (C189, 0x01))
                        {
                            Store (C0A2 (0x00, 0x00), C188)
                        }
                        Else
                        {
                            Store (C187, C188)
                        }

                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, 0x00, C187)
                        CreateDWordField (Arg0, 0x04, C188)
                        CreateDWordField (Arg0, 0x10, C189)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            Store (0x00, Local0)
                            Store (Buffer (Multiply (SizeOf (C18A), 0x02)=
) {}, Local1)
                            While (LLess (Local0, SizeOf (C18A)))
                            {
                                Store (DerefOf (Index (C18A, Local0)), Lo=
cal2)
                                Multiply (Local2, 0x02, Local2)
                                Multiply (Local0, 0x02, Local3)
                                Store (DerefOf (Index (Arg1, Local2)), In=
dex (Local1, Local3))
                                Store (DerefOf (Index (Arg1, Add (Local2,=
 0x01))), Index (Local1, Add (Local3, 0x01)))
                                Increment (Local0)
                            }

                            Store (C0A4 (0x00, 0x00, C187, C189, Local1),=
 Local2)
                            Store (C0A8 (0x00, 0x00, C188, C189, Local1),=
 Local3)
                            \_SB.C18B (Local2, Local3, Local1, C186)
                            If (\_SB.C18C)
                            {
                                Store (0x00, \_SB.C18C)
                                If (And (DerefOf (Index (Arg1, 0x0100)), =
0x02))
                                {
                                    \_SB.C0D9 (0xEA49, 0x0C, 0x00, 0x00, =
0x00)
                                }
                            }
                        }
                    }

                    Device (C158)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (\_SB.C18D (C186, 0x00))
                        }
                    }
                }

                Device (C18E)
                {
                    Name (_ADR, 0x01)
                    Name (C18F, Package (0x05)
                    {
                        0x00,=20
                        0x00,=20
                        0x00,=20
                        0x00,=20
                        0x00
                    })
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (Buffer (0x14)
                            {
                                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,=
 0xFF,=20
                                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,=
 0xFF,=20
                                0xFF, 0xFF, 0xFF, 0xFF
                            }, Local0)
                        CreateDWordField (Local0, 0x00, C187)
                        CreateDWordField (Local0, 0x04, C188)
                        CreateDWordField (Local0, 0x10, C189)
                        Store (C0A0 (0x01, 0x00), C187)
                        Store (C0A3 (0x01), C189)
                        If (And (C189, 0x01))
                        {
                            Store (C0A2 (0x01, 0x00), C188)
                        }
                        Else
                        {
                            Store (C187, C188)
                        }

                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        If (LEqual (And (\_SB.C0E2 (), 0x0F), 0x01))
                        {
                            CreateDWordField (Arg0, 0x00, C187)
                            CreateDWordField (Arg0, 0x04, C188)
                            CreateDWordField (Arg0, 0x10, C189)
                            If (LEqual (SizeOf (Arg1), 0x0200))
                            {
                                Store (0x00, Local0)
                                Store (Buffer (Multiply (SizeOf (C18A), 0=
x02)) {}, Local1)
                                While (LLess (Local0, SizeOf (C18A)))
                                {
                                    Store (DerefOf (Index (C18A, Local0))=
, Local2)
                                    Multiply (Local2, 0x02, Local2)
                                    Multiply (Local0, 0x02, Local3)
                                    Store (DerefOf (Index (Arg1, Local2))=
, Index (Local1, Local3))
                                    Store (DerefOf (Index (Arg1, Add (Loc=
al2, 0x01))), Index (Local1, Add (Local3, 0x01)))
                                    Increment (Local0)
                                }

                                Store (C0A4 (0x01, 0x00, C187, C189, Loca=
l1), Local2)
                                Store (C0A8 (0x01, 0x00, C188, C189, Loca=
l1), Local3)
                                \_SB.C18B (Local2, Local3, Local1, C18F)
                                If (And (DerefOf (Index (Arg1, 0x0100)), =
0x04))
                                {
                                    \_SB.C0D9 (0xEA49, 0x0C, 0x01, 0x00, =
0x00)
                                }
                            }
                        }
                    }

                    Device (C158)
                    {
                        Name (_ADR, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, Local0)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x00, Local0)
                        }

                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (\_SB.C18D (C18F, 0x00))
                        }
                    }
                }

                Method (C0AA, 2, NotSerialized)
                {
                    Store (0x02, Local0)
                    If (LAnd (LEqual (Arg0, 0x00), LEqual (Arg1, 0x00)))
                    {
                        Store (0x05, Local0)
                    }

                    Return (Local0)
                }
            }

            Name (C0C1._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {5,10,11}
            })
            Name (C0C2._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {5,10,11}
            })
            Name (C0C3._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {5,10,11}
            })
            Name (C0C4._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {5,10,11}
            })
            Name (C0C5._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {5,10,11}
            })
            Name (C0C6._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {}
            })
            Name (C0C7._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {}
            })
            Name (C0C8._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {}
            })
            Name (_PRT, Package (0x02)
            {
                Package (0x04)
                {
                    0x001FFFFF,=20
                    0x00,=20
                    C0C3,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x001FFFFF,=20
                    0x01,=20
                    C0C2,=20
                    0x00
                }
            })
            Name (C048._PRT, Package (0x01)
            {
                Package (0x04)
                {
                    0xFFFF,=20
                    0x00,=20
                    C0C1,=20
                    0x00
                }
            })
            Name (C059._PRT, Package (0x08)
            {
                Package (0x04)
                {
                    0x0004FFFF,=20
                    0x00,=20
                    C0C2,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0004FFFF,=20
                    0x02,=20
                    C0C2,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0005FFFF,=20
                    0x00,=20
                    C0C3,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0006FFFF,=20
                    0x00,=20
                    C0C4,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x0008FFFF,=20
                    0x00,=20
                    C0C5,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x000EFFFF,=20
                    0x00,=20
                    C0C5,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x000EFFFF,=20
                    0x01,=20
                    C0C5,=20
                    0x00
                },=20

                Package (0x04)
                {
                    0x000EFFFF,=20
                    0x02,=20
                    C0C5,=20
                    0x00
                }
            })
        }

        Name (C12A, Package (0x02)
        {
            Package (0x0D)
            {
                0x01,=20
                0xFFFFFFFF,=20
                0xFFFFFFFF,=20
                0x01,=20
                0xFFFFFFFF,=20
                0x00,=20
                0x00,=20
                0x64,=20
                0x64,=20
                "Primary",=20
                "100000",=20
                "LIon",=20
                " COMPAQ "
            },=20

            Package (0x0D)
            {
                0x01,=20
                0xFFFFFFFF,=20
                0xFFFFFFFF,=20
                0x01,=20
                0xFFFFFFFF,=20
                0x00,=20
                0x00,=20
                0x64,=20
                0x64,=20
                "MultiBay",=20
                "100000",=20
                "LIon",=20
                " COMPAQ "
            }
        })
        Name (C129, Package (0x02)
        {
            Package (0x04)
            {
                0x00,=20
                0x00,=20
                0xB010,=20
                0x40F2
            },=20

            Package (0x04)
            {
                0x00,=20
                0x00,=20
                0xB010,=20
                0x40F2
            }
        })
        Name (C128, Package (0x04)
        {
            0x00,=20
            0x00,=20
            0xB010,=20
            0x40F2
        })
        Method (C127, 1, Serialized)
        {
            Store (\_SB.C047.C05A.C0E5.C127 (Arg0), Local0)
            If (LEqual (Local0, 0xFFFFFFFD))
            {
                Return (Package (0x0D)
                {
                    0x00,=20
                    0xFFFFFFFF,=20
                    0xFFFFFFFF,=20
                    0x01,=20
                    0xFFFFFFFF,=20
                    0x00,=20
                    0x00,=20
                    0x00,=20
                    0x00,=20
                    "",=20
                    "",=20
                    "",=20
                    0x00
                })
            }
            Else
            {
                Return (DerefOf (Index (C12A, Arg0)))
            }
        }

        Name (C190, 0x01)
        Method (C12D, 1, Serialized)
        {
            Store (\_SB.C047.C05A.C0E0 (C190), Local1)
            If (C190)
            {
                Store (0x00, C190)
            }

            Store (\_SB.C047.C05A.C0E5.C12D (Arg0, Local1), Local0)
            Return (DerefOf (Index (C129, Arg0)))
        }

        Device (C133)
        {
            Name (_HID, "PNP0C0A")
            Name (_UID, 0x01)
            Method (_STA, 0, NotSerialized)
            {
                Return (\_SB.C047.C05A.C0E5.C126 (0x01))
            }

            Method (_BIF, 0, NotSerialized)
            {
                Return (C127 (0x00))
            }

            Method (_BST, 0, NotSerialized)
            {
                Return (C12D (0x00))
            }

            Name (_PCL, Package (0x01)
            {
                \_SB
            })
        }

        Device (C132)
        {
            Name (_HID, "PNP0C0A")
            Name (_UID, 0x02)
            Method (_STA, 0, NotSerialized)
            {
                Store (0x00, Local0)
                If (LEqual (\_SB.C028, 0x00))
                {
                    Store (\_SB.C047.C05A.C0E5.C126 (0x02), Local0)
                }

                Return (Local0)
            }

            Method (_BIF, 0, NotSerialized)
            {
                Return (C127 (0x01))
            }

            Method (_BST, 0, NotSerialized)
            {
                Return (C12D (0x01))
            }

            Name (_PCL, Package (0x01)
            {
                \_SB
            })
        }

        Device (C131)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Method (_PSR, 0, NotSerialized)
            {
                Store (\_SB.C047.C05A.C0E5.C124 (), Local0)
                Return (Local0)
            }
        }

        Device (C191)
        {
            Name (_HID, "PNP0C0C")
            Name (_PRW, Package (0x02)
            {
                0x1C,=20
                0x04
            })
        }

        Device (C135)
        {
            Name (_HID, "PNP0C0E")
            Name (_PRW, Package (0x02)
            {
                0x1C,=20
                0x04
            })
        }

        Device (C134)
        {
            Name (_HID, "PNP0C0D")
            Method (_LID, 0, NotSerialized)
            {
                Store (0x00, Local0)
                If (And (\_SB.C047.C05A.C086, 0x02))
                {
                    Store (0x01, Local0)
                }

                Return (Local0)
            }
        }

        Name (C18A, Buffer (0x08)
        {
            0x2F, 0x31, 0x35, 0x3F, 0x40, 0x53, 0x58, 0x80
        })
        Name (C18C, 0x00)
        Method (C18B, 4, NotSerialized)
        {
            CreateWordField (Arg2, 0x00, C192)
            CreateWordField (Arg2, 0x06, C193)
            CreateWordField (Arg2, 0x0A, C194)
            CreateWordField (Arg2, 0x0E, C195)
            Store (0x00, Local0)
            While (LLess (Local0, SizeOf (Arg3)))
            {
                Store (0x00, Index (Arg3, Local0))
                Increment (Local0)
            }

            Store (Arg0, Local0)
            Store (Arg1, Local1)
            If (LEqual (Local1, 0x00))
            {
                If (And (C193, 0x01))
                {
                    Store (0x20, Local1)
                    If (LAnd (LEqual (And (Local0, 0x07), 0x03), And (C19=
3, 0x02)))
                    {
                        Or (Local1, 0x01, Local1)
                    }
                    Else
                    {
                        If (LAnd (LEqual (And (Local0, 0x07), 0x04), And =
(C193, 0x04)))
                        {
                            Or (Local1, 0x02, Local1)
                        }
                    }
                }
            }

            Store (Local0, Index (Arg3, 0x00))
            Store (Local1, Index (Arg3, 0x01))
            If (And (C195, 0x01))
            {
                Store (0x01, Index (Arg3, 0x02))
            }

            If (And (C194, 0x0800))
            {
                Store (0x01, Index (Arg3, 0x03))
            }

            If (LNot (LEqual (C192, 0x00)))
            {
                Store (C192, Index (Arg3, 0x04))
            }
        }

        Method (C196, 3, NotSerialized)
        {
            If (LOr (LEqual (Arg0, 0x00), LEqual (Arg0, 0x01)))
            {
                Store (Buffer (0x07)
                    {
                        0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEF
                    }, Local0)
                Store (Arg1, Index (Local0, 0x01))
            }

            If (LEqual (Arg0, 0x02))
            {
                Store (Buffer (0x07)
                    {
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF5
                    }, Local0)
            }

            If (LEqual (Arg0, 0x03))
            {
                Store (Buffer (0x07)
                    {
                        0xC1, 0x00, 0x00, 0x00, 0x00, 0x00, 0xB1
                    }, Local0)
            }

            If (LEqual (Arg0, 0x04))
            {
                Store (Buffer (0x07)
                    {
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC6
                    }, Local0)
                Store (Arg1, Index (Local0, 0x01))
            }

            Store (Or (0xA0, ShiftLeft (Arg2, 0x04)), Index (Local0, 0x05=
))
            Return (Local0)
        }

        Method (C18D, 2, NotSerialized)
        {
            Store (0x00, Local0)
            While (LLess (Local0, SizeOf (Arg0)))
            {
                If (LNot (LEqual (DerefOf (Index (Arg0, Local0)), 0x00)))
                {
                    Store (C196 (Local0, DerefOf (Index (Arg0, Local0)), =
Arg1), Local2)
                    If (LEqual (Local0, 0x00))
                    {
                        Store (Local2, Local1)
                    }
                    Else
                    {
                        Concatenate (Local1, Local2, Local3)
                        Store (Local3, Local1)
                    }
                }

                Increment (Local0)
            }

            Return (Local1)
        }

        Method (C197, 2, NotSerialized)
        {
            Add (Multiply (Arg0, 0x02), Arg1, Local0)
            XOr (ShiftRight (C041, 0x06), 0x03, Local1)
            XOr (ShiftRight (C045, 0x06), 0x03, Local2)
            If (LEqual (Local0, Local1))
            {
                Return (0x01)
            }

            If (LEqual (Local0, Local2))
            {
                Return (0x05)
            }

            Return (0xFF)
        }

        Mutex (C198, 0x00)
        Method (C0D9, 5, NotSerialized)
        {
            Acquire (C198, 0xFFFF)
            If (Arg4)
            {
                Acquire (\_GL, 0xFFFF)
            }

            ShiftLeft (Arg0, 0x10, C039)
            Store (Arg1, C03C)
            Store (Arg2, C03A)
            Store (Arg3, C03B)
            Store (0x00, C03D)
            \C0C9 (Arg0)
            Store (C03D, Local0)
            If (Arg4)
            {
                Release (\_GL)
            }

            Release (C198)
            Return (Local0)
        }

        OperationRegion (C199, SystemIO, 0x84, 0x02)
        Field (C199, ByteAcc, NoLock, Preserve)
        {
            C19A,   8,=20
            C19B,   8
        }

        Mutex (C19C, 0x00)
        Method (C1A6, 1, NotSerialized)
        {
            Acquire (C19C, 0xFFFF)
            Store (Arg0, C19A)
            Release (C19C)
            Return (0x00)
        }

        Method (C1A9, 1, NotSerialized)
        {
            Acquire (C19C, 0xFFFF)
            Store (Arg0, C19B)
            Release (C19C)
            Return (0x00)
        }

        Method (C1AA, 1, NotSerialized)
        {
            Acquire (C19C, 0xFFFF)
            Store (And (Arg0, 0xFF), C19A)
            Store (And (ShiftRight (Arg0, 0x08), 0xFF), C19B)
            Release (C19C)
            Return (0x00)
        }

        Method (C1A8, 1, NotSerialized)
        {
            Return (0x00)
        }

        Method (C1AB, 1, NotSerialized)
        {
            Return (0x00)
        }

        Method (C1A7, 0, NotSerialized)
        {
            Return (0x00)
        }
    }

    Device (\_SB.C1AE)
    {
        Name (_HID, "PNP0C02")
        Name (_UID, 0x00)
        Name (C1AF, Package (0x10) {})
        Name (C1B0, Package (0x10) {})
        Name (C1B1, Package (0x11) {})
        Name (C1B2, Package (0x11) {})
        Name (C1B3, 0xFFFFFFFD)
        Mutex (C1B4, 0x00)
        Method (C1B5, 0, NotSerialized)
        {
            Add (\_SB.C01C, 0x000F0000, Local0)
            Return (Local0)
        }

        OperationRegion (C1B6, SystemMemory, C1B5, 0xB0)
        Field (C1B6, AnyAcc, NoLock, Preserve)
        {
            C1B7,   640
        }

        Method (C1B8, 1, NotSerialized)
        {
            OperationRegion (C1B9, SystemMemory, Arg0, 0x03)
            Field (C1B9, ByteAcc, NoLock, Preserve)
            {
                C1BA,   16,=20
                C1BB,   8
            }

            Store (0x00, Local0)
            If (LEqual (C1BA, 0xAA55))
            {
                ShiftLeft (C1BB, 0x09, Local0)
                Add (Arg0, Local0, Local0)
                Decrement (Local0)
            }

            Return (Local0)
        }

        Method (C1BC, 0, NotSerialized)
        {
            Store (C1B7, Local0)
            Store (0x00, Local3)
            Store (0x00, Local4)
            Store (0x01, Local1)
            While (LAnd (Local1, LNot (LGreater (Local3, 0x10))))
            {
                Store (DerefOf (Index (Local0, Add (Local4, 0x03))), Loca=
l2)
                Or (ShiftLeft (DerefOf (Index (Local0, Add (Local4, 0x04)=
)), 0x08), Local2, Local1)
                ShiftLeft (Local1, 0x04, Local1)
                If (Local1)
                {
                    Store (Local1, Index (C1AF, Local3))
                    Store (DerefOf (Index (Local0, Add (Local4, 0x02))), =
Local5)
                    Add (Local1, ShiftLeft (Local5, 0x09), Local5)
                    Decrement (Local5)
                    Store (Local5, Index (C1B0, Local3))
                    Increment (Local3)
                    Add (Local4, 0x05, Local4)
                }
            }

            Return (Local3)
        }

        Method (C1BD, 0, NotSerialized)
        {
            Store (C1BC (), Local3)
            Store (Local3, Local4)
            Store (0x00, Local2)
            Store (Local2, Local7)
            While (LLess (Local2, Local4))
            {
                Store (0x000FFFFF, Local1)
                Store (Local2, Local5)
                While (LLess (Local5, Local3))
                {
                    Store (DerefOf (Index (C1AF, Local5)), Local6)
                    If (LGreater (Local6, Local7))
                    {
                        If (LLess (Local6, Local1))
                        {
                            Store (Local5, Local0)
                            Store (Local6, Local1)
                        }
                    }
                    Else
                    {
                        If (LEqual (Local6, Local7))
                        {
                            Decrement (Local4)
                        }
                    }

                    Increment (Local5)
                }

                If (LGreater (Local0, Local2))
                {
                    Store (DerefOf (Index (C1B0, Local0)), Local7)
                    Store (DerefOf (Index (C1AF, Local2)), Index (C1AF, L=
ocal0))
                    Store (DerefOf (Index (C1B0, Local2)), Index (C1B0, L=
ocal0))
                    Store (Local1, Index (C1AF, Local2))
                    Store (Local7, Index (C1B0, Local2))
                }

                Store (C1B8 (Local1), Local7)
                If (Local7)
                {
                    Store (Local7, Index (C1B0, Local2))
                }

                Store (Local1, Local7)
                Increment (Local2)
            }

            Return (Local4)
        }

        Method (C1BE, 1, NotSerialized)
        {
            Acquire (C04D, 0xFFFF)
            Store (0x00, Local0)
            Store (Local0, C1B3)
            Store (Local0, Local2)
            Store (Local0, Local3)
            While (LNot (LGreater (Local0, 0x10)))
            {
                Store (Local2, Index (C1B1, Local0))
                Store (Local2, Index (C1B2, Local0))
                Increment (Local0)
            }

            Store (ShiftLeft (C015, 0x04), Local0)
            Store (Local0, Index (C04F, C04E))
            Store (Local0, Index (C050, C04E))
            Store (Local0, Index (C1AF, Arg0))
            Store (Local0, Index (C1B0, Arg0))
            While (LAnd (LNot (LGreater (Local2, Arg0)), LNot (LGreater (=
Local3, C04E))))
            {
                Store (DerefOf (Index (C04F, Local3)), Local0)
                Add (DerefOf (Index (C050, Local3)), 0x01, Local1)
                Store (DerefOf (Index (C1AF, Local2)), Local4)
                Add (DerefOf (Index (C1B0, Local2)), 0x01, Local5)
                Store (DerefOf (Index (C1B1, C1B3)), Local6)
                If (LNot (LGreater (Local1, Local4)))
                {
                    If (Local6)
                    {
                        Subtract (Local0, Local6, Index (C1B2, C1B3))
                        Increment (C1B3)
                    }

                    If (LLess (Local1, Local4))
                    {
                        Store (Local1, Index (C1B1, C1B3))
                    }

                    Increment (Local3)
                }
                Else
                {
                    If (Local6)
                    {
                        Subtract (Local4, Local6, Local7)
                        If (LGreater (Local7, 0x00))
                        {
                            Store (Local7, Index (C1B2, C1B3))
                            Increment (C1B3)
                        }
                    }

                    If (LGreater (Local0, Local5))
                    {
                        Store (Local5, Index (C1B1, C1B3))
                    }

                    Increment (Local2)
                }
            }

            Release (C04D)
        }

        Method (C1BF, 0, NotSerialized)
        {
            Acquire (C1B4, 0xFFFF)
            If (LEqual (C1B3, 0xFFFFFFFD))
            {
                C04C ()
                Store (C1BD (), Local0)
                C1BE (Local0)
            }

            Store (C1B3, Local1)
            Release (C1B4)
            Return (Local1)
        }

        Method (_INI, 0, NotSerialized)
        {
            C1BF ()
        }

        Method (C053, 3, NotSerialized)
        {
            Store (Arg1, Local2)
            CreateDWordField (Arg0, Local2, C1C0)
            Store (0x0986, C1C0)
            Add (Local2, 0x04, Local2)
            CreateDWordField (Arg0, Local2, C1C1)
            Store (DerefOf (Index (C1B1, Arg2)), C1C1)
            Add (Local2, 0x04, Local2)
            CreateDWordField (Arg0, Local2, C1C2)
            Store (DerefOf (Index (C1B2, Arg2)), C1C2)
            Add (Local2, 0x04, Local2)
            Return (Local2)
        }

        Method (C1C3, 0, NotSerialized)
        {
            Multiply (C1B3, 0x0C, Local1)
            Add (SizeOf (C00D), Local1, Local2)
            Store (Buffer (Local2) {}, Local0)
            Store (0x00, Local1)
            Store (Local1, Local2)
            While (LLess (Local1, C1B3))
            {
                Store (C053 (Local0, Local2, Local1), Local2)
                Increment (Local1)
            }

            Store (0x00, Local1)
            While (LLess (Local1, SizeOf (C00D)))
            {
                Store (DerefOf (Index (C00D, Local1)), Index (Local0, Loc=
al2))
                Increment (Local2)
                Increment (Local1)
            }

            Return (Local0)
        }

        Method (_CRS, 0, NotSerialized)
        {
            Store (C00D, Local0)
            Acquire (C1B4, 0xFFFF)
            If (LGreater (C1B3, 0x00))
            {
                Store (C1C3 (), Local0)
            }

            Release (C1B4)
            Return (Local0)
        }

        Method (_STA, 0, NotSerialized)
        {
            Subtract (SizeOf (C00D), 0x02, Local0)
            Or (C1BF (), Local0, Local0)
            If (Local0)
            {
                Store (0x0F, Local0)
            }

            Return (Local0)
        }
    }

    Name (\_SB.C1AE.C00D, ResourceTemplate ()
    {
    })
    Device (\_SB.C047.C1C4)
    {
        Name (_HID, "PNP0C02")
        Name (_UID, 0x01)
        Method (_CRS, 0, NotSerialized)
        {
            Name (C1C5, ResourceTemplate ()
            {
                IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                IO (Decode16, 0x1000, 0x1000, 0x01, 0x80)
                IO (Decode16, 0x1100, 0x1100, 0x01, 0x40)
                IO (Decode16, 0x1200, 0x1200, 0x01, 0x20)
                Memory32Fixed (ReadWrite, 0xFFC00000, 0x00000400)
            })
            Return (C1C5)
        }
    }

    Device (\_SB.C047.C05A.C1C7)
    {
        Name (_HID, "PNP0C02")
        Name (_UID, 0x02)
        Name (\_SB.C047.C05A.C14C, ResourceTemplate ()
        {
            IO (Decode16, 0x0010, 0x0010, 0x01, 0x10)
            IO (Decode16, 0x0024, 0x0024, 0x01, 0x1A)
            IO (Decode16, 0x004E, 0x004E, 0x01, 0x02)
            IO (Decode16, 0x0050, 0x0050, 0x01, 0x04)
            IO (Decode16, 0x0074, 0x0074, 0x01, 0x04)
            IO (Decode16, 0x0090, 0x0090, 0x01, 0x10)
            IO (Decode16, 0x00A4, 0x00A4, 0x01, 0x1A)
            Memory32Fixed (ReadOnly, 0xFFB00000, 0x00100000)
            Memory32Fixed (ReadOnly, 0xFFF00000, 0x00100000)
        })
        Method (_CRS, 0, NotSerialized)
        {
            Return (^^C136.C14B ())
        }
    }

    Name (\_S0, Package (0x03)
    {
        0x00,=20
        0x00,=20
        0x00
    })
    Name (\_S3, Package (0x03)
    {
        0x05,=20
        0x05,=20
        0x00
    })
    Name (\_S4, Package (0x03)
    {
        0x06,=20
        0x06,=20
        0x00
    })
    Name (\_S5, Package (0x03)
    {
        0x07,=20
        0x07,=20
        0x00
    })
    Method (\_PTS, 1, NotSerialized)
    {
        Store (Arg0, \_SB.C023)
        If (LAnd (\_SB.C047.C05A.C0E5.C0E8, LEqual (Arg0, 0x03)))
        {
            Acquire (\_SB.C047.C05A.C0E5.C0E6, 0xFFFF)
            Store (Arg0, \_SB.C047.C05A.C0E5.C0F0)
            Release (\_SB.C047.C05A.C0E5.C0E6)
        }

        If (LGreater (Arg0, 0x00))
        {
            \_SB.C047.C05A.C0E5.C0EA (0x01, 0xFF)
            If (LNot (LEqual (Arg0, 0x05)))
            {
                \_SB.C047.C05A.C0E5.C125 (0x00)
                If (LNot (LEqual (Arg0, 0x04)))
                {
                    Store (0x01, \_SB.C18C)
                }

                Store (0x01, \_SB.C190)
            }
        }
    }

    Method (\_WAK, 1, NotSerialized)
    {
        Store (0x00, \_SB.C023)
        Store (0x00, \_SB.C02C)
        If (\_SB.C047.C05A.C0E5.C0E8)
        {
            Acquire (\_SB.C047.C05A.C0E5.C0E6, 0xFFFF)
            Store (0x01, \_SB.C047.C05A.C0E5.C0F1)
            Store (0x00, \_SB.C047.C05A.C0E5.C0F0)
            Release (\_SB.C047.C05A.C0E5.C0E6)
        }

        If (LEqual (Arg0, 0x04))
        {
            \_TZ.C1C8 ()
        }

        If (LGreater (Arg0, 0x02))
        {
            Store (0x01, \_SB.C190)
            Notify (\_TZ.TZ1, 0x80)
            Notify (\_TZ.TZ2, 0x80)
        }

        If (LOr (LEqual (Arg0, 0x04), LEqual (\C00B (), 0x01)))
        {
            Notify (\_SB.C135, 0x02)
        }

        Store (\_SB.C047.C05A.C0E5.C0EB (), Local0)
        Store (\_SB.C047.C05A.C0E5.C124 (), Local2)
        \_SB.C047.C05A.C0E5.C0EA (0x03, 0xFF)
        Store (\_SB.C047.C05A.C0E5.C0EB (), Local1)
        Store (\_SB.C047.C05A.C0E5.C124 (), Local3)
        XOr (Local0, Local1, Local1)
        XOr (Local2, Local3, Local3)
        \_SB.C047.C05A.C0E5.C0EC (Local1, 0x81)
        If (Local2)
        {
            Notify (\_SB.C131, 0x80)
        }

        Notify (\_SB.C047.C098.C18E, 0x00)
        Notify (\_SB.C047.C059.C0AB, 0x00)
        Notify (\_SB.C047.C059.C0B1, 0x00)
        Notify (\_SB.C047.C059.C0B4, 0x00)
        Notify (\_SB.C047.C05A.C136.C157, 0x00)
        Return (Package (0x02)
        {
            0x00,=20
            0x00
        })
    }

    Scope (\_TZ)
    {
        Name (C1D6, 0x00)
        Name (C1D7, 0x01)
        Name (C1D8, 0x02)
        Name (C1D9, 0x03)
        Name (C1DA, 0x04)
        Name (C1DB, 0x00)
        Name (C1DC, 0x00)
        Name (C1DD, 0x00)
        Name (C1DE, 0x01)
        Name (C1DF, Package (0x03)
        {
            0x00,=20
            0x00,=20
            0x00
        })
        Name (C1E0, Package (0x03)
        {
            0x00,=20
            0x00,=20
            0x00
        })
        Name (C1E1, Package (0x03)
        {
            0xFFFFFFFD,=20
            0xFFFFFFFD,=20
            0xFFFFFFFD
        })
        Name (C1E2, 0x00)
        Mutex (C12F, 0x00)
        Name (C130, 0x07)
        Method (C1E3, 2, Serialized)
        {
            Store (0x00, Local1)
            If (And (C1E2, Arg0))
            {
                Store (\_SB.C047.C05A.C08E (0x59, 0x22, 0x00), Local0)
                If (LEqual (And (Local0, 0xFF00), 0x00))
                {
                    If (LGreater (Arg0, 0x08))
                    {
                        And (Local0, 0xF0, Local0)
                    }
                    Else
                    {
                        And (Local0, 0x0F, Local0)
                    }

                    If (LNot (LLess (Local0, Arg1)))
                    {
                        Store (0x01, Local1)
                    }
                }
            }

            Return (Local1)
        }

        Method (C1E4, 2, Serialized)
        {
            Store (\_SB.C047.C05A.C08E (0x59, 0x22, 0x00), Local1)
            If (LEqual (And (Local1, 0xFF00), 0x00))
            {
                If (LGreater (Arg0, 0x08))
                {
                    And (Local1, 0xF0, Local2)
                    If (LGreater (Arg1, Local2))
                    {
                        Store (Arg1, Local2)
                    }

                    And (Local1, 0x0F, Local1)
                    Or (Local1, Local2, Local1)
                }
                Else
                {
                    And (Local1, 0x0F, Local2)
                    If (LGreater (Arg1, Local2))
                    {
                        Store (Arg1, Local2)
                    }

                    And (Local1, 0xF0, Local1)
                    Or (Local1, Local2, Local1)
                }

                \_SB.C047.C05A.C08E (0x58, 0x22, Local1)
            }

            Or (C1E2, Arg0, C1E2)
        }

        Method (C1E5, 2, Serialized)
        {
            And (C1E2, Not (Arg0), C1E2)
            Store (\_SB.C047.C05A.C08E (0x59, 0x22, 0x00), Local1)
            If (LEqual (And (Local1, 0xFF00), 0x00))
            {
                If (LGreater (Arg0, 0x08))
                {
                    And (Local1, 0x0F, Local1)
                    Or (Local1, Arg1, Local1)
                }
                Else
                {
                    And (Local1, 0xF0, Local1)
                    Or (Local1, Arg1, Local1)
                }
            }

            \_SB.C047.C05A.C08E (0x58, 0x22, Local1)
        }

        Method (C1E6, 2, Serialized)
        {
            Store (0x01, Local0)
            Store (Arg0, Local1)
            If (LLess (Arg0, DerefOf (Index (C1E1, Arg1))))
            {
                Store (0x00, Local0)
                Add (Arg0, 0x01, Local1)
            }

            Store (DerefOf (Index (DerefOf (Index (DerefOf (Index (C1C9, =
C1E7 (Arg1))), Local0)), Local1)), Local2)
            If (LEqual (\_SB.C028, 0x00))
            {
                If (LAnd (LEqual (\_SB.C029, 0x01), LAnd (LEqual (Arg0, 0=
x00), LEqual (Arg1, 0x00))))
                {
                    If (\_SB.C047.C05A.C0E5.C124 ())
                    {
                        Store (0x0B4B, Local2)
                    }
                }
            }
            Else
            {
                If (LAnd (LEqual (\_SB.C029, 0x01), LAnd (LEqual (Arg0, 0=
x00), LLess (Arg1, 0x02))))
                {
                    If (\_SB.C047.C05A.C0E5.C124 ())
                    {
                        Store (0x0B4B, Local2)
                    }
                }
            }

            Store (Local2, Debug)
            Return (Local2)
        }

        Method (C1C8, 0, NotSerialized)
        {
            Acquire (C12F, 0xFFFF)
            Store (0x07, C130)
            Store (0xFFFFFFFD, Index (C1E1, 0x00))
            Store (0xFFFFFFFD, Index (C1E1, 0x01))
            Store (0x00, C1E2)
            Release (C12F)
            Subtract (C1D4, 0x0AAC, Local1)
            Divide (Local1, 0x0A, Local0, Local2)
            \_SB.C047.C05A.C08E (0x58, 0x1A, Local2)
            Subtract (C1D5, 0x0AAC, Local1)
            Divide (Local1, 0x0A, Local0, Local2)
            \_SB.C047.C05A.C08E (0x58, 0x16, Local2)
            \_SB.C047.C05A.C08E (0x58, 0x00, 0x0B)
            \_SB.C047.C05A.C08E (0x58, 0x01, 0x33)
            \_SB.C047.C05A.C08E (0x58, 0x20, 0xB4)
            \_SB.C047.C05A.C08E (0x58, 0x21, 0xB4)
            \_SB.C047.C05A.C08E (0x58, 0x23, 0x90)
            \_SB.C047.C05A.C08E (0x58, 0x3F, 0x80)
        }

        Method (C1E8, 1, Serialized)
        {
            If (LLess (Arg0, 0x02))
            {
                XOr (Arg0, 0x0B, Local4)
                Store (\_SB.C047.C05A.C08E (0x59, Local4, 0x00), Local2)
                If (And (Local2, 0x80))
                {
                    Subtract (0x0100, Local2, Local2)
                }

                Multiply (Local2, 0x0A, Local1)
                Add (Local1, 0x0AAC, Local1)
            }
            Else
            {
                Store (0x0B4C, Local1)
                Acquire (\_SB.C047.C05A.C0E5.C0E6, 0xFFFF)
                If (\_SB.C047.C05A.C0E5.C0E8)
                {
                    Store (\_SB.C047.C05A.C0E5.C119, Local1)
                }

                Release (\_SB.C047.C05A.C0E5.C0E6)
            }

            Store (Local1, Local2)
            If (LLess (Local1, 0x0B4C))
            {
                If (LLess (DerefOf (Index (C1DF, Arg0)), 0x0B4C))
                {
                    Store (0x0B4C, Index (C1E0, Arg0))
                }

                Store (DerefOf (Index (C1E0, Arg0)), Local1)
            }

            Store (Local2, Index (C1DF, Arg0))
            Store (Local1, Index (C1E0, Arg0))
            Acquire (C12F, 0xFFFF)
            Store (ShiftLeft (0x01, Arg0), Local2)
            If (And (C130, Local2))
            {
                If (C1DE)
                {
                    Store (Match (DerefOf (Index (DerefOf (Index (C1C9, C=
1E7 (Arg0))), 0x01)), MGT, Local1, MTR, 0x00, 0x00), Local0)
                }
                Else
                {
                    Store (Match (DerefOf (Index (DerefOf (Index (C1C9, C=
1E7 (Arg0))), 0x00)), MGT, Local1, MTR, 0x00, 0x00), Local0)
                    Decrement (Local0)
                    Store (0x01, C1DE)
                }

                If (LOr (LNot (LEqual (Local0, DerefOf (Index (C1E1, Arg0=
)))), C1DD))
                {
                    Store (0x00, C1DD)
                    Store (Local0, Index (C1E1, Arg0))
                    If (LLess (Arg0, 0x02))
                    {
                        C1E9 (Local0, Arg0)
                    }
                    Else
                    {
                        Notify (\_TZ.TZ3, 0x81)
                    }
                }

                And (C130, Not (Local2), C130)
            }

            Release (C12F)
            Return (Local1)
        }

        Method (C1E9, 2, Serialized)
        {
            Store (DerefOf (Index (DerefOf (Index (DerefOf (Index (C1C9, =
C1E7 (Arg1))), 0x01)), Arg0)), Local0)
            Subtract (Local0, 0x0AAC, Local0)
            Divide (Local0, 0x0A, Local1, Local6)
            Store (DerefOf (Index (DerefOf (Index (DerefOf (Index (C1C9, =
C1E7 (Arg1))), 0x00)), Arg0)), Local0)
            If (LLess (Local0, 0x0AAC))
            {
                Subtract (0x0AAC, Local0, Local1)
                Divide (Local1, 0x0A, Local3, Local2)
                Not (Local2, Local2)
                Add (Local2, 0x01, Local2)
                And (Local2, 0xFF, Local2)
            }
            Else
            {
                Subtract (Local0, 0x0AAC, Local0)
                Divide (Local0, 0x0A, Local1, Local2)
            }

            If (LLess (Arg1, 0x02))
            {
                Store (0x18, Local5)
                Store (0x19, Local4)
                If (Arg1)
                {
                    Store (0x14, Local5)
                    Store (0x15, Local4)
                }

                \_SB.C047.C05A.C08E (0x58, Local4, Local2)
                \_SB.C047.C05A.C08E (0x58, Local5, Local6)
                If (Arg1)
                {
                    Notify (\_TZ.TZ2, 0x81)
                }
                Else
                {
                    Notify (\_TZ.TZ1, 0x81)
                }
            }
        }

        Method (C1E7, 1, Serialized)
        {
            If (LEqual (Arg0, 0x00))
            {
                Store (C1DC, Local1)
            }
            Else
            {
                Add (Arg0, 0x01, Local1)
            }

            Return (Local1)
        }

        PowerResource (C1EA, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Return (C1E3 (0x01, C1CA))
            }

            Method (_ON, 0, NotSerialized)
            {
                C1E4 (0x01, C1CA)
            }

            Method (_OFF, 0, NotSerialized)
            {
                C1E5 (0x01, C1CB)
            }
        }

        PowerResource (C1EB, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Return (C1E3 (0x02, C1CB))
            }

            Method (_ON, 0, NotSerialized)
            {
                C1E4 (0x02, C1CB)
            }

            Method (_OFF, 0, NotSerialized)
            {
                C1E5 (0x02, C1CC)
            }
        }

        PowerResource (C1EC, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Return (C1E3 (0x04, C1CC))
            }

            Method (_ON, 0, NotSerialized)
            {
                C1E4 (0x04, C1CC)
            }

            Method (_OFF, 0, NotSerialized)
            {
                C1E5 (0x04, C1CD)
            }
        }

        PowerResource (C1ED, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Return (C1E3 (0x08, C1CD))
            }

            Method (_ON, 0, NotSerialized)
            {
                C1E4 (0x08, C1CD)
            }

            Method (_OFF, 0, NotSerialized)
            {
                C1E5 (0x08, 0x00)
            }
        }

        Device (C1EE)
        {
            Method (_INI, 0, NotSerialized)
            {
                \_TZ.C1C8 ()
            }

            Name (_HID, "PNP0C0B")
            Name (_UID, 0x00)
            Name (_PR0, Package (0x01)
            {
                C1EA
            })
        }

        Device (C1EF)
        {
            Name (_HID, "PNP0C0B")
            Name (_UID, 0x01)
            Name (_PR0, Package (0x01)
            {
                C1EB
            })
        }

        Device (C1F0)
        {
            Name (_HID, "PNP0C0B")
            Name (_UID, 0x02)
            Name (_PR0, Package (0x01)
            {
                C1EC
            })
        }

        Device (C1F1)
        {
            Name (_HID, "PNP0C0B")
            Name (_UID, 0x03)
            Name (_PR0, Package (0x01)
            {
                C1ED
            })
        }

        ThermalZone (TZ1)
        {
            Name (_AL0, Package (0x01)
            {
                C1EE
            })
            Name (_AL1, Package (0x01)
            {
                C1EF
            })
            Name (_AL2, Package (0x01)
            {
                C1F0
            })
            Name (_AL3, Package (0x01)
            {
                C1F1
            })
            Method (_AC0, 0, NotSerialized)
            {
                Return (C1E6 (C1D9, 0x00))
            }

            Method (_AC1, 0, NotSerialized)
            {
                Return (C1E6 (C1D8, 0x00))
            }

            Method (_AC2, 0, NotSerialized)
            {
                Return (C1E6 (C1D7, 0x00))
            }

            Method (_AC3, 0, NotSerialized)
            {
                Return (C1E6 (C1D6, 0x00))
            }

            Method (_PSV, 0, NotSerialized)
            {
                Return (C1E6 (C1DA, 0x00))
            }

            Name (_PSL, Package (0x01)
            {
                \_PR.C000
            })
            Method (C1F2, 1, NotSerialized)
            {
                Store (Arg0, C1DC)
                Acquire (C12F, 0xFFFF)
                Store (0x07, C130)
                Store (0x01, C1DD)
                Release (C12F)
                If (LEqual (Arg0, 0x00))
                {
                    Store (0x00, C1D6)
                    Store (0x01, C1D7)
                    Store (0x02, C1D8)
                    Store (0x03, C1D9)
                    Store (0x04, C1DA)
                }
                Else
                {
                    Store (0x00, C1D6)
                    Store (0x01, C1DA)
                    Store (0x02, C1D7)
                    Store (0x03, C1D8)
                    Store (0x04, C1D9)
                }
            }

            Name (_TSP, 0x64)
            Name (_TC1, 0x01)
            Name (_TC2, 0x02)
            Method (_TMP, 0, Serialized)
            {
                Store (C1E8 (0x00), Local0)
                Return (Local0)
            }
        }

        ThermalZone (TZ2)
        {
            Method (C1F3, 0, NotSerialized)
            {
                Return (C1E6 (0x00, 0x01))
            }

            Name (C1F4, Package (0x01)
            {
                \_PR.C000
            })
            Name (_TSP, 0x012C)
            Name (_TC1, 0x01)
            Name (_TC2, 0x02)
            Method (_TMP, 0, Serialized)
            {
                Store (C1E8 (0x01), Local0)
                Return (Local0)
            }
        }

        ThermalZone (TZ3)
        {
            Method (_PSV, 0, NotSerialized)
            {
                Return (C1E6 (0x00, 0x02))
            }

            Name (_PSL, Package (0x01)
            {
                \_PR.C000
            })
            Name (_TSP, 0x012C)
            Name (_TC1, 0x01)
            Name (_TC2, 0x02)
            Method (_TMP, 0, Serialized)
            {
                Store (C1E8 (0x02), Local0)
                Return (Local0)
            }
        }
    }

    Scope (\_GPE)
    {
        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.C047.C059, 0x02)
        }

        Method (_L11, 0, NotSerialized)
        {
            And (\_SB.C047.C05A.C066, 0xFFFFFFF3, Local0)
            Or (Local0, 0x04, \_SB.C047.C05A.C066)
            Notify (\_SB.C134, 0x80)
            If (LEqual (And (\_SB.C033, 0x03), 0x00))
            {
                If (LAnd (And (\_SB.C047.C05A.C086, 0x02), \_SB.C02A))
                {
                    Notify (\_SB.C047.C048.C0CF, 0x80)
                }
            }
        }

        Method (_L13, 0, NotSerialized)
        {
            Store (0x00, Local0)
        }

        Method (_L14, 0, NotSerialized)
        {
            And (\_SB.C047.C05A.C066, 0xFFFFFCFF, Local0)
            Or (Local0, 0x0100, \_SB.C047.C05A.C066)
            \_SB.C047.C048.C0CF.C0D6 (0x01)
            If (LEqual (And (\_SB.C033, 0x03), 0x00))
            {
                Notify (\_SB.C047.C048.C0CF, 0x80)
            }
        }

        Method (_L15, 0, NotSerialized)
        {
            Store (0x00, Local1)
            Store (\_SB.C047.C05A.C08E (0x59, 0x02, 0x00), Local0)
            Store (\_SB.C047.C05A.C08E (0x59, 0x03, 0x00), Local2)
            If (LEqual (And (Local0, 0xFF00), 0x00))
            {
                If (And (Local0, 0x0C))
                {
                    Store (0x01, Local1)
                    If (And (Local1, 0x08))
                    {
                        Store (0x00, \_TZ.C1DE)
                    }
                }

                If (And (Local0, 0xC0))
                {
                    Store (0x02, Local1)
                    If (And (Local1, 0x80))
                    {
                        Store (0x00, \_TZ.C1DE)
                    }
                }

                If (And (Local0, 0x10))
                {
                    Notify (\_TZ.TZ1, 0x80)
                }

                If (And (Local2, 0x40))
                {
                    Notify (\_TZ.TZ2, 0x80)
                }
            }
            Else
            {
                Store (0x03, Local1)
            }

            Acquire (\_TZ.C12F, 0xFFFF)
            Store (Local1, \_TZ.C130)
            Release (\_TZ.C12F)
            If (And (Local1, 0x01))
            {
                Notify (\_TZ.TZ1, 0x80)
            }

            If (And (Local1, 0x02))
            {
                Notify (\_TZ.TZ2, 0x80)
            }
        }

        Method (_L17, 0, NotSerialized)
        {
            Store ("Hot swap of MultiBay", Debug)
            And (\_SB.C047.C05A.C066, 0xFFFF3FFF, Local0)
            Or (Local0, 0x4000, \_SB.C047.C05A.C066)
            Notify (\_SB.C047.C098.C18E, 0x00)
            Notify (\_SB.C047.C05A.C136.C157, 0x00)
        }

        Method (_L18, 0, NotSerialized)
        {
            Store (0x00, Local0)
        }

        Method (_L1C, 0, NotSerialized)
        {
            Notify (\_SB.C135, 0x02)
        }
    }
}
------=_20040305152126_44785
Content-Type: application/octet-stream; name="evo-n800v.dsdt.interp.error"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="evo-n800v.dsdt.interp.error"

IEJJT1MtZTgyMDogMDAwMDAwMDAxZmZmMGMwMCAtIDAwMDAwMDAwMWZmZmMwMDAgKEFDUEkgTlZT
KQpBQ1BJOiBSU0RQICh2MDAwIENPTVBBUSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICkgQCAweDAwMGY2MDgwCkFDUEk6IFJTRFQgKHYwMDEgQ09NUEFRIENQUTAwNEEgIDB4Mjgx
MDAzMjAgQ1BRICAweDAwMDAwMDAxKSBAIDB4MWZmZjBjODQKQUNQSTogRkFEVCAodjAwMiBDT01Q
QVEgQ1BRMDA0QSAgMHgwMDAwMDAwMiBDUFEgIDB4MDAwMDAwMDEpIEAgMHgxZmZmMGMwMApBQ1BJ
OiBTU0RUICh2MDAxIENPTVBBUSAgQ1BRR3lzciAweDAwMDAxMDAxIE1TRlQgMHgwMTAwMDAwZCkg
QCAweDFmZmY2OTBmCkFDUEk6IFNTRFQgKHYwMDEgQ09NUEFRICAgQ1BRTWFnIDB4MDAwMDEwMDEg
TVNGVCAweDAxMDAwMDBkKSBAIDB4MWZmZjZhMWQKQUNQSTogRFNEVCAodjAwMSBDT01QQVEgIEVW
T044MDAgMHgwMDAxMDAwMCBNU0ZUIDB4MDEwMDAwMGQpIEAgMHgwMDAwMDAwMApBQ1BJOiBTdWJz
eXN0ZW0gcmV2aXNpb24gMjAwNDAyMTEKQUNQSTogSVJROSBTQ0k6IEVkZ2Ugc2V0IHRvIExldmVs
IFRyaWdnZXIuCiAgICBBQ1BJLTExMjA6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWls
ZWQgW1xfU0JfLkMwNDcuQzA1QS5DMEU1LkMwRTldIChOb2RlIGMxNTQ4N2MwKSwgQUVfTk9UX0VY
SVNUCiAgICBBQ1BJLTExMjA6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xf
U0JfLkMwNDcuQzA1QS5DMEU1Ll9JTkldIChOb2RlIGMxNTQ4ZGMwKSwgQUVfTk9UX0VYSVNUCkFD
UEk6IEludGVycHJldGVyIGVuYWJsZWQKQUNQSTogVXNpbmcgUElDIGZvciBpbnRlcnJ1cHQgcm91
dGluZwpBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2UgW0MwNDddICgwMDowMCkKQUNQSTogUENJIEludGVy
cnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5DMDQ3Ll9QUlRdCkFDUEk6IFBDSSBJbnRlcnJ1cHQg
Um91dGluZyBUYWJsZSBbXF9TQl8uQzA0Ny5DMDQ4Ll9QUlRdCkFDUEk6IFBDSSBJbnRlcnJ1cHQg
Um91dGluZyBUYWJsZSBbXF9TQl8uQzA0Ny5DMDU5Ll9QUlRdCkFDUEk6IEVtYmVkZGVkIENvbnRy
b2xsZXIgW0MwRTVdIChncGUgMjkpCkFDUEk6IFBvd2VyIFJlc291cmNlIFtDMTU2XSAob2ZmKQpB
Q1BJOiBQb3dlciBSZXNvdXJjZSBbQzE2QV0gKG9mZikKQUNQSTogUG93ZXIgUmVzb3VyY2UgW0Mx
NkVdIChvZmYpCkFDUEk6IFBvd2VyIFJlc291cmNlIFtDMTcyXSAob2ZmKQpBQ1BJOiBQb3dlciBS
ZXNvdXJjZSBbQzE3Ql0gKG9uKQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0MwQzFdIChJUlFz
IDUgMTAgKjExKQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0MwQzJdIChJUlFzICo1IDEwIDEx
KQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0MwQzNdIChJUlFzIDUgMTAgMTEpCkFDUEk6IFBD
SSBJbnRlcnJ1cHQgTGluayBbQzBDNF0gKElSUXMgNSAxMCAqMTEpCkFDUEk6IFBDSSBJbnRlcnJ1
cHQgTGluayBbQzBDNV0gKElSUXMgNSAqMTAgMTEpCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBb
QzBDNl0gKElSUXMpCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQzBDN10gKElSUXMpCkFDUEk6
IFBDSSBJbnRlcnJ1cHQgTGluayBbQzBDOF0gKElSUXMpCkFDUEk6IFBvd2VyIFJlc291cmNlIFtD
MEU0XSAob24pCkFDUEk6IFBvd2VyIFJlc291cmNlIFtDMUVBXSAob2ZmKQpBQ1BJOiBQb3dlciBS
ZXNvdXJjZSBbQzFFQl0gKG9mZikKQUNQSTogUG93ZXIgUmVzb3VyY2UgW0MxRUNdIChvZmYpCkFD
UEk6IFBvd2VyIFJlc291cmNlIFtDMUVEXSAob2ZmKQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsg
W0MwQzNdIGVuYWJsZWQgYXQgSVJRIDExCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQzBDMl0g
ZW5hYmxlZCBhdCBJUlEgNQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0MwQzFdIGVuYWJsZWQg
YXQgSVJRIDExCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQzBDNF0gZW5hYmxlZCBhdCBJUlEg
MTEKQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtDMEM1XSBlbmFibGVkIGF0IElSUSAxMApQQ0k6
IFVzaW5nIEFDUEkgZm9yIElSUSByb3V0aW5nCkFDUEk6IEFDIEFkYXB0ZXIgW0MxMzFdIChvbi1s
aW5lKQpBQ1BJOiBCYXR0ZXJ5IFNsb3QgW0MxMzNdIChiYXR0ZXJ5IGFic2VudCkKQUNQSTogQmF0
dGVyeSBTbG90IFtDMTMyXSAoYmF0dGVyeSBhYnNlbnQpCkFDUEk6IFBvd2VyIEJ1dHRvbiAoRkYp
IFtQV1JGXQpBQ1BJOiBTbGVlcCBCdXR0b24gKENNKSBbQzEzNV0KQUNQSTogTGlkIFN3aXRjaCBb
QzEzNF0KQUNQSTogRmFuIFtDMUVFXSAob2ZmKQpBQ1BJOiBGYW4gW0MxRUZdIChvZmYpCkFDUEk6
IEZhbiBbQzFGMF0gKG9mZikKQUNQSTogRmFuIFtDMUYxXSAob2ZmKQpBQ1BJOiBQcm9jZXNzb3Ig
W0MwMDBdIChzdXBwb3J0cyBDMSBDMiBDMywgOCB0aHJvdHRsaW5nIHN0YXRlcykKQUNQSTogVGhl
cm1hbCBab25lIFtUWjFdICg1MyBDKQpBQ1BJOiBUaGVybWFsIFpvbmUgW1RaMl0gKDQ4IEMpCkFD
UEk6IFRoZXJtYWwgWm9uZSBbVFozXSAoMTYgQykKQUNQSTogKHN1cHBvcnRzIFMwIFMzIFM0IFM1
KQo=
------=_20040305152126_44785--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
