From: Jeff Hagen <jeff-ziEjmj+msWXYtjvyW6yDsg@public.gmane.org>
Subject: Re: DSDT table for an Evo N150 ?
Date: Sun, 28 Mar 2004 23:53:16 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403282353.16492.jeff@hagen.org>
References: <20040328200426.GZ1950@gaspode.nextlink.co.za>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sX9ZAOtlf7zHV5e"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040328200426.GZ1950-beYWCVBHuyQmjp9Ioln+9+7fARiR49SZ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Thomas Andrews <tandrews-Dza9YrynN5pWaveUIWBRJg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_sX9ZAOtlf7zHV5e
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is one for the N610c....

Somebody posted this one to the newsgroup a while back, but I don't think the 
link in that e-mail still works.

I donno how this will work on yours, but at least this should give you a 
starting point?

-Jeff Hagen
jeff - at - hagen - dot - org


--Boundary-00=_sX9ZAOtlf7zHV5e
Content-Type: text/x-dsl;
  charset="iso-8859-1";
  name="dsdt.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dsdt.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of dsdt, Sun Sep 28 15:19:08 2003
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "COMPAQ", "EVON610C", 65536)
{
    Processor (\_PR.C000, 0x01, 0x00001010, 0x06)
    {
        Name (_CST, Package (0x04)
        {
            0x03, 
            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 0x00, 0x00, 0x0000000000000000)
                }, 

                0x01, 
                0x01, 
                0x03E8
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x0000000000001014)
                }, 

                0x02, 
                0x02, 
                0x01F4
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x0000000000001015)
                }, 

                0x03, 
                0xB9, 
                0xFA
            }
        })
    }

    Name (\C001, Package (0x10)
    {
        "0", 
        "1", 
        "2", 
        "3", 
        "4", 
        "5", 
        "6", 
        "7", 
        "8", 
        "9", 
        "A", 
        "B", 
        "C", 
        "D", 
        "E", 
        "F"
    })
    Method (\C002, 2, NotSerialized)
    {
        Store (Arg0, Local0)
        Store ("", Local7)
        Store (Arg1, Local4)
        While (LGreater (Local4, 0x00))
        {
            And (Local0, 0x0F, Local1)
            Store (DerefOf (Index (\C001, Local1)), Local2)
            Concatenate (Local2, Local7, Local3)
            Store (Local3, Local7)
            ShiftRight (Local0, 0x04, Local0)
            Decrement (Local4)
        }

        Return (Local7)
    }

    Method (\C003, 2, NotSerialized)
    {
        Store (SizeOf (Arg0), Local7)
        If (LNot (LEqual (Local7, SizeOf (Arg1))))
        {
            Return (0x00)
        }

        Name (C004, Buffer (Local7) {})
        Name (C005, Buffer (Local7) {})
        Store (Arg0, C004)
        Store (Arg1, C005)
        Store (0x00, Local6)
        Store (0x01, Local0)
        While (LAnd (LNot (LEqual (Local6, Local7)), Local0))
        {
            Store (DerefOf (Index (C004, Local6)), Local2)
            Store (DerefOf (Index (C005, Local6)), Local3)
            Increment (Local6)
            If (LNot (LEqual (Local2, Local3)))
            {
                Store (0x00, Local0)
            }
        }

        Return (Local0)
    }

    Name (C006, 0xFFFFFFFD)
    Name (C007, Package (0x03)
    {
        "Microsoft Windows", 
        "Microsoft WindowsME: Millennium Edition", 
        "Microsoft Windows NT"
    })
    Method (C008, 0, Serialized)
    {
        If (LEqual (C006, 0xFFFFFFFD))
        {
            Store (\_OS, Local0)
            Store (SizeOf (C007), Local7)
            Store (0x00, Local1)
            While (LAnd (LLess (Local1, Local7), LEqual (C006, 0xFFFFFFFD)))
            {
                Store (\C003 (Local0, DerefOf (Index (C007, Local1))), Local2)
                If (Local2)
                {
                    Add (Local1, 0x01, C006)
                }
                Else
                {
                    Increment (Local1)
                }
            }

            If (LEqual (C006, 0xFFFFFFFD))
            {
                Store (0x00, C006)
            }

            If (LOr (LEqual (C006, 0x00), LEqual (C006, 0x03)))
            {
                If (CondRefOf (\_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x04, C006)
                    }
                }
            }

            Store (C006, \_SB.C008)
        }

        Return (C006)
    }

    Method (\_SB._INI, 0, NotSerialized)
    {
        \C008 ()
    }

    Scope (\_SB)
    {
        Device (C009)
        {
            Name (_HID, EisaId ("PNP0C01"))
            Method (_CRS, 0, NotSerialized)
            {
                Name (C00A, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0x00000000, 0x000A0000)
                    Memory32Fixed (ReadOnly, 0x000F0000, 0x00100000)
                    Memory32Fixed (ReadWrite, 0x00100000, 0x00F00000)
                })
                CreateDWordField (C00A, 0x20, C00D)
                CreateDWordField (C00A, 0x1C, C00E)
                Subtract (\_SB.C00F (), C00E, C00D)
                CreateDWordField (C00A, 0x14, C010)
                CreateDWordField (C00A, 0x10, C011)
                Store (ShiftLeft (\_SB.C012, 0x04), C011)
                Subtract (C00E, C011, C010)
                Return (C00A)
            }
        }

        Method (C00F, 0, NotSerialized)
        {
            Store (C013, Local0)
            Return (Local0)
        }

        Method (C014, 0, NotSerialized)
        {
            Store (C015, Local0)
            Return (Local0)
        }

        Method (C016, 0, NotSerialized)
        {
            Add (C014 (), 0x0002BEC0, Local0)
            Return (Local0)
        }

        OperationRegion (C017, SystemMemory, 0x000F8000, 0x2C)
        Field (C017, WordAcc, NoLock, Preserve)
        {
            C018,   16, 
            Offset (0x08), 
            C019,   16, 
            Offset (0x0E), 
            C015,   32
        }

        OperationRegion (C01A, SystemMemory, C014, 0x00020200)
        Field (C01A, AnyAcc, NoLock, Preserve)
        {
            C01B,   1048576, 
            C01C,   2048, 
            C01D,   2048
        }

        OperationRegion (C01E, SystemMemory, C016, 0x0140)
        Field (C01E, AnyAcc, NoLock, Preserve)
        {
            C01F,   32, 
            C020,   4, 
            C021,   1, 
            C008,   4, 
            C022,   5, 
            C023,   1, 
            C024,   1, 
            C025,   2, 
            C026,   1, 
            C027,   1, 
            C028,   1, 
            C029,   11, 
            C02A,   32, 
            C012,   16, 
            C02B,   16, 
            C02C,   16, 
            C02D,   16, 
            C02E,   16, 
            C02F,   16, 
            C030,   16, 
            C013,   32, 
            C031,   8, 
            C032,   8, 
            C033,   8, 
            C034,   8, 
            C035,   8, 
            C036,   8, 
            Offset (0x68), 
            C037,   32, 
            C038,   32, 
            C039,   32, 
            C03A,   32, 
            Offset (0x8C), 
            C03B,   32
        }

        Method (C03C, 0, NotSerialized)
        {
            Add (C018, 0x000F0000, Local0)
            Return (Local0)
        }

        OperationRegion (C03D, SystemMemory, C03C, 0x06)
        Field (C03D, AnyAcc, NoLock, Preserve)
        {
            C03E,   8, 
            C03F,   8, 
            C040,   8, 
            C041,   8, 
            C042,   8, 
            C043,   8
        }

        Method (C044, 2, Serialized)
        {
            Store (Arg0, Local0)
            If (LEqual (Local0, 0x01))
            {
                Store (\_SB.C02A, Local1)
                Or (Local1, Arg1, Local1)
                Store (Local1, \_SB.C02A)
            }
            Else
            {
                Store (\_SB.C02A, Local1)
                Not (Arg1, Local2)
                And (Local1, Local2, Local1)
                Store (Local1, \_SB.C02A)
            }
        }

        Device (C045)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Device (C046)
            {
                Name (_ADR, 0x00010000)
            }

            OperationRegion (C047, PCI_Config, 0x91, 0x06)
            Field (C047, AnyAcc, NoLock, Preserve)
            {
                C048,   48
            }

            Alias (C048, \_SB.C048)
            Scope (\_SB)
            {
                Name (C049, Package (0x0C)
                {
                    0x4000, 
                    0x4000, 
                    0x4000, 
                    0x4000, 
                    0x4000, 
                    0x4000, 
                    0x4000, 
                    0x4000, 
                    0x4000, 
                    0x4000, 
                    0x4000, 
                    0x4000
                })
                Method (C04A, 0, NotSerialized)
                {
                    Acquire (C04B, 0xFFFF)
                    If (LEqual (C04C, 0xFFFFFFFD))
                    {
                        Store (0x00, Local0)
                        Store (Local0, C04C)
                        Store (Local0, Local2)
                        Store (C048, Local5)
                        Store (DerefOf (Index (Local5, Local0)), Local1)
                        Store (0x000C0000, Local4)
                        Store (ShiftLeft (C012, 0x04), Local3)
                        While (LAnd (LNot (LGreater (Local4, Local3)), LLess (C04C, 0x06)))
                        {
                            If (LEqual (And (Local1, 0x03), 0x00))
                            {
                                If (LEqual (Local2, 0x00))
                                {
                                    Store (Local4, Index (C04D, C04C))
                                }

                                Store (0x01, Local2)
                            }
                            Else
                            {
                                If (Local2)
                                {
                                    Subtract (Local4, 0x01, Index (C04E, C04C))
                                    Increment (C04C)
                                }

                                Store (0x00, Local2)
                            }

                            If (LLess (Local4, Local3))
                            {
                                Add (Local4, DerefOf (Index (C049, Local0)), Local4)
                                ShiftRight (Local1, 0x04, Local1)
                                If (And (Local0, 0x01))
                                {
                                    Store (0x01, Local1)
                                    If (LLess (Local4, Local3))
                                    {
                                        ShiftRight (Local0, 0x01, Local6)
                                        Increment (Local6)
                                        Store (DerefOf (Index (Local5, Local6)), Local1)
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

                    Release (C04B)
                }
            }

            Method (_INI, 0, NotSerialized)
            {
                C04A ()
            }

            Name (C04F, ResourceTemplate ()
            {
                WordBusNumber (ResourceConsumer, MinFixed, MaxFixed, PosDecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0000,
                    0x0CF7,
                    0x0000,
                    0x0CF8)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0xFFFFFFFF,
                    0x00000000,
                    0x00000000)
            })
            Scope (\_SB)
            {
                Name (C04D, Package (0x07) {})
                Name (C04E, Package (0x07) {})
                Name (C04C, 0xFFFFFFFD)
                Mutex (C04B, 0x00)
            }

            Method (C051, 4, NotSerialized)
            {
                Store (Arg1, Local2)
                Store (Arg3, Local4)
                Add (Local4, 0x1A, Local5)
                While (LLess (Local4, Local5))
                {
                    Store (DerefOf (Index (C04F, Local4)), Index (Arg0, Local2))
                    Increment (Local4)
                    Increment (Local2)
                }

//                Store (Arg1, Local2)
		Subtract (Local2, 0x1A, Local2)
//
                Add (Local2, 0x0A, Local2)
                CreateDWordField (Arg0, Local2, C052)
                Add (Local2, 0x04, Local2)
                CreateDWordField (Arg0, Local2, C053)
                Add (Local2, 0x08, Local2)
                CreateDWordField (Arg0, Local2, C054)
                Store (DerefOf (Index (C04D, Arg2)), C052)
                Store (DerefOf (Index (C04E, Arg2)), C053)
                Subtract (C053, C052, Local3)
                Add (Local3, 0x01, C054)
                Add (Local2, 0x04, Local2)
                Return (Local2)
            }

            Method (C055, 0, NotSerialized)
            {
                Acquire (C04B, 0xFFFF)
                Multiply (C04C, 0x1A, Local1)
                Add (SizeOf (C04F), Local1, Local2)
                Store (Buffer (Local2) {}, Local0)
                Store (0x00, Local1)
                Store (0x00, Local2)
                While (LLess (Local1, SizeOf (C04F)))
                {
                    Store (DerefOf (Index (C04F, Local1)), Index (Local0, Local2))
                    Increment (Local2)
                    Increment (Local1)
                }

                Store (0x00, Local1)
                Subtract (Local2, 0x02, Local2)
                Subtract (Local2, 0x1A, Local3)
                While (LLess (Local1, C04C))
                {
                    Store (C051 (Local0, Local2, Local1, Local3), Local2)
                    Increment (Local1)
                }

                CreateWordField (Local0, Local2, C056)
                Store (0x79, C056)
                Release (C04B)
                Return (Local0)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (C04F, 0x5C, C052)
                CreateDWordField (C04F, 0x68, C054)
                CreateDWordField (C04F, 0x60, C053)
                Store (\_SB.C00F (), Local1)
                Store (Local1, C052)
                Subtract (C053, Local1, Local1)
                Add (Local1, 0x01, C054)
                Store (C055 (), Local2)
                Return (Local2)
            }

            Name (_S3D, 0x02)
            Name (_S4D, 0x03)
            Name (C057, Package (0x01)
            {
                0x001F0001
            })
            Device (C058)
            {
                Name (_ADR, 0x001E0000)
                Name (_PRW, Package (0x02)
                {
                    0x0B, 
                    0x05
                })
            }

            Device (C059)
            {
                Name (_ADR, 0x001F0000)
                OperationRegion (C05A, PCI_Config, 0x60, 0xA0)
                Field (C05A, AnyAcc, NoLock, Preserve)
                {
                    C05B,   8, 
                    C05C,   8, 
                    C05D,   8, 
                    C05E,   8, 
                    Offset (0x08), 
                    C05F,   8, 
                    C060,   8, 
                    C061,   8, 
                    C062,   8, 
                    Offset (0x30), 
                    C063,   16, 
                    Offset (0x40), 
                        ,   7, 
                    C064,   1, 
                    Offset (0x58), 
                    C065,   32, 
                    Offset (0x60), 
                        ,   4, 
                    C066,   4, 
                    Offset (0x64), 
                    C067,   64, 
                    C068,   16, 
                    Offset (0x80), 
                    C069,   3, 
                        ,   1, 
                    C06A,   3, 
                    Offset (0x81), 
                    C06B,   2, 
                        ,   2, 
                    C06C,   1, 
                    Offset (0x84), 
                    C06D,   16, 
                    C06E,   1, 
                    C06F,   1, 
                    C070,   1, 
                    C071,   1
                }

                OperationRegion (C072, SystemIO, 0xB2, 0x01)
                Field (C072, AnyAcc, NoLock, Preserve)
                {
                    C073,   8
                }

                OperationRegion (C074, SystemIO, 0x1000, 0x36)
                Field (C074, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x2A), 
                        ,   2, 
                    C075,   1, 
                    Offset (0x2C), 
                    C076,   16, 
                    Offset (0x30), 
                    C077,   1, 
                    C078,   1, 
                        ,   2, 
                    C079,   1, 
                    Offset (0x34), 
                        ,   4, 
                    C07A,   1
                }

                OperationRegion (C07B, SystemIO, 0x1060, 0x11)
                Field (C07B, ByteAcc, NoLock, Preserve)
                {
                    C07C,   8, 
                    C07D,   8, 
                    Offset (0x04), 
                        ,   3, 
                    C07E,   1, 
                    Offset (0x06), 
                        ,   1, 
                    C07F,   1, 
                    Offset (0x08), 
                        ,   11, 
                    C080,   1
                }

                OperationRegion (C081, SystemMemory, 0xFFBC0100, 0x01)
                Field (C081, ByteAcc, NoLock, Preserve)
                {
                    C082,   5
                }

                OperationRegion (C083, SystemIO, 0x1100, 0x3C)
                Field (C083, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x0C), 
                    C084,   32, 
                    Offset (0x2C), 
                    C085,   32, 
                    Offset (0x38), 
                    C086,   16
                }

                OperationRegion (C087, SystemIO, 0x1200, 0x06)
                Field (C087, ByteAcc, NoLock, Preserve)
                {
                    C088,   8, 
                    Offset (0x02), 
                    C089,   8, 
                    C08A,   8, 
                    C08B,   8, 
                    C08C,   8
                }

                Method (C08D, 3, Serialized)
                {
                    Acquire (\_GL, 0xFFFF)
                    Store (0x00, Local2)
                    Store (0xFA, Local0)
                    While (LAnd (And (C088, 0x01), LGreater (Local0, 0x00)))
                    {
                        Stall (0x64)
                        Decrement (Local0)
                    }

                    If (Local0)
                    {
                        Store (Arg1, C08A)
                        Store (Arg0, C08B)
                        If (LEqual (And (Arg0, 0x01), 0x00))
                        {
                            Store (Arg2, C08C)
                        }

                        Store (0xFF, C088)
                        Store (0x48, C089)
                        Store (0xFA, Local0)
                        While (LAnd (LEqual (And (C088, 0x1E), 0x00), LGreater (Local0, 0x00)))
                        {
                            Stall (0x64)
                            Decrement (Local0)
                        }

                        And (C088, 0x1C, Local1)
                        Store (0xFF, C088)
                        If (LAnd (LEqual (Local1, 0x00), And (Arg0, 0x01)))
                        {
                            Store (C08C, Local2)
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

                Method (C08E, 2, Serialized)
                {
                    If (And (Arg0, 0xEF))
                    {
                        FindSetRightBit (Arg0, Local4)
                        Decrement (Local4)
                        Multiply (Local4, 0x02, Local0)
                        ShiftLeft (0x03, Local0, Local1)
                        ShiftLeft (Arg1, Local0, Local2)
                        Store (C063, Local3)
                        And (Local3, Not (Local1), Local3)
                        Or (Local3, Local2, Local3)
                        Store (Local3, C063)
                    }
                }

                Name (C08F, Package (0x08)
                {
                    0x03F8, 
                    0x02F8, 
                    0x0220, 
                    0x0228, 
                    0x0238, 
                    0x02E8, 
                    0x0338, 
                    0x03E8
                })
                Name (C090, Package (0x03)
                {
                    0x0378, 
                    0x0278, 
                    0x03BC
                })
                Method (C091, 3, NotSerialized)
                {
                    Store (0x00, Local1)
                    Store (Match (Arg0, MEQ, Arg1, MTR, 0x00, 0x00), Local0)
                    If (LNot (LEqual (Local0, Ones)))
                    {
                        ShiftLeft (Local0, Arg2, Local1)
                    }

                    Return (Local1)
                }

                Method (C092, 3, Serialized)
                {
                    Store (C067, Local0)
                    CreateWordField (Local0, Multiply (Arg0, 0x02), C093)
                    Store (Arg1, C093)
                    Store (Local0, C067)
                    Multiply (Arg0, 0x04, Local1)
                    ShiftLeft (Arg2, Local1, Local2)
                    ShiftLeft (0x0F, Local1, Local3)
                    And (C068, Not (Local3), Local4)
                    Or (Local4, Local2, C068)
                }

                Method (C094, 3, Serialized)
                {
                    If (Arg1)
                    {
                        Store (0x00, Local0)
                        Store (0x00, Local1)
                        Store (0x00, Local3)
                        And (C066, 0x0F, Local2)
                        While (Local2)
                        {
                            If (And (Local2, 0x01))
                            {
                                Multiply (Local3, 0x02, Local5)
                                Store (C067, Local6)
                                Store (DerefOf (Index (Local6, Local5)), Local4)
                                Or (ShiftLeft (DerefOf (Index (Local6, Add (Local5, 0x01))), 0x08), Local4, Local4)
                                If (LEqual (Arg1, Local4))
                                {
                                    If (LEqual (Arg0, 0x00))
                                    {
                                        ShiftLeft (0x01, Local3, Local5)
                                        And (C066, Not (Local5), C066)
                                        C092 (Local3, 0x00, 0x00)
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
                                C092 (Local0, Arg1, Arg2)
                                Or (C066, ShiftLeft (0x01, Local0), C066)
                            }
                        }
                    }
                }

                Method (C095, 2, Serialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Store (0x00, C071)
                    }
                    Else
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (0x00, C070)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x04))
                            {
                                Store (0x00, C06E)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x05))
                                {
                                    Store (0x00, C06F)
                                    C094 (0x00, Arg1, 0x00)
                                }
                            }
                        }
                    }
                }

                Method (C096, 3, Serialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Store (0x00, Local0)
                        If (LEqual (Arg1, 0x0370))
                        {
                            Store (0x01, Local0)
                        }

                        Store (Local0, C06C)
                        Store (0x01, C071)
                    }
                    Else
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (C091 (C090, Arg1, 0x00), C06B)
                            Store (0x01, C070)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x04))
                            {
                                Store (C091 (C08F, Arg1, 0x00), C069)
                                Store (0x01, C06E)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x05))
                                {
                                    Store (C091 (C08F, Arg1, 0x00), C06A)
                                    Store (0x01, C06F)
                                    C094 (0x01, Arg2, 0x07)
                                }
                            }
                        }
                    }
                }
            }

            Device (C097)
            {
                Name (_ADR, 0x001F0001)
                OperationRegion (C098, PCI_Config, 0x40, 0x18)
                Field (C098, AnyAcc, NoLock, Preserve)
                {
                    C099,   16, 
                    C09A,   16, 
                    C09B,   8, 
                    Offset (0x08), 
                    C09C,   8, 
                    Offset (0x0A), 
                    C09D,   16, 
                    Offset (0x14), 
                    C09E,   32
                }

                Method (C09F, 2, Serialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Store (C099, Local0)
                    }
                    Else
                    {
                        Store (C09A, Local0)
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
                        Return (Multiply (0x1E, Subtract (0x09, Add (Local1, Local2))))
                    }
                    Else
                    {
                        If (And (Local0, 0x4000))
                        {
                            If (LEqual (And (Local0, 0x90), 0x80))
                            {
                                Return (0x0384)
                            }

                            Store (C09B, Local0)
                            If (LEqual (Arg0, 0x01))
                            {
                                ShiftRight (Local0, 0x04, Local0)
                            }

                            Return (Multiply (0x1E, Subtract (0x09, Add (And (ShiftRight (Local0, 0x02), 0x03), And (Local0, 0x03)))))
                        }

                        Return (0xFFFFFFFF)
                    }
                }

                Name (C0A0, Buffer (0x05)
                {
                    0x70, 0x49, 0x36, 0x27, 0x19
                })
                Method (C0A1, 2, Serialized)
                {
                    ShiftLeft (0x01, Add (Multiply (Arg0, 0x02), Arg1), Local0)
                    If (And (C09C, Local0))
                    {
                        Store (C09E, Local1)
                        If (And (ShiftRight (Local1, 0x0C), Local0))
                        {
                            Return (0x11)
                        }

                        Store (And (ShiftRight (C09D, Add (Multiply (Arg0, 0x08), Multiply (Arg1, 0x04))), 0x03), Local2)
                        If (And (Local1, Local0))
                        {
                            Add (Local2, 0x02, Local2)
                        }

                        Return (DerefOf (Index (C0A0, Local2)))
                    }

                    Return (0xFFFFFFFF)
                }

                Method (C0A2, 1, Serialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Store (C099, Local0)
                    }
                    Else
                    {
                        Store (C09A, Local0)
                    }

                    Store (ShiftRight (C09C, Multiply (0x02, Arg0)), Local1)
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

                Method (C0A3, 5, Serialized)
                {
                    CreateWordField (Arg4, 0x02, C0A4)
                    CreateWordField (Arg4, 0x04, C0A5)
                    CreateWordField (Arg4, 0x08, C0A6)
                    Store (0x0C, Local0)
                    Store (0x00, Local1)
                    Store (0x00, Local2)
                    Store (0x01, Local5)
                    If (LAnd (And (Arg3, ShiftLeft (0x02, Multiply (Arg1, 0x02))), And (C0A4, 0x0800)))
                    {
                        Or (Local0, 0x02, Local0)
                        Store (0x08, Local5)
                    }

                    If (LAnd (LNot (LGreater (Arg2, 0xF0)), And (C0A5, 0x02)))
                    {
                        Or (And (Local0, 0xFFFFFFF7), 0x01, Local0)
                        If (LAnd (LNot (LGreater (Arg2, 0x78)), And (C0A6, 0x02)))
                        {
                            Store (0x2300, Local1)
                            Store (0x0B, Local2)
                            Or (Local5, 0x04, Local5)
                        }
                        Else
                        {
                            If (LAnd (LNot (LGreater (Arg2, 0xB4)), And (C0A6, 0x01)))
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
                                Or (And (C09B, 0xF0), Local2, C09B)
                            }
                            Else
                            {
                                Or (And (C09B, 0x0F), ShiftLeft (Local2, 0x04), C09B)
                            }
                        }

                        Store (0x3F0F, Local4)
                    }

                    Or (Local0, 0x8000, Local0)
                    If (LEqual (Arg0, 0x00))
                    {
                        Or (And (C099, Local4), Local0, C099)
                    }
                    Else
                    {
                        Or (And (C09A, Local4), Local0, C09A)
                    }

                    Return (Local5)
                }

                Method (C0A7, 5, Serialized)
                {
                    CreateWordField (Arg4, 0x0C, C0A8)
                    Store (0x00, Local0)
                    Store (0x00, Local1)
                    Store (0x00, Local2)
                    Add (Multiply (Arg0, 0x02), Arg1, Local3)
                    Store (0x00, Local4)
                    ShiftLeft (0x1011, Local3, Local5)
                    If (And (Arg3, ShiftLeft (0x01, Multiply (Arg1, 0x02))))
                    {
                        Store (0x01, Local1)
                        Store (C0A9 (Arg0, Arg1), Local6)
                        If (LAnd (LNot (LLess (Local6, 0x05)), LAnd (LLess (Arg2, 0x19), And (C0A8, 0x20))))
                        {
                            Store (0x01, Local0)
                            Store (0x45, Local2)
                            ShiftLeft (0x1011, Local3, Local4)
                        }
                        Else
                        {
                            If (LAnd (LNot (LLess (Local6, 0x04)), LAnd (LLess (Arg2, 0x27), And (C0A8, 0x10))))
                            {
                                Store (0x02, Local0)
                                Store (0x44, Local2)
                                ShiftLeft (0x11, Local3, Local4)
                            }
                            Else
                            {
                                If (LAnd (LNot (LLess (Local6, 0x03)), LAnd (LLess (Arg2, 0x36), And (C0A8, 0x08))))
                                {
                                    Store (0x01, Local0)
                                    Store (0x43, Local2)
                                    ShiftLeft (0x11, Local3, Local4)
                                }
                                Else
                                {
                                    If (LAnd (LNot (LLess (Local6, 0x02)), LAnd (LLess (Arg2, 0x49), And (C0A8, 0x04))))
                                    {
                                        Store (0x02, Local0)
                                        Store (0x42, Local2)
                                    }
                                    Else
                                    {
                                        If (LAnd (LNot (LLess (Local6, 0x01)), LAnd (LLess (Arg2, 0x70), And (C0A8, 0x02))))
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

                    Or (And (C09C, Not (ShiftLeft (0x01, Local3))), ShiftLeft (Local1, Local3), C09C)
                    Multiply (Local3, 0x04, Local3)
                    Or (And (C09D, Not (ShiftLeft (0x03, Local3))), ShiftLeft (Local0, Local3), C09D)
                    Or (And (C09E, Not (Local5)), Local4, C09E)
                    Return (Local2)
                }
            }

            Device (C0AA)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (C0AB, PCI_Config, 0xC4, 0x04)
                Field (C0AB, AnyAcc, NoLock, Preserve)
                {
                    C0AC,   1, 
                    C0AD,   1
                }

                Device (C0AE)
                {
                    Name (_ADR, 0x00)
                    Device (C0AF)
                    {
                        Name (_ADR, 0x00)
                    }
                }
            }

            Device (C0B0)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (C0AB, PCI_Config, 0xC4, 0x04)
                Field (C0AB, AnyAcc, NoLock, Preserve)
                {
                    C0AC,   1, 
                    C0AD,   1
                }

                Device (C0AE)
                {
                    Name (_ADR, 0x00)
                    Device (C0AF)
                    {
                        Name (_ADR, 0x00)
                    }

                    Device (C0B1)
                    {
                        Name (_ADR, 0x01)
                    }
                }
            }

            Device (C0B2)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (C0AB, PCI_Config, 0xC4, 0x01)
                Field (C0AB, AnyAcc, NoLock, Preserve)
                {
                    C0AC,   1, 
                    C0AD,   1
                }

                Device (C0AE)
                {
                    Name (_ADR, 0x00)
                    Device (C0AF)
                    {
                        Name (_ADR, 0x00)
                    }

                    Device (C0B1)
                    {
                        Name (_ADR, 0x01)
                    }
                }
            }

            Device (C0B3)
            {
                Name (_ADR, 0x001D0007)
                Device (C0AE)
                {
                    Name (_ADR, 0x00)
                    Device (C0AF)
                    {
                        Name (_ADR, 0x00)
                    }

                    Device (C0B1)
                    {
                        Name (_ADR, 0x01)
                    }

                    Device (C0B4)
                    {
                        Name (_ADR, 0x02)
                    }

                    Device (C0B5)
                    {
                        Name (_ADR, 0x03)
                    }

                    Device (C0B6)
                    {
                        Name (_ADR, 0x04)
                    }

                    Device (C0B7)
                    {
                        Name (_ADR, 0x05)
                    }
                }
            }

            Method (C0B8, 1, Serialized)
            {
                Name (C0B9, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {}
                })
                CreateWordField (C0B9, 0x01, C0BB)
                Store (0x00, Local1)
                Store (Arg0, Local0)
                And (Local0, 0x8F, Local0)
                If (LLess (Local0, 0x80))
                {
                    And (Local0, 0x0F, Local0)
                    ShiftLeft (0x01, Local0, Local1)
                }

                Store (Local1, C0BB)
                Return (C0B9)
            }

            Method (C0BC, 1, Serialized)
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

            Method (C0BD, 1, Serialized)
            {
                Store (Arg0, Local0)
                And (Local0, 0xF0, Local0)
                Or (Local0, 0x80, Local0)
                Return (Local0)
            }

            Method (C0BE, 1, Serialized)
            {
                CreateWordField (Arg0, 0x01, C0BF)
                If (LEqual (C0BF, 0x00))
                {
                    Store (0x00, Local0)
                }
                Else
                {
                    FindSetRightBit (C0BF, Local0)
                    Decrement (Local0)
                }

                Return (Local0)
            }

            Device (C0C0)
            {
                Name (_HID, EisaId ("PNP0C0F"))
                Name (_UID, 0x60)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BC (^^C059.C05B))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BD (^^C059.C05B), ^^C059.C05B)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BE (Arg0), ^^C059.C05B)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B8 (^^C059.C05B))
                }
            }

            Device (C0C1)
            {
                Name (_HID, EisaId ("PNP0C0F"))
                Name (_UID, 0x61)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BC (^^C059.C05C))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BD (^^C059.C05C), ^^C059.C05C)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BE (Arg0), ^^C059.C05C)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B8 (^^C059.C05C))
                }
            }

            Device (C0C2)
            {
                Name (_HID, EisaId ("PNP0C0F"))
                Name (_UID, 0x62)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BC (^^C059.C05D))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BD (^^C059.C05D), ^^C059.C05D)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BE (Arg0), ^^C059.C05D)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B8 (^^C059.C05D))
                }
            }

            Device (C0C3)
            {
                Name (_HID, EisaId ("PNP0C0F"))
                Name (_UID, 0x63)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BC (^^C059.C05E))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BD (^^C059.C05E), ^^C059.C05E)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BE (Arg0), ^^C059.C05E)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B8 (^^C059.C05E))
                }
            }

            Device (C0C4)
            {
                Name (_HID, EisaId ("PNP0C0F"))
                Name (_UID, 0x68)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BC (^^C059.C05F))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BD (^^C059.C05F), ^^C059.C05F)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BE (Arg0), ^^C059.C05F)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B8 (^^C059.C05F))
                }
            }

            Device (C0C5)
            {
                Name (_HID, EisaId ("PNP0C0F"))
                Name (_UID, 0x69)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BC (^^C059.C060))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BD (^^C059.C060), ^^C059.C060)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BE (Arg0), ^^C059.C060)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B8 (^^C059.C060))
                }
            }

            Device (C0C6)
            {
                Name (_HID, EisaId ("PNP0C0F"))
                Name (_UID, 0x6A)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BC (^^C059.C061))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BD (^^C059.C061), ^^C059.C061)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BE (Arg0), ^^C059.C061)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B8 (^^C059.C061))
                }
            }

            Device (C0C7)
            {
                Name (_HID, EisaId ("PNP0C0F"))
                Name (_UID, 0x6B)
                Method (_STA, 0, NotSerialized)
                {
                    Return (C0BC (^^C059.C062))
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (C0BD (^^C059.C062), ^^C059.C062)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (C0BE (Arg0), ^^C059.C062)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (C0B8 (^^C059.C062))
                }
            }

            Method (C0C8, 1, NotSerialized)
            {
                While (^C059.C07A)
                {
                    Stall (0x01)
                }

                Store (0xF3, ^C059.C073)
                Stall (0x32)
                While (^C059.C07A)
                {
                    Stall (0x01)
                }
            }

            Mutex (C0C9, 0x00)
            Name (C0CA, 0x00)
            Name (C0CB, 0x00)
            Method (C0CC, 0, NotSerialized)
            {
                Acquire (C0C9, 0xFFFF)
                If (LEqual (C0CB, 0x00))
                {
                    Store (0x00, ^C059.C077)
                    Store (0x00, ^C059.C078)
                }

                Increment (C0CB)
                Release (C0C9)
            }

            Method (C0CD, 0, NotSerialized)
            {
                Acquire (C0C9, 0xFFFF)
                Decrement (C0CB)
                If (LEqual (C0CB, 0x00))
                {
                    Store (0x01, ^C059.C078)
                    Store (0x01, ^C059.C077)
                }

                Release (C0C9)
            }

            Scope (C046)
            {
                Device (C0CE)
                {
                    Name (_ADR, 0x00)
                    Name (C0CF, 0x00)
                    OperationRegion (C0D0, PCI_Config, 0x2C, 0x04)
                    Field (C0D0, DWordAcc, NoLock, Preserve)
                    {
                        C0D1,   32
                    }

                    OperationRegion (C0D2, PCI_Config, 0x4C, 0x04)
                    Field (C0D2, DWordAcc, NoLock, Preserve)
                    {
                        C0D3,   32
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LAnd (LEqual (Arg0, 0x02), LEqual (Arg1, 0x01)))
                        {
                            Store (C0D1, Local0)
                            If (LEqual (C0CF, 0x00))
                            {
                                Store (Local0, C0CF)
                            }
                            Else
                            {
                                If (LNot (LEqual (Local0, C0CF)))
                                {
                                    Store (C0CF, C0D3)
                                }
                            }
                        }
                    }

                    Name (_S1D, 0x03)
                    Name (_S3D, 0x03)
                    Name (_S4D, 0x03)
                    Method (C0D4, 1, Serialized)
                    {
                        Store (0x00, Local0)
                        If (And (C0D5 (0x00), Arg0))
                        {
                            Store (0x01, Local0)
                            If (And (C033, Arg0))
                            {
                                Store (0x1D, Local0)
                                If (And (C032, Arg0))
                                {
                                    Store (0x1F, Local0)
                                }
                            }
                        }

                        Return (Local0)
                    }

                    Method (C0D6, 1, Serialized)
                    {
                        Store (0x00, Local0)
                        If (And (C034, Arg0))
                        {
                            Store (0x01, Local0)
                        }

                        Return (Local0)
                    }

                    Method (C0D7, 2, Serialized)
                    {
                        Store (C035, Local0)
                        If (And (Arg1, 0x01))
                        {
                            Or (Local0, Arg0, Local0)
                        }
                        Else
                        {
                            And (Local0, Not (Arg0), Local0)
                        }

                        Store (Local0, C035)
                        If (And (Arg1, 0x40000000))
                        {
                            Store (Local0, C032)
                        }

                        If (LEqual (And (Arg1, 0xC0000000), 0x80000000))
                        {
                            \_SB.C0D8 (0xEA74, 0x01, 0x00, 0x00, 0x00)
                        }
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        And (C031, 0xF8, Local0)
                        Or (Local0, Arg0, C031)
                    }

                    Device (C0D9)
                    {
                        Name (_ADR, 0x0100)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Return (C0D4 (0x02))
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (C0D6 (0x02))
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            C0D7 (0x02, Arg0)
                        }
                    }

                    Device (C0DA)
                    {
                        Name (_ADR, 0x0110)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Return (C0D4 (0x01))
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (C0D6 (0x01))
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            C0D7 (0x01, Arg0)
                        }
                    }

                    Device (C0DB)
                    {
                        Name (_ADR, 0x0200)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Return (C0D4 (0x04))
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (C0D6 (0x04))
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            C0D7 (0x04, Arg0)
                        }
                    }

                    Device (C0DC)
                    {
                        Name (_ADR, 0x0210)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Return (C0D4 (0x08))
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (C0D6 (0x08))
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            C0D7 (0x08, Arg0)
                        }
                    }

                    Name (C0DD, 0xFFFFFFFD)
                    Method (C0D5, 1, Serialized)
                    {
                        If (LAnd (Arg0, LEqual (C0DD, 0xFFFFFFFD)))
                        {
                            Store (0x07, Local0)
                            If (And (\_SB.C045.C059.C085, 0x10))
                            {
                                Or (Local0, 0x08, Local0)
                            }

                            Store (Local0, C0DD)
                        }

                        Return (C0DD)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x04)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x00010200, 
                            0x00010210
                        })
                    }
                }
            }

            Method (\C0C8, 1, NotSerialized)
            {
                \_SB.C045.C0C8 (Arg0)
            }

            Method (\C0CC, 0, NotSerialized)
            {
                \_SB.C045.C0CC ()
            }

            Method (\C0CD, 0, NotSerialized)
            {
                \_SB.C045.C0CD ()
            }

            Method (C059.C0DE, 5, Serialized)
            {
                If (LEqual (Arg1, 0x00))
                {
                    ^C095 (Arg0, Arg2)
                    Store (0x01, Local0)
                }
                Else
                {
                    ^C096 (Arg0, Arg1, Arg2)
                    Store (0x03, Local0)
                }

                ^C08E (Arg4, Local0)
            }

            Method (\_SB.C0DF, 5, Serialized)
            {
                ^C045.C059.C0DE (Arg0, Arg1, Arg2, Arg3, Arg4)
            }

            Method (\_SB.C0E0, 0, NotSerialized)
            {
                And (\_SB.C045.C059.C085, 0x3000, Local0)
                And (\_SB.C045.C059.C082, 0x0F, Local1)
                If (And (Local0, 0x1000))
                {
                    Store (ShiftLeft (0x07, 0x04), Local2)
                }
                Else
                {
                    And (ShiftLeft (Local1, 0x02), 0x30, Local2)
                }

                If (And (Local0, 0x2000))
                {
                    Store (0x07, Local3)
                }
                Else
                {
                    And (Local1, 0x03, Local3)
                }

                Or (Local2, Local3, Local2)
                Return (Local2)
            }

            Device (C0E1)
            {
                Name (_ADR, 0x001F0005)
            }

            Scope (C059)
            {
                Device (C0E2)
                {
                    Name (_HID, EisaId ("PNP0A06"))
                    OperationRegion (C0E3, SystemIO, 0x2E, 0x02)
                    Field (C0E3, ByteAcc, NoLock, Preserve)
                    {
                        C0E4,   8, 
                        C0E5,   8
                    }

                    OperationRegion (C0E6, SystemIO, 0x2E, 0x01)
                    Field (C0E6, ByteAcc, NoLock, Preserve)
                    {
                        C0E7,   8
                    }

                    Mutex (C0E8, 0x00)
                    Mutex (C0E9, 0x00)
                    Name (C0EA, 0x00)
                    Name (C0EB, 0x00)
                    Method (C0EC, 0, NotSerialized)
                    {
                        Store (0x55, C0E7)
                    }

                    Method (C0ED, 0, NotSerialized)
                    {
                        Store (0xAA, C0E7)
                    }

                    Method (C0EE, 2, NotSerialized)
                    {
                        Acquire (C0E8, 0xFFFF)
                        Acquire (\_GL, 0xFFFF)
                        C0EC ()
                        Store (0x07, C0E4)
                        Store (Arg0, C0E5)
                        Store (Arg1, C0E4)
                        Store (C0E5, Local0)
                        C0ED ()
                        Release (\_GL)
                        Release (C0E8)
                        Return (Local0)
                    }

                    Method (C0EF, 3, NotSerialized)
                    {
                        Acquire (C0E8, 0xFFFF)
                        Acquire (\_GL, 0xFFFF)
                        C0EC ()
                        Store (0x07, C0E4)
                        Store (Arg0, C0E5)
                        Store (Arg1, C0E4)
                        Store (Arg2, C0E5)
                        C0ED ()
                        Release (\_GL)
                        Release (C0E8)
                    }

                    Method (C0F0, 4, Serialized)
                    {
                        Store (C0EE (Arg0, Arg1), Local0)
                        And (Arg2, Local0, Local1)
                        Or (Arg3, Local1, Local2)
                        C0EF (Arg0, Arg1, Local2)
                    }

                    Method (C0F1, 1, NotSerialized)
                    {
                        Store (C0EE (Arg0, 0x61), Local0)
                        Store (C0EE (Arg0, 0x60), Local1)
                        Or (Local0, ShiftLeft (Local1, 0x08), Local0)
                        If (Local0)
                        {
                            If (LEqual (C0EE (Arg0, 0x30), 0x00))
                            {
                                Acquire (C0E9, 0xFFFF)
                                Store (C0EA, Local1)
                                Store (C0EB, Local2)
                                Release (C0E9)
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

                    Method (C0F2, 1, NotSerialized)
                    {
                        Name (C0F3, Package (0x04)
                        {
                            0x00, 
                            0x00, 
                            0x00, 
                            0x00
                        })
                        Store (C0EE (Arg0, 0x61), Local0)
                        Store (C0EE (Arg0, 0x60), Local1)
                        ShiftLeft (Local1, 0x08, Local1)
                        Or (Local0, Local1, Index (C0F3, 0x00))
                        If (LEqual (Arg0, 0x05))
                        {
                            Store (C0EE (Arg0, 0x63), Local0)
                            Store (C0EE (Arg0, 0x62), Local1)
                            ShiftLeft (Local1, 0x08, Local1)
                            Or (Local0, Local1, Index (C0F3, 0x01))
                        }

                        Store (C0EE (Arg0, 0x70), Local0)
                        Store (0x00, Local1)
                        If (LLess (Local0, 0x10))
                        {
                            ShiftLeft (0x01, Local0, Local1)
                        }

                        Store (Local1, Index (C0F3, 0x02))
                        If (LNot (LEqual (Arg0, 0x04)))
                        {
                            Store (C0EE (Arg0, 0x74), Local0)
                            Store (0x00, Local1)
                            If (LLess (Local0, 0x04))
                            {
                                ShiftLeft (0x01, Local0, Local1)
                            }

                            Store (Local1, Index (C0F3, 0x03))
                        }

                        Return (C0F3)
                    }

                    Method (C0F4, 5, NotSerialized)
                    {
                        If (LAnd (LNot (LEqual (Arg0, 0x04)), LEqual (Arg1, 0x00)))
                        {
                            C0EF (Arg0, 0x30, 0x00)
                        }

                        FindSetRightBit (Arg3, Local1)
                        If (LAnd (LGreater (Local1, 0x01), LLess (Local1, 0x11)))
                        {
                            Decrement (Local1)
                        }
                        Else
                        {
                            Store (0x00, Local1)
                        }

                        FindSetRightBit (Arg4, Local2)
                        If (LAnd (LGreater (Local2, 0x00), LLess (Local2, 0x05)))
                        {
                            Decrement (Local2)
                        }
                        Else
                        {
                            Store (0x04, Local2)
                        }

                        C0EF (Arg0, 0x61, Arg1)
                        ShiftRight (Arg1, 0x08, Local0)
                        C0EF (Arg0, 0x60, Local0)
                        If (LEqual (Arg0, 0x05))
                        {
                            C0EF (Arg0, 0x63, Arg2)
                            ShiftRight (Arg2, 0x08, Local0)
                            C0EF (Arg0, 0x62, Local0)
                        }

                        C0F0 (Arg0, 0x70, 0xF0, Local1)
                        If (LNot (LEqual (Arg0, 0x04)))
                        {
                            C0F0 (Arg0, 0x74, 0xF0, Local2)
                        }

                        If (LNot (LEqual (Arg1, 0x00)))
                        {
                            C0EF (Arg0, 0x30, 0x01)
                        }
                    }

                    Method (C0F5, 1, NotSerialized)
                    {
                        Store (0x00, Local0)
                        If (Arg0)
                        {
                            Store (0x10, Local0)
                        }

                        C0F0 (0x00, 0x25, 0xE7, Local0)
                    }

                    Method (C0F6, 1, Serialized)
                    {
                        Acquire (C0E9, 0xFFFF)
                        Store (C0EA, Local0)
                        Release (C0E9)
                        ShiftRight (Local0, Arg0, Local1)
                        Return (And (One, Local1, Local1))
                    }

                    Method (C0F7, 2, Serialized)
                    {
                        ShiftLeft (0x01, Arg0, Local0)
                        ShiftLeft (And (Arg1, 0x01), Arg0, Local1)
                        Acquire (C0E9, 0xFFFF)
                        Or (C0EB, Local0, C0EB)
                        Store (C0EA, Local2)
                        And (Local2, Not (Local0), Local2)
                        Or (Local2, Local1, Local2)
                        Store (Local2, C0EA)
                        Release (C0E9)
                    }

                    OperationRegion (C0F8, SystemIO, 0x4E, 0x02)
                    Field (C0F8, ByteAcc, NoLock, Preserve)
                    {
                        C0F9,   8, 
                        C0FA,   8
                    }

                    IndexField (C0F9, C0FA, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x82), 
                        C0FB,   8, 
                        C0FC,   8, 
                        C0FD,   8, 
                        C0FE,   8, 
                        C0FF,   8, 
                        C100,   8, 
                        C101,   8, 
                        C102,   8, 
                        C103,   8, 
                        C104,   8, 
                        C105,   8, 
                        C106,   8, 
                        C107,   8, 
                        C108,   8, 
                        C109,   8, 
                        C10A,   8, 
                        Offset (0xA0), 
                        C10B,   8, 
                        C10C,   8, 
                        C10D,   8, 
                        C10E,   8, 
                        C10F,   8, 
                        C110,   8, 
                        C111,   8, 
                        C112,   8, 
                        C113,   8, 
                        C114,   8, 
                        C115,   8, 
                        C116,   8, 
                        C117,   8, 
                        C118,   8, 
                        C119,   8, 
                        C11A,   8
                    }

                    Mutex (C11B, 0x00)
                    Mutex (C11C, 0x00)
                    Mutex (C11D, 0x00)
                    Name (C11E, 0xFFFFFFFD)
                    Name (C11F, 0x00)
                    Method (_INI, 0, NotSerialized)
                    {
                        Acquire (\_GL, 0xFFFF)
                        Store (C103, \_GPE.C120)
                        Store (C105, \_GPE.C121)
                        Store (C106, \_GPE.C122)
                        Store (C113, \_GPE.C123)
                        Store (C114, \_GPE.C124)
                        Store (C115, \_GPE.C125)
                        Store (C116, \_GPE.C126)
                        Store (C118, \_GPE.C127)
                        Store (C119, \_GPE.C128)
                        Store (C129 (), C11F)
                        Store (0x39, C0EA)
                        Release (\_GL)
                    }

                    Method (C129, 0, NotSerialized)
                    {
                        Acquire (\_GL, 0xFFFF)
                        Store (C105, Local0)
                        Release (\_GL)
                        If (And (Local0, 0x01, Local0))
                        {
                            Acquire (\_GL, 0xFFFF)
                            Store (C106, Local0)
                            Release (\_GL)
                            ShiftRight (Local0, 0x04, Local0)
                            And (Local0, 0x07, Local0)
                            If (Local0)
                            {
                                Return (Local0)
                            }
                        }

                        Return (0x00)
                    }

                    Method (C12A, 5, NotSerialized)
                    {
                        Acquire (C11B, 0xFFFF)
                        Acquire (\_GL, 0xFFFF)
                        Store (0x09C4, Local0)
                        While (LAnd (LNot (LEqual (0x00, C0FB)), LGreater (Local0, 0x00)))
                        {
                            Stall (0x64)
                            Decrement (Local0)
                        }

                        Store (C0FD, Local2)
                        Store (C0FE, Local3)
                        Store (C0FF, Local4)
                        Store (C100, Local5)
                        Store (Arg1, C0FD)
                        Store (Arg2, C0FE)
                        Store (Arg3, C0FF)
                        Store (Arg4, C100)
                        Store (Arg0, C0FB)
                        Store (0x09C4, Local0)
                        While (LAnd (LNot (LEqual (0x00, C0FB)), LGreater (Local0, 0x00)))
                        {
                            Stall (0x64)
                            Decrement (Local0)
                        }

                        Store (Buffer (0x05)
                            {
                                0x00, 0x00, 0x00, 0x00, 0x00
                            }, Local7)
                        Store (C0FD, Index (Local7, 0x01))
                        Store (C0FE, Index (Local7, 0x02))
                        Store (C0FF, Index (Local7, 0x03))
                        Store (C100, Index (Local7, 0x04))
                        Store (Local2, C0FD)
                        Store (Local3, C0FE)
                        Store (Local4, C0FF)
                        Store (Local5, C100)
                        Release (\_GL)
                        Release (C11B)
                        Return (Local7)
                    }

                    Method (C12B, 4, NotSerialized)
                    {
                        Acquire (C11C, 0xFFFF)
                        Acquire (\_GL, 0xFFFF)
                        \C0CC ()
                        Store (0x01, C107)
                        Store (0x012C, Local0)
                        While (LAnd (LNot (LEqual (0x00, C107)), LGreater (Local0, 0x00)))
                        {
                            Stall (0x64)
                            Decrement (Local0)
                        }

                        Store (Arg3, C10A)
                        Store (Arg2, C109)
                        Store (Arg1, C108)
                        Store (Arg0, C107)
                        Store (0x012C, Local0)
                        While (LAnd (LNot (LEqual (0x00, C107)), LGreater (Local0, 0x00)))
                        {
                            Stall (0x64)
                            Decrement (Local0)
                        }

                        Store (Buffer (0x04) {}, Local7)
                        Store (C107, Index (Local7, 0x00))
                        Store (C108, Index (Local7, 0x01))
                        Store (C109, Index (Local7, 0x02))
                        Store (C10A, Index (Local7, 0x03))
                        If (LNot (LEqual (Arg0, 0x17)))
                        {
                            Store (0x02, C107)
                            Store (0x012C, Local0)
                            While (LAnd (LNot (LEqual (0x00, C107)), LGreater (Local0, 0x00)))
                            {
                                Stall (0x64)
                                Decrement (Local0)
                            }
                        }

                        \C0CD ()
                        Release (\_GL)
                        Release (C11C)
                        Return (Local7)
                    }

                    Method (C12C, 2, NotSerialized)
                    {
                        Acquire (C11B, 0xFFFF)
                        Acquire (\_GL, 0xFFFF)
                        Add (Arg1, 0x01, Local6)
                        If (LGreater (Local6, 0x11))
                        {
                            Store (0x11, Local6)
                        }

                        Store (Buffer (Local6) {}, Local7)
                        Store (0x01, Local6)
                        Store (0x09C4, Local0)
                        While (LAnd (LNot (LEqual (0x00, C0FB)), LGreater (Local0, 0x00)))
                        {
                            Stall (0x64)
                            Decrement (Local0)
                        }

                        Store (C0FD, Local2)
                        Store (C0FE, Local3)
                        Store (C0FF, Local4)
                        Store (C100, Local5)
                        Store (Arg1, C0FE)
                        Store (Arg0, C0FD)
                        Store (0x00, Local0)
                        While (LAnd (LEqual (Local0, 0x00), LNot (LGreater (Local6, Arg1))))
                        {
                            Store (0x07, C0FB)
                            Store (0xFA, Local0)
                            While (LAnd (LNot (LEqual (0x00, C0FB)), LGreater (Local0, 0x00)))
                            {
                                Sleep (0x01)
                                Decrement (Local0)
                            }

                            Store (C100, Local0)
                            Store (Local0, Index (Local7, 0x00))
                            Store (C0FF, Local1)
                            Store (Local1, Index (Local7, Local6))
                            Increment (Local6)
                        }

                        Store (Local2, C0FD)
                        Store (Local3, C0FE)
                        Store (Local4, C0FF)
                        Store (Local5, C100)
                        Release (\_GL)
                        Release (C11B)
                        Return (Local7)
                    }

                    Method (C12D, 2, NotSerialized)
                    {
                        Store (0x00, Local1)
                        Acquire (C11B, 0xFFFF)
                        Acquire (\_GL, 0xFFFF)
                        Store (SizeOf (Arg1), Local7)
                        Store (0x09C4, Local0)
                        While (LAnd (LNot (LEqual (0x00, C0FB)), LGreater (Local0, 0x00)))
                        {
                            Stall (0x64)
                            Decrement (Local0)
                        }

                        Store (C0FD, Local2)
                        Store (C0FE, Local3)
                        Store (C0FF, Local4)
                        Store (C100, Local5)
                        Store (Local7, C0FE)
                        Store (Arg0, C0FD)
                        Store (0x00, Local0)
                        While (LAnd (LEqual (Local0, 0x00), LGreater (Local7, 0x00)))
                        {
                            Store (DerefOf (Index (Arg1, Local1)), Local6)
                            Store (Local6, C0FF)
                            Store (0x06, C0FB)
                            Store (0xFA, Local0)
                            While (LAnd (LNot (LEqual (0x00, C0FB)), LGreater (Local0, 0x00)))
                            {
                                Sleep (0x01)
                                Decrement (Local0)
                            }

                            Store (C100, Local0)
                            Decrement (Local7)
                            Increment (Local1)
                        }

                        Store (Local2, C0FD)
                        Store (Local3, C0FE)
                        Store (Local4, C0FF)
                        Store (Local5, C100)
                        Release (\_GL)
                        Release (C11B)
                        Return (Local0)
                    }

                    Method (C12E, 1, Serialized)
                    {
                        Store (C12A (0x1C, 0x01, 0x00, 0x00, 0x00), Local0)
                        Store (DerefOf (Index (Local0, 0x04)), Local1)
                        Store (Arg0, Local2)
                        While (LAnd (LNot (LEqual (0x00, Local1)), LGreater (Local2, 0x00)))
                        {
                            Sleep (0x5A)
                            Store (C12A (0x1C, 0x01, 0x00, 0x00, 0x00), Local0)
                            Store (DerefOf (Index (Local0, 0x04)), Local1)
                            Decrement (Local2)
                        }

                        Return (Local1)
                    }

                    Method (C12F, 0, Serialized)
                    {
                        Store (C12A (0x1C, 0x00, 0x00, 0x00, 0x00), Local0)
                        Store (DerefOf (Index (Local0, 0x04)), Local1)
                        Return (Local1)
                    }

                    Name (C130, 0xFF)
                    Name (C131, 0xFF)
                    Name (C132, 0x03)
                    Name (C133, 0x00)
                    Name (C134, 0x00)
                    Name (C135, 0x00)
                    Mutex (C136, 0x00)
                    Method (C137, 0, NotSerialized)
                    {
                        Store (C12B (0x1D, 0x0A, 0x05, 0x00), Local0)
                    }

                    Method (C138, 2, Serialized)
                    {
                        CreateDWordField (Arg0, Arg1, C139)
                        Return (C139)
                    }

                    Method (C13A, 2, Serialized)
                    {
                        Multiply (Arg0, And (Arg1, 0xFFFF), Local0)
                        ShiftRight (And (Arg1, 0x00FF0000), 0x10, Local1)
                        ShiftRight (Local0, Local1, Local0)
                        Multiply (Local0, 0x7D, Local0)
                        Divide (Add (Local0, 0x40), 0x80, Local2, Local3)
                        Return (Local3)
                    }

                    Method (C13B, 0, Serialized)
                    {
                        Acquire (\_GL, 0xFFFF)
                        And (C106, 0x01, Local0)
                        Release (\_GL)
                        Return (Local0)
                    }

                    Method (C13C, 2, Serialized)
                    {
                        Acquire (C136, 0xFFFF)
                        Or (Arg0, C132, Local1)
                        And (Local1, 0x03, C132)
                        If (And (C132, 0x02))
                        {
                            Or (C130, Arg1, C130)
                        }

                        Release (C136)
                    }

                    Method (C13D, 1, Serialized)
                    {
                        If (LEqual (Arg0, 0x01))
                        {
                            Store (0x01, C135)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x00))
                            {
                                Store (0x00, C135)
                            }
                        }

                        Return (C135)
                    }

                    Method (C13E, 1, Serialized)
                    {
                        Acquire (C136, 0xFFFF)
                        If (And (C132, 0x02))
                        {
                            And (C132, 0x01, C132)
                            Release (C136)
                            Acquire (\_GL, 0xFFFF)
                            Store (C103, Local0)
                            Release (\_GL)
                            Store (Local0, C134)
                        }
                        Else
                        {
                            Release (C136)
                            Store (C134, Local0)
                        }

                        Store (0x0F, Local1)
                        If (And (Local0, Arg0))
                        {
                            Store (0x1F, Local1)
                        }

                        Return (Local1)
                    }

                    Method (C13F, 3, Serialized)
                    {
                        Add (Arg2, 0x01, Local3)
                        Store (Buffer (Local3)
                            {
                                0x10
                            }, Local2)
                        Store (0x0A, Local5)
                        Store (0x01, Local1)
						Store (0x00, Local0)
                        While (LAnd (Local1, LGreater (Local5, 0x00)))
                        {
                            Store (C12E (0x00), Local1)
                            If (LNot (Local1))
                            {
                                Store (C12D (Arg0, Arg1), Local1)
                                If (LAnd (LNot (Local1), LGreater (Arg2, 0x00)))
                                {
                                    Store (C12C (Arg0, Arg2), Local0)
                                    Store (DerefOf (Index (Local0, 0x00)), Local1)
                                }

                                Or (C12F (), Local1, Local1)
                            }

                            Decrement (Local5)
                            If (LAnd (Local1, LGreater (Local5, 0x00)))
                            {
                                Sleep (0x64)
                            }
                        }

                        If (Local1)
                        {
                            Return (Local2)
                        }

                        Return (Local0)
                    }

                    Method (C140, 2, Serialized)
                    {
                        Store (C13F (Arg1, Buffer (0x01)
                                {
                                    0x06
                                }, 0x10), Local0)
                        Store (DerefOf (Index (Local0, 0x00)), Local1)
                        If (Local1)
                        {
                            Return (Local1)
                        }

                        Store (0x00, Local3)
                        While (LLess (Local3, 0x04))
                        {
                            Add (0x01, Multiply (Local3, 0x04), Local5)
                            Store (C138 (Local0, Local5), Local1)
                            ShiftRight (Local1, 0x17, Local2)
                            And (Local2, 0xFF, Local2)
                            Subtract (0x84, Local2, Local2)
                            ShiftLeft (Local2, 0x10, Local2)
                            And (Local1, 0x007FFFFF, Local1)
                            Or (Local1, 0x00800000, Local1)
                            Add (Local1, 0x80, Local1)
                            ShiftRight (Local1, 0x08, Local1)
                            Or (Local2, Local1, Local2)
                            Store (Local2, Index (DerefOf (Index (C141, Arg0)), Local3))
                            Increment (Local3)
                        }

                        Return (0x00)
                    }

                    Method (C142, 1, Serialized)
                    {
                        Store (Package (0x02)
                            {
                                0x00, 
                                0x00
                            }, Local5)
                        Store (C13F (Arg0, Buffer (0x01)
                                {
                                    0x09
                                }, 0x06), Local0)
                        Store (DerefOf (Index (Local0, 0x00)), Local1)
                        If (Local1)
                        {
                            Store (Local1, Index (Local5, 0x00))
                        }
                        Else
                        {
                            Name (C143, " ")
                            Store (DerefOf (Index (Local0, 0x02)), C143)
                            Store ("", Local2)
                            Concatenate (Local2, C143, Local3)
                            Store (DerefOf (Index (Local0, 0x01)), Local1)
                            Store (\C002 (Local1, 0x02), Local2)
                            Concatenate (Local3, Local2, Local4)
                            Store (ShiftLeft (DerefOf (Index (Local0, 0x04)), 0x08), Local1)
                            Or (Local1, DerefOf (Index (Local0, 0x03)), Local1)
                            Store (\C002 (Local1, 0x04), Local2)
                            Concatenate (Local4, Local2, Local3)
                            Store (ShiftLeft (DerefOf (Index (Local0, 0x06)), 0x08), Local1)
                            Or (Local1, DerefOf (Index (Local0, 0x05)), Local1)
                            Store (\C002 (Local1, 0x04), Local2)
                            Concatenate (Local3, Local2, Local4)
                            Store (Local4, Index (Local5, 0x01))
                        }

                        Return (Local5)
                    }

                    Name (C144, Package (0x05)
                    {
                        Package (0x03)
                        {
                            Buffer (0x01)
                            {
                                0x04
                            }, 

                            0x04
                        }, 

                        Package (0x03)
                        {
                            Buffer (0x01)
                            {
                                0x05
                            }, 

                            0x02
                        }, 

                        Package (0x03)
                        {
                            Buffer (0x01)
                            {
                                0x08
                            }, 

                            0x08
                        }, 

                        Package (0x03)
                        {
                            Buffer (0x02)
                            {
                                0x0C, 0x0E
                            }, 

                            0x02
                        }, 

                        Package (0x03)
                        {
                            Buffer (0x02)
                            {
                                0x0C, 0x2E
                            }, 

                            0x02
                        }
                    })
                    Method (C145, 4, Serialized)
                    {
                        Store (Package (0x03)
                            {
                                0x00, 
                                0x00, 
                                0x00
                            }, Local4)
                        Store (DerefOf (Index (DerefOf (Index (C144, Arg0)), 0x00)), Local0)
                        Store (DerefOf (Index (DerefOf (Index (C144, Arg0)), 0x01)), Local1)
                        Store (C13F (Arg1, Local0, Local1), Local2)
                        Store (DerefOf (Index (Local2, 0x00)), Local3)
                        If (Local3)
                        {
                            Store (Local3, Index (Local4, 0x00))
                        }
                        Else
                        {
                            Store (0x01, Local3)
                            If (LEqual (ObjectType (Arg2), 0x03))
                            {
                                Store (SizeOf (Arg2), Local3)
                            }

                            Store (0x00, Local5)
                            While (LLess (Local5, Local3))
                            {
                                If (LEqual (Local3, 0x01))
                                {
                                    Store (Arg2, Local6)
                                    Store (Arg3, Local7)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (Arg2, Local5)), Local6)
                                    Store (DerefOf (Index (Arg3, Local5)), Local7)
                                }

                                Add (Local6, 0x02, Local0)
                                Store (ShiftLeft (DerefOf (Index (Local2, Local0)), 0x08), Local1)
                                Decrement (Local0)
                                Or (Local1, DerefOf (Index (Local2, Local0)), Local1)
                                Store (C13A (Local1, Local7), Local0)
                                Increment (Local5)
                                Store (Local0, Index (Local4, Local5))
                            }
                        }

                        Return (Local4)
                    }

                    Method (C146, 1, Serialized)
                    {
                        Store (0x00, Local4)
                        Acquire (\_GL, 0xFFFF)
                        And (C113, Arg0, Local0)
                        And (C114, Arg0, Local1)
                        And (C115, Arg0, Local2)
                        Store (C117, Local3)
                        If (And (Local3, 0x80))
                        {
                            And (Local3, 0x7F, C117)
                        }

                        Release (\_GL)
                        And (Local3, 0x80, Local4)
                        If (Local0)
                        {
                            Or (0x01, Local4, Local4)
                        }

                        If (Local1)
                        {
                            Or (0x02, Local4, Local4)
                        }

                        If (Local2)
                        {
                            Or (0x04, Local4, Local4)
                        }

                        If (LAnd (And (Local4, 0x02), And (Local4, 0x01)))
                        {
                            If (LEqual (C13B (), 0x01))
                            {
                                And (0xFFFFFFFE, Local4, Local4)
                            }
                            Else
                            {
                                And (0xFFFFFFFD, Local4, Local4)
                            }
                        }

                        Return (Local4)
                    }

                    Method (C147, 1, Serialized)
                    {
                        Store (DerefOf (Index (C148, Arg0)), Local6)
                        ShiftLeft (0x01, ShiftRight (And (Local6, 0x0F), 0x01), Local7)
                        C13D (0x01)
                        If (LEqual (C13E (Local7), 0x0F))
                        {
                            Return (0xFFFFFFFD)
                        }

                        Acquire (C136, 0xFFFF)
                        Store (C130, Local0)
                        Release (C136)
                        If (LEqual (And (Local0, Local7), 0x00))
                        {
                            Return (0x00)
                        }

                        Store (C149, Index (C14A, Arg0))
                        Store (C140 (Arg0, Local6), Local0)
                        If (Local0)
                        {
                            Return (Or (Local0, 0x01))
                        }

                        Store (DerefOf (Index (DerefOf (Index (C141, Arg0)), 0x03)), Local1)
                        Store (C145 (0x03, Local6, 0x00, Local1), Local2)
                        Store (DerefOf (Index (Local2, 0x00)), Local0)
                        If (Local0)
                        {
                            Return (Or (Local0, 0x02))
                        }

                        Store (DerefOf (Index (Local2, 0x01)), Index (DerefOf (Index (C14B, Arg0)), 0x01))
                        Store (C145 (0x00, Local6, 0x00, Local1), Local2)
                        Store (DerefOf (Index (Local2, 0x00)), Local0)
                        If (Local0)
                        {
                            Return (Or (Local0, 0x03))
                        }

                        Store (DerefOf (Index (Local2, 0x01)), Local3)
                        Store (Local3, Index (DerefOf (Index (C14B, Arg0)), 0x02))
                        Store (DerefOf (Index (DerefOf (Index (C141, Arg0)), 0x01)), Local4)
                        Store (C145 (0x04, Local6, 0x00, Local4), Local2)
                        Store (DerefOf (Index (Local2, 0x00)), Local0)
                        If (Local0)
                        {
                            Return (Or (Local0, 0x04))
                        }

                        Store (DerefOf (Index (Local2, 0x01)), Index (DerefOf (Index (C14B, Arg0)), 0x04))
                        Store (C13A (0x01, Local1), Local3)
                        Store (Local3, Index (DerefOf (Index (C14B, Arg0)), 0x07))
                        Store (Local3, Index (DerefOf (Index (C14B, Arg0)), 0x08))
                        Store (C142 (Local6), Local2)
                        Store (DerefOf (Index (Local2, 0x00)), Local0)
                        If (Local0)
                        {
                            Return (Or (Local0, 0x04))
                        }

                        Store (DerefOf (Index (Local2, 0x01)), Index (DerefOf (Index (C14B, Arg0)), 0x0A))
                        Acquire (C136, 0xFFFF)
                        And (C130, Not (Local7), C130)
                        Release (C136)
                        Return (0x00)
                    }

                    Method (C14C, 2, Serialized)
                    {
                        Store (DerefOf (Index (C148, Arg0)), Local6)
                        ShiftLeft (0x01, ShiftRight (And (Local6, 0x0F), 0x01), Local7)
                        C13D (0x01)
                        Store (C146 (Local7), Local4)
                        And (Local4, 0x07, Index (DerefOf (Index (C14A, Arg0)), 0x00))
                        If (Arg1)
                        {
                            Return (0x00)
                        }

                        If (LEqual (C13E (Local7), 0x0F))
                        {
                            Store (Package (0x04)
                                {
                                    0x00, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF
                                }, Index (C14A, Arg0))
                            Return (0xFFFFFFFD)
                        }

                        If (And (Local4, 0x80))
                        {
                            Store (0xFF, C131)
                        }

                        If (LEqual (And (C131, Local7), 0x00))
                        {
                            Return (0x00)
                        }

                        Store (Package (0x02) {}, Local1)
                        Store (DerefOf (Index (DerefOf (Index (C141, Arg0)), 0x01)), Index (Local1, 0x00))
                        Store (DerefOf (Index (DerefOf (Index (C141, Arg0)), 0x00)), Index (Local1, 0x01))
                        Store (C145 (0x02, Local6, Buffer (0x02)
                                {
                                    0x00, 0x02
                                }, Local1), Local2)
                        Store (DerefOf (Index (Local2, 0x00)), Local0)
                        If (Local0)
                        {
                            Return (Or (Local0, 0x03))
                        }

                        Store (DerefOf (Index (Local2, 0x01)), Local5)
                        Store (Local5, Index (DerefOf (Index (C14A, Arg0)), 0x03))
                        Store (0x00, Local3)
                        If (And (Local4, 0x01))
                        {
                            Store (DerefOf (Index (DerefOf (Index (C141, Arg0)), 0x02)), Local1)
                            Store (C145 (0x01, Local6, 0x00, Local1), Local2)
                            Store (DerefOf (Index (Local2, 0x00)), Local0)
                            If (Local0)
                            {
                                Return (Or (Local0, 0x01))
                            }

                            Store (DerefOf (Index (Local2, 0x01)), Local3)
                            If (LOr (LLess (Local3, 0x2710), LGreater (Local3, 0x4650)))
                            {
                                Store (DerefOf (Index (DerefOf (Index (C14A, Arg0)), 0x01)), Local5)
                                If (LOr (LLess (Local5, 0x2710), LGreater (Local5, 0x4650)))
                                {
                                    Store (0x36B0, Local3)
                                }
                                Else
                                {
                                    Store (Local5, Local3)
                                }
                            }
                        }
                        Else
                        {
                            If (And (Local4, 0x02))
                            {
                                Multiply (DerefOf (Index (Local2, 0x02)), Local5, Local1)
                                Divide (Local1, 0x03E8, Local0, Local3)
                            }
                        }

                        Store (Local3, Index (DerefOf (Index (C14A, Arg0)), 0x01))
                        Store (DerefOf (Index (DerefOf (Index (C141, Arg0)), 0x03)), Local1)
                        Store (C145 (0x00, Local6, 0x02, Local1), Local2)
                        Store (DerefOf (Index (Local2, 0x00)), Local0)
                        If (Local0)
                        {
                            Return (Or (Local0, 0x02))
                        }

                        If (And (Local4, 0x04))
                        {
                            Store (0x00, Index (DerefOf (Index (C14A, Arg0)), 0x02))
                        }
                        Else
                        {
                            Store (DerefOf (Index (Local2, 0x01)), Index (DerefOf (Index (C14A, Arg0)), 0x02))
                        }

                        And (C131, Not (Local7), C131)
                        Return (0x00)
                    }

                    Method (C14E, 2, NotSerialized)
                    {
                        Store (DerefOf (Index (C148, Arg0)), Local6)
                        ShiftLeft (0x01, ShiftRight (And (Local6, 0x0F), 0x01), Local7)
                        C13D (0x01)
                        If (LEqual (C13E (Local7), 0x0F))
                        {
                            Return (0xFFFFFFFD)
                        }

                        If (LNot (LEqual (DerefOf (Index (C14F, Arg0)), Arg1)))
                        {
                            Store (DerefOf (Index (DerefOf (Index (C141, Arg0)), 0x03)), Local0)
                            Store (Buffer (0x03)
                                {
                                    0x07, 0x00, 0x00
                                }, Local4)
                            If (LAnd (Local0, Arg1))
                            {
                                Multiply (Arg1, 0x80, Local1)
                                Divide (Add (Local1, 0x3E), 0x7D, Local2, Local3)
                                ShiftRight (And (Local0, 0x00FF0000), 0x10, Local2)
                                ShiftLeft (Local3, Local2, Local1)
                                Divide (Local1, And (Local0, 0xFFFF), Local2, Local3)
                                And (ShiftRight (Local3, 0x08), 0xFF, Index (Local4, 0x02))
                                And (Local3, 0xFF, Index (Local4, 0x01))
                            }

                            Store (C13F (Local6, Local4, 0x00), Local0)
                            Store (Arg1, Index (C14F, Arg0))
                        }

                        Return (0x00)
                    }

                    Method (C150, 2, Serialized)
                    {
                        And (C022, 0x10, Local0)
                        And (Not (C022), Arg1, Local1)
                        If (LOr (Local0, Local1))
                        {
                            Store (0x00, Local0)
                        }
                        Else
                        {
                            Store (C0F1 (Arg0), Local1)
                            Store (0x0D, Local0)
                            If (Local1)
                            {
                                Store (0x0F, Local0)
                            }
                        }

                        Return (Local0)
                    }

                    Method (C151, 1, Serialized)
                    {
                        If (C0F1 (Arg0))
                        {
                            Store (C0F2 (Arg0), Local0)
                            Store (DerefOf (Index (Local0, 0x01)), Local1)
                            Store (DerefOf (Index (Local0, 0x02)), Local2)
                            Store (DerefOf (Index (Local0, 0x03)), Local3)
                            \_SB.C0DF (Arg0, 0x00, Local1, Local2, Local3)
                            C0F4 (Arg0, 0x00, 0x00, 0x00, 0x00)
                        }
                    }

                    Method (C152, 0, NotSerialized)
                    {
                        Store (^^C153, Local3)
                        If (\_SB.C154 ())
                        {
                            If (C0F1 (0x04))
                            {
                                Name (C155, ResourceTemplate ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                })
                                CreateWordField (C155, 0x02, C157)
                                CreateWordField (C155, 0x04, C158)
                                Store (C0F2 (0x04), Local1)
                                Store (DerefOf (Index (Local1, 0x00)), C157)
                                Store (C157, C158)
                                Add (SizeOf (C155), SizeOf (Local3), Local1)
                                Subtract (Local1, 0x02, Local1)
                                Store (Buffer (Local1) {}, Local0)
                                Store (0x00, Local1)
                                While (LLess (Local1, SizeOf (Local3)))
                                {
                                    Store (DerefOf (Index (Local3, Local1)), Index (Local0, Local1))
                                    Increment (Local1)
                                }

                                Subtract (Local1, 0x02, Local1)
                                Store (0x00, Local2)
                                While (LLess (Local2, SizeOf (C155)))
                                {
                                    Store (DerefOf (Index (C155, Local2)), Index (Local0, Local1))
                                    Increment (Local1)
                                    Increment (Local2)
                                }

                                Store (Local0, Local3)
                            }
                        }

                        Return (Local3)
                    }

                    Device (C159)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_CID, 0x0005D041)
                        Name (_DDN, "COM1")
                        Name (C15A, 0x00)
                        Name (C15B, ResourceTemplate ()
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
                            Return (C15B)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            If (C15A)
                            {
                                Store (0x0D, Local0)
                            }
                            Else
                            {
                                Store (C150 (0x04, 0x02), Local0)
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            If (LOr (\_SB.C021, LEqual (0x00, 0x01)))
                            {
                                Store (0x01, C15A)
                                Return (0x00)
                            }

                            C151 (0x04)
                            Return (0x00)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x02, C157)
                            CreateWordField (Arg0, 0x09, C15C)
                            If (C150 (0x04, 0x02))
                            {
                                _DIS ()
                                \_SB.C0DF (0x04, C157, 0x00, C15C, 0x00)
                                C0F4 (0x04, C157, 0x00, C15C, 0x00)
                            }

                            Store (0x00, C15A)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (C00A, ResourceTemplate ()
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                            })
                            CreateWordField (C00A, 0x02, C157)
                            CreateWordField (C00A, 0x04, C158)
                            CreateWordField (C00A, 0x09, C15C)
                            If (C15A)
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Store (C150 (0x04, 0x02), Local0)
                            }

                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, C157)
                                Store (0x00, C158)
                                Store (0x00, C15C)
                                Return (C00A)
                            }

                            Store (C0F2 (0x04), Local1)
                            Store (DerefOf (Index (Local1, 0x00)), C157)
                            Store (C157, C158)
                            Store (DerefOf (Index (Local1, 0x02)), C15C)
                            Return (C00A)
                        }

                        PowerResource (C15D, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)
                            {
                                Return (C0F6 (0x04))
                            }

                            Method (_ON, 0, NotSerialized)
                            {
                                C0F7 (0x04, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)
                            {
                                If (LOr (\_SB.C021, LEqual (0x00, 0x01)))
                                {
                                    Store (0x00, Local0)
                                }
                                Else
                                {
                                    C0F7 (0x04, 0x00)
                                }
                            }
                        }

                        Name (_PR0, Package (0x01)
                        {
                            C15D
                        })
                    }

                    Device (C15E)
                    {
                        Name (_HID, EisaId ("PNP0700"))
                        Device (C15F)
                        {
                            Name (_ADR, 0x00)
                            Name (_FDI, Package (0x10)
                            {
                                0x00, 
                                0x04, 
                                0x4F, 
                                0x12, 
                                0x01, 
                                0xDF, 
                                0x02, 
                                0x25, 
                                0x02, 
                                0x12, 
                                0x1B, 
                                0xFF, 
                                0x65, 
                                0xF6, 
                                0x0F, 
                                0x08
                            })
                        }

                        Device (C160)
                        {
                            Name (_ADR, 0x01)
                            Name (_FDI, Package (0x10)
                            {
                                0x01, 
                                0x04, 
                                0x4F, 
                                0x12, 
                                0x01, 
                                0xDF, 
                                0x02, 
                                0x25, 
                                0x02, 
                                0x12, 
                                0x1B, 
                                0xFF, 
                                0x65, 
                                0xF6, 
                                0x0F, 
                                0x08
                            })
                        }

                        Name (C15B, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (C15B)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            Store (C150 (0x00, 0x08), Local0)
                            If (LEqual (And (C022, 0x08), 0x00))
                            {
                                If (LOr (LEqual (C008, 0x01), LEqual (C008, 0x02)))
                                {
                                    Store (0x0F, Local0)
                                }
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            C151 (0x00)
                        }

                        OperationRegion (C161, SystemIO, 0x03F0, 0x08)
                        Field (C161, AnyAcc, NoLock, Preserve)
                        {
                            C162,   8, 
                            C163,   8, 
                            C164,   8, 
                            C165,   8, 
                            C166,   8, 
                            C167,   8, 
                            C168,   8, 
                            C169,   8
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x02, C157)
                            CreateWordField (Arg0, 0x0A, C16A)
                            CreateWordField (Arg0, 0x11, C15C)
                            CreateWordField (Arg0, 0x14, C16B)
                            If (C150 (0x00, 0x08))
                            {
                                _DIS ()
                                \_SB.C0DF (0x00, C157, C16A, C15C, C16B)
                                C0F4 (0x00, C157, C16A, C15C, C16B)
                                \_SB.C16C (0x01)
                                If (LOr (LEqual (C008, 0x01), LEqual (C008, 0x02)))
                                {
                                    Store (Or (C164, 0x04), C164)
                                }
                            }
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (C00A, ResourceTemplate ()
                            {
                                IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                                IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                                IRQNoFlags () {6}
                                DMA (Compatibility, NotBusMaster, Transfer8) {2}
                            })
                            CreateWordField (C00A, 0x02, C157)
                            CreateWordField (C00A, 0x04, C158)
                            CreateWordField (C00A, 0x0A, C16A)
                            CreateWordField (C00A, 0x0C, C170)
                            CreateWordField (C00A, 0x11, C15C)
                            CreateWordField (C00A, 0x14, C16B)
                            If (LEqual (C150 (0x00, 0x08), 0x00))
                            {
                                If (LEqual (And (C022, 0x08), 0x00))
                                {
                                    If (LOr (LEqual (C008, 0x01), LEqual (C008, 0x02)))
                                    {
                                        Return (C00A)
                                    }
                                }
                                Else
                                {
                                    Store (0x00, C157)
                                    Store (0x00, C158)
                                    Store (0x00, C16A)
                                    Store (0x00, C170)
                                    Store (0x00, C15C)
                                    Store (0x00, C16B)
                                    Return (C00A)
                                }
                            }

                            Store (C0F2 (0x00), Local1)
                            Store (DerefOf (Index (Local1, 0x00)), C157)
                            Store (C157, C158)
                            Add (C157, 0x07, C16A)
                            Store (C16A, C170)
                            Store (DerefOf (Index (Local1, 0x02)), C15C)
                            Store (DerefOf (Index (Local1, 0x03)), C16B)
                            Return (C00A)
                        }

                        PowerResource (C171, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)
                            {
                                Return (C0F6 (0x00))
                            }

                            Method (_ON, 0, NotSerialized)
                            {
                                C0F7 (0x00, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)
                            {
                                C0F7 (0x00, 0x00)
                            }
                        }

                        Name (_PR0, Package (0x01)
                        {
                            C171
                        })
                        Scope (C15F)
                        {
                            Name (_RMV, 0x01)
                            Method (_STA, 0, NotSerialized)
                            {
                                Store (0x00, Local0)
                                Store (\_SB.C16C (0x00), Local3)
                                Store (\_SB.C0E0 (), Local7)
                                If (Local3)
                                {
                                    Store (0x02, Local7)
                                }
                                Else
                                {
                                    ShiftRight (Local7, 0x04, Local7)
                                }

                                If (LEqual (Local7, 0x02))
                                {
                                    Store (0x0F, Local0)
                                }

                                Return (Local0)
                            }
                        }

                        Method (_FDE, 0, NotSerialized)
                        {
                            Name (C172, Buffer (0x14)
                            {
                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                                0x02, 0x00, 0x00, 0x00
                            })
                            CreateDWordField (C172, 0x00, C173)
                            Store (^C15F._STA (), Local0)
                            If (LEqual (Local0, 0x0F))
                            {
                                Store (0x01, C173)
                            }

                            Return (C172)
                        }
                    }

                    Device (C174)
                    {
                        Name (_HID, EisaId ("SMCF010"))
                        Name (_CID, 0x1105D041)
                        Name (C15B, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IO (Decode16, 0x0100, 0x0130, 0x08, 0x08)
                                IRQNoFlags () {3,4,5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IO (Decode16, 0x0100, 0x0130, 0x08, 0x08)
                                IRQNoFlags () {3,4,5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IO (Decode16, 0x0100, 0x0130, 0x08, 0x08)
                                IRQNoFlags () {3,4,5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IO (Decode16, 0x0100, 0x0130, 0x08, 0x08)
                                IRQNoFlags () {3,4,5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (C15B)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            Return (C150 (0x05, 0x01))
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            C151 (0x05)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x02, C157)
                            CreateWordField (Arg0, 0x0A, C16A)
                            CreateWordField (Arg0, 0x11, C15C)
                            CreateWordField (Arg0, 0x14, C16B)
                            If (C150 (0x05, 0x01))
                            {
                                ^_DIS ()
                                \_SB.C0DF (0x05, C157, C16A, C15C, C16B)
                                ^^C0F4 (0x05, C157, C16A, C15C, C16B)
                            }
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (C00A, ResourceTemplate ()
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IO (Decode16, 0x0100, 0x0100, 0x10, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            })
                            CreateWordField (C00A, 0x02, C157)
                            CreateWordField (C00A, 0x04, C158)
                            CreateWordField (C00A, 0x0A, C16A)
                            CreateWordField (C00A, 0x0C, C170)
                            CreateWordField (C00A, 0x11, C15C)
                            CreateWordField (C00A, 0x14, C16B)
                            If (LEqual (C150 (0x05, 0x01), 0x00))
                            {
                                Store (0x00, C157)
                                Store (0x00, C158)
                                Store (0x00, C16A)
                                Store (0x00, C170)
                                Store (0x00, C15C)
                                Store (0x00, C16B)
                                Return (C00A)
                            }

                            Store (C0F2 (0x05), Local1)
                            Store (DerefOf (Index (Local1, 0x00)), C157)
                            Store (C157, C158)
                            Store (DerefOf (Index (Local1, 0x01)), C16A)
                            Store (C16A, C170)
                            Store (DerefOf (Index (Local1, 0x02)), C15C)
                            Store (DerefOf (Index (Local1, 0x03)), C16B)
                            Return (C00A)
                        }

                        PowerResource (C175, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)
                            {
                                Return (C0F6 (0x05))
                            }

                            Method (_ON, 0, NotSerialized)
                            {
                                C0F7 (0x05, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)
                            {
                                C0F7 (0x05, 0x00)
                            }
                        }

                        Name (_PR0, Package (0x01)
                        {
                            C175
                        })
                    }

                    Device (C176)
                    {
                        Name (_HID, EisaId ("PNP0401"))
                        Name (C15B, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x03)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x03)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x03)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x03)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x03)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x03)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x03)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfer8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x03)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfer8) {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x03)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfer8) {}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (C15B)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            Return (C150 (0x03, 0x04))
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            C151 (0x03)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x02, C157)
                            CreateWordField (Arg0, 0x0A, C16A)
                            CreateWordField (Arg0, 0x11, C15C)
                            CreateWordField (Arg0, 0x14, C16B)
                            If (C150 (0x03, 0x04))
                            {
                                _DIS ()
                                \_SB.C0DF (0x03, C157, C16A, C15C, C16B)
                                C0F4 (0x03, C157, C16A, C15C, C16B)
                            }
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (C00A, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x03)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            })
                            CreateWordField (C00A, 0x02, C157)
                            CreateWordField (C00A, 0x04, C158)
                            CreateByteField (C00A, 0x07, C177)
                            CreateWordField (C00A, 0x0A, C16A)
                            CreateWordField (C00A, 0x0C, C170)
                            CreateWordField (C00A, 0x11, C15C)
                            CreateWordField (C00A, 0x14, C16B)
                            If (LEqual (C150 (0x03, 0x04), 0x00))
                            {
                                Store (0x00, C157)
                                Store (0x00, C158)
                                Store (0x00, C16A)
                                Store (0x00, C170)
                                Store (0x00, C15C)
                                Store (0x00, C16B)
                                Return (C00A)
                            }

                            Store (C0F2 (0x03), Local1)
                            Store (DerefOf (Index (Local1, 0x00)), C157)
                            Store (C157, C158)
                            If (LEqual (C157, 0x03BC))
                            {
                                Store (0x04, C177)
                            }

                            Add (C157, 0x0400, C16A)
                            Store (C16A, C170)
                            Store (DerefOf (Index (Local1, 0x02)), C15C)
                            Store (DerefOf (Index (Local1, 0x03)), C16B)
                            Return (C00A)
                        }

                        PowerResource (C178, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)
                            {
                                Return (C0F6 (0x03))
                            }

                            Method (_ON, 0, NotSerialized)
                            {
                                C0F7 (0x03, 0x01)
                            }

                            Method (_OFF, 0, NotSerialized)
                            {
                                C0F7 (0x03, 0x00)
                            }
                        }

                        Name (_PR0, Package (0x01)
                        {
                            C178
                        })
                    }

                    Method (\_SB.C179, 0, NotSerialized)
                    {
                        Store (\_SB.C045.C059.C0E2.C0F1 (0x04), Local0)
                        Return (Local0)
                    }

                    Method (\_SB.C154, 0, NotSerialized)
                    {
                        Store (0x01, Local0)
                        If (Not (And (\_SB.C022, 0x10)))
                        {
                            Store (0x00, Local0)
                        }

                        Return (Local0)
                    }

                    Method (\_SB.C16C, 1, NotSerialized)
                    {
                        Store (0x00, Local0)
                        Acquire (\_GL, 0xFFFF)
                        And (\_SB.C045.C059.C0E2.C105, 0x20, Local1)
                        Release (\_GL)
                        If (Arg0)
                        {
                            Store (0x01, Local0)
                            And (\_GPE.C121, 0xFFFFFFDF, Local2)
                            Or (Local1, Local2, \_GPE.C121)
                        }

                        If (Local1)
                        {
                            Or (Local0, 0x02, Local0)
                        }

                        Return (Local0)
                    }
                }

                Device (C17A)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x10)
                        IRQNoFlags () {13}
                    })
                }

                Device (C17B)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQNoFlags () {0}
                    })
                }

                Device (C16B)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x10)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer16) {4}
                    })
                }

                Device (C17C)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                    })
                }

                Device (C17D)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x02)
                        IO (Decode16, 0x0072, 0x0072, 0x01, 0x02)
                        IRQNoFlags () {8}
                    })
                }

                Device (C17E)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQNoFlags () {1}
                    })
                }

                Device (C17F)
                {
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Name (C180, 0x01)
                    PowerResource (C181, 0x00, 0x0000)
                    {
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (C180)
                        }

                        Method (_ON, 0, NotSerialized)
                        {
                            Store (0x01, C180)
                        }

                        Method (_OFF, 0, NotSerialized)
                        {
                            Store (0x00, C180)
                        }
                    }

                    Name (_PR0, Package (0x01)
                    {
                        C181
                    })
                }

                Scope (C17F)
                {
                    Name (_HID, EisaId ("SYN0100"))
                    Name (_CID, 0x130FD041)
                }

                Device (C182)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IRQNoFlags () {2}
                    })
                }
            }

            Scope (C058)
            {
                Device (C183)
                {
                    Name (_ADR, 0x00060000)
                    OperationRegion (C184, PCI_Config, 0x44, 0x04)
                    Field (C184, AnyAcc, NoLock, Preserve)
                    {
                        C185,   32
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Store (0x00, C185)
                    }
                }

                Device (C186)
                {
                    Name (_ADR, 0x00060001)
                    OperationRegion (C187, PCI_Config, 0x44, 0x04)
                    Field (C187, AnyAcc, NoLock, Preserve)
                    {
                        C185,   32
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Store (0x00, C185)
                    }
                }

                Device (C0AA)
                {
                    Name (_ADR, 0x000E0000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x03
                    })
                    Name (_S3D, 0x03)
                    Device (C0AE)
                    {
                        Name (_ADR, 0x00)
                        Device (C0AF)
                        {
                            Name (_ADR, 0x00)
                        }

                        Device (C0B1)
                        {
                            Name (_ADR, 0x01)
                        }

                        Device (C0B4)
                        {
                            Name (_ADR, 0x02)
                        }
                    }
                }

                Device (C0B0)
                {
                    Name (_ADR, 0x000E0001)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x03
                    })
                    Name (_S3D, 0x03)
                    Device (C0AE)
                    {
                        Name (_ADR, 0x00)
                        Device (C0AF)
                        {
                            Name (_ADR, 0x00)
                        }

                        Device (C0B1)
                        {
                            Name (_ADR, 0x01)
                        }
                    }
                }

                Device (C0B3)
                {
                    Name (_ADR, 0x000E0002)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x03
                    })
                    Name (_S3D, 0x03)
                    Device (C0AE)
                    {
                        Name (_ADR, 0x00)
                        Device (C0AF)
                        {
                            Name (_ADR, 0x00)
                        }

                        Device (C0B1)
                        {
                            Name (_ADR, 0x01)
                        }

                        Device (C0B4)
                        {
                            Name (_ADR, 0x02)
                        }

                        Device (C0B5)
                        {
                            Name (_ADR, 0x03)
                        }

                        Device (C0B6)
                        {
                            Name (_ADR, 0x04)
                        }
                    }
                }

                Device (C188)
                {
                    Name (_ADR, 0x00040000)
                }

                Device (C189)
                {
                    Name (_ADR, 0x00040001)
                }
            }

            Scope (C097)
            {
                Device (C18A)
                {
                    Name (_ADR, 0x00)
                    Name (C18B, Package (0x05)
                    {
                        0x00, 
                        0x00, 
                        0x00, 
                        0x00, 
                        0x00
                    })
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (Buffer (0x14)
                            {
                                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
                                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
                                0xFF, 0xFF, 0xFF, 0xFF
                            }, Local0)
                        CreateDWordField (Local0, 0x00, C18C)
                        CreateDWordField (Local0, 0x04, C18D)
                        CreateDWordField (Local0, 0x10, C18E)
                        Store (C09F (0x00, 0x00), C18C)
                        Store (C0A2 (0x00), C18E)
                        If (And (C18E, 0x01))
                        {
                            Store (C0A1 (0x00, 0x00), C18D)
                        }
                        Else
                        {
                            Store (C18C, C18D)
                        }

                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, 0x00, C18C)
                        CreateDWordField (Arg0, 0x04, C18D)
                        CreateDWordField (Arg0, 0x10, C18E)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            Store (0x00, Local0)
                            Store (Buffer (Multiply (SizeOf (C18F), 0x02)) {}, Local1)
                            While (LLess (Local0, SizeOf (C18F)))
                            {
                                Store (DerefOf (Index (C18F, Local0)), Local2)
                                Multiply (Local2, 0x02, Local2)
                                Multiply (Local0, 0x02, Local3)
                                Store (DerefOf (Index (Arg1, Local2)), Index (Local1, Local3))
                                Store (DerefOf (Index (Arg1, Add (Local2, 0x01))), Index (Local1, Add (Local3, 0x01)))
                                Increment (Local0)
                            }

                            Store (C0A3 (0x00, 0x00, C18C, C18E, Local1), Local2)
                            Store (C0A7 (0x00, 0x00, C18D, C18E, Local1), Local3)
                            \_SB.C190 (Local2, Local3, Local1, C18B)
                            If (\_SB.C191)
                            {
                                Store (0x00, \_SB.C191)
                                If (And (DerefOf (Index (Arg1, 0x0100)), 0x02))
                                {
                                    \_SB.C0D8 (0xEA49, 0x0C, 0x00, 0x00, 0x00)
                                }
                            }
                        }
                    }

                    Device (C15F)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (\_SB.C192 (C18B, 0x00))
                        }
                    }
                }

                Device (C193)
                {
                    Name (_ADR, 0x01)
                    Name (C194, Package (0x05)
                    {
                        0x00, 
                        0x00, 
                        0x00, 
                        0x00, 
                        0x00
                    })
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (Buffer (0x14)
                            {
                                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
                                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
                                0xFF, 0xFF, 0xFF, 0xFF
                            }, Local0)
                        CreateDWordField (Local0, 0x00, C18C)
                        CreateDWordField (Local0, 0x04, C18D)
                        CreateDWordField (Local0, 0x10, C18E)
                        Store (C09F (0x01, 0x00), C18C)
                        Store (C0A2 (0x01), C18E)
                        If (And (C18E, 0x01))
                        {
                            Store (C0A1 (0x01, 0x00), C18D)
                        }
                        Else
                        {
                            Store (C18C, C18D)
                        }

                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, 0x00, C18C)
                        CreateDWordField (Arg0, 0x04, C18D)
                        CreateDWordField (Arg0, 0x10, C18E)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            Store (0x00, Local0)
                            Store (Buffer (Multiply (SizeOf (C18F), 0x02)) {}, Local1)
                            While (LLess (Local0, SizeOf (C18F)))
                            {
                                Store (DerefOf (Index (C18F, Local0)), Local2)
                                Multiply (Local2, 0x02, Local2)
                                Multiply (Local0, 0x02, Local3)
                                Store (DerefOf (Index (Arg1, Local2)), Index (Local1, Local3))
                                Store (DerefOf (Index (Arg1, Add (Local2, 0x01))), Index (Local1, Add (Local3, 0x01)))
                                Increment (Local0)
                            }

                            Store (C0A3 (0x01, 0x00, C18C, C18E, Local1), Local2)
                            Store (C0A7 (0x01, 0x00, C18D, C18E, Local1), Local3)
                            \_SB.C190 (Local2, Local3, Local1, C194)
                            If (And (DerefOf (Index (Arg1, 0x0100)), 0x04))
                            {
                                \_SB.C0D8 (0xEA49, 0x0C, 0x05, 0x00, 0x00)
                            }
                        }
                    }

                    Device (C15F)
                    {
                        Name (_ADR, 0x00)
                        Name (_RMV, 0x01)
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
                            Return (\_SB.C192 (C194, 0x00))
                        }
                    }
                }

                Method (C0A9, 2, NotSerialized)
                {
                    Store (0x02, Local0)
                    If (LAnd (LEqual (Arg0, 0x00), LEqual (Arg1, 0x00)))
                    {
                        Store (0x05, Local0)
                    }

                    Return (Local0)
                }
            }

            Name (C0C0._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {5,10,11}
            })
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
                IRQ (Level, ActiveLow, Shared) {}
            })
            Name (C0C6._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {}
            })
            Name (C0C7._PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {}
            })
            Name (_PRT, Package (0x02)
            {
                Package (0x04)
                {
                    0x001FFFFF, 
                    0x00, 
                    C0C2, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x01, 
                    C0C1, 
                    0x00
                }
            })
            Name (C046._PRT, Package (0x01)
            {
                Package (0x04)
                {
                    0xFFFF, 
                    0x00, 
                    C0C0, 
                    0x00
                }
            })
            Name (C058._PRT, Package (0x07)
            {
                Package (0x04)
                {
                    0x0004FFFF, 
                    0x00, 
                    C0C1, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    0x01, 
                    C0C2, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x00, 
                    C0C3, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    0x00, 
                    C0C4, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    0x00, 
                    C0C4, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    0x01, 
                    C0C4, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    0x02, 
                    C0C4, 
                    0x00
                }
            })
        }

        Name (C14B, Package (0x02)
        {
            Package (0x0D)
            {
                0x00, 
                0xB3B0, 
                0xB3B0, 
                0x01, 
                0x3840, 
                0x00, 
                0x00, 
                0x01, 
                0x01, 
                "Primary", 
                "100000", 
                "LIon", 
                " COMPAQ "
            }, 

            Package (0x0D)
            {
                0x00, 
                0xB3B0, 
                0xB3B0, 
                0x01, 
                0x3840, 
                0x00, 
                0x00, 
                0x01, 
                0x01, 
                "MultiBay", 
                "100000", 
                "LIon", 
                " COMPAQ "
            }
        })
        Name (C148, Buffer (0x02)
        {
            0x30, 0x36
        })
        Name (C14A, Package (0x02)
        {
            Package (0x04)
            {
                0x00, 
                0x00, 
                0xB010, 
                0x40F2
            }, 

            Package (0x04)
            {
                0x00, 
                0x00, 
                0xB010, 
                0x40F2
            }
        })
        Name (C141, Package (0x02)
        {
            Package (0x04)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00
            }, 

            Package (0x04)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (C14F, Package (0x02)
        {
            0xFFFFFFFD, 
            0xFFFFFFFD
        })
        Name (C149, Package (0x04)
        {
            0x00, 
            0x00, 
            0xB010, 
            0x40F2
        })
        Name (C133, 0x00)
        Method (C147, 1, Serialized)
        {
            Store (\_SB.C045.C059.C0E2.C147 (Arg0), Local0)
            If (LEqual (Local0, 0xFFFFFFFD))
            {
                Return (Package (0x0D)
                {
                    0x00, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    0x01, 
                    0xFFFFFFFF, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    "", 
                    "", 
                    "", 
                    0x00
                })
            }
            Else
            {
                Return (DerefOf (Index (C14B, Arg0)))
            }
        }

        Method (C14C, 1, Serialized)
        {
            Store (\_SB.C045.C059.C0E2.C14C (Arg0, 0x00), Local0)
            Return (DerefOf (Index (C14A, Arg0)))
        }

        Name (C195, 0x00)
        Method (C196, 2, NotSerialized)
        {
            Store (C195, Local0)
            If (Arg0)
            {
                Or (Local0, Arg1, C195)
            }
            Else
            {
                And (Local0, Not (Arg1), C195)
            }
        }

        Method (C197, 0, Serialized)
        {
            Store (Package (0x01)
                {
                    \_SB
                }, Local0)
            Return (Local0)
        }

        Device (C198)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Method (_INI, 0, NotSerialized)
            {
                \_SB.C045.C059.C0E2.C137 ()
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (\_SB.C045.C059.C0E2.C13E (0x01))
            }

            Method (_BIF, 0, NotSerialized)
            {
                Return (C147 (0x00))
            }

            Method (_BST, 0, NotSerialized)
            {
                Return (C14C (0x00))
            }

            Name (_PRW, Package (0x02)
            {
                0x0B, 
                0x03
            })
            Method (_PSW, 1, NotSerialized)
            {
                C196 (Arg0, 0x01)
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (C197 ())
            }

            Method (_BTP, 1, NotSerialized)
            {
                \_SB.C045.C059.C0E2.C14E (0x00, Arg0)
            }
        }

        Device (C199)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x02)
            Method (_STA, 0, NotSerialized)
            {
                Return (\_SB.C045.C059.C0E2.C13E (0x08))
            }

            Method (_BIF, 0, NotSerialized)
            {
                Return (C147 (0x01))
            }

            Method (_BST, 0, NotSerialized)
            {
                Return (C14C (0x01))
            }

            Name (_PRW, Package (0x02)
            {
                0x0B, 
                0x03
            })
            Method (_PSW, 1, NotSerialized)
            {
                C196 (Arg0, 0x02)
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (C197 ())
            }

            Method (_BTP, 1, NotSerialized)
            {
                \_SB.C045.C059.C0E2.C14E (0x01, Arg0)
            }
        }

        Device (C19A)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Method (_PSR, 0, NotSerialized)
            {
                Store (\_SB.C045.C059.C0E2.C13B (), Local0)
                If (XOr (Local0, C133))
                {
                    Store (Local0, C133)
                    If (LEqual (\_SB.C026, 0x00))
                    {
                        XOr (Local0, 0x01, \_SB.C045.C059.C064)
                    }
                    Else
                    {
                        Store (0x00, \_SB.C045.C059.C064)
                    }
                }

                Return (Local0)
            }
        }

        Device (C19B)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Name (_PRW, Package (0x02)
            {
                0x18, 
                0x04
            })
            Method (_PSW, 1, NotSerialized)
            {
                C044 (Arg0, 0x02)
            }
        }

        Device (C19C)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_LID, 0, NotSerialized)
            {
                Acquire (\_GL, 0xFFFF)
                Store (\_SB.C045.C059.C0E2.C105, Local0)
                Release (\_GL)
                And (Local0, 0x02, Local0)
                ShiftRight (Local0, 0x01, Local0)
                Return (Local0)
            }

            Name (_PRW, Package (0x02)
            {
                0x18, 
                0x04
            })
            Method (_PSW, 1, NotSerialized)
            {
                C044 (Arg0, 0x01)
            }
        }

        Name (C18F, Buffer (0x08)
        {
            0x2F, 0x31, 0x35, 0x3F, 0x40, 0x53, 0x58, 0x80
        })
        Name (C191, 0x00)
        Method (C190, 4, NotSerialized)
        {
            CreateWordField (Arg2, 0x00, C19D)
            CreateWordField (Arg2, 0x06, C19E)
            CreateWordField (Arg2, 0x0A, C19F)
            CreateWordField (Arg2, 0x0E, C1A0)
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
                If (And (C19E, 0x01))
                {
                    Store (0x20, Local1)
                    If (LAnd (LEqual (And (Local0, 0x07), 0x03), And (C19E, 0x02)))
                    {
                        Or (Local1, 0x01, Local1)
                    }
                    Else
                    {
                        If (LAnd (LEqual (And (Local0, 0x07), 0x04), And (C19E, 0x04)))
                        {
                            Or (Local1, 0x02, Local1)
                        }
                    }
                }
            }

            Store (Local0, Index (Arg3, 0x00))
            Store (Local1, Index (Arg3, 0x01))
            If (And (C1A0, 0x01))
            {
                Store (0x01, Index (Arg3, 0x02))
            }

            If (And (C19F, 0x0800))
            {
                Store (0x01, Index (Arg3, 0x03))
            }

            If (LNot (LEqual (C19D, 0x00)))
            {
                Store (C19D, Index (Arg3, 0x04))
            }
        }

        Method (C1A1, 3, NotSerialized)
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

            Store (Or (0xA0, ShiftLeft (Arg2, 0x04)), Index (Local0, 0x05))
            Return (Local0)
        }

        Method (C192, 2, NotSerialized)
        {
            Store (0x00, Local0)
            While (LLess (Local0, SizeOf (Arg0)))
            {
                If (LNot (LEqual (DerefOf (Index (Arg0, Local0)), 0x00)))
                {
                    Store (C1A1 (Local0, DerefOf (Index (Arg0, Local0)), Arg1), Local2)
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

        Method (C1A2, 2, NotSerialized)
        {
            Add (Multiply (Arg0, 0x02), Arg1, Local0)
            XOr (ShiftRight (C03F, 0x06), 0x03, Local1)
            XOr (ShiftRight (C043, 0x06), 0x03, Local2)
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

        Mutex (C1A3, 0x00)
        Method (C0D8, 5, NotSerialized)
        {
            Acquire (C1A3, 0xFFFF)
            If (Arg4)
            {
                Acquire (\_GL, 0xFFFF)
            }

            ShiftLeft (Arg0, 0x10, C037)
            Store (Arg1, C03A)
            Store (Arg2, C038)
            Store (Arg3, C039)
            Store (0x00, C03B)
            \C0C8 (Arg0)
            Store (C03B, Local0)
            If (Arg4)
            {
                Release (\_GL)
            }

            Release (C1A3)
            Return (Local0)
        }

        OperationRegion (C1A4, SystemIO, 0x84, 0x02)
        Field (C1A4, ByteAcc, NoLock, Preserve)
        {
            C1A5,   8, 
            C1A6,   8
        }

        Mutex (C1A7, 0x00)
        Method (C1B1, 1, NotSerialized)
        {
            Acquire (C1A7, 0xFFFF)
            Store (Arg0, C1A5)
            Release (C1A7)
            Return (0x00)
        }

        Method (C1B4, 1, NotSerialized)
        {
            Acquire (C1A7, 0xFFFF)
            Store (Arg0, C1A6)
            Release (C1A7)
            Return (0x00)
        }

        Method (C1B5, 1, NotSerialized)
        {
            Acquire (C1A7, 0xFFFF)
            Store (And (Arg0, 0xFF), C1A5)
            Store (And (ShiftRight (Arg0, 0x08), 0xFF), C1A6)
            Release (C1A7)
            Return (0x00)
        }

        Method (C1B3, 1, NotSerialized)
        {
            Return (0x00)
        }

        Method (C1B6, 1, NotSerialized)
        {
            Return (0x00)
        }

        Method (C1B2, 0, NotSerialized)
        {
            Return (0x00)
        }
    }

    Device (\_SB.C1B9)
    {
        Name (_HID, EisaId ("PNP0C02"))
        Name (_UID, 0x00)
        Name (C1BA, Package (0x10) {})
        Name (C1BB, Package (0x10) {})
        Name (C1BC, Package (0x11) {})
        Name (C1BD, Package (0x11) {})
        Name (C1BE, 0xFFFFFFFD)
        Mutex (C1BF, 0x00)
        Method (C1C0, 0, NotSerialized)
        {
            Add (\_SB.C019, 0x000F0000, Local0)
            Return (Local0)
        }

        OperationRegion (C1C1, SystemMemory, C1C0, 0xB0)
        Field (C1C1, AnyAcc, NoLock, Preserve)
        {
            C1C2,   640
        }

        Method (C1C3, 1, NotSerialized)
        {
            OperationRegion (C1C4, SystemMemory, Arg0, 0x03)
            Field (C1C4, ByteAcc, NoLock, Preserve)
            {
                C1C5,   16, 
                C1C6,   8
            }

            Store (0x00, Local0)
            If (LEqual (C1C5, 0xAA55))
            {
                ShiftLeft (C1C6, 0x09, Local0)
                Add (Arg0, Local0, Local0)
                Decrement (Local0)
            }

            Return (Local0)
        }

        Method (C1C7, 0, NotSerialized)
        {
            Store (C1C2, Local0)
            Store (0x00, Local3)
            Store (0x00, Local4)
            Store (0x01, Local1)
            While (LAnd (Local1, LNot (LGreater (Local3, 0x10))))
            {
                Store (DerefOf (Index (Local0, Add (Local4, 0x03))), Local2)
                Or (ShiftLeft (DerefOf (Index (Local0, Add (Local4, 0x04))), 0x08), Local2, Local1)
                ShiftLeft (Local1, 0x04, Local1)
                If (Local1)
                {
                    Store (Local1, Index (C1BA, Local3))
                    Store (DerefOf (Index (Local0, Add (Local4, 0x02))), Local5)
                    Add (Local1, ShiftLeft (Local5, 0x09), Local5)
                    Decrement (Local5)
                    Store (Local5, Index (C1BB, Local3))
                    Increment (Local3)
                    Add (Local4, 0x05, Local4)
                }
            }

            Return (Local3)
        }

        Method (C1C8, 0, NotSerialized)
        {
            Store (C1C7 (), Local3)
            Store (Local3, Local4)
            Store (0x00, Local2)
            Store (Local2, Local7)
            While (LLess (Local2, Local4))
            {
                Store (0x000FFFFF, Local1)
                Store (Local2, Local5)
                While (LLess (Local5, Local3))
                {
                    Store (DerefOf (Index (C1BA, Local5)), Local6)
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
                    Store (DerefOf (Index (C1BB, Local0)), Local7)
                    Store (DerefOf (Index (C1BA, Local2)), Index (C1BA, Local0))
                    Store (DerefOf (Index (C1BB, Local2)), Index (C1BB, Local0))
                    Store (Local1, Index (C1BA, Local2))
                    Store (Local7, Index (C1BB, Local2))
                }

                Store (C1C3 (Local1), Local7)
                If (Local7)
                {
                    Store (Local7, Index (C1BB, Local2))
                }

                Store (Local1, Local7)
                Increment (Local2)
            }

            Return (Local4)
        }

        Method (C1C9, 1, NotSerialized)
        {
            Acquire (C04B, 0xFFFF)
            Store (0x00, Local0)
            Store (Local0, C1BE)
            Store (Local0, Local2)
            Store (Local0, Local3)
            While (LNot (LGreater (Local0, 0x10)))
            {
                Store (Local2, Index (C1BC, Local0))
                Store (Local2, Index (C1BD, Local0))
                Increment (Local0)
            }

            Store (ShiftLeft (C012, 0x04), Local0)
            Store (Local0, Index (C04D, C04C))
            Store (Local0, Index (C04E, C04C))
            Store (Local0, Index (C1BA, Arg0))
            Store (Local0, Index (C1BB, Arg0))
            While (LAnd (LNot (LGreater (Local2, Arg0)), LNot (LGreater (Local3, C04C))))
            {
                Store (DerefOf (Index (C04D, Local3)), Local0)
                Add (DerefOf (Index (C04E, Local3)), 0x01, Local1)
                Store (DerefOf (Index (C1BA, Local2)), Local4)
                Add (DerefOf (Index (C1BB, Local2)), 0x01, Local5)
                Store (DerefOf (Index (C1BC, C1BE)), Local6)
                If (LNot (LGreater (Local1, Local4)))
                {
                    If (Local6)
                    {
                        Subtract (Local0, Local6, Index (C1BD, C1BE))
                        Increment (C1BE)
                    }

                    If (LLess (Local1, Local4))
                    {
                        Store (Local1, Index (C1BC, C1BE))
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
                            Store (Local7, Index (C1BD, C1BE))
                            Increment (C1BE)
                        }
                    }

                    If (LGreater (Local0, Local5))
                    {
                        Store (Local5, Index (C1BC, C1BE))
                    }

                    Increment (Local2)
                }
            }

            Release (C04B)
        }

        Method (C1CA, 0, NotSerialized)
        {
            Acquire (C1BF, 0xFFFF)
            If (LEqual (C1BE, 0xFFFFFFFD))
            {
                C04A ()
                Store (C1C8 (), Local0)
                C1C9 (Local0)
            }

            Store (C1BE, Local1)
            Release (C1BF)
            Return (Local1)
        }

        Method (_INI, 0, NotSerialized)
        {
            C1CA ()
        }

        Method (C051, 3, NotSerialized)
        {
            Store (Arg1, Local2)
            CreateDWordField (Arg0, Local2, C1CB)
            Store (0x0986, C1CB)
            Add (Local2, 0x04, Local2)
            CreateDWordField (Arg0, Local2, C1CC)
            Store (DerefOf (Index (C1BC, Arg2)), C1CC)
            Add (Local2, 0x04, Local2)
            CreateDWordField (Arg0, Local2, C1CD)
            Store (DerefOf (Index (C1BD, Arg2)), C1CD)
            Add (Local2, 0x04, Local2)
            Return (Local2)
        }

        Method (C1CE, 0, NotSerialized)
        {
            Multiply (C1BE, 0x0C, Local1)
            Add (SizeOf (C00A), Local1, Local2)
            Store (Buffer (Local2) {}, Local0)
            Store (0x00, Local1)
            Store (Local1, Local2)
            While (LLess (Local1, C1BE))
            {
                Store (C051 (Local0, Local2, Local1), Local2)
                Increment (Local1)
            }

            Store (0x00, Local1)
            While (LLess (Local1, SizeOf (C00A)))
            {
                Store (DerefOf (Index (C00A, Local1)), Index (Local0, Local2))
                Increment (Local2)
                Increment (Local1)
            }

            Return (Local0)
        }

        Method (_CRS, 0, NotSerialized)
        {
            Store (C00A, Local0)
            Acquire (C1BF, 0xFFFF)
            If (LGreater (C1BE, 0x00))
            {
                Store (C1CE (), Local0)
            }

            Release (C1BF)
            Return (Local0)
        }

        Method (_STA, 0, NotSerialized)
        {
            Subtract (SizeOf (C00A), 0x02, Local0)
            Or (C1CA (), Local0, Local0)
            If (Local0)
            {
                Store (0x0F, Local0)
            }

            Return (Local0)
        }
    }

    Name (\_SB.C1B9.C00A, ResourceTemplate ()
    {
    })
    Device (\_SB.C045.C1CF)
    {
        Name (_HID, EisaId ("PNP0C02"))
        Name (_UID, 0x01)
        Method (_CRS, 0, NotSerialized)
        {
            Name (C1D0, ResourceTemplate ()
            {
                IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                IO (Decode16, 0x1000, 0x1000, 0x01, 0x80)
                IO (Decode16, 0x1100, 0x1100, 0x01, 0x40)
                IO (Decode16, 0x1200, 0x1200, 0x01, 0x20)
                Memory32Fixed (ReadWrite, 0xFFC00000, 0x00000400)
            })
            Return (C1D0)
        }
    }

    Device (\_SB.C045.C059.C1D2)
    {
        Name (_HID, EisaId ("PNP0C02"))
        Name (_UID, 0x02)
        Name (\_SB.C045.C059.C153, ResourceTemplate ()
        {
            IO (Decode16, 0x0010, 0x0010, 0x01, 0x10)
            IO (Decode16, 0x0024, 0x0024, 0x01, 0x1A)
            IO (Decode16, 0x004E, 0x004E, 0x01, 0x02)
            IO (Decode16, 0x0050, 0x0050, 0x01, 0x04)
            IO (Decode16, 0x0074, 0x0074, 0x01, 0x04)
            IO (Decode16, 0x0090, 0x0090, 0x01, 0x10)
            IO (Decode16, 0x00A4, 0x00A4, 0x01, 0x1A)
            IO (Decode16, 0x0140, 0x0140, 0x01, 0x10)
            Memory32Fixed (ReadOnly, 0xFFB00000, 0x00100000)
            Memory32Fixed (ReadOnly, 0xFFF00000, 0x00100000)
        })
        Method (_CRS, 0, NotSerialized)
        {
            Return (^^C0E2.C152 ())
        }
    }

    Name (\_S0, Package (0x03)
    {
        0x00, 
        0x00, 
        0x00
    })
    Name (\_S3, Package (0x03)
    {
        0x05, 
        0x05, 
        0x00
    })
    Name (\_S4, Package (0x03)
    {
        0x06, 
        0x06, 
        0x00
    })
    Name (\_S5, Package (0x03)
    {
        0x07, 
        0x07, 
        0x00
    })
    Method (\_PTS, 1, NotSerialized)
    {
        Store (Arg0, \_SB.C020)
        If (LGreater (Arg0, 0x00))
        {
            \_SB.C045.C059.C0E2.C13C (0x03, 0xFF)
            If (LNot (LEqual (Arg0, 0x05)))
            {
                \_SB.C045.C059.C0E2.C13D (0x00)
                If (LNot (LEqual (Arg0, 0x04)))
                {
                    Store (0x01, \_SB.C191)
                    Store (0x00, Local0)
                    If (\_SB.C195)
                    {
                        Store (0x01, Local0)
                    }

                    \_SB.C044 (Local0, 0x10)
                }
            }
        }
    }

    Method (\_WAK, 1, NotSerialized)
    {
        Store (0x00, \_SB.C020)
        Store (0x00, \_SB.C02A)
        \_SB.C045.C059.C0E2.C137 ()
        If (LEqual (Arg0, 0x04))
        {
            Store (\_SB.C045.C059.C0E2.C12B (0x03, 0x00, 0x00, 0x00), Local0)
            Store (DerefOf (Index (Local0, 0x01)), Local1)
            Store (DerefOf (Index (Local0, 0x02)), Local2)
            Store (0x00, \_GPE.C126)
            Or (Local1, 0x20, Local1)
            \_SB.C045.C059.C0E2.C12B (0x04, Local1, Local2, 0x00)
            \_TZ.C1D3 ()
        }

        If (LEqual (\C008 (), 0x01))
        {
            Notify (\_SB.C19B, 0x02)
        }

        Store (\_GPE.C120, Local1)
        Acquire (\_GL, 0xFFFF)
        Store (\_SB.C045.C059.C0E2.C103, \_GPE.C120)
        Release (\_GL)
        XOr (Local1, \_GPE.C120, Local1)
        \_GPE.C1D4 (Local1)
        Notify (\_SB.C045.C097.C193, 0x00)
        Notify (\_SB.C045.C058.C0AA, 0x00)
        Notify (\_SB.C045.C058.C0B0, 0x00)
        Notify (\_SB.C045.C058.C0B3, 0x00)
        Notify (\_SB.C045.C059.C0E2.C15E, 0x00)
        Return (Package (0x02)
        {
            0x00, 
            0x00
        })
    }

    Scope (\_TZ)
    {
        Name (C1D5, Package (0x02)
        {
            Package (0x02)
            {
                Package (0x05)
                {
                    0x05AC, 
                    0x0C3C, 
                    0x0CD2, 
                    0x0D68, 
                    0x0DFE
                }, 

                Package (0x05)
                {
                    0x0CA0, 
                    0x0D36, 
                    0x0DF4, 
                    0x0E44, 
                    0x0FA3
                }
            }, 

            Package (0x02)
            {
                Package (0x02)
                {
                    0x05AC, 
                    0x0CA0
                }, 

                Package (0x02)
                {
                    0x0D04, 
                    0x0FA3
                }
            }
        })
        Name (C1D6, 0x64)
        Name (C1D7, 0x46)
        Name (C1D8, 0x28)
        Name (C1D9, 0x00)
        Name (C1DA, 0x01)
        Name (C1DB, 0x02)
        Name (C1DC, 0x03)
        Name (C1DD, 0x00)
        Method (C12B, 4, Serialized)
        {
            Return (\_SB.C045.C059.C0E2.C12B (Arg0, Arg1, Arg2, Arg3))
        }

        Name (C1DE, Package (0x02)
        {
            0x0B9C, 
            0x0B9C
        })
        Name (C1DF, Package (0x02)
        {
            0x0B9C, 
            0x0B9C
        })
        Name (C1E0, Package (0x02)
        {
            0xFFFFFFFD, 
            0xFFFFFFFD
        })
        Name (C1E1, 0x00)
        Mutex (C1E2, 0x00)
        Name (C1E3, 0x03)
        Method (C1E4, 2, Serialized)
        {
            Store (0x00, Local2)
            If (And (C1E1, Arg0))
            {
                Store (C12B (0x1F, 0x00, 0x00, 0x00), Local0)
                Store (DerefOf (Index (Local0, 0x01)), Local1)
                Store (0x00, Local2)
                If (LNot (LLess (Local1, Arg1)))
                {
                    Store (0x01, Local2)
                }
            }

            Return (Local2)
        }

        Method (C1E5, 2, Serialized)
        {
            ShiftLeft (Arg0, 0x01, Local0)
            Decrement (Local0)
            If (LEqual (And (C1E1, Local0), 0x00))
            {
                C12B (0x20, Arg1, 0x00, 0x00)
            }

            Or (C1E1, Arg0, C1E1)
        }

        Method (C1E6, 2, Serialized)
        {
            And (C1E1, Not (Arg0), C1E1)
            Store (0x00, Local0)
            If (C1E1)
            {
                Store (Arg1, Local0)
            }

            If (LOr (Arg1, LEqual (C1E1, 0x00)))
            {
                C12B (0x20, Local0, 0x00, 0x00)
            }
        }

        Method (C1E7, 2, Serialized)
        {
            Store (0x01, Local0)
            Store (Arg0, Local1)
            If (LLess (Arg0, DerefOf (Index (C1E0, Arg1))))
            {
                Store (0x00, Local0)
                Add (Arg0, 0x01, Local1)
            }

            Store (DerefOf (Index (DerefOf (Index (DerefOf (Index (C1D5, Arg1)), Local0)), Local1)), Local2)
            If (LAnd (LEqual (\_SB.C027, 0x01), LAnd (LEqual (Arg0, 0x00), LEqual (Arg1, 0x00))))
            {
                If (\_SB.C045.C059.C0E2.C13B ())
                {
                    Store (0x0B4B, Local2)
                }
            }

            Return (Local2)
        }

        Method (C1D3, 0, NotSerialized)
        {
            Acquire (C1E2, 0xFFFF)
            Store (0x03, C1E3)
            Store (0xFFFFFFFD, Index (C1E0, 0x00))
            Store (0x00, C1E1)
            Release (C1E2)
            Subtract (0x0E58, 0x0AAC, Local1)
            Divide (Local1, 0x0A, Local0, Local2)
            C12B (0x0E, Local2, 0x00, 0x00)
            C12B (0x20, 0x00, 0x00, 0x00)
        }

        Method (C1E8, 1, Serialized)
        {
            If (LEqual (Arg0, 0x00))
            {
                Store (C12B (0x08, 0x00, 0x00, 0x00), Local0)
                Store (DerefOf (Index (Local0, 0x01)), Local2)
                If (And (Local2, 0x80))
                {
                    Subtract (0x0100, Local2, Local2)
                }

                Multiply (Local2, 0x0A, Local1)
                Add (Local1, 0x0AAC, Local1)
            }
            Else
            {
                Store (\_SB.C045.C059.C0E2.C119, Local2)
                And (Local2, 0x0F, Local2)
                Store (0x0D0E, Local1)
                If (LLess (Local2, 0x0A))
                {
                    Store (0x0CAA, Local1)
                    If (LLess (Local2, 0x09))
                    {
                        Store (0x0C6E, Local1)
                    }
                }

                If (\_SB.C045.C059.C0E2.C13B ())
                {
                    Store (0x0C6E, Local1)
                }
            }

            Store (Local1, Local2)
            If (LLess (Local1, 0x0B4C))
            {
                If (LLess (DerefOf (Index (C1DE, Arg0)), 0x0B4C))
                {
                    Store (0x0B4C, Index (C1DF, Arg0))
                }

                Store (DerefOf (Index (C1DF, Arg0)), Local1)
            }

            Store (Local2, Index (C1DE, Arg0))
            Store (Local1, Index (C1DF, Arg0))
            Acquire (C1E2, 0xFFFF)
            Store (ShiftLeft (0x01, Arg0), Local2)
            If (And (C1E3, Local2))
            {
                Store (Match (DerefOf (Index (DerefOf (Index (C1D5, Arg0)), 0x01)), MGT, Local1, MTR, 0x00, 0x00), Local0)
                If (LNot (LEqual (Local0, DerefOf (Index (C1E0, Arg0)))))
                {
                    Store (Local0, Index (C1E0, Arg0))
                    If (LEqual (Arg0, 0x00))
                    {
                        C1E9 (Local0)
                    }
                    Else
                    {
                        Notify (\_TZ.C1EA, 0x81)
                    }
                }

                And (C1E3, Not (Local2), C1E3)
            }

            Release (C1E2)
            Return (Local1)
        }

        Method (C1E9, 1, Serialized)
        {
            Store (DerefOf (Index (DerefOf (Index (DerefOf (Index (C1D5, 0x00)), 0x01)), Arg0)), Local0)
            Subtract (Local0, 0x0AAC, Local0)
            Divide (Local0, 0x0A, Local1, Local2)
            C12B (0x0C, Local2, 0xFF, 0x00)
            Store (DerefOf (Index (DerefOf (Index (DerefOf (Index (C1D5, 0x00)), 0x00)), Arg0)), Local0)
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

            C12B (0x0A, Local2, 0x00, 0x00)
            Notify (\_TZ.TZ1, 0x81)
        }

        PowerResource (C1EB, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Return (C1E4 (0x01, C1D6))
            }

            Method (_ON, 0, NotSerialized)
            {
                C1E5 (0x01, C1D6)
            }

            Method (_OFF, 0, NotSerialized)
            {
                C1E6 (0x01, C1D7)
            }
        }

        PowerResource (C1EC, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Return (C1E4 (0x02, C1D7))
            }

            Method (_ON, 0, NotSerialized)
            {
                C1E5 (0x02, C1D7)
            }

            Method (_OFF, 0, NotSerialized)
            {
                C1E6 (0x02, C1D8)
            }
        }

        PowerResource (C1ED, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Return (C1E4 (0x04, C1D8))
            }

            Method (_ON, 0, NotSerialized)
            {
                C1E5 (0x04, C1D8)
            }

            Method (_OFF, 0, NotSerialized)
            {
                C1E6 (0x04, 0x00)
            }
        }

        Device (C1EE)
        {
            Method (_INI, 0, NotSerialized)
            {
                \_TZ.C1D3 ()
            }

            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, 0x00)
            Name (_PR0, Package (0x01)
            {
                C1EB
            })
        }

        Device (C1EF)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, 0x01)
            Name (_PR0, Package (0x01)
            {
                C1EC
            })
        }

        Device (C1F0)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, 0x02)
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
            Method (_AC0, 0, NotSerialized)
            {
                Return (C1E7 (C1DB, 0x00))
            }

            Method (_AC1, 0, NotSerialized)
            {
                Return (C1E7 (C1DA, 0x00))
            }

            Method (_AC2, 0, NotSerialized)
            {
                Return (C1E7 (C1D9, 0x00))
            }

            Method (_PSV, 0, NotSerialized)
            {
                Return (C1E7 (C1DC, 0x00))
            }

            Name (_PSL, Package (0x01)
            {
                \_PR.C000
            })
            Method (C1F1, 1, NotSerialized)
            {
                If (LEqual (Arg0, 0x00))
                {
                    Store (0x00, C1D9)
                    Store (0x01, C1DA)
                    Store (0x02, C1DB)
                    Store (0x03, C1DC)
                }
                Else
                {
                    Store (0x00, C1D9)
                    Store (0x01, C1DC)
                    Store (0x02, C1DA)
                    Store (0x03, C1DB)
                }
            }

            Name (_TSP, 0x64)
            Name (_TC1, 0x01)
            Name (_TC2, 0x02)
            Name (_CRT, 0x0E58)
            Method (_TMP, 0, Serialized)
            {
                Store (C1E8 (0x00), Local0)
                Return (Local0)
            }
        }

        ThermalZone (C1EA)
        {
            Method (_PSV, 0, NotSerialized)
            {
                Return (C1E7 (0x00, 0x01))
            }

            Name (_PSL, Package (0x01)
            {
                \_PR.C000
            })
            Name (_TSP, 0x012C)
            Name (_TC1, 0x01)
            Name (_TC2, 0x02)
            Name (_CRT, 0x0E58)
            Method (_TMP, 0, Serialized)
            {
                Store (C1E8 (0x01), Local0)
                Return (Local0)
            }
        }
    }

    Scope (\_GPE)
    {
        Name (C120, 0x00)
        Name (C121, 0x00)
        Name (C122, 0x00)
        Name (C123, 0x00)
        Name (C124, 0x00)
        Name (C125, 0x00)
        Name (C126, 0x00)
        Name (C127, 0x00)
        Name (C128, 0x00)
        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.C045.C058, 0x02)
        }

        Method (_L10, 0, NotSerialized)
        {
            Store (\_SB.C045.C059.C0E2.C12A (0x30, 0x00, 0x00, 0x00, 0x00), Local0)
            Store (DerefOf (Index (Local0, 0x01)), Local4)
            If (And (Local4, 0x10))
            {
                Store (C120, Local1)
                Store (C122, Local2)
                Store (C123, Local3)
                Store (C124, Local5)
                Store (C125, Local6)
                Store (C126, Local7)
                Acquire (\_GL, 0xFFFF)
                Store (\_SB.C045.C059.C0E2.C103, C120)
                Store (\_SB.C045.C059.C0E2.C106, C122)
                Store (\_SB.C045.C059.C0E2.C113, C123)
                Store (\_SB.C045.C059.C0E2.C114, C124)
                Store (\_SB.C045.C059.C0E2.C115, C125)
                Store (\_SB.C045.C059.C0E2.C116, C126)
                Release (\_GL)
                If (\_SB.C045.C059.C0E2.C13D (0x02))
                {
                    XOr (Local1, C120, Local1)
                    XOr (Local2, C122, Local2)
                    XOr (Local3, C123, Local3)
                    XOr (Local5, C124, Local5)
                    XOr (Local6, C125, Local6)
                    XOr (Local7, C126, Local7)
                    Or (Local3, Local5, Local3)
                    Or (Local3, Local6, Local3)
                    Or (Local3, Local7, Local3)
                    And (Local3, Not (Local1), Local3)
                    If (And (Local2, 0x01))
                    {
                        \_SB.C045.C059.C0E2.C13C (0x01, 0x00)
                        Store (0x00, Local3)
                        Notify (\_SB.C19A, 0x80)
                        Notify (\_PR.C000, 0x80)
                        Notify (\_TZ.C1EA, 0x80)
                    }

                    If (Local1)
                    {
                        \_SB.C045.C059.C0E2.C13C (0x02, Local1)
                        C1D4 (Local1)
                    }

                    If (LAnd (Local3, LNot (LEqual (\_SB.C045.C059.C0E2.C131, 0xFF))))
                    {
                        If (And (Local3, 0x01))
                        {
                            Notify (\_SB.C198, 0x80)
                        }

                        If (And (Local3, 0x08))
                        {
                            Notify (\_SB.C199, 0x80)
                        }
                    }
                }
            }

            If (And (Local4, 0x40))
            {
                Store (\_SB.C045.C059.C0E2.C119, Local1)
                Store (0x01, Local2)
                If (And (Local1, 0x80))
                {
                    Store (0x02, Local2)
                }

                Acquire (\_TZ.C1E2, 0xFFFF)
                Store (Local2, \_TZ.C1E3)
                Release (\_TZ.C1E2)
                If (And (Local1, 0x80))
                {
                    Notify (\_TZ.C1EA, 0x80)
                }
                Else
                {
                    Notify (\_TZ.TZ1, 0x80)
                }
            }
        }

        Method (_L11, 0, NotSerialized)
        {
            Store (\_SB.C045.C059.C0E2.C12A (0x30, 0x01, 0x00, 0x00, 0x00), Local0)
            Store (DerefOf (Index (Local0, 0x01)), Local4)
            If (And (Local4, 0x80))
            {
                Store (C121, Local2)
                Store (C127, Local6)
                Acquire (\_GL, 0xFFFF)
                Store (\_SB.C045.C059.C0E2.C105, C121)
                Store (\_SB.C045.C059.C0E2.C118, C127)
                Release (\_GL)
                XOr (Local2, C121, Local2)
                XOr (Local6, C127, Local6)
                If (And (Local2, 0x20))
                {
                    And (C121, 0x20, Local0)
                    Notify (\_SB.C045.C059.C0E2.C15E, 0x00)
                }
            }
        }

        Method (_L14, 0, NotSerialized)
        {
            And (\_SB.C045.C059.C065, 0xFFFFFCFF, Local0)
            Or (Local0, 0x0100, \_SB.C045.C059.C065)
            \_SB.C045.C046.C0CE.C0D5 (0x01)
            If (LEqual (And (\_SB.C031, 0x03), 0x00))
            {
                Notify (\_SB.C045.C046.C0CE, 0x80)
            }
        }

        Method (_L17, 0, NotSerialized)
        {
            Store (0x00, Local0)
        }

        Method (_L18, 0, NotSerialized)
        {
            Store (\_SB.C045.C059.C0E2.C12A (0x30, 0x02, 0x00, 0x00, 0x00), Local0)
            Store (DerefOf (Index (Local0, 0x01)), Local4)
            If (And (Local4, 0x04))
            {
                Notify (\_SB.C19B, 0x80)
            }

            If (And (Local4, 0x08))
            {
                Notify (\_SB.C19B, 0x02)
            }

            If (And (Local4, 0x02))
            {
                Notify (\_SB.C19C, 0x80)
                If (LEqual (And (\_SB.C031, 0x03), 0x00))
                {
                    If (LAnd (And (\_SB.C045.C059.C0E2.C105, 0x02), \_SB.C028))
                    {
                        Notify (\_SB.C045.C046.C0CE, 0x80)
                    }
                }
            }
        }

        Method (_L1C, 0, NotSerialized)
        {
            Store ("Hot swap of MultiBay 2", Debug)
            And (\_SB.C045.C059.C065, 0xFCFFFFFF, Local0)
            Or (Local0, 0x01000000, \_SB.C045.C059.C065)
            Notify (\_SB.C045.C097.C193, 0x00)
            Notify (\_SB.C045.C059.C0E2.C15E, 0x00)
        }

        Method (_L1D, 0, NotSerialized)
        {
            Store ("Hot swap of MultiBay 1", Debug)
            And (\_SB.C045.C059.C065, 0xF3FFFFFF, Local0)
            Or (Local0, 0x04000000, \_SB.C045.C059.C065)
            Store (\_SB.C036, Local0)
            If (Local0)
            {
                Store (0x00, \_SB.C036)
                If (LEqual (Local0, 0x01))
                {
                    If (LEqual (And (\_SB.C031, 0x03), 0x00))
                    {
                        Notify (\_SB.C045.C046.C0CE, 0x80)
                    }
                }
            }
        }

        Method (C1D4, 1, Serialized)
        {
            If (And (Arg0, 0x01))
            {
                Notify (\_SB.C198, 0x81)
            }

            If (And (Arg0, 0x08))
            {
                Notify (\_SB.C199, 0x81)
            }
        }
    }
}


--Boundary-00=_sX9ZAOtlf7zHV5e--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
