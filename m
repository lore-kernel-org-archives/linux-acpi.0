From: <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Subject: Re: 2.6.2-rc1 / ACPI sleep / irqbalance / kirqd / pentium 4 HT problems on Uniwill N258SA0
Date: Tue, 27 Jan 2004 15:49:57 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37778.199.172.169.20.1075236597.squirrel@webmail.localnet.com>
References: <20040124233749.5637.COUNT0@localnet.com>
        <20040127083936.GA18246@elf.ucw.cz>
        <401685F9.6000904@samwel.tk>
        <1075231649.18386.34.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20040127154957_25915"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1075231649.18386.34.camel-udXHSmD1qAy4CTf7w+cZoA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: bart-MhNDsYAqC79aa/9Udqfwiw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-laptop-WlP1pkEOrE5AfugRpC6u6w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

------=_20040127154957_25915
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Here's the dsdt.dsl for UniWill N258SA0, courtesy of /proc/acpi/dsdt
and iasl -d (attached).

The dsdt recompiles without any warnings.

Some more suspend/resume
observances (after commenting out the SMP prohibition on sleep,
and booting with noirqbalance to disable kirqd):

S1 - suspends, does not fully resume (USB devices get re-initted,
     then hangs). needs power cycle to get back
S3 - suspends if acpi_os_name="Microsoft Windows NT", but resume
     disables the display so thoroughly I have to unplug AC and remove
     battery before power cycling to get it back!
S4 (pmdisk) - suspends and immediately resumes with spurious wake up
S4b - ('') - ditto

> I have SMP working under 2.4, and am not far away from having it for
> 2.6. There is just one file that needs changing, but I need to learn
> some x86 assembly first. If someone already knows x86 assembly and
> wants to get it going first, I'll happily apply the patch.

Cool!



