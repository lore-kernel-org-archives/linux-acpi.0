From: Maximilian Mehnert <widolo87-LWAfsSFWpa4@public.gmane.org>
Subject: Help needed to fix my dsdt / running out of ideas
Date: Thu, 06 Oct 2005 18:51:34 +0200
Message-ID: <43455616.90501@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080902030904040803090108"
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

This is a multi-part message in MIME format.
--------------080902030904040803090108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello everyone!

I have fixed a few dsdts before so I am not completely new to this.

However I have no clue how to fix my current dsdt after it changed
because of a RAM upgrade.

Attached to this mail you find my decompiled dsdt and the output of iasl
trying to compile it again.

I would be extremely glad if someone with more insight into this matter
could give me a few advises to fix the first (and maybe the last) error.
Most of them seem to follow the same pattern so I should be able to do
most of this on my own...

Hoping for your help,

all the best,

Maximilian Mehnert


PS: This is from an Acer Travelmate 3002wtmi, the change in the dsdt
occured after upgrading to more than 1GB of ram.


--------------080902030904040803090108
Content-Type: text/plain;
 name="dsdt-highmem.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dsdt-highmem.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20050624
 *
 * Disassembly of dsdt-highmem, Thu Oct  6 17:41:21 2005
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "INTEL ", "ALVISO  ", 100925440)
{
    OperationRegion (PRT0, SystemIO, 0x80, 0x04)
    Field (PRT0, DWordAcc, Lock, Preserve)
    {
        P80H,   32
    }

    OperationRegion (IO_T, SystemIO, 0x0800, 0x10)
    Field (IO_T, ByteAcc, NoLock, Preserve)
    {
        Offset (0x02), 
        Offset (0x04), 
        Offset (0x06), 
        Offset (0x08), 
        TRP0,   8, 
        Offset (0x0A), 
        Offset (0x0B), 
        Offset (0x0C), 
        Offset (0x0D), 
        Offset (0x0E), 
        Offset (0x0F), 
        Offset (0x10)
    }

    OperationRegion (PMIO, SystemIO, 0x1000, 0x3C)
    Field (PMIO, ByteAcc, NoLock, Preserve)
    {
        Offset (0x28), 
            ,   1, 
        HOTS,   1, 
        Offset (0x2A), 
        BAYS,   2, 
        Offset (0x2B), 
            ,   3, 
        LIDS,   1, 
        Z000,   1, 
        Offset (0x2C), 
            ,   1, 
        HOTP,   1
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
        BAYO,   1, 
            ,   4, 
        GP21,   1, 
            ,   1, 
        BAYR,   1, 
            ,   1, 
        GP25,   1, 
        Offset (0x10), 
        Offset (0x18), 
        GB00,   8, 
        GB01,   8, 
        GB02,   8, 
        GB03,   8, 
        Offset (0x2C), 
        GIV0,   8, 
            ,   3, 
        LIDP,   1, 
        Z001,   1, 
        Offset (0x2E), 
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
        GP33,   1, 
        Offset (0x39), 
        GL05,   8, 
        GL06,   8, 
        GL07,   8
    }

    OperationRegion (MNVS, SystemMemory, 0x1F685D2C, 0x0100)
    Field (MNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        SCIF,   8, 
        PRM2,   8, 
        PRM3,   8, 
        Offset (0x09), 
        Offset (0x0A), 
        Offset (0x0B), 
        P80D,   32, 
        Offset (0x10), 
        Offset (0x11), 
        Offset (0x12), 
        Offset (0x14), 
        Offset (0x1E), 
        Offset (0x28), 
        APIC,   8, 
        CPUL,   8, 
        CPUH,   8, 
        GV3E,   8, 
        HTTE,   8, 
        WTHT,   8, 
        Offset (0x32), 
        Offset (0x3C), 
        IGDS,   8, 
        TLST,   8, 
        CADL,   8, 
        PADL,   8, 
        CSTE,   16, 
        NSTE,   16, 
        SSTE,   16, 
        NDID,   8, 
        DID1,   32, 
        DID2,   32, 
        DID3,   32, 
        DID4,   32, 
        DID5,   32, 
        Offset (0x67), 
        Offset (0x69), 
        Offset (0x6E), 
        Offset (0x78), 
        D400,   8, 
        Offset (0x82), 
        GTF0,   56, 
        GTF2,   56, 
        IDEM,   8
    }

    OperationRegion (RCRB, SystemMemory, 0xF0008000, 0x4000)
    Field (RCRB, DWordAcc, Lock, Preserve)
    {
        Offset (0x1000), 
        Offset (0x3000), 
        Offset (0x3404), 
        HPAS,   2, 
            ,   5, 
        HPAE,   1, 
        Offset (0x3418), 
            ,   1, 
        PATD,   1, 
        SATD,   1, 
        SMBD,   1, 
        AZAD,   1, 
        A97D,   1, 
        Offset (0x341A), 
        RP1D,   1, 
        RP2D,   1, 
        RP3D,   1, 
        RP4D,   1
    }

    Mutex (MUTX, 0x00)
    Name (_S0, Package (0x03)
    {
        Zero, 
        Zero, 
        Zero
    })
    Name (_S3, Package (0x03)
    {
        0x05, 
        0x05, 
        Zero
    })
    Name (_S4, Package (0x03)
    {
        0x06, 
        0x06, 
        Zero
    })
    Name (_S5, Package (0x03)
    {
        0x07, 
        0x07, 
        Zero
    })
    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06) {}
        Processor (CPU1, 0x01, 0x00001010, 0x06) {}
    }

    Name (DSEN, Zero)
    Name (ECON, Zero)
    Name (GPIC, Zero)
    Name (CTYP, Zero)
    Name (L01C, Zero)
    Name (INSX, Zero)
    Method (_PIC, 1, NotSerialized)
    {
        Store (Arg0, GPIC)
    }

    Method (_PTS, 1, NotSerialized)
    {
        Store (Zero, P80D)
        P8XH (Zero, Arg0)
        If (LEqual (Arg0, 0x04))
        {
            Store (One, INS4)
            Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
            Store (One, \_SB.PCI0.LPCB.EC0.FLS4)
            Release (\_SB.PCI0.LPCB.EC0.MUT1)
        }

        If (\_SB.ECOK)
        {
            Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
            If (LEqual (\_SB.PCI0.PCIB.LANC.LANP, Zero))
            {
                Store (Zero, \_SB.PCI0.LPCB.EC0.VAUX)
            }
            Else
            {
                Store (One, \_SB.PCI0.LPCB.EC0.VAUX)
            }

            Release (\_SB.PCI0.LPCB.EC0.MUT1)
        }

        \_SB.PHSR (0x08, Zero)
        Store (Zero, HOTP)
    }

    Method (_WAK, 1, NotSerialized)
    {
        P8XH (Zero, Zero)
        If (LEqual (Arg0, 0x03))
        {
            \_SB.PHSR (Zero, Zero)
            Store (One, INSX)
        }

        If (LEqual (Arg0, 0x04))
        {
            \_SB.PHSR (0x09, Zero)
            Store (Zero, INS4)
        }

        \_SB.PHSR (0x08, One)
        If (Z001)
        {
            If (LEqual (\_SB.PCI0.DOCK.DCKS, Zero))
            {
                XOr (Z001, One, Z001)
                Store (Zero, Z001)
            }
        }
        Else
        {
            If (LEqual (\_SB.PCI0.DOCK.DCKS, One))
            {
                XOr (Z001, One, Z001)
                Store (One, Z001)
            }
        }

        If (LOr (LEqual (Arg0, 0x04), LEqual (Arg0, 0x03)))
        {
            Store (\_SB.BTEN, \_SB.PCI0.LPCB.EC0.BLTH)
            Store (\_SB.WLAN, \_SB.PCI0.LPCB.EC0.WLAN)
            Store (One, \_SB.PCI0.LPCB.EC0.CPLE)
        }

        Return (Package (0x02)
        {
            Zero, 
            Zero
        })
    }

    Scope (_GPE)
    {
        Method (_L01, 0, NotSerialized)
        {
            Add (L01C, One, L01C)
            P8XH (Zero, One)
            P8XH (One, L01C)
            Sleep (0x64)
            If (\_SB.PCI0.RP01.HPCS)
            {
                If (\_SB.PCI0.RP01.PDC1)
                {
                    Store (One, \_SB.PCI0.RP01.PDC1)
                }

                Store (One, \_SB.PCI0.RP01.HPCS)
                Sleep (0x64)
                Notify (\_SB.PCI0.RP01, Zero)
                Sleep (0x64)
            }

            If (\_SB.PCI0.RP02.HPCS)
            {
                If (\_SB.PCI0.RP02.PDC2)
                {
                    Store (One, \_SB.PCI0.RP02.PDC2)
                }

                Store (One, \_SB.PCI0.RP02.HPCS)
                Sleep (0x64)
                Notify (\_SB.PCI0.RP02, Zero)
                Sleep (0x64)
            }

            If (\_SB.PCI0.RP03.HPCS)
            {
                If (\_SB.PCI0.RP03.PDC3)
                {
                    Sleep (0x01F4)
                    \_SB.PHSR (0x07, Zero)
                    Sleep (0x01F4)
                    Store (Zero, INSX)
                    Store (One, \_SB.PCI0.RP03.PDC3)
                }

                Store (One, \_SB.PCI0.RP03.HPCS)
            }

            If (\_SB.PCI0.RP04.HPCS)
            {
                If (\_SB.PCI0.RP04.PDC4)
                {
                    Store (One, \_SB.PCI0.RP04.PDC4)
                }

                Store (One, \_SB.PCI0.RP04.HPCS)
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

        Method (_L05, 0, NotSerialized)
        {
            If (AZAD) {}
            Else
            {
                Notify (\_SB.PCI0.AZAL, 0x02)
            }
        }

        Method (_L09, 0, NotSerialized)
        {
            If (\_SB.PCI0.RP01.PSP1)
            {
                Store (One, \_SB.PCI0.RP01.PSP1)
                Store (One, \_SB.PCI0.RP01.PMCS)
                Notify (\_SB.PCI0.RP01, 0x02)
            }

            If (\_SB.PCI0.RP02.PSP2)
            {
                Store (One, \_SB.PCI0.RP02.PSP2)
                Store (One, \_SB.PCI0.RP02.PMCS)
                Notify (\_SB.PCI0.RP02, 0x02)
            }

            If (\_SB.PCI0.RP03.PSP3)
            {
                Store (One, \_SB.PCI0.RP03.PSP3)
                Store (One, \_SB.PCI0.RP03.PMCS)
                Notify (\_SB.PCI0.RP03, 0x02)
            }

            If (\_SB.PCI0.RP04.PSP4)
            {
                Store (One, \_SB.PCI0.RP04.PSP4)
                Store (One, \_SB.PCI0.RP04.PMCS)
                Notify (\_SB.PCI0.RP04, 0x02)
            }
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.PCIB, 0x02)
        }

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB3, 0x02)
        }

        Method (_L0D, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB7, 0x02)
        }

        Method (_L0E, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB4, 0x02)
        }

        Method (_L1B, 0, NotSerialized)
        {
            Notify (\_SB.LID, 0x80)
        }

        Method (_L1C, 0, NotSerialized)
        {
            Sleep (0x012C)
            Store (One, Z000)
            Store (Z000, Local1)
            If (LEqual (Local1, One))
            {
                Store (Z001, Local0)
                If (Local0)
                {
                    Or (CFGD, 0xC0, CFGD)
                    Notify (\_PR.CPU0, 0x81)
                    Sleep (0x012C)
                    Store (One, \_SB.PCI0.LPCB.C4C3)
                    Store (0x1C, P80H)
                    If (LEqual (\_SB.PCI0.RP03.Z002, One))
                    {
                        Store (0x1E, P80H)
                        Store (Zero, \_SB.PCI0.RP03.Z002)
                        Sleep (0x01F4)
                        Store (One, \_SB.PCI0.RP03.LDP3)
                        Notify (\_SB.PCI0.RP03, Zero)
                        Sleep (0x07D0)
                    }

                    Store (Zero, \_SB.PCI0.DOCK.DCKS)
                    Notify (\_SB.PCI0.DOCK, One)
                }
                Else
                {
                    And (CFGD, 0x3F, CFGD)
                    Notify (\_PR.CPU0, 0x81)
                    Sleep (0x012C)
                    Store (Zero, \_SB.PCI0.LPCB.C4C3)
                    Store (0x1D, P80H)
                    Store (One, \_SB.PCI0.DOCK.DCKS)
                    Store (Zero, \_SB.PCI0.RP03.LDP3)
                    Sleep (0x01F4)
                    Store (One, \_SB.PCI0.RP03.Z002)
                    Sleep (0x0BB8)
                    Notify (\_SB.PCI0.DOCK, Zero)
                }

                XOr (Z001, One, Z001)
            }
        }
    }

    Method (GETB, 3, Serialized)
    {
        Multiply (Arg0, 0x08, Local0)
        Multiply (Arg1, 0x08, Local1)
        CreateField (Arg2, Local0, Local1, TBF3)
        Return (TBF3)
    }

    Method (HKDS, 1, Serialized)
    {
        If (LEqual (Zero, DSEN))
        {
            Store (Arg0, SMIF)
            Store (Zero, TRP0)
            If (LEqual (SMIF, Zero))
            {
                If (LNot (LEqual (CADL, PADL)))
                {
                    Store (CADL, PADL)
                    If (LEqual (OSYS, 0x07D1))
                    {
                        Notify (\_SB.PCI0, Zero)
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.GFX0, Zero)
                    }

                    Sleep (0x02EE)
                }

                Notify (\_SB.PCI0.GFX0, 0x80)
            }
        }

        If (LEqual (One, DSEN))
        {
            Store (Increment (Arg0), SMIF)
            Store (Zero, TRP0)
            If (LEqual (SMIF, Zero))
            {
                Notify (\_SB.PCI0.GFX0, 0x81)
            }
        }
    }

    Method (LSDS, 1, Serialized)
    {
        If (Arg0)
        {
            HKDS (0x0C)
        }
        Else
        {
            HKDS (0x0E)
        }

        If (LNot (LEqual (DSEN, One)))
        {
            Sleep (0x32)
            While (LEqual (DSEN, 0x02))
            {
                Sleep (0x32)
            }
        }
    }

    Method (P8XH, 2, Serialized)
    {
        If (LEqual (Arg0, Zero))
        {
            Store (Or (And (P80D, 0xFFFFFF00), Arg1), P80D)
        }

        If (LEqual (Arg0, One))
        {
            Store (Or (And (P80D, 0xFFFF00FF), ShiftLeft (Arg1, 0x08)), P80D)
        }

        If (LEqual (Arg0, 0x02))
        {
            Store (Or (And (P80D, 0xFF00FFFF), ShiftLeft (Arg1, 0x10)), P80D)
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (Or (And (P80D, 0x00FFFFFF), ShiftLeft (Arg1, 0x18)), P80D)
        }

        Store (P80D, P80H)
    }

    Method (PNOT, 0, Serialized)
    {
        If (HTTE)
        {
            If (LEqual (And (PDC0, 0x0A), 0x0A))
            {
                Notify (\_PR.CPU0, 0x80)
            }

            If (LEqual (And (PDC1, 0x0A), 0x0A))
            {
                Notify (\_PR.CPU1, 0x80)
            }
        }
        Else
        {
            Notify (\_PR.CPU0, 0x80)
            Sleep (0x64)
            Notify (\_PR.CPU0, 0x81)
        }
    }

    Method (VTOB, 1, NotSerialized)
    {
        Store (One, Local0)
        ShiftLeft (Local0, Arg0, Local0)
        Return (Local0)
    }

    Method (BTOV, 1, NotSerialized)
    {
        ShiftRight (Arg0, One, Local0)
        Store (Zero, Local1)
        While (Local0)
        {
            Increment (Local1)
            ShiftRight (Local0, One, Local0)
        }

        Return (Local1)
    }

    Method (MKWD, 2, NotSerialized)
    {
        If (And (Arg1, 0x80))
        {
            Store (0xFFFF0000, Local0)
        }
        Else
        {
            Store (Zero, Local0)
        }

        Or (Local0, Arg0, Local0)
        Or (Local0, ShiftLeft (Arg1, 0x08), Local0)
        Return (Local0)
    }

    Method (POSW, 1, NotSerialized)
    {
        If (And (Arg0, 0x8000))
        {
            If (LEqual (Arg0, 0xFFFF))
            {
                Return (Ones)
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
        Store (Zero, Local2)
        Store (Zero, Local3)
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

    Method (GETP, 1, Serialized)
    {
        If (LEqual (And (Arg0, 0x09), Zero))
        {
            Return (Ones)
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

        Return (Ones)
    }

    Method (GETT, 1, Serialized)
    {
        Return (Multiply (0x1E, Subtract (0x09, Add (And (ShiftRight (Arg0, 0x02), 0x03), And (Arg0, 0x03)))))
    }

    Method (GETF, 3, Serialized)
    {
        Name (TMPF, Zero)
        If (Arg0)
        {
            Or (TMPF, One, TMPF)
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

                If (LAnd (LNot (LGreater (Arg0, 0xB4)), And (Arg2, One)))
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
            Return (One)
        }

        If (LNot (LGreater (Arg0, 0x1E)))
        {
            Return (0x02)
        }

        If (LNot (LGreater (Arg0, 0x2D)))
        {
            Return (One)
        }

        If (LNot (LGreater (Arg0, 0x3C)))
        {
            Return (0x02)
        }

        If (LNot (LGreater (Arg0, 0x5A)))
        {
            Return (One)
        }

        Return (Zero)
    }

    Method (SETT, 3, Serialized)
    {
        If (And (Arg1, 0x02))
        {
            If (LAnd (LNot (LGreater (Arg0, 0x78)), And (Arg2, 0x02)))
            {
                Return (0x0B)
            }

            If (LAnd (LNot (LGreater (Arg0, 0xB4)), And (Arg2, One)))
            {
                Return (0x09)
            }
        }

        Return (0x04)
    }

    OperationRegion (NV1, SystemIO, 0x72, 0x02)
    Field (NV1, ByteAcc, NoLock, Preserve)
    {
        INDX,   8, 
        DATA,   8
    }

    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
    {
        Offset (0x6E), 
        INS4,   1, 
        Offset (0x70), 
        DLST,   8
    }

    Scope (_SB)
    {
        Name (ECOK, Zero)
        Device (PCI0)
        {
            Method (_INI, 0, NotSerialized)
            {
                If (CondRefOf (_OSI, Local0))
                {
                    Store (0x07D1, OSYS)
                    If (HTTE)
                    {
                        Store (0x32, SMIF)
                        Store (Zero, TRP0)
                    }
                }
                Else
                {
                    If (LOr (LEqual (SizeOf (_OS), 0x14), LEqual (SizeOf (_OS), 0x05)))
                    {
                        Store (0x07D0, OSYS)
                        Store (0x35, SMIF)
                        Store (Zero, TRP0)
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
                    Store (One, ECON)
                    Store (0x2B, SMIF)
                    Store (Zero, TRP0)
                    PNOT ()
                }
            }

            Method (_S3D, 0, NotSerialized)
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)
            {
                Return (0x02)
            }

            Name (_HID, EisaId ("PNP0A08"))
            Name (_CID, 0x030AD041)
            Name (_ADR, Zero)
            Name (_BBN, Zero)
            OperationRegion (HBUS, PCI_Config, 0x40, 0xC0)
            Field (HBUS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x14), 
                    ,   1, 
                PEGA,   1, 
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
                    ,   7, 
                HENA,   1, 
                Offset (0x5C), 
                    ,   3, 
                TOUD,   5
            }

            Name (BUF0, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000, // Address Space Granularity
                    0x0000, // Address Range Minimum
                    0x00FF, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x0100,,,)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000, // Address Space Granularity
                    0x00000000, // Address Range Minimum
                    0x00000CF7, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00000CF8,,,
                    , TypeStatic)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000, // Address Space Granularity
                    0x00000D00, // Address Range Minimum
                    0x0000BFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x0000B300,,,
                    , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000A0000, // Address Range Minimum
                    0x000BFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00020000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000C0000, // Address Range Minimum
                    0x000C3FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000C4000, // Address Range Minimum
                    0x000C7FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000C8000, // Address Range Minimum
                    0x000CBFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000CC000, // Address Range Minimum
                    0x000CFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000D0000, // Address Range Minimum
                    0x000D3FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000D4000, // Address Range Minimum
                    0x000D7FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000D8000, // Address Range Minimum
                    0x000DBFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000DC000, // Address Range Minimum
                    0x000DFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000E0000, // Address Range Minimum
                    0x000E3FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000E4000, // Address Range Minimum
                    0x000E7FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000E8000, // Address Range Minimum
                    0x000EBFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000EC000, // Address Range Minimum
                    0x000EFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000F0000, // Address Range Minimum
                    0x000FFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00010000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x00000000, // Address Range Minimum
                    0xFEBFFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00000000,,,
                    , AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, Serialized)
            {
                If (PM1L)
                {
                    CreateDWordField (BUF0, 0x80, C0LN)
                    Store (Zero, C0LN)
                }

                If (LEqual (PM1L, One))
                {
                    CreateBitField (BUF0, 0x0378, C0RW)
                    Store (Zero, C0RW)
                }

                If (PM1H)
                {
                    CreateDWordField (BUF0, 0x9B, C4LN)
                    Store (Zero, C4LN)
                }

                If (LEqual (PM1H, One))
                {
                    CreateBitField (BUF0, 0x0450, C4RW)
                    Store (Zero, C4RW)
                }

                If (PM2L)
                {
                    CreateDWordField (BUF0, 0xB6, C8LN)
                    Store (Zero, C8LN)
                }

                If (LEqual (PM2L, One))
                {
                    CreateBitField (BUF0, 0x0528, C8RW)
                    Store (Zero, C8RW)
                }

                If (PM2H)
                {
                    CreateDWordField (BUF0, 0xD1, CCLN)
                    Store (Zero, CCLN)
                }

                If (LEqual (PM2H, One))
                {
                    CreateBitField (BUF0, 0x0600, CCRW)
                    Store (Zero, CCRW)
                }

                If (PM3L)
                {
                    CreateDWordField (BUF0, 0xEC, D0LN)
                    Store (Zero, D0LN)
                }

                If (LEqual (PM3L, One))
                {
                    CreateBitField (BUF0, 0x06D8, D0RW)
                    Store (Zero, D0RW)
                }

                If (PM3H)
                {
                    CreateDWordField (BUF0, 0x0107, D4LN)
                    Store (Zero, D4LN)
                }

                If (LEqual (PM3H, One))
                {
                    CreateBitField (BUF0, 0x07B0, D4RW)
                    Store (Zero, D4RW)
                }

                If (PM4L)
                {
                    CreateDWordField (BUF0, 0x0122, D8LN)
                    Store (Zero, D8LN)
                }

                If (LEqual (PM4L, One))
                {
                    CreateBitField (BUF0, 0x0888, D8RW)
                    Store (Zero, D8RW)
                }

                If (PM4H)
                {
                    CreateDWordField (BUF0, 0x013D, DCLN)
                    Store (Zero, DCLN)
                }

                If (LEqual (PM4H, One))
                {
                    CreateBitField (BUF0, 0x0960, DCRW)
                    Store (Zero, DCRW)
                }

                If (PM5L)
                {
                    CreateDWordField (BUF0, 0x0158, E0LN)
                    Store (Zero, E0LN)
                }

                If (LEqual (PM5L, One))
                {
                    CreateBitField (BUF0, 0x0A38, E0RW)
                    Store (Zero, E0RW)
                }

                If (PM5H)
                {
                    CreateDWordField (BUF0, 0x0173, E4LN)
                    Store (Zero, E4LN)
                }

                If (LEqual (PM5H, One))
                {
                    CreateBitField (BUF0, 0x0B10, E4RW)
                    Store (Zero, E4RW)
                }

                If (PM6L)
                {
                    CreateDWordField (BUF0, 0x018E, E8LN)
                    Store (Zero, E8LN)
                }

                If (LEqual (PM6L, One))
                {
                    CreateBitField (BUF0, 0x0BE8, E8RW)
                    Store (Zero, E8RW)
                }

                If (PM6H)
                {
                    CreateDWordField (BUF0, 0x01A9, ECLN)
                    Store (Zero, ECLN)
                }

                If (LEqual (PM6H, One))
                {
                    CreateBitField (BUF0, 0x0CC0, ECRW)
                    Store (Zero, ECRW)
                }

                If (PM0H)
                {
                    CreateDWordField (BUF0, 0x01C4, F0LN)
                    Store (Zero, F0LN)
                }

                If (LEqual (PM0H, One))
                {
                    CreateBitField (BUF0, 0x0D98, F0RW)
                    Store (Zero, F0RW)
                }

                CreateDWordField (BUF0, 0x01D3, M1MN)
                CreateDWordField (BUF0, 0x01D7, M1MX)
                CreateDWordField (BUF0, 0x01DF, M1LN)
                ShiftLeft (TOUD, 0x1B, M1MN)
                Add (Subtract (M1MX, M1MN), One, M1LN)
                Return (BUF0)
            }

            Device (PDRC)
            {
                Name (_HID, EisaId ("PNP0C02"))
                Name (_UID, One)
                Name (_CRS, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0xE0000000, 0x10000000)
                    Memory32Fixed (ReadWrite, 0xF0000000, 0x00004000)
                    Memory32Fixed (ReadWrite, 0xF0004000, 0x00001000)
                    Memory32Fixed (ReadWrite, 0xF0005000, 0x00001000)
                    Memory32Fixed (ReadWrite, 0xF0008000, 0x00004000)
                    Memory32Fixed (ReadWrite, 0xFED20000, 0x00070000)
                })
            }

            Method (_PRT, 0, NotSerialized)
            {
                If (GPIC)
                {
                    Return (Package (0x11)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0007FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001BFFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            Zero, 
                            Zero, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            One, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x02, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x03, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            Zero, 
                            Zero, 
                            0x17
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            One, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x02, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x03, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001EFFFF, 
                            Zero, 
                            Zero, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x001EFFFF, 
                            One, 
                            Zero, 
                            0x14
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            Zero, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            One, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x03, 
                            Zero, 
                            0x10
                        }
                    })
                }
                Else
                {
                    Return (Package (0x11)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            Zero, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            Zero, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0007FFFF, 
                            Zero, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001BFFFF, 
                            Zero, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            Zero, 
                            ^LPCB.LNKB, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            One, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x02, 
                            ^LPCB.LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x03, 
                            ^LPCB.LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            Zero, 
                            ^LPCB.LNKH, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            One, 
                            ^LPCB.LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x02, 
                            ^LPCB.LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x03, 
                            ^LPCB.LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001EFFFF, 
                            Zero, 
                            ^LPCB.LNKB, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001EFFFF, 
                            One, 
                            ^LPCB.LNKE, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            Zero, 
                            ^LPCB.LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            One, 
                            ^LPCB.LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x03, 
                            ^LPCB.LNKA, 
                            Zero
                        }
                    })
                }
            }

            Device (GFX0)
            {
                Name (_ADR, 0x00020000)
                Method (_STA, 0, NotSerialized)
                {
                    If (PEGA)
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                OperationRegion (VNVS, SystemMemory, 0x1F685E2C, 0x00010000)
                Field (VNVS, AnyAcc, Lock, Preserve)
                {
                    VBF1,   262144, 
                    VBF2,   262144
                }

                Method (_DOS, 1, NotSerialized)
                {
                    Store (And (Arg0, 0x03), DSEN)
                }

                Method (_DOD, 0, NotSerialized)
                {
                    If (LEqual (NDID, One))
                    {
                        Name (TMP1, Package (0x01)
                        {
                            Ones
                        })
                        Store (Or (0x00010000, DID1), Index (TMP1, Zero))
                        Return (TMP1)
                    }

                    If (LEqual (NDID, 0x02))
                    {
                        Name (TMP2, Package (0x02)
                        {
                            Ones, 
                            Ones
                        })
                        Store (Or (0x00010000, DID1), Index (TMP2, Zero))
                        Store (Or (0x00010000, DID2), Index (TMP2, One))
                        Return (TMP2)
                    }

                    If (LEqual (NDID, 0x03))
                    {
                        Name (TMP3, Package (0x03)
                        {
                            Ones, 
                            Ones, 
                            Ones
                        })
                        Store (Or (0x00010000, DID1), Index (TMP3, Zero))
                        Store (Or (0x00010000, DID2), Index (TMP3, One))
                        Store (Or (0x00010000, DID3), Index (TMP3, 0x02))
                        Return (TMP3)
                    }

                    If (LEqual (NDID, 0x04))
                    {
                        Name (TMP4, Package (0x04)
                        {
                            Ones, 
                            Ones, 
                            Ones, 
                            Ones
                        })
                        Store (Or (0x00010000, DID1), Index (TMP4, Zero))
                        Store (Or (0x00010000, DID2), Index (TMP4, One))
                        Store (Or (0x00010000, DID3), Index (TMP4, 0x02))
                        Store (Or (0x00010000, DID4), Index (TMP4, 0x03))
                        Return (TMP4)
                    }

                    Name (TMP5, Package (0x05)
                    {
                        Ones, 
                        Ones, 
                        Ones, 
                        Ones, 
                        Ones
                    })
                    Store (Or (0x00010000, DID1), Index (TMP5, Zero))
                    Store (Or (0x00010000, DID2), Index (TMP5, One))
                    Store (Or (0x00010000, DID3), Index (TMP5, 0x02))
                    Store (Or (0x00010000, DID4), Index (TMP5, 0x03))
                    Store (Or (0x00010000, DID5), Index (TMP5, 0x04))
                    Return (TMP5)
                }

                Method (_ROM, 2, NotSerialized)
                {
                    If (LNot (LLess (Arg0, 0x8000)))
                    {
                        Return (GETB (Subtract (Arg0, 0x8000), Arg1, VBF2))
                    }

                    If (LGreater (Add (Arg0, Arg1), 0x8000))
                    {
                        Subtract (0x8000, Arg0, Local0)
                        Subtract (Arg1, Local0, Local1)
                        Store (GETB (Arg0, Local0, VBF1), Local3)
                        Store (GETB (Zero, Local1, VBF2), Local4)
                        Concatenate (Local3, Local4, Local5)
                        Return (Local5)
                    }

                    Return (GETB (Arg0, Arg1, VBF1))
                }

                Device (DD01)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID1))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        Store (One, SMIF)
                        Store (Zero, TRP0)
                        If (And (CSTE, One))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, One))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD02)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID2))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        Store (One, SMIF)
                        Store (Zero, TRP0)
                        If (And (CSTE, 0x02))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x02))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD03)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID3))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        Store (One, SMIF)
                        Store (Zero, TRP0)
                        If (And (CSTE, 0x04))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x04))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD04)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID4))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        Store (One, SMIF)
                        Store (Zero, TRP0)
                        If (And (CSTE, 0x08))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x08))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD05)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID5))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        Store (One, SMIF)
                        Store (Zero, TRP0)
                        If (And (CSTE, 0x10))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x10))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }
            }

            Device (AZAL)
            {
                Name (_ADR, 0x001B0000)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x03
                })
            }

            Device (RP01)
            {
                Name (_ADR, 0x001C0000)
                OperationRegion (P1CS, PCI_Config, 0x40, 0x0100)
                Field (P1CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x1A), 
                    ABP1,   1, 
                        ,   2, 
                    PDC1,   1, 
                        ,   2, 
                    PDS1,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSP1,   1, 
                    Offset (0x9C), 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Device (PXS1)
                {
                    Name (_ADR, Zero)
                    Method (_RMV, 0, NotSerialized)
                    {
                        Return (One)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x04
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKD, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP02)
            {
                Name (_ADR, 0x001C0001)
                OperationRegion (P2CS, PCI_Config, 0x40, 0x0100)
                Field (P2CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x1A), 
                    ABP2,   1, 
                        ,   2, 
                    PDC2,   1, 
                        ,   2, 
                    PDS2,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSP2,   1, 
                    Offset (0x9C), 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Device (PXS2)
                {
                    Name (_ADR, Zero)
                    Method (_RMV, 0, NotSerialized)
                    {
                        Return (One)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x04
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKA, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP03)
            {
                Name (_ADR, 0x001C0002)
                OperationRegion (P3CS, PCI_Config, 0x40, 0x0100)
                Field (P3CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x10), 
                        ,   4, 
                    LDP3,   1, 
                    Offset (0x18), 
                        ,   5, 
                    HPI3,   1, 
                    Offset (0x19), 
                    PIC3,   2, 
                    PCC3,   1, 
                    Offset (0x1A), 
                    ABP3,   1, 
                        ,   2, 
                    PDC3,   1, 
                        ,   2, 
                    PDS3,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSP3,   1, 
                    Offset (0x9B), 
                        ,   6, 
                    Z002,   1, 
                    Z003,   1, 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Scope (^^PCI0)
                {
                    Device (DOCK)
                    {
                        Name (_HID, EisaId ("PNP0C15"))
                        Name (_UID, One)
                        Name (_BDN, "EZ4 ")
                        Name (DCKS, Zero)
                        Method (_DCK, 1, NotSerialized)
                        {
                            If (LEqual (Arg0, One))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Store (Zero, ^^RP03.Z002)
                                Store (One, ^^RP03.LDP3)
                            }
                        }

                        Method (_EJ0, 1, NotSerialized)
                        {
                            Store (One, HOTS)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (^^RP03.LDP3, One))
                            {
                                Return (Zero)
                            }
                            Else
                            {
                                If (DCKS)
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }
                        }
                    }
                }

                Device (PXHA)
                {
                    Name (_ADR, Zero)
                    OperationRegion (PXHR, PCI_Config, Zero, 0xC0)
                    Field (PXHR, DWordAcc, NoLock, Preserve)
                    {
                        PVID,   16, 
                        PDID,   16
                    }

                    Name (_EJD, "_SB.PCI0.DOCK")
                    Method (_INI, 0, NotSerialized)
                    {
                        If (LEqual (PDID, 0x032C))
                        {
                            Store (One, ^^^DOCK.DCKS)
                            And (CFGD, 0x3F, CFGD)
                            Notify (\_PR.CPU0, 0x81)
                            Sleep (0x012C)
                        }
                        Else
                        {
                            Store (Zero, ^^^DOCK.DCKS)
                            Store (Zero, Z002)
                            Store (One, LDP3)
                            Or (CFGD, 0xC0, CFGD)
                            Notify (\_PR.CPU0, 0x81)
                            Sleep (0x012C)
                        }
                    }

                    Name (_PSC, Zero)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (Zero, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Method (_PRT, 0, NotSerialized)
                    {
                        Return (Package (0x0A)
                        {
                            Package (0x04)
                            {
                                0x0002FFFF, 
                                Zero, 
                                Zero, 
                                0x18
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                One, 
                                Zero, 
                                0x19
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                0x02, 
                                Zero, 
                                0x1A
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                Zero, 
                                Zero, 
                                0x1B
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                One, 
                                Zero, 
                                0x1C
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x02, 
                                Zero, 
                                0x1D
                            }, 

                            Package (0x04)
                            {
                                0x0004FFFF, 
                                Zero, 
                                Zero, 
                                0x1E
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                Zero, 
                                Zero, 
                                0x1F
                            }, 

                            Package (0x04)
                            {
                                0x0006FFFF, 
                                Zero, 
                                Zero, 
                                0x20
                            }, 

                            Package (0x04)
                            {
                                0x0006FFFF, 
                                One, 
                                Zero, 
                                0x21
                            }
                        })
                    }

                    Device (PXHI)
                    {
                        Name (_ADR, 0x00040000)
                        Name (PXHS, Zero)
                        Name (_PSC, Zero)
                        Method (_PS0, 0, NotSerialized)
                        {
                            If (LEqual (^^^^DOCK.DCKS, One))
                            {
                                If (LEqual (PXHS, Zero))
                                {
                                    PHSR (0x0A, Zero)
                                    Store (One, PXHS)
                                }
                            }

                            Store (Zero, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }
                    }
                }
            }

            Device (RP04)
            {
                Name (_ADR, 0x001C0003)
                OperationRegion (P4CS, PCI_Config, 0x40, 0x0100)
                Field (P4CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x1A), 
                    ABP4,   1, 
                        ,   2, 
                    PDC4,   1, 
                        ,   2, 
                    PDS4,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSP4,   1, 
                    Offset (0x9C), 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x04
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x12
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKC, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (U1CS, PCI_Config, 0xC4, 0x04)
                Field (U1CS, DWordAcc, NoLock, Preserve)
                {
                    U1EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x03, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    Store (0x03, U1EN)
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (U2CS, PCI_Config, 0xC4, 0x04)
                Field (U2CS, DWordAcc, NoLock, Preserve)
                {
                    U2EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x04, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    Store (0x03, U2EN)
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (U2CS, PCI_Config, 0xC4, 0x04)
                Field (U2CS, DWordAcc, NoLock, Preserve)
                {
                    U3EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x0C, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    Store (0x03, U3EN)
                }
            }

            Device (USB4)
            {
                Name (_ADR, 0x001D0003)
                OperationRegion (U4CS, PCI_Config, 0xC4, 0x04)
                Field (U4CS, DWordAcc, NoLock, Preserve)
                {
                    U4EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x0E, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    Store (0x03, U4EN)
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

            Device (PCIB)
            {
                Name (_ADR, 0x001E0000)
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x05)
                        {
                            Package (0x04)
                            {
                                0x0007FFFF, 
                                Zero, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0x0007FFFF, 
                                0x02, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0x0006FFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0x0008FFFF, 
                                Zero, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0x0008FFFF, 
                                One, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x15)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKF, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKG, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKH, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKE, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                Zero, 
                                ^^LPCB.LNKG, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                One, 
                                ^^LPCB.LNKF, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                0x02, 
                                ^^LPCB.LNKE, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                0x03, 
                                ^^LPCB.LNKH, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                Zero, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                One, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                0x02, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                0x03, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                Zero, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                One, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x02, 
                                ^^LPCB.LNKF, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x03, 
                                ^^LPCB.LNKG, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                Zero, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                One, 
                                ^^LPCB.LNKE, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x02, 
                                ^^LPCB.LNKG, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x03, 
                                ^^LPCB.LNKF, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0008FFFF, 
                                Zero, 
                                ^^LPCB.LNKE, 
                                Zero
                            }
                        })
                    }
                }

                Device (LANC)
                {
                    Name (_ADR, 0x00060000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x04
                    })
                    Name (LANP, Zero)
                    Method (_PSW, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, Zero))
                        {
                            Store (Zero, LANP)
                        }
                        Else
                        {
                            Store (One, LANP)
                        }
                    }
                }

                Device (IEEE)
                {
                    Name (_ADR, 0x00070002)
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)
                OperationRegion (LPC0, PCI_Config, 0x40, 0xC0)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x20), 
                    PARC,   8, 
                    PBRC,   8, 
                    PCRC,   8, 
                    PDRC,   8, 
                    Offset (0x28), 
                    PERC,   8, 
                    PFRC,   8, 
                    PGRC,   8, 
                    PHRC,   8, 
                    Offset (0x40), 
                    IOD0,   8, 
                    IOD1,   8, 
                    Z004,   1, 
                    Z005,   1, 
                    LPTE,   1, 
                    Offset (0x60), 
                        ,   7, 
                    C4C3,   1
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, One)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PARC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLA, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PARC, 0x0F), IRQ0)
                        Return (RTLA)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PARC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PARC, 0x80))
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
                        Store (0x80, PBRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLB, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLB, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PBRC, 0x0F), IRQ0)
                        Return (RTLB)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PBRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PBRC, 0x80))
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
                        Store (0x80, PCRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLC, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PCRC, 0x0F), IRQ0)
                        Return (RTLC)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PCRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PCRC, 0x80))
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
                        Store (0x80, PDRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLD, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLD, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PDRC, 0x0F), IRQ0)
                        Return (RTLD)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PDRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PDRC, 0x80))
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
                        Store (0x80, PERC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLE, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLE, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PERC, 0x0F), IRQ0)
                        Return (RTLE)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PERC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PERC, 0x80))
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
                        Store (0x80, PFRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLF, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLF, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PFRC, 0x0F), IRQ0)
                        Return (RTLF)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PFRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PFRC, 0x80))
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
                        Store (0x80, PGRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLG, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLG, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PGRC, 0x0F), IRQ0)
                        Return (RTLG)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PGRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PGRC, 0x80))
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
                        Store (0x80, PHRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLH, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLH, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PHRC, 0x0F), IRQ0)
                        Return (RTLH)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PHRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PHRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
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
                    Name (SEL0, 0xF0)
                    Name (BFLG, Zero)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, Local0)
                            If (Local0)
                            {
                                Store (One, ECOK)
                            }
                            Else
                            {
                                Store (Zero, ECOK)
                            }
                        }

                        If (ECOK)
                        {
                            Acquire (MUT1, 0xFFFF)
                            Store (0x03, RG59)
                            Store (BTEN, BLTH)
                            Store (^^^^WLAN, WLAN)
                            Store (One, CPLE)
                            Store (PHSR (0x05, Zero), DOFF)
                            Release (MUT1)
                        }
                    }

                    OperationRegion (ERAM, EmbeddedControl, Zero, 0xFF)
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
                        FLS4,   1, 
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
                        BAYE,   1, 
                        PRDE,   1, 
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
                        BAYI,   1, 
                        PRCT,   1, 
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
                        Offset (0x53), 
                        DOFF,   8, 
                        Offset (0x57), 
                        RG57,   8, 
                        CTMP,   8, 
                        RG59,   8, 
                        RG5A,   8, 
                        RG5B,   8, 
                        FSPD,   16, 
                        Offset (0x5F), 
                        WLAN,   1, 
                        BLTH,   1, 
                        CPLE,   1, 
                        Offset (0x61), 
                        BRLV,   8, 
                        Offset (0x63), 
                            ,   7, 
                        VGAF,   1, 
                        Offset (0x71), 
                        MBTS,   1, 
                        MBTF,   1, 
                        Offset (0x72), 
                        MBTC,   1, 
                            ,   2, 
                        LION,   1, 
                        Offset (0x77), 
                        BA1C,   8, 
                        Offset (0x81), 
                        ABTS,   1, 
                        ABFC,   1, 
                            ,   3, 
                        ABBL,   1, 
                        Z006,   1, 
                        ABCT,   1, 
                        ABCG,   1, 
                            ,   2, 
                        ABTP,   1, 
                        Offset (0x87), 
                        BA2C,   8, 
                        Offset (0x8A), 
                        ACUR,   16, 
                        Offset (0xC1), 
                        MCUR,   16, 
                        MBRM,   16, 
                        MBVG,   16, 
                        BTST,   8, 
                        ABCR,   16, 
                        ABRM,   16, 
                        ABVG,   16, 
                        Offset (0xD0), 
                        EBPL,   1, 
                        Offset (0xD1), 
                        PWRE,   1, 
                        Offset (0xD2), 
                            ,   6, 
                        VAUX,   1, 
                        Offset (0xD6), 
                        DBPL,   8, 
                        Offset (0xD8), 
                        LFCC,   16, 
                        BTSN,   16, 
                        BTDC,   16, 
                        BTDV,   16, 
                        BTMN,   8, 
                        BTMD,   8, 
                        AFCC,   16, 
                        ABSN,   16, 
                        ABDC,   16, 
                        ABDV,   16, 
                        ABMN,   8, 
                        ABMD,   8, 
                        TRDV,   3
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

                    Mutex (MUT1, 0x00)
                    Mutex (MUT0, 0x00)
                    Method (SMRD, 4, NotSerialized)
                    {
                        If (LEqual (ECOK, Zero))
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
                        While (LGreater (Local0, One))
                        {
                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            Store (Zero, Local3)
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
                                    Store (Zero, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (Zero, Local0)
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

                                PBFE (Local4, Local5, Zero)
                                Store (Local4, Arg3)
                            }
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (SMWR, 4, NotSerialized)
                    {
                        If (LEqual (ECOK, Zero))
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
                        While (LGreater (Local0, One))
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
                            Store (Zero, Local3)
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
                                    Store (Zero, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (Zero, Local0)
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

                    Method (APOL, 1, NotSerialized)
                    {
                        Store (Arg0, DBPL)
                        Store (One, EBPL)
                    }

                    Name (PSTA, Zero)
                    Method (CPOL, 1, NotSerialized)
                    {
                        If (LEqual (PSTA, Zero))
                        {
                            If (LNot (LEqual (ECOK, Zero)))
                            {
                                APOL (Arg0)
                                Store (One, PSTA)
                            }
                        }
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        If (ECOK)
                        {
                            Acquire (MUT1, 0xFFFF)
                            If (And (SMST, 0x40))
                            {
                                Store (SMAA, Local0)
                                If (LEqual (Local0, 0x14))
                                {
                                    And (SMST, 0xBF, SMST)
                                    Store (PWRE, Local1)
                                    If (Local1)
                                    {
                                        Store (Zero, PWRE)
                                        Store (0x12, BFLG)
                                        CPOL (One)
                                    }
                                }

                                If (LEqual (Local0, 0x16))
                                {
                                    And (SMST, 0xBF, SMST)
                                    Store (0x04, ^^^^BAT1.BCRI)
                                    Notify (BAT1, 0x80)
                                }
                                Else
                                {
                                    Store (Zero, ^^^^BAT1.BCRI)
                                }
                            }

                            Release (MUT1)
                        }
                    }

                    Method (_Q09, 0, NotSerialized)
                    {
                        If (ECOK)
                        {
                            Store (Zero, PSTA)
                            ^^^^BAT1.Z007 ()
                            Notify (ACAD, 0x80)
                            Sleep (0x01F4)
                            Notify (BAT1, 0x80)
                            If (^^^^BAT1.BTCH)
                            {
                                ^^^^BAT1.UBIF ()
                                Notify (BAT1, 0x81)
                                Store (Zero, ^^^^BAT1.BTCH)
                            }
                        }
                    }

                    Method (_Q8A, 0, NotSerialized)
                    {
                        Store (0x8A, P80H)
                    }

                    Method (_Q0F, 0, NotSerialized)
                    {
                        Store (DLST, Local0)
                        Store (Local0, TLST)
                        HKDS (0x0A)
                    }

                    Method (_Q0D, 0, NotSerialized)
                    {
                        Notify (SLPB, 0x80)
                    }

                    Method (_Q0E, 0, NotSerialized)
                    {
                        If (PEGA) {}
                        Else
                        {
                            Store (One, TLST)
                            HKDS (0x0A)
                        }
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x20)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x11)
                        IO (Decode16, 0x0093, 0x0093, 0x01, 0x0D)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer8_16) {4}
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
                        If (LNot (LLess (OSYS, 0x07D1)))
                        {
                            If (HPAE)
                            {
                                Return (0x0F)
                            }
                        }
                        Else
                        {
                            If (HPAE)
                            {
                                Return (0x0B)
                            }
                        }

                        Return (Zero)
                    }

                    Method (_CRS, 0, Serialized)
                    {
                        If (HPAE)
                        {
                            CreateDWordField (BUF0, 0x0A, HPT0)
                            If (LEqual (HPAS, One))
                            {
                                Store (0xFED01000, HPT0)
                            }

                            If (LEqual (HPAS, 0x02))
                            {
                                Store (0xFED02000, HPT0)
                            }

                            If (LEqual (HPAS, 0x03))
                            {
                                Store (0xFED03000, HPT0)
                            }
                        }

                        Return (BUF0)
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

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x01)
                        IRQNoFlags () {13}
                    })
                }

                Device (LDRC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x02)
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16, 0x002E, 0x002E, 0x01, 0x02)
                        IO (Decode16, 0x004E, 0x004E, 0x01, 0x02)
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                        IO (Decode16, 0x0063, 0x0063, 0x01, 0x01)
                        IO (Decode16, 0x0065, 0x0065, 0x01, 0x01)
                        IO (Decode16, 0x0067, 0x0067, 0x01, 0x01)
                        IO (Decode16, 0x0068, 0x006F, 0x01, 0x08)
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x01)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x00B2, 0x00B2, 0x01, 0x02)
                        IO (Decode16, 0x0680, 0x0680, 0x01, 0x80)
                        IO (Decode16, 0x0800, 0x0800, 0x01, 0x10)
                        IO (Decode16, 0x1000, 0x1000, 0x01, 0x80)
                        IO (Decode16, 0x1180, 0x1180, 0x01, 0x40)
                        IO (Decode16, 0x1600, 0x1600, 0x01, 0x80)
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Return (BUF1)
                    }
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
                        If (HPAE)
                        {
                            Return (BUF0)
                        }

                        Return (BUF1)
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
                        If (HPAE)
                        {
                            Return (BUF0)
                        }

                        Return (BUF1)
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

                    Mutex (N383, 0x00)
                    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x07), 
                        LDN,    8, 
                        Offset (0x26), 
                            ,   1, 
                        LPTE,   1, 
                        Z008,   1, 
                        Z009,   1, 
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
                        OPT1,   8
                    }

                    Method (ENFG, 1, NotSerialized)
                    {
                        Acquire (N383, 0xFFFF)
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                    }

                    Method (EXFG, 0, NotSerialized)
                    {
                        Release (N383)
                    }

                    Device (FIR)
                    {
                        Name (_HID, EisaId ("NSC6001"))
                        Method (_STA, 0, NotSerialized)
                        {
                            ENFG (0x02)
                            If (LEqual (Z008, Zero))
                            {
                                If (ACTR)
                                {
                                    Store (0x0F, Local0)
                                }
                                Else
                                {
                                    Store (0x0D, Local0)
                                }
                            }
                            Else
                            {
                                Store (Zero, Local0)
                            }

                            EXFG ()
                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (0x02)
                            If (ACTR)
                            {
                                Store (Zero, ACTR)
                                Store (Zero, INTR)
                                Store (Zero, IOAH)
                                Store (Zero, IOAL)
                                Store (Zero, DMCH)
                            }

                            EXFG ()
                            Store (Zero, Z005)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
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
                                IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
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
                                IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
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
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {4}
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
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {4}
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
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            EndDependentFn ()
                        })
                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            })
                            ENFG (0x02)
                            If (ACTR)
                            {
                                Store (IOAH, Local1)
                                Store (IOAL, Local0)
                                Store (Local0, Index (DCRS, 0x02))
                                Store (Local0, Index (DCRS, 0x04))
                                Store (Local1, Index (DCRS, 0x03))
                                Store (Local1, Index (DCRS, 0x05))
                                ShiftLeft (One, INTR, Local0)
                                Store (Local0, Index (DCRS, 0x09))
                                ShiftRight (Local0, 0x08, Local1)
                                Store (Local1, Index (DCRS, 0x0A))
                                ShiftLeft (One, DMCH, Local0)
                                Store (Local0, Index (DCRS, 0x0C))
                                ShiftRight (Local0, 0x08, Local1)
                                Store (Local1, Index (DCRS, 0x0D))
                            }
                            Else
                            {
                                Store (Zero, Index (DCRS, 0x02))
                                Store (Zero, Index (DCRS, 0x04))
                                Store (Zero, Index (DCRS, 0x03))
                                Store (Zero, Index (DCRS, 0x05))
                                Store (Zero, Index (DCRS, 0x09))
                                Store (Zero, Index (DCRS, 0x0A))
                                Store (Zero, Index (DCRS, 0x0C))
                                Store (Zero, Index (DCRS, 0x0D))
                            }

                            EXFG ()
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
                            And (IOD0, 0x0F, Local2)
                            If (LEqual (ADRM, 0x03))
                            {
                                If (LEqual (ADRL, 0xF8))
                                {
                                    Store (Local2, IOD0)
                                }
                                Else
                                {
                                    Or (Local2, 0x70, IOD0)
                                }
                            }
                            Else
                            {
                                If (LEqual (ADRL, 0xF8))
                                {
                                    Or (Local2, 0x10, IOD0)
                                }
                                Else
                                {
                                    Or (Local2, 0x50, IOD0)
                                }
                            }

                            Store (One, Z005)
                            ENFG (0x02)
                            Store (Local0, INTR)
                            Store (Local1, DMCH)
                            Store (ADRM, IOAH)
                            Store (ADRL, IOAL)
                            Store (One, ACTR)
                            Or (0x80, OPT1, OPT1)
                            EXFG ()
                        }
                    }

                    Device (COMA)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Method (_STA, 0, NotSerialized)
                        {
                            If (^^^^^DOCK)
                            {
                                ENFG (0x03)
                                If (LEqual (Z009, Zero))
                                {
                                    If (ACTR)
                                    {
                                        Store (0x0F, Local0)
                                    }
                                    Else
                                    {
                                        Store (0x0D, Local0)
                                    }
                                }
                                Else
                                {
                                    Store (Zero, Local0)
                                }

                                EXFG ()
                            }
                            Else
                            {
                                Store (Zero, Local0)
                            }

                            If (LEqual (Local0, Zero))
                            {
                                Store (Zero, Z004)
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (0x03)
                            If (ACTR)
                            {
                                Store (Zero, ACTR)
                                Store (Zero, INTR)
                                Store (Zero, IOAH)
                                Store (Zero, IOAL)
                            }

                            EXFG ()
                            Store (Zero, Z004)
                        }

                        Name (_PRS, ResourceTemplate ()
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
                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {3}
                            })
                            ENFG (0x03)
                            If (ACTR)
                            {
                                Store (IOAH, Local1)
                                Store (IOAL, Local0)
                                Store (Local0, Index (DCRS, 0x02))
                                Store (Local0, Index (DCRS, 0x04))
                                Store (Local1, Index (DCRS, 0x03))
                                Store (Local1, Index (DCRS, 0x05))
                                ShiftLeft (One, INTR, Local0)
                                Store (Local0, Index (DCRS, 0x09))
                                ShiftRight (Local0, 0x08, Local1)
                                Store (Local1, Index (DCRS, 0x0A))
                            }
                            Else
                            {
                                Store (Zero, Index (DCRS, 0x02))
                                Store (Zero, Index (DCRS, 0x04))
                                Store (Zero, Index (DCRS, 0x03))
                                Store (Zero, Index (DCRS, 0x05))
                                Store (Zero, Index (DCRS, 0x09))
                                Store (Zero, Index (DCRS, 0x0A))
                            }

                            EXFG ()
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            Store (0x55, P80H)
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x09, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            And (IOD0, 0xF0, Local1)
                            If (LEqual (ADRM, 0x03))
                            {
                                If (LEqual (ADRL, 0xF8))
                                {
                                    Store (Local1, IOD0)
                                }
                                Else
                                {
                                    Or (Local1, 0x07, IOD0)
                                }
                            }
                            Else
                            {
                                If (LEqual (ADRL, 0xF8))
                                {
                                    Or (Local1, One, IOD0)
                                }
                                Else
                                {
                                    Or (Local1, 0x05, IOD0)
                                }
                            }

                            Store (One, Z004)
                            ENFG (0x03)
                            Store (Local0, INTR)
                            Store (ADRM, IOAH)
                            Store (ADRL, IOAL)
                            Store (One, ACTR)
                            EXFG ()
                        }
                    }

                    Device (ECP)
                    {
                        Name (_HID, EisaId ("PNP0401"))
                        Name (_UID, 0x03)
                        Method (_STA, 0, NotSerialized)
                        {
                            ENFG (One)
                            Store (OPT1, Local0)
                            Store (LPTE, Local2)
                            Store (ACTR, Local3)
                            EXFG ()
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (LEqual (Local2, Zero), LOr (LEqual (Local0, 0x04), LEqual (Local0, 0x07))))
                            {
                                If (^^^^^DOCK)
                                {
                                    ShiftLeft (Local3, One, Local1)
                                    Add (0x0D, Local1, Local1)
                                }
                                Else
                                {
                                    Store (Zero, Local1)
                                }
                            }
                            Else
                            {
                                Store (Zero, Local1)
                            }

                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (One)
                            Store (OPT1, Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (LEqual (LPTE, Zero), LOr (LEqual (Local0, 0x04), LEqual (Local0, 0x07))))
                            {
                                If (ACTR)
                                {
                                    Store (Zero, ACTR)
                                    Store (Zero, INTR)
                                    Store (Zero, IOAH)
                                    Store (Zero, IOAL)
                                    Store (Zero, DMCH)
                                }

                                Store (Zero, ^^^LPTE)
                            }

                            EXFG ()
                        }

                        Name (_PRS, ResourceTemplate ()
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
                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            })
                            ENFG (One)
                            If (ACTR)
                            {
                                Store (IOAH, Local1)
                                Store (IOAL, Local0)
                                Store (Local0, Index (DCRS, 0x02))
                                Store (Local0, Index (DCRS, 0x0A))
                                Store (Local0, Index (DCRS, 0x04))
                                Store (Local0, Index (DCRS, 0x0C))
                                Store (Local1, Index (DCRS, 0x03))
                                Store (Local1, Index (DCRS, 0x05))
                                Add (Local1, 0x04, Local1)
                                Store (Local1, Index (DCRS, 0x0B))
                                Store (Local1, Index (DCRS, 0x0D))
                                ShiftLeft (One, INTR, Local0)
                                Store (Local0, Index (DCRS, 0x11))
                                ShiftRight (Local0, 0x08, Local1)
                                Store (Local1, Index (DCRS, 0x12))
                                ShiftLeft (One, DMCH, Local0)
                                Store (Local0, Index (DCRS, 0x14))
                                ShiftRight (Local0, 0x08, Local1)
                                Store (Local1, Index (DCRS, 0x15))
                            }
                            Else
                            {
                                Store (Zero, Index (DCRS, 0x02))
                                Store (Zero, Index (DCRS, 0x0A))
                                Store (Zero, Index (DCRS, 0x04))
                                Store (Zero, Index (DCRS, 0x0C))
                                Store (Zero, Index (DCRS, 0x03))
                                Store (Zero, Index (DCRS, 0x05))
                                Store (Zero, Index (DCRS, 0x0B))
                                Store (Zero, Index (DCRS, 0x0D))
                                Store (Zero, Index (DCRS, 0x11))
                                Store (Zero, Index (DCRS, 0x12))
                                Store (Zero, Index (DCRS, 0x14))
                                Store (Zero, Index (DCRS, 0x15))
                            }

                            EXFG ()
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
                            Store (Zero, ^^^LPTE)
                            And (IOD1, 0xF0, Local2)
                            If (LEqual (ADRM, 0x03))
                            {
                                Store (Local2, IOD1)
                            }
                            Else
                            {
                                Or (Local2, One, IOD1)
                            }

                            Store (One, ^^^LPTE)
                            ENFG (One)
                            Store (Local0, INTR)
                            Store (Local1, DMCH)
                            Store (ADRM, IOAH)
                            Store (ADRL, IOAL)
                            Store (One, ACTR)
                            EXFG ()
                        }
                    }

                    Device (EPP)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x02)
                        Method (_STA, 0, NotSerialized)
                        {
                            ENFG (One)
                            Store (OPT1, Local0)
                            Store (LPTE, Local2)
                            Store (ACTR, Local3)
                            EXFG ()
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (LEqual (Local2, Zero), LOr (LEqual (Local0, 0x02), LEqual (Local0, 0x03))))
                            {
                                If (^^^^^DOCK)
                                {
                                    ShiftLeft (Local3, One, Local1)
                                    Add (0x0D, Local1, Local1)
                                }
                                Else
                                {
                                    Store (Zero, Local1)
                                }
                            }
                            Else
                            {
                                Store (Zero, Local1)
                            }

                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (One)
                            Store (OPT1, Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (LEqual (LPTE, Zero), LOr (LEqual (Local0, 0x02), LEqual (Local0, 0x03))))
                            {
                                If (ACTR)
                                {
                                    Store (Zero, ACTR)
                                    Store (Zero, INTR)
                                    Store (Zero, IOAH)
                                    Store (Zero, IOAL)
                                }

                                Store (Zero, ^^^LPTE)
                            }

                            EXFG ()
                        }

                        Name (_PRS, ResourceTemplate ()
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
                            EndDependentFn ()
                        })
                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {7}
                            })
                            ENFG (One)
                            If (ACTR)
                            {
                                Store (IOAH, Local1)
                                Store (IOAL, Local0)
                                Store (Local0, Index (DCRS, 0x02))
                                Store (Local0, Index (DCRS, 0x0A))
                                Store (Local0, Index (DCRS, 0x04))
                                Store (Local0, Index (DCRS, 0x0C))
                                Store (Local1, Index (DCRS, 0x03))
                                Store (Local1, Index (DCRS, 0x05))
                                Add (Local1, 0x04, Local1)
                                Store (Local1, Index (DCRS, 0x0B))
                                Store (Local1, Index (DCRS, 0x0D))
                                ShiftLeft (One, INTR, Local0)
                                Store (Local0, Index (DCRS, 0x11))
                                ShiftRight (Local0, 0x08, Local1)
                                Store (Local1, Index (DCRS, 0x12))
                            }
                            Else
                            {
                                Store (Zero, Index (DCRS, 0x02))
                                Store (Zero, Index (DCRS, 0x0A))
                                Store (Zero, Index (DCRS, 0x04))
                                Store (Zero, Index (DCRS, 0x0C))
                                Store (Zero, Index (DCRS, 0x03))
                                Store (Zero, Index (DCRS, 0x05))
                                Store (Zero, Index (DCRS, 0x0B))
                                Store (Zero, Index (DCRS, 0x0D))
                                Store (Zero, Index (DCRS, 0x11))
                                Store (Zero, Index (DCRS, 0x12))
                            }

                            EXFG ()
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            Store (Zero, ^^^LPTE)
                            And (IOD1, 0xF0, Local2)
                            If (LEqual (ADRM, 0x03))
                            {
                                Store (Local2, IOD1)
                            }
                            Else
                            {
                                Or (Local2, One, IOD1)
                            }

                            Store (One, ^^^LPTE)
                            ENFG (One)
                            Store (Local0, INTR)
                            Store (ADRM, IOAH)
                            Store (ADRL, IOAL)
                            Store (One, ACTR)
                            EXFG ()
                        }
                    }

                    Device (LPTB)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, One)
                        Method (_STA, 0, NotSerialized)
                        {
                            ENFG (One)
                            Store (OPT1, Local0)
                            Store (LPTE, Local2)
                            Store (ACTR, Local3)
                            EXFG ()
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (LEqual (Local2, Zero), LEqual (Local0, One)))
                            {
                                If (^^^^^DOCK)
                                {
                                    ShiftLeft (Local3, One, Local1)
                                    Add (0x0D, Local1, Local1)
                                }
                                Else
                                {
                                    Store (Zero, Local1)
                                }
                            }
                            Else
                            {
                                Store (Zero, Local1)
                            }

                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (One)
                            Store (OPT1, Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (LEqual (LPTE, Zero), LEqual (Local0, One)))
                            {
                                If (ACTR)
                                {
                                    Store (Zero, ACTR)
                                    Store (Zero, INTR)
                                    Store (Zero, IOAH)
                                    Store (Zero, IOAL)
                                }

                                Store (Zero, ^^^LPTE)
                            }

                            EXFG ()
                        }

                        Name (_PRS, ResourceTemplate ()
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
                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {7}
                            })
                            ENFG (One)
                            If (ACTR)
                            {
                                Store (IOAH, Local1)
                                Store (IOAL, Local0)
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
                                ShiftLeft (One, INTR, Local0)
                                Store (Local0, Index (DCRS, 0x11))
                                ShiftRight (Local0, 0x08, Local1)
                                Store (Local1, Index (DCRS, 0x12))
                            }
                            Else
                            {
                                Store (Zero, Index (DCRS, 0x02))
                                Store (Zero, Index (DCRS, 0x0A))
                                Store (Zero, Index (DCRS, 0x04))
                                Store (Zero, Index (DCRS, 0x0C))
                                Store (Zero, Index (DCRS, 0x03))
                                Store (Zero, Index (DCRS, 0x05))
                                Store (Zero, Index (DCRS, 0x0B))
                                Store (Zero, Index (DCRS, 0x0D))
                                Store (Zero, Index (DCRS, 0x11))
                                Store (Zero, Index (DCRS, 0x12))
                            }

                            EXFG ()
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            Store (Zero, ^^^LPTE)
                            And (IOD1, 0xF0, Local2)
                            If (LEqual (ADRM, 0x03))
                            {
                                If (LEqual (ADRL, 0xBC))
                                {
                                    Or (Local2, 0x02, IOD1)
                                }
                                Else
                                {
                                    Store (Local2, IOD1)
                                }
                            }
                            Else
                            {
                                Or (Local2, One, IOD1)
                            }

                            Store (One, ^^^LPTE)
                            ENFG (One)
                            Store (Local0, INTR)
                            Store (ADRM, IOAH)
                            Store (ADRL, IOAL)
                            Store (One, ACTR)
                            EXFG ()
                        }
                    }

                    Device (LPT)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, Zero)
                        Method (_STA, 0, NotSerialized)
                        {
                            ENFG (One)
                            Store (OPT1, Local0)
                            Store (LPTE, Local2)
                            Store (ACTR, Local3)
                            EXFG ()
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (LEqual (Local2, Zero), LEqual (Local0, Zero)))
                            {
                                If (^^^^^DOCK)
                                {
                                    ShiftLeft (Local3, One, Local1)
                                    Add (0x0D, Local1, Local1)
                                }
                                Else
                                {
                                    Store (Zero, Local1)
                                }
                            }
                            Else
                            {
                                Store (Zero, Local1)
                            }

                            Return (Local1)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (One)
                            Store (OPT1, Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (LEqual (LPTE, Zero), LEqual (Local0, Zero)))
                            {
                                If (ACTR)
                                {
                                    Store (Zero, ACTR)
                                    Store (Zero, INTR)
                                    Store (Zero, IOAH)
                                    Store (Zero, IOAL)
                                }

                                Store (Zero, ^^^LPTE)
                            }

                            EXFG ()
                        }

                        Name (_PRS, ResourceTemplate ()
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
                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                                IRQNoFlags () {7}
                            })
                            ENFG (One)
                            If (ACTR)
                            {
                                Store (IOAH, Local1)
                                Store (IOAL, Local0)
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
                                ShiftLeft (One, INTR, Local0)
                                Store (Local0, Index (DCRS, 0x11))
                                ShiftRight (Local0, 0x08, Local1)
                                Store (Local1, Index (DCRS, 0x12))
                            }
                            Else
                            {
                                Store (Zero, Index (DCRS, 0x02))
                                Store (Zero, Index (DCRS, 0x0A))
                                Store (Zero, Index (DCRS, 0x04))
                                Store (Zero, Index (DCRS, 0x0C))
                                Store (Zero, Index (DCRS, 0x03))
                                Store (Zero, Index (DCRS, 0x05))
                                Store (Zero, Index (DCRS, 0x0B))
                                Store (Zero, Index (DCRS, 0x0D))
                                Store (Zero, Index (DCRS, 0x11))
                                Store (Zero, Index (DCRS, 0x12))
                            }

                            EXFG ()
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            Store (Zero, ^^^LPTE)
                            And (IOD1, 0xF0, Local2)
                            If (LEqual (ADRM, 0x03))
                            {
                                If (LEqual (ADRL, 0xBC))
                                {
                                    Or (Local2, 0x02, IOD1)
                                }
                                Else
                                {
                                    Store (Local2, IOD1)
                                }
                            }
                            Else
                            {
                                Or (Local2, One, IOD1)
                            }

                            Store (One, ^^^LPTE)
                            ENFG (One)
                            Store (Local0, INTR)
                            Store (ADRM, IOAH)
                            Store (ADRL, IOAL)
                            Store (One, ACTR)
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
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("SYN100A"))
                    Name (_CID, Package (0x03)
                    {
                        0x00102E4F, 
                        0x02002E4F, 
                        0x130FD041
                    })
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive) {12}
                    })
                }
            }

            Device (PATA)
            {
                Name (_ADR, 0x001F0001)
                OperationRegion (PACS, PCI_Config, 0x40, 0xC0)
                Field (PACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                    Offset (0x04), 
                    PSIT,   4, 
                    Offset (0x08), 
                    SYNC,   4, 
                    Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
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
                    Name (_ADR, Zero)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Return (Buffer (0x14)
                        {
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 
                            0x1F, 0x00, 0x00, 0x00
                        })
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, Zero, PIO0)
                        CreateDWordField (Arg0, 0x04, DMA0)
                        CreateDWordField (Arg0, 0x08, PIO1)
                        CreateDWordField (Arg0, 0x0C, DMA1)
                        CreateDWordField (Arg0, 0x10, FLAG)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            And (PRIT, 0x40F0, PRIT)
                            And (SYNC, 0x02, SYNC)
                            Store (Zero, SDT0)
                            And (ICR0, 0x02, ICR0)
                            And (ICR1, 0x02, ICR1)
                            And (ICR3, 0x02, ICR3)
                            And (ICR5, 0x02, ICR5)
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
                            If (And (FLAG, One))
                            {
                                Or (SYNC, One, SYNC)
                                Store (SDMA (DMA0), SDT0)
                                If (LLess (DMA0, 0x1E))
                                {
                                    Or (ICR3, One, ICR3)
                                }

                                If (LLess (DMA0, 0x3C))
                                {
                                    Or (ICR0, One, ICR0)
                                }

                                If (And (W930, 0x2000))
                                {
                                    Or (ICR1, One, ICR1)
                                }
                            }
                        }

                        If (LEqual (SizeOf (Arg2), 0x0200))
                        {
                            And (PRIT, 0x3F0F, PRIT)
                            Store (Zero, PSIT)
                            And (SYNC, One, SYNC)
                            Store (Zero, SDT1)
                            And (ICR0, One, ICR0)
                            And (ICR1, One, ICR1)
                            And (ICR3, One, ICR3)
                            And (ICR5, One, ICR5)
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
                        Name (_ADR, Zero)
                        Method (_RMV, 0, NotSerialized)
                        {
                            Return (XOr (SATD, One))
                        }

                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (PIB0, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x03, 
                                0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                            })
                            CreateByteField (PIB0, One, PMD0)
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
                                Store (One, PMD0)
                            }

                            If (And (SYNC, One))
                            {
                                Store (Or (SDT0, 0x40), DMD0)
                                If (And (ICR1, One))
                                {
                                    If (And (ICR0, One))
                                    {
                                        Add (DMD0, 0x02, DMD0)
                                    }

                                    If (And (ICR3, One))
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
                }
            }

            Device (SATA)
            {
                Name (_ADR, 0x001F0002)
                OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
                Field (SACS, DWordAcc, NoLock, Preserve)
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
                    ICR5,   4, 
                    Offset (0x50), 
                    MAPV,   2, 
                    Offset (0x52), 
                    PCSR,   8
                }
            }

            Device (SBUS)
            {
                Name (_ADR, 0x001F0003)
                OperationRegion (SMBP, PCI_Config, 0x40, 0xC0)
                Field (SMBP, DWordAcc, NoLock, Preserve)
                {
                        ,   2, 
                    I2CE,   1
                }

                OperationRegion (SMBI, SystemIO, 0x18E0, 0x10)
                Field (SMBI, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8, 
                    Offset (0x02), 
                    HCON,   8, 
                    HCOM,   8, 
                    TXSA,   8, 
                    DAT0,   8, 
                    DAT1,   8, 
                    HBDR,   8, 
                    PECR,   8, 
                    RXSA,   8, 
                    SDAT,   16
                }

                Method (SSXB, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Zero, I2CE)
                    Store (0xBF, HSTS)
                    Store (Arg0, TXSA)
                    Store (Arg1, HCOM)
                    Store (0x48, HCON)
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SRXB, 1, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    Store (Zero, I2CE)
                    Store (0xBF, HSTS)
                    Store (Or (Arg0, One), TXSA)
                    Store (0x44, HCON)
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (DAT0)
                    }

                    Return (0xFFFF)
                }

                Method (SWRB, 3, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Zero, I2CE)
                    Store (0xBF, HSTS)
                    Store (Arg0, TXSA)
                    Store (Arg1, HCOM)
                    Store (Arg2, DAT0)
                    Store (0x48, HCON)
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SRDB, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    Store (Zero, I2CE)
                    Store (0xBF, HSTS)
                    Store (Or (Arg0, One), TXSA)
                    Store (Arg1, HCOM)
                    Store (0x48, HCON)
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (DAT0)
                    }

                    Return (0xFFFF)
                }

                Method (SBLW, 4, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Arg3, I2CE)
                    Store (0xBF, HSTS)
                    Store (Arg0, TXSA)
                    Store (Arg1, HCOM)
                    Store (SizeOf (Arg2), DAT0)
                    Store (Zero, Local1)
                    Store (DerefOf (Index (Arg2, Zero)), HBDR)
                    Store (0x54, HCON)
                    While (LGreater (SizeOf (Arg2), Local1))
                    {
                        Store (0x0FA0, Local0)
                        While (LAnd (LNot (And (HSTS, 0x80)), Local0))
                        {
                            Decrement (Local0)
                            Stall (0x32)
                        }

                        If (LNot (Local0))
                        {
                            KILL ()
                            Return (Zero)
                        }

                        Store (0x80, HSTS)
                        Increment (Local1)
                        If (LGreater (SizeOf (Arg2), Local1))
                        {
                            Store (DerefOf (Index (Arg2, Local1)), HBDR)
                        }
                    }

                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SBLR, 3, Serialized)
                {
                    Name (TBUF, Buffer (0x0100) {})
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Arg2, I2CE)
                    Store (0xBF, HSTS)
                    Store (Or (Arg0, One), TXSA)
                    Store (Arg1, HCOM)
                    Store (0x54, HCON)
                    Store (0x0FA0, Local0)
                    While (LAnd (LNot (And (HSTS, 0x80)), Local0))
                    {
                        Decrement (Local0)
                        Stall (0x32)
                    }

                    If (LNot (Local0))
                    {
                        KILL ()
                        Return (Zero)
                    }

                    Store (DAT0, Index (TBUF, Zero))
                    Store (0x80, HSTS)
                    Store (One, Local1)
                    While (LLess (Local1, DerefOf (Index (TBUF, Zero))))
                    {
                        Store (0x0FA0, Local0)
                        While (LAnd (LNot (And (HSTS, 0x80)), Local0))
                        {
                            Decrement (Local0)
                            Stall (0x32)
                        }

                        If (LNot (Local0))
                        {
                            KILL ()
                            Return (Zero)
                        }

                        Store (HBDR, Index (TBUF, Local1))
                        Store (0x80, HSTS)
                        Increment (Local1)
                    }

                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (TBUF)
                    }

                    Return (Zero)
                }

                Method (STRT, 0, Serialized)
                {
                    Store (0xC8, Local0)
                    While (Local0)
                    {
                        If (And (HSTS, 0x40))
                        {
                            Decrement (Local0)
                            Sleep (One)
                            If (LEqual (Local0, Zero))
                            {
                                Return (One)
                            }
                        }
                        Else
                        {
                            Store (Zero, Local0)
                        }
                    }

                    Store (0x0FA0, Local0)
                    While (Local0)
                    {
                        If (And (HSTS, One))
                        {
                            Decrement (Local0)
                            Stall (0x32)
                            If (LEqual (Local0, Zero))
                            {
                                KILL ()
                            }
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Return (One)
                }

                Method (COMP, 0, Serialized)
                {
                    Store (0x0FA0, Local0)
                    While (Local0)
                    {
                        If (And (HSTS, 0x02))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Decrement (Local0)
                            Stall (0x32)
                            If (LEqual (Local0, Zero))
                            {
                                KILL ()
                            }
                        }
                    }

                    Return (Zero)
                }

                Method (KILL, 0, Serialized)
                {
                    Or (HCON, 0x02, HCON)
                    Or (HSTS, 0xFF, HSTS)
                }
            }
        }

        OperationRegion (SMI0, SystemIO, 0xFE00, 0x02)
        Field (SMI0, AnyAcc, NoLock, Preserve)
        {
            SMIC,   8
        }

        OperationRegion (SMI1, SystemMemory, 0x1F695E2D, 0x0120)
        Field (SMI1, AnyAcc, NoLock, Preserve)
        {
            BCMD,   8, 
            DID,    32, 
            INF,    8
        }

        Field (SMI1, AnyAcc, NoLock, Preserve)
        {
            Offset (0x110), 
            BTEN,   1, 
            WLAN,   1, 
            DOCK,   1, 
            Z00A,   1
        }

        Mutex (PSMX, 0x00)
        Method (PHSR, 2, NotSerialized)
        {
            Acquire (PSMX, 0xFFFF)
            Store (0x90, BCMD)
            Store (Arg0, DID)
            Store (Arg1, INF)
            Store (Zero, SMIC)
            Store (INF, Local0)
            Release (PSMX)
            Return (Local0)
        }

        Device (ACAD)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                _SB
            })
            Name (ACST, Zero)
            Method (_PSR, 0, NotSerialized)
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPCB.EC0.MUT1, 0xFFFF)
                    Store (^^PCI0.LPCB.EC0.ACDF, ACST)
                    Release (^^PCI0.LPCB.EC0.MUT1)
                }
                Else
                {
                    Store (One, ACST)
                }

                If (ACST)
                {
                    Store (One, Local0)
                    Store (Zero, ^^BAT1.BCRI)
                }
                Else
                {
                    Store (Zero, Local0)
                }

                Return (Local0)
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, One)
            Name (CBTI, Zero)
            Name (PBTI, Zero)
            Name (BTIN, Zero)
            Name (BTCH, Zero)
            Name (BIFI, Zero)
            Name (SEL0, Zero)
            Name (BCRI, Zero)
            Name (PBIF, Package (0x0D)
            {
                One, 
                0x1130, 
                0x1130, 
                One, 
                0x2B5C, 
                0x012C, 
                0x84, 
                0x20, 
                0x20, 
                "BAT1      ", 
                "11        ", 
                "11        ", 
                "11        "
            })
            Name (PBST, Package (0x04)
            {
                Zero, 
                Z007 (),                 Z007 (),                 0x2710
            })
            Name (ERRC, Zero)
            Name (_PCL, Package (0x01)
            {
                _SB
            })
            Method (_STA, 0, NotSerialized)
            {
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
                If (LEqual (BIFI, Zero))
                {
                    UBIF ()
                    Store (One, BIFI)
                }

                Return (PBIF)
            }

            Name (LFCC, 0x1130)
            Method (UBIF, 0, NotSerialized)
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPCB.EC0.MUT1, 0xFFFF)
                    Store (^^PCI0.LPCB.EC0.BTDC, Local0)
                    Store (^^PCI0.LPCB.EC0.LFCC, Local1)
                    Store (^^PCI0.LPCB.EC0.BTDV, Local2)
                    Store (^^PCI0.LPCB.EC0.BTMD, Local3)
                    Store (^^PCI0.LPCB.EC0.BTMN, Local4)
                    Store (^^PCI0.LPCB.EC0.BTSN, Local5)
                    Store (^^PCI0.LPCB.EC0.LION, Local6)
                    Release (^^PCI0.LPCB.EC0.MUT1)
                    Store (Local0, Index (PBIF, One))
                    Store (Local1, Index (PBIF, 0x02))
                    Store (Local2, Index (PBIF, 0x04))
                    Store (Local1, LFCC)
                    If (Local6)
                    {
                        Store ("NiMH", Index (PBIF, 0x0B))
                    }
                    Else
                    {
                        Store ("LION", Index (PBIF, 0x0B))
                    }

                    And (Local3, 0x0F, Local3)
                    If (LEqual (Local3, One))
                    {
                        Store ("ZH01", Index (PBIF, 0x09))
                    }
                    Else
                    {
                        If (LEqual (Local3, 0x02))
                        {
                            Store ("ZH02", Index (PBIF, 0x09))
                        }
                        Else
                        {
                            If (LEqual (Local3, 0x03))
                            {
                                Store ("ZH03", Index (PBIF, 0x09))
                            }
                        }
                    }

                    If (LEqual (Local4, 0x08))
                    {
                        Store ("MOTOROLA", Index (PBIF, 0x0C))
                    }
                    Else
                    {
                        If (LEqual (Local4, 0x06))
                        {
                            Store ("SIMPLO", Index (PBIF, 0x0C))
                        }
                        Else
                        {
                            If (LEqual (Local4, 0x05))
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
            }

            Name (RCAP, Zero)
            Method (_BST, 0, NotSerialized)
            {
                If (LEqual (BTIN, Zero))
                {
                    Store (Zero, Index (PBST, Zero))
                    Store (Ones, Index (PBST, One))
                    Store (Ones, Index (PBST, 0x02))
                    Store (Ones, Index (PBST, 0x03))
                    Return (PBST)
                }

                If (ECOK)
                {
                    Acquire (^^PCI0.LPCB.EC0.MUT1, 0xFFFF)
                    Store (^^PCI0.LPCB.EC0.MBTC, Local0)
                    Store (^^PCI0.LPCB.EC0.MBRM, Local1)
                    Store (^^PCI0.LPCB.EC0.MBVG, Local2)
                    Store (^^PCI0.LPCB.EC0.MCUR, Local3)
                    Store (^^PCI0.LPCB.EC0.BTST, Local4)
                    Store (^^PCI0.LPCB.EC0.MBTF, Local5)
                    Store (^^PCI0.LPCB.EC0.ACDF, Local6)
                    Release (^^PCI0.LPCB.EC0.MUT1)
                    If (Local6)
                    {
                        If (LEqual (Local5, One))
                        {
                            Store (Zero, Local7)
                            Store (LFCC, Local1)
                        }
                        Else
                        {
                            If (LEqual (Local0, One))
                            {
                                Store (0x02, Local7)
                            }
                            Else
                            {
                                Store (Zero, Local7)
                            }
                        }
                    }
                    Else
                    {
                        If (LAnd (Local4, One))
                        {
                            Store (One, Local7)
                        }
                        Else
                        {
                            Store (Zero, Local7)
                        }
                    }

                    And (Local4, 0x04, Local4)
                    If (LEqual (Local4, 0x04))
                    {
                        Or (Local7, Local4, Local7)
                    }

                    Store (Local7, Index (PBST, Zero))
                    If (LNot (And (Local1, 0x8000)))
                    {
                        Store (Local1, Index (PBST, 0x02))
                    }

                    If (LNot (And (Local2, 0x8000)))
                    {
                        Store (Local7, Index (PBST, 0x03))
                    }

                    If (LAnd (Local3, 0x8000))
                    {
                        If (LNot (LEqual (Local3, 0xFFFF)))
                        {
                            Not (Local3, Local3)
                            Increment (Local3)
                            And (Local3, 0xFFFF, Local3)
                        }
                    }

                    Store (Local3, Index (PBST, One))
                }

                Return (PBST)
            }

            Method (Z007, 0, NotSerialized)
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPCB.EC0.MUT1, 0xFFFF)
                    Store (^^PCI0.LPCB.EC0.MBTS, Local0)
                    Release (^^PCI0.LPCB.EC0.MUT1)
                    If (LEqual (Local0, One))
                    {
                        If (LEqual (BTIN, Zero))
                        {
                            Store (One, BTCH)
                            Store (Zero, BIFI)
                        }

                        Store (One, BTIN)
                    }
                    Else
                    {
                        If (LEqual (BTIN, One))
                        {
                            Store (One, BTCH)
                            Store (Zero, BIFI)
                        }

                        Store (Zero, BTIN)
                    }
                }
            }
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_INI, 0, NotSerialized)
            {
                Store (One, LIDS)
            }

            Method (_LID, 0, NotSerialized)
            {
                Store (One, LIDS)
                If (LIDS)
                {
                    If (LIDP)
                    {
                        Store (Zero, Local0)
                    }
                    Else
                    {
                        Store (One, Local0)
                    }
                }
                Else
                {
                    Store (LIDP, Local0)
                }

                Return (Local0)
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
        }

        Scope (\_TZ)
        {
            ThermalZone (THRM)
            {
                Method (_TMP, 0, NotSerialized)
                {
                    If (\_SB.ECOK)
                    {
                        Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
                        Store (\_SB.PCI0.LPCB.EC0.CTMP, Local0)
                        Release (\_SB.PCI0.LPCB.EC0.MUT1)
                        Return (Add (Multiply (Local0, 0x0A), 0x0AAC))
                    }
                    Else
                    {
                        Return (0x0C3C)
                    }
                }

                Method (_PSV, 0, NotSerialized)
                {
                    Return (0x0E4E)
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
                    Return (0x0E76)
                }
            }
        }
    }

    Name (FWSO, "FWSO")
}


