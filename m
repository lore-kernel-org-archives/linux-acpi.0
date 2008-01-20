From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output - FSC AMILO Pi 1536
Date: Sun, 20 Jan 2008 14:19:20 -0500
Message-ID: <200801201419.20652.lenb@kernel.org>
References: <469D1DD1.6080704@dottout.com> <200801181904.51226.lenb@kernel.org> <4791AE8D.6090303@dottout.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36541 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060AbYATTTj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:19:39 -0500
In-Reply-To: <4791AE8D.6090303@dottout.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrea Rizzolo <andrea@dottout.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 03:02, Andrea Rizzolo wrote:
> Len Brown wrote:
> > On Tuesday 17 July 2007 15:51, andrea wrote:
> >    
> >> ystem Information
> >>          Manufacturer: FUJITSU SIEMENS
> >>          Product Name: AMILO Pi 1536
> >>          Version: Not Applicable
> >>          Serial Number: 5311F9B6
> >>          UUID: 00D5D495-CD63-0010-8C63-99E512DA426C
> >>          Wake-up Type: Power Switch
> >>          SKU Number: Not Specified
> >>          Family: Not Specified
> >>
> >> Handle 0x0002, DMI type 2, 8 bytes
> >> Base Board Information
> >>          Manufacturer: FUJITSU SIEMENS
> >>          Product Name: AMILO Pi 1536
> >>      
> >
> > Do you notice any functional difference when booting with
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
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
> >    
> Since kernel 2.6.23 my acpi works way better: fan is less noisy (really 
> a lot) Currently Im running zen-sources, a patchset which applies to git 
> kernel. so, running latest acpi code, dmesg still complains about 
> acpi_osi but it gives more output:
> ACPI: _OSI(Linux) requested by unknown system BIOS
> 1. FUJITSU SIEMENS
> 3. 07/19/2007
> 4. FUJITSU SIEMENS
> 5. AMILO Pi 1536
> 6. Not Applicable
> 10. AMILO Pi 1536
> ACPI: Please send DMI info above to linux-acpi@vger.kernel.org

ah, good.  This message replaces the request for dmidecode output.
It will go away when I update the entry, because ...

the ASL for this box shows that OSI(Linux) is a NOP.

-Len

           Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
                }

                If (_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    Store (0x07D1, OSYS)
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    Store (0x07D2, OSYS)
                }

                If (_OSI ("Windows 2006"))
                {
                    Store (0x07D6, OSYS)
                }

                If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
                {
                    TRAP (0x3D)
                }
            }

