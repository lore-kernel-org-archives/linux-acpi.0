From: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Wed, 11 Feb 2004 23:48:01 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402B0581.4040203@zopatista.com>
References: <402AF9FF.3020706@zopatista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5D13D5A6C5D21B0AF2DDFF59"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <402AF9FF.3020706-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5D13D5A6C5D21B0AF2DDFF59
Content-Type: multipart/mixed;
 boundary="------------090700050900010905010605"

This is a multi-part message in MIME format.
--------------090700050900010905010605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> Attached my DSDT.dsl, as fixed so far.

Yikes, classic email mistake, 11 years of use and I still do it.
Actually attached this time.

Martijn


--------------090700050900010905010605
Content-Type: text/x-dsl;
 name="dsdt.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dsdt.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of dsdt.raw, Mon Feb  9 20:42:05 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "Arima", "161Fh   ", 100925440)
{
    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00004010, 0x06) {}
    }

    Scope (\)
    {
        Name (PICF, 0x00)
        Method (_PIC, 1, NotSerialized)
        {
            Store (Arg0, PICF)
        }
    }

    Name (_S0, Package (0x02)
    {
        0x00, 
        0x00
    })
    Name (_S3, Package (0x02)
    {
        0x01, 
        0x01
    })
    Name (_S4, Package (0x02)
    {
        0x02, 
        0x02
    })
    Name (_S5, Package (0x02)
    {
        0x02, 
        0x02
    })
    Scope (\_SB)
    {
        OperationRegion (PSIB, SystemIO, 0x0000F500, 0x00000002)
        Field (PSIB, AnyAcc, NoLock, Preserve)
        {
            SMIC,   8
        }

        OperationRegion (PSCB, SystemMemory, 0x1FEFBD4D, 0x00000200)
        Field (PSCB, AnyAcc, NoLock, Preserve)
        {
            BCMD,   8, 
            DID,    32, 
            INF,    1024
        }
    }

    Scope (\_SB)
    {
        Name (OSTB, Ones)
        OperationRegion (OSTY, SystemMemory, 0x1FEFBD4C, 0x00000001)
        Field (OSTY, AnyAcc, NoLock, Preserve)
        {
            TPOS,   8
        }

        Method (OSTP, 0, NotSerialized)
        {
            If (LEqual (^OSTB, Ones))
            {
                If (CondRefOf (\_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001.1"))
                    {
                        Store (0x20, ^OSTB)
                        Store (0x20, ^TPOS)
                    }
                    Else
                    {
                        If (\_OSI ("Windows 2001 SP1"))
                        {
                            Store (0x10, ^OSTB)
                            Store (0x10, ^TPOS)
                        }
                        Else
                        {
                            If (\_OSI ("Windows 2001"))
                            {
                                Store (0x08, ^OSTB)
                                Store (0x08, ^TPOS)
                            }
                            Else
                            {
                                Store (0x00, ^OSTB)
                                Store (0x00, ^TPOS)
                            }
                        }
                    }
                }
                Else
                {
                    If (CondRefOf (\_OS, Local0))
                    {
                        If (^SEQL (\_OS, "Microsoft Windows"))
                        {
                            Store (0x01, ^OSTB)
                            Store (0x01, ^TPOS)
                        }
                        Else
                        {
                            If (^SEQL (\_OS, "Microsoft WindowsME: Millennium Edition"))
                            {
                                Store (0x02, ^OSTB)
                                Store (0x02, ^TPOS)
                            }
                            Else
                            {
                                If (^SEQL (\_OS, "Microsoft Windows NT"))
                                {
                                    Store (0x04, ^OSTB)
                                    Store (0x04, ^TPOS)
                                }
                                Else
                                {
                                    Store (0x00, ^OSTB)
                                    Store (0x00, ^TPOS)
                                }
                            }
                        }
                    }
                    Else
                    {
                        Store (0x00, ^OSTB)
                        Store (0x00, ^TPOS)
                    }
                }
            }

            Return (^OSTB)
        }

        Method (SEQL, 2, Serialized)
        {
            Store (SizeOf (Arg0), Local0)
            Store (SizeOf (Arg1), Local1)
            If (LNot (LEqual (Local0, Local1)))
            {
                Return (Zero)
            }

            Name (BUF0, Buffer (Local0) {})
            Store (Arg0, BUF0)
            Name (BUF1, Buffer (Local0) {})
            Store (Arg1, BUF1)
            Store (Zero, Local2)
            While (LLess (Local2, Local0))
            {
                Store (DerefOf (Index (BUF0, Local2)), Local3)
                Store (DerefOf (Index (BUF1, Local2)), Local4)
                If (LNot (LEqual (Local3, Local4)))
                {
                    Return (Zero)
                }

                Increment (Local2)
            }

            Return (One)
        }
    }

    Name (FWSO, "FWSO")
    Name (_PSC, 0x00)
    Method (_PS0, 0, NotSerialized)
    {
        Store (_PSC, Local0)
        Store (0x00, _PSC)
        If (LEqual (Local0, 0x03))
        {
            Store (0x01, \_SB.INF)
            While (\_SB.INF)
            {
                If (LAnd (LEqual (\_SB.INF, 0x01), LNot (LLess (\_SB.OSTB, 0x04))))
                {
                    Sleep (0x01F4)
                }
            }
        }
    }

    Method (_PS3, 0, NotSerialized)
    {
        Store (0x03, _PSC)
    }

    Method (\_PTS, 1, NotSerialized)
    {
        Store (Zero, \_SB.PCI0.PIB.STRP)
        If (LEqual (Arg0, 0x01))
        {
            Store (One, \_SB.PCI0.PIB.GPSU)
            Store (One, \_SB.PCI0.VLNK)
            Store (One, \_SB.PCI0.VCLK)
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (0x00, \_GPE.GPEF)
            Store (Zero, \_SB.PCI0.PIB.GPSU)
            Store (One, \_SB.PCI0.PIB.STRP)
            If (LEqual (\_GPE.GUSB, 0x01))
            {
                Store (0x8D, PSCM)
                Store (Zero, SMIC)
            }

            Store (0x80, PSCM)
            Store (Zero, SMIC)
        }

        If (LEqual (Arg0, 0x04))
        {
            Sleep (0x07D0)
        }
    }

    Method (\_WAK, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x01))
        {
            Store (Zero, \_SB.PCI0.VLNK)
            Store (Zero, \_SB.PCI0.VCLK)
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (0x81, PSCM)
            Store (Zero, SMIC)
            Notify (\_SB.PCI0, 0x02)
            If (LEqual (\_GPE.GPEF, 0x01))
            {
                Store (0x00, \_GPE.GPEF)
                Notify (\_SB.PWRB, 0x02)
            }
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x82, PSCM)
            Store (Zero, SMIC)
        }

        Name (BUFF, Package (0x02)
        {
            Zero,
            One
        })
        If (LEqual (\_SB.PCI0.PIB.AC.ACP, Zero))
        {
            Store (DerefOf (Index (\_SB.PCI0.PIB.BAT0.BSTB, 0x00)), Local0)
            And (Local0, 0x02, Local0)
            If (LEqual (Local0, 0x02))
            {
                Store (One, Index (BUFF, Zero))
            }
        }

        Return (BUFF)
    }

    Scope (\_GPE)
    {
        Name (GPEF, 0x00)
        Name (GUSB, 0x00)
        Method (_L03, 0, NotSerialized)
        {
            Store (0x01, \_GPE.GPEF)
            Notify (\_SB.PCI0.NICD, 0x02)
        }

        Method (_L05, 0, NotSerialized)
        {
            Store (0x01, \_GPE.GPEF)
            Notify (\_SB.PCI0, 0x02)
            Notify (\_SB.PCI0.CRD0, 0x02)
        }

        Method (_L0B, 0, NotSerialized)
        {
            Store (0x01, \_GPE.GPEF)
            Notify (\_SB.LID, 0x80)
        }

        Method (_L0E, 0, NotSerialized)
        {
            Store (0x01, \_GPE.GPEF)
            Notify (\_SB.PCI0.USB1, 0x02)
            Notify (\_SB.PCI0.USB2, 0x02)
            Notify (\_SB.PCI0.USB3, 0x02)
        }

        Method (_L0D, 0, NotSerialized)
        {
            Store (0x01, \_GPE.GPEF)
        }
    }

    OperationRegion (PSIB, SystemIO, 0x0000F500, 0x00000002)
    Field (PSIB, AnyAcc, NoLock, Preserve)
    {
        SMIC,   8
    }

    OperationRegion (PSCB, SystemMemory, 0x1FEFBD4D, 0x00000200)
    Field (PSCB, AnyAcc, NoLock, Preserve)
    {
        PSCM,   8, 
        DID,    32, 
        INFO,   1024
    }

    Scope (\_SB)
    {
        Mutex (VSMX, 0x00)
        Method (Z000, 1, Serialized)
        {
            Store ("--------- VIA SOFTWARE SMI PMIO 2Fh ------------", Debug)
            Acquire (VSMX, 0xFFFF)
            Store (Arg0, \_SB.PCI0.PIB.BCMD)
            Release (VSMX)
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Name (_PRW, Package (0x02)
            {
                0x0C, 
                0x03
            })
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (_PRW, Package (0x02)
            {
                0x0B, 
                0x03
            })
            Method (_LID, 0, NotSerialized)
            {
                If (\_SB.PCI0.PIB.NLID)
                {
                    Return (0x01)
                }
                Else
                {
                    Return (0x00)
                }
            }
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_PRW, Package (0x02)
            {
                0x05, 
                0x05
            })
            Name (_BBN, 0x00)
            Method (_S3D, 0, NotSerialized)
            {
                Return (0x02)
            }

            OperationRegion (ECSM, SystemMemory, 0x1FEFBD4D, 0x00000200)
            Field (ECSM, AnyAcc, NoLock, Preserve)
            {
                Offset (0x05), 
                AD00,   8, 
                AD01,   8, 
                AD02,   8, 
                AD03,   8
            }

            OperationRegion (NB00, PCI_Config, 0x00, 0x0100)
            Field (NB00, ByteAcc, NoLock, Preserve)
            {
                Offset (0x47), 
                    ,   2, 
                VLNK,   1, 
                Offset (0x57), 
                EADD,   8, 
                Offset (0x61), 
                C0C3,   2, 
                C4C7,   2, 
                C8CB,   2, 
                CCCF,   2, 
                D0D3,   2, 
                D4D7,   2, 
                D8DB,   2, 
                DCDF,   2, 
                    ,   4, 
                E0EF,   2, 
                F0FF,   2, 
                Offset (0x69), 
                    ,   5, 
                VCLK,   1
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
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
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,
                    0x00000000,
                    0x00000CF7,
                    0x00000000,
                    0x00000CF8, 0x00)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,
                    0x00000D00,
                    0x0000FFFF,
                    0x00000000,
                    0x0000F300, 0x00)
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
                    0x000EFFFF,
                    0x00000000,
                    0x00010000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000F0000,
                    0x000FFFFF,
                    0x00000000,
                    0x00010000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000, 0x00)
            })
            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (CRES, 0x0182, TCMN)
                CreateDWordField (CRES, 0x0186, TCMX)
                CreateDWordField (CRES, 0x018E, TOLN)
                Multiply (\_SB.PCI0.EADD, 0x01000000, TCMN)
                Subtract (0xFFE80000, TCMN, TOLN)
                Subtract (Add (TCMN, TOLN), 0x01, TCMX)
                CreateBitField (CRES, 0x0378, C0RW)
                CreateDWordField (CRES, 0x74, C0MN)
                CreateDWordField (CRES, 0x78, C0MX)
                CreateDWordField (CRES, 0x80, C0LN)
                Store (One, C0RW)
                If (LEqual (And (C0C3, 0x03), 0x01))
                {
                    Store (Zero, C0RW)
                }

                Store (Zero, C0LN)
                If (LNot (And (C0C3, 0x03)))
                {
                    Store (0x4000, C0LN)
                }

                CreateBitField (CRES, 0x0450, C4RW)
                CreateDWordField (CRES, 0x8F, C4MN)
                CreateDWordField (CRES, 0x93, C4MX)
                CreateDWordField (CRES, 0x9B, C4LN)
                Store (One, C4RW)
                If (LEqual (And (C4C7, 0x03), 0x01))
                {
                    Store (Zero, C4RW)
                }

                Store (Zero, C4LN)
                If (LNot (And (C4C7, 0x03)))
                {
                    Store (0x4000, C4LN)
                }

                CreateBitField (CRES, 0x0528, C8RW)
                CreateDWordField (CRES, 0xAA, C8MN)
                CreateDWordField (CRES, 0xAE, C8MX)
                CreateDWordField (CRES, 0xB6, C8LN)
                Store (One, C8RW)
                If (LEqual (And (C8CB, 0x03), 0x01))
                {
                    Store (Zero, C8RW)
                }

                Store (Zero, C8LN)
                If (LNot (And (C8CB, 0x03)))
                {
                    Store (0x4000, C8LN)
                }

                CreateBitField (CRES, 0x0600, CCRW)
                CreateDWordField (CRES, 0xC5, CCMN)
                CreateDWordField (CRES, 0xC9, CCMX)
                CreateDWordField (CRES, 0xD1, CCLN)
                Store (One, CCRW)
                If (LEqual (And (CCCF, 0x03), 0x01))
                {
                    Store (Zero, CCRW)
                }

                Store (Zero, CCLN)
                If (LNot (And (CCCF, 0x03)))
                {
                    Store (0x4000, CCLN)
                }

                CreateBitField (CRES, 0x06D8, D0RW)
                CreateDWordField (CRES, 0xE0, D0MN)
                CreateDWordField (CRES, 0xE4, D0MX)
                CreateDWordField (CRES, 0xEC, D0LN)
                Store (One, D0RW)
                If (LEqual (And (D0D3, 0x03), 0x01))
                {
                    Store (Zero, D0RW)
                }

                Store (Zero, D0LN)
                If (LNot (And (D0D3, 0x03)))
                {
                    Store (0x4000, D0LN)
                }

                CreateBitField (CRES, 0x07B0, D4RW)
                CreateDWordField (CRES, 0xFB, D4MN)
                CreateDWordField (CRES, 0xFF, D4MX)
                CreateDWordField (CRES, 0x0107, D4LN)
                Store (One, D4RW)
                If (LEqual (And (D4D7, 0x03), 0x01))
                {
                    Store (Zero, D4RW)
                }

                Store (Zero, D4LN)
                If (LNot (And (D4D7, 0x03)))
                {
                    Store (0x4000, D4LN)
                }

                CreateBitField (CRES, 0x0888, D8RW)
                CreateDWordField (CRES, 0x0116, D8MN)
                CreateDWordField (CRES, 0x011A, D8MX)
                CreateDWordField (CRES, 0x0122, D8LN)
                Store (One, D8RW)
                If (LEqual (And (D8DB, 0x03), 0x01))
                {
                    Store (Zero, D8RW)
                }

                Store (Zero, D8LN)
                If (LNot (And (D8DB, 0x03)))
                {
                    Store (0x4000, D8LN)
                }

                CreateBitField (CRES, 0x0960, DCRW)
                CreateDWordField (CRES, 0x0131, DCMN)
                CreateDWordField (CRES, 0x0135, DCMX)
                CreateDWordField (CRES, 0x013D, DCLN)
                Store (One, DCRW)
                If (LEqual (And (DCDF, 0x03), 0x01))
                {
                    Store (Zero, DCRW)
                }

                Store (Zero, DCLN)
                If (LNot (And (DCDF, 0x03)))
                {
                    Store (0x4000, DCLN)
                }

                CreateBitField (CRES, 0x0A38, E0RW)
                CreateDWordField (CRES, 0x014C, E0MN)
                CreateDWordField (CRES, 0x0150, E0MX)
                CreateDWordField (CRES, 0x0158, E0LN)
                Store (One, E0RW)
                If (LEqual (And (E0EF, 0x03), 0x01))
                {
                    Store (Zero, E0RW)
                }

                Store (Zero, E0LN)
                If (LNot (And (E0EF, 0x03)))
                {
                    Store (0x00010000, E0LN)
                }

                CreateBitField (CRES, 0x0B10, F0RW)
                CreateDWordField (CRES, 0x0167, F0MN)
                CreateDWordField (CRES, 0x016B, F0MX)
                CreateDWordField (CRES, 0x0173, F0LN)
                Store (One, F0RW)
                If (LEqual (And (F0FF, 0x03), 0x01))
                {
                    Store (Zero, F0RW)
                }

                Store (Zero, F0LN)
                If (LNot (And (F0FF, 0x03)))
                {
                    Store (0x00010000, F0LN)
                }

                Return (CRES)
            }

            Name (APIC, Package (0x15)
            {
                Package (0x04)
                {
                    0x0018FFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x01, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x02, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x03, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.ALKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.ALKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x02, 
                    \_SB.PCI0.PIB.ALKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x03, 
                    \_SB.PCI0.PIB.ALKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.ALKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x01, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x03, 
                    0x00, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.ALKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.ALKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x02, 
                    \_SB.PCI0.PIB.ALKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x03, 
                    \_SB.PCI0.PIB.ALKD, 
                    0x00
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
                    0x10
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x00, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x00, 
                    0x00, 
                    0x13
                }
            })
            Name (PICM, Package (0x15)
            {
                Package (0x04)
                {
                    0x0001FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x02, 
                    \_SB.PCI0.PIB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x03, 
                    \_SB.PCI0.PIB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x02, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0018FFFF, 
                    0x03, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x02, 
                    \_SB.PCI0.PIB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x03, 
                    \_SB.PCI0.PIB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x02, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x03, 
                    \_SB.PCI0.PIB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKB, 
                    0x00
                }
            })
            Method (_PRT, 0, NotSerialized)
            {
                If (PICF)
                {
                    Return (APIC)
                }
                Else
                {
                    Return (PICM)
                }
            }

            Device (PIB)
            {
                Name (_ADR, 0x00110000)
                OperationRegion (IRQR, PCI_Config, 0x00, 0x0100)
                Field (IRQR, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x50), 
                        ,   1, 
                    ESB4,   1, 
                    ESB3,   1, 
                        ,   1, 
                    ESB1,   1, 
                    ESB2,   1, 
                    AC97,   1, 
                    MC97,   1, 
                        ,   2, 
                    PS2E,   1, 
                    Offset (0x55), 
                        ,   4, 
                    PIRA,   4, 
                    PIRB,   4, 
                    PIRC,   4, 
                        ,   4, 
                    PIRD,   4, 
                    Offset (0x88), 
                    PMBS,   16, 
                    Offset (0x94), 
                        ,   4, 
                    GPSU,   1, 
                    SUSC,   1, 
                    STRP,   1, 
                    Offset (0x95), 
                    USBW,   1, 
                    Offset (0xD0), 
                    SMBS,   16, 
                    SMBC,   1
                }

                OperationRegion (PMIO, SystemIO, 0x4000, 0x50)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                    THRO,   4, 
                    THEN,   1, 
                    Offset (0x11), 
                    ASLP,   1, 
                    HCST,   1, 
                    Offset (0x21), 
                        ,   3, 
                    NLID,   1, 
                    Offset (0x2A), 
                    PACT,   1, 
                    Offset (0x2C), 
                        ,   7, 
                    LIDP,   1, 
                    Offset (0x2F), 
                    BCMD,   8, 
                        ,   5, 
                    CMAS,   1, 
                    CMBS,   1, 
                    Offset (0x31), 
                    Offset (0x34), 
                        ,   5, 
                    CMAE,   1, 
                    CMBE,   1
                }

                OperationRegion (Z001, SystemIO, 0x80, 0x01)
                Field (Z001, ByteAcc, NoLock, Preserve)
                {
                    Z002,   8
                }

                Device (ALKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Name (_PRS, ResourceTemplate ()
                    {
                        Interrupt (ResourceConsumer, Level, ActiveLow, Shared)
                        {
                            0x00000010,
                            0x00000011,
                            0x00000012,
                            0x00000013,
                            0x00000014,
                            0x00000015,
                            0x00000016,
                            0x00000017,
                        }
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        And (PIRA, 0xF0, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        And (PIRA, 0x0F, PIRA)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFA, ResourceTemplate ()
                        {
                            Interrupt (ResourceConsumer, Level, ActiveLow, Shared)
                            {
                                0x00000000,
                            }
                        })
                        CreateWordField (BUFA, 0x05, IRAI)
                        Store (\_SB.PCI0.PIB.PIRA, IRAI)
                        Return (BUFA)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                    }
                }

                Device (ALKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Name (_PRS, ResourceTemplate ()
                    {
                        Interrupt (ResourceConsumer, Level, ActiveLow, Shared)
                        {
                            0x00000017,
                        }
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        And (PIRB, 0xF0, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        And (PIRB, 0x0F, PIRB)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFB, ResourceTemplate ()
                        {
                            Interrupt (ResourceConsumer, Level, ActiveLow, Shared)
                            {
                                0x00000000,
                            }
                        })
                        CreateWordField (BUFB, 0x05, IRBI)
                        Store (\_SB.PCI0.PIB.PIRB, IRBI)
                        Return (BUFB)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                    }
                }

                Device (ALKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Name (_PRS, ResourceTemplate ()
                    {
                        Interrupt (ResourceConsumer, Level, ActiveLow, Shared)
                        {
                            0x00000016,
                        }
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        And (PIRC, 0xF0, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        And (PIRC, 0x0F, PIRC)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFC, ResourceTemplate ()
                        {
                            Interrupt (ResourceConsumer, Level, ActiveLow, Shared)
                            {
                                0x00000000,
                            }
                        })
                        CreateWordField (BUFC, 0x05, IRCI)
                        Store (\_SB.PCI0.PIB.PIRC, IRCI)
                        Return (BUFC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                    }
                }

                Device (ALKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Name (_PRS, ResourceTemplate ()
                    {
                        Interrupt (ResourceConsumer, Level, ActiveLow, Shared)
                        {
                            0x00000015,
                        }
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        And (PIRD, 0xF0, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        And (PIRD, 0x0F, PIRD)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFD, ResourceTemplate ()
                        {
                            Interrupt (ResourceConsumer, Level, ActiveLow, Shared)
                            {
                                0x00000000,
                            }
                        })
                        CreateWordField (BUFD, 0x05, IRDI)
                        Store (\_SB.PCI0.PIB.PIRD, IRDI)
                        Return (BUFD)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                    }
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {3,4,5,7,9,12,14,15}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (Zero, \_SB.PCI0.PIB.PIRA)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.PIB.PIRA, 0x00))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateByteField (BUFA, 0x01, IRA1)
                        CreateByteField (BUFA, 0x02, IRA2)
                        Store (\_SB.PCI0.PIB.PIRA, Local0)
                        If (LGreater (Local0, 0x00))
                        {
                            If (LGreater (Local0, 0x07))
                            {
                                Subtract (Local0, 0x08, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRA2)
                            }
                            Else
                            {
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRA1)
                            }
                        }

                        Return (BUFA)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x01, IRA1)
                        CreateByteField (Arg0, 0x02, IRA2)
                        If (LGreater (IRA2, Zero))
                        {
                            FindSetLeftBit (IRA2, Local0)
                            Decrement (Local0)
                            Add (Local0, 0x08, Local0)
                        }
                        Else
                        {
                            FindSetLeftBit (IRA1, Local0)
                            Decrement (Local0)
                        }

                        Store (Local0, \_SB.PCI0.PIB.PIRA)
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {3,4,5,7,10,11,12,14,15}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (Zero, \_SB.PCI0.PIB.PIRB)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.PIB.PIRB, 0x00))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFB, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateByteField (BUFB, 0x01, IRB1)
                        CreateByteField (BUFB, 0x02, IRB2)
                        Store (\_SB.PCI0.PIB.PIRB, Local0)
                        If (LGreater (Local0, 0x00))
                        {
                            If (LGreater (Local0, 0x07))
                            {
                                Subtract (Local0, 0x08, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRB2)
                            }
                            Else
                            {
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRB1)
                            }
                        }

                        Return (BUFB)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x01, IRB1)
                        CreateByteField (Arg0, 0x02, IRB2)
                        If (LGreater (IRB2, Zero))
                        {
                            FindSetLeftBit (IRB2, Local0)
                            Decrement (Local0)
                            Add (Local0, 0x08, Local0)
                        }
                        Else
                        {
                            FindSetLeftBit (IRB1, Local0)
                            Decrement (Local0)
                        }

                        Store (Local0, \_SB.PCI0.PIB.PIRB)
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {3,4,5,7,11,12,14,15}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (Zero, \_SB.PCI0.PIB.PIRC)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.PIB.PIRC, 0x00))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateByteField (BUFC, 0x01, IRC1)
                        CreateByteField (BUFC, 0x02, IRC2)
                        Store (\_SB.PCI0.PIB.PIRC, Local0)
                        If (LGreater (Local0, 0x00))
                        {
                            If (LGreater (Local0, 0x07))
                            {
                                Subtract (Local0, 0x08, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRC2)
                            }
                            Else
                            {
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRC1)
                            }
                        }

                        Return (BUFC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x01, IRC1)
                        CreateByteField (Arg0, 0x02, IRC2)
                        If (LGreater (IRC2, Zero))
                        {
                            FindSetLeftBit (IRC2, Local0)
                            Decrement (Local0)
                            Add (Local0, 0x08, Local0)
                        }
                        Else
                        {
                            FindSetLeftBit (IRC1, Local0)
                            Decrement (Local0)
                        }

                        Store (Local0, \_SB.PCI0.PIB.PIRC)
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {3,4,5,7,9,10,11,12,14,15}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (Zero, \_SB.PCI0.PIB.PIRD)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.PIB.PIRD, 0x00))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFD, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateByteField (BUFD, 0x01, IRD1)
                        CreateByteField (BUFD, 0x02, IRD2)
                        Store (\_SB.PCI0.PIB.PIRD, Local0)
                        If (LGreater (Local0, 0x00))
                        {
                            If (LGreater (Local0, 0x07))
                            {
                                Subtract (Local0, 0x08, Local2)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local2, Local3)
                                Store (Local3, IRD2)
                            }
                            Else
                            {
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, Local2)
                                Store (Local2, IRD1)
                            }
                        }

                        Return (BUFD)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x01, IRD1)
                        CreateByteField (Arg0, 0x02, IRD2)
                        If (LGreater (IRD2, Zero))
                        {
                            FindSetLeftBit (IRD2, Local0)
                            Decrement (Local0)
                            Add (Local0, 0x08, Local0)
                        }
                        Else
                        {
                            FindSetLeftBit (IRD1, Local0)
                            Decrement (Local0)
                        }

                        Store (Local0, \_SB.PCI0.PIB.PIRD)
                    }
                }

                Device (DMA1)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        DMA (Compatibility, BusMaster, Transfer8) {4}
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode10, 0x0070, 0x0070, 0x01, 0x06)
                        IRQNoFlags () {8}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IRQNoFlags () {2}
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x10)
                        IRQNoFlags () {13}
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQNoFlags () {0}
                    })
                }

                Device (SPKR)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                    })
                }

                Device (MEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (SMEM, ResourceTemplate ()
                        {
                            Memory32Fixed (ReadWrite, 0x00000000, 0x000A0000)
                            Memory32Fixed (ReadOnly, 0x000E0000, 0x00020000)
                            Memory32Fixed (ReadOnly, 0xFFF00000, 0x00100000)
                            Memory32Fixed (ReadOnly, 0xFFEE0000, 0x00020000)
                            Memory32Fixed (ReadWrite, 0xFEE00400, 0x00001000)
                        })
                        Return (SMEM)
                    }
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.PIB.SMBC)
                        {
                            Name (RSR2, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                                IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                                IO (Decode16, 0xF510, 0xF510, 0x01, 0x02)
                                IO (Decode16, 0xF500, 0xF500, 0x01, 0x01)
                                IO (Decode16, 0x8000, 0x8000, 0x01, 0x80)
                                IO (Decode16, 0x8100, 0x8100, 0x01, 0x20)
                                IO (Decode16, 0x002E, 0x002E, 0x01, 0x01)
                                IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                                IO (Decode16, 0x00A8, 0x00A8, 0x01, 0x02)
                                IO (Decode16, 0x0300, 0x0300, 0x01, 0x02)
                            })
                            CreateWordField (RSR2, 0x22, PMMI)
                            CreateWordField (RSR2, 0x24, PMMA)
                            CreateWordField (RSR2, 0x2A, SMMI)
                            CreateWordField (RSR2, 0x2C, SMMA)
                            And (\_SB.PCI0.PIB.PMBS, 0xFFFE, PMMI)
                            Store (PMMI, PMMA)
                            And (\_SB.PCI0.PIB.SMBS, 0xFFF0, SMMI)
                            Store (SMMI, SMMA)
                            Return (RSR2)
                        }
                        Else
                        {
                            Name (RSR1, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                                IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                                IO (Decode16, 0xFE10, 0xFE10, 0x01, 0x02)
                                IO (Decode16, 0xFE00, 0xFE00, 0x01, 0x01)
                                IO (Decode16, 0x8000, 0x8000, 0x01, 0x80)
                            })
                            CreateWordField (RSR1, 0x22, IOMI)
                            CreateWordField (RSR1, 0x24, IOMA)
                            And (\_SB.PCI0.PIB.PMBS, 0xFFFE, IOMI)
                            Store (IOMI, IOMA)
                            Return (RSR1)
                        }
                    }
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_PRW, Package (0x02)
                    {
                        0x0D, 
                        0x03
                    })
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQNoFlags () {1}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (_PSW, 1, NotSerialized)
                    {
                        If (Arg0)
                        {
                            If (\_SB.PCI0.EC.ECOK)
                            {
                                Store (0x01, \_SB.PCI0.EC.KYIN)
                            }
                        }
                        Else
                        {
                            If (\_SB.PCI0.EC.ECOK)
                            {
                                Store (0x00, \_SB.PCI0.EC.KYIN)
                            }
                        }
                    }
                }

                Device (AC)
                {
                    Name (_HID, "ACPI0003")
                    Name (_PCL, Package (0x01)
                    {
                        \_SB
                    })
                    Name (ACP, 0x00)
                    Method (_STA, 0, NotSerialized)
                    {
                        Store ("---------------------------- AC _STA", Debug)
                        Return (0x0F)
                    }

                    Method (_PSR, 0, NotSerialized)
                    {
                        Store ("---------------------------- AC _PSR", Debug)
                        Store (ACP, Local0)
                        If (\_SB.PCI0.EC.ECOK)
                        {
                            Store (\_SB.PCI0.EC.ADP, Local0)
                            If (LNot (LEqual (Local0, ACP)))
                            {
                                FLPA ()
                            }
                        }

                        If (Local0)
                        {
                            Store ("---------------------------- AC on line", Debug)
                        }
                        Else
                        {
                            Store ("---------------------------- AC off line", Debug)
                        }

                        Return (Local0)
                    }

                    Method (CHAC, 0, NotSerialized)
                    {
                        Store ("---------------------------- AC _CHAC", Debug)
                        If (\_SB.PCI0.EC.ECOK)
                        {
                            Acquire (\_SB.PCI0.EC.MTX0, 0xFFFF)
                            Store (\_SB.PCI0.EC.ADP, Local0)
                            Release (\_SB.PCI0.EC.MTX0)
                            If (LNot (LEqual (Local0, ACP)))
                            {
                                FLPA ()
                            }
                        }
                    }

                    Method (FLPA, 0, NotSerialized)
                    {
                        Store ("---------------------------- AC _FLPA", Debug)
                        If (ACP)
                        {
                            Store (0x00, ACP)
                        }
                        Else
                        {
                            Store (0x01, ACP)
                        }

                        Notify (\_SB.PCI0.PIB.AC, 0x00)
                    }
                }

                Device (BAT0)
                {
                    Name (_HID, EisaId ("PNP0C0A"))
                    Name (_UID, 0x01)
                    Name (_PCL, Package (0x01)
                    {
                        \_SB
                    })
                    Name (BIFB, Package (0x0D)
                    {
                        0x01, 
                        0x0514, 
                        0x0514, 
                        0x01, 
                        0x2A30, 
                        0x0138, 
                        0x9C, 
                        0x0D, 
                        0x0D, 
                        "CA54200", 
                        "Li4402A", 
                        " ", 
                        " ARIMA  "
                    })
                    Name (BSTB, Package (0x04)
                    {
                        0x00, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0x2710
                    })
                    Name (MDLS, Package (0x07)
                    {
                        "Unknown", 
                        " 3500", 
                        " 3800", 
                        " 4500", 
                        " 2600", 
                        " 3000", 
                        " 3200"
                    })
                    Name (CHAR, Package (0x10)
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
                    Method (PBFE, 3, NotSerialized)
                    {
                        CreateByteField (Arg0, Arg1, TIDX)
                        Store (Arg2, TIDX)
                    }

                    Method (ITOS, 1, NotSerialized)
                    {
                        Store ("", Local0)
                        Store (0x08, Local1)
                        While (Local1)
                        {
                            Decrement (Local1)
                            And (ShiftRight (Arg0, ShiftLeft (Local1, 0x02)), 0x0F, Local4)
                            Store (DerefOf (Index (CHAR, Local4)), Local2)
                            Concatenate (Local0, Local2, Local5)
                            Store (Local5, Local0)
                        }

                        Return (Local0)
                    }

                    Method (Z003, 1, NotSerialized)
                    {
                        Store ("", Local0)
                        Store (0x04, Local1)
                        While (Local1)
                        {
                            Decrement (Local1)
                            And (ShiftRight (Arg0, ShiftLeft (Local1, 0x02)), 0x0F, Local4)
                            Store (DerefOf (Index (CHAR, Local4)), Local2)
                            Concatenate (Local0, Local2, Local5)
                            Store (Local5, Local0)
                        }

                        Return (Local0)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.EC.ECOK, 0x00))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Acquire (\_SB.PCI0.EC.MTX0, 0xFFFF)
                            Store (\_SB.PCI0.EC.BATP, Local0)
                            Release (\_SB.PCI0.EC.MTX0)
                            If (Or (Local0, Local0))
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }
                    }

                    Method (_BIF, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.EC.ECOK, 0x00))
                        {
                            Store (0x01, Index (BIFB, 0x00))
                            Store (0x0514, Index (BIFB, 0x01))
                            Store (0x0514, Index (BIFB, 0x02))
                            Store (0x01, Index (BIFB, 0x03))
                            Store (0x2A30, Index (BIFB, 0x04))
                            Store (0x0138, Index (BIFB, 0x05))
                            Store (0x9C, Index (BIFB, 0x06))
                            Store (0x0D, Index (BIFB, 0x07))
                            Store (0x0D, Index (BIFB, 0x08))
                            Store ("CA54200", Index (BIFB, 0x09))
                            Store ("Li4402A", Index (BIFB, 0x0A))
                            Store (" ", Index (BIFB, 0x0B))
                            Store (" ARIMA  ", Index (BIFB, 0x0C))
                        }
                        Else
                        {
                            If (\_SB.PCI0.EC.ADP)
                            {
                                Store (Zero, \_PR.CPU0._PPC)
                                Notify (\_PR.CPU0, 0x80)
                            }
                            Else
                            {
                                Store (0x02, \_PR.CPU0._PPC)
                                Notify (\_PR.CPU0, 0x80)
                            }

                            Acquire (\_SB.PCI0.EC.MTX0, 0xFFFF)
                            Store (\_SB.PCI0.EC.BPU, Index (BIFB, 0x00))
                            Store (\_SB.PCI0.EC.BDV0, Local1)
                            Store (\_SB.PCI0.EC.BDC0, Local0)
                            Multiply (Local0, Local1, Local0)
                            Divide (Local0, 0x03E8, Local2, Local0)
                            Store (Local0, Index (BIFB, 0x01))
                            Store (\_SB.PCI0.EC.BFC0, Local0)
                            Multiply (Local0, Local1, Local0)
                            Divide (Local0, 0x03E8, Local2, Local0)
                            Store (Local0, Index (BIFB, 0x02))
                            Store (\_SB.PCI0.EC.BTC0, Index (BIFB, 0x03))
                            Store (\_SB.PCI0.EC.BDV0, Index (BIFB, 0x04))
                            Store (\_SB.PCI0.EC.BCW0, Local0)
                            Multiply (Local0, Local1, Local0)
                            Divide (Local0, 0x03E8, Local2, Local0)
                            Store (Local0, Index (BIFB, 0x05))
                            Store (\_SB.PCI0.EC.BCL0, Local0)
                            Multiply (Local0, Local1, Local0)
                            Divide (Local0, 0x03E8, Local2, Local0)
                            Store (Local0, Index (BIFB, 0x06))
                            Store (\_SB.PCI0.EC.BCG0, Local0)
                            Multiply (Local0, Local1, Local0)
                            Divide (Local0, 0x03E8, Local2, Local0)
                            Store (Local0, Index (BIFB, 0x07))
                            Store (\_SB.PCI0.EC.BG20, Local0)
                            Multiply (Local0, Local1, Local0)
                            Divide (Local0, 0x03E8, Local2, Local0)
                            Store (Local0, Index (BIFB, 0x08))
                            Store (\_SB.PCI0.EC.BMO0, Local5)
                            And (Local5, 0x0F, Local5)
                            If (LGreater (Local5, 0x06))
                            {
                                Store (DerefOf (Index (MDLS, 0x00)), Index (BIFB, 0x09))
                            }
                            Else
                            {
                                Store ("---------------- NABT < 6 ", Debug)
                                Store (\_SB.PCI0.EC.BMO0, Local5)
                                And (Local5, 0x0F, Local5)
                                Store (0x00, Local1)
                                If (LEqual (Local5, 0x01))
                                {
                                    Store (0x01, Local1)
                                }

                                If (LEqual (Local5, 0x04))
                                {
                                    Store (0x01, Local1)
                                }

                                Store (\_SB.PCI0.EC.BDC0, Local0)
                                If (LEqual (Local1, 0x01))
                                {
                                    Store ("---------------------NiMH battery, NABT =1,4 ", Debug)
                                    If (LNot (LLess (Local0, 0x0ED8)))
                                    {
                                        Store (Z003 (ToBCD (Local0)), Local1)
                                        Store (Local1, Index (BIFB, 0x09))
                                        Store ("-------------------- DC > 3800 ", Debug)
                                    }
                                    Else
                                    {
                                        Store ("3800", Index (BIFB, 0x09))
                                        Store ("-------------------- DC <= 3800 ", Debug)
                                    }

                                    Store (\_SB.PCI0.EC.BDC0, Local0)
                                    If (LEqual (Local0, 0x11C6))
                                    {
                                        Store ("3800", Index (BIFB, 0x09))
                                        Store ("-------------------- DC =4550 ", Debug)
                                    }
                                }
                                Else
                                {
                                    Store ("---------------- Li Battery ", Debug)
                                    If (LNot (LLess (Local0, 0x0BB8)))
                                    {
                                        Store (Z003 (ToBCD (Local0)), Local1)
                                        Store (Local1, Index (BIFB, 0x09))
                                        Store ("--------------------- DC >= 3000 ", Debug)
                                    }
                                    Else
                                    {
                                        Store ("2600", Index (BIFB, 0x09))
                                        Store ("--------------------- DC < 3000 ", Debug)
                                    }
                                }
                            }

                            Store ("Li4402A                                                                                     ", Index (BIFB, 0x0A))
                            Store (\_SB.PCI0.EC.BSN0, Local0)
                            Store (\_SB.PCI0.EC.BSN1, Local1)
                            Store (\_SB.PCI0.EC.BTY0, Local0)
                            Store (\_SB.PCI0.EC.BTY1, Local1)
                            Store (\_SB.PCI0.EC.BTY2, Local2)
                            Store (\_SB.PCI0.EC.BTY3, Local3)
                            Store (Buffer (0x05) {}, Local4)
                            PBFE (Local4, 0x00, Local0)
                            PBFE (Local4, 0x01, Local1)
                            PBFE (Local4, 0x02, Local2)
                            PBFE (Local4, 0x03, Local3)
                            PBFE (Local4, 0x04, 0x00)
                            Name (Z004, "xxxxxxxx")
                            Store (Local4, Z004)
                            Store ("Li", Index (BIFB, 0x0B))
                            If (\_SB.PCI0.EC.BATP)
                            {
                                Store (" Dynapack ", Index (BIFB, 0x0C))
                            }
                            Else
                            {
                                Store (" ", Index (BIFB, 0x0C))
                            }

                            Release (\_SB.PCI0.EC.MTX0)
                        }
                        Return (BIFB)
                    }

                    Method (_BST, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.EC.ECOK)
                        {
                            UBST ()
                        }

                        Return (BSTB)
                    }

                    Name (CRIT, 0x00)
                    Method (UBST, 0, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.EC.MTX1, 0xFFFF)
                        Store (\_SB.PCI0.EC.BST0, Index (BSTB, 0x00))
                        Store (\_SB.PCI0.EC.BPR0, Local0)
                        Store (\_SB.PCI0.EC.BDV0, Local1)
                        If (LNot (LLess (Local0, 0x8000)))
                        {
                            Subtract (0x00010000, Local0, Local0)
                            Multiply (Local0, Local1, Local0)
                            Divide (Local0, 0x03E8, Local2, Local0)
                            Store (Local0, Index (BSTB, 0x01))
                        }
                        Else
                        {
                            Multiply (Local0, Local1, Local0)
                            Divide (Local0, 0x03E8, Local2, Local0)
                            Store (Local0, Index (BSTB, 0x01))
                        }

                        Store (\_SB.PCI0.EC.BRC0, Local0)
                        Multiply (Local0, Local1, Local0)
                        Divide (Local0, 0x03E8, Local2, Local0)
                        Store (Local0, Index (BSTB, 0x02))
                        Store (\_SB.PCI0.EC.BPV0, Index (BSTB, 0x03))
                        Store (DerefOf (Index (BSTB, 0x00)), Local0)
                        If (\_SB.PCI0.EC.ECOK)
                        {
                            Store (\_SB.PCI0.EC.BATC, Local1)
                        }

                        And (Local0, 0xFFFB, Local0)
                        ShiftLeft (Local1, 0x02, Local1)
                        Add (Local0, Local1, Local0)
                        Store (Local0, Index (BSTB, 0x00))
                        Release (\_SB.PCI0.EC.MTX1)
                    }

                    Method (INUT, 0, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.EC.MTX1, 0xFFFF)
                        If (LEqual (_STA (), 0x1F))
                        {
                            UBST ()
                            _BIF ()
                            Notify (\_SB.PCI0.PIB.AC, 0x00)
                            Notify (\_SB.PCI0.PIB.BAT0, 0x00)
                            Notify (\_SB.PCI0.PIB.BAT0, 0x80)
                            Notify (\_SB.PCI0.PIB.BAT0, 0x81)
                        }
                        Else
                        {
                            UBST ()
                            Notify (\_SB.PCI0.PIB.AC, 0x00)
                            Notify (\_SB.PCI0.PIB.BAT0, 0x00)
                            Notify (\_SB.PCI0.PIB.BAT0, 0x80)
                            Notify (\_SB.PCI0.PIB.BAT0, 0x81)
                        }

                        \_SB.PCI0.PIB.AC.FLPA ()
                        Release (\_SB.PCI0.EC.MTX1)
                    }
                }
            }

            Name (REGT, Package (0x15)
            {
                0x10, 
                0x20, 
                0x21, 
                0x22, 
                0x23, 
                0x33, 
                0x34, 
                0x35, 
                0x36, 
                0x37, 
                0x47, 
                0x48, 
                0x49, 
                0x4A, 
                0x4B, 
                0x4C, 
                0x5C, 
                0x5D, 
                0x5E, 
                0x5F, 
                0x6F
            })
            Name (DMTT, Package (0x07)
            {
                0x0F, 
                0x14, 
                0x1E, 
                0x2D, 
                0x3C, 
                0x4B, 
                0x78
            })
            Name (PIOT, Package (0x07)
            {
                0x0258, 
                0x017F, 
                0xF0, 
                0xB4, 
                0x78, 
                0x5A, 
                0x00
            })
            Device (IDE)
            {
                Name (_ADR, 0x00110001)
                OperationRegion (PCI, PCI_Config, 0x48, 0x60)
                Field (PCI, DWordAcc, NoLock, Preserve)
                {
                    SDR1,   8, 
                    SDR0,   8, 
                    PDR1,   8, 
                    PDR0,   8, 
                    SDST,   4, 
                    PDST,   4, 
                    Offset (0x08), 
                    UDMS,   16, 
                    UDMP,   16
                }

                Name (Z005, 0x00)
                Name (Z006, 0x00)
                Method (_PS3, 0, NotSerialized)
                {
                    And (^UDMP, 0x10, ^Z005)
                    And (^UDMS, 0x10, ^Z006)
                }

                Method (_PS0, 0, NotSerialized)
                {
                    If (^Z005)
                    {
                        Or (^UDMP, ^Z005, Local0)
                        Or (Local0, ShiftLeft (^Z005, 0x08), ^UDMP)
                    }

                    If (^Z006)
                    {
                        Or (^UDMS, ^Z006, Local0)
                        Or (Local0, ShiftLeft (^Z006, 0x08), ^UDMS)
                    }
                }

                Method (GIDX, 1, NotSerialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Store (0x00, Local1)
                    }
                    Else
                    {
                        If (LEqual (Arg0, 0x0E))
                        {
                            Store (0x06, Local1)
                        }
                        Else
                        {
                            Add (ShiftRight (Arg0, 0x01), 0x01, Local1)
                        }
                    }

                    Return (Local1)
                }

                Method (RIDX, 1, NotSerialized)
                {
                    Store (0x00, Local0)
                    While (NAnd (LLess (Local0, 0x07), LEqual (DerefOf (Index (^^DMTT, Local0)), Arg0)))
                    {
                        Increment (Local0)
                    }

                    If (Local0)
                    {
                        If (LGreater (Local0, 0x06))
                        {
                            Store (0x0E, Local0)
                        }
                        Else
                        {
                            Subtract (ShiftLeft (Local0, 0x01), 0x01, Local0)
                            If (LNot (LEqual (Local0, 0x01)))
                            {
                                Decrement (Local0)
                            }
                        }
                    }

                    Return (Local0)
                }

                Method (GTM, 3, NotSerialized)
                {
                    Store (Buffer (0x14) {}, Local0)
                    CreateDWordField (Local0, 0x00, PIO0)
                    CreateDWordField (Local0, 0x04, DMA0)
                    CreateDWordField (Local0, 0x08, PIO1)
                    CreateDWordField (Local0, 0x0C, DMA1)
                    CreateDWordField (Local0, 0x10, FLAG)
                    Store (Zero, FLAG)
                    Or (FLAG, 0x10, FLAG)
                    Add (And (Arg1, 0x0F), ShiftRight (Arg1, 0x04), Local1)
                    Add (Local1, 0x02, Local1)
                    Multiply (Local1, 0x1E, PIO0)
                    Or (FLAG, 0x02, FLAG)
                    Add (And (Arg2, 0x0F), ShiftRight (Arg2, 0x04), Local1)
                    Add (Local1, 0x02, Local1)
                    Multiply (Local1, 0x1E, PIO1)
                    Or (FLAG, 0x08, FLAG)
                    And (Arg0, 0x0F, Local1)
                    If (And (Arg0, 0xE0))
                    {
                        Or (FLAG, 0x04, FLAG)
                        Store (^GIDX (Local1), Local1)
                    }
                    Else
                    {
                        Store (0x06, Local1)
                    }

                    Store (DerefOf (Index (^^DMTT, Local1)), DMA1)
                    ShiftRight (And (Arg0, 0x0F00), 0x08, Local1)
                    If (And (Arg0, 0xE000))
                    {
                        Or (FLAG, 0x01, FLAG)
                        Store (^GIDX (Local1), Local1)
                    }
                    Else
                    {
                        Store (0x06, Local1)
                    }

                    Store (DerefOf (Index (^^DMTT, Local1)), DMA0)
                    Return (Local0)
                }

                Method (STM, 3, NotSerialized)
                {
                    Store (Buffer (0x05) {}, Local7)
                    CreateWordField (Local7, 0x00, UDMT)
                    CreateWordField (Local7, 0x02, PIOT)
                    CreateByteField (Local7, 0x04, R4CT)
                    CreateDWordField (Arg0, 0x00, PIO0)
                    CreateDWordField (Arg0, 0x04, DMA0)
                    CreateDWordField (Arg0, 0x08, PIO1)
                    CreateDWordField (Arg0, 0x0C, DMA1)
                    CreateDWordField (Arg0, 0x10, FLAG)
                    Store (FLAG, Local4)
                    Store (0x0E0E, Local1)
                    If (And (Local4, 0x01))
                    {
                        And (Local1, 0x0F, Local1)
                        Store (^RIDX (DMA0), Local3)
                        Or (Local3, 0xE0, Local3)
                        Or (ShiftLeft (Local3, 0x08), Local1, Local1)
                    }

                    If (And (Local4, 0x04))
                    {
                        And (Local1, 0xFF00, Local1)
                        Store (^RIDX (DMA1), Local3)
                        Or (Local3, 0xE0, Local3)
                        Or (Local3, Local1, Local1)
                    }

                    Store (Local1, UDMT)
                    Store (0x0A, Local2)
                    If (And (Local4, 0x02))
                    {
                        Divide (PIO0, 0x1E, , Local3)
                        Subtract (Local3, 0x03, Local3)
                        If (LLess (Local3, 0x0C))
                        {
                            And (Local2, 0x03, Local2)
                            Or (Local2, 0x04, Local2)
                        }

                        Store (ShiftLeft (DerefOf (Index (^^REGT, Local3)), 0x08), Local6)
                    }
                    Else
                    {
                        Store (0x00, Local6)
                    }

                    If (And (Local4, 0x08))
                    {
                        Divide (PIO1, 0x1E, , Local3)
                        Subtract (Local3, 0x03, Local3)
                        If (LLess (Local3, 0x0C))
                        {
                            And (Local2, 0x0C, Local2)
                            Or (Local2, 0x01, Local2)
                        }

                        Store (DerefOf (Index (^^REGT, Local3)), Local6)
                    }
                    Else
                    {
                        Store (And (Local6, 0xFF00), Local6)
                    }

                    Store (Local2, R4CT)
                    Store (Local6, PIOT)
                    Return (Local7)
                }

                Method (GTF, 3, NotSerialized)
                {
                    If (Arg2)
                    {
                        Store (Buffer (0x07)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                            }, Local7)
                    }
                    Else
                    {
                        Store (Buffer (0x07)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                            }, Local7)
                    }

                    CreateByteField (Local7, 0x01, MODE)
                    Add (And (Arg0, 0x0F), ShiftRight (Arg0, 0x04), Local1)
                    Add (Local1, 0x02, Local1)
                    Multiply (Local1, 0x1E, Local0)
                    Store (Match (^^PIOT, MLT, Local0, MTR, 0x00, 0x00), Local1)
                    If (Local1)
                    {
                        Decrement (Local1)
                    }

                    If (And (Arg1, 0xE0))
                    {
                        Store (^GIDX (And (Arg1, 0x0F)), Local0)
                        If (LGreater (Local0, 0x06))
                        {
                            Store (0x00, Local0)
                        }
                        Else
                        {
                            Subtract (0x06, Local0, Local0)
                        }

                        Or (Local0, 0x40, MODE)
                    }
                    Else
                    {
                        Or (Local1, 0x08, MODE)
                    }

                    Concatenate (Local7, Local7, Local6)
                    Or (Local1, 0x08, MODE)
                    Concatenate (Local6, Local7, Local5)
                    Return (Local5)
                }

                Device (PRIM)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store ("GTM - Primary Controller", Debug)
                        Store (^^GTM (^^UDMP, ^^PDR0, ^^PDR1), Local0)
                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store ("STM - Primary Controller", Debug)
                        Store (^^STM (Arg0, Arg1, Arg2), Local0)
                        CreateWordField (Local0, 0x00, UDMA)
                        CreateWordField (Local0, 0x02, PIOM)
                        CreateByteField (Local0, 0x04, ADST)
                        Store (Or (UDMA, And (^^UDMP, 0x1010)), ^^UDMP)
                        Store (And (PIOM, 0xFF), Local1)
                        If (Local1)
                        {
                            Store (Local1, ^^PDR1)
                        }

                        ShiftRight (PIOM, 0x08, Local1)
                        If (Local1)
                        {
                            Store (Local1, ^^PDR0)
                        }

                        Store (ADST, ^^PDST)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Primary Master", Debug)
                            ShiftRight (^^^UDMP, 0x08, Local0)
                            Store (^^^GTF (^^^PDR0, Local0, 0x01), Local0)
                            Return (Local0)
                        }
                    }

                    Device (SLAV)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Primary Slave", Debug)
                            Store (^^^GTF (^^^PDR1, ^^^UDMP, 0x00), Local0)
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
                        Store (^^GTM (^^UDMS, ^^SDR0, ^^SDR1), Local0)
                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store ("STM - Secondary Controller", Debug)
                        Store (^^STM (Arg0, Arg1, Arg2), Local0)
                        CreateWordField (Local0, 0x00, DMAS)
                        CreateWordField (Local0, 0x02, PIOS)
                        CreateByteField (Local0, 0x04, ADSS)
                        Store (Or (DMAS, And (^^UDMS, 0x1010)), ^^UDMS)
                        And (PIOS, 0xFF, Local1)
                        If (Local1)
                        {
                            Store (Local1, ^^SDR1)
                        }

                        ShiftRight (PIOS, 0x08, Local1)
                        If (Local1)
                        {
                            Store (Local1, ^^SDR0)
                        }

                        Store (ADSS, ^^SDST)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Secondary Master", Debug)
                            ShiftRight (^^^UDMS, 0x08, Local0)
                            Store (^^^GTF (^^^SDR0, Local0, 0x01), Local0)
                            Return (Local0)
                        }
                    }

                    Device (SLAV)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Secondary Slave", Debug)
                            Store (^^^GTF (^^^SDR1, ^^^UDMS, 0x00), Local0)
                            Return (Local0)
                        }
                    }
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x00100000)
                Method (_STA, 0, NotSerialized)
                {
                    If (\_SB.PCI0.PIB.ESB1)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x0E, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x00, \_GPE.GUSB)
                    }
                    Else
                    {
                        Store (0x01, \_GPE.GUSB)
                    }
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x00100001)
                Method (_STA, 0, NotSerialized)
                {
                    If (\_SB.PCI0.PIB.ESB2)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x0E, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x00, \_GPE.GUSB)
                    }
                    Else
                    {
                        Store (0x01, \_GPE.GUSB)
                    }
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x00100002)
                Method (_STA, 0, NotSerialized)
                {
                    If (\_SB.PCI0.PIB.ESB3)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x0E, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x00, \_GPE.GUSB)
                    }
                    Else
                    {
                        Store (0x01, \_GPE.GUSB)
                    }
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB4)
            {
                Name (_ADR, 0x00100003)
                Method (_STA, 0, NotSerialized)
                {
                    If (\_SB.PCI0.PIB.ESB4)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (Z007)
            {
                Name (_ADR, 0x00110005)
                OperationRegion (SB75, PCI_Config, 0x00, 0x80)
                Field (SB75, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x2C), 
                    AD2C,   32, 
                    Offset (0x42), 
                        ,   5, 
                    Z008,   1
                }

                Method (_STA, 0, NotSerialized)
                {
                    If (\_SB.PCI0.PIB.AC97)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Name (Z009, 0x00)
                Method (_PS0, 0, NotSerialized)
                {
                    If (LEqual (^AD2C, 0x00))
                    {
                        Store (0x01, ^Z008)
                        Store (Z009, ^AD2C)
                        Store (0x00, ^Z008)
                    }
                    Else
                    {
                        Store (^AD2C, Z009)
                    }
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (^AD2C, Z009)
                }
            }

            Device (Z00A)
            {
                Name (_ADR, 0x00110006)
                Name (_PRW, Package (0x02)
                {
                    0x0D, 
                    0x03
                })
                OperationRegion (SB76, PCI_Config, 0x00, 0x80)
                Field (SB76, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x2C), 
                    MD2C,   32, 
                    Offset (0x44), 
                        ,   4, 
                    Z00B,   1
                }

                Method (_STA, 0, NotSerialized)
                {
                    If (\_SB.PCI0.PIB.MC97)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Name (Z009, 0x00)
                Method (_PS0, 0, NotSerialized)
                {
                    If (LEqual (^MD2C, 0x00))
                    {
                        Store (0x01, ^Z00B)
                        Store (Z009, ^MD2C)
                        Store (0x00, ^Z00B)
                    }
                    Else
                    {
                        Store (^MD2C, Z009)
                    }
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (^MD2C, Z009)
                }
            }

            Device (CRD0)
            {
                Name (_ADR, 0x000A0000)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x03
                })
                Method (_INI, 0, NotSerialized)
                {
                    Or (PMEE, 0x01, PMEE)
                    Store (0x01, PMEN)
                }

                Method (_PSC, 0, NotSerialized)
                {
                    Store (PWST, Local0)
                    Return (Local0)
                }

                Method (_PS0, 0, NotSerialized)
                {
                    Store (0x01, PMST)
                }

                Method (_PS2, 0, NotSerialized)
                {
                    Store (0x01, PMST)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (0x01, PMST)
                }

                Name (EX03, Zero)
                Method (_PSW, 1, NotSerialized)
                {
                    If (LEqual (Arg0, 0x01))
                    {
                        Store (0x00, PWST)
                        Or (PMEE, 0x01, PMEE)
                        Store (TI04, Local1)
                        Store (Or (TI04, 0x01), TI04)
                        Store (0x03E1, TI44)
                        Store (0x03, TIID)
                        Store (TIDA, EX03)
                        Store (Or (EX03, 0x80), TIDA)
                    }
                    Else
                    {
                        Store (0x00, PWST)
                        If (LEqual (PMST, 0x01))
                        {
                            Store (0x01, PMST)
                            Notify (\_SB.PCI0.CRD0, 0x00)
                        }
                    }
                }

                OperationRegion (CCRD, PCI_Config, 0x00, 0xA7)
                Field (CCRD, DWordAcc, Lock, Preserve)
                {
                    Offset (0x04), 
                    TI04,   8, 
                    Offset (0x44), 
                    TI44,   16, 
                    Offset (0x80), 
                    PMEE,   1, 
                    Offset (0x81), 
                    Offset (0xA4), 
                    PWST,   2, 
                    Offset (0xA5), 
                    PMEN,   1, 
                        ,   6, 
                    PMST,   1
                }

                OperationRegion (TIIO, SystemIO, 0x03E0, 0x02)
                Field (TIIO, ByteAcc, NoLock, Preserve)
                {
                    TIID,   8, 
                    TIDA,   8
                }
            }

            Device (NICD)
            {
                Name (_ADR, 0x00120000)
                Name (_PRW, Package (0x02)
                {
                    0x03, 
                    0x03
                })
                Method (_PS0, 0, NotSerialized)
                {
                }

                Method (_PS3, 0, NotSerialized)
                {
                }
            }

            Device (AGP)
            {
                Name (_ADR, 0x00010000)
                Device (VGA)
                {
                    Name (_ADR, 0x00)
                    Name (SWIT, 0x01)
                    Name (CRTA, 0x01)
                    Name (LCDA, 0x01)
                    Name (TVOA, 0x01)
                    Name (TOGF, 0x01)
                    Name (OSF, 0x00)
                    Method (_INI, 0, NotSerialized)
                    {
                        If (LEqual (SCMP (\_OS, "Microsoft Windows NT"), Zero))
                        {
                            Store (One, OSF)
                        }

                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            Store (One, OSF)
                        }
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        Store ("VGA --_DOS", Debug)
                        Store (Arg0, SWIT)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Store ("VGA --_DOD", Debug)
                        Return (Package (0x03)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x00010200
                        })
                    }

                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store ("CRT --_DCS", Debug)
                            If (CRTA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("CRT --_DGS", Debug)
                            Store (CRTA, Local0)
                            If (CRTA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("CRT --_DSS", Debug)
                        }
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store ("LCD --_DCS", Debug)
                            If (LCDA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("LCD --_DGS", Debug)
                            Store (LCDA, Local0)
                            If (LCDA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("LCD --_DSS", Debug)
                        }
                    }

                    Device (TVO)
                    {
                        Name (_ADR, 0x0200)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store ("TVO --_DCS", Debug)
                            If (TVOA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("TVO --_DGS", Debug)
                            Store (TVOA, Local0)
                            If (TVOA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("TVO --_DSS", Debug)
                        }
                    }
                }
            }

            Method (MIN, 2, NotSerialized)
            {
                If (LLess (Arg0, Arg1))
                {
                    Return (Arg0)
                }
                Else
                {
                    Return (Arg1)
                }
            }

            Method (SLEN, 1, NotSerialized)
            {
                Return (SizeOf (Arg0))
            }

            Method (S2BF, 1, Serialized)
            {
                Add (SLEN (Arg0), One, Local0)
                Name (BUFF, Buffer (Local0) {})
                Store (Arg0, BUFF)
                Return (BUFF)
            }

            Method (SCMP, 2, NotSerialized)
            {
                Store (S2BF (Arg0), Local0)
                Store (S2BF (Arg1), Local1)
                Store (Zero, Local4)
                Store (SLEN (Arg0), Local5)
                Store (SLEN (Arg1), Local6)
                Store (MIN (Local5, Local6), Local7)
                While (LLess (Local4, Local7))
                {
                    Store (DerefOf (Index (Local0, Local4)), Local2)
                    Store (DerefOf (Index (Local1, Local4)), Local3)
                    If (LGreater (Local2, Local3))
                    {
                        Return (One)
                    }
                    Else
                    {
                        If (LLess (Local2, Local3))
                        {
                            Return (Ones)
                        }
                    }

                    Increment (Local4)
                }

                If (LLess (Local4, Local5))
                {
                    Return (One)
                }
                Else
                {
                    If (LLess (Local4, Local6))
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (EC)
            {
                Name (_HID, EisaId ("PNP0C09"))
                Name (_GPE, 0x01)
                Name (ECOK, 0x00)
                Method (_REG, 2, NotSerialized)
                {
                    If (LEqual (Arg0, 0x03))
                    {
                        Store (Arg1, ECOK)
                        Store (Arg1, \_SB.PCI0.EC.ECOK)
                    }
                }

                Name (_CRS, ResourceTemplate ()
                {
                    IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                    IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                })
                OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                Field (ERAM, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                    CMCM,   8, 
                    CMD1,   8, 
                    CMD2,   8, 
                    CMD3,   8
                }

                Field (ERAM, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x80), 
                    NMSG,   8, 
                    SLED,   4, 
                    SLPT,   4, 
                    MODE,   1, 
                    KYIN,   1, 
                    ACPI,   1, 
                    PWBN,   1, 
                    TME0,   1, 
                    TME1,   1, 
                    FANC,   1, 
                    DETF,   1, 
                    LIDS,   1, 
                    LWKE,   1, 
                    IWKE,   1, 
                    INTM,   1, 
                    MWKE,   1, 
                    COMM,   1, 
                    PME,    1, 
                    Offset (0x84), 
                    ADP,    1, 
                    AFLT,   1, 
                    BATP,   1, 
                        ,   1, 
                    BATL,   1, 
                    BATC,   1, 
                    Offset (0x85), 
                    BPU,    32, 
                    BDC0,   16, 
                    BDC1,   16, 
                    BFC0,   16, 
                    BFC1,   16, 
                    BTC0,   16, 
                    BTC1,   16, 
                    BDV0,   16, 
                    BDV1,   16, 
                    BST0,   16, 
                    BST1,   16, 
                    BPR0,   16, 
                    BPR1,   16, 
                    BRC0,   16, 
                    BRC1,   16, 
                    BPV0,   16, 
                    BPV1,   16, 
                    BTP,    32, 
                    BCW0,   16, 
                    BCW1,   16, 
                    BCL0,   16, 
                    BCL1,   16, 
                    BCG0,   16, 
                    BCG1,   16, 
                    BG20,   16, 
                    BG21,   16, 
                    BMO0,   16, 
                    BMO1,   16, 
                    BIF,    64, 
                    BSN0,   32, 
                    BSN1,   32, 
                    BTY0,   16, 
                    BTY1,   16, 
                    BTY2,   16, 
                    BTY3,   16, 
                    AC0,    16, 
                    Offset (0xDD), 
                    PSV,    16, 
                    Offset (0xE1), 
                    CRT,    16, 
                    Offset (0xE5), 
                    TMP1,   8, 
                    TMP2,   8, 
                    NABT,   16, 
                    Offset (0xF1), 
                    CPID,   8, 
                    CPSP,   8
                }

                Mutex (MTX0, 0x00)
                Mutex (MTX1, 0x00)
                Method (_Q06, 0, NotSerialized)
                {
                    If (\_SB.PCI0.EC.ADP)
                    {
                        Store (Zero, \_PR.CPU0._PPC)
                        Notify (\_PR.CPU0, 0x80)
                        Notify (\_SB.PCI0.PIB.AC, 0x00)
                        Notify (\_SB.PCI0.PIB.BAT0, 0x80)
                    }
                    Else
                    {
                        Store (0x02, \_PR.CPU0._PPC)
                        Notify (\_PR.CPU0, 0x80)
                        Notify (\_SB.PCI0.PIB.AC, 0x01)
                        Notify (\_SB.PCI0.PIB.BAT0, 0x80)
                    }
                }

                Method (_Q08, 0, NotSerialized)
                {
                    \_SB.PCI0.PIB.BAT0.INUT ()
                    Notify (\_SB.PCI0.PIB.BAT0, 0x80)
                }

                Method (_Q09, 0, NotSerialized)
                {
                    \_SB.PCI0.PIB.BAT0.UBST ()
                    Notify (\_SB.PCI0.PIB.BAT0, 0x80)
                }

                Method (_Q03, 0, NotSerialized)
                {
                    Notify (\_SB.PCI0.PIB.BAT0, 0x80)
                }

                Method (_Q04, 0, NotSerialized)
                {
                    Notify (\_SB.PCI0.PIB.BAT0, 0x80)
                }

                Method (_Q0A, 0, NotSerialized)
                {
                    Notify (\_SB.LID, 0x80)
                }

                Method (_Q11, 0, NotSerialized)
                {
                    Store (0x88, PSCM)
                    Store (Zero, SMIC)
                }

                Method (_Q10, 0, NotSerialized)
                {
                    Notify (\_SB.SLPB, 0x80)
                }

                Method (_Q0B, 0, NotSerialized)
                {
                    Store ("_Q10 Enevt", Debug)
                    Store (Zero, Local1)
                    Store (0x83, PSCM)
                    Store (Zero, SMIC)
                    Store (\_SB.PCI0.AD02, Local1)
                    If (Local1)
                    {
                        If (\_SB.PCI0.AGP.VGA.OSF)
                        {
                            Notify (\_SB.PCI0.AGP.VGA, 0x80)
                            Store (\_SB.PCI0.AGP.VGA.TOGF, Local0)
                            Store (\_SB.PCI0.AD01, Local3)
                            Store (\_SB.PCI0.AD00, Local4)
                            Store (One, Local5)
                            Store (Zero, Local6)
                            If (Local3)
                            {
                                Add (Local5, 0x02, Local5)
                            }

                            If (Local4)
                            {
                                Add (Local5, 0x04, Local5)
                            }

                            If (LGreater (Local0, 0x06))
                            {
                                Store (Zero, \_SB.PCI0.AGP.VGA.TOGF)
                                Store (Zero, Local0)
                            }

                            Increment (Local0)
                            And (Local5, Local0, Local6)
                            If (LEqual (Local6, Local0))
                            {
                                Store (Zero, Local3)
                            }
                            Else
                            {
                                Store (One, Local3)
                            }

                            While (Local3)
                            {
                                Increment (Local0)
                                And (Local5, Local0, Local6)
                                If (LEqual (Local6, Local0))
                                {
                                    Store (Zero, Local3)
                                }
                                Else
                                {
                                    Store (One, Local3)
                                }

                                If (LGreater (Local0, 0x06))
                                {
                                    Store (Zero, Local0)
                                }
                            }

                            Store (Local0, \_SB.PCI0.AGP.VGA.TOGF)
                            Store (Local6, \_SB.PCI0.PIB.Z002)
                            If (LEqual (Local6, 0x01))
                            {
                                Store (One, \_SB.PCI0.AGP.VGA.LCDA)
                                Store (Zero, \_SB.PCI0.AGP.VGA.CRTA)
                                Store (Zero, \_SB.PCI0.AGP.VGA.TVOA)
                            }

                            If (LEqual (Local6, 0x02))
                            {
                                Store (Zero, \_SB.PCI0.AGP.VGA.LCDA)
                                Store (One, \_SB.PCI0.AGP.VGA.CRTA)
                                Store (Zero, \_SB.PCI0.AGP.VGA.TVOA)
                            }

                            If (LEqual (Local6, 0x03))
                            {
                                Store (One, \_SB.PCI0.AGP.VGA.LCDA)
                                Store (One, \_SB.PCI0.AGP.VGA.CRTA)
                                Store (Zero, \_SB.PCI0.AGP.VGA.TVOA)
                            }

                            If (LEqual (Local6, 0x04))
                            {
                                Store (Zero, \_SB.PCI0.AGP.VGA.LCDA)
                                Store (Zero, \_SB.PCI0.AGP.VGA.CRTA)
                                Store (One, \_SB.PCI0.AGP.VGA.TVOA)
                            }

                            If (LEqual (Local6, 0x05))
                            {
                                Store (One, \_SB.PCI0.AGP.VGA.LCDA)
                                Store (Zero, \_SB.PCI0.AGP.VGA.CRTA)
                                Store (One, \_SB.PCI0.AGP.VGA.TVOA)
                            }

                            If (LEqual (Local6, 0x06))
                            {
                                Store (Zero, \_SB.PCI0.AGP.VGA.LCDA)
                                Store (One, \_SB.PCI0.AGP.VGA.CRTA)
                                Store (One, \_SB.PCI0.AGP.VGA.TVOA)
                            }

                            If (LEqual (Local6, 0x07))
                            {
                                Store (One, \_SB.PCI0.AGP.VGA.LCDA)
                                Store (One, \_SB.PCI0.AGP.VGA.CRTA)
                                Store (One, \_SB.PCI0.AGP.VGA.TVOA)
                            }

                            Notify (\_SB.PCI0.AGP.VGA, 0x80)
                        }
                        Else
                        {
                            Store (0x85, PSCM)
                            Store (Zero, SMIC)
                            Notify (\_SB.PCI0.AGP.VGA, 0x80)
                        }
                    }
                }

                Method (_Q12, 0, NotSerialized)
                {
                    Store (0x12, \_SB.PCI0.PIB.Z002)
                    Store (0x86, PSCM)
                    Store (Zero, SMIC)
                }

                Method (_Q13, 0, NotSerialized)
                {
                    Store (0x13, \_SB.PCI0.PIB.Z002)
                    Store (0x87, PSCM)
                    Store (Zero, SMIC)
                }

                Method (_Q38, 0, NotSerialized)
                {
                    Store (0x02, \_PR.CPU0._PPC)
                    Notify (\_PR.CPU0, 0x80)
                }

                Method (_Q3A, 0, NotSerialized)
                {
                    Store (0x8B, PSCM)
                    Store (Zero, SMIC)
                    If (\_SB.PCI0.EC.ADP)
                    {
                        Store (Zero, \_PR.CPU0._PPC)
                        Notify (\_PR.CPU0, 0x80)
                    }
                    Else
                    {
                        Store (0x02, \_PR.CPU0._PPC)
                        Notify (\_PR.CPU0, 0x80)
                    }
                }
            }
        }
    }
}



--------------090700050900010905010605--

--------------enig5D13D5A6C5D21B0AF2DDFF59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAKwWB3xaj2GOvgP0RAneXAJ4oU57YvjvMW4P1I3Q38YVJmCTlrACfRimx
roFtRLTlBu2EqPH4gtuxao0=
=3AcX
-----END PGP SIGNATURE-----

--------------enig5D13D5A6C5D21B0AF2DDFF59--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