--------------080902030904040803090108
Content-Type: text/plain;
 name="errors"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errors"


Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050624 [Jul 23 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) - reached beyond root node
dsdt-highmem.dsl   224:             Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
Error    1022 -                              Object does not exist ^  (\_SB.PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl   225:             Store (One, \_SB.PCI0.LPCB.EC0.FLS4)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.LPCB.EC0.FLS4)

dsdt-highmem.dsl   226:             Release (\_SB.PCI0.LPCB.EC0.MUT1)
Error    1022 -                              Object does not exist ^  (\_SB.PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl   229:         If (\_SB.ECOK)
Error    1022 -       Object does not exist ^  (\_SB.ECOK)

dsdt-highmem.dsl   231:             Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0xFFFF)
Error    1022 -                              Object does not exist ^  (\_SB.PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl   232:             If (LEqual (\_SB.PCI0.PCIB.LANC.LANP, Zero))
Error    1022 -                                  Object does not exist ^  (\_SB.PCI0.PCIB.LANC.LANP)

dsdt-highmem.dsl   234:                 Store (Zero, \_SB.PCI0.LPCB.EC0.VAUX)
Error    1022 -                                      Object does not exist ^  (\_SB.PCI0.LPCB.EC0.VAUX)

dsdt-highmem.dsl   238:                 Store (One, \_SB.PCI0.LPCB.EC0.VAUX)
Error    1022 -                                     Object does not exist ^  (\_SB.PCI0.LPCB.EC0.VAUX)

dsdt-highmem.dsl   241:             Release (\_SB.PCI0.LPCB.EC0.MUT1)
Error    1022 -                              Object does not exist ^  (\_SB.PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl   244:         \_SB.PHSR (0x08, Zero)
Error    1022 -   Object does not exist ^  (\_SB.PHSR)

dsdt-highmem.dsl   253:             \_SB.PHSR (Zero, Zero)
Error    1022 -       Object does not exist ^  (\_SB.PHSR)

dsdt-highmem.dsl   259:             \_SB.PHSR (0x09, Zero)
Error    1022 -       Object does not exist ^  (\_SB.PHSR)

dsdt-highmem.dsl   263:         \_SB.PHSR (0x08, One)
Error    1022 -   Object does not exist ^  (\_SB.PHSR)

dsdt-highmem.dsl   266:             If (LEqual (\_SB.PCI0.DOCK.DCKS, Zero))
Error    1022 -                             Object does not exist ^  (\_SB.PCI0.DOCK.DCKS)

dsdt-highmem.dsl   274:             If (LEqual (\_SB.PCI0.DOCK.DCKS, One))
Error    1022 -                             Object does not exist ^  (\_SB.PCI0.DOCK.DCKS)

dsdt-highmem.dsl   283:             Store (\_SB.BTEN, \_SB.PCI0.LPCB.EC0.BLTH)
Error    1022 -              Object does not exist ^  (\_SB.BTEN)

dsdt-highmem.dsl   283:             Store (\_SB.BTEN, \_SB.PCI0.LPCB.EC0.BLTH)
Error    1022 -                                       Object does not exist ^  (\_SB.PCI0.LPCB.EC0.BLTH)

dsdt-highmem.dsl   284:             Store (\_SB.WLAN, \_SB.PCI0.LPCB.EC0.WLAN)
Error    1022 -              Object does not exist ^  (\_SB.WLAN)

dsdt-highmem.dsl   284:             Store (\_SB.WLAN, \_SB.PCI0.LPCB.EC0.WLAN)
Error    1022 -                                       Object does not exist ^  (\_SB.PCI0.LPCB.EC0.WLAN)

dsdt-highmem.dsl   285:             Store (One, \_SB.PCI0.LPCB.EC0.CPLE)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.LPCB.EC0.CPLE)

dsdt-highmem.dsl   303:             If (\_SB.PCI0.RP01.HPCS)
Error    1022 -                     Object does not exist ^  (\_SB.PCI0.RP01.HPCS)

dsdt-highmem.dsl   305:                 If (\_SB.PCI0.RP01.PDC1)
Error    1022 -                         Object does not exist ^  (\_SB.PCI0.RP01.PDC1)

dsdt-highmem.dsl   307:                     Store (One, \_SB.PCI0.RP01.PDC1)
Error    1022 -                                     Object does not exist ^  (\_SB.PCI0.RP01.PDC1)

dsdt-highmem.dsl   310:                 Store (One, \_SB.PCI0.RP01.HPCS)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP01.HPCS)

