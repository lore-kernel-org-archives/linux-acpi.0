From: "CHP.Dekker" <chp.dekker-OdOgJZujJHXcqV2Q6a4srg@public.gmane.org>
Subject: VIA KT333 acpi DSDT bug
Date: Mon, 2 Feb 2004 15:04:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402021504.25352.chp.dekker@hsdrenthe.nl>
Reply-To: chp.dekker-OdOgJZujJHXcqV2Q6a4srg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

Hello,
I use a VIA KT333 motherboard.

It hase some bugs in the DSDT file and I don't know how to fix them.
Once when I had xp installed on it (2 days long ;) I had S0 t/m S5 (Ofcourse 
not called that way by M$cro)
No ACPI (sleep) say I only have S0 S3 S4 S5
Some time none of them work becuase "one process didn't stop" But now it "at 
least I can "use S3", all that it does is putting my computer in 1/10000 sec 
to sleep (S3) mode and can be re-awakend. The lid switch doesn't do any 
thing.

Maybe there is already a DSDT patch, but for some reason the pathes are 
ordened by computer brands and not by chip-set brand, still I have looked 
there but as far as I know there isn't a VIA / VIA KT333 DSDT file.

I have tried to fix the bugs, even read a howto (+ some howto's it pointed to) 
and couldn't find a solution to my problem

So I hope that some one can fix my DSDT file

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of dsdt.dat, Sun Feb  1 14:51:33 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA", "VIA_K7", 4096)
{
    Name (APIC, 0x00)
    Method (\_PIC, 1, NotSerialized)
    {
        Store (Arg0, APIC)
    }

    Scope (\_PR)
    {
        Processor (CPU1, 0x01, 0x00000810, 0x06)
        {
            Name (_PCT, Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 0x08, 0x00, 0x00000000000000B2)
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 0x08, 0x00, 0x00000000000000B3)
                }
            })
            Name (_PSS, Package (0x08)
            {
                Package (0x06)
                {
                    0x0708, 
                    0xAFC8, 
                    0x7D, 
                    0x7D, 
                    0x00D05975, 
                    0x0175
                }, 

                Package (0x06)
                {
                    0x0640, 
                    0x9C40, 
                    0x7D, 
                    0x7D, 
                    0x00D05962, 
                    0x0162
                }, 

                Package (0x06)
                {
                    0x05BB, 
                    0x8F3A, 
                    0x7D, 
                    0x7D, 
                    0x00D05960, 
                    0x0160
                }, 

                Package (0x06)
                {
                    0x0535, 
                    0x8235, 
                    0x7D, 
                    0x7D, 
                    0x00D0596E, 
                    0x016E
                }, 

                Package (0x06)
                {
                    0x04B0, 
                    0x7530, 
                    0x7D, 
                    0x7D, 
                    0x00D0596C, 
                    0x016C
                }, 

                Package (0x06)
                {
                    0x042B, 
                    0x682A, 
                    0x7D, 
                    0x7D, 
                    0x00D0596A, 
                    0x016A
                }, 

                Package (0x06)
                {
                    0x03A5, 
                    0x5B25, 
                    0x7D, 
                    0x7D, 
                    0x00D05968, 
                    0x0168
                }, 

                Package (0x06)
                {
                    0x0320, 
                    0x4E20, 
                    0x7D, 
                    0x7D, 
                    0x00D05966, 
                    0x0166
                }
            })
            Method (_PPC, 0, NotSerialized)
            {
                Return (0x00)
            }
        }
    }

    Name (\_S0, Package (0x04)
    {
        0x00, 
        0x00, 
        0x00, 
        0x00
    })
    Name (\_S3, Package (0x04)
    {
        0x01, 
        0x00, 
        0x00, 
        0x00
    })
    Name (\_S4, Package (0x04)
    {
        0x02, 
        0x00, 
        0x00, 
        0x00
    })
    Name (\_S5, Package (0x04)
    {
        0x02, 
        0x00, 
        0x00, 
        0x00
    })
    Name (PTBF, Buffer (0x03)
    {
        0x00, 0x00, 0x00
    })
    CreateByteField (PTBF, 0x00, PTB0)
    CreateByteField (PTBF, 0x01, PTB1)
    CreateByteField (PTBF, 0x02, PTB2)
    Method (MCTH, 2, NotSerialized)
    {
        If (LLess (SizeOf (Arg0), SizeOf (Arg1)))
        {
            Return (0x00)
        }

        Add (SizeOf (Arg0), 0x01, Local0)
        Name (BUF0, Buffer (Local0) {})
        Name (BUF1, Buffer (Local0) {})
        Store (Arg0, BUF0)
        Store (Arg1, BUF1)
        While (Local0)
        {
            Decrement (Local0)
            If (LEqual (DerefOf (Index (BUF0, Local0)), DerefOf (Index (BUF1, 
Local0)))) {}
            Else
            {
                Return (Zero)
            }
        }

        Return (One)
    }

    Scope (\_SB)
    {
        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            Method (_S3D, 0, NotSerialized)
            {
                If (LLess (OSFL, 0x03))
                {
                    Return (0x02)
                }
                Else
                {
                    Return (0x03)
                }
            }

            Name (CRS, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, 
PosDecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, 
EntireRange,
                    0x0000,
                    0x0000,
                    0x0CF7,
                    0x0000,
                    0x0CF8)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, 
EntireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, 
Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, 
Cacheable, ReadWrite,
                    0x00000000,
                    0x000C0000,
                    0x000DFFFF,
                    0x00000000,
                    0x00020000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, 
Cacheable, ReadWrite,
                    0x00000000,
                    0x20000000,
                    0xFFDFFFFF,
                    0x00000000,
                    0xDFE00000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, 
Cacheable, ReadWrite,
                    0x00000000,
                    0xFEE01000,
                    0xFFDFFFFF,
                    0x00000000,
                    0x00FFF000)
            })
            OperationRegion (GART, PCI_Config, 0x80, 0x01)
            Field (GART, ByteAcc, NoLock, Preserve)
            {
                    ,   1, 
                TLBC,   1
            }

            OperationRegion (TTBR, PCI_Config, 0x88, 0x01)
            Field (TTBR, ByteAcc, NoLock, Preserve)
            {
                    ,   1, 
                GATR,   1
            }

            OperationRegion (BSR0, PCI_Config, 0xF4, 0x01)
            Field (BSR0, ByteAcc, NoLock, Preserve)
            {
                SPLV,   3, 
                W2FG,   2, 
                    ,   2, 
                RTCX,   1
            }

            OperationRegion (TMEM, PCI_Config, 0x57, 0x01)
            Field (TMEM, ByteAcc, NoLock, Preserve)
            {
                MEMT,   8
            }

            Name (TOM, 0x00)
            Method (MDET, 0, NotSerialized)
            {
                If (TOM) {}
                Else
                {
                    If (FLAG)
                    {
                        ShiftLeft (MEMT, 0x18, TOM)
                    }
                    Else
                    {
                        Return (0x20000000)
                    }
                }

                Return (TOM)
            }

            Method (TFCS, 0, NotSerialized)
            {
                Subtract (MDET (), 0x7FC0, Local0)
                Return (Local0)
            }

            Name (FLAG, 0x01)
            Name (OSFL, 0x00)
            Name (\TOOS, 0x00)
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

            Method (_INI, 0, NotSerialized)
            {
                If (CondRefOf (_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x04, \TOOS)
                    }
                }
                Else
                {
                    Store (\_OS, Local0)
                    Store (SCMP (Local0, "Microsoft Windows NT"), Local1)
                    If (LEqual (Local1, Zero))
                    {
                        Store (0x02, \TOOS)
                    }
                    Else
                    {
                        Store (SCMP (Local0, "Microsoft Windows"), Local2)
                        If (LEqual (Local2, Zero))
                        {
                            Store (0x01, \TOOS)
                        }
                        Else
                        {
                            Store (SCMP (Local0, "Microsoft WindowsME: 
Millennium Edition"), Local3)
                            If (LEqual (Local3, Zero))
                            {
                                Store (0x03, \TOOS)
                            }
                            Else
                            {
                                Store (0x00, \TOOS)
                            }
                        }
                    }
                }

                \_SB.PCI0.IODT ()
                If (LEqual (TOOS, 0x01))
                {
                    Store (0x01, OSFL)
                    Store (0x01, OSEC)
                }
                Else
                {
                    If (LEqual (TOOS, 0x02))
                    {
                        Store (0x02, OSFL)
                        Store (0x02, OSEC)
                    }
                    Else
                    {
                        If (LEqual (TOOS, 0x03))
                        {
                            Store (0x03, OSFL)
                            Store (0x03, OSEC)
                        }
                        Else
                        {
                            If (LEqual (TOOS, 0x04))
                            {
                                Store (0x04, OSFL)
                                Store (0x04, OSEC)
                            }
                            Else
                            {
                                Store (0x00, OSFL)
                                Store (0x00, OSEC)
                            }
                        }
                    }
                }

                Store (0x30, SSMI)
            }

            Method (_REG, 2, NotSerialized)
            {
                If (LEqual (Arg0, 0x02))
                {
                    Store (Arg1, FLAG)
                }
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (CRS, 0x76, TMEM)
                CreateDWordField (CRS, 0x82, TLEN)
                Store (MDET (), TMEM)
                Subtract (0xFEC00000, TMEM, TLEN)
                Return (CRS)
            }

            Method (_PRT, 0, NotSerialized)
            {
                If (APIC)
                {
                    Return (PIC0)
                }
                Else
                {
                    Return (PIC1)
                }
            }

            Name (PIC0, Package (0x0C)
            {
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
                    0x0011FFFF, 
                    0x02, 
                    0x00, 
                    0x16
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x00, 
                    0x00, 
                    0x13
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
                    0x000AFFFF, 
                    0x01, 
                    0x00, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    0x00, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x00, 
                    0x00, 
                    0x15
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x01, 
                    0x00, 
                    0x15
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x02, 
                    0x00, 
                    0x15
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x03, 
                    0x00, 
                    0x15
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x00, 
                    0x00, 
                    0x17
                }
            })
            Name (PIC1, Package (0x0C)
            {
                Package (0x04)
                {
                    0x0001FFFF, 
                    0x00, 
                    \_SB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x01, 
                    \_SB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    0x02, 
                    \_SB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x00, 
                    \_SB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x00, 
                    \_SB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000AFFFF, 
                    0x01, 
                    \_SB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x00, 
                    \_SB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x00, 
                    \_SB.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x01, 
                    \_SB.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x02, 
                    \_SB.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    0x03, 
                    \_SB.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x00, 
                    \_SB.LNKA, 
                    0x00
                }
            })
            Name (SPIO, 0x2E)
            Mutex (SIOF, 0x00)
            OperationRegion (WIN1, SystemIO, SPIO, 0x02)
            Field (WIN1, ByteAcc, NoLock, Preserve)
            {
                INDX,   8, 
                DATA,   8
            }

            IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
            {
                Offset (0x07), 
                LDN,    8, 
                Offset (0x20), 
                CFG0,   8, 
                CFG1,   8, 
                CFG2,   8, 
                CFG3,   8, 
                CFG4,   8, 
                CFG5,   8, 
                CFG6,   8, 
                CFG7,   8, 
                CFG8,   8, 
                CFG9,   8, 
                CFGA,   8, 
                Offset (0x30), 
                ACTR,   8, 
                Offset (0x60), 
                IOAH,   8, 
                IOAL,   8, 
                Offset (0x70), 
                INTR,   8, 
                Offset (0x72), 
                INT1,   8, 
                Offset (0x74), 
                DMCH,   8, 
                Offset (0xF0), 
                OPT0,   8, 
                OPT1,   8, 
                OPT2,   8
            }

            Name (LDFD, 0x00)
            Name (LDLP, 0x01)
            Name (LDU2, 0x02)
            Name (LDIR, 0x02)
            Name (LDU1, 0x03)
            Name (LDXB, 0x0F)
            Name (FDST, 0x00)
            Name (U1ST, 0x00)
            Name (U2ST, 0x00)
            Name (IRST, 0x00)
            Name (LPST, 0x00)
            Method (IODT, 0, NotSerialized)
            {
                If (LEqual (GSTA (LDFD), 0x0F))
                {
                    Store (0x01, FDST)
                }

                If (LEqual (GSTA (LDU1), 0x0F))
                {
                    Store (0x01, U1ST)
                }

                If (LEqual (GSTA (LDU2), 0x0F))
                {
                    If (ISIR (LDU2))
                    {
                        Store (0x01, IRST)
                    }
                    Else
                    {
                        Store (0x01, U2ST)
                    }
                }

                If (LEqual (GSTA (LDLP), 0x0F))
                {
                    Store (0x01, LPST)
                }
            }

            Method (ISIR, 1, NotSerialized)
            {
                Store (Arg0, LDN)
                If (LEqual (DMCH, 0x04))
                {
                    Store (Zero, Local0)
                }
                Else
                {
                    Store (One, Local0)
                }

                Return (Local0)
            }

            Method (GSTA, 1, NotSerialized)
            {
                Store (Arg0, LDN)
                If (ACTR)
                {
                    Store (0x0F, Local0)
                }
                Else
                {
                    If (Or (IOAH, IOAL))
                    {
                        Store (0x0D, Local0)
                    }
                    Else
                    {
                        Store (0x00, Local0)
                    }
                }

                Return (Local0)
            }

            Method (DDIS, 1, NotSerialized)
            {
                Store (Arg0, LDN)
                Store (Zero, ACTR)
            }

            Method (DENB, 1, NotSerialized)
            {
                Store (Arg0, LDN)
                Store (One, ACTR)
            }

            Method (PCRS, 3, NotSerialized)
            {
                CreateByteField (PBUF, 0x02, IOLO)
                CreateByteField (PBUF, 0x03, IOHI)
                CreateWordField (PBUF, 0x02, IOHL)
                CreateWordField (PBUF, 0x04, IORL)
                CreateByteField (PBUF, 0x06, ALMN)
                CreateByteField (PBUF, 0x07, LENG)
                CreateByteField (PBUF, 0x09, IRQL)
                Store (Arg0, LDN)
                Store (IOAH, IOHI)
                Store (IOAL, IOLO)
                Store (IOHL, IORL)
                Store (Arg1, ALMN)
                If (LEqual (IOLO, 0xBC))
                {
                    Store (0x04, LENG)
                }
                Else
                {
                    Store (Arg2, LENG)
                }

                Store (One, Local0)
                ShiftLeft (Local0, INTR, IRQL)
                If (LEqual (INTR, Zero))
                {
                    Store (Zero, IRQL)
                }

                Return (PBUF)
            }

            Method (GSRS, 2, NotSerialized)
            {
                CreateByteField (Arg0, 0x02, GMLB)
                CreateByteField (Arg0, 0x03, GMHB)
                Store (Arg1, LDN)
                Subtract (GMLB, 0x01, GMLB)
                Store (GMLB, IOAL)
                Store (GMHB, IOAH)
                Store (One, ACTR)
            }

            Method (PSRS, 2, NotSerialized)
            {
                CreateByteField (Arg0, 0x02, POLB)
                CreateByteField (Arg0, 0x03, POHB)
                CreateByteField (Arg0, 0x09, PIRQ)
                Store (Arg1, LDN)
                Store (POLB, IOAL)
                Store (POHB, IOAH)
                If (LEqual (PIRQ, Zero))
                {
                    Store (Zero, INTR)
                }
                Else
                {
                    FindSetRightBit (PIRQ, Local0)
                    Subtract (Local0, 0x01, INTR)
                }

                Store (One, ACTR)
            }

            Method (ECRS, 1, NotSerialized)
            {
                CreateByteField (EBUF, 0x02, EPLO)
                CreateByteField (EBUF, 0x03, EPHI)
                CreateWordField (EBUF, 0x02, EPHL)
                CreateWordField (EBUF, 0x04, EPRL)
                CreateWordField (EBUF, 0x06, ALM1)
                CreateWordField (EBUF, 0x0A, E4LO)
                CreateWordField (EBUF, 0x0C, E4RL)
                CreateWordField (EBUF, 0x0E, E4AL)
                CreateWordField (EBUF, 0x11, EIRQ)
                CreateWordField (EBUF, 0x14, EDMA)
                Store (Arg0, LDN)
                Store (IOAH, EPHI)
                Store (IOAL, EPLO)
                Store (EPHL, EPRL)
                Add (EPHL, 0x0400, E4LO)
                Store (E4LO, E4RL)
                If (LEqual (EPHL, 0x03BC))
                {
                    Store (0x0401, ALM1)
                    Store (0x0401, E4AL)
                }
                Else
                {
                    Store (0x0801, ALM1)
                    Store (0x0801, E4AL)
                }

                Store (One, Local0)
                Store (INTR, Local1)
                ShiftLeft (Local0, Local1, EIRQ)
                Store (DMCH, Local1)
                If (LGreater (Local1, 0x03))
                {
                    Store (0x00, EDMA)
                }
                Else
                {
                    Store (One, Local0)
                    ShiftLeft (Local0, Local1, EDMA)
                }

                Return (EBUF)
            }

            Method (ESRS, 2, NotSerialized)
            {
                CreateByteField (Arg0, 0x02, LOEP)
                CreateByteField (Arg0, 0x03, HIEP)
                CreateWordField (Arg0, 0x11, IRQE)
                CreateWordField (Arg0, 0x14, DMAE)
                Store (Arg1, LDN)
                Store (LOEP, IOAL)
                Store (HIEP, IOAH)
                FindSetRightBit (IRQE, Local0)
                Subtract (Local0, 0x01, INTR)
                If (DMAE)
                {
                    FindSetRightBit (DMAE, Local0)
                    Subtract (Local0, 0x01, DMCH)
                }
                Else
                {
                    Store (0x04, DMCH)
                }

                Store (One, ACTR)
            }

            Method (RCRS, 3, NotSerialized)
            {
                CreateByteField (FBUF, 0x02, FRLO)
                CreateByteField (FBUF, 0x03, FRHI)
                CreateWordField (FBUF, 0x02, FRHL)
                CreateWordField (FBUF, 0x04, FRRL)
                CreateByteField (FBUF, 0x06, FALN)
                CreateByteField (FBUF, 0x07, FLEN)
                CreateByteField (FBUF, 0x09, RIRQ)
                CreateWordField (FBUF, 0x0C, RDMA)
                Store (Arg0, LDN)
                Store (IOAH, FRHI)
                Store (IOAL, FRLO)
                Store (FRHL, FRRL)
                Store (Arg1, FALN)
                If (LEqual (FRLO, 0xBC))
                {
                    Store (0x04, FLEN)
                }
                Else
                {
                    Store (Arg2, FLEN)
                }

                Store (One, Local0)
                ShiftLeft (Local0, INTR, RIRQ)
                If (LEqual (INTR, Zero))
                {
                    Store (Zero, RIRQ)
                }

                Store (DMCH, Local1)
                If (LGreater (Local1, 0x03))
                {
                    Store (0x00, RDMA)
                }
                Else
                {
                    Store (One, Local0)
                    ShiftLeft (Local0, Local1, RDMA)
                }

                Return (FBUF)
            }

            Method (FSRS, 2, NotSerialized)
            {
                CreateByteField (Arg0, 0x02, LOFR)
                CreateByteField (Arg0, 0x03, HIFR)
                CreateByteField (Arg0, 0x09, FIRQ)
                CreateByteField (Arg0, 0x0C, FDMA)
                Store (Arg1, LDN)
                Store (LOFR, IOAL)
                Store (HIFR, IOAH)
                If (LEqual (FIRQ, Zero))
                {
                    Store (Zero, INTR)
                }
                Else
                {
                    FindSetRightBit (FIRQ, Local0)
                    Subtract (Local0, 0x01, INTR)
                }

                If (FDMA)
                {
                    FindSetRightBit (FDMA, Local0)
                    Subtract (Local0, 0x01, DMCH)
                }
                Else
                {
                    Store (0x04, DMCH)
                }

                Store (One, ACTR)
            }

            Name (FCRS, ResourceTemplate ()
            {
                IO (Decode16, 0x03F2, 0x03F2, 0x01, 0x02)
                IO (Decode16, 0x03F4, 0x03F4, 0x01, 0x02)
                IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                IRQNoFlags () {6}
                DMA (Compatibility, NotBusMaster, Transfer8) {2}
            })
            Name (PBUF, ResourceTemplate ()
            {
                IO (Decode16, 0x0000, 0x0000, 0x01, 0x08)
                IRQNoFlags () {0}
            })
            Name (FBUF, ResourceTemplate ()
            {
                IO (Decode16, 0x0000, 0x0000, 0x01, 0x08)
                IRQNoFlags () {0}
                DMA (Compatibility, NotBusMaster, Transfer8) {}
            })
            Name (EBUF, ResourceTemplate ()
            {
                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                IRQNoFlags () {7}
                DMA (Compatibility, NotBusMaster, Transfer8) {}
            })
            OperationRegion (\FDCC, SystemIO, 0x03F0, 0x08)
            Field (\FDCC, ByteAcc, NoLock, Preserve)
            {
                Offset (0x04), 
                FDC4,   8
            }

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
            Device (FDC0)
            {
                Name (_HID, EisaId ("PNP0700"))
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x00)
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Acquire (SIOF, 0xFFFF)
                    DDIS (LDFD)
                    Release (SIOF)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (FCRS)
                }

                Method (_PRS, 0, NotSerialized)
                {
                    Return (FPRS)
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Acquire (SIOF, 0xFFFF)
                    DENB (LDFD)
                    Release (SIOF)
                }
            }

            Name (FDPS, 0x00)
            PowerResource (FDDP, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x00)
                }

                Method (_ON, 0, NotSerialized)
                {
                    Store (0x01, FDPS)
                }

                Method (_OFF, 0, NotSerialized)
                {
                    Store (0x00, FDPS)
                }
            }

            Name (LPPR, ResourceTemplate ()
            {
                StartDependentFn (0x00, 0x00)
                {
                    IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                    IRQNoFlags () {7}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                    IRQNoFlags () {5,7}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                    IRQNoFlags () {5,7}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                    IRQNoFlags () {5,7}
                }
                EndDependentFn ()
            })
            Name (EPRS, ResourceTemplate ()
            {
                StartDependentFn (0x00, 0x00)
                {
                    IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                    IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                    IRQNoFlags () {7}
                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                    IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                    IRQNoFlags () {5,7}
                    DMA (Compatibility, NotBusMaster, Transfer8) {0,1,3}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                    IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                    IRQNoFlags () {5,7}
                    DMA (Compatibility, NotBusMaster, Transfer8) {0,1,3}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                    IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                    IRQNoFlags () {5,7}
                    DMA (Compatibility, NotBusMaster, Transfer8) {0,1,3}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                    IO (Decode16, 0x0778, 0x0778, 0x01, 0x04)
                    IRQNoFlags () {5,7}
                    DMA (Compatibility, NotBusMaster, Transfer8) {}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                    IO (Decode16, 0x0678, 0x0678, 0x01, 0x04)
                    IRQNoFlags () {5,7}
                    DMA (Compatibility, NotBusMaster, Transfer8) {}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                    IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                    IRQNoFlags () {5,7}
                    DMA (Compatibility, NotBusMaster, Transfer8) {}
                }
                EndDependentFn ()
            })
            Device (LPT)
            {
                Name (_HID, EisaId ("PNP0400"))
                Method (_STA, 0, NotSerialized)
                {
                    Acquire (SIOF, 0xFFFF)
                    Store (LDLP, LDN)
                    Store (DMCH, Local1)
                    Release (SIOF)
                    If (LEqual (Local1, 0x04))
                    {
                        Acquire (SIOF, 0xFFFF)
                        Store (LDLP, LDN)
                        If (ACTR)
                        {
                            Store (0x0F, Local0)
                        }
                        Else
                        {
                            If (Or (IOAH, IOAL))
                            {
                                Store (0x0D, Local0)
                            }
                            Else
                            {
                                Store (0x00, Local0)
                            }
                        }

                        Release (SIOF)
                        Return (Local0)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_DIS, 0, NotSerialized)
                {
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (PCRS (LDLP, 0x01, 0x08))
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Acquire (SIOF, 0xFFFF)
                    PSRS (Arg0, LDLP)
                    Release (SIOF)
                }

                Method (_PRS, 0, NotSerialized)
                {
                    Return (LPPR)
                }
            }

            Device (ECP)
            {
                Name (_HID, EisaId ("PNP0401"))
                Method (_STA, 0, NotSerialized)
                {
                    Acquire (SIOF, 0xFFFF)
                    Store (LDLP, LDN)
                    Store (DMCH, Local1)
                    Release (SIOF)
                    If (LEqual (Local1, 0x04))
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Acquire (SIOF, 0xFFFF)
                        Store (LDLP, LDN)
                        If (ACTR)
                        {
                            Store (0x0F, Local0)
                        }
                        Else
                        {
                            Store (0x00, Local0)
                        }

                        Release (SIOF)
                        Return (Local0)
                    }
                }

                Method (_DIS, 0, NotSerialized)
                {
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (ECRS (0x01))
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Acquire (SIOF, 0xFFFF)
                    ESRS (Arg0, 0x01)
                    Release (SIOF)
                }

                Method (_PRS, 0, NotSerialized)
                {
                    Return (EPRS)
                }
            }

            Name (LPPS, 0x00)
            PowerResource (LPTP, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)
                {
                    Return (LPPS)
                }

                Method (_ON, 0, NotSerialized)
                {
                    Store (0x01, LPPS)
                }

                Method (_OFF, 0, NotSerialized)
                {
                    Store (0x00, LPPS)
                }
            }

            Name (U2PR, ResourceTemplate ()
            {
                StartDependentFn (0x00, 0x00)
                {
                    IO (Decode16, 0x02F8, 0x02F8, 0x04, 0x08)
                    IRQNoFlags () {3}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x02F8, 0x02F8, 0x04, 0x08)
                    IRQNoFlags () {3,4,10,11}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x03F8, 0x03F8, 0x04, 0x08)
                    IRQNoFlags () {3,4,10,11}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x03E8, 0x03E8, 0x04, 0x08)
                    IRQNoFlags () {3,4,10,11}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x02E8, 0x02E8, 0x04, 0x08)
                    IRQNoFlags () {3,4,10,11}
                }
                EndDependentFn ()
            })
            Name (IRPR, ResourceTemplate ()
            {
                StartDependentFn (0x00, 0x00)
                {
                    IO (Decode16, 0x02F8, 0x02F8, 0x04, 0x08)
                    IRQNoFlags () {3}
                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x02F8, 0x02F8, 0x04, 0x08)
                    IRQNoFlags () {3,4,10,11}
                    DMA (Compatibility, NotBusMaster, Transfer8) {0,1,3}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x03F8, 0x03F8, 0x04, 0x08)
                    IRQNoFlags () {3,4,10,11}
                    DMA (Compatibility, NotBusMaster, Transfer8) {0,1,3}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x03E8, 0x03E8, 0x04, 0x08)
                    IRQNoFlags () {3,4,10,11}
                    DMA (Compatibility, NotBusMaster, Transfer8) {0,1,3}
                }
                StartDependentFnNoPri ()
                {
                    IO (Decode16, 0x02E8, 0x02E8, 0x04, 0x08)
                    IRQNoFlags () {3,4,10,11}
                    DMA (Compatibility, NotBusMaster, Transfer8) {0,1,3}
                }
                EndDependentFn ()
            })
            Device (IRDA)
            {
                Method (_HID, 0, NotSerialized)
                {
                    If (IRST)
                    {
                        Return (0x0160633A)
                    }
                    Else
                    {
                        Return (0x1005D041)
                    }
                }

                Name (_UID, 0x02)
                Method (_STA, 0, NotSerialized)
                {
                    Acquire (SIOF, 0xFFFF)
                    Store (LDU2, LDN)
                    If (ACTR)
                    {
                        Store (0x0F, Local0)
                    }
                    Else
                    {
                        Store (0x00, Local0)
                    }

                    Release (SIOF)
                    Return (Local0)
                }

                Method (_DIS, 0, NotSerialized)
                {
                }

                Method (_CRS, 0, NotSerialized)
                {
                    If (IRST)
                    {
                        Return (RCRS (LDIR, 0x01, 0x08))
                    }
                    Else
                    {
                        Return (PCRS (LDU2, 0x01, 0x08))
                    }
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Acquire (SIOF, 0xFFFF)
                    If (IRST)
                    {
                        FSRS (Arg0, LDIR)
                    }
                    Else
                    {
                        PSRS (Arg0, LDU2)
                    }

                    Release (SIOF)
                }

                Method (_PRS, 0, NotSerialized)
                {
                    If (IRST)
                    {
                        Return (IRPR)
                    }
                    Else
                    {
                        Return (U2PR)
                    }
                }
            }

            Name (IRPS, 0x00)
            PowerResource (URP2, 0x01, 0x0000)
            {
                Method (_STA, 0, NotSerialized)
                {
                    Return (IRPS)
                }

                Method (_ON, 0, NotSerialized)
                {
                    Store (0x01, IRPS)
                }

                Method (_OFF, 0, NotSerialized)
                {
                    Store (0x00, IRPS)
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x00100000)
                Method (_S3D, 0, NotSerialized)
                {
                    If (OSFL)
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x0E, 
                    0x03
                })
                Scope (\_GPE)
                {
                    Method (_L0E, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.USB1, 0x02)
                    }
                }
            }

            Device (EHCI)
            {
                Name (_ADR, 0x00100003)
                Name (_PRW, Package (0x02)
                {
                    0x0E, 
                    0x03
                })
            }

            Device (EC0)
            {
                Name (_HID, EisaId ("PNP0C09"))
                Name (_CRS, ResourceTemplate ()
                {
                    IO (Decode16, 0x0062, 0x0062, 0x00, 0x01)
                    IO (Decode16, 0x0066, 0x0066, 0x00, 0x01)
                })
                Method (_REG, 2, NotSerialized)
                {
                    If (LEqual (Arg0, 0x03))
                    {
                        Store (Arg1, FGEC)
                    }
                }

                Name (_GPE, 0x05)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x04
                })
                Method (_Q00, 0, NotSerialized)
                {
                }

                Method (_Q18, 0, NotSerialized)
                {
                    Store ("Trip Point Event", Debug)
                    Notify (\_SB.PCI0.BAT0, 0x80)
                }

                Method (_Q06, 0, NotSerialized)
                {
                    Store ("Battery Change Event", Debug)
                    Store (0x07, DBG8)
                    If (LEqual (TOOS, 0x00))
                    {
                        Sleep (0x64)
                        Store (0x30, SSMI)
                        If (BTIN)
                        {
                            Notify (\_SB.PCI0.BAT0, 0x00)
                        }
                        Else
                        {
                            Notify (\_SB.PCI0.BAT0, 0x01)
                        }

                        Notify (\_SB.PCI0.BAT0, 0x80)
                    }

                    If (LEqual (TOOS, 0x01))
                    {
                        Sleep (0x64)
                        Store (0x30, SSMI)
                        If (BTIN)
                        {
                            Notify (\_SB.PCI0.BAT0, 0x00)
                        }
                        Else
                        {
                            Notify (\_SB.PCI0.BAT0, 0x01)
                        }

                        Notify (\_SB.PCI0.BAT0, 0x80)
                        Notify (\_SB.PCI0, 0x00)
                    }

                    If (LEqual (TOOS, 0x02))
                    {
                        Store (0x01, FAKE)
                        Notify (\_SB.PCI0.AC0, 0x00)
                        Store (0x00, FAKE)
                        Notify (\_SB.PCI0.AC0, 0x00)
                        Sleep (0x64)
                        Store (0x30, SSMI)
                        If (BTIN)
                        {
                            Notify (\_SB.PCI0.BAT0, 0x00)
                        }
                        Else
                        {
                            Notify (\_SB.PCI0.BAT0, 0x01)
                        }

                        Notify (\_SB.PCI0.BAT0, 0x80)
                        Notify (\_SB.PCI0.BAT0, 0x81)
                    }

                    If (LEqual (TOOS, 0x03))
                    {
                        Sleep (0x64)
                        Store (0x30, SSMI)
                        If (BTIN)
                        {
                            Notify (\_SB.PCI0.BAT0, 0x00)
                        }
                        Else
                        {
                            Notify (\_SB.PCI0.BAT0, 0x01)
                        }

                        Notify (\_SB.PCI0.BAT0, 0x80)
                    }

                    If (LEqual (TOOS, 0x04))
                    {
                        Store (0x17, DBG8)
                        Sleep (0x64)
                        Store (0x30, SSMI)
                        If (BTIN)
                        {
                            Notify (\_SB.PCI0.BAT0, 0x00)
                        }
                        Else
                        {
                            Notify (\_SB.PCI0.BAT0, 0x01)
                        }

                        Notify (\_SB.PCI0.BAT0, 0x80)
                    }
                }

                Method (_Q07, 0, NotSerialized)
                {
                    Store ("AC Change", Debug)
                    Store (0x30, SSMI)
                    Store (0x09, DBG8)
                    Acquire (ECKP, 0xFFFF)
                    If (LEqual (TOOS, 0x01))
                    {
                        Store (0x00, FAKE)
                        Notify (\_SB.PCI0.AC0, 0x00)
                    }

                    If (LEqual (TOOS, 0x02))
                    {
                        Store (0x00, FAKE)
                        Notify (\_SB.PCI0.AC0, 0x00)
                    }

                    If (LEqual (TOOS, 0x03))
                    {
                        Notify (\_SB.PCI0.AC0, 0x80)
                        Notify (\_SB.PCI0.BAT0, 0x80)
                    }

                    If (LEqual (TOOS, 0x04))
                    {
                        Store (0x19, DBG8)
                        Notify (\_SB.PCI0.AC0, 0x80)
                        Notify (\_SB.PCI0.BAT0, 0x80)
                    }

                    Release (ECKP)
                }

                Method (_Q0A, 0, NotSerialized)
                {
                    Store ("FN+F1 Event", Debug)
                    Notify (\_SB.SLPB, 0x80)
                    Store (0xF1, DBG8)
                }

                Method (_Q0C, 0, NotSerialized)
                {
                    Store ("FN+F3 Event", Debug)
                    Store (0xF3, DBG8)
                    Store (0x22, SSMI)
                }

                Method (_Q0D, 0, NotSerialized)
                {
                    Store ("FN+F4 Event", Debug)
                    Store (0xF4, DBG8)
                    Store (0x23, SSMI)
                }

                Method (_Q10, 0, NotSerialized)
                {
                    Store ("FN+F7 Event", Debug)
                    Store (0xF7, DBG8)
                    Store (0x26, SSMI)
                }

                Method (_Q11, 0, NotSerialized)
                {
                    Store ("FN+F8 Event", Debug)
                    Store (0xF8, DBG8)
                    Store (0x27, SSMI)
                }

                Method (_Q16, 0, NotSerialized)
                {
                    Store (0x16, DBG8)
                    Store (0x01, \_SB.PCI0.SBRG.LIDS)
                    Notify (\_SB.PCI0.SBRG.LID, 0x80)
                }

                Method (_Q19, 0, NotSerialized)
                {
                    Store (0x19, DBG8)
                    Store (0x00, \_SB.PCI0.SBRG.LIDS)
                    Notify (\_SB.PCI0.SBRG.LID, 0x80)
                }

                Method (_Q1A, 0, NotSerialized)
                {
                    Store (0x01, QSMB)
                    Store (0x11, DBG8)
                }

                Method (_Q1B, 0, NotSerialized)
                {
                    Store (0x02, QSMB)
                    Store (0x22, DBG8)
                }

                Method (_Q1E, 0, NotSerialized)
                {
                    Store (0x00, THRT)
                    Store (0x00, DBG8)
                }

                Method (_Q1F, 0, NotSerialized)
                {
                    Store (0x1D, THRT)
                    Store (0x1D, DBG8)
                }

                Method (_Q20, 0, NotSerialized)
                {
                    Store (0x1A, THRT)
                    Store (0x1A, DBG8)
                }

                Method (_Q21, 0, NotSerialized)
                {
                    Store (0x18, THRT)
                    Store (0x18, DBG8)
                }

                Method (_Q22, 0, NotSerialized)
                {
                    Store (0x16, THRT)
                    Store (0x18, DBG8)
                }

                Method (_Q23, 0, NotSerialized)
                {
                    Store (0x14, THRT)
                    Store (0x14, DBG8)
                }

                Method (_Q24, 0, NotSerialized)
                {
                    Store (0x13, THRT)
                    Store (0x13, DBG8)
                }

                Method (_Q25, 0, NotSerialized)
                {
                    Store (0x12, THRT)
                    Store (0x12, DBG8)
                }

                Method (_Q26, 0, NotSerialized)
                {
                    Store (0x34, SSMI)
                    Store (0x34, DBG8)
                }

                Method (_Q27, 0, NotSerialized)
                {
                    Store (0x69, THPP)
                    Notify (\_TZ.THRM, 0x80)
                }

                Method (_Q30, 0, NotSerialized)
                {
                    Store (0x30, DBG8)
                    Notify (\_SB.PCI0.CBC0, 0x02)
                    Store (0x01, Local0)
                    While (Local0)
                    {
                        Or (\_SB.PCI0.CBC0.C0A5, 0x80, \_SB.PCI0.CBC0.C0A5)
                        Store (\_SB.PCI0.CBC0.C0A5, Local0)
                        And (Local0, 0x80, Local0)
                    }
                }

                Method (_Q31, 0, NotSerialized)
                {
                    Store (0x01, QTMF)
                    Store (0x01, DBG8)
                }

                Method (_Q32, 0, NotSerialized)
                {
                    Store (0x02, QTMF)
                    Store (0x02, DBG8)
                }

                Method (_Q33, 0, NotSerialized)
                {
                    Store (0x04, QTMF)
                    Store (0x04, DBG8)
                }

                Method (_Q34, 0, NotSerialized)
                {
                    Store (0x08, QTMF)
                    Store (0x08, DBG8)
                }

                Method (_Q35, 0, NotSerialized)
                {
                    Store (0x10, QTMF)
                    Store (0x10, DBG8)
                }

                Method (_Q36, 0, NotSerialized)
                {
                    Store (0x10, QSMB)
                    Store (0x10, DBG8)
                }

                Method (_Q37, 0, NotSerialized)
                {
                    Store (0x20, QSMB)
                    Store (0x20, DBG8)
                }

                Method (_Q38, 0, NotSerialized)
                {
                    Store (0x38, SSMI)
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
                        0x00, 
                        0x0C56, 
                        0x0C56, 
                        0x00, 
                        0x2A30, 
                        0x013B, 
                        0x9D, 
                        0x10, 
                        0x08, 
                        "251C1", 
                        "00002", 
                        "LiIon", 
                        "OEM"
                    })
                    Method (_BIF, 0, NotSerialized)
                    {
                        Store ("BIf", Debug)
                        Store (0x31, SSMI)
                        Store (BIF0, Index (PAK1, 0x00))
                        Store (BIF1, Index (PAK1, 0x01))
                        Store (BIF2, Local0)
                        Store (Local0, Index (PAK1, 0x02))
                        Store (BIF3, Index (PAK1, 0x03))
                        Store (BIF4, Index (PAK1, 0x04))
                        Store (Divide (Local0, 0x0A, ), Index (PAK1, 0x05))
                        Store (Divide (Local0, 0x14, ), Index (PAK1, 0x06))
                        Store (BIF7, Index (PAK1, 0x07))
                        Return (PAK1)
                    }

                    Name (BFB0, Package (0x04)
                    {
                        0x00, 
                        0xFFFFFFFF, 
                        0x1034, 
                        0x2A30
                    })
                    Method (_BST, 0, NotSerialized)
                    {
                        Store ("BST Start", Debug)
                        Store (0x32, SSMI)
                        Store (BST0, Index (BFB0, 0x00))
                        Store (BST2, Index (BFB0, 0x02))
                        Store (BST3, Index (BFB0, 0x03))
                        Store ("BST End", Debug)
                        Return (BFB0)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Store ("BAT_STA Start", Debug)
                        Store (0x30, SSMI)
                        Store (BTIN, Local0)
                        If (Local0)
                        {
                            Return (0x1F)
                        }
                        Else
                        {
                            Return (0x0F)
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
                        Store (0x30, SSMI)
                        If (LNot (LEqual (FAKE, 0x00)))
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            Store ("AC_PSR Start", Debug)
                            Acquire (ECKP, 0xFFFF)
                            Store (ACIN, Local0)
                            Release (ECKP)
                            Store ("AC_PSR END", Debug)
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

            Device (SBRG)
            {
                Name (_ADR, 0x00110000)
                OperationRegion (SBID, PCI_Config, 0x02, 0x02)
                Field (SBID, WordAcc, NoLock, Preserve)
                {
                    D147,   16
                }

                Name (\_SB.PRSA, ResourceTemplate ()
                {
                    StartDependentFnNoPri ()
                    {
                        IRQ (Level, ActiveLow, Shared) 
{3,4,5,6,7,10,11,12,14,15}
                    }
                    EndDependentFn ()
                })
                Name (\_SB.PRSB, ResourceTemplate ()
                {
                    StartDependentFnNoPri ()
                    {
                        IRQ (Level, ActiveLow, Shared) 
{3,4,5,6,7,10,11,12,14,15}
                    }
                    EndDependentFn ()
                })
                Name (\_SB.PRSC, ResourceTemplate ()
                {
                    StartDependentFnNoPri ()
                    {
                        IRQ (Level, ActiveLow, Shared) 
{3,4,5,6,7,10,11,12,14,15}
                    }
                    EndDependentFn ()
                })
                Name (\_SB.PRSD, ResourceTemplate ()
                {
                    StartDependentFnNoPri ()
                    {
                        IRQ (Level, ActiveLow, Shared) 
{3,4,5,6,7,10,11,12,14,15}
                    }
                    EndDependentFn ()
                })
                OperationRegion (PIX0, PCI_Config, 0x55, 0x04)
                OperationRegion (PIX1, PCI_Config, 0x50, 0x02)
                OperationRegion (PIX2, PCI_Config, 0x44, 0x04)
                OperationRegion (PIX3, PCI_Config, 0x67, 0x03)
                OperationRegion (PIX4, PCI_Config, 0x6C, 0x04)
                Scope (\_SB)
                {
                    Field (PCI0.SBRG.PIX0, ByteAcc, NoLock, Preserve)
                    {
                            ,   4, 
                        PIRA,   4, 
                        PIRB,   4, 
                        PIRC,   4, 
                            ,   4, 
                        PIRD,   4, 
                            ,   4
                    }

                    Field (PCI0.SBRG.PIX1, ByteAcc, NoLock, Preserve)
                    {
                            ,   1, 
                        EP3C,   1, 
                        EN3C,   1, 
                            ,   6, 
                        KBFG,   1
                    }

                    Field (PCI0.SBRG.PIX2, ByteAcc, NoLock, Preserve)
                    {
                        FLDA,   2, 
                        LPDA,   2, 
                        IRD1,   2, 
                        IRD2,   2, 
                        FLIR,   4, 
                        LPIR,   4, 
                        U1IR,   4, 
                        Offset (0x03), 
                        IRIR,   4, 
                        Offset (0x04)
                    }

                    Field (PCI0.SBRG.PIX3, ByteAcc, NoLock, Preserve)
                    {
                        ENIR,   1, 
                        IRSD,   1, 
                        Offset (0x02), 
                        IRBA,   8
                    }

                    Field (PCI0.SBRG.PIX4, ByteAcc, NoLock, Preserve)
                    {
                        PS0E,   1, 
                        PS1E,   1, 
                        ROME,   1, 
                        APCE,   1, 
                        LPMS,   2, 
                        MSEN,   1, 
                        IXEN,   1, 
                        LPMD,   2, 
                        MDEN,   1, 
                        GMEN,   1, 
                        LPLP,   2, 
                        LPEN,   1, 
                        FDEN,   1, 
                        LPCA,   3, 
                        CAEN,   1, 
                        LPCB,   3, 
                        CBEN,   1, 
                        LPSB,   2, 
                        SBEN,   1, 
                        FDSE,   1, 
                        Offset (0x04)
                    }

                    Name (IRQA, 0x00)
                    Name (IRQB, 0x00)
                    Name (IRQC, 0x00)
                    Name (IRQD, 0x00)
                    Name (ICRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {15}
                    })
                    Device (LNKA)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (PIRA, IRQA)
                            If (PIRA)
                            {
                                Return (0x0B)
                            }
                            Else
                            {
                                Return (0x09)
                            }
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (PRSA)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            Store (0x00, PIRA)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            CreateWordField (ICRS, 0x01, IRA0)
                            Store (One, Local1)
                            ShiftLeft (Local1, IRQA, IRA0)
                            Return (ICRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x01, IRA)
                            FindSetRightBit (IRA, Local0)
                            Decrement (Local0)
                            Store (Local0, PIRA)
                            Store (PIRA, IRQA)
                        }
                    }

                    Device (LNKB)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))
                        Name (_UID, 0x02)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (PIRB, IRQB)
                            If (PIRB)
                            {
                                Return (0x0B)
                            }
                            Else
                            {
                                Return (0x09)
                            }
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (PRSB)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            Store (0x00, PIRB)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            CreateWordField (ICRS, 0x01, IRA0)
                            Store (One, Local1)
                            ShiftLeft (Local1, IRQB, IRA0)
                            Return (ICRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x01, IRA)
                            FindSetRightBit (IRA, Local0)
                            Decrement (Local0)
                            Store (Local0, PIRB)
                            Store (PIRB, IRQB)
                        }
                    }

                    Device (LNKC)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))
                        Name (_UID, 0x03)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (PIRC, IRQC)
                            If (PIRC)
                            {
                                Return (0x0B)
                            }
                            Else
                            {
                                Return (0x09)
                            }
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (PRSC)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            Store (0x00, PIRC)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            CreateWordField (ICRS, 0x01, IRA0)
                            Store (One, Local1)
                            ShiftLeft (Local1, IRQC, IRA0)
                            Return (ICRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x01, IRA)
                            FindSetRightBit (IRA, Local0)
                            Decrement (Local0)
                            Store (Local0, PIRC)
                            Store (PIRC, IRQC)
                        }
                    }

                    Device (LNKD)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))
                        Name (_UID, 0x04)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (PIRD, IRQD)
                            If (PIRD)
                            {
                                Return (0x0B)
                            }
                            Else
                            {
                                Return (0x09)
                            }
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (PRSD)
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            Store (0x00, PIRD)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            CreateWordField (ICRS, 0x01, IRA0)
                            Store (One, Local1)
                            ShiftLeft (Local1, IRQD, IRA0)
                            Return (ICRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateWordField (Arg0, 0x01, IRA)
                            FindSetRightBit (IRA, Local0)
                            Decrement (Local0)
                            Store (Local0, PIRD)
                            Store (PIRD, IRQD)
                        }
                    }
                }

                Name (LIDS, 0x01)
                Device (\_SB.PCI0.SBRG.LID)
                {
                    Name (_HID, EisaId ("PNP0C0D"))
                    Name (_PRW, Package (0x02)
                    {
                        0x05, 
                        0x04
                    })
                    Method (_LID, 0, NotSerialized)
                    {
                        Return (LIDS)
                    }
                }

                Device (\_SB.PCI0.CBC0)
                {
                    Name (_ADR, 0x000B0000)
                    OperationRegion (CBR0, PCI_Config, 0x00, 0xFF)
                    Field (CBR0, DWordAcc, NoLock, Preserve)
                    {
                        Offset (0x44), 
                        C044,   32, 
                        Offset (0xA4), 
                        C0A4,   8, 
                        C0A5,   8
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Store (0x00, \_SB.PCI0.CBC0.C044)
                        Store (0x00, \_SB.PCI0.CBC0.C0A4)
                    }
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LNot (LLess (\_SB.PCI0.OSFL, 0x02)))
                        {
                            Return (0x00)
                        }

                        Return (0x0F)
                    }

                    Name (IORG, ResourceTemplate ()
                    {
                        FixedIO (0x0010, 0x10)
                        FixedIO (0x0022, 0x1E)
                        FixedIO (0x0044, 0x1C)
                        FixedIO (0x0063, 0x01)
                        FixedIO (0x0065, 0x01)
                        FixedIO (0x0067, 0x09)
                        FixedIO (0x0072, 0x0E)
                        FixedIO (0x0080, 0x01)
                        FixedIO (0x0084, 0x03)
                        FixedIO (0x0088, 0x01)
                        FixedIO (0x008C, 0x03)
                        FixedIO (0x0090, 0x10)
                        FixedIO (0x00A2, 0x1E)
                        FixedIO (0x00E0, 0x10)
                        IO (Decode16, 0x03F0, 0x03F0, 0x00, 0x02)
                        IO (Decode16, 0x04D0, 0x04D0, 0x00, 0x02)
                        IO (Decode16, 0x0400, 0x0400, 0x00, 0x10)
                        IO (Decode16, 0x0800, 0x0800, 0x00, 0x80)
                        IO (Decode16, 0x0C00, 0x0C00, 0x00, 0x80)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (IORG)
                    }
                }

                Device (\_SB.MEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LNot (LLess (\_SB.PCI0.OSFL, 0x02)))
                        {
                            Return (0x00)
                        }

                        Return (0x0F)
                    }

                    Name (MEM1, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite, 0x00000000, 0x000A0000)
                        Memory32Fixed (ReadWrite, 0x000D2000, 0x00006000)
                        Memory32Fixed (ReadOnly, 0x000F0000, 0x00010000)
                        Memory32Fixed (ReadWrite, 0x00100000, 0x1FF00000)
                        Memory32Fixed (ReadOnly, 0xFEC00000, 0x00001000)
                        Memory32Fixed (ReadOnly, 0xFEE00000, 0x00001000)
                        Memory32Fixed (ReadOnly, 0xFFF80000, 0x00080000)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (MEM1, 0x2C, TOP1)
                        Subtract (\_SB.PCI0.MDET (), 0x00100000, TOP1)
                        Return (MEM1)
                    }
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (OSFL)
                        {
                            Return (0x0F)
                        }

                        Return (0x00)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        FixedIO (0x0020, 0x02)
                        FixedIO (0x00A0, 0x02)
                        IRQNoFlags () {2}
                    })
                }

                Device (DMAD)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        DMA (Compatibility, BusMaster, Transfer8) {4}
                        FixedIO (0x0000, 0x10)
                        FixedIO (0x0081, 0x03)
                        FixedIO (0x0087, 0x01)
                        FixedIO (0x0089, 0x03)
                        FixedIO (0x008F, 0x01)
                        FixedIO (0x00C0, 0x20)
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        FixedIO (0x0040, 0x04)
                        IRQNoFlags () {0}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        FixedIO (0x0070, 0x02)
                        IRQNoFlags () {8}
                    })
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        FixedIO (0x0061, 0x01)
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        FixedIO (0x00F0, 0x10)
                        IRQNoFlags () {13}
                    })
                }

                OperationRegion (PSRG, SystemMemory, 0x000FE2C2, 0x01)
                Field (PSRG, ByteAcc, NoLock, Preserve)
                {
                    PK2E,   1, 
                    PM2E,   1, 
                    Offset (0x01)
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PM2E)
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

                    Name (M2R0, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Name (M2R1, ResourceTemplate ()
                    {
                        FixedIO (0x0060, 0x01)
                        FixedIO (0x0064, 0x01)
                        IRQNoFlags () {12}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (PK2E)
                        {
                            Return (M2R0)
                        }
                        Else
                        {
                            Return (M2R1)
                        }
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CID, 0x0B03D041)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PK2E)
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        FixedIO (0x0060, 0x01)
                        FixedIO (0x0064, 0x01)
                        IRQNoFlags () {1}
                    })
                }

                OperationRegion (PWCR, PCI_Config, 0x94, 0x01)
                Field (PWCR, ByteAcc, NoLock, Preserve)
                {
                        ,   4, 
                    SUST,   1, 
                    Offset (0x01)
                }
            }

            Device (IDE0)
            {
                Name (_ADR, 0x00110001)
                Name (REGF, 0x01)
                Method (_REG, 2, NotSerialized)
                {
                    If (LEqual (Arg0, 0x02))
                    {
                        Store (Arg1, REGF)
                    }
                }

                Name (TIM0, Package (0x0A)
                {
                    Package (0x05)
                    {
                        0x3C, 
                        0x78, 
                        0xB4, 
                        0xF0, 
                        0x0384
                    }, 

                    Package (0x05)
                    {
                        0x11, 
                        0x20, 
                        0x31, 
                        0x65, 
                        0xA8
                    }, 

                    Package (0x08)
                    {
                        0x05, 
                        0x04, 
                        0x03, 
                        0x02, 
                        0x02, 
                        0x01, 
                        0x01, 
                        0x00
                    }, 

                    Package (0x07)
                    {
                        0x70, 
                        0x49, 
                        0x36, 
                        0x27, 
                        0x19, 
                        0x11, 
                        0x0C
                    }, 

                    Package (0x06)
                    {
                        0x07, 
                        0x06, 
                        0x04, 
                        0x02, 
                        0x01, 
                        0x00
                    }, 

                    Package (0x07)
                    {
                        0x00, 
                        0x00, 
                        0x00, 
                        0x01, 
                        0x01, 
                        0x01, 
                        0x01
                    }, 

                    Package (0x05)
                    {
                        0x05, 
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
                    }, 

                    Package (0x0F)
                    {
                        0x06, 
                        0x05, 
                        0x04, 
                        0x04, 
                        0x03, 
                        0x03, 
                        0x02, 
                        0x02, 
                        0x01, 
                        0x01, 
                        0x01, 
                        0x01, 
                        0x00, 
                        0x00, 
                        0x00
                    }, 

                    Package (0x07)
                    {
                        0x0E, 
                        0x08, 
                        0x06, 
                        0x04, 
                        0x02, 
                        0x01, 
                        0x00
                    }
                })
                Name (TMD0, Buffer (0x14) {})
                CreateDWordField (TMD0, 0x00, PIO0)
                CreateDWordField (TMD0, 0x04, DMA0)
                CreateDWordField (TMD0, 0x08, PIO1)
                CreateDWordField (TMD0, 0x0C, DMA1)
                CreateDWordField (TMD0, 0x10, CHNF)
                OperationRegion (CFG2, PCI_Config, 0x40, 0x20)
                Field (CFG2, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x08), 
                    SSPT,   8, 
                    SMPT,   8, 
                    PSPT,   8, 
                    PMPT,   8, 
                    Offset (0x10), 
                    SSUT,   3, 
                        ,   1, 
                    SSCR,   1, 
                    SSUE,   3, 
                    SMUT,   3, 
                        ,   1, 
                    SMCR,   1, 
                    SMUE,   3, 
                    PSUT,   3, 
                        ,   1, 
                    PSCR,   1, 
                    PSUE,   3, 
                    PMUT,   3, 
                        ,   1, 
                    PMCR,   1, 
                    PMUE,   3
                }

                Name (GMPT, 0x00)
                Name (GMUE, 0x00)
                Name (GMUT, 0x00)
                Name (GMCR, 0x00)
                Name (GSPT, 0x00)
                Name (GSUE, 0x00)
                Name (GSUT, 0x00)
                Name (GSCR, 0x00)
                Device (CHN0)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        ShiftLeft (PSCR, 0x01, Local1)
                        Or (PMCR, Local1, Local0)
                        Return (GTM (PMPT, PMUE, PMUT, PSPT, PSUE, PSUT, 
Local0))
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        Store (PMPT, GMPT)
                        Store (PMUE, GMUE)
                        Store (PMUT, GMUT)
                        Store (PMCR, GMCR)
                        Store (PSPT, GSPT)
                        Store (PSUE, GSUE)
                        Store (PSUT, GSUT)
                        Store (PSCR, GSCR)
                        STM ()
                        Store (GMPT, PMPT)
                        Store (GMUE, PMUE)
                        Store (GMUT, PMUT)
                        Store (GMCR, PMCR)
                        Store (GSPT, PSPT)
                        Store (GSUE, PSUE)
                        Store (GSUT, PSUT)
                        Store (GSCR, PSCR)
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
                        ShiftLeft (SSCR, 0x01, Local1)
                        Or (SMCR, Local1, Local0)
                        Return (GTM (SMPT, SMUE, SMUT, SSPT, SSUE, SSUT, 
Local0))
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        Store (SMPT, GMPT)
                        Store (SMUE, GMUE)
                        Store (SMUT, GMUT)
                        Store (SMCR, GMCR)
                        Store (SSPT, GSPT)
                        Store (SSUE, GSUE)
                        Store (SSUT, GSUT)
                        Store (SSCR, GSCR)
                        STM ()
                        Store (GMPT, SMPT)
                        Store (GMUE, SMUE)
                        Store (GMUT, SMUT)
                        Store (GMCR, SMCR)
                        Store (GSPT, SSPT)
                        Store (GSUE, SSUE)
                        Store (GSUT, SSUT)
                        Store (GSCR, SSCR)
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

                Method (GTM, 7, Serialized)
                {
                    Store (Ones, PIO0)
                    Store (Ones, PIO1)
                    Store (Ones, DMA0)
                    Store (Ones, DMA1)
                    Store (0x10, CHNF)
                    If (REGF) {}
                    Else
                    {
                        Return (TMD0)
                    }

                    Store (Match (DerefOf (Index (TIM0, 0x01)), MEQ, Arg0, 
MTR, 0x00, 0x00), Local6)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, 0x00)), 
Local6)), Local7)
                    Store (Local7, DMA0)
                    Store (Local7, PIO0)
                    Store (Match (DerefOf (Index (TIM0, 0x01)), MEQ, Arg3, 
MTR, 0x00, 0x00), Local6)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, 0x00)), 
Local6)), Local7)
                    Store (Local7, DMA1)
                    Store (Local7, PIO1)
                    If (Arg1)
                    {
                        If (LOr (LEqual (\_SB.PCI0.SBRG.D147, 0x3147), LEqual 
(\_SB.PCI0.SBRG.D147, 0x3177)))
                        {
                            Store (DerefOf (Index (DerefOf (Index (TIM0, 
0x08)), Arg2)), Local5)
                        }
                        Else
                        {
                            Store (DerefOf (Index (DerefOf (Index (TIM0, 
0x02)), Arg2)), Local5)
                        }

                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x03)), 
