From: Hein-Pieter van Braam <hp-KOxqMzujAKlWk0Htik3J/w@public.gmane.org>
Subject: Compaq 2552EA suspend/resume
Date: Wed, 05 Oct 2005 19:13:25 +0200
Message-ID: <1128532406.16313.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BIVw+RwixH9qZLhMAP6M"
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


--=-BIVw+RwixH9qZLhMAP6M
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all!

I've got a compaq 2552EA laptop, and I have been trying to get suspend
to ram and suspend to disk to work forever, and, well, failed :)

I've patched my DSDT, and it is a little better now, but I think there's
a bit more wrong with it than just syntax :) but.

Anyway, I would really like to debug this problem, either from my DSDT
or from linux's acpi implementation. But, I've got no real clue where to
start. The AML language is pretty simple, but not really understandable
without intimate knowledge of the hardware I feel :)

anyway, what happens when I try to enter S3, is (without patched DSDT)
it tried to resume, then just sits there doing nothing. I can then
switch to another console, and continue working, but I can't suspend
again. 
With my patched DSDT it suspends then immediately wakes up again.

Hibernation just crashes during disk write (I think, can't be sure as
there is no output) but the harddisk led just keeps burning without
generating any actual harddisk activity (I can tell because the disks
isn't making 'writing noises') :)

I would really appreciate some pointers as to where to start looking for
trouble. I've attached my dsdt and lspci -v output.

thanks in advance

hp

--=-BIVw+RwixH9qZLhMAP6M
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device cbb2 (rev 02)
	Flags: bus master, 66MHz, medium devsel, latency 64
	Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Memory at d0007000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0300000-d03fffff
	Prefetchable memory behind bridge: d8000000-dfffffff

0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 1000 [size=256]
	Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
	Flags: bus master, medium devsel, latency 0
	Capabilities: <available only to root>

0000:00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: medium devsel, IRQ 10
	Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 1400 [size=256]
	Capabilities: <available only to root>

0000:00:09.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 00e7
	Flags: bus master, fast devsel, latency 64, IRQ 10
	Memory at d0002000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: <available only to root>

0000:00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
	Memory at d0004000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: d0200000-d02ff000 (prefetchable)
	Memory window 1: d0100000-d01ff000
	I/O window 0: 00001c00-00001cff
	I/O window 1: 00001800-000018ff
	16-bit legacy interface ports at 0001

0000:00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 2000 [size=32]
	Capabilities: <available only to root>

0000:00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 2020 [size=32]
	Capabilities: <available only to root>

0000:00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at d0005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, medium devsel, latency 32
	I/O ports at 2040 [size=16]
	Capabilities: <available only to root>

0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: medium devsel

0000:00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, medium devsel, latency 90, IRQ 10
	I/O ports at 2400 [size=256]
	Memory at d0006000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, stepping, fast Back2Back, 66MHz, medium devsel, latency 66, IRQ 10
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 9000 [size=256]
	Memory at d0300000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>


--=-BIVw+RwixH9qZLhMAP6M
Content-Disposition: attachment; filename=dsdt.dsl
Content-Type: text/x-dsl; name=dsdt.dsl; charset=UTF-8
Content-Transfer-Encoding: 7bit

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20050902
 *
 * Disassembly of dsdt.dat, Tue Oct  4 03:17:58 2005
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "ATI", "MS2_1535", 100925440)
{
    OperationRegion (PORT, SystemIO, 0x80, 0x01)
    Field (PORT, ByteAcc, NoLock, Preserve)
    {
        P80H,   8
    }

    OperationRegion (PMIO, SystemIO, 0x8000, 0x30)
    Field (PMIO, ByteAcc, NoLock, Preserve)
    {
        PMS1,   16, 
        PME1,   16, 
        PMC1,   16, 
        Offset (0x08), 
        ATMR,   32, 
        Offset (0x10), 
            ,   1, 
        TRDC,   3, 
        TREN,   1
    }

    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06)
        {
            Method (_CST, 0, NotSerialized)
            {
                Return (Package (0x03)
                {
                    0x02, 
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
                            Register (SystemIO, 0x08, 0x00, 0x0000000000008014)
                        }, 

                        0x02, 
                        0x63, 
                        0x01F4
                    }
                })
            }

            Name (XPCT, Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x00000000000000B1)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x00000000000000B3)
                }
            })
            Name (XPSS, Package (0x02)
            {
                Package (0x06)
                {
                    0x270F, 
                    0x0001869F, 
                    0x03E7, 
                    0x03E7, 
                    0x99, 
                    0x99
                }, 

                Package (0x06)
                {
                    0x270F, 
                    0x0001869F, 
                    0x03E7, 
                    0x03E7, 
                    0x99, 
                    0x99
                }
            })
            Method (XPPC, 0, NotSerialized)
            {
                Return (0x00)
            }
        }
    }

    Method (VTOB, 1, NotSerialized)
    {
        Store (0x01, Local0)
        ShiftLeft (Local0, Arg0, Local0)
        Return (Local0)
    }

    Method (BTOV, 1, NotSerialized)
    {
        ShiftRight (Arg0, 0x01, Local0)
        Store (0x00, Local1)
        While (Local0)
        {
            Increment (Local1)
            ShiftRight (Local0, 0x01, Local0)
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
        Store (0x00, Local2)
        Store (0x00, Local3)
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

    Name (_S0, Package (0x04)
    {
        0x00, 
        0x00, 
        0x00, 
        0x00
    })
    Name (_S3, Package (0x04)
    {
        0x03, 
        0x03, 
        0x00, 
        0x00
    })
    Name (_S4, Package (0x04)
    {
        0x04, 
        0x04, 
        0x00, 
        0x00
    })
    Name (_S5, Package (0x04)
    {
        0x05, 
        0x05, 
        0x00, 
        0x00
    })
    Scope (\_SB)
    {
        Name (ECEN, 0x00)
        Name (WLMF, 0x00)
        Name (ACCG, 0x00)
        Name (Q8CD, 0x00)
        Name (PRCT, 0x00)
        Method (ECOK, 0, NotSerialized)
        {
            If (ECEN)
            {
                Return (0x01)
            }
            Else
            {
                Return (0x00)
            }
        }

        Method (_INI, 0, NotSerialized)
        {
            \_TZ.TINI ()
            If (CondRefOf (\_OSI, Local0))
            {
                If (\_OSI ("Windows 2001"))
                {
                    Store (0x04, \_SB.PCI0.ISA.TOOS)
                }
            }
            Else
            {
                Store (SizeOf (\_OS), Local0)
                If (LEqual (Local0, 0x14))
                {
                    Store (0x03, \_SB.PCI0.ISA.TOOS)
                }

                If (LEqual (Local0, 0x26))
                {
                    Store (0x02, \_SB.PCI0.ISA.TOOS)
                }

                If (LEqual (Local0, 0x11))
                {
                    Store (0x01, \_SB.PCI0.ISA.TOOS)
                }
            }
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_PRW, Package (0x02)
            {
                0x09, 
                0x05
            })
            Name (_BBN, 0x00)
            OperationRegion (MREG, PCI_Config, 0xB8, 0x14)
            Field (MREG, ByteAcc, NoLock, Preserve)
            {
                CS0,    8, 
                CS1,    8, 
                CS2,    8, 
                CS3,    8, 
                Offset (0x10), 
                FBSL,   8, 
                FBSM,   8
            }

            Method (TOM, 0, NotSerialized)
            {
                Multiply (FBSL, 0x00010000, Local0)
                Multiply (FBSM, 0x01000000, Local1)
                Add (Local0, Local1, Local0)
                Return (Local0)
            }

            OperationRegion (REGS, PCI_Config, 0x59, 0x3B)
            Field (REGS, ByteAcc, NoLock, Preserve)
            {
                SR59,   8, 
                SR5A,   8, 
                SR5B,   8, 
                SR5C,   8, 
                SR5D,   8, 
                SR5E,   8, 
                SR5F,   8, 
                Offset (0x39), 
                SR92,   8, 
                SR93,   8
            }

            Name (RSRC, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, SubDecode,
                    0x0000, // Address Space Granularity
                    0x0000, // Address Range Minimum
                    0x00FF, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x0100,,,)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000A0000, // Address Range Minimum
                    0x000BFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00020000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000C0000, // Address Range Minimum
                    0x000C3FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000C4000, // Address Range Minimum
                    0x000C7FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000C8000, // Address Range Minimum
                    0x000CBFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000CC000, // Address Range Minimum
                    0x000CFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000D0000, // Address Range Minimum
                    0x000D3FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000D4000, // Address Range Minimum
                    0x000D7FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000D8000, // Address Range Minimum
                    0x000DBFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000DC000, // Address Range Minimum
                    0x000DFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000E0000, // Address Range Minimum
                    0x000E3FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000E4000, // Address Range Minimum
                    0x000E7FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000E8000, // Address Range Minimum
                    0x000EBFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000EC000, // Address Range Minimum
                    0x000EFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00004000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x00000000, // Address Range Minimum
                    0xFFFDFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00000000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000D0000, // Address Range Minimum
                    0x000D7FFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00008000,,,
                    , AddressRangeMemory, TypeStatic)
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
            })
            Method (_CRS, 0, Serialized)
            {
                CreateBitField (RSRC, 0x0188, C0RW)
                CreateDWordField (RSRC, 0x42, C0LN)
                Store (One, C0RW)
                Store (0x4000, C0LN)
                If (And (SR5A, 0x01))
                {
                    Store (0x00, C0LN)
                }

                CreateBitField (RSRC, 0x0260, C4RW)
                CreateDWordField (RSRC, 0x5D, C4LN)
                Store (One, C4RW)
                Store (0x4000, C4LN)
                If (And (SR5A, 0x10))
                {
                    Store (0x00, C4LN)
                }

                CreateBitField (RSRC, 0x0338, C8RW)
                CreateDWordField (RSRC, 0x78, C8LN)
                Store (One, C8RW)
                Store (0x4000, C8LN)
                If (And (SR5B, 0x01))
                {
                    Store (0x00, C8LN)
                }

                CreateBitField (RSRC, 0x0410, CCRW)
                CreateDWordField (RSRC, 0x93, CCLN)
                Store (One, CCRW)
                Store (0x4000, CCLN)
                If (And (SR5B, 0x10))
                {
                    Store (0x00, CCLN)
                }

                CreateBitField (RSRC, 0x04E8, D0RW)
                CreateDWordField (RSRC, 0xAE, D0LN)
                Store (One, D0RW)
                Store (0x4000, D0LN)
                If (And (SR5C, 0x01))
                {
                    Store (0x00, D0LN)
                }

                CreateBitField (RSRC, 0x05C0, D4RW)
                CreateDWordField (RSRC, 0xC9, D4LN)
                Store (One, D4RW)
                Store (0x4000, D4LN)
                If (And (SR5C, 0x10))
                {
                    Store (0x00, D4LN)
                }

                CreateBitField (RSRC, 0x0698, D8RW)
                CreateDWordField (RSRC, 0xE4, D8LN)
                Store (One, D8RW)
                Store (0x4000, D8LN)
                If (And (SR5D, 0x01))
                {
                    Store (0x00, D8LN)
                }

                CreateBitField (RSRC, 0x0770, DCRW)
                CreateDWordField (RSRC, 0xFF, DCLN)
                Store (One, DCRW)
                Store (0x4000, DCLN)
                If (And (SR5D, 0x10))
                {
                    Store (0x00, DCLN)
                }

                CreateBitField (RSRC, 0x0848, E0RW)
                CreateDWordField (RSRC, 0x011A, E0LN)
                Store (One, E0RW)
                Store (0x4000, E0LN)
                If (And (SR5E, 0x01))
                {
                    Store (0x00, E0LN)
                }

                CreateBitField (RSRC, 0x0920, E4RW)
                CreateDWordField (RSRC, 0x0135, E4LN)
                Store (One, E4RW)
                Store (0x4000, E4LN)
                If (And (SR5E, 0x10))
                {
                    Store (0x00, E4LN)
                }

                CreateBitField (RSRC, 0x09F8, E8RW)
                CreateDWordField (RSRC, 0x0150, E8LN)
                Store (One, E8RW)
                Store (0x4000, E8LN)
                If (And (SR5F, 0x01))
                {
                    Store (0x00, E8LN)
                }

                CreateBitField (RSRC, 0x0AD0, ECRW)
                CreateDWordField (RSRC, 0x016B, ECLN)
                Store (One, ECRW)
                Store (0x4000, ECLN)
                If (And (SR5F, 0x10))
                {
                    Store (0x00, ECLN)
                }

                CreateDWordField (RSRC, 0x017A, BTMN)
                CreateDWordField (RSRC, 0x017E, BTMX)
                CreateDWordField (RSRC, 0x0186, BTLN)
                Multiply (SR92, 0x00010000, Local0)
                Multiply (SR93, 0x01000000, Local1)
                Add (Local0, Local1, BTMN)
                Subtract (0xFFF80000, BTMN, BTLN)
                Subtract (Add (BTMN, BTLN), 0x01, BTMX)
                Return (RSRC)
            }

            Name (_PRT, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0006FFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK7, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK6, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK3, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0009FFFF, 
                    0x01, 
                    \_SB.PCI0.ISA.LNK2, 
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
                    \_SB.PCI0.ISA.LNK2, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x01, 
                    \_SB.PCI0.ISA.LNK3, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000BFFFF, 
                    0x02, 
                    \_SB.PCI0.ISA.LNK5, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK2, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    0x00, 
                    \_SB.PCI0.ISA.LNK1, 
                    0x00
                }
            })
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }

            Device (AGPB)
            {
                Name (_ADR, 0x00010000)
                Name (_PRT, Package (0x01)
                {
                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x00, 
                        \_SB.PCI0.ISA.LNK0, 
                        0x00
                    }
                })
                Device (VGA)
                {
                    Name (_ADR, 0x00050000)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS1, 0, NotSerialized)
                    {
                        Store (0x01, _PSC)
                    }

                    Method (_PS2, 0, NotSerialized)
                    {
                        Store (0x02, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Name (DISW, 0x01)
                    Name (NDSP, 0x00)
                    Name (VRSM, 0x00)
                    Name (TGLT, Package (0x04)
                    {
                        Package (0x08)
                        {
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }, 

                        Package (0x08)
                        {
                            0x01, 
                            0x02, 
                            0x03, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }, 

                        Package (0x08)
                        {
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }, 

                        Package (0x08)
                        {
                            0x01, 
                            0x02, 
                            0x03, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01, 
                            0x01
                        }
                    })
                    Name (TGLP, 0x00)
                    Method (NDGS, 0, NotSerialized)
                    {
                        ShiftRight (And (^LCD._DCS, 0x02), 0x01, Local0)
                        Or (Local0, And (^CRT._DCS, 0x02), Local0)
                        Or (Local0, ShiftLeft (And (^TV._DCS, 0x02), 0x01), Local0)
                        Store (DerefOf (Index (DerefOf (Index (TGLT, TGLP)), Local0)), Local1)
                        And (Local1, 0x01, ^LCD._DGS)
                        ShiftRight (And (Local1, 0x02), 0x01, ^CRT._DGS)
                        ShiftRight (And (Local1, 0x04), 0x02, ^TV._DGS)
                    }

                    Method (USTS, 1, NotSerialized)
                    {
                        Store (\_SB.PCI0.ISA.HPSS (0x0F, 0x00), Local0)
                        And (Local0, 0x0F, Local1)
                        If (LEqual (Local1, 0x03))
                        {
                            Store (0x01, TGLP)
                        }
                        Else
                        {
                            If (LEqual (Local1, 0x05))
                            {
                                Store (0x02, TGLP)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x07))
                                {
                                    Store (0x03, TGLP)
                                }
                                Else
                                {
                                    Store (0x00, TGLP)
                                }
                            }
                        }

                        Or (ShiftRight (And (Local0, 0x10), 0x03), And (^LCD._DCS, 0xFD), ^LCD._DCS)
                        Or (Or (ShiftLeft (And (Local0, 0x02), 0x03), ShiftRight (And (Local0, 0x20), 0x04)), And (^CRT._DCS, 0xED), ^CRT._DCS)
                        Or (Or (ShiftLeft (And (Local0, 0x04), 0x02), ShiftRight (And (Local0, 0x40), 0x05)), And (^TV._DCS, 0xED), ^TV._DCS)
                        Return (Local0)
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Store (USTS (0x00), Local1)
                        Or (ShiftRight (And (Local1, 0x10), 0x03), 0x1D, ^LCD._DCS)
                        Or (Or (ShiftLeft (And (Local1, 0x02), 0x03), ShiftRight (And (Local1, 0x20), 0x04)), 0x0D, ^CRT._DCS)
                        Or (Or (ShiftLeft (And (Local1, 0x04), 0x02), ShiftRight (And (Local1, 0x40), 0x05)), 0x0D, ^TV._DCS)
                        ShiftRight (Local1, 0x04, NDSP)
                        Store (ShiftRight (And (^LCD._DCS, 0x02), 0x01), ^LCD._DGS)
                        Store (ShiftRight (And (^CRT._DCS, 0x02), 0x01), ^CRT._DGS)
                        Store (ShiftRight (And (^TV._DCS, 0x02), 0x01), ^TV._DGS)
                        NDGS ()
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        If (LAnd (LEqual (And (Arg0, 0x03), 0x00), LEqual (And (DISW, 0x03), 0x02)))
                        {
                            Notify (\_SB.PCI0.ISA.HPCI, 0x89)
                        }

                        Store (Arg0, DISW)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x03)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x00010200
                        })
                    }

                    Method (DRUL, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x01))
                        {
                            Store (USTS (0x01), Local2)
                        }
                        Else
                        {
                            Store (USTS (0x00), Local2)
                        }

                        If (LEqual (Arg0, 0x01))
                        {
                            NDGS ()
                            If (LOr (LAnd (^CRT._DGS, LNot (And (^CRT._DCS, 0x10))), LAnd (^TV._DGS, LNot (And (^TV._DCS, 0x10)))))
                            {
                                NDGS ()
                                Return (0x00)
                            }
                            Else
                            {
                                Notify (VGA, 0x80)
                                Return (0x00)
                            }
                        }

                        If (LEqual (Arg0, 0x02))
                        {
                            If (And (Local2, 0x02))
                            {
                                Store (0x01, ^CRT._DGS)
                                If (\_SB.PCI0.ISA.DISB)
                                {
                                    Store (0x01, ^LCD._DGS)
                                }
                                Else
                                {
                                    Store (0x00, ^LCD._DGS)
                                }

                                Store ("CRT Connected VGA.DRUL(2) called", Debug)
                            }
                            Else
                            {
                                Store (0x00, ^CRT._DGS)
                                Store (0x01, ^LCD._DGS)
                                Store ("CRT DisConnected VGA.DRUL(2) called", Debug)
                            }

                            Notify (VGA, 0x80)
                        }

                        If (LEqual (Arg0, 0x04))
                        {
                            Store (0x00, ^CRT._DGS)
                            Store (0x01, ^LCD._DGS)
                            Notify (VGA, 0x80)
                        }

                        If (LEqual (Arg0, 0x03))
                        {
                            If (LNot (LEqual (Local2, 0x02)))
                            {
                                If (And (Local2, 0x02))
                                {
                                    Store (0x01, ^CRT._DGS)
                                    If (\_SB.PCI0.ISA.DISB)
                                    {
                                        Store (0x01, ^LCD._DGS)
                                    }
                                    Else
                                    {
                                        Store (0x00, ^LCD._DGS)
                                    }
                                }
                                Else
                                {
                                    Store (0x00, ^CRT._DGS)
                                    Store (0x01, ^LCD._DGS)
                                }

                                Store ("Resume VGA.DRUL(3) called", Debug)
                                Notify (VGA, 0x80)
                            }
                        }

                        If (LEqual (Arg0, 0x04))
                        {
                            Notify (VGA, 0x80)
                            Return (0x00)
                        }
                        Return (0x00)
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Name (_PSC, 0x00)
                        Name (_S3D, 0x03)
                        Method (_PS0, 0, NotSerialized)
                        {
                            If (LAnd (LAnd (VRSM, LNot (^^CRT._PSC)), LNot (^^TV._PSC)))
                            {
                                If (_PSC)
                                {
                                    DRUL (0x03)
                                }

                                Store (0x00, VRSM)
                            }

                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("LCD._DSS(1) called", Debug)
                                Or (NDSP, 0x01, NDSP)
                            }
                            Else
                            {
                                Store ("LCD._DSS(0) called", Debug)
                                And (NDSP, 0xFE, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            If (LEqual (Local0, 0x80000000))
                            {
                                Store ("LCD._DSS(8000000x) called", Debug)
                                \_SB.PCI0.ISA.HPSS (0x01, NDSP)
                            }

                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("LCD._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And (NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And (NDSP, 0x04), 0x01), ^^TV._DCS)
                            }
                        }

                        Name (_DGS, 0x00)
                    }

                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            If (LAnd (LAnd (VRSM, LNot (^^LCD._PSC)), LNot (^^TV._PSC)))
                            {
                                If (_PSC)
                                {
                                    DRUL (0x03)
                                }

                                Store (0x00, VRSM)
                            }

                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("CRT._DSS(1) called", Debug)
                                Or (NDSP, 0x02, NDSP)
                            }
                            Else
                            {
                                Store ("CRT._DSS(0) called", Debug)
                                And (NDSP, 0xFD, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            If (LEqual (Local0, 0x80000000))
                            {
                                Store ("CRT._DSS(8000000x) called", Debug)
                                \_SB.PCI0.ISA.HPSS (0x01, NDSP)
                            }

                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("CRT._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And (NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And (NDSP, 0x04), 0x01), ^^TV._DCS)
                            }
                        }

                        Name (_DGS, 0x00)
                    }

                    Device (TV)
                    {
                        Name (_ADR, 0x0200)
                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            If (LAnd (LAnd (VRSM, LNot (^^CRT._PSC)), LNot (^^LCD._PSC)))
                            {
                                If (_PSC)
                                {
                                    DRUL (0x03)
                                }

                                Store (0x00, VRSM)
                            }

                            Store (0x00, _PSC)
                        }

                        Method (_PS1, 0, NotSerialized)
                        {
                            Store (0x01, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_DCS, 0x1B)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Store (Arg0, Local0)
                            If (And (Local0, 0x01))
                            {
                                Store ("TV_._DSS(1) called", Debug)
                                Or (NDSP, 0x04, NDSP)
                            }
                            Else
                            {
                                Store ("TV_._DSS(0) called", Debug)
                                And (NDSP, 0xFB, NDSP)
                            }

                            And (Local0, 0xC0000000, Local0)
                            If (LEqual (Local0, 0x80000000))
                            {
                                Store ("TV_._DSS(8000000x) called", Debug)
                                \_SB.PCI0.ISA.HPSS (0x01, NDSP)
                            }

                            And (Local0, 0x80000000, Local0)
                            If (LNot (LEqual (Local0, 0x00)))
                            {
                                Store ("TV_._DSS, update next _DGS", Debug)
                                Or (And (^^LCD._DCS, 0xFD), ShiftLeft (And (NDSP, 0x01), 0x01), ^^LCD._DCS)
                                Or (And (^^CRT._DCS, 0xFD), And (NDSP, 0x02), ^^CRT._DCS)
                                Or (And (^^TV._DCS, 0xFD), ShiftRight (And (NDSP, 0x04), 0x01), ^^TV._DCS)
                            }
                        }

                        Name (_DGS, 0x00)
                    }
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

                Method (STM, 3, NotSerialized)
                {
                    Name (A100, 0x00)
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
                    Name (W49M, 0x00)
                    Name (W53M, 0x00)
                    Name (W62M, 0x00)
                    Name (W64M, 0x00)
                    Name (W88M, 0x00)
                    If (LEqual (SizeOf (Arg1), 0x0200))
                    {
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
                    }
                    Else
                    {
                        Store (0x00, W49M)
                        Store (0x00, W53M)
                        Store (0x00, W62M)
                        Store (0x00, W64M)
                        Store (0x00, W88M)
                    }

                    If (LAnd (And (0x38, W88M), Ones))
                    {
                        Or (0x01, Local6, Local6)
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

                    Store (Ones, Local4)
                    If (LOr (DMA0, PIO0))
                    {
                        If (LAnd (DMA0, LNot (PIO0)))
                        {
                            If (And (Local6, 0x01))
                            {
                                If (LLess (DMA0, 0x1E))
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
                                If (LLess (DMA0, 0x1E))
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

                Device (PRIM)
                {
                    Name (_ADR, 0x00)
                    Name (_PSC, 0x00)
                    OperationRegion (HDIO, SystemIO, 0x01F0, 0x08)
                    Field (HDIO, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x01), 
                        Offset (0x02), 
                        Offset (0x03), 
                        Offset (0x04), 
                        Offset (0x05), 
                        Offset (0x06), 
                        HDSL,   8, 
                        HDCM,   8
                    }

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
                        Store ("GTM - Primary Controller", Debug)
                        Return (Buffer (0x14)
                        {
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 
                            0x1F, 0x00, 0x00, 0x00
                        })
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

                        Store (0x55, ^^PFTH)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("GTF - Primary Master", Debug)
                            Store (^^^GTF0 (^^^PCHE, ^^^PUDC, ^^^PTM0), Local0)
                            Return (Local0)
                        }

                        Name (_PSC, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            \_SB.PCI0.ISA.Z000 (0x02)
                            Store (0x03, _PSC)
                            Sleep (0x03E8)
                        }
                    }
                }

                Device (SECN)
                {
                    Name (_ADR, 0x01)
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
                        Store ("GTM - Secondary Controller", Debug)
                        Return (Buffer (0x14)
                        {
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 
                            0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 
                            0x1F, 0x00, 0x00, 0x00
                        })
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

                        Store (0x55, ^^SFTH)
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

                        Method (_PS0, 0, NotSerialized)
                        {
                            Store (0x00, _PSC)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Store (0x03, _PSC)
                        }

                        Name (_PSC, 0x00)
                    }
                }
            }

            Device (MDEM)
            {
                Name (_ADR, 0x00080000)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x04
                })
            }

            Device (AUDI)
            {
                Name (_ADR, 0x00060000)
            }

            Device (LAN)
            {
                Name (_ADR, 0x00120000)
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x05
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (\_SB.ECOK ())
                    {
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        If (Arg0)
                        {
                            Store (0x01, \_SB.PCI0.ISA.EC0.WOLE)
                        }
                        Else
                        {
                            Store (0x00, \_SB.PCI0.ISA.EC0.WOLE)
                        }

                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                    }
                }
            }

            Device (IEEE)
            {
                Name (_ADR, 0x000C0000)
            }

            Device (CBUS)
            {
                Name (_ADR, 0x000A0000)
            }

            Device (MINI)
            {
                Name (_ADR, 0x00090000)
            }

            Device (UB20)
            {
                Name (_ADR, 0x000B0000)
            }

            Device (ISA)
            {
                Name (_ADR, 0x00070000)
                OperationRegion (Z001, PCI_Config, 0x44, 0x01)
                Field (Z001, ByteAcc, NoLock, Preserve)
                {
                        ,   7, 
                    Z002,   1
                }

                OperationRegion (ISAR, PCI_Config, 0x00, 0x9F)
                Field (ISAR, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x77), 
                        ,   6, 
                    MDNE,   1, 
                    Offset (0x7E), 
                        ,   7, 
                    USB2,   1
                }

                OperationRegion (MNVS, SystemMemory, 0x1BF7CE1D, 0x10)
                Field (MNVS, AnyAcc, Lock, Preserve)
                {
                    TOOS,   8, 
                    LIDS,   8, 
                    ACST,   8, 
                    TV,     1, 
                    FIR,    1, 
                    COMM,   1, 
                    LPT,    1
                }

                OperationRegion (SMI0, SystemIO, 0x0000FE00, 0x00000002)
                Field (SMI0, AnyAcc, NoLock, Preserve)
                {
                    SMIC,   8
                }

                OperationRegion (SMI1, SystemMemory, 0x1BF7CE2D, 0x00000120)
                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    BCMD,   8, 
                    DID,    32, 
                    INFO,   2048
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    Offset (0x05), 
                    INF,    8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    Offset (0x05), 
                    STSB,   8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x05), 
                    PNLR,   32
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x105), 
                    BDST,   8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x106), 
                    DKSN,   32
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10A), 
                    DKTP,   8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10B), 
                    VGAB,   32
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10F), 
                    WOLE,   1, 
                    DISB,   1, 
                    PA3G,   1, 
                    FDDS,   1, 
                    POPS,   1, 
                    FIRS,   1, 
                    PCPU,   1
                }

                Mutex (PSMX, 0x00)
                Method (HPSS, 2, NotSerialized)
                {
                    Acquire (\_SB.PCI0.ISA.PSMX, 0xFFFF)
                    Store (Arg1, STSB)
                    Store (0x80, BCMD)
                    Store (Arg0, DID)
                    Store (Zero, SMIC)
                    Store (STSB, Local0)
                    Release (\_SB.PCI0.ISA.PSMX)
                    Return (Local0)
                }

                Method (Z000, 1, NotSerialized)
                {
                    Acquire (\_SB.PCI0.ISA.PSMX, 0xFFFF)
                    Store (0x90, BCMD)
                    Store (Arg0, DID)
                    Store (Zero, SMIC)
                    Release (\_SB.PCI0.ISA.PSMX)
                }

                OperationRegion (PUSB, PCI_Config, 0x74, 0x01)
                Field (PUSB, ByteAcc, NoLock, Preserve)
                {
                    PIR8,   4, 
                    Offset (0x01)
                }

                OperationRegion (PIRX, PCI_Config, 0x48, 0x04)
                Field (PIRX, ByteAcc, NoLock, Preserve)
                {
                    PIR0,   4, 
                    PIR1,   4, 
                    PIR2,   4, 
                    PIR3,   4, 
                    PIR4,   4, 
                    PIR5,   4, 
                    PIR6,   4, 
                    PIR7,   4
                }

                Name (IPRS, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {7,10}
                })
                Name (Z003, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {5}
                })
                Name (Z004, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared) {7,11}
                })
                Name (IXLT, Package (0x10)
                {
                    0x00, 
                    0x0200, 
                    0x08, 
                    0x0400, 
                    0x10, 
                    0x20, 
                    0x80, 
                    0x40, 
                    0x02, 
                    0x0800, 
                    0x00, 
                    0x1000, 
                    0x00, 
                    0x4000, 
                    0x00, 
                    0x8000
                })
                Device (LNK0)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR0)
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
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR0)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIR0, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PIR0)
                    }
                }

                Device (LNK1)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR1)
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
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR1)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIR1, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PIR1)
                    }
                }

                Device (LNK2)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR2)
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
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR2)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIR2, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PIR2)
                    }
                }

                Device (LNK3)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR3)
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
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR3)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIR3, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PIR3)
                    }
                }

                Device (LNK4)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR4)
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
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR4)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIR4, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PIR4)
                    }
                }

                Device (LNK5)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR5)
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
                        Return (Z004)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR5)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z004, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIR5, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PIR5)
                    }
                }

                Device (LNK6)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR6)
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
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR6)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIR6, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PIR6)
                    }
                }

                Device (LNK7)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR7)
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
                        Return (Z003)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR7)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z003, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIR7, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PIR7)
                    }
                }

                Device (LNK8)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x09)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIR8)
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
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIR8)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        Store (PIR8, Local1)
                        Store (DerefOf (Index (IXLT, Local1)), IRA0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRA0)
                        Store (Match (IXLT, MEQ, IRA0, MGT, 0x00, 0x00), PIR8)
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer8_16) {4}
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

                Device (TIME)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQ (Edge, ActiveHigh, Exclusive) {0}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x04)
                        IRQ (Edge, ActiveHigh, Exclusive) {8}
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

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                    })
                }

                Device (KBC0)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQ (Edge, ActiveHigh, Exclusive) {1}
                    })
                    Name (KBS3, 0x00)
                    Name (_PSC, 0x00)
                    Name (PS2D, 0x044C)
                }

                Device (MSE0)
                {
                    Name (_HID, "SYN0106")
                    Name (_CID, Package (0x03)
                    {
                        0x00012E4F, 
                        0x02002E4F, 
                        0x130FD041
                    })
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive) {12}
                    })
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (CRSZ, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x00B0, 0x00B0, 0x01, 0x04)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x040B, 0x040B, 0x01, 0x01)
                        IO (Decode16, 0x0480, 0x0480, 0x01, 0x10)
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0x04D6, 0x04D6, 0x01, 0x01)
                        IO (Decode16, 0x8000, 0x8000, 0x01, 0x80)
                        IO (Decode16, 0xFF00, 0xFF00, 0x01, 0x02)
                        IO (Decode16, 0x8004, 0x8004, 0x01, 0x02)
                        IO (Decode16, 0x80F0, 0x80F0, 0x01, 0x04)
                        IO (Decode16, 0xFE00, 0xFE00, 0x01, 0xFF)
                        Memory32Fixed (ReadWrite, 0xD0000000, 0x00001000)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRSZ, 0x64, VGAG)
                        Store (\_SB.PCI0.ISA.VGAB, VGAG)
                        Return (CRSZ)
                    }
                }

                Device (MEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (MSRC, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly, 0x000DC000, 0x00004000)
                        Memory32Fixed (ReadOnly, 0x000EC000, 0x00014000)
                        Memory32Fixed (ReadOnly, 0xFFF80000, 0x00080000)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                Device (SIOD)
                {
                    Name (_HID, EisaId ("PNP0A05"))
                    OperationRegion (SIIO, SystemIO, 0x03F0, 0x02)
                    Field (SIIO, ByteAcc, NoLock, Preserve)
                    {
                        INDX,   8, 
                        DATA,   8
                    }

                    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x22), 
                        CR22,   8, 
                        Offset (0x30), 
                        CR30,   8, 
                        Offset (0x60), 
                        CR60,   8, 
                        CR61,   8, 
                        Offset (0x70), 
                        CR70,   8, 
                        Offset (0x74), 
                        CR74,   8, 
                        Offset (0xF0), 
                        CRF0,   8, 
                        CRF1,   8, 
                        CRF2,   8, 
                        Offset (0xF4), 
                        CRF4,   8, 
                        CRF5,   8
                    }

                    Method (ENFG, 1, NotSerialized)
                    {
                        Acquire (MTIO, 0xFFFF)
                        Store (0x51, INDX)
                        Store (0x23, INDX)
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                        Store (0x22, INDX)
                        ShiftLeft (0x01, Arg0, Local0)
                        Return (And (DATA, Local0))
                    }

                    Method (EXFG, 0, NotSerialized)
                    {
                        Store (0xBB, INDX)
                        Release (MTIO)
                    }

                    Device (FDC)
                    {
                        Name (_HID, EisaId ("PNP0700"))
                        Method (_STA, 0, NotSerialized)
                        {
                            ENFG (0x00)
                            And (CR30, 0x01, Local0)
                            EXFG ()
                            If (\_SB.PCI0.ISA.FDDS)
                            {
                                If (Local0)
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (0x0D)
                                }
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (0x00)
                            Store (0x00, CR30)
                            Store (0x00, CR60)
                            Store (0x00, CR61)
                            Store (0x04, CR74)
                            Store (0x00, CR70)
                            EXFG ()
                        }

                        Name (RSRC, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        })
                        Method (_CRS, 0, NotSerialized)
                        {
                            CreateWordField (RSRC, 0x02, IO1L)
                            CreateWordField (RSRC, 0x04, IO1H)
                            CreateWordField (RSRC, 0x0A, IO2L)
                            CreateWordField (RSRC, 0x0C, IO2H)
                            CreateWordField (RSRC, 0x11, IRQX)
                            CreateByteField (RSRC, 0x14, DMAX)
                            Store (Zero, IO1L)
                            Store (Zero, IO1H)
                            Store (Zero, IO2L)
                            Store (Zero, IO2H)
                            Store (Zero, IRQX)
                            Store (Zero, DMAX)
                            ENFG (0x00)
                            Store (CR30, Local0)
                            Store (CR60, Local1)
                            If (LAnd (Local0, Local1))
                            {
                                Store (_PRS, RSRC)
                            }

                            EXFG ()
                            Return (RSRC)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        })
                        Method (_SRS, 1, NotSerialized)
                        {
                            Store (Arg0, RSRC)
                            CreateWordField (RSRC, 0x02, IOX)
                            CreateWordField (RSRC, 0x11, IRQX)
                            CreateByteField (RSRC, 0x14, DMAX)
                            ENFG (0x00)
                            And (IOX, 0xFF, CR61)
                            ShiftRight (IOX, 0x08, CR60)
                            FindSetRightBit (IRQX, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, CR70)
                            FindSetRightBit (DMAX, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, CR74)
                            Store (0x01, CR30)
                            EXFG ()
                        }
                    }

                    Method (STAX, 1, NotSerialized)
                    {
                        Store (^ENFG (Arg0), Local0)
                        ^EXFG ()
                        If (Local0)
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            If (And (CR30, 0x01))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x0D)
                            }
                        }
                    }

                    Method (DISX, 1, NotSerialized)
                    {
                        ^ENFG (Arg0)
                        And (CR30, 0xFE, CR30)
                        ^EXFG ()
                    }

                    Method (PSCX, 1, NotSerialized)
                    {
                        Store (LAnd (^ENFG (Arg0), And (CR30, 0x01)), Local0)
                        ^EXFG ()
                        If (Local0)
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            Return (0x03)
                        }
                    }

                    Method (PS0X, 1, NotSerialized)
                    {
                        Store (^ENFG (Arg0), Local0)
                        And (CR22, Not (Local0), CR22)
                        Or (CR30, 0x01, CR30)
                        ^EXFG ()
                    }

                    Method (PS3X, 1, NotSerialized)
                    {
                        Store (^ENFG (Arg0), Local0)
                        And (CR30, 0xFE, CR30)
                        Or (CR22, Local0, CR22)
                        ^EXFG ()
                    }

                    Name (RSRA, ResourceTemplate ()
                    {
                        IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                        IRQNoFlags () {4}
                    })
                    Method (CRSA, 1, NotSerialized)
                    {
                        CreateWordField (RSRA, 0x02, IOAL)
                        CreateWordField (RSRA, 0x04, IOAH)
                        CreateByteField (RSRA, 0x07, LENA)
                        CreateWordField (RSRA, 0x09, INTX)
                        ^ENFG (Arg0)
                        Store (Add (ShiftLeft (CR60, 0x08), CR61), Local0)
                        Store (Local0, IOAL)
                        Store (Local0, IOAH)
                        If (And (Local0, 0x04))
                        {
                            Store (0x04, Local1)
                        }
                        Else
                        {
                            Store (0x08, Local1)
                        }

                        Store (Local1, LENA)
                        Store (ShiftLeft (0x01, CR70), INTX)
                        ^EXFG ()
                        Return (RSRA)
                    }

                    Method (SRSA, 2, NotSerialized)
                    {
                        Store (Arg0, RSRA)
                        CreateWordField (RSRA, 0x02, IOAL)
                        CreateWordField (RSRA, 0x09, INTX)
                        ^ENFG (Arg1)
                        And (IOAL, 0xFF, CR61)
                        ShiftRight (IOAL, 0x08, CR60)
                        FindSetRightBit (INTX, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, CR70)
                        ^EXFG ()
                    }

                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                        IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                        IRQNoFlags () {6}
                        DMA (Compatibility, NotBusMaster, Transfer8) {2}
                    })
                    Method (CRSC, 1, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x02, IO1L)
                        CreateWordField (RSRC, 0x04, IO1H)
                        CreateByteField (RSRC, 0x07, LEN1)
                        CreateWordField (RSRC, 0x0A, IO2L)
                        CreateWordField (RSRC, 0x0C, IO2H)
                        CreateByteField (RSRC, 0x0F, LEN2)
                        CreateWordField (RSRC, 0x11, IRQX)
                        CreateByteField (RSRC, 0x14, DMAX)
                        ^ENFG (Arg0)
                        Store (Add (ShiftLeft (CR60, 0x08), CR61), Local0)
                        Store (Local0, IO1L)
                        Store (Local0, IO1H)
                        Store (0x0400, Local1)
                        If (And (Local0, 0x04))
                        {
                            Store (0x04, Local2)
                        }
                        Else
                        {
                            If (And (Local0, 0x08))
                            {
                                Store (0x08, Local2)
                            }
                            Else
                            {
                                Store (0x06, Local2)
                                Store (0x07, Local1)
                            }
                        }

                        Add (Local0, Local1, Local1)
                        Store (Local1, IO2L)
                        Store (Local1, IO2H)
                        Store (Local2, LEN1)
                        If (LEqual (Local1, 0x03F7))
                        {
                            Store (0x01, LEN2)
                        }
                        Else
                        {
                            Store (Local2, LEN2)
                        }

                        Store (ShiftLeft (0x01, CR70), IRQX)
                        Store (ShiftLeft (0x01, CR74), DMAX)
                        ^EXFG ()
                        Return (RSRC)
                    }

                    Method (SRSC, 2, NotSerialized)
                    {
                        Store (Arg0, RSRC)
                        CreateWordField (RSRC, 0x02, IO1L)
                        CreateWordField (RSRC, 0x11, IRQX)
                        CreateByteField (RSRC, 0x14, DMAX)
                        ^ENFG (Arg1)
                        And (IO1L, 0xFF, CR61)
                        ShiftRight (IO1L, 0x08, CR60)
                        FindSetRightBit (IRQX, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, CR70)
                        FindSetRightBit (DMAX, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, CR74)
                        ^EXFG ()
                    }

                    Device (LPT)
                    {
                        Name (TYPE, 0x00)
                        Method (IECP, 0, NotSerialized)
                        {
                            ENFG (0x03)
                            And (CRF0, 0x07, ^TYPE)
                            EXFG ()
                            Return (And (^TYPE, 0x02))
                        }

                        Method (_HID, 0, NotSerialized)
                        {
                            If (IECP ())
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
                            Return (^^STAX (0x03))
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ^^DISX (0x03)
                        }

                        Method (_PSC, 0, NotSerialized)
                        {
                            Return (^^PSCX (0x03))
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            ^^PS0X (0x03)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            ^^PS3X (0x03)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            If (IECP ())
                            {
                                Return (^^CRSC (0x03))
                            }
                            Else
                            {
                                Return (^^CRSA (0x03))
                            }
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            If (IECP ())
                            {
                                ^^SRSC (Arg0, 0x03)
                            }
                            Else
                            {
                                ^^SRSA (Arg0, 0x03)
                            }
                        }

                        Name (PRSA, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                            }
                            EndDependentFn ()
                        })
                        Name (PRSB, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {7}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IRQNoFlags () {5}
                            }
                            EndDependentFn ()
                        })
                        Name (PRSC, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {5}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                                IO (Decode16, 0x0678, 0x0678, 0x01, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                                IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)
                        {
                            If (IECP ())
                            {
                                Return (^PRSC)
                            }
                            Else
                            {
                                If (LEqual (0x01, ^TYPE))
                                {
                                    Return (^PRSB)
                                }
                                Else
                                {
                                    Return (^PRSA)
                                }
                            }
                        }
                    }

                    Name (CPRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        EndDependentFn ()
                    })
                    Device (FIR)
                    {
                        Name (_HID, EisaId ("ALI5123"))
                        Name (_CID, 0x1005D041)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (\_SB.PCI0.ISA.FIRS, 0x00))
                            {
                                Return (0x00)
                            }

                            ENFG (0x05)
                            And (CR22, 0x20, Local0)
                            And (CR30, 0x81, Local1)
                            EXFG ()
                            If (Local0)
                            {
                                Return (0x00)
                            }
                            Else
                            {
                                If (And (Local1, 0x80))
                                {
                                    If (And (Local1, 0x01))
                                    {
                                        Return (0x0F)
                                    }
                                    Else
                                    {
                                        Return (0x0D)
                                    }
                                }
                                Else
                                {
                                    Return (0x00)
                                }
                            }
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (0x05)
                            And (CR30, 0xFE, CR30)
                            EXFG ()
                        }

                        Name (RSRC, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0100, 0x0100, 0x01, 0x08)
                            IRQNoFlags () {}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                        })
                        Method (_CRS, 0, NotSerialized)
                        {
                            CreateWordField (RSRC, 0x02, IO1L)
                            CreateWordField (RSRC, 0x04, IO1H)
                            CreateWordField (RSRC, 0x09, IRQX)
                            CreateWordField (RSRC, 0x0C, DMAX)
                            ENFG (0x05)
                            And (CR30, 0x01, Local0)
                            If (Local0)
                            {
                                Store (CR60, IO1L)
                                ShiftLeft (IO1L, 0x08, Local1)
                                Or (CR61, Local1, Local2)
                                Store (Local2, IO1L)
                                Store (Local2, IO1H)
                                Store (CR70, Local1)
                                ShiftLeft (One, Local1, IRQX)
                                Store (CR74, Local2)
                                ShiftLeft (One, Local2, DMAX)
                            }
                            Else
                            {
                                Store (Zero, IO1L)
                                Store (Zero, IO1H)
                                Store (Zero, IRQX)
                                Store (0x04, DMAX)
                            }

                            EXFG ()
                            Return (RSRC)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            }
                            EndDependentFn ()
                        })
                        Method (_SRS, 1, NotSerialized)
                        {
                            Store (Arg0, RSRC)
                            CreateWordField (RSRC, 0x02, IO1L)
                            CreateWordField (RSRC, 0x09, IRQX)
                            CreateWordField (RSRC, 0x0C, DMAX)
                            ENFG (0x05)
                            And (IO1L, 0xFF, CR61)
                            ShiftRight (IO1L, 0x08, CR60)
                            FindSetRightBit (IRQX, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, CR70)
                            FindSetRightBit (DMAX, Local1)
                            If (Local1)
                            {
                                Decrement (Local1)
                            }

                            Store (Local1, CR74)
                            Or (CR30, 0x01, CR30)
                            EXFG ()
                        }
                    }

                    Device (COM1)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (\_SB.PRCT, 0x00))
                            {
                                ENFG (0x04)
                                Store (0x00, CR30)
                                Store (0x00, CR60)
                                Store (0x00, CR61)
                                Store (0x00, CR70)
                                EXFG ()
                                Return (0x00)
                            }

                            ENFG (0x04)
                            And (CR22, 0x10, Local0)
                            And (CR30, 0x01, Local1)
                            And (CRF1, 0x18, Local2)
                            EXFG ()
                            If (LEqual (Local2, 0x00))
                            {
                                If (And (Local1, 0x01))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (0x0D)
                                }
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            ENFG (0x04)
                            Store (0x00, CR30)
                            Store (0x00, CR60)
                            Store (0x00, CR61)
                            Store (0x00, CR70)
                            Or (CR22, 0x10, CR22)
                            EXFG ()
                        }

                        Name (RSRC, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        })
                        Method (_CRS, 0, NotSerialized)
                        {
                            CreateWordField (RSRC, 0x02, IO1L)
                            CreateWordField (RSRC, 0x04, IO1H)
                            CreateWordField (RSRC, 0x09, IRQX)
                            Store (Zero, IO1L)
                            Store (Zero, IO1H)
                            Store (Zero, IRQX)
                            ENFG (0x04)
                            And (CR30, 0x01, Local0)
                            If (Local0)
                            {
                                Store (CR60, IO1L)
                                ShiftLeft (IO1L, 0x08, Local1)
                                Or (CR61, Local1, Local2)
                                Store (Local2, IO1L)
                                Store (Local2, IO1H)
                                Store (CR70, Local1)
                                ShiftLeft (One, Local1, IRQX)
                            }
                            Else
                            {
                                Store (Zero, IO1L)
                                Store (Zero, IO1H)
                                Store (Zero, IRQX)
                            }

                            EXFG ()
                            Return (RSRC)
                        }

                        Name (_PRS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                                IRQNoFlags () {3}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                                IRQNoFlags () {4}
                            }
                            StartDependentFn (0x00, 0x01)
                            {
                                IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                                IRQNoFlags () {3}
                            }
                            EndDependentFn ()
                        })
                        Method (_SRS, 1, NotSerialized)
                        {
                            Store (Arg0, RSRC)
                            CreateWordField (RSRC, 0x02, IO1L)
                            CreateWordField (RSRC, 0x09, IRQX)
                            ENFG (0x04)
                            And (IO1L, 0xFF, CR61)
                            ShiftRight (IO1L, 0x08, CR60)
                            FindSetRightBit (IRQX, Local0)
                            If (Local0)
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, CR70)
                            Store (0x01, CR30)
                            And (CR22, Not (0x10), CR22)
                            EXFG ()
                        }

                        Name (_PRW, Package (0x02)
                        {
                            0x0A, 
                            0x04
                        })
                        Name (SV60, 0x00)
                        Name (SV61, 0x00)
                        Name (IRQV, 0x00)
                        Method (SAVE, 0, NotSerialized)
                        {
                            ENFG (0x04)
                            And (CR30, 0x01, Local0)
                            If (Local0)
                            {
                                Store (CR60, SV60)
                                Store (CR61, SV61)
                                Store (CR70, IRQV)
                            }

                            EXFG ()
                        }

                        Method (REST, 0, NotSerialized)
                        {
                            If (LNot (LEqual (SV60, Zero)))
                            {
                                ENFG (0x04)
                                Or (CR30, 0x01, CR30)
                                Store (SV60, CR60)
                                Store (SV61, CR61)
                                Store (IRQV, CR70)
                                EXFG ()
                            }
                        }
                    }

                    Mutex (MTIO, 0x00)
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x18)
                    Name (SEL0, 0xF0)
                    Name (BFLG, 0x00)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, ECEN)
                            Acquire (MUT1, 0xFFFF)
                            Store (ADP, Local0)
                            Release (MUT1)
                            If (LEqual (Arg1, 0x01))
                            {
                                \_TZ.EOFF ()
                            }
                        }
                    }

                    OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                    Field (ERAM, ByteAcc, Lock, Preserve)
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
                        S1D0,   8, 
                        S1D1,   8, 
                        SM2A,   8, 
                        S2D0,   8, 
                        S2D1,   8, 
                        SM3A,   8, 
                        LIDS,   1, 
                        DV1S,   1, 
                        EXFD,   1, 
                        RFSW,   1, 
                            ,   1, 
                        CRTS,   1, 
                        SLPS,   1, 
                        DCKS,   1, 
                        EJBS,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        DV2S,   1, 
                        DV3S,   1, 
                        WK10,   16, 
                        EVTP,   16, 
                        BTM3,   8, 
                        DCID,   8, 
                        DPWR,   1, 
                        UDR0,   1, 
                        UDR5,   1, 
                        EQBF,   1, 
                        LDDS,   1, 
                        CRST,   1, 
                        DCWT,   1, 
                        QVCC,   1, 
                        HP4D,   8, 
                        WAKP,   16, 
                        POLL,   1, 
                        ADP,    1, 
                        ALRT,   1, 
                        B1WE,   1, 
                        B1WS,   1, 
                        B2WE,   1, 
                        B2WS,   1, 
                        BWAK,   1, 
                        PWRE,   1, 
                        ALLB,   1, 
                        AUXB,   1, 
                        S2DR,   1, 
                        F1B4,   1, 
                        F1B5,   1, 
                        F1B6,   1, 
                        RSMA,   1, 
                        S1LD,   1, 
                        S2LD,   1, 
                        ACWR,   1, 
                        PTSV,   3, 
                        PMEE,   1, 
                        ENCB,   1, 
                        F3B0,   1, 
                        F3B1,   1, 
                        RFLD,   1, 
                        F3B3,   1, 
                        SW8B,   1, 
                        WOLE,   1, 
                        WORE,   1, 
                        S4FG,   1, 
                        TMSS,   2, 
                        OSMD,   1, 
                        F4B3,   1, 
                        BANK,   4, 
                        CTMP,   8, 
                        S2DC,   8, 
                        BPD,    8, 
                        BT1I,   16, 
                        BT1C,   16, 
                        BT1V,   16, 
                        BT1S,   8, 
                        Offset (0x60), 
                        TSEC,   8, 
                        TSDN,   8, 
                        Offset (0x63), 
                        Offset (0x64), 
                        Offset (0x65), 
                        Offset (0x66), 
                        Q8CF,   1, 
                            ,   3, 
                        KLED,   1, 
                        Offset (0x67), 
                        TTMP,   8, 
                        HPCB,   8, 
                        R69F,   2, 
                            ,   1, 
                        Offset (0x6A), 
                        BTEC,   8, 
                        UBDM,   4, 
                        UBPC,   3, 
                        Offset (0x6C), 
                        BTCS,   8, 
                        BMDL,   8, 
                        CBDM,   4, 
                        CBPC,   3, 
                        Offset (0x6F), 
                        HP6F,   8, 
                        HP70,   8, 
                        TRDV,   8, 
                        RSMT,   16, 
                        PWSL,   8, 
                        PWSM,   8, 
                            ,   1, 
                        PREF,   1, 
                            ,   1, 
                        UPP1,   1, 
                        UPP2,   1, 
                            ,   1, 
                            ,   1, 
                        BTOF,   1, 
                        SUSB,   1, 
                        SUSC,   1, 
                        CPWR,   1, 
                        CBTN,   1, 
                        FAN,    1, 
                            ,   1, 
                            ,   1, 
                        S4IN,   1, 
                        FANL,   16, 
                        QU7A,   8, 
                        QU7B,   8, 
                        QU7C,   8, 
                        QU7D,   8, 
                        QU7E,   8, 
                        QU7F,   8
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

                    Mutex (CMUT, 0x00)
                    Method (CMC2, 3, NotSerialized)
                    {
                        Acquire (CMUT, 0xFFFF)
                        Store (Arg2, CMD2)
                        Store (Arg1, CMD1)
                        Store (Arg0, CMCM)
                        While (CMCM) {}
                        Release (CMUT)
                    }

                    Mutex (MUT0, 0x00)
                    Mutex (MUT1, 0x00)
                    Method (SMRD, 4, NotSerialized)
                    {
                        If (LNot (ECOK ()))
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

                                PBFE (Local4, Local5, 0x00)
                                Store (Local4, Arg3)
                            }
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (SMWR, 4, NotSerialized)
                    {
                        If (LNot (ECOK ()))
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

                        Release (MUT0)
                        Return (Local0)
                    }

                    Name (ACFL, 0x00)
                    Method (SMSL, 0, NotSerialized)
                    {
                        Store ("CMBatt - SMSL", Debug)
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x14, 0x01, RefOf (Local0))))
                        {
                            Store (Local0, SEL0)
                            Store (SEL0, Debug)
                            If (LEqual (ALRT, 0x01))
                            {
                                \_SB.BAT1.IVBI ()
                                \_SB.BAT1.IVBS ()
                                Store (0x00, ALRT)
                            }

                            Store (\_SB.ACAD.CHAC (SEL0), Local1)
                            Store (\_SB.BAT1.CHBP (SEL0), Local2)
                            Or (SEL0, 0x0FFF, Local0)
                            SMWR (0x08, 0x14, 0x01, Local0)
                            If (LAnd (Local1, \_SB.ACAD.ACP))
                            {
                                Store ("CMBatt - Notify(ACAD,0x80): AC_Inserted", Debug)
                                \_SB.PCI0.ISA.HPSS (0x16, 0x00)
                                Notify (\_SB.ACAD, 0x80)
                                Store (0x02, ACFL)
                            }

                            If (And (0x04, Local2))
                            {
                                \_SB.BAT1.B1CK ()
                            }

                            If (And (0x02, Local2))
                            {
                                \_SB.BAT1.B1ST ()
                            }

                            If (And (0x01, Local2))
                            {
                                \_SB.BAT1.B1IF ()
                            }

                            If (LAnd (Local1, LNot (\_SB.ACAD.ACP)))
                            {
                                Store ("CMBatt - Notify(ACAD, 0x80): AC_Removed", Debug)
                                Notify (\_SB.ACAD, 0x80)
                                Store (0x01, ACFL)
                            }
			    Return(0x00) 
                        }

                        Store (0x3C, Local4)
                        If (\_SB.BAT1.REPT)
                        {
                            Store (0x02, Local4)
                        }

                        If (BFLG)
                        {
                            Store (0x01, Local5)
                            While (LNot (And (BFLG, 0x01)))
                            {
                                Increment (Local5)
                                ShiftRight (BFLG, 0x01, BFLG)
                            }

                            ShiftRight (BFLG, 0x01, BFLG)
                            If (LGreater (Local4, Local5))
                            {
                                Store (Local5, Local4)
                            }
                        }

                        Store (Local4, BPD)
                        BPOL ()
                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        If (ACFL)
                        {
                            Decrement (ACFL)
                            Store (\_SB.PCI0.ISA.HPSS (0x12, ACFL), Local0)
                            CMC2 (0xC4, Local0, 0x82)
                            Notify (HPCI, 0x8A)
                            Store (0x00, ACFL)
                            Store (0x01, \_SB.ACCG)
                            Notify (\_TZ.THRM, 0x80)
                        }
                    }

                    Name (PSTA, 0x00)
                    Method (CPOL, 0, NotSerialized)
                    {
                        If (LEqual (PSTA, 0x00))
                        {
                            If (ECOK ())
                            {
                                BPOL ()
                                Store (0x01, PSTA)
                            }
                        }
                    }

                    Method (BPOL, 0, NotSerialized)
                    {
                        Store (0x01, POLL)
                    }

                    Name (PQ8A, 0x00)
                    Method (_Q09, 0, NotSerialized)
                    {
                        Store ("QUERY_09", Debug)
                        SMSL ()
                    }

                    Method (_Q10, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.ISA.HPCI, 0x90)
                    }

                    Method (_Q11, 0, NotSerialized)
                    {
                        If (ACWR)
                        {
                            Notify (\_SB.PCI0.ISA.HPCI, 0x91)
                        }
                        Else
                        {
                            Notify (\_SB.PCI0.ISA.HPCI, 0x93)
                        }
                    }

                    Method (_Q12, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.ISA.HPCI, 0x92)
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        Store ("QUERY_20", Debug)
                        If (And (SMST, 0x40))
                        {
                            And (SMST, 0xBF, SMST)
                            Store (SMAA, Local0)
                            If (LEqual (Local0, 0x14))
                            {
                                If (PWRE)
                                {
                                    Store ("CMBatt - PwrEvent", Debug)
                                    Store (0x00, PWRE)
                                    Store (0x12, BFLG)
                                    Store (0x00, BPD)
                                    BPOL ()
                                }
                            }
                        }
                    }

                    Method (_Q03, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.AGPB.VGA.DISW, 0x00))
                        {
                            \_SB.PCI0.AGPB.VGA.DRUL (0x01)
                        }
                        Else
                        {
                            If (LEqual (\_SB.PCI0.AGPB.VGA.DISW, 0x01))
                            {
                                \_SB.PCI0.ISA.HPSS (0x01, 0x00)
                            }
                        }
                    }

                    Method (_Q04, 0, NotSerialized)
                    {
                        Store ("Q04 - Fn+F12 Pressed! --- Hibernation ---", Debug)
                        Notify (\_SB.PCI0.ISA.HPCI, 0x86)
                    }

                    Method (_Q0A, 0, NotSerialized)
                    {
                        Store ("Brightness Down: _Q0A", Debug)
                        Store (\_SB.PCI0.ISA.HPSS (0x08, 0x00), Local0)
                        CMC2 (0xC4, Local0, 0x82)
                        Notify (HPCI, 0x8A)
                    }

                    Method (_Q0B, 0, NotSerialized)
                    {
                        Store ("Brightness Up: _Q0B", Debug)
                        Store (\_SB.PCI0.ISA.HPSS (0x08, 0x01), Local0)
                        CMC2 (0xC4, Local0, 0x82)
                        Notify (HPCI, 0x8A)
                    }

                    Method (_Q0C, 0, NotSerialized)
                    {
                        Store ("Brightness Up: _Q0C", Debug)
                        Store (\_SB.PCI0.ISA.HPCI.GFPR (), Local0)
                        Store (Local0, Debug)
                    }

                    Method (_Q80, 0, NotSerialized)
                    {
                        Store ("THERM: _Q80 - Thermal Change", Debug)
                        Store ("Notify _TZ.THRM , 0x80", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Method (_Q8B, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.ISA.HPCI, 0x8B)
                    }

                    Method (_Q8C, 0, NotSerialized)
                    {
                        If (ECOK ())
                        {
                            Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                            Store (TRDV, Local0)
                            Store (Local0, Q8CD)
                            Store (PWSL, Local1)
                            Store (PWSM, Local2)
                            Release (\_SB.PCI0.ISA.EC0.MUT1)
                            Store ("_Q8C:Throttle Duty Cycle :", Debug)
                            Store (Local0, Debug)
                            Store ("Power Consumption Low Byte Value :", Debug)
                            Store (Local1, Debug)
                            Store ("Power Consumption High Byte Value :", Debug)
                            Store (Local2, Debug)
                            Store (0x00, Q8CF)
                            Notify (\_TZ.THRM, 0x80)
                        }
                    }

                    Method (_Q8D, 0, NotSerialized)
                    {
                        Store ("_Q8D:Port Replicator Event :", Debug)
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        Store (PREF, Local0)
                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        If (LEqual (\_SB.PCI0.ISA.POPS, 0x01))
                        {
                            Store (0x01, Local0)
                            Store (0x00, \_SB.PCI0.ISA.POPS)
                        }

                        If (Not (LEqual (\_SB.PRCT, Local0)))
                        {
                            Store (Local0, \_SB.PRCT)
                            Notify (\_SB.PCI0.ISA.SIOD.COM1, 0x01)
                            If (LEqual (\_SB.PRCT, 0x01))
                            {
                                Store (">>> Docking Plug In ! <<<", Debug)
                            }
                            Else
                            {
                                Store (">>> Docking Plug Out ! <<<", Debug)
                            }
                        }
                    }

                    Method (_Q8E, 0, NotSerialized)
                    {
                        SMSL ()
                        Notify (\_SB.BAT1, 0x80)
                    }

                    Method (_Q29, 0, NotSerialized)
                    {
                        Store ("QUERY_29", Debug)
                        If (ECOK ())
                        {
                            If (And (PQ8A, 0x01))
                            {
                                And (PQ8A, Not (0x01), PQ8A)
                                Notify (\_SB.PCI0.ISA.HPCI, 0x86)
                            }
                        }
                    }
                }

                Device (HPCI)
                {
                    Name (_HID, EisaId ("HWPC209"))
                    Name (Z005, 0x00)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (STAT, 1, NotSerialized)
                    {
                        Store (Arg0, Z005)
                    }

                    Method (GKBL, 0, NotSerialized)
                    {
                        Return (0x1B)
                    }

                    Method (GDCP, 0, NotSerialized)
                    {
                        Return (0x0033000F)
                    }

                    Method (GDBT, 0, NotSerialized)
                    {
                        Return (\_SB.PCI0.ISA.HPSS (0x08, 0x10))
                    }

                    Method (SDBT, 1, NotSerialized)
                    {
                        If (ECOK ())
                        {
                            Store (\_SB.PCI0.ISA.HPSS (0x08, Or (0x20, And (Arg0, 0x0F))), Local0)
                            \_SB.PCI0.ISA.EC0.CMC2 (0xC4, Local0, 0x82)
                        }
                    }

                    Method (GADP, 0, NotSerialized)
                    {
                        Return (\_SB.PCI0.ISA.HPSS (0x0F, 0x00))
                    }

                    Method (SADP, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, \_SB.PCI0.AGPB.VGA.LCD._DGS)
                        ShiftRight (And (Arg0, 0x02), 0x01, \_SB.PCI0.AGPB.VGA.CRT._DGS)
                        ShiftRight (And (Arg0, 0x04), 0x02, \_SB.PCI0.AGPB.VGA.TV._DGS)
                        If (LEqual (\_SB.PCI0.AGPB.VGA.DISW, 0x00))
                        {
                            \_SB.PCI0.AGPB.VGA.DRUL (0x04)
                        }
                        Else
                        {
                            If (LEqual (\_SB.PCI0.AGPB.VGA.DISW, 0x01))
                            {
                                HPSS (0x01, 0x00)
                            }
                        }
                    }

                    Method (TGAD, 0, NotSerialized)
                    {
                        \_SB.PCI0.ISA.EC0._Q03 ()
                    }

                    Method (GFPR, 0, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.ISA.PSMX, 0xFFFF)
                        Store (0x80, \_SB.PCI0.ISA.BCMD)
                        Store (0x14, \_SB.PCI0.ISA.DID)
                        Store (Zero, \_SB.PCI0.ISA.SMIC)
                        Store (\_SB.PCI0.ISA.PNLR, Local0)
                        Release (\_SB.PCI0.ISA.PSMX)
                        Return (Local0)
                    }

                    Method (GTVR, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.ISA.HPSS (0x10, 0x00), Local1)
                        If (Local1)
                        {
                            Store (0x02580320, Local0)
                        }
                        Else
                        {
                            Store (0x01E00280, Local0)
                        }

                        Return (Local0)
                    }

                    Method (SRFL, 1, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        If (Arg0)
                        {
                            Store (One, \_SB.PCI0.ISA.EC0.RFLD)
                        }
                        Else
                        {
                            Store (Zero, \_SB.PCI0.ISA.EC0.RFLD)
                        }

                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                    }

                    Method (GRFI, 0, NotSerialized)
                    {
                        Return (0x03)
                    }

                    Method (GSBI, 0, NotSerialized)
                    {
                        Store ("USB\\VID_0A12&PID_0001", Local0)
                        Return (Local0)
                    }

                    Method (GSBS, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            Store (\_SB.PCI0.ISA.HPSS (0x17, 0x00), Local1)
                            If (LEqual (Local1, 0x00))
                            {
                                Return (0x00)
                            }

                            Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                            Store (\_SB.PCI0.ISA.EC0.SW8B, Local0)
                            Release (\_SB.PCI0.ISA.EC0.MUT1)
                            If (LEqual (Local1, 0x02))
                            {
                                If (Local0)
                                {
                                    Return (0x03)
                                }
                                Else
                                {
                                    Return (0x01)
                                }
                            }
                        }
                    }

                    Method (SRFP, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                            If (LEqual (Arg1, 0x01))
                            {
                                Store (One, \_SB.PCI0.ISA.EC0.SW8B)
                            }
                            Else
                            {
                                Store (Zero, \_SB.PCI0.ISA.EC0.SW8B)
                            }

                            Release (\_SB.PCI0.ISA.EC0.MUT1)
                        }
                    }

                    Name (MDLS, 0x03)
                    Name (DEVS, Package (0x09)
                    {
                        "01KT", 
                        "BQ2060", 
                        "4x2", 
                        "02KT", 
                        "BQ2060", 
                        "4x2", 
                        "04KT", 
                        "BQ2060", 
                        "4x2"
                    })
                    Method (GBID, 1, NotSerialized)
                    {
                        Store (0x00, Local0)
                        While (LGreater (MDLS, Local0))
                        {
                            Add (ShiftLeft (Local0, 0x01), Local0, Local1)
                            Store (S2BF (DerefOf (Index (DEVS, Local1))), Local2)
                            If (BCMP (Arg0, Local2))
                            {
                                Return (Local0)
                            }

                            Increment (Local0)
                        }

                        Return (0xFF)
                    }

                    Method (BCMP, 2, NotSerialized)
                    {
                        Store (SizeOf (Arg0), Local0)
                        If (LNot (LEqual (SizeOf (Arg1), Local0)))
                        {
                            Return (Zero)
                        }

                        Store (0x00, Local1)
                        While (LGreater (Local0, Local1))
                        {
                            Store (DerefOf (Index (Arg0, Local1)), Local2)
                            Store (DerefOf (Index (Arg1, Local1)), Local3)
                            If (LNot (LEqual (Local2, Local3)))
                            {
                                Return (Zero)
                            }

                            Increment (Local1)
                        }

                        Return (Ones)
                    }

                    Method (SBDN, 1, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Store (0xFF, \_SB.PCI0.ISA.EC0.BMDL)
                            Store (0x06, \_SB.PCI0.ISA.EC0.BTEC)
                        }
                        Else
                        {
                            Store (Arg0, \_SB.PCI0.ISA.EC0.UBDM)
                            Store (DerefOf (Index (\_SB.BAT1.PBIF, 0x09)), Local0)
                            Store (\_SB.PCI0.ISA.HPCI.GBID (Local0), Local1)
                            Store (Local1, \_SB.PCI0.ISA.EC0.BMDL)
                            If (LEqual (Local1, 0xFF))
                            {
                                Store (0x06, \_SB.PCI0.ISA.EC0.BTEC)
                            }
                        }
                    }

                    Method (GBDN, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (\_SB.PCI0.ISA.EC0.CBDM, Local0)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Method (GBPN, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (And (0x0F, \_SB.PCI0.ISA.EC0.SEL0), Local0)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Method (SBPC, 1, NotSerialized)
                    {
                        If (ECOK ())
                        {
                            Store (Arg0, \_SB.PCI0.ISA.EC0.UBPC)
                        }
                    }

                    Method (GBPC, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (\_SB.PCI0.ISA.EC0.CBPC, Local0)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Method (GBEC, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (\_SB.PCI0.ISA.EC0.BTEC, Local0)
                        Store (0x00, \_SB.PCI0.ISA.EC0.BTEC)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Method (GBCS, 0, NotSerialized)
                    {
                        If (LNot (ECOK ()))
                        {
                            Return (0xFF)
                        }

                        Store (\_SB.PCI0.ISA.EC0.BTCS, Debug)
                        Return (\_SB.PCI0.ISA.EC0.BTCS)
                    }

                    Method (GBSD, 0, NotSerialized)
                    {
                        Name (PBSD, Package (0x08)
                        {
                            "", 
                            "", 
                            "", 
                            "", 
                            "", 
                            0xFFFF, 
                            0xFFFF, 
                            0xFFFF
                        })
                        If (LNot (ECOK ()))
                        {
                            Return (PBSD)
                        }

                        Store (\_SB.PCI0.ISA.EC0.BMDL, Local0)
                        If (LNot (LLess (Local0, MDLS)))
                        {
                            Return (PBSD)
                        }

                        Add (ShiftLeft (Local0, 0x01), Local0, Local0)
                        Store (\_SB.BAT1.PBIF, Local1)
                        Store (DerefOf (Index (Local1, 0x0C)), Index (PBSD, 0x00))
                        Store (DerefOf (Index (DEVS, Add (Local0, 0x01))), Local2)
                        Store (Local2, Index (PBSD, 0x01))
                        Store (DerefOf (Index (DEVS, Local0)), Local2)
                        Store (Local2, Index (PBSD, 0x02))
                        Store (DerefOf (Index (Local1, 0x0B)), Index (PBSD, 0x03))
                        Store (DerefOf (Index (DEVS, Add (Local0, 0x02))), Local2)
                        Store (Local2, Index (PBSD, 0x04))
                        Store (\_SB.BAT1.BATS, Index (PBSD, 0x05))
                        Store (DerefOf (Index (Local1, 0x04)), Index (PBSD, 0x06))
                        Store (DerefOf (Index (Local1, 0x01)), Index (PBSD, 0x07))
                        Store (PBSD, Debug)
                        Return (PBSD)
                    }

                    Method (GBHD, 0, NotSerialized)
                    {
                        Name (DBHD, Package (0x03)
                        {
                            0xFFFF, 
                            0xFFFF, 
                            0xFFFF
                        })
                        If (LNot (ECOK ()))
                        {
                            Return (DBHD)
                        }

                        Store (\_SB.BAT1.PBHD, Local0)
                        Store (Local0, Debug)
                        Return (Local0)
                    }

                    Name (DCNT, 0x00)
                    Method (GBDD, 0, NotSerialized)
                    {
                        Name (PBDD, Package (0x03)
                        {
                            0xFFFF, 
                            0xFFFF, 
                            0xFFFF
                        })
                        If (LNot (ECOK ()))
                        {
                            Return (PBDD)
                        }

                        Increment (DCNT)
                        If (LEqual (DCNT, 0x14))
                        {
                            Store (0x00, DCNT)
                        }

                        Store (\_SB.BAT1.BATI, Index (PBDD, 0x00))
                        If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x16, 0x0F, RefOf (Local5))))
                        {
                            Store (Local5, Index (PBDD, 0x01))
                        }
                        Else
                        {
                            Store (\_SB.BAT1.BATC, Index (PBDD, 0x01))
                        }

                        Store (\_SB.BAT1.BATV, Index (PBDD, 0x02))
                        If (LEqual (DCNT, 0x00))
                        {
                            Store (0x00, \_SB.BAT1.UBHD)
                        }

                        Store (PBDD, Debug)
                        Return (PBDD)
                    }

                    Method (S2BF, 1, Serialized)
                    {
                        Add (SizeOf (Arg0), One, Local0)
                        Name (BUFF, Buffer (Local0) {})
                        Store (Arg0, BUFF)
                        Return (BUFF)
                    }

                    Name (DDA0, Ones)
                    Name (DDA1, Ones)
                    Name (DDA2, Ones)
                    Name (DDA3, Ones)
                    Name (DDA4, Ones)
                    Name (DDA5, Ones)
                    Name (DDA6, Ones)
                    Name (DDA7, Ones)
                    Name (DDA8, Ones)
                    Name (DDA9, Ones)
                }
            }

            Device (PMU)
            {
                Name (_ADR, 0x00110000)
                OperationRegion (PMIO, SystemIO, 0x8000, 0x38)
                Field (PMIO, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x08), 
                    ATMR,   32
                }

                OperationRegion (PMUR, PCI_Config, 0x00, 0xFF)
                Field (PMUR, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x85), 
                        ,   4, 
                        ,   1, 
                    LLOW,   1, 
                    LHGH,   1, 
                    Offset (0x88), 
                        ,   3, 
                    LIDS,   1, 
                    Offset (0x91), 
                        ,   1, 
                    CRTF,   1, 
                    CRTR,   1, 
                    Offset (0x97), 
                        ,   1, 
                    TVC,    1, 
                    FIRC,   1, 
                    COMC,   1, 
                    Offset (0x98), 
                    Z006,   1, 
                    LPTC,   1, 
                        ,   2, 
                    CRTI,   1, 
                    Offset (0xB1), 
                        ,   3, 
                    CRUN,   1, 
                    Offset (0xB5)
                }
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (_PRW, Package (0x02)
            {
                0x03, 
                0x03
            })
            Method (_LID, 0, NotSerialized)
            {
                If (\_SB.ECOK ())
                {
                    If (\_SB.PCI0.PMU.LIDS)
                    {
                        Store (0x00, \_SB.PCI0.PMU.LHGH)
                        Store (0x01, \_SB.PCI0.PMU.LLOW)
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        Store (0x00, \_SB.PCI0.ISA.EC0.KLED)
                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        Return (0x01)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.PMU.LLOW)
                        Store (0x01, \_SB.PCI0.PMU.LHGH)
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        Store (0x01, \_SB.PCI0.ISA.EC0.KLED)
                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        Return (0x00)
                    }
                }
                Else
                {
                    If (\_SB.PCI0.PMU.LIDS)
                    {
                        Store (0x00, \_SB.PCI0.PMU.LHGH)
                        Store (0x01, \_SB.PCI0.PMU.LLOW)
                        Return (0x01)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.PMU.LLOW)
                        Store (0x01, \_SB.PCI0.PMU.LHGH)
                        Return (0x00)
                    }
                }
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
            Method (_PSR, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                Store ("CMBatt - _PSR", Debug)
                \_SB.PCI0.ISA.EC0.CPOL ()
                Store (ACP, Local0)
                If (Local0)
                {
                    Store (0x01, Local1)
                }
                Else
                {
                    Store (0x00, Local1)
                }

                Release (\_SB.PCI0.ISA.EC0.MUT1)
                Store (Local1, \_SB.PCI0.ISA.ACST)
                Return (Local1)
            }

            Method (CHAC, 1, NotSerialized)
            {
                Store (LGreater (And (Arg0, 0xF0), 0x80), Local0)
                If (LNot (LEqual (Local0, ACP)))
                {
                    Store (Local0, ACP)
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Scope (\_TZ)
        {
            Name (TPTM, 0x0CA0)
            Name (TBSE, 0x0AAC)
            Name (PLCY, 0x00)
            Name (TPA0, 0x0CF0)
            Name (TPA1, 0x0D22)
            Name (TPA2, 0x0D36)
            Name (TPAC, 0x0D7C)
            Name (TPAS, 0x0D68)
            Name (TBUF, 0x28)
            Name (PTHS, 0x00)
            Name (TMPS, 0x00)
            Name (Z007, 0x04)
            Name (Z008, 0x04)
            Name (Z009, 0x04)
            Name (Z00A, 0x04)
            Name (Z00B, 0x01)
            Name (Z00C, 0x01)
            Name (Z00D, 0x01)
            Name (WTMP, 0x3F)
            Name (FPOL, 0x00)
            Name (D420, Package (0x0E)
            {
                0x02DA, 
                0x02DA, 
                0x02CD, 
                0x02CE, 
                0x02CF, 
                0x43, 
                0x04, 
                0x04, 
                0x04, 
                0x04, 
                0x01, 
                0x01, 
                0x01, 
                0x43
            })
            Name (D428, Package (0x0E)
            {
                0x02DA, 
                0x02DA, 
                0x02CD, 
                0x02CE, 
                0x02CF, 
                0x43, 
                0x04, 
                0x04, 
                0x04, 
                0x04, 
                0x01, 
                0x01, 
                0x01, 
                0x43
            })
            Name (M430, Package (0x0E)
            {
                0x02DA, 
                0x02DA, 
                0x02CD, 
                0x02CE, 
                0x02CF, 
                0x43, 
                0x04, 
                0x04, 
                0x04, 
                0x04, 
                0x01, 
                0x01, 
                0x01, 
                0x43
            })
            Method (TINI, 0, NotSerialized)
            {
                If (LAnd (LNot (\_SB.PCI0.ISA.PA3G), LNot (\_SB.PCI0.ISA.PCPU)))
                {
                    Store (D428, Local0)
                }
                Else
                {
                    If (\_SB.PCI0.ISA.PCPU)
                    {
                        Store (M430, Local0)
                    }
                    Else
                    {
                        Store (D420, Local0)
                    }
                }

                Store (CTOK (DerefOf (Index (Local0, 0x00))), TPAC)
                Store (CTOK (DerefOf (Index (Local0, 0x01))), TPAS)
                Store (CTOK (DerefOf (Index (Local0, 0x02))), TPA0)
                Store (CTOK (DerefOf (Index (Local0, 0x03))), TPA1)
                Store (CTOK (DerefOf (Index (Local0, 0x04))), TPA2)
                Store (DerefOf (Index (Local0, 0x05)), TBUF)
                Store (DerefOf (Index (Local0, 0x06)), Z007)
                Store (DerefOf (Index (Local0, 0x07)), Z008)
                Store (DerefOf (Index (Local0, 0x08)), Z009)
                Store (DerefOf (Index (Local0, 0x09)), Z00A)
                Store (DerefOf (Index (Local0, 0x0A)), Z00B)
                Store (DerefOf (Index (Local0, 0x0B)), Z00C)
                Store (DerefOf (Index (Local0, 0x0C)), Z00D)
                Store (DerefOf (Index (Local0, 0x0D)), WTMP)
            }

            Method (CTOK, 1, NotSerialized)
            {
                Add (Arg0, 0x0AAC, Local0)
                Return (Local0)
            }

            Method (EOFF, 0, NotSerialized)
            {
                If (\_SB.ECOK ())
                {
                    Store (TPAC, Local0)
                    Store (Add (Divide (Subtract (Local0, TBSE), 0x0A, ), 0x02), \_SB.PCI0.ISA.EC0.TSDN)
                    Store (\_SB.PCI0.ISA.EC0.TRDV, \_SB.Q8CD)
                    Store (0x00, PTHS)
                }
            }

            ThermalZone (THRM)
            {
                Method (_TMP, 0, NotSerialized)
                {
                    If (\_SB.ECOK ())
                    {
                        Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                        Store (\_SB.PCI0.ISA.EC0.CTMP, Local0)
                        If (LAnd (LNot (LLess (Local0, WTMP)), LNot (FPOL)))
                        {
                            Store (0x01, \_SB.PCI0.ISA.EC0.QU7B)
                            Store (0x01, \_SB.PCI0.ISA.EC0.TSEC)
                            Store (0x01, FPOL)
                        }
                        Else
                        {
                            If (LAnd (LLess (Local0, WTMP), FPOL))
                            {
                                Store (0x03, \_SB.PCI0.ISA.EC0.QU7B)
                                Store (0x03, \_SB.PCI0.ISA.EC0.TSEC)
                                Store (0x00, FPOL)
                            }
                        }

                        Release (\_SB.PCI0.ISA.EC0.MUT1)
                        Store ("Current Temperature C is ----------- ", Debug)
                        Store (Local0, Debug)
                        Store (Local0, Local2)
                        Multiply (Local0, 0x0A, Local1)
                        Add (Local1, TBSE, Local0)
                        CHTL (Local0)
                        Return (Local0)
                    }
                    Else
                    {
                        Return (TPTM)
                    }
                }

                Method (CHTL, 1, NotSerialized)
                {
                    Store (Arg0, Local0)
                    If (LLess (Local0, TPA0))
                    {
                        Subtract (TPA0, TBUF, Local2)
                        If (LNot (LGreater (Local0, Local2)))
                        {
                            ETL0 ()
                        }
                        Else
                        {
                            If (LNot (LLess (TMPS, 0x01)))
                            {
                                ETL1 ()
                            }
                            Else
                            {
                                ETL0 ()
                            }
                        }
                    }

                    If (LAnd (LNot (LLess (Local0, TPA0)), LLess (Local0, TPA1)))
                    {
                        Subtract (TPA1, TBUF, Local2)
                        If (LNot (LGreater (Local0, Local2)))
                        {
                            ETL1 ()
                        }
                        Else
                        {
                            If (LNot (LLess (TMPS, 0x02)))
                            {
                                ETL2 ()
                            }
                            Else
                            {
                                ETL1 ()
                            }
                        }
                    }

                    If (LAnd (LNot (LLess (Local0, TPA1)), LLess (Local0, TPA2)))
                    {
                        Subtract (TPA2, TBUF, Local2)
                        If (LNot (LGreater (Local0, Local2)))
                        {
                            ETL2 ()
                        }
                        Else
                        {
                            If (LNot (LLess (TMPS, 0x03)))
                            {
                                ETL3 ()
                            }
                            Else
                            {
                                ETL2 ()
                            }
                        }
                    }

                    If (LNot (LLess (Local0, TPA2)))
                    {
                        ETL3 ()
                    }

                    Store (0x00, \_SB.ACCG)
                }

                Method (ETL0, 0, NotSerialized)
                {
                    Store (0x00, TMPS)
                    If (\_SB.ACAD.ACP)
                    {
                        If (LEqual (\_SB.Q8CD, 0x00))
                        {
                            If (LNot (LEqual (PTHS, 0x00)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x16, 0x00)
                                Store (0x00, PTHS)
                            }
                        }
                        Else
                        {
                            If (LNot (LEqual (PTHS, \_SB.Q8CD)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, \_SB.Q8CD)
                                Store (\_SB.Q8CD, PTHS)
                            }
                        }
                    }
                    Else
                    {
                        If (LOr (LEqual (\_SB.Q8CD, 0x00), LNot (LLess (\_SB.Q8CD, Z00A))))
                        {
                            If (LNot (LEqual (PTHS, Z00A)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, Z00A)
                                Store (Z00A, PTHS)
                            }
                        }
                        Else
                        {
                            If (LNot (LEqual (PTHS, \_SB.Q8CD)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, \_SB.Q8CD)
                                Store (\_SB.Q8CD, PTHS)
                            }
                        }
                    }
                }

                Method (ETL1, 0, NotSerialized)
                {
                    Store (0x01, TMPS)
                    If (\_SB.ACAD.ACP)
                    {
                        If (LOr (LEqual (\_SB.Q8CD, 0x00), LNot (LLess (\_SB.Q8CD, Z007))))
                        {
                            If (LNot (LEqual (PTHS, Z007)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, Z007)
                                Store (Z007, PTHS)
                            }
                        }
                        Else
                        {
                            If (LNot (LEqual (PTHS, \_SB.Q8CD)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, \_SB.Q8CD)
                                Store (\_SB.Q8CD, PTHS)
                            }
                        }
                    }
                    Else
                    {
                        If (LOr (LEqual (\_SB.Q8CD, 0x00), LNot (LLess (\_SB.Q8CD, Z00B))))
                        {
                            If (LNot (LEqual (PTHS, Z00B)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, Z00B)
                                Store (Z00B, PTHS)
                            }
                        }
                        Else
                        {
                            If (LNot (LEqual (PTHS, \_SB.Q8CD)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, \_SB.Q8CD)
                                Store (\_SB.Q8CD, PTHS)
                            }
                        }
                    }
                }

                Method (ETL2, 0, NotSerialized)
                {
                    Store (0x02, TMPS)
                    If (\_SB.ACAD.ACP)
                    {
                        If (LOr (LEqual (\_SB.Q8CD, 0x00), LNot (LLess (\_SB.Q8CD, Z008))))
                        {
                            If (LNot (LEqual (PTHS, Z008)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, Z008)
                                Store (Z008, PTHS)
                            }
                        }
                        Else
                        {
                            If (LNot (LEqual (PTHS, \_SB.Q8CD)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, \_SB.Q8CD)
                                Store (\_SB.Q8CD, PTHS)
                            }
                        }
                    }
                    Else
                    {
                        If (LOr (LEqual (\_SB.Q8CD, 0x00), LNot (LLess (\_SB.Q8CD, Z00C))))
                        {
                            If (LNot (LEqual (PTHS, Z00C)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, Z00C)
                                Store (Z00C, PTHS)
                            }
                        }
                        Else
                        {
                            If (LNot (LEqual (PTHS, \_SB.Q8CD)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, \_SB.Q8CD)
                                Store (\_SB.Q8CD, PTHS)
                            }
                        }
                    }
                }

                Method (ETL3, 0, NotSerialized)
                {
                    Store (0x03, TMPS)
                    If (\_SB.ACAD.ACP)
                    {
                        If (LOr (LEqual (\_SB.Q8CD, 0x00), LNot (LLess (\_SB.Q8CD, Z009))))
                        {
                            If (LNot (LEqual (PTHS, Z009)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, Z009)
                                Store (Z009, PTHS)
                            }
                        }
                        Else
                        {
                            If (LNot (LEqual (PTHS, \_SB.Q8CD)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, \_SB.Q8CD)
                                Store (\_SB.Q8CD, PTHS)
                            }
                        }
                    }
                    Else
                    {
                        If (LOr (LEqual (\_SB.Q8CD, 0x00), LNot (LLess (\_SB.Q8CD, Z00D))))
                        {
                            If (LNot (LEqual (PTHS, Z00D)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, Z00D)
                                Store (Z00D, PTHS)
                            }
                        }
                        Else
                        {
                            If (LNot (LEqual (PTHS, \_SB.Q8CD)))
                            {
                                \_SB.PCI0.ISA.HPSS (0x15, \_SB.Q8CD)
                                Store (\_SB.Q8CD, PTHS)
                            }
                        }
                    }
                }

                Name (_PSL, Package (0x01)
                {
                    \_PR.CPU0
                })
                Name (_TC1, 0x04)
                Name (_TC2, 0x03)
                Name (_TSP, 0x28)
                Method (_CRT, 0, NotSerialized)
                {
                    Return (TPAC)
                }

                Method (_PSV, 0, NotSerialized)
                {
                    Return (TPAS)
                }

                Method (_SCP, 1, NotSerialized)
                {
                    Store (Arg0, PLCY)
                }
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
            Name (UBHD, 0x00)
            Name (BATL, 0x00)
            Name (BATT, 0x00)
            Name (PBHD, Package (0x03)
            {
                0xFFFF, 
                0xFFFF, 
                0xFFFF
            })
            Name (BATI, 0xFFFF)
            Name (BATC, 0xFFFF)
            Name (BATV, 0xFFFF)
            Name (BATS, 0xFFFF)
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0x0B40, 
                0x0B40, 
                0x01, 
                0x39D0, 
                0x012C, 
                0xC8, 
                0x20, 
                0x20, 
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
            Name (UBIF, 0x01E9)
            Name (BP, 0x00)
            Name (REPT, 0x00)
            Name (ERRC, 0x00)
            Method (_STA, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                Store ("CMBatt - _STA.BAT1", Debug)
                \_SB.PCI0.ISA.EC0.CPOL ()
                If (BP)
                {
                    Store (0x1F, Local1)
                }
                Else
                {
                    Store (0x0F, Local1)
                }

                Release (\_SB.PCI0.ISA.EC0.MUT1)
                Return (Local1)
            }

            Method (_BIF, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                Store ("CMBatt - _BIF.BAT1", Debug)
                \_SB.PCI0.ISA.EC0.CPOL ()
                Release (\_SB.PCI0.ISA.EC0.MUT1)
                Return (PBIF)
            }

            Method (_BST, 0, NotSerialized)
            {
                Acquire (\_SB.PCI0.ISA.EC0.MUT1, 0xFFFF)
                Store ("CMBatt - _BST.BAT1", Debug)
                \_SB.PCI0.ISA.EC0.CPOL ()
                Release (\_SB.PCI0.ISA.EC0.MUT1)
                Return (PBST)
            }

            Method (B1CK, 0, NotSerialized)
            {
                Store ("CMBatt - Notify(BAT1,0x81): B1CK", Debug)
                Notify (\_SB.BAT1, 0x81)
            }

            Method (B1ST, 0, NotSerialized)
            {
                Store ("CMBatt - Notify(BAT1,0x80): B1ST", Debug)
                Notify (\_SB.BAT1, 0x80)
            }

            Method (B1IF, 0, NotSerialized)
            {
                Store ("CMBatt - Notify(BAT1,0x81): B1IF", Debug)
                Notify (\_SB.BAT1, 0x81)
            }

            Method (UPBI, 0, NotSerialized)
            {
                Store ("CMBatt - UPBI.BAT1", Debug)
                Store (Zero, Local0)
                If (LNot (ECOK ()))
                {
                    Return (Local0)
                }

                Store (0x0C, Local1)
                Store (Buffer (0x0D)
                    {
                        0x00, 0x18, 0x10, 0x00, 0x19, 0x00, 0x00, 0x00, 
                        0x00, 0x21, 0x00, 0x22, 0x20
                    }, Local2)
                While (LGreater (Local1, 0x08))
                {
                    If (LNot (And (UBIF, VTOB (Local1))))
                    {
                        GBFE (Local2, Local1, RefOf (Local3))
                        If (Local3)
                        {
                            If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x0B, 0x16, Local3, RefOf (Local4))))
                            {
                                Store (\_SB.PCI0.ISA.EC0.BCNT, Local5)
                                Store (Zero, Local3)
                                Store (Zero, ERRC)
                                While (LGreater (Local5, Local3))
                                {
                                    GBFE (Local4, Local3, RefOf (Local6))
                                    Increment (Local3)
                                    If (And (Local6, 0x80))
                                    {
                                        Increment (ERRC)
                                    }
                                }

                                If (LEqual (ERRC, 0x00))
                                {
                                    Store (Local4, Index (PBIF, Local1))
                                    Or (UBIF, VTOB (Local1), UBIF)
                                    Store (Ones, Local0)
                                }
                            }
                        }
                    }

                    Decrement (Local1)
                }

                While (LGreater (Local1, 0x00))
                {
                    If (LNot (And (UBIF, VTOB (Local1))))
                    {
                        GBFE (Local2, Local1, RefOf (Local3))
                        If (Local3)
                        {
                            If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x16, Local3, RefOf (Local5))))
                            {
                                If (LAnd (Local5, LNot (And (Local5, 0x8000))))
                                {
                                    If (LEqual (Local1, 0x02))
                                    {
                                        ShiftRight (Local5, 0x05, Local5)
                                        ShiftLeft (Local5, 0x05, Local5)
                                        ShiftRight (Local5, 0x04, BATL)
                                        Add (BATL, 0x14, BATL)
                                    }

                                    Store (Local5, Index (PBIF, Local1))
                                    Or (UBIF, VTOB (Local1), UBIF)
                                    Store (Ones, Local0)
                                }
                            }
                        }
                    }

                    Decrement (Local1)
                }

                Store (0x0A, Local1)
                If (LNot (And (UBIF, VTOB (Local1))))
                {
                    If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x16, 0x1C, RefOf (Local5))))
                    {
                        Store (Local5, BATS)
                        Store (ITOS (ToBCD (Local5)), Index (PBIF, Local1))
                        Or (UBIF, VTOB (Local1), UBIF)
                        Store (Ones, Local0)
                    }
                }

                Store (PBIF, Debug)
                Return (Local0)
            }

            Method (UPBS, 0, NotSerialized)
            {
                Store ("CMBatt - UPBS.BAT1", Debug)
                Store (Zero, Local0)
                If (LNot (ECOK ()))
                {
                    Return (Local0)
                }

                Store (\_SB.PCI0.ISA.EC0.BT1S, Local5)
                Store (Local5, Local1)
                And (Local5, 0x07, Local5)
                If (LNot (LEqual (Local5, DerefOf (Index (PBST, 0x00)))))
                {
                    Store ("CMBatt - BAT1 STATE CHANGE", Debug)
                    Store (Local1, Debug)
                    Store (Local5, Index (PBST, 0x00))
                    Store (Local5, BATT)
                    Store (Ones, Local0)
                }

                Store (\_SB.PCI0.ISA.EC0.BT1C, Local5)
                If (LNot (And (Local5, 0x8000)))
                {
                    Store (Local5, BATC)
                    ShiftRight (Local5, 0x05, Local5)
                    ShiftLeft (Local5, 0x05, Local5)
                    If (LNot (LEqual (Local5, DerefOf (Index (PBST, 0x02)))))
                    {
                        Store (Local5, Index (PBST, 0x02))
                        Store (Ones, Local0)
                    }

                    If (And (BATT, 0x01))
                    {
                        If (LLess (Local5, BATL))
                        {
                            Or (\_SB.PCI0.ISA.EC0.PQ8A, 0x01, \_SB.PCI0.ISA.EC0.PQ8A)
                            Store (0x0780, \_SB.PCI0.ISA.EC0.HPCB)
                            Store (0x01, \_SB.PCI0.ISA.EC0.ENCB)
                        }
                    }
                }

                Store (\_SB.PCI0.ISA.EC0.BT1V, Local5)
                If (LNot (And (Local5, 0x8000)))
                {
                    Store (Local5, BATV)
                    ShiftRight (Local5, 0x05, Local5)
                    ShiftLeft (Local5, 0x05, Local5)
                    If (LNot (LEqual (Local5, DerefOf (Index (PBST, 0x03)))))
                    {
                        Store (Local5, Index (PBST, 0x03))
                        Store (Ones, Local0)
                    }
                }

                Store (\_SB.PCI0.ISA.EC0.BT1I, Local5)
                Store (Local5, BATI)
                If (And (BATI, 0x8000))
                {
                    Or (BATI, 0xFFFF0000, BATI)
                }

                If (And (Local1, 0x01))
                {
                    Store (\_SB.PCI0.ISA.EC0.BT1V, Local2)
                    If (LEqual (Local2, Zero))
                    {
                        Store (0x39D0, Local2)
                    }

                    Divide (0x01036640, Local2, , Local3)
                    If (And (Local5, 0x8000))
                    {
                        Or (Local5, 0xFFFF0000, Local5)
                        Add (Not (Local5), 0x01, Local5)
                        If (LGreater (Local3, Local5))
                        {
                            Store (Local3, Local5)
                        }
                    }
                    Else
                    {
                        Store (Local3, Local5)
                    }
                }

                If (And (Local1, 0x02))
                {
                    If (And (Local5, 0x8000))
                    {
                        Store (0x00, Local5)
                    }

                    If (LGreater (0x64, Local5))
                    {
                        Store (0x64, Local5)
                    }
                }

                If (LEqual (And (Local1, 0x03), 0x00))
                {
                    Store (0x00, Local5)
                }

                ShiftRight (Local5, 0x05, Local5)
                ShiftLeft (Local5, 0x05, Local5)
                If (LNot (LEqual (Local5, DerefOf (Index (PBST, 0x01)))))
                {
                    Store (Local5, Index (PBST, 0x01))
                    Store (Ones, Local0)
                }

                If (Local0)
                {
                    Store ("CMBATT - PBST Changed", Debug)
                }

                Store (PBST, Debug)
                Return (Local0)
            }

            Method (UPBH, 0, NotSerialized)
            {
                Store ("CMBatt - UPBH.BAT1", Debug)
                Store (Zero, Local0)
                If (LNot (ECOK ()))
                {
                    Return (Local0)
                }

                Store (0x00, Local1)
                Store (Buffer (0x03)
                    {
                        0x17, 0x0C, 0x10
                    }, Local2)
                While (LLess (Local1, 0x03))
                {
                    If (LNot (And (UBHD, VTOB (Local1))))
                    {
                        GBFE (Local2, Local1, RefOf (Local3))
                        If (LNot (\_SB.PCI0.ISA.EC0.SMRD (0x09, 0x16, Local3, RefOf (Local5))))
                        {
                            Store (Local5, Index (PBHD, Local1))
                            Or (UBHD, VTOB (Local1), UBHD)
                            Store (Ones, Local0)
                        }
                    }

                    Increment (Local1)
                }

                Store (PBHD, Debug)
                Return (Local0)
            }

            Method (IVBI, 0, NotSerialized)
            {
                Store (0x01E9, UBIF)
                Store (0x0B40, Index (PBIF, 0x01))
                Store (0x0B40, Index (PBIF, 0x02))
                Store (0x39D0, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("Bad", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
            }

            Method (IVBS, 0, NotSerialized)
            {
                Store (0x00, Index (PBST, 0x00))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (0xFFFFFFFF, Index (PBST, 0x02))
                Store (0x39D0, Index (PBST, 0x03))
            }

            Method (IVBH, 0, NotSerialized)
            {
                Store (0x00, UBHD)
                Store (0xFFFF, Index (PBHD, 0x00))
                Store (0xFFFF, Index (PBHD, 0x01))
                Store (0xFFFF, Index (PBHD, 0x02))
            }

            Method (CHBP, 1, NotSerialized)
            {
                Store ("CMBatt - CHBP.BAT1", Debug)
                Store (Zero, Local0)
                If (LNot (ECOK ()))
                {
                    Return (Local0)
                }

                Store (VTOB (Subtract (_UID, 0x01)), Local1)
                Or (ShiftLeft (Local1, 0x0C), 0x0FFF, Local2)
                Store (Zero, Local3)
                If (And (Arg0, Local1))
                {
                    If (BP)
                    {
                        Store ("CMBatt - BAT1 still present", Debug)
                        \_SB.PCI0.ISA.EC0.SMWR (0x08, 0x14, 0x01, Local2)
                        \_SB.PCI0.ISA.EC0.SMRD (0x09, 0x14, 0x01, RefOf (Local3))
                        If (LEqual (Local2, Or (Local3, 0x0FFF)))
                        {
                            If (UPBI ())
                            {
                                Or (0x01, Local0, Local0)
                            }

                            If (UPBS ())
                            {
                                Or (0x02, Local0, Local0)
                            }

                            UPBH ()
                        }
                    }
                    Else
                    {
                        Store ("CMBatt - BAT1 connected", Debug)
                        \_SB.PCI0.ISA.EC0.SMWR (0x08, 0x14, 0x01, Local2)
                        \_SB.PCI0.ISA.EC0.SMRD (0x09, 0x14, 0x01, RefOf (Local3))
                        If (LEqual (Local2, Or (Local3, 0x0FFF)))
                        {
                            UPBI ()
                            UPBS ()
                            UPBH ()
                        }

                        Store (0x01, BP)
                        Or (0x05, Local0, Local0)
                    }
                }
                Else
                {
                    If (BP)
                    {
                        Store ("CMBatt - BAT1 disconnected", Debug)
                        Store (0x00, BP)
                        IVBI ()
                        IVBS ()
                        IVBH ()
                        Or (0x04, Local0, Local0)
                    }
                }

                If (LAnd (And (Arg0, Local1), LNot (LEqual (UBIF, 0x1FFF))))
                {
                    Store (0x01, REPT)
                }
                Else
                {
                    Store (0x00, REPT)
                }

                Return (Local0)
            }
        }
    }

    Method (_PTS, 1, NotSerialized)
    {
        Add (Arg0, 0x50, Local0)
        Store (Local0, P80H)
        If (LEqual (Arg0, 0x01)) {}
        If (LEqual (Arg0, 0x03))
        {
            If (\_SB.ECOK ())
            {
                Store (0x01, \_SB.PCI0.ISA.EC0.WORE)
            }

            Store (0x00, \_SB.PCI0.PMU.LLOW)
            Store (0x01, \_SB.PCI0.PMU.LHGH)
            \_SB.PCI0.ISA.Z000 (0x00)
            Add (Arg0, 0x51, Local0)
        }

        If (LEqual (Arg0, 0x04))
        {
            If (\_SB.ECOK ())
            {
                Store (0x01, \_SB.PCI0.ISA.EC0.S4FG)
                Store (0x00, \_SB.PCI0.ISA.EC0.WORE)
            }

            \_SB.PCI0.ISA.Z000 (0x03)
        }

        If (LEqual (Arg0, 0x05))
        {
            If (\_SB.ECOK ())
            {
                Store (0x00, \_SB.PCI0.ISA.EC0.WORE)
                If (\_SB.PCI0.ISA.WOLE)
                {
                    Store (0x01, \_SB.PCI0.ISA.EC0.WOLE)
                }
                Else
                {
                    Store (0x00, \_SB.PCI0.ISA.EC0.WOLE)
                }
            }
        }

        If (LEqual (Arg0, 0x05))
        {
            \_SB.PCI0.ISA.Z000 (0x02)
            Sleep (0x07D0)
            Store (0x01, \_SB.PCI0.ISA.Z002)
        }
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (0x58, P80H)
        Store (0x01, \_SB.PCI0.AGPB.VGA.VRSM)
        If (\_SB.ECOK ())
        {
            Store (\_SB.PCI0.ISA.HPSS (0x08, 0x11), Local0)
            \_SB.PCI0.ISA.EC0.CMC2 (0xC4, Local0, 0x82)
            \_TZ.EOFF ()
            Notify (\_TZ.THRM, 0x80)
        }

        If (LEqual (Arg0, 0x01)) {}
        If (LEqual (Arg0, 0x03))
        {
            Store (0x01, \_SB.PCI0.ISA.KBC0.KBS3)
            If (\_SB.PCI0.PMU.LIDS)
            {
                Store (0x00, \_SB.PCI0.PMU.LHGH)
                Store (0x01, \_SB.PCI0.PMU.LLOW)
            }
            Else
            {
                Store (0x00, \_SB.PCI0.PMU.LLOW)
                Store (0x01, \_SB.PCI0.PMU.LHGH)
            }

            \_SB.PCI0.ISA.Z000 (0x01)
            If (\_SB.ECOK ())
            {
                Store (0x00, \_SB.PCI0.ISA.EC0.PWRE)
                Store (0x12, \_SB.PCI0.ISA.EC0.BFLG)
                Store (0x01, \_SB.PCI0.ISA.EC0.BPD)
                \_SB.PCI0.ISA.EC0.BPOL ()
            }
        }

        If (LEqual (Arg0, 0x04))
        {
            Notify (\_SB.PWRB, 0x02)
        }

        If (LEqual (Arg0, 0x05)) {}
        If (\_SB.PCI0.PMU.CRTI)
        {
            Store (0x00, \_SB.PCI0.PMU.CRTR)
            Store (0x01, \_SB.PCI0.PMU.CRTF)
        }
        Else
        {
            Store (0x00, \_SB.PCI0.PMU.CRTF)
            Store (0x01, \_SB.PCI0.PMU.CRTR)
        }
	Return(Package(0x02){0x00, 0x00})
    }

    Scope (\_SI)
    {
        Method (_SST, 1, NotSerialized)
        {
            If (LEqual (Arg0, 0x01)) {}
            If (LEqual (Arg0, 0x02)) {}
            If (LEqual (Arg0, 0x03)) {}
            If (LEqual (Arg0, 0x04)) {}
        }
    }

    Scope (_GPE)
    {
        Method (_L03, 0, NotSerialized)
        {
            Notify (\_SB.LID, 0x80)
        }

        Method (_L09, 0, NotSerialized)
        {
            Notify (\_SB.PCI0, 0x02)
            Sleep (0x01F4)
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L0A, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.MDEM, 0x02)
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L0D, 0, NotSerialized)
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L23, 0, NotSerialized)
        {
            Notify (\_TZ.THRM, 0x80)
        }

        Method (_L24, 0, NotSerialized)
        {
            Sleep (0x01F4)
            If (\_SB.PCI0.PMU.CRTI)
            {
                Store (0x00, \_SB.PCI0.PMU.CRTR)
                Store (0x01, \_SB.PCI0.PMU.CRTF)
            }
            Else
            {
                Store (0x00, \_SB.PCI0.PMU.CRTF)
                Store (0x01, \_SB.PCI0.PMU.CRTR)
            }

            \_SB.PCI0.AGPB.VGA.DRUL (0x02)
        }
    }
}


--=-BIVw+RwixH9qZLhMAP6M--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
