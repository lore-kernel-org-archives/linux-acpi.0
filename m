From: Bob Weber <rjweber-EkmVulN54Sk@public.gmane.org>
Subject: Compile problem in DSDT.dsl file
Date: Mon, 10 Jan 2005 12:00:13 -0800
Message-ID: <200501101200.13340.rjweber@ieee.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_N7t4BogCo2a92aX"
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

--Boundary-00=_N7t4BogCo2a92aX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello. I've had ACPI working on my laptop, but with the latest kernel I cannot 
boot unless I have "acpi=off".

After reading up on the linux ACPI effort, I decided to try and tackle this. I 
have an enpower ENP24004 centrino-based system. With an Intel chipset, I 
figured chances are good that the only issue is in the DSDT table.

I've extracted the DSDT code, and when I compile it with "iasl -tc dsdt.dsl", 
I get the following:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.dsl  7573:     If (SS1)
Error    1037 -      ^ parse error, unexpected PARSEOP_IF

ASL Input:  dsdt.dsl - 7657 lines, 262438 bytes, 3475 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

I'm not literate in DSDT speak, but this looks like it should be pretty clear. 
Looking at the code, I don't  know what's wrong.

Can anyone help? Where can I find out more about this? I'm not sure if this is 
the right place.

If we get this fixed, would it be useful to add to the list of fixed DSDT 
files? Tnx.

-- 
----------------------------------------------------------------------------
The only maxim of a free government ought to be to trust no man living with
power to endanger the public liberty. -John Adams, 2nd US president
(1735-1826)