dsdt-highmem.dsl   312:                 Notify (\_SB.PCI0.RP01, Zero)
Error    1022 -                        Object does not exist ^  (\_SB.PCI0.RP01)

dsdt-highmem.dsl   316:             If (\_SB.PCI0.RP02.HPCS)
Error    1022 -                     Object does not exist ^  (\_SB.PCI0.RP02.HPCS)

dsdt-highmem.dsl   318:                 If (\_SB.PCI0.RP02.PDC2)
Error    1022 -                         Object does not exist ^  (\_SB.PCI0.RP02.PDC2)

dsdt-highmem.dsl   320:                     Store (One, \_SB.PCI0.RP02.PDC2)
Error    1022 -                                     Object does not exist ^  (\_SB.PCI0.RP02.PDC2)

dsdt-highmem.dsl   323:                 Store (One, \_SB.PCI0.RP02.HPCS)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP02.HPCS)

dsdt-highmem.dsl   325:                 Notify (\_SB.PCI0.RP02, Zero)
Error    1022 -                        Object does not exist ^  (\_SB.PCI0.RP02)

dsdt-highmem.dsl   329:             If (\_SB.PCI0.RP03.HPCS)
Error    1022 -                     Object does not exist ^  (\_SB.PCI0.RP03.HPCS)

