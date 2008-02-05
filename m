From: Len Brown <lenb@kernel.org>
Subject: Re: MAcBook Pro DMI info - MacBookPro3,1
Date: Tue, 5 Feb 2008 14:40:23 -0500
Message-ID: <200802051440.23568.lenb@kernel.org>
References: <20080131081821.89030@gmx.net> <200802051322.31624.lenb@kernel.org> <20080205185811.62790@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56471 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbYBETku (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2008 14:40:50 -0500
In-Reply-To: <20080205185811.62790@gmx.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: der flooh <derflooh@gmx.de>, linux-acpi@vger.kernel.org


> > On Thursday 31 January 2008 03:18, der flooh wrote:
> > > Jan 31 08:40:41 elm ACPI: DMI System Vendor: Apple Inc.
...
> > 
> > > Jan 31 08:40:41 elm ACPI: DMI Product Name: MacBookPro3,1
> > > Jan 31 08:40:41 elm ACPI: DMI Product Version: 1.0
> > > Jan 31 08:40:41 elm ACPI: DMI Board Name: Mac-F4238BC8
> > > Jan 31 08:40:41 elm ACPI: DMI BIOS Vendor: Apple Inc.
> > > Jan 31 08:40:41 elm ACPI: DMI BIOS Date: 09/26/07

Thanks for the acpidump.
Apple has added new code BIOS to test OSYS.

But it looks like a NOP for Linux.

I also looks like the Apple BIOS programmers don't
realize that Windows 2006 returns true for OSI(Windows 2001).
But since they test OSYS only against 0x7D1 and the Darwin
value, that bug isn't noticed yet.

cheers,
-Len

    Method (PINI, 0, NotSerialized)
    {
        If (CondRefOf (_OSI, Local0))
        {
            If (_OSI ("Darwin"))
            {
                Store (0x2710, OSYS)
            }
            Else
            {
                If (_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
                }
                Else
                {
                    If (_OSI ("Windows 2001"))
                    {
                        Store (0x07D1, OSYS)
                    }
                    Else
                    {
                        If (_OSI ("Windows 2001 SP1"))
                        {
                            Store (0x07D1, OSYS)
                        }
                        Else
                        {
                            If (_OSI ("Windows 2001 SP2"))
                            {
                                Store (0x07D2, OSYS)
                            }
                            Else
                            {
                                If (_OSI ("Windows 2006"))
                                {
                                    Store (0x07D6, OSYS)
                                }
                            }
                        }
                    }
                }
            }
        }
        Else
        {
            Store (0x07D0, OSYS)
        }
    }

Re: OSYS use

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (_CID, 0x010CD041)
                    Name (BUF0, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {0}
                        IRQNoFlags ()
                            {8}
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y1B)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LGreaterEqual (OSYS, 0x07D1))
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
# Linux will come here,
# but it doesn't matter, because we don't look at the GUI bits in _STA anyway...

                                Return (0x0B)
                            }
                        }

                        Return (0x00)
                    }
...
# the test for Darwin:

    Method (OSDW, 0, NotSerialized)
    {
        If (LEqual (OSYS, 0x2710))
        {
            Return (0x01)
        }
        Else
        {
            Return (0x00)
        }
    }

