From: Daniel Burke <burkey-YVaAKlyYKEBBDgjK7y7TUQ@public.gmane.org>
Subject: LG LM50-3 laptop no battery
Date: Sun, 07 Mar 2004 11:45:31 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078620331.4445.7.camel@localhost>
Reply-To: burkey-YVaAKlyYKEBBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6k7t4OU/ksbr+p+cKjn3"
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


--=-6k7t4OU/ksbr+p+cKjn3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I have what must be a one of a kind on linux!  A new LG Centino Laptop,
which run's Linux great.. mostly, sadly Intel have not released their
wireless driver which forces me to driverload wireless, and the SD card
slot if not yet working, but everything else is besides the battery, I
get the following error from dmesg

ACPI: Subsystem revision 20040211
ACPI: IRQ9 SCI: Edge set to Level Trigger.
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0._INI]
(Node c15d5
aa0), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
    ACPI-1120: *** Error: Method execution failed [\_SB_.CMB0._STA]
(Node c15d5
ca0), AE_NOT_EXIST

and I have attached the DSDT disassemble, not being familiar at all with
AML source, I dont want to just blindly start modifying code (I am a C++
s/w engineer) and know enough to know I can badly mess it up...

So I am really hoping I can get some help on this one, as I intend to
put up a howto on getting Linux working on this awesome laptop.

If need be I could attach the whole dmesg output if it would help. 
AC-Adapter is ok, as is LID and Power button


Regards,
-- 
Daniel Burke