dsdt-highmem.dsl   331:                 If (\_SB.PCI0.RP03.PDC3)
Error    1022 -                         Object does not exist ^  (\_SB.PCI0.RP03.PDC3)

dsdt-highmem.dsl   334:                     \_SB.PHSR (0x07, Zero)
Error    1022 -               Object does not exist ^  (\_SB.PHSR)

dsdt-highmem.dsl   337:                     Store (One, \_SB.PCI0.RP03.PDC3)
Error    1022 -                                     Object does not exist ^  (\_SB.PCI0.RP03.PDC3)

dsdt-highmem.dsl   340:                 Store (One, \_SB.PCI0.RP03.HPCS)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP03.HPCS)

dsdt-highmem.dsl   343:             If (\_SB.PCI0.RP04.HPCS)
Error    1022 -                     Object does not exist ^  (\_SB.PCI0.RP04.HPCS)

dsdt-highmem.dsl   345:                 If (\_SB.PCI0.RP04.PDC4)
Error    1022 -                         Object does not exist ^  (\_SB.PCI0.RP04.PDC4)

dsdt-highmem.dsl   347:                     Store (One, \_SB.PCI0.RP04.PDC4)
Error    1022 -                                     Object does not exist ^  (\_SB.PCI0.RP04.PDC4)

