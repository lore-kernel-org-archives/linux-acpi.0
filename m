From: Oliver Zimmermann <olli.zimmermann-hi6Y0CQ0nG0@public.gmane.org>
Subject: smart battery on acer extensa 3002
Date: Thu, 2 Dec 2004 21:21:00 +0100
Message-ID: <200412022121.00582.olli.zimmermann@gmx.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sk3rBCJz3CvlDs/"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_sk3rBCJz3CvlDs/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello

i bought an acer extensa 3002 laptop and install SuSE 9.1 with Kernel 2.6.5=
 to=20
2.6.10-rc1.=20
Acpi is supported and i can get many informations but there is no battery=20
support. I disassembled the DSDT and dont=B4t find any device <bat>. After=
=20
reading acpi-documentation i found entries about smart battery useage. i=20
compared with my dsdt an didn=B4t find a difference. With=20
Windows XP the control manager dosn=B4t list a ACPI battery support but use=
=20
two smart batteries (only one is present) with SMBus. So i install and ask=
=20
lm_sensor for help. They told me, that i2cdetect 0 dosn=B4t list a smart=20
battery so i can=B4t get a module for my battery. So i asked acpi.sourcefor=
ge=20
and they told me to ask you.=20


PLEASE: Can i get smart battery informations? Perhaps changing my dsdt? A=20
notebook without battery informations is . . . and i don=B4t want to fall b=
ack=20
to windows.

I attached my log files.

Thanks

Zimmermann