--Boundary-00=_N7t4BogCo2a92aX
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="dsdt.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dsdt.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of dsdt.dat, Sun Jan  9 21:13:00 2005
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "0ABBD", "0ABBD001", 1)
{
    OperationRegion (BIOS, SystemMemory, 0x1F750064, 0xFF)
    Field (BIOS, ByteAcc, NoLock, Preserve)
    {
        SS1,    1, 
        SS2,    1, 
        SS3,    1, 
        SS4,    1, 
        Offset (0x01), 
        IOST,   16, 
        TOPM,   32, 
        ROMS,   32, 
        MG1B,   32, 
        MG1L,   32, 
        MG2B,   32, 
        MG2L,   32
    }

    Name (IO1B, 0x0480)
    Name (IO1L, 0x10)
    Name (IOXB, 0x04C0)
    Name (IOXL, 0x10)
    Name (SPIO, 0x2E)
    Name (APCB, 0x00)
    Name (APCL, 0x00)
    Name (PMBS, 0xE400)
    Name (PMLN, 0x80)
    Name (WFAT, 0x90)
    Name (WNVR, 0x91)
    Name (RNVR, 0x92)
    Name (SWFR, 0x93)
    Name (STDD, 0x94)
    Name (GTDD, 0x95)
    Name (ADBR, 0x96)
    Name (CGPS, 0x97)
    Name (CGWK, 0x98)
    Name (ISWP, 0x99)
    Name (ISTB, 0x9A)
    Name (GPBS, 0xEC00)
    Name (GPLN, 0x40)
    Name (SMBS, 0xE800)
    Name (SMBL, 0x10)
    Name (FNC0, 0x00)
    Name (FNC1, 0x12)
    Name (FNC2, 0x1E)
    Name (FNC3, 0x28)
    Name (FNC4, 0x30)
    Method (RRIO, 4, NotSerialized)
    {
        Store ("RRIO", Debug)
    }

    Method (RDMA, 3, NotSerialized)
    {
        Store ("rDMA", Debug)
    }

    Name (PICM, 0x00)
    Method (_PIC, 1, NotSerialized)
    {
        If (Arg0)
        {
            Store (0xAA, DBG8)
        }
        Else
        {
            Store (0x55, DBG8)
        }

        Store (Arg0, PICM)
    }

    Method (OSFL, 0, NotSerialized)
    {
        Store (0x01, Local0)
        If (MCTH (\_OS, "Microsoft Windows NT"))
        {
            Store (0x00, Local0)
        }

        Return (Local0)
    }

    Method (MCTH, 2, NotSerialized)
    {
        If (LLess (SizeOf (Arg0), SizeOf (Arg1)))
        {
            Return (Zero)
        }

        Add (SizeOf (Arg0), 0x01, Local0)
        Name (BUF0, Buffer (Local0) {})
        Name (BUF1, Buffer (Local0) {})
        Store (Arg0, BUF0)
        Store (Arg1, BUF1)
        While (Local0)
        {
            Decrement (Local0)
            If (LNot (LEqual (DerefOf (Index (BUF0, Local0)), DerefOf (Index (BUF1, Local0)))))
            {
                Return (Zero)
            }
        }

        Return (One)
    }

    Method (GPRW, 2, NotSerialized)
    {
        Name (PRWP, Package (0x02)
        {
            0x00, 
            0x00
        })
        Store (Arg0, Index (PRWP, 0x00))
        Store (Arg1, Index (PRWP, 0x01))
        Store (0x00, Local0)
        Or (Local0, ShiftLeft (SS1, 0x01), Local0)
        Or (Local0, ShiftLeft (SS2, 0x02), Local0)
        Or (Local0, ShiftLeft (SS3, 0x03), Local0)
        Or (Local0, ShiftLeft (SS4, 0x04), Local0)
        If (And (ShiftLeft (0x01, Arg1), Local0)) {}
        Else
        {
            ShiftRight (Local0, 0x01, Local0)
            Store (OSFL (), Local1)
            If (LOr (LEqual (Local1, 0x01), LEqual (Local1, 0x02)))
            {
                FindSetLeftBit (Local0, Index (PRWP, 0x01))
            }
            Else
            {
                FindSetRightBit (Local0, Index (PRWP, 0x01))
            }
        }

        Return (PRWP)
    }

    Name (WAKP, Package (0x02)
    {
        0x00, 
        0x00
    })
    OperationRegion (DEB0, SystemIO, 0x80, 0x01)
    Field (DEB0, ByteAcc, NoLock, Preserve)
    {
        DBG8,   8
    }

    OperationRegion (DEB1, SystemIO, 0x90, 0x02)
    Field (DEB1, WordAcc, NoLock, Preserve)
    {
        DBG9,   16
    }

    Scope (\_PR)
    {
        Processor (CPU1, 0x01, 0x0000E410, 0x06) {}
    }

    Scope (\_SB)
    {
        Name (PR01, Package (0x05)
        {
            Package (0x04)
            {
                0x0008FFFF, 
                0x00, 
                LNKE, 
                0x00
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                0x00, 
                LNKB, 
                0x00
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                0x01, 
                LNKA, 
                0x00
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x00, 
                LNKC, 
                0x00
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x01, 
                LNKD, 
                0x00
            }
        })
        Name (AR01, Package (0x05)
        {
            Package (0x04)
            {
                0x0008FFFF, 
                0x00, 
                0x00, 
                0x14
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                0x00, 
                0x00, 
                0x11
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                0x01, 
                0x00, 
                0x10
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x01, 
                0x00, 
                0x13
            }
        })
        Name (PR00, Package (0x07)
        {
            Package (0x04)
            {
                0x0002FFFF, 
                0x00, 
                LNKA, 
                0x00
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x00, 
                LNKC, 
                0x00
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x01, 
                LNKB, 
                0x00
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x00, 
                LNKA, 
                0x00
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x01, 
                LNKD, 
                0x00
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x02, 
                LNKC, 
                0x00
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x03, 
                LNKH, 
                0x00
            }
        })
        Name (AR00, Package (0x07)
        {
            Package (0x04)
            {
                0x0002FFFF, 
                0x00, 
                0x00, 
                0x10
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x01, 
                0x00, 
                0x11
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x00, 
                0x00, 
                0x10
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x01, 
                0x00, 
                0x13
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x02, 
                0x00, 
                0x12
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x03, 
                0x00, 
                0x17
            }
        })
        Name (PRSA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {3,4,5,6,7,11,12}
        })
        Alias (PRSA, PRSB)
        Name (PRSC, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {4,12}
        })
        Name (PRSD, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {5,6}
        })
        Name (PRSE, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {6,11}
        })
        Name (PRSF, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {3,7}
        })
        Name (PRSG, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {4,7}
        })
        Name (PRSH, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {4,6,12}
        })
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            Name (_UID, 0x00)
            Method (_PRT, 0, NotSerialized)
            {
                If (PICM)
                {
                    Return (AR00)
                }

                Return (PR00)
            }

            Device (P0P1)
            {
                Name (_ADR, 0x001E0000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x0B, 0x04))
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR01)
                    }

                    Return (PR01)
                }

                Device (LAN0)
                {
                    Name (_ADR, 0x00080000)
                    Method (_PRW, 0, NotSerialized)
                    {
                        Return (GPRW (0x0B, 0x04))
                    }
                }

                Device (CBS0)
                {
                    Name (_ADR, 0x00050000)
                    OperationRegion (CBSP, PCI_Config, 0x00, 0xF0)
                    Field (CBSP, DWordAcc, NoLock, Preserve)
                    {
                        Offset (0x04), 
                        CB04,   8, 
                        Offset (0x14), 
                        CB14,   8, 
                        Offset (0x3C), 
                        CB3C,   8, 
                        Offset (0x3E), 
                        CB3E,   8, 
                        Offset (0x44), 
                        CB44,   32, 
                        Offset (0xE0), 
                        PME0,   8, 
                        PME1,   8
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Store (Zero, CB44)
                    }

                    Method (CBSW, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Zero, CB44)
                        }
                    }

                    Method (CBSR, 0, NotSerialized)
                    {
                        And (PME1, 0x80, Local1)
                        If (Local1)
                        {
                            And (PME0, 0xFC, PME0)
                            Store (PME1, Local2)
                            Store (Local2, PME1)
                        }

                        Return (Local1)
                    }

                    Method (_PRW, 0, NotSerialized)
                    {
                        Return (GPRW (0x0B, 0x03))
                    }
                }

                Device (P394)
                {
                    Name (_ADR, 0x00050001)
                    Method (_PRW, 0, NotSerialized)
                    {
                        Return (GPRW (0x0B, 0x03))
                    }
                }

                Device (MPCI)
                {
                    Name (_ADR, 0x00040000)
                    OperationRegion (MINP, PCI_Config, 0x00, 0x68)
                    Field (MINP, ByteAcc, NoLock, Preserve)
                    {
                        VNUM,   32, 
                        Offset (0x2C), 
                        SNUM,   32, 
                        Offset (0x34)
                    }

                    Method (MPDP, 0, NotSerialized)
                    {
                        If (LEqual (SNUM, 0x04621668))
                        {
                            Return (0x01)
                        }

                        If (LEqual (SNUM, 0x25228086))
                        {
                            Return (0x02)
                        }

                        If (LEqual (SNUM, 0x25278086))
                        {
                            Return (0x02)
                        }

                        Return (0x00)
                    }

                    Method (_PRW, 0, NotSerialized)
                    {
                        Return (GPRW (0x0B, 0x03))
                    }
                }
            }

            Device (SBRG)
            {
                Name (_ADR, 0x001F0000)
                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x00, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x00, 0x02)
                        IRQNoFlags () {2}
                    })
                }

                Device (DMAD)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        DMA (Compatibility, BusMaster, Transfer8) {4}
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x10)
                        IO (Decode16, 0x0081, 0x0081, 0x00, 0x03)
                        IO (Decode16, 0x0087, 0x0087, 0x00, 0x01)
                        IO (Decode16, 0x0089, 0x0089, 0x00, 0x03)
                        IO (Decode16, 0x008F, 0x008F, 0x00, 0x01)
                        IO (Decode16, 0x00C0, 0x00C0, 0x00, 0x20)
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x00, 0x04)
                        IRQNoFlags () {0}
                    })
                }

                Device (RTC0)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x00, 0x02)
                        IRQNoFlags () {8}
                    })
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CID, 0x0B03D041)
                    Method (_STA, 0, NotSerialized)
                    {
                        ShiftLeft (0x01, 0x0A, Local0)
                        If (And (IOST, Local0))
                        {
                            Return (0x0F)
                        }

                        Return (0x00)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x00, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x00, 0x01)
                        IRQNoFlags () {1}
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F03"))
                    Name (_CID, 0x130FD041)
                    Method (_STA, 0, NotSerialized)
                    {
                        ShiftLeft (0x01, 0x0C, Local0)
                        If (And (IOST, Local0))
                        {
                            Return (0x0F)
                        }

                        Return (0x00)
                    }

                    Name (CRS1, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Name (CRS2, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x00, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x00, 0x01)
                        IRQNoFlags () {12}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        ShiftLeft (0x01, 0x0A, Local0)
                        If (And (IOST, Local0))
                        {
                            Return (CRS1)
                        }
                        Else
                        {
                            Return (CRS2)
                        }
                    }
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x00, 0x01)
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x00, 0x10)
                        IRQNoFlags () {13}
                    })
                }

                Device (SIOR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Method (_UID, 0, NotSerialized)
                    {
                        Return (SPIO)
                    }

                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (LAnd (LNot (LEqual (SPIO, 0x03F0)), LGreater (SPIO, 0xF0)))
                        {
                            CreateWordField (CRS, 0x02, GP10)
                            CreateWordField (CRS, 0x04, GP11)
                            CreateByteField (CRS, 0x07, GPL1)
                            Store (SPIO, GP10)
                            Store (SPIO, GP11)
                            Store (0x02, GPL1)
                        }

                        If (IO1B)
                        {
                            CreateWordField (CRS, 0x0A, GP20)
                            CreateWordField (CRS, 0x0C, GP21)
                            CreateByteField (CRS, 0x0F, GPL2)
                            Store (IO1B, GP20)
                            Store (IO1B, GP21)
                            Store (IO1L, GPL2)
                        }

                        If (IOXB)
                        {
                            CreateWordField (CRS, 0x12, GP30)
                            CreateWordField (CRS, 0x14, GP31)
                            CreateByteField (CRS, 0x17, GPL3)
                            Store (IOXB, GP30)
                            Store (IOXB, GP31)
                            Store (IOXL, GPL3)
                        }

                        Return (CRS)
                    }
                }

                Name (DCAT, Package (0x15)
                {
                    0x03, 
                    0x02, 
                    0x01, 
                    0x00, 
                    0xFF, 
                    0x0C, 
                    0xFF, 
                    0xFF, 
                    0x0B, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF
                })
                Mutex (MUT0, 0x00)
                Method (ENFG, 1, NotSerialized)
                {
                    Acquire (MUT0, 0x0FFF)
                    Store (Arg0, LDN)
                }

                Method (EXFG, 0, NotSerialized)
                {
                    Release (MUT0)
                }

                Method (LPTM, 1, NotSerialized)
                {
                    ENFG (CGLD (Arg0))
                    And (OPT1, 0x02, Local0)
                    EXFG ()
                    Return (Local0)
                }

                Method (FIRM, 1, NotSerialized)
                {
                    ENFG (CGLD (Arg0))
                    Store (DMCH, Local0)
                    EXFG ()
                    If (LAnd (LLess (Local0, 0x04), LNot (LEqual (And (Local0, 0x03, Local1), 0x00))))
                    {
                        Store (0x01, Local0)
                    }
                    Else
                    {
                        Store (0x00, Local0)
                    }

                    Return (Local0)
                }

                Method (UHID, 1, NotSerialized)
                {
                    If (LEqual (Arg0, 0x01))
                    {
                        ENFG (CGLD (Arg0))
                        Store (DMCH, Local0)
                        EXFG ()
                        If (LAnd (LLess (DMCH, 0x04), LNot (LEqual (And (DMCH, 0x03, Local1), 0x00))))
                        {
                            Return (0x0160633A)
                        }
                        Else
                        {
                            Return (0x1005D041)
                        }
                    }

                    Return (0x0105D041)
                }

                Method (SIOS, 1, NotSerialized)
                {
                }

                Method (SIOW, 1, NotSerialized)
                {
                }

                Method (SIOH, 0, NotSerialized)
                {
                }

                OperationRegion (IOID, SystemIO, SPIO, 0x02)
                Field (IOID, ByteAcc, NoLock, Preserve)
                {
                    INDX,   8, 
                    DATA,   8
                }

                IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x07), 
                    LDN,    8, 
                    Offset (0x22), 
                    FDCP,   1, 
                        ,   2, 
                    LPTP,   1, 
                    URAP,   1, 
                    URBP,   1, 
                    Offset (0x30), 
                    ACTR,   8, 
                    Offset (0x60), 
                    IOAH,   8, 
                    IOAL,   8, 
                    IOH2,   8, 
                    IOL2,   8, 
                    Offset (0x70), 
                    INTR,   8, 
                    Offset (0x74), 
                    DMCH,   8, 
                    Offset (0xF0), 
                    OPT1,   8, 
                    OPT2,   8, 
                    OPT3,   8
                }

                Method (CGLD, 1, NotSerialized)
                {
                    Return (DerefOf (Index (DCAT, Arg0)))
                }

                Method (DSTA, 1, NotSerialized)
                {
                    Store (0x00, Local0)
                    ShiftLeft (0x01, Arg0, Local1)
                    If (And (IOST, Local1))
                    {
                        ENFG (CGLD (Arg0))
                        If (ACTR)
                        {
                            Store (0x0F, Local0)
                        }
                        Else
                        {
                            Store (0x0D, Local0)
                        }

                        EXFG ()
                    }

                    Return (Local0)
                }

                Method (DCNT, 2, NotSerialized)
                {
                    ENFG (CGLD (Arg0))
                    ShiftLeft (IOAH, 0x08, Local1)
                    Or (IOAL, Local1, Local1)
                    RRIO (Arg0, Arg1, Local1, 0x08)
                    If (LAnd (LLess (DMCH, 0x04), LNot (LEqual (And (DMCH, 0x03, Local1), 0x00))))
                    {
                        RDMA (Arg0, Arg1, Increment (Local1))
                    }

                    Store (Arg1, ACTR)
                    EXFG ()
                }

                Name (CRS1, ResourceTemplate ()
                {
                    IRQNoFlags () {}
                    DMA (Compatibility, NotBusMaster, Transfer8) {}
                    IO (Decode16, 0x0000, 0x0000, 0x01, 0x00)
                })
                CreateWordField (CRS1, 0x01, IRQM)
                CreateByteField (CRS1, 0x04, DMAM)
                CreateWordField (CRS1, 0x08, IO11)
                CreateWordField (CRS1, 0x0A, IO12)
                CreateByteField (CRS1, 0x0D, LEN1)
                Name (CRS2, ResourceTemplate ()
                {
                    IRQNoFlags () {6}
                    DMA (Compatibility, NotBusMaster, Transfer8) {2}
                    IO (Decode16, 0x0000, 0x0000, 0x01, 0x00)
                    IO (Decode16, 0x0000, 0x0000, 0x01, 0x00)
                })
                CreateWordField (CRS2, 0x01, IRQE)
                CreateByteField (CRS2, 0x04, DMAE)
                CreateWordField (CRS2, 0x08, IO21)
                CreateWordField (CRS2, 0x0A, IO22)
                CreateByteField (CRS2, 0x0D, LEN2)
                CreateWordField (CRS2, 0x10, IO31)
                CreateWordField (CRS2, 0x12, IO32)
                CreateByteField (CRS2, 0x15, LEN3)
                Method (DCRS, 1, NotSerialized)
                {
                    ENFG (CGLD (Arg0))
                    ShiftLeft (IOAH, 0x08, IO11)
                    Or (IOAL, IO11, IO11)
                    Store (IO11, IO12)
                    Subtract (FindSetRightBit (IO11), 0x01, Local0)
                    ShiftLeft (0x01, Local0, LEN1)
                    If (INTR)
                    {
                        ShiftLeft (0x01, INTR, IRQM)
                    }
                    Else
                    {
                        Store (0x00, IRQM)
                    }

                    If (LAnd (LLess (DMCH, 0x04), LNot (LEqual (And (DMCH, 0x03, Local1), 0x00))))
                    {
                        ShiftLeft (0x01, Local1, DMAM)
                    }
                    Else
                    {
                        Store (0x00, DMAM)
                    }

                    EXFG ()
                    Return (CRS1)
                }

                Method (DSRS, 2, NotSerialized)
                {
                    CreateWordField (Arg0, 0x01, IRQM)
                    CreateByteField (Arg0, 0x04, DMAM)
                    CreateWordField (Arg0, 0x08, IO11)
                    ENFG (CGLD (Arg1))
                    And (IO11, 0xFF, IOAL)
                    ShiftRight (IO11, 0x08, IOAH)
                    If (IRQM)
                    {
                        FindSetRightBit (IRQM, Local0)
                        Subtract (Local0, 0x01, INTR)
                    }
                    Else
                    {
                        Store (0x00, INTR)
                    }

                    If (DMAM)
                    {
                        FindSetRightBit (DMAM, Local0)
                        Subtract (Local0, 0x01, DMCH)
                    }
                    Else
                    {
                        Store (0x04, DMCH)
                    }

                    EXFG ()
                    DCNT (Arg1, 0x01)
                }

                Device (RMSC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x10)
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0010, 0x0010, 0x00, 0x10)
                        IO (Decode16, 0x0022, 0x0022, 0x00, 0x1E)
                        IO (Decode16, 0x0044, 0x0044, 0x00, 0x1C)
                        IO (Decode16, 0x0063, 0x0063, 0x00, 0x01)
                        IO (Decode16, 0x0065, 0x0065, 0x00, 0x01)
                        IO (Decode16, 0x0067, 0x0067, 0x00, 0x09)
                        IO (Decode16, 0x0072, 0x0072, 0x00, 0x0E)
                        IO (Decode16, 0x0080, 0x0080, 0x00, 0x01)
                        IO (Decode16, 0x0084, 0x0084, 0x00, 0x03)
                        IO (Decode16, 0x0088, 0x0088, 0x00, 0x01)
                        IO (Decode16, 0x008C, 0x008C, 0x00, 0x03)
                        IO (Decode16, 0x0090, 0x0090, 0x00, 0x10)
                        IO (Decode16, 0x00A2, 0x00A2, 0x00, 0x1E)
                        IO (Decode16, 0x00E0, 0x00E0, 0x00, 0x10)
                        IO (Decode16, 0x04D0, 0x04D0, 0x00, 0x02)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (CRS, 0x7A, GP00)
                        CreateWordField (CRS, 0x7C, GP01)
                        CreateByteField (CRS, 0x7F, GP0L)
                        Store (PMBS, GP00)
                        Store (PMBS, GP01)
                        Store (PMLN, GP0L)
                        If (GPBS)
                        {
                            CreateWordField (CRS, 0x82, GP20)
                            CreateWordField (CRS, 0x84, GP21)
                            CreateByteField (CRS, 0x87, GP2L)
                            Store (GPBS, GP20)
                            Store (GPBS, GP21)
                            Store (GPLN, GP2L)
                        }

                        Return (CRS)
                    }
                }

                Device (OMSC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x00)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly, 0x00000000, 0x00000000)
                        Memory32Fixed (ReadOnly, 0x00000000, 0x00000000)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (APCB)
                        {
                            CreateDWordField (CRS, 0x08, ML01)
                            CreateDWordField (CRS, 0x04, MB01)
                            CreateDWordField (CRS, 0x14, ML02)
                            CreateDWordField (CRS, 0x10, MB02)
                            Store (APCB, MB01)
                            Store (APCL, ML01)
                            Store (0xFEE00000, MB02)
                            Store (0x1000, ML02)
                        }

                        Return (CRS)
                    }
                }

                Device (\_SB.RMEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, 0x01)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite, 0x00000000, 0x000A0000)
                        Memory32Fixed (ReadOnly, 0x00000000, 0x00000000)
                        Memory32Fixed (ReadOnly, 0x000E0000, 0x00020000)
                        Memory32Fixed (ReadWrite, 0x00100000, 0x00000000)
                        Memory32Fixed (ReadOnly, 0x00000000, 0x00000000)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS, 0x10, BAS1)
                        CreateDWordField (CRS, 0x14, LEN1)
                        CreateDWordField (CRS, 0x1C, BAS2)
                        CreateDWordField (CRS, 0x20, LEN2)
                        CreateDWordField (CRS, 0x2C, LEN3)
                        CreateDWordField (CRS, 0x34, BAS4)
                        CreateDWordField (CRS, 0x38, LEN4)
                        If (OSFL ()) {}
                        Else
                        {
                            If (MG1B)
                            {
                                If (LGreater (MG1B, 0x000C0000))
                                {
                                    Store (0x000C0000, BAS1)
                                    Subtract (MG1B, BAS1, LEN1)
                                }
                            }
                            Else
                            {
                                Store (0x000C0000, BAS1)
                                Store (0x00020000, LEN1)
                            }

                            If (Add (MG1B, MG1L, Local0))
                            {
                                Store (Local0, BAS2)
                                Subtract (0x00100000, BAS2, LEN2)
                            }
                        }

                        Subtract (MG2B, 0x00100000, LEN3)
                        Add (MG2B, MG2L, BAS4)
                        Subtract (0x00, BAS4, LEN4)
                        Return (CRS)
                    }
                }

                Scope (\)
                {
                    OperationRegion (\GPSC, SystemIO, 0xB2, 0x02)
                    Field (\GPSC, ByteAcc, NoLock, Preserve)
                    {
                        SMCM,   8, 
                        SMST,   8
                    }

                    Method (\ISMI, 1, Serialized)
                    {
                        Store (Arg0, SMCM)
                    }

                    Method (\DIAG, 1, NotSerialized)
                    {
                        Store (Arg0, DBG8)
                    }

                    OperationRegion (\SIOG, SystemIO, IO1B, 0x10)
                    Field (\SIOG, ByteAcc, NoLock, Preserve)
                    {
                        PO00,   1, 
                        PO01,   1, 
                        PO02,   1, 
                        PO03,   1, 
                        PO04,   1, 
                        PO05,   1, 
                        PO06,   1, 
                        PO07,   1, 
                        PI00,   1, 
                        PI01,   1, 
                        PI02,   1, 
                        PI03,   1, 
                        PI04,   1, 
                        PI05,   1, 
                        PI06,   1, 
                        PI07,   1, 
                        Offset (0x04), 
                        PO10,   1, 
                        PO11,   1, 
                        PO12,   1, 
                        PO13,   1, 
                        PO14,   1, 
                        PO15,   1, 
                        PO16,   1, 
                        PO17,   1, 
                        PI10,   1, 
                        PI11,   1, 
                        PI12,   1, 
                        PI13,   1, 
                        PI14,   1, 
                        PI15,   1, 
                        PI16,   1, 
                        PI17,   1, 
                        Offset (0x08), 
                        PO20,   1, 
                        PO21,   1, 
                        PO22,   1, 
                        PO23,   1, 
                        PO24,   1, 
                        PO25,   1, 
                        PO26,   1, 
                        PO27,   1, 
                        PI20,   1, 
                        PI21,   1, 
                        PI22,   1, 
                        PI23,   1, 
                        PI24,   1, 
                        PI25,   1, 
                        PI26,   1, 
                        PI27,   1, 
                        PO30,   1, 
                        PO31,   1, 
                        PO32,   1, 
                        PO33,   1, 
                        PO34,   1, 
                        PO35,   1, 
                        PO36,   1, 
                        PO37,   1, 
                        PI30,   1, 
                        PI31,   1, 
                        PI32,   1, 
                        PI33,   1, 
                        PI34,   1, 
                        PI35,   1, 
                        PI36,   1, 
                        PI37,   1
                    }

                    OperationRegion (\PMIO, SystemIO, PMBS, 0x80)
                    Field (\PMIO, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x10), 
                            ,   1, 
                        TDTY,   3, 
                        TENA,   1, 
                        TTDT,   3, 
                        FRCT,   1, 
                            ,   8, 
                        THLS,   1, 
                        Offset (0x28), 
                            ,   11, 
                        SBPS,   1, 
                        Offset (0x2A), 
                        Offset (0x2B), 
                        G08S,   1, 
                            ,   2, 
                        G11S,   1, 
                        G12S,   1, 
                        FLPS,   1, 
                        Offset (0x2C), 
                            ,   2, 
                        TPOL,   1, 
                        Offset (0x2D), 
                        Offset (0x2E), 
                        Offset (0x2F), 
                        G08E,   1, 
                            ,   2, 
                        G11E,   1, 
                        G12E,   1, 
                        Offset (0x30), 
                            ,   4, 
                        SLPE,   1, 
                        Offset (0x31), 
                        Offset (0x34), 
                            ,   4, 
                        SLPS,   1, 
                        Offset (0x35)
                    }

                    OperationRegion (\GPIO, SystemIO, GPBS, 0x40)
                    Field (\GPIO, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x0C), 
                            ,   28, 
                        IPWR,   1, 
                        Offset (0x2C), 
                            ,   11, 
                        LIDL,   1, 
                            ,   1, 
                        FLPL,   1, 
                        Offset (0x38), 
                        BKLT,   1, 
                        SBAY,   2, 
                        FS02,   3, 
                        FS56,   2
                    }

                    OperationRegion (\ECMS, SystemIO, 0x72, 0x02)
                    Field (\ECMS, ByteAcc, Lock, Preserve)
                    {
                        EIND,   8, 
                        EDAT,   8
                    }

                    IndexField (EIND, EDAT, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x10), 
                        IKFG,   8, 
                        FRPN,   16, 
                        RAMB,   32, 
                        AVOL,   8, 
                        LBTN,   8, 
                        CKLN,   8, 
                        CK00,   8, 
                        CK01,   8, 
                        CK02,   8, 
                        CK03,   8, 
                        CK04,   8, 
                        CK05,   8, 
                        CK06,   8, 
                        CK07,   8, 
                        CK08,   8, 
                        CK09,   8, 
                        CK10,   8, 
                        CK11,   8, 
                        CK12,   8, 
                        CK13,   8, 
                        CK14,   8, 
                        CK15,   8, 
                        CK16,   8, 
                        CK17,   8, 
                        CK18,   8, 
                        CK19,   8, 
                        CK20,   8, 
                        CK21,   8, 
                        CK22,   8, 
                        CK23,   8, 
                        CK24,   8, 
                        CK25,   8, 
                        CK26,   8, 
                        CK27,   8, 
                        CK28,   8, 
                        CK29,   8, 
                        ERRF,   8, 
                        OCLK,   8, 
                        WIDE,   1, 
                        OVCK,   2, 
                        S42K,   3, 
                        Offset (0x3B), 
                        CPUR,   6, 
                        CPUF,   2
                    }

                    OperationRegion (\RAMW, SystemMemory, RAMB, 0xFF)
                    Field (\RAMW, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xB0), 
                        TRTY,   8, 
                        FSFN,   8, 
                        FSTA,   16, 
                        FADR,   32, 
                        FSIZ,   16, 
                        ACTD,   8, 
                        AVLD,   8, 
                        SETD,   8, 
                        ACPF,   1, 
                        DCPF,   1, 
                        CHGF,   1, 
                        Offset (0xBE), 
                        PADL,   16, 
                        CADL,   16, 
                        CSTE,   16, 
                        NSTE,   16, 
                        SSTE,   16, 
                        SFUN,   8, 
                        TSAD,   8, 
                        TAC3,   8, 
                        TAC2,   8, 
                        TAC1,   8, 
                        TAC0,   8, 
                        TPSV,   8, 
                        TCRT,   8, 
                        F1L0,   8, 
                        F2L0,   8, 
                        F1L1,   8, 
                        F2L1,   8, 
                        F1L2,   8, 
                        F2L2,   8, 
                        F1L3,   8, 
                        F2L3,   8, 
                        F1L4,   8, 
                        F2L4,   8, 
                        SLPT,   8, 
                        DBRD,   32, 
                        SIDS,   8
                    }

                    Name (OSFG, 0x00)
                    Name (OS9X, 0x01)
                    Name (OS98, 0x02)
                    Name (OSME, 0x04)
                    Name (OS2K, 0x08)
                    Name (OSXP, 0x10)
                    Method (OSVR, 0, NotSerialized)
                    {
                        If (CondRefOf (\_OSI, Local0))
                        {
                            Store (OSXP, OSFG)
                        }
                        Else
                        {
                            If (MCTH (\_OS, "Microsoft Windows"))
                            {
                                Store (OS98, OSFG)
                            }
                            Else
                            {
                                If (MCTH (\_OS, "Microsoft WindowsME: Millennium Edition"))
                                {
                                    Store (OSME, OSFG)
                                }
                                Else
                                {
                                    If (MCTH (\_OS, "Microsoft Windows NT"))
                                    {
                                        Store (OS2K, OSFG)
                                    }
                                    Else
                                    {
                                        Store (OSXP, OSFG)
                                    }
                                }
                            }
                        }

                        Return (OSFG)
                    }

                    OperationRegion (\SIOP, SystemIO, \SPIO, 0x02)
                    Field (\SIOP, ByteAcc, Lock, Preserve)
                    {
                        SIOI,   8, 
                        SIOD,   8
                    }

                    IndexField (SIOI, SIOD, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x07), 
                        LDNP,   8, 
                        Offset (0x30), 
                        LDCP,   8
                    }

                    Method (\DBGR, 1, NotSerialized)
                    {
                        Store (LDNP, Local0)
                        Store (0x01, LDNP)
                        Store (LDCP, Local1)
                        Store (0x01, LDCP)
                        Store (Arg0, DBRD)
                        \ISMI (\ADBR)
                        Store (0x01, LDNP)
                        Store (Local1, LDCP)
                        Store (Local0, LDNP)
                    }

                    Name (MNAM, "M3N")
                    Name (ONAM, "ASUSTEK")
                }

                Scope (\_SB.PCI0)
                {
                    Method (_INI, 0, NotSerialized)
                    {
                        \OSVR ()
                    }
                }

                Scope (\_SB.PCI0.SBRG)
                {
                    Device (EC0)
                    {
                        Name (_HID, EisaId ("PNP0C09"))
                        Name (_CRS, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0062, 0x0062, 0x00, 0x01)
                            IO (Decode16, 0x0066, 0x0066, 0x00, 0x01)
                        })
                        Name (_GPE, 0x1C)
                        Mutex (MUEC, 0x00)
                        Name (ECFL, Zero)
                        Method (ECAV, 0, NotSerialized)
                        {
                            Return (ECFL)
                        }

                        OperationRegion (ECOR, EmbeddedControl, 0x00, 0x80)
                        Field (ECOR, ByteAcc, Lock, Preserve)
                        {
                            Offset (0x04), 
                            CMD1,   8, 
                            CDT1,   8, 
                            CDT2,   8, 
                            CDT3,   8, 
                            Offset (0x43), 
                            P50I,   1, 
                                ,   1, 
                                ,   1, 
                            P43I,   1, 
                            P54I,   1, 
                            P55I,   1, 
                                ,   1, 
                            Offset (0x44), 
                            P54D,   8, 
                            P55D,   8, 
                            Offset (0x48), 
                            P54S,   8, 
                            P55S,   8, 
                            P50S,   8, 
                            P43S,   8, 
                            P54T,   8, 
                            P55T,   8, 
                            P50T,   8, 
                            P43T,   8, 
                            P60S,   8, 
                            P61S,   8, 
                            P62S,   8, 
                            P63S,   8, 
                            P64S,   8, 
                            P65S,   8, 
                            P66S,   8, 
                            P67S,   8, 
                            P60T,   8, 
                            P61T,   8, 
                            P62T,   8, 
                            P63T,   8, 
                            P64T,   8, 
                            P65T,   8, 
                            P66T,   8, 
                            P67T,   8, 
                            Offset (0x78), 
                            P60I,   1, 
                            P61I,   1, 
                            P62I,   1, 
                            P63I,   1, 
                            P64I,   1, 
                            P65I,   1, 
                            P66I,   1, 
                            P67I,   1
                        }

                        Name (SMBF, 0x00)
                        OperationRegion (SMBX, EmbeddedControl, 0x18, 0x28)
                        Field (SMBX, ByteAcc, NoLock, Preserve)
                        {
                            PRTC,   8, 
                            SSTS,   5, 
                                ,   1, 
                            ALFG,   1, 
                            CDFG,   1, 
                            ADDR,   8, 
                            CMDB,   8, 
                            BDAT,   256, 
                            BCNT,   8, 
                                ,   1, 
                            ALAD,   7, 
                            ALD0,   8, 
                            ALD1,   8
                        }

                        Field (SMBX, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x04), 
                            DAT0,   8, 
                            DAT1,   8
                        }

                        Field (SMBX, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x04), 
                            DT2B,   16
                        }

                        OperationRegion (NSBS, EmbeddedControl, 0x40, 0x04)
                        Field (NSBS, ByteAcc, NoLock, Preserve)
                        {
                            A2AD,   8, 
                            A2D0,   8, 
                            A2D1,   8, 
                            A3AD,   8
                        }

                        Method (_INI, 0, NotSerialized)
                        {
                            If (LNot (LGreater (\OSFG, \OSME)))
                            {
                                Store (One, ECFL)
                            }
                        }

                        Method (_REG, 2, NotSerialized)
                        {
                            If (LEqual (Arg0, 0x03))
                            {
                                Store (Arg1, ECFL)
                            }
                        }

                        Method (_Q01, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x52)
                            }
                        }

                        Method (_Q02, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x53)
                            }
                        }

                        Method (_Q03, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x54)
                            }
                        }

                        Method (_Q04, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x55)
                            }
                        }

                        Method (_Q05, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x56)
                            }
                        }

                        Method (_Q0A, 0, NotSerialized)
                        {
                            Notify (\_SB.SLPB, 0x80)
                        }

                        Method (_Q0B, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.P0P1.MPCI.MPDP ())
                            {
                                If (\_SB.ATKP)
                                {
                                    Notify (\_SB.ATKD, 0x5D)
                                }
                            }
                        }

                        Method (_Q0E, 0, NotSerialized)
                        {
                            If (LGreater (LBTN, 0x00))
                            {
                                Decrement (LBTN)
                            }

                            If (LGreater (LBTN, 0x0F))
                            {
                                Store (0x0F, LBTN)
                            }

                            STBR ()
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, Add (LBTN, 0x20))
                            }
                        }

                        Method (_Q0F, 0, NotSerialized)
                        {
                            If (LLess (LBTN, 0x0F))
                            {
                                Increment (LBTN)
                            }
                            Else
                            {
                                Store (0x0F, LBTN)
                            }

                            STBR ()
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, Add (LBTN, 0x10))
                            }
                        }

                        Method (_Q10, 0, NotSerialized)
                        {
                            Store (\BKLT, Local0)
                            XOr (Local0, 0x01, Local0)
                            Store (Local0, \BKLT)
                            If (\_SB.ATKP)
                            {
                                Subtract (0x34, \BKLT, Local0)
                                Notify (\_SB.ATKD, Local0)
                            }
                        }

                        Method (_Q11, 0, NotSerialized)
                        {
                            FHKW ()
                            Store (\ADVG (), Local0)
                            If (\NATK ())
                            {
                                Add (Local0, 0x60, Local1)
                                If (\_SB.ATKP)
                                {
                                    Notify (\_SB.ATKD, Local1)
                                }
                            }
                            Else
                            {
                                \SWHG (Local0)
                            }

                            FHKS ()
                        }

                        Name (FHKM, One)
                        Method (FHKW, 0, Serialized)
                        {
                            While (LNot (FHKM))
                            {
                                Sleep (0x0A)
                            }

                            Store (Zero, FHKM)
                        }

                        Method (FHKS, 0, Serialized)
                        {
                            Store (One, FHKM)
                        }

                        Method (_Q13, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x32)
                            }
                        }

                        Method (_Q14, 0, NotSerialized)
                        {
                            If (LLess (\AVOL, 0x0F))
                            {
                                Increment (\AVOL)
                            }

                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x31)
                            }
                        }

                        Method (_Q15, 0, NotSerialized)
                        {
                            If (LGreater (\AVOL, 0x00))
                            {
                                Decrement (\AVOL)
                            }

                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x30)
                            }
                        }

                        Method (_Q20, 0, NotSerialized)
                        {
                            If (CDFG)
                            {
                                Store (One, SMBF)
                                Store (Zero, CDFG)
                            }

                            If (ALFG)
                            {
                                \_SB.PCI0.SBRG.EC0.ALMH (ALAD)
                                Store (Zero, ALFG)
                            }
                        }

                        Method (_Q30, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x50)
                            }
                        }

                        Method (_Q31, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x51)
                            }
                        }

                        Method (_Q32, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x5C)
                            }
                        }

                        Method (_Q33, 0, NotSerialized)
                        {
                            If (\_SB.ATKP)
                            {
                                Notify (\_SB.ATKD, 0x6A)
                            }
                        }

                        Name (LEDS, Ones)
                        Method (EC0S, 1, NotSerialized)
                        {
                            If (LEqual (Arg0, 0x03))
                            {
                                STC5 (0x2C)
                            }

                            If (Arg0)
                            {
                                If (LLess (Arg0, 0x04))
                                {
                                    Store (RDC3 (0x02), Local0)
                                    And (Local0, 0xE0, LEDS)
                                    And (LEDS, 0x80, Local1)
                                    If (LNot (Local1))
                                    {
                                        STC5 (0x2F)
                                    }

                                    And (LEDS, 0x40, Local1)
                                    If (LNot (Local1))
                                    {
                                        STC5 (0x2E)
                                    }

                                    And (LEDS, 0x20, Local1)
                                    If (LNot (Local1))
                                    {
                                        STC5 (0x2D)
                                    }

                                    WCMD (0xCB)
                                    Store (0x01F4, Local0)
                                    While (Local0)
                                    {
                                        Stall (0x0A)
                                        Decrement (Local0)
                                    }
                                }
                            }
                        }

                        Method (EC0W, 1, NotSerialized)
                        {
                            If (LEqual (Arg0, 0x03))
                            {
                                STC5 (0x4C)
                            }

                            If (LEqual (Arg0, 0x04))
                            {
                                Store (ACAP (), \ACPF)
                            }

                            If (Arg0)
                            {
                                If (LLess (Arg0, 0x04))
                                {
                                    And (LEDS, 0x80, Local1)
                                    If (LNot (Local1))
                                    {
                                        STC5 (0x4F)
                                    }

                                    And (LEDS, 0x40, Local1)
                                    If (LNot (Local1))
                                    {
                                        STC5 (0x4E)
                                    }

                                    And (LEDS, 0x20, Local1)
                                    If (LNot (Local1))
                                    {
                                        STC5 (0x4D)
                                    }
                                }
                            }
                        }
                    }
                }

                Scope (\_SB.PCI0.SBRG.EC0)
                {
                    Method (WCMD, 1, Serialized)
                    {
                        If (ECAV ())
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Store (Arg0, CMD1)
                                Release (MUEC)
                            }
                        }
                        Else
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                ECWC (Arg0)
                                Release (MUEC)
                            }
                        }
                    }

                    Method (DLY0, 1, Serialized)
                    {
                        If (LNot (ECAV ()))
                        {
                            Return (Ones)
                        }

                        Store (Ones, Local0)
                        If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                        {
                            Store (Arg0, CDT1)
                            Store (0x6B, CDT2)
                            Store (0x00, CDT3)
                            Store (0xBB, CMD1)
                            Store (0x7F, Local1)
                            While (LAnd (Local1, CMD1))
                            {
                                Sleep (0x01)
                                Decrement (Local1)
                            }

                            If (LEqual (CMD1, Zero))
                            {
                                Store (CDT1, Local0)
                            }

                            Release (MUEC)
                        }

                        Return (Local0)
                    }

                    Name (PWAC, Buffer (0x10)
                    {
                        0x17, 0x2E, 0x3D, 0x49, 0x58, 0x60, 0x64, 0x68, 
                        0x6C, 0x70, 0x73, 0x77, 0x7B, 0x7F, 0x83, 0x87
                    })
                    Name (PWDC, Buffer (0x10)
                    {
                        0x0F, 0x26, 0x36, 0x41, 0x51, 0x58, 0x5C, 0x60, 
                        0x64, 0x68, 0x6C, 0x70, 0x73, 0x77, 0x7B, 0x7F
                    })
                    Method (STBR, 0, Serialized)
                    {
                        If (ACAP ())
                        {
                            Store (DerefOf (Index (PWAC, LBTN)), Local0)
                        }
                        Else
                        {
                            Store (DerefOf (Index (PWDC, LBTN)), Local0)
                        }

                        STC4 (Local0)
                    }

                    Method (STC4, 1, Serialized)
                    {
                        If (ECAV ())
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Store (Arg0, CDT1)
                                Store (0x85, CDT2)
                                Store (0xC4, CMD1)
                                Store (0x7F, Local0)
                                While (LAnd (Local0, CMD1))
                                {
                                    Sleep (0x01)
                                    Decrement (Local0)
                                }

                                If (LEqual (CMD1, Zero))
                                {
                                    Store (CDT1, Local0)
                                }
                                Else
                                {
                                    Store (Ones, Local0)
                                }

                                Release (MUEC)
                                Return (Local0)
                            }
                        }

                        Return (Ones)
                    }

                    Method (STDA, 1, Serialized)
                    {
                        If (ECAV ())
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Store (Arg0, CDT1)
                                Store (0xD0, CDT2)
                                Store (0xDA, CMD1)
                                Store (0x7F, Local0)
                                While (LAnd (Local0, CMD1))
                                {
                                    Sleep (0x01)
                                    Decrement (Local0)
                                }

                                If (LEqual (CMD1, Zero))
                                {
                                    Store (CDT1, Local0)
                                }
                                Else
                                {
                                    Store (Ones, Local0)
                                }

                                Release (MUEC)
                                Return (Local0)
                            }
                        }

                        Return (Ones)
                    }

                    Method (ACAP, 0, Serialized)
                    {
                        If (ECAV ())
                        {
                            Store (RDC3 (0x06), Local0)
                            While (LEqual (Local0, Ones))
                            {
                                Store (RDC3 (0x06), Local0)
                            }

                            And (Local0, 0x10, Local0)
                            ShiftRight (Local0, 0x04, Local0)
                            Return (Local0)
                        }
                        Else
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Store (ECRP (0x06), Local0)
                                ShiftRight (Local0, 0x04, Local0)
                                And (Local0, 0x01, Local0)
                                Release (MUEC)
                                Return (Local0)
                            }
                        }
                    }

                    Method (BATP, 1, Serialized)
                    {
                        If (ECAV ())
                        {
                            If (Arg0)
                            {
                                Store (RDC3 (0x04), Local0)
                                While (LEqual (Local0, Ones))
                                {
                                    Store (RDC3 (0x04), Local0)
                                }

                                And (Local0, 0x08, Local0)
                            }
                            Else
                            {
                                Store (RDC3 (0x05), Local0)
                                While (LEqual (Local0, Ones))
                                {
                                    Store (RDC3 (0x05), Local0)
                                }

                                And (Local0, 0x20, Local0)
                            }

                            If (Local0)
                            {
                                Return (Zero)
                            }
                            Else
                            {
                                Return (One)
                            }
                        }
                        Else
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                If (Arg0)
                                {
                                    Store (ECRP (0x04), Local0)
                                    ShiftRight (Local0, 0x03, Local0)
                                }
                                Else
                                {
                                    Store (ECRP (0x05), Local0)
                                    ShiftRight (Local0, 0x05, Local0)
                                }

                                And (Local0, 0x01, Local0)
                                Release (MUEC)
                                If (Local0)
                                {
                                    Return (Zero)
                                }
                                Else
                                {
                                    Return (One)
                                }
                            }
                        }
                    }

                    Method (CHGS, 0, Serialized)
                    {
                        Return (\PI27)
                    }

                    Method (STC5, 1, Serialized)
                    {
                        If (ECAV ())
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Store (Arg0, CDT1)
                                Store (0xC5, CMD1)
                                Store (0x7F, Local0)
                                While (LAnd (Local0, CMD1))
                                {
                                    Sleep (0x01)
                                    Decrement (Local0)
                                }

                                If (LEqual (CMD1, Zero))
                                {
                                    Store (CDT1, Local0)
                                }
                                Else
                                {
                                    Store (Ones, Local0)
                                }

                                Release (MUEC)
                                Return (Local0)
                            }
                        }
                        Else
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                ECSP (Arg0)
                                Release (MUEC)
                                Return (One)
                            }
                        }

                        Return (Ones)
                    }

                    Method (RDC3, 1, Serialized)
                    {
                        If (ECAV ())
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Store (Arg0, CDT1)
                                Store (0xC3, CMD1)
                                Store (0x7F, Local0)
                                While (LAnd (Local0, CMD1))
                                {
                                    Sleep (0x01)
                                    Decrement (Local0)
                                }

                                If (LEqual (CMD1, Zero))
                                {
                                    Store (CDT1, Local0)
                                }
                                Else
                                {
                                    Store (Ones, Local0)
                                }

                                Release (MUEC)
                                Return (Local0)
                            }
                        }
                        Else
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Store (ECRP (Arg0), Local0)
                                Release (MUEC)
                                Return (Local0)
                            }
                        }

                        Return (Ones)
                    }

                    Method (RBAT, 2, Serialized)
                    {
                        If (LNot (ECAV ()))
                        {
                            Return (Ones)
                        }

                        If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                        {
                            Store (0x03, Local0)
                            While (Local0)
                            {
                                Store (Arg0, CDT2)
                                Store (Arg1, Local1)
                                ShiftLeft (Local1, 0x01, Local1)
                                Add (Local1, 0xDA, Local1)
                                Store (Local1, CMD1)
                                Store (0x7F, Local1)
                                While (LAnd (CMD1, Local1))
                                {
                                    Decrement (Local1)
                                    Sleep (0x01)
                                }

                                If (LEqual (CMD1, 0x00))
                                {
                                    Store (CDT1, Local1)
                                    Store (Zero, Local0)
                                }
                                Else
                                {
                                    Store (Ones, Local1)
                                    Decrement (Local0)
                                }
                            }

                            Release (MUEC)
                            Return (Local1)
                        }

                        Return (Ones)
                    }

                    Method (FNCT, 2, Serialized)
                    {
                        If (ECAV ())
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Store (Arg0, CDT2)
                                Store (Arg1, CDT1)
                                Store (0xC4, CMD1)
                                Store (0x7F, Local0)
                                While (LAnd (Local0, CMD1))
                                {
                                    Sleep (0x01)
                                    Decrement (Local0)
                                }

                                Release (MUEC)
                            }
                        }
                    }

                    Name (WRQK, 0x02)
                    Name (RDQK, 0x03)
                    Name (SDBT, 0x04)
                    Name (RCBT, 0x05)
                    Name (WRBT, 0x06)
                    Name (RDBT, 0x07)
                    Name (WRWD, 0x08)
                    Name (RDWD, 0x09)
                    Name (WRBL, 0x0A)
                    Name (RDBL, 0x0B)
                    Name (PCLL, 0x0C)
                    Name (GOOD, 0x00)
                    Name (UKER, 0x07)
                    Name (DAER, 0x10)
                    Name (CMDN, 0x12)
                    Name (UKE2, 0x13)
                    Name (DADN, 0x17)
                    Name (SBTO, 0x18)
                    Name (USPT, 0x19)
                    Name (SBBY, 0x1A)
                    Method (SWTC, 1, NotSerialized)
                    {
                        Store (UKER, Local0)
                        Store (Arg0, Local1)
                        And (Local1, 0xFFFF, Local1)
                        While (Local1)
                        {
                            If (LEqual (SMBF, 0x00))
                            {
                                Sleep (0x0A)
                                If (LNot (LEqual (Local1, 0xFFFF)))
                                {
                                    Subtract (Local1, 0x0A, Local1)
                                }
                            }
                            Else
                            {
                                Store (Zero, Local1)
                                Store (SSTS, Local0)
                                Store (Zero, SMBF)
                            }
                        }

                        Return (Local0)
                    }

                    Method (SMBR, 3, NotSerialized)
                    {
                        Store (Package (0x03)
                            {
                                0x07, 
                                0x00, 
                                0x00
                            }, Local0)
                        If (LNot (ECAV ()))
                        {
                            Return (Local0)
                        }

                        If (LNot (LEqual (Arg0, RDBL)))
                        {
                            If (LNot (LEqual (Arg0, RDWD)))
                            {
                                If (LNot (LEqual (Arg0, RDBT)))
                                {
                                    If (LNot (LEqual (Arg0, RCBT)))
                                    {
                                        If (LNot (LEqual (Arg0, RDQK)))
                                        {
                                            Return (Local0)
                                        }
                                    }
                                }
                            }
                        }

                        If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                        {
                            Store (PRTC, Local1)
                            Store (Zero, Local2)
                            While (LNot (LEqual (Local1, 0x00)))
                            {
                                Stall (0x0A)
                                Increment (Local2)
                                If (LGreater (Local2, 0x03E8))
                                {
                                    Store (SBBY, Index (Local0, 0x00))
                                    Store (Zero, Local1)
                                }
                                Else
                                {
                                    Store (PRTC, Local1)
                                }
                            }

                            If (LNot (LGreater (Local2, 0x03E8)))
                            {
                                ShiftLeft (Arg1, 0x01, Local3)
                                Or (Local3, 0x01, Local3)
                                Store (Local3, ADDR)
                                If (LNot (LEqual (Arg0, RDQK)))
                                {
                                    If (LNot (LEqual (Arg0, RCBT)))
                                    {
                                        Store (Arg2, CMDB)
                                    }
                                }

                                Store (Arg0, PRTC)
                                Store (SWTC (0x07D0), Index (Local0, 0x00))
                                If (LEqual (DerefOf (Index (Local0, 0x00)), 0x00))
                                {
                                    If (LEqual (Arg0, RDBL))
                                    {
                                        Store (BCNT, Index (Local0, 0x01))
                                        Store (BDAT, Index (Local0, 0x02))
                                    }

                                    If (LEqual (Arg0, RDWD))
                                    {
                                        Store (0x02, Index (Local0, 0x01))
                                        Store (DT2B, Index (Local0, 0x02))
                                    }

                                    If (LEqual (Arg0, RDBT))
                                    {
                                        Store (0x01, Index (Local0, 0x01))
                                        Store (DAT0, Index (Local0, 0x02))
                                    }

                                    If (LEqual (Arg0, RCBT))
                                    {
                                        Store (0x01, Index (Local0, 0x01))
                                        Store (DAT0, Index (Local0, 0x02))
                                    }
                                }
                            }

                            Release (MUEC)
                        }

                        Return (Local0)
                    }

                    Method (SMBW, 5, NotSerialized)
                    {
                        Store (Package (0x01)
                            {
                                0x07
                            }, Local0)
                        If (LNot (ECAV ()))
                        {
                            Return (Local0)
                        }

                        If (LNot (LEqual (Arg0, WRBL)))
                        {
                            If (LNot (LEqual (Arg0, WRWD)))
                            {
                                If (LNot (LEqual (Arg0, WRBT)))
                                {
                                    If (LNot (LEqual (Arg0, SDBT)))
                                    {
                                        If (LNot (LEqual (Arg0, WRQK)))
                                        {
                                            Return (Local0)
                                        }
                                    }
                                }
                            }
                        }

                        If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                        {
                            Store (PRTC, Local1)
                            Store (Zero, Local2)
                            While (LNot (LEqual (Local1, 0x00)))
                            {
                                Stall (0x0A)
                                Increment (Local2)
                                If (LGreater (Local2, 0x03E8))
                                {
                                    Store (SBBY, Index (Local0, 0x00))
                                    Store (Zero, Local1)
                                }
                                Else
                                {
                                    Store (PRTC, Local1)
                                }
                            }

                            If (LNot (LGreater (Local2, 0x03E8)))
                            {
                                ShiftLeft (Arg1, 0x01, Local3)
                                Store (Local3, ADDR)
                                If (LNot (LEqual (Arg0, WRQK)))
                                {
                                    If (LNot (LEqual (Arg0, SDBT)))
                                    {
                                        Store (Arg2, CMDB)
                                    }
                                }

                                If (LEqual (Arg0, WRBL))
                                {
                                    Store (Arg3, BCNT)
                                    Store (Arg4, BDAT)
                                }

                                If (LEqual (Arg0, WRWD))
                                {
                                    Store (Arg4, DT2B)
                                }

                                If (LEqual (Arg0, WRBT))
                                {
                                    Store (Arg4, DAT0)
                                }

                                If (LEqual (Arg0, SDBT))
                                {
                                    Store (Arg4, DAT0)
                                }

                                Store (Arg0, PRTC)
                                Store (SWTC (0x07D0), Index (Local0, 0x00))
                            }

                            Release (MUEC)
                        }

                        Return (Local0)
                    }

                    OperationRegion (K62P, SystemIO, 0x62, 0x01)
                    Field (K62P, ByteAcc, NoLock, Preserve)
                    {
                        EC62,   8
                    }

                    OperationRegion (K66P, SystemIO, 0x66, 0x01)
                    Field (K66P, ByteAcc, NoLock, Preserve)
                    {
                        EC66,   8
                    }

                    Alias (\G12E, KSCE)
                    Alias (\G12S, KSCS)
                    Method (WEIE, 0, NotSerialized)
                    {
                        Store (0x4000, Local0)
                        And (EC66, 0x02, Local1)
                        While (LAnd (LNot (LEqual (Local0, Zero)), LEqual (Local1, 0x02)))
                        {
                            And (EC66, 0x02, Local1)
                            Decrement (Local0)
                        }
                    }

                    Method (WEOF, 0, NotSerialized)
                    {
                        Store (0x4000, Local0)
                        And (EC66, 0x01, Local1)
                        While (LAnd (LNot (LEqual (Local0, Zero)), LEqual (Local1, 0x00)))
                        {
                            And (EC66, 0x01, Local1)
                            Decrement (Local0)
                        }
                    }

                    Method (ECRD, 1, NotSerialized)
                    {
                        Store (KSCE, Local1)
                        Store (Zero, KSCE)
                        WEIE ()
                        Store (0x80, EC66)
                        WEIE ()
                        Store (Arg0, EC62)
                        WEOF ()
                        Store (EC62, Local0)
                        While (KSCS)
                        {
                            Store (One, KSCS)
                        }

                        Store (Local1, KSCE)
                        Return (Local0)
                    }

                    Method (ECWR, 2, NotSerialized)
                    {
                        Store (KSCE, Local1)
                        Store (Zero, KSCE)
                        WEIE ()
                        Store (0x81, EC66)
                        WEIE ()
                        Store (Arg0, EC62)
                        WEIE ()
                        Store (Arg1, EC62)
                        WEIE ()
                        While (KSCS)
                        {
                            Store (One, KSCS)
                        }

                        Store (Local1, KSCE)
                    }

                    Method (ECWC, 1, NotSerialized)
                    {
                        Store (KSCE, Local1)
                        Store (Zero, KSCE)
                        WEIE ()
                        Store (0x81, EC66)
                        WEIE ()
                        Store (0x04, EC62)
                        WEIE ()
                        Store (Arg0, EC62)
                        While (KSCS)
                        {
                            Store (One, KSCS)
                        }

                        Store (Local1, KSCE)
                    }

                    Method (ECQR, 0, NotSerialized)
                    {
                        Store (KSCE, Local1)
                        Store (Zero, KSCE)
                        WEIE ()
                        Store (0x84, EC66)
                        WEIE ()
                        WEOF ()
                        Store (EC62, Local0)
                        While (KSCS)
                        {
                            Store (One, KSCS)
                        }

                        Store (Local1, KSCE)
                        Return (Local0)
                    }

                    Method (ECRP, 1, NotSerialized)
                    {
                        ECWR (0x05, Arg0)
                        ECWR (0x04, 0xC3)
                        While (ECRD (0x04)) {}
                        Return (ECRD (0x05))
                    }

                    Method (ECSP, 1, NotSerialized)
                    {
                        ECWR (0x05, Arg0)
                        ECWR (0x04, 0xC5)
                        While (ECRD (0x04)) {}
                    }
                }

                Scope (\_SB.PCI0.SBRG.EC0)
                {
                    Method (_Q69, 0, NotSerialized)
                    {
                        If (\_SB.ATKP)
                        {
                            Notify (\_SB.ATKD, 0x40)
                        }
                    }

                    Method (_Q6A, 0, NotSerialized)
                    {
                        If (\_SB.ATKP)
                        {
                            Notify (\_SB.ATKD, 0x41)
                        }
                    }

                    Method (_Q6B, 0, NotSerialized)
                    {
                        If (\_SB.ATKP)
                        {
                            Notify (\_SB.ATKD, 0x43)
                        }
                    }

                    Method (_Q6C, 0, NotSerialized)
                    {
                        If (\_SB.ATKP)
                        {
                            Notify (\_SB.ATKD, 0x45)
                        }
                    }
                }

                Scope (\_SB.PCI0)
                {
                    Device (AC0)
                    {
                        Name (_HID, "ACPI0003")
                        Method (_PSR, 0, NotSerialized)
                        {
                            Return (\_SB.PCI0.SBRG.EC0.ACAP ())
                        }

                        Name (_PCL, Package (0x01)
                        {
                            \_SB.PCI0
                        })
                    }
                }

                Scope (\_SB.PCI0.SBRG.EC0)
                {
                    Method (_Q34, 0, NotSerialized)
                    {
                        STBR ()
                        If (ACAP ())
                        {
                            Store (One, \ACPF)
                            Store (0x58, Local0)
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                And (P64S, 0xEF, P64S)
                                Release (MUEC)
                            }
                        }
                        Else
                        {
                            Store (Zero, \ACPF)
                            Store (0x57, Local0)
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Or (P64S, 0x10, P64S)
                                Release (MUEC)
                            }
                        }

                        Notify (\_SB.PCI0.AC0, 0x80)
                        NBAT (0x80)
                        If (\_SB.ATKP)
                        {
                            Notify (\_SB.ATKD, Local0)
                        }

                        Notify (\_PR.CPU1, 0x80)
                        Notify (\_PR.CPU1, 0x81)
                    }
                }

                Scope (\_SB.PCI0)
                {
                    Device (BAT0)
                    {
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_UID, 0x00)
                        Name (_PCL, Package (0x01)
                        {
                            \_SB.PCI0
                        })
                        Method (_STA, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.SBRG.EC0.BATP (0x00))
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }

                        Name (LOW2, 0x012C)
                        Name (DVOT, 0x0E)
                        Name (PUNT, One)
                        Name (LFCC, 0x1770)
                        Name (NBIF, Package (0x0D)
                        {
                            0x00, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0x01, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            "", 
                            "", 
                            "", 
                            ""
                        })
                        Name (PBIF, Package (0x0D)
                        {
                            0x01, 
                            0x1770, 
                            0x1770, 
                            0x01, 
                            0x39D0, 
                            0x0258, 
                            0x012C, 
                            0x3C, 
                            0x3C, 
                            "M3N", 
                            " ", 
                            "LIon", 
                            "ASUSTek"
                        })
                        Name (PBST, Package (0x04)
                        {
                            0x00, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Method (FBIF, 5, NotSerialized)
                        {
                            Store (Arg0, PUNT)
                            Store (Arg1, Local1)
                            Store (Arg2, Local2)
                            If (LEqual (PUNT, 0x00))
                            {
                                Multiply (Local1, 0x0A, Local1)
                                Multiply (Local2, 0x0A, Local2)
                            }

                            Store (Arg0, Index (PBIF, 0x00))
                            Store (Local1, Index (PBIF, 0x01))
                            Store (Local2, Index (PBIF, 0x02))
                            Store (Local2, LFCC)
                            Store (Arg3, Index (PBIF, 0x03))
                            Store (Arg4, Index (PBIF, 0x04))
                            Divide (Local1, 0x0A, Local3, Local5)
                            Store (Local5, Index (PBIF, 0x05))
                            ShiftRight (Local5, 0x01, Local6)
                            Store (Local6, Index (PBIF, 0x06))
                            Store (Local6, LOW2)
                            Divide (Local1, 0x64, Local3, Local7)
                            Store (Local7, Index (PBIF, 0x07))
                            Store (Local7, Index (PBIF, 0x08))
                        }

                        Method (CBIF, 0, NotSerialized)
                        {
                            If (PUNT)
                            {
                                Store (DerefOf (Index (PBIF, 0x04)), Local0)
                                Add (Local0, 0x01F4, Local0)
                                Divide (Local0, 0x03E8, Local1, DVOT)
                                Store (Zero, Index (PBIF, 0x00))
                                Multiply (DerefOf (Index (PBIF, 0x01)), DVOT, Index (PBIF, 0x01))
                                Multiply (DerefOf (Index (PBIF, 0x02)), DVOT, Index (PBIF, 0x02))
                                Multiply (DerefOf (Index (PBIF, 0x05)), DVOT, Index (PBIF, 0x05))
                                Multiply (DerefOf (Index (PBIF, 0x06)), DVOT, Index (PBIF, 0x06))
                                Multiply (DerefOf (Index (PBIF, 0x07)), DVOT, Index (PBIF, 0x07))
                                Multiply (DerefOf (Index (PBIF, 0x08)), DVOT, Index (PBIF, 0x08))
                            }
                        }

                        Method (_BIF, 0, NotSerialized)
                        {
                            If (LNot (\_SB.PCI0.SBRG.EC0.BATP (0x00)))
                            {
                                Return (NBIF)
                            }

                            \_SB.PCI0.SBRG.EC0.BATS (0x00)
                            Store (\MNAM, Index (PBIF, 0x09))
                            Store (\ONAM, Index (PBIF, 0x0C))
                            Store (\_SB.PCI0.SBRG.EC0.BIF0 (), Local0)
                            Store (\_SB.PCI0.SBRG.EC0.BIF1 (), Local1)
                            Store (\_SB.PCI0.SBRG.EC0.BIF2 (), Local2)
                            Store (\_SB.PCI0.SBRG.EC0.BIF3 (), Local3)
                            Store (\_SB.PCI0.SBRG.EC0.BIF4 (), Local4)
                            \_SB.PCI0.SBRG.EC0.BATR ()
                            If (LNot (LEqual (Local0, Ones)))
                            {
                                If (LNot (LEqual (Local1, Ones)))
                                {
                                    If (LNot (LEqual (Local2, Ones)))
                                    {
                                        If (LNot (LEqual (Local3, Ones)))
                                        {
                                            If (LNot (LEqual (Local4, Ones)))
                                            {
                                                FBIF (Local0, Local1, Local2, Local3, Local4)
                                                CBIF ()
                                            }
                                        }
                                    }
                                }
                            }

                            If (LEqual (PUNT, 0x00))
                            {
                                Multiply (Local2, 0x0A, Local2)
                            }

                            Store (Local2, LFCC)
                            Return (PBIF)
                        }

                        Method (FBST, 4, NotSerialized)
                        {
                            And (Arg1, 0xFFFF, Local1)
                            If (\_SB.PCI0.SBRG.EC0.ACAP ())
                            {
                                If (LAnd (LGreater (Local1, 0xA0), LLess (Local1, 0x8000)))
                                {
                                    Store (0x02, Local0)
                                }
                                Else
                                {
                                    Store (0x01, Local0)
                                }
                            }
                            Else
                            {
                                Store (0x01, Local0)
                            }

                            And (Arg0, 0x0300, Local2)
                            If (Local2)
                            {
                                ShiftLeft (One, 0x02, Local2)
                                Or (Local0, Local2, Local0)
                            }

                            If (LNot (LLess (Local1, 0x8000)))
                            {
                                Subtract (0xFFFF, Local1, Local1)
                            }

                            Store (Arg2, Local2)
                            If (LEqual (PUNT, 0x00))
                            {
                                Multiply (Local1, DVOT, Local1)
                                Multiply (Local2, 0x0A, Local2)
                            }

                            And (Local0, 0x02, Local3)
                            If (LNot (Local3))
                            {
                                Subtract (LFCC, Local2, Local3)
                                Divide (LFCC, 0xC8, Local4, Local5)
                                If (LLess (Local3, Local5))
                                {
                                    Store (LFCC, Local2)
                                }
                            }

                            Store (Local0, Index (PBST, 0x00))
                            Store (Local1, Index (PBST, 0x01))
                            Store (Local2, Index (PBST, 0x02))
                            Store (Arg3, Index (PBST, 0x03))
                        }

                        Method (CBST, 0, NotSerialized)
                        {
                            If (PUNT)
                            {
                                Multiply (DerefOf (Index (PBST, 0x01)), DVOT, Index (PBST, 0x01))
                                Multiply (DerefOf (Index (PBST, 0x02)), DVOT, Index (PBST, 0x02))
                            }
                        }

                        Method (_BST, 0, NotSerialized)
                        {
                            If (LNot (\_SB.PCI0.SBRG.EC0.BATP (0x00)))
                            {
                                Store (Zero, Index (PBST, 0x00))
                                Store (Ones, Index (PBST, 0x01))
                                Store (Ones, Index (PBST, 0x02))
                                Store (Ones, Index (PBST, 0x03))
                                Return (PBST)
                            }

                            \_SB.PCI0.SBRG.EC0.BATS (0x00)
                            Store (\_SB.PCI0.SBRG.EC0.BSTS (), Local0)
                            Store (\_SB.PCI0.SBRG.EC0.BCRT (), Local1)
                            Store (\_SB.PCI0.SBRG.EC0.BRCP (), Local2)
                            Store (\_SB.PCI0.SBRG.EC0.BVOT (), Local3)
                            \_SB.PCI0.SBRG.EC0.BATR ()
                            If (LNot (LEqual (Local0, Ones)))
                            {
                                If (LNot (LEqual (Local1, Ones)))
                                {
                                    If (LNot (LEqual (Local2, Ones)))
                                    {
                                        If (LNot (LEqual (Local3, Ones)))
                                        {
                                            FBST (Local0, Local1, Local2, Local3)
                                            CBST ()
                                        }
                                    }
                                }
                            }

                            Return (PBST)
                        }
                    }

                    Device (BAT1)
                    {
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_UID, 0x01)
                        Name (_PCL, Package (0x01)
                        {
                            \_SB.PCI0
                        })
                        Method (_STA, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.SBRG.EC0.BATP (0x01))
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }

                        Name (LOW2, 0x012C)
                        Name (DVOT, 0x0E)
                        Name (PUNT, One)
                        Name (LFCC, 0x1770)
                        Name (NBIF, Package (0x0D)
                        {
                            0x00, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0x01, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            "", 
                            "", 
                            "", 
                            ""
                        })
                        Name (PBIF, Package (0x0D)
                        {
                            0x01, 
                            0x1770, 
                            0x1770, 
                            0x01, 
                            0x39D0, 
                            0x0258, 
                            0x012C, 
                            0x3C, 
                            0x3C, 
                            "M3N", 
                            " ", 
                            "LIon", 
                            "ASUSTek"
                        })
                        Name (PBST, Package (0x04)
                        {
                            0x00, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Method (FBIF, 5, NotSerialized)
                        {
                            Store (Arg0, PUNT)
                            Store (Arg1, Local1)
                            Store (Arg2, Local2)
                            If (LEqual (PUNT, 0x00))
                            {
                                Multiply (Local1, 0x0A, Local1)
                                Multiply (Local2, 0x0A, Local2)
                            }

                            Store (Arg0, Index (PBIF, 0x00))
                            Store (Local1, Index (PBIF, 0x01))
                            Store (Local2, Index (PBIF, 0x02))
                            Store (Local2, LFCC)
                            Store (Arg3, Index (PBIF, 0x03))
                            Store (Arg4, Index (PBIF, 0x04))
                            Divide (Local1, 0x0A, Local3, Local5)
                            Store (Local5, Index (PBIF, 0x05))
                            ShiftRight (Local5, 0x01, Local6)
                            Store (Local6, Index (PBIF, 0x06))
                            Store (Local6, LOW2)
                            Divide (Local1, 0x64, Local3, Local7)
                            Store (Local7, Index (PBIF, 0x07))
                            Store (Local7, Index (PBIF, 0x08))
                        }

                        Method (CBIF, 0, NotSerialized)
                        {
                            If (PUNT)
                            {
                                Store (DerefOf (Index (PBIF, 0x04)), Local0)
                                Add (Local0, 0x01F4, Local0)
                                Divide (Local0, 0x03E8, Local1, DVOT)
                                Store (Zero, Index (PBIF, 0x00))
                                Multiply (DerefOf (Index (PBIF, 0x01)), DVOT, Index (PBIF, 0x01))
                                Multiply (DerefOf (Index (PBIF, 0x02)), DVOT, Index (PBIF, 0x02))
                                Multiply (DerefOf (Index (PBIF, 0x05)), DVOT, Index (PBIF, 0x05))
                                Multiply (DerefOf (Index (PBIF, 0x06)), DVOT, Index (PBIF, 0x06))
                                Multiply (DerefOf (Index (PBIF, 0x07)), DVOT, Index (PBIF, 0x07))
                                Multiply (DerefOf (Index (PBIF, 0x08)), DVOT, Index (PBIF, 0x08))
                            }
                        }

                        Method (_BIF, 0, NotSerialized)
                        {
                            If (LNot (\_SB.PCI0.SBRG.EC0.BATP (0x01)))
                            {
                                Return (NBIF)
                            }

                            Store (\MNAM, Index (PBIF, 0x09))
                            Store (\ONAM, Index (PBIF, 0x0C))
                            \_SB.PCI0.SBRG.EC0.BATS (0x01)
                            Store (\_SB.PCI0.SBRG.EC0.BIF0 (), Local0)
                            Store (\_SB.PCI0.SBRG.EC0.BIF1 (), Local1)
                            Store (\_SB.PCI0.SBRG.EC0.BIF2 (), Local2)
                            Store (\_SB.PCI0.SBRG.EC0.BIF3 (), Local3)
                            Store (\_SB.PCI0.SBRG.EC0.BIF4 (), Local4)
                            \_SB.PCI0.SBRG.EC0.BATR ()
                            If (LNot (LEqual (Local0, Ones)))
                            {
                                If (LNot (LEqual (Local1, Ones)))
                                {
                                    If (LNot (LEqual (Local2, Ones)))
                                    {
                                        If (LNot (LEqual (Local3, Ones)))
                                        {
                                            If (LNot (LEqual (Local4, Ones)))
                                            {
                                                FBIF (Local0, Local1, Local2, Local3, Local4)
                                                CBIF ()
                                            }
                                        }
                                    }
                                }
                            }

                            If (LEqual (PUNT, 0x00))
                            {
                                Multiply (Local2, 0x0A, Local2)
                            }

                            Store (Local2, LFCC)
                            Return (PBIF)
                        }

                        Method (FBST, 4, NotSerialized)
                        {
                            And (Arg1, 0xFFFF, Local1)
                            If (\_SB.PCI0.SBRG.EC0.ACAP ())
                            {
                                If (LAnd (LGreater (Local1, 0xA0), LLess (Local1, 0x8000)))
                                {
                                    Store (0x02, Local0)
                                }
                                Else
                                {
                                    Store (0x01, Local0)
                                }
                            }
                            Else
                            {
                                Store (0x01, Local0)
                            }

                            And (Arg0, 0x0300, Local2)
                            If (Local2)
                            {
                                ShiftLeft (One, 0x02, Local2)
                                Or (Local0, Local2, Local0)
                            }

                            If (LNot (LLess (Local1, 0x8000)))
                            {
                                Subtract (0xFFFF, Local1, Local1)
                            }

                            Store (Arg2, Local2)
                            If (LEqual (PUNT, 0x00))
                            {
                                Multiply (Local1, DVOT, Local1)
                                Multiply (Local2, 0x0A, Local2)
                            }

                            And (Local0, 0x02, Local3)
                            If (LNot (Local3))
                            {
                                Subtract (LFCC, Local2, Local3)
                                Divide (LFCC, 0xC8, Local4, Local5)
                                If (LLess (Local3, Local5))
                                {
                                    Store (LFCC, Local2)
                                }
                            }

                            Store (Local0, Index (PBST, 0x00))
                            Store (Local1, Index (PBST, 0x01))
                            Store (Local2, Index (PBST, 0x02))
                            Store (Arg3, Index (PBST, 0x03))
                        }

                        Method (CBST, 0, NotSerialized)
                        {
                            If (PUNT)
                            {
                                Multiply (DerefOf (Index (PBST, 0x01)), DVOT, Index (PBST, 0x01))
                                Multiply (DerefOf (Index (PBST, 0x02)), DVOT, Index (PBST, 0x02))
                            }
                        }

                        Method (_BST, 0, NotSerialized)
                        {
                            If (LNot (\_SB.PCI0.SBRG.EC0.BATP (0x01)))
                            {
                                Store (Zero, Index (PBST, 0x00))
                                Store (Ones, Index (PBST, 0x01))
                                Store (Ones, Index (PBST, 0x02))
                                Store (Ones, Index (PBST, 0x03))
                                Return (PBST)
                            }

                            \_SB.PCI0.SBRG.EC0.BATS (0x01)
                            Store (\_SB.PCI0.SBRG.EC0.BSTS (), Local0)
                            Store (\_SB.PCI0.SBRG.EC0.BCRT (), Local1)
                            Store (\_SB.PCI0.SBRG.EC0.BRCP (), Local2)
                            Store (\_SB.PCI0.SBRG.EC0.BVOT (), Local3)
                            \_SB.PCI0.SBRG.EC0.BATR ()
                            If (LNot (LEqual (Local0, Ones)))
                            {
                                If (LNot (LEqual (Local1, Ones)))
                                {
                                    If (LNot (LEqual (Local2, Ones)))
                                    {
                                        If (LNot (LEqual (Local3, Ones)))
                                        {
                                            FBST (Local0, Local1, Local2, Local3)
                                            CBST ()
                                        }
                                    }
                                }
                            }

                            Return (PBST)
                        }
                    }
                }

                Scope (\_SB.PCI0.SBRG.EC0)
                {
                    Method (_Q2F, 0, NotSerialized)
                    {
                        If (LNot (BATP (0x00)))
                        {
                            Store (Zero, \DCPF)
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                And (P55S, 0xEF, P55S)
                                Release (MUEC)
                            }
                        }
                        Else
                        {
                            Store (One, \DCPF)
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Or (P55S, 0x10, P55S)
                                Release (MUEC)
                            }
                        }

                        Notify (\_SB.PCI0.BAT0, 0x01)
                        Notify (\_SB.PCI0.BAT0, 0x81)
                        Notify (\_SB.PCI0.AC0, 0x80)
                    }

                    Method (_Q51, 0, NotSerialized)
                    {
                        If (LNot (BATP (0x01)))
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                And (P43S, 0xEF, P43S)
                                Release (MUEC)
                            }
                        }
                        Else
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Or (P43S, 0x10, P43S)
                                Release (MUEC)
                            }
                        }

                        Notify (\_SB.PCI0.BAT1, 0x01)
                        Notify (\_SB.PCI0.BAT1, 0x81)
                        Notify (\_SB.PCI0.AC0, 0x80)
                    }

                    Method (_Q50, 0, NotSerialized)
                    {
                        If (\_SB.ATKP)
                        {
                            Notify (\_SB.ATKD, 0x6E)
                        }
                        Else
                        {
                            If (BATP (0x00))
                            {
                                Notify (\_SB.PCI0.BAT0, 0x80)
                            }

                            If (BATP (0x01))
                            {
                                Notify (\_SB.PCI0.BAT1, 0x80)
                            }
                        }
                    }

                    Method (NBAT, 1, NotSerialized)
                    {
                        If (BATP (0x00))
                        {
                            Notify (\_SB.PCI0.BAT0, Arg0)
                        }

                        If (BATP (0x01))
                        {
                            Notify (\_SB.PCI0.BAT1, Arg0)
                        }
                    }

                    Mutex (MMPX, 0x00)
                    Method (BATS, 1, Serialized)
                    {
                        Acquire (MMPX, 0xFFFF)
                        If (LEqual (Arg0, 0x00))
                        {
                            \_SB.PCI0.SBRG.EC0.STC5 (0x4B)
                        }
                        Else
                        {
                            \_SB.PCI0.SBRG.EC0.STC5 (0x2B)
                        }
                    }

                    Method (BATR, 0, Serialized)
                    {
                        Release (MMPX)
                    }

                    Name (BADR, 0x0B)
                    Name (CADR, 0x09)
                    Name (SADR, 0x0A)
                    Method (ALMH, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, BADR))
                        {
                            NBAT (0x80)
                        }
                    }

                    Method (BIFW, 1, NotSerialized)
                    {
                        Store (SMBR (RDWD, BADR, Arg0), Local0)
                        Store (DerefOf (Index (Local0, 0x00)), Local1)
                        If (Local1)
                        {
                            Return (Ones)
                        }
                        Else
                        {
                            Return (DerefOf (Index (Local0, 0x02)))
                        }
                    }

                    Method (BIF0, 0, NotSerialized)
                    {
                        Store (One, Local1)
                        Store (One, Local2)
                        While (And (LNot (LEqual (Local1, 0x00)), LNot (LGreater (Local2, 0x03))))
                        {
                            Store (SMBR (RDWD, BADR, 0x03), Local0)
                            Store (DerefOf (Index (Local0, 0x00)), Local1)
                            Increment (Local2)
                        }

                        If (Local1)
                        {
                            Return (Ones)
                        }
                        Else
                        {
                            Store (DerefOf (Index (Local0, 0x02)), Local2)
                            ShiftRight (Local2, 0x0F, Local2)
                            And (Local2, 0x01, Local2)
                            XOr (Local2, 0x01, Local2)
                            Return (Local2)
                        }
                    }

                    Method (BIF1, 0, NotSerialized)
                    {
                        Store (Ones, Local1)
                        Store (One, Local0)
                        While (And (LEqual (Local1, Ones), LNot (LGreater (Local0, 0x03))))
                        {
                            Store (BIFW (0x18), Local1)
                            Increment (Local0)
                        }

                        Return (Local1)
                    }

                    Method (BIF2, 0, NotSerialized)
                    {
                        Store (Ones, Local1)
                        Store (One, Local0)
                        While (And (LEqual (Local1, Ones), LNot (LGreater (Local0, 0x03))))
                        {
                            Store (BIFW (0x10), Local1)
                            Increment (Local0)
                        }

                        Return (Local1)
                    }

                    Method (BIF3, 0, NotSerialized)
                    {
                        Store (Ones, Local1)
                        Store (One, Local0)
                        While (And (LEqual (Local1, Ones), LNot (LGreater (Local0, 0x03))))
                        {
                            Store (BIFW (0x03), Local1)
                            Increment (Local0)
                        }

                        If (LNot (LEqual (Local1, Ones)))
                        {
                            ShiftRight (Local1, 0x09, Local1)
                            And (Local1, 0x01, Local1)
                            XOr (Local1, 0x01, Local1)
                        }

                        Return (Local1)
                    }

                    Method (BIF4, 0, NotSerialized)
                    {
                        Store (Ones, Local1)
                        Store (One, Local0)
                        While (And (LEqual (Local1, Ones), LNot (LGreater (Local0, 0x03))))
                        {
                            Store (BIFW (0x19), Local1)
                            Increment (Local0)
                        }

                        Return (Local1)
                    }

                    Method (BIF9, 0, NotSerialized)
                    {
                        Name (BSTR, Buffer (0x20) {})
                        Store (SMBR (RDBL, BADR, 0x21), Local0)
                        If (LNot (LEqual (DerefOf (Index (Local0, 0x00)), 0x00)))
                        {
                            Store (\MNAM, BSTR)
                            Store (0x00, Index (BSTR, 0x04))
                        }
                        Else
                        {
                            Store (DerefOf (Index (Local0, 0x02)), BSTR)
                            Store (0x00, Index (BSTR, DerefOf (Index (Local0, 0x01))))
                        }

                        Return (BSTR)
                    }

                    Method (BSTS, 0, NotSerialized)
                    {
                        Return (BIFW (0x16))
                    }

                    Method (BCRT, 0, NotSerialized)
                    {
                        Return (BIFW (0x0A))
                    }

                    Method (BRCP, 0, NotSerialized)
                    {
                        Return (BIFW (0x0F))
                    }

                    Method (BVOT, 0, NotSerialized)
                    {
                        Return (BIFW (0x09))
                    }
                }

                Scope (\_SB)
                {
                    Device (SLPB)
                    {
                        Name (_HID, EisaId ("PNP0C0E"))
                        Method (_PRW, 0, NotSerialized)
                        {
                            Return (Package (0x02)
                            {
                                0x0A, 
                                0x04
                            })
                        }
                    }
                }

                Scope (\_GPE)
                {
                    Method (_L0A, 0, NotSerialized)
                    {
                        Notify (\_SB.SLPB, 0x02)
                    }
                }

                Scope (\_SB)
                {
                    Device (LID)
                    {
                        Name (_HID, EisaId ("PNP0C0D"))
                        Method (_LID, 0, NotSerialized)
                        {
                            Return (\LIDL)
                        }
                    }
                }

                Scope (\_GPE)
                {
                    Method (_L1B, 0, Serialized)
                    {
                        XOr (\LIDL, 0x01, \LIDL)
                        Notify (\_SB.LID, 0x80)
                    }
                }

                Scope (\)
                {
                    OperationRegion (SMB0, SystemIO, SMBS, 0x10)
                    Field (SMB0, ByteAcc, NoLock, Preserve)
                    {
                        HSTS,   8, 
                        SSTS,   8, 
                        HSTC,   8, 
                        HCMD,   8, 
                        HADR,   8, 
                        HDT0,   8, 
                        HDT1,   8, 
                        BLKD,   8, 
                        SLCT,   8, 
                        SHCM,   8, 
                        SLEV,   16, 
                        SLDT,   16, 
                        SCFG,   8, 
                        SADR,   8
                    }

                    Name (RBUF, Package (0x20) {})
                    Method (HBSY, 0, NotSerialized)
                    {
                        Store (0x00FFFFFF, Local0)
                        While (Local0)
                        {
                            And (HSTS, 0x01, Local1)
                            If (LNot (Local1))
                            {
                                Return (Zero)
                            }

                            Decrement (Local0)
                        }

                        Return (One)
                    }

                    Method (WTSB, 0, NotSerialized)
                    {
                        Store (0x00FFFFFF, Local0)
                        While (Local0)
                        {
                            Decrement (Local0)
                            And (HSTS, 0x1E, Local1)
                            If (LEqual (Local1, 0x02))
                            {
                                Return (One)
                            }

                            If (Local1)
                            {
                                Return (Zero)
                            }
                        }

                        Return (Zero)
                    }

                    Mutex (\P4SM, 0x00)
                    Method (SBYT, 2, Serialized)
                    {
                        If (LNot (LEqual (Acquire (\P4SM, 0xFFFF), 0x00)))
                        {
                            Return (Ones)
                        }

                        Store (0x05, Local0)
                        While (Local0)
                        {
                            If (HBSY ())
                            {
                                Decrement (Local0)
                            }
                            Else
                            {
                                Store (Arg0, HADR)
                                Store (Arg1, HCMD)
                                Store (0xFF, HSTS)
                                Store (0x44, HSTC)
                                If (WTSB ())
                                {
                                    Release (\P4SM)
                                    Return (One)
                                }
                                Else
                                {
                                    Decrement (Local0)
                                }
                            }
                        }

                        Release (\P4SM)
                        Return (Ones)
                    }

                    Method (WBYT, 3, Serialized)
                    {
                        If (LNot (LEqual (Acquire (\P4SM, 0xFFFF), 0x00)))
                        {
                            Return (Ones)
                        }

                        Store (0x05, Local0)
                        While (Local0)
                        {
                            If (HBSY ())
                            {
                                Decrement (Local0)
                            }
                            Else
                            {
                                Store (Arg0, HADR)
                                Store (Arg1, HCMD)
                                Store (Arg2, HDT0)
                                Store (0xFF, HSTS)
                                Store (0x48, HSTC)
                                If (WTSB ())
                                {
                                    Release (\P4SM)
                                    Return (One)
                                }
                                Else
                                {
                                    Decrement (Local0)
                                }
                            }
                        }

                        Release (\P4SM)
                        Return (Ones)
                    }

                    Method (WWRD, 4, Serialized)
                    {
                        If (LNot (LEqual (Acquire (\P4SM, 0xFFFF), 0x00)))
                        {
                            Return (Ones)
                        }

                        Store (0x05, Local0)
                        While (Local0)
                        {
                            If (HBSY ())
                            {
                                Decrement (Local0)
                            }
                            Else
                            {
                                Store (Arg0, HADR)
                                Store (Arg1, HCMD)
                                And (Arg2, 0xFF, Local1)
                                ShiftRight (Arg2, 0x08, Local2)
                                And (Local2, 0xFF, Local2)
                                Store (Local2, HDT0)
                                Store (Local1, HDT1)
                                Store (0xFF, HSTS)
                                Store (0x4C, HSTC)
                                If (WTSB ())
                                {
                                    Release (\P4SM)
                                    Return (One)
                                }
                                Else
                                {
                                    Decrement (Local0)
                                }
                            }
                        }

                        Release (\P4SM)
                        Return (Ones)
                    }

                    Method (WBLK, 4, Serialized)
                    {
                        If (LNot (LEqual (Acquire (\P4SM, 0xFFFF), 0x00)))
                        {
                            Return (Ones)
                        }

                        Store (0x05, Local0)
                        While (Local0)
                        {
                            If (HBSY ())
                            {
                                Decrement (Local0)
                            }
                            Else
                            {
                                Store (Arg0, HADR)
                                Store (Arg1, HCMD)
                                Store (HSTC, Local1)
                                Store (Arg2, Local2)
                                Store (0x00, Local1)
                                While (Local2)
                                {
                                    Store (DerefOf (Index (Arg3, Local1)), BLKD)
                                    Decrement (Local2)
                                    Increment (Local1)
                                }

                                Store (Arg2, HDT0)
                                Store (HSTC, Local1)
                                Store (0xFF, HSTS)
                                Store (0x54, HSTC)
                                If (WTSB ())
                                {
                                    Release (\P4SM)
                                    Return (One)
                                }
                                Else
                                {
                                    Decrement (Local0)
                                }
                            }
                        }

                        Release (\P4SM)
                        Return (Ones)
                    }

                    Method (RSBT, 2, Serialized)
                    {
                        If (LNot (LEqual (Acquire (\P4SM, 0xFFFF), 0x00)))
                        {
                            Return (Ones)
                        }

                        Store (0x05, Local0)
                        While (Local0)
                        {
                            If (HBSY ())
                            {
                                Decrement (Local0)
                            }
                            Else
                            {
                                Or (Arg0, 0x01, HADR)
                                Store (Arg1, HCMD)
                                Store (0xFF, HSTS)
                                Store (0x44, HSTC)
                                If (WTSB ())
                                {
                                    Release (\P4SM)
                                    Return (HDT0)
                                }
                                Else
                                {
                                    Decrement (Local0)
                                }
                            }
                        }

                        Release (\P4SM)
                        Return (Ones)
                    }

                    Method (RBYT, 2, Serialized)
                    {
                        If (LNot (LEqual (Acquire (\P4SM, 0xFFFF), 0x00)))
                        {
                            Return (Ones)
                        }

                        Store (0x05, Local0)
                        While (Local0)
                        {
                            If (HBSY ())
                            {
                                Decrement (Local0)
                            }
                            Else
                            {
                                Or (Arg0, 0x01, HADR)
                                Store (Arg1, HCMD)
                                Store (0xFF, HSTS)
                                Store (0x48, HSTC)
                                If (WTSB ())
                                {
                                    Release (\P4SM)
                                    Return (HDT0)
                                }
                                Else
                                {
                                    Decrement (Local0)
                                }
                            }
                        }

                        Release (\P4SM)
                        Return (Ones)
                    }

                    Method (RWRD, 2, Serialized)
                    {
                        If (LNot (LEqual (Acquire (\P4SM, 0xFFFF), 0x00)))
                        {
                            Return (Ones)
                        }

                        Store (0x05, Local0)
                        While (Local0)
                        {
                            If (HBSY ())
                            {
                                Decrement (Local0)
                            }
                            Else
                            {
                                Or (Arg0, 0x01, HADR)
                                Store (Arg1, HCMD)
                                Store (0xFF, HSTS)
                                Store (0x4C, HSTC)
                                If (WTSB ())
                                {
                                    Store (HDT0, Local1)
                                    ShiftLeft (Local1, 0x08, Local1)
                                    Store (HDT1, Local2)
                                    Add (Local1, Local2, Local1)
                                    Release (\P4SM)
                                    Return (Local1)
                                }
                                Else
                                {
                                    Decrement (Local0)
                                }
                            }
                        }

                        Release (\P4SM)
                        Return (Ones)
                    }

                    Method (RBLK, 3, Serialized)
                    {
                        If (LNot (LEqual (Acquire (\P4SM, 0xFFFF), 0x00)))
                        {
                            Return (Ones)
                        }

                        Store (0x05, Local0)
                        While (Local0)
                        {
                            If (HBSY ())
                            {
                                Decrement (Local0)
                            }
                            Else
                            {
                                Or (Arg0, 0x01, HADR)
                                Store (Arg1, HCMD)
                                Store (0xFF, HSTS)
                                Store (0x54, HSTC)
                                If (WTSB ())
                                {
                                    Store (HSTC, Local1)
                                    Store (HDT0, Local2)
                                    Store (Local2, Local3)
                                    Store (0x00, RBUF)
                                    Store (0x00, Local1)
                                    While (Local2)
                                    {
                                        Store (BLKD, Index (RBUF, Local1))
                                        Decrement (Local2)
                                        Increment (Local1)
                                    }

                                    Release (\P4SM)
                                    Return (Local3)
                                }
                                Else
                                {
                                    Decrement (Local0)
                                }
                            }
                        }

                        Release (\P4SM)
                        Return (Ones)
                    }
                }

                Scope (\)
                {
                    Name (FAN1, 0x00)
                    Name (FAN2, 0x00)
                    Device (FN00)
                    {
                        Name (_HID, EisaId ("PNP0C0B"))
                        Name (_PR0, Package (0x01)
                        {
                            GFAN
                        })
                    }

                    PowerResource (GFAN, 0x00, 0x0000)
                    {
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (FAN1)
                        }

                        Method (_ON, 0, NotSerialized)
                        {
                            Store (0x01, FAN1)
                        }

                        Method (_OFF, 0, NotSerialized)
                        {
                            Store (0x00, FAN1)
                        }
                    }

                    Name (\_SB.PCI0.SBRG._PR0, Package (0x01)
                    {
                        GFAN
                    })
                    Method (FANW, 1, NotSerialized)
                    {
                        Noop
                    }

                    Method (FANS, 1, NotSerialized)
                    {
                        If (Arg0)
                        {
                            \GFAN._OFF ()
                        }
                    }
                }

                Scope (\)
                {
                    Name (TSP, 0x0A)
                    Name (TC1, 0x02)
                    Name (TC2, 0x0A)
                }

                Scope (\_TZ)
                {
                    Method (KELV, 1, NotSerialized)
                    {
                        And (Arg0, 0xFF, Local0)
                        Multiply (Local0, 0x0A, Local0)
                        Add (Local0, 0x0AAC, Local0)
                        Return (Local0)
                    }

                    Name (PLCY, 0x00)
                    ThermalZone (THRM)
                    {
                        Method (_CRT, 0, NotSerialized)
                        {
                            Return (KELV (TCRT))
                        }

                        Method (_TMP, 0, NotSerialized)
                        {
                            Store (0x05, Local1)
                            While (Local1)
                            {
                                Store (RTMP (), Local0)
                                If (LGreater (Local0, TCRT))
                                {
                                    Decrement (Local1)
                                }
                                Else
                                {
                                    Store (0x00, Local1)
                                }
                            }

                            Return (KELV (Local0))
                        }

                        Name (_PSL, Package (0x01)
                        {
                            \_PR.CPU1
                        })
                        Method (_TSP, 0, NotSerialized)
                        {
                            Multiply (TSP, 0x0A, Local0)
                            Return (Local0)
                        }

                        Method (_TC1, 0, NotSerialized)
                        {
                            Return (TC1)
                        }

                        Method (_TC2, 0, NotSerialized)
                        {
                            Return (TC2)
                        }

                        Method (_PSV, 0, NotSerialized)
                        {
                            If (PLCY)
                            {
                                Subtract (TPSV, 0x0A, Local0)
                                Return (KELV (Local0))
                            }
                            Else
                            {
                                Return (KELV (TPSV))
                            }
                        }

                        Name (_AL0, Package (0x01)
                        {
                            FN00
                        })
                        Method (_AC0, 0, NotSerialized)
                        {
                            If (PLCY)
                            {
                                Return (KELV (TPSV))
                            }
                            Else
                            {
                                Return (KELV (TAC3))
                            }
                        }

                        Method (_SCP, 1, NotSerialized)
                        {
                            Store (Arg0, PLCY)
                            TCHG ()
                            Notify (THRM, 0x81)
                        }
                    }

                    Method (TRMS, 1, NotSerialized)
                    {
                        If (Arg0)
                        {
                            \_TZ.TMSS (Arg0)
                        }
                    }

                    Method (TRMW, 1, NotSerialized)
                    {
                        If (Arg0)
                        {
                            If (LLess (Arg0, 0x04))
                            {
                                \_TZ.TMSW (Arg0)
                                \_TZ.TCHG ()
                            }
                        }
                    }
                }

                Scope (\_GPE)
                {
                    Method (_L00, 0, Serialized)
                    {
                        \_TZ.TCHG ()
                        Notify (\_TZ.THRM, 0x80)
                    }
                }

                Scope (\_TZ)
                {
                    Name (FON1, 0x76)
                    Name (FON2, 0xA0)
                    Name (LTMP, 0x3C)
                    Name (HLMT, 0x46)
                    Name (LLMT, 0x32)
                    Name (ELMT, 0x02)
                    Method (TMSW, 1, NotSerialized)
                    {
                        If (Arg0)
                        {
                            If (LLess (Arg0, 0x04))
                            {
                                WBYT (TSAD, 0x0B, 0x7F)
                                WBYT (TSAD, 0x0C, 0xC9)
                                WBYT (TSAD, 0x19, 0x7F)
                                WBYT (TSAD, 0x20, 0x7F)
                                RBYT (TSAD, 0x02)
                                RBYT (TSAD, 0x02)
                            }
                        }
                    }

                    Method (TMSS, 1, NotSerialized)
                    {
                        If (LNot (LGreater (Arg0, 0x03)))
                        {
                            WBYT (TSAD, 0x0D, 0x7F)
                            WBYT (TSAD, 0x0E, 0xC9)
                            RBYT (TSAD, 0x02)
                            RBYT (TSAD, 0x02)
                        }

                        If (LEqual (Arg0, 0x01))
                        {
                            \_SB.PCI0.SBRG.EC0.FNCT (0x84, 0x00)
                        }
                    }

                    Method (TCHG, 0, NotSerialized)
                    {
                        RTMP ()
                        If (LGreater (LTMP, TCRT))
                        {
                            Store (0x7F, HLMT)
                            Store (TCRT, LLMT)
                            Store (F1L4, FON1)
                            Store (F2L4, FON2)
                        }
                        Else
                        {
                            If (LGreater (LTMP, TPSV))
                            {
                                Store (TCRT, HLMT)
                                Store (TPSV, LLMT)
                                Store (F1L4, FON1)
                                Store (F2L4, FON2)
                            }
                            Else
                            {
                                If (LGreater (LTMP, TAC0))
                                {
                                    Store (TPSV, HLMT)
                                    Store (TAC0, LLMT)
                                    Store (F1L4, FON1)
                                    Store (F2L4, FON2)
                                }
                                Else
                                {
                                    If (LGreater (LTMP, TAC1))
                                    {
                                        Store (TAC0, HLMT)
                                        Store (TAC1, LLMT)
                                        Store (F1L3, FON1)
                                        Store (F2L3, FON2)
                                    }
                                    Else
                                    {
                                        If (LGreater (LTMP, TAC2))
                                        {
                                            Store (TAC1, HLMT)
                                            Store (TAC2, LLMT)
                                            Store (F1L2, FON1)
                                            Store (F2L2, FON2)
                                        }
                                        Else
                                        {
                                            If (LGreater (LTMP, TAC3))
                                            {
                                                Store (TAC2, HLMT)
                                                Store (TAC3, LLMT)
                                                Store (F1L1, FON1)
                                                Store (F2L1, FON2)
                                            }
                                            Else
                                            {
                                                Store (TAC3, HLMT)
                                                Store (0xC9, LLMT)
                                                Store (F1L0, FON1)
                                                Store (F2L0, FON2)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        If (PLCY)
                        {
                            If (LLess (LTMP, TPSV))
                            {
                                Store (F1L0, FON1)
                                Store (F2L0, FON2)
                            }
                        }

                        Add (HLMT, 0x02, Local1)
                        If (LGreater (Local1, 0x7F))
                        {
                            Store (0x7F, Local1)
                        }

                        Subtract (LLMT, 0x02, Local2)
                        WBYT (TSAD, 0x0D, Local1)
                        WBYT (TSAD, 0x0E, Local2)
                        RBYT (TSAD, 0x02)
                        RBYT (TSAD, 0x02)
                        \_SB.PCI0.SBRG.EC0.FNCT (0x84, FON1)
                    }

                    Method (RTMP, 0, NotSerialized)
                    {
                        Store (RBYT (TSAD, 0x01), Local0)
                        If (Not (Local0))
                        {
                            Store (Local0, LTMP)
                        }

                        Return (LTMP)
                    }

                    Method (RFAN, 0, NotSerialized)
                    {
                        If (LEqual (FON1, F1L0))
                        {
                            Store (FNC0, Local0)
                        }
                        Else
                        {
                            If (LEqual (FON1, F1L1))
                            {
                                Store (FNC1, Local0)
                            }
                            Else
                            {
                                If (LEqual (FON1, F1L2))
                                {
                                    Store (FNC2, Local0)
                                }
                                Else
                                {
                                    If (LEqual (FON1, F1L3))
                                    {
                                        Store (FNC3, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (FON1, F1L4))
                                        {
                                            Store (FNC4, Local0)
                                        }
                                    }
                                }
                            }
                        }

                        Return (Local0)
                    }

                    Method (THDL, 0, NotSerialized)
                    {
                        TCHG ()
                    }
                }

                Scope (\_SB.PCI0)
                {
                    Device (VGA)
                    {
                        Name (_ADR, 0x00020000)
                        Name (LCDM, 0x0808)
                        Name (CRTM, 0x0101)
                        Name (TVOM, 0x0202)
                        Name (DONE, Zero)
                        Name (DOSF, One)
                        Method (_INI, 0, NotSerialized)
                        {
                            GCAD ()
                            Store (\CADL, \PADL)
                            GCDD ()
                            GNDD ()
                        }

                        Method (_DOS, 1, NotSerialized)
                        {
                            Store (Arg0, DOSF)
                        }

                        Method (_DOD, 0, NotSerialized)
                        {
                            Return (Package (0x02)
                            {
                                0x00010100, 
                                0x00010400
                            })
                        }

                        Device (CRTD)
                        {
                            Name (_ADR, 0x0100)
                            Method (_DCS, 0, NotSerialized)
                            {
                                If (And (\CSTE, CRTM))
                                {
                                    Return (0x1F)
                                }

                                Return (0x1D)
                            }

                            Method (_DGS, 0, NotSerialized)
                            {
                                If (And (\NSTE, CRTM))
                                {
                                    Return (0x01)
                                }

                                Return (0x00)
                            }

                            Method (_DSS, 1, NotSerialized)
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    If (And (Arg0, 0x80000000))
                                    {
                                        Store (\NSTE, \CSTE)
                                        Store (One, DONE)
                                    }
                                }
                            }
                        }

                        Device (LCDD)
                        {
                            Name (_ADR, 0x0400)
                            Method (_DCS, 0, NotSerialized)
                            {
                                If (And (\CSTE, LCDM))
                                {
                                    Return (0x1F)
                                }

                                Return (0x1D)
                            }

                            Method (_DGS, 0, NotSerialized)
                            {
                                If (And (\NSTE, LCDM))
                                {
                                    Return (0x01)
                                }

                                Return (0x00)
                            }

                            Method (_DSS, 1, NotSerialized)
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    If (And (Arg0, 0x80000000))
                                    {
                                        Store (\NSTE, \CSTE)
                                        Store (One, DONE)
                                    }
                                }
                            }
                        }

                        Method (SWHD, 1, Serialized)
                        {
                            If (DOSF)
                            {
                                Store (0x04, \SFUN)
                                Store (Arg0, \SSTE)
                                ISMI (\STDD)
                                Notify (\_SB.PCI0.VGA, 0x81)
                            }
                            Else
                            {
                                If (LNot (LEqual (\CADL, \PADL)))
                                {
                                    Store (\CADL, \PADL)
                                    If (LEqual (OSFG, OSXP))
                                    {
                                        Notify (\_SB.PCI0, 0x00)
                                    }
                                    Else
                                    {
                                        Notify (\_SB.PCI0.VGA, 0x00)
                                    }

                                    Sleep (0x03E8)
                                }

                                Notify (\_SB.PCI0.VGA, 0x80)
                            }
                        }

                        Method (GCDD, 0, NotSerialized)
                        {
                            Store (0x01, \SFUN)
                            ISMI (\GTDD)
                            Return (\CSTE)
                        }

                        Method (GNDD, 0, NotSerialized)
                        {
                            Store (0x05, \SFUN)
                            ISMI (\GTDD)
                            Return (\NSTE)
                        }

                        Method (GCAD, 0, NotSerialized)
                        {
                            Store (0x02, \SFUN)
                            ISMI (\GTDD)
                            Return (\CADL)
                        }

                        Method (ADVD, 0, NotSerialized)
                        {
                            GCDD ()
                            GCAD ()
                            Return (GNDD ())
                        }
                    }
                }

                Scope (\)
                {
                    Method (ADVG, 0, NotSerialized)
                    {
                        Return (\_SB.PCI0.VGA.ADVD ())
                    }

                    Method (SWHG, 1, Serialized)
                    {
                        Store (Zero, \_SB.PCI0.VGA.DONE)
                        \_SB.PCI0.VGA.SWHD (Arg0)
                        If (LNot (\_SB.PCI0.VGA.DOSF))
                        {
                            Store (0x01F4, Local0)
                            While (Local0)
                            {
                                If (\_SB.PCI0.VGA.DONE)
                                {
                                    Store (Zero, Local0)
                                }
                                Else
                                {
                                    Sleep (0x0A)
                                    Decrement (Local0)
                                }
                            }
                        }
                    }

                    Method (NATK, 0, NotSerialized)
                    {
                        Return (Zero)
                    }
                }

                Scope (\_SB)
                {
                    Name (ATKP, Zero)
                    Device (ATKD)
                    {
                        Name (_HID, "ATK0100")
                        Name (_UID, 0x01010100)
                        Method (INIT, 1, NotSerialized)
                        {
                            Store (One, ATKP)
                            Return (\MNAM)
                        }

                        Method (BSTS, 0, NotSerialized)
                        {
                            Store (\IKFG, Local0)
                            If (\_SB.PCI0.SBRG.EC0.ACAP ())
                            {
                                And (Local0, 0x7F, Local0)
                            }

                            Return (Local0)
                        }

                        Method (MLED, 1, NotSerialized)
                        {
                            If (Arg0)
                            {
                                Store (0x31, Local0)
                            }
                            Else
                            {
                                Store (0x51, Local0)
                            }

                            \_SB.PCI0.SBRG.EC0.STC5 (Local0)
                        }

                        Method (TMPR, 0, NotSerialized)
                        {
                            Store (\_TZ.RTMP (), Local0)
                            Store (\_TZ.RFAN (), Local1)
                            ShiftLeft (Local1, 0x10, Local1)
                            Add (\_TZ.KELV (Local0), Local1, Local0)
                            Store (Zero, Local2)
                            If (\TENA)
                            {
                                Store (\TDTY, Local2)
                            }
                            Else
                            {
                                If (\THLS)
                                {
                                    Store (\TTDT, Local2)
                                }
                            }

                            ShiftLeft (Local2, 0x18, Local2)
                            Add (Local0, Local2, Local0)
                            Return (Local0)
                        }

                        Method (SFUN, 0, NotSerialized)
                        {
                            Store (0x37, Local0)
                            Or (Local0, 0x0240, Local0)
                            If (LEqual (\_SB.PCI0.P0P1.MPCI.MPDP (), 0x01))
                            {
                                Or (Local0, 0x0100, Local0)
                            }

                            If (LGreater (\_SB.PCI0.P0P1.MPCI.MPDP (), 0x01))
                            {
                                Or (Local0, 0x0800, Local0)
                            }

                            Add (Local0, 0x08, Local0)
                            Return (Local0)
                        }

                        Name (FMST, Package (0x04)
                        {
                            Package (0x04)
                            {
                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x55, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0x64, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0x69, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0x6E, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0x73, 
                                        0x07
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x71, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0x85, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0x8C, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0x93, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0x99, 
                                        0x07
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x8D, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0xA6, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0xAF, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0xB7, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0xBF, 
                                        0x07
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0xAA, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0xC8, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0xD2, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0xDC, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0xE6, 
                                        0x07
                                    }
                                }
                            }, 

                            Package (0x04)
                            {
                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x5A, 
                                        0x03
                                    }, 

                                    Package (0x02)
                                    {
                                        0x64, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0x6E, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0x78, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0x82, 
                                        0x07
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x78, 
                                        0x03
                                    }, 

                                    Package (0x02)
                                    {
                                        0x85, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0x93, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0xA0, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0xAD, 
                                        0x07
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x96, 
                                        0x03
                                    }, 

                                    Package (0x02)
                                    {
                                        0xA6, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0xB7, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0xC7, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0xD9, 
                                        0x07
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0xB4, 
                                        0x03
                                    }, 

                                    Package (0x02)
                                    {
                                        0xC8, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0xDC, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0xF0, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0x0104, 
                                        0x07
                                    }
                                }
                            }, 

                            Package (0x04)
                            {
                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x5A, 
                                        0x00
                                    }, 

                                    Package (0x02)
                                    {
                                        0x64, 
                                        0x01
                                    }, 

                                    Package (0x02)
                                    {
                                        0x69, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0x6E, 
                                        0x03
                                    }, 

                                    Package (0x02)
                                    {
                                        0x73, 
                                        0x04
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x78, 
                                        0x00
                                    }, 

                                    Package (0x02)
                                    {
                                        0x85, 
                                        0x01
                                    }, 

                                    Package (0x02)
                                    {
                                        0x8C, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0x93, 
                                        0x03
                                    }, 

                                    Package (0x02)
                                    {
                                        0x99, 
                                        0x04
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x96, 
                                        0x00
                                    }, 

                                    Package (0x02)
                                    {
                                        0xA6, 
                                        0x01
                                    }, 

                                    Package (0x02)
                                    {
                                        0xAF, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0xB7, 
                                        0x03
                                    }, 

                                    Package (0x02)
                                    {
                                        0xBF, 
                                        0x04
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0xB4, 
                                        0x00
                                    }, 

                                    Package (0x02)
                                    {
                                        0xC8, 
                                        0x01
                                    }, 

                                    Package (0x02)
                                    {
                                        0xD2, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0xDC, 
                                        0x03
                                    }, 

                                    Package (0x02)
                                    {
                                        0xE6, 
                                        0x04
                                    }
                                }
                            }, 

                            Package (0x04)
                            {
                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x5A, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0x64, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0x78, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0x7D, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0x82, 
                                        0x07
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x78, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0x85, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0xA0, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0xA7, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0xAD, 
                                        0x07
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0x96, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0xA6, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0xC8, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0xD0, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0xD9, 
                                        0x07
                                    }
                                }, 

                                Package (0x05)
                                {
                                    Package (0x02)
                                    {
                                        0xB4, 
                                        0x02
                                    }, 

                                    Package (0x02)
                                    {
                                        0xC8, 
                                        0x04
                                    }, 

                                    Package (0x02)
                                    {
                                        0xF0, 
                                        0x05
                                    }, 

                                    Package (0x02)
                                    {
                                        0xFA, 
                                        0x06
                                    }, 

                                    Package (0x02)
                                    {
                                        0x0104, 
                                        0x07
                                    }
                                }
                            }
                        })
                        Method (GFRQ, 1, NotSerialized)
                        {
                            If (LEqual (\OVCK, 0x00))
                            {
                                If (LNot (LEqual (Arg0, 0x01)))
                                {
                                    Return (0x00)
                                }
                            }

                            Store (DerefOf (Index (FMST, \FS56)), Local0)
                            Store (DerefOf (Index (Local0, \CPUF)), Local1)
                            Store (Arg0, Local5)
                            If (LEqual (Local5, 0x02))
                            {
                                If (\OVCK)
                                {
                                    Subtract (\OVCK, 0x01, Local6)
                                    Add (Local5, Local6, Local5)
                                }
                            }

                            Store (DerefOf (Index (Local1, Local5)), Local2)
                            Store (DerefOf (Index (Local2, 0x00)), Local3)
                            Multiply (Local3, \CPUR, Local4)
                            Return (Local4)
                        }

                        Method (SFRQ, 1, NotSerialized)
                        {
                            Store (DerefOf (Index (FMST, \FS56)), Local0)
                            Store (DerefOf (Index (Local0, \CPUF)), Local1)
                            Store (Arg0, Local5)
                            If (LEqual (Local5, 0x02))
                            {
                                If (\OVCK)
                                {
                                    Subtract (\OVCK, 0x01, Local6)
                                    Add (Local5, Local6, Local5)
                                }
                            }

                            Store (DerefOf (Index (Local1, Local5)), Local2)
                            Store (DerefOf (Index (Local2, 0x01)), Local3)
                            Store (Local3, \FS02)
                            Return (One)
                        }

                        Method (WDEV, 0, NotSerialized)
                        {
                            Return (\_SB.PCI0.P0P1.MPCI.MPDP ())
                        }

                        Method (SWBX, 1, NotSerialized)
                        {
                            If (Arg0)
                            {
                                \_SB.PCI0.IDE0.SPWR (0x00)
                            }
                        }

                        Method (AIBX, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.SBRG.EC0.AIBP ())
                            {
                                If (\_SB.PCI0.SBRG.EC0.IDEP ())
                                {
                                    Return (One)
                                }
                            }

                            Return (Zero)
                        }

                        Method (OSVR, 1, NotSerialized)
                        {
                            Store (Arg0, \OSFG)
                        }

                        Method (GPLV, 0, NotSerialized)
                        {
                            Return (\LBTN)
                        }

                        Method (SPLV, 1, NotSerialized)
                        {
                            Store (Arg0, \LBTN)
                            \_SB.PCI0.SBRG.EC0.STBR ()
                        }

                        Method (WLED, 1, NotSerialized)
                        {
                            If (Arg0)
                            {
                                Store (Zero, \PO33)
                                \_SB.PCI0.SBRG.EC0.STC5 (0x41)
                            }
                            Else
                            {
                                Store (One, \PO33)
                                \_SB.PCI0.SBRG.EC0.STC5 (0x21)
                            }
                        }

                        Method (SDSP, 1, NotSerialized)
                        {
                            If (\NATK ())
                            {
                                \SWHG (Arg0)
                            }
                        }
                    }
                }

                Scope (\)
                {
                    Name (PMEW, Zero)
                    Method (OEMS, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            If (LNot (LGreater (\OSFG, \OSME)))
                            {
                                Store (One, \WIDE)
                            }
                            Else
                            {
                                Store (Zero, \WIDE)
                            }
                        }

                        \_SB.PCI0.USB1.USBS (Arg0)
                        \_SB.PCI0.USB2.USBS (Arg0)
                        \_SB.PCI0.USB3.USBS (Arg0)
                        \_SB.PCI0.SBRG.EC0.EC0S (Arg0)
                        If (LEqual (Arg0, 0x05))
                        {
                            \_SB.PCI0.IDE0.STBY (0x00)
                            \_SB.PCI0.IDE0.STBY (0x01)
                        }

                        If (LEqual (Arg0, 0x04))
                        {
                            If (LEqual (OSFG, OS2K))
                            {
                                \DBGR (0xAA)
                                Store (Arg0, S42K)
                            }
                        }

                        Add (Arg0, 0xD0, DBG8)
                    }

                    Method (OEMW, 1, NotSerialized)
                    {
                        \_SB.PCI0.P0P1.CBS0.CBSW (Arg0)
                        Store (\SBPS, \PMEW)
                        \_SB.PCI0.USB1.USBW (Arg0)
                        \_SB.PCI0.USB2.USBW (Arg0)
                        \_SB.PCI0.USB3.USBW (Arg0)
                        \_SB.PCI0.SBRG.EC0.EC0W (Arg0)
                        If (LEqual (Arg0, 0x04))
                        {
                            Notify (\_SB.SLPB, 0x02)
                        }

                        Add (Arg0, 0xF0, DBG8)
                    }
                }

                Scope (\_GPE)
                {
                    Method (_L03, 0, Serialized)
                    {
                        Notify (\_SB.PCI0.USB1, 0x02)
                        Notify (\_SB.SLPB, 0x02)
                    }

                    Method (_L04, 0, Serialized)
                    {
                        Notify (\_SB.PCI0.USB2, 0x02)
                        Notify (\_SB.SLPB, 0x02)
                    }

                    Method (_L0C, 0, Serialized)
                    {
                        Notify (\_SB.PCI0.USB3, 0x02)
                        Notify (\_SB.SLPB, 0x02)
                    }

                    Method (_L0D, 0, Serialized)
                    {
                        Notify (\_SB.PCI0.EHCI, 0x02)
                        Notify (\_SB.SLPB, 0x02)
                    }

                    Method (_L05, 0, Serialized)
                    {
                        Notify (\_SB.PCI0.MODM, 0x02)
                        Notify (\_SB.SLPB, 0x02)
                    }

                    Method (_L0B, 0, Serialized)
                    {
                        If (\PMEW)
                        {
                            Notify (\_SB.PCI0.P0P1, 0x02)
                            Notify (\_SB.SLPB, 0x02)
                            Store (Zero, \PMEW)
                        }
                        Else
                        {
                            If (\_SB.PCI0.P0P1.CBS0.CBSR ())
                            {
                                Notify (\_SB.PCI0.P0P1.CBS0, 0x02)
                            }
                        }
                    }
                }

                Scope (\_SB.ATKD)
                {
                    Method (FSMI, 1, NotSerialized)
                    {
                        Store (Arg0, \FSFN)
                        Or (Arg0, 0xA0, Local0)
                        Store (Local0, \DBG8)
                        ISMI (\WFAT)
                        Return (\FSTA)
                    }

                    Method (FLSH, 1, NotSerialized)
                    {
                        Store (Arg0, \FSTA)
                        FSMI (0x00)
                    }

                    Method (FINI, 1, NotSerialized)
                    {
                        Store (Arg0, \FADR)
                        Return (FSMI (0x01))
                    }

                    Method (FERS, 1, NotSerialized)
                    {
                        Store (Arg0, \FSTA)
                        Return (FSMI (0x02))
                    }

                    Method (FWRI, 1, NotSerialized)
                    {
                        Store (Arg0, \FADR)
                        Store (0x1000, \FSIZ)
                        Return (Subtract (0x1000, FSMI (0x03)))
                    }

                    Method (FWRP, 0, NotSerialized)
                    {
                        Store (0x00, \FSIZ)
                        Return (Subtract (0x1000, FSMI (0x03)))
                    }
                }

                Device (UAR2)
                {
                    Name (_UID, 0x02)
                    Method (_HID, 0, NotSerialized)
                    {
                        Return (UHID (0x01))
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Return (DSTA (0x01))
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        If (LGreater (\OSFG, \OSME))
                        {
                            DCNT (0x01, 0x00)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (DCRS (0x01))
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        DSRS (Arg0, 0x01)
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (CMPR)
                    }

                    Name (CMPR, ResourceTemplate ()
                    {
                        IRQNoFlags () {3,4}
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,2,3}
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,2,3}
                            IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,2,3}
                            IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,2,3}
                            IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                        }
                        EndDependentFn ()
                    })
                }

                Device (LPTE)
                {
                    Method (_HID, 0, NotSerialized)
                    {
                        If (LPTM (0x02))
                        {
                            Return (0x0104D041)
                        }
                        Else
                        {
                            Return (0x0004D041)
                        }
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Return (DSTA (0x02))
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        DCNT (0x02, 0x00)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        DCRS (0x02)
                        If (LPTM (0x02))
                        {
                            Store (IRQM, IRQE)
                            Store (DMAM, DMAE)
                            Store (IO11, IO21)
                            Store (IO12, IO22)
                            Store (LEN1, LEN2)
                            Add (IO21, 0x0400, IO31)
                            Store (IO31, IO32)
                            Store (LEN2, LEN3)
                            Return (CRS2)
                        }
                        Else
                        {
                            Return (CRS1)
                        }
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        DSRS (Arg0, 0x02)
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        If (LPTM (0x02))
                        {
                            Return (EPPR)
                        }
                        Else
                        {
                            Return (LPPR)
                        }
                    }

                    Name (LPPR, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IRQNoFlags () {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IRQNoFlags () {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IRQNoFlags () {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                        }
                        StartDependentFnNoPri ()
                        {
                            IRQNoFlags () {}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IRQNoFlags () {}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IRQNoFlags () {}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                        }
                        EndDependentFn ()
                    })
                    Name (EPPR, ResourceTemplate ()
                    {
                        IRQNoFlags () {3,4,5,6,7,10,11,12}
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,2,3}
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                            IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,2,3}
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                            IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,2,3}
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                            IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                            IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                            IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                            IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                        }
                        EndDependentFn ()
                    })
                }

                Device (FWH)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x02)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly, 0x00000000, 0x00000000)
                        Memory32Fixed (ReadOnly, 0x00000000, 0x00000000)
                    })
                    CreateDWordField (CRS, 0x04, BS00)
                    CreateDWordField (CRS, 0x08, BL00)
                    CreateDWordField (CRS, 0x10, BS10)
                    CreateDWordField (CRS, 0x14, BL10)
                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (0xFF800000, Local0)
                        FindSetRightBit (FHD0, Local1)
                        Decrement (Local1)
                        If (Local1)
                        {
                            Multiply (Local1, 0x00080000, Local1)
                        }

                        Add (Local0, Local1, Local2)
                        Store (Local2, BS00)
                        Add (BS00, 0x00400000, BS10)
                        Subtract (0x00, BS10, BL00)
                        Store (BL00, BL10)
                        Return (CRS)
                    }
                }

                Device (FWHE)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x03)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly, 0x00000000, 0x00000000)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS, 0x04, BS00)
                        CreateDWordField (CRS, 0x08, BL00)
                        If (LEqual (^^FWH.BS00, 0x00))
                        {
                            ^^FWH._CRS ()
                        }

                        Add (^^FWH.BS00, ^^FWH.BL00, BS00)
                        Subtract (^^FWH.BS10, BS00, BL00)
                        Return (CRS)
                    }
                }

                OperationRegion (FHR0, PCI_Config, 0xE3, 0x01)
                Field (FHR0, ByteAcc, NoLock, Preserve)
                {
                    FHD0,   8
                }
            }

            Device (IDE0)
            {
                Name (_ADR, 0x001F0001)
                Scope (\_SB.PCI0.SBRG.EC0)
                {
                    Method (AIBP, 0, Serialized)
                    {
                        Store (RDC3 (0x05), Local0)
                        While (LEqual (Local0, Ones))
                        {
                            Store (RDC3 (0x05), Local0)
                        }

                        And (Local0, 0x10, Local0)
                        If (Local0)
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (One)
                        }
                    }

                    Name (PIDE, 0x00)
                    Name (CIDE, 0x00)
                    Method (_Q2E, 0, NotSerialized)
                    {
                        Store (AIBP (), Local1)
                        Store (0x03, Local3)
                        While (Local3)
                        {
                            Sleep (0xC8)
                            Store (AIBP (), Local4)
                            If (LEqual (Local1, Local4))
                            {
                                Decrement (Local3)
                            }
                            Else
                            {
                                Store (Local4, Local1)
                                Increment (Local3)
                            }
                        }

                        If (Local1)
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                Or (P54S, 0x10, P54S)
                                Release (MUEC)
                            }

                            Store (IDEP (), CIDE)
                        }
                        Else
                        {
                            If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))
                            {
                                And (P54S, 0xEF, P54S)
                                Release (MUEC)
                            }

                            Store (Zero, CIDE)
                        }

                        If (LNot (LEqual (PIDE, CIDE)))
                        {
                            IEVT (Local1)
                        }
                        Else
                        {
                            FEVT (Local1)
                        }

                        Store (CIDE, PIDE)
                    }

                    Method (IDEP, 0, Serialized)
                    {
                        Return (One)
                    }

                    Method (FEVT, 1, Serialized)
                    {
                        Return (Zero)
                    }

                    Method (IEVT, 1, Serialized)
                    {
                        If (Arg0)
                        {
                            Store (0x59, Local0)
                        }
                        Else
                        {
                            Store (0x5A, Local0)
                        }

                        \_SB.PCI0.IDE0.SPWR (Arg0)
                        \_SB.PCI0.IDE0.REMU ()
                        If (\_SB.ATKP)
                        {
                            Notify (\_SB.ATKD, Local0)
                        }

                        Return (One)
                    }
                }

                Method (SPWR, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (Zero, \_SB.PCI0.IDE0.SSIG)
                        Sleep (0x07D0)
                        Store (Zero, \IPWR)
                        Sleep (0x1B58)
                        \ISMI (\ISWP)
                    }
                    Else
                    {
                        Store (0x01, \_SB.PCI0.IDE0.SSIG)
                        Store (One, \IPWR)
                        And (TIMS, 0xCCFF, TIMS)
                        And (STMS, 0x00, STMS)
                    }
                }

                Method (REMU, 0, NotSerialized)
                {
                    Notify (\_SB.PCI0.IDE0.CHN1, 0x00)
                    Notify (\_SB.PCI0.IDE0.CHN1.DRV0, 0x01)
                    Notify (\_SB.PCI0.IDE0.CHN1.DRV1, 0x01)
                }

                Method (_INI, 0, NotSerialized)
                {
                    If (\_SB.PCI0.SBRG.EC0.AIBP ())
                    {
                        If (\_SB.PCI0.SBRG.EC0.IDEP ())
                        {
                            Store (One, \_SB.PCI0.SBRG.EC0.CIDE)
                            Store (One, \_SB.PCI0.SBRG.EC0.PIDE)
                            If (\IPWR)
                            {
                                \_SB.PCI0.IDE0.SPWR (0x01)
                            }
                        }
                        Else
                        {
                            Store (0x01, SSIG)
                        }
                    }
                    Else
                    {
                        \_SB.PCI0.IDE0.SPWR (0x00)
                    }
                }

                Name (REGF, 0x01)
                Method (_REG, 2, NotSerialized)
                {
                    If (LEqual (Arg0, 0x02))
                    {
                        Store (Arg1, REGF)
                    }
                }

                OperationRegion (BAR0, PCI_Config, 0x00, 0x0100)
                Field (BAR0, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x40), 
                    TIMP,   16, 
                    TIMS,   16, 
                    STMP,   4, 
                    STMS,   4, 
                    Offset (0x48), 
                    UDMP,   2, 
                    UDMS,   2, 
                    Offset (0x4A), 
                    UDTP,   6, 
                    Offset (0x4B), 
                    UDTS,   6, 
                    Offset (0x54), 
                    PCB0,   2, 
                    SCB0,   2, 
                    PCA0,   2, 
                    SCA0,   2, 
                        ,   4, 
                    FPB0,   2, 
                    FSB0,   2, 
                    PSIG,   2, 
                    SSIG,   2
                }

                Name (TIM0, Package (0x09)
                {
                    Package (0x04)
                    {
                        0x78, 
                        0xB4, 
                        0xF0, 
                        0x0384
                    }, 

                    Package (0x04)
                    {
                        0x23, 
                        0x21, 
                        0x10, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0B, 
                        0x09, 
                        0x04, 
                        0x00
                    }, 

                    Package (0x06)
                    {
                        0x70, 
                        0x49, 
                        0x36, 
                        0x27, 
                        0x19, 
                        0x0F
                    }, 

                    Package (0x06)
                    {
                        0x00, 
                        0x01, 
                        0x02, 
                        0x01, 
                        0x02, 
                        0x01
                    }, 

                    Package (0x06)
                    {
                        0x00, 
                        0x00, 
                        0x00, 
                        0x01, 
                        0x01, 
                        0x01
                    }, 

                    Package (0x06)
                    {
                        0x00, 
                        0x00, 
                        0x00, 
                        0x00, 
                        0x00, 
                        0x01
                    }, 

                    Package (0x04)
                    {
                        0x04, 
                        0x03, 
                        0x02, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x02, 
                        0x01, 
                        0x00, 
                        0x00
                    }
                })
                Name (TMD0, Buffer (0x14) {})
                CreateDWordField (TMD0, 0x00, PIO0)
                CreateDWordField (TMD0, 0x04, DMA0)
                CreateDWordField (TMD0, 0x08, PIO1)
                CreateDWordField (TMD0, 0x0C, DMA1)
                CreateDWordField (TMD0, 0x10, CHNF)
                Name (GTIM, 0x00)
                Name (GSTM, 0x00)
                Name (GUDM, 0x00)
                Name (GUDT, 0x00)
                Name (GCB0, 0x00)
                Name (GFB0, 0x00)
                Method (STBY, 1, NotSerialized)
                {
                    Store (0xA0, SIDS)
                    If (LEqual (Arg0, 0x01))
                    {
                        Store (0xB0, SIDS)
                    }

                    \ISMI (\ISTB)
                    Sleep (0x01F4)
                }

                Device (CHN0)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Return (GTM (TIMP, STMP, UDMP, UDTP, PCB0, FPB0))
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        Store (TIMP, GTIM)
                        Store (UDTP, GUDT)
                        If (STM ())
                        {
                            Store (GTIM, TIMP)
                            Store (GSTM, STMP)
                            Store (GUDM, UDMP)
                            Store (GUDT, UDTP)
                            Store (GCB0, PCB0)
                            Store (GFB0, FPB0)
                        }

                        Store (GTF (0x00, Arg1), ATA0)
                        Store (GTF (0x01, Arg2), ATA1)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA0))
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA1))
                        }
                    }
                }

                Device (CHN1)
                {
                    Name (_ADR, 0x01)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Return (GTM (TIMS, STMS, UDMS, UDTS, SCB0, FSB0))
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        Store (TIMS, GTIM)
                        Store (UDTS, GUDT)
                        If (STM ())
                        {
                            Store (GTIM, TIMS)
                            Store (GSTM, STMS)
                            Store (GUDM, UDMS)
                            Store (GUDT, UDTS)
                            Store (GCB0, SCB0)
                            Store (GFB0, FSB0)
                        }

                        Store (GTF (0x00, Arg1), ATA2)
                        Store (GTF (0x01, Arg2), ATA3)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, 0x00)
                        Method (_EJ0, 1, NotSerialized)
                        {
                            \_SB.PCI0.IDE0.STBY (0x00)
                            \_SB.PCI0.IDE0.SPWR (0x00)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            If (LNot (\IPWR))
                            {
                                If (\_SB.PCI0.SBRG.EC0.AIBP ())
                                {
                                    If (\_SB.PCI0.SBRG.EC0.IDEP ())
                                    {
                                        Return (0x0F)
                                    }
                                }
                            }

                            Return (Zero)
                        }

                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA2))
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, 0x01)
                        Method (_EJ0, 1, NotSerialized)
                        {
                            \_SB.PCI0.IDE0.STBY (0x01)
                            \_SB.PCI0.IDE0.SPWR (0x00)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            If (LNot (\IPWR))
                            {
                                If (\_SB.PCI0.SBRG.EC0.AIBP ())
                                {
                                    If (\_SB.PCI0.SBRG.EC0.IDEP ())
                                    {
                                        Return (0x0F)
                                    }
                                }
                            }

                            Return (Zero)
                        }

                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA3))
                        }
                    }
                }

                Method (GTM, 6, Serialized)
                {
                    Store (Ones, PIO0)
                    Store (PIO0, PIO1)
                    Store (PIO0, DMA0)
                    Store (PIO0, DMA1)
                    Store (Zero, CHNF)
                    If (REGF) {}
                    Else
                    {
                        Return (TMD0)
                    }

                    If (And (Arg0, 0x02))
                    {
                        Or (CHNF, 0x02, CHNF)
                    }

                    ShiftRight (And (Arg0, 0x3300), 0x08, Local5)
                    Store (Match (DerefOf (Index (TIM0, 0x01)), MLE, Local5, MTR, 0x00, 0x00), Local6)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, 0x00)), Local6)), Local7)
                    Store (Local7, DMA0)
                    If (And (Arg0, 0x08))
                    {
                        Store (0x0384, PIO0)
                    }
                    Else
                    {
                        Store (Local7, PIO0)
                    }

                    If (And (Arg0, 0x20))
                    {
                        Or (CHNF, 0x08, CHNF)
                    }

                    If (And (Arg0, 0x4000))
                    {
                        Or (CHNF, 0x10, CHNF)
                        Store (Match (DerefOf (Index (TIM0, 0x02)), MLE, Arg1, MTR, 0x00, 0x00), Local5)
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x00)), Local5)), Local6)
                        Store (Local6, DMA1)
                        If (And (Arg0, 0x80))
                        {
                            Store (0x0384, PIO1)
                        }
                        Else
                        {
                            Store (Local6, PIO1)
                        }
                    }

                    If (And (Arg2, 0x01))
                    {
                        And (Arg3, 0x03, Local5)
                        If (LAnd (And (Arg5, 0x01), LEqual (Local5, 0x01)))
                        {
                            Add (Local5, 0x04, Local5)
                        }
                        Else
                        {
                            If (And (Arg4, 0x01))
                            {
                                Add (Local5, 0x02, Local5)
                            }
                        }

                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x03)), Local5)), DMA0)
                        Or (CHNF, 0x01, CHNF)
                    }

                    If (And (Arg2, 0x02))
                    {
                        And (ShiftRight (Arg3, 0x04), 0x03, Local5)
                        If (LAnd (And (Arg5, 0x02), LEqual (Local5, 0x01)))
                        {
                            Add (Local5, 0x04, Local5)
                        }
                        Else
                        {
                            If (And (Arg4, 0x02))
                            {
                                Add (Local5, 0x02, Local5)
                            }
                        }

                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x03)), Local5)), DMA1)
                        Or (CHNF, 0x04, CHNF)
                    }

                    Store (TMD0, Debug)
                    Return (TMD0)
                }

                Method (STM, 0, Serialized)
                {
                    If (REGF) {}
                    Else
                    {
                        Return (0x00)
                    }

                    And (GTIM, 0x8044, GTIM)
                    Store (0x00, GSTM)
                    Store (0x00, GUDM)
                    Store (0x00, GCB0)
                    And (GUDT, 0xCC, GUDT)
                    Store (0x00, GFB0)
                    If (And (CHNF, 0x01))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DMA0, MTR, 0x00, 0x00), Local0)
                        If (LGreater (Local0, 0x05))
                        {
                            Store (0x05, Local0)
                        }

                        Or (GUDT, DerefOf (Index (DerefOf (Index (TIM0, 0x04)), Local0)), GUDT)
                        Or (GCB0, DerefOf (Index (DerefOf (Index (TIM0, 0x05)), Local0)), GCB0)
                        Or (GFB0, DerefOf (Index (DerefOf (Index (TIM0, 0x06)), Local0)), GFB0)
                        Or (GUDM, 0x01, GUDM)
                    }
                    Else
                    {
                        If (Or (LEqual (PIO0, Ones), LEqual (PIO0, 0x00)))
                        {
                            If (And (LLess (DMA0, Ones), LGreater (DMA0, 0x00)))
                            {
                                Store (DMA0, PIO0)
                                Or (GTIM, 0x08, GTIM)
                            }
                        }
                    }

                    If (And (CHNF, 0x04))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DMA1, MTR, 0x00, 0x00), Local0)
                        If (LGreater (Local0, 0x05))
                        {
                            Store (0x05, Local0)
                        }

                        Or (GUDT, ShiftLeft (DerefOf (Index (DerefOf (Index (TIM0, 0x04)), Local0)), 0x04), GUDT)
                        Or (GCB0, ShiftLeft (DerefOf (Index (DerefOf (Index (TIM0, 0x05)), Local0)), 0x01), GCB0)
                        Or (GFB0, ShiftLeft (DerefOf (Index (DerefOf (Index (TIM0, 0x06)), Local0)), 0x01), GFB0)
                        Or (GUDM, 0x02, GUDM)
                    }
                    Else
                    {
                        If (Or (LEqual (PIO1, Ones), LEqual (PIO1, 0x00)))
                        {
                            If (And (LLess (DMA1, Ones), LGreater (DMA1, 0x00)))
                            {
                                Store (DMA1, PIO1)
                                Or (GTIM, 0x80, GTIM)
                            }
                        }
                    }

                    If (And (CHNF, 0x02))
                    {
                        Or (GTIM, 0x03, GTIM)
                    }

                    If (And (CHNF, 0x08))
                    {
                        Or (GTIM, 0x30, GTIM)
                    }

                    And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIO0, MTR, 0x00, 0x00), 0x03, Local0)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, 0x01)), Local0)), Local1)
                    ShiftLeft (Local1, 0x08, Local2)
                    Or (GTIM, Local2, GTIM)
                    If (And (CHNF, 0x10))
                    {
                        Or (GTIM, 0x4000, GTIM)
                        And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIO1, MTR, 0x00, 0x00), 0x03, Local0)
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x02)), Local0)), GSTM)
                    }

                    Return (0x01)
                }

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
                Name (ATAB, Buffer (0x1D) {})
                CreateByteField (ATAB, 0x00, CMDC)
                Method (GTFB, 3, Serialized)
                {
                    Multiply (CMDC, 0x38, Local0)
                    Add (Local0, 0x08, Local1)
                    CreateField (ATAB, Local1, 0x38, CMDX)
                    Multiply (CMDC, 0x07, Local0)
                    CreateByteField (ATAB, Add (Local0, 0x02), A001)
                    CreateByteField (ATAB, Add (Local0, 0x06), A005)
                    Store (Arg0, CMDX)
                    Store (Arg1, A001)
                    Store (Arg2, A005)
                    Increment (CMDC)
                }

                Method (GTF, 2, Serialized)
                {
                    Store (Arg1, Debug)
                    Store (0x00, CMDC)
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

                    If (LAnd (LAnd (And (ID53, 0x04), And (ID88, 0xFF00)), DMAT))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DMAT, MTR, 0x00, 0x00), Local1)
                        If (LGreater (Local1, 0x05))
                        {
                            Store (0x05, Local1)
                        }

                        GTFB (AT01, Or (0x40, Local1), Local7)
                    }
                    Else
                    {
                        If (LAnd (And (ID63, 0xFF00), PIOT))
                        {
                            And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIOT, MTR, 0x00, 0x00), 0x03, Local0)
                            Or (0x20, DerefOf (Index (DerefOf (Index (TIM0, 0x08)), Local0)), Local1)
                            GTFB (AT01, Local1, Local7)
                        }
                    }

                    If (IRDY)
                    {
                        And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIOT, MTR, 0x00, 0x00), 0x03, Local0)
                        Or (0x08, DerefOf (Index (DerefOf (Index (TIM0, 0x07)), Local0)), Local1)
                        GTFB (AT01, Local1, Local7)
                    }
                    Else
                    {
                        If (And (ID49, 0x0400))
                        {
                            GTFB (AT01, 0x01, Local7)
                        }
                    }

                    If (LAnd (And (ID59, 0x0100), And (ID59, 0xFF)))
                    {
                        GTFB (AT03, And (ID59, 0xFF), Local7)
                    }

                    Store (ATAB, Debug)
                    Return (ATAB)
                }

                Method (RATA, 1, NotSerialized)
                {
                    CreateByteField (Arg0, 0x00, CMDN)
                    Multiply (CMDN, 0x38, Local0)
                    CreateField (Arg0, 0x08, Local0, RETB)
                    Store (RETB, Debug)
                    Return (RETB)
                }
            }

            Device (SMBC)
            {
                Name (_ADR, 0x001F0003)
            }

            Device (MODM)
            {
                Name (_ADR, 0x001F0006)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x05, 0x03))
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x01, P0WE)
                        Store (0x01, P1WE)
                    }
                    Else
                    {
                        Store (0x00, P0WE)
                        Store (0x00, P1WE)
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Store (Zero, Local0)
                    If (LEqual (OSFG, OS9X))
                    {
                        Store (One, Local0)
                    }
                    Else
                    {
                        If (LEqual (OSFG, OS98))
                        {
                            Store (One, Local0)
                        }
                    }

                    If (Local0)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    Store (UBAS, BASA)
                    And (BASA, 0xFFFFFFFE, BASA)
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    Store (CCS0, P0ST)
                    Store (CCS1, P1ST)
                }

                Method (RSTA, 0, NotSerialized)
                {
                    Store (BASA, UBAS)
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    If (P0ST)
                    {
                        Store (CCS0, PED0)
                    }

                    If (P1ST)
                    {
                        Store (CCS1, PED1)
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x03, 0x03))
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x01, P0WE)
                        Store (0x01, P1WE)
                    }
                    Else
                    {
                        Store (0x00, P0WE)
                        Store (0x00, P1WE)
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Store (Zero, Local0)
                    If (LEqual (OSFG, OS9X))
                    {
                        Store (One, Local0)
                    }
                    Else
                    {
                        If (LEqual (OSFG, OS98))
                        {
                            Store (One, Local0)
                        }
                    }

                    If (Local0)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    Store (UBAS, BASA)
                    And (BASA, 0xFFFFFFFE, BASA)
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    Store (CCS0, P0ST)
                    Store (CCS1, P1ST)
                }

                Method (RSTA, 0, NotSerialized)
                {
                    Store (BASA, UBAS)
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    If (P0ST)
                    {
                        Store (CCS0, PED0)
                    }

                    If (P1ST)
                    {
                        Store (CCS1, PED1)
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x04, 0x03))
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16, 
                    Offset (0x04), 
                    P0WE,   1, 
                    P1WE,   1, 
                    Offset (0x05)
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x01, P0WE)
                        Store (0x01, P1WE)
                    }
                    Else
                    {
                        Store (0x00, P0WE)
                        Store (0x00, P1WE)
                    }
                }

                Method (UPAC, 1, NotSerialized)
                {
                    Store (Zero, Local0)
                    If (LEqual (OSFG, OS9X))
                    {
                        Store (One, Local0)
                    }
                    Else
                    {
                        If (LEqual (OSFG, OS98))
                        {
                            Store (One, Local0)
                        }
                    }

                    If (Local0)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                OperationRegion (UPCI, PCI_Config, 0x20, 0x04)
                Field (UPCI, ByteAcc, NoLock, Preserve)
                {
                    UBAS,   32
                }

                Name (BASA, 0xB400)
                Name (P0ST, Zero)
                Name (P1ST, Zero)
                Method (SSTA, 0, NotSerialized)
                {
                    Store (UBAS, BASA)
                    And (BASA, 0xFFFFFFFE, BASA)
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    Store (CCS0, P0ST)
                    Store (CCS1, P1ST)
                }

                Method (RSTA, 0, NotSerialized)
                {
                    Store (BASA, UBAS)
                    OperationRegion (UHCI, SystemIO, BASA, 0x20)
                    Field (UHCI, ByteAcc, NoLock, Preserve)
                    {
                        RSTP,   1, 
                        HRST,   1, 
                        GRST,   1, 
                        Offset (0x10), 
                        CCS0,   1, 
                        CSC0,   1, 
                        PED0,   1, 
                        Offset (0x12), 
                        CCS1,   1, 
                        CSC1,   1, 
                        PED1,   1
                    }

                    If (P0ST)
                    {
                        Store (CCS0, PED0)
                    }

                    If (P1ST)
                    {
                        Store (CCS1, PED1)
                    }
                }

                Method (USBS, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        SSTA ()
                    }
                }

                Method (USBW, 1, NotSerialized)
                {
                    If (UPAC (Arg0))
                    {
                        RSTA ()
                    }
                }

                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x0C, 0x03))
                }
            }

            Device (EHCI)
            {
                Name (_ADR, 0x001D0007)
                OperationRegion (U20P, PCI_Config, 0x00, 0x0100)
                Field (U20P, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                        ,   1, 
                    MSPE,   1, 
                    Offset (0x06), 
                    Offset (0x10), 
                    MBAS,   32, 
                    Offset (0x54), 
                    PSTA,   2, 
                    Offset (0x55), 
                    PMEE,   1, 
                        ,   6, 
                    PMES,   1
                }

                Method (_PSW, 1, NotSerialized)
                {
                    Store (MBAS, Local0)
                    And (Local0, 0xFFFFFFF0, Local0)
                    OperationRegion (MMIO, SystemMemory, Local0, 0x0100)
                    Field (MMIO, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x64), 
                        P0SC,   32, 
                        P1SC,   32, 
                        P2SC,   32, 
                        P3SC,   32, 
                        P4SC,   32, 
                        P5SC,   32
                    }

                    If (LNot (Local0))
                    {
                        Store (PSTA, Local2)
                        Store (Zero, PSTA)
                        Store (MSPE, Local3)
                        Store (One, MSPE)
                        If (Arg0)
                        {
                            Store (P0SC, Local4)
                            Or (Local4, 0x00300000, Local4)
                            Store (Local4, P0SC)
                            Store (P1SC, Local4)
                            Or (Local4, 0x00300000, Local4)
                            Store (Local4, P1SC)
                            Store (P2SC, Local4)
                            Or (Local4, 0x00300000, Local4)
                            Store (Local4, P2SC)
                            Store (P3SC, Local4)
                            Or (Local4, 0x00300000, Local4)
                            Store (Local4, P3SC)
                            Store (P4SC, Local4)
                            Or (Local4, 0x00300000, Local4)
                            Store (Local4, P4SC)
                            Store (P5SC, Local4)
                            Or (Local4, 0x00300000, Local4)
                            Store (Local4, P5SC)
                            Store (One, PMES)
                            Store (One, PMEE)
                        }
                        Else
                        {
                            Store (P0SC, Local4)
                            And (Local4, 0xFFCFFFFF, Local4)
                            Store (Local4, P0SC)
                            Store (P1SC, Local4)
                            And (Local4, 0xFFCFFFFF, Local4)
                            Store (Local4, P1SC)
                            Store (P2SC, Local4)
                            And (Local4, 0xFFCFFFFF, Local4)
                            Store (Local4, P2SC)
                            Store (P3SC, Local4)
                            And (Local4, 0xFFCFFFFF, Local4)
                            Store (Local4, P3SC)
                            Store (P4SC, Local4)
                            And (Local4, 0xFFCFFFFF, Local4)
                            Store (Local4, P4SC)
                            Store (P5SC, Local4)
                            And (Local4, 0xFFCFFFFF, Local4)
                            Store (Local4, P5SC)
                            Store (One, PMES)
                            Store (Zero, PMEE)
                        }

                        Store (Local3, MSPE)
                        Store (Local2, PSTA)
                    }
                }

                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x0D, 0x03))
                }
            }
        }
    }

    Scope (\_PR.CPU1)
    {
        Name (TYPE, 0x00)
        Name (PDCR, 0x01)
        Name (PDCM, 0x01)
        Method (_PDC, 1, NotSerialized)
        {
            Store (SizeOf (Arg0), Local0)
            Name (PDCB, Buffer (Local0) {})
            Store (Arg0, PDCB)
            CreateDWordField (PDCB, 0x00, REV)
            CreateDWordField (PDCB, 0x04, SIZE)
            If (LNot (LEqual (REV, PDCR)))
            {
                Return (0x00)
            }

            If (LLess (SIZE, 0x01))
            {
                Return (0x00)
            }

            CreateDWordField (PDCB, 0x08, DAT0)
            If (And (DAT0, PDCM))
            {
                Store (0x01, TYPE)
            }

            Return (0x01)
        }

        Name (MPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 0x40, 0x00, 0x0000000000000199)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 0x10, 0x00, 0x0000000000000198)
            }
        })
        Name (PPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 0x10, 0x00, 0x00000000000000B2)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 0x08, 0x00, 0x00000000000000B3)
            }
        })
        Method (_PCT, 0, NotSerialized)
        {
            If (TYPE)
            {
                Return (MPCT)
            }
            Else
            {
                Return (PPCT)
            }
        }

        Name (MPSS, Package (0x0A)
        {
            Package (0x06)
            {
                0x06A4, 
                0x84D0, 
                0x0A, 
                0x0A, 
                0x112C, 
                0x112C
            }, 

            Package (0x06)
            {
                0x06A4, 
                0x84D0, 
                0x0A, 
                0x0A, 
                0x112C, 
                0x112C
            }, 

            Package (0x06)
            {
                0x06A4, 
                0x84D0, 
                0x0A, 
                0x0A, 
                0x112C, 
                0x112C
            }, 

            Package (0x06)
            {
                0x06A4, 
                0x84D0, 
                0x0A, 
                0x0A, 
                0x112C, 
                0x112C
            }, 

            Package (0x06)
            {
                0x0640, 
                0x7D00, 
                0x0A, 
                0x0A, 
                0x1029, 
                0x1029
            }, 

            Package (0x06)
            {
                0x0578, 
                0x6D60, 
                0x0A, 
                0x0A, 
                0x0E23, 
                0x0E23
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x5DC0, 
                0x0A, 
                0x0A, 
                0x0C1D, 
                0x0C1D
            }, 

            Package (0x06)
            {
                0x03E8, 
                0x4E20, 
                0x0A, 
                0x0A, 
                0x0A17, 
                0x0A17
            }, 

            Package (0x06)
            {
                0x0320, 
                0x3E80, 
                0x0A, 
                0x0A, 
                0x0811, 
                0x0811
            }, 

            Package (0x06)
            {
                0x0258, 
                0x2EE0, 
                0x0A, 
                0x0A, 
                0x060B, 
                0x060B
            }
        })
        Name (PPSS, Package (0x0A)
        {
            Package (0x06)
            {
                0x0578, 
                0x6D60, 
                0x0A, 
                0x6E, 
                0x86, 
                0x00
            }, 

            Package (0x06)
            {
                0x0578, 
                0x6D60, 
                0x0A, 
                0x6E, 
                0x86, 
                0x00
            }, 

            Package (0x06)
            {
                0x0578, 
                0x6D60, 
                0x0A, 
                0x6E, 
                0x86, 
                0x00
            }, 

            Package (0x06)
            {
                0x0578, 
                0x6D60, 
                0x0A, 
                0x6E, 
                0x86, 
                0x00
            }, 

            Package (0x06)
            {
                0x0578, 
                0x6D60, 
                0x0A, 
                0x6E, 
                0x0086, 
                0x00
            }, 

            Package (0x06)
            {
                0x0578, 
                0x6D60, 
                0x0A, 
                0x6E, 
                0x0086, 
                0x00
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x5DC0, 
                0x0A, 
                0x6E, 
                0x0186, 
                0x01
            }, 

            Package (0x06)
            {
                0x03E8, 
                0x4E20, 
                0x0A, 
                0x6E, 
                0x0286, 
                0x02
            }, 

            Package (0x06)
            {
                0x0320, 
                0x3E80, 
                0x0A, 
                0x6E, 
                0x0386, 
                0x03
            }, 

            Package (0x06)
            {
                0x0258, 
                0x2EE0, 
                0x0A, 
                0x6E, 
                0x0486, 
                0x04
            }
        })
        Name (NPSS, 0x05)
        Method (_PSS, 0, NotSerialized)
        {
            If (TYPE)
            {
                Return (MPSS)
            }
            Else
            {
                Return (PPSS)
            }
        }

        Method (_PPC, 0, NotSerialized)
        {
            If (LNot (LGreater (SizeOf (PPSS), NPSS)))
            {
                Return (0x00)
            }
            Else
            {
                Return (Subtract (SizeOf (PPSS), NPSS))
            }
        }
    }

    Scope (\_SB)
    {
        OperationRegion (\_SB.PCI0.SBRG.IROR, PCI_Config, 0x00, 0xFF)
        Field (\_SB.PCI0.SBRG.IROR, ByteAcc, NoLock, Preserve)
        {
            Offset (0x60), 
            PIRA,   8, 
            PIRB,   8, 
            PIRC,   8, 
            PIRD,   8, 
            Offset (0x68), 
            PIRE,   8, 
            PIRF,   8, 
            PIRG,   8, 
            PIRH,   8
        }

        Name (BUFA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {15}
        })
        CreateWordField (BUFA, 0x01, ICRS)
        Method (LSTA, 1, NotSerialized)
        {
            And (Arg0, 0x80, Local0)
            If (Local0)
            {
                Return (0x09)
            }
            Else
            {
                Return (0x0B)
            }
        }

        Method (LCRS, 1, NotSerialized)
        {
            And (Arg0, 0x0F, Local0)
            ShiftLeft (0x01, Local0, ICRS)
            Return (BUFA)
        }

        Method (LSRS, 1, NotSerialized)
        {
            CreateWordField (Arg0, 0x01, ISRS)
            FindSetRightBit (ISRS, Local0)
            Return (Decrement (Local0))
        }

        Method (LDIS, 1, NotSerialized)
        {
            Return (Or (Arg0, 0x80))
        }

        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x01)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRA))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSA)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRA), PIRA)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRA))
            }

            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), PIRA)
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x02)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRB))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSB)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRB), PIRB)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRB))
            }

            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), PIRB)
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x03)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRC))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSC)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRC), PIRC)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRC))
            }

            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), PIRC)
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x04)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRD))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSD)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRD), PIRD)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRD))
            }

            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), PIRD)
            }
        }

        Device (LNKE)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x05)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRE))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSE)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRE), PIRE)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRE))
            }

            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), PIRE)
            }
        }

        Device (LNKF)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x06)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRF))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSF)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRF), PIRF)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRF))
            }

            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), PIRF)
            }
        }

        Device (LNKG)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x07)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRG))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSG)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRG), PIRG)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRG))
            }

            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), PIRG)
            }
        }

        Device (LNKH)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x08)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRH))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSH)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRH), PIRH)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRH))
            }

            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), PIRH)
            }
        }
    }

    Scope (\_SB)
    {
        Scope (PCI0)
        {
            Name (CRS, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
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
                    0x00000000,
                    0x00000000,
                    0x00000000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000)
            })
            CreateDWordField (CRS, 0x5C, MIN5)
            CreateDWordField (CRS, 0x60, MAX5)
            CreateDWordField (CRS, 0x68, LEN5)
            CreateDWordField (CRS, 0x76, MIN6)
            CreateDWordField (CRS, 0x7A, MAX6)
            CreateDWordField (CRS, 0x82, LEN6)
            Method (_CRS, 0, NotSerialized)
            {
                Store (MG1B, MIN5)
                Store (MG1L, LEN5)
                Store (MG1L, Local0)
                If (Local0)
                {
                    Add (MIN5, Decrement (Local0), MAX5)
                }

                Store (MG2B, MIN6)
                Store (MG2L, LEN6)
                Store (MG2L, Local0)
                Add (MIN6, Decrement (Local0), MAX6)
                Return (CRS)
            }
        }
    }

    If (SS1)
    {
        Name (\_SB.PCI0._S1D, 0x02)
        Name (\_SB.PCI0.P0P1._S1D, 0x02)
        Name (\_SB.PCI0.USB1._S1D, 0x02)
        Name (\_SB.PCI0.USB2._S1D, 0x02)
        Name (\_SB.PCI0.USB3._S1D, 0x02)
    }

    If (SS3)
    {
        Name (\_SB.PCI0._S3D, 0x02)
        Name (\_SB.PCI0.P0P1._S3D, 0x02)
        Name (\_SB.PCI0.USB1._S3D, 0x02)
        Name (\_SB.PCI0.USB2._S3D, 0x02)
        Name (\_SB.PCI0.USB3._S3D, 0x02)
    }

    If (SS4)
    {
        Name (\_SB.PCI0._S4D, 0x02)
        Name (\_SB.PCI0.P0P1._S4D, 0x02)
    }

    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, DBG8)
        PTS (Arg0)
        Store (0x00, Index (WAKP, 0x00))
        Store (0x00, Index (WAKP, 0x01))
    }

    Name (SLID, 0x01)
    Method (_WAK, 1, NotSerialized)
    {
        ShiftLeft (Arg0, 0x04, DBG8)
        Store (0x01, SLID)
        WAK (Arg0)
        If (DerefOf (Index (WAKP, 0x00)))
        {
            Store (0x00, Index (WAKP, 0x01))
        }
        Else
        {
            Store (Arg0, Index (WAKP, 0x01))
        }

        Return (WAKP)
    }

    Name (_S0, Package (0x04)
    {
        0x00, 
        0x00, 
        0x00, 
        0x00
    })
    If (SS1)
    {
        Name (_S1, Package (0x04)
        {
            0x02, 
            0x00, 
            0x00, 
            0x00
        })
    }

    If (SS3)
    {
        Name (_S3, Package (0x04)
        {
            0x05, 
            0x00, 
            0x00, 
            0x00
        })
    }

    If (SS4)
    {
        Name (_S4, Package (0x04)
        {
            0x06, 
            0x00, 
            0x00, 
            0x00
        })
    }

    Name (_S5, Package (0x04)
    {
        0x07, 
        0x00, 
        0x00, 
        0x00
    })
    Method (PTS, 1, NotSerialized)
    {
        If (Arg0)
        {
            FANS (Arg0)
            \_TZ.TRMS (Arg0)
        }

        OEMS (Arg0)
    }

    Method (WAK, 1, NotSerialized)
    {
        FANW (Arg0)
        \_TZ.TRMW (Arg0)
        OEMW (Arg0)
    }
}


--Boundary-00=_N7t4BogCo2a92aX--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
