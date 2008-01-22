From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for acer aspire 5052 laptop
Date: Mon, 21 Jan 2008 22:45:34 -0500
Message-ID: <200801212245.34299.lenb@kernel.org>
References: <d8d1b9d10801190430r106a5fa6w94cb5191061201d4@mail.gmail.com> <200801201850.21464.lenb@kernel.org> <d8d1b9d10801210949r132b4f72o1753311b72882d41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41679 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbYAVDpr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 22:45:47 -0500
In-Reply-To: <d8d1b9d10801210949r132b4f72o1753311b72882d41@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Artem Goncharov <artem.goncharov@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Monday 21 January 2008 12:49, Artem Goncharov wrote:
> On Jan 21, 2008 1:50 AM, Len Brown <lenb@kernel.org> wrote:
> > On Saturday 19 January 2008 09:58, Artem Goncharov wrote:
> > > Hi. For my laptop using acpi_osi=Linux seems to be working better, but
> > > I'm not completely sure in that.
> > >
> > >
> > > What I don't like is the following cut from /var/log/messages
> > >
> > > >Jan 19 14:19:09 blending kernel: PCI: MSI quirk detected. MSI deactivated.
> > > >Jan 19 14:19:09 blending kernel: assign_interrupt_mode Found MSI capability
> > > >Jan 19 14:19:10 blending kernel:last message repeated 3 times
> > > >Jan 19 14:19:09 blending kernel: pci_hotplug: PCI Hot Plug PCI Core
> > > version: 0.5
> > > >Jan 19 14:19:09 blending kernel: ACPI Exception
> > > (processor_core-0819): AE_NOT_FOUND, Processor Device is not present
> > > [20070126]
> >
> > if this one happens with latest 2.6.24-rc,
> > then please file a bug and attch your acpidump output here:
> > http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> >
> 
> Unfortunately I didn't have a chance to test it with latest kernel (it
> happens with 2.6.23-9)
> 
> > >
> > > That is true in both cases (with and without acpi_osi=Linux option.
> > >
> > >
> > > However I'm attaching dmidecode for my laptop.
> > >
> > >
> > >
> > > P.S.
> > > >Jan 19 14:19:09 blending kernel: ACPI: System BIOS is requesting _OSI(Linux)
> > >
> > >
> > >
> > > # dmidecode 2.7
> > > SMBIOS 2.4 present.
> > > 35 structures occupying 1106 bytes.
> > > Table at 0x000F1790.
> > >
> > > Handle 0x0000, DMI type 0, 24 bytes.
> > > BIOS Information
> > > Vendor: Acer
> > > Version: v1.3303
> > > Release Date: 01/23/07
> > > Address: 0xE5230
> > > Runtime Size: 110032 bytes
> > > ROM Size: 1024 kB
> > > Characteristics:
> > ...
> > >
> > > Handle 0x0001, DMI type 1, 27 bytes.
> > > System Information
> > > Manufacturer: Acer, inc.
> > > Product Name: Aspire 5050
> > > Version: Not Applicable
> > > Serial Number: LXAV40Y0867120E60B2502
> > > UUID: C09465D5-4F87-D811-BCCB-001B240E64F7
> > > Wake-up Type: Power Switch
> > > SKU Number: Not Specified
> > > Family: Not Specified
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes.
> > > Base Board Information
> > > Manufacturer: Acer, Inc.
> > > Product Name: Prespa M
> >

thanks for the acpidump.  Like others in the Aspire 5050 family,
there is a possible interraction between OSI(Linux) and SATA
that is because OSI(Linux) disables the test for Vista.

If you notice any difference with SATA between acpi_osi=Linux
and acpi_osi=!Linux, please let me know.

thanks,
-Len


                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)	# a NOP, like other Acers
                        Store (0x80, ^OSTB)	# no effect, like other Acers
                        Store (0x80, ^TPOS)	# touches SATA _PS0
                    }

---
                Device (PRID)
                {
                    Name (_ADR, 0x00)
                    Name (SPTM, Buffer (0x14)
                    {
                        /* 0000 */    0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
                        /* 0008 */    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                        /* 0010 */    0x13, 0x00, 0x00, 0x00
                    })
                    Method (_GTM, 0, NotSerialized)
                    {
                        Return (SPTM)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, SPTM)
                    }

                    Name (S12P, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        If (LEqual (TPOS, 0x40))
                        {
# this is the "if vista" case (similar code for other SATA targets)
# OSI(Linux) would disable this
                            Store (0x28, Local0)
                            OperationRegion (SAI1, SystemIO, P3F4, 0x04)
                            Field (SAI1, ByteAcc, NoLock, Preserve)
                            {
                                        Offset (0x01),
                                    ,   7,
                                BSY0,   1
                            }

                            While (LAnd (LEqual (BSY0, 0x01), Local0))
                            {
                                Store (Local0, DBGP)
                                Sleep (0xFA)
                                Decrement (Local0)
                            }
                        }

                        Store (0x00, S12P)
                    }
...
