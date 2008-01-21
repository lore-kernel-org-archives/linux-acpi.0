From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - HP dv6000 30B8 (dv6276eu)
Date: Sun, 20 Jan 2008 19:27:59 -0500
Message-ID: <200801201927.59528.lenb@kernel.org>
References: <134ef2900711041501s4c753808hba0e253d9e0785ff@mail.gmail.com> <200801190011.17684.lenb@kernel.org> <134ef2900801190814t3192207cx3b5912b9336ee2bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55512 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754514AbYAUA2Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 19:28:16 -0500
In-Reply-To: <134ef2900801190814t3192207cx3b5912b9336ee2bf@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dimitri Michaux <dimitri.michaux@gmail.com>
Cc: linux-acpi@vger.kernel.org

> > > System Information
> > > Manufacturer: Hewlett-Packard
> > > Product Name:
> > > Version: Rev 1
> > > Serial Number:
> > > UUID: Not Settable
> > > Wake-up Type: Power Switch
> > > SKU Number:
> > > Family: 103C_5335KV
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > > Manufacturer: Quanta
> > > Product Name: 30B8
> >
> > Is this a production BIOS?
> > It is unusual to have no "Product Name" above.
> > What name is on the sticker on the box -- something
> > from the Pavilion dv6000 family?
> >
> > Thanks for the dmidecode output.
> >
> > Do you notice any functional difference when booting with...
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> >
> > ...in particular, please check sound, wifi, and hibernate.
> >
> > Also, please send me the output from acpidump.
> >
> > thanks,
> > -Len
> >
> > ps
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php
> >
> 
On Saturday 19 January 2008 11:14, Dimitri Michaux wrote:
> Hey,
> 
> I had a hardware failure with this laptop and they had to replace the
> motherboard, luckily HP didn't complain about me running Linux on the
> laptop, but now dmidecode give's a different output (see attachment).
> 
> > Is this a production BIOS?
> > It is unusual to have no "Product Name" above.
> > What name is on the sticker on the box -- something
> > from the Pavilion dv6000 family?

> It's a dv6276eu

Heh, the new dmidecode says this:

BIOS Information
        Vendor: Hewlett-Packard
        Version: F.3B
        Release Date: 10/02/2007
        Address: 0xE6A30
        Runtime Size: 103888 bytes
        ROM Size: 1024 kB
 ...

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Hewlett-Packard
        Product Name: HP Pqvilion dv6000 (RY606EQ#UUG)
        Version: Rev 1
        Serial Number: CNF7092FC7
        UUID: 434E4637-3039-3246-4337-001B24E59B82
        Wake-up Type: Power Switch
        SKU Number: RY606EQ#UUG
        Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: Quanta
        Product Name: 30B8
-----------
so it is still a Quanta 30B8 board.

Humerous that they mis-spelled the product name -- but
no matter -- it became clear very quickly that I can't key off the
product names on HP boxes b/c they are semi-random strings.
so I'm keying off of the board name (30B8).


> When I need to boot with acpi_osi, do I still need to use
> acpi_os_name="Windows 2006"?

No, you should never have to use acpi_os_name= under any conditions.
On this particular box, the BIOS doesn't check _OS contents anyway,
so any setting you use would be a NOP.

re: acpi_osi=Linux ...

It is a NOP also, for in the code below, OSYS
is over-written by the Windows values no matter
if the Linux value is set or not.

thanks,
-Len

       Device (PCI0)
        {
            Name (_ADR, 0x00)
            Name (_HID, EisaId ("PNP0A03"))
            Name (_UID, 0x01)
            Method (_INI, 0, NotSerialized)
            {
                Store (0x07D0, OSYS)
                If (CondRefOf (_OSI, Local0))
                {
                    If (\_OSI ("Linux"))
                    {
                        Store (0x03E8, OSYS)
                    }

                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x07D1, OSYS)
                    }

                    If (\_OSI ("Windows 2001 SP1"))
                    {
                        Store (0x07D1, OSYS)
                    }

                    If (\_OSI ("Windows 2001 SP2"))
                    {
                        Store (0x07D2, OSYS)
                    }

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x07D6, OSYS)
                    }
                }
            }