dsdt-highmem.dsl   350:                 Store (One, \_SB.PCI0.RP04.HPCS)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP04.HPCS)

dsdt-highmem.dsl   356:             Notify (\_SB.PCI0.USB1, 0x02)
Error    1022 -                    Object does not exist ^  (\_SB.PCI0.USB1)

dsdt-highmem.dsl   361:             Notify (\_SB.PCI0.USB2, 0x02)
Error    1022 -                    Object does not exist ^  (\_SB.PCI0.USB2)

dsdt-highmem.dsl   369:                 Notify (\_SB.PCI0.AZAL, 0x02)
Error    1022 -                        Object does not exist ^  (\_SB.PCI0.AZAL)

dsdt-highmem.dsl   375:             If (\_SB.PCI0.RP01.PSP1)
Error    1022 -                     Object does not exist ^  (\_SB.PCI0.RP01.PSP1)

dsdt-highmem.dsl   377:                 Store (One, \_SB.PCI0.RP01.PSP1)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP01.PSP1)

dsdt-highmem.dsl   378:                 Store (One, \_SB.PCI0.RP01.PMCS)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP01.PMCS)

dsdt-highmem.dsl   379:                 Notify (\_SB.PCI0.RP01, 0x02)
Error    1022 -                        Object does not exist ^  (\_SB.PCI0.RP01)