--Boundary-00=_sk3rBCJz3CvlDs/
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="dsdt.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dsdt.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20040220
 *
 * Disassembly of dsdt.dat, Sat Nov 13 13:39:11 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "ACER  ", "Kestrel ", 537004297)
{
    OperationRegion (PORT, SystemIO, 0x80, 0x02)
    Field (PORT, ByteAcc, NoLock, Preserve)
    {
        P80H,   8, 
        P81H,   8
    }

    OperationRegion (IO_T, SystemIO, 0x0800, 0x10)
    Field (IO_T, ByteAcc, NoLock, Preserve)
    {
        TRP0,   8
    }

    OperationRegion (MNVS, SystemMemory, 0x1FEECE59, 0x60)
    Field (MNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        SCIF,   8, 
        PAR1,   8, 
        PAR2,   8, 
        ACPS,   8, 
        DBGS,   8, 
        DCKS,   4, 
        CDCK,   4, 
        IGDS,   8, 
        SLID,   8, 
        BRTC,   8, 
        BRTS,   8, 
        WRKF,   8, 
        SW2L,   1, 
        PNCS,   1, 
        Offset (0x0F), 
        PRID,   8, 
        CMAP,   8, 
        CMBP,   8, 
        LPTP,   8, 
        FDCP,   8, 
        Offset (0x15), 
        PS2F,   8, 
        Offset (0x18), 
        ACTT,   8, 
        PSVT,   8, 
        TC1V,   8, 
        TC2V,   8, 
        TSPV,   8, 
        CRTT,   8, 
        Offset (0x20), 
        BVAL,   32, 
        DOFF,   8, 
        CLNM,   8, 
        TMP2,   8, 
        SVCR,   8, 
        TMP4,   32, 
        TMP5,   32, 
        CSTE,   16, 
        NSTE,   16, 
        SSTE,   16, 
        CADL,   16, 
        PADL,   16, 
        BCAP,   8
    }

    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06)
        {
            Name (_PCT, Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x00000000000000B2)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x00000000000000B3)
                }
            })
            Method (_PSS, 0, NotSerialized)
            {
                If (CLNM)
                {
                    Return (CPSS)
                }

                Return (PPSS)
            }

            Name (CPSS, Package (0x01)
            {
                Package (0x06)
                {
                    0x0640, 
                    0x5DC0, 
                    0x0A, 
                    0x0A, 
                    0x89, 
                    0x00
                }
            })
            Name (PPSS, Package (0x05)
            {
                Package (0x06)
                {
                    0x0640, 
                    0x5DC0, 
                    0x0A, 
                    0x0A, 
                    0x89, 
                    0x00
                }, 

                Package (0x06)
                {
                    0x0578, 
                    0x4E20, 
                    0x0A, 
                    0x0A, 
                    0x8A, 
                    0x01
                }, 

                Package (0x06)
                {
                    0x04B0, 
                    0x4650, 
                    0x0A, 
                    0x0A, 
                    0x8B, 
                    0x02
                }, 

                Package (0x06)
                {
                    0x0320, 
                    0x3E80, 
                    0x0A, 
                    0x0A, 
                    0x8C, 
                    0x03
                }, 

                Package (0x06)
                {
                    0x0258, 
                    0x2EE0, 
                    0x0A, 
                    0x0A, 
                    0x8D, 
                    0x04
                }
            })
            Method (_PPC, 0, NotSerialized)
            {
                Return (0x00)
            }
        }
    }

    Name (\DSEN, 0x01)
    Scope (_SI)
    {
        Method (_MSG, 1, NotSerialized)
        {
            If (Arg0)
            {
                Store (One, \_SB.PCI0.LPC0.BL27)
            }
            Else
            {
                Store (Zero, \_SB.PCI0.LPC0.BL27)
            }
        }
    }

    Name (\_S0, Package (0x02)
    {
        0x00, 
        0x00
    })
    Name (\_S3, Package (0x02)
    {
        0x05, 
        0x05
    })
    Name (\_S4, Package (0x02)
    {
        0x06, 
        0x06
    })
    Name (\_S5, Package (0x02)
    {
        0x07, 
        0x07
    })
    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, \_SB.STAT)
        Store (">>>> _PTS ------------", Debug)
        Store (Arg0, Debug)
        Store (Arg0, \_SB.SLEE)
        Store (0x84, \_SB.PCI0.LPC0.BCMD)
        Store (0x00, \_SB.PCI0.LPC0.SMIC)
        If (Or (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
        {
            Store (0x01, \_SB.PCI0.LPC0.EC0.APWR)
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (0xE6, P80H)
            Store (0x80, \_SB.PCI0.LPC0.BCMD)
            Store (0x00, \_SB.PCI0.LPC0.SMIC)
            Store (0x01, \_SB.PCI0.LPC0.LV37)
            Sleep (0xC8)
            Store (0xE7, P80H)
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x01, \_SB.S4WP)
            Store (0x82, \_SB.PCI0.LPC0.BCMD)
            Store (0x00, \_SB.PCI0.LPC0.SMIC)
            Store (One, \_SB.PCI0.LPC0.EC0.PFLG)
            Store (One, \_SB.PCI0.LPC0.EC0.S4LD)
        }

        If (LEqual (SizeOf (\_OS), 0x27)) {}
        If (LEqual (Arg0, 0x05))
        {
            Store (One, \_SB.PCI0.LPC0.EC0.S5LW)
            Store (0x00, \_SB.ECOK)
        }
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (Arg0, \_SB.STAT)
        If (Or (LEqual (\_SB.PCI0.MYOS, 0x03), LEqual (\_SB.PCI0.MYOS, 0x01)))
        {
            Store (\_SB.WLES, \_SB.PCI0.LPC0.EC0.WEST)
            Store (\_SB.BTES, \_SB.PCI0.LPC0.EC0.BEST)
            Store (One, \_SB.PCI0.LPC0.EC0.WBIN)
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x01, \_SB.OKEC)
            Notify (\_SB.SLPB, 0x02)
        }

        If (LEqual (SizeOf (\_OS), 0x14))
        {
            Store (0xE4, P80H)
            Store (\_SB.PCI0.LPC0.RBID, Local0)
            Store (\_SB.PCI0.IDE0.BAYR, Local1)
            Store (Local0, \_SB.PCI0.IDE0.BAYR)
            If (LNot (LEqual (Local0, Local1)))
            {
                If (Or (LEqual (Local1, 0x01), LEqual (Local1, 0x02)))
                {
                    If (And (LEqual (\_SB.PCI0.MYOS, 0x03), LEqual (Local0, 0x03)))
                    {
                        Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x03)
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x01)
                    }
                }
            }

            If (Or (LEqual (Local0, 0x01), LEqual (Local0, 0x02)))
            {
                Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x00)
            }

            Store (0xE5, P80H)
        }

        If (LEqual (SizeOf (\_OS), 0x27)) {}
        Store (\_SB.PCI0.LPC0.EC0.ACDF, \_SB.ACST)
        If (LEqual (SizeOf (\_OS), 0x11))
        {
            Notify (\_SB.SLPB, 0x02)
        }

        Store (0x00, \_SB.SLEE)
    }

    Scope (_GPE)
    {
        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.MDM0, 0x02)
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.PCIB, 0x00)
            If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
            {
                Notify (\_SB.SLPB, 0x02)
            }
        }

        Method (_L03, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB1, 0x02)
        }

        Method (_L04, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB2, 0x02)
        }

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB3, 0x02)
        }

        Method (_E18, 0, NotSerialized)
        {
            Sleep (0x01)
        }
    }

    Scope (_SB)
    {
        Name (STAT, 0x00)
        Name (D1ST, 0x00)
        Name (D1SJ, 0x01)
        Name (OKEC, 0x00)
        Device (PCI0)
        {
            Name (MYOS, 0x02)
            Method (_INI, 0, NotSerialized)
            {
                Store (0x01, \_SB.D1SJ)
                Store (0x02, MYOS)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    Store (0x01, MYOS)
                    Store (0x07D0, OSYS)
                    Store (0x01, \_SB.W2KF)
                    If (CondRefOf (_OSI, Local0))
                    {
                        If (\_OSI ("Windows 2001"))
                        {
                            Store (0x03, MYOS)
                            Store (0x07D1, OSYS)
                            Store (0x03, \_SB.W2KF)
                        }
                    }
                }
                Else
                {
                    If (LEqual (SizeOf (\_OS), 0x11))
                    {
                        Store (0x00, MYOS)
                        Store (0x07CE, OSYS)
                        Store (0x00, \_SB.W2KF)
                    }
                    Else
                    {
                        If (LEqual (SizeOf (\_OS), 0x27))
                        {
                            Store (0x02, MYOS)
                            Store (0x07CF, OSYS)
                            Store (0x02, \_SB.W2KF)
                        }
                    }
                }
            }

            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            OperationRegion (HBUS, PCI_Config, 0x40, 0xC0)
            Field (HBUS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x18), 
                    ,   7, 
                HENA,   1, 
                    ,   4, 
                PM0H,   2, 
                Offset (0x1A), 
                PM1L,   2, 
                    ,   2, 
                PM1H,   2, 
                Offset (0x1B), 
                PM2L,   2, 
                    ,   2, 
                PM2H,   2, 
                Offset (0x1C), 
                PM3L,   2, 
                    ,   2, 
                PM3H,   2, 
                Offset (0x1D), 
                PM4L,   2, 
                    ,   2, 
                PM4H,   2, 
                Offset (0x1E), 
                PM5L,   2, 
                    ,   2, 
                PM5H,   2, 
                Offset (0x1F), 
                PM6L,   2, 
                    ,   2, 
                PM6H,   2, 
                Offset (0x20)
            }

            Name (BUF0, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100, 0x00)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,
                    0x00000000,
                    0x00000CF7,
                    0x00000000,
                    0x00000CF8, 0x00)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
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
                    0x000F0000,
                    0x000FFFFF,
                    0x00000000,
                    0x00010000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0xFEBFFFFF,
                    0x00000000,
                    0x00000000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000, 0x00)
            })
            Method (_CRS, 0, Serialized)
            {
                If (PM1L)
                {
                    CreateDWordField (BUF0, 0x80, C0LN)
                    Store (Zero, C0LN)
                }

                If (LEqual (PM1L, 0x01))
                {
                    CreateBitField (BUF0, 0x0378, C0RW)
                    Store (Zero, C0RW)
                }

                If (PM1H)
                {
                    CreateDWordField (BUF0, 0x9B, C4LN)
                    Store (Zero, C4LN)
                }

                If (LEqual (PM1H, 0x01))
                {
                    CreateBitField (BUF0, 0x0450, C4RW)
                    Store (Zero, C4RW)
                }

                If (PM2L)
                {
                    CreateDWordField (BUF0, 0xB6, C8LN)
                    Store (Zero, C8LN)
                }

                If (LEqual (PM2L, 0x01))
                {
                    CreateBitField (BUF0, 0x0528, C8RW)
                    Store (Zero, C8RW)
                }

                If (PM2H)
                {
                    CreateDWordField (BUF0, 0xD1, CCLN)
                    Store (Zero, CCLN)
                }

                If (LEqual (PM2H, 0x01))
                {
                    CreateBitField (BUF0, 0x0600, CCRW)
                    Store (Zero, CCRW)
                }

                If (PM3L)
                {
                    CreateDWordField (BUF0, 0xEC, D0LN)
                    Store (Zero, D0LN)
                }

                If (LEqual (PM3L, 0x01))
                {
                    CreateBitField (BUF0, 0x06D8, D0RW)
                    Store (Zero, D0RW)
                }

                If (PM3H)
                {
                    CreateDWordField (BUF0, 0x0107, D4LN)
                    Store (Zero, D4LN)
                }

                If (LEqual (PM3H, 0x01))
                {
                    CreateBitField (BUF0, 0x07B0, D4RW)
                    Store (Zero, D4RW)
                }

                If (PM4L)
                {
                    CreateDWordField (BUF0, 0x0122, D8LN)
                    Store (Zero, D8LN)
                }

                If (LEqual (PM4L, 0x01))
                {
                    CreateBitField (BUF0, 0x0888, D8RW)
                    Store (Zero, D8RW)
                }

                If (PM4H)
                {
                    CreateDWordField (BUF0, 0x013D, DCLN)
                    Store (Zero, DCLN)
                }

                If (LEqual (PM4H, 0x01))
                {
                    CreateBitField (BUF0, 0x0960, DCRW)
                    Store (Zero, DCRW)
                }

                If (PM5L)
                {
                    CreateDWordField (BUF0, 0x0158, E0LN)
                    Store (Zero, E0LN)
                }

                If (LEqual (PM5L, 0x01))
                {
                    CreateBitField (BUF0, 0x0A38, E0RW)
                    Store (Zero, E0RW)
                }

                If (PM5H)
                {
                    CreateDWordField (BUF0, 0x0173, E4LN)
                    Store (Zero, E4LN)
                }

                If (LEqual (PM5H, 0x01))
                {
                    CreateBitField (BUF0, 0x0B10, E4RW)
                    Store (Zero, E4RW)
                }

                If (PM6L)
                {
                    CreateDWordField (BUF0, 0x018E, E8LN)
                    Store (Zero, E8LN)
                }

                If (LEqual (PM6L, 0x01))
                {
                    CreateBitField (BUF0, 0x0BE8, E8RW)
                    Store (Zero, E8RW)
                }

                If (PM6H)
                {
                    CreateDWordField (BUF0, 0x01A9, ECLN)
                    Store (Zero, ECLN)
                }

                If (LEqual (PM6H, 0x01))
                {
                    CreateBitField (BUF0, 0x0CC0, ECRW)
                    Store (Zero, ECRW)
                }

                If (PM0H)
                {
                    CreateDWordField (BUF0, 0x01C4, F0LN)
                    Store (Zero, F0LN)
                }

                If (LEqual (PM0H, 0x01))
                {
                    CreateBitField (BUF0, 0x0D98, F0RW)
                    Store (Zero, F0RW)
                }

                CreateDWordField (BUF0, 0x01D3, M1MN)
                CreateDWordField (BUF0, 0x01D7, M1MX)
                CreateDWordField (BUF0, 0x01DF, M1LN)
                Multiply (0x02000000, \_SB.PCI0.MBUS.DRB3, M1MN)
                Add (Subtract (M1MX, M1MN), 0x01, M1LN)
                ShiftRight (And (\_SB.PCI0.LPC0.MTSE, 0x0380), 0x07, Local0)
                If (And (Local0, 0x04))
                {
                    CreateDWordField (BUF0, 0x01EE, M2MN)
                    CreateDWordField (BUF0, 0x01F2, M2MX)
                    CreateDWordField (BUF0, 0x01FA, M2LN)
                    Store (0xFED00000, M2MN)
                    Store (0xFED003FF, M2MX)
                    Store (0x0400, M2LN)
                    If (LEqual (Local0, 0x05))
                    {
                        Store (0xFED01000, M2MN)
                        Store (0xFED013FF, M2MX)
                    }

                    If (LEqual (Local0, 0x06))
                    {
                        Store (0xFED02000, M2MN)
                        Store (0xFED023FF, M2MX)
                    }

                    If (LEqual (Local0, 0x07))
                    {
                        Store (0xFED03000, M2MN)
                        Store (0xFED033FF, M2MX)
                    }
                }

                Return (BUF0)
            }

            Method (_PRT, 0, NotSerialized)
            {
                Return (Package (0x07)
                {
                    Package (0x04)
                    {
                        0x0001FFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKA, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        0x01, 
                        \_SB.PCI0.LPC0.LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        0x02, 
                        \_SB.PCI0.LPC0.LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        0x03, 
                        \_SB.PCI0.LPC0.LNKH, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKC, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        0x01, 
                        \_SB.PCI0.LPC0.LNKB, 
                        0x00
                    }
                })
            }

            Device (MBUS)
            {
                Name (_ADR, 0x01)
                OperationRegion (MBUS, PCI_Config, 0x40, 0xC0)
                Field (MBUS, DWordAcc, NoLock, Preserve)
                {
                    DRB0,   8, 
                    DRB1,   8, 
                    DRB2,   8, 
                    DRB3,   8
                }
            }

            Device (AGP)
            {
                Name (_ADR, 0x00010000)
                Name (_PRT, Package (0x01)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKA, 
                        0x00
                    }
                })
                Device (VGA)
                {
                    Name (_ADR, 0x00)
                    Name (SWIT, 0x01)
                    Name (CRTA, 0x00)
                    Name (LCDA, 0x01)
                    Name (TV0A, 0x00)
                    Name (DVIA, 0x00)
                    Name (TOGF, 0x00)
                    Name (LSTF, 0x00)
                    Name (WDAS, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_PSC, 0x00)
                    Name (USBF, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (And (Arg0, 0x03), SWIT)
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

                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Method (_DCS, 0, NotSerialized)
                        {
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

                    Device (DVI)
                    {
                        Name (_ADR, 0x0210)
                        Method (_DCS, 0, NotSerialized)
                        {
                            If (DVIA)
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
                            If (DVIA)
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
                            Store ("DVI --_DSS", Debug)
                        }
                    }

                    Device (TV0)
                    {
                        Name (_ADR, 0x0200)
                        Method (_DCS, 0, NotSerialized)
                        {
                            If (TV0A)
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
                            If (TV0A)
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
                            Store ("TV --_DSS", Debug)
                        }
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Method (_DCS, 0, NotSerialized)
                        {
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

                    Method (SWIH, 0, NotSerialized)
                    {
                        Store (0x97, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                        Store (\_SB.DATS, WDAS)
                        Store (WDAS, P80H)
                        GETD ()
                        If (LEqual (WDAS, 0x0F))
                        {
                            Increment (TOGF)
                            If (LGreater (TOGF, 0x07))
                            {
                                Store (0x01, TOGF)
                            }

                            Store (TOGF, Local1)
                            If (LEqual (Local1, 0x01))
                            {
                                Store (0x01, LCDA)
                                Store (0x00, CRTA)
                                Store (0x00, TV0A)
                                Store (0x00, DVIA)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Store (0x01, LCDA)
                                    Store (0x01, CRTA)
                                    Store (0x00, TV0A)
                                    Store (0x00, DVIA)
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x03))
                                    {
                                        Store (0x01, LCDA)
                                        Store (0x00, CRTA)
                                        Store (0x00, TV0A)
                                        Store (0x01, DVIA)
                                    }
                                    Else
                                    {
                                        If (LEqual (Local1, 0x04))
                                        {
                                            Store (0x01, LCDA)
                                            Store (0x00, CRTA)
                                            Store (0x01, TV0A)
                                            Store (0x00, DVIA)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local1, 0x05))
                                            {
                                                Store (0x00, LCDA)
                                                Store (0x01, CRTA)
                                                Store (0x00, TV0A)
                                                Store (0x00, DVIA)
                                            }
                                            Else
                                            {
                                                If (LEqual (Local1, 0x06))
                                                {
                                                    Store (0x00, LCDA)
                                                    Store (0x00, CRTA)
                                                    Store (0x00, TV0A)
                                                    Store (0x01, DVIA)
                                                }
                                                Else
                                                {
                                                    If (LEqual (Local1, 0x07))
                                                    {
                                                        Store (0x00, LCDA)
                                                        Store (0x00, CRTA)
                                                        Store (0x01, TV0A)
                                                        Store (0x00, DVIA)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        If (LEqual (WDAS, 0x0D))
                        {
                            Increment (TOGF)
                            If (LGreater (TOGF, 0x05))
                            {
                                Store (0x01, TOGF)
                            }

                            Store (TOGF, Local1)
                            If (LEqual (Local1, 0x01))
                            {
                                Store (0x01, LCDA)
                                Store (0x00, CRTA)
                                Store (0x00, TV0A)
                                Store (0x00, DVIA)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Store (0x01, LCDA)
                                    Store (0x00, CRTA)
                                    Store (0x00, TV0A)
                                    Store (0x01, DVIA)
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x03))
                                    {
                                        Store (0x01, LCDA)
                                        Store (0x00, CRTA)
                                        Store (0x01, TV0A)
                                        Store (0x00, DVIA)
                                    }
                                    Else
                                    {
                                        If (LEqual (Local1, 0x04))
                                        {
                                            Store (0x00, LCDA)
                                            Store (0x00, CRTA)
                                            Store (0x00, TV0A)
                                            Store (0x01, DVIA)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local1, 0x05))
                                            {
                                                Store (0x00, LCDA)
                                                Store (0x00, CRTA)
                                                Store (0x01, TV0A)
                                                Store (0x00, DVIA)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        If (LEqual (WDAS, 0x0B))
                        {
                            Increment (TOGF)
                            If (LGreater (TOGF, 0x05))
                            {
                                Store (0x01, TOGF)
                            }

                            Store (TOGF, Local1)
                            If (LEqual (Local1, 0x01))
                            {
                                Store (0x01, LCDA)
                                Store (0x00, CRTA)
                                Store (0x00, TV0A)
                                Store (0x00, DVIA)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Store (0x01, LCDA)
                                    Store (0x01, CRTA)
                                    Store (0x00, TV0A)
                                    Store (0x00, DVIA)
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x03))
                                    {
                                        Store (0x01, LCDA)
                                        Store (0x00, CRTA)
                                        Store (0x00, TV0A)
                                        Store (0x01, DVIA)
                                    }
                                    Else
                                    {
                                        If (LEqual (Local1, 0x04))
                                        {
                                            Store (0x00, LCDA)
                                            Store (0x01, CRTA)
                                            Store (0x00, TV0A)
                                            Store (0x00, DVIA)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local1, 0x05))
                                            {
                                                Store (0x00, LCDA)
                                                Store (0x00, CRTA)
                                                Store (0x00, TV0A)
                                                Store (0x01, DVIA)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        If (LEqual (WDAS, 0x09))
                        {
                            Increment (TOGF)
                            If (LGreater (TOGF, 0x03))
                            {
                                Store (0x01, TOGF)
                            }

                            Store (TOGF, Local1)
                            If (LEqual (Local1, 0x01))
                            {
                                Store (0x01, LCDA)
                                Store (0x00, CRTA)
                                Store (0x00, TV0A)
                                Store (0x00, DVIA)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Store (0x01, LCDA)
                                    Store (0x00, CRTA)
                                    Store (0x00, TV0A)
                                    Store (0x01, DVIA)
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x03))
                                    {
                                        Store (0x00, LCDA)
                                        Store (0x00, CRTA)
                                        Store (0x00, TV0A)
                                        Store (0x01, DVIA)
                                    }
                                }
                            }
                        }

                        If (LOr (LEqual (WDAS, 0x05), LEqual (WDAS, 0x07)))
                        {
                            Increment (TOGF)
                            If (LGreater (TOGF, 0x05))
                            {
                                Store (0x01, TOGF)
                            }

                            Store (TOGF, Local1)
                            If (LEqual (Local1, 0x01))
                            {
                                Store (0x01, LCDA)
                                Store (0x00, CRTA)
                                Store (0x00, TV0A)
                                Store (0x00, DVIA)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Store (0x01, LCDA)
                                    Store (0x01, CRTA)
                                    Store (0x00, TV0A)
                                    Store (0x00, DVIA)
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x03))
                                    {
                                        Store (0x01, LCDA)
                                        Store (0x00, CRTA)
                                        Store (0x01, TV0A)
                                        Store (0x00, DVIA)
                                    }
                                    Else
                                    {
                                        If (LEqual (Local1, 0x04))
                                        {
                                            Store (0x00, LCDA)
                                            Store (0x01, CRTA)
                                            Store (0x00, TV0A)
                                            Store (0x00, DVIA)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local1, 0x05))
                                            {
                                                Store (0x00, LCDA)
                                                Store (0x00, CRTA)
                                                Store (0x01, TV0A)
                                                Store (0x00, DVIA)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        If (LNot (LGreater (WDAS, 0x03)))
                        {
                            Increment (TOGF)
                            If (LGreater (TOGF, 0x03))
                            {
                                Store (0x01, TOGF)
                            }

                            Store (TOGF, Local1)
                            If (LEqual (Local1, 0x01))
                            {
                                Store (0x01, LCDA)
                                Store (0x00, CRTA)
                                Store (0x00, TV0A)
                                Store (0x00, DVIA)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Store (0x01, LCDA)
                                    Store (0x01, CRTA)
                                    Store (0x00, TV0A)
                                    Store (0x00, DVIA)
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x03))
                                    {
                                        Store (0x00, LCDA)
                                        Store (0x01, CRTA)
                                        Store (0x00, TV0A)
                                        Store (0x00, DVIA)
                                    }
                                }
                            }
                        }

                        Notify (\_SB.PCI0.AGP.VGA, 0x80)
                    }

                    Method (GETD, 0, NotSerialized)
                    {
                        Store (0x98, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                        Store (\_SB.DISD, Local0)
                        If (LEqual (WDAS, 0x0F))
                        {
                            If (LEqual (Local0, 0x07))
                            {
                                Store (0x07, TOGF)
                            }

                            If (LEqual (Local0, 0x06))
                            {
                                Store (0x06, TOGF)
                            }

                            If (LEqual (Local0, 0x05))
                            {
                                Store (0x05, TOGF)
                            }

                            If (LEqual (Local0, 0x04))
                            {
                                Store (0x04, TOGF)
                            }

                            If (LEqual (Local0, 0x03))
                            {
                                Store (0x03, TOGF)
                            }

                            If (LEqual (Local0, 0x02))
                            {
                                Store (0x02, TOGF)
                            }

                            If (LEqual (Local0, 0x01))
                            {
                                Store (0x01, TOGF)
                            }

                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, TOGF)
                            }
                        }

                        If (LEqual (WDAS, 0x0D))
                        {
                            If (LEqual (Local0, 0x07))
                            {
                                Store (0x05, TOGF)
                            }

                            If (LEqual (Local0, 0x06))
                            {
                                Store (0x04, TOGF)
                            }

                            If (LEqual (Local0, 0x04))
                            {
                                Store (0x03, TOGF)
                            }

                            If (LEqual (Local0, 0x03))
                            {
                                Store (0x02, TOGF)
                            }

                            If (LEqual (Local0, 0x01))
                            {
                                Store (0x01, TOGF)
                            }

                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, TOGF)
                            }
                        }

                        If (LEqual (WDAS, 0x0B))
                        {
                            If (LEqual (Local0, 0x06))
                            {
                                Store (0x05, TOGF)
                            }

                            If (LEqual (Local0, 0x05))
                            {
                                Store (0x04, TOGF)
                            }

                            If (LEqual (Local0, 0x03))
                            {
                                Store (0x03, TOGF)
                            }

                            If (LEqual (Local0, 0x02))
                            {
                                Store (0x02, TOGF)
                            }

                            If (LEqual (Local0, 0x01))
                            {
                                Store (0x01, TOGF)
                            }

                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, TOGF)
                            }
                        }

                        If (LEqual (WDAS, 0x09))
                        {
                            If (LEqual (Local0, 0x06))
                            {
                                Store (0x03, TOGF)
                            }

                            If (LEqual (Local0, 0x03))
                            {
                                Store (0x02, TOGF)
                            }

                            If (LEqual (Local0, 0x01))
                            {
                                Store (0x01, TOGF)
                            }

                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, TOGF)
                            }
                        }

                        If (LOr (LEqual (WDAS, 0x05), LEqual (WDAS, 0x07)))
                        {
                            If (LEqual (Local0, 0x07))
                            {
                                Store (0x05, TOGF)
                            }

                            If (LEqual (Local0, 0x05))
                            {
                                Store (0x04, TOGF)
                            }

                            If (LEqual (Local0, 0x04))
                            {
                                Store (0x03, TOGF)
                            }

                            If (LEqual (Local0, 0x02))
                            {
                                Store (0x02, TOGF)
                            }

                            If (LEqual (Local0, 0x01))
                            {
                                Store (0x01, TOGF)
                            }

                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, TOGF)
                            }

                            If (LEqual (TOGF, LSTF))
                            {
                                Increment (TOGF)
                            }

                            Store (TOGF, LSTF)
                        }

                        If (LNot (LGreater (WDAS, 0x03)))
                        {
                            If (LEqual (Local0, 0x05))
                            {
                                Store (0x03, TOGF)
                            }

                            If (LEqual (Local0, 0x02))
                            {
                                Store (0x02, TOGF)
                            }

                            If (LEqual (Local0, 0x01))
                            {
                                Store (0x01, TOGF)
                            }

                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, TOGF)
                            }
                        }
                    }
                }
            }

            Device (PCIB)
            {
                Name (_ADR, 0x001E0000)
                Device (GLAN)
                {
                    Name (_ADR, 0x00020000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x05
                    })
                }

                Device (MPCI)
                {
                    Name (_ADR, 0x00040000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x04
                    })
                }

                Device (T394)
                {
                    Name (_ADR, 0x00060002)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x04
                    })
                }

                Method (_PRT, 0, NotSerialized)
                {
                    Return (Package (0x06)
                    {
                        Package (0x04)
                        {
                            0x0002FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x01, 
                            \_SB.PCI0.LPC0.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKE, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x01, 
                            \_SB.PCI0.LPC0.LNKF, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x02, 
                            \_SB.PCI0.LPC0.LNKG, 
                            0x00
                        }
                    })
                }
            }

            Device (LPC0)
            {
                Name (_ADR, 0x001F0000)
                Method (DECD, 4, NotSerialized)
                {
                    Store (Arg0, Debug)
                }

                OperationRegion (REGS, PCI_Config, 0x40, 0xC0)
                Field (REGS, DWordAcc, NoLock, Preserve)
                {
                    PMBA,   16, 
                    Offset (0x18), 
                    GPBA,   16, 
                    Offset (0x90), 
                    POSD,   1, 
                    Offset (0x91), 
                    MTSE,   16, 
                    Offset (0x94), 
                    Offset (0xA0), 
                    CMAD,   3, 
                        ,   1, 
                    CMBD,   3, 
                    Offset (0xA1), 
                    LPTD,   2, 
                        ,   2, 
                    FDDD,   1, 
                    Offset (0xA6), 
                    ECO1,   1, 
                    ECO2,   1, 
                    ELPT,   1, 
                    EFDD,   1
                }

                OperationRegion (PIRX, PCI_Config, 0x60, 0x0C)
                Field (PIRX, DWordAcc, NoLock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    Offset (0x08), 
                    PIRE,   8, 
                    PIRF,   8, 
                    PIRG,   8, 
                    PIRH,   8
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IO (Decode16, 0x0050, 0x0050, 0x10, 0x04)
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IO (Decode16, 0x0050, 0x0050, 0x10, 0x04)
                        IRQNoFlags () {0}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        If (And (MTSE, 0x0200))
                        {
                            Return (BUF0)
                        }

                        Return (BUF1)
                    }
                }

                Device (IPIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x0024, 0x0024, 0x01, 0x02)
                        IO (Decode16, 0x0028, 0x0028, 0x01, 0x02)
                        IO (Decode16, 0x002C, 0x002C, 0x01, 0x02)
                        IO (Decode16, 0x0030, 0x0030, 0x01, 0x02)
                        IO (Decode16, 0x0034, 0x0034, 0x01, 0x02)
                        IO (Decode16, 0x0038, 0x0038, 0x01, 0x02)
                        IO (Decode16, 0x003C, 0x003C, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IO (Decode16, 0x00A4, 0x00A4, 0x01, 0x02)
                        IO (Decode16, 0x00A8, 0x00A8, 0x01, 0x02)
                        IO (Decode16, 0x00AC, 0x00AC, 0x01, 0x02)
                        IO (Decode16, 0x00B0, 0x00B0, 0x01, 0x02)
                        IO (Decode16, 0x00B4, 0x00B4, 0x01, 0x02)
                        IO (Decode16, 0x00B8, 0x00B8, 0x01, 0x02)
                        IO (Decode16, 0x00BC, 0x00BC, 0x01, 0x02)
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IRQNoFlags () {2}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x08)
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x08)
                        IRQNoFlags () {8}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        If (And (MTSE, 0x0200))
                        {
                            Return (BUF0)
                        }

                        Return (BUF1)
                    }
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x01)
                        IRQNoFlags () {13}
                    })
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x20)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x0090, 0x0090, 0x01, 0x02)
                        IO (Decode16, 0x0093, 0x0093, 0x01, 0x0D)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer8_16) {4}
                    })
                }

                Device (MBRD)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x1F)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0010, 0x0010, 0x01, 0x10)
                        IO (Decode16, 0x0024, 0x0024, 0x01, 0x02)
                        IO (Decode16, 0x0028, 0x0028, 0x01, 0x02)
                        IO (Decode16, 0x002C, 0x002C, 0x01, 0x02)
                        IO (Decode16, 0x164E, 0x164E, 0x01, 0x02)
                        IO (Decode16, 0x0030, 0x0030, 0x01, 0x02)
                        IO (Decode16, 0x0034, 0x0034, 0x01, 0x02)
                        IO (Decode16, 0x0038, 0x0038, 0x01, 0x02)
                        IO (Decode16, 0x003C, 0x003C, 0x01, 0x02)
                        IO (Decode16, 0x0050, 0x0050, 0x01, 0x04)
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                        IO (Decode16, 0x0063, 0x0063, 0x01, 0x01)
                        IO (Decode16, 0x0065, 0x0065, 0x01, 0x01)
                        IO (Decode16, 0x0067, 0x0067, 0x01, 0x01)
                        IO (Decode16, 0x0072, 0x0072, 0x01, 0x06)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x0090, 0x0090, 0x01, 0x10)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x00A4, 0x00A4, 0x01, 0x02)
                        IO (Decode16, 0x00A8, 0x00A8, 0x01, 0x02)
                        IO (Decode16, 0x00AC, 0x00AC, 0x01, 0x02)
                        IO (Decode16, 0x00B0, 0x00B0, 0x01, 0x06)
                        IO (Decode16, 0x00B2, 0x00B2, 0x01, 0x02)
                        IO (Decode16, 0x00B8, 0x00B8, 0x01, 0x02)
                        IO (Decode16, 0x00BC, 0x00BC, 0x01, 0x02)
                        IO (Decode16, 0x0600, 0x0600, 0x01, 0x10)
                        IO (Decode16, 0x0700, 0x0700, 0x01, 0x10)
                        IO (Decode16, 0x0800, 0x0800, 0x01, 0x10)
                        IO (Decode16, 0x1000, 0x1000, 0x01, 0x80)
                        IO (Decode16, 0x1180, 0x1180, 0x01, 0x40)
                        IO (Decode16, 0x01C0, 0x01C0, 0x01, 0x10)
                        IO (Decode16, 0x002E, 0x002E, 0x01, 0x02)
                        IO (Decode16, 0x0068, 0x0068, 0x01, 0x01)
                        IO (Decode16, 0x006C, 0x006C, 0x01, 0x01)
                        IO (Decode16, 0xFE00, 0xFE00, 0x00, 0x01)
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0x0610, 0x0610, 0x01, 0x10)
                        IO (Decode16, 0x0068, 0x0068, 0x01, 0x01)
                        IO (Decode16, 0x006C, 0x006C, 0x01, 0x01)
                        Memory32Fixed (ReadWrite, 0xFEC10000, 0x00010000)
                        Memory32Fixed (ReadOnly, 0xFF800000, 0x00400000)
                        Memory32Fixed (ReadOnly, 0xFFF00000, 0x00100000)
                        Memory32Fixed (ReadWrite, 0x00000000, 0x000A0000)
                        Memory32Fixed (ReadOnly, 0x000E0000, 0x00020000)
                        Memory32Fixed (ReadOnly, 0x000DF800, 0x00000800)
                        Memory32Fixed (ReadWrite, 0x00100000, 0x00000000)
                    })
                }

                Device (FWHD)
                {
                    Name (_HID, EisaId ("INT0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly, 0xFF800000, 0x00800000)
                    })
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (BUF0, ResourceTemplate ()
                    {
                        IRQNoFlags () {0}
                        IRQNoFlags () {8}
                        Memory32Fixed (ReadOnly, 0xFED00000, 0x00000400)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        ShiftRight (And (MTSE, 0x0380), 0x07, Local0)
                        If (LEqual (OSYS, 0x07D1))
                        {
                            If (And (Local0, 0x04))
                            {
                                Return (0x0F)
                            }
                        }
                        Else
                        {
                            If (And (Local0, 0x04))
                            {
                                Return (0x0B)
                            }
                        }

                        Return (0x00)
                    }

                    Method (_CRS, 0, Serialized)
                    {
                        ShiftRight (And (MTSE, 0x0380), 0x07, Local0)
                        If (And (Local0, 0x04))
                        {
                            CreateDWordField (BUF0, 0x0A, HPT0)
                            If (LEqual (Local0, 0x05))
                            {
                                Store (0xFED01000, HPT0)
                            }

                            If (LEqual (Local0, 0x06))
                            {
                                Store (0xFED02000, HPT0)
                            }

                            If (LEqual (Local0, 0x07))
                            {
                                Store (0xFED03000, HPT0)
                            }
                        }

                        Return (BUF0)
                    }
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRA)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {6}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLA, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRA, 0x0F), IRQ0)
                        Return (RTLA)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRA)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRA, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRB)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLB, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLB, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRB, 0x0F), IRQ0)
                        Return (RTLB)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRB)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRB, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {6}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLC, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRC, 0x0F), IRQ0)
                        Return (RTLC)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRD)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {6}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLD, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLD, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRD, 0x0F), IRQ0)
                        Return (RTLD)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRD)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRD, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRE)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLE, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLE, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRE, 0x0F), IRQ0)
                        Return (RTLE)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRE)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRE, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRF)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLF, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLF, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRF, 0x0F), IRQ0)
                        Return (RTLF)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRF)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRF, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRG)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {6}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLG, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLG, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRG, 0x0F), IRQ0)
                        Return (RTLG)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRG)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRG, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRH)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLH, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLH, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRH, 0x0F), IRQ0)
                        Return (RTLH)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRH)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRH, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                OperationRegion (GPOX, SystemIO, 0x1180, 0x40)
                Field (GPOX, DWordAcc, Lock, Preserve)
                {
                    Offset (0x07), 
                        ,   1, 
                    IO25,   1, 
                        ,   1, 
                    IO27,   1, 
                    Offset (0x0E), 
                    LV16,   1, 
                    LV17,   1, 
                    Offset (0x0F), 
                        ,   1, 
                    LV25,   1, 
                        ,   1, 
                    LV27,   1, 
                    Offset (0x1B), 
                        ,   1, 
                    BL25,   1, 
                        ,   1, 
                    BL27,   1, 
                    Offset (0x38), 
                    RBID,   2, 
                    MBTP,   3, 
                    LV37,   1, 
                    LV38,   1, 
                    LV39,   1
                }

                OperationRegion (PMIO, SystemIO, 0x1000, 0x51)
                Field (PMIO, WordAcc, Lock, Preserve)
                {
                    AccessAs (DWordAcc, 0x00), 
                    Offset (0x29), 
                        ,   3, 
                    PMES,   1, 
                    Offset (0x2B), 
                        ,   3, 
                    PMEE,   1, 
                    Offset (0x2C), 
                    GPI0,   1, 
                    GPI1,   1, 
                    GPI2,   1, 
                    GPI3,   1, 
                    GPI4,   1, 
                    GPI5,   1, 
                    GPI6,   1, 
                    GPI7,   1, 
                    GPI8,   1, 
                    GPI9,   1, 
                    GPIA,   1, 
                    GPIB,   1, 
                    GPIC,   1, 
                    GPID,   1, 
                    GPIE,   1, 
                    GPIF,   1, 
                        ,   6, 
                    GPEE,   1
                }

                Device (KBC)
                {
                    Name (_HID, EisaId ("PNP0303"))
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
                }

                Device (MOUE)
                {
                    Name (_HID, EisaId ("IBM3780"))
                    Name (_CID, 0x03102E4F)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            If (PS2F)
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }
                    }
                }

                Device (MOU2)
                {
                    Name (_HID, EisaId ("SYN1003"))
                    Name (_CID, Package (0x03)
                    {
                        0x02102E4F, 
                        0x00102E4F, 
                        0x130FD041
                    })
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            If (PS2F)
                            {
                                Store (PS2F, Local0)
                                Return (0x0F)
                            }
                            Else
                            {
                                Store (PS2F, Local0)
                                Return (0x00)
                            }
                        }
                        Else
                        {
                            Store (PS2F, Local0)
                            Return (0x00)
                        }
                    }
                }

                Device (SIO)
                {
                    Name (_HID, EisaId ("PNP0A05"))
                    OperationRegion (SIIO, SystemIO, 0x164E, 0x02)
                    Field (SIIO, ByteAcc, NoLock, Preserve)
                    {
                        INDX,   8, 
                        DATA,   8
                    }

                    Mutex (N393, 0x00)
                    Method (SETD, 1, Serialized)
                    {
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                    }

                    Method (READ, 1, Serialized)
                    {
                        Store (Arg0, INDX)
                        Store (DATA, Local0)
                        Return (Local0)
                    }

                    Method (WRIT, 2, Serialized)
                    {
                        Store (Arg0, INDX)
                        Store (Arg1, DATA)
                    }

                    Method (LDRS, 3, NotSerialized)
                    {
                        Acquire (N393, 0xFFFF)
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                        Store (Arg1, INDX)
                        Store (Arg2, DATA)
                        Release (N393)
                    }

                    Method (LDRG, 2, NotSerialized)
                    {
                        Acquire (N393, 0xFFFF)
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                        Store (Arg1, INDX)
                        Store (DATA, Local0)
                        Release (N393)
                        Return (Local0)
                    }

                    Method (RCF6, 1, NotSerialized)
                    {
                        Acquire (N393, 0xFFFF)
                        Store (0x26, INDX)
                        Store (DATA, Local0)
                        And (Local0, Arg0, Local0)
                        Release (N393)
                        Return (XOr (Local0, Arg0))
                    }

                    Method (PDRS, 2, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC0.POSD)
                        {
                            If (LEqual (Arg0, 0x00))
                            {
                                If (LEqual (Arg1, 0x03F0))
                                {
                                    Store (0x00, Local0)
                                }
                                Else
                                {
                                    If (LEqual (Arg1, 0x0370))
                                    {
                                        Store (0x01, Local0)
                                    }
                                }

                                Store (Local0, \_SB.PCI0.LPC0.FDDD)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x01))
                                {
                                    If (LEqual (Arg1, 0x0378))
                                    {
                                        Store (0x00, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg1, 0x0278))
                                        {
                                            Store (0x01, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (Arg1, 0x03BC))
                                            {
                                                Store (0x02, Local0)
                                            }
                                        }
                                    }

                                    Store (Local0, \_SB.PCI0.LPC0.LPTD)
                                }
                                Else
                                {
                                    If (LEqual (Arg1, 0x03F8))
                                    {
                                        Store (0x00, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg1, 0x02F8))
                                        {
                                            Store (0x01, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (Arg1, 0x0220))
                                            {
                                                Store (0x02, Local0)
                                            }
                                            Else
                                            {
                                                If (LEqual (Arg1, 0x0228))
                                                {
                                                    Store (0x03, Local0)
                                                }
                                                Else
                                                {
                                                    If (LEqual (Arg1, 0x0238))
                                                    {
                                                        Store (0x04, Local0)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (Arg1, 0x02E8))
                                                        {
                                                            Store (0x05, Local0)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (Arg1, 0x0338))
                                                            {
                                                                Store (0x06, Local0)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (Arg1, 0x03E8))
                                                                {
                                                                    Store (0x07, Local0)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    If (LEqual (Arg0, 0x02))
                                    {
                                        Store (Local0, \_SB.PCI0.LPC0.CMBD)
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg0, 0x03))
                                        {
                                            Store (Local0, \_SB.PCI0.LPC0.CMAD)
                                        }
                                    }
                                }
                            }

                            Return (0x01)
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

                    Device (ECP)
                    {
                        Name (_HID, EisaId ("PNP0401"))
                        Name (_UID, 0x03)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x01, 0xF0), Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LGreater (\_SB.PCI0.LPC0.MBTP, 0x01))
                            {
                                Return (0x00)
                            }

                            If (LAnd (RCF6 (0x02), LOr (LEqual (Local0, 0x04), LEqual (Local0, 0x07))))
                            {
                                ShiftLeft (LDRG (0x01, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            })
                            Store (LDRG (0x01, 0x60), Local1)
                            Store (LDRG (0x01, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x0A))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local0, Index (DCRS, 0x0C))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            Add (Local1, 0x04, Local1)
                            Store (Local1, Index (DCRS, 0x0B))
                            Store (Local1, Index (DCRS, 0x0D))
                            ShiftLeft (0x01, LDRG (0x01, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x11))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x12))
                            ShiftLeft (0x01, LDRG (0x01, 0x74), Local0)
                            Store (Local0, Index (DCRS, 0x14))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x15))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            CreateWordField (Arg0, 0x14, DMAM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            FindSetRightBit (DMAM, Local1)
                            Decrement (Local1)
                            LDRS (0x01, 0x70, Local0)
                            LDRS (0x01, 0x74, Local1)
                            LDRS (0x01, 0x60, ADRM)
                            LDRS (0x01, 0x61, ADRL)
                            LDRS (0x01, 0x30, 0x01)
                        }
                    }

                    Device (EPP)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x02)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x01, 0xF0), Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LGreater (\_SB.PCI0.LPC0.MBTP, 0x01))
                            {
                                Return (0x00)
                            }

                            If (LAnd (RCF6 (0x02), LOr (LEqual (Local0, 0x02), LEqual (Local0, 0x03))))
                            {
                                ShiftLeft (LDRG (0x01, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0178, 0x0178, 0x08, 0x08)
                                    IO (Decode16, 0x0578, 0x0578, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0178, 0x0178, 0x08, 0x08)
                                    IO (Decode16, 0x0578, 0x0578, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                IRQNoFlags () {7}
                            })
                            Store (LDRG (0x01, 0x60), Local1)
                            Store (LDRG (0x01, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x0A))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local0, Index (DCRS, 0x0C))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            Add (Local1, 0x04, Local1)
                            Store (Local1, Index (DCRS, 0x0B))
                            Store (Local1, Index (DCRS, 0x0D))
                            ShiftLeft (0x01, LDRG (0x01, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x11))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x12))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            LDRS (0x01, 0x70, Local0)
                            LDRS (0x01, 0x60, ADRM)
                            LDRS (0x01, 0x61, ADRL)
                            LDRS (0x01, 0x30, 0x01)
                        }
                    }

                    Device (LPTB)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x01, 0xF0), Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LGreater (\_SB.PCI0.LPC0.MBTP, 0x01))
                            {
                                Return (0x00)
                            }

                            If (LAnd (RCF6 (0x02), LEqual (Local0, 0x01)))
                            {
                                ShiftLeft (LDRG (0x01, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                                    IO (Decode16, 0x07BC, 0x07BC, 0x04, 0x04)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                                    IO (Decode16, 0x07BC, 0x07BC, 0x04, 0x04)
                                    IRQNoFlags () {5}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                IRQNoFlags () {7}
                            })
                            Store (LDRG (0x01, 0x60), Local1)
                            Store (LDRG (0x01, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x0A))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local0, Index (DCRS, 0x0C))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            Add (Local1, 0x04, Local1)
                            Store (Local1, Index (DCRS, 0x0B))
                            Store (Local1, Index (DCRS, 0x0D))
                            If (And (Local0, 0x04))
                            {
                                Store (0x04, Local0)
                            }
                            Else
                            {
                                Store (0x08, Local0)
                            }

                            Store (Local0, Index (DCRS, 0x06))
                            Store (Local0, Index (DCRS, 0x07))
                            Store (Local0, Index (DCRS, 0x0E))
                            Store (Local0, Index (DCRS, 0x0F))
                            ShiftLeft (0x01, LDRG (0x01, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x11))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x12))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            LDRS (0x01, 0x70, Local0)
                            LDRS (0x01, 0x60, ADRM)
                            LDRS (0x01, 0x61, ADRL)
                            LDRS (0x01, 0x30, 0x01)
                        }
                    }

                    Device (LPT)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x00)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x01, 0xF0), Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LGreater (\_SB.PCI0.LPC0.MBTP, 0x01))
                            {
                                Return (0x00)
                            }

                            If (LAnd (RCF6 (0x02), LEqual (Local0, 0x00)))
                            {
                                ShiftLeft (LDRG (0x01, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                                    IO (Decode16, 0x07BC, 0x07BC, 0x04, 0x04)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                                    IO (Decode16, 0x07BC, 0x07BC, 0x04, 0x04)
                                    IRQNoFlags () {5}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                IRQNoFlags () {7}
                            })
                            Store (LDRG (0x01, 0x60), Local1)
                            Store (LDRG (0x01, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x0A))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local0, Index (DCRS, 0x0C))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            Add (Local1, 0x04, Local1)
                            Store (Local1, Index (DCRS, 0x0B))
                            Store (Local1, Index (DCRS, 0x0D))
                            If (And (Local0, 0x04))
                            {
                                Store (0x04, Local0)
                            }
                            Else
                            {
                                Store (0x08, Local0)
                            }

                            Store (Local0, Index (DCRS, 0x06))
                            Store (Local0, Index (DCRS, 0x07))
                            Store (Local0, Index (DCRS, 0x0E))
                            Store (Local0, Index (DCRS, 0x0F))
                            ShiftLeft (0x01, LDRG (0x01, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x11))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x12))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            LDRS (0x01, 0x70, Local0)
                            LDRS (0x01, 0x60, ADRM)
                            LDRS (0x01, 0x61, ADRL)
                            LDRS (0x01, 0x30, 0x01)
                        }
                    }

                    Device (COMA)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_UID, 0x00)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LGreater (\_SB.PCI0.LPC0.MBTP, 0x01))
                            {
                                Return (0x00)
                            }

                            If (RCF6 (0x08))
                            {
                                ShiftLeft (LDRG (0x03, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x03, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x03, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
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
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x03, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            })
                            Store (LDRG (0x03, 0x60), Local1)
                            Store (LDRG (0x03, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            ShiftLeft (0x01, LDRG (0x03, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x09))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x0A))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x09, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            LDRS (0x03, 0x70, Local0)
                            LDRS (0x03, 0x60, ADRM)
                            LDRS (0x03, 0x61, ADRL)
                            LDRS (0x03, 0x30, 0x01)
                        }
                    }

                    Device (FIR)
                    {
                        Method (_HID, 0, NotSerialized)
                        {
                            If (LOr (LEqual (MYOS, 0x01), LEqual (MYOS, 0x03)))
                            {
                                Return (0x0160633A)
                            }
                            Else
                            {
                                Return (0x0160633A)
                            }
                        }

                        Name (_UID, 0x00)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x02, 0x74), Local0)
                            If (LAnd (RCF6 (0x04), LNot (LEqual (Local0, 0x04))))
                            {
                                ShiftLeft (LDRG (0x02, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x02, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x02, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x02, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            })
                            Store (LDRG (0x02, 0x60), Local1)
                            Store (LDRG (0x02, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            ShiftLeft (0x01, LDRG (0x02, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x09))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x0A))
                            ShiftLeft (0x01, LDRG (0x02, 0x74), Local0)
                            Store (Local0, Index (DCRS, 0x0C))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x0D))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x09, IRQM)
                            CreateWordField (Arg0, 0x0C, DMAM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            FindSetRightBit (DMAM, Local1)
                            Decrement (Local1)
                            LDRS (0x02, 0x70, Local0)
                            LDRS (0x02, 0x74, Local1)
                            LDRS (0x02, 0x60, ADRM)
                            LDRS (0x02, 0x61, ADRL)
                            PDRS (0x02, Add (ShiftLeft (ADRM, 0x08), ADRL))
                            LDRS (0x02, 0x30, 0x01)
                        }
                    }
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x1D)
                    Name (OSEJ, 0x00)
                    Device (SMBC)
                    {
                        Name (_HID, "ACPI0001")
                        Name (_EC, 0x1820)
                        Device (SBS0)
                        {
                            Name (_HID, "ACPI0002")
                            Name (_SBS, 0x02)
                        }
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, \_SB.OKEC)
                            Store (Arg1, \_SB.ECOK)
                            If (Or (LEqual (\_SB.PCI0.MYOS, 0x03), LEqual (\_SB.PCI0.MYOS, 0x01)))
                            {
                                If (Arg1)
                                {
                                    Store (0x01, \_SB.PCI0.LPC0.EC0.RG57)
                                }

                                Store (\_SB.WLES, \_SB.PCI0.LPC0.EC0.WEST)
                                Store (\_SB.BTES, \_SB.PCI0.LPC0.EC0.BEST)
                                Store (One, \_SB.PCI0.LPC0.EC0.WBIN)
                                Store (DOFF, \_SB.PCI0.LPC0.EC0.TMOF)
                            }
                        }
                    }

                    OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x04), 
                        CMCM,   8, 
                        CMD1,   8, 
                        CMD2,   8, 
                        CMD3,   8, 
                        Offset (0x18), 
                        SMPR,   8, 
                        SMST,   8, 
                        SMAD,   8, 
                        SMCM,   8, 
                        SMD0,   256, 
                        BCNT,   8, 
                        SMAA,   8, 
                        BATD,   16, 
                        ACDF,   1, 
                        Offset (0x41), 
                            ,   4, 
                        FPR1,   1, 
                        S4LD,   1, 
                        S5LW,   1, 
                        PFLG,   1, 
                        Offset (0x43), 
                        TMSS,   2, 
                            ,   2, 
                        BANK,   4, 
                        Offset (0x45), 
                        VFAN,   1, 
                        Offset (0x46), 
                        RL01,   1, 
                        RD01,   1, 
                        RF01,   1, 
                        RP01,   1, 
                        RB01,   1, 
                        RC01,   1, 
                            ,   1, 
                        R701,   1, 
                        R801,   1, 
                        RM01,   1, 
                        RI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        RA01,   1, 
                        RR01,   1, 
                        RL10,   1, 
                        RD10,   1, 
                        RF10,   1, 
                        RP10,   1, 
                        RB10,   1, 
                        RC10,   1, 
                            ,   1, 
                        R710,   1, 
                        R810,   1, 
                        RM10,   1, 
                        RI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        RA10,   1, 
                        RR10,   1, 
                        LIDE,   1, 
                        DB2E,   1, 
                        RPTE,   1, 
                        WP01,   1, 
                        WB01,   1, 
                        WC01,   1, 
                            ,   1, 
                        W701,   1, 
                        W801,   1, 
                        WM01,   1, 
                        WI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA01,   1, 
                        WR01,   1, 
                        LIDS,   1, 
                        DB2S,   1, 
                        RPTS,   1, 
                        WP10,   1, 
                        WB10,   1, 
                        WC10,   1, 
                            ,   1, 
                        W710,   1, 
                        W810,   1, 
                        WM10,   1, 
                        WI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA10,   1, 
                        WR10,   1, 
                            ,   1, 
                        BAYE,   1, 
                        EFDE,   1, 
                        PRDE,   1, 
                        BRBE,   1, 
                        ADIM,   1, 
                            ,   1, 
                        W7BE,   1, 
                        W8BE,   1, 
                        PMEE,   1, 
                        INTE,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        DB3E,   1, 
                        Offset (0x52), 
                            ,   1, 
                        BAYS,   1, 
                        EFDS,   1, 
                        PRDS,   1, 
                        BRBS,   1, 
                        CRTS,   1, 
                            ,   1, 
                        W7BS,   1, 
                        TMOF,   8, 
                        Offset (0x57), 
                        RG57,   8, 
                        CTMP,   8, 
                        RG59,   8, 
                        RG5A,   8, 
                        RG5B,   8, 
                        FSPD,   16, 
                        Offset (0x5F), 
                        WEST,   1, 
                        BEST,   1, 
                        WBIN,   1, 
                        Offset (0x60), 
                            ,   1, 
                        FANC,   1, 
                        Offset (0x70), 
                        MBID,   8, 
                        MBTS,   1, 
                        MBTF,   1, 
                        Offset (0x72), 
                        MBTC,   1, 
                        Offset (0x77), 
                        BA1C,   8, 
                        MBVG,   16, 
                        MCUR,   16, 
                        Offset (0x80), 
                        SBID,   8, 
                        SBTS,   1, 
                        SBTF,   1, 
                        Offset (0x82), 
                        SBTC,   1, 
                        Offset (0x87), 
                        BA2C,   8, 
                        ABVG,   16, 
                        ACUR,   16, 
                        Offset (0xC3), 
                        MBRM,   16, 
                        Offset (0xCA), 
                        ABRM,   16, 
                        Offset (0xD0), 
                        EBPL,   1, 
                        Offset (0xD2), 
                            ,   6, 
                        APWR,   1, 
                        Offset (0xD6), 
                        DBPL,   8, 
                        Offset (0xE7), 
                        GQKS,   7
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        SMW0,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        SMB0,   8
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD0,   64
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD1,   128
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD2,   192
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD3,   256
                    }

                    Method (BPOL, 1, NotSerialized)
                    {
                        Store (Arg0, DBPL)
                        Store (0x01, EBPL)
                    }

                    Name (ECUS, 0x00)
                    Name (BATO, 0x00)
                    Name (BATN, 0x00)
                    Name (BATF, 0xC0)
                    Method (_Q09, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14)) {}
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            BPOL (0x3C)
                        }
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        If (And (SMST, 0x40))
                        {
                            Store (SMAA, Local0)
                            If (LEqual (Local0, 0x14))
                            {
                                And (SMST, 0xBF, SMST)
                            }
                        }
                    }

                    Method (SELE, 0, NotSerialized)
                    {
                        Store (BATD, BATN)
                        Store (0x00, BATF)
                        If (And (0xC0, BATN))
                        {
                            Or (BATF, 0x01, BATF)
                        }

                        If (And (0x0300, BATN))
                        {
                            Or (BATF, 0x04, BATF)
                        }

                        And (BATN, 0x01, Local0)
                        And (BATO, 0x01, Local1)
                        If (Local0)
                        {
                            Or (BATF, 0x0100, BATF)
                        }
                        Else
                        {
                            And (BATF, 0xFEFF, BATF)
                        }

                        If (Not (LEqual (Local0, Local1)))
                        {
                            Or (BATF, 0x40, BATF)
                        }

                        And (BATN, 0x02, Local0)
                        And (BATO, 0x02, Local1)
                        If (Local0)
                        {
                            Or (BATF, 0x0200, BATF)
                        }
                        Else
                        {
                            And (BATF, 0xFDFF, BATF)
                        }

                        If (Not (LEqual (Local0, Local1)))
                        {
                            Or (BATF, 0x80, BATF)
                        }

                        And (BATN, 0xC0, Local0)
                        And (BATO, 0xC0, Local1)
                        If (Not (LEqual (Local0, Local1)))
                        {
                            Or (BATF, 0x02, BATF)
                        }

                        If (And (0x01, BATF))
                        {
                            If (And (0x04, BATF))
                            {
                                If (And (BATN, 0x20))
                                {
                                    Or (BATF, 0x10, BATF)
                                }
                                Else
                                {
                                    Or (BATF, 0x20, BATF)
                                }
                            }
                        }
                    }

                    Method (_Q0D, 0, NotSerialized)
                    {
                        Store ("Sleep Button Query: Fn+F4", Debug)
                        Notify (\_SB.SLPB, 0x80)
                    }

                    Method (_Q0E, 0, NotSerialized)
                    {
                        \_SB.PCI0.AGP.VGA.SWIH ()
                    }

                    Method (_Q13, 0, NotSerialized)
                    {
                        Store ("Brightness Up: Fn+->", Debug)
                        Store (0x8C, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                    }

                    Method (_Q12, 0, NotSerialized)
                    {
                        Store ("Brightness Down: Fn+<-", Debug)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                    }

                    Method (_Q80, 0, NotSerialized)
                    {
                        Store ("Temperature increasing: _Q80", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Method (_Q81, 0, NotSerialized)
                    {
                        Store ("Temperature decreasing: _Q81", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Event (EJT1)
                    Method (_Q8A, 0, NotSerialized)
                    {
                        Mutex (MUT0, 0x00)
                        Mutex (MUT1, 0x00)
                        Store ("------------------_Q0x8A --------------------------------------", Debug)
                        If (LIDE)
                        {
                            Store (0x01, LIDE)
                            Notify (\_SB.LID, 0x80)
                        }

                        If (DB2E)
                        {
                            Store ("-------- Device R-Bay Event ------", Debug)
                            Store (0x01, DB2E)
                            Store (0xB1, P80H)
                            If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                            {
                                If (DB2S)
                                {
                                    Store (0xB2, P80H)
                                    Store ("----------- Device Bay Change Status ---------- IN ", Debug)
                                    Store (\_SB.PCI0.LPC0.RBID, Local0)
                                    Store (Local0, \_SB.PCI0.IDE0.BAYR)
                                    If (LEqual (Local0, 0x00))
                                    {
                                        Store (0xB4, P80H)
                                        Store (0x00, \_SB.PCI0.LPC0.LV37)
                                        Sleep (0xC8)
                                    }
                                    Else
                                    {
                                        Store (0xB5, P80H)
                                        Store (0x00, \_SB.PCI0.LPC0.LV37)
                                        Sleep (0x64)
                                        Store (0x00, \_SB.PCI0.LPC0.LV39)
                                        Sleep (0xC8)
                                        Store (0x01, \_SB.PCI0.LPC0.LV39)
                                        Sleep (0x09C4)
                                        Sleep (0xC8)
                                        Sleep (0xC8)
                                        Sleep (0x64)
                                        Store (0x01, \_SB.PCI0.IDE0.SSIG)
                                        Store (0x01, \_SB.PCI0.IDE0.UDC1)
                                        Store (0x02, \_SB.PCI0.IDE0.UDT1)
                                        Or (\_SB.PCI0.IDE0.FSCB, 0x04, \_SB.PCI0.IDE0.FSCB)
                                        Store (0xE303, \_SB.PCI0.IDE0.ITM1)
                                        Store (0x00, \_SB.PCI0.IDE0.SSIG)
                                        Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x00)
                                        Store (0xB6, P80H)
                                    }
                                }
                                Else
                                {
                                    Store (0xB7, P80H)
                                    Store ("-------- Device Bay Event ------ OUT ", Debug)
                                    Store (\_SB.PCI0.IDE0.BAYR, Local0)
                                    Store (0x01, \_SB.PCI0.LPC0.LV37)
                                    Sleep (0xC8)
                                    If (Or (LEqual (Local0, 0x01), LEqual (Local0, 0x02)))
                                    {
                                        Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x01)
                                        Store (0xB8, P80H)
                                    }
                                }
                            }
                        }
                    }
                }

                OperationRegion (SMI0, SystemIO, 0x0000FE00, 0x00000002)
                Field (SMI0, AnyAcc, NoLock, Preserve)
                {
                    SMIC,   8
                }

                OperationRegion (SMI1, SystemMemory, 0x1FEFCEBD, 0x00000090)
                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    BCMD,   8, 
                    DID,    32, 
                    INFO,   1024
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    Offset (0x05), 
                    INF,    8
                }
            }

            Device (MDM0)
            {
                Name (_ADR, 0x001F0006)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x03
                })
            }

            Device (IDE0)
            {
                Name (_ADR, 0x001F0001)
                OperationRegion (PCI, PCI_Config, 0x00, 0x58)
                Field (PCI, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                        ,   7, 
                    SIDE,   1, 
                    Offset (0x42), 
                        ,   1, 
                    EIOR,   1, 
                        ,   13, 
                    ESID,   1, 
                    Offset (0x48), 
                    UMA0,   1, 
                    UMA1,   1, 
                    UMA2,   1, 
                    UMA3,   1, 
                    Offset (0x56), 
                    PSIG,   2, 
                    SSIG,   2
                }

                Field (PCI, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x40), 
                    ITM0,   16, 
                    ITM1,   16, 
                    SIT0,   4, 
                    SIT1,   4, 
                    Offset (0x48), 
                    UDC0,   2, 
                    UDC1,   2, 
                    Offset (0x4A), 
                    UDT0,   8, 
                    UDT1,   8, 
                    Offset (0x54), 
                    ICF0,   2, 
                    ICF1,   2, 
                    CB80,   4, 
                        ,   2, 
                    WPPE,   1, 
                        ,   1, 
                    FSCB,   4, 
                    TRIP,   2, 
                    TRIS,   2, 
                    FATS,   4
                }

                Name (TIM0, Package (0x01)
                {
                    Package (0x05)
                    {
                        0x78, 
                        0xB4, 
                        0xF0, 
                        0x0186, 
                        0x0258
                    }
                })
                Name (TIM1, Package (0x01)
                {
                    Package (0x03)
                    {
                        0x78, 
                        0x96, 
                        0x01FE
                    }
                })
                Name (TIM2, Package (0x01)
                {
                    Package (0x06)
                    {
                        0x18, 
                        0x1E, 
                        0x2D, 
                        0x3C, 
                        0x5A, 
                        0x78
                    }
                })
                Name (AT01, Buffer (0x07)
                {
                    0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEF
                })
                Name (AT02, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90
                })
                Name (AT03, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC6
                })
                Name (AT04, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x91
                })
                Name (ATA0, Buffer (0x1D) {})
                Name (ATA1, Buffer (0x1D) {})
                Name (ATA2, Buffer (0x1D) {})
                Name (ATA3, Buffer (0x1D) {})
                Name (ATAB, Buffer (0x0E) {})
                Name (CMDC, 0x00)
                Name (BAYR, 0x00)
                Method (_INI, 0, NotSerialized)
                {
                    Store (\_SB.PCI0.LPC0.RBID, BAYR)
                }

                Method (GTFB, 3, Serialized)
                {
                    Multiply (CMDC, 0x38, Local0)
                    CreateField (ATAB, Local0, 0x38, CMDX)
                    Multiply (CMDC, 0x07, Local0)
                    CreateByteField (ATAB, Add (Local0, 0x01), A001)
                    CreateByteField (ATAB, Add (Local0, 0x05), A005)
                    Store (Arg0, CMDX)
                    Store (Arg1, A001)
                    Store (Arg2, A005)
                    Increment (CMDC)
                }

                Mutex (GTFM, 0x00)
                Method (GTF, 3, Serialized)
                {
                    Acquire (GTFM, 0xFFFF)
                    CreateDWordField (Arg2, 0x00, PIO0)
                    CreateDWordField (Arg2, 0x04, DMA0)
                    CreateDWordField (Arg2, 0x08, PIO1)
                    CreateDWordField (Arg2, 0x0C, DMA1)
                    CreateDWordField (Arg2, 0x10, CHNF)
                    Store (0x00, CMDC)
                    Name (ID00, 0x80)
                    Name (ID49, 0x0C00)
                    Name (ID59, 0x00)
                    Name (ID53, 0x04)
                    Name (ID63, 0x0F00)
                    Name (ID88, 0x0F00)
                    Name (IRDY, 0x01)
                    Name (PIOT, 0x00)
                    Name (DMAT, 0x00)
                    If (LEqual (SizeOf (Arg1), 0x0200))
                    {
                        CreateByteField (Arg1, 0x00, IB00)
                        Store (IB00, ID00)
                        CreateWordField (Arg1, 0x62, IW49)
                        Store (IW49, ID49)
                        CreateWordField (Arg1, 0x6A, IW53)
                        Store (IW53, ID53)
                        CreateWordField (Arg1, 0x7E, IW63)
                        Store (IW63, ID63)
                        CreateWordField (Arg1, 0x76, IW59)
                        Store (IW59, ID59)
                        CreateWordField (Arg1, 0xB0, IW88)
                        Store (IW88, ID88)
                    }
                    Else
                    {
                        Return (ATAB)
                    }

                    Store (0xA0, Local7)
                    If (Arg0)
                    {
                        Store (0xB0, Local7)
                        And (CHNF, 0x08, IRDY)
                        If (And (CHNF, 0x10))
                        {
                            Store (PIO1, PIOT)
                        }
                        Else
                        {
                            Store (PIO0, PIOT)
                        }

                        If (And (CHNF, 0x04))
                        {
                            If (And (CHNF, 0x10))
                            {
                                Store (DMA1, DMAT)
                            }
                            Else
                            {
                                Store (DMA0, DMAT)
                            }
                        }
                    }
                    Else
                    {
                        And (CHNF, 0x02, IRDY)
                        Store (PIO0, PIOT)
                        If (And (CHNF, 0x01))
                        {
                            Store (DMA0, DMAT)
                        }
                    }

                    If (LAnd (And (ID53, 0x04), And (ID88, 0xFF)))
                    {
                        Store (0x00, Local1)
                        And (ID88, 0xFF, Local2)
                        While (ShiftRight (Local2, Local1))
                        {
                            Increment (Local1)
                        }

                        Decrement (Local1)
                        GTFB (AT01, Or (0x40, Local1), Local7)
                    }

                    If (IRDY)
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIOT, MTR, 0x00, 0x00), Local1)
                        If (LEqual (Local1, Ones))
                        {
                            Store (0x04, Local1)
                        }

                        Subtract (0x04, Local1, Local1)
                        GTFB (AT01, Or (0x08, Local1), Local7)
                    }
                    Else
                    {
                        If (And (ID49, 0x0400))
                        {
                            GTFB (AT01, 0x01, Local7)
                        }
                    }

                    Release (GTFM)
                    Return (ATAB)
                }

                Method (RATA, 1, NotSerialized)
                {
                    CreateByteField (Arg0, 0x00, CMDN)
                    Multiply (CMDN, 0x38, Local0)
                    CreateField (Arg0, 0x08, Local0, RETB)
                    Return (RETB)
                }

                Name (REGF, 0x01)
                Method (_REG, 2, NotSerialized)
                {
                    If (LEqual (Arg0, 0x02))
                    {
                        Store (Arg1, REGF)
                    }
                }

                Name (BAYD, 0x00)
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0F)
                }

                Method (GTM, 6, NotSerialized)
                {
                    Store (Buffer (0x14) {}, Local0)
                    CreateDWordField (Local0, 0x00, PIO0)
                    CreateDWordField (Local0, 0x04, DMA0)
                    CreateDWordField (Local0, 0x08, PIO1)
                    CreateDWordField (Local0, 0x0C, DMA1)
                    CreateDWordField (Local0, 0x10, FLAG)
                    If (LOr (And (Arg0, 0x08), LNot (And (Arg0, 0x01))))
                    {
                        Store (0x0384, PIO0)
                    }
                    Else
                    {
                        Add (ShiftRight (And (Arg0, 0x0300), 0x08), ShiftRight (And (Arg0, 0x3000), 0x0C), Local1)
                        Multiply (Subtract (0x09, Local1), 0x1E, PIO0)
                    }

                    If (And (Arg0, 0x4000))
                    {
                        If (LOr (And (Arg0, 0x80), LNot (And (Arg0, 0x10))))
                        {
                            Store (0x0384, PIO1)
                        }
                        Else
                        {
                            Add (And (Arg1, 0x03), ShiftRight (And (Arg1, 0x0C), 0x02), Local1)
                            Multiply (Subtract (0x09, Local1), 0x1E, PIO1)
                        }
                    }
                    Else
                    {
                        Store (PIO0, PIO1)
                    }

                    If (And (Arg2, 0x01))
                    {
                        If (And (Arg5, 0x01))
                        {
                            Store (0x08, DMA0)
                        }
                        Else
                        {
                            Subtract (0x04, And (Arg3, 0x03), Local1)
                            If (And (Arg4, 0x01))
                            {
                                Multiply (Local1, 0x0F, DMA0)
                            }
                            Else
                            {
                                Multiply (Local1, 0x1E, DMA0)
                            }
                        }
                    }
                    Else
                    {
                        Store (PIO0, DMA0)
                    }

                    If (And (Arg0, 0x4000))
                    {
                        If (And (Arg2, 0x02))
                        {
                            If (And (Arg5, 0x02))
                            {
                                Store (0x08, DMA1)
                            }
                            Else
                            {
                                Subtract (0x04, ShiftRight (And (Arg3, 0x30), 0x04), Local1)
                                If (And (Arg4, 0x02))
                                {
                                    Multiply (Local1, 0x0F, DMA1)
                                }
                                Else
                                {
                                    Multiply (Local1, 0x1E, DMA1)
                                }
                            }
                        }
                        Else
                        {
                            Store (PIO1, DMA1)
                        }
                    }
                    Else
                    {
                        Store (DMA0, DMA1)
                    }

                    Store (Zero, FLAG)
                    If (And (Arg0, 0x01))
                    {
                        Or (FLAG, 0x10, FLAG)
                    }

                    If (And (Arg2, 0x01))
                    {
                        Or (FLAG, 0x01, FLAG)
                    }

                    If (And (Arg0, 0x02))
                    {
                        Or (FLAG, 0x02, FLAG)
                    }

                    If (And (Arg2, 0x02))
                    {
                        Or (FLAG, 0x04, FLAG)
                    }

                    If (And (Arg0, 0x20))
                    {
                        Or (FLAG, 0x08, FLAG)
                    }

                    Return (Local0)
                }

                Method (STMS, 3, NotSerialized)
                {
                    Store (Buffer (0x18) {}, Local7)
                    CreateDWordField (Local7, 0x00, ITM)
                    CreateDWordField (Local7, 0x04, SIT)
                    CreateDWordField (Local7, 0x08, UDC)
                    CreateDWordField (Local7, 0x0C, UDT)
                    CreateDWordField (Local7, 0x10, ICF)
                    CreateDWordField (Local7, 0x14, A100)
                    Store (0x01, WPPE)
                    CreateDWordField (Arg0, 0x00, PIO0)
                    CreateDWordField (Arg0, 0x04, DMA0)
                    CreateDWordField (Arg0, 0x08, PIO1)
                    CreateDWordField (Arg0, 0x0C, DMA1)
                    CreateDWordField (Arg0, 0x10, FLAG)
                    Store (FLAG, Local4)
                    Store (0x4000, Local0)
                    Name (W49M, 0x00)
                    Name (W53M, 0x00)
                    Name (W62M, 0x00)
                    Name (W64M, 0x00)
                    Name (W88M, 0x00)
                    If (LEqual (SizeOf (Arg1), 0x0200))
                    {
                        CreateDWordField (Arg1, 0x00, W00A)
                        CreateDWordField (Arg1, 0x62, W49A)
                        CreateDWordField (Arg1, 0x6A, W53A)
                        CreateDWordField (Arg1, 0x7C, W62A)
                        CreateDWordField (Arg1, 0x80, W64A)
                        CreateDWordField (Arg1, 0xB0, W88A)
                        Store (W49A, W49M)
                        Store (W53A, W53M)
                        Store (W62A, W62M)
                        Store (W64A, W64M)
                        Store (W88A, W88M)
                        If (W00A)
                        {
                            Or (Local0, 0x8000, Local0)
                        }

                        If (LNot (And (W00A, 0x80)))
                        {
                            Or (Local0, 0x04, Local0)
                        }
                    }
                    Else
                    {
                        Store (0x00, W49M)
                        Store (0x00, W53M)
                        Store (0x00, W62M)
                        Store (0x00, W64M)
                        Store (0x00, W88M)
                    }

                    Name (W49S, 0x00)
                    Name (W53S, 0x00)
                    Name (W62S, 0x00)
                    Name (W64S, 0x00)
                    Name (W88S, 0x00)
                    If (LEqual (SizeOf (Arg2), 0x0200))
                    {
                        CreateDWordField (Arg2, 0x00, W00B)
                        CreateDWordField (Arg2, 0x62, W49B)
                        CreateDWordField (Arg2, 0x6A, W53B)
                        CreateDWordField (Arg2, 0x7C, W62B)
                        CreateDWordField (Arg2, 0x80, W64B)
                        CreateDWordField (Arg2, 0xB0, W88B)
                        Store (W49B, W49S)
                        Store (W53B, W53S)
                        Store (W62B, W62S)
                        Store (W64B, W64S)
                        Store (W88B, W88S)
                        If (W00B)
                        {
                            Or (Local0, 0x8000, Local0)
                        }

                        If (LNot (And (W00B, 0x80)))
                        {
                            Or (Local0, 0x40, Local0)
                        }
                    }
                    Else
                    {
                        Store (0x00, W49S)
                        Store (0x00, W53S)
                        Store (0x00, W62S)
                        Store (0x00, W64S)
                        Store (0x00, W88S)
                    }

                    Store (0x00, A100)
                    If (And (0x38, W88M))
                    {
                        If (And (0x20, W88M))
                        {
                            Store (0x08, DMA0)
                            Or (A100, 0x00100010, A100)
                        }
                        Else
                        {
                            If (And (0x10, W88M))
                            {
                                Store (0x1E, DMA0)
                                Or (A100, 0x10, A100)
                            }
                            Else
                            {
                                Store (0x2D, DMA0)
                            }
                        }
                    }
                    Else
                    {
                        If (And (0x07, W88M))
                        {
                            Or (0x0100, A100, A100)
                            If (And (0x04, W88M))
                            {
                                Store (0x3C, DMA0)
                            }
                            Else
                            {
                                If (And (0x02, W88M))
                                {
                                    Store (0x5A, DMA0)
                                }
                                Else
                                {
                                    Store (0x78, DMA0)
                                }
                            }
                        }
                    }

                    If (And (0x3F, W88S))
                    {
                        If (And (0x20, W88S))
                        {
                            Store (0x08, DMA1)
                            Or (A100, 0x00200020, A100)
                        }
                        Else
                        {
                            If (And (0x10, W88S))
                            {
                                Store (0x1E, DMA1)
                                Or (A100, 0x20, A100)
                            }
                            Else
                            {
                                Store (0x2D, DMA1)
                            }
                        }
                    }

                    If (LAnd (And (W49M, 0x0800), And (Local4, 0x02)))
                    {
                        Or (Local0, 0x02, Local0)
                    }

                    If (LLess (PIO0, 0x0384))
                    {
                        Or (Local0, 0x01, Local0)
                    }

                    If (LAnd (And (W49S, 0x0800), And (Local4, 0x08)))
                    {
                        Or (Local0, 0x20, Local0)
                    }

                    If (LLess (PIO1, 0x0384))
                    {
                        Or (Local0, 0x10, Local0)
                    }

                    If (And (Local4, 0x01))
                    {
                        Store (PIO0, Local1)
                    }
                    Else
                    {
                        Store (DMA0, Local1)
                    }

                    If (LNot (LLess (Local1, 0xF0)))
                    {
                        Or (Local0, 0x08, Local0)
                    }
                    Else
                    {
                        If (And (W53M, 0x02))
                        {
                            If (LAnd (And (W64M, 0x02), LNot (LGreater (Local1, 0x78))))
                            {
                                Or (Local0, 0x2301, Local0)
                            }
                            Else
                            {
                                If (LAnd (And (W64M, 0x01), LNot (LGreater (Local1, 0xB4))))
                                {
                                    Or (Local0, 0x2101, Local0)
                                }
                            }
                        }
                        Else
                        {
                            Or (Local0, 0x1001, Local0)
                        }
                    }

                    Store (Local0, ITM)
                    Store (Zero, Local0)
                    If (And (Local4, 0x04))
                    {
                        Store (PIO1, Local1)
                    }
                    Else
                    {
                        Store (DMA1, Local1)
                    }

                    If (And (Local4, 0x10))
                    {
                        If (LNot (LLess (Local1, 0xF0)))
                        {
                            Or (0x80, ITM, ITM)
                        }
                        Else
                        {
                            Or (0x10, ITM, ITM)
                            If (And (W53S, 0x02))
                            {
                                If (LAnd (And (W64S, 0x02), LNot (LGreater (Local1, 0x78))))
                                {
                                    Store (0x0B, Local0)
                                }
                                Else
                                {
                                    If (LAnd (And (W64S, 0x01), LNot (LGreater (Local1, 0xB4))))
                                    {
                                        Store (0x09, Local0)
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x04, Local0)
                            }
                        }
                    }

                    Store (Local0, SIT)
                    Store (0x00, Local0)
                    If (LAnd (And (0x3F, W88M), And (Local4, 0x01)))
                    {
                        Or (Local0, 0x01, Local0)
                    }

                    If (And (Local4, 0x04))
                    {
                        Or (Local0, 0x02, Local0)
                    }

                    Store (Local0, UDC)
                    Store (0x00, Local0)
                    If (And (Local4, 0x01))
                    {
                        If (LLess (DMA0, 0x1E))
                        {
                            Or (A100, 0x1000, A100)
                            Or (Local0, 0x01, Local0)
                        }
                        Else
                        {
                            If (LLess (DMA0, 0x3C))
                            {
                                Divide (DMA0, 0x0F, , Local1)
                            }
                            Else
                            {
                                Divide (DMA0, 0x1E, , Local1)
                            }

                            Subtract (0x04, Local1, Local0)
                        }
                    }

                    If (And (Local4, 0x04))
                    {
                        If (LLess (DMA1, 0x1E))
                        {
                            Or (A100, 0x2000, A100)
                            Or (Local0, 0x10, Local0)
                        }
                        Else
                        {
                            If (LLess (DMA1, 0x3C))
                            {
                                Divide (DMA1, 0x0F, , Local1)
                            }
                            Else
                            {
                                Divide (DMA1, 0x1E, , Local1)
                            }

                            Subtract (0x04, Local1, Local1)
                            ShiftLeft (Local1, 0x04, Local1)
                            Or (Local0, Local1, Local0)
                        }
                    }

                    Store (Local0, UDT)
                    Store (0x00, Local0)
                    If (LLess (DMA0, 0x3C))
                    {
                        Or (Local0, 0x01, Local0)
                    }

                    If (LLess (DMA1, 0x3C))
                    {
                        Or (Local0, 0x02, Local0)
                    }

                    Store (Local0, ICF)
                    Return (Local7)
                }

                Method (GTF0, 7, NotSerialized)
                {
                    Store (Buffer (0x07)
                        {
                            0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                        }, Local7)
                    CreateByteField (Local7, 0x01, MODE)
                    If (And (Arg2, 0x01))
                    {
                        If (And (Arg6, 0x01))
                        {
                            Store (0x45, MODE)
                        }
                        Else
                        {
                            And (Arg3, 0x03, Local0)
                            If (And (Arg4, 0x01))
                            {
                                Add (Local0, 0x02, Local0)
                            }

                            Or (Local0, 0x40, MODE)
                        }
                    }
                    Else
                    {
                        Add (ShiftRight (And (Arg0, 0x0300), 0x08), ShiftRight (And (Arg0, 0x3000), 0x0C), Local0)
                        If (LNot (LLess (Local0, 0x05)))
                        {
                            Store (0x22, MODE)
                        }
                        Else
                        {
                            If (LNot (LLess (Local0, 0x03)))
                            {
                                Store (0x21, MODE)
                            }
                            Else
                            {
                                Store (0x20, MODE)
                            }
                        }
                    }

                    Concatenate (Local7, Local7, Local6)
                    If (LOr (And (Arg0, 0x08), LNot (And (Arg0, 0x01))))
                    {
                        If (And (Arg0, 0x02))
                        {
                            Store (0x00, MODE)
                        }
                        Else
                        {
                            Store (0x08, MODE)
                        }
                    }
                    Else
                    {
                        Add (ShiftRight (And (Arg0, 0x0300), 0x08), ShiftRight (And (Arg0, 0x3000), 0x0C), Local0)
                        If (LNot (LLess (Local0, 0x05)))
                        {
                            Store (0x0C, MODE)
                        }
                        Else
                        {
                            If (LNot (LLess (Local0, 0x03)))
                            {
                                Store (0x0B, MODE)
                            }
                            Else
                            {
                                Store (0x0A, MODE)
                            }
                        }
                    }

                    Concatenate (Local6, Local7, Local5)
                    Return (Local5)
                }

                Name (B04, Buffer (0x04) {})
                Name (B20, Buffer (0x04) {})
                Name (B40, Buffer (0x04) {})
                Device (PRIM)
                {
                    Name (_ADR, 0x00)
                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (Buffer (0x14)
                            {
                                0x00
                            }, Local0)
                        Store (^^GTM (^^ITM0, ^^SIT0, ^^UDC0, ^^UDT0, ^^ICF0, ^^FSCB), Local0)
                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (GTF (0x00, Arg1, Arg0), ATA0)
                        Store (GTF (0x01, Arg2, Arg0), ATA1)
                        Store (^^STMS (Arg0, Arg1, Arg2), Local0)
                        CreateDWordField (Local0, 0x00, ITM)
                        CreateDWordField (Local0, 0x04, SIT)
                        CreateDWordField (Local0, 0x08, UDC)
                        CreateDWordField (Local0, 0x0C, UDT)
                        CreateDWordField (Local0, 0x10, ICF)
                        Store (ITM, ^^ITM0)
                        Store (SIT, ^^SIT0)
                        Store (UDC, ^^UDC0)
                        Store (UDT, ^^UDT0)
                        CreateDWordField (Local0, 0x14, A100)
                        Or (And (^^CB80, 0x0C), ShiftRight (And (0x30, A100), 0x04), ^^CB80)
                        Or (And (^^FSCB, 0x0C), ShiftRight (And (0x3000, A100), 0x0C), ^^FSCB)
                        Or (And (^^FATS, 0x0C), ShiftRight (And (0x00300000, A100), 0x14), ^^FATS)
                        Store (ICF, ^^ICF0)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                        Name (H15F, Zero)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA0))
                        }
                    }
                }

                Device (SECN)
                {
                    Name (_ADR, 0x01)
                    Name (FAST, 0x63)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (ESID)
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (0x08)
                        }
                    }

                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (Buffer (0x14)
                            {
                                0x00
                            }, Local0)
                        Store (^^FSCB, Local1)
                        ShiftRight (Local1, 0x02, Local1)
                        Store (^^GTM (^^ITM1, ^^SIT1, ^^UDC1, ^^UDT1, ^^ICF1, Local1), Local0)
                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (GTF (0x00, Arg1, Arg0), ATA2)
                        Store (GTF (0x01, Arg2, Arg0), ATA3)
                        Store (^^STMS (Arg0, Arg1, Arg2), Local0)
                        CreateDWordField (Local0, 0x00, ITM)
                        CreateDWordField (Local0, 0x04, SIT)
                        CreateDWordField (Local0, 0x08, UDC)
                        CreateDWordField (Local0, 0x0C, UDT)
                        CreateDWordField (Local0, 0x10, ICF)
                        Store (ITM, ^^ITM1)
                        Store (SIT, ^^SIT1)
                        Store (UDC, ^^UDC1)
                        Store (UDT, ^^UDT1)
                        CreateDWordField (Local0, 0x14, A100)
                        Or (And (^^CB80, 0x03), ShiftRight (And (0x30, A100), 0x02), ^^CB80)
                        Or (And (^^FSCB, 0x03), ShiftRight (And (0x3000, A100), 0x0A), ^^FSCB)
                        Or (And (^^FATS, 0x03), ShiftRight (And (0x00300000, A100), 0x12), ^^FATS)
                        Store (ICF, ^^ICF1)
                    }

                    Device (BAY1)
                    {
                        Name (_ADR, 0x00)
                        Name (H15F, Zero)
                        Name (EJ0F, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA2))
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.IDE0.ESID)
                            {
                                \_SB.PCI0.IDE0.SECN.CBAY ()
                                Store (^^BFLG, Local0)
                                If (LEqual (^^BNUM, 0x01))
                                {
                                    If (And (Local0, 0x01))
                                    {
                                        If (\_SB.PCI0.LPC0.LV37)
                                        {
                                            Return (0x08)
                                        }
                                        Else
                                        {
                                            Return (0x0F)
                                        }
                                    }
                                }
                                Else
                                {
                                    If (LEqual (^^BNUM, 0x02))
                                    {
                                        If (\_SB.PCI0.LPC0.LV37)
                                        {
                                            Return (0x08)
                                        }
                                        Else
                                        {
                                            Return (0x0F)
                                        }
                                    }
                                    Else
                                    {
                                        Return (0x08)
                                    }
                                }
                            }
                            Else
                            {
                                Return (0x08)
                            }
                        }

                        Method (_EJ0, 1, NotSerialized)
                        {
                            If (Arg0)
                            {
                                If (LGreater (\_SB.PCI0.LPC0.MBTP, 0x01))
                                {
                                    Sleep (0x32)
                                }
                                Else
                                {
                                    Store (0x01, ^^^SSIG)
                                    Sleep (0x32)
                                    Store (0xC000, ^^^ITM1)
                                    Store (0x01, \_SB.PCI0.LPC0.LV37)
                                    Sleep (0xC8)
                                    Store (0x00, \_SB.PCI0.LPC0.LV39)
                                    Sleep (0xC8)
                                }
                            }
                        }
                    }

                    Name (BNUM, 0x00)
                    Name (BFLG, 0x00)
                    Method (CBAY, 0, NotSerialized)
                    {
                        Store (0x00, BNUM)
                        Store (0x00, BFLG)
                        Store (\_SB.PCI0.LPC0.RBID, Local0)
                        If (Or (LEqual (Local0, 0x01), LEqual (Local0, 0x02)))
                        {
                            Increment (BNUM)
                            Or (BFLG, 0x01, BFLG)
                        }
                    }
                }

                Method (_PS0, 0, NotSerialized)
                {
                    If (And (LEqual (_PSC, 0x03), LEqual (\_SB.STAT, 0x03)))
                    {
                        Store (0x89, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                        Store (0xB0, P80H)
                    }

                    Store (0x00, _PSC)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (0x03, _PSC)
                    Store (0xB3, P80H)
                }

                Name (_PSC, 0x00)
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (USBO, PCI_Config, 0xC4, 0x04)
                Field (USBO, ByteAcc, NoLock, Preserve)
                {
                    RSEN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x03, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, \_SB.PCI0.USB1.RSEN)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.USB1.RSEN)
                    }
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (USBO, PCI_Config, 0xC4, 0x04)
                Field (USBO, ByteAcc, NoLock, Preserve)
                {
                    RSEN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x04, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, \_SB.PCI0.USB2.RSEN)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.USB2.RSEN)
                    }
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (USBO, PCI_Config, 0xC4, 0x04)
                Field (USBO, ByteAcc, NoLock, Preserve)
                {
                    RSEN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x0C, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, \_SB.PCI0.USB3.RSEN)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.USB3.RSEN)
                    }
                }
            }
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (LSTS, 0x00)
            Method (_LID, 0, NotSerialized)
            {
                If (\_SB.OKEC)
                {
                    If (\_SB.PCI0.LPC0.EC0.LIDS)
                    {
                        Store (Zero, LSTS)
                    }
                    Else
                    {
                        Store (One, LSTS)
                    }
                }
                Else
                {
                    Store (Zero, LSTS)
                }

                Return (LSTS)
            }
        }

        Scope (\_TZ)
        {
            Name (TPL, 0x0CA0)
            Name (TAC1, 0x0D0E)
            Name (TAC0, 0x0D54)
            Name (TPAS, 0x0E44)
            Name (TPC, 0x0E94)
            Name (TPTM, 0x0C3C)
            Name (TBSE, 0x0AAC)
            Name (LTMP, 0x0CA0)
            Name (TVAR, Buffer (0x05)
            {
                0x00, 0x20, 0x1F, 0x0C, 0x1F
            })
            CreateByteField (TVAR, 0x00, PLCY)
            CreateWordField (TVAR, 0x01, CTOS)
            CreateWordField (TVAR, 0x03, CTHY)
            Device (FAN0)
            {
                Name (_HID, EisaId ("PNP0C0B"))
                Name (_UID, 0x01)
                Name (_PR0, Package (0x01)
                {
                    PFN0
                })
                Method (_PS0, 0, NotSerialized)
                {
                    Store ("Low Speed FAN - _PS0", Debug)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store ("Low Speed FAN - _PS3", Debug)
                }
            }

            PowerResource (PFN0, 0x00, 0x0000)
            {
                Name (FNS1, 0x00)
                Name (FFST, 0x01)
                Method (_STA, 0, NotSerialized)
                {
                    Store (FNS1, Local1)
                    Return (Local1)
                }

                Method (_ON, 0, NotSerialized)
                {
                    Store (0x01, FNS1)
                    If (\_TZ.PFN1.FNS2)
                    {
                        Store ("FAN 1 (High speed already turn on) ", Debug)
                    }
                    Else
                    {
                        If (\_SB.OKEC)
                        {
                            Store (0xB4, \_SB.PCI0.LPC0.EC0.FSPD)
                            Store (0x01, \_SB.PCI0.LPC0.EC0.FPR1)
                        }
                    }

                    If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                    {
                        \_TZ.THRM._SCP (0x01)
                    }
                }

                Method (_OFF, 0, NotSerialized)
                {
                    Store (0x00, FNS1)
                    If (LEqual (SizeOf (\_OS), 0x14))
                    {
                        If (\_SB.OKEC)
                        {
                            If (\_TZ.PFN1.FNS2)
                            {
                                Store (One, \_SB.PCI0.LPC0.EC0.FPR1)
                            }
                            Else
                            {
                                Store (Zero, \_SB.PCI0.LPC0.EC0.FPR1)
                            }
                        }
                    }
                    Else
                    {
                        If (LLess (FFST, 0x02))
                        {
                            Store (0x86, \_SB.PCI0.LPC0.BCMD)
                            Store (0x00, \_SB.PCI0.LPC0.SMIC)
                            Increment (FFST)
                        }
                        Else
                        {
                            If (\_SB.OKEC)
                            {
                                Store (0x00, \_SB.PCI0.LPC0.EC0.FPR1)
                            }
                        }
                    }

                    If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                    {
                        \_TZ.THRM._SCP (0x01)
                    }
                }
            }

            Device (FAN1)
            {
                Name (_HID, EisaId ("PNP0C0B"))
                Name (_UID, 0x02)
                Name (_PR0, Package (0x02)
                {
                    PFN0, 
                    PFN1
                })
                Method (_PS0, 0, NotSerialized)
                {
                    Store ("High Speed FAN - _PS0", Debug)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store ("High Speed FAN - _PS3", Debug)
                }
            }

            PowerResource (PFN1, 0x00, 0x0000)
            {
                Name (FNS2, 0x00)
                Method (_STA, 0, NotSerialized)
                {
                    Return (FNS2)
                }

                Method (_ON, 0, NotSerialized)
                {
                    Store (0x01, FNS2)
                    If (\_SB.OKEC)
                    {
                        Store (0xFF, \_SB.PCI0.LPC0.EC0.FSPD)
                        Store (0x01, \_SB.PCI0.LPC0.EC0.FPR1)
                    }

                    If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                    {
                        \_TZ.THRM._SCP (0x01)
                    }
                }

                Method (_OFF, 0, NotSerialized)
                {
                    Store (Zero, FNS2)
                    Store (0x00, FNS2)
                    If (\_TZ.PFN0.FNS1)
                    {
                        If (\_SB.OKEC)
                        {
                            Store (0xB4, \_SB.PCI0.LPC0.EC0.FSPD)
                            Store (0x01, \_SB.PCI0.LPC0.EC0.FPR1)
                        }
                    }
                    Else
                    {
                        If (\_SB.OKEC)
                        {
                            Store (0x00, \_SB.PCI0.LPC0.EC0.FPR1)
                        }
                    }

                    If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                    {
                        \_TZ.THRM._SCP (0x01)
                    }
                }
            }

            ThermalZone (THRM)
            {
                Name (_AL0, Package (0x01)
                {
                    FAN1
                })
                Method (_AC0, 0, NotSerialized)
                {
                    Return (TAC0)
                }

                Name (_AL1, Package (0x01)
                {
                    FAN0
                })
                Method (_AC1, 0, NotSerialized)
                {
                    Return (TAC1)
                }

                Method (_CRT, 0, NotSerialized)
                {
                    Return (TPC)
                }

                Method (_PSV, 0, NotSerialized)
                {
                    Return (TPAS)
                }

                Name (_TSP, 0x64)
                Method (_TMP, 0, NotSerialized)
                {
                    If (\_SB.OKEC)
                    {
                        Store (\_SB.PCI0.LPC0.EC0.CTMP, Local1)
                        Store ("Dothan B1 CPU temperature offset value = ", Debug)
                        Store (DOFF, Debug)
                        Store (Local1, Debug)
                        Store ("Current Temperature is ----------- ", Debug)
                        Store (Local1, Debug)
                        Add (Multiply (Local1, 0x0A), TBSE, Local1)
                    }
                    Else
                    {
                        Store (LTMP, Local1)
                    }

                    Return (Local1)
                }

                Name (_PSL, Package (0x01)
                {
                    \_PR.CPU0
                })
                Name (_TC1, 0x02)
                Name (_TC2, 0x03)
                Method (_SCP, 1, NotSerialized)
                {
                    Store (Zero, PLCY)
                    If (\_TZ.PFN0.FNS1)
                    {
                        If (LEqual (\_TZ.PFN1.FNS2, 0x00))
                        {
                            Store (0x0D22, TAC1)
                            Store (0x0D86, TAC0)
                        }
                        Else
                        {
                            Store (0x0D22, TAC1)
                            Store (0x0D40, TAC0)
                        }
                    }
                    Else
                    {
                        If (\_TZ.PFN1.FNS2)
                        {
                            Store (0x0D22, TAC1)
                            Store (0x0D40, TAC0)
                        }
                        Else
                        {
                            Store (0x0D40, TAC1)
                            Store (0x0D86, TAC0)
                        }
                    }

                    Store (0x0E44, TPAS)
                    Notify (\_TZ.THRM, 0x81)
                }
            }
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
        }

        OperationRegion (EXCO, SystemIO, 0x72, 0x02)
        Field (EXCO, ByteAcc, NoLock, Preserve)
        {
            INDX,   8, 
            DATA,   8
        }

        IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
        {
            Offset (0x20), 
            ACST,   1, 
            ECOK,   1, 
            WLES,   1, 
            BTES,   1, 
            W2KF,   2, 
            S4WP,   1, 
            FLA7,   1, 
            LSFG,   1, 
            LD10,   1, 
            PS2M,   1, 
            DISD,   3, 
            OVRL,   1, 
            Offset (0x22), 
            SLEE,   8, 
            BPFG,   8, 
            PWST,   8, 
            DATS,   8, 
            CM26,   8, 
            CM27,   8, 
            CM28,   16, 
            CM2A,   16, 
            F4FG,   1, 
            Offset (0x30), 
            CM30,   8, 
            CM31,   8, 
            CM32,   8
        }
    }
}


