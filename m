From: Andreas Leppert <wudmx-S0/GAf8tV78@public.gmane.org>
Subject: Re: throttling is not changing
Date: Mon, 13 Sep 2004 04:21:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040913022119.GA7359@laptop>
References: <1554095126@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1554095126-S0/GAf8tV78@public.gmane.org>
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


--Yylu36WmvOXNoKYn
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i disassembled my dsdt and tried to compile it again.

bash-2.05b# ./iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040715 [Sep 13=20
2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

dsdt.dsl  3081:     If (SS1)
Error    1037 -      ^ syntax error, unexpected PARSEOP_IF

ASL Input:  dsdt.dsl - 3132 lines, 104097 bytes, 1533 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

sorry, really dont know wheres the problem. can you help me?

dsdt.dsl is attached!

thanks
Andreas Leppert

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dsdt.dsl"
Content-Transfer-Encoding: quoted-printable

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20040715
 *
 * Disassembly of dsdt.dat, Mon Sep 13 04:16:01 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "UW____", "FSC_____", 22)
{
    OperationRegion (BIOS, SystemMemory, 0x1FFDF064, 0xFF)
    Field (BIOS, ByteAcc, NoLock, Preserve)
    {
        SS1,    1,=20
        SS2,    1,=20
        SS3,    1,=20
        SS4,    1,=20
        Offset (0x01),=20
        IOST,   16,=20
        TOPM,   32,=20
        ROMS,   32,=20
        MG1B,   32,=20
        MG1L,   32,=20
        MG2B,   32,=20
        MG2L,   32
    }

    Name (IO1B, 0x0680)
    Name (IO1L, 0x80)
    Name (PMBS, 0x0400)
    Name (PMLN, 0x80)
    Name (GPBS, 0x0500)
    Name (GPLN, 0x40)
    Name (SMBS, 0x0540)
    Name (SMBL, 0x10)
    Name (SPIO, 0x4E)
    Name (APCB, 0xFEC00000)
    Name (APCL, 0x1000)
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
            Store (0xAC, DBG8)
        }

        Store (Arg0, PICM)
    }

    Name (OSVR, Ones)
    Method (OSFL, 0, NotSerialized)
    {
        If (LNot (LEqual (OSVR, Ones)))
        {
            Return (OSVR)
        }

        If (LEqual (PICM, 0x00))
        {
            Store (0xAC, DBG8)
        }

        Store (0x01, OSVR)
        If (MCTH (\_OS, "Microsoft Windows NT"))
        {
            If (LEqual (OSVR, 0x01))
            {
                If (CondRefOf (_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x04, OSVR)
                    }
                }
                Else
                {
                    Store (0x00, OSVR)
                }
            }
        }
        Else
        {
            If (MCTH (\_OS, "Microsoft WindowsME: Millennium Edition"))
            {
                Store (0x02, OSVR)
            }
        }

        Return (OSVR)
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
            If (LNot (LEqual (DerefOf (Index (BUF0, Local0)), DerefOf (Inde=
x (BUF1, Local0)))))
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
            0x00,=20
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
            If (LOr (LEqual (OSFL (), 0x01), LEqual (OSFL (), 0x02)))
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
        0x00,=20
        0x00
    })
    OperationRegion (DEB0, SystemIO, 0x0378, 0x01)
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
        Processor (CPU1, 0x01, 0x00000100, 0x06) {}
        Processor (CPU2, 0x02, 0x00000100, 0x06) {}
    }

    Scope (\_SB)
    {
        Name (PR00, Package (0x08)
        {
            Package (0x04)
            {
                0x0001FFFF,=20
                0x00,=20
                LNKA,=20
                0x00
            },=20

            Package (0x04)
            {
                0x0001FFFF,=20
                0x01,=20
                LNKB,=20
                0x00
            },=20

            Package (0x04)
            {
                0x001FFFFF,=20
                0x01,=20
                LNKB,=20
                0x00
            },=20

            Package (0x04)
            {
                0x001FFFFF,=20
                0x00,=20
                LNKC,=20
                0x00
            },=20

            Package (0x04)
            {
                0x001DFFFF,=20
                0x00,=20
                LNKA,=20
                0x00
            },=20

            Package (0x04)
            {
                0x001DFFFF,=20
                0x01,=20
                LNKD,=20
                0x00
            },=20

            Package (0x04)
            {
                0x001DFFFF,=20
                0x02,=20
                LNKC,=20
                0x00
            },=20

            Package (0x04)
            {
                0x001DFFFF,=20
                0x03,=20
                LNKH,=20
                0x00
            }
        })
        Name (AR00, Package (0x08)
        {
            Package (0x04)
            {
                0x0001FFFF,=20
                0x00,=20
                0x00,=20
                0x10
            },=20

            Package (0x04)
            {
                0x0001FFFF,=20
                0x01,=20
                0x00,=20
                0x11
            },=20

            Package (0x04)
            {
                0x001FFFFF,=20
                0x01,=20
                0x00,=20
                0x11
            },=20

            Package (0x04)
            {
                0x001FFFFF,=20
                0x00,=20
                0x00,=20
                0x12
            },=20

            Package (0x04)
            {
                0x001DFFFF,=20
                0x00,=20
                0x00,=20
                0x10
            },=20

            Package (0x04)
            {
                0x001DFFFF,=20
                0x01,=20
                0x00,=20
                0x13
            },=20

            Package (0x04)
            {
                0x001DFFFF,=20
                0x02,=20
                0x00,=20
                0x12
            },=20

            Package (0x04)
            {
                0x001DFFFF,=20
                0x03,=20
                0x00,=20
                0x17
            }
        })
        Name (PR02, Package (0x03)
        {
            Package (0x04)
            {
                0x0003FFFF,=20
                0x00,=20
                LNKB,=20
                0x00
            },=20

            Package (0x04)
            {
                0x000CFFFF,=20
                0x00,=20
                LNKB,=20
                0x00
            },=20

            Package (0x04)
            {
                0x000AFFFF,=20
                0x00,=20
                LNKC,=20
                0x00
            }
        })
        Name (AR02, Package (0x03)
        {
            Package (0x04)
            {
                0x0003FFFF,=20
                0x00,=20
                0x00,=20
                0x11
            },=20

            Package (0x04)
            {
                0x000CFFFF,=20
                0x00,=20
                0x00,=20
                0x11
            },=20

            Package (0x04)
            {
                0x000AFFFF,=20
                0x00,=20
                0x00,=20
                0x12
            }
        })
        Name (PRSA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {3,4,5,6,7,9,10,11,12,14,15}
        })
        Alias (PRSA, PRSB)
        Alias (PRSA, PRSC)
        Alias (PRSA, PRSD)
        Alias (PRSA, PRSE)
        Alias (PRSA, PRSF)
        Alias (PRSA, PRSG)
        Alias (PRSA, PRSH)
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

            Device (P0P2)
            {
                Name (_ADR, 0x001E0000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x0B, 0x03))
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR02)
                    }

                    Return (PR02)
                }

                Device (LAN1)
                {
                    Name (_ADR, 0x000C0000)
                    Method (_PRW, 0, NotSerialized)
                    {
                        Return (GPRW (0x0B, 0x03))
                    }
                }
            }

            Device (MC97)
            {
                Name (_ADR, 0x001F0006)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x05, 0x03))
                }
            }

            Device (IDE0)
            {
                Name (_ADR, 0x001F0001)
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
                    Offset (0x40),=20
                    TIMP,   16,=20
                    TIMS,   16,=20
                    STMP,   4,=20
                    STMS,   4,=20
                    Offset (0x48),=20
                    UDMP,   2,=20
                    UDMS,   2,=20
                    Offset (0x4A),=20
                    UDTP,   6,=20
                    Offset (0x4B),=20
                    UDTS,   6,=20
                    Offset (0x54),=20
                    PCB0,   2,=20
                    SCB0,   2,=20
                    PCA0,   2,=20
                    SCA0,   2,=20
                        ,   4,=20
                    FPB0,   2,=20
                    FSB0,   2
                }

                Name (TIM0, Package (0x09)
                {
                    Package (0x04)
                    {
                        0x78,=20
                        0xB4,=20
                        0xF0,=20
                        0x0384
                    },=20

                    Package (0x04)
                    {
                        0x23,=20
                        0x21,=20
                        0x10,=20
                        0x00
                    },=20

                    Package (0x04)
                    {
                        0x0B,=20
                        0x09,=20
                        0x04,=20
                        0x00
                    },=20

                    Package (0x06)
                    {
                        0x70,=20
                        0x49,=20
                        0x36,=20
                        0x27,=20
                        0x19,=20
                        0x0F
                    },=20

                    Package (0x06)
                    {
                        0x00,=20
                        0x01,=20
                        0x02,=20
                        0x01,=20
                        0x02,=20
                        0x01
                    },=20

                    Package (0x06)
                    {
                        0x00,=20
                        0x00,=20
                        0x00,=20
                        0x01,=20
                        0x01,=20
                        0x01
                    },=20

                    Package (0x06)
                    {
                        0x00,=20
                        0x00,=20
                        0x00,=20
                        0x00,=20
                        0x00,=20
                        0x01
                    },=20

                    Package (0x04)
                    {
                        0x04,=20
                        0x03,=20
                        0x02,=20
                        0x00
                    },=20

                    Package (0x04)
                    {
                        0x02,=20
                        0x01,=20
                        0x00,=20
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
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA2))
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, 0x01)
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
                    Store (Match (DerefOf (Index (TIM0, 0x01)), MLE, Local5=
, MTR, 0x00, 0x00), Local6)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, 0x00)), Lo=
cal6)), Local7)
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
                        Store (Match (DerefOf (Index (TIM0, 0x02)), MLE, Ar=
g1, MTR, 0x00, 0x00), Local5)
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x00))=
, Local5)), Local6)
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

                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x03))=
