From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (acpi_osi=!Linux)=?utf-8?q?=09?= (MacBookPro2,2)
Date: Fri, 18 Jan 2008 17:55:53 -0500
Message-ID: <200801181755.53894.lenb@kernel.org>
References: <200707011439.23511.a.biardi@tiscali.it> <200707020304.58932.lenb@kernel.org> <200707020925.30573.a.biardi@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44981 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139AbYARW4J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 17:56:09 -0500
In-Reply-To: <200707020925.30573.a.biardi@tiscali.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: a.biardi@tiscali.it
Cc: linux-acpi@vger.kernel.org

On Monday 02 July 2007 05:25, a.biardi@tiscali.it wrote:
> On Monday 02 July 2007, you wrote:
> 
> > On Sunday 01 July 2007 10:39, a.biardi@tiscali.it wrote:
> > > Upon booting 2.6.22-rc6, the kernel says:
> > >
> > > Initializing Device/Processor/Thermal objects by executing _INI
> > > methods:<4>ACPI: System BIOS is requesting _OSI(Linux)
> > > ACPI: Please test with "acpi_osi=!Linux"
> > > Please send dmidecode to linux-acpi@vger.kernel.org
> > >
> > > so, attached is the dmidecode for my macbook pro (core2 duo)
> > >
> > > let me know if you need further information
> >
> > Yes, does it run differently with "acpi_osi=!Linux"?
> > Can you send me the output from acpidump?
> >
> > thanks,
> > -Len
> 
> attached: acpidump (20061130) and dmesg (same kernel, booting with and 
> without "acpi_osi=!Linux").
> 
> I didn't notice any different behaviour booting 
> with "acpi_osi=!Linux"; also tried suspend to ram, and it seems to 
> work.
> 
> for the record, I have had *no* acpi-related problems at all, since at 
> least 2.6.19, up to and including 2.6.22-rc6.
> 
> thanks for your time, keep up the great work

	Manufacturer: Apple Computer, Inc.
	Product Name: MacBookPro2,2


Thanks for the acpidump.

While the DSDT does check for Linux:

        Method (_INI, 0, NotSerialized)
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
                        Store (0x07D1, OSYS)
                    }
                }
            }
            Else
            {
                Store (0x07D0, OSYS)
            }

            Store (0x35, SMIF)
            Store (0x00, TRP0)
        }

OSYS isn't really used much, except to see if the HPET should be in the GUI:

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
                            _Y16)
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
                                Return (0x0B)
                            }
                        }

                        Return (0x00)
                    }


More significant is that if acpi_osi=Darwin,
you'll trigger a bunch of Apple hooks via "OSDW" that do who knows what...


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

cheers,
-Len