--Boundary-00=_sk3rBCJz3CvlDs/
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="lspci.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.log"

0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable)
	Capabilities: [40] #09 [8105]
	Capabilities: [a0] AGP version 2.0

0000:00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, fast devsel, latency 0

0000:00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, fast devsel, latency 0

0000:00:01.0 PCI bridge: Intel Corp.: Unknown device 3581 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	Expansion ROM at 00003000 [disabled] [size=4K]

0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 6
	I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 6
	I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 6
	I/O ports at 1840 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 10
	Memory at d0000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d05fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 6
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1860 [size=16]
	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: medium devsel, IRQ 10
	I/O ports at 1880 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at 1c00
	I/O ports at 18c0 [size=64]
	Memory at d0000c00 (32-bit, non-prefetchable) [size=512]
	Memory at d0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

0000:00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: medium devsel, IRQ 10
	I/O ports at 2400
	I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency 66, IRQ 6
	Memory at d8000000 (32-bit, prefetchable)
	I/O ports at 3000 [size=256]
	Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

0000:02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, fast devsel, latency 64, IRQ 6
	Memory at d0204000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2

0000:02:04.0 Network controller: Intel Corp.: Unknown device 4220 (rev 05)
	Subsystem: Intel Corp.: Unknown device 2701
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at d0208000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2

