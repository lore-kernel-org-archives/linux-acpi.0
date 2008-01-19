From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output for a Sony Vaio TZ21MN
Date: Sat, 19 Jan 2008 01:16:40 -0500
Message-ID: <200801190116.41066.lenb@kernel.org>
References: <200712270018.25131.theboywho@ruddyperl.com> <200801181627.00108.lenb@kernel.org> <200801190012.19564.theboywho@ruddyperl.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49771 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbYASGRA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 01:17:00 -0500
In-Reply-To: <200801190012.19564.theboywho@ruddyperl.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Parminder Singh Dhillon <theboywho@ruddyperl.com>
Cc: linux-acpi@vger.kernel.org

On Friday 18 January 2008 19:12, you wrote:
> On Friday 18 January 2008 21:26:59 Len Brown wrote:
> > System Information
> > 	Manufacturer: Sony Corporation
> > 	Product Name: VGN-TZ21MN_N
> > 	Version: J002RMWG
> >
> >
> > With 2.6.22, did you notice any functional difference with
> > "acpi_osi=!Linux"?
> 
> I haven't tried this with 2.6.22
> 
> >
> > (or since the default changed at 2.6.23, with 2.6.23 or later
> >  do you notice any difference with "acpi_osi=Linux"?)
> 
> I am now running my 2.6.23 kernel with acpi_osi=Linux. I have not noticed any 
> difference. Is there anything in particular I should look for?

sound, wifi, same /proc/acpi/thermal_zone contents (w/ changing temperature), hibernate etc.

it looks from your DSDT that this option should have no effect,
but somebody with a DSDT like yours claimed to see a thermal difference.

thanks,
-Len
            If (CondRefOf (\_OSI, Local0))
            {
                If (\_OSI ("Linux"))
                {
                    Store (0x01, LINX)
...
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16,
        SMIF,   8,
        PRM0,   8,
        PRM1,   8,
        SCIF,   8,
        PRM2,   8,
        PRM3,   8,
        LCKF,   8,
        PRM4,   8,
        PRM5,   8,
        P80D,   32,
                Offset (0x10),
                Offset (0x11),
        DBGS,   8,
        LINX,   8,
                Offset (0x14),

