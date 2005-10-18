From: Federico =?iso-8859-1?q?Nu=F1ez_Artigas?= <fna-H4aWS73dXuqoBQtF3CFPZg@public.gmane.org>
Subject: Compaq Evo N150
Date: Mon, 17 Oct 2005 23:56:16 -0300
Message-ID: <200510172356.16445.fna@internet.com.uy>
Reply-To: fna-H4aWS73dXuqoBQtF3CFPZg@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QRGVDWxxYz+2GTE"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

--Boundary-00=_QRGVDWxxYz+2GTE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello..

I'm having some troubles with the acpi Support on this laptop.
Here is happening some crazy thinks that I don't understand at all.

Reading on the web I found that someone discover that compiling the kernel 
with gcc-2.95 make acpi work on this laptop, I doit a make battery and thermal 
status work (sleep modes no). 
The same kernel, the same config, the same buggy DSDT with gcc-2.95 make 
battery and thermal status work and with gcc-3xx/gcc-4 DON,T.

I have try fix the DSDT, I fix all compiling problem but nothing change.

I was running a kernel compiled with 2.95 for a year, but that take me other 
problems when trying to compile external modules.

Now, I need to leave 2.95....

can someone help me?
really, I don't know what more I can do!!!
I send my fixed DSDT attached, 


bye and thanks 
fede.