Local5)), DMA0)
                        Or (CHNF, 0x01, CHNF)
                    }

                    If (Arg4)
                    {
                        If (LOr (LEqual (\_SB.PCI0.SBRG.D147, 0x3147), LEqual 
(\_SB.PCI0.SBRG.D147, 0x3177)))
                        {
                            Store (DerefOf (Index (DerefOf (Index (TIM0, 
0x08)), Arg5)), Local5)
                        }
                        Else
                        {
                            Store (DerefOf (Index (DerefOf (Index (TIM0, 
0x02)), Arg5)), Local5)
                        }

                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x03)), 
Local5)), DMA1)
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
                        Return (TMD0)
                    }

                    Store (0x00, GMUE)
                    Store (0x07, GMUT)
                    Store (0x00, GSUE)
                    Store (0x07, GSUT)
                    If (And (CHNF, 0x01))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DMA0, 
MTR, 0x00, 0x00), Local0)
                        If (LGreater (Local0, 0x06))
                        {
                            Store (0x06, Local0)
                        }

                        If (LOr (LEqual (\_SB.PCI0.SBRG.D147, 0x3147), LEqual 
(\_SB.PCI0.SBRG.D147, 0x3177)))
                        {
                            Store (DerefOf (Index (DerefOf (Index (TIM0, 
0x09)), Local0)), GMUT)
                        }
                        Else
                        {
                            Store (DerefOf (Index (DerefOf (Index (TIM0, 
0x04)), Local0)), GMUT)
                        }

                        Or (GMUE, 0x07, GMUE)
                    }
                    Else
                    {
                        If (Or (LEqual (PIO0, Ones), LEqual (PIO0, 0x00)))
                        {
                            If (And (LLess (DMA0, Ones), LGreater (DMA0, 
0x00)))
                            {
                                Store (DMA0, PIO0)
                            }
                        }
                    }

                    If (And (CHNF, 0x04))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DMA1, 
