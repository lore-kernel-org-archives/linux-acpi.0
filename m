From: Martin Lorenz <martin-2WKW0nu+7nMiq3RsQ1AnAw@public.gmane.org>
Subject: fixing my DSDT: may I ask for help?
Date: Fri, 16 Jan 2004 12:00:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4007C44B.7000306@lorenz.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090404050501020604050407"
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

This is a multi-part message in MIME format.
--------------090404050501020604050407
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dear all,

I decided to give it a try and fix my laptops DSDT myself, but I seem
somehow stuck, as I am not sure, if I know, what I'm doing.

iasl gives the followin output:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030228 [Feb 28 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.dsl   579:                 Field (PIUC, DWordAcc, Lock, Preserve)
Error    1047 -                           ^ Access width is greater than
region size

>>> this one I already got rid of by changing 'DWordAcc' to 'WordAcc'
>>> the attached dsdt is the resulting one
>>> it now reads as
|>>                OperationRegion (PIUC, PCI_Config, 0x74, 0x02)
|>>                Field (PIUC, WordAcc, Lock, Preserve)
|>>                {
|>>                    AccessAs (ByteAcc, 0x00),
|>>                    PIRU,   4,
|>>                    Offset (0x01),
|>>                    PIRE,   4
|>>                }


dsdt.dsl  1266:                 Method (WIB1, 0, Serialized)
Warning  2019 -                            ^ Not all control paths
return a value (WIB1)

dsdt.dsl  1279:                 Method (WOB1, 0, Serialized)
Warning  2019 -                            ^ Not all control paths
return a value (WOB1)

dsdt.dsl  2109:             Method (WPD0, 0, NotSerialized)
Warning  2019 -                        ^ Not all control paths return a
value (WPD0)

dsdt.dsl  2152:                     CDA4,   16
Error    1051 -                        ^ Access width of Field Unit
extends beyond region limit

>>> with this one I really don't know what to do.
>>> the code fragment reads as follows:
|>>                Field (CCRD, DWordAcc, NoLock, Preserve)
|>>                {
|>>                    Offset (0x04),
|>>                    CD04,   32,
|>>                    Offset (0x10),
|>>                    CD10,   32,
|>>                    Offset (0x3C),
|>>                    CD3C,   32,
|>>                    Offset (0x44),
|>>                    CD44,   32,
|>>                    Offset (0xA4),
|>>                    CDA4,   16
|>>                }


dsdt.dsl  2614:         Method (_E19, 0, NotSerialized)
Warning  2019 -                    ^ Not all control paths return a
value (_E19)

dsdt.dsl  2701:         Method (_L03, 0, NotSerialized)
Warning  2019 -                    ^ Not all control paths return a
value (_L03)

dsdt.dsl  2776:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value (_WAK)

>>> This one is well documented :-)
>>> I inserted 'Return(Package(0x02){0x00, 0x00})'
>>> as suggested by some sources

ASL Input:  dsdt.dsl - 2848 lines, 90850 bytes, 1482 keywords
Compilation complete. 2 Errors, 6 Warnings, 0 Remarks, 416 Optimizations

so in the meantime i reduced this to 1 error and 5 warnings.

thanks for any additional hint
greets
mlo
-- 
martin lorenz
--
	They that can give up essential liberty
	to obtain a little temporary safety
	deserve neither liberty nor safety.
				-- Benjamin Franklin