--Boundary-00=_QRGVDWxxYz+2GTE
Content-Type: text/plain;
  charset="us-ascii";
  name="dsdt_original.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dsdt_original.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20050513
 *
 * Disassembly of dsdt_dump2.dat, Sun Oct  9 21:15:36 2005
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "Compaq", "Wrangler", 100925440)
{
    Scope (\_PR)
    {
        Processor (CPU0, 0x01, 0x986E8482, 0x80) {}
    }

    Name (\_S0, Package (0x02)
    {
        0x00, 
        0x00
    })
    Name (\_S1, Package (0x02)
    {
        0x04, 
        0x04
    })
    Name (\_S4, Package (0x02)
    {
        0x02, 
        0x02
    })
    Name (\_S5, Package (0x02)
    {
        0x02, 
        0x02
    })
    Scope (\_GPE)
    {
        Name (LIF1, 0x00)
        Name (LIF2, 0x00)
        Method (_L0B, 0, NotSerialized)
        {
            \_SB.Z000 (0x88)
            If (LEqual (\_GPE.LIF1, 0x01))
            {
                Not (\_SB.PCI0.PM.LPOL, \_SB.PCI0.PM.LPOL)
                Store (0x00, \_GPE.LIF1)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    \_SB.PCI0.AGP.VGA.DRUU (0xFF)
                }
                Else
                {
                    \_SB.Z000 (0x84)
                }
            }
            Else
            {
                If (LEqual (\_GPE.LIF2, 0x01))
                {
                    Not (\_SB.PCI0.PM.LPOL, \_SB.PCI0.PM.LPOL)
                    Store (0x00, \_GPE.LIF2)
                    Notify (\_SB.LID, 0x80)
                }
                Else
                {
                    If (LEqual (\_SB.PCI0.CRTS, 0x01))
                    {
                        Not (\_SB.PCI0.PM.LPOL, \_SB.PCI0.PM.LPOL)
                        If (LEqual (\_SB.PCI0.PM.LPOL, 0x01))
                        {
                            If (LEqual (SizeOf (\_OS), 0x14))
                            {
                                \_SB.PCI0.AGP.VGA.DRUU (0xFF)
                            }
                            Else
                            {
                                \_SB.Z000 (0x84)
                            }
                        }
                        Else
                        {
                            Store (0x01, \_GPE.LIF1)
                            If (LEqual (SizeOf (\_OS), 0x14))
                            {
                                \_SB.PCI0.AGP.VGA.DRUU (0x00)
                            }
                            Else
                            {
                                \_SB.Z000 (0x83)
                            }
                        }
                    }
                    Else
                    {
                        Store (" GPE_L0B - LID CLOSED ", Debug)
                        Not (\_SB.PCI0.PM.LPOL, \_SB.PCI0.PM.LPOL)
                        Store (0x01, \_GPE.LIF2)
                        Notify (\_SB.LID, 0x80)
                    }
                }
            }
        }

        Method (_L08, 0, NotSerialized)
        {
            Store ("_GPE._L08 - UAR1", Debug)
            Notify (\_SB.PCI0.PIB.UAR1, 0x02)
        }

        Method (_L09, 0, NotSerialized)
        {
            Store ("_GPE._L09 - USB", Debug)
            Notify (\_SB.PCI0.USB0, 0x02)
            Notify (\_SB.PCI0.PIB.UAR1, 0x02)
        }

        Method (_L05, 0, NotSerialized)
        {
            If (LEqual (SizeOf (\_OS), 0x11))
            {
                If (\_SB.SPST)
                {
                    Notify (\_SB.PCI0, 0x02)
                }
                Else
                {
                    If (LOr (\_SB.PCI0.PMOD.MWAK, \_SB.PCI0.PMOD.MPME))
                    {
                        Store (0x01, \_SB.PCI0.PMOD.MWAK)
                        Store (0x00, \_SB.PCI0.PMOD.MPME)
                    }

                    If (\_SB.PCI0.CRD0.PMST)
                    {
                        Notify (\_SB.PCI0.CRD0, 0x02)
                    }

                    If (\_SB.PCI0.CRD1.PMST)
                    {
                        Notify (\_SB.PCI0.CRD1, 0x02)
                    }
                }
            }
            Else
            {
                Notify (\_SB.PCI0, 0x02)
            }
        }

        Name (HKFG, 0x00)
        Method (_L00, 0, NotSerialized)
        {
            If (LEqual (\_GPE.HKFG, 0x00))
            {
                \_SB.Z000 (0x8B)
            }
            Else
            {
                Store (0x00, \_GPE.HKFG)
                Notify (\_SB.PWRB, 0x02)
            }
        }
    }

    OperationRegion (CMOS, SystemIO, 0x72, 0x02)
    Field (CMOS, ByteAcc, NoLock, Preserve)
    {
        CINX,   8, 
        CDAT,   8
    }

    IndexField (CINX, CDAT, ByteAcc, NoLock, Preserve)
    {
        Offset (0xA0), 
        BCRN,   16, 
        MFCC,   16, 
        AFCC,   16, 
        MBRM,   16, 
        ABRM,   16, 
        MBVT,   16, 
        ABVT,   16, 
        Offset (0xB0), 
        MBTS,   1, 
        SBTS,   1, 
            ,   2, 
        MBTD,   1, 
        ABTD,   1, 
        MBTC,   1, 
        ABTC,   1, 
        ACDF,   1, 
            ,   1, 
        NVOS,   2, 
        PHEX,   1, 
        Offset (0xB2), 
        CTMP,   8
    }

    Method (\_PTS, 1, NotSerialized)
    {
        Store (0x01, \_SB.SPST)
        If (LEqual (Arg0, 0x04))
        {
            Store (Zero, \_SB.PCI0.PM.GPI5)
        }

        If (LEqual (Arg0, 0x05))
        {
            Store (0x00, \_SB.PCI0.PM.GO22)
        }

        If (LEqual (Arg0, 0x01))
        {
            If (LEqual (SizeOf (\_OS), 0x14))
            {
                Store (0x01, NVOS)
            }
            Else
            {
                Store (0x00, NVOS)
            }

            Sleep (0x32)
            Store ("------------- System S0 to S1 mode -------------", Debug)
            \_SB.Z000 (0x8A)
            Store (0x00, \_SB.PCI0.PM.LPOL)
            If (LEqual (SizeOf (\_OS), 0x11))
            {
                Store (0x01, \_SB.PCI0.PMOD.MWAK)
                Store (0x01, \_SB.PCI0.PMOD.MPME)
            }

            Store (0x01, \_GPE.HKFG)
        }
    }

    Method (\_WAK, 1, NotSerialized)
    {
        \_SB.Z000 (0x9A)
        Store (0x00, \_SB.ACAD.AFST)
        Store (0x00, \_SB.BAT1.BFST)
        Store (0x00, \_SB.BAT2.BFST)
        Store (0x01, \_SB.MFLG)
        Store (0x01, \_SB.AFLG)
        Store (0x01, \_SB.FACD)
        Store (0x00, \_GPE.LIF1)
        Store (0x00, \_GPE.LIF2)
        If (LEqual (SizeOf (\_OS), 0x14))
        {
            \_SB.PCI0.AGP.VGA._INI ()
        }

        If (\_SB.SSVW)
        {
            Store (\_SB.SSVW, \_SB.PCI0.AGP.VGA.VW01)
        }

        Store (0x00, \_SB.SPST)
        If (LEqual (Arg0, 0x04))
        {
            Store ("------------- System S4 to S0 mode -------------", Debug)
            \_SB.Z000 (0x8C)
            Store (0x01, \_SB.PCI0.QTMR)
            If (LEqual (SizeOf (\_OS), 0x14))
            {
                Store (0x28, \_SB.PCI0.TMR0)
                \_SB.Z000 (0x8D)
            }
        }

        If (LEqual (Arg0, 0x01))
        {
            Store ("------------- System S1 to S0 mode -------------", Debug)
            \_SB.Z000 (0x81)
            If (LEqual (SizeOf (\_OS), 0x14))
            {
                Notify (\_SB.PCI0.AGP.VGA, 0x00)
                Return (0x00)
            }
        }

        If (LNot (\_SB.PCI0.PM.RTCS))
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Notify (\_SB.PCI0.AGP.VGA, 0x00)
    }

    Scope (\_TZ)
    {
        Name (TAC1, 0x0CFA)
        Name (HAC1, 0x0CFA)
        Name (TAC0, 0x0D9A)
        Name (HAC0, 0x0D9A)
        Name (TPAS, 0x0E30)
        Name (HPAS, 0x0E30)
        Name (TPC, 0x0E80)
        Name (TPTM, 0x0CA0)
        Name (TBSE, 0x0AAC)
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
                Store ("FAN 0 - _PS0", Debug)
            }

            Method (_PS3, 0, NotSerialized)
            {
                Store ("FAN 0 - _PS3", Debug)
            }
        }

        PowerResource (PFN0, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                XOr (\_SB.PCI0.PM.GO07, One, Local7)
                Return (Local7)
            }

            Method (_ON, 0, NotSerialized)
            {
                Store (Zero, \_SB.PCI0.PM.GO07)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    Notify (\_TZ.THRM, 0x81)
                }
            }

            Method (_OFF, 0, NotSerialized)
            {
                Store (One, \_SB.PCI0.PM.GO07)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    Notify (\_TZ.THRM, 0x81)
                }
            }
        }

        Device (FAN1)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, 0x02)
            Name (_PR0, Package (0x01)
            {
                PFN1
            })
            Method (_PS0, 0, NotSerialized)
            {
                Store ("FAN 1 - _PS0", Debug)
            }

            Method (_PS3, 0, NotSerialized)
            {
                Store ("FAN 1 - _PS3", Debug)
            }
        }

        PowerResource (PFN1, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                XOr (\_SB.PCI0.PM.GO23, One, Local7)
                Return (Local7)
            }

            Method (_ON, 0, NotSerialized)
            {
                Store (Zero, \_SB.PCI0.PM.GO07)
                Store (Zero, \_SB.PCI0.PM.GO23)
            }

            Method (_OFF, 0, NotSerialized)
            {
                Store (One, \_SB.PCI0.PM.GO23)
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

            Name (_TSP, 0x28)
            Method (_TMP, 0, NotSerialized)
            {
                If (Or (Or (PHEX, \_SB.DFEC), \_SB.THGO))
                {
                    Return (TPTM)
                }

                If (\_SB.OKEC)
                {
                    \_SB.Z000 (0x93)
                    Store (CTMP, Local1)
                    Store ("_TMP Current Temperature is ----------- ", Debug)
                    Store (Local1, Debug)
                    Add (Multiply (Local1, 0x0A), TBSE, Local1)
                    Return (Local1)
                }
                Else
                {
                    Return (TPTM)
                }
            }

            Name (_PSL, Package (0x01)
            {
                \_PR.CPU0
            })
            Name (_TC1, 0x02)
            Name (_TC2, 0x03)
            Method (_SCP, 1, NotSerialized)
            {
                If (Arg0)
                {
                    Store (One, PLCY)
                    Store (HAC1, TPAS)
                    Store (HAC0, TAC1)
                    Store (HPAS, TAC0)
                }
                Else
                {
                    Store (Zero, PLCY)
                    Store (HAC1, TAC1)
                    Store (HAC0, TAC0)
                    Store (HPAS, TPAS)
                }

                Notify (\_TZ.THRM, 0x81)
            }
        }
    }

    OperationRegion (\P378, SystemIO, 0x0378, 0x02)
    Field (\P378, ByteAcc, NoLock, Preserve)
    {
        O378,   8, 
        I379,   8
    }

    Method (DBGC, 1, Serialized)
    {
        F378 (Arg0)
        FODB (0x55)
        FODB (0xAA)
        FODB (0x0E)
        FODB (0x10)
        FODB (0x20)
        FODB (0x07)
        FODB (0x66)
    }

    Method (DBGD, 1, Serialized)
    {
        Store (Arg0, Local0)
        And (Local0, 0xFF, Local1)
        ShiftRight (Local0, 0x08, Local2)
        And (Local2, 0xFF, Local2)
        ShiftRight (Local0, 0x10, Local3)
        And (Local3, 0xFF, Local3)
        ShiftRight (Local0, 0x18, Local4)
        And (Local4, 0xFF, Local4)
        And (I379, 0xF8, Local0)
        If (LEqual (Local0, 0xB0))
        {
            FODB (0x55)
            FODB (0xAA)
            FODB (0x02)
            FODB (0x02)
            FODB (Local1)
            FODB (Local2)
            FODB (Local3)
            FODB (Local4)
            FODB (0x66)
        }
    }

    Method (DBGS, 1, Serialized)
    {
        And (I379, 0xF8, Local0)
        If (LEqual (Local0, 0xB0))
        {
            Store (SizeOf (Arg0), Local1)
            Name (BUFF, Buffer (Local1) {})
            Store (Arg0, BUFF)
            Store (Zero, Local2)
            FODB (0x55)
            FODB (0xAA)
            FODB (0x09)
            FODB (0x10)
            FODB (0x0D)
            FODB (0x0A)
            While (LNot (LEqual (Local2, Local1)))
            {
                Store (DerefOf (Index (BUFF, Local2)), Local3)
                Increment (Local2)
                FODB (Local3)
            }

            FODB (0x00)
            FODB (0x66)
        }
    }

    Method (DBGT, 1, Serialized)
    {
        And (I379, 0xF8, Local0)
        If (LEqual (Local0, 0xB0))
        {
            Store (SizeOf (Arg0), Local1)
            Name (BUFF, Buffer (Local1) {})
            Store (Arg0, BUFF)
            Store (Zero, Local2)
            FODB (0x55)
            FODB (0xAA)
            FODB (0x0A)
            FODB (0x10)
            While (LNot (LEqual (Local2, Local1)))
            {
                Store (DerefOf (Index (BUFF, Local2)), Local3)
                Increment (Local2)
                FODB (Local3)
            }

            FODB (0x00)
            FODB (0x66)
        }
    }

    Method (CHAR, 1, Serialized)
    {
        FODB (0x55)
        FODB (0xAA)
        FODB (0x0E)
        FODB (0x10)
        FODB (Arg0)
        FODB (0x07)
        FODB (0x66)
    }

    Method (F378, 1, Serialized)
    {
        And (I379, 0xF8, Local0)
        If (LEqual (Local0, 0xB0))
        {
            FODB (0x55)
            FODB (0xAA)
            FODB (0x00)
            FODB (0x02)
            FODB (Arg0)
            FODB (0x66)
        }
    }

    Method (\FODB, 1, NotSerialized)
    {
        Or (Arg0, 0x10, Local0)
        Store (Local0, O378)
        Store (0x01, Local3)
        While (Local3)
        {
            If (LEqual (And (I379, 0x80, Local3), 0x00))
            {
                ShiftRight (I379, 0x03, Local0)
                And (Local0, 0x0F, Local0)
                ShiftRight (Arg0, 0x04, Local1)
                Store (Local1, O378)
                Store (0x01, Local2)
                While (Local2)
                {
                    If (And (I379, 0x80, Local2))
                    {
                        Store (I379, Local1)
                        Store (0x00, Local2)
                    }
                    Else
                    {
                        Store (0x01, Local2)
                    }
                }

                ShiftLeft (Local1, 0x01, Local1)
                And (Local1, 0xF0, Local1)
                Or (Local1, Local0, Local0)
                Store (0x00, Local3)
            }
        }
    }

    Scope (_SB)
    {
        Name (SSVW, 0x00)
        Name (GGEC, 0x01)
        Name (YYEC, 0x00)
        Name (MFLG, 0x01)
        Name (AFLG, 0x01)
        Name (MBT0, 0x01)
        Name (SBT0, 0x01)
        Name (ACD0, 0x01)
        Name (FACD, 0x01)
        Name (THGO, 0x00)
        Name (FMST, 0x01)
        Name (FAST, 0x01)
        Name (FDD0, 0x00)
        Name (WVGA, 0x00)
        Name (MYOS, 0x04)
        Method (_INI, 0, NotSerialized)
        {
            Store (0x04, MYOS)
            If (LEqual (SizeOf (\_OS), 0x14))
            {
                Store (0x01, MYOS)
            }

            If (LEqual (SizeOf (\_OS), 0x11))
            {
                Store (0x00, MYOS)
            }

            If (LEqual (SizeOf (\_OS), 0x27))
            {
                Store (0x02, MYOS)
            }
        }

        Name (SPST, 0x00)
        Mutex (VSMX, 0x00)
        Method (Z000, 1, Serialized)
        {
            Store ("--------- VIA SOFTWARE SMI PMIO 2Fh ------------", Debug)
            Acquire (VSMX, 0xFFFF)
            Store (Arg0, \_SB.PCI0.PM.BCMD)
            Release (VSMX)
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x00, 
                0x01
            })
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0B)
            }
        }

        Device (ACAD)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (ACP, Ones)
            Name (AFST, 0x00)
            Method (_PSR, 0, NotSerialized)
            {
                Store (0x00, Local0)
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (Local0)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.FACD)
                    {
                        Sleep (0x32)
                        \_SB.Z000 (0x91)
                        Store (ACDF, \_SB.ACD0)
                        Sleep (0x32)
                        Store (Zero, \_SB.FACD)
                    }

                    If (\_SB.ACD0)
                    {
                        Store (0x01, Local0)
                    }

                    If (LNot (AFST))
                    {
                        Store (0x01, AFST)
                        And (\_SB.PCI0.PIB.EC0.BATO, 0x3F, \_SB.PCI0.PIB.EC0.BATO)
                        If (LEqual (Local0, 0x01))
                        {
                            Or (\_SB.PCI0.PIB.EC0.BATO, 0xC0, \_SB.PCI0.PIB.EC0.BATO)
                        }
                    }
                }
                Else
                {
                    Store (0x01, Local0)
                }

                Return (Local0)
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }

        Method (POSW, 1, NotSerialized)
        {
            If (And (Arg0, 0x8000))
            {
                If (LEqual (Arg0, 0xFFFF))
                {
                    Return (0xFFFFFFFF)
                }
                Else
                {
                    Not (Arg0, Local0)
                    Increment (Local0)
                    And (Local0, 0xFFFF, Local0)
                    Return (Local0)
                }
            }
            Else
            {
                Return (Arg0)
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (BFST, 0x00)
            Name (FBST, 0x01)
            Mutex (MMTX, 0x00)
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0xFA, 
                0x64, 
                0x0A, 
                0x19, 
                "BAT1", 
                " ", 
                " ", 
                " "
            })
            Name (PBST, Package (0x04)
            {
                0x00, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x2710
            })
            Name (FAST, 0x00)
            Method (_STA, 0, NotSerialized)
            {
                Store (0x0F, Local0)
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (Local0)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.MFLG)
                    {
                        \_SB.Z000 (0x90)
                        Store (MBTS, \_SB.MBT0)
                        Sleep (0x32)
                        Store (Zero, \_SB.MFLG)
                    }

                    If (\_SB.MBT0)
                    {
                        Store (0x1F, Local0)
                    }

                    If (LNot (BFST))
                    {
                        Store (0x01, BFST)
                        And (\_SB.PCI0.PIB.EC0.BATO, 0xFFFE, \_SB.PCI0.PIB.EC0.BATO)
                        If (LEqual (Local0, 0x1F))
                        {
                            Or (\_SB.PCI0.PIB.EC0.BATO, 0x01, \_SB.PCI0.PIB.EC0.BATO)
                        }
                    }
                }

                Return (Local0)
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (PBIF)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.MBT0)
                    {
                        \_SB.Z000 (0x8E)
                        UPBI ()
                    }
                    Else
                    {
                        IVBI ()
                    }
                }

                Return (PBIF)
            }

            Method (_BST, 0, NotSerialized)
            {
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (PBST)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.MBT0)
                    {
                        If (FBST)
                        {
                            \_SB.Z000 (0x8F)
                            Store (0x00, FBST)
                        }

                        UPBS ()
                    }
                    Else
                    {
                        IVBS ()
                    }
                }

                Return (PBST)
            }

            Method (UPBI, 0, NotSerialized)
            {
                Store (0x1E, Local1)
                While (LGreater (Local1, 0x01))
                {
                    Store (MFCC, Local5)
                    If (LEqual (Local5, 0x00))
                    {
                        Decrement (Local1)
                        Sleep (0x012C)
                        \_SB.Z000 (0x8E)
                    }
                    Else
                    {
                        Store (0x00, Local1)
                    }
                }

                Store (Local5, Index (PBIF, 0x02))
                Store (0x0E10, Index (PBIF, 0x01))
                Store (0x39D0, Index (PBIF, 0x04))
                Store ("HQL4", Index (PBIF, 0x09))
                Store ("LION", Index (PBIF, 0x0B))
                Store ("SANYO", Index (PBIF, 0x0C))
            }

            Method (UPBS, 0, NotSerialized)
            {
                Acquire (MMTX, 0xFFFF)
                Store (MBRM, Local2)
                Store (MBVT, Local3)
                Store (0x00, Local0)
                If (LEqual (MBTC, 0x01))
                {
                    Or (0x02, Local0, Local0)
                }

                If (LEqual (MBTD, 0x01))
                {
                    Or (0x01, Local0, Local0)
                }

                Release (MMTX)
                Store (SizeOf (\_OS), Local7)
                If (Or (Or (LEqual (Local7, 0x14), LEqual (Local7, 0x11)), LEqual (Local7, 0x27)))
                {
                    Store (0xFFFFFFFF, Index (PBST, 0x01))
                }
                Else
                {
                    \_SB.Z000 (0x92)
                    Store (BCRN, Index (PBST, 0x01))
                }

                Store (Local2, Index (PBST, 0x02))
                Store (Local3, Index (PBST, 0x03))
                Store ("Bat1 remaining cap", Debug)
                Store (Local2, Debug)
                Store (Local0, Index (PBST, 0x00))
            }

            Method (IVBI, 0, NotSerialized)
            {
                Store (0xFFFFFFFF, Index (PBIF, 0x01))
                Store (0xFFFFFFFF, Index (PBIF, 0x02))
                Store (0xFFFFFFFF, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("      ", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
            }

            Method (IVBS, 0, NotSerialized)
            {
                Store (0x00, Index (PBST, 0x00))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (0xFFFFFFFF, Index (PBST, 0x02))
                Store (0x2710, Index (PBST, 0x03))
            }
        }

        Device (BAT2)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x02)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (BFST, 0x00)
            Name (FBST, 0x01)
            Mutex (AMTX, 0x00)
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0xFA, 
                0x64, 
                0x0A, 
                0x19, 
                "BAT1", 
                " ", 
                " ", 
                " "
            })
            Name (PBST, Package (0x04)
            {
                0x00, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x2710
            })
            Method (_STA, 0, NotSerialized)
            {
                Store (0x0F, Local0)
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (Local0)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.AFLG)
                    {
                        \_SB.Z000 (0x96)
                        Store (SBTS, \_SB.SBT0)
                        Sleep (0x32)
                        Store (Zero, \_SB.AFLG)
                    }

                    If (\_SB.SBT0)
                    {
                        Store (0x1F, Local0)
                    }

                    If (LNot (BFST))
                    {
                        Store (0x01, BFST)
                        And (\_SB.PCI0.PIB.EC0.BATO, 0xFFFD, \_SB.PCI0.PIB.EC0.BATO)
                        If (LEqual (Local0, 0x1F))
                        {
                            Or (\_SB.PCI0.PIB.EC0.BATO, 0x02, \_SB.PCI0.PIB.EC0.BATO)
                        }
                    }
                }

                Return (Local0)
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (PBIF)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.SBT0)
                    {
                        \_SB.Z000 (0x94)
                        UPBI ()
                    }
                    Else
                    {
                        IVBI ()
                    }
                }

                Return (PBIF)
            }

            Method (_BST, 0, NotSerialized)
            {
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (PBST)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.SBT0)
                    {
                        If (FBST)
                        {
                            \_SB.Z000 (0x95)
                            Store (0x00, FBST)
                        }

                        UPBS ()
                    }
                    Else
                    {
                        IVBS ()
                    }
                }

                Return (PBST)
            }

            Method (UPBI, 0, NotSerialized)
            {
                Store (0x1E, Local1)
                While (LGreater (Local1, 0x01))
                {
                    Store (AFCC, Local5)
                    If (LEqual (Local5, 0x00))
                    {
                        Decrement (Local1)
                        Sleep (0x012C)
                        \_SB.Z000 (0x94)
                    }
                    Else
                    {
                        Store (0x00, Local1)
                    }
                }

                Store (Local5, Index (PBIF, 0x02))
                Store (0x0C1C, Index (PBIF, 0x01))
                Store (0x2B5C, Index (PBIF, 0x04))
                Store ("HQL3", Index (PBIF, 0x09))
                Store ("LION", Index (PBIF, 0x0B))
                Store ("SANYO", Index (PBIF, 0x0C))
            }

            Method (UPBS, 0, NotSerialized)
            {
                Acquire (AMTX, 0xFFFF)
                Store (ABRM, Local2)
                Store (ABVT, Local3)
                Store (0x00, Local0)
                If (LEqual (ABTC, 0x01))
                {
                    Store ("--Power State as charging", Debug)
                    Or (0x02, Local0, Local0)
                }

                If (LEqual (ABTD, 0x01))
                {
                    Store ("---Power State as discharging", Debug)
                    Or (0x01, Local0, Local0)
                }

                Release (AMTX)
                Store (SizeOf (\_OS), Local7)
                If (Or (Or (LEqual (Local7, 0x14), LEqual (Local7, 0x11)), LEqual (Local7, 0x27)))
                {
                    Store (0xFFFFFFFF, Index (PBST, 0x01))
                }
                Else
                {
                    \_SB.Z000 (0x92)
                    Store (BCRN, Index (PBST, 0x01))
                }

                Store (Local2, Index (PBST, 0x02))
                Store (Local3, Index (PBST, 0x03))
                Store ("Bat2 Remaining cap", Debug)
                Store (Local2, Debug)
                Store (Local0, Index (PBST, 0x00))
            }

            Method (IVBI, 0, NotSerialized)
            {
                Store (0xFFFFFFFF, Index (PBIF, 0x01))
                Store (0xFFFFFFFF, Index (PBIF, 0x02))
                Store (0xFFFFFFFF, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("      ", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
            }

            Method (IVBS, 0, NotSerialized)
            {
                Store (0x00, Index (PBST, 0x00))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (0xFFFFFFFF, Index (PBST, 0x02))
                Store (0x2710, Index (PBST, 0x03))
            }
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_LID, 0, NotSerialized)
            {
                Return (\_SB.PCI0.PM.LPOL)
            }

            Name (_PRW, Package (0x02)
            {
                0x0B, 
                0x01
            })
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            Name (_PRW, Package (0x02)
            {
                0x05, 
                0x01
            })
            OperationRegion (FDMA, SystemIO, 0x08, 0x02)
            Field (FDMA, ByteAcc, NoLock, Preserve)
            {
                DMCX,   4, 
                DMAR,   4
            }

            OperationRegion (NB00, PCI_Config, 0x00, 0x0100)
            Field (NB00, ByteAcc, NoLock, Preserve)
            {
                Offset (0x5F), 
                EADD,   8, 
                Offset (0xF0), 
                TMR0,   8, 
                SDCS,   8, 
                CRTS,   1, 
                ACON,   1, 
                GWEN,   1, 
                SBT1,   1, 
                MBT1,   1, 
                QTMR,   1, 
                Offset (0xF3), 
                QFDD,   1, 
                Offset (0xFB), 
                    ,   4, 
                FBSZ,   2, 
                    ,   1, 
                Offset (0xFC)
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }

            Method (_INI, 0, NotSerialized)
            {
                Store (Zero, \_SB.PCI0.GWEN)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    Store (0x28, \_SB.PCI0.TMR0)
                    \_SB.Z000 (0x8D)
                }
            }

            Name (CRES, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000, // Address Space Granularity
                    0x0000, // Address Range Minimum
                    0x00FF, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x0100,,,)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000, // Address Space Granularity
                    0x0000, // Address Range Minimum
                    0x0CF7, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x0CF8,,,
                    , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000, // Address Space Granularity
                    0x0D00, // Address Range Minimum
                    0xFFFF, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0xF300,,,
                    , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000A0000, // Address Range Minimum
                    0x000BFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00020000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000C8000, // Address Range Minimum
                    0x000DFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00018000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x02000000, // Address Range Minimum
                    0xFFDFFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0xFDE00000,,,
                    , AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (CRES, 0x76, RAMT)
                CreateDWordField (CRES, 0x82, RAMR)
                Store (\_SB.PCI0.FBSZ, Local0)
                If (LEqual (Local0, 0x01))
                {
                    Store (0x00200000, Local0)
                }
                Else
                {
                    If (LEqual (Local0, 0x02))
                    {
                        Store (0x00400000, Local0)
                    }
                    Else
                    {
                        If (LEqual (Local0, 0x03))
                        {
                            Store (0x00800000, Local0)
                        }
                        Else
                        {
                            Store (0x00, Local0)
                        }
                    }
                }

                Multiply (\_SB.PCI0.EADD, 0x00800000, Local1)
                Subtract (Local1, Local0, RAMT)
                Subtract (0xFFE00000, RAMT, RAMR)
                Return (CRES)
            }

            Name (_PRT, Package (0x08)
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
                    0x0007FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x02, 
                    \_SB.PCI0.PIB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x03, 
                    \_SB.PCI0.PIB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.LNKC, 
                    0x00
                }
            })
            Device (AGP)
            {
                Name (_ADR, 0x00010000)
                Device (VGA)
                {
                    Name (_ADR, 0x00)
                    Name (DOSA, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (_PS0, 0, NotSerialized)
                    {
                        Store ("VGA in D0", Debug)
                        If (\_SB.SSVW)
                        {
                            Store (One, \_SB.PCI0.AGP.VGA.VW01)
                            Store (Zero, \_SB.SSVW)
                            Sleep (0x64)
                            Store (\_SB.PCI0.AGP.VGA.VW01, Debug)
                        }

                        Notify (\_SB.PCI0.AGP.VGA, 0x00)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.AGP.VGA.VW01, Local0)
                        Store ("VGA in D3", Debug)
                        Store (Local0, Debug)
                        Store (Local0, \_SB.SSVW)
                    }

                    OperationRegion (CBI1, SystemIO, 0x03D4, 0x02)
                    Field (CBI1, ByteAcc, NoLock, Preserve)
                    {
                        VIDX,   8, 
                        VDAT,   8
                    }

                    IndexField (VIDX, VDAT, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x8E), 
                            ,   4, 
                        VW01,   1, 
                        Offset (0x8F)
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        \_SB.Z000 (0x88)
                        \_SB.Z000 (0x86)
                        XVCH ()
                        EDGS ()
                    }

                    Method (XVCH, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.SDCS, Local0)
                        Store (Local0, Local1)
                        And (Local1, 0x01, Local1)
                        ShiftLeft (Local1, 0x01, Local1)
                        And (^LCD._DCS, 0xFFFFFFFD, ^LCD._DCS)
                        Or (^LCD._DCS, Local1, ^LCD._DCS)
                        Store (Local0, Local1)
                        And (Local1, 0x02, Local1)
                        And (^CRT._DCS, 0xFFFFFFFD, ^CRT._DCS)
                        Or (^CRT._DCS, Local1, ^CRT._DCS)
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (Arg0, DOSA)
                    }

                    Name (LDCS, 0x00)
                    Name (CDCS, 0x00)
                    Method (DRUU, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            \_SB.Z000 (0x86)
                            Store (0x00, ^LCD._DGS)
                            Store (0x01, ^CRT._DGS)
                            Notify (VGA, 0x80)
                        }
                        Else
                        {
                            Store (\_SB.PCI0.SDCS, Local0)
                            Store (Local0, Local1)
                            And (Local1, 0x01, Local1)
                            And (^LCD._DGS, 0xFFFFFFFE, ^LCD._DGS)
                            Or (^LCD._DGS, Local1, ^LCD._DGS)
                            ShiftLeft (Local1, 0x01, Local1)
                            And (^LCD._DCS, 0xFFFFFFFD, ^LCD._DCS)
                            Or (^LCD._DCS, Local1, ^LCD._DCS)
                            Store (Local0, Local1)
                            And (Local1, 0x02, Local1)
                            And (^CRT._DCS, 0xFFFFFFFD, ^CRT._DCS)
                            Or (^CRT._DCS, Local1, ^CRT._DCS)
                            ShiftRight (Local1, 0x01, Local1)
                            And (^CRT._DGS, 0xFFFFFFFE, ^CRT._DGS)
                            Or (^CRT._DGS, Local1, ^CRT._DGS)
                            Notify (VGA, 0x80)
                        }
                    }

                    Method (EDGS, 0, NotSerialized)
                    {
                        If (And (^LCD._DCS, 0x02))
                        {
                            If (And (^CRT._DCS, 0x02))
                            {
                                Store (0x00, ^LCD._DGS)
                                Store (0x01, ^CRT._DGS)
                            }
                            Else
                            {
                                Store (0x01, ^LCD._DGS)
                                Store (0x01, ^CRT._DGS)
                            }
                        }
                        Else
                        {
                            Store (0x01, ^LCD._DGS)
                            Store (0x00, ^CRT._DGS)
                        }
                    }

                    Method (USTS, 0, NotSerialized)
                    {
                        And (^LCD._DCS, 0xFFFFFFFD, ^LCD._DCS)
                        Or (^LCD._DCS, ShiftLeft (LDCS, 0x01), ^LCD._DCS)
                        And (^CRT._DCS, 0xFFFFFFFD, ^CRT._DCS)
                        If (And (CDCS, 0x01))
                        {
                            If (LEqual (\_SB.PCI0.CRTS, 0x01))
                            {
                                Or (^CRT._DCS, 0x02, ^CRT._DCS)
                            }
                        }

                        EDGS ()
                    }

                    Method (SWIT, 0, NotSerialized)
                    {
                        USTS ()
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x02)
                        {
                            0x00010100, 
                            0x00010110
                        })
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Name (_DCS, 0x1F)
                        Name (_DGS, 0x00)
                        Method (_DSS, 1, NotSerialized)
                        {
                            If (And (Arg0, 0x40000000))
                            {
                                And (Arg0, 0x01, LDCS)
                                If (And (Arg0, 0x80000000))
                                {
                                    ^^USTS ()
                                }
                            }
                            Else
                            {
                                And (Arg0, 0x01, LDCS)
                                If (And (Arg0, 0x80000000))
                                {
                                    ^^SWIT ()
                                }
                            }
                        }
                    }

                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Name (_DGS, 0x00)
                        Name (_DCS, 0x0F)
                        Method (_DSS, 1, NotSerialized)
                        {
                            If (And (Arg0, 0x40000000))
                            {
                                And (Arg0, 0x01, CDCS)
                                If (And (Arg0, 0x80000000))
                                {
                                    ^^USTS ()
                                }
                            }
                            Else
                            {
                                And (Arg0, 0x01, CDCS)
                                If (And (Arg0, 0x80000000))
                                {
                                    ^^SWIT ()
                                }
                            }
                        }
                    }
                }
            }

            Device (PIB)
            {
                Name (_ADR, 0x00070000)
                OperationRegion (IRQR, PCI_Config, 0x00, 0x88)
                Field (IRQR, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x48), 
                        ,   2, 
                    EUSB,   1, 
                    Offset (0x50), 
                    FDDA,   2, 
                    LPDA,   2, 
                    Offset (0x51), 
                    FDIQ,   4, 
                    LPIQ,   4, 
                    SAIQ,   4, 
                    SBIQ,   4, 
                    Offset (0x55), 
                        ,   4, 
                    PIRA,   4, 
                    PIRB,   4, 
                    PIRC,   4, 
                        ,   4, 
                    PIRD,   4, 
                    Offset (0x81), 
                    PDC1,   8, 
                    PDC2,   8, 
                    PDC3,   8, 
                    PDC4,   8, 
                        ,   2, 
                    EXFA,   1, 
                    EXFM,   1, 
                    ESB1,   1
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
                            Memory32Fixed (ReadOnly, 0x000DC000, 0x00004000)
                            Memory32Fixed (ReadOnly, 0x000E0000, 0x00020000)
                            Memory32Fixed (ReadOnly, 0xFFFE0000, 0x00020000)
                        })
                        Return (SMEM)
                    }
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x00A8, 0x00A8, 0x01, 0x02)
                        IO (Decode16, 0x0220, 0x0220, 0x01, 0x10)
                        IO (Decode16, 0x0388, 0x0388, 0x01, 0x04)
                        IO (Decode16, 0x8000, 0x8000, 0x01, 0x90)
                        IO (Decode16, 0x9050, 0x9050, 0x01, 0x02)
                        IO (Decode16, 0x6800, 0x6800, 0x01, 0x80)
                        IO (Decode16, 0x0370, 0x0370, 0x01, 0x02)
                    })
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

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {9,10,12}
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
                        IRQ (Level, ActiveLow, Shared) {9,10,12}
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
                        IRQ (Level, ActiveLow, Shared) {9,10,12}
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
                        IRQ (Level, ActiveLow, Shared) {9,10,12}
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

                OperationRegion (SMC1, SystemIO, 0x0370, 0x02)
                Field (SMC1, ByteAcc, NoLock, Preserve)
                {
                    INDX,   8, 
                    DATA,   8
                }

                Method (ENFG, 0, NotSerialized)
                {
                    Store (0x55, INDX)
                }

                Method (EXFG, 0, NotSerialized)
                {
                    Store (0xAA, INDX)
                }

                Device (UAR1)
                {
                    Name (_HID, EisaId ("PNP0501"))
                    Name (_UID, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x24, INDX)
                        Store (DATA, Local0)
                        Store (0x28, INDX)
                        Store (DATA, Local1)
                        And (Local1, 0xF0, Local1)
                        If (LNot (LEqual (Local1, 0x00)))
                        {
                            If (LNot (LEqual (Local0, 0x00)))
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
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF1, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            IRQNoFlags () {}
                        })
                        CreateByteField (BUF1, 0x02, IOLO)
                        CreateByteField (BUF1, 0x03, IOHI)
                        CreateByteField (BUF1, 0x04, IORL)
                        CreateByteField (BUF1, 0x05, IORH)
                        CreateWordField (BUF1, 0x09, IRQL)
                        ENFG ()
                        Store (0x24, INDX)
                        Store (DATA, Local0)
                        If (LEqual (Local0, 0xFE))
                        {
                            Store (0xF8, IOLO)
                            Store (0xF8, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                        }

                        If (LEqual (Local0, 0xBE))
                        {
                            Store (0xF8, IOLO)
                            Store (0xF8, IORL)
                            Store (0x02, IOHI)
                            Store (0x02, IORH)
                        }

                        If (LEqual (Local0, 0xFA))
                        {
                            Store (0xE8, IOLO)
                            Store (0xE8, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                        }

                        If (LEqual (Local0, 0xBA))
                        {
                            Store (0xE8, IOLO)
                            Store (0xE8, IORL)
                            Store (0x02, IOHI)
                            Store (0x02, IORH)
                        }

                        Store (0x28, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        ShiftRight (Local0, 0x04, Local0)
                        Store (0x01, IRQL)
                        ShiftLeft (IRQL, Local0, IRQL)
                        EXFG ()
                        Return (BUF1)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x00, 0x08)
                            IRQNoFlags () {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x00, 0x08)
                            IRQNoFlags () {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x00, 0x08)
                            IRQNoFlags () {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x00, 0x08)
                            IRQNoFlags () {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateWordField (Arg0, 0x09, IRQL)
                        ENFG ()
                        If (LEqual (IOLO, 0xF8))
                        {
                            If (LEqual (IOHI, 0x03))
                            {
                                Store (0xFE, Local0)
                            }
                            Else
                            {
                                Store (0xBE, Local0)
                            }
                        }
                        Else
                        {
                            If (LEqual (IOHI, 0x03))
                            {
                                Store (0xFA, Local0)
                            }
                            Else
                            {
                                Store (0xBA, Local0)
                            }
                        }

                        Store (0x24, INDX)
                        Store (Local0, DATA)
                        Store (0x28, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        If (LEqual (IRQL, 0x00))
                        {
                            Store (0x00, Local1)
                        }
                        Else
                        {
                            FindSetRightBit (IRQL, Local1)
                            Subtract (Local1, 0x01, Local1)
                        }

                        ShiftLeft (Local1, 0x04, Local1)
                        Or (Local1, Local0, Local0)
                        Store (0x28, INDX)
                        Store (Local0, DATA)
                        EXFG ()
                    }

                    Name (_PRW, Package (0x02)
                    {
                        0x08, 
                        0x04
                    })
                }

                Device (FRIO)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x02)
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x02, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x80, Local0)
                        Store (0x2B, INDX)
                        Store (DATA, Local1)
                        Store (0x2C, INDX)
                        And (DATA, 0x0F, Local2)
                        If (LEqual (Local0, 0x80))
                        {
                            If (LNot (LEqual (Local2, 0x0F)))
                            {
                                If (LNot (LEqual (Local1, 0x00)))
                                {
                                    EXFG ()
                                    Return (0x0F)
                                }
                                Else
                                {
                                    EXFG ()
                                    Return (0x00)
                                }
                            }
                            Else
                            {
                                EXFG ()
                                Return (0x00)
                            }
                        }
                        Else
                        {
                            EXFG ()
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0958, 0x0958, 0x01, 0x08)
                    })
                }

                Device (FIR)
                {
                    Name (_HID, EisaId ("SMCF010"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x0C, INDX)
                        Store (0x0E, DATA)
                        Store (0x0A, INDX)
                        Store (0x40, DATA)
                        Store (0x02, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x80, Local0)
                        Store (0x2C, INDX)
                        Store (DATA, Local1)
                        And (Local1, 0x0F, Local1)
                        Store (0x25, INDX)
                        Store (DATA, Local3)
                        If (LEqual (Local0, 0x80))
                        {
                            If (LNot (LEqual (Local1, 0x0F)))
                            {
                                If (LNot (LEqual (Local3, 0x00)))
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
                                Return (0x00)
                            }
                        }
                        Else
                        {
                            EXFG ()
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            Store ("Win2000 FIR", Debug)
                        }
                        Else
                        {
                            ENFG ()
                            Store (0x25, INDX)
                            Store (0x00, DATA)
                            Store (0x2B, INDX)
                            Store (0x00, DATA)
                            EXFG ()
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF2, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            IRQNoFlags () {}
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            DMA (Compatibility, NotBusMaster, Transfer8) {0,1}
                        })
                        CreateByteField (BUF2, 0x02, IOLL)
                        CreateByteField (BUF2, 0x03, IOLH)
                        CreateByteField (BUF2, 0x04, IOHL)
                        CreateByteField (BUF2, 0x05, IOHH)
                        CreateByteField (BUF2, 0x0D, IRC1)
                        CreateByteField (BUF2, 0x0E, IRC2)
                        CreateByteField (BUF2, 0x0F, IRC3)
                        CreateByteField (BUF2, 0x10, IRC4)
                        CreateWordField (BUF2, 0x09, IRQL)
                        CreateByteField (BUF2, 0x14, DMAC)
                        ENFG ()
                        Store (0x25, INDX)
                        Store (DATA, Local0)
                        ShiftLeft (Local0, 0x02, Local0)
                        Store (Local0, Local1)
                        And (Local0, 0xFF, Local0)
                        ShiftRight (Local1, 0x08, Local1)
                        Store (Local0, IOLL)
                        Store (Local0, IOHL)
                        Store (Local1, IOLH)
                        Store (Local1, IOHH)
                        Store (0x2B, INDX)
                        Store (DATA, Local0)
                        If (LEqual (Local0, 0x2B))
                        {
                            Store (0x58, IRC1)
                            Store (0x58, IRC3)
                            Store (0x01, IRC2)
                            Store (0x01, IRC4)
                        }

                        If (LEqual (Local0, 0x2C))
                        {
                            Store (0x60, IRC1)
                            Store (0x60, IRC3)
                            Store (0x01, IRC2)
                            Store (0x01, IRC4)
                        }

                        If (LEqual (Local0, 0x2D))
                        {
                            Store (0x68, IRC1)
                            Store (0x68, IRC3)
                            Store (0x01, IRC2)
                            Store (0x01, IRC4)
                        }

                        Store (0x2C, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Store (0x02, DMAC)
                        }

                        If (LEqual (Local0, 0x02))
                        {
                            Store (0x08, DMAC)
                        }

                        If (LEqual (Local0, 0x03))
                        {
                            Store (0x01, DMAC)
                        }

                        Store (0x28, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        Store (0x01, IRQL)
                        ShiftLeft (IRQL, Local0, IRQL)
                        EXFG ()
                        Return (BUF2)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x00, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x00, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x00, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x00, 0x08)
                        }
                        EndDependentFn ()
                        IRQNoFlags () {3,4}
                        IO (Decode16, 0x0158, 0x016F, 0x08, 0x08)
                        DMA (Compatibility, NotBusMaster, InvalidSize) {1,3}
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x02, IOLP)
                        CreateWordField (Arg0, 0x0D, IRPO)
                        CreateWordField (Arg0, 0x09, IRQL)
                        CreateByteField (Arg0, 0x14, DMAC)
                        ENFG ()
                        Store (0x02, INDX)
                        Store (DATA, Local0)
                        Store (0x02, INDX)
                        Or (Local0, 0x80, DATA)
                        Store (0x25, INDX)
                        ShiftRight (IOLP, 0x02, DATA)
                        Store (0x2B, INDX)
                        ShiftRight (IRPO, 0x03, DATA)
                        Store (0x2C, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        If (LEqual (DMAC, 0x01))
                        {
                            Or (Local0, 0x03, Local0)
                        }

                        If (LEqual (DMAC, 0x02))
                        {
                            Or (Local0, 0x00, Local0)
                        }

                        If (LEqual (DMAC, 0x08))
                        {
                            Or (Local0, 0x02, Local0)
                        }

                        Store (0x2C, INDX)
                        Store (Local0, DATA)
                        Store (0x28, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        FindSetRightBit (IRQL, Local1)
                        Subtract (Local1, 0x01, Local1)
                        Or (Local1, Local0, Local0)
                        Store (0x28, INDX)
                        Store (Local0, DATA)
                        EXFG ()
                    }
                }

                Device (LPT1)
                {
                    Name (_HID, EisaId ("PNP0400"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x04, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x02, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Store (0x23, INDX)
                            Store (DATA, Local0)
                            Store (0x01, INDX)
                            Store (DATA, Local1)
                            And (Local1, 0x04, Local1)
                            If (LNot (LEqual (Local1, 0x00)))
                            {
                                If (LNot (LEqual (Local0, 0x00)))
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
                                Return (0x00)
                            }
                        }
                        Else
                        {
                            EXFG ()
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x23, INDX)
                        Store (0x00, DATA)
                        EXFG ()
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF4, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            IRQNoFlags () {}
                        })
                        CreateByteField (BUF4, 0x02, IOLO)
                        CreateByteField (BUF4, 0x03, IOHI)
                        CreateByteField (BUF4, 0x04, IORL)
                        CreateByteField (BUF4, 0x05, IORH)
                        CreateByteField (BUF4, 0x07, IOLN)
                        CreateWordField (BUF4, 0x09, IRQL)
                        ENFG ()
                        Store (0x23, INDX)
                        Store (DATA, Local0)
                        If (LEqual (Local0, 0xDE))
                        {
                            Store (0x78, IOLO)
                            Store (0x78, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                            Store (0x08, IOLN)
                        }

                        If (LEqual (Local0, 0x9E))
                        {
                            Store (0x78, IOLO)
                            Store (0x78, IORL)
                            Store (0x02, IOHI)
                            Store (0x02, IORH)
                            Store (0x08, IOLN)
                        }

                        If (LEqual (Local0, 0xEF))
                        {
                            Store (0xBC, IOLO)
                            Store (0xBC, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                            Store (0x04, IOLN)
                        }

                        Store (0x27, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        If (LNot (LEqual (Local0, 0x00)))
                        {
                            Store (0x01, IRQL)
                            ShiftLeft (IRQL, Local0, IRQL)
                        }
                        Else
                        {
                            Store (Local0, IRQL)
                        }

                        EXFG ()
                        Return (BUF4)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                            IRQNoFlags () {5,7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                            IRQNoFlags () {5,7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x00, 0x04)
                            IRQNoFlags () {5,7}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateWordField (Arg0, 0x09, IRQL)
                        ENFG ()
                        If (LEqual (IOLO, 0xBC))
                        {
                            Store (0xEF, Local0)
                        }
                        Else
                        {
                            If (LEqual (IOHI, 0x03))
                            {
                                Store (0xDE, Local0)
                            }
                            Else
                            {
                                If (LEqual (IOHI, 0x02))
                                {
                                    Store (0x9E, Local0)
                                }
                                Else
                                {
                                    Store (0x00, Local0)
                                }
                            }
                        }

                        If (LNot (LEqual (Local0, 0x00)))
                        {
                            Store (0x23, INDX)
                            Store (Local0, DATA)
                        }

                        Store (0x27, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        If (LEqual (IRQL, 0x00))
                        {
                            Store (0x00, Local1)
                        }
                        Else
                        {
                            FindSetRightBit (IRQL, Local1)
                            Subtract (Local1, 0x01, Local1)
                        }

                        Or (Local1, Local0, Local0)
                        Store (0x27, INDX)
                        Store (Local0, DATA)
                        EXFG ()
                    }
                }

                Device (ECP1)
                {
                    Name (_HID, EisaId ("PNP0401"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x04, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x02, Local0)
                        If (LEqual (Local0, 0x02))
                        {
                            Store (0x23, INDX)
                            Store (DATA, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
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
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x23, INDX)
                        Store (0x00, DATA)
                        EXFG ()
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF6, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x04)
                            IRQNoFlags () {}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                        })
                        CreateByteField (BUF6, 0x02, IOLO)
                        CreateByteField (BUF6, 0x03, IOHI)
                        CreateByteField (BUF6, 0x04, IORL)
                        CreateByteField (BUF6, 0x05, IORH)
                        CreateByteField (BUF6, 0x07, IOLN)
                        CreateByteField (BUF6, 0x0A, IOEL)
                        CreateByteField (BUF6, 0x0B, IOEH)
                        CreateByteField (BUF6, 0x0C, IOML)
                        CreateByteField (BUF6, 0x0D, IOMH)
                        CreateByteField (BUF6, 0x0F, IOHN)
                        CreateWordField (BUF6, 0x11, IRQL)
                        CreateByteField (BUF6, 0x14, DMAC)
                        ENFG ()
                        Store (0x23, INDX)
                        Store (DATA, Local0)
                        If (LEqual (Local0, 0xDE))
                        {
                            Store (0x78, IOLO)
                            Store (0x78, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                            Store (0x08, IOLN)
                        }

                        If (LEqual (Local0, 0x9E))
                        {
                            Store (0x78, IOLO)
                            Store (0x78, IORL)
                            Store (0x02, IOHI)
                            Store (0x02, IORH)
                            Store (0x08, IOLN)
                        }

                        If (LEqual (Local0, 0xEF))
                        {
                            Store (0xBC, IOLO)
                            Store (0xBC, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                            Store (0x04, IOLN)
                        }

                        Store (IOLO, IOEL)
                        Store (IOLO, IOML)
                        Or (IOHI, 0x04, IOEH)
                        Or (IOHI, 0x04, IOMH)
                        Store (0x27, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        Store (0x01, IRQL)
                        ShiftLeft (IRQL, Local0, IRQL)
                        Store (0x26, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Store (0x02, DMAC)
                        }

                        If (LEqual (Local0, 0x02))
                        {
                            Store (0x08, DMAC)
                        }

                        If (LEqual (Local0, 0x03))
                        {
                            Store (0x01, DMAC)
                        }

                        EXFG ()
                        Return (BUF6)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                            IO (Decode16, 0x0778, 0x0778, 0x00, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                            IO (Decode16, 0x0678, 0x0678, 0x00, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x00, 0x04)
                            IO (Decode16, 0x07BC, 0x07BC, 0x00, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateByteField (Arg0, 0x14, DMAC)
                        CreateWordField (Arg0, 0x11, IRQL)
                        ENFG ()
                        If (LEqual (IOLO, 0xBC))
                        {
                            Store (0xEF, Local0)
                        }
                        Else
                        {
                            If (LEqual (IOHI, 0x03))
                            {
                                Store (0xDE, Local0)
                            }
                            Else
                            {
                                Store (0x9E, Local0)
                            }
                        }

                        Store (0x23, INDX)
                        Store (Local0, DATA)
                        Store (0x27, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        If (LEqual (IRQL, 0x00))
                        {
                            Store (0x00, Local1)
                        }
                        Else
                        {
                            FindSetRightBit (IRQL, Local1)
                            Subtract (Local1, 0x01, Local1)
                        }

                        Or (Local1, Local0, Local0)
                        Store (0x27, INDX)
                        Store (Local0, DATA)
                        Store (0x26, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        If (LEqual (DMAC, 0x01))
                        {
                            Or (Local0, 0x03, Local0)
                        }

                        If (LEqual (DMAC, 0x02))
                        {
                            Or (Local0, 0x00, Local0)
                        }

                        If (LEqual (DMAC, 0x08))
                        {
                            Or (Local0, 0x02, Local0)
                        }

                        Store (0x26, INDX)
                        Store (Local0, DATA)
                        EXFG ()
                    }
                }

                Device (FDC0)
                {
                    OperationRegion (LS12, SystemMemory, 0x04EA, 0x01)
                    Field (LS12, ByteAcc, NoLock, Preserve)
                    {
                            ,   2, 
                        LSON,   1
                    }

                    Name (_HID, EisaId ("PNP0700"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x20, INDX)
                        Store (DATA, Local0)
                        If (LNot (LEqual (Local0, 0x00)))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            If (LSON)
                            {
                                Return (0x00)
                            }
                            Else
                            {
                                Return (0x0D)
                            }

                            Return (0x0D)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x20, INDX)
                        Store (0x00, DATA)
                        EXFG ()
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x04)
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x01)
                            IRQNoFlags () {}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                        })
                        CreateByteField (BUF0, 0x02, IOLO)
                        CreateByteField (BUF0, 0x03, IOHI)
                        CreateByteField (BUF0, 0x04, IORL)
                        CreateByteField (BUF0, 0x05, IORH)
                        CreateByteField (BUF0, 0x0A, ILO1)
                        CreateByteField (BUF0, 0x0B, IHI1)
                        CreateByteField (BUF0, 0x0C, IRL1)
                        CreateByteField (BUF0, 0x0D, IRH1)
                        CreateByteField (BUF0, 0x11, IRQL)
                        CreateByteField (BUF0, 0x14, DMAV)
                        Store (0xF2, IOLO)
                        Store (0xF2, IORL)
                        Store (0x03, IOHI)
                        Store (0x03, IORH)
                        Store (0xF7, ILO1)
                        Store (0xF7, IRL1)
                        Store (0x03, IHI1)
                        Store (0x03, IRH1)
                        ShiftLeft (0x01, 0x06, IRQL)
                        ShiftLeft (0x01, 0x02, DMAV)
                        Return (BUF0)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03F2, 0x03F2, 0x00, 0x04)
                            IO (Decode16, 0x03F7, 0x03F7, 0x00, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateWordField (Arg0, 0x11, IRQL)
                        CreateByteField (Arg0, 0x14, DMAV)
                        ENFG ()
                        Store (0x20, INDX)
                        Store (0xFC, DATA)
                        EXFG ()
                    }

                    Name (BUF, Buffer (0x14)
                    {
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                        0x00, 0x00, 0x00, 0x00
                    })
                    Method (_FDE, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.PIB.FDC0.FDDA._STA (), Local0)
                        If (LEqual (Local0, 0x0F))
                        {
                            Store (Ones, Local0)
                        }
                        Else
                        {
                            Store (Zero, Local0)
                        }

                        CreateDWordField (BUF, 0x00, DRV0)
                        Store (Local0, DRV0)
                        Return (BUF)
                    }

                    Device (FDDA)
                    {
                        Name (_ADR, Zero)
                        Name (_RMV, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LNot (\_SB.PCI0.QFDD))
                            {
                                Return (0x08)
                            }

                            If (\_SB.PCI0.PM.PNFI)
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                If (LEqual (\_SB.PCI0.PM.BAYD, 0x00))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (0x08)
                                }
                            }
                        }

                        Name (D0IN, Package (0x10)
                        {
                            0x00, 
                            0x04, 
                            0x4F, 
                            0x12, 
                            0x01, 
                            0xAF, 
                            0x02, 
                            0x25, 
                            0x02, 
                            0x12, 
                            0x1B, 
                            0xFF, 
                            0x6C, 
                            0xF6, 
                            0x0F, 
                            0x05
                        })
                        Method (_FDI, 0, NotSerialized)
                        {
                            Return (D0IN)
                        }
                    }
                }

                Scope (_SB)
                {
                    Name (OKEC, 0x00)
                    Name (DFEC, 0x00)
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x01)
                    Name (BRIN, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store ("EC in _PS0 Status", Debug)
                        Store (0x00, \_SB.DFEC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x01, \_SB.DFEC)
                        Store ("EC in _PS3 Status", Debug)
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, \_SB.OKEC)
                        }
                    }

                    Name (FQSB, 0x00)
                    Name (FBAT, 0x00)
                    Name (FTMP, 0x00)
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
                        SMD0,   264, 
                        SMAA,   8, 
                        BATD,   16, 
                        ACDF,   1, 
                        Offset (0x45), 
                        LDP0,   1, 
                        Offset (0x47), 
                        LDP1,   1, 
                        Offset (0x49), 
                        LIDS,   1, 
                        Offset (0x4C), 
                        MBTS,   1, 
                        MBTF,   1, 
                            ,   4, 
                        MBTD,   1, 
                        Offset (0x4D), 
                        SBTS,   1, 
                        SBTF,   1, 
                            ,   4, 
                        SBTD,   1, 
                        Offset (0x4F), 
                        MBTC,   1, 
                        Offset (0x50), 
                        SBTC,   1, 
                        Offset (0x53), 
                        TMSS,   2, 
                            ,   2, 
                        BANK,   4, 
                        Offset (0x67), 
                        WEVN,   8, 
                        TMP,    8, 
                        Offset (0x80), 
                        CTMP,   8, 
                        Offset (0x83), 
                        STMP,   8, 
                        Offset (0x96), 
                        RG96,   16, 
                        Offset (0x9C), 
                        RG9C,   16, 
                        Offset (0xA1), 
                        PTIM,   8, 
                        Offset (0xA8), 
                        RGA8,   8, 
                        Offset (0xB9), 
                        ARMB,   2, 
                        Offset (0xC0), 
                        MBRM,   16, 
                        MFCC,   16, 
                        BCRN,   16, 
                        ABRM,   16, 
                        AFCC,   16, 
                        Offset (0xE4), 
                        LWP0,   1, 
                        Offset (0xE6), 
                        LWP1,   1, 
                        Offset (0xE8), 
                        LIDE,   1, 
                        BAYE,   1, 
                        EFDE,   1, 
                        PRDE,   1
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
                        Offset (0x40), 
                        ACIN,   1, 
                        Offset (0x4C), 
                        BATS,   16, 
                        Offset (0x4F), 
                        BATC,   16
                    }

                    Method (SMRD, 4, NotSerialized)
                    {
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

                        Acquire (BNKM, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
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
                                Store (SMD0, Arg3)
                            }
                        }

                        Release (BNKM)
                        Return (Local0)
                    }

                    Method (SMWR, 4, NotSerialized)
                    {
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

                        Acquire (BNKM, 0xFFFF)
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
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
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

                        Release (BNKM)
                        Return (Local0)
                    }

                    Mutex (BNKM, 0x00)
                    Name (EVNT, 0x00)
                    Name (BATN, 0x00)
                    Name (ACEV, 0x00)
                    Name (MBIE, 0x00)
                    Name (ABIE, 0x00)
                    Name (BATO, 0x00)
                    Name (BATF, 0xC0)
                    Name (BCNT, 0x00)
                    Name (AMOF, 0x00)
                    Method (_Q09, 0, NotSerialized)
                    {
                        Store ("_Q09", Debug)
                        If (LEqual (\_SB.PCI0.GWEN, 0x01))
                        {
                            If (LEqual (\_SB.PCI0.AGP.VGA.VW01, 0x00))
                            {
                                And (\_SB.PCI0.DMCX, 0x0F, Local0)
                                If (LEqual (Local0, 0x00))
                                {
                                    Store (Zero, \_SB.SSVW)
                                    \_SB.Z000 (0x89)
                                    Store (Zero, \_SB.PCI0.GWEN)
                                }
                                Else
                                {
                                    Store (0x04, \_SB.PCI0.TMR0)
                                    \_SB.Z000 (0x8D)
                                }
                            }
                            Else
                            {
                                Store (0x04, \_SB.PCI0.TMR0)
                                \_SB.Z000 (0x8D)
                            }
                        }

                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            Notify (\_TZ.THRM, 0x80)
                            Store (0x28, \_SB.PCI0.TMR0)
                            \_SB.Z000 (0x8D)
                        }
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        Store ("_Q20", Debug)
                        Acquire (BNKM, 0xFFFF)
                        Store (SMST, Local1)
                        And (Local1, 0x7F, Local1)
                        If (LEqual (Local1, 0x40))
                        {
                            And (SMST, 0xBF, SMST)
                            Store (SMAA, Local0)
                            Store (0x00, SMAA)
                            If (LEqual (Local0, 0x14))
                            {
                                SEL2 ()
                            }

                            If (LEqual (Local0, 0x16))
                            {
                                Store ("Address is 0x16 :Alarm and notify BAT1 00", Debug)
                                Notify (\_SB.BAT1, 0x00)
                                Notify (\_SB.BAT2, 0x00)
                            }
                        }
                        Else
                        {
                            Store (SMAA, Local0)
                        }

                        Release (BNKM)
                    }

                    Method (SEL2, 0, NotSerialized)
                    {
                        Store (BATD, BATN)
                        And (BATN, 0x01, Local0)
                        And (BATO, 0x01, Local1)
                        If (Not (LEqual (Local0, Local1)))
                        {
                            If (LEqual (Local0, 0x01))
                            {
                                Store (One, \_SB.MBT0)
                                Store (One, \_SB.PCI0.MBT1)
                            }
                            Else
                            {
                                Store (Zero, \_SB.MBT0)
                                Store (Zero, \_SB.PCI0.MBT1)
                            }

                            And (EVNT, 0xF8, EVNT)
                            Or (EVNT, 0x02, EVNT)
                            Store ("Notify Bat1 00", Debug)
                            Notify (\_SB.BAT1, 0x00)
                            Store (SizeOf (\_OS), Local5)
                            If (Not (Or (Or (LEqual (Local5, 0x14), LEqual (Local5, 0x11)), LEqual (Local5, 0x27))))
                            {
                                Notify (\_SB.BAT1, 0x81)
                                Notify (\_SB.BAT1, 0x80)
                            }
                        }
                        Else
                        {
                            And (BATN, 0x02, Local0)
                            And (BATO, 0x02, Local1)
                            If (Not (LEqual (Local0, Local1)))
                            {
                                If (LEqual (Local0, 0x02))
                                {
                                    Store (One, \_SB.SBT0)
                                    Store (One, \_SB.PCI0.SBT1)
                                }
                                Else
                                {
                                    Store (Zero, \_SB.SBT0)
                                    Store (Zero, \_SB.PCI0.SBT1)
                                }

                                And (EVNT, 0xF8, EVNT)
                                Or (EVNT, 0x04, EVNT)
                                Store ("Notify Bat2 00", Debug)
                                Notify (\_SB.BAT2, 0x00)
                                Store (SizeOf (\_OS), Local5)
                                If (Not (Or (Or (LEqual (Local5, 0x14), LEqual (Local5, 0x11)), LEqual (Local5, 0x27))))
                                {
                                    Notify (\_SB.BAT2, 0x81)
                                    Notify (\_SB.BAT2, 0x80)
                                }
                            }
                            Else
                            {
                                And (BATN, 0xC0, Local0)
                                And (BATO, 0xC0, Local1)
                                If (Not (LEqual (Local0, Local1)))
                                {
                                    If (LEqual (Local0, 0xC0))
                                    {
                                        Store (0x01, Local0)
                                        Store (One, \_SB.PCI0.ACON)
                                    }
                                    Else
                                    {
                                        Store (0x00, Local0)
                                        Store (Zero, \_SB.PCI0.ACON)
                                    }

                                    Store (Local0, \_SB.ACD0)
                                    If (LEqual (\_SB.PCI0.AGP.VGA.VW01, 0x00))
                                    {
                                        And (\_SB.PCI0.DMCX, 0x0F, Local0)
                                        If (LEqual (Local0, 0x00))
                                        {
                                            Store (Zero, \_SB.SSVW)
                                            \_SB.Z000 (0x89)
                                        }
                                        Else
                                        {
                                            Store (One, \_SB.PCI0.GWEN)
                                            Store (0x04, \_SB.PCI0.TMR0)
                                            \_SB.Z000 (0x8D)
                                        }
                                    }
                                    Else
                                    {
                                        Store (One, \_SB.PCI0.GWEN)
                                        Store (0x04, \_SB.PCI0.TMR0)
                                        \_SB.Z000 (0x8D)
                                    }

                                    And (EVNT, 0xF8, EVNT)
                                    Or (EVNT, 0x01, EVNT)
                                    Notify (\_SB.ACAD, 0x00)
                                }
                                Else
                                {
                                    If (LEqual (EVNT, 0x01))
                                    {
                                        Notify (\_SB.ACAD, 0x00)
                                    }

                                    If (LEqual (EVNT, 0x02))
                                    {
                                        Notify (\_SB.ACAD, 0x00)
                                    }

                                    If (LEqual (EVNT, 0x04))
                                    {
                                        Notify (\_SB.ACAD, 0x00)
                                    }

                                    Store (0x00, EVNT)
                                }
                            }
                        }

                        If (LNot (\_SB.BAT1.BFST))
                        {
                            Store (0x01, \_SB.BAT1.BFST)
                        }

                        If (LNot (\_SB.BAT2.BFST))
                        {
                            Store (0x01, \_SB.BAT1.BFST)
                        }

                        If (LNot (\_SB.ACAD.AFST))
                        {
                            Store (0x01, \_SB.ACAD.AFST)
                        }

                        Store (BATN, BATO)
                    }

                    Method (_Q8A, 0, NotSerialized)
                    {
                        Store ("Ext Dev Alarm: _Q8A", Debug)
                        If (BAYE)
                        {
                            Store ("- device bay -", Debug)
                            If (\_SB.OKEC)
                            {
                                Store (0x00, BAYE)
                            }

                            \_SB.Z000 (0x85)
                            Notify (\_SB.PCI0.IDE1.SECN.CDRM, 0x01)
                            If (\_SB.PCI0.QFDD)
                            {
                                Notify (\_SB.PCI0.PIB.FDC0.FDDA, 0x01)
                            }
                        }

                        If (EFDE)
                        {
                            Store ("-------- EXT FDD event  ------", Debug)
                            If (\_SB.OKEC)
                            {
                                \_SB.Z000 (0x85)
                                Store (0x00, EFDE)
                                If (\_SB.PCI0.QFDD)
                                {
                                    Notify (\_SB.PCI0.PIB.FDC0.FDDA, 0x01)
                                }
                            }
                        }
                    }

                    Method (_Q8B, 0, NotSerialized)
                    {
                        Acquire (\_SB.BAT1.MMTX, 0xFFFF)
                        \_SB.Z000 (0x8F)
                        Release (\_SB.BAT1.MMTX)
                    }

                    Method (_Q8C, 0, NotSerialized)
                    {
                        Acquire (\_SB.BAT2.AMTX, 0xFFFF)
                        \_SB.Z000 (0x95)
                        Release (\_SB.BAT2.AMTX)
                    }

                    Method (_Q0C, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            If (LEqual (\_SB.PCI0.AGP.VGA.DOSA, 0x00))
                            {
                                \_SB.Z000 (0x86)
                                Notify (\_SB.PCI0.AGP.VGA, 0x80)
                            }
                        }
                        Else
                        {
                            \_SB.Z000 (0x87)
                        }
                    }

                    Method (_Q0D, 0, NotSerialized)
                    {
                        Notify (\_SB.SLPB, 0x80)
                    }

                    Method (_Q80, 0, NotSerialized)
                    {
                        DBGS ("_Q80")
                        Store ("Temperature Up _Q80", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Method (_Q81, 0, NotSerialized)
                    {
                        DBGS ("_Q81")
                        Store ("Temperature Dn _Q80", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }
                }
            }

            Device (IDE1)
            {
                Name (_ADR, 0x00070001)
                OperationRegion (PCI, PCI_Config, 0x40, 0x04)
                Field (PCI, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                        ,   7, 
                    SIDE,   1
                }

                Device (PRIM)
                {
                    Name (_ADR, 0x00)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                    }
                }

                Device (SECN)
                {
                    Name (_ADR, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Device (CDRM)
                    {
                        Name (_ADR, 0x00)
                        Name (_RMV, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (\_SB.PCI0.PM.BAYD, 0x01))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x08)
                            }
                        }
                    }
                }

                Method (_PS0, 0, NotSerialized)
                {
                    Store (0x00, _PSC)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (0x03, _PSC)
                }

                Name (_PSC, 0x00)
                Name (_PR0, Package (0x01)
                {
                    PIDE
                })
            }

            PowerResource (PIDE, 0x00, 0x0000)
            {
                Name (IDES, 0x01)
                Method (_STA, 0, NotSerialized)
                {
                    Return (IDES)
                }

                Method (_ON, 0, NotSerialized)
                {
                    Store (One, IDES)
                }

                Method (_OFF, 0, NotSerialized)
                {
                    Store (Zero, IDES)
                }
            }

            Device (USB0)
            {
                Name (_ADR, 0x00070002)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x01
                })
                OperationRegion (SB72, PCI_Config, 0x00, 0xC2)
                Field (SB72, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x3C), 
                    UIRR,   4
                }

                Method (_STA, 0, NotSerialized)
                {
                    If (\_SB.PCI0.PIB.EUSB)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x00070003)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x01
                })
                OperationRegion (SB72, PCI_Config, 0x00, 0xC2)
                Field (SB72, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x3C), 
                    UBRR,   4
                }

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
            }

            Device (PM)
            {
                Name (_ADR, 0x00070004)
                OperationRegion (SB74, PCI_Config, 0x00, 0x0100)
                Field (SB74, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x44), 
                    PIR0,   8, 
                    PIR8,   8
                }

                OperationRegion (GPIO, SystemIO, 0x8048, 0x08)
                Field (GPIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x01), 
                        ,   1, 
                    BAYD,   2, 
                    PNFI,   1, 
                    Offset (0x04), 
                    GO00,   1, 
                    GO01,   1, 
                    GO02,   1, 
                    GO03,   1, 
                    GO04,   1, 
                    GO05,   1, 
                    GO06,   1, 
                    GO07,   1, 
                    GO08,   1, 
                    GO09,   1, 
                    GO10,   1, 
                    GO11,   1, 
                    GO12,   1, 
                    GO13,   1, 
                    GO14,   1, 
                    GO15,   1, 
                    GO16,   1, 
                    GO17,   1, 
                    GO18,   1, 
                    GO19,   1, 
                    GO20,   1, 
                    GO21,   1, 
                    GO22,   1, 
                    GO23,   1, 
                    GO24,   1, 
                    GO25,   1
                }

                OperationRegion (PMIO, SystemIO, 0x8000, 0x50)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                        ,   10, 
                    RTCS,   1, 
                    Offset (0x10), 
                    TRDC,   4, 
                    TREN,   1, 
                    Offset (0x22), 
                        ,   5, 
                    GPI5,   1, 
                    Offset (0x28), 
                        ,   7, 
                    PIRS,   1, 
                    Offset (0x2A), 
                        ,   7, 
                    PIEN,   1, 
                    Offset (0x2C), 
                        ,   7, 
                    LPOL,   1, 
                    Offset (0x2F), 
                    BCMD,   8, 
                    Offset (0x48), 
                    EXMI,   1, 
                        ,   2, 
                    LIDI,   1, 
                    Offset (0x49), 
                    CRTP,   1
                }

                OperationRegion (SMIO, SystemIO, 0x8080, 0x07)
                Field (SMIO, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8, 
                    SSTS,   8, 
                    CTLR,   8, 
                    CMDR,   8, 
                    ADDR,   8, 
                    DAT0,   8, 
                    DAT1,   8
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store ("$$$$$$$$$$$$$$$$$$$$$", Debug)
                    Stall (0x05)
                }

                Method (_PS0, 0, NotSerialized)
                {
                    Store ("######################", Debug)
                    Store (0x00, \_GPE.HKFG)
                }

                Name (_PR0, Package (0x01)
                {
                    PLPC
                })
                PowerResource (PLPC, 0x00, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x01)
                    }

                    Method (_ON, 0, NotSerialized)
                    {
                        Stall (0x05)
                    }

                    Method (_OFF, 0, NotSerialized)
                    {
                        Stall (0x05)
                    }
                }
            }

            Device (AUDI)
            {
                Name (_ADR, 0x00070005)
                OperationRegion (SB75, PCI_Config, 0x00, 0x85)
                Field (SB75, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x3C), 
                    MIRR,   8
                }

                Method (_STA, 0, NotSerialized)
                {
                    Store (\_SB.PCI0.PIB.EXFA, Local0)
                    And (Local0, 0x04, Local0)
                    If (Local0)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (PMOD)
            {
                Name (_ADR, 0x00090001)
                OperationRegion (PM00, PCI_Config, 0x00, 0x0100)
                Field (PM00, ByteAcc, NoLock, Preserve)
                {
                    Offset (0xE0), 
                    Offset (0xE1), 
                    MPME,   1, 
                        ,   6, 
                    MWAK,   1
                }
            }

            Device (PLOD)
            {
                Name (_ADR, 0x00090000)
                OperationRegion (PL00, PCI_Config, 0x00, 0x0100)
                Field (PL00, ByteAcc, NoLock, Preserve)
                {
                    Offset (0xE0), 
                    Offset (0xE1), 
                    LPME,   1, 
                        ,   6, 
                    LWAK,   1
                }
            }

            Device (CRD0)
            {
                Name (_ADR, 0x000A0000)
                Method (_INI, 0, NotSerialized)
                {
                    Or (PMEE, 0x01, PMEE)
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

                OperationRegion (CCRD, PCI_Config, 0x00, 0xA7)
                Field (CCRD, DWordAcc, Lock, Preserve)
                {
                    Offset (0x80), 
                    PMEE,   1, 
                    Offset (0x81), 
                    Offset (0xA4), 
                    PWST,   2, 
                    Offset (0xA5), 
                        ,   7, 
                    PMST,   1
                }
            }

            Device (CRD1)
            {
                Name (_ADR, 0x000A0001)
                Method (_INI, 0, NotSerialized)
                {
                    Or (PMEE, 0x01, PMEE)
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

                OperationRegion (CCRD, PCI_Config, 0x00, 0xA7)
                Field (CCRD, DWordAcc, Lock, Preserve)
                {
                    Offset (0x80), 
                    PMEE,   1, 
                    Offset (0x81), 
                    Offset (0xA4), 
                    PWST,   2, 
                    Offset (0xA5), 
                        ,   7, 
                    PMST,   1
                }
            }
        }
    }
}