, Local5)), DMA0)
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

                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x03))=
, Local5)), DMA1)
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
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DM=
A0, MTR, 0x00, 0x00), Local0)
                        If (LGreater (Local0, 0x05))
                        {
                            Store (0x05, Local0)
                        }

                        Or (GUDT, DerefOf (Index (DerefOf (Index (TIM0, 0x0=
4)), Local0)), GUDT)
                        Or (GCB0, DerefOf (Index (DerefOf (Index (TIM0, 0x0=
5)), Local0)), GCB0)
                        Or (GFB0, DerefOf (Index (DerefOf (Index (TIM0, 0x0=
6)), Local0)), GFB0)
                        Or (GUDM, 0x01, GUDM)
                    }
                    Else
                    {
                        If (Or (LEqual (PIO0, Ones), LEqual (PIO0, 0x00)))
                        {
                            If (And (LLess (DMA0, Ones), LGreater (DMA0, 0x=
00)))
                            {
                                Store (DMA0, PIO0)
                                Or (GTIM, 0x08, GTIM)
                            }
                        }
                    }

                    If (And (CHNF, 0x04))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DM=
A1, MTR, 0x00, 0x00), Local0)
                        If (LGreater (Local0, 0x05))
                        {
                            Store (0x05, Local0)
                        }

                        Or (GUDT, ShiftLeft (DerefOf (Index (DerefOf (Index=
 (TIM0, 0x04)), Local0)), 0x04), GUDT)
                        Or (GCB0, ShiftLeft (DerefOf (Index (DerefOf (Index=
 (TIM0, 0x05)), Local0)), 0x01), GCB0)
                        Or (GFB0, ShiftLeft (DerefOf (Index (DerefOf (Index=
 (TIM0, 0x06)), Local0)), 0x01), GFB0)
                        Or (GUDM, 0x02, GUDM)
                    }
                    Else
                    {
                        If (Or (LEqual (PIO1, Ones), LEqual (PIO1, 0x00)))
                        {
                            If (And (LLess (DMA1, Ones), LGreater (DMA1, 0x=
00)))
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

                    And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIO0, MT=
R, 0x00, 0x00), 0x03, Local0)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, 0x01)), Lo=
cal0)), Local1)
                    ShiftLeft (Local1, 0x08, Local2)
                    Or (GTIM, Local2, GTIM)
                    If (And (CHNF, 0x10))
                    {
                        Or (GTIM, 0x4000, GTIM)
                        And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIO1=
, MTR, 0x00, 0x00), 0x03, Local0)
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x02))=
, Local0)), GSTM)
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

                    If (LAnd (LAnd (And (ID53, 0x04), And (ID88, 0xFF00)), =
DMAT))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DM=
AT, MTR, 0x00, 0x00), Local1)
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
                            And (Match (DerefOf (Index (TIM0, 0x00)), MGE, =
PIOT, MTR, 0x00, 0x00), 0x03, Local0)
                            Or (0x20, DerefOf (Index (DerefOf (Index (TIM0,=
 0x08)), Local0)), Local1)
                            GTFB (AT01, Local1, Local7)
                        }
                    }

                    If (IRDY)
                    {
                        And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIOT=
, MTR, 0x00, 0x00), 0x03, Local0)
                        Or (0x08, DerefOf (Index (DerefOf (Index (TIM0, 0x0=
7)), Local0)), Local1)
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

            Device (USB1)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16,=20
                    Offset (0x04),=20
                    USBW,   8
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, USBW)
                    }
                    Else
                    {
                        Store (0x00, USBW)
                    }
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16,=20
                    Offset (0x04),=20
                    USBW,   8
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, USBW)
                    }
                    Else
                    {
                        Store (0x00, USBW)
                    }
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (BAR0, PCI_Config, 0xC0, 0x05)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    UBL1,   16,=20
                    Offset (0x04),=20
                    USBW,   8
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, USBW)
                    }
                    Else
                    {
                        Store (0x00, USBW)
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

                Device (RMSC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x10)
                    Name (CRS0, ResourceTemplate ()
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
                        Memory32 (ReadOnly, 0xFFE80000, 0xFFE80000, 0x00000=
000, 0x00080000)
                        Memory32 (ReadOnly, 0xFFF80000, 0xFFF80000, 0x00000=
000, 0x00080000)
                        Memory32 (ReadOnly, 0xFEE00400, 0xFEE00400, 0x00000=
000, 0x00DFFC00)
                    })
                    Name (CRS1, ResourceTemplate ()
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
                        If (LEqual (OSFL (), 0x00))
                        {
                            CreateWordField (CRS1, 0x7A, GP00)
                            CreateWordField (CRS1, 0x7C, GP01)
                            CreateByteField (CRS1, 0x7F, GP0L)
                            Store (PMBS, GP00)
                            Store (PMBS, GP01)
                            Store (PMLN, GP0L)
                        }
                        Else
                        {
                            CreateWordField (CRS0, 0x7A, GPX0)
                            CreateWordField (CRS0, 0x7C, GPX1)
                            CreateByteField (CRS0, 0x7F, GPXL)
                            Store (PMBS, GPX0)
                            Store (PMBS, GPX1)
                            Store (PMLN, GPXL)
                        }

                        If (GPBS)
                        {
                            If (LEqual (OSFL (), 0x00))
                            {
                                CreateWordField (CRS1, 0x82, GP20)
                                CreateWordField (CRS1, 0x84, GP21)
                                CreateByteField (CRS1, 0x87, GP2L)
                                Store (GPBS, GP20)
                                Store (GPBS, GP21)
                                Store (GPLN, GP2L)
                            }
                            Else
                            {
                                CreateWordField (CRS0, 0x82, GX20)
                                CreateWordField (CRS0, 0x84, GX21)
                                CreateByteField (CRS0, 0x87, GX2L)
                                Store (GPBS, GX20)
                                Store (GPBS, GX21)
                                Store (GPLN, GX2L)
                            }
                        }

                        If (LEqual (OSFL (), 0x00))
                        {
                            Return (CRS1)
                        }
                        Else
                        {
                            Return (CRS0)
                        }
                    }
                }

                Device (OMSC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x00)
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x1100, 0x1100, 0x00, 0x40)
                        IO (Decode16, 0x1254, 0x1254, 0x00, 0x01)
                        IO (Decode16, 0x12D4, 0x12D4, 0x00, 0x01)
                        IO (Decode16, 0x1300, 0x1300, 0x00, 0x76)
                        IO (Decode16, 0x1377, 0x1377, 0x00, 0x09)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        Memory32Fixed (ReadOnly, 0x00000000, 0x00000000)
                        Memory32Fixed (ReadOnly, 0x00000000, 0x00000000)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (APCB)
                        {
                            If (OSFL ()) {}
                            Else
                            {
                                CreateDWordField (CRS, 0x38, ML01)
                                CreateDWordField (CRS, 0x34, MB01)
                                CreateDWordField (CRS, 0x44, ML02)
                                CreateDWordField (CRS, 0x40, MB02)
                                Store (APCB, MB01)
                                Store (APCL, ML01)
                                Store (0xFEE00000, MB02)
                                Store (0x1000, ML02)
                            }
                        }

                        If (OSFL ()) {}
                        Else
                        {
                            CreateWordField (CRS, 0x2A, GP40)
                            CreateWordField (CRS, 0x2C, GP41)
                            CreateByteField (CRS, 0x2F, GP4L)
                            Store (0x1376, GP40)
                            Store (0x1376, GP41)
                            Store (0x01, GP4L)
                        }

                        Return (CRS)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (OSFL ())
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (0x00)
                        }
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
                    Method (_STA, 0, NotSerialized)
                    {
                        If (OSFL ())
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

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

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP030B"))
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

                Method (PS2K._PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x1D, 0x05))
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

                Method (PS2M._PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x1D, 0x05))
                }

                OperationRegion (WIN1, SystemIO, SPIO, 0x02)
                Field (WIN1, ByteAcc, NoLock, Preserve)
                {
                    INDX,   8,=20
                    DATA,   8
                }

                IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x02),=20
                    CFG,    8,=20
                    Offset (0x07),=20
                    LDN,    8,=20
                    Offset (0x22),=20
                        ,   4,=20
                    PPPD,   1,=20
                    Offset (0x23),=20
                    Offset (0x30),=20
                    ACTR,   8,=20
                    Offset (0x60),=20
                    IOAH,   8,=20
                    IOAL,   8,=20
                    Offset (0x70),=20
                    INTR,   8,=20
                    Offset (0x74),=20
                    DMCH,   8,=20
                    Offset (0xF0),=20
                    OPT0,   8,=20
                    OPT1,   8,=20
                    OPT2,   8,=20
                    OPT3,   8,=20
                    OPT4,   8,=20
                    OPT5,   8,=20
                    OPT6,   8,=20
                    OPT7,   8
                }

                Method (ENFG, 0, NotSerialized)
                {
                    Store (0x87, INDX)
                    Store (0x87, INDX)
                }

                Method (EXFG, 0, NotSerialized)
                {
                    Store (0xAA, INDX)
                }

                Name (LDFD, 0x00)
                Name (LDLP, 0x01)
                Name (LDU1, 0x02)
                Name (LDU2, 0x03)
                Name (LDIR, 0x0C)
                Name (LDMD, 0x06)
                Name (LDGM, 0x07)
                Method (SIOS, 1, NotSerialized)
                {
                }

                Method (SIOH, 0, NotSerialized)
                {
                }

                Method (SIOW, 1, NotSerialized)
                {
                }

                Name (FDST, 0x00)
                Name (U1ST, 0x00)
                Name (U2ST, 0x00)
                Name (IRST, 0x00)
                Name (LPST, 0x00)
                Name (GMST, 0x00)
                Name (MDST, 0x00)
                Method (_INI, 0, NotSerialized)
                {
                    If (LNot (LEqual (GSTA (LDFD), 0x00)))
                    {
                        Store (0x01, FDST)
                    }

                    If (LNot (LEqual (GSTA (LDU1), 0x00)))
                    {
                        Store (0x01, U1ST)
                    }

                    If (LNot (LEqual (GSTA (LDU2), 0x00)))
                    {
                        Store (0x01, U2ST)
                    }

                    If (LNot (LEqual (GSTA (LDIR), 0x00)))
                    {
                        Store (0x01, IRST)
                    }

                    If (LNot (LEqual (GSTA (LDGM), 0x00)))
                    {
                        Store (0x01, GMST)
                    }

                    If (LNot (LEqual (GSTA (LDMD), 0x00)))
                    {
                        Store (0x01, MDST)
                    }

                    ENFG ()
                    Store (LDLP, LDN)
                    If (LNot (LEqual (ACTR, 0x03)))
                    {
                        Store (0x01, LPST)
                    }

                    EXFG ()
                }

                Device (LPT)
                {
                    Name (_HID, EisaId ("PNP0400"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LPST)
                        {
                            ENFG ()
                            Store (LDLP, LDN)
                            Store (ACTR, Local0)
                            Store (IOAH, Local1)
                            EXFG ()
                            And (Local0, 0x01, Local0)
                            If (LAnd (LNot (Local0), Local1))
                            {
                                Return (0x0F)
                            }
                        }

                        Return (Zero)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (One, PPPD)
                        EXFG ()
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFE, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                            IRQNoFlags () {7}
                        })
                        CreateWordField (BUFE, 0x02, IMI1)
                        CreateWordField (BUFE, 0x04, IMA1)
                        CreateByteField (BUFE, 0x06, ALN1)
                        CreateByteField (BUFE, 0x07, LEN1)
                        CreateWordField (BUFE, 0x09, IRQ0)
                        ENFG ()
                        Store (LDLP, LDN)
                        Store (IOAH, Local0)
                        ShiftLeft (Local0, 0x02, Local0)
                        Store (Local0, IMI1)
                        Store (Local0, IMA1)
                        If (LEqual (IMI1, 0x03BC))
                        {
                            Store (0x04, ALN1)
                            Store (0x04, LEN1)
                        }
                        Else
                        {
                            Store (0x08, ALN1)
                            Store (0x08, LEN1)
                        }

                        Store (INTR, Local0)
                        Store (0x01, Local1)
                        ShiftLeft (Local1, Local0, IRQ0)
                        EXFG ()
                        Return (BUFE)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x02, IOAR)
                        CreateWordField (Arg0, 0x09, IRQ0)
                        ENFG ()
                        Store (LDLP, LDN)
                        Store (ACTR, Local2)
                        Or (Local2, 0x03, Local3)
                        Store (Local3, ACTR)
                        Store (IOAR, Local0)
                        ShiftRight (Local0, 0x02, Local0)
                        Store (Local0, IOAH)
                        FindSetRightBit (IRQ0, Local0)
                        If (LGreater (Local0, 0x00))
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, INTR)
                        Store (Local2, ACTR)
                        Store (Zero, PPPD)
                        EXFG ()
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                            IRQNoFlags () {5,7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                            IRQNoFlags () {5,7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                            IRQNoFlags () {5,7}
                        }
                        EndDependentFn ()
                    })
                }

                Device (ECP)
                {
                    Name (_HID, EisaId ("PNP0401"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LPST)
                        {
                            ENFG ()
                            Store (LDLP, LDN)
                            Store (ACTR, Local0)
                            Store (IOAH, Local1)
                            EXFG ()
                            And (Local0, 0x03, Local0)
                            If (LAnd (LEqual (Local0, 0x01), Local1))
                            {
                                Return (0x0F)
                            }
                        }

                        Return (Zero)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENFG ()
                        Store (One, PPPD)
                        EXFG ()
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFE, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                            IO (Decode16, 0x0778, 0x0778, 0x04, 0x04)
                            IRQNoFlags () {7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {3}
                        })
                        CreateWordField (BUFE, 0x02, IMI1)
                        CreateWordField (BUFE, 0x04, IMA1)
                        CreateByteField (BUFE, 0x06, ALN1)
                        CreateByteField (BUFE, 0x07, LEN1)
                        CreateWordField (BUFE, 0x0A, IMI2)
                        CreateWordField (BUFE, 0x0C, IMA2)
                        CreateWordField (BUFE, 0x11, IRQ0)
                        CreateByteField (BUFE, 0x14, DMA0)
                        ENFG ()
                        Store (LDLP, LDN)
                        Store (IOAH, Local0)
                        ShiftLeft (Local0, 0x02, Local0)
                        Store (Local0, IMI1)
                        Store (Local0, IMA1)
                        Add (Local0, 0x0400, Local0)
                        Store (Local0, IMI2)
                        Store (Local0, IMA2)
                        If (LEqual (IMI1, 0x03BC))
                        {
                            Store (0x04, ALN1)
                            Store (0x04, LEN1)
                        }
                        Else
                        {
                            Store (0x08, ALN1)
                            Store (0x08, LEN1)
                        }

                        Store (INTR, Local0)
                        Store (0x01, Local1)
                        ShiftLeft (Local1, Local0, IRQ0)
                        Store (DMCH, Local0)
                        And (Local0, 0x03, Local0)
                        Store (0x01, Local1)
                        ShiftLeft (Local1, Local0, DMA0)
                        EXFG ()
                        Return (BUFE)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x02, IOAR)
                        CreateWordField (Arg0, 0x11, IRQ0)
                        CreateByteField (Arg0, 0x14, DMA0)
                        ENFG ()
                        Store (LDLP, LDN)
                        Store (ACTR, Local2)
                        Or (Local2, 0x03, Local3)
                        Store (Local3, ACTR)
                        Store (IOAR, Local0)
                        ShiftRight (Local0, 0x02, Local0)
                        Store (Local0, IOAH)
                        FindSetRightBit (IRQ0, Local0)
                        If (LGreater (Local0, 0x00))
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, INTR)
                        FindSetRightBit (DMA0, Local0)
                        If (LGreater (Local0, 0x00))
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, DMCH)
                        Store (Local2, ACTR)
                        Store (Zero, PPPD)
                        EXFG ()
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                            IO (Decode16, 0x0778, 0x0778, 0x04, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {0=
,1,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                            IO (Decode16, 0x0678, 0x0678, 0x04, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {0=
,1,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                            IO (Decode16, 0x07BC, 0x07BC, 0x04, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {0=
,1,3}
                        }
                        EndDependentFn ()
                    })
                }

                Method (GSTA, 1, NotSerialized)
                {
                    ENFG ()
                    Store (Arg0, LDN)
                    If (ACTR)
                    {
                        Store (0x0F, Local0)
                    }
                    Else
                    {
                        If (IOAH)
                        {
                            Store (0x0D, Local0)
                        }
                        Else
                        {
                            Store (0x00, Local0)
                        }
                    }

                    EXFG ()
                    Return (Local0)
                }

                Method (DDIS, 1, NotSerialized)
                {
                    ENFG ()
                    Store (Arg0, LDN)
                    Store (Zero, ACTR)
                    EXFG ()
                }

                Method (DENB, 1, NotSerialized)
                {
                    ENFG ()
                    Store (Arg0, LDN)
                    Store (One, ACTR)
                    EXFG ()
                }

                Name (CSCP, 0x00)
                PowerResource (URP1, 0x01, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (CSCP)
                    }

                    Method (_ON, 0, NotSerialized)
                    {
                        Store (0x01, CSCP)
                    }

                    Method (_OFF, 0, NotSerialized)
                    {
                        Store (0x00, CSCP)
                    }
                }

                PowerResource (URP2, 0x01, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (CSCP)
                    }

                    Method (_ON, 0, NotSerialized)
                    {
                        Store (0x01, CSCP)
                    }

                    Method (_OFF, 0, NotSerialized)
                    {
                        Store (0x00, CSCP)
                    }
                }

                PowerResource (FDDP, 0x00, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (CSCP)
                    }

                    Method (_ON, 0, NotSerialized)
                    {
                        Store (0x01, CSCP)
                    }

                    Method (_OFF, 0, NotSerialized)
                    {
                        Store (0x00, CSCP)
                    }
                }

                PowerResource (LPTP, 0x00, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (CSCP)
                    }

                    Method (_ON, 0, NotSerialized)
                    {
                        Store (0x01, CSCP)
                    }

                    Method (_OFF, 0, NotSerialized)
                    {
                        Store (0x00, CSCP)
                    }
                }

                Name (FCRS, ResourceTemplate ()
                {
                    IO (Decode16, 0x03F2, 0x03F2, 0x01, 0x02)
                    IO (Decode16, 0x03F4, 0x03F4, 0x01, 0x02)
                    IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                    IRQNoFlags () {6}
                    DMA (Compatibility, NotBusMaster, Transfer8) {2}
                })
                Name (FPRS, ResourceTemplate ()
                {
                    StartDependentFn (0x00, 0x00)
                    {
                        IO (Decode16, 0x03F2, 0x03F2, 0x01, 0x02)
                        IO (Decode16, 0x03F4, 0x03F4, 0x01, 0x02)
                        IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                        IRQNoFlags () {6}
                        DMA (Compatibility, NotBusMaster, Transfer8) {2}
                    }
                    EndDependentFn ()
                })
                OperationRegion (OPR0, SystemIO, 0x0378, 0x80)
                Field (OPR0, ByteAcc, NoLock, Preserve)
                {
                    P378,   8
                }

                Field (BIOS, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x80),=20
                    BIF0,   16,=20
                    BIF1,   16,=20
                    BIF2,   16,=20
                    BIF3,   16,=20
                    BIF4,   16,=20
                    BIF5,   16,=20
                    BIF6,   16,=20
                    BIF7,   16,=20
                    BIF8,   16,=20
                    BIF9,   64,=20
                    BIFA,   64,=20
                    BIFB,   64,=20
                    BIFC,   64,=20
                    BST0,   16,=20
                    BST1,   16,=20
                    BST2,   16,=20
                    BST3,   16,=20
                    BTP0,   16,=20
                    ACIN,   1,=20
                        ,   1,=20
                    BTIN,   1,=20
                    Offset (0xC0),=20
                    OSEC,   8,=20
                    SLPT,   8
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
                        Name (FGEC, 0x00)
                        Method (_REG, 2, NotSerialized)
                        {
                            If (LEqual (Arg0, 0x03))
                            {
                                Store (Arg1, FGEC)
                            }

                            If (LEqual (OSFL (), 0x01))
                            {
                                Store (0x01, OSEC)
                            }
                            Else
                            {
                                If (LEqual (OSFL (), 0x00))
                                {
                                    Store (0x02, OSEC)
                                }
                                Else
                                {
                                    If (LEqual (OSFL (), 0x02))
                                    {
                                        Store (0x03, OSEC)
                                    }

                                    If (LEqual (OSFL (), 0x04))
                                    {
                                        Store (0x04, OSEC)
                                    }
                                }
                            }

                            Store (0xB8, SWI0)
                        }

                        OperationRegion (ECXP, EmbeddedControl, 0x00, 0x010=
0)
                        Field (ECXP, ByteAcc, Lock, Preserve)
                        {
                            XIF0,   16,=20
                            XIF1,   16,=20
                            XIF2,   16,=20
                            XIF3,   16,=20
                            XIF4,   16,=20
                            XIF5,   16,=20
                            XIF6,   16,=20
                            XIF7,   16,=20
                            XIF8,   16,=20
                            XIF9,   64,=20
                            XIFA,   64,=20
                            XIFB,   64,=20
                            XIFC,   64,=20
                            XST0,   16,=20
                            XST1,   16,=20
                            XST2,   16,=20
                            XST3,   16,=20
                            XTP0,   16,=20
                            XCIN,   1,=20
                                ,   1,=20
                            XTIN,   1,=20
                            Offset (0x3D),=20
                            Offset (0x3E),=20
                            XHPP,   7,=20
                            Offset (0x3F),=20
                            Offset (0x40),=20
                            XSEC,   8,=20
                            XLPT,   8
                        }

                        Name (_GPE, 0x1C)
                        Method (_Q06, 0, NotSerialized)
                        {
                            If (LEqual (OSFL (), 0x03))
                            {
                                If (BTIN)
                                {
                                    Notify (\_SB.PCI0.BAT0, 0x01)
                                }
                                Else
                                {
                                    Notify (\_SB.PCI0.BAT0, 0x00)
                                }

                                Notify (\_SB.PCI0.BAT0, 0x80)
                            }

                            If (LEqual (OSFL (), 0x01))
                            {
                                If (BTIN)
                                {
                                    Notify (\_SB.PCI0.BAT0, 0x01)
                                }
                                Else
                                {
                                    Notify (\_SB.PCI0.BAT0, 0x00)
                                }

                                Notify (\_SB.PCI0.BAT0, 0x80)
                                Notify (\_SB.PCI0, 0x00)
                            }

                            If (LEqual (OSFL (), 0x02))
                            {
                                Store (0x01, FAKE)
                                Notify (\_SB.PCI0.AC0, 0x00)
                                Store (0x00, FAKE)
                                Notify (\_SB.PCI0.AC0, 0x00)
                                If (BTIN)
                                {
                                    Notify (\_SB.PCI0.BAT0, 0x00)
                                }
                                Else
                                {
                                    Notify (\_SB.PCI0.BAT0, 0x03)
                                }

                                Notify (\_SB.PCI0.BAT0, 0x81)
                                Notify (\_SB.PCI0.BAT0, 0x80)
                            }

                            If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (=
), 0x04)))
                            {
                                Sleep (0x01F4)
                                If (\_SB.PCI0.SBRG.EC0.XTIN)
                                {
                                    Notify (\_SB.PCI0.BAT0, 0x01)
                                }
                                Else
                                {
                                    Notify (\_SB.PCI0.BAT0, 0x00)
                                }

                                Notify (\_SB.PCI0.BAT0, 0x80)
                            }
                        }

                        Method (_Q07, 0, NotSerialized)
                        {
                            Store (0x07, P378)
                            If (LEqual (OSFL (), 0x01))
                            {
                                Store (0x00, FAKE)
                                Notify (\_SB.PCI0.AC0, 0x00)
                            }

                            If (LEqual (OSFL (), 0x02))
                            {
                                Store (0x00, FAKE)
                                Notify (\_SB.PCI0.AC0, 0x00)
                            }

                            If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (=
), 0x04)))
                            {
                                Notify (\_SB.PCI0.AC0, 0x80)
                                Notify (\_SB.PCI0.BAT0, 0x80)
                            }
                        }

                        Method (_Q0A, 0, NotSerialized)
                        {
                            Store (0xF1, P378)
                            Notify (\_SB.SLPB, 0x80)
                        }

                        Method (_Q0B, 0, NotSerialized)
                        {
                            Store (0xF2, P378)
                        }

                        Method (_Q0C, 0, NotSerialized)
                        {
                            Store (0xF3, P378)
                        }

                        Method (_Q0D, 0, NotSerialized)
                        {
                            Store (0xF4, P378)
                            If (LEqual (\_SB.PCI0.AGP.VGA.SWIT, 0x00))
                            {
                                If (LEqual (\_SB.PCI0.AGP.VGA.GDFG, 0x01))
                                {
                                    Notify (\_SB.PCI0.AGP.VGA, 0x80)
                                    Store (0x00, \_SB.PCI0.AGP.VGA.GDFG)
                                    Sleep (0x07D0)
                                }

                                If (LEqual (\_SB.PCI0.AGP.VGA.GDTS, 0x00))
                                {
                                    If (LEqual (\_SB.PCI0.AGP.VGA.GDGS, 0x0=
1))
                                    {
                                        Store (0x00, \_SB.PCI0.AGP.VGA.LCD.=
_DGS)
                                        Store (0x01, \_SB.PCI0.AGP.VGA.CRT.=
_DGS)
                                    }

                                    If (LEqual (\_SB.PCI0.AGP.VGA.GDGS, 0x0=
2))
                                    {
                                        Store (0x01, \_SB.PCI0.AGP.VGA.LCD.=
_DGS)
                                        Store (0x00, \_SB.PCI0.AGP.VGA.CRT.=
_DGS)
                                    }

                                    If (LEqual (\_SB.PCI0.AGP.VGA.GDGS, 0x0=
3))
                                    {
                                        Store (0x01, \_SB.PCI0.AGP.VGA.LCD.=
_DGS)
                                        Store (0x01, \_SB.PCI0.AGP.VGA.CRT.=
_DGS)
                                    }

                                    Notify (\_SB.PCI0.AGP.VGA, 0x80)
                                    If (LEqual (\_SB.PCI0.AGP.VGA.GDGS, 0x0=
3))
                                    {
                                        Store (0x01, \_SB.PCI0.AGP.VGA.GDGS)
                                    }
                                    Else
                                    {
                                        Add (0x01, \_SB.PCI0.AGP.VGA.GDGS, =
\_SB.PCI0.AGP.VGA.GDGS)
                                    }
                                }
                            }
                        }

                        Method (_Q0E, 0, NotSerialized)
                        {
                            Store (0xF5, P378)
                            If (LEqual (OSFL (), 0x01))
                            {
                                Store (0xA4, SWI0)
                            }
                        }

                        Method (_Q0F, 0, NotSerialized)
                        {
                            Store (0xF6, P378)
                            If (LEqual (OSFL (), 0x01))
                            {
                                Store (0xA5, SWI0)
                            }
                        }

                        Method (_Q1C, 0, NotSerialized)
                        {
                            Store (0x1C, P378)
                            If (LEqual (OSFL (), 0x01))
                            {
                                Store (0xBE, SWI0)
                            }
                        }

                        Method (_Q1D, 0, NotSerialized)
                        {
                            Store (0x1D, P378)
                            If (LEqual (OSFL (), 0x01))
                            {
                                Store (0xBF, SWI0)
                            }
                        }

                        Method (_Q10, 0, NotSerialized)
                        {
                            Store (0xF7, P378)
                            Store (0xA6, SWI0)
                        }

                        Method (_Q11, 0, NotSerialized)
                        {
                            Store (0xF8, P378)
                            Store (0xA7, SWI0)
                        }

                        Method (_Q12, 0, NotSerialized)
                        {
                            Store (0xF9, P378)
                        }

                        Method (_Q13, 0, NotSerialized)
                        {
                            Store (0xFA, P378)
                        }

                        Method (_Q14, 0, NotSerialized)
                        {
                            Store (0xFB, P378)
                        }

                        Method (_Q15, 0, NotSerialized)
                        {
                            Store (0xFC, P378)
                        }

                        Method (_Q16, 0, NotSerialized)
                        {
                            Store (0x16, P378)
                            Store (0x01, LIDS)
                            Notify (\_SB.PCI0.SBRG.LID, 0x80)
                        }

                        Method (_Q19, 0, NotSerialized)
                        {
                            Store (0x19, P378)
                            Store (0x00, LIDS)
                            Notify (\_SB.PCI0.SBRG.LID, 0x80)
                        }

                        Method (_Q1A, 0, NotSerialized)
                        {
                            Store (0x1A, P378)
                            If (LEqual (OSFL (), 0x01))
                            {
                                Store (0xBC, SWI0)
                            }
                        }

                        Method (_Q1B, 0, NotSerialized)
                        {
                            Store (0x1B, P378)
                            If (LEqual (OSFL (), 0x01))
                            {
                                Store (0xBD, SWI0)
                            }
                        }

                        Method (_Q1E, 0, NotSerialized)
                        {
                            Store (0x1E, P378)
                            Store (0x00, THRT)
                        }

                        Method (_Q1F, 0, NotSerialized)
                        {
                            Store (0x1F, P378)
                            Store (0x1E, THRT)
                        }

                        Method (_Q20, 0, NotSerialized)
                        {
                            Store (0x20, P378)
                            Store (0x1C, THRT)
                        }

                        Method (_Q21, 0, NotSerialized)
                        {
                            Store (0x21, P378)
                            Store (0x1A, THRT)
                        }

                        Method (_Q22, 0, NotSerialized)
                        {
                            Store (0x22, P378)
                            Store (0x18, THRT)
                        }

                        Method (_Q23, 0, NotSerialized)
                        {
                            Store (0x23, P378)
                            Store (0x16, THRT)
                        }

                        Method (_Q24, 0, NotSerialized)
                        {
                            Store (0x24, P378)
                            Store (0x14, THRT)
                        }

                        Method (_Q25, 0, NotSerialized)
                        {
                            Store (0x25, P378)
                            Store (0xB5, SWI0)
                        }

                        Method (_Q26, 0, NotSerialized)
                        {
                            Store (0x26, P378)
                            Store (0xB6, SWI0)
                        }

                        Method (_Q27, 0, NotSerialized)
                        {
                            Store (0x27, P378)
                            Store (0x69, THPP)
                            Notify (\_TZ.THRM, 0x80)
                        }

                        Device (\_SB.PCI0.BAT0)
                        {
                            Name (_HID, EisaId ("PNP0C0A"))
                            Name (_UID, 0x00)
                            Name (_PCL, Package (0x01)
                            {
                                \_SB.PCI0.SBRG.EC0
                            })
                            Name (PAK1, Package (0x0D)
                            {
                                0x00,=20
                                0x0C56,=20
                                0x0C56,=20
                                0x00,=20
                                0x2A30,=20
                                0x013B,=20
                                0x9D,=20
                                0x10,=20
                                0x08,=20
                                "755",=20
                                "001",=20
                                "LiON",=20
                                "OEM"
                            })
                            Method (_BIF, 0, NotSerialized)
                            {
                                Store ("BIf", Debug)
                                If (LOr (LEqual (OSFL (), 0x00), LEqual (OS=
FL (), 0x04)))
                                {
                                    Store (\_SB.PCI0.SBRG.EC0.XIF0, Index (=
PAK1, 0x00))
                                    Store (\_SB.PCI0.SBRG.EC0.XIF1, Index (=
PAK1, 0x01))
                                    Store (\_SB.PCI0.SBRG.EC0.XIF2, Local0)
                                    Store (Local0, Index (PAK1, 0x02))
                                    Store (\_SB.PCI0.SBRG.EC0.XIF3, Index (=
PAK1, 0x03))
                                    Store (\_SB.PCI0.SBRG.EC0.XIF4, Index (=
PAK1, 0x04))
                                    Store (Divide (Local0, 0x0A, ), Index (=
PAK1, 0x05))
                                    Store (Divide (Local0, 0x14, ), Index (=
PAK1, 0x06))
                                    Store (\_SB.PCI0.SBRG.EC0.XIF7, Index (=
PAK1, 0x07))
                                }
                                Else
                                {
                                    Store (0xB9, SWI0)
                                    Store (BIF0, Index (PAK1, 0x00))
                                    Store (BIF1, Index (PAK1, 0x01))
                                    Store (BIF2, Local0)
                                    Store (Local0, Index (PAK1, 0x02))
                                    Store (BIF3, Index (PAK1, 0x03))
                                    Store (BIF4, Index (PAK1, 0x04))
                                    Store (Divide (Local0, 0x0A, ), Index (=
PAK1, 0x05))
                                    Store (Divide (Local0, 0x14, ), Index (=
PAK1, 0x06))
                                    Store (BIF7, Index (PAK1, 0x07))
                                }

                                Return (PAK1)
                            }

                            Name (BFB0, Package (0x04)
                            {
                                0x00,=20
                                0xFFFFFFFF,=20
                                0x1034,=20
                                0x2A30
                            })
                            Method (_BST, 0, NotSerialized)
                            {
                                Store ("BST Start", Debug)
                                If (LOr (LEqual (OSFL (), 0x00), LEqual (OS=
FL (), 0x04)))
                                {
                                    Store (\_SB.PCI0.SBRG.EC0.XST0, Index (=
BFB0, 0x00))
                                    Store (\_SB.PCI0.SBRG.EC0.XST2, Index (=
BFB0, 0x02))
                                    Store (\_SB.PCI0.SBRG.EC0.XST3, Index (=
BFB0, 0x03))
                                }
                                Else
                                {
                                    Store (0xBA, SWI0)
                                    Store (BST0, Index (BFB0, 0x00))
                                    Store (BST1, Index (BFB0, 0x01))
                                    Store (BST2, Index (BFB0, 0x02))
                                    Store (BST3, Index (BFB0, 0x03))
                                }

                                Store ("BST End", Debug)
                                Return (BFB0)
                            }

                            Method (_BTP, 1, NotSerialized)
                            {
                                If (LOr (LEqual (OSFL (), 0x00), LEqual (OS=
FL (), 0x04)))
                                {
                                    Store (Arg0, \_SB.PCI0.SBRG.EC0.XTP0)
                                }
                                Else
                                {
                                    Store (Arg0, BTP0)
                                    Store (0x33, SWI0)
                                }
                            }

                            Method (_STA, 0, NotSerialized)
                            {
                                Store ("BAT_STA Start", Debug)
                                If (LOr (LEqual (OSFL (), 0x00), LEqual (OS=
FL (), 0x04)))
                                {
                                    If (LEqual (\_SB.PCI0.SBRG.EC0.FGEC, 0x=
00))
                                    {
                                        Store (0xB8, SWI0)
                                        Store (BTIN, Local0)
                                    }
                                    Else
                                    {
                                        Store (\_SB.PCI0.SBRG.EC0.XTIN, Loc=
al0)
                                    }
                                }
                                Else
                                {
                                    Store (0xB8, SWI0)
                                    Store (BTIN, Local0)
                                }

                                If (Local0)
                                {
                                    Return (0x1F)
                                    Store (0x1F, P378)
                                }
                                Else
                                {
                                    Return (0x0F)
                                    Store (0x0F, P378)
                                }

                                Store ("BAT_STA END", Debug)
                            }
                        }

                        Device (\_SB.PCI0.AC0)
                        {
                            Name (_HID, "ACPI0003")
                            Name (_PCL, Package (0x01)
                            {
                                \_SB.PCI0.SBRG.EC0
                            })
                            Method (_PSR, 0, NotSerialized)
                            {
                                If (LNot (LEqual (FAKE, 0x00)))
                                {
                                    Return (0x00)
                                }
                                Else
                                {
                                    If (LOr (LEqual (OSFL (), 0x00), LEqual=
 (OSFL (), 0x04)))
                                    {
                                        Store (\_SB.PCI0.SBRG.EC0.XCIN, Loc=
al0)
                                    }
                                    Else
                                    {
                                        Store (ACIN, Local0)
                                    }

                                    Return (Local0)
                                }
                            }
                        }

                        Scope (\_TZ)
                        {
                            ThermalZone (THRM)
                            {
                                Method (KELV, 1, NotSerialized)
                                {
                                    If (LGreater (Arg0, 0x7F))
                                    {
                                        XOr (Arg0, 0xFF, Local0)
                                        Add (Local0, 0x01, Local0)
                                        Multiply (Local0, 0x0A, Local0)
                                        Subtract (0x0AAC, Local0, Local1)
                                    }
                                    Else
                                    {
                                        Multiply (Arg0, 0x0A, Local0)
                                        Add (Local0, 0x0AAC, Local1)
                                    }

                                    Return (Local1)
                                }

                                Method (_TMP, 0, NotSerialized)
                                {
                                    Return (KELV (THPP))
                                }

                                Method (_CRT, 0, NotSerialized)
                                {
                                    Return (KELV (0x55))
                                }
                            }
                        }
                    }
                }

                Scope (\_SB)
                {
                    Method (_INI, 0, NotSerialized)
                    {
                        Store (DCPU, Local0)
                        And (Local0, 0xF7, DCPU)
                    }

                    Device (\_SB.PCI0.SBRG.LID)
                    {
                        Name (_HID, EisaId ("PNP0C0D"))
                        Method (_LID, 0, NotSerialized)
                        {
                            Return (LIDS)
                        }
                    }

                    Device (\_SB.SLPB)
                    {
                        Name (_HID, EisaId ("PNP0C0E"))
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (0x0B)
                        }

                        Method (SBEV, 0, NotSerialized)
                        {
                            If (SLPP)
                            {
                                Store (0x00, SLPP)
                                Notify (SLPB, 0x02)
                            }
                            Else
                            {
                                Store (0x01, SLPP)
                                Notify (SLPB, 0x80)
                            }
                        }
                    }

                    Device (\_SB.PCI0.P0P2.CBC0)
                    {
                        Name (_ADR, 0x00030000)
                        Name (_PRW, Package (0x02)
                        {
                            0x0B,=20
                            0x04
                        })
                        OperationRegion (CBR0, PCI_Config, 0x00, 0xFF)
                        Field (CBR0, DWordAcc, NoLock, Preserve)
                        {
                            Offset (0x44),=20
                            C044,   32,=20
                            Offset (0xA4),=20
                            C0A4,   8,=20
                            C0A5,   8
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            Return (0x0F)
                        }

                        Method (_INI, 0, NotSerialized)
                        {
                            Store (0x00, \_SB.PCI0.P0P2.CBC0.C044)
                        }
                    }
                }

                Scope (\_SB.PCI0)
                {
                    Device (AGP)
                    {
                        Name (_ADR, 0x00010000)
                        Device (VGA)
                        {
                            Name (_ADR, 0x00)
                            Method (_DOS, 1, NotSerialized)
                            {
                                Store (Arg0, SWIT)
                            }

                            Name (_DOD, Package (0x02)
                            {
                                0x00010100,=20
                                0x00010110
                            })
                            Device (CRT)
                            {
                                Name (_ADR, 0x0100)
                                Name (_DCS, 0x1F)
                                Name (_DGS, 0x01)
                                Method (_DSS, 1, NotSerialized)
                                {
                                }
                            }

                            Device (LCD)
                            {
                                Name (_ADR, 0x0110)
                                Name (_DCS, 0x1F)
                                Name (_DGS, 0x01)
                                Method (_DSS, 1, NotSerialized)
                                {
                                }

                                Method (_BCM, 1, NotSerialized)
                                {
                                }

                                Name (PBCL, Package (0x07)
                                {
                                    0x50,=20
                                    0x32,=20
                                    0x14,=20
                                    0x28,=20
                                    0x3C,=20
                                    0x50,=20
                                    0x64
                                })
                                Method (_BCL, 0, NotSerialized)
                                {
                                    Return (PBCL)
                                }
                            }

                            Name (SWIT, 0x00)
                            Name (GDCS, 0x02)
                            Name (GDGS, 0x01)
                            Name (GDTS, 0x00)
                            Name (GDFG, 0x01)
                        }
                    }
                }
            }
        }

        Scope (\_GPE)
        {
            Method (_L0B, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.P0P2, 0x02)
                Notify (\_SB.PCI0.P0P2.LAN1, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }

            Method (_L05, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.MC97, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }

            Method (_L1D, 0, NotSerialized)
            {
                \_SB.PCI0.SBRG.SIOH ()
                Notify (\_SB.PWRB, 0x02)
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_UID, 0x1D)
            Name (_STA, 0x0B)
            Method (_PRW, 0, NotSerialized)
            {
                Return (GPRW (0x1D, 0x05))
            }
        }
    }

    Scope (\_SB)
    {
        OperationRegion (\_SB.PCI0.SBRG.IROR, PCI_Config, 0x00, 0xFF)
        Field (\_SB.PCI0.SBRG.IROR, ByteAcc, NoLock, Preserve)
        {
            Offset (0x60),=20
            PIRA,   8,=20
            PIRB,   8,=20
            PIRC,   8,=20
            PIRD,   8,=20
            Offset (0x68),=20
            PIRE,   8,=20
            PIRF,   8,=20
            PIRG,   8,=20
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
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDec=
ode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, En=
tireRange,
                    0x0000,
                    0x0000,
                    0x0CF7,
                    0x0000,
                    0x0CF8)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, En=
tireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixe=
d, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixe=
d, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixe=
d, Cacheable, ReadWrite,
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
        Name (\_SB.PCI0.P0P2._S1D, 0x02)
        Name (\_SB.PCI0.USB1._S1D, 0x02)
        Name (\_SB.PCI0.USB2._S1D, 0x02)
        Name (\_SB.PCI0.USB3._S1D, 0x02)
    }

    If (SS3)
    {
        Name (\_SB.PCI0._S3D, 0x02)
        Name (\_SB.PCI0.P0P2._S3D, 0x02)
        Name (\_SB.PCI0.USB1._S3D, 0x02)
        Name (\_SB.PCI0.USB2._S3D, 0x02)
        Name (\_SB.PCI0.USB3._S3D, 0x02)
    }

    If (SS4)
    {
        Name (\_SB.PCI0._S4D, 0x02)
        Name (\_SB.PCI0.P0P2._S4D, 0x02)
    }

    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, P378)
        PTS (Arg0)
        Store (0x00, Index (WAKP, 0x00))
        Store (0x00, Index (WAKP, 0x01))
    }

    Method (_WAK, 1, NotSerialized)
    {
        ShiftLeft (Arg0, 0x04, P378)
        WAK (Arg0)
        If (LEqual (Arg0, 0x04))
        {
            Notify (\_SB.PWRB, 0x02)
            If (LEqual (OSFL (), 0x01))
            {
                Store (0x01, OSEC)
            }
            Else
            {
                If (LEqual (OSFL (), 0x00))
                {
                    Store (0x02, OSEC)
                }
                Else
                {
                    If (LEqual (OSFL (), 0x02))
                    {
                        Store (0x03, OSEC)
                    }
                }
            }

            Store (0xB8, SWI0)
        }

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

    OperationRegion (PMRG, SystemIO, 0x0400, 0x80)
    Field (PMRG, ByteAcc, NoLock, Preserve)
    {
        Offset (0x04),=20
        SCIF,   1,=20
        Offset (0x06),=20
        RTCS,   8,=20
        Offset (0x10),=20
        THRT,   8,=20
        Offset (0x2D),=20
        DCPU,   8,=20
        Offset (0x30),=20
            ,   4,=20
        SLPS,   1
    }

    OperationRegion (OPR1, SystemIO, 0xB2, 0x02)
    Field (OPR1, ByteAcc, NoLock, Preserve)
    {
        SWI0,   8
    }

    OperationRegion (OPR2, SystemIO, 0x0378, 0x02)
    Field (OPR2, ByteAcc, NoLock, Preserve)
    {
        P378,   8
    }

    Name (THPP, 0x4B)
    Name (FAKE, 0x00)
    Name (LIDS, 0x01)
    Name (SLPP, 0x00)
    Field (BIOS, ByteAcc, NoLock, Preserve)
    {
        Offset (0x80),=20
        BIF0,   16,=20
        BIF1,   16,=20
        BIF2,   16,=20
        BIF3,   16,=20
        BIF4,   16,=20
        BIF5,   16,=20
        BIF6,   16,=20
        BIF7,   16,=20
        BIF8,   16,=20
        BIF9,   64,=20
        BIFA,   64,=20
        BIFB,   64,=20
        BIFC,   64,=20
        BST0,   16,=20
        BST1,   16,=20
        BST2,   16,=20
        BST3,   16,=20
        BTP0,   16,=20
        ACIN,   1,=20
            ,   1,=20
        BTIN,   1,=20
        Offset (0xC0),=20
        OSEC,   8,=20
        SLPT,   8
    }

    Name (\_S0, Package (0x04)
    {
        0x00,=20
        0x00,=20
        0x00,=20
        0x00
    })
    If (SS1)
    {
        Name (\S3, Package (0x04)
        {
            0x01,=20
            0x00,=20
            0x00,=20
            0x00
        })
    }

    If (SS3)
    {
        Name (\_S3, Package (0x04)
        {
            0x05,=20
            0x00,=20
            0x00,=20
            0x00
        })
    }

    If (SS4)
    {
        Name (\_S4, Package (0x04)
        {
            0x07,=20
            0x00,=20
            0x00,=20
            0x00
        })
    }

    Name (\_S5, Package (0x04)
    {
        0x07,=20
        0x00,=20
        0x00,=20
        0x00
    })
    Method (PTS, 1, NotSerialized)
    {
        If (Arg0)
        {
            \_SB.PCI0.SBRG.SIOS (Arg0)
        }
    }

    Method (WAK, 1, NotSerialized)
    {
        \_SB.PCI0.SBRG.SIOW (Arg0)
    }
}


--Dxnq1zWXvFF0Q93v--

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBRQQf6EeWSkhF85cRArXHAJ94XsZBXeif3hrZYneYJbPrpqqZzwCfUXzX
jNzdLKUzy7K7pMPjfIYMw2w=
=fGX+
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