--=-6k7t4OU/ksbr+p+cKjn3
Content-Disposition: attachment; filename=dsdt.dsl
Content-Type: text/x-dsl; name=dsdt.dsl; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030522
 *
 * Disassembly of dsdt.dat, Mon Feb 23 22:22:10 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "INTEL ", "ODEM    ", 100925440)
{
    OperationRegion (PORT, SystemIO, 0x80, 0x01)
    Field (PORT, ByteAcc, NoLock, Preserve)
    {
        P80H,   8
    }

    OperationRegion (IO_T, SystemIO, 0x0800, 0x08)
    Field (IO_T, ByteAcc, NoLock, Preserve)
    {
        TRP0,   8
    }

    OperationRegion (PMIO, SystemIO, 0x1000, 0x50)
    Field (PMIO, ByteAcc, NoLock, Preserve)
    {
        Offset (0x10), 
            ,   1, 
        TDTY,   3, 
        THTL,   1
    }

    OperationRegion (GPIO, SystemIO, 0x1180, 0x3C)
    Field (GPIO, ByteAcc, NoLock, Preserve)
    {
        GU00,   8, 
        GU01,   8, 
        GU02,   8, 
        GU03,   8, 
        GIO0,   8, 
        GIO1,   8, 
        GIO2,   8, 
        GIO3,   8, 
        Offset (0x0C), 
        GL00,   8, 
        GL01,   8, 
        GL02,   8, 
        GL03,   8, 
        Offset (0x18), 
        GB00,   8, 
        GB01,   8, 
        GB02,   8, 
        GB03,   8, 
        Offset (0x2C), 
        GIV0,   8, 
        GIV1,   8, 
        GIV2,   8, 
        GIV3,   8, 
        GU04,   8, 
        GU05,   8, 
        GU06,   8, 
        GU07,   8, 
        GIO4,   8, 
        GIO5,   8, 
        GIO6,   8, 
        GIO7,   8, 
            ,   1, 
            ,   1, 
        CPEN,   1, 
        Offset (0x39), 
        GL05,   8, 
        GL06,   8, 
        GL07,   8
    }

    OperationRegion (MNVS, SystemMemory, 0x1FF6CE6C, 0x40)
    Field (MNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        SCIF,   8, 
        PRM2,   8, 
        PRM3,   8, 
        LCKF,   8, 
        PRM4,   8, 
        PRM5,   8, 
        DBGS,   8, 
        DCKS,   4, 
        CDCK,   4, 
        FPEN,   8, 
        FPST,   8, 
        LIDS,   8, 
        PWRS,   8, 
        WRK0,   1, 
        WRK1,   1, 
        SIDE,   8, 
        Offset (0x14), 
        CMAP,   8, 
        CMBP,   8, 
        LPTP,   8, 
        FDCP,   8, 
        Offset (0x19), 
        ACTT,   8, 
        PSVT,   8, 
        TC1V,   8, 
        TC2V,   8, 
        TSPV,   8, 
        CRTT,   8, 
        Offset (0x20), 
        BVAL,   32, 
        TMP0,   8, 
        TMP1,   8, 
        TMP2,   8, 
        TMP3,   8, 
        TMP4,   32, 
        TMP5,   32
    }

    Mutex (MUTX, 0x00)
    Name (_S0, Package (0x03)
    {
        0x00, 
        0x00, 
        0x00
    })
    Name (_S3, Package (0x03)
    {
        0x05, 
        0x05, 
        0x00
    })
    Name (_S4, Package (0x03)
    {
        0x06, 
        0x06, 
        0x00
    })
    Name (_S5, Package (0x03)
    {
        0x07, 
        0x07, 
        0x00
    })
    Name (DSEN, 0x01)
    Name (ENUM, 0x01)
    Name (NEDV, 0x01)
    Name (\CP3D, 0x00)
    OperationRegion (NV1, SystemIO, 0x72, 0x04)
    Field (NV1, ByteAcc, NoLock, Preserve)
    {
        CMID,   8, 
        CMDA,   8
    }

    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06)
        {
            Method (_CST, 0, NotSerialized)
            {
                Return (Package (0x04)
                {
                    0x03, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 0x08, 0x00, 0x0000000000000000)
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
                        0x01, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 0x08, 0x00, 0x0000000000001015)
                        }, 

                        0x03, 
                        0x55, 
                        0xFA
                    }
                })
            }
        }
    }

    Name (\GPIC, 0x00)
    Name (\CTYP, 0x00)
    Name (\ECON, 0x00)
    Name (\CSST, 0x00)
    Method (\_PIC, 1, NotSerialized)
    {
        Store (Arg0, GPIC)
    }

    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, \CSST)
        Store (Arg0, P80H)
        Acquire (MUTX, 0xFFFF)
        Store (\CSST, \_SB.PCI0.LPCB.EC.SPT)
        If (LEqual (\CSST, 0x05))
        {
            Store (0x00, \_SB.PCI0.LPCB.EC.ACPI)
        }

        Release (MUTX)
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (Arg0, P80H)
        If (LNot (LLess (Arg0, 0x03)))
        {
            Acquire (MUTX, 0xFFFF)
            Store (0x01, \_SB.PCI0.LPCB.EC.ACPI)
            Store (0x00, \_SB.PCI0.LPCB.EC.SPT)
            Release (MUTX)
        }

        Notify (\_SB.PCI0.USB0, 0x00)
        Notify (\_SB.PCI0.USB1, 0x00)
        Notify (\_SB.PCI0.USB2, 0x00)
        Notify (\_SB.PCI0.USB7, 0x00)
        Notify (\_SB.AC, 0x80)
        Notify (\_SB.CMB0, 0x81)
        Notify (\_SB.CMB0, 0x80)
        Store (0x00, \CSST)
        Return (Package (0x02)
        {
            0x00, 
            0x00
        })
    }

    Scope (\_GPE)
    {
        Method (_L00, 0, NotSerialized)
        {
            Store (0x2C, SMIF)
            Store (0x00, TRP0)
        }

        Method (_L03, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB0, 0x02)
            Notify (\_SB.PWRB, 0x02)
            Store (0x03, P80H)
        }

        Method (_L04, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB1, 0x02)
            Notify (\_SB.PWRB, 0x02)
            Store (0x04, P80H)
        }

        Method (_L07, 0, NotSerialized)
        {
            Store (0x20, \_SB.PCI0.SBUS.HSTS)
            Notify (\_SB.PCI0.SBUS, 0x02)
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.SLPB, 0x02)
        }

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB2, 0x02)
            Notify (\_SB.PWRB, 0x02)
            Store (0x0C, P80H)
        }

        Method (_L0D, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB7, 0x02)
            Notify (\_SB.PWRB, 0x02)
            Store (0x0D, P80H)
        }

        Method (_L18, 0, NotSerialized)
        {
        }
    }

    Scope (\_TZ)
    {
        Name (C_TP, 0x61)
        Name (B_TP, 0x54)
        Name (D_TP, 0x3C)
        Name (O_TP, 0x02)
        Name (AC0R, 0x01)
        Name (AC1R, 0x02)
        Name (AC2R, 0x03)
        Name (AC3R, 0x04)
        Name (AC4R, 0x05)
        Name (AC5R, 0x06)
        Name (AC6R, 0x07)
        Name (DC0T, 0x5F)
        Name (DC1T, 0x5D)
        Name (DC2T, 0x5B)
        Name (BC0T, 0x52)
        Name (BC1T, 0x50)
        Name (BC2T, 0x4E)
        Name (S1LT, 0x00)
        Name (S1HT, 0x50)
        Name (S2LT, 0x00)
        Name (S2HT, 0x50)
        Name (TSCP, 0x00)
        Name (L0ST, 0x00)
        Name (L1ST, 0x00)
        Name (L2ST, 0x00)
        Name (TSCI, 0x00)
        PowerResource (LRP0, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Store ("LRP0 _STA", Debug)
                Return (L0ST)
            }

            Method (_ON, 0, Serialized)
            {
                If (TSCI)
                {
                    Store ("LRP0 _ON", Debug)
                    Store (0xE0, P80H)
                    Store (One, L0ST)
                    Store (One, THTL)
                    Store (AC1R, TDTY)
                }
            }

            Method (_OFF, 0, Serialized)
            {
                If (TSCI)
                {
                    Store ("LRP0 _OFF", Debug)
                    Store (0xF0, P80H)
                    Store (Zero, L0ST)
                    If (LOr (L1ST, L2ST))
                    {
                        If (L1ST)
                        {
                            Store (AC3R, TDTY)
                        }
                        Else
                        {
                            Store (AC5R, TDTY)
                        }
                    }
                    Else
                    {
                        Store (Zero, THTL)
                    }
                }
            }
        }

        PowerResource (LRP1, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Store ("LRP1 _STA", Debug)
                Return (L1ST)
            }

            Method (_ON, 0, Serialized)
            {
                If (LNot (L0ST))
                {
                    If (TSCI)
                    {
                        Store ("LRP1 _ON", Debug)
                        Store (0xE1, P80H)
                        Store (One, L1ST)
                        Store (One, THTL)
                        Store (AC3R, TDTY)
                    }
                }
            }

            Method (_OFF, 0, Serialized)
            {
                If (TSCI)
                {
                    Store ("LRP1 _OFF", Debug)
                    Store (0xF1, P80H)
                    Store (Zero, L1ST)
                    If (LOr (L0ST, L2ST))
                    {
                        If (L0ST)
                        {
                            Store (Zero, L0ST)
                            Store (One, L2ST)
                            Store (AC5R, TDTY)
                        }
                        Else
                        {
                            Store (AC5R, TDTY)
                        }
                    }
                    Else
                    {
                        Store (Zero, THTL)
                    }
                }
            }
        }

        PowerResource (LRP2, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                Store ("LRP2 _STA", Debug)
                Return (L2ST)
            }

            Method (_ON, 0, Serialized)
            {
                If (LNot (LOr (L0ST, L1ST)))
                {
                    If (TSCI)
                    {
                        Store ("LRP2 _ON", Debug)
                        Store (0xE2, P80H)
                        Store (One, L2ST)
                        Store (One, THTL)
                        Store (AC5R, TDTY)
                    }
                }
            }

            Method (_OFF, 0, Serialized)
            {
                If (TSCI)
                {
                    Store ("LRP2 _OFF", Debug)
                    Store (0xF2, P80H)
                    Store (Zero, L2ST)
                    Store (Zero, L1ST)
                    Store (Zero, L0ST)
                    Store (Zero, THTL)
                    If (LOr (L0ST, L1ST))
                    {
                        If (L0ST)
                        {
                            Store (AC1R, TDTY)
                        }
                        Else
                        {
                            Store (AC3R, TDTY)
                        }
                    }
                    Else
                    {
                        Store (Zero, THTL)
                    }
                }
            }
        }

        Device (FAN0)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, 0x01)
            Name (_PR0, Package (0x01)
            {
                LRP0
            })
        }

        Device (FAN1)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, 0x02)
            Name (_PR0, Package (0x01)
            {
                LRP1
            })
        }

        Device (FAN2)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, 0x03)
            Name (_PR0, Package (0x01)
            {
                LRP2
            })
        }

        ThermalZone (THM2)
        {
            Method (_AC0, 0, NotSerialized)
            {
                Store (0xC0, P80H)
                Store ("_AC0", Debug)
                Return (GACX (BC0T))
            }

            Name (_AL0, Package (0x01)
            {
                FAN0
            })
            Method (_AC1, 0, NotSerialized)
            {
                Store (0xC1, P80H)
                Store ("_AC1", Debug)
                Return (GACX (BC1T))
            }

            Name (_AL1, Package (0x01)
            {
                FAN1
            })
            Method (_AC2, 0, NotSerialized)
            {
                Store (0xC2, P80H)
                Store ("_AC2", Debug)
                Return (GACX (BC2T))
            }

            Name (_AL2, Package (0x01)
            {
                FAN2
            })
            Method (_CRT, 0, NotSerialized)
            {
                Store ("_CRT", Debug)
                Return (KELV (B_TP))
            }

            Method (_TMP, 0, NotSerialized)
            {
                If (\ECON)
                {
                    Store (0xC3, P80H)
                    Acquire (MUTX, 0xFFFF)
                    Store (\_SB.PCI0.LPCB.EC.TMP2, Local0)
                    Release (MUTX)
                    Return (KELV (Local0))
                }
                Else
                {
                    Return (KELV (D_TP))
                }
            }

            Method (KELV, 1, NotSerialized)
            {
                Multiply (Arg0, 0x0A, Local0)
                Add (Local0, 0x0AAC, Local0)
                Return (Local0)
            }

            Method (_SCP, 1, NotSerialized)
            {
                Store (Arg0, TSCP)
                Notify (\_TZ.THM2, 0x81)
            }

            Method (GACX, 1, NotSerialized)
            {
                Return (KELV (Arg0))
            }
        }

        ThermalZone (THRM)
        {
            Name (SCIF, 0x00)
            Method (_AC0, 0, NotSerialized)
            {
                Store (0xC0, P80H)
                Store ("_AC0", Debug)
                Return (GACX (DC0T))
            }

            Name (_AL0, Package (0x01)
            {
                FAN0
            })
            Method (_AC1, 0, NotSerialized)
            {
                Store (0xC1, P80H)
                Store ("_AC1", Debug)
                Return (GACX (DC1T))
            }

            Name (_AL1, Package (0x01)
            {
                FAN1
            })
            Method (_AC2, 0, NotSerialized)
            {
                Store (0xC2, P80H)
                Store ("_AC2", Debug)
                Return (GACX (DC2T))
            }

            Name (_AL2, Package (0x01)
            {
                FAN2
            })
            Method (_CRT, 0, NotSerialized)
            {
                Store ("_CRT", Debug)
                Return (KELV (C_TP))
            }

            Method (_TMP, 0, NotSerialized)
            {
                If (\ECON)
                {
                    Store (0xC3, P80H)
                    Acquire (MUTX, 0xFFFF)
                    Store (\_SB.PCI0.LPCB.EC.TMP1, Local0)
                    Release (MUTX)
                    Return (KELV (Local0))
                }
                Else
                {
                    Return (KELV (D_TP))
                }
            }

            Method (KELV, 1, NotSerialized)
            {
                Multiply (Arg0, 0x0A, Local0)
                Add (Local0, 0x0AAC, Local0)
                Return (Local0)
            }

            Method (_SCP, 1, NotSerialized)
            {
                Store (Arg0, TSCP)
                Notify (\_TZ.THRM, 0x81)
            }

            Method (GACX, 1, NotSerialized)
            {
                Return (KELV (Arg0))
            }
        }
    }

    Scope (\_SB)
    {
        Device (AC)
        {
            Name (_HID, "ACPI0003")
            Name (ACPW, Ones)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (_STA, 0x0F)
            Method (_PSR, 0, NotSerialized)
            {
                If (\ECON)
                {
                    Acquire (MUTX, 0xFFFF)
                    Store (\_SB.PCI0.LPCB.EC.ACP, Local0)
                    If (Local0)
                    {
                        And (\_SB.PCI0.LPCB.PMC1, 0x7F, \_SB.PCI0.LPCB.PMC1)
                    }
                    Else
                    {
                        And (\_SB.PCI0.LPCB.PMC1, 0x7F, \_SB.PCI0.LPCB.PMC1)
                    }

                    And (\_SB.PCI0.LPCB.EC.ACP, 0x01, ACPW)
                    Release (MUTX)
                    Return (ACPW)
                }
                Else
                {
                    Return (0x01)
                }
            }
        }

        Device (CMB0)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Name (BATS, Ones)
            Name (CRIT, 0x00)
            Name (LFC0, 0xFFFF)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Method (_STA, 0, NotSerialized)
            {
                If (\ECON)
                {
                    Acquire (MUTX, 0xFFFF)
                    And (\_SB.PCI0.LPCB.EC.BAP1, 0x01, BATS)
                    Release (MUTX)
                    If (LEqual (BATS, Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (0x1F)
                    }
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (PBIF, Package (0x0D)
            {
                0x01, 
                Ones, 
                Ones, 
                0x01, 
                Ones, 
                0x0320, 
                0x0320, 
                0x64, 
                0x64, 
                "BAT1", 
                "1234", 
                "LION", 
                "LGIBM"
            })
            Method (_BIF, 0, NotSerialized)
            {
                Store (0xB1, P80H)
                If (\ECON)
                {
                    Acquire (MUTX, 0xFFFF)
                    ShiftRight (And (\_SB.PCI0.LPCB.EC.BDC, 0xFF00, Local0), 0x08, Local0)
                    ShiftLeft (And (\_SB.PCI0.LPCB.EC.BDC, 0xFF, Local1), 0x08, Local1)
                    Add (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Local0)
                    }

                    Store (Local0, Index (PBIF, 0x01))
                    ShiftRight (And (\_SB.PCI0.LPCB.EC.BLFC, 0xFF00, Local0), 0x08, Local0)
                    ShiftLeft (And (\_SB.PCI0.LPCB.EC.BLFC, 0xFF, Local1), 0x08, Local1)
                    Add (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Local0)
                    }

                    Store (Local0, Index (PBIF, 0x02))
                    Store (Local0, LFC0)
                    Store (0x01, Index (PBIF, 0x03))
                    ShiftRight (And (\_SB.PCI0.LPCB.EC.BDV, 0xFF00, Local0), 0x08, Local0)
                    ShiftLeft (And (\_SB.PCI0.LPCB.EC.BDV, 0xFF, Local1), 0x08, Local1)
                    Add (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Local0)
                    }

                    Store (Local0, Index (PBIF, 0x04))
                    ShiftRight (And (\_SB.PCI0.LPCB.EC.BDWC, 0xFF00, Local0), 0x08, Local0)
                    ShiftLeft (And (\_SB.PCI0.LPCB.EC.BDWC, 0xFF, Local1), 0x08, Local1)
                    Add (Local0, Local1, Local0)
                    Store (Local0, Index (PBIF, 0x05))
                    Store (0x10, Index (PBIF, 0x06))
                    ShiftRight (And (\_SB.PCI0.LPCB.EC.BSN, 0xFF00, Local0), 0x08, Local0)
                    ShiftLeft (And (\_SB.PCI0.LPCB.EC.BSN, 0xFF, Local1), 0x08, Local1)
                    Add (Local0, Local1, Local0)
                    Name (SERN, Buffer (0x06)
                    {
                        "     "
                    })
                    Store (0x04, Local2)
                    While (Local0)
                    {
                        Divide (Local0, 0x0A, Local1, Local0)
                        Add (Local1, 0x30, Index (SERN, Local2))
                        Decrement (Local2)
                    }

                    Store (SERN, Index (PBIF, 0x0A))
                    Release (MUTX)
                }

                Store (0xB2, P80H)
                Return (PBIF)
            }

            Name (BUFF, Package (0x04)
            {
                0x00, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Method (_BST, 0, NotSerialized)
            {
                Store (0xB3, P80H)
                If (\ECON)
                {
                    Acquire (MUTX, 0xFFFF)
                    If (And (\_SB.PCI0.LPCB.EC.BST, 0x03))
                    {
                        Store (\_SB.PCI0.LPCB.EC.BST, Local0)
                    }
                    Else
                    {
                        Store (Or (0x01, \_SB.PCI0.LPCB.EC.BST), Local0)
                    }

                    Store (And (Local0, 0x07), Local1)
                    Store (Local1, Index (BUFF, 0x00))
                    ShiftRight (And (\_SB.PCI0.LPCB.EC.BPR, 0xFF00, Local0), 0x08, Local0)
                    ShiftLeft (And (\_SB.PCI0.LPCB.EC.BPR, 0xFF, Local1), 0x08, Local1)
                    Add (Local0, Local1, Local0)
                    If (LEqual (Local0, 0x7FFF))
                    {
                        Store (0xFFFFFFFF, Local0)
                        Store (Local0, Index (BUFF, 0x01))
                    }
                    Else
                    {
                        Store (Local0, Local1)
                        If (And (Local0, 0x8000))
                        {
                            Store (Subtract (0x00010000, Local1), Local2)
                        }
                        Else
                        {
                            Store (Local1, Local2)
                        }

                        Store (Local2, Index (BUFF, 0x01))
                    }

                    ShiftRight (And (\_SB.PCI0.LPCB.EC.BRC, 0xFF00, Local0), 0x08, Local0)
                    ShiftLeft (And (\_SB.PCI0.LPCB.EC.BRC, 0xFF, Local1), 0x08, Local1)
                    Add (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Local0)
                    }

                    If (LGreater (Local0, LFC0))
                    {
                        Store (LFC0, Index (BUFF, 0x02))
                    }
                    Else
                    {
                        Store (Local0, Index (BUFF, 0x02))
                    }

                    ShiftRight (And (\_SB.PCI0.LPCB.EC.BPV, 0xFF00, Local0), 0x08, Local0)
                    ShiftLeft (And (\_SB.PCI0.LPCB.EC.BPV, 0xFF, Local1), 0x08, Local1)
                    Add (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Local0)
                    }

                    Store (Local0, Index (BUFF, 0x03))
                    Release (MUTX)
                }

                Store (0xB4, P80H)
                Return (BUFF)
            }

            Method (_BTP, 1, NotSerialized)
            {
                If (\ECON)
                {
                    Store ("_SB.CMB0._BTP", Debug)
                }
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x18, 
                0x05
            })
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Name (_PRW, Package (0x02)
            {
                0x18, 
                0x04
            })
        }

        Device (LID0)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_LID, 0, NotSerialized)
            {
                Return (LIDS)
            }
        }

        Device (PCI0)
        {
            Method (_INI, 0, NotSerialized)
            {
                If (CondRefOf (\_OSI, Local0))
                {
                    Store (0x07D1, OSYS)
                }
                Else
                {
                    If (LEqual (SizeOf (_OS), 0x14))
                    {
                        Store (0x07D0, OSYS)
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
                }

                If (LNot (LGreater (OSYS, 0x07CF)))
                {
                    Store (0x01, ECON)
                    Store (0x01, \_SB.PCI0.LPCB.EC.ACPI)
                }
            }

            Method (_S1D, 0, NotSerialized)
            {
                If (LEqual (OSYS, 0x07CF))
                {
                    Return (0x02)
                }

                Return (0x01)
            }

            Method (_S3D, 0, NotSerialized)
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)
            {
                Return (0x02)
            }

            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            OperationRegion (HBUS, PCI_Config, 0x40, 0xC0)
            Field (HBUS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x20), 
                DRB0,   8, 
                DRB1,   8, 
                DRB2,   8, 
                DRB3,   8, 
                Offset (0x50), 
                    ,   4, 
                PM0H,   2, 
                Offset (0x51), 
                PM1L,   2, 
                    ,   2, 
                PM1H,   2, 
                Offset (0x52), 
                PM2L,   2, 
                    ,   2, 
                PM2H,   2, 
                Offset (0x53), 
                PM3L,   2, 
                    ,   2, 
                PM3H,   2, 
                Offset (0x54), 
                PM4L,   2, 
                    ,   2, 
                PM4H,   2, 
                Offset (0x55), 
                PM5L,   2, 
                    ,   2, 
                PM5H,   2, 
                Offset (0x56), 
                PM6L,   2, 
                    ,   2, 
                PM6H,   2, 
                Offset (0x57), 
                FDHC,   8
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
                Multiply (0x02000000, DRB3, M1MN)
                Add (Subtract (M1MX, M1MN), 0x01, M1LN)
                ShiftRight (And (\_SB.PCI0.LPCB.HPTE, 0x00038000), 0x0F, Local0)
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
                If (GPIC)
                {
                    Return (Package (0x07)
                    {
                        Package (0x04)
                        {
                            0x0007FFFF, 
                            0x00, 
                            0x00, 
                            0x10
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
                        }
                    })
                }
                Else
                {
                    Return (Package (0x07)
                    {
                        Package (0x04)
                        {
                            0x0007FFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x01, 
                            \_SB.PCI0.LPCB.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x02, 
                            \_SB.PCI0.LPCB.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x03, 
                            \_SB.PCI0.LPCB.LNKH, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x01, 
                            \_SB.PCI0.LPCB.LNKB, 
                            0x00
                        }
                    })
                }
            }

            Device (AGPB)
            {
                Name (_ADR, 0x00010000)
                Method (_PRT, 0, NotSerialized)
                {
                    Return (Package (0x02)
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
                            \_SB.PCI0.LPCB.LNKB, 
                            0x00
                        }
                    })
                }

                Device (VGA)
                {
                    Name (_ADR, 0x00)
                    Name (_S3D, 0x03)
                    OperationRegion (VGAB, SystemMemory, 0x1FF6CFAC, 0x00010010)
                    Field (VGAB, AnyAcc, Lock, Preserve)
                    {
                        RSIZ,   32, 
                        VFUN,   16, 
                        CSTE,   16, 
                        NSTE,   16, 
                        SSTE,   16, 
                        CADL,   16, 
                        PADL,   16, 
                        RBUF,   524288
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (And (Arg0, 0x03), DSEN)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x03)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x00010200
                        })
                        Name (PSIZ, 0x00)
                        Name (PPTR, 0x00)
                        Store (0x82, \_SB.BCMD)
                        Store (Zero, \_SB.SMIC)
                        Store (CADL, Local0)
                        Store (CADL, Local1)
                        Store (CADL, PADL)
                        While (Local1)
                        {
                            If (And (Local1, 0x01))
                            {
                                Increment (PSIZ)
                            }

                            ShiftRight (Local1, 0x01, Local1)
                        }

                        If (LOr (LEqual (PSIZ, 0x00), LGreater (PSIZ, 0x03)))
                        {
                            Store (0x00, ENUM)
                            Return (Package (0x01)
                            {
                                0x00010100
                            })
                        }
                        Else
                        {
                            Store (0x01, ENUM)
                            If (LEqual (PSIZ, 0x02))
                            {
                                Name (VID2, Package (0x02)
                                {
                                    0x00010100, 
                                    0x00010110
                                })
                                If (And (Local0, 0x01))
                                {
                                    Store (0x00010100, Index (VID2, PPTR))
                                    Increment (PPTR)
                                }

                                If (And (Local0, 0x02))
                                {
                                    Store (0x00010110, Index (VID2, PPTR))
                                    Increment (PPTR)
                                }

                                If (And (Local0, 0x04))
                                {
                                    Store (0x00010200, Index (VID2, PPTR))
                                    Increment (PPTR)
                                }

                                Return (VID2)
                            }

                            If (LEqual (PSIZ, 0x03))
                            {
                                Name (VID3, Package (0x03)
                                {
                                    0x00010100, 
                                    0x00010110, 
                                    0x00010200
                                })
                                If (And (Local0, 0x01))
                                {
                                    Store (0x00010100, Index (VID3, PPTR))
                                    Increment (PPTR)
                                }

                                If (And (Local0, 0x02))
                                {
                                    Store (0x00010110, Index (VID3, PPTR))
                                    Increment (PPTR)
                                }

                                If (And (Local0, 0x04))
                                {
                                    Store (0x00010200, Index (VID3, PPTR))
                                    Increment (PPTR)
                                }

                                Return (VID3)
                            }

                            Name (VID1, Package (0x01)
                            {
                                0x00010100
                            })
                            If (And (Local0, 0x01))
                            {
                                Store (0x00010100, Index (VID1, 0x00))
                            }

                            If (And (Local0, 0x02))
                            {
                                Store (0x00010110, Index (VID1, 0x00))
                            }

                            If (And (Local0, 0x04))
                            {
                                Store (0x00010200, Index (VID1, 0x00))
                            }

                            Return (VID1)
                        }
                    }

                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store ("VGA_PS0", Debug)
                        Store (0x00, _PSC)
                    }

                    Method (_PS2, 0, NotSerialized)
                    {
                        Store ("VGA_PS2", Debug)
                        Store (0x02, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store ("VGA_PS3", Debug)
                        Store (0x03, _PSC)
                    }

                    Device (CRT0)
                    {
                        Name (_ADR, 0x0100)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (0x81, \_SB.BCMD)
                            Store (Zero, \_SB.SMIC)
                            Store (CSTE, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x0202))
                                {
                                    Return (0x1F)
                                }
                            }

                            Return (0x1D)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (\NEDV, Local0)
                            If (Local0)
                            {
                                If (LOr (And (Local0, 0x02), And (Local0, 0x04)))
                                {
                                    Return (0x01)
                                }
                            }

                            Return (0x00)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                        }
                    }

                    Device (LCD0)
                    {
                        Name (_ADR, 0x0110)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (0x81, \_SB.BCMD)
                            Store (Zero, \_SB.SMIC)
                            Store (CSTE, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x0101))
                                {
                                    Return (0x1F)
                                }
                            }

                            Return (0x1D)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (\NEDV, Local0)
                            If (Local0)
                            {
                                If (LOr (And (Local0, 0x01), And (Local0, 0x04)))
                                {
                                    Return (0x01)
                                }
                            }

                            Return (0x00)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                        }
                    }

                    Device (TV0)
                    {
                        Name (_ADR, 0x0200)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (0x82, \_SB.BCMD)
                            Store (Zero, \_SB.SMIC)
                            Store (CSTE, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x04))
                                {
                                    Return (0x1F)
                                }
                            }

                            Return (0x1D)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (\NEDV, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x08))
                                {
                                    Return (0x01)
                                }
                            }

                            Return (0x00)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                        }
                    }
                }
            }

            Device (PCIB)
            {
                Device (CRD0)
                {
                    Name (_ADR, 0x00)
                    OperationRegion (CBD0, PCI_Config, 0x00, 0xC0)
                    Field (CBD0, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x3C), 
                        CD3C,   8, 
                        Offset (0x44), 
                        CD44,   32, 
                        Offset (0x80), 
                        OPME,   1, 
                        Offset (0x8F), 
                        MF06,   4, 
                        Offset (0xA4), 
                        PWST,   2, 
                        Offset (0xA5), 
                        PMEE,   1, 
                            ,   6, 
                        PMST,   1
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Or (CD3C, 0xFF, CD3C)
                        Store (0x00, CD44)
                        Or (OPME, 0x01, OPME)
                        Or (MF06, 0x01, MF06)
                    }
                }

                Device (CRD1)
                {
                    Name (_ADR, 0x01)
                    OperationRegion (CBD1, PCI_Config, 0x00, 0xB4)
                    Field (CBD1, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x3C), 
                        CD3C,   8, 
                        Offset (0x44), 
                        CD44,   32, 
                        Offset (0x80), 
                        OPME,   1, 
                        Offset (0x8F), 
                        MF06,   4, 
                        Offset (0xA4), 
                        PWST,   2, 
                        Offset (0xA5), 
                        PMEE,   1, 
                            ,   6, 
                        PMST,   1
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Or (CD3C, 0xFF, CD3C)
                        Store (0x00, CD44)
                        Or (OPME, 0x01, OPME)
                        Or (MF06, 0x01, MF06)
                    }
                }

                Name (_ADR, 0x001E0000)
                Device (LANC)
                {
                    Name (_ADR, 0x00060000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x05
                    })
                    Method (_PSW, 1, NotSerialized)
                    {
                        If (\ECON)
                        {
                            Acquire (\MUTX, 0xFFFF)
                            Store (Arg0, \_SB.PCI0.LPCB.EC.LNW4)
                            Store (Arg0, \_SB.PCI0.LPCB.EC.LNW3)
                            Release (\MUTX)
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)
                {
                    Return (Package (0x07)
                    {
                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0xFFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0xFFFF, 
                            0x01, 
                            \_SB.PCI0.LPCB.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0xFFFF, 
                            0x02, 
                            \_SB.PCI0.LPCB.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0xFFFF, 
                            0x03, 
                            \_SB.PCI0.LPCB.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            0x01, 
                            \_SB.PCI0.LPCB.LNKD, 
                            0x00
                        }
                    })
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)
                OperationRegion (LPC0, PCI_Config, 0x40, 0xC0)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x20), 
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    Offset (0x28), 
                    PIRE,   8, 
                    PIRF,   8, 
                    PIRG,   8, 
                    PIRH,   8, 
                    Offset (0x60), 
                    PMC1,   8, 
                    Offset (0x90), 
                    HPTE,   32, 
                    Offset (0xA0), 
                    LDE0,   8, 
                    LDE1,   8
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
                        IRQ (Level, ActiveLow, Shared) {1,3,5,6,7,10,11,12,14}
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
                        IRQ (Level, ActiveLow, Shared) {1,3,5,6,7,10,11,12,14}
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
                        IRQ (Level, ActiveLow, Shared) {1,3,5,6,7,10,11,12,14}
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
                        IRQ (Level, ActiveLow, Shared) {1,3,5,6,7,10,11,12,14}
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
                        IRQ (Level, ActiveLow, Shared) {1,3,5,6,7,10,11,12,14}
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
                        IRQ (Level, ActiveLow, Shared) {1,3,5,6,7,10,11,12,14}
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
                        IRQ (Level, ActiveLow, Shared) {1,3,5,6,7,10,11,12,14}
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
                        IRQ (Level, ActiveLow, Shared) {1,3,5,6,7,10,11,12,14}
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
                        If (And (HPTE, 0x00020000))
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
                        If (And (HPTE, 0x00020000))
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
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x004E, 0x004E, 0x01, 0x02)
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                        IO (Decode16, 0x0063, 0x0063, 0x01, 0x01)
                        IO (Decode16, 0x0065, 0x0065, 0x01, 0x01)
                        IO (Decode16, 0x0067, 0x0067, 0x01, 0x01)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x00B2, 0x00B2, 0x01, 0x02)
                        IO (Decode16, 0x0600, 0x0600, 0x01, 0x10)
                        IO (Decode16, 0x0800, 0x0800, 0x01, 0x08)
                        IO (Decode16, 0x1000, 0x1000, 0x01, 0x80)
                        IO (Decode16, 0x1180, 0x1180, 0x01, 0x40)
                        Memory32Fixed (ReadWrite, 0xFEBFE000, 0x00001000)
                        Memory32Fixed (ReadWrite, 0xFEBFF000, 0x00001000)
                        Memory32Fixed (ReadWrite, 0xFEC00000, 0x00001000)
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
                        ShiftRight (And (HPTE, 0x00038000), 0x0F, Local0)
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
                        ShiftRight (And (HPTE, 0x00038000), 0x0F, Local0)
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

                Device (EC)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_UID, 0x01)
                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BFFR, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0062, 0x0062, 0x00, 0x01)
                            IO (Decode16, 0x0066, 0x0066, 0x00, 0x01)
                        })
                        Return (BFFR)
                    }

                    OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x01), 
                        VER,    24, 
                        Offset (0x08), 
                        AVER,   48, 
                        Offset (0x60), 
                        SPT,    4, 
                        ACPI,   1, 
                        Offset (0x62), 
                        MSWK,   1, 
                        KBWK,   1, 
                        LNW4,   1, 
                        LNW3,   1, 
                            ,   2, 
                        LIW3,   1, 
                        Offset (0x64), 
                        TPDP,   1, 
                        TPDU,   1, 
                        IKDP,   1, 
                        IKDU,   1, 
                        Offset (0x65), 
                            ,   1, 
                        UPS4,   1, 
                        UPS3,   1, 
                        Offset (0x66), 
                        Offset (0x68), 
                        DLB1,   1, 
                        DLB2,   1, 
                        Offset (0x69), 
                        Offset (0x6C), 
                        WRI,    1, 
                        WLAN,   1, 
                        WLID,   1, 
                        WIPS,   1, 
                        WLBT,   1, 
                        Offset (0x6D), 
                        Offset (0x6E), 
                        LID,    1, 
                        Offset (0x6F), 
                        Offset (0x7F), 
                        MBSE,   8, 
                        ACP,    1, 
                        BAP1,   1, 
                        BAP2,   1, 
                        BAP3,   1, 
                        BLB1,   1, 
                        BLB2,   1, 
                        Offset (0x81), 
                        BT,     2, 
                        BPU,    1, 
                        Offset (0x82), 
                        BST,    3, 
                        Offset (0x83), 
                        BTY,    8, 
                        BDC,    16, 
                        BLFC,   16, 
                        BDV,    16, 
                        BDWC,   16, 
                        BDLC,   16, 
                        BCG1,   16, 
                        BCG2,   16, 
                        BSN,    16, 
                        BPR,    16, 
                        BRC,    16, 
                        BPV,    16, 
                        BTP,    16, 
                        CBT,    16, 
                        Offset (0xC0), 
                        TME0,   1, 
                        FANC,   1, 
                        Offset (0xC1), 
                        FSR,    8, 
                        T1LO,   8, 
                        T2LO,   8, 
                        T1HI,   8, 
                        T2HI,   8, 
                        SHT1,   8, 
                        SHT2,   8, 
                        TMP1,   8, 
                        TMP2,   8, 
                        TMOD,   8, 
                        FCD,    8, 
                        TSTA,   4, 
                        Offset (0xCD), 
                        FMOD,   8, 
                        Offset (0xE0), 
                        LBRI,   4, 
                        Offset (0xE1), 
                        LBRR,   8, 
                        PFD,    1, 
                        LMD,    1, 
                        Offset (0xE3), 
                        LFRV,   8, 
                        Offset (0xF0), 
                        SMDM,   1, 
                        Offset (0xF1), 
                        DLED,   4, 
                        Offset (0xF2), 
                        SEAB,   7, 
                        Offset (0xF3)
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LAnd (LEqual (Arg0, 0x03), LEqual (Arg1, 0x01)))
                        {
                            Store (0x01, ECON)
                            Store (0x01, ACPI)
                            If (LNot (LEqual (ACP, PWRS)))
                            {
                                Store (ACP, PWRS)
                                Store (0x2B, SMIF)
                                Store (0x00, TRP0)
                                Notify (\_SB.CMB0, 0x80)
                            }
                        }
                    }

                    Name (_GPE, 0x1C)
                    Method (_Q01, 0, NotSerialized)
                    {
                        Store (0x81, P80H)
                        Acquire (MUTX, 0xFFFF)
                        Store (ACP, PWRS)
                        Release (MUTX)
                        Notify (\_SB.AC, 0x80)
                        Notify (\_SB.CMB0, 0x80)
                    }

                    Method (_Q02, 0, NotSerialized)
                    {
                        Acquire (MUTX, 0xFFFF)
                        Store (One, \_SB.PCI0.LPCB.EC.DLB1)
                        Release (MUTX)
                        Notify (\_SB.CMB0, 0x80)
                        Store (0x82, P80H)
                    }

                    Method (_Q03, 0, NotSerialized)
                    {
                        Acquire (MUTX, 0xFFFF)
                        Store (One, \_SB.PCI0.LPCB.EC.DLB1)
                        Store (One, \_SB.PCI0.LPCB.EC.DLB2)
                        Release (MUTX)
                        Notify (\_SB.CMB0, 0x80)
                        Store (0x83, P80H)
                    }

                    Method (_Q04, 0, NotSerialized)
                    {
                        Store (0x84, P80H)
                        Notify (\_SB.CMB0, 0x81)
                    }

                    Method (_Q05, 0, NotSerialized)
                    {
                        Store (0x85, P80H)
                        Notify (\_SB.CMB0, 0x80)
                    }

                    Method (_Q08, 0, NotSerialized)
                    {
                        Store (0x88, P80H)
                        If (LEqual (\CSST, 0x00))
                        {
                            Notify (\_SB.PWRB, 0x80)
                        }
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        Store ("===== Thermal sensor tripped =====", Debug)
                        Store (0xA0, P80H)
                        Acquire (MUTX, 0xFFFF)
                        Store (TMP1, Local0)
                        Store (T1HI, Local1)
                        Store (T1LO, Local2)
                        Store (TMP2, Local0)
                        Store (T2HI, Local1)
                        Store (T2LO, Local2)
                        SBTP (Local0, Local1, Local2)
                        SNTP (Local0, Local1, Local2)
                        Store (One, \_TZ.TSCI)
                        Release (MUTX)
                        Notify (\_TZ.THRM, 0x80)
                        Notify (\_TZ.THM2, 0x80)
                    }

                    Method (_Q34, 0, NotSerialized)
                    {
                        Store (0x34, P80H)
                        If (LEqual (\CSST, 0x00))
                        {
                            Notify (\_SB.SLPB, 0x80)
                        }
                    }

                    Method (_Q35, 0, NotSerialized)
                    {
                        Store (0x35, P80H)
                        If (LEqual (\CSST, 0x00))
                        {
                            Acquire (MUTX, 0xFFFF)
                            Store (0x14, SMIF)
                            Store (0x00, TRP0)
                            Release (MUTX)
                        }
                    }

                    Method (_Q37, 0, NotSerialized)
                    {
                        If (LEqual (\CSST, 0x00))
                        {
                            If (\ECON)
                            {
                                Acquire (MUTX, 0xFFFF)
                                Store (0x83, \_SB.BCMD)
                                Store (Zero, \_SB.SMIC)
                                Release (MUTX)
                            }
                        }

                        If (LEqual (0x00, DSEN))
                        {
                            If (LEqual (\CSST, 0x00))
                            {
                                Acquire (MUTX, 0xFFFF)
                                Store (0x84, \_SB.BCMD)
                                Store (Zero, \_SB.SMIC)
                                Store (0x5E, \CMID)
                                Store (\CMDA, \NEDV)
                                Release (MUTX)
                            }

                            Store (0x5F, \CMID)
                            Store (\CMDA, \CP3D)
                            If (\CP3D) {}
                            Else
                            {
                                Notify (\_SB.PCI0.AGPB.VGA, 0x80)
                            }

                            Store (\CP3D, P80H)
                        }

                        If (LEqual (0x01, DSEN))
                        {
                            If (LEqual (\CSST, 0x00))
                            {
                                If (\ECON)
                                {
                                    Acquire (MUTX, 0xFFFF)
                                    Store (0x83, \_SB.BCMD)
                                    Store (Zero, \_SB.SMIC)
                                    Release (MUTX)
                                }
                            }

                            Notify (\_SB.PCI0.AGPB, 0x81)
                        }

                        If (LNot (LLess (DSEN, 0x02))) {}
                    }

                    Method (_Q40, 0, NotSerialized)
                    {
                        Store (0x40, P80H)
                        If (LEqual (\CSST, 0x00))
                        {
                            Acquire (MUTX, 0xFFFF)
                            Store (0x15, SMIF)
                            Store (0x00, TRP0)
                            Release (MUTX)
                        }
                    }

                    Method (_Q41, 0, NotSerialized)
                    {
                        Store (0x41, P80H)
                        If (LEqual (\CSST, 0x00))
                        {
                            Store (0x29, SMIF)
                            Store (0x00, TRP0)
                            Notify (\_SB.LID0, 0x80)
                        }
                    }

                    Method (SNTP, 3, NotSerialized)
                    {
                        Store (Zero, TME0)
                        Store (TSTA, Local0)
                        If (And (Local0, 0x01))
                        {
                            Store ("---------Above ACTIVE_TP---", Debug)
                            Subtract (Arg1, \_TZ.O_TP, Local1)
                            Store (Local1, T1LO)
                            Add (Arg1, \_TZ.O_TP, Local1)
                            Store (Local1, T1HI)
                        }

                        If (And (Local0, 0x02))
                        {
                            Store ("---------Below SENSOR1_ACTIVE_TP---", Debug)
                            Subtract (Arg2, \_TZ.O_TP, Local1)
                            If (LLess (Local1, \_TZ.DC2T))
                            {
                                Store (\_TZ.S1LT, Local1)
                            }

                            Store (Local1, T1LO)
                            Add (Arg2, \_TZ.O_TP, Local2)
                            If (LLess (Local2, \_TZ.DC2T))
                            {
                                Store (\_TZ.DC2T, Local2)
                            }

                            Store (Local2, T1HI)
                        }

                        Store (One, TME0)
                    }

                    Method (SBTP, 3, NotSerialized)
                    {
                        Store (Zero, TME0)
                        Store (TSTA, Local0)
                        If (And (Local0, 0x01))
                        {
                            Store ("---------Above ACTIVE_TP---", Debug)
                            Subtract (Arg1, \_TZ.O_TP, Local1)
                            Store (Local1, T2LO)
                            Add (Arg1, \_TZ.O_TP, Local1)
                            Store (Local1, T2HI)
                        }

                        If (And (Local0, 0x02))
                        {
                            Store ("---------Below SENSOR1_ACTIVE_TP---", Debug)
                            Subtract (Arg2, \_TZ.O_TP, Local1)
                            If (LLess (Local1, \_TZ.BC2T))
                            {
                                Store (\_TZ.S2LT, Local1)
                            }

                            Store (Local1, T2LO)
                            Add (Arg2, \_TZ.O_TP, Local2)
                            If (LLess (Local2, \_TZ.BC2T))
                            {
                                Store (\_TZ.BC2T, Local2)
                            }

                            Store (Local2, T2HI)
                        }

                        Store (One, TME0)
                    }
                }

                Device (SIO)
                {
                    Name (_HID, EisaId ("PNP0A05"))
                    Mutex (MX00, 0x00)
                    OperationRegion (SMC1, SystemIO, 0x4E, 0x02)
                    Field (SMC1, ByteAcc, NoLock, Preserve)
                    {
                        I227,   8, 
                        D227,   8
                    }

                    IndexField (I227, D227, AnyAcc, Lock, WriteAsOnes)
                    {
                        AccessAs (ByteAcc, 0x00), 
                            ,   3, 
                        FPWR,   1, 
                        Offset (0x01), 
                            ,   2, 
                        PPWR,   1, 
                        PMOD,   1, 
                        Offset (0x02), 
                            ,   3, 
                        APWR,   1, 
                            ,   3, 
                        BPWR,   1, 
                        FDCM,   8, 
                        PEMD,   2, 
                        PFDC,   2, 
                            ,   2, 
                        EPPT,   1, 
                        Offset (0x05), 
                        FDCT,   1, 
                        FDCC,   1, 
                        FDCD,   1, 
                        DENS,   2, 
                        SWPD,   1, 
                        Offset (0x07), 
                        FBT,    2, 
                            ,   2, 
                        PPAP,   1, 
                        BAPD,   1, 
                        AAPD,   1, 
                        FAPD,   1, 
                        Offset (0x0A), 
                            ,   6, 
                        MMOD,   2, 
                        FDRT,   2, 
                        Offset (0x0C), 
                        BRXI,   1, 
                        BTXO,   1, 
                        BDUX,   1, 
                        BMOD,   3, 
                        ASPD,   1, 
                        BSPD,   1, 
                        Offset (0x12), 
                        IADR,   8, 
                        Offset (0x17), 
                        DSKC,   2, 
                        Offset (0x20), 
                        FADR,   8, 
                        Offset (0x22), 
                        ECPD,   3, 
                        ECPI,   3, 
                        Offset (0x23), 
                        PADR,   8, 
                        AADR,   8, 
                        BADR,   8, 
                        PDMA,   4, 
                        FDMA,   4, 
                        PIRQ,   4, 
                        FIRQ,   4, 
                        BIRQ,   4, 
                        AIRQ,   4, 
                        Offset (0x2B), 
                        FBAR,   8, 
                        IDMA,   8
                    }

                    Method (ENFG, 0, NotSerialized)
                    {
                        Store (0x55, I227)
                    }

                    Method (EXFG, 0, NotSerialized)
                    {
                        Store (0xAA, I227)
                    }

                    Method (RDRG, 1, NotSerialized)
                    {
                        ENFG ()
                        Store (Arg0, I227)
                        Store (D227, Local0)
                        EXFG ()
                        Return (Local0)
                    }

                    Method (WRRG, 2, NotSerialized)
                    {
                        ENFG ()
                        Store (Arg0, I227)
                        Store (Arg1, D227)
                        EXFG ()
                    }

                    Method (READ, 3, NotSerialized)
                    {
                        Acquire (MX00, 0xFFFF)
                        If (LEqual (Arg0, 0x00))
                        {
                            Store (RDRG (Arg1), Local1)
                        }

                        And (Local1, Arg2, Local1)
                        Release (MX00)
                        Return (Local1)
                    }

                    Method (WRIT, 3, NotSerialized)
                    {
                        Acquire (MX00, 0xFFFF)
                        If (LEqual (Arg0, 0x00))
                        {
                            WRRG (Arg1, Arg2)
                        }

                        Release (MX00)
                    }

                    Device (LPP)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x01)
                        Name (LPTP, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (LPTP, 0x01))
                            {
                                Store (READ (0x00, 0x01, 0x04), Local0)
                                If (LEqual (Local0, 0x00))
                                {
                                    Return (0x00)
                                }
                            }

                            Store (READ (0x00, 0x01, 0x08), Local0)
                            If (LEqual (Local0, 0x00))
                            {
                                Return (0x00)
                            }

                            Store (READ (0x00, 0x23, 0xC0), Local0)
                            If (LEqual (Local0, 0x00))
                            {
                                Return (0x0D)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateByteField (Arg0, 0x09, IRQL)
                            WRIT (0x00, 0x23, 0x00)
                            FindSetRightBit (IRQL, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                                Store (READ (0x00, 0x27, 0xF0), Local1)
                                Or (Local0, Local1, Local0)
                                WRIT (0x00, 0x27, Local0)
                            }
                            Else
                            {
                                Store (READ (0x00, 0x27, 0xF0), Local0)
                                WRIT (0x00, 0x27, Local0)
                            }

                            Store (IOLO, Local0)
                            ShiftRight (Local0, 0x02, Local0)
                            Store (IOHI, Local1)
                            ShiftLeft (Local1, 0x06, Local1)
                            Or (Local0, Local1, Local0)
                            WRIT (0x00, 0x23, Local0)
                            Store (READ (0x00, 0x01, 0xFF), Local0)
                            Or (Local0, 0x0C, Local0)
                            WRIT (0x00, 0x01, Local0)
                            Store (0x01, LPTP)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x01, 0x08)
                                IRQNoFlags () {}
                            })
                            CreateByteField (BUF0, 0x02, IOLO)
                            CreateByteField (BUF0, 0x03, IOHI)
                            CreateByteField (BUF0, 0x04, IORL)
                            CreateByteField (BUF0, 0x05, IORH)
                            CreateByteField (BUF0, 0x07, LNA1)
                            CreateByteField (BUF0, 0x09, IRQL)
                            Store (READ (0x00, 0x23, 0xFF), Local0)
                            Store (Local0, Local1)
                            And (Local1, 0xC0, Local1)
                            ShiftRight (Local1, 0x06, Local1)
                            And (Local0, 0x3F, Local0)
                            ShiftLeft (Local0, 0x02, Local0)
                            Store (Local0, IOLO)
                            Store (Local1, IOHI)
                            Store (IOLO, IORL)
                            Store (IOHI, IORH)
                            If (Local0)
                            {
                                If (LEqual (Local0, 0xBC))
                                {
                                    Store (0x04, LNA1)
                                }
                                Else
                                {
                                    Store (0x08, LNA1)
                                }
                            }
                            Else
                            {
                                Store (0x00, LNA1)
                            }

                            If (Local0)
                            {
                                Store (READ (0x00, 0x27, 0xFF), Local0)
                                And (Local0, 0x0F, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRQL)
                            }

                            Return (BUF0)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                            }
                            StartDependentFn (0x01, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IRQNoFlags () {5,7}
                            }
                            EndDependentFn ()
                        })
                        Method (_DIS, 0, NotSerialized)
                        {
                            WRIT (0x00, 0x23, 0x00)
                            Store (READ (0x00, 0x27, 0xFF), Local0)
                            And (Local0, 0xF0, Local0)
                            WRIT (0x00, 0x27, Local0)
                            Store (READ (0x00, 0x01, 0xFF), Local0)
                            And (Local0, 0xFB, Local0)
                            WRIT (0x00, 0x01, Local0)
                            Store (0x00, LPTP)
                        }
                    }

                    Device (LPBI)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x02)
                        Name (LPBI, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (LPBI, 0x01))
                            {
                                Store (READ (0x00, 0x01, 0x04), Local0)
                                If (LEqual (Local0, 0x00))
                                {
                                    Return (0x00)
                                }
                            }

                            Store (READ (0x00, 0x01, 0x08), Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Return (0x00)
                            }

                            Store (READ (0x00, 0x04, 0x03), Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Return (0x00)
                            }

                            Store (READ (0x00, 0x23, 0xC0), Local0)
                            If (LEqual (Local0, 0x00))
                            {
                                Return (0x0D)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateByteField (Arg0, 0x09, IRQL)
                            WRIT (0x00, 0x23, 0x00)
                            FindSetRightBit (IRQL, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                                Store (READ (0x00, 0x27, 0xF0), Local1)
                                Or (Local0, Local1, Local0)
                                WRIT (0x00, 0x27, Local0)
                            }
                            Else
                            {
                                Store (READ (0x00, 0x27, 0xF0), Local0)
                                WRIT (0x00, 0x27, Local0)
                            }

                            Store (IOLO, Local0)
                            ShiftRight (Local0, 0x02, Local0)
                            Store (IOHI, Local1)
                            ShiftLeft (Local1, 0x06, Local1)
                            Or (Local0, Local1, Local0)
                            WRIT (0x00, 0x23, Local0)
                            Store (READ (0x00, 0x04, 0xFC), Local0)
                            WRIT (0x00, 0x04, Local0)
                            Store (READ (0x00, 0x01, 0xFF), Local0)
                            Or (Local0, 0x04, Local0)
                            And (Local0, 0xF7, Local0)
                            WRIT (0x00, 0x01, Local0)
                            Store (0x01, LPBI)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x01, 0x08)
                                IRQNoFlags () {}
                            })
                            CreateByteField (BUF0, 0x02, IOLO)
                            CreateByteField (BUF0, 0x03, IOHI)
                            CreateByteField (BUF0, 0x04, IORL)
                            CreateByteField (BUF0, 0x05, IORH)
                            CreateByteField (BUF0, 0x07, LNA1)
                            CreateByteField (BUF0, 0x09, IRQL)
                            Store (READ (0x00, 0x23, 0xFF), Local0)
                            Store (Local0, Local1)
                            And (Local1, 0xC0, Local1)
                            ShiftRight (Local1, 0x06, Local1)
                            And (Local0, 0x3F, Local0)
                            ShiftLeft (Local0, 0x02, Local0)
                            Store (Local0, IOLO)
                            Store (Local1, IOHI)
                            Store (IOLO, IORL)
                            Store (IOHI, IORH)
                            If (Local0)
                            {
                                If (LEqual (Local0, 0xBC))
                                {
                                    Store (0x04, LNA1)
                                }
                                Else
                                {
                                    Store (0x08, LNA1)
                                }
                            }
                            Else
                            {
                                Store (0x00, LNA1)
                            }

                            If (Local0)
                            {
                                Store (READ (0x00, 0x27, 0xFF), Local0)
                                And (Local0, 0x0F, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRQL)
                            }

                            Return (BUF0)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                            }
                            StartDependentFn (0x01, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IRQNoFlags () {5,7}
                            }
                            EndDependentFn ()
                        })
                        Method (_DIS, 0, NotSerialized)
                        {
                            WRIT (0x00, 0x23, 0x00)
                            Store (READ (0x00, 0x27, 0xFF), Local0)
                            And (Local0, 0xF0, Local0)
                            WRIT (0x00, 0x27, Local0)
                            Store (READ (0x00, 0x01, 0xFF), Local0)
                            And (Local0, 0xFB, Local0)
                            WRIT (0x00, 0x01, Local0)
                            Store (0x00, LPBI)
                        }
                    }

                    Device (PECP)
                    {
                        Name (_HID, EisaId ("PNP0401"))
                        Name (ECPP, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (ECPP, 0x01))
                            {
                                Store (READ (0x00, 0x01, 0x04), Local0)
                                If (LEqual (Local0, 0x00))
                                {
                                    Return (0x00)
                                }
                            }

                            Store (READ (0x00, 0x01, 0x08), Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Return (0x00)
                            }

                            Store (READ (0x00, 0x04, 0x03), Local0)
                            If (LNot (LEqual (Local0, 0x02)))
                            {
                                Return (0x00)
                            }

                            Store (READ (0x00, 0x23, 0xC0), Local0)
                            If (LEqual (Local0, 0x00))
                            {
                                Return (0x0D)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateByteField (Arg0, 0x11, IRQL)
                            CreateByteField (Arg0, 0x14, DMAC)
                            WRIT (0x00, 0x23, 0x00)
                            FindSetRightBit (IRQL, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                                Store (READ (0x00, 0x27, 0xF0), Local1)
                                Or (Local0, Local1, Local0)
                                WRIT (0x00, 0x27, Local0)
                            }
                            Else
                            {
                                Store (READ (0x00, 0x27, 0xF0), Local0)
                                WRIT (0x00, 0x27, Local0)
                            }

                            Store (IOLO, Local0)
                            ShiftRight (Local0, 0x02, Local0)
                            Store (IOHI, Local1)
                            ShiftLeft (Local1, 0x06, Local1)
                            Or (Local0, Local1, Local0)
                            WRIT (0x00, 0x23, Local0)
                            FindSetRightBit (DMAC, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                                Store (READ (0x00, 0x26, 0xF0), Local1)
                                Or (Local0, Local1, Local0)
                                WRIT (0x00, 0x26, Local0)
                            }
                            Else
                            {
                                Store (READ (0x00, 0x26, 0xF0), Local0)
                                WRIT (0x00, 0x26, Local0)
                            }

                            Store (READ (0x00, 0x04, 0xFC), Local0)
                            Or (Local0, 0x02, Local0)
                            WRIT (0x00, 0x04, Local0)
                            Store (READ (0x00, 0x01, 0xFF), Local0)
                            Or (Local0, 0x04, Local0)
                            And (Local0, 0xF7, Local0)
                            WRIT (0x00, 0x01, Local0)
                            Store (0x01, ECPP)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x01, 0x08)
                                IO (Decode16, 0x0000, 0x0000, 0x01, 0x08)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfer8) {}
                            })
                            CreateByteField (BUF0, 0x02, IOLO)
                            CreateByteField (BUF0, 0x03, IOHI)
                            CreateByteField (BUF0, 0x04, IORL)
                            CreateByteField (BUF0, 0x05, IORH)
                            CreateByteField (BUF0, 0x07, LNA1)
                            CreateByteField (BUF0, 0x0A, DALO)
                            CreateByteField (BUF0, 0x0B, DAHI)
                            CreateByteField (BUF0, 0x0C, DRLO)
                            CreateByteField (BUF0, 0x0D, DRHI)
                            CreateByteField (BUF0, 0x0F, LNA2)
                            CreateByteField (BUF0, 0x11, IRQL)
                            CreateByteField (BUF0, 0x14, DMAC)
                            Store (READ (0x00, 0x23, 0xFF), Local0)
                            Store (Local0, Local1)
                            And (Local1, 0xC0, Local1)
                            ShiftRight (Local1, 0x06, Local1)
                            And (Local0, 0x3F, Local0)
                            ShiftLeft (Local0, 0x02, Local0)
                            Store (Local0, IOLO)
                            Store (Local1, IOHI)
                            Store (IOLO, IORL)
                            Store (IOHI, IORH)
                            Add (Local1, 0x04, Local1)
                            Store (IOLO, DALO)
                            Store (Local1, DAHI)
                            Store (DALO, DRLO)
                            Store (DAHI, DRHI)
                            If (LEqual (Local0, 0x00))
                            {
                                Store (0x00, LNA1)
                                Store (0x00, LNA2)
                            }

                            If (Local0)
                            {
                                Store (READ (0x00, 0x27, 0xFF), Local0)
                                And (Local0, 0x0F, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRQL)
                            }

                            If (Local0)
                            {
                                Store (READ (0x00, 0x26, 0xFF), Local0)
                                And (Local0, 0x0F, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, DMAC)
                            }

                            Return (BUF0)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFn (0x01, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x08)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            EndDependentFn ()
                        })
                        Method (_DIS, 0, NotSerialized)
                        {
                            WRIT (0x00, 0x23, 0x00)
                            Store (READ (0x00, 0x27, 0xFF), Local0)
                            And (Local0, 0xF0, Local0)
                            WRIT (0x00, 0x27, Local0)
                            Store (READ (0x00, 0x01, 0xFF), Local0)
                            And (Local0, 0xFB, Local0)
                            WRIT (0x00, 0x01, Local0)
                            Store (0x00, ECPP)
                        }
                    }

                    Device (LPPP)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x03)
                        Name (EPPP, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (EPPP, 0x01))
                            {
                                Store (READ (0x00, 0x01, 0x04), Local0)
                                If (LEqual (Local0, 0x00))
                                {
                                    Return (0x00)
                                }
                            }

                            Store (READ (0x00, 0x01, 0x08), Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Return (0x00)
                            }

                            Store (READ (0x00, 0x04, 0x03), Local0)
                            If (LNot (LEqual (Local0, 0x01)))
                            {
                                Return (0x00)
                            }

                            Store (READ (0x00, 0x23, 0xC0), Local0)
                            If (LEqual (Local0, 0x00))
                            {
                                Return (0x0D)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateByteField (Arg0, 0x09, IRQL)
                            WRIT (0x00, 0x23, 0x00)
                            FindSetRightBit (IRQL, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                                Store (READ (0x00, 0x27, 0xF0), Local1)
                                Or (Local0, Local1, Local0)
                                WRIT (0x00, 0x27, Local0)
                            }
                            Else
                            {
                                Store (READ (0x00, 0x27, 0xF0), Local0)
                                WRIT (0x00, 0x27, Local0)
                            }

                            Store (IOLO, Local0)
                            ShiftRight (Local0, 0x02, Local0)
                            Store (IOHI, Local1)
                            ShiftLeft (Local1, 0x06, Local1)
                            Or (Local0, Local1, Local0)
                            WRIT (0x00, 0x23, Local0)
                            Store (READ (0x00, 0x04, 0xFC), Local0)
                            Or (Local0, 0x01, Local0)
                            And (Local0, 0xBF, Local0)
                            WRIT (0x00, 0x04, Local0)
                            Store (READ (0x00, 0x01, 0xFF), Local0)
                            Or (Local0, 0x04, Local0)
                            And (Local0, 0xF7, Local0)
                            WRIT (0x00, 0x01, Local0)
                            Store (0x01, EPPP)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x01, 0x08)
                                IRQNoFlags () {}
                            })
                            CreateByteField (BUF0, 0x02, IOLO)
                            CreateByteField (BUF0, 0x03, IOHI)
                            CreateByteField (BUF0, 0x04, IORL)
                            CreateByteField (BUF0, 0x05, IORH)
                            CreateByteField (BUF0, 0x07, LNA1)
                            CreateByteField (BUF0, 0x09, IRQL)
                            Store (READ (0x00, 0x23, 0xFF), Local0)
                            Store (Local0, Local1)
                            And (Local1, 0xC0, Local1)
                            ShiftRight (Local1, 0x06, Local1)
                            And (Local0, 0x3F, Local0)
                            ShiftLeft (Local0, 0x02, Local0)
                            Store (Local0, IOLO)
                            Store (Local1, IOHI)
                            Store (IOLO, IORL)
                            Store (IOHI, IORH)
                            If (Local0)
                            {
                                If (LEqual (Local0, 0xBC))
                                {
                                    Store (0x04, LNA1)
                                }
                                Else
                                {
                                    Store (0x08, LNA1)
                                }
                            }
                            Else
                            {
                                Store (0x00, LNA1)
                            }

                            If (Local0)
                            {
                                Store (READ (0x00, 0x27, 0xFF), Local0)
                                And (Local0, 0x0F, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRQL)
                            }

                            Return (BUF0)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                            }
                            StartDependentFn (0x01, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {5,7}
                            }
                            StartDependentFn (0x02, 0x02)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IRQNoFlags () {5,7}
                            }
                            EndDependentFn ()
                        })
                        Method (_DIS, 0, NotSerialized)
                        {
                            WRIT (0x00, 0x23, 0x00)
                            Store (READ (0x00, 0x27, 0xFF), Local0)
                            And (Local0, 0xF0, Local0)
                            WRIT (0x00, 0x27, Local0)
                            Store (READ (0x00, 0x01, 0xFF), Local0)
                            And (Local0, 0xFB, Local0)
                            WRIT (0x00, 0x01, Local0)
                            Store (0x00, EPPP)
                        }
                    }

                    Device (FIR)
                    {
                        Name (_HID, EisaId ("SMCF010"))
                        Method (_STA, 0, NotSerialized)
                        {
                            ENFG ()
                            If (LEqual (BPWR, 0x01))
                            {
                                If (LNot (LEqual (IDMA, 0x0F)))
                                {
                                    If (LNot (LEqual (BADR, 0x00)))
                                    {
                                        EXFG ()
                                        Return (0x0F)
                                    }
                                    Else
                                    {
                                        EXFG ()
                                        Return (0x0D)
                                    }
                                }
                                Else
                                {
                                    EXFG ()
                                    Return (0x0D)
                                }
                            }
                            Else
                            {
                                EXFG ()
                                Return (0x0D)
                            }
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG ()
                            Store (0x00, BPWR)
                            Store (0x00, BADR)
                            Store (0x00, FBAR)
                            EXFG ()
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (RSRC, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x01, 0x08)
                                IO (Decode16, 0x0000, 0x0000, 0x01, 0x08)
                                IRQNoFlags () {}
                                DMA (Compatibility, NotBusMaster, Transfer8) {}
                            })
                            CreateByteField (RSRC, 0x02, IOLO)
                            CreateByteField (RSRC, 0x03, IOHI)
                            CreateByteField (RSRC, 0x04, IORL)
                            CreateByteField (RSRC, 0x05, IORH)
                            CreateByteField (RSRC, 0x0A, I2LO)
                            CreateByteField (RSRC, 0x0B, I2HI)
                            CreateByteField (RSRC, 0x0C, I2RL)
                            CreateByteField (RSRC, 0x0D, I2RH)
                            CreateByteField (RSRC, 0x11, IRQL)
                            CreateByteField (RSRC, 0x12, IRQH)
                            CreateByteField (RSRC, 0x14, DMAC)
                            ENFG ()
                            If (BPWR)
                            {
                                Store (BADR, Local0)
                                Store (Local0, Local1)
                                And (Local1, 0xC0, Local1)
                                ShiftRight (Local1, 0x06, Local1)
                                ShiftLeft (Local0, 0x02, Local0)
                                And (Local0, 0xFF, Local0)
                                Store (Local0, IOLO)
                                Store (Local1, IOHI)
                                Store (IOLO, IORL)
                                Store (IOHI, IORH)
                                Store (IOHI, Local0)
                                Add (Local0, 0x04, Local0)
                                Store (Local0, I2HI)
                                Store (Local0, I2RH)
                                Store (IOLO, Local0)
                                Store (Local0, I2LO)
                                Store (Local0, I2RL)
                                Store (BIRQ, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, IRQL)
                                Store (0x00, IRQH)
                                Store (IDMA, Local0)
                                Store (0x01, Local1)
                                ShiftLeft (Local1, Local0, DMAC)
                            }

                            EXFG ()
                            Return (RSRC)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IO (Decode16, 0x06F8, 0x06F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IO (Decode16, 0x07F8, 0x07F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IO (Decode16, 0x07E8, 0x07E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IO (Decode16, 0x06E8, 0x06E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                            }
                            EndDependentFn ()
                        })
                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateByteField (Arg0, 0x0A, I2LO)
                            CreateByteField (Arg0, 0x0B, I2HI)
                            CreateByteField (Arg0, 0x11, IRQL)
                            CreateByteField (Arg0, 0x14, DMAC)
                            ENFG ()
                            FindSetRightBit (IRQL, Local0)
                            Subtract (Local0, 0x01, BIRQ)
                            ShiftLeft (IOHI, 0x08, Local0)
                            Or (IOLO, Local0, Local0)
                            ShiftRight (Local0, 0x02, BADR)
                            Store (I2LO, Local0)
                            ShiftRight (Local0, 0x03, Local0)
                            Store (I2HI, Local1)
                            ShiftLeft (Local1, 0x05, Local1)
                            Or (Local0, Local1, Local0)
                            Store (Local0, FBAR)
                            FindSetRightBit (DMAC, Local0)
                            Decrement (Local0)
                            Store (Local0, IDMA)
                            Store (0x00, MMOD)
                            Store (0x0C, I227)
                            Store (0x0E, D227)
                            Store (0x01, BPWR)
                            Store (0x00, BAPD)
                            EXFG ()
                        }
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQ (Edge, ActiveHigh, Exclusive) {1}
                    })
                    Name (_PRW, Package (0x02)
                    {
                        0x18, 
                        0x03
                    })
                    Method (_PSW, 1, NotSerialized)
                    {
                        If (\ECON)
                        {
                            Acquire (\MUTX, 0xFFFF)
                            Store (Arg0, \_SB.PCI0.LPCB.EC.KBWK)
                            Release (\MUTX)
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
            }

            Device (USB0)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (U0CS, PCI_Config, 0xC4, 0x04)
                Field (U0CS, DWordAcc, NoLock, Preserve)
                {
                    U0EN,   2
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
                        Store (0x03, U0EN)
                    }
                    Else
                    {
                        Store (0x00, U0EN)
                    }
                }

                Method (_S1D, 0, NotSerialized)
                {
                    If (LEqual (OSYS, 0x07CF))
                    {
                        Return (0x02)
                    }

                    Return (0x01)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (U1CS, PCI_Config, 0xC4, 0x04)
                Field (U1CS, DWordAcc, NoLock, Preserve)
                {
                    U1EN,   2
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
                        Store (0x03, U1EN)
                    }
                    Else
                    {
                        Store (0x00, U1EN)
                    }
                }

                Method (_S1D, 0, NotSerialized)
                {
                    If (LEqual (OSYS, 0x07CF))
                    {
                        Return (0x02)
                    }

                    Return (0x01)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (U2CS, PCI_Config, 0xC4, 0x04)
                Field (U2CS, DWordAcc, NoLock, Preserve)
                {
                    U2EN,   2
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
                        Store (0x03, U2EN)
                    }
                    Else
                    {
                        Store (0x00, U2EN)
                    }
                }

                Method (_S1D, 0, NotSerialized)
                {
                    If (LEqual (OSYS, 0x07CF))
                    {
                        Return (0x02)
                    }

                    Return (0x01)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB7)
            {
                Name (_ADR, 0x001D0007)
                Name (_PRW, Package (0x02)
                {
                    0x0D, 
                    0x03
                })
            }

            Name (PUAL, Package (0x01)
            {
                0x001F0001
            })
            Device (IDEC)
            {
                Name (_ADR, 0x001F0001)
                OperationRegion (IDEC, PCI_Config, 0x40, 0x18)
                Field (IDEC, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                    SECT,   16, 
                    PSIT,   4, 
                    SSIT,   4, 
                    Offset (0x08), 
                    SYNC,   4, 
                    Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
                    Offset (0x0B), 
                    SDT2,   2, 
                        ,   2, 
                    SDT3,   2, 
                    Offset (0x14), 
                    ICR0,   4, 
                    ICR1,   4, 
                    ICR2,   4, 
                    ICR3,   4, 
                    ICR4,   4, 
                    ICR5,   4
                }

                Device (PRID)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Name (PBUF, Buffer (0x14)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            0x00, 0x00, 0x00, 0x00
                        })
                        CreateDWordField (PBUF, 0x00, PIO0)
                        CreateDWordField (PBUF, 0x04, DMA0)
                        CreateDWordField (PBUF, 0x08, PIO1)
                        CreateDWordField (PBUF, 0x0C, DMA1)
                        CreateDWordField (PBUF, 0x10, FLAG)
                        Store (GETP (PRIT), PIO0)
                        Store (GDMA (And (SYNC, 0x01), And (ICR3, 0x01), And (ICR0, 0x01), SDT0, And (ICR1, 0x01)), DMA0)
                        If (LEqual (DMA0, 0xFFFFFFFF))
                        {
                            Store (PIO0, DMA0)
                        }

                        If (And (PRIT, 0x4000))
                        {
                            If (LEqual (And (PRIT, 0x90), 0x80))
                            {
                                Store (0x0384, PIO1)
                            }
                            Else
                            {
                                Store (GETT (PSIT), PIO1)
                            }
                        }
                        Else
                        {
                            Store (0xFFFFFFFF, PIO1)
                        }

                        Store (GDMA (And (SYNC, 0x02), And (ICR3, 0x02), And (ICR0, 0x02), SDT1, And (ICR1, 0x02)), DMA1)
                        If (LEqual (DMA1, 0xFFFFFFFF))
                        {
                            Store (PIO1, DMA1)
                        }

                        Store (GETF (And (SYNC, 0x01), And (SYNC, 0x02), PRIT), FLAG)
                        Return (PBUF)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, 0x00, PIO0)
                        CreateDWordField (Arg0, 0x04, DMA0)
                        CreateDWordField (Arg0, 0x08, PIO1)
                        CreateDWordField (Arg0, 0x0C, DMA1)
                        CreateDWordField (Arg0, 0x10, FLAG)
                        Or (ICR2, 0x04, ICR2)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            And (PRIT, 0x40F0, PRIT)
                            And (SYNC, 0x0E, SYNC)
                            Store (0x00, SDT0)
                            And (ICR0, 0x0E, ICR0)
                            And (ICR1, 0x0E, ICR1)
                            And (ICR3, 0x0E, ICR3)
                            And (ICR5, 0x0E, ICR5)
                            CreateWordField (Arg1, 0x62, W490)
                            CreateWordField (Arg1, 0x6A, W530)
                            CreateWordField (Arg1, 0x7E, W630)
                            CreateWordField (Arg1, 0x80, W640)
                            CreateWordField (Arg1, 0xB0, W880)
                            CreateWordField (Arg1, 0xBA, W930)
                            Or (PRIT, 0x8004, PRIT)
                            If (LAnd (And (FLAG, 0x02), And (W490, 0x0800)))
                            {
                                Or (PRIT, 0x02, PRIT)
                            }

                            Or (PRIT, SETP (PIO0, W530, W640), PRIT)
                            If (And (FLAG, 0x01))
                            {
                                Or (SYNC, 0x01, SYNC)
                                Store (SDMA (DMA0), SDT0)
                                If (LLess (DMA0, 0x1E))
                                {
                                    Or (ICR3, 0x01, ICR3)
                                }

                                If (LLess (DMA0, 0x3C))
                                {
                                    Or (ICR0, 0x01, ICR0)
                                }

                                If (And (W930, 0x2000))
                                {
                                    Or (ICR1, 0x01, ICR1)
                                }
                            }
                        }

                        If (LEqual (SizeOf (Arg2), 0x0200))
                        {
                            And (PRIT, 0x3F0F, PRIT)
                            Store (0x00, PSIT)
                            And (SYNC, 0x0D, SYNC)
                            Store (0x00, SDT1)
                            And (ICR0, 0x0D, ICR0)
                            And (ICR1, 0x0D, ICR1)
                            And (ICR3, 0x0D, ICR3)
                            And (ICR5, 0x0D, ICR5)
                            CreateWordField (Arg2, 0x62, W491)
                            CreateWordField (Arg2, 0x6A, W531)
                            CreateWordField (Arg2, 0x7E, W631)
                            CreateWordField (Arg2, 0x80, W641)
                            CreateWordField (Arg2, 0xB0, W881)
                            CreateWordField (Arg2, 0xBA, W931)
                            Or (PRIT, 0x8040, PRIT)
                            If (LAnd (And (FLAG, 0x08), And (W491, 0x0800)))
                            {
                                Or (PRIT, 0x20, PRIT)
                            }

                            If (And (FLAG, 0x10))
                            {
                                Or (PRIT, 0x4000, PRIT)
                                If (LGreater (PIO1, 0xF0))
                                {
                                    Or (PRIT, 0x80, PRIT)
                                }
                                Else
                                {
                                    Or (PRIT, 0x10, PRIT)
                                    Store (SETT (PIO1, W531, W641), PSIT)
                                }
                            }

                            If (And (FLAG, 0x04))
                            {
                                Or (SYNC, 0x02, SYNC)
                                Store (SDMA (DMA1), SDT1)
                                If (LLess (DMA1, 0x1E))
                                {
                                    Or (ICR3, 0x02, ICR3)
                                }

                                If (LLess (DMA1, 0x3C))
                                {
                                    Or (ICR0, 0x02, ICR0)
                                }

                                If (And (W931, 0x2000))
                                {
                                    Or (ICR1, 0x02, ICR1)
                                }
                            }
                        }
                    }

                    Device (P_D0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (PIB0, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x03, 
                                0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                            })
                            CreateByteField (PIB0, 0x01, PMD0)
                            CreateByteField (PIB0, 0x08, DMD0)
                            If (And (PRIT, 0x02))
                            {
                                If (LEqual (And (PRIT, 0x09), 0x08))
                                {
                                    Store (0x08, PMD0)
                                }
                                Else
                                {
                                    Store (0x0A, PMD0)
                                    ShiftRight (And (PRIT, 0x0300), 0x08, Local0)
                                    ShiftRight (And (PRIT, 0x3000), 0x0C, Local1)
                                    Add (Local0, Local1, Local2)
                                    If (LEqual (0x03, Local2))
                                    {
                                        Store (0x0B, PMD0)
                                    }

                                    If (LEqual (0x05, Local2))
                                    {
                                        Store (0x0C, PMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x01, PMD0)
                            }

                            If (And (SYNC, 0x01))
                            {
                                Store (Or (SDT0, 0x40), DMD0)
                                If (And (ICR1, 0x01))
                                {
                                    If (And (ICR0, 0x01))
                                    {
                                        Add (DMD0, 0x02, DMD0)
                                    }

                                    If (And (ICR3, 0x01))
                                    {
                                        Store (0x45, DMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD0, 0x07), 0x02), 0x20, DMD0)
                            }

                            Return (PIB0)
                        }
                    }

                    Device (P_D1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (PIB1, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF, 0x03, 
                                0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                            })
                            CreateByteField (PIB1, 0x01, PMD1)
                            CreateByteField (PIB1, 0x08, DMD1)
                            If (And (PRIT, 0x20))
                            {
                                If (LEqual (And (PRIT, 0x90), 0x80))
                                {
                                    Store (0x08, PMD1)
                                }
                                Else
                                {
                                    Add (And (PSIT, 0x03), ShiftRight (And (PSIT, 0x0C), 0x02), Local0)
                                    If (LEqual (0x05, Local0))
                                    {
                                        Store (0x0C, PMD1)
                                    }
                                    Else
                                    {
                                        If (LEqual (0x03, Local0))
                                        {
                                            Store (0x0B, PMD1)
                                        }
                                        Else
                                        {
                                            Store (0x0A, PMD1)
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x01, PMD1)
                            }

                            If (And (SYNC, 0x02))
                            {
                                Store (Or (SDT1, 0x40), DMD1)
                                If (And (ICR1, 0x02))
                                {
                                    If (And (ICR0, 0x02))
                                    {
                                        Add (DMD1, 0x02, DMD1)
                                    }

                                    If (And (ICR3, 0x02))
                                    {
                                        Store (0x45, DMD1)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD1, 0x07), 0x02), 0x20, DMD1)
                            }

                            Return (PIB1)
                        }
                    }

                    Method (_PS0, 0, NotSerialized)
                    {
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                    }
                }

                Device (SECD)
                {
                    Name (_ADR, 0x01)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Name (SBUF, Buffer (0x14)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            0x00, 0x00, 0x00, 0x00
                        })
                        CreateDWordField (SBUF, 0x00, PIO0)
                        CreateDWordField (SBUF, 0x04, DMA0)
                        CreateDWordField (SBUF, 0x08, PIO1)
                        CreateDWordField (SBUF, 0x0C, DMA1)
                        CreateDWordField (SBUF, 0x10, FLAG)
                        Store (GETP (SECT), PIO0)
                        Store (GDMA (And (SYNC, 0x04), And (ICR3, 0x04), And (ICR0, 0x04), SDT2, And (ICR1, 0x04)), DMA0)
                        If (LEqual (DMA0, 0xFFFFFFFF))
                        {
                            Store (PIO0, DMA0)
                        }

                        If (And (SECT, 0x4000))
                        {
                            If (LEqual (And (SECT, 0x90), 0x80))
                            {
                                Store (0x0384, PIO1)
                            }
                            Else
                            {
                                Store (GETT (SSIT), PIO1)
                            }
                        }
                        Else
                        {
                            Store (0xFFFFFFFF, PIO1)
                        }

                        Store (GDMA (And (SYNC, 0x08), And (ICR3, 0x08), And (ICR0, 0x08), SDT3, And (ICR1, 0x08)), DMA1)
                        If (LEqual (DMA1, 0xFFFFFFFF))
                        {
                            Store (PIO1, DMA1)
                        }

                        Store (GETF (And (SYNC, 0x04), And (SYNC, 0x08), SECT), FLAG)
                        Return (SBUF)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, 0x00, PIO0)
                        CreateDWordField (Arg0, 0x04, DMA0)
                        CreateDWordField (Arg0, 0x08, PIO1)
                        CreateDWordField (Arg0, 0x0C, DMA1)
                        CreateDWordField (Arg0, 0x10, FLAG)
                        Or (ICR2, 0x04, ICR2)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            And (SECT, 0x40F0, SECT)
                            And (SYNC, 0x0B, SYNC)
                            Store (0x00, SDT2)
                            And (ICR0, 0x0B, ICR0)
                            And (ICR1, 0x0B, ICR1)
                            And (ICR3, 0x0B, ICR3)
                            And (ICR5, 0x0B, ICR5)
                            CreateWordField (Arg1, 0x62, W490)
                            CreateWordField (Arg1, 0x6A, W530)
                            CreateWordField (Arg1, 0x7E, W630)
                            CreateWordField (Arg1, 0x80, W640)
                            CreateWordField (Arg1, 0xB0, W880)
                            CreateWordField (Arg1, 0xBA, W930)
                            Or (SECT, 0x8004, SECT)
                            If (LAnd (And (FLAG, 0x02), And (W490, 0x0800)))
                            {
                                Or (SECT, 0x02, SECT)
                            }

                            Or (SECT, SETP (PIO0, W530, W640), SECT)
                            If (And (FLAG, 0x01))
                            {
                                Or (SYNC, 0x04, SYNC)
                                Store (SDMA (DMA0), SDT2)
                                If (LLess (DMA0, 0x1E))
                                {
                                    Or (ICR3, 0x04, ICR3)
                                }

                                If (LLess (DMA0, 0x3C))
                                {
                                    Or (ICR0, 0x04, ICR0)
                                }

                                If (And (W930, 0x2000))
                                {
                                    Or (ICR1, 0x04, ICR1)
                                }
                            }
                        }

                        If (LEqual (SizeOf (Arg2), 0x0200))
                        {
                            And (SECT, 0x3F0F, SECT)
                            Store (0x00, SSIT)
                            And (SYNC, 0x07, SYNC)
                            Store (0x00, SDT3)
                            And (ICR0, 0x07, ICR0)
                            And (ICR1, 0x07, ICR1)
                            And (ICR3, 0x07, ICR3)
                            And (ICR5, 0x07, ICR5)
                            CreateWordField (Arg2, 0x62, W491)
                            CreateWordField (Arg2, 0x6A, W531)
                            CreateWordField (Arg2, 0x7E, W631)
                            CreateWordField (Arg2, 0x80, W641)
                            CreateWordField (Arg2, 0xB0, W881)
                            CreateWordField (Arg2, 0xBA, W931)
                            Or (SECT, 0x8040, SECT)
                            If (LAnd (And (FLAG, 0x08), And (W491, 0x0800)))
                            {
                                Or (SECT, 0x20, SECT)
                            }

                            If (And (FLAG, 0x10))
                            {
                                Or (SECT, 0x4000, SECT)
                                If (LGreater (PIO1, 0xF0))
                                {
                                    Or (SECT, 0x80, SECT)
                                }
                                Else
                                {
                                    Or (SECT, 0x10, SECT)
                                    Store (SETT (PIO1, W531, W641), SSIT)
                                }
                            }

                            If (And (FLAG, 0x04))
                            {
                                Or (SYNC, 0x08, SYNC)
                                Store (SDMA (DMA1), SDT3)
                                If (LLess (DMA1, 0x1E))
                                {
                                    Or (ICR3, 0x08, ICR3)
                                }

                                If (LLess (DMA1, 0x3C))
                                {
                                    Or (ICR0, 0x08, ICR0)
                                }

                                If (And (W931, 0x2000))
                                {
                                    Or (ICR1, 0x08, ICR1)
                                }
                            }
                        }
                    }

                    Device (S_D0)
                    {
                        Name (_ADR, 0x00)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LAnd (ICR4, 0x04))
                            {
                                Return (0x00)
                            }

                            Return (0x0F)
                        }

                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (SIB0, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x03, 
                                0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                            })
                            CreateByteField (SIB0, 0x01, PMD0)
                            CreateByteField (SIB0, 0x08, DMD0)
                            If (And (SECT, 0x02))
                            {
                                If (LEqual (And (SECT, 0x09), 0x08))
                                {
                                    Store (0x08, PMD0)
                                }
                                Else
                                {
                                    Store (0x0A, PMD0)
                                    ShiftRight (And (SECT, 0x0300), 0x08, Local0)
                                    ShiftRight (And (SECT, 0x3000), 0x0C, Local1)
                                    Add (Local0, Local1, Local2)
                                    If (LEqual (0x03, Local2))
                                    {
                                        Store (0x0B, PMD0)
                                    }

                                    If (LEqual (0x05, Local2))
                                    {
                                        Store (0x0C, PMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x01, PMD0)
                            }

                            If (And (SYNC, 0x04))
                            {
                                Store (Or (SDT2, 0x40), DMD0)
                                If (And (ICR1, 0x04))
                                {
                                    If (And (ICR0, 0x04))
                                    {
                                        Add (DMD0, 0x02, DMD0)
                                    }

                                    If (And (ICR3, 0x04))
                                    {
                                        Store (0x45, DMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD0, 0x07), 0x02), 0x20, DMD0)
                            }

                            Return (SIB0)
                        }
                    }

                    Device (S_D1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (SIB1, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF, 0x03, 
                                0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                            })
                            CreateByteField (SIB1, 0x01, PMD1)
                            CreateByteField (SIB1, 0x08, DMD1)
                            If (And (SECT, 0x20))
                            {
                                If (LEqual (And (SECT, 0x90), 0x80))
                                {
                                    Store (0x08, PMD1)
                                }
                                Else
                                {
                                    Add (And (SSIT, 0x03), ShiftRight (And (SSIT, 0x0C), 0x02), Local0)
                                    If (LEqual (0x05, Local0))
                                    {
                                        Store (0x0C, PMD1)
                                    }
                                    Else
                                    {
                                        If (LEqual (0x03, Local0))
                                        {
                                            Store (0x0B, PMD1)
                                        }
                                        Else
                                        {
                                            Store (0x0A, PMD1)
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x01, PMD1)
                            }

                            If (And (SYNC, 0x08))
                            {
                                Store (Or (SDT3, 0x40), DMD1)
                                If (And (ICR1, 0x08))
                                {
                                    If (And (ICR0, 0x08))
                                    {
                                        Add (DMD1, 0x02, DMD1)
                                    }

                                    If (And (ICR3, 0x08))
                                    {
                                        Store (0x45, DMD1)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD1, 0x07), 0x02), 0x20, DMD1)
                            }

                            Return (SIB1)
                        }
                    }

                    Method (_PS0, 0, NotSerialized)
                    {
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                    }
                }

                Method (GETP, 1, Serialized)
                {
                    If (LEqual (And (Arg0, 0x09), 0x00))
                    {
                        Return (0xFFFFFFFF)
                    }

                    If (LEqual (And (Arg0, 0x09), 0x08))
                    {
                        Return (0x0384)
                    }

                    ShiftRight (And (Arg0, 0x0300), 0x08, Local0)
                    ShiftRight (And (Arg0, 0x3000), 0x0C, Local1)
                    Return (Multiply (0x1E, Subtract (0x09, Add (Local0, Local1))))
                }

                Method (GDMA, 5, Serialized)
                {
                    If (Arg0)
                    {
                        If (LAnd (Arg1, Arg4))
                        {
                            Return (0x14)
                        }

                        If (LAnd (Arg2, Arg4))
                        {
                            Return (Multiply (Subtract (0x04, Arg3), 0x0F))
                        }

                        Return (Multiply (Subtract (0x04, Arg3), 0x1E))
                    }

                    Return (0xFFFFFFFF)
                }

                Method (GETT, 1, Serialized)
                {
                    Return (Multiply (0x1E, Subtract (0x09, Add (And (ShiftRight (Arg0, 0x02), 0x03), And (Arg0, 0x03)))))
                }

                Method (GETF, 3, Serialized)
                {
                    Name (TMPF, 0x00)
                    If (Arg0)
                    {
                        Or (TMPF, 0x01, TMPF)
                    }

                    If (And (Arg2, 0x02))
                    {
                        Or (TMPF, 0x02, TMPF)
                    }

                    If (Arg1)
                    {
                        Or (TMPF, 0x04, TMPF)
                    }

                    If (And (Arg2, 0x20))
                    {
                        Or (TMPF, 0x08, TMPF)
                    }

                    If (And (Arg2, 0x4000))
                    {
                        Or (TMPF, 0x10, TMPF)
                    }

                    Return (TMPF)
                }

                Method (SETP, 3, Serialized)
                {
                    If (LGreater (Arg0, 0xF0))
                    {
                        Return (0x08)
                    }
                    Else
                    {
                        If (And (Arg1, 0x02))
                        {
                            If (LAnd (LNot (LGreater (Arg0, 0x78)), And (Arg2, 0x02)))
                            {
                                Return (0x2301)
                            }

                            If (LAnd (LNot (LGreater (Arg0, 0xB4)), And (Arg2, 0x01)))
                            {
                                Return (0x2101)
                            }
                        }

                        Return (0x1001)
                    }
                }

                Method (SDMA, 1, Serialized)
                {
                    If (LNot (LGreater (Arg0, 0x14)))
                    {
                        Return (0x01)
                    }

                    If (LNot (LGreater (Arg0, 0x1E)))
                    {
                        Return (0x02)
                    }

                    If (LNot (LGreater (Arg0, 0x2D)))
                    {
                        Return (0x01)
                    }

                    If (LNot (LGreater (Arg0, 0x3C)))
                    {
                        Return (0x02)
                    }

                    If (LNot (LGreater (Arg0, 0x5A)))
                    {
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Method (SETT, 3, Serialized)
                {
                    If (And (Arg1, 0x02))
                    {
                        If (LAnd (LNot (LGreater (Arg0, 0x78)), And (Arg2, 0x02)))
                        {
                            Return (0x0B)
                        }

                        If (LAnd (LNot (LGreater (Arg0, 0xB4)), And (Arg2, 0x01)))
                        {
                            Return (0x09)
                        }
                    }

                    Return (0x04)
                }
            }

            Device (SBUS)
            {
                Name (_ADR, 0x001F0003)
                OperationRegion (SBUS, SystemIO, 0x1880, 0x10)
                Field (SBUS, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8, 
                    Offset (0x02), 
                    HCON,   8, 
                    HCOM,   8, 
                    TXSA,   8, 
                    DAT0,   8, 
                    DAT1,   8, 
                    BDBR,   8, 
                    Offset (0x09), 
                    RXSA,   8, 
                    SDAT,   16
                }

                Method (SBWB, 3, NotSerialized)
                {
                    Store (0x0A, Local0)
                    While (LAnd (And (HSTS, 0x01), Local0))
                    {
                        Sleep (0x64)
                        Decrement (Local0)
                    }

                    Store (0xFF, HSTS)
                    Store (Arg0, TXSA)
                    Store (Arg1, HCOM)
                    Store (Arg2, DAT0)
                    Store (0x00, DAT1)
                    Store (0x08, HCON)
                    Sleep (0x64)
                    Store (0x48, HCON)
                }

                Method (SBRB, 2, NotSerialized)
                {
                    Store (0x0A, Local0)
                    While (LAnd (And (HSTS, 0x01), Local0))
                    {
                        Sleep (0x64)
                        Decrement (Local0)
                    }

                    Store (0xFF, HSTS)
                    Store (Or (Arg0, 0x01), TXSA)
                    Store (Arg1, HCOM)
                    Store (0x08, HCON)
                    Sleep (0x64)
                    Store (0x48, HCON)
                    Store (0x0A, Local0)
                    While (LAnd (And (HSTS, 0x02), Local0))
                    {
                        Sleep (0x64)
                        Decrement (Local0)
                    }

                    Return (DAT0)
                }
            }

            Device (AUD0)
            {
                Name (_ADR, 0x001F0005)
            }

            Device (MODM)
            {
                Name (_ADR, 0x001F0006)
            }
        }

        OperationRegion (SMI0, SystemIO, 0x0000FE00, 0x00000002)
        Field (SMI0, AnyAcc, NoLock, Preserve)
        {
            SMIC,   8
        }

        OperationRegion (SMI1, SystemMemory, 0x1FF6CEAC, 0x00000090)
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

        Mutex (PSMX, 0x00)
    }
}


--=-6k7t4OU/ksbr+p+cKjn3--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