--Boundary-00=_QRGVDWxxYz+2GTE
Content-Type: text/plain;
  charset="us-ascii";
  name="dsdt_fixed.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dsdt_fixed.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20050513
 *
 * Disassembly of dsdt_dump.dat, Sun Oct  9 03:21:09 2005
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "Compaq", "Wrangler", 100925440)
{
    Scope (\_PR)
    {
        Processor (CPU0, 0x01, 0x986E8482, 0x80) {}
    }

    Name (\_S0, Package (0x02)
    {
        0x00, 
        0x00
    })
    Name (\_S1, Package (0x02)
    {
        0x04, 
        0x04
    })
    Name (\_S4, Package (0x02)
    {
        0x02, 
        0x02
    })
    Name (\_S5, Package (0x02)
    {
        0x02, 
        0x02
    })
    Scope (\_GPE)
    {
        Name (LIF1, 0x00)
        Name (LIF2, 0x00)
        Method (_L0B, 0, NotSerialized)
        {
            \_SB.Z000 (0x88)
            If (LEqual (\_GPE.LIF1, 0x01))
            {
                Not (\_SB.PCI0.PM.LPOL, \_SB.PCI0.PM.LPOL)
                Store (0x00, \_GPE.LIF1)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    \_SB.PCI0.AGP.VGA.DRUU (0xFF)
                }
                Else
                {
                    \_SB.Z000 (0x84)
                }
            }
            Else
            {
                If (LEqual (\_GPE.LIF2, 0x01))
                {
                    Not (\_SB.PCI0.PM.LPOL, \_SB.PCI0.PM.LPOL)
                    Store (0x00, \_GPE.LIF2)
                    Notify (\_SB.LID, 0x80)
                }
                Else
                {
                    If (LEqual (\_SB.PCI0.CRTS, 0x01))
                    {
                        Not (\_SB.PCI0.PM.LPOL, \_SB.PCI0.PM.LPOL)
                        If (LEqual (\_SB.PCI0.PM.LPOL, 0x01))
                        {
                            If (LEqual (SizeOf (\_OS), 0x14))
                            {
                                \_SB.PCI0.AGP.VGA.DRUU (0xFF)
                            }
                            Else
                            {
                                \_SB.Z000 (0x84)
                            }
                        }
                        Else
                        {
                            Store (0x01, \_GPE.LIF1)
                            If (LEqual (SizeOf (\_OS), 0x14))
                            {
                                \_SB.PCI0.AGP.VGA.DRUU (0x00)
                            }
                            Else
                            {
                                \_SB.Z000 (0x83)
                            }
                        }
                    }
                    Else
                    {
                        Store (" GPE_L0B - LID CLOSED ", Debug)
                        Not (\_SB.PCI0.PM.LPOL, \_SB.PCI0.PM.LPOL)
                        Store (0x01, \_GPE.LIF2)
                        Notify (\_SB.LID, 0x80)
                    }
                }
            }
        }

        Method (_L08, 0, NotSerialized)
        {
            Store ("_GPE._L08 - UAR1", Debug)
            Notify (\_SB.PCI0.PIB.UAR1, 0x02)
        }

        Method (_L09, 0, NotSerialized)
        {
            Store ("_GPE._L09 - USB", Debug)
            Notify (\_SB.PCI0.USB0, 0x02)
            Notify (\_SB.PCI0.PIB.UAR1, 0x02)
        }

        Method (_L05, 0, NotSerialized)
        {
            If (LEqual (SizeOf (\_OS), 0x11))
            {
                If (\_SB.SPST)
                {
                    Notify (\_SB.PCI0, 0x02)
                }
                Else
                {
                    If (LOr (\_SB.PCI0.PMOD.MWAK, \_SB.PCI0.PMOD.MPME))
                    {
                        Store (0x01, \_SB.PCI0.PMOD.MWAK)
                        Store (0x00, \_SB.PCI0.PMOD.MPME)
                    }

                    If (\_SB.PCI0.CRD0.PMST)
                    {
                        Notify (\_SB.PCI0.CRD0, 0x02)
                    }

                    If (\_SB.PCI0.CRD1.PMST)
                    {
                        Notify (\_SB.PCI0.CRD1, 0x02)
                    }
                }
            }
            Else
            {
                Notify (\_SB.PCI0, 0x02)
            }
        }

        Name (HKFG, 0x00)
        Method (_L00, 0, NotSerialized)
        {
            If (LEqual (\_GPE.HKFG, 0x00))
            {
                \_SB.Z000 (0x8B)
            }
            Else
            {
                Store (0x00, \_GPE.HKFG)
                Notify (\_SB.PWRB, 0x02)
            }
        }
    }

    OperationRegion (CMOS, SystemIO, 0x72, 0x02)
    Field (CMOS, ByteAcc, NoLock, Preserve)
    {
        CINX,   8, 
        CDAT,   8
    }

    IndexField (CINX, CDAT, ByteAcc, NoLock, Preserve)
    {
        Offset (0xA0), 
        BCRN,   16, 
        MFCC,   16, 
        AFCC,   16, 
        MBRM,   16, 
        ABRM,   16, 
        MBVT,   16, 
        ABVT,   16, 
        Offset (0xB0), 
        MBTS,   1, 
        SBTS,   1, 
            ,   2, 
        MBTD,   1, 
        ABTD,   1, 
        MBTC,   1, 
        ABTC,   1, 
        ACDF,   1, 
            ,   1, 
        NVOS,   2, 
        PHEX,   1, 
        Offset (0xB2), 
        CTMP,   8
    }

    Method (\_PTS, 1, NotSerialized)
    {
        Store (0x01, \_SB.SPST)
        If (LEqual (Arg0, 0x04))
        {
            Store (Zero, \_SB.PCI0.PM.GPI5)
        }

        If (LEqual (Arg0, 0x05))
        {
            Store (0x00, \_SB.PCI0.PM.GO22)
        }

        If (LEqual (Arg0, 0x01))
        {
            If (LEqual (SizeOf (\_OS), 0x14))
            {
                Store (0x01, NVOS)
            }
            Else
            {
                Store (0x00, NVOS)
            }

            Sleep (0x32)
            Store ("------------- System S0 to S1 mode -------------", Debug)
            \_SB.Z000 (0x8A)
            Store (0x00, \_SB.PCI0.PM.LPOL)
            If (LEqual (SizeOf (\_OS), 0x11))
            {
                Store (0x01, \_SB.PCI0.PMOD.MWAK)
                Store (0x01, \_SB.PCI0.PMOD.MPME)
            }

            Store (0x01, \_GPE.HKFG)
        }
    }

    Method (\_WAK, 1, NotSerialized)
    {
        \_SB.Z000 (0x9A)
        Store (0x00, \_SB.ACAD.AFST)
        Store (0x00, \_SB.BAT1.BFST)
        Store (0x00, \_SB.BAT2.BFST)
        Store (0x01, \_SB.MFLG)
        Store (0x01, \_SB.AFLG)
        Store (0x01, \_SB.FACD)
        Store (0x00, \_GPE.LIF1)
        Store (0x00, \_GPE.LIF2)
        If (LEqual (SizeOf (\_OS), 0x14))
        {
            \_SB.PCI0.AGP.VGA._INI ()
        }

        If (\_SB.SSVW)
        {
            Store (\_SB.SSVW, \_SB.PCI0.AGP.VGA.VW01)
        }

        Store (0x00, \_SB.SPST)
        If (LEqual (Arg0, 0x04))
        {
            Store ("------------- System S4 to S0 mode -------------", Debug)
            \_SB.Z000 (0x8C)
            Store (0x01, \_SB.PCI0.QTMR)
            If (LEqual (SizeOf (\_OS), 0x14))
            {
                Store (0x28, \_SB.PCI0.TMR0)
                \_SB.Z000 (0x8D)
            }
        }

        If (LEqual (Arg0, 0x01))
        {
            Store ("------------- System S1 to S0 mode -------------", Debug)
            \_SB.Z000 (0x81)
            If (LEqual (SizeOf (\_OS), 0x14))
            {
                Notify (\_SB.PCI0.AGP.VGA, 0x00)
                Return (0x00)
            }
        }

        If (LNot (\_SB.PCI0.PM.RTCS))
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Notify (\_SB.PCI0.AGP.VGA, 0x00)
        Return(Package(0x02){0x00, 0x00})
    }

    Scope (\_TZ)
    {
        Name (TAC1, 0x0CFA)
        Name (HAC1, 0x0CFA)
        Name (TAC0, 0x0D9A)
        Name (HAC0, 0x0D9A)
        Name (TPAS, 0x0E30)
        Name (HPAS, 0x0E30)
        Name (TPC, 0x0E80)
        Name (TPTM, 0x0CA0)
        Name (TBSE, 0x0AAC)
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
                Store ("FAN 0 - _PS0", Debug)
            }

            Method (_PS3, 0, NotSerialized)
            {
                Store ("FAN 0 - _PS3", Debug)
            }
        }

        PowerResource (PFN0, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                XOr (\_SB.PCI0.PM.GO07, One, Local7)
                Return (Local7)
            }

            Method (_ON, 0, NotSerialized)
            {
                Store (Zero, \_SB.PCI0.PM.GO07)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    Notify (\_TZ.THRM, 0x81)
                }
            }

            Method (_OFF, 0, NotSerialized)
            {
                Store (One, \_SB.PCI0.PM.GO07)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    Notify (\_TZ.THRM, 0x81)
                }
            }
        }

        Device (FAN1)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, 0x02)
            Name (_PR0, Package (0x01)
            {
                PFN1
            })
            Method (_PS0, 0, NotSerialized)
            {
                Store ("FAN 1 - _PS0", Debug)
            }

            Method (_PS3, 0, NotSerialized)
            {
                Store ("FAN 1 - _PS3", Debug)
            }
        }

        PowerResource (PFN1, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)
            {
                XOr (\_SB.PCI0.PM.GO23, One, Local7)
                Return (Local7)
            }

            Method (_ON, 0, NotSerialized)
            {
                Store (Zero, \_SB.PCI0.PM.GO07)
                Store (Zero, \_SB.PCI0.PM.GO23)
            }

            Method (_OFF, 0, NotSerialized)
            {
                Store (One, \_SB.PCI0.PM.GO23)
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

            Name (_TSP, 0x28)
            Method (_TMP, 0, NotSerialized)
            {
                If (Or (Or (PHEX, \_SB.DFEC), \_SB.THGO))
                {
                    Return (TPTM)
                }

                If (\_SB.OKEC)
                {
                    \_SB.Z000 (0x93)
                    Store (CTMP, Local1)
                    Store ("_TMP Current Temperature is ----------- ", Debug)
                    Store (Local1, Debug)
                    Add (Multiply (Local1, 0x0A), TBSE, Local1)
                    Return (Local1)
                }
                Else
                {
                    Return (TPTM)
                }
            }

            Name (_PSL, Package (0x01)
            {
                \_PR.CPU0
            })
            Name (_TC1, 0x02)
            Name (_TC2, 0x03)
            Method (_SCP, 1, NotSerialized)
            {
                If (Arg0)
                {
                    Store (One, PLCY)
                    Store (HAC1, TPAS)
                    Store (HAC0, TAC1)
                    Store (HPAS, TAC0)
                }
                Else
                {
                    Store (Zero, PLCY)
                    Store (HAC1, TAC1)
                    Store (HAC0, TAC0)
                    Store (HPAS, TPAS)
                }

                Notify (\_TZ.THRM, 0x81)
            }
        }
    }

    OperationRegion (\P378, SystemIO, 0x0378, 0x02)
    Field (\P378, ByteAcc, NoLock, Preserve)
    {
        O378,   8, 
        I379,   8
    }

    Method (DBGC, 1, Serialized)
    {
        F378 (Arg0)
        FODB (0x55)
        FODB (0xAA)
        FODB (0x0E)
        FODB (0x10)
        FODB (0x20)
        FODB (0x07)
        FODB (0x66)
    }

    Method (DBGD, 1, Serialized)
    {
        Store (Arg0, Local0)
        And (Local0, 0xFF, Local1)
        ShiftRight (Local0, 0x08, Local2)
        And (Local2, 0xFF, Local2)
        ShiftRight (Local0, 0x10, Local3)
        And (Local3, 0xFF, Local3)
        ShiftRight (Local0, 0x18, Local4)
        And (Local4, 0xFF, Local4)
        And (I379, 0xF8, Local0)
        If (LEqual (Local0, 0xB0))
        {
            FODB (0x55)
            FODB (0xAA)
            FODB (0x02)
            FODB (0x02)
            FODB (Local1)
            FODB (Local2)
            FODB (Local3)
            FODB (Local4)
            FODB (0x66)
        }
    }

    Method (DBGS, 1, Serialized)
    {
        And (I379, 0xF8, Local0)
        If (LEqual (Local0, 0xB0))
        {
            Store (SizeOf (Arg0), Local1)
            Name (BUFF, Buffer (Local1) {})
            Store (Arg0, BUFF)
            Store (Zero, Local2)
            FODB (0x55)
            FODB (0xAA)
            FODB (0x09)
            FODB (0x10)
            FODB (0x0D)
            FODB (0x0A)
            While (LNot (LEqual (Local2, Local1)))
            {
                Store (DerefOf (Index (BUFF, Local2)), Local3)
                Increment (Local2)
                FODB (Local3)
            }

            FODB (0x00)
            FODB (0x66)
        }
    }

    Method (DBGT, 1, Serialized)
    {
        And (I379, 0xF8, Local0)
        If (LEqual (Local0, 0xB0))
        {
            Store (SizeOf (Arg0), Local1)
            Name (BUFF, Buffer (Local1) {})
            Store (Arg0, BUFF)
            Store (Zero, Local2)
            FODB (0x55)
            FODB (0xAA)
            FODB (0x0A)
            FODB (0x10)
            While (LNot (LEqual (Local2, Local1)))
            {
                Store (DerefOf (Index (BUFF, Local2)), Local3)
                Increment (Local2)
                FODB (Local3)
            }

            FODB (0x00)
            FODB (0x66)
        }
    }

    Method (CHAR, 1, Serialized)
    {
        FODB (0x55)
        FODB (0xAA)
        FODB (0x0E)
        FODB (0x10)
        FODB (Arg0)
        FODB (0x07)
        FODB (0x66)
    }

    Method (F378, 1, Serialized)
    {
        And (I379, 0xF8, Local0)
        If (LEqual (Local0, 0xB0))
        {
            FODB (0x55)
            FODB (0xAA)
            FODB (0x00)
            FODB (0x02)
            FODB (Arg0)
            FODB (0x66)
        }
    }

    Method (\FODB, 1, NotSerialized)
    {
        Or (Arg0, 0x10, Local0)
        Store (Local0, O378)
        Store (0x01, Local3)
        While (Local3)
        {
            If (LEqual (And (I379, 0x80, Local3), 0x00))
            {
                ShiftRight (I379, 0x03, Local0)
                And (Local0, 0x0F, Local0)
                ShiftRight (Arg0, 0x04, Local1)
                Store (Local1, O378)
                Store (0x01, Local2)
                While (Local2)
                {
                    If (And (I379, 0x80, Local2))
                    {
                        Store (I379, Local1)
                        Store (0x00, Local2)
                    }
                    Else
                    {
                        Store (0x01, Local2)
                    }
                }

                ShiftLeft (Local1, 0x01, Local1)
                And (Local1, 0xF0, Local1)
                Or (Local1, Local0, Local0)
                Store (0x00, Local3)
            }
        }
    }

    Scope (_SB)
    {
        Name (SSVW, 0x00)
        Name (GGEC, 0x01)
        Name (YYEC, 0x00)
        Name (MFLG, 0x01)
        Name (AFLG, 0x01)
        Name (MBT0, 0x01)
        Name (SBT0, 0x01)
        Name (ACD0, 0x01)
        Name (FACD, 0x01)
        Name (THGO, 0x00)
        Name (FMST, 0x01)
        Name (FAST, 0x01)
        Name (FDD0, 0x00)
        Name (WVGA, 0x00)
        Name (MYOS, 0x04)
        Method (_INI, 0, NotSerialized)
        {
            Store (0x04, MYOS)
            If (LEqual (SizeOf (\_OS), 0x14))
            {
                Store (0x01, MYOS)
            }

            If (LEqual (SizeOf (\_OS), 0x11))
            {
                Store (0x00, MYOS)
            }

            If (LEqual (SizeOf (\_OS), 0x27))
            {
                Store (0x02, MYOS)
            }
        }

        Name (SPST, 0x00)
        Mutex (VSMX, 0x00)
        Method (Z000, 1, Serialized)
        {
            Store ("--------- VIA SOFTWARE SMI PMIO 2Fh ------------", Debug)
            Acquire (VSMX, 0xFFFF)
            Store (Arg0, \_SB.PCI0.PM.BCMD)
            Release (VSMX)
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x00, 
                0x01
            })
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0B)
            }
        }

        Device (ACAD)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (ACP, Ones)
            Name (AFST, 0x00)
            Method (_PSR, 0, NotSerialized)
            {
                Store (0x00, Local0)
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (Local0)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.FACD)
                    {
                        Sleep (0x32)
                        \_SB.Z000 (0x91)
                        Store (ACDF, \_SB.ACD0)
                        Sleep (0x32)
                        Store (Zero, \_SB.FACD)
                    }

                    If (\_SB.ACD0)
                    {
                        Store (0x01, Local0)
                    }

                    If (LNot (AFST))
                    {
                        Store (0x01, AFST)
                        And (\_SB.PCI0.PIB.EC0.BATO, 0x3F, \_SB.PCI0.PIB.EC0.BATO)
                        If (LEqual (Local0, 0x01))
                        {
                            Or (\_SB.PCI0.PIB.EC0.BATO, 0xC0, \_SB.PCI0.PIB.EC0.BATO)
                        }
                    }
                }
                Else
                {
                    Store (0x01, Local0)
                }

                Return (Local0)
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }

        Method (POSW, 1, NotSerialized)
        {
            If (And (Arg0, 0x8000))
            {
                If (LEqual (Arg0, 0xFFFF))
                {
                    Return (0xFFFFFFFF)
                }
                Else
                {
                    Not (Arg0, Local0)
                    Increment (Local0)
                    And (Local0, 0xFFFF, Local0)
                    Return (Local0)
                }
            }
            Else
            {
                Return (Arg0)
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (BFST, 0x00)
            Name (FBST, 0x01)
            Mutex (MMTX, 0x00)
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0xFA, 
                0x64, 
                0x0A, 
                0x19, 
                "BAT1", 
                " ", 
                " ", 
                " "
            })
            Name (PBST, Package (0x04)
            {
                0x00, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x2710
            })
            Name (FAST, 0x00)
            Method (_STA, 0, NotSerialized)
            {
                Store (0x0F, Local0)
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (Local0)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.MFLG)
                    {
                        \_SB.Z000 (0x90)
                        Store (MBTS, \_SB.MBT0)
                        Sleep (0x32)
                        Store (Zero, \_SB.MFLG)
                    }

                    If (\_SB.MBT0)
                    {
                        Store (0x1F, Local0)
                    }

                    If (LNot (BFST))
                    {
                        Store (0x01, BFST)
                        And (\_SB.PCI0.PIB.EC0.BATO, 0xFFFE, \_SB.PCI0.PIB.EC0.BATO)
                        If (LEqual (Local0, 0x1F))
                        {
                            Or (\_SB.PCI0.PIB.EC0.BATO, 0x01, \_SB.PCI0.PIB.EC0.BATO)
                        }
                    }
                }

                Return (Local0)
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (PBIF)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.MBT0)
                    {
                        \_SB.Z000 (0x8E)
                        UPBI ()
                    }
                    Else
                    {
                        IVBI ()
                    }
                }

                Return (PBIF)
            }

            Method (_BST, 0, NotSerialized)
            {
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (PBST)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.MBT0)
                    {
                        If (FBST)
                        {
                            \_SB.Z000 (0x8F)
                            Store (0x00, FBST)
                        }

                        UPBS ()
                    }
                    Else
                    {
                        IVBS ()
                    }
                }

                Return (PBST)
            }

            Method (UPBI, 0, NotSerialized)
            {
                Store (0x1E, Local1)
                While (LGreater (Local1, 0x01))
                {
                    Store (MFCC, Local5)
                    If (LEqual (Local5, 0x00))
                    {
                        Decrement (Local1)
                        Sleep (0x012C)
                        \_SB.Z000 (0x8E)
                    }
                    Else
                    {
                        Store (0x00, Local1)
                    }
                }

                Store (Local5, Index (PBIF, 0x02))
                Store (0x0E10, Index (PBIF, 0x01))
                Store (0x39D0, Index (PBIF, 0x04))
                Store ("HQL4", Index (PBIF, 0x09))
                Store ("LION", Index (PBIF, 0x0B))
                Store ("SANYO", Index (PBIF, 0x0C))
            }

            Method (UPBS, 0, NotSerialized)
            {
                Acquire (MMTX, 0xFFFF)
                Store (MBRM, Local2)
                Store (MBVT, Local3)
                Store (0x00, Local0)
                If (LEqual (MBTC, 0x01))
                {
                    Or (0x02, Local0, Local0)
                }

                If (LEqual (MBTD, 0x01))
                {
                    Or (0x01, Local0, Local0)
                }

                Release (MMTX)
                Store (SizeOf (\_OS), Local7)
                If (Or (Or (LEqual (Local7, 0x14), LEqual (Local7, 0x11)), LEqual (Local7, 0x27)))
                {
                    Store (0xFFFFFFFF, Index (PBST, 0x01))
                }
                Else
                {
                    \_SB.Z000 (0x92)
                    Store (BCRN, Index (PBST, 0x01))
                }

                Store (Local2, Index (PBST, 0x02))
                Store (Local3, Index (PBST, 0x03))
                Store ("Bat1 remaining cap", Debug)
                Store (Local2, Debug)
                Store (Local0, Index (PBST, 0x00))
            }

            Method (IVBI, 0, NotSerialized)
            {
                Store (0xFFFFFFFF, Index (PBIF, 0x01))
                Store (0xFFFFFFFF, Index (PBIF, 0x02))
                Store (0xFFFFFFFF, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("      ", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
            }

            Method (IVBS, 0, NotSerialized)
            {
                Store (0x00, Index (PBST, 0x00))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (0xFFFFFFFF, Index (PBST, 0x02))
                Store (0x2710, Index (PBST, 0x03))
            }
        }

        Device (BAT2)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x02)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (BFST, 0x00)
            Name (FBST, 0x01)
            Mutex (AMTX, 0x00)
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0xFA, 
                0x64, 
                0x0A, 
                0x19, 
                "BAT1", 
                " ", 
                " ", 
                " "
            })
            Name (PBST, Package (0x04)
            {
                0x00, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x2710
            })
            Method (_STA, 0, NotSerialized)
            {
                Store (0x0F, Local0)
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (Local0)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.AFLG)
                    {
                        \_SB.Z000 (0x96)
                        Store (SBTS, \_SB.SBT0)
                        Sleep (0x32)
                        Store (Zero, \_SB.AFLG)
                    }

                    If (\_SB.SBT0)
                    {
                        Store (0x1F, Local0)
                    }

                    If (LNot (BFST))
                    {
                        Store (0x01, BFST)
                        And (\_SB.PCI0.PIB.EC0.BATO, 0xFFFD, \_SB.PCI0.PIB.EC0.BATO)
                        If (LEqual (Local0, 0x1F))
                        {
                            Or (\_SB.PCI0.PIB.EC0.BATO, 0x02, \_SB.PCI0.PIB.EC0.BATO)
                        }
                    }
                }

                Return (Local0)
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (PBIF)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.SBT0)
                    {
                        \_SB.Z000 (0x94)
                        UPBI ()
                    }
                    Else
                    {
                        IVBI ()
                    }
                }

                Return (PBIF)
            }

            Method (_BST, 0, NotSerialized)
            {
                If (Or (PHEX, \_SB.DFEC))
                {
                    Return (PBST)
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.SBT0)
                    {
                        If (FBST)
                        {
                            \_SB.Z000 (0x95)
                            Store (0x00, FBST)
                        }

                        UPBS ()
                    }
                    Else
                    {
                        IVBS ()
                    }
                }

                Return (PBST)
            }

            Method (UPBI, 0, NotSerialized)
            {
                Store (0x1E, Local1)
                While (LGreater (Local1, 0x01))
                {
                    Store (AFCC, Local5)
                    If (LEqual (Local5, 0x00))
                    {
                        Decrement (Local1)
                        Sleep (0x012C)
                        \_SB.Z000 (0x94)
                    }
                    Else
                    {
                        Store (0x00, Local1)
                    }
                }

                Store (Local5, Index (PBIF, 0x02))
                Store (0x0C1C, Index (PBIF, 0x01))
                Store (0x2B5C, Index (PBIF, 0x04))
                Store ("HQL3", Index (PBIF, 0x09))
                Store ("LION", Index (PBIF, 0x0B))
                Store ("SANYO", Index (PBIF, 0x0C))
            }

            Method (UPBS, 0, NotSerialized)
            {
                Acquire (AMTX, 0xFFFF)
                Store (ABRM, Local2)
                Store (ABVT, Local3)
                Store (0x00, Local0)
                If (LEqual (ABTC, 0x01))
                {
                    Store ("--Power State as charging", Debug)
                    Or (0x02, Local0, Local0)
                }

                If (LEqual (ABTD, 0x01))
                {
                    Store ("---Power State as discharging", Debug)
                    Or (0x01, Local0, Local0)
                }

                Release (AMTX)
                Store (SizeOf (\_OS), Local7)
                If (Or (Or (LEqual (Local7, 0x14), LEqual (Local7, 0x11)), LEqual (Local7, 0x27)))
                {
                    Store (0xFFFFFFFF, Index (PBST, 0x01))
                }
                Else
                {
                    \_SB.Z000 (0x92)
                    Store (BCRN, Index (PBST, 0x01))
                }

                Store (Local2, Index (PBST, 0x02))
                Store (Local3, Index (PBST, 0x03))
                Store ("Bat2 Remaining cap", Debug)
                Store (Local2, Debug)
                Store (Local0, Index (PBST, 0x00))
            }

            Method (IVBI, 0, NotSerialized)
            {
                Store (0xFFFFFFFF, Index (PBIF, 0x01))
                Store (0xFFFFFFFF, Index (PBIF, 0x02))
                Store (0xFFFFFFFF, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("      ", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
            }

            Method (IVBS, 0, NotSerialized)
            {
                Store (0x00, Index (PBST, 0x00))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (0xFFFFFFFF, Index (PBST, 0x02))
                Store (0x2710, Index (PBST, 0x03))
            }
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_LID, 0, NotSerialized)
            {
                Return (\_SB.PCI0.PM.LPOL)
            }

            Name (_PRW, Package (0x02)
            {
                0x0B, 
                0x01
            })
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            Name (_PRW, Package (0x02)
            {
                0x05, 
                0x01
            })
            OperationRegion (FDMA, SystemIO, 0x08, 0x02)
            Field (FDMA, ByteAcc, NoLock, Preserve)
            {
                DMCX,   4, 
                DMAR,   4
            }

            OperationRegion (NB00, PCI_Config, 0x00, 0x0100)
            Field (NB00, ByteAcc, NoLock, Preserve)
            {
                Offset (0x5F), 
                EADD,   8, 
                Offset (0xF0), 
                TMR0,   8, 
                SDCS,   8, 
                CRTS,   1, 
                ACON,   1, 
                GWEN,   1, 
                SBT1,   1, 
                MBT1,   1, 
                QTMR,   1, 
                Offset (0xF3), 
                QFDD,   1, 
                Offset (0xFB), 
                    ,   4, 
                FBSZ,   2, 
                    ,   1, 
                Offset (0xFC)
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }

            Method (_INI, 0, NotSerialized)
            {
                Store (Zero, \_SB.PCI0.GWEN)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    Store (0x28, \_SB.PCI0.TMR0)
                    \_SB.Z000 (0x8D)
                }
            }

            Name (CRES, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000, // Address Space Granularity
                    0x0000, // Address Range Minimum
                    0x00FF, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x0100,,,)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000, // Address Space Granularity
                    0x0000, // Address Range Minimum
                    0x0CF7, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x0CF8,,,
                    , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000, // Address Space Granularity
                    0x0D00, // Address Range Minimum
                    0xFFFF, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0xF300,,,
                    , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000A0000, // Address Range Minimum
                    0x000BFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00020000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000C8000, // Address Range Minimum
                    0x000DFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00018000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x02000000, // Address Range Minimum
                    0xFFDFFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0xFDE00000,,,
                    , AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (CRES, 0x76, RAMT)
                CreateDWordField (CRES, 0x82, RAMR)
                Store (\_SB.PCI0.FBSZ, Local0)
                If (LEqual (Local0, 0x01))
                {
                    Store (0x00200000, Local0)
                }
                Else
                {
                    If (LEqual (Local0, 0x02))
                    {
                        Store (0x00400000, Local0)
                    }
                    Else
                    {
                        If (LEqual (Local0, 0x03))
                        {
                            Store (0x00800000, Local0)
                        }
                        Else
                        {
                            Store (0x00, Local0)
                        }
                    }
                }

                Multiply (\_SB.PCI0.EADD, 0x00800000, Local1)
                Subtract (Local1, Local0, RAMT)
                Subtract (0xFFE00000, RAMT, RAMR)
                Return (CRES)
            }

            Name (_PRT, Package (0x08)
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
                    0x0007FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x02, 
                    \_SB.PCI0.PIB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x03, 
                    \_SB.PCI0.PIB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x00, 
                    \_SB.PCI0.PIB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x01, 
                    \_SB.PCI0.PIB.LNKC, 
                    0x00
                }
            })
            Device (AGP)
            {
                Name (_ADR, 0x00010000)
                Device (VGA)
                {
                    Name (_ADR, 0x00)
                    Name (DOSA, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (_PS0, 0, NotSerialized)
                    {
                        Store ("VGA in D0", Debug)
                        If (\_SB.SSVW)
                        {
                            Store (One, \_SB.PCI0.AGP.VGA.VW01)
                            Store (Zero, \_SB.SSVW)
                            Sleep (0x64)
                            Store (\_SB.PCI0.AGP.VGA.VW01, Debug)
                        }

                        Notify (\_SB.PCI0.AGP.VGA, 0x00)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.AGP.VGA.VW01, Local0)
                        Store ("VGA in D3", Debug)
                        Store (Local0, Debug)
                        Store (Local0, \_SB.SSVW)
                    }

                    OperationRegion (CBI1, SystemIO, 0x03D4, 0x02)
                    Field (CBI1, ByteAcc, NoLock, Preserve)
                    {
                        VIDX,   8, 
                        VDAT,   8
                    }

                    IndexField (VIDX, VDAT, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x8E), 
                            ,   4, 
                        VW01,   1, 
                        Offset (0x8F)
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        \_SB.Z000 (0x88)
                        \_SB.Z000 (0x86)
                        XVCH ()
                        EDGS ()
                    }

                    Method (XVCH, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.SDCS, Local0)
                        Store (Local0, Local1)
                        And (Local1, 0x01, Local1)
                        ShiftLeft (Local1, 0x01, Local1)
                        And (^LCD._DCS, 0xFFFFFFFD, ^LCD._DCS)
                        Or (^LCD._DCS, Local1, ^LCD._DCS)
                        Store (Local0, Local1)
                        And (Local1, 0x02, Local1)
                        And (^CRT._DCS, 0xFFFFFFFD, ^CRT._DCS)
                        Or (^CRT._DCS, Local1, ^CRT._DCS)
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (Arg0, DOSA)
                    }

                    Name (LDCS, 0x00)
                    Name (CDCS, 0x00)
                    Method (DRUU, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            \_SB.Z000 (0x86)
                            Store (0x00, ^LCD._DGS)
                            Store (0x01, ^CRT._DGS)
                            Notify (VGA, 0x80)
                        }
                        Else
                        {
                            Store (\_SB.PCI0.SDCS, Local0)
                            Store (Local0, Local1)
                            And (Local1, 0x01, Local1)
                            And (^LCD._DGS, 0xFFFFFFFE, ^LCD._DGS)
                            Or (^LCD._DGS, Local1, ^LCD._DGS)
                            ShiftLeft (Local1, 0x01, Local1)
                            And (^LCD._DCS, 0xFFFFFFFD, ^LCD._DCS)
                            Or (^LCD._DCS, Local1, ^LCD._DCS)
                            Store (Local0, Local1)
                            And (Local1, 0x02, Local1)
                            And (^CRT._DCS, 0xFFFFFFFD, ^CRT._DCS)
                            Or (^CRT._DCS, Local1, ^CRT._DCS)
                            ShiftRight (Local1, 0x01, Local1)
                            And (^CRT._DGS, 0xFFFFFFFE, ^CRT._DGS)
                            Or (^CRT._DGS, Local1, ^CRT._DGS)
                            Notify (VGA, 0x80)
                        }
                    }

                    Method (EDGS, 0, NotSerialized)
                    {
                        If (And (^LCD._DCS, 0x02))
                        {
                            If (And (^CRT._DCS, 0x02))
                            {
                                Store (0x00, ^LCD._DGS)
                                Store (0x01, ^CRT._DGS)
                            }
                            Else
                            {
                                Store (0x01, ^LCD._DGS)
                                Store (0x01, ^CRT._DGS)
                            }
                        }
                        Else
                        {
                            Store (0x01, ^LCD._DGS)
                            Store (0x00, ^CRT._DGS)
                        }
                    }

                    Method (USTS, 0, NotSerialized)
                    {
                        And (^LCD._DCS, 0xFFFFFFFD, ^LCD._DCS)
                        Or (^LCD._DCS, ShiftLeft (LDCS, 0x01), ^LCD._DCS)
                        And (^CRT._DCS, 0xFFFFFFFD, ^CRT._DCS)
                        If (And (CDCS, 0x01))
                        {
                            If (LEqual (\_SB.PCI0.CRTS, 0x01))
                            {
                                Or (^CRT._DCS, 0x02, ^CRT._DCS)
                            }
                        }

                        EDGS ()
                    }

                    Method (SWIT, 0, NotSerialized)
                    {
                        USTS ()
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x02)
                        {
                            0x00010100, 
                            0x00010110
                        })
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Name (_DCS, 0x1F)
                        Name (_DGS, 0x00)
                        Method (_DSS, 1, NotSerialized)
                        {
                            If (And (Arg0, 0x40000000))
                            {
                                And (Arg0, 0x01, LDCS)
                                If (And (Arg0, 0x80000000))
                                {
                                    ^^USTS ()
                                }
                            }
                            Else
                            {
                                And (Arg0, 0x01, LDCS)
                                If (And (Arg0, 0x80000000))
                                {
                                    ^^SWIT ()
                                }
                            }
                        }
                    }

                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Name (_DGS, 0x00)
                        Name (_DCS, 0x0F)
                        Method (_DSS, 1, NotSerialized)
                        {
                            If (And (Arg0, 0x40000000))
                            {
                                And (Arg0, 0x01, CDCS)
                                If (And (Arg0, 0x80000000))
                                {
                                    ^^USTS ()
                                }
                            }
                            Else
                            {
                                And (Arg0, 0x01, CDCS)
                                If (And (Arg0, 0x80000000))
                                {
                                    ^^SWIT ()
                                }
                            }
                        }
                    }
                }
            }

            Device (PIB)
            {
                Name (_ADR, 0x00070000)
                OperationRegion (IRQR, PCI_Config, 0x00, 0x88)
                Field (IRQR, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x48), 
                        ,   2, 
                    EUSB,   1, 
                    Offset (0x50), 
                    FDDA,   2, 
                    LPDA,   2, 
                    Offset (0x51), 
                    FDIQ,   4, 
                    LPIQ,   4, 
                    SAIQ,   4, 
                    SBIQ,   4, 
                    Offset (0x55), 
                        ,   4, 
                    PIRA,   4, 
                    PIRB,   4, 
                    PIRC,   4, 
                        ,   4, 
                    PIRD,   4, 
                    Offset (0x81), 
                    PDC1,   8, 
                    PDC2,   8, 
                    PDC3,   8, 
                    PDC4,   8, 
                        ,   2, 
                    EXFA,   1, 
                    EXFM,   1, 
                    ESB1,   1
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
                            Memory32Fixed (ReadOnly, 0x000DC000, 0x00004000)
                            Memory32Fixed (ReadOnly, 0x000E0000, 0x00020000)
                            Memory32Fixed (ReadOnly, 0xFFFE0000, 0x00020000)
                        })
                        Return (SMEM)
                    }
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x00A8, 0x00A8, 0x01, 0x02)
                        IO (Decode16, 0x0220, 0x0220, 0x01, 0x10)
                        IO (Decode16, 0x0388, 0x0388, 0x01, 0x04)
                        IO (Decode16, 0x8000, 0x8000, 0x01, 0x90)
                        IO (Decode16, 0x9050, 0x9050, 0x01, 0x02)
                        IO (Decode16, 0x6800, 0x6800, 0x01, 0x80)
                        IO (Decode16, 0x0370, 0x0370, 0x01, 0x02)
                    })
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

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {9,10,12}
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
                        IRQ (Level, ActiveLow, Shared) {9,10,12}
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
                        IRQ (Level, ActiveLow, Shared) {9,10,12}
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
                        IRQ (Level, ActiveLow, Shared) {9,10,12}
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

                OperationRegion (SMC1, SystemIO, 0x0370, 0x02)
                Field (SMC1, ByteAcc, NoLock, Preserve)
                {
                    INDX,   8, 
                    DATA,   8
                }

                Method (ENFG, 0, NotSerialized)
                {
                    Store (0x55, INDX)
                }

                Method (EXFG, 0, NotSerialized)
                {
                    Store (0xAA, INDX)
                }

                Device (UAR1)
                {
                    Name (_HID, EisaId ("PNP0501"))
                    Name (_UID, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x24, INDX)
                        Store (DATA, Local0)
                        Store (0x28, INDX)
                        Store (DATA, Local1)
                        And (Local1, 0xF0, Local1)
                        If (LNot (LEqual (Local1, 0x00)))
                        {
                            If (LNot (LEqual (Local0, 0x00)))
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
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF1, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            IRQNoFlags () {}
                        })
                        CreateByteField (BUF1, 0x02, IOLO)
                        CreateByteField (BUF1, 0x03, IOHI)
                        CreateByteField (BUF1, 0x04, IORL)
                        CreateByteField (BUF1, 0x05, IORH)
                        CreateWordField (BUF1, 0x09, IRQL)
                        ENFG ()
                        Store (0x24, INDX)
                        Store (DATA, Local0)
                        If (LEqual (Local0, 0xFE))
                        {
                            Store (0xF8, IOLO)
                            Store (0xF8, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                        }

                        If (LEqual (Local0, 0xBE))
                        {
                            Store (0xF8, IOLO)
                            Store (0xF8, IORL)
                            Store (0x02, IOHI)
                            Store (0x02, IORH)
                        }

                        If (LEqual (Local0, 0xFA))
                        {
                            Store (0xE8, IOLO)
                            Store (0xE8, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                        }

                        If (LEqual (Local0, 0xBA))
                        {
                            Store (0xE8, IOLO)
                            Store (0xE8, IORL)
                            Store (0x02, IOHI)
                            Store (0x02, IORH)
                        }

                        Store (0x28, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        ShiftRight (Local0, 0x04, Local0)
                        Store (0x01, IRQL)
                        ShiftLeft (IRQL, Local0, IRQL)
                        EXFG ()
                        Return (BUF1)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x00, 0x08)
                            IRQNoFlags () {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x00, 0x08)
                            IRQNoFlags () {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x00, 0x08)
                            IRQNoFlags () {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x00, 0x08)
                            IRQNoFlags () {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateWordField (Arg0, 0x09, IRQL)
                        ENFG ()
                        If (LEqual (IOLO, 0xF8))
                        {
                            If (LEqual (IOHI, 0x03))
                            {
                                Store (0xFE, Local0)
                            }
                            Else
                            {
                                Store (0xBE, Local0)
                            }
                        }
                        Else
                        {
                            If (LEqual (IOHI, 0x03))
                            {
                                Store (0xFA, Local0)
                            }
                            Else
                            {
                                Store (0xBA, Local0)
                            }
                        }

                        Store (0x24, INDX)
                        Store (Local0, DATA)
                        Store (0x28, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        If (LEqual (IRQL, 0x00))
                        {
                            Store (0x00, Local1)
                        }
                        Else
                        {
                            FindSetRightBit (IRQL, Local1)
                            Subtract (Local1, 0x01, Local1)
                        }

                        ShiftLeft (Local1, 0x04, Local1)
                        Or (Local1, Local0, Local0)
                        Store (0x28, INDX)
                        Store (Local0, DATA)
                        EXFG ()
                    }

                    Name (_PRW, Package (0x02)
                    {
                        0x08, 
                        0x04
                    })
                }

                Device (FRIO)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x02)
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x02, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x80, Local0)
                        Store (0x2B, INDX)
                        Store (DATA, Local1)
                        Store (0x2C, INDX)
                        And (DATA, 0x0F, Local2)
                        If (LEqual (Local0, 0x80))
                        {
                            If (LNot (LEqual (Local2, 0x0F)))
                            {
                                If (LNot (LEqual (Local1, 0x00)))
                                {
                                    EXFG ()
                                    Return (0x0F)
                                }
                                Else
                                {
                                    EXFG ()
                                    Return (0x00)
                                }
                            }
                            Else
                            {
                                EXFG ()
                                Return (0x00)
                            }
                        }
                        Else
                        {
                            EXFG ()
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0958, 0x0958, 0x01, 0x08)
                    })
                }

                Device (FIR)
                {
                    Name (_HID, EisaId ("SMCF010"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x0C, INDX)
                        Store (0x0E, DATA)
                        Store (0x0A, INDX)
                        Store (0x40, DATA)
                        Store (0x02, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x80, Local0)
                        Store (0x2C, INDX)
                        Store (DATA, Local1)
                        And (Local1, 0x0F, Local1)
                        Store (0x25, INDX)
                        Store (DATA, Local3)
                        If (LEqual (Local0, 0x80))
                        {
                            If (LNot (LEqual (Local1, 0x0F)))
                            {
                                If (LNot (LEqual (Local3, 0x00)))
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
                                Return (0x00)
                            }
                        }
                        Else
                        {
                            EXFG ()
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            Store ("Win2000 FIR", Debug)
                        }
                        Else
                        {
                            ENFG ()
                            Store (0x25, INDX)
                            Store (0x00, DATA)
                            Store (0x2B, INDX)
                            Store (0x00, DATA)
                            EXFG ()
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF2, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            IRQNoFlags () {}
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            DMA (Compatibility, NotBusMaster, Transfer8) {0,1}
                        })
                        CreateByteField (BUF2, 0x02, IOLL)
                        CreateByteField (BUF2, 0x03, IOLH)
                        CreateByteField (BUF2, 0x04, IOHL)
                        CreateByteField (BUF2, 0x05, IOHH)
                        CreateByteField (BUF2, 0x0D, IRC1)
                        CreateByteField (BUF2, 0x0E, IRC2)
                        CreateByteField (BUF2, 0x0F, IRC3)
                        CreateByteField (BUF2, 0x10, IRC4)
                        CreateWordField (BUF2, 0x09, IRQL)
                        CreateByteField (BUF2, 0x14, DMAC)
                        ENFG ()
                        Store (0x25, INDX)
                        Store (DATA, Local0)
                        ShiftLeft (Local0, 0x02, Local0)
                        Store (Local0, Local1)
                        And (Local0, 0xFF, Local0)
                        ShiftRight (Local1, 0x08, Local1)
                        Store (Local0, IOLL)
                        Store (Local0, IOHL)
                        Store (Local1, IOLH)
                        Store (Local1, IOHH)
                        Store (0x2B, INDX)
                        Store (DATA, Local0)
                        If (LEqual (Local0, 0x2B))
                        {
                            Store (0x58, IRC1)
                            Store (0x58, IRC3)
                            Store (0x01, IRC2)
                            Store (0x01, IRC4)
                        }

                        If (LEqual (Local0, 0x2C))
                        {
                            Store (0x60, IRC1)
                            Store (0x60, IRC3)
                            Store (0x01, IRC2)
                            Store (0x01, IRC4)
                        }

                        If (LEqual (Local0, 0x2D))
                        {
                            Store (0x68, IRC1)
                            Store (0x68, IRC3)
                            Store (0x01, IRC2)
                            Store (0x01, IRC4)
                        }

                        Store (0x2C, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Store (0x02, DMAC)
                        }

                        If (LEqual (Local0, 0x02))
                        {
                            Store (0x08, DMAC)
                        }

                        If (LEqual (Local0, 0x03))
                        {
                            Store (0x01, DMAC)
                        }

                        Store (0x28, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        Store (0x01, IRQL)
                        ShiftLeft (IRQL, Local0, IRQL)
                        EXFG ()
                        Return (BUF2)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x00, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x00, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x00, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x00, 0x08)
                        }
                        EndDependentFn ()
                        IRQNoFlags () {3,4}
                        IO (Decode16, 0x0158, 0x016F, 0x08, 0x08)
                        DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x02, IOLP)
                        CreateWordField (Arg0, 0x0D, IRPO)
                        CreateWordField (Arg0, 0x09, IRQL)
                        CreateByteField (Arg0, 0x14, DMAC)
                        ENFG ()
                        Store (0x02, INDX)
                        Store (DATA, Local0)
                        Store (0x02, INDX)
                        Or (Local0, 0x80, DATA)
                        Store (0x25, INDX)
                        ShiftRight (IOLP, 0x02, DATA)
                        Store (0x2B, INDX)
                        ShiftRight (IRPO, 0x03, DATA)
                        Store (0x2C, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        If (LEqual (DMAC, 0x01))
                        {
                            Or (Local0, 0x03, Local0)
                        }

                        If (LEqual (DMAC, 0x02))
                        {
                            Or (Local0, 0x00, Local0)
                        }

                        If (LEqual (DMAC, 0x08))
                        {
                            Or (Local0, 0x02, Local0)
                        }

                        Store (0x2C, INDX)
                        Store (Local0, DATA)
                        Store (0x28, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        FindSetRightBit (IRQL, Local1)
                        Subtract (Local1, 0x01, Local1)
                        Or (Local1, Local0, Local0)
                        Store (0x28, INDX)
                        Store (Local0, DATA)
                        EXFG ()
                    }
                }

                Device (LPT1)
                {
                    Name (_HID, EisaId ("PNP0400"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x04, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x02, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Store (0x23, INDX)
                            Store (DATA, Local0)
                            Store (0x01, INDX)
                            Store (DATA, Local1)
                            And (Local1, 0x04, Local1)
                            If (LNot (LEqual (Local1, 0x00)))
                            {
                                If (LNot (LEqual (Local0, 0x00)))
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
                                Return (0x00)
                            }
                        }
                        Else
                        {
                            EXFG ()
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x23, INDX)
                        Store (0x00, DATA)
                        EXFG ()
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF4, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            IRQNoFlags () {}
                        })
                        CreateByteField (BUF4, 0x02, IOLO)
                        CreateByteField (BUF4, 0x03, IOHI)
                        CreateByteField (BUF4, 0x04, IORL)
                        CreateByteField (BUF4, 0x05, IORH)
                        CreateByteField (BUF4, 0x07, IOLN)
                        CreateWordField (BUF4, 0x09, IRQL)
                        ENFG ()
                        Store (0x23, INDX)
                        Store (DATA, Local0)
                        If (LEqual (Local0, 0xDE))
                        {
                            Store (0x78, IOLO)
                            Store (0x78, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                            Store (0x08, IOLN)
                        }

                        If (LEqual (Local0, 0x9E))
                        {
                            Store (0x78, IOLO)
                            Store (0x78, IORL)
                            Store (0x02, IOHI)
                            Store (0x02, IORH)
                            Store (0x08, IOLN)
                        }

                        If (LEqual (Local0, 0xEF))
                        {
                            Store (0xBC, IOLO)
                            Store (0xBC, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                            Store (0x04, IOLN)
                        }

                        Store (0x27, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        If (LNot (LEqual (Local0, 0x00)))
                        {
                            Store (0x01, IRQL)
                            ShiftLeft (IRQL, Local0, IRQL)
                        }
                        Else
                        {
                            Store (Local0, IRQL)
                        }

                        EXFG ()
                        Return (BUF4)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                            IRQNoFlags () {5,7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                            IRQNoFlags () {5,7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x00, 0x04)
                            IRQNoFlags () {5,7}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateWordField (Arg0, 0x09, IRQL)
                        ENFG ()
                        If (LEqual (IOLO, 0xBC))
                        {
                            Store (0xEF, Local0)
                        }
                        Else
                        {
                            If (LEqual (IOHI, 0x03))
                            {
                                Store (0xDE, Local0)
                            }
                            Else
                            {
                                If (LEqual (IOHI, 0x02))
                                {
                                    Store (0x9E, Local0)
                                }
                                Else
                                {
                                    Store (0x00, Local0)
                                }
                            }
                        }

                        If (LNot (LEqual (Local0, 0x00)))
                        {
                            Store (0x23, INDX)
                            Store (Local0, DATA)
                        }

                        Store (0x27, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        If (LEqual (IRQL, 0x00))
                        {
                            Store (0x00, Local1)
                        }
                        Else
                        {
                            FindSetRightBit (IRQL, Local1)
                            Subtract (Local1, 0x01, Local1)
                        }

                        Or (Local1, Local0, Local0)
                        Store (0x27, INDX)
                        Store (Local0, DATA)
                        EXFG ()
                    }
                }

                Device (ECP1)
                {
                    Name (_HID, EisaId ("PNP0401"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x04, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x02, Local0)
                        If (LEqual (Local0, 0x02))
                        {
                            Store (0x23, INDX)
                            Store (DATA, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
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
                            Return (0x00)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x23, INDX)
                        Store (0x00, DATA)
                        EXFG ()
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF6, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x08)
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x04)
                            IRQNoFlags () {}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                        })
                        CreateByteField (BUF6, 0x02, IOLO)
                        CreateByteField (BUF6, 0x03, IOHI)
                        CreateByteField (BUF6, 0x04, IORL)
                        CreateByteField (BUF6, 0x05, IORH)
                        CreateByteField (BUF6, 0x07, IOLN)
                        CreateByteField (BUF6, 0x0A, IOEL)
                        CreateByteField (BUF6, 0x0B, IOEH)
                        CreateByteField (BUF6, 0x0C, IOML)
                        CreateByteField (BUF6, 0x0D, IOMH)
                        CreateByteField (BUF6, 0x0F, IOHN)
                        CreateWordField (BUF6, 0x11, IRQL)
                        CreateByteField (BUF6, 0x14, DMAC)
                        ENFG ()
                        Store (0x23, INDX)
                        Store (DATA, Local0)
                        If (LEqual (Local0, 0xDE))
                        {
                            Store (0x78, IOLO)
                            Store (0x78, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                            Store (0x08, IOLN)
                        }

                        If (LEqual (Local0, 0x9E))
                        {
                            Store (0x78, IOLO)
                            Store (0x78, IORL)
                            Store (0x02, IOHI)
                            Store (0x02, IORH)
                            Store (0x08, IOLN)
                        }

                        If (LEqual (Local0, 0xEF))
                        {
                            Store (0xBC, IOLO)
                            Store (0xBC, IORL)
                            Store (0x03, IOHI)
                            Store (0x03, IORH)
                            Store (0x04, IOLN)
                        }

                        Store (IOLO, IOEL)
                        Store (IOLO, IOML)
                        Or (IOHI, 0x04, IOEH)
                        Or (IOHI, 0x04, IOMH)
                        Store (0x27, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        Store (0x01, IRQL)
                        ShiftLeft (IRQL, Local0, IRQL)
                        Store (0x26, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0x0F, Local0)
                        If (LEqual (Local0, 0x00))
                        {
                            Store (0x02, DMAC)
                        }

                        If (LEqual (Local0, 0x02))
                        {
                            Store (0x08, DMAC)
                        }

                        If (LEqual (Local0, 0x03))
                        {
                            Store (0x01, DMAC)
                        }

                        EXFG ()
                        Return (BUF6)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                            IO (Decode16, 0x0778, 0x0778, 0x00, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                            IO (Decode16, 0x0678, 0x0678, 0x00, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x00, 0x04)
                            IO (Decode16, 0x07BC, 0x07BC, 0x00, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateByteField (Arg0, 0x14, DMAC)
                        CreateWordField (Arg0, 0x11, IRQL)
                        ENFG ()
                        If (LEqual (IOLO, 0xBC))
                        {
                            Store (0xEF, Local0)
                        }
                        Else
                        {
                            If (LEqual (IOHI, 0x03))
                            {
                                Store (0xDE, Local0)
                            }
                            Else
                            {
                                Store (0x9E, Local0)
                            }
                        }

                        Store (0x23, INDX)
                        Store (Local0, DATA)
                        Store (0x27, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        If (LEqual (IRQL, 0x00))
                        {
                            Store (0x00, Local1)
                        }
                        Else
                        {
                            FindSetRightBit (IRQL, Local1)
                            Subtract (Local1, 0x01, Local1)
                        }

                        Or (Local1, Local0, Local0)
                        Store (0x27, INDX)
                        Store (Local0, DATA)
                        Store (0x26, INDX)
                        Store (DATA, Local0)
                        And (Local0, 0xF0, Local0)
                        If (LEqual (DMAC, 0x01))
                        {
                            Or (Local0, 0x03, Local0)
                        }

                        If (LEqual (DMAC, 0x02))
                        {
                            Or (Local0, 0x00, Local0)
                        }

                        If (LEqual (DMAC, 0x08))
                        {
                            Or (Local0, 0x02, Local0)
                        }

                        Store (0x26, INDX)
                        Store (Local0, DATA)
                        EXFG ()
                    }
                }

                Device (FDC0)
                {
                    OperationRegion (LS12, SystemMemory, 0x04EA, 0x01)
                    Field (LS12, ByteAcc, NoLock, Preserve)
                    {
                            ,   2, 
                        LSON,   1
                    }

                    Name (_HID, EisaId ("PNP0700"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x20, INDX)
                        Store (DATA, Local0)
                        If (LNot (LEqual (Local0, 0x00)))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            If (LSON)
                            {
                                Return (0x00)
                            }
                            Else
                            {
                                Return (0x0D)
                            }

                            Return (0x0D)
                        }

                        EXFG ()
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (0x20, INDX)
                        Store (0x00, DATA)
                        EXFG ()
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x04)
                            IO (Decode16, 0x0000, 0x0000, 0x00, 0x01)
                            IRQNoFlags () {}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                        })
                        CreateByteField (BUF0, 0x02, IOLO)
                        CreateByteField (BUF0, 0x03, IOHI)
                        CreateByteField (BUF0, 0x04, IORL)
                        CreateByteField (BUF0, 0x05, IORH)
                        CreateByteField (BUF0, 0x0A, ILO1)
                        CreateByteField (BUF0, 0x0B, IHI1)
                        CreateByteField (BUF0, 0x0C, IRL1)
                        CreateByteField (BUF0, 0x0D, IRH1)
                        CreateByteField (BUF0, 0x11, IRQL)
                        CreateByteField (BUF0, 0x14, DMAV)
                        Store (0xF2, IOLO)
                        Store (0xF2, IORL)
                        Store (0x03, IOHI)
                        Store (0x03, IORH)
                        Store (0xF7, ILO1)
                        Store (0xF7, IRL1)
                        Store (0x03, IHI1)
                        Store (0x03, IRH1)
                        ShiftLeft (0x01, 0x06, IRQL)
                        ShiftLeft (0x01, 0x02, DMAV)
                        Return (BUF0)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03F2, 0x03F2, 0x00, 0x04)
                            IO (Decode16, 0x03F7, 0x03F7, 0x00, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateWordField (Arg0, 0x11, IRQL)
                        CreateByteField (Arg0, 0x14, DMAV)
                        ENFG ()
                        Store (0x20, INDX)
                        Store (0xFC, DATA)
                        EXFG ()
                    }

                    Name (BUF, Buffer (0x14)
                    {
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                        0x00, 0x00, 0x00, 0x00
                    })
                    Method (_FDE, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.PIB.FDC0.FDDA._STA (), Local0)
                        If (LEqual (Local0, 0x0F))
                        {
                            Store (Ones, Local0)
                        }
                        Else
                        {
                            Store (Zero, Local0)
                        }

                        CreateDWordField (BUF, 0x00, DRV0)
                        Store (Local0, DRV0)
                        Return (BUF)
                    }

                    Device (FDDA)
                    {
                        Name (_ADR, Zero)
                        Name (_RMV, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LNot (\_SB.PCI0.QFDD))
                            {
                                Return (0x08)
                            }

                            If (\_SB.PCI0.PM.PNFI)
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                If (LEqual (\_SB.PCI0.PM.BAYD, 0x00))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (0x08)
                                }
                            }
                        }

                        Name (D0IN, Package (0x10)
                        {
                            0x00, 
                            0x04, 
                            0x4F, 
                            0x12, 
                            0x01, 
                            0xAF, 
                            0x02, 
                            0x25, 
                            0x02, 
                            0x12, 
                            0x1B, 
                            0xFF, 
                            0x6C, 
                            0xF6, 
                            0x0F, 
                            0x05
                        })
                        Method (_FDI, 0, NotSerialized)
                        {
                            Return (D0IN)
                        }
                    }
                }

                Scope (_SB)
                {
                    Name (OKEC, 0x00)
                    Name (DFEC, 0x00)
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x01)
                    Name (BRIN, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store ("EC in _PS0 Status", Debug)
                        Store (0x00, \_SB.DFEC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x01, \_SB.DFEC)
                        Store ("EC in _PS3 Status", Debug)
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, \_SB.OKEC)
                        }
                    }

                    Name (FQSB, 0x00)
                    Name (FBAT, 0x00)
                    Name (FTMP, 0x00)
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
                        SMD0,   264, 
                        SMAA,   8, 
                        BATD,   16, 
                        ACDF,   1, 
                        Offset (0x45), 
                        LDP0,   1, 
                        Offset (0x47), 
                        LDP1,   1, 
                        Offset (0x49), 
                        LIDS,   1, 
                        Offset (0x4C), 
                        MBTS,   1, 
                        MBTF,   1, 
                            ,   4, 
                        MBTD,   1, 
                        Offset (0x4D), 
                        SBTS,   1, 
                        SBTF,   1, 
                            ,   4, 
                        SBTD,   1, 
                        Offset (0x4F), 
                        MBTC,   1, 
                        Offset (0x50), 
                        SBTC,   1, 
                        Offset (0x53), 
                        TMSS,   2, 
                            ,   2, 
                        BANK,   4, 
                        Offset (0x67), 
                        WEVN,   8, 
                        TMP,    8, 
                        Offset (0x80), 
                        CTMP,   8, 
                        Offset (0x83), 
                        STMP,   8, 
                        Offset (0x96), 
                        RG96,   16, 
                        Offset (0x9C), 
                        RG9C,   16, 
                        Offset (0xA1), 
                        PTIM,   8, 
                        Offset (0xA8), 
                        RGA8,   8, 
                        Offset (0xB9), 
                        ARMB,   2, 
                        Offset (0xC0), 
                        MBRM,   16, 
                        MFCC,   16, 
                        BCRN,   16, 
                        ABRM,   16, 
                        AFCC,   16, 
                        Offset (0xE4), 
                        LWP0,   1, 
                        Offset (0xE6), 
                        LWP1,   1, 
                        Offset (0xE8), 
                        LIDE,   1, 
                        BAYE,   1, 
                        EFDE,   1, 
                        PRDE,   1
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
                        Offset (0x40), 
                        ACIN,   1, 
                        Offset (0x4C), 
                        BATS,   16, 
                        Offset (0x4F), 
                        BATC,   16
                    }

                    Method (SMRD, 4, NotSerialized)
                    {
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

                        Acquire (BNKM, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
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
                                Store (SMD0, Arg3)
                            }
                        }

                        Release (BNKM)
                        Return (Local0)
                    }

                    Method (SMWR, 4, NotSerialized)
                    {
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

                        Acquire (BNKM, 0xFFFF)
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
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
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

                        Release (BNKM)
                        Return (Local0)
                    }

                    Mutex (BNKM, 0x00)
                    Name (EVNT, 0x00)
                    Name (BATN, 0x00)
                    Name (ACEV, 0x00)
                    Name (MBIE, 0x00)
                    Name (ABIE, 0x00)
                    Name (BATO, 0x00)
                    Name (BATF, 0xC0)
                    Name (BCNT, 0x00)
                    Name (AMOF, 0x00)
                    Method (_Q09, 0, NotSerialized)
                    {
                        Store ("_Q09", Debug)
                        If (LEqual (\_SB.PCI0.GWEN, 0x01))
                        {
                            If (LEqual (\_SB.PCI0.AGP.VGA.VW01, 0x00))
                            {
                                And (\_SB.PCI0.DMCX, 0x0F, Local0)
                                If (LEqual (Local0, 0x00))
                                {
                                    Store (Zero, \_SB.SSVW)
                                    \_SB.Z000 (0x89)
                                    Store (Zero, \_SB.PCI0.GWEN)
                                }
                                Else
                                {
                                    Store (0x04, \_SB.PCI0.TMR0)
                                    \_SB.Z000 (0x8D)
                                }
                            }
                            Else
                            {
                                Store (0x04, \_SB.PCI0.TMR0)
                                \_SB.Z000 (0x8D)
                            }
                        }

                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            Notify (\_TZ.THRM, 0x80)
                            Store (0x28, \_SB.PCI0.TMR0)
                            \_SB.Z000 (0x8D)
                        }
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        Store ("_Q20", Debug)
                        Acquire (BNKM, 0xFFFF)
                        Store (SMST, Local1)
                        And (Local1, 0x7F, Local1)
                        If (LEqual (Local1, 0x40))
                        {
                            And (SMST, 0xBF, SMST)
                            Store (SMAA, Local0)
                            Store (0x00, SMAA)
                            If (LEqual (Local0, 0x14))
                            {
                                SEL2 ()
                            }

                            If (LEqual (Local0, 0x16))
                            {
                                Store ("Address is 0x16 :Alarm and notify BAT1 00", Debug)
                                Notify (\_SB.BAT1, 0x00)
                                Notify (\_SB.BAT2, 0x00)
                            }
                        }
                        Else
                        {
                            Store (SMAA, Local0)
                        }

                        Release (BNKM)
                    }

                    Method (SEL2, 0, NotSerialized)
                    {
                        Store (BATD, BATN)
                        And (BATN, 0x01, Local0)
                        And (BATO, 0x01, Local1)
                        If (Not (LEqual (Local0, Local1)))
                        {
                            If (LEqual (Local0, 0x01))
                            {
                                Store (One, \_SB.MBT0)
                                Store (One, \_SB.PCI0.MBT1)
                            }
                            Else
                            {
                                Store (Zero, \_SB.MBT0)
                                Store (Zero, \_SB.PCI0.MBT1)
                            }

                            And (EVNT, 0xF8, EVNT)
                            Or (EVNT, 0x02, EVNT)
                            Store ("Notify Bat1 00", Debug)
                            Notify (\_SB.BAT1, 0x00)
                            Store (SizeOf (\_OS), Local5)
                            If (Not (Or (Or (LEqual (Local5, 0x14), LEqual (Local5, 0x11)), LEqual (Local5, 0x27))))
                            {
                                Notify (\_SB.BAT1, 0x81)
                                Notify (\_SB.BAT1, 0x80)
                            }
                        }
                        Else
                        {
                            And (BATN, 0x02, Local0)
                            And (BATO, 0x02, Local1)
                            If (Not (LEqual (Local0, Local1)))
                            {
                                If (LEqual (Local0, 0x02))
                                {
                                    Store (One, \_SB.SBT0)
                                    Store (One, \_SB.PCI0.SBT1)
                                }
                                Else
                                {
                                    Store (Zero, \_SB.SBT0)
                                    Store (Zero, \_SB.PCI0.SBT1)
                                }

                                And (EVNT, 0xF8, EVNT)
                                Or (EVNT, 0x04, EVNT)
                                Store ("Notify Bat2 00", Debug)
                                Notify (\_SB.BAT2, 0x00)
                                Store (SizeOf (\_OS), Local5)
                                If (Not (Or (Or (LEqual (Local5, 0x14), LEqual (Local5, 0x11)), LEqual (Local5, 0x27))))
                                {
                                    Notify (\_SB.BAT2, 0x81)
                                    Notify (\_SB.BAT2, 0x80)
                                }
                            }
                            Else
                            {
                                And (BATN, 0xC0, Local0)
                                And (BATO, 0xC0, Local1)
                                If (Not (LEqual (Local0, Local1)))
                                {
                                    If (LEqual (Local0, 0xC0))
                                    {
                                        Store (0x01, Local0)
                                        Store (One, \_SB.PCI0.ACON)
                                    }
                                    Else
                                    {
                                        Store (0x00, Local0)
                                        Store (Zero, \_SB.PCI0.ACON)
                                    }

                                    Store (Local0, \_SB.ACD0)
                                    If (LEqual (\_SB.PCI0.AGP.VGA.VW01, 0x00))
                                    {
                                        And (\_SB.PCI0.DMCX, 0x0F, Local0)
                                        If (LEqual (Local0, 0x00))
                                        {
                                            Store (Zero, \_SB.SSVW)
                                            \_SB.Z000 (0x89)
                                        }
                                        Else
                                        {
                                            Store (One, \_SB.PCI0.GWEN)
                                            Store (0x04, \_SB.PCI0.TMR0)
                                            \_SB.Z000 (0x8D)
                                        }
                                    }
                                    Else
                                    {
                                        Store (One, \_SB.PCI0.GWEN)
                                        Store (0x04, \_SB.PCI0.TMR0)
                                        \_SB.Z000 (0x8D)
                                    }

                                    And (EVNT, 0xF8, EVNT)
                                    Or (EVNT, 0x01, EVNT)
                                    Notify (\_SB.ACAD, 0x00)
                                }
                                Else
                                {
                                    If (LEqual (EVNT, 0x01))
                                    {
                                        Notify (\_SB.ACAD, 0x00)
                                    }

                                    If (LEqual (EVNT, 0x02))
                                    {
                                        Notify (\_SB.ACAD, 0x00)
                                    }

                                    If (LEqual (EVNT, 0x04))
                                    {
                                        Notify (\_SB.ACAD, 0x00)
                                    }

                                    Store (0x00, EVNT)
                                }
                            }
                        }

                        If (LNot (\_SB.BAT1.BFST))
                        {
                            Store (0x01, \_SB.BAT1.BFST)
                        }

                        If (LNot (\_SB.BAT2.BFST))
                        {
                            Store (0x01, \_SB.BAT1.BFST)
                        }

                        If (LNot (\_SB.ACAD.AFST))
                        {
                            Store (0x01, \_SB.ACAD.AFST)
                        }

                        Store (BATN, BATO)
                    }

                    Method (_Q8A, 0, NotSerialized)
                    {
                        Store ("Ext Dev Alarm: _Q8A", Debug)
                        If (BAYE)
                        {
                            Store ("- device bay -", Debug)
                            If (\_SB.OKEC)
                            {
                                Store (0x00, BAYE)
                            }

                            \_SB.Z000 (0x85)
                            Notify (\_SB.PCI0.IDE1.SECN.CDRM, 0x01)
                            If (\_SB.PCI0.QFDD)
                            {
                                Notify (\_SB.PCI0.PIB.FDC0.FDDA, 0x01)
                            }
                        }

                        If (EFDE)
                        {
                            Store ("-------- EXT FDD event  ------", Debug)
                            If (\_SB.OKEC)
                            {
                                \_SB.Z000 (0x85)
                                Store (0x00, EFDE)
                                If (\_SB.PCI0.QFDD)
                                {
                                    Notify (\_SB.PCI0.PIB.FDC0.FDDA, 0x01)
                                }
                            }
                        }
                    }

                    Method (_Q8B, 0, NotSerialized)
                    {
                        Acquire (\_SB.BAT1.MMTX, 0xFFFF)
                        \_SB.Z000 (0x8F)
                        Release (\_SB.BAT1.MMTX)
                    }

                    Method (_Q8C, 0, NotSerialized)
                    {
                        Acquire (\_SB.BAT2.AMTX, 0xFFFF)
                        \_SB.Z000 (0x95)
                        Release (\_SB.BAT2.AMTX)
                    }

                    Method (_Q0C, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            If (LEqual (\_SB.PCI0.AGP.VGA.DOSA, 0x00))
                            {
                                \_SB.Z000 (0x86)
                                Notify (\_SB.PCI0.AGP.VGA, 0x80)
                            }
                        }
                        Else
                        {
                            \_SB.Z000 (0x87)
                        }
                    }

                    Method (_Q0D, 0, NotSerialized)
                    {
                        Notify (\_SB.SLPB, 0x80)
                    }

                    Method (_Q80, 0, NotSerialized)
                    {
                        DBGS ("_Q80")
                        Store ("Temperature Up _Q80", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Method (_Q81, 0, NotSerialized)
                    {
                        DBGS ("_Q81")
                        Store ("Temperature Dn _Q80", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }
                }
            }

            Device (IDE1)
            {
                Name (_ADR, 0x00070001)
                OperationRegion (PCI, PCI_Config, 0x40, 0x04)
                Field (PCI, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                        ,   7, 
                    SIDE,   1
                }

                Device (PRIM)
                {
                    Name (_ADR, 0x00)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                    }
                }

                Device (SECN)
                {
                    Name (_ADR, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Device (CDRM)
                    {
                        Name (_ADR, 0x00)
                        Name (_RMV, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (\_SB.PCI0.PM.BAYD, 0x01))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x08)
                            }
                        }
                    }
                }

                Method (_PS0, 0, NotSerialized)
                {
                    Store (0x00, _PSC)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (0x03, _PSC)
                }

                Name (_PSC, 0x00)
                Name (_PR0, Package (0x01)
                {
                    PIDE
                })
            }

            PowerResource (PIDE, 0x00, 0x0000)
            {
                Name (IDES, 0x01)
                Method (_STA, 0, NotSerialized)
                {
                    Return (IDES)
                }

                Method (_ON, 0, NotSerialized)
                {
                    Store (One, IDES)
                }

                Method (_OFF, 0, NotSerialized)
                {
                    Store (Zero, IDES)
                }
            }

            Device (USB0)
            {
                Name (_ADR, 0x00070002)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x01
                })
                OperationRegion (SB72, PCI_Config, 0x00, 0xC2)
                Field (SB72, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x3C), 
                    UIRR,   4
                }

                Method (_STA, 0, NotSerialized)
                {
                    If (\_SB.PCI0.PIB.EUSB)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x00070003)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x01
                })
                OperationRegion (SB72, PCI_Config, 0x00, 0xC2)
                Field (SB72, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x3C), 
                    UBRR,   4
                }

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
            }

            Device (PM)
            {
                Name (_ADR, 0x00070004)
                OperationRegion (SB74, PCI_Config, 0x00, 0x0100)
                Field (SB74, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x44), 
                    PIR0,   8, 
                    PIR8,   8
                }

                OperationRegion (GPIO, SystemIO, 0x8048, 0x08)
                Field (GPIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x01), 
                        ,   1, 
                    BAYD,   2, 
                    PNFI,   1, 
                    Offset (0x04), 
                    GO00,   1, 
                    GO01,   1, 
                    GO02,   1, 
                    GO03,   1, 
                    GO04,   1, 
                    GO05,   1, 
                    GO06,   1, 
                    GO07,   1, 
                    GO08,   1, 
                    GO09,   1, 
                    GO10,   1, 
                    GO11,   1, 
                    GO12,   1, 
                    GO13,   1, 
                    GO14,   1, 
                    GO15,   1, 
                    GO16,   1, 
                    GO17,   1, 
                    GO18,   1, 
                    GO19,   1, 
                    GO20,   1, 
                    GO21,   1, 
                    GO22,   1, 
                    GO23,   1, 
                    GO24,   1, 
                    GO25,   1
                }

                OperationRegion (PMIO, SystemIO, 0x8000, 0x50)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                        ,   10, 
                    RTCS,   1, 
                    Offset (0x10), 
                    TRDC,   4, 
                    TREN,   1, 
                    Offset (0x22), 
                        ,   5, 
                    GPI5,   1, 
                    Offset (0x28), 
                        ,   7, 
                    PIRS,   1, 
                    Offset (0x2A), 
                        ,   7, 
                    PIEN,   1, 
                    Offset (0x2C), 
                        ,   7, 
                    LPOL,   1, 
                    Offset (0x2F), 
                    BCMD,   8, 
                    Offset (0x48), 
                    EXMI,   1, 
                        ,   2, 
                    LIDI,   1, 
                    Offset (0x49), 
                    CRTP,   1
                }

                OperationRegion (SMIO, SystemIO, 0x8080, 0x07)
                Field (SMIO, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8, 
                    SSTS,   8, 
                    CTLR,   8, 
                    CMDR,   8, 
                    ADDR,   8, 
                    DAT0,   8, 
                    DAT1,   8
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store ("$$$$$$$$$$$$$$$$$$$$$", Debug)
                    Stall (0x05)
                }

                Method (_PS0, 0, NotSerialized)
                {
                    Store ("######################", Debug)
                    Store (0x00, \_GPE.HKFG)
                }

                Name (_PR0, Package (0x01)
                {
                    PLPC
                })
                PowerResource (PLPC, 0x00, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x01)
                    }

                    Method (_ON, 0, NotSerialized)
                    {
                        Stall (0x05)
                    }

                    Method (_OFF, 0, NotSerialized)
                    {
                        Stall (0x05)
                    }
                }
            }

            Device (AUDI)
            {
                Name (_ADR, 0x00070005)
                OperationRegion (SB75, PCI_Config, 0x00, 0x85)
                Field (SB75, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x3C), 
                    MIRR,   8
                }

                Method (_STA, 0, NotSerialized)
                {
                    Store (\_SB.PCI0.PIB.EXFA, Local0)
                    And (Local0, 0x04, Local0)
                    If (Local0)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (PMOD)
            {
                Name (_ADR, 0x00090001)
                OperationRegion (PM00, PCI_Config, 0x00, 0x0100)
                Field (PM00, ByteAcc, NoLock, Preserve)
                {
                    Offset (0xE0), 
                    Offset (0xE1), 
                    MPME,   1, 
                        ,   6, 
                    MWAK,   1
                }
            }

            Device (PLOD)
            {
                Name (_ADR, 0x00090000)
                OperationRegion (PL00, PCI_Config, 0x00, 0x0100)
                Field (PL00, ByteAcc, NoLock, Preserve)
                {
                    Offset (0xE0), 
                    Offset (0xE1), 
                    LPME,   1, 
                        ,   6, 
                    LWAK,   1
                }
            }

            Device (CRD0)
            {
                Name (_ADR, 0x000A0000)
                Method (_INI, 0, NotSerialized)
                {
                    Or (PMEE, 0x01, PMEE)
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

                OperationRegion (CCRD, PCI_Config, 0x00, 0xA8)
                Field (CCRD, DWordAcc, Lock, Preserve)
                {
                    Offset (0x80), 
                    PMEE,   1, 
                    Offset (0x81), 
                    Offset (0xA4), 
                    PWST,   2, 
                    Offset (0xA5), 
                        ,   7, 
                    PMST,   1
                }
            }

            Device (CRD1)
            {
                Name (_ADR, 0x000A0001)
                Method (_INI, 0, NotSerialized)
                {
                    Or (PMEE, 0x01, PMEE)
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

                OperationRegion (CCRD, PCI_Config, 0x00, 0xA8)
                Field (CCRD, DWordAcc, Lock, Preserve)
                {
                    Offset (0x80), 
                    PMEE,   1, 
                    Offset (0x81), 
                    Offset (0xA4), 
                    PWST,   2, 
                    Offset (0xA5), 
                        ,   7, 
                    PMST,   1
                }
            }
        }
    }
}


--Boundary-00=_QRGVDWxxYz+2GTE--

 Internet Banda Ancha Todo el Dia desde $u 490 por mes!
 ______________________________________________________
 http://www.internet.com.uy - En Uruguay somos internet





-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