MTR, 0x00, 0x00), Local0)
                        If (LGreater (Local0, 0x06))
                        {
                            Store (0x06, Local0)
                        }

                        If (LOr (LEqual (\_SB.PCI0.SBRG.D147, 0x3147), LEqual 
(\_SB.PCI0.SBRG.D147, 0x3177)))
                        {
                            Store (DerefOf (Index (DerefOf (Index (TIM0, 
0x09)), Local0)), GSUT)
                        }
                        Else
                        {
                            Store (DerefOf (Index (DerefOf (Index (TIM0, 
0x04)), Local0)), GSUT)
                        }

                        Or (GSUE, 0x07, GSUE)
                    }
                    Else
                    {
                        If (Or (LEqual (PIO1, Ones), LEqual (PIO1, 0x00)))
                        {
                            If (And (LLess (DMA1, Ones), LGreater (DMA1, 
0x00)))
                            {
                                Store (DMA1, PIO1)
                            }
                        }
                    }

                    And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIO0, MTR, 
0x00, 0x00), 0x07, Local0)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, 0x01)), 
Local0)), Local1)
                    Store (Local1, GMPT)
                    And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIO1, MTR, 
0x00, 0x00), 0x07, Local0)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, 0x01)), 
Local0)), Local1)
                    Store (Local1, GSPT)
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

                    If (LAnd (LAnd (And (ID53, 0x04), And (ID88, 0xFF00)), 
DMAT))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DMAT, 
MTR, 0x00, 0x00), Local1)
                        If (LGreater (Local1, 0x06))
                        {
                            Store (0x06, Local1)
                        }

                        GTFB (AT01, Or (0x40, Local1), Local7)
                    }
                    Else
                    {
                        If (LAnd (And (ID63, 0xFF00), PIOT))
                        {
                            And (Match (DerefOf (Index (TIM0, 0x00)), MGE, 
PIOT, MTR, 0x00, 0x00), 0x03, Local0)
                            Or (0x20, DerefOf (Index (DerefOf (Index (TIM0, 
0x07)), Local0)), Local1)
                            GTFB (AT01, Local1, Local7)
                        }
                    }

                    If (IRDY)
                    {
                        And (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIOT, 
MTR, 0x00, 0x00), 0x07, Local0)
                        Or (0x08, DerefOf (Index (DerefOf (Index (TIM0, 
0x06)), Local0)), Local1)
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

            Device (AC9)
            {
                Name (_ADR, 0x00110005)
                Name (_PRW, Package (0x02)
                {
                    0x0D, 
                    0x04
                })
                Scope (\_GPE)
                {
                    Method (_L0D, 0, NotSerialized)
                    {
                        Notify (\_SB.PWRB, 0x02)
                    }
                }
            }

            Device (MC9)
            {
                Name (_ADR, 0x00110006)
                OperationRegion (ACLK, PCI_Config, 0x41, 0x01)
                Field (ACLK, ByteAcc, NoLock, Preserve)
                {
                        ,   6, 
                    MC9P,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x0D, 
                    0x04
                })
            }

            Device (ILAN)
            {
                Name (_ADR, 0x00120000)
                Method (_STA, 0, NotSerialized)
                {
                    If (LEqual (\_SB.PCI0.SBRG.D147, 0x3147))
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x03, 
                    0x04
                })
                Scope (\_GPE)
                {
                    Method (_L03, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.ILAN, 0x02)
                    }
                }
            }

            Name (_PRW, Package (0x02)
            {
                0x05, 
                0x04
            })
            Scope (\_GPE)
            {
                Method (_L05, 0, NotSerialized)
                {
                    Notify (\_SB.PCI0, 0x02)
                }
            }
        }

        Name (SLPS, 0x00)
        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Method (SBEV, 0, NotSerialized)
            {
                If (SLPS)
                {
                    Store (0x00, SLPS)
                    Notify (SLPB, 0x02)
                }
                Else
                {
                    Store (0x01, SLPS)
                    Notify (SLPB, 0x80)
                }
            }

            Scope (\_GPE)
            {
                Method (_L04, 0, NotSerialized)
                {
                    \_SB.SLPB.SBEV ()
                }
            }

            Name (_PRW, Package (0x02)
            {
                0x04, 
                0x04
            })
        }
    }

    OperationRegion (FNOR, SystemIO, 0x084C, 0x04)
    OperationRegion (SIOR, SystemIO, 0x0370, 0x02)
    Field (SIOR, ByteAcc, NoLock, Preserve)
    {
        SIND,   8, 
        SDTA,   8
    }

    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, DBG8)
        If (LEqual (Arg0, 0x03))
        {
            Store (0xA3, SSMI)
        }

        If (LAnd (LEqual (Arg0, 0x04), LNot (LLess (\_SB.PCI0.OSFL, 0x02))))
        {
            Sleep (0x0BB8)
        }

        If (LEqual (Arg0, 0x01))
        {
            While (WAKS)
            {
                Stall (0x50)
                Store (0x01, WAKS)
            }
        }
        Else
        {
            Store (0x00, \_SB.PCI0.SBRG.SUST)
        }

        If (LNot (\_SB.PCI0.OSFL))
        {
            Store (\_SB.PCI0.TLBC, PTB1)
        }

        Store (\_SB.PCI0.MC9.MC9P, PTB0)
        Store (0x00, \_SB.PCI0.MC9.MC9P)
        Store (Arg0, \_SB.PCI0.SPLV)
        While (PS1S)
        {
            Stall (0x50)
            Store (0x01, PS1S)
        }

        Store (0x01, PS1E)
        Store (\_SB.PCI0.OSFL, \_SB.PCI0.W2FG)
        Store (0x00, \_SB.PCI0.RTCX)
        Store (0x01, \_SB.SLPS)
    }

    Method (_WAK, 1, NotSerialized)
    {
        ShiftLeft (Arg0, 0x04, DBG8)
        If (LEqual (Arg0, 0x03))
        {
            If (\_SB.PCI0.RTCX)
            {
                Notify (\_SB.PWRB, 0x02)
                Sleep (0x0294)
            }
        }
        Else
        {
            If (LOr (LNot (RTCS), \_SB.PCI0.RTCX))
            {
                Notify (\_SB.PWRB, 0x02)
                Sleep (0x0294)
            }
        }

        Store (0x01, PWBT)
        If (LNot (\_SB.PCI0.OSFL))
        {
            If (\_SB.PCI0.GATR)
            {
                Store (PTB1, \_SB.PCI0.TLBC)
            }
            Else
            {
                Store (0x00, \_SB.PCI0.TLBC)
            }
        }

        Store (PTB0, \_SB.PCI0.MC9.MC9P)
        Store (0x00, PS1E)
        Store (0x00, \_SB.PCI0.W2FG)
        Store (0x00, \_SB.PCI0.RTCX)
        Store (0x00, \_SB.SLPS)
        Return (Zero)
    }

    OperationRegion (PMS0, SystemIO, 0x0800, 0x04)
    Field (PMS0, ByteAcc, NoLock, Preserve)
    {
            ,   10, 
        RTCS,   1, 
        Offset (0x03), 
        PWBT,   1, 
        Offset (0x04)
    }

    OperationRegion (IOTP, SystemIO, 0x0828, 0x04)
    Field (IOTP, ByteAcc, NoLock, Preserve)
    {
            ,   7, 
        WAKS,   1, 
            ,   6, 
        PS0S,   1, 
        PS1S,   1, 
            ,   14, 
        PS0E,   1, 
        PS1E,   1
    }

    OperationRegion (TEMP, SystemIO, 0x80, 0x01)
    Field (TEMP, ByteAcc, NoLock, Preserve)
    {
        DBG8,   8
    }

    OperationRegion (DEB0, SystemIO, 0x90, 0x02)
    Field (DEB0, WordAcc, NoLock, Preserve)
    {
        DBG9,   16
    }

    OperationRegion (SDB0, SystemIO, 0x040E, 0x01)
    Field (SDB0, ByteAcc, NoLock, Preserve)
    {
        QSMB,   4, 
        Offset (0x01)
    }

    OperationRegion (SDB1, SystemIO, 0x040F, 0x01)
    Field (SDB1, ByteAcc, NoLock, Preserve)
    {
        QTMF,   8
    }

    OperationRegion (PMRG, SystemIO, 0x0800, 0x80)
    Field (PMRG, ByteAcc, NoLock, Preserve)
    {
        Offset (0x10), 
        THRT,   8, 
        Offset (0x2F), 
        SSMI,   8
    }

    Mutex (ECKP, 0x00)
    Name (FGEC, 0x00)
    Name (FAKE, 0x00)
    Name (TEM1, 0x00)
    Name (THPP, 0x4B)
    OperationRegion (BSMM, SystemMemory, 0x1FFFF000, 0x0100)
    Field (BSMM, ByteAcc, NoLock, Preserve)
    {
        BIF0,   16, 
        BIF1,   16, 
        BIF2,   16, 
        BIF3,   16, 
        BIF4,   16, 
        BIF5,   16, 
        BIF6,   16, 
        BIF7,   16, 
        BIF8,   16, 
        BIF9,   64, 
        BIFA,   64, 
        BIFB,   64, 
        BIFC,   64, 
        BST0,   16, 
        BST1,   16, 
        BST2,   16, 
        BST3,   16, 
        BTP0,   16, 
        ACIN,   1, 
            ,   1, 
        BTIN,   1, 
        Offset (0x3D), 
        Offset (0x40), 
        OSEC,   3, 
        Offset (0x41), 
        SLPT,   3, 
        Offset (0x42), 
        Offset (0x70), 
        GVCS,   8
    }
}

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>This is the end of the 
file

Many Thanks,
Caspar.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