0000:02:06.0 CardBus bridge: Texas Instruments: Unknown device 8031
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at d0209000 (32-bit, non-prefetchable)
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: d0400000-d04ff000 (prefetchable)
	Memory window 1: d0300000-d03ff000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004000-000040ff
	16-bit legacy interface ports at 0001

0000:02:06.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8032 (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at d020a000 (32-bit, non-prefetchable)
	Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

0000:02:06.3 Unknown mass storage controller: Texas Instruments: Unknown device 8033
	Subsystem: Acer Incorporated [ALI]: Unknown device 0064
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at d0206000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2


--Boundary-00=_sk3rBCJz3CvlDs/
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.log"

ity bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
input: PC Speaker
EISA: Probing bus 0 at eisa0
Cannot allocate resource for EISA slot 1
Cannot allocate resource for EISA slot 2
Cannot allocate resource for EISA slot 3
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
GLAN MPCI T394 MDM0 USB1 USB2 USB3 
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0, recovered transactions 85088 to 85285
(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 4772 and revoked 6/13 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda3: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 65321
EXT3-fs: hda3: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 248k freed
Adding 2104472k swap on /dev/hda5.  Priority:42 extents:1
EXT3 FS on hda3, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm-K+EdE700+2x7YGS17jhuJQ@public.gmane.org
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda6, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0, recovered transactions 371060 to 371103
(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 571 and revoked 0/1 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda7, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
subfs 0.9
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: CHECK for good STATUS
b44.c:v0.95 (Aug 3, 2004)
PCI: Found IRQ 6 for device 0000:02:02.0
PCI: Sharing IRQ 6 with 0000:00:1d.1
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:55:f0:2b
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:02:06.0 (0104 -> 0106)
PCI: Found IRQ 10 for device 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:06.2
PCI: Sharing IRQ 10 with 0000:02:06.3
Yenta: CardBus bridge found at 0000:02:06.0 [1025:0064]
Yenta: ISA IRQ mask 0x08b8, PCI irq 10
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: clean.
cs: IO port probe 0x0800-0x080f: excluding 0x808-0x80f
cs: IO port probe 0x03e0-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
b44: eth0: Link is down.
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 6 for device 0000:00:1d.0
PCI: Sharing IRQ 6 with 0000:01:00.0
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 6, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.10-rc1 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
PCI: Found IRQ 6 for device 0000:00:1d.1
PCI: Sharing IRQ 6 with 0000:02:02.0
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.0: port 1 portsc 0c80,00
hub 1-0:1.0: over-current change on port 1
uhci_hcd 0000:00:1d.0: port 2 portsc 0c80,00
hub 1-0:1.0: over-current change on port 2
Linux agpgart interface v0.100 (c) Dave Jones
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 6, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.10-rc1 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
PCI: Found IRQ 6 for device 0000:00:1d.2
PCI: Sharing IRQ 6 with 0000:00:1f.1
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 6, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.10-rc1 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
agpgart: Detected an Intel 855GM Chipset.
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: AGP aperture is 256M @ 0xe0000000
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
PCI: Found IRQ 10 for device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem 0xd0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: default language 0x0409
usb usb4: Product: EHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.10-rc1 ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: ganged power switching
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: Single TT
hub 4-0:1.0: TT requires at most 8 FS bit times
hub 4-0:1.0: power on to power good time: 20ms
hub 4-0:1.0: local power source is good
hub 4-0:1.0: enabling power on all ports
ehci_hcd 0000:00:1d.7: fatal error
ehci_hcd 0000:00:1d.7: reset command 010003 (park)=0 ithresh=1 period=1024 Reset RUN
ehci_hcd 0000:00:1d.7: HC died; cleaning up
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
PCI: Found IRQ 10 for device 0000:02:06.2
PCI: Sharing IRQ 10 with 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:06.3
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d020a000-d020a7ff]  Max Packet=[2048]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (62 C)
Invalid control/status registers
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1.60GHz": max frequency: 1600000kHz
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03ef900(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device db07cc00(sit0)
uhci_hcd 0000:00:1d.1: suspend_hc
uhci_hcd 0000:00:1d.2: suspend_hc
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f000026e498]
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
eth0: no IPv6 routers present
Non-volatile memory driver v1.2
SCSI subsystem initialized
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
usbcore: registered new driver wacom
drivers/usb/input/wacom.c: v1.30:USB Wacom Graphire and Wacom Intuos tablet driver
snd_intel8x0: Unknown parameter `joystick'
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:02:04.0
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49590 usecs
intel8x0: clocking to 48000
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
b44: eth0: Link is down.
Stopping tasks: ====================================================================================|
Freeing memory...  -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-done (68584 pages freed)
ehci_hcd 0000:00:1d.7: suspend D0 --> D3
ehci_hcd 0000:00:1d.7: halted; hcd not suspended
uhci_hcd 0000:00:1d.2: suspend_hc
uhci_hcd 0000:00:1d.1: suspend_hc
..............................................................swsusp: Need to copy 30339 pages
..<7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ehci_hcd 0000:00:1d.7: resume from state D0
ehci_hcd 0000:00:1d.7: can't resume, not suspended!
PCI: Found IRQ 6 for device 0000:00:1f.1
PCI: Sharing IRQ 6 with 0000:00:1d.2
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:02:04.0
PCI: Setting latency timer of device 0000:00:1f.5 to 64
uhci_hcd 0000:00:1d.1: wakeup_hc
uhci_hcd 0000:00:1d.2: wakeup_hc
PCI: Found IRQ 10 for device 0000:02:06.2
PCI: Sharing IRQ 10 with 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:06.3
Restarting tasks... done
uhci_hcd 0000:00:1d.0: port 1 portsc 0c80,00
hub 1-0:1.0: over-current change on port 1
uhci_hcd 0000:00:1d.0: port 2 portsc 0c80,00
hub 1-0:1.0: over-current change on port 2
uhci_hcd 0000:00:1d.1: suspend_hc
uhci_hcd 0000:00:1d.2: suspend_hc
Warning: CPU frequency is 1600000, cpufreq assumed 800000 kHz.
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ehci_hcd 0000:00:1d.7: remove, state 0
ehci_hcd 0000:00:1d.7: roothub graceful disconnect
usb usb4: USB disconnect, address 1
usb usb4: usb_disable_device nuking all URBs
ehci_hcd 0000:00:1d.7: shutdown urb dbf55a00 pipe 40408180 ep1in-intr
usb usb4: unregistering interface 4-0:1.0
usb 4-0:1.0: hotplug
usb usb4: unregistering device
usb usb4: hotplug
ehci_hcd 0000:00:1d.7: stop
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:1d.7: irq normal 0 err 0 reclaim 0 (lost 0)
ehci_hcd 0000:00:1d.7: complete 0 unlink 0
ehci_hcd 0000:00:1d.7: ehci_stop completed status 1004 Halt PCD
ehci_hcd 0000:00:1d.7: USB bus 4 deregistered
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
PCI: Found IRQ 10 for device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem 0xd0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: default language 0x0409
usb usb4: Product: EHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.10-rc1 ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: ganged power switching
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: Single TT
hub 4-0:1.0: TT requires at most 8 FS bit times
hub 4-0:1.0: power on to power good time: 20ms
hub 4-0:1.0: local power source is good
hub 4-0:1.0: enabling power on all ports
ehci_hcd 0000:00:1d.7: fatal error
ehci_hcd 0000:00:1d.7: reset command 010003 (park)=0 ithresh=1 period=1024 Reset RUN
ehci_hcd 0000:00:1d.7: HC died; cleaning up
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
atkbd.c: Unknown key pressed (translated set 2, code 0xb3 on isa0060/serio0).
atkbd.c: Use 'setkeycodes e033 <keycode>' to make it known.
atkbd.c: Unknown key released (translated set 2, code 0xb3 on isa0060/serio0).
atkbd.c: Use 'setkeycodes e033 <keycode>' to make it known.

--Boundary-00=_sk3rBCJz3CvlDs/
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="i2cdetect.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="i2cdetect.log"

WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX                         

--Boundary-00=_sk3rBCJz3CvlDs/
Content-Type: text/plain;
  charset="iso-8859-1";
  name="sensors-detect"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sensors-detect"


This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation, just scanning
 the bus will break your Thinkpad forever!
 If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
 had users reporting system breakage on other IBM systems as well.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 1880
Do you want to scan it? (YES/no/selectively): Client found at address 0x30
Client found at address 0x31
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): Probing for `ITE 8702F Super IO Sensors'
  Failed! (0xec11)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xec11)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xec11)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xec)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0xec)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0xec)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xec)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xec)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xec)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0xec)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xec)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xec)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xec)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xec)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xec)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xec)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xec)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xec)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xec)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xec)

