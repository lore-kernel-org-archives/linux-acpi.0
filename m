From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (Samsung R40plus)
Date: Mon, 21 Jan 2008 00:05:21 -0500
Message-ID: <200801210005.22146.lenb@kernel.org>
References: <200712282201.42665.ulrich.ivens@gmx.de> <200801181618.51124.lenb@kernel.org> <200801191843.03458.ulrich.ivens@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36905 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbYAUFFk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 00:05:40 -0500
In-Reply-To: <200801191843.03458.ulrich.ivens@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ulrich Ivens <ulrich.ivens@gmx.de>
Cc: linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com

On Saturday 19 January 2008 12:43, Ulrich Ivens wrote:
> Am Freitag 18 Januar 2008 22:18:50 schrieben Sie:
> > > Handle 0x0001, DMI type 1, 27 bytes
> > > System Information
> > >         Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
> > >         Product Name: R40P/R41P
> > >         Version: 01YE
> > >         Serial Number: 987V93CP300020
> > >         UUID: 609A7519-D21D-B211-8000-C10FFE3A9BBA
> > >         Wake-up Type: Power Switch
> > >         SKU Number: Not Specified
> > >         Family: Not Specified
> >
> > With 2.6.22, did you notice any functional difference with
> > "acpi_osi=!Linux"?
> 
> No, no significant changes happened.
> 
> 
> > (or since the default changed at 2.6.23, with 2.6.23 or later
> >  do you notice any difference with "acpi_osi=Linux"?)
> 
> It's still the Kernel 2.6.22 with ubuntu linux.  
> 
> > Please send me the output from acpidump.
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php
> >
> > thanks,
> > -Len
> 
> I tried three things for you:
> 
> I set the menu.lst Parameters in kernel line explicit to 
> 1. acpi_osi=!Linux, 
> 2. acpi_osi=Linux
> 3. nothing
> 
> Each time I made an acpidump like you told me. I attached them to the mail. I 
> also added one output from dmesg. 

thanks for the acpidump.
I wouldn't expect it to change for each case, though curiously,
some bits inside the HPET table did change.

Venki, should I be concerned about the "Hardware Block ID"?

<  * Disassembly of HPET.dat, Sun Jan 20 19:41:11 2008
---
>  * Disassembly of HPET.dat, Sun Jan 20 19:40:40 2008
15c15
< [009h 009  1]                     Checksum : 8B
---
> [009h 009  1]                     Checksum : 9A
22c22
< [024h 036  4]            Hardware Block ID : 43538310
---
> [024h 036  4]            Hardware Block ID : 43538301
39c39
<   0000: 48 50 45 54 38 00 00 00 01 8B 50 54 4C 54 44 20  HPET8.....PTLTD
---
>   0000: 48 50 45 54 38 00 00 00 01 9A 50 54 4C 54 44 20  HPET8.....PTLTD
41c41
<   0020: 01 00 00 00 10 83 53 43 00 08 00 00 00 00 D0 FE  ......SC........
---
>   0020: 01 00 00 00 01 83 53 43 00 08 00 00 00 00 D0 FE  ......SC........

> Greetings from Heinsberg, Germany 
> 
> Ulli
> 
>  

Re: OSI(Linux)
       Method (OSTP, 0, NotSerialized)
# OSTP return value is never checked
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

                   If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)
# LINX is a NOP here, since it is never referenced
                        Store (0x80, ^OSTB)
# there are quite a few references to OSTB == x40 (Vista)
# which will be disabled by OSI(Linux), 
# including code under the RTC, PNP0100 timer, PNP0C32 button
# PNP0103 HPET


                        Store (0x80, ^TPOS)
# TPOS is only compared against 4 (NT)
                    }


So I I think it is not a good idea to enable OSI(Linux) on this box.
For it enables nothing, and disables hooks for Vista and newer.

It would be interesting if you notice any difference in the dmesg
with and without acpi_osi=Linux in 2.6.24-rc -- particularly any
messages about the timers.

-Len

