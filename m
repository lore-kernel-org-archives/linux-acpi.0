From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output HP DV2320US laptop
Date: Sat, 19 Jan 2008 01:10:53 -0500
Message-ID: <200801190110.53613.lenb@kernel.org>
References: <200712290837.25509.greg@gallensanders.org> <200801181551.09207.lenb@kernel.org> <200801182042.06353.greg@gallensanders.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60987 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbYASGLI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 01:11:08 -0500
In-Reply-To: <200801182042.06353.greg@gallensanders.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: greg@gallensanders.org
Cc: linux-acpi@vger.kernel.org

On Friday 18 January 2008 22:42, Greg Sanders wrote:
> Len,
> 
> I tried the acpi_osi thing briefly, but didn't notice any difference, so I 
> took it out.  After getting your email, I put it back and ran the acpidump 
> utility.  (got it by apt-get)
> 
> The output is attached.
>...
> On Friday - January 18, 2008 13:51:09 you wrote:
> > O
> >
> > > Handle 0x0001, DMI type 1, 27 bytes
> > > System Information
> > >         Manufacturer: Hewlett-Packard
> > >         Product Name: HP Pavilion dv2000 (RV323UA#ABA)
> > >         Version: F.34
> > >         Serial Number: 2CE7171BDY
> > >         UUID: 1501AA80-F433-11DB-9D1A-9EE3B10D875F
> > >         Wake-up Type: Power Switch
> > >         SKU Number: RV323UA#ABA
> > >         Family: 103C_5335KV
> >
> > With 2.6.22, did you notice any functional difference with
> > "acpi_osi=!Linux"?
> >
> > (or since the default changed at 2.6.23, with 2.6.23 or later
> >  do you notice any difference with "acpi_osi=Linux"?)

thanks for the acpidump.

            Store (0x07D0, OSYS)
            If (CondRefOf (\_OSI, Local0))
            {
                If (\_OSI ("Linux"))
                {
                    Store (0x01, LINX)
                }

    Name (\OSYS, 0x00)
    Name (\LINX, 0x00)
    Name (\PPCM, 0x00)

And LINX is otherwise not referenced, so I'll add this box to the NOP DMI list.

thanks,
-Len
