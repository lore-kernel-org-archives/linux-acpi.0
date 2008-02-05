From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI DMI Dell R200
Date: Tue, 5 Feb 2008 14:20:27 -0500
Message-ID: <200802051420.27503.lenb@kernel.org>
References: <47A63D17.9070203@norm.lu> <200802040045.42996.lenb@kernel.org> <47A714DD.5040703@norm.lu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56462 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbYBETko (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2008 14:40:44 -0500
In-Reply-To: <47A714DD.5040703@norm.lu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Georges Toth <georges@norm.lu>, shaohua.li@intel.com, venkatesh.pallipadi@intel.com
Cc: linux-acpi@vger.kernel.org

On Monday 04 February 2008 08:36, Georges Toth wrote:
> Len Brown wrote:
> >> ACPI: BIOS _OSI(Linux) query ignored
> >> ACPI: DMI System Vendor: Dell Inc.
> >> ACPI: DMI Product Name: PowerEdge R200
> >> ACPI: DMI Product Version:
> >> ACPI: DMI Board Name: 0TY019
> >> ACPI: DMI BIOS Vendor: Dell Inc.
> >> ACPI: DMI BIOS Date: 10/24/2007
> >> ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
> > 
> > thanks, please send me the output from acpidump.
> 
> I've attached it
> Let me know if you need anything else
> 

This DSDT shows that Dell BIOS writers know enough to be dangerous.

It appears that the BIOS writer put in special tests for (Vistal or Linux),
not realizing that Linux always sets Vista.

OSI(Linux) is a NOP on this box.
it will exchange the PNPid of the PCIe/PCI HID/CID, but nothing else.

It is interesting to see that PNP0C01 motherboard device is present only for OS's
earlier than XP.

It is also interseting that the SSDT has a special test for Vista,
to enable fixed-feature P-state access, but that code would have
run even without that test.

thanks,
-Len


        Name (TOOS, 0x00)
        Method (INIC, 0, NotSerialized)
        {

            If (CondRefOf (_OSI, Local0))
            {
                If (\_OSI ("Windows 2001"))
                {
                    Store (0x05, TOOS)
                }

                If (\_OSI ("Windows 2001.1"))
                {
                    Store (0x06, TOOS)
                }

                If (\_OSI ("Windows 2001.1 SP1"))
                {
                    Store (0x07, TOOS)
                }

                If (\_OSI ("Windows 2006"))
                {
                    Store (0x08, TOOS)
                }

                If (\_OSI ("Windows 2006.1"))
                {
                    Store (0x08, TOOS)
                }

# OSI(Linux) overwrites TOOS with 1

                If (\_OSI ("Linux"))
                {
                    Store (0x01, TOOS)
                }
            }
            Else
            {
                Store (\_OS, Local0)
                Store (SCMP (Local0, "Microsoft Windows NT"), Local1)
                If (Not (Local1))
                {
                    Store (0x04, TOOS)
                }
                Else
                {
                    Store (SCMP (Local0, "Microsoft Windows"), Local2)
                    If (Not (Local2))
                    {
                        Store (0x02, TOOS)
                    }
                    Else
                    {
                        Store (SCMP (Local0, "Microsoft WindowsME:Millennium Edition"), Local3)
                        If (Not (Local3))
                        {
                            Store (0x03, TOOS)
                        }
                    }
                }
            }
        Method (_INI, 0, NotSerialized)
        {
            \_SB.INIC ()
            \_SB.INIS ()
        }
...
        Method (INIS, 0, NotSerialized)
        {
            Store ("Method _INI", Debug)
            If (LNotEqual (RIST, 0x00))
            {
                Store (0xFFFFFFFF, \_SB.PCI0.SBE0.PXHA._ADR)
                Store (0x00, \_SB.PCI0.SBE0.PXHA._STA)
            }

            If (LGreaterEqual (\_SB.TOOS, 0x08))
            {
# Vista gets _PCI0 _HID and _CID exchanged
# to put PCIe as _HID and PCI as _CID

                Store (0x080AD041, \_SB.PCI0._HID)
                Store (0x030AD041, \_SB.PCI0._CID)
            }
            Else
            {
                Store (0x030AD041, \_SB.PCI0._HID)
                Store (0x080AD041, \_SB.PCI0._CID)
            }
        }
       Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08"))
            Name (_CID, 0x030AD041)
...


                Device (NIPM)
                {
                    Name (_HID, EisaId ("IPI0001"))
                    Name (_CID, 0x010CD041)
                    Name (_UID, 0x05)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (TOOS, 0x01))
                        {
                            Return (0x0F)
# this is effectively a special test for Linux,
# but it is a NOP because of the test below
# I dont' knwo what IPI0001 is...

                        }
                        Else
                        {
                            If (LOr (LEqual (TOOS, 0x07), LEqual (TOOS, 0x08)))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }
                    }


...
                Device (MBI1)
                {
                    Name (_HID, EisaId ("PNP0C01"))
# motherboard device
                    Name (_UID, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LOr (LEqual (TOOS, 0x08), LEqual (TOOS, 0x01)))
                        {
# if Vista or Linux
                            Return (0x00)
                        }
                        Else
                        {
                            If (LEqual (TOOS, 0x07))
                            {
# XP SP1
                                Return (0x00)
                            }
                            Else
                            {
# everything else does see motherboard device
                                Return (0x0F)
                            }
                        }
                    }
                   Method (_CRS, 0, NotSerialized)
                    {
                        Name (SBDB, ResourceTemplate ()
                        {
                            IO (Decode16,
                                0x0800,             // Range Minimum
                                0x0800,             // Range Maximum
                                0x01,               // Alignment
                                0x80,               // Length
                                )
                            IO (Decode16,
                                0x0880,             // Range Minimum
                                0x0880,             // Range Maximum
                                0x01,               // Alignment
                                0x40,               // Length
                                )
                            IO (Decode16,
                                0x08C0,             // Range Minimum
                                0x08C0,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            IO (Decode16,
                                0x08E0,             // Range Minimum
                                0x08E0,             // Range Maximum
                                0x01,               // Alignment
                                0x04,               // Length
                                )
                            IO (Decode16,
                                0x0900,             // Range Minimum
                                0x0900,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                            IO (Decode16,
                                0x0C00,             // Range Minimum
                                0x0C00,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            IO (Decode16,
                                0x0C10,             // Range Minimum
                                0x0C10,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            IO (Decode16,
                                0x0CA0,             // Range Minimum
                                0x0CA0,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0CA9,             // Range Minimum
                                0x0CA9,             // Range Maximum
                                0x01,               // Alignment
                                0x03,               // Length
                                )
                           IO (Decode16,
                                0x0CAD,             // Range Minimum
                                0x0CAD,             // Range Maximum
                                0x01,               // Alignment
                                0x03,               // Length
                                )
                            IO (Decode16,
                                0x0C20,             // Range Minimum
                                0x0C20,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            IO (Decode16,
                                0x0060,             // Range Minimum
                                0x0060,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                _Y08)
                            IO (Decode16,
                                0x0064,             // Range Minimum
                                0x0064,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                _Y09)
                        })
                        CreateByteField (SBDB, \_SB.PCI0.ISA.MBIO._CRS._Y08._LEN, KBL1)
                        CreateByteField (SBDB, \_SB.PCI0.ISA.MBIO._CRS._Y09._LEN, KBL2)
                        If (LOr (GCKB (), GCMS ()))
                        {
                            Store (Zero, KBL1)
                            Store (Zero, KBL2)
                        }

                        Return (SBDB)
                    }
                }

in SSDT1:

   Scope (_PR.CPU1)
    {
        Method (_PPC, 0, NotSerialized)
        {
            Return (Zero)
        }

        Method (_PCT, 0, NotSerialized)
        {

# if PDC[9] && CFGD != x4000, use MSR for P-states
# Linux comes here
            If (LAnd (LNot (And (CFGD, 0x4000)), LEqual (And (PDC0,
                0x09), 0x09)))
            {
                Return (Package (0x02)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW,
                            0x40,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000199, // Address
                            ,)
                    },

                    ResourceTemplate ()
                    {
                        Register (FFixedHW,
                            0x10,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000198, // Address
                            ,)
                    }
                })
            }

# if PDC[9] && Vista, use MSR for P-states

            If (LAnd (LEqual (And (PDC0, 0x09), 0x09), LGreaterEqual (
                \_SB.TOOS, 0x08)))
            {
                Return (Package (0x02)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW,
                            0x40,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000199, // Address
                            ,)
                    },

                    ResourceTemplate ()
                    {
                        Register (FFixedHW,
                            0x10,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000198, // Address
                            ,)
                    }
                })
            }

# else use IO for P-states

           Return (Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO,
                        0x10,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000000008E0, // Address
                        ,)
                },

                ResourceTemplate ()
                {
                    Register (SystemIO,
                        0x10,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000000008E2, // Address
                        ,)
                }
            })
        }

        Method (_PSS, 0, NotSerialized)
        {
            If (LAnd (LNot (And (CFGD, 0x4000)), LEqual (And (PDC0,
                0x09), 0x09)))
            {
                Return (NPSS)
            }

            If (LAnd (LEqual (And (PDC0, 0x09), 0x09), LGreaterEqual (
                \_SB.TOOS, 0x08)))
            {
                Return (NPSS)
            }
# same test as in _PCT, -- MSR accesses gets NPSS (latency 10usec)
# while IO access gets SPSS (latecy 160usec)

            Return (SPSS)
        }
        Name (SPSS, Package (0x02)
        {
            Package (0x06)
            {
                0x0000091D,
                0x00019258,
                0x000000A0,
                0x0000000A,
                0x00000726,
                0x00000726
            },

            Package (0x06)
            {
                0x000007D0,
                0x0000FDE8,
                0x000000A0,
                0x0000000A,
                0x00000614,
                0x00000614
            }
        })
        Name (NPSS, Package (0x02)
        {
            Package (0x06)
            {
                0x0000091D,
                0x00019258,
                0x0000000A,
                0x0000000A,
                0x00000726,
                0x00000726
            },

            Package (0x06)
            {
                0x000007D0,
                0x0000FDE8,
                0x0000000A,
                0x0000000A,
                0x00000614,
                0x00000614
            }
        })
    }

in SSDT3: 
    Scope (\)
    {
        Name (CFGD, 0x00000002)

# CFGD is defined as 2, but never changed

        Name (PDC0, 0x80000000)
        Name (PDC1, 0x80000000)
        Name (PDC2, 0x80000000)
        Name (PDC3, 0x80000000)
    }