--------------090404050501020604050407
Content-Type: text/plain;
 name="dsdt.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dsdt.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030228
 *
 * Disassembly of /proc/acpi/dsdt, Fri Jan 16 10:55:34 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "PTLTD ", "DSDT    ", 100925445)
{
    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06) {}
    }

    Name (\KBWC, 0x01)
    Name (\LDWC, 0x01)
    Name (\OSYS, 0x00)
    Name (\OEMI, 0x01)
    Name (\OEMS, Buffer (0x13)
    {
        "SHARP Corporation "
    })
    OperationRegion (PORT, SystemIO, 0x80, 0x01)
    Field (PORT, ByteAcc, NoLock, Preserve)
    {
        P80H,   8
    }

    OperationRegion (SMI0, SystemIO, 0x00008084, 0x00000002)
    Field (SMI0, AnyAcc, NoLock, Preserve)
    {
        SMIC,   8
    }

    OperationRegion (SMI1, SystemMemory, 0x0E6FFE4D, 0x00000100)
    Field (SMI1, AnyAcc, NoLock, Preserve)
    {
        BCMD,   8, 
        DID,    32, 
        INFO,   128
    }

    Field (SMI1, AnyAcc, NoLock, Preserve)
    {
        AccessAs (ByteAcc, 0x00), 
        Offset (0x05), 
        INFW,   16
    }

    Mutex (PSMX, 0x01)
    Method (PHS, 2, Serialized)
    {
        Acquire (PSMX, 0xFFFF)
        Store (Arg0, BCMD)
        Store (Arg1, INFO)
        Store (0x00, DID)
        Store (0x00, SMIC)
        Store (0x00, BCMD)
        Store (INFW, Local0)
        Release (PSMX)
        Return (Local0)
    }

    Scope (_SB)
    {
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_BBN, 0x00)
            Name (_ADR, 0x00)
            Name (_PRT, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0005FFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK2, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNKM, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK1, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK5, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK6, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK3, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x01, 
                    \_SB.PCI0.ISA.LNK3, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x02, 
                    \_SB.PCI0.ISA.LNK4, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNKU, 
                    0x00
                }
            })
            OperationRegion (VNBR, PCI_Config, 0x00, 0x0100)
            Field (VNBR, ByteAcc, NoLock, Preserve)
            {
                Offset (0xA8), 
                Z000,   1, 
                Z001,   3, 
                Z002,   1, 
                Offset (0xD8), 
                Z003,   16, 
                Z004,   16, 
                Z005,   16, 
                Z006,   1, 
                Z007,   1, 
                Z008,   6, 
                Z009,   8, 
                Z00A,   16, 
                Z00B,   16, 
                Z00C,   16, 
                Z00D,   1, 
                Z00E,   1, 
                Z00F,   6, 
                Z00G,   8, 
                Z00H,   16, 
                Z00I,   16, 
                Z00J,   16, 
                Z00K,   1, 
                Z00L,   1, 
                Z00M,   6, 
                Z00N,   8, 
                Z00O,   16, 
                Z00P,   16, 
                Z00Q,   16, 
                Z00R,   1, 
                Z00S,   1, 
                Z00T,   6, 
                Z00U,   8
            }

            OperationRegion (REGS, PCI_Config, 0x40, 0x34)
            Field (REGS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x0A), 
                TOM,    16, 
                Offset (0x1A), 
                PAM1,   8, 
                PAM2,   8, 
                PAM3,   8, 
                PAM4,   8, 
                PAM5,   8, 
                PAM6,   8, 
                Offset (0x33), 
                T_EN,   1
            }

            Name (RSRC, ResourceTemplate ()
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
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000C0000,
                    0x000C3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000C4000,
                    0x000C7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000C8000,
                    0x000CBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000CC000,
                    0x000CFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D0000,
                    0x000D3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D4000,
                    0x000D7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D8000,
                    0x000DBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000DC000,
                    0x000DFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000E0000,
                    0x000E3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000E4000,
                    0x000E7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000E8000,
                    0x000EBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000EC000,
                    0x000EFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000, 0x00)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300, 0x00)
            })
            Method (_CRS, 0, Serialized)
            {
                CreateDWordField (RSRC, 0x0193, ATMN)
                CreateDWordField (RSRC, 0x0197, ATMX)
                CreateDWordField (RSRC, 0x019F, ATLN)
                Multiply (TOM, 0x00010000, Local0)
                If (T_EN)
                {
                    Add (Local0, 0x000E0000, ATMN)
                }
                Else
                {
                    Store (Local0, ATMN)
                }

                Subtract (0xFFF80000, ATMN, ATLN)
                Subtract (Add (ATMN, ATLN), 0x01, ATMX)
                CreateBitField (RSRC, 0x0250, C0RW)
                CreateDWordField (RSRC, 0x4F, C0MN)
                CreateDWordField (RSRC, 0x53, C0MX)
                CreateDWordField (RSRC, 0x5B, C0LN)
                Store (One, C0RW)
                If (LEqual (And (PAM1, 0x03), 0x01))
                {
                    Store (Zero, C0RW)
                }

                Store (Zero, C0LN)
                If (LNot (And (PAM1, 0x03)))
                {
                    Store (0x4000, C0LN)
                }

                CreateBitField (RSRC, 0x0328, C4RW)
                CreateDWordField (RSRC, 0x6A, C4MN)
                CreateDWordField (RSRC, 0x6E, C4MX)
                CreateDWordField (RSRC, 0x76, C4LN)
                Store (One, C4RW)
                If (LEqual (And (PAM1, 0x30), 0x10))
                {
                    Store (Zero, C4RW)
                }

                Store (Zero, C4LN)
                If (LNot (And (PAM1, 0x30)))
                {
                    Store (0x4000, C4LN)
                }

                CreateBitField (RSRC, 0x0400, C8RW)
                CreateDWordField (RSRC, 0x85, C8MN)
                CreateDWordField (RSRC, 0x89, C8MX)
                CreateDWordField (RSRC, 0x91, C8LN)
                Store (One, C8RW)
                If (LEqual (And (PAM2, 0x03), 0x01))
                {
                    Store (Zero, C8RW)
                }

                Store (Zero, C8LN)
                If (LNot (And (PAM2, 0x03)))
                {
                    Store (0x4000, C8LN)
                }

                CreateBitField (RSRC, 0x04D8, CCRW)
                CreateDWordField (RSRC, 0xA0, CCMN)
                CreateDWordField (RSRC, 0xA4, CCMX)
                CreateDWordField (RSRC, 0xAC, CCLN)
                Store (One, CCRW)
                If (LEqual (And (PAM2, 0x30), 0x10))
                {
                    Store (Zero, CCRW)
                }

                Store (Zero, CCLN)
                If (LNot (And (PAM2, 0x30)))
                {
                    Store (0x4000, CCLN)
                }

                CreateBitField (RSRC, 0x05B0, D0RW)
                CreateDWordField (RSRC, 0xBB, D0MN)
                CreateDWordField (RSRC, 0xBF, D0MX)
                CreateDWordField (RSRC, 0xC7, D0LN)
                Store (One, D0RW)
                If (LEqual (And (PAM3, 0x03), 0x01))
                {
                    Store (Zero, D0RW)
                }

                Store (Zero, D0LN)
                If (LNot (And (PAM3, 0x03)))
                {
                    Store (0x4000, D0LN)
                }

                CreateBitField (RSRC, 0x0688, D4RW)
                CreateDWordField (RSRC, 0xD6, D4MN)
                CreateDWordField (RSRC, 0xDA, D4MX)
                CreateDWordField (RSRC, 0xE2, D4LN)
                Store (One, D4RW)
                If (LEqual (And (PAM3, 0x30), 0x10))
                {
                    Store (Zero, D4RW)
                }

                Store (Zero, D4LN)
                If (LNot (And (PAM3, 0x30)))
                {
                    Store (0x4000, D4LN)
                }

                CreateBitField (RSRC, 0x0760, D8RW)
                CreateDWordField (RSRC, 0xF1, D8MN)
                CreateDWordField (RSRC, 0xF5, D8MX)
                CreateDWordField (RSRC, 0xFD, D8LN)
                Store (One, D8RW)
                If (LEqual (And (PAM4, 0x03), 0x01))
                {
                    Store (Zero, D8RW)
                }

                Store (Zero, D8LN)
                If (LNot (And (PAM4, 0x03)))
                {
                    Store (0x4000, D8LN)
                }

                CreateBitField (RSRC, 0x0838, DCRW)
                CreateDWordField (RSRC, 0x010C, DCMN)
                CreateDWordField (RSRC, 0x0110, DCMX)
                CreateDWordField (RSRC, 0x0118, DCLN)
                Store (One, DCRW)
                If (LEqual (And (PAM4, 0x30), 0x10))
                {
                    Store (Zero, DCRW)
                }

                Store (Zero, DCLN)
                If (LNot (And (PAM4, 0x30)))
                {
                    Store (0x4000, DCLN)
                }

                CreateBitField (RSRC, 0x0910, E0RW)
                CreateDWordField (RSRC, 0x0127, E0MN)
                CreateDWordField (RSRC, 0x012B, E0MX)
                CreateDWordField (RSRC, 0x0133, E0LN)
                Store (One, E0RW)
                If (LEqual (And (PAM5, 0x03), 0x01))
                {
                    Store (Zero, E0RW)
                }

                Store (Zero, E0LN)
                If (LNot (And (PAM5, 0x03)))
                {
                    Store (0x4000, E0LN)
                }

                CreateBitField (RSRC, 0x09E8, E4RW)
                CreateDWordField (RSRC, 0x0142, E4MN)
                CreateDWordField (RSRC, 0x0146, E4MX)
                CreateDWordField (RSRC, 0x014E, E4LN)
                Store (One, E4RW)
                If (LEqual (And (PAM5, 0x30), 0x10))
                {
                    Store (Zero, E4RW)
                }

                Store (Zero, E4LN)
                If (LNot (And (PAM5, 0x30)))
                {
                    Store (0x4000, E4LN)
                }

                CreateBitField (RSRC, 0x0AC0, E8RW)
                CreateDWordField (RSRC, 0x015D, E8MN)
                CreateDWordField (RSRC, 0x0161, E8MX)
                CreateDWordField (RSRC, 0x0169, E8LN)
                Store (One, E8RW)
                If (LEqual (And (PAM6, 0x03), 0x01))
                {
                    Store (Zero, E8RW)
                }

                Store (Zero, E8LN)
                If (LNot (And (PAM6, 0x03)))
                {
                    Store (0x4000, E8LN)
                }

                CreateBitField (RSRC, 0x0B98, ECRW)
                CreateDWordField (RSRC, 0x0178, ECMN)
                CreateDWordField (RSRC, 0x017C, ECMX)
                CreateDWordField (RSRC, 0x0184, ECLN)
                Store (One, ECRW)
                If (LEqual (And (PAM6, 0x30), 0x10))
                {
                    Store (Zero, ECRW)
                }

                Store (Zero, ECLN)
                If (LNot (And (PAM6, 0x30)))
                {
                    Store (0x4000, ECLN)
                }

                Return (RSRC)
            }

            Method (_INI, 0, NotSerialized)
            {
                If (LEqual (SizeOf (_OS), 0x14))
                {
                    If (CondRefOf (\_OSI, Local0))
                    {
                        Store (0x07D1, OSYS)
                    }
                    Else
                    {
                        Store (0x07D0, OSYS)
                    }
                }
                Else
                {
                    If (LEqual (SizeOf (_OS), 0x27))
                    {
                        Store (0x07CF, OSYS)
                    }
                    Else
                    {
                        Store (0x07CE, OSYS)
                    }
                }

                If (LNot (LLess (OSYS, 0x07D0))) {}
                Store (\_SB.PCI0.ISA.RE1T (0xED, 0x02), \OEMI)
                If (\OEMI)
                {
                    Store ("HITACHI ", \OEMS)
                }
                Else
                {
                    Store ("SHARP Corporation ", \OEMS)
                }
            }

            Device (ISA)
            {
                Name (_ADR, 0x00070000)
                OperationRegion (PIRX, PCI_Config, 0x48, 0x04)
                Field (PIRX, DWordAcc, Lock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    PIR1,   4, 
                    PIR2,   4, 
                    PIR3,   4, 
                    PIR4,   4, 
                    PIR5,   4, 
                    PIR6,   4, 
                    PIRM,   4, 
                    PIRA,   4
                }

                OperationRegion (PIUC, PCI_Config, 0x74, 0x02)
                Field (PIUC, WordAcc, Lock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    PIRU,   4, 
                    Offset (0x01), 
                    PIRE,   4
                }

                Name (PIRI, Package (0x10)
                {
                    0x00, 
                    0x09, 
                    0x03, 
                    0x0A, 
                    0x04, 
                    0x05, 
                    0x07, 
                    0x06, 
                    0x01, 
                    0x0B, 
                    0x00, 
                    0x0C, 
                    0x00, 
                    0x0E, 
                    0x00, 
                    0x0F
                })
                Name (PIIR, Package (0x10)
                {
                    0x00, 
                    0x08, 
                    0x00, 
                    0x02, 
                    0x04, 
                    0x05, 
                    0x07, 
                    0x06, 
                    0x00, 
                    0x01, 
                    0x03, 
                    0x09, 
                    0x0B, 
                    0x00, 
                    0x0D, 
                    0x0F
                })
                Device (LNK1)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (RSRC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PHS (0xB3, 0x00), IRQ0)
                        Return (RSRC)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR1)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (RTL1, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTL1, 0x01, IRQ0)
                        Store (PIR1, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RTL1)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIR1)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR1)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

                Device (LNK2)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (RSRC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PHS (0xB3, 0x01), IRQ0)
                        Return (RSRC)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR2)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (RTL2, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTL2, 0x01, IRQ0)
                        Store (PIR2, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RTL2)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIR2)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR2)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

                Device (LNK3)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (RSRC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PHS (0xB3, 0x02), IRQ0)
                        Return (RSRC)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR3)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (RTL3, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTL3, 0x01, IRQ0)
                        Store (PIR3, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RTL3)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIR3)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR3)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

                Device (LNK4)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (RSRC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PHS (0xB3, 0x03), IRQ0)
                        Return (RSRC)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR4)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (RTL4, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTL4, 0x01, IRQ0)
                        Store (PIR4, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RTL4)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIR4)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR4)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

                Device (LNK5)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (RSRC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PHS (0xB3, 0x04), IRQ0)
                        Return (RSRC)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR5)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (RTL5, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTL5, 0x01, IRQ0)
                        Store (PIR5, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RTL5)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIR5)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR5)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

                Device (LNK6)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (RSRC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PHS (0xB3, 0x05), IRQ0)
                        Return (RSRC)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR6)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (RTL6, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTL6, 0x01, IRQ0)
                        Store (PIR6, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RTL6)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIR6)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR6)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

                Device (LNKM)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (RSRC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PHS (0xB3, 0x06), IRQ0)
                        Return (RSRC)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRM)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (RTLM, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLM, 0x01, IRQ0)
                        Store (PIRM, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RTLM)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIRM)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRM)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (RSRC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PHS (0xB3, 0x07), IRQ0)
                        Return (RSRC)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRA)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (RTLA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLA, 0x01, IRQ0)
                        Store (PIRA, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RTLA)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIRA)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRA)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

                Device (LNKU)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x09)
                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (RSRC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RSRC, 0x01, IRQ0)
                        Store (PHS (0xB3, 0x08), IRQ0)
                        Return (RSRC)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRU)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (RTLU, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLU, 0x01, IRQ0)
                        Store (PIRU, Local0)
                        Store (DerefOf (Index (PIRI, Local0)), Local1)
                        If (Local1)
                        {
                            ShiftLeft (0x01, Local1, IRQ0)
                        }

                        Return (RTLU)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (DerefOf (Index (PIIR, Local0)), PIRU)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRU)
                        {
                            Return (0x0B)
                        }

                        Return (0x09)
                    }
                }

                Method (QH4A, 0, Serialized)
                {
                    PHS (0xB0, 0x00)
                    Notify (\_SB.BAT0, 0x80)
                    Notify (\_SB.ADP1, 0x80)
                }

                Method (QH4F, 0, Serialized)
                {
                    Notify (\_SB.LID, 0x80)
                }

                Method (QH59, 0, NotSerialized)
                {
                    Notify (\_TZ.THRM, 0x80)
                }

                Method (QH5B, 0, NotSerialized)
                {
                    Store (\_SB.PCI0.ISA.RE1B (0xE8), Local0)
                    If (And (Local0, 0x08))
                    {
                        And (Local0, 0x07, Local1)
                        If (LGreater (\_SB.PCI0.Z001, Local1))
                        {
                            Store (Local1, \_SB.PCI0.Z001)
                            Store (0x01, \_SB.PCI0.Z002)
                            WE1B (0xE9, Local0)
                        }
                        Else
                        {
                            WE1B (0xE9, Local0)
                            Store (Local1, \_SB.PCI0.Z001)
                            Store (0x01, \_SB.PCI0.Z002)
                        }
                    }
                    Else
                    {
                        WE1B (0xE9, Local0)
                        Store (0x00, \_SB.PCI0.Z002)
                    }
                }

                Method (QH81, 0, NotSerialized)
                {
                    Notify (\_SB.BAT0, 0x81)
                }

                Method (QH82, 0, Serialized)
                {
                    Notify (\_SB.BAT0, 0x80)
                    Notify (\_SB.ADP1, 0x80)
                }

                Method (QH83, 0, NotSerialized)
                {
                    Notify (\_SB.BAT0, 0x80)
                }

                Method (QH84, 0, NotSerialized)
                {
                    Notify (\_SB.BAT0, 0x81)
                }

                Method (QH0A, 0, Serialized)
                {
                    Acquire (ECMX, 0xFFFF)
                    Store (RE1B (0xED), Local0)
                    And (Local0, 0x08, Local1)
                    If (Local1)
                    {
                        And (Local0, 0xF7, Local1)
                    }
                    Else
                    {
                        Or (Local0, 0x08, Local1)
                    }

                    WE1B (0xED, Local1)
                    PHS (0xA2, Local1)
                    Release (ECMX)
                }

                Method (QH0E, 0, NotSerialized)
                {
                    PHS (0xA0, 0x00)
                }

                Mutex (ECMX, 0x00)
                Method (QH0F, 0, Serialized)
                {
                    Acquire (ECMX, 0xFFFF)
                    Store (RE1B (0xF1), Local0)
                    And (Local0, 0x0F, Local1)
                    If (Local1)
                    {
                        Or (And (Local0, 0xF0), Decrement (Local1), Local1)
                        WE1B (0xF1, Local1)
                    }

                    PHS (0xB2, Local1)
                    Release (ECMX)
                }

                Method (QH10, 0, Serialized)
                {
                    Acquire (ECMX, 0xFFFF)
                    Store (RE1B (0xF1), Local0)
                    And (Local0, 0x0F, Local1)
                    If (LGreater (Local1, 0x06))
                    {
                        Store (0x06, Local1)
                    }

                    Or (And (Local0, 0xF0), Increment (Local1), Local1)
                    WE1B (0xF1, Local1)
                    PHS (0xB2, Local1)
                    Release (ECMX)
                }

                Method (QH14, 0, NotSerialized)
                {
                    PHS (0xA1, 0x00)
                }

                OperationRegion (ECM1, SystemIO, 0x66, 0x01)
                Field (ECM1, ByteAcc, NoLock, Preserve)
                {
                    ECC1,   8
                }

                OperationRegion (EDT1, SystemIO, 0x62, 0x01)
                Field (EDT1, ByteAcc, NoLock, Preserve)
                {
                    ECD1,   8
                }

                Method (WIB1, 0, Serialized)
                {
                    While (0x01)
                    {
                        If (LNot (And (ECC1, 0x02)))
                        {
                            Return (0x00)
                        }

                        Stall (0x0A)
                    }
                }

                Method (WOB1, 0, Serialized)
                {
                    While (0x01)
                    {
                        If (And (ECC1, 0x01))
                        {
                            Return (0x00)
                        }

                        Stall (0x0A)
                    }
                }

                Method (RE1B, 1, Serialized)
                {
                    WIB1 ()
                    Store (0x80, ECC1)
                    WIB1 ()
                    Store (Arg0, ECD1)
                    WOB1 ()
                    Return (ECD1)
                }

                Method (WE1B, 2, Serialized)
                {
                    WIB1 ()
                    Store (0x81, ECC1)
                    WIB1 ()
                    Store (Arg0, ECD1)
                    WIB1 ()
                    Store (Arg1, ECD1)
                }

                Method (RE1W, 1, Serialized)
                {
                    Store (RE1B (Arg0), Local0)
                    Store (RE1B (Add (Arg0, 0x01)), Local1)
                    Return (Or (ShiftLeft (Local1, 0x08), Local0))
                }

                Method (WE1W, 2, Serialized)
                {
                    WE1B (Arg0, And (Arg1, 0xFF))
                    WE1B (Add (Arg0, 0x01), And (ShiftRight (Arg1, 0x08), 0xFF))
                }

                Method (RE1T, 2, Serialized)
                {
                    Store (ShiftLeft (0x01, Arg1), Local0)
                    If (And (RE1B (Arg0), Local0))
                    {
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Method (WE1T, 3, Serialized)
                {
                    Store (ShiftLeft (0x01, Arg1), Local0)
                    If (Arg2)
                    {
                        WE1B (Arg0, Or (RE1B (Arg0), Local0))
                    }
                    Else
                    {
                        WE1B (Arg0, And (RE1B (Arg0), Not (Local0)))
                    }
                }

                Method (QYEC, 0, Serialized)
                {
                    If (LNot (And (ECC1, 0x20)))
                    {
                        Return (0x00)
                    }

                    WIB1 ()
                    Store (0x84, ECC1)
                    WOB1 ()
                    Return (ECD1)
                }

                Method (QYWK, 0, Serialized)
                {
                    If (LNot (And (ECC2, 0x20)))
                    {
                        Return (0x00)
                    }

                    WE1B (0x04, 0xC9)
                    While (RE1B (0x04))
                    {
                        Stall (0x0A)
                    }

                    Return (RE1B (0x05))
                }

                OperationRegion (ECM2, SystemIO, 0xD004, 0x01)
                Field (ECM2, ByteAcc, NoLock, Preserve)
                {
                    ECC2,   8
                }

                OperationRegion (EDT2, SystemIO, 0xD000, 0x01)
                Field (EDT2, ByteAcc, NoLock, Preserve)
                {
                    ECD2,   8
                }

                Device (MBRD)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x00B1, 0x00B1, 0x01, 0x01)
                        IO (Decode16, 0x040B, 0x040B, 0x01, 0x01)
                        IO (Decode16, 0x0480, 0x0480, 0x01, 0x10)
                        IO (Decode16, 0x04D6, 0x04D6, 0x01, 0x01)
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0xD000, 0xD000, 0x01, 0x01)
                        IO (Decode16, 0xD004, 0xD004, 0x01, 0x01)
                        IO (Decode16, 0x8000, 0x8000, 0x01, 0x40)
                        IO (Decode16, 0x8040, 0x8040, 0x01, 0x20)
                        IO (Decode16, 0x8084, 0x8084, 0x01, 0x04)
                        IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x02)
                        Memory32Fixed (ReadOnly, 0xFFF80000, 0x00080000)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                Device (PS2K)
                {
                    Method (_HID, 0, NotSerialized)
                    {
                        And (ShiftRight (RE1B (0xEA), 0x02), 0x03, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Return (0x2003D041)
                        }

                        If (LEqual (Local0, 0x01))
                        {
                            Return (0x0303D041)
                        }

                        Return (0x0303D041)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQ (Edge, ActiveHigh, Exclusive) {1}
                    })
                    Name (_PRW, Package (0x02)
                    {
                        0x03, 
                        0x03
                    })
                    Method (_PSW, 1, NotSerialized)
                    {
                        If (LNot (\KBWC))
                        {
                            \_SB.PCI0.ISA.WE1T (0xF4, 0x07, Arg0)
                        }
                    }
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive) {12}
                    })
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer16) {4}
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x0F)
                        IRQ (Edge, ActiveHigh, Exclusive) {13}
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

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x02)
                        IRQ (Edge, ActiveHigh, Exclusive) {8}
                    })
                }

                Device (TIME)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQ (Edge, ActiveHigh, Exclusive) {0}
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
            }

            Device (IDE)
            {
                Name (_ADR, 0x00100000)
                Name (UDMT, Package (0x08)
                {
                    0x1E, 
                    0x2D, 
                    0x3C, 
                    0x5A, 
                    0x78, 
                    0x78, 
                    0x78, 
                    0x14
                })
                Name (PIOT, Package (0x05)
                {
                    0x78, 
                    0xB4, 
                    0xF0, 
                    0x017F, 
                    0x0258
                })
                Name (PIOC, Package (0x05)
                {
                    0x04, 
                    0x06, 
                    0x08, 
                    0x0D, 
                    0x10
                })
                Name (CBCT, Package (0x05)
                {
                    0x31, 
                    0x33, 
                    0x01, 
                    0x03, 
                    0x0A
                })
                Name (DACT, Package (0x05)
                {
                    0x03, 
                    0x03, 
                    0x04, 
                    0x05, 
                    0x08
                })
                Name (DRCT, Package (0x05)
                {
                    0x01, 
                    0x03, 
                    0x04, 
                    0x08, 
                    0x08
                })
                Name (PXLM, Package (0x05)
                {
                    0x02, 
                    0x01, 
                    0x00, 
                    0x00, 
                    0x00
                })
                OperationRegion (PCI, PCI_Config, 0x00, 0x60)
                Field (PCI, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x09), 
                        ,   4, 
                    SCHE,   1, 
                    PCHE,   1, 
                    Offset (0x0A), 
                    Offset (0x0D), 
                    IDLT,   8, 
                    Offset (0x4B), 
                    U66E,   1, 
                    Offset (0x4C), 
                    Offset (0x53), 
                    CDFI,   1, 
                    CDUD,   1, 
                    Offset (0x54), 
                    PFTH,   8, 
                    SFTH,   8, 
                    PUDC,   8, 
                    SUDC,   8, 
                    PAST,   8, 
                    PCBT,   8, 
                    PTM0,   8, 
                    PTM1,   8, 
                    SAST,   8, 
                    SCBT,   8, 
                    STM0,   8, 
                    STM1,   8
                }

                Method (GTM, 3, NotSerialized)
                {
                    Store (Buffer (0x14) {}, Local0)
                    CreateDWordField (Local0, 0x00, PIO0)
                    CreateDWordField (Local0, 0x04, DMA0)
                    CreateDWordField (Local0, 0x08, PIO1)
                    CreateDWordField (Local0, 0x0C, DMA1)
                    CreateDWordField (Local0, 0x10, FLAG)
                    Store (Zero, PIO0)
                    Store (Zero, DMA0)
                    Store (Zero, PIO1)
                    Store (Zero, DMA1)
                    Store (Zero, FLAG)
                    If (Arg0)
                    {
                        ShiftRight (And (Arg0, 0x70), 0x04, Local1)
                        If (LEqual (Local1, Zero))
                        {
                            Store (0x08, Local1)
                        }

                        Add (And (Arg0, 0x0F, Local2), Local1, Local1)
                        Store (Match (^PIOC, MLE, Local1, MTR, 0x00, 0x00), Local2)
                        Store (DerefOf (Index (^PIOT, Local2)), PIO0)
                        If (LNot (LGreater (PIO0, 0xF0)))
                        {
                            Or (FLAG, 0x02, FLAG)
                        }
                    }

                    If (And (Arg2, 0x08))
                    {
                        Store (DerefOf (Index (^UDMT, And (Arg2, 0x07))), DMA0)
                        Or (FLAG, 0x01, FLAG)
                    }
                    Else
                    {
                        Store (PIO0, DMA0)
                    }

                    If (Arg1)
                    {
                        ShiftRight (And (Arg1, 0x70), 0x04, Local1)
                        If (LEqual (Local1, Zero))
                        {
                            Store (0x08, Local1)
                        }

                        Add (And (Arg1, 0x0F, Local2), Local1, Local1)
                        Store (Match (^PIOC, MLE, Local1, MTR, 0x00, 0x00), Local2)
                        Store (DerefOf (Index (^PIOT, Local2)), PIO1)
                        If (LNot (LGreater (PIO1, 0xF0)))
                        {
                            Or (FLAG, 0x08, FLAG)
                        }
                    }

                    If (And (Arg2, 0x80))
                    {
                        Store (DerefOf (Index (^UDMT, ShiftRight (And (Arg2, 0x70), 0x04))), DMA1)
                        Or (FLAG, 0x04, FLAG)
                    }
                    Else
                    {
                        Store (PIO1, DMA1)
                    }

                    Or (FLAG, 0x10, FLAG)
                    Return (Local0)
                }

                Method (STM, 3, NotSerialized)
                {
                    Store (Buffer (0x06)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        }, Local7)
                    CreateByteField (Local7, 0x00, TM0)
                    CreateByteField (Local7, 0x01, TM1)
                    CreateByteField (Local7, 0x02, UDC)
                    CreateByteField (Local7, 0x03, AST)
                    CreateByteField (Local7, 0x04, CBT)
                    CreateByteField (Local7, 0x05, U66)
                    CreateDWordField (Arg0, 0x00, PIO0)
                    CreateDWordField (Arg0, 0x04, DMA0)
                    CreateDWordField (Arg0, 0x08, PIO1)
                    CreateDWordField (Arg0, 0x0C, DMA1)
                    CreateDWordField (Arg0, 0x10, FLAG)
                    Store (FLAG, Local6)
                    Store (Ones, Local4)
                    If (LOr (DMA0, PIO0))
                    {
                        If (LAnd (DMA0, LNot (PIO0)))
                        {
                            If (And (Local6, 0x01))
                            {
                                If (LAnd (LLess (DMA0, 0x1E), LNot (LLess (DMA0, 0x0F))))
                                {
                                    Store (0x07, Local0)
                                }
                                Else
                                {
                                    Store (Match (^UDMT, MGE, DMA0, MTR, 0x00, 0x00), Local0)
                                }

                                Or (Local0, 0x08, UDC)
                                If (LLess (DMA0, 0x3C))
                                {
                                    Store (One, U66)
                                }
                            }

                            Store (Match (^PIOT, MGE, DMA0, MTR, 0x00, 0x00), Local0)
                            Store (DerefOf (Index (^DACT, Local0)), Local2)
                            Store (DerefOf (Index (^DRCT, Local0)), Local3)
                            Add (Local3, ShiftLeft (Local2, 0x04), TM0)
                            Store (Local0, Local4)
                        }

                        If (LAnd (LNot (DMA0), PIO0))
                        {
                            Store (Match (^PIOT, MGE, PIO0, MTR, 0x00, 0x00), Local0)
                            Store (DerefOf (Index (^DACT, Local0)), Local2)
                            Store (DerefOf (Index (^DRCT, Local0)), Local3)
                            Add (Local3, ShiftLeft (Local2, 0x04), TM0)
                            Store (Local0, Local4)
                        }

                        If (LAnd (DMA0, PIO0))
                        {
                            If (And (Local6, 0x01))
                            {
                                If (LAnd (LLess (DMA0, 0x1E), LNot (LLess (DMA0, 0x0F))))
                                {
                                    Store (0x07, Local0)
                                }
                                Else
                                {
                                    Store (Match (^UDMT, MGE, DMA0, MTR, 0x00, 0x00), Local0)
                                }

                                Or (Local0, 0x08, UDC)
                                If (LLess (DMA0, 0x3C))
                                {
                                    Store (One, U66)
                                }
                            }

                            If (LNot (LLess (PIO0, DMA0)))
                            {
                                Store (Match (^PIOT, MGE, PIO0, MTR, 0x00, 0x00), Local0)
                                Store (Local0, Local4)
                            }
                            Else
                            {
                                Store (Match (^PIOT, MGE, DMA0, MTR, 0x00, 0x00), Local0)
                                Store (Local0, Local4)
                            }

                            Store (DerefOf (Index (^DACT, Local0)), Local2)
                            Store (DerefOf (Index (^DRCT, Local0)), Local3)
                            Add (Local3, ShiftLeft (Local2, 0x04), TM0)
                        }
                    }

                    Store (Ones, Local5)
                    If (LOr (DMA1, PIO1))
                    {
                        If (LAnd (DMA1, LNot (PIO1)))
                        {
                            If (And (Local6, 0x04))
                            {
                                If (LAnd (LLess (DMA1, 0x1E), LNot (LLess (DMA1, 0x0F))))
                                {
                                    Store (0x07, Local0)
                                }
                                Else
                                {
                                    Store (Match (^UDMT, MGE, DMA1, MTR, 0x00, 0x00), Local0)
                                }

                                Or (ShiftLeft (Or (Local0, 0x08), 0x04), UDC, UDC)
                                If (LLess (DMA1, 0x3C))
                                {
                                    Store (One, U66)
                                }
                            }

                            Store (Match (^PIOT, MGE, DMA1, MTR, 0x00, 0x00), Local0)
                            Store (DerefOf (Index (^DACT, Local0)), Local2)
                            Store (DerefOf (Index (^DRCT, Local0)), Local3)
                            Add (Local3, ShiftLeft (Local2, 0x04), TM1)
                            Store (Local0, Local5)
                        }

                        If (LAnd (LNot (DMA1), PIO1))
                        {
                            Store (Match (^PIOT, MGE, PIO1, MTR, 0x00, 0x00), Local0)
                            Store (DerefOf (Index (^DACT, Local0)), Local2)
                            Store (DerefOf (Index (^DRCT, Local0)), Local3)
                            Add (Local3, ShiftLeft (Local2, 0x04), TM1)
                            Store (Local0, Local5)
                        }

                        If (LAnd (DMA1, PIO1))
                        {
                            If (And (Local6, 0x04))
                            {
                                If (LAnd (LLess (DMA1, 0x1E), LNot (LLess (DMA1, 0x0F))))
                                {
                                    Store (0x07, Local0)
                                }
                                Else
                                {
                                    Store (Match (^UDMT, MGE, DMA1, MTR, 0x00, 0x00), Local0)
                                }

                                Or (ShiftLeft (Or (Local0, 0x08), 0x04), UDC, UDC)
                                If (LLess (DMA1, 0x3C))
                                {
                                    Store (One, U66)
                                }
                            }

                            If (LNot (LLess (PIO1, DMA1)))
                            {
                                Store (Match (^PIOT, MGE, PIO1, MTR, 0x00, 0x00), Local0)
                                Store (Local0, Local5)
                            }
                            Else
                            {
                                Store (Match (^PIOT, MGE, DMA1, MTR, 0x00, 0x00), Local0)
                                Store (Local0, Local5)
                            }

                            Store (DerefOf (Index (^DACT, Local0)), Local2)
                            Store (DerefOf (Index (^DRCT, Local0)), Local3)
                            Add (Local3, ShiftLeft (Local2, 0x04), TM1)
                        }
                    }

                    If (LEqual (Local4, Ones))
                    {
                        If (LEqual (Local5, Ones))
                        {
                            Store (Zero, CBT)
                        }
                        Else
                        {
                            Store (DerefOf (Index (^CBCT, Local5)), CBT)
                        }
                    }
                    Else
                    {
                        If (LEqual (Local5, Ones))
                        {
                            Store (DerefOf (Index (^CBCT, Local4)), CBT)
                        }
                        Else
                        {
                            If (LNot (LLess (Local4, Local5)))
                            {
                                Store (DerefOf (Index (^CBCT, Local4)), CBT)
                            }
                            Else
                            {
                                Store (DerefOf (Index (^CBCT, Local5)), CBT)
                            }
                        }
                    }

                    Store (0x02, AST)
                    Return (Local7)
                }

                Method (GTF0, 3, NotSerialized)
                {
                    Store (Buffer (0x07)
                        {
                            0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                        }, Local7)
                    CreateByteField (Local7, 0x01, MODE)
                    If (And (Arg1, 0x08))
                    {
                        And (Arg1, 0x07, Local0)
                        If (LEqual (Local0, 0x07))
                        {
                            Store (0x05, MODE)
                        }
                        Else
                        {
                            Subtract (0x04, Local0, MODE)
                        }

                        Or (MODE, 0x40, MODE)
                    }
                    Else
                    {
                        And (Arg2, 0x0F, Local0)
                        Store (Match (^DRCT, MEQ, Local0, MTR, 0x00, 0x00), Local1)
                        Store (DerefOf (Index (^PXLM, Local1)), MODE)
                        Or (MODE, 0x20, MODE)
                    }

                    Concatenate (Local7, Local7, Local6)
                    And (Arg2, 0x0F, Local0)
                    Store (Match (^DRCT, MEQ, Local0, MTR, 0x00, 0x00), Local1)
                    Subtract (0x04, Local1, MODE)
                    Or (MODE, 0x08, MODE)
                    Concatenate (Local6, Local7, Local5)
                    Return (Local5)
                }

                Method (GTF1, 3, NotSerialized)
                {
                    Store (Buffer (0x07)
                        {
                            0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                        }, Local7)
                    CreateByteField (Local7, 0x01, MODE)
                    If (And (Arg1, 0x80))
                    {
                        ShiftRight (And (Arg1, 0x70), 0x04, Local0)
                        If (LEqual (Local0, 0x07))
                        {
                            Store (0x05, MODE)
                        }
                        Else
                        {
                            Subtract (0x04, Local0, MODE)
                        }

                        Or (MODE, 0x40, MODE)
                    }
                    Else
                    {
                        And (Arg2, 0x0F, Local0)
                        Store (Match (^DRCT, MEQ, Local0, MTR, 0x00, 0x00), Local1)
                        Store (DerefOf (Index (^PXLM, Local1)), MODE)
                        Or (MODE, 0x20, MODE)
                    }

                    Concatenate (Local7, Local7, Local6)
                    And (Arg2, 0x0F, Local0)
                    Store (Match (^DRCT, MEQ, Local0, MTR, 0x00, 0x00), Local1)
                    Subtract (0x04, Local1, MODE)
                    Or (MODE, 0x08, MODE)
                    Concatenate (Local6, Local7, Local5)
                    Return (Local5)
                }

                Device (PRIM)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store ("GTM - Primary Controller", Debug)
                        Store (^^GTM (^^PTM0, ^^PTM1, ^^PUDC), Local0)
                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store ("STM - Primary Controller", Debug)
                        Store (^^STM (Arg0, Arg1, Arg2), Local0)
                        CreateByteField (Local0, 0x00, TM0)
                        CreateByteField (Local0, 0x01, TM1)
                        CreateByteField (Local0, 0x02, UDC)
                        CreateByteField (Local0, 0x03, AST)
                        CreateByteField (Local0, 0x04, CBT)
                        CreateByteField (Local0, 0x05, U66)
                        Store (TM0, ^^PTM0)
                        Store (TM1, ^^PTM1)
                        Store (UDC, ^^PUDC)
                        Store (AST, ^^PAST)
                        Store (CBT, ^^PCBT)
                        If (U66)
                        {
                            Store (U66, ^^U66E)
                        }
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            If (LEqual (_PSC, 0x03))
                            {
                                PHS (0x94, 0x00)
                                FZLK ()
                            }

                            Store (0x00, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Primary Master", Debug)
                            Store (^^^GTF0 (^^^PCHE, ^^^PUDC, ^^^PTM0), Local0)
                            Return (Local0)
                        }
                    }

                    Device (SLAV)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Primary Slave", Debug)
                            Store (^^^GTF1 (^^^PCHE, ^^^PUDC, ^^^PTM1), Local0)
                            Return (Local0)
                        }
                    }
                }

                Device (SECN)
                {
                    Name (_ADR, 0x01)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store ("GTM - Secondary Controller", Debug)
                        Store (^^GTM (^^STM0, ^^STM1, ^^SUDC), Local0)
                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store ("STM - Secondary Controller", Debug)
                        Store (^^STM (Arg0, Arg1, Arg2), Local0)
                        CreateByteField (Local0, 0x00, TM0)
                        CreateByteField (Local0, 0x01, TM1)
                        CreateByteField (Local0, 0x02, UDC)
                        CreateByteField (Local0, 0x03, AST)
                        CreateByteField (Local0, 0x04, CBT)
                        CreateByteField (Local0, 0x05, U66)
                        Store (TM0, ^^STM0)
                        Store (TM1, ^^STM1)
                        Store (UDC, ^^SUDC)
                        Store (AST, ^^SAST)
                        Store (CBT, ^^SCBT)
                        If (U66)
                        {
                            Store (U66, ^^U66E)
                        }
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Secondary Master", Debug)
                            Store (^^^GTF0 (^^^SCHE, ^^^SUDC, ^^^STM0), Local0)
                            Return (Local0)
                        }
                    }

                    Device (SLAV)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Secondary Slave", Debug)
                            Store (^^^GTF1 (^^^SCHE, ^^^SUDC, ^^^STM1), Local0)
                            Return (Local0)
                        }
                    }
                }
            }

            OperationRegion (PRIP, SystemIO, 0x01F7, 0x01)
            Field (PRIP, ByteAcc, NoLock, Preserve)
            {
                PPD0,   8
            }

            Method (FZLK, 0, NotSerialized)
            {
                WPD0 ()
                PHS (0xB8, 0x00)
                WPD0 ()
            }

            Method (WPD0, 0, NotSerialized)
            {
                While (0x01)
                {
                    If (LNot (And (PPD0, 0x80)))
                    {
                        Return (0x00)
                    }

                    Sleep (0x0A)
                }
            }

            Device (VGA0)
            {
                Name (_ADR, 0x00090000)
            }

            Device (AUDO)
            {
                Name (_ADR, 0x00060000)
            }

            Device (MODM)
            {
                Name (_ADR, 0x00080000)
            }

            Device (CRD0)
            {
                Name (_ADR, 0x00050000)
                OperationRegion (CCRD, PCI_Config, 0x00, 0xA6)
                Field (CCRD, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                    CD04,   32, 
                    Offset (0x10), 
                    CD10,   32, 
                    Offset (0x3C), 
                    CD3C,   32, 
                    Offset (0x44), 
                    CD44,   32, 
                    Offset (0xA4), 
                    CDA4,   16
                }

                Method (_INI, 0, NotSerialized)
                {
                    Or (CD3C, 0xFF, CD3C)
                    And (CD44, 0xFFFF0000, CD44)
                }
            }

            Device (LAN0)
            {
                Name (_ADR, 0x000A0000)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x03
                })
                OperationRegion (LANP, PCI_Config, 0x00, 0x80)
                Field (LANP, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x54), 
                    PMDX,   2, 
                    Offset (0x55), 
                    PMEE,   1, 
                        ,   6, 
                    PMES,   1
                }
            }

            Device (PM)
            {
                Name (_ADR, 0x00110000)
                OperationRegion (PMUR, PCI_Config, 0x00, 0xFF)
                Field (PMUR, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x7D), 
                    GPC0,   1, 
                    GPC1,   1, 
                    GPC2,   1, 
                    GPC3,   1, 
                    GPC4,   1, 
                    GPC5,   1, 
                    GPC6,   1, 
                    GPC7,   1, 
                    GPD0,   1, 
                    GPD1,   1, 
                    GPD2,   1, 
                    GPD3,   1, 
                    GPD4,   1, 
                    GPD5,   1, 
                    GPD6,   1, 
                    GPD7,   1, 
                    GPS0,   1, 
                    GPS1,   1, 
                    GPS2,   1, 
                    GPS3,   1, 
                    GPS4,   1, 
                    GPS5,   1, 
                    GPS6,   1, 
                    GPS7,   1, 
                    Offset (0x84), 
                    GP08,   8, 
                    GP09,   8, 
                    GP10,   8, 
                    GP11,   8, 
                    GP12,   8, 
                    GP13,   8, 
                    GP14,   8, 
                    GP15,   8, 
                    Offset (0x90), 
                    GP16,   8, 
                    GP17,   8, 
                    GP18,   8, 
                    GP19,   8
                }
            }

            Device (OHC1)
            {
                Name (_ADR, 0x000C0000)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x03
                })
            }

            Device (OHC2)
            {
                Name (_ADR, 0x000C0001)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x03
                })
            }

            Device (EHCI)
            {
                Name (_ADR, 0x000C0002)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x03
                })
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x03, 
                0x05
            })
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_LID, 0, NotSerialized)
            {
                If (\_SB.PCI0.ISA.RE1T (0xF3, 0x01))
                {
                    Return (0x00)
                }

                Return (0x01)
            }
        }

        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x00)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (BINF, Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0x00, 
                0x00, 
                0x01, 
                0x01, 
                "?", 
                "?", 
                "LION", 
                "? "
            })
            Name (INF2, Package (0x0D)
            {
                0x01, 
                0x0708, 
                0x0708, 
                0x01, 
                0x2B5C, 
                0xB4, 
                0x5A, 
                0x01, 
                0x01, 
                "UNKNOWN", 
                "20020000-65535 ", 
                "LION", 
                "SHARP Corporation"
            })
            Name (BSTR, Buffer (0x10)
            {
                "????????-????? "
            })
            Name (LASW, 0x01F4)
            Name (DCAP, 0x00)
            Name (FCAP, 0x00)
            Name (DVOL, 0x00)
            Name (BVOL, 0x00)
            Name (RCAP, 0x00)
            Name (ACUR, 0x00)
            Name (BSTA, 0x00)
            Name (BTYP, 0x00)
            Method (PBUF, 3, Serialized)
            {
                CreateByteField (Arg0, Arg1, DGIT)
                Store (Arg2, DGIT)
            }

            Method (TSTR, 4, Serialized)
            {
                While (Arg2)
                {
                    Decrement (Arg2)
                    Divide (Arg1, 0x0A, Local0, Arg1)
                    PBUF (Arg0, Add (Arg2, Arg3), Add (Local0, 0x30))
                }
            }

            Method (_BIF, 0, Serialized)
            {
                If (LNot (CKBT (0x01)))
                {
                    Return (INF2)
                }

                Store (DCAP, Index (BINF, 0x01))
                Store (FCAP, Index (BINF, 0x02))
                Store (DVOL, Index (BINF, 0x04))
                Divide (DCAP, 0x0A, Local1, Index (BINF, 0x05))
                Divide (DCAP, 0x14, Local1, Index (BINF, 0x06))
                If (And (BSTA, 0x40))
                {
                    If (And (BTYP, 0x40))
                    {
                        Store ("CEBL25", Index (BINF, 0x09))
                    }
                    Else
                    {
                        Store ("CEBL24", Index (BINF, 0x09))
                    }
                }
                Else
                {
                    Store ("CEBL23", Index (BINF, 0x09))
                }

                Store (\_SB.PCI0.ISA.RE1W (0x7E), Local3)
                Store (\_SB.PCI0.ISA.RE1W (0x7C), Local4)
                TSTR (BSTR, And (Local3, 0x1F), 0x02, 0x06)
                ShiftRight (Local3, 0x05, Local3)
                TSTR (BSTR, And (Local3, 0x0F), 0x02, 0x04)
                ShiftRight (Local3, 0x04, Local3)
                TSTR (BSTR, Add (And (Local3, 0x7F), 0x07BC), 0x04, 0x00)
                TSTR (BSTR, Local4, 0x05, 0x09)
                Store (BSTR, Index (BINF, 0x0A))
                Store (\OEMS, Index (BINF, 0x0C))
                Return (BINF)
            }

            Name (STAT, Package (0x04)
            {
                0x00, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (STA2, Package (0x04)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Method (_BST, 0, Serialized)
            {
                If (LNot (CKBT (0x02)))
                {
                    Return (STA2)
                }

                Store (And (BSTA, 0x07), Index (STAT, 0x00))
                If (And (ACUR, 0x8000))
                {
                    Store (XOr (ACUR, 0xFFFF), Local1)
                    Increment (Local1)
                    If (LGreater (Local1, 0x01F4))
                    {
                        Store (Local1, LASW)
                    }
                    Else
                    {
                        Store (0x01F4, LASW)
                    }

                    Store (LASW, Index (STAT, 0x01))
                }
                Else
                {
                    If (And (BSTA, 0x02))
                    {
                        Store (ACUR, Index (STAT, 0x01))
                    }
                    Else
                    {
                        Store (LASW, Index (STAT, 0x01))
                    }
                }

                If (LNot (LLess (RCAP, FCAP)))
                {
                    Store (FCAP, Index (STAT, 0x02))
                }
                Else
                {
                    Store (RCAP, Index (STAT, 0x02))
                }

                Store (BVOL, Index (STAT, 0x03))
                Return (STAT)
            }

            Method (_STA, 0, Serialized)
            {
                If (LNot (CKBT (0x00)))
                {
                    Return (0x0F)
                }

                If (And (BSTA, 0x20))
                {
                    Return (0x1F)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Method (CKBT, 1, Serialized)
            {
                Store (\_SB.PCI0.ISA.RE1B (0x6F), Local0)
                Store (\_SB.PCI0.ISA.RE1B (0xF3), Local1)
                Or (And (Local0, 0x07), And (Local1, 0xF8), BSTA)
                Store (\_SB.PCI0.ISA.RE1B (0xEC), BTYP)
                If (LEqual (Arg0, 0x00))
                {
                    Return (0x01)
                }

                If (LNot (And (BSTA, 0x20)))
                {
                    Return (0x00)
                }

                Store (\_SB.PCI0.ISA.RE1W (0x74), DVOL)
                If (LEqual (DVOL, 0xFFFF))
                {
                    Return (0x00)
                }

                If (LEqual (DVOL, 0x00))
                {
                    Return (0x00)
                }

                If (LEqual (Arg0, 0x03))
                {
                    Return (0x01)
                }

                Store (\_SB.PCI0.ISA.RE1W (0x72), FCAP)
                If (LEqual (FCAP, 0xFFFF))
                {
                    Return (0x00)
                }

                If (LEqual (FCAP, 0x00))
                {
                    Return (0x00)
                }

                If (LEqual (Arg0, 0x01))
                {
                    Store (\_SB.PCI0.ISA.RE1W (0x70), DCAP)
                    If (LEqual (DCAP, 0xFFFF))
                    {
                        Return (0x00)
                    }

                    If (LEqual (DCAP, 0x00))
                    {
                        Return (0x00)
                    }

                    Return (0x01)
                }

                Store (\_SB.PCI0.ISA.RE1W (0x7A), BVOL)
                If (LEqual (BVOL, 0xFFFF))
                {
                    Return (0x00)
                }

                If (LEqual (BVOL, 0x00))
                {
                    Return (0x00)
                }

                Store (\_SB.PCI0.ISA.RE1W (0x78), RCAP)
                If (LEqual (RCAP, 0xFFFF))
                {
                    Return (0x00)
                }

                If (LEqual (RCAP, 0x00))
                {
                    Return (0x00)
                }

                Store (\_SB.PCI0.ISA.RE1W (0x76), ACUR)
                If (LEqual (ACUR, 0x7FFF))
                {
                    Return (0x00)
                }

                Return (0x01)
            }
        }

        Device (ADP1)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Method (_PSR, 0, NotSerialized)
            {
                Return (\_SB.PCI0.ISA.RE1T (0xF3, 0x03))
            }

            Name (_STA, 0x0F)
        }
    }

    Scope (_TZ)
    {
        ThermalZone (THRM)
        {
            Method (_TMP, 0, Serialized)
            {
                Return (Add (KLVN (\_SB.PCI0.ISA.RE1B (0xF2)), 0x01))
            }

            Method (_CRT, 0, Serialized)
            {
                Return (KLVN (\_SB.PCI0.ISA.RE1B (0xFD)))
            }

            Method (KLVN, 1, Serialized)
            {
                If (And (Arg0, 0x80))
                {
                    Store (0x10, Arg0)
                }

                Return (Add (Multiply (Arg0, 0x0A), 0x0AAB))
            }
        }
    }

    Scope (\_GPE)
    {
        Method (_L09, 0, NotSerialized)
        {
            Notify (\_SB.PCI0, 0x02)
        }

        Method (_E19, 0, NotSerialized)
        {
            Store (\_SB.PCI0.ISA.QYEC (), Local0)
            If (Local0)
            {
                Store (Local0, P80H)
            }

            If (LEqual (Local0, 0x0A))
            {
                \_SB.PCI0.ISA.QH0A ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x0E))
            {
                \_SB.PCI0.ISA.QH0E ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x0F))
            {
                \_SB.PCI0.ISA.QH0F ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x10))
            {
                \_SB.PCI0.ISA.QH10 ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x14))
            {
                \_SB.PCI0.ISA.QH14 ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x4A))
            {
                \_SB.PCI0.ISA.QH4A ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x4F))
            {
                \_SB.PCI0.ISA.QH4F ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x59))
            {
                \_SB.PCI0.ISA.QH59 ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x5B))
            {
                \_SB.PCI0.ISA.QH5B ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x81))
            {
                \_SB.PCI0.ISA.QH81 ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x82))
            {
                \_SB.PCI0.ISA.QH82 ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x83))
            {
                \_SB.PCI0.ISA.QH83 ()
                Return (0x00)
            }

            If (LEqual (Local0, 0x84))
            {
                \_SB.PCI0.ISA.QH84 ()
                Return (0x00)
            }
        }

        Method (_L03, 0, NotSerialized)
        {
            While (0x01)
            {
                Store (\_SB.PCI0.ISA.QYWK (), Local0)
                If (LEqual (Local0, 0x00))
                {
                    Return (0x00)
                }

                Store (Local0, P80H)
                If (LEqual (Local0, 0x28))
                {
                    Notify (\_SB.PCI0.ISA.PS2K, 0x02)
                }

                If (LEqual (Local0, 0x4F))
                {
                    Notify (\_SB.LID, 0x02)
                }

                If (LEqual (Local0, 0x83))
                {
                    Notify (\_SB.BAT0, 0x80)
                }
            }
        }
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
    OperationRegion (PSOM, SystemMemory, 0x0E6FFE4D, 0x00000100)
    Field (PSOM, ByteAcc, NoLock, Preserve)
    {
        PSCB,   8
    }

    Name (SFLG, 0x00)
    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, SFLG)
        Store (Arg0, P80H)
        If (LEqual (Arg0, 0x03))
        {
            PHS (0x90, 0x03)
        }

        If (LEqual (Arg0, 0x04))
        {
            \_SB.PCI0.ISA.WE1T (0xED, 0x01, 0x01)
            PHS (0x90, 0x04)
        }

        If (LEqual (Arg0, 0x05)) {}
        Sleep (0x03E8)
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (Arg0, P80H)
        If (LEqual (Arg0, 0x03))
        {
            PHS (0x91, 0x03)
            If (LNot (\_SB.PCI0.ISA.RE1T (0xEA, 0x00)))
            {
                If (LNot (\_SB.PCI0.ISA.RE1T (0xEA, 0x01)))
                {
                    Notify (\_SB.PWRB, 0x02)
                }
            }

            \_GPE._L03 ()
            PHS (0xB0, 0x00)
        }

        If (LEqual (Arg0, 0x04))
        {
            PHS (0x91, 0x04)
            If (LEqual (OSYS, 0x07D0))
            {
                Notify (\_SB.PWRB, 0x02)
            }

            If (LEqual (OSYS, 0x07D1))
            {
                Notify (\_SB.PWRB, 0x02)
            }
        }

        Notify (\_SB.BAT0, 0x81)
        Notify (\_SB.ADP1, 0x80)
        Notify (\_TZ.THRM, 0x80)
        Sleep (0xC8)
    }

    Scope (_SI)
    {
        Method (_SST, 1, NotSerialized)
        {
            If (LEqual (Arg0, 0x00))
            {
                Store (0xF5, P80H)
            }

            If (LEqual (Arg0, 0x01))
            {
                Store (0xF1, P80H)
            }

            If (LEqual (Arg0, 0x02))
            {
                Store (0xF2, P80H)
            }

            If (LEqual (Arg0, 0x03))
            {
                Store (0xF3, P80H)
                Sleep (0x012C)
            }

            If (LEqual (Arg0, 0x04))
            {
                Store (0xF4, P80H)
            }
        }
    }
}


--------------090404050501020604050407--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