dsdt-highmem.dsl   382:             If (\_SB.PCI0.RP02.PSP2)
Error    1022 -                     Object does not exist ^  (\_SB.PCI0.RP02.PSP2)

dsdt-highmem.dsl   384:                 Store (One, \_SB.PCI0.RP02.PSP2)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP02.PSP2)

dsdt-highmem.dsl   385:                 Store (One, \_SB.PCI0.RP02.PMCS)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP02.PMCS)

dsdt-highmem.dsl   386:                 Notify (\_SB.PCI0.RP02, 0x02)
Error    1022 -                        Object does not exist ^  (\_SB.PCI0.RP02)

dsdt-highmem.dsl   389:             If (\_SB.PCI0.RP03.PSP3)
Error    1022 -                     Object does not exist ^  (\_SB.PCI0.RP03.PSP3)

dsdt-highmem.dsl   391:                 Store (One, \_SB.PCI0.RP03.PSP3)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP03.PSP3)

dsdt-highmem.dsl   392:                 Store (One, \_SB.PCI0.RP03.PMCS)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP03.PMCS)

dsdt-highmem.dsl   393:                 Notify (\_SB.PCI0.RP03, 0x02)
Error    1022 -                        Object does not exist ^  (\_SB.PCI0.RP03)

dsdt-highmem.dsl   396:             If (\_SB.PCI0.RP04.PSP4)
Error    1022 -                     Object does not exist ^  (\_SB.PCI0.RP04.PSP4)

