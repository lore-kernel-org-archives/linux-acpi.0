From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode from HP Pavilion DV6373EA
Date: Sun, 20 Jan 2008 14:30:00 -0500
Message-ID: <200801201430.00400.lenb@kernel.org>
References: <472DF8F4.1050205@inwind.it> <200801190007.10524.lenb@kernel.org> <4791D86D.1090406@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59860 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755227AbYATTaT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:30:19 -0500
In-Reply-To: <4791D86D.1090406@inwind.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mirco Miranda <mircomir@inwind.it>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 06:01, Mirco Miranda wrote:
> Hi Len,
> 
> Len Brown ha scritto:
> >   
> > Thanks for the dmidecode output.
> > Do you notice any functional difference when booting with...
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> >
> > ...in particular, please check sound, wifi, and hibernate.
> >   
> 
> I'm using K2.6.23. Sound and wifi works fine like 2.6.22; i'm not using
> hibernate, only suspend to ram (works fine).
> The big difference that I see from k2.6.22 is the  LCD backlight
> setting: with K2.6.23 works! :)

Thanks for the acpidump, it shows that OSI(Linux)
is a NOP on this box, as LINX is set but never referenced.

-Len

                If (CondRefOf (_OSI, Local0))
                {
                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)
                    }
...
    OperationRegion (GNVS, SystemMemory, 0x3FE84DBC, 0x0100)
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
        LIDS,   8,
        PWRS,   8,
        DBGS,   8,
        LINX,   8,
                Offset (0x14),