Do you want to scan for secondary Super I/O sensors? (YES/no): Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1880' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 1880' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? 
To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
# I2C chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

--Boundary-00=_sk3rBCJz3CvlDs/
Content-Type: text/plain;
  charset="iso-8859-1";
  name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10-rc1
# Mon Nov 29 22:56:46 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_SKIP_MBR=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hda5"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_CUSTOM_DSDT_INITRD=y
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_TABLE=m

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
# CONFIG_PCMCIA_OBSOLETE is not set
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_PD6729=m
CONFIG_I82092=m
# CONFIG_I82365 is not set
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=64000
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
CONFIG_SCSI_ACARD=m
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=m
# CONFIG_SCSI_SATA_NV is not set
CONFIG_SCSI_SATA_PROMISE=m
# CONFIG_SCSI_SATA_SX4 is not set
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIS=m
# CONFIG_SCSI_SATA_ULI is not set
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_SATA_VITESSE=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_DMX3191D=m
# CONFIG_SCSI_DTC3280 is not set
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_EATA_LINKED_COMMANDS=y
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
CONFIG_SCSI_IPS=m
# CONFIG_SCSI_INITIO is not set
CONFIG_SCSI_INIA100=m
# CONFIG_SCSI_NCR53C406A is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
CONFIG_SCSI_QLOGIC_FC_FIRMWARE=y
CONFIG_SCSI_QLOGIC_1280=m
# CONFIG_SCSI_QLOGIC_1280_1040 is not set
CONFIG_SCSI_QLA2XXX=m
CONFIG_SCSI_QLA21XX=m
CONFIG_SCSI_QLA22XX=m
CONFIG_SCSI_QLA2300=m
CONFIG_SCSI_QLA2322=m
CONFIG_SCSI_QLA6312=m
CONFIG_SCSI_QLA6322=m
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
CONFIG_SCSI_NSP32=m
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_CONFIG=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_COMPAT_IPFWADM=m

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
# CONFIG_IP6_NF_MATCH_PHYSDEV is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_IP6_NF_RAW is not set

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
CONFIG_DECNET=m
CONFIG_DECNET_SIOCGIFCONF=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
# CONFIG_LTPC is not set
# CONFIG_COPS is not set
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_X25=m
CONFIG_LAPB=m
# CONFIG_NET_DIVERT is not set
CONFIG_ECONET=m
# CONFIG_ECONET_AUNUDP is not set
# CONFIG_ECONET_NATIVE is not set
CONFIG_WAN_ROUTER=m
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=y
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETPOLL=y
CONFIG_NETPOLL_RX=y
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=m
# CONFIG_DMASCC is not set
# CONFIG_SCC is not set
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_YAM=m
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
# CONFIG_IRDA_FAST_RR is not set
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_MA600_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_MCP2120_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_ACT200L_DONGLE=m

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_SIGMATEL_FIR=m
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
CONFIG_TOSHIBA_FIR=m
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
CONFIG_VLSI_FIR=m
# CONFIG_VIA_FIR is not set
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
# CONFIG_BT_HCIBTUART is not set
CONFIG_BT_HCIVHCI=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
# CONFIG_PCMCIA_XIRCOM is not set
# CONFIG_PCMCIA_XIRTULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
CONFIG_B44=m
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=m
CONFIG_E100_NAPI=y
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
CONFIG_STRIP=m
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
# CONFIG_PCMCIA_HERMES is not set
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_ATMEL is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set
# CONFIG_ATM_HE is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
# CONFIG_SLIP is not set
CONFIG_NET_FC=y
CONFIG_SHAPER=m
CONFIG_NETCONSOLE=m

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=m
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_MULTIPORT=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

#
# The compressor will be built as a module only!
#
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
CONFIG_FT_PROC_FS=y
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
CONFIG_AGP_INTEL_MCH=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_I830=m
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_STUB=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_PCA_ISA=m

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
# CONFIG_SND_DEBUG_DETECT is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
# CONFIG_USB_EGALAX is not set
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_RT=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=y
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_POSIX is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_ROOTPLUG=m
# CONFIG_SECURITY_SECLVL is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
# CONFIG_SECURITY_SELINUX_MLS is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_AES_586 is not set
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_CRC32C is not set
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--Boundary-00=_sk3rBCJz3CvlDs/--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