------=_20040127154957_25915
Content-Type: text/plain; name="dsdt.dsl"
Content-Disposition: attachment; filename="dsdt.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of dsdt.dat, Mon Jan 26 21:57:14 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "1ABFS", "1ABFS001", 1)
{
    OperationRegion (BIOS, SystemMemory, 0x1FFDF064, 0xFF)
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
    Name (PMBS, 0x0800)
    Name (PMLN, 0x80)
    Name (GPBS, 0x00)
    Name (GPLN, 0x00)
    Name (SMBS, 0x0C00)
    Name (SMBL, 0x20)
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
        Processor (CPU1, 0x01, 0x00000810, 0x06) {}
        Processor (CPU2, 0x02, 0x00000810, 0x06) {}
    }

    Scope (\_SB)
    {
        Name (PR00, Package (0x11)
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
                0x0002FFFF, 
                0x01, 
                LNKB, 
                0x00
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x02, 
                LNKC, 
                0x00
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x03, 
                LNKD, 
                0x00
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                LNKH, 
                0x00
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x00, 
                LNKE, 
                0x00
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x01, 
                LNKF, 
                0x00
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                LNKG, 
                0x00
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x00, 
                LNKD, 
                0x00
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x00, 
                LNKA, 
                0x00
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x01, 
                LNKB, 
                0x00
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                LNKC, 
                0x00
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                LNKD, 
                0x00
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                0x00, 
                LNKC, 
                0x00
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                0x01, 
                LNKD, 
                0x00
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                0x00, 
                LNKD, 
                0x00
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                0x00, 
                LNKB, 
                0x00
            }
        })
        Name (AR00, Package (0x11)
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
                0x0002FFFF, 
                0x01, 
                0x00, 
                0x11
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x02, 
                0x00, 
                0x12
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x03, 
                0x00, 
                0x13
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                0x00, 
                0x17
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x00, 
                0x00, 
                0x14
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x01, 
                0x00, 
                0x15
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                0x00, 
                0x16
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x00, 
                0x00, 
                0x13
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
                0x000BFFFF, 
                0x00, 
                0x00, 
                0x12
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                0x01, 
                0x00, 
                0x13
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                0x00, 
                0x00, 
                0x13
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                0x00, 
                0x00, 
                0x11
            }
        })
        Name (PRSA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {3,4,5,7,10,11,12,14,15}
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

            Device (SBRG)
            {
                Name (_ADR, 0x00020000)
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

                Device (PS2M)
                {
                    Name (_HID, EisaId ("SYN0801"))
                    Name (_CID, Package (0x02)
                    {
                        0x00082E4F, 
                        0x130FD041
                    })
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

                Device (UAR1)
                {
                    Name (_UID, 0x01)
                    Name (_HID, EisaId ("PNP0501"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (DSTA (0x00))
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        DCNT (0x00, 0x00)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (DCRS (0x00))
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        DSRS (Arg0, 0x00)
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (CMPR)
                    }

                    Name (CMPR, ResourceTemplate ()
                    {
                        IRQNoFlags () {3,4,5,6,7,10,11,12}
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                        }
                        EndDependentFn ()
                    })
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
                        IRQNoFlags () {3,4,5,6,7,10,11,12}
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                            IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                        }
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

                Device (FDC)
                {
                    Name (_HID, EisaId ("PNP0700"))
                    Name (_FDE, Package (0x05)
                    {
                        0x01, 
                        0x00, 
                        0x02, 
                        0x02, 
                        0x02
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (DSTA (0x03))
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        DCNT (0x03, 0x00)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        DCRS (0x03)
                        Store (IRQM, IRQE)
                        Store (DMAM, DMAE)
                        Store (IO11, IO21)
                        Store (IO12, IO22)
                        Store (0x06, LEN2)
                        Add (IO21, 0x07, IO31)
                        Store (IO31, IO32)
                        Store (0x01, LEN3)
                        Return (CRS2)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        DSRS (Arg0, 0x03)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                        }
                        StartDependentFnNoPri ()
                        {
                            IRQNoFlags () {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,2,3}
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                        }
                        StartDependentFnNoPri ()
                        {
                            IRQNoFlags () {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,2,3}
                            IO (Decode16, 0x0370, 0x0370, 0x01, 0x06)
                            IO (Decode16, 0x0377, 0x0377, 0x01, 0x01)
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
                    Name (CRS0, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0010, 0x0010, 0x00, 0x10)
                        IO (Decode16, 0x0022, 0x0022, 0x00, 0x1E)
                        IO (Decode16, 0x0044, 0x0044, 0x00, 0x1C)
                        IO (Decode16, 0x0072, 0x0072, 0x00, 0x0E)
                        IO (Decode16, 0x0080, 0x0080, 0x00, 0x01)
                        IO (Decode16, 0x0084, 0x0084, 0x00, 0x03)
                        IO (Decode16, 0x0088, 0x0088, 0x00, 0x01)
                        IO (Decode16, 0x008C, 0x008C, 0x00, 0x03)
                        IO (Decode16, 0x0090, 0x0090, 0x00, 0x10)
                        IO (Decode16, 0x00A2, 0x00A2, 0x00, 0x1E)
                        IO (Decode16, 0x00E0, 0x00E0, 0x00, 0x10)
                        IO (Decode16, 0x0480, 0x0480, 0x00, 0x10)
                        IO (Decode16, 0x04D0, 0x04D0, 0x00, 0x02)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        Memory32 (ReadOnly, 0xFFE80000, 0xFFE80000, 0x00000000, 0x00080000)
                        Memory32 (ReadOnly, 0xFFF80000, 0xFFF80000, 0x00000000, 0x00080000)
                        Memory32 (ReadOnly, 0xFEE00400, 0xFEE00400, 0x00000000, 0x00DFFC00)
                    })
                    Name (CRS1, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0010, 0x0010, 0x00, 0x10)
                        IO (Decode16, 0x0022, 0x0022, 0x00, 0x1E)
                        IO (Decode16, 0x0044, 0x0044, 0x00, 0x1C)
                        IO (Decode16, 0x0072, 0x0072, 0x00, 0x0E)
                        IO (Decode16, 0x0080, 0x0080, 0x00, 0x01)
                        IO (Decode16, 0x0084, 0x0084, 0x00, 0x03)
                        IO (Decode16, 0x0088, 0x0088, 0x00, 0x01)
                        IO (Decode16, 0x008C, 0x008C, 0x00, 0x03)
                        IO (Decode16, 0x0090, 0x0090, 0x00, 0x10)
                        IO (Decode16, 0x00A2, 0x00A2, 0x00, 0x1E)
                        IO (Decode16, 0x00E0, 0x00E0, 0x00, 0x10)
                        IO (Decode16, 0x0480, 0x0480, 0x00, 0x10)
                        IO (Decode16, 0x04D0, 0x04D0, 0x00, 0x02)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        Memory32Fixed (ReadOnly, 0xFFE00000, 0x00200000)
                    })
                    Name (CRS2, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0010, 0x0010, 0x00, 0x10)
                        IO (Decode16, 0x0022, 0x0022, 0x00, 0x1E)
                        IO (Decode16, 0x0044, 0x0044, 0x00, 0x1C)
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
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                        IO (Decode16, 0x0000, 0x0000, 0x00, 0x00)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (LEqual (OSFL (), 0x00))
                        {
                            CreateWordField (CRS1, 0x6A, GP00)
                            CreateWordField (CRS1, 0x6C, GP01)
                            CreateByteField (CRS1, 0x6F, GP0L)
                            Store (PMBS, GP00)
                            Store (PMBS, GP01)
                            Store (PMLN, GP0L)
                        }
                        Else
                        {
                            CreateWordField (CRS0, 0x6A, GX00)
                            CreateWordField (CRS0, 0x6C, GX01)
                            CreateByteField (CRS0, 0x6F, GX0L)
                            Store (PMBS, GX00)
                            Store (PMBS, GX01)
                            Store (PMLN, GX0L)
                        }

                        If (LEqual (OSFL (), 0x00))
                        {
                            CreateWordField (CRS1, 0x72, GP30)
                            CreateWordField (CRS1, 0x74, GP31)
                            CreateByteField (CRS1, 0x77, GP3L)
                            Add (0x80, PMBS, Local0)
                            Store (Local0, GP30)
                            Store (Local0, GP31)
                            Store (0x80, GP3L)
                        }
                        Else
                        {
                            CreateWordField (CRS0, 0x72, GX30)
                            CreateWordField (CRS0, 0x74, GX31)
                            CreateByteField (CRS0, 0x77, GX3L)
                            Add (0x80, PMBS, Local0)
                            Store (Local0, GX30)
                            Store (Local0, GX31)
                            Store (0x80, GX3L)
                        }

                        If (SMBS)
                        {
                            If (LEqual (OSFL (), 0x00))
                            {
                                CreateWordField (CRS1, 0x7A, GP10)
                                CreateWordField (CRS1, 0x7C, GP11)
                                CreateByteField (CRS1, 0x7F, GP1L)
                                Store (SMBS, GP10)
                                Store (SMBS, GP11)
                                Store (SMBL, GP1L)
                            }
                            Else
                            {
                                CreateWordField (CRS0, 0x7A, GX10)
                                CreateWordField (CRS0, 0x7C, GX11)
                                CreateByteField (CRS0, 0x7F, GX1L)
                                Store (SMBS, GX10)
                                Store (SMBS, GX11)
                                Store (SMBL, GX1L)
                            }
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
                            If (LEqual (OSFL (), 0x02))
                            {
                                Return (CRS2)
                            }
                            Else
                            {
                                Return (CRS0)
                            }
                        }
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

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x00, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x00, 0x01)
                    })
                    Name (FGEC, 0x00)
                    Name (OTYP, 0x00)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, FGEC)
                        }

                        If (LEqual (OSFL (), 0x01))
                        {
                            Store (0x01, OSEC)
                            Store (0x01, OTYP)
                        }
                        Else
                        {
                            If (LEqual (OSFL (), 0x00))
                            {
                                Store (0x02, OSEC)
                                Store (0x02, OTYP)
                            }
                            Else
                            {
                                If (LEqual (OSFL (), 0x02))
                                {
                                    Store (0x03, OSEC)
                                    Store (0x03, OTYP)
                                }
                            }

                            If (LEqual (OSFL (), 0x04))
                            {
                                Store (0x04, OSEC)
                                Store (0x04, OTYP)
                            }
                        }

                        Store (0x98, SSMI)
                    }

                    OperationRegion (ECXP, EmbeddedControl, 0x00, 0x0100)
                    Field (ECXP, ByteAcc, Lock, Preserve)
                    {
                        XIF0,   16, 
                        XIF1,   16, 
                        XIF2,   16, 
                        XIF3,   16, 
                        XIF4,   16, 
                        XIF5,   16, 
                        XIF6,   16, 
                        XIF7,   16, 
                        XIF8,   16, 
                        XIF9,   64, 
                        XIFA,   64, 
                        XIFB,   64, 
                        XIFC,   64, 
                        XST0,   16, 
                        XST1,   16, 
                        XST2,   16, 
                        XST3,   16, 
                        XTP0,   16, 
                        XCIN,   1, 
                            ,   1, 
                        XTIN,   1, 
                        Offset (0x3D), 
                        Offset (0x3E), 
                        XHPP,   7, 
                        Offset (0x3F), 
                        Offset (0x40), 
                        XSEC,   8, 
                        XLPT,   8, 
                        Offset (0xA3), 
                        ECBL,   8
                    }

                    Name (_GPE, 0x0B)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
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
                                Store (0x22, P378)
                                Notify (\_SB.PCI0.BAT0, 0x00)
                            }
                            Else
                            {
                                Store (0x23, P378)
                                Notify (\_SB.PCI0.BAT0, 0x03)
                            }

                            Notify (\_SB.PCI0.BAT0, 0x81)
                            Notify (\_SB.PCI0.BAT0, 0x80)
                        }

                        If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (), 0x04)))
                        {
                            Store (0x22, P378)
                            Sleep (0x01F4)
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
                    }

                    Method (_Q07, 0, NotSerialized)
                    {
                        Store ("AC Change", Debug)
                        Store (0x07, DBG8)
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

                        If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (), 0x04)))
                        {
                            Notify (\_SB.PCI0.AC0, 0x80)
                            Notify (\_SB.PCI0.BAT0, 0x80)
                        }

                        Store (0x9C, SSMI)
                        Sleep (0x03E8)
                        Store (0x9C, SSMI)
                    }

                    Method (_Q0A, 0, NotSerialized)
                    {
                        Store (0xF1, DBG8)
                        Store ("FN+F1 Event", Debug)
                        Notify (\_SB.SLPB, 0x80)
                    }

                    Method (_Q0C, 0, NotSerialized)
                    {
                        Store ("FN+F3 Event", Debug)
                        Store (0x82, SSMI)
                    }

                    Method (_Q0D, 0, NotSerialized)
                    {
                        Store ("FN+F4 Event", Debug)
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
                                If (LEqual (\_SB.PCI0.AGP.VGA.GDGS, 0x01))
                                {
                                    Store (0x00, \_SB.PCI0.AGP.VGA.LCD._DGS)
                                    Store (0x01, \_SB.PCI0.AGP.VGA.CRT._DGS)
                                }

                                If (LEqual (\_SB.PCI0.AGP.VGA.GDGS, 0x02))
                                {
                                    Store (0x01, \_SB.PCI0.AGP.VGA.LCD._DGS)
                                    Store (0x00, \_SB.PCI0.AGP.VGA.CRT._DGS)
                                }

                                If (LEqual (\_SB.PCI0.AGP.VGA.GDGS, 0x03))
                                {
                                    Store (0x01, \_SB.PCI0.AGP.VGA.LCD._DGS)
                                    Store (0x01, \_SB.PCI0.AGP.VGA.CRT._DGS)
                                }

                                Notify (\_SB.PCI0.AGP.VGA, 0x80)
                                If (LEqual (\_SB.PCI0.AGP.VGA.GDGS, 0x03))
                                {
                                    Store (0x01, \_SB.PCI0.AGP.VGA.GDGS)
                                }
                                Else
                                {
                                    Add (0x01, \_SB.PCI0.AGP.VGA.GDGS, \_SB.PCI0.AGP.VGA.GDGS)
                                }
                            }
                        }
                    }

                    Method (_Q10, 0, NotSerialized)
                    {
                        Store ("FN+F7 Event", Debug)
                        Store (\_SB.PCI0.SBRG.EC0.ECBL, Local0)
                        Store (Local0, A3BL)
                        Store (0x86, SSMI)
                    }

                    Method (_Q11, 0, NotSerialized)
                    {
                        Store ("FN+F8 Event", Debug)
                        Store (\_SB.PCI0.SBRG.EC0.ECBL, A3BL)
                        Store (0x87, SSMI)
                    }

                    Method (_Q16, 0, NotSerialized)
                    {
                        Store (0x16, DBG8)
                        Store (0x01, LIDS)
                        Notify (\_SB.PCI0.SBRG.LID, 0x80)
                    }

                    Method (_Q19, 0, NotSerialized)
                    {
                        Store (0x19, DBG8)
                        Store (0x00, LIDS)
                        Notify (\_SB.PCI0.SBRG.LID, 0x80)
                    }

                    Method (_Q1E, 0, NotSerialized)
                    {
                        Store (0x8E, SSMI)
                    }

                    Method (_Q1F, 0, NotSerialized)
                    {
                        Store (0x8F, SSMI)
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        Store (0x90, SSMI)
                    }

                    Method (_Q21, 0, NotSerialized)
                    {
                        Store (0x91, SSMI)
                    }

                    Method (_Q22, 0, NotSerialized)
                    {
                        Store (0x92, SSMI)
                    }

                    Method (_Q23, 0, NotSerialized)
                    {
                        Store (0x93, SSMI)
                    }

                    Method (_Q24, 0, NotSerialized)
                    {
                        Store (0x94, SSMI)
                    }

                    Method (_Q25, 0, NotSerialized)
                    {
                        Store (0x95, SSMI)
                    }

                    Method (_Q26, 0, NotSerialized)
                    {
                        Store (0x96, SSMI)
                    }

                    Method (_Q27, 0, NotSerialized)
                    {
                        Store (0x69, THPP)
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Method (_Q38, 0, NotSerialized)
                    {
                        Store (0x9B, SSMI)
                    }
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
                        "258SA0", 
                        "00002", 
                        "LiIon", 
                        "OEM"
                    })
                    Method (_BIF, 0, NotSerialized)
                    {
                        Store ("BIf", Debug)
                        If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (), 0x04)))
                        {
                            Store (\_SB.PCI0.SBRG.EC0.XIF0, Index (PAK1, 0x00))
                            Store (\_SB.PCI0.SBRG.EC0.XIF1, Index (PAK1, 0x01))
                            Store (\_SB.PCI0.SBRG.EC0.XIF2, Local0)
                            Store (Local0, Index (PAK1, 0x02))
                            Store (\_SB.PCI0.SBRG.EC0.XIF3, Index (PAK1, 0x03))
                            Store (\_SB.PCI0.SBRG.EC0.XIF4, Index (PAK1, 0x04))
                            Store (Divide (Local0, 0x0A, ), Index (PAK1, 0x05))
                            Store (Divide (Local0, 0x14, ), Index (PAK1, 0x06))
                            Store (\_SB.PCI0.SBRG.EC0.XIF7, Index (PAK1, 0x07))
                        }
                        Else
                        {
                            Store (0x99, SSMI)
                            Store (BIF0, Index (PAK1, 0x00))
                            Store (BIF1, Index (PAK1, 0x01))
                            Store (BIF2, Local0)
                            Store (Local0, Index (PAK1, 0x02))
                            Store (BIF3, Index (PAK1, 0x03))
                            Store (BIF4, Index (PAK1, 0x04))
                            Store (Divide (Local0, 0x0A, ), Index (PAK1, 0x05))
                            Store (Divide (Local0, 0x14, ), Index (PAK1, 0x06))
                            Store (BIF7, Index (PAK1, 0x07))
                        }

                        Return (PAK1)
                    }

                    Name (BFB0, Package (0x04)
                    {
                        0x00, 
                        0x00, 
                        0x1034, 
                        0x2A30
                    })
                    Method (_BST, 0, NotSerialized)
                    {
                        Store ("BST Start", Debug)
                        If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (), 0x04)))
                        {
                            Store (\_SB.PCI0.SBRG.EC0.XST0, Index (BFB0, 0x00))
                            Store (\_SB.PCI0.SBRG.EC0.XST2, Index (BFB0, 0x02))
                            Store (\_SB.PCI0.SBRG.EC0.XST3, Index (BFB0, 0x03))
                        }
                        Else
                        {
                            Store (0x9A, SSMI)
                            Store (BST0, Index (BFB0, 0x00))
                            Store (BST2, Index (BFB0, 0x02))
                            Store (BST3, Index (BFB0, 0x03))
                        }

                        Store ("BST End", Debug)
                        Return (BFB0)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Store ("BAT_STA Start", Debug)
                        If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (), 0x04)))
                        {
                            If (LEqual (\_SB.PCI0.SBRG.EC0.FGEC, 0x00))
                            {
                                Store (0x98, SSMI)
                                Store (BTIN, Local0)
                            }
                            Else
                            {
                                Store (\_SB.PCI0.SBRG.EC0.XTIN, Local0)
                            }

                            If (Local0)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }
                        Else
                        {
                            Store (0x98, SSMI)
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
                            If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (), 0x04)))
                            {
                                Store (\_SB.PCI0.SBRG.EC0.XCIN, Local0)
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

                Scope (\_GPE)
                {
                    Method (_L0B, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0, 0x02)
                    }
                }

                Name (LIDS, 0x01)
                Device (\_SB.PCI0.SBRG.LID)
                {
                    Name (_HID, EisaId ("PNP0C0D"))
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x04
                    })
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

                    Name (_PRW, Package (0x02)
                    {
                        0x0F, 
                        0x04
                    })
                }

                Scope (\)
                {
                    OperationRegion (PMRG, SystemIO, 0x0800, 0x80)
                    Field (PMRG, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x01), 
                        WWAK,   8, 
                        Offset (0x04), 
                        SCIF,   1, 
                        Offset (0x06), 
                        RTCS,   8, 
                        Offset (0x10), 
                        THRT,   8, 
                        Offset (0x48), 
                        SSMI,   8
                    }

                    OperationRegion (OPR2, SystemIO, 0x0378, 0x02)
                    Field (OPR2, ByteAcc, NoLock, Preserve)
                    {
                        P378,   8
                    }

                    Mutex (ECKP, 0x00)
                    Name (FGEC, 0x00)
                    Name (TEM1, 0x00)
                    Name (THPP, 0x4B)
                    Name (FAKE, 0x00)
                    Name (SLPS, 0x00)
                    Field (BIOS, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x50), 
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
                        Offset (0x90), 
                        OSEC,   8, 
                        SLPT,   8, 
                        Offset (0xA3), 
                        A3BL,   8
                    }
                }
            }

            Device (IDEC)
            {
                Name (_ADR, 0x00020005)
                Name (IO5T, Package (0x03)
                {
                    Package (0x07)
                    {
                        0x78, 
                        0xB4, 
                        0x014A, 
                        0x0186, 
                        0x0258, 
                        0x78, 
                        0x96
                    }, 

                    Package (0x07)
                    {
                        0x06, 
                        0x07, 
                        0x1C, 
                        0x1C, 
                        0x1C, 
                        0x06, 
                        0x07
                    }, 

                    Package (0x07)
                    {
                        0x04, 
                        0x09, 
                        0x03, 
                        0x09, 
                        0x1E, 
                        0x04, 
                        0x06
                    }
                })
                Name (IO6T, Package (0x03)
                {
                    Package (0x07)
                    {
                        0x78, 
                        0xB4, 
                        0x014A, 
                        0x0186, 
                        0x0258, 
                        0x78, 
                        0xB4
                    }, 

                    Package (0x07)
                    {
                        0x09, 
                        0x0A, 
                        0x26, 
                        0x26, 
                        0x26, 
                        0x09, 
                        0x0A
                    }, 

                    Package (0x07)
                    {
                        0x05, 
                        0x0C, 
                        0x04, 
                        0x0C, 
                        0x28, 
                        0x05, 
                        0x0C
                    }
                })
                Name (UM5T, Package (0x06)
                {
                    0x0B, 
                    0x07, 
                    0x05, 
                    0x04, 
                    0x02, 
                    0x01
                })
                Name (UM6T, Package (0x07)
                {
                    0x0F, 
                    0x0A, 
                    0x07, 
                    0x05, 
                    0x03, 
                    0x02, 
                    0x01
                })
                Name (PIO5, Package (0x05)
                {
                    0x3A, 
                    0x25, 
                    0x1F, 
                    0x10, 
                    0x0A
                })
                Name (PIO6, Package (0x05)
                {
                    0x4E, 
                    0x32, 
                    0x2A, 
                    0x16, 
                    0x0E
                })
                Name (CRCT, Package (0x07)
                {
                    0x06, 
                    0x04, 
                    0x03, 
                    0x01, 
                    0x01, 
                    0x01, 
                    0x01
                })
                Name (INTT, Package (0x05)
                {
                    0x02, 
                    0x02, 
                    0x02, 
                    0x04, 
                    0x06
                })
                Name (DMAT, Package (0x05)
                {
                    0x00, 
                    0x01, 
                    0x01, 
                    0x01, 
                    0x02
                })
                Name (RMFL, 0x01)
                OperationRegion (CF40, PCI_Config, 0x40, 0x18)
                Field (CF40, WordAcc, NoLock, Preserve)
                {
                        ,   1, 
                    IOR0,   1, 
                    UDM0,   1, 
                    UM60,   1, 
                    UCT0,   4, 
                    CRC0,   4, 
                    INI0,   4, 
                    ATT0,   6, 
                    Offset (0x03), 
                    RCT0,   6, 
                    Offset (0x04), 
                        ,   1, 
                    IOR1,   1, 
                    UDM1,   1, 
                    UM61,   1, 
                    UCT1,   4, 
                    CRC1,   4, 
                    INI1,   4, 
                    ATT1,   6, 
                    Offset (0x07), 
                    RCT1,   6, 
                    Offset (0x08), 
                        ,   1, 
                    IOR2,   1, 
                    UDM2,   1, 
                    UM62,   1, 
                    UCT2,   4, 
                    CRC2,   4, 
                    INI2,   4, 
                    ATT2,   6, 
                    Offset (0x0B), 
                    RCT2,   6, 
                    Offset (0x0C), 
                        ,   1, 
                    IOR3,   1, 
                    UDM3,   1, 
                    UM63,   1, 
                    UCT3,   4, 
                    CRC3,   4, 
                    INI3,   4, 
                    ATT3,   6, 
                    Offset (0x0F), 
                    RCT3,   6, 
                    Offset (0x10), 
                        ,   1, 
                    CHE0,   1, 
                    Offset (0x12), 
                        ,   1, 
                    CHE1,   1, 
                    Offset (0x14), 
                        ,   30, 
                    REMP,   1, 
                    Offset (0x18)
                }

                Name (IDEP, Buffer (0x14) {})
                CreateDWordField (IDEP, 0x00, GTM0)
                CreateDWordField (IDEP, 0x04, GTM1)
                CreateDWordField (IDEP, 0x08, GTM2)
                CreateDWordField (IDEP, 0x0C, GTM3)
                CreateDWordField (IDEP, 0x10, GTM4)
                Device (IDE0)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (0xFFFFFFFF, Local0)
                        Store (0xFFFFFFFF, Local1)
                        Store (0xFFFFFFFF, Local2)
                        Store (0xFFFFFFFF, Local3)
                        Store (0x10, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (CHE0)
                        {
                            If (LNot (LEqual (ATT0, 0x00)))
                            {
                                Add (RCT0, 0x01, Local5)
                                Add (ATT0, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM60, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local0)
                                ShiftRight (Local0, 0x01, Local0)
                                If (LNot (LGreater (Local0, 0xB4)))
                                {
                                    Store (Local0, Local1)
                                }

                                If (IOR0)
                                {
                                    Or (Local4, 0x02, Local4)
                                }

                                If (UDM0)
                                {
                                    Add (UCT0, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local1)
                                    Or (Local4, 0x01, Local4)
                                }
                            }

                            If (LNot (LEqual (ATT1, 0x00)))
                            {
                                Add (RCT1, 0x01, Local5)
                                Add (ATT1, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM61, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local2)
                                ShiftRight (Local2, 0x01, Local2)
                                If (LNot (LGreater (Local2, 0xB4)))
                                {
                                    Store (Local2, Local3)
                                }

                                If (IOR1)
                                {
                                    Or (Local4, 0x08, Local4)
                                }

                                If (UDM1)
                                {
                                    Add (UCT1, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local3)
                                    Or (Local4, 0x04, Local4)
                                }
                            }
                        }

                        Store (RMFL, REMP)
                        Store (Local0, GTM0)
                        Store (Local1, GTM1)
                        Store (Local2, GTM2)
                        Store (Local3, GTM3)
                        Store (Local4, GTM4)
                        Return (IDEP)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, IDEP)
                        Store (GTM0, Local0)
                        Store (GTM1, Local1)
                        Store (GTM2, Local2)
                        Store (GTM3, Local3)
                        Store (GTM4, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (LAnd (LNot (LEqual (Local1, 0xFFFFFFFF)), LNot (LEqual (Local1, 0x00))))
                        {
                            If (And (Local4, 0x01))
                            {
                                Store (0x01, UDM0)
                                If (LLess (Local1, 0x14))
                                {
                                    Store (0x01, UM60)
                                    Store (0x01, UCT0)
                                }
                                Else
                                {
                                    Store (0x00, UM60)
                                    Divide (Local1, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT0)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC0)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local0, 0xFFFFFFFF)), LNot (LEqual (Local0, 0x00))))
                        {
                            If (UM60)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT0)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT0)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT0)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT0)
                                Store (DerefOf (Index (INTT, Local6)), INI0)
                            }
                        }

                        If (LAnd (LNot (LEqual (Local3, 0xFFFFFFFF)), LNot (LEqual (Local3, 0x00))))
                        {
                            If (And (Local4, 0x04))
                            {
                                Store (0x01, UDM1)
                                If (LLess (Local3, 0x14))
                                {
                                    Store (0x01, UM61)
                                    Store (0x01, UCT1)
                                }
                                Else
                                {
                                    Store (0x00, UM61)
                                    Divide (Local3, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT1)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC1)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local2, 0xFFFFFFFF)), LNot (LEqual (Local2, 0x00))))
                        {
                            If (UM61)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT1)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT1)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT1)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT1)
                                Store (DerefOf (Index (INTT, Local6)), INI1)
                            }
                        }

                        Store (RMFL, REMP)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT0, 0x00)))
                            {
                                Add (ATT0, RCT0, Local5)
                                If (UM60)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM0)
                                {
                                    If (UM60)
                                    {
                                        Store (Match (UM6T, MEQ, UCT0, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT0, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT1, 0x00)))
                            {
                                Add (ATT1, RCT1, Local5)
                                If (UM61)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM1)
                                {
                                    If (UM61)
                                    {
                                        Store (Match (UM6T, MEQ, UCT1, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT1, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }
                }

                Device (IDE1)
                {
                    Name (_ADR, 0x01)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (0xFFFFFFFF, Local0)
                        Store (0xFFFFFFFF, Local1)
                        Store (0xFFFFFFFF, Local2)
                        Store (0xFFFFFFFF, Local3)
                        Store (0x10, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (CHE1)
                        {
                            If (LNot (LEqual (ATT2, 0x00)))
                            {
                                Add (RCT2, 0x01, Local5)
                                Add (ATT2, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM62, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local0)
                                ShiftRight (Local0, 0x01, Local0)
                                If (LNot (LGreater (Local0, 0xB4)))
                                {
                                    Store (Local0, Local1)
                                }

                                If (IOR2)
                                {
                                    Or (Local4, 0x02, Local4)
                                }

                                If (UDM2)
                                {
                                    Add (UCT2, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local1)
                                    Or (Local4, 0x01, Local4)
                                }
                            }

                            If (LNot (LEqual (ATT3, 0x00)))
                            {
                                Add (RCT3, 0x01, Local5)
                                Add (ATT3, 0x01, Local6)
                                Add (Local5, Local6, Local5)
                                Multiply (UM63, 0x05, Local6)
                                Subtract (0x14, Local6, Local7)
                                Multiply (Local5, Local7, Local2)
                                ShiftRight (Local2, 0x01, Local2)
                                If (LNot (LGreater (Local2, 0xB4)))
                                {
                                    Store (Local2, Local3)
                                }

                                If (IOR3)
                                {
                                    Or (Local4, 0x08, Local4)
                                }

                                If (UDM3)
                                {
                                    Add (UCT3, 0x01, Local5)
                                    Multiply (Local5, Local7, Local6)
                                    ShiftRight (Local6, 0x01, Local3)
                                    Or (Local4, 0x04, Local4)
                                }
                            }
                        }

                        Store (RMFL, REMP)
                        Store (Local0, GTM0)
                        Store (Local1, GTM1)
                        Store (Local2, GTM2)
                        Store (Local3, GTM3)
                        Store (Local4, GTM4)
                        Return (IDEP)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, IDEP)
                        Store (GTM0, Local0)
                        Store (GTM1, Local1)
                        Store (GTM2, Local2)
                        Store (GTM3, Local3)
                        Store (GTM4, Local4)
                        Store (REMP, RMFL)
                        Store (0x00, REMP)
                        If (LAnd (LNot (LEqual (Local1, 0xFFFFFFFF)), LNot (LEqual (Local1, 0x00))))
                        {
                            If (And (Local4, 0x01))
                            {
                                Store (0x01, UDM2)
                                If (LLess (Local1, 0x14))
                                {
                                    Store (0x01, UM62)
                                    Store (0x01, UCT2)
                                }
                                Else
                                {
                                    Store (0x00, UM62)
                                    Divide (Local1, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT2)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC2)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local0, 0xFFFFFFFF)), LNot (LEqual (Local0, 0x00))))
                        {
                            If (UM62)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT2)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT2)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local0, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT2)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT2)
                                Store (DerefOf (Index (INTT, Local6)), INI2)
                            }
                        }

                        If (LAnd (LNot (LEqual (Local3, 0xFFFFFFFF)), LNot (LEqual (Local3, 0x00))))
                        {
                            If (And (Local4, 0x04))
                            {
                                Store (0x01, UDM3)
                                If (LLess (Local3, 0x14))
                                {
                                    Store (0x01, UM63)
                                    Store (0x01, UCT3)
                                }
                                Else
                                {
                                    Store (0x00, UM63)
                                    Divide (Local3, 0x0A, Local6, Local5)
                                    Decrement (Local5)
                                    Store (Local5, UCT3)
                                    Store (Match (UM5T, MEQ, Local5, MTR, 0x00, 0x00), Local5)
                                    Store (DerefOf (Index (CRCT, Local5)), CRC3)
                                }
                            }
                        }

                        If (LAnd (LNot (LEqual (Local2, 0xFFFFFFFF)), LNot (LEqual (Local2, 0x00))))
                        {
                            If (UM63)
                            {
                                Store (Match (DerefOf (Index (IO6T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x01)), Local6)), ATT3)
                                Store (DerefOf (Index (DerefOf (Index (IO6T, 0x02)), Local6)), RCT3)
                            }
                            Else
                            {
                                Store (Match (DerefOf (Index (IO5T, 0x00)), MEQ, Local2, MTR, 0x00, 0x00), Local6)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x01)), Local6)), ATT3)
                                Store (DerefOf (Index (DerefOf (Index (IO5T, 0x02)), Local6)), RCT3)
                                Store (DerefOf (Index (INTT, Local6)), INI3)
                            }
                        }

                        Store (RMFL, REMP)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT2, 0x00)))
                            {
                                Add (ATT2, RCT2, Local5)
                                If (UM62)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM2)
                                {
                                    If (UM62)
                                    {
                                        Store (Match (UM6T, MEQ, UCT2, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT2, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local6)
                            Store (Buffer (0x07)
                                {
                                    0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local7)
                            CreateByteField (Local6, 0x01, MODE)
                            CreateByteField (Local7, 0x01, UMOD)
                            Store (REMP, RMFL)
                            Store (0x00, REMP)
                            If (LNot (LEqual (ATT3, 0x00)))
                            {
                                Add (ATT3, RCT3, Local5)
                                If (UM63)
                                {
                                    Store (Match (PIO6, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }
                                Else
                                {
                                    Store (Match (PIO5, MEQ, Local5, MTR, 0x00, 0x00), MODE)
                                }

                                If (UDM3)
                                {
                                    If (UM63)
                                    {
                                        Store (Match (UM6T, MEQ, UCT3, MTR, 0x00, 0x00), UMOD)
                                    }
                                    Else
                                    {
                                        Store (Match (UM5T, MEQ, UCT3, MTR, 0x00, 0x00), UMOD)
                                    }

                                    Or (UMOD, 0x40, UMOD)
                                }
                                Else
                                {
                                    Store (DerefOf (Index (DMAT, MODE)), UMOD)
                                    Or (UMOD, 0x20, UMOD)
                                }

                                Or (MODE, 0x08, MODE)
                            }

                            Store (RMFL, REMP)
                            Concatenate (Local6, Local7, Local5)
                            Return (Local5)
                        }
                    }
                }
            }

            Device (EUSB)
            {
                Name (_ADR, 0x00030003)
            }

            Device (USB)
            {
                Name (_ADR, 0x00030000)
            }

            Device (USB2)
            {
                Name (_ADR, 0x00030001)
            }

            Device (USB3)
            {
                Name (_ADR, 0x00030002)
            }

            Device (MAC)
            {
                Name (_ADR, 0x00040000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x0C, 0x04))
                }
            }

            Device (S139)
            {
                Name (_ADR, 0x00020003)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x03, 0x04))
                }
            }

            Device (AC97)
            {
                Name (_ADR, 0x00020007)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x0A, 0x04))
                }
            }

            Device (MC97)
            {
                Name (_ADR, 0x00020006)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x05, 0x04))
                }
            }

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
                        0x00010100, 
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
                            0x50, 
                            0x32, 
                            0x14, 
                            0x28, 
                            0x3C, 
                            0x50, 
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

        Scope (\_GPE)
        {
            Method (_L0C, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.MAC, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }

            Method (_L03, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.S139, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }

            Method (_L0A, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.AC97, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }

            Method (_L05, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.MC97, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_UID, 0x05)
            Name (_STA, 0x0B)
            Method (_PRW, 0, NotSerialized)
            {
                Return (GPRW (0x05, 0x04))
            }
        }
    }

    Scope (\_SB)
    {
        OperationRegion (\_SB.PCI0.SBRG.PIX0, PCI_Config, 0x41, 0x04)
        OperationRegion (\_SB.PCI0.SBRG.PIX1, PCI_Config, 0x60, 0x04)
        Field (\_SB.PCI0.SBRG.PIX0, ByteAcc, NoLock, Preserve)
        {
            PIRA,   8, 
            PIRB,   8, 
            PIRC,   8, 
            PIRD,   8
        }

        Field (\_SB.PCI0.SBRG.PIX1, ByteAcc, NoLock, Preserve)
        {
            PIRE,   8, 
            PIRF,   8, 
            PIRG,   8, 
            PIRH,   8
        }

        Name (BUFA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared) {15}
        })
        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x01)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRA, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSA)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRA, 0x80, PIRA)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BUFA, 0x01, IRA0)
                And (PIRA, 0x0F, Local0)
                Store (One, Local1)
                ShiftLeft (Local1, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRA)
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x02)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRB, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSB)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRB, 0x80, PIRB)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BUFA, 0x01, IRA0)
                And (PIRB, 0x0F, Local0)
                Store (One, Local1)
                ShiftLeft (Local1, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRB)
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x03)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRC, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSC)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRC, 0x80, PIRC)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BUFA, 0x01, IRA0)
                And (PIRC, 0x0F, Local0)
                Store (One, Local1)
                ShiftLeft (Local1, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRC)
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x04)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRD, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSD)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRD, 0x80, PIRD)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BUFA, 0x01, IRA0)
                And (PIRD, 0x0F, Local0)
                Store (One, Local1)
                ShiftLeft (Local1, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRD)
            }
        }

        Device (LNKE)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x05)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRE, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSE)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRE, 0x80, PIRE)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BUFA, 0x01, IRA0)
                And (PIRE, 0x0F, Local0)
                Store (One, Local1)
                ShiftLeft (Local1, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRE)
            }
        }

        Device (LNKF)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x06)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRF, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSF)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRF, 0x80, PIRF)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BUFA, 0x01, IRA0)
                And (PIRF, 0x0F, Local0)
                Store (One, Local1)
                ShiftLeft (Local1, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRF)
            }
        }

        Device (LNKG)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x07)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRG, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSG)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRG, 0x80, PIRG)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BUFA, 0x01, IRA0)
                And (PIRG, 0x0F, Local0)
                Store (One, Local1)
                ShiftLeft (Local1, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRG)
            }
        }

        Device (LNKH)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x08)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRH, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSH)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRH, 0x80, PIRH)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BUFA, 0x01, IRA0)
                And (PIRH, 0x0F, Local0)
                Store (One, Local1)
                ShiftLeft (Local1, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRH)
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
                    0x000D0000,
                    0x000D3FFF,
                    0x00000000,
                    0x00004000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D4000,
                    0x000D7FFF,
                    0x00000000,
                    0x00004000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000DE000,
                    0x000DFFFF,
                    0x00000000,
                    0x00002000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000)
            })
            CreateDWordField (CRS, 0xAA, MIN6)
            CreateDWordField (CRS, 0xAE, MAX6)
            CreateDWordField (CRS, 0xB6, LEN6)
            Method (_CRS, 0, NotSerialized)
            {
                Store (MG2B, MIN6)
                Store (MG2L, LEN6)
                Store (MG2L, Local0)
                Add (MIN6, Decrement (Local0), MAX6)
                Return (CRS)
            }

            Method (_S3D, 0, NotSerialized)
            {
                If (LOr (LEqual (OSFL (), 0x01), LEqual (OSFL (), 0x02)))
                {
                    Return (0x02)
                }
                Else
                {
                    Return (0x03)
                }
            }

            Scope (EUSB)
            {
                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), 0x01), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Scope (USB)
            {
                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), 0x01), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Scope (USB2)
            {
                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), 0x01), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            Scope (USB3)
            {
                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), 0x01), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
            }

            OperationRegion (NBR0, PCI_Config, 0x00, 0xFF)
            Field (NBR0, DWordAcc, NoLock, Preserve)
            {
                Offset (0xD1), 
                NRD1,   1, 
                Offset (0xD8), 
                NRD8,   32
            }
        }
    }

    Name (SD0, 0x00)
    Name (SD1, 0x00)
    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, DBG8)
        PTS (Arg0)
        Store (\_SB.PCI0.NRD1, SD0)
        Store (\_SB.PCI0.NRD8, SD1)
        Or (P42, 0x40, P42)
        Store (OSFL (), P49)
        Or (Arg0, 0xA0, Local0)
        Add (Local0, 0x06, Local0)
        Store (Local0, P48)
        If (LAnd (LEqual (Arg0, 0x04), LEqual (OSFL (), 0x02)))
        {
            Sleep (0x0BB8)
        }

        Store (0x00, Index (WAKP, 0x00))
        Store (0x00, Index (WAKP, 0x01))
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (SD1, \_SB.PCI0.NRD8)
        Store (SD0, \_SB.PCI0.NRD1)
        ShiftLeft (Arg0, 0x04, DBG8)
        ShiftLeft (Arg0, 0x04, P378)
        If (LEqual (Arg0, 0x03))
        {
            If (RTC3)
            {
                Store (0xC3, P378)
            }
            Else
            {
                Notify (\_SB.PWRB, 0x02)
                Sleep (0x64)
            }
        }
        Else
        {
            Notify (\_SB.PWRB, 0x02)
            Sleep (0x64)
            Store (\_SB.PCI0.SBRG.EC0.OTYP, OSEC)
            Store (0x98, SSMI)
        }

        Or (Arg0, 0xA0, Local0)
        Store (Local0, P48)
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

    OperationRegion (PR48, SystemIO, 0x0848, 0x01)
    Field (PR48, ByteAcc, NoLock, Preserve)
    {
        P48,    8
    }

    OperationRegion (S3WK, SystemIO, 0x0860, 0x02)
    Field (S3WK, ByteAcc, NoLock, Preserve)
    {
            ,   14, 
        RTC3,   1
    }

    OperationRegion (PR42, SystemIO, 0x0842, 0x01)
    Field (PR42, ByteAcc, NoLock, Preserve)
    {
        P42,    8
    }

    OperationRegion (PR49, SystemIO, 0x0849, 0x01)
    Field (PR49, ByteAcc, NoLock, Preserve)
    {
        P49,    8
    }

    Name (\_S0, Package (0x04)
    {
        0x00, 
        0x00, 
        0x00, 
        0x00
    })
    Name (\_S1, Package (0x04)
    {
	0x01, 
	0x00, 
	0x00, 
	0x00
    })
    Name (\_S3, Package (0x04)
    {
	0x03, 
	0x00, 
	0x00, 
	0x00
    })
    Name (\_S4, Package (0x04)
    {
	0x04, 
	0x00, 
	0x00, 
	0x00
    })
    Name (\_S5, Package (0x04)
    {
        0x05, 
        0x00, 
        0x00, 
        0x00
    })

    Method (PTS, 1, NotSerialized)
    {
        If (Arg0) {}
    }

    Method (WAK, 1, NotSerialized)
    {
    }
}


------=_20040127154957_25915--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