dsdt-highmem.dsl   398:                 Store (One, \_SB.PCI0.RP04.PSP4)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP04.PSP4)

dsdt-highmem.dsl   399:                 Store (One, \_SB.PCI0.RP04.PMCS)
Error    1022 -                                 Object does not exist ^  (\_SB.PCI0.RP04.PMCS)

dsdt-highmem.dsl   400:                 Notify (\_SB.PCI0.RP04, 0x02)
Error    1022 -                        Object does not exist ^  (\_SB.PCI0.RP04)

dsdt-highmem.dsl   406:             Notify (\_SB.PCI0.PCIB, 0x02)
Error    1022 -                    Object does not exist ^  (\_SB.PCI0.PCIB)

dsdt-highmem.dsl   411:             Notify (\_SB.PCI0.USB3, 0x02)
Error    1022 -                    Object does not exist ^  (\_SB.PCI0.USB3)

dsdt-highmem.dsl   416:             Notify (\_SB.PCI0.USB7, 0x02)
Error    1022 -                    Object does not exist ^  (\_SB.PCI0.USB7)

dsdt-highmem.dsl   421:             Notify (\_SB.PCI0.USB4, 0x02)
Error    1022 -                    Object does not exist ^  (\_SB.PCI0.USB4)

dsdt-highmem.dsl   426:             Notify (\_SB.LID, 0x80)
Error    1022 -              Object does not exist ^  (\_SB.LID)

