From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - HP Pavilion dv9000
Date: Sun, 3 Feb 2008 14:04:02 -0500
Message-ID: <200802031404.02883.lenb@kernel.org>
References: <1191918635.6457.4.camel@fourmile> <200801182325.52584.lenb@kernel.org> <b1bc5edc0801240220r7976e968j5b93d6cffb18e35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33332 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbYBCTET (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Feb 2008 14:04:19 -0500
In-Reply-To: <b1bc5edc0801240220r7976e968j5b93d6cffb18e35@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marco De Felice <m.defel@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 24 January 2008 05:20, Marco De Felice wrote:
> On 2008/1/19, Len Brown <lenb@kernel.org> wrote:
> >
> > On Tuesday 09 October 2007 04:30, Marco De Felice wrote:
> > > System Information
> > > Manufacturer: Hewlett-Packard
> > > Product Name: HP Pavilion dv9000 (RR109EA#ABZ)
> > > Version: Rev 1
> > > Serial Number: CNF6510ZHG
> > > UUID: 434E4636-3531-305A-4847-001636C68701
> > > Wake-up Type: Power Switch
> > > SKU Number: RR109EA#ABZ
> > > Family: 103C_5335KV
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > > Manufacturer: Quanta
> > > Product Name: 30B9
> >
> >
> > Thanks for the dmidecode output.
> >
> > Do you notice any functional difference when booting with
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> >
> > In particular, please try out sound in both cases.
> >
> > Also, please send me the output from acpidump.
> >
> 
> Thanks to you
> At the time I sent the dmidecode output i was on a 32 bit linux kernel and
> in fact I had to boot with the option acpi_osi="!Linux" (I'm sorry but I
> don't remember where the boot hanged without this option, it could be that
> it was a video driver problem).
> Now I'm on a x86_64 2.6.22-14-rt kernel (the distro being Ubuntu Studio 7.10)
> and I have to boot with "noapic" option and the acpi_osi has no effect at
> all, sound is always ok.
> If I boot without "noapic", again regardless of the acpi_osi option the boot
> process hangs at "[*] Loading hardware drivers"
> I'm sending also a new dmidecode because hp released a new bios.
> 
> Please don't hesitate to ask whatever further test you need, also including
> installing a different kernel/distribution.

Thanks for the acpidump.

The ASL below confirms your observation that with this version of the BIOS,
OSI(Linux) is a NOP for the HP dv9000, for OSYS is immediately overwritten
after it is first set.

I don't know what the issue is with the IOAPIC.
It is hard to believe that HP, Quanta, and AMD
intend that box to run in PIC mode, since it is multi-core.
(insert plug for Intel chipsets here:-)

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
