From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode 2.9 (Samsung R59P/R60P/R61P)
Date: Mon, 21 Jan 2008 23:28:57 -0500
Message-ID: <200801212328.57118.lenb@kernel.org>
References: <4780BE66.8050605@gmx.de> <200801201833.35026.lenb@kernel.org> <4794F88F.4050604@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47520 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755AbYAVE3M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 23:29:12 -0500
In-Reply-To: <4794F88F.4050604@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Becker <zorak1103@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Monday 21 January 2008 14:54, Stefan Becker wrote:
...
> 
> meanwhile i did some testing. these are some of my observations:
> 
> sometimes:
> - booting is lightning fast (< 25 seconds)
> - booting is dead slow (>> 60 seconds), have to press a key to continue
> 
> always:
> - poweroff or reboot not working (no shutdown)
> - no problem setting system clock (as opposed to 'select() to /dev/rtc 
> to wait for clock tick timed out' when starting with 'nolapic_timer 
> usbcore autosuspend=1 noapic'

thanks for the acpidump.
Like others, there is no special support for Linux here,
but setting OSI(Linux) will disable a bunch of hooks
that were put in for Vista.

So we should disable OSI(Linux) on this box unless
proof of incompatibility with the Vista BIOS hooks emerges.

thanks
-Len

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX) # a no-op
                        Store (0x80, ^OSTB)
                        Store (0x80, ^TPOS)
                    }

# OSTB != x40 will change PCI initialization below:

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08"))
            Name (_CID, 0x030AD041)
            Name (_ADR, 0x00)
            Name (_UID, 0x01)
            Name (_BBN, 0x00)
            Method (_INI, 0, NotSerialized)
            {
                If (DTSE)
                {
                    DTSF (0x47)
                }

                \_SB.OSTP ()
                If (LGreaterEqual (TPOS, 0x04))
                {
                    Store (Zero, \_SB.PCI0.SMB.C4C3)
                    Store (0x49, \_SB.PCI0.LPC0.BCMD)
                    Store (0x01, \_SB.PCI0.LPC0.DID)
                    Store (0x00, \_SB.PCI0.LPC0.SMIC)
                }

                If (LEqual (\_SB.OSTB, 0x40))
                {
                    \_SB.PCI0.LPC0.PHS1 (0xA9, 0x01)
                }
                Else
                {
                    \_SB.PCI0.LPC0.PHS1 (0xA9, 0x00)
                }
            }

# OSTB != 40 will touch display brightness:

                        Method (_BCM, 1, NotSerialized)
                        {
                            Store (Arg0, BRTL)
                            If (LGreaterEqual (\_SB.OSTB, 0x40))
                            {
                                \_SB.PCI0.LPC0.PHS (0xA6)
                            }
                        }

# OSTB != 40 touches the RTC:

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (RCB0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {8}
                    })
                    Name (RCB1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        If (LEqual (\_SB.OSTB, 0x40))
                        {
                            If (LEqual (\_SB.PCI0.SMB.GHPT (), 0xFED00000))
                            {
                                Return (RCB1)
                            }
                        }

                        Return (RCB0)
                    }
                }

...
OSTB != 40 will disable the new button hooks:

                    Device (MBTN)
                    {
                        Name (_HID, EisaId ("PNP0C32"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (\_SB.OSTB, 0x40))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (GHID, 0, NotSerialized)
                        {
                            If (DMED)
                            {
                                Notify (MBTN, 0x02)
                            }

                            Return (Buffer (0x01)
                            {
                                0x01
                            })
                        }
                    }


...
OSTB != x40 changes _WAK
        If (LEqual (\_SB.OSTB, 0x40))
        {
            Store (\_SB.PCI0.LPC0.PHS1 (0xAA, 0x00), Local1)
            If (Local1)
            {
                Notify (\_SB.PCI0.LPC0.H_EC.MBTN, 0x02)
            }
        }

        If (LEqual (\_SB.OSTB, 0x40))
        {
            \_SB.PCI0.LPC0.PHS1 (0xA9, 0x01)
        }
        Else
        {
            \_SB.PCI0.LPC0.PHS1 (0xA9, 0x00)
        }

# TPOS != 40 changes SATA:
                   Method (_PS0, 0, NotSerialized)
                    {
                        GBAA ()
                        If (LAnd (LOr (LEqual (TPOS, 0x40), LEqual (TPOS, 0x04)), \_SB.PCI0.SATA.B5EN))
                        {
                            If (\_SB.PCI0.SATA.PMS1)
                            {
                                Store (0x32, Local0)
                                While (LAnd (LEqual (\_SB.PCI0.SATA.PMBY, 0x01), Local0))
                                {
                                    Sleep (0xFA)
                                    Decrement (Local0)
                                }
                            }

                            If (\_SB.PCI0.SATA.PSS1)
                            {
                                Store (0x32, Local0)
                                While (LAnd (LEqual (\_SB.PCI0.SATA.PSBY, 0x01), Local0))
                                {
                                    Sleep (0xFA)
                                    Decrement (Local0)
                                }
                            }
                        }

                        Store (0x00, PRIS)
                    }