dsdt-highmem.dsl   439:                     Or (CFGD, 0xC0, CFGD)
Error    1022 -              Object does not exist ^  (CFGD)

dsdt-highmem.dsl   439:                     Or (CFGD, 0xC0, CFGD)
Error    1022 -                          Object does not exist ^  (CFGD)

dsdt-highmem.dsl   442:                     Store (One, \_SB.PCI0.LPCB.C4C3)
Error    1022 -                                     Object does not exist ^  (\_SB.PCI0.LPCB.C4C3)

dsdt-highmem.dsl   444:                     If (LEqual (\_SB.PCI0.RP03.Z002, One))
Error    1022 -                                     Object does not exist ^  (\_SB.PCI0.RP03.Z002)

dsdt-highmem.dsl   447:                         Store (Zero, \_SB.PCI0.RP03.Z002)
Error    1022 -                                          Object does not exist ^  (\_SB.PCI0.RP03.Z002)

dsdt-highmem.dsl   449:                         Store (One, \_SB.PCI0.RP03.LDP3)
Error    1022 -                                         Object does not exist ^  (\_SB.PCI0.RP03.LDP3)

dsdt-highmem.dsl   450:                         Notify (\_SB.PCI0.RP03, Zero)
Error    1022 -                                Object does not exist ^  (\_SB.PCI0.RP03)

dsdt-highmem.dsl   454:                     Store (Zero, \_SB.PCI0.DOCK.DCKS)
Error    1022 -                                      Object does not exist ^  (\_SB.PCI0.DOCK.DCKS)

dsdt-highmem.dsl   455:                     Notify (\_SB.PCI0.DOCK, One)
Error    1022 -                            Object does not exist ^  (\_SB.PCI0.DOCK)

dsdt-highmem.dsl   459:                     And (CFGD, 0x3F, CFGD)
Error    1022 -               Object does not exist ^  (CFGD)

dsdt-highmem.dsl   459:                     And (CFGD, 0x3F, CFGD)
Error    1022 -                           Object does not exist ^  (CFGD)

dsdt-highmem.dsl   462:                     Store (Zero, \_SB.PCI0.LPCB.C4C3)
Error    1022 -                                      Object does not exist ^  (\_SB.PCI0.LPCB.C4C3)

dsdt-highmem.dsl   464:                     Store (One, \_SB.PCI0.DOCK.DCKS)
Error    1022 -                                     Object does not exist ^  (\_SB.PCI0.DOCK.DCKS)

dsdt-highmem.dsl   465:                     Store (Zero, \_SB.PCI0.RP03.LDP3)
Error    1022 -                                      Object does not exist ^  (\_SB.PCI0.RP03.LDP3)

dsdt-highmem.dsl   467:                     Store (One, \_SB.PCI0.RP03.Z002)
Error    1022 -                                     Object does not exist ^  (\_SB.PCI0.RP03.Z002)

dsdt-highmem.dsl   469:                     Notify (\_SB.PCI0.DOCK, Zero)
Error    1022 -                            Object does not exist ^  (\_SB.PCI0.DOCK)

dsdt-highmem.dsl   498:                         Notify (\_SB.PCI0, Zero)
Error    1022 -                           Object does not exist ^  (\_SB.PCI0)

dsdt-highmem.dsl   502:                         Notify (\_SB.PCI0.GFX0, Zero)
Error    1022 -                                Object does not exist ^  (\_SB.PCI0.GFX0)

dsdt-highmem.dsl   508:                 Notify (\_SB.PCI0.GFX0, 0x80)
Error    1022 -                        Object does not exist ^  (\_SB.PCI0.GFX0)

dsdt-highmem.dsl   518:                 Notify (\_SB.PCI0.GFX0, 0x81)
Error    1022 -                        Object does not exist ^  (\_SB.PCI0.GFX0)

dsdt-highmem.dsl   573:             If (LEqual (And (PDC0, 0x0A), 0x0A))
Error    1022 -                   Object does not exist ^  (PDC0)

dsdt-highmem.dsl   578:             If (LEqual (And (PDC1, 0x0A), 0x0A))
Error    1022 -                   Object does not exist ^  (PDC1)

dsdt-highmem.dsl  5714:                 Z007 (),                 Z007 (),                 0x2710
Error    1037 - parse error, expecting `'}'' ^ 

dsdt-highmem.dsl  5723:                 If (BTIN)
Error    1022 -          Object does not exist ^  (BTIN)

dsdt-highmem.dsl  5735:                 If (LEqual (BIFI, Zero))
Error    1022 -                  Object does not exist ^  (BIFI)

dsdt-highmem.dsl  5738:                     Store (One, BIFI)
Error    1022 -                      Object does not exist ^  (BIFI)

dsdt-highmem.dsl  5741:                 Return (PBIF)
Error    1022 -              Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5747:                 If (ECOK)
Error    1022 -          Object does not exist ^  (ECOK)

dsdt-highmem.dsl  5749:                     Acquire (^^PCI0.LPCB.EC0.MUT1, 0xFFFF)
Error    1020 -           Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl  5750:                     Store (^^PCI0.LPCB.EC0.BTDC, Local0)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.BTDC)

dsdt-highmem.dsl  5751:                     Store (^^PCI0.LPCB.EC0.LFCC, Local1)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.LFCC)

dsdt-highmem.dsl  5752:                     Store (^^PCI0.LPCB.EC0.BTDV, Local2)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.BTDV)

dsdt-highmem.dsl  5753:                     Store (^^PCI0.LPCB.EC0.BTMD, Local3)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.BTMD)

dsdt-highmem.dsl  5754:                     Store (^^PCI0.LPCB.EC0.BTMN, Local4)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.BTMN)

dsdt-highmem.dsl  5755:                     Store (^^PCI0.LPCB.EC0.BTSN, Local5)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.BTSN)

dsdt-highmem.dsl  5756:                     Store (^^PCI0.LPCB.EC0.LION, Local6)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.LION)

dsdt-highmem.dsl  5757:                     Release (^^PCI0.LPCB.EC0.MUT1)
Error    1020 -           Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl  5758:                     Store (Local0, Index (PBIF, One))
Error    1022 -                                Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5759:                     Store (Local1, Index (PBIF, 0x02))
Error    1022 -                                Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5760:                     Store (Local2, Index (PBIF, 0x04))
Error    1022 -                                Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5764:                         Store ("NiMH", Index (PBIF, 0x0B))
Error    1022 -                                    Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5768:                         Store ("LION", Index (PBIF, 0x0B))
Error    1022 -                                    Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5774:                         Store ("ZH01", Index (PBIF, 0x09))
Error    1022 -                                    Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5780:                             Store ("ZH02", Index (PBIF, 0x09))
Error    1022 -                                        Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5786:                                 Store ("ZH03", Index (PBIF, 0x09))
Error    1022 -                                            Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5793:                         Store ("MOTOROLA", Index (PBIF, 0x0C))
Error    1022 -                                        Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5799:                             Store ("SIMPLO", Index (PBIF, 0x0C))
Error    1022 -                                          Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5805:                                 Store ("SANYO", Index (PBIF, 0x0C))
Error    1022 -                                             Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5811:                                     Store ("SONY", Index (PBIF, 0x0C))
Error    1022 -                                                Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5817:                     Store (ITOS (ToBCD (Local5)), Index (PBIF, 0x0A))
Error    1022 -                                               Object does not exist ^  (PBIF)

dsdt-highmem.dsl  5824:                 If (LEqual (BTIN, Zero))
Error    1022 -                  Object does not exist ^  (BTIN)

dsdt-highmem.dsl  5826:                     Store (Zero, Index (PBST, Zero))
Error    1022 -                              Object does not exist ^  (PBST)

dsdt-highmem.dsl  5827:                     Store (Ones, Index (PBST, One))
Error    1022 -                              Object does not exist ^  (PBST)

dsdt-highmem.dsl  5828:                     Store (Ones, Index (PBST, 0x02))
Error    1022 -                              Object does not exist ^  (PBST)

dsdt-highmem.dsl  5829:                     Store (Ones, Index (PBST, 0x03))
Error    1022 -                              Object does not exist ^  (PBST)

dsdt-highmem.dsl  5830:                     Return (PBST)
Error    1022 -                  Object does not exist ^  (PBST)

dsdt-highmem.dsl  5833:                 If (ECOK)
Error    1022 -          Object does not exist ^  (ECOK)

dsdt-highmem.dsl  5835:                     Acquire (^^PCI0.LPCB.EC0.MUT1, 0xFFFF)
Error    1020 -           Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl  5836:                     Store (^^PCI0.LPCB.EC0.MBTC, Local0)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MBTC)

dsdt-highmem.dsl  5837:                     Store (^^PCI0.LPCB.EC0.MBRM, Local1)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MBRM)

dsdt-highmem.dsl  5838:                     Store (^^PCI0.LPCB.EC0.MBVG, Local2)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MBVG)

dsdt-highmem.dsl  5839:                     Store (^^PCI0.LPCB.EC0.MCUR, Local3)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MCUR)

dsdt-highmem.dsl  5840:                     Store (^^PCI0.LPCB.EC0.BTST, Local4)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.BTST)

dsdt-highmem.dsl  5841:                     Store (^^PCI0.LPCB.EC0.MBTF, Local5)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MBTF)

dsdt-highmem.dsl  5842:                     Store (^^PCI0.LPCB.EC0.ACDF, Local6)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.ACDF)

dsdt-highmem.dsl  5843:                     Release (^^PCI0.LPCB.EC0.MUT1)
Error    1020 -           Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl  5881:                     Store (Local7, Index (PBST, Zero))
Error    1022 -                                Object does not exist ^  (PBST)

dsdt-highmem.dsl  5884:                         Store (Local1, Index (PBST, 0x02))
Error    1022 -                                    Object does not exist ^  (PBST)

dsdt-highmem.dsl  5889:                         Store (Local7, Index (PBST, 0x03))
Error    1022 -                                    Object does not exist ^  (PBST)

dsdt-highmem.dsl  5902:                     Store (Local3, Index (PBST, One))
Error    1022 -                                Object does not exist ^  (PBST)

dsdt-highmem.dsl  5905:                 Return (PBST)
Error    1022 -              Object does not exist ^  (PBST)

dsdt-highmem.dsl  5910:                 If (ECOK)
Error    1022 -          Object does not exist ^  (ECOK)

dsdt-highmem.dsl  5912:                     Acquire (^^PCI0.LPCB.EC0.MUT1, 0xFFFF)
Error    1020 -           Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl  5913:                     Store (^^PCI0.LPCB.EC0.MBTS, Local0)
Error    1020 -         Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MBTS)

dsdt-highmem.dsl  5914:                     Release (^^PCI0.LPCB.EC0.MUT1)
Error    1020 -           Object not found or not accessible from scope ^  (^^PCI0.LPCB.EC0.MUT1)

dsdt-highmem.dsl  5917:                         If (LEqual (BTIN, Zero))
Error    1022 -                          Object does not exist ^  (BTIN)

dsdt-highmem.dsl  5919:                             Store (One, BTCH)
Error    1022 -                              Object does not exist ^  (BTCH)

dsdt-highmem.dsl  5920:                             Store (Zero, BIFI)
Error    1022 -                               Object does not exist ^  (BIFI)

dsdt-highmem.dsl  5923:                         Store (One, BTIN)
Error    1022 -                          Object does not exist ^  (BTIN)

dsdt-highmem.dsl  5927:                         If (LEqual (BTIN, One))
Error    1022 -                          Object does not exist ^  (BTIN)

dsdt-highmem.dsl  5929:                             Store (One, BTCH)
Error    1022 -                              Object does not exist ^  (BTCH)

dsdt-highmem.dsl  5930:                             Store (Zero, BIFI)
Error    1022 -                               Object does not exist ^  (BIFI)

dsdt-highmem.dsl  5933:                         Store (Zero, BTIN)
Error    1022 -                           Object does not exist ^  (BTIN)

dsdt-highmem.dsl  5939:         Device
Error    1037 -                      ^ parse error, expecting `$'

ASL Input:  dsdt-highmem.dsl - 5940 lines, 205791 bytes, 2594 keywords
Compilation complete. 147 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

--------------080902030904040803090108--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
