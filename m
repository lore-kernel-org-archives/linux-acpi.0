From: Len Brown <lenb@kernel.org>
Subject: Re: Dell Inspiron 1501 - dmidecode
Date: Mon, 21 Jan 2008 00:32:19 -0500
Message-ID: <200801210032.19509.lenb@kernel.org>
References: <469CB083.10101@tiscali.it> <200801181903.04953.lenb@kernel.org> <4792B528.7080902@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56219 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbYAUFch (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 00:32:37 -0500
In-Reply-To: <4792B528.7080902@tiscali.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dario Castellarin <dacstp@tiscali.it>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 21:42, Dario Castellarin wrote:
> Len Brown ha scritto:
> > On Tuesday 17 July 2007 08:05, Dario Castellarin wrote:
> >   
> >> BIOS Information
> >>        Vendor: Dell Inc.
> >>        Version: 2.4.1    
> >>        Release Date: 05/30/2006
> >>     

> >> System Information
> >>         Manufacturer: Dell Inc.
> >>         Product Name: Inspiron 1501 
> >>         Version: Not Specified                   
> >>         Serial Number: 5NYFM2J
> >>         UUID: 44454C4C-4E00-1059-8046-B5C04F4D324A
> >>         Wake-up Type: Power Switch
> >>         SKU Number: Not Specified
> >>         Family: Not Specified
> >>
> >> Handle 0x0003, DMI type 2, 8 bytes.
> >> Base Board Information
> >>         Manufacturer: Dell Inc.
> >>         Product Name: 0UW744?????? 

heh, after your BIOS upgrade Dell fixed the issue above
by clearing the Board Product Name field:-)

  BIOS Information
        Vendor: Dell Inc.
        Version: 2.6.3
        Release Date: 12/07/2007
        Address: 0xE5860
        Runtime Size: 108448 bytes
        ROM Size: 1024 kB
...

Handle 0x0002, DMI type 1, 27 bytes.
System Information
        Manufacturer: Dell Inc.
        Product Name: Inspiron 1501
        Version: Not Specified
        Serial Number:
        UUID: 44454C4C-2000-1020-8020-A0C04F202020
        Wake-up Type: Power Switch
        SKU Number: Not Specified
        Family: Not Specified

Handle 0x0003, DMI type 2, 8 bytes.
Base Board Information
        Manufacturer: Dell Inc.
        Product Name:

> >
> > (curious if you added the '?'s above, or did Dell?,
> >  they are not there on earlier versions of this BIOS)
> >
> > Thanks for confirming that
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> >
> > had no functional difference on the 1501.
> >
> > please send me the output from acpidump.
> >
> > thanks,
> > -Len
> >
> > ps
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php
> >   
> No, I didn't add anything to that dmidecode dump.
> Sorry but in the meanwhile I upgraded the BIOS to the latest offered by 
> Dell (version 2.6.3), many things changed, anyway I attached a new 
> dmidecode dump, and also an acpidump.
> I wish this can be useful...

acpi_osi=Linux is a NOP on this box.

thanks,
-Len

   Scope (\_SB)
    {
        Name (LINX, 0x00)
        Name (OSTB, Ones)
        OperationRegion (OSTY, SystemMemory, 0x37E80F06, 0x00000001)
        Field (OSTY, AnyAcc, NoLock, Preserve)
# return value of OSTY is never checked
        {
            TPOS,   8
        }

        Method (OSTP, 0, NotSerialized)
        {
            If (LEqual (^OSTB, Ones))
            {
                If (CondRefOf (\_OSI, Local0))
                {
                    Store (0x00, ^OSTB)
                    Store (0x00, ^TPOS)
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x08, ^OSTB)
                        Store (0x08, ^TPOS)
                    }
...
                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)
# setting LINX is a NOP, as it is never referenced
                        Store (0x80, ^OSTB)
# OSTB is only compard to 4 (NT), so OSI(Linux) doen't affect that
                        Store (0x80, ^TPOS)
# TPOS is only compared to 4 (NT), so we have no effect on that either
n
                    }
