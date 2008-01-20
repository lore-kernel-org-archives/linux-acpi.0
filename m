From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for Sony Vaio VGN-SZ650NC
Date: Sun, 20 Jan 2008 18:36:45 -0500
Message-ID: <200801201836.45800.lenb@kernel.org>
References: <4752C941.90801@doube.net> <200801181656.27771.lenb@kernel.org> <47920876.1030002@doube.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41398 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098AbYATXhA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 18:37:00 -0500
In-Reply-To: <47920876.1030002@doube.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Doube <michael@doube.net>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 09:25, Michael Doube wrote:
> 
> Len Brown wrote:
> > On Sunday 02 December 2007 10:03, Michael Doube wrote:
> >   
> >>         Manufacturer: Sony Corporation
> >>         Product Name: VGN-SZ650N
> >>     
> >
> > With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?
> >   
> No - what sort of changes should I look for?
> > (or since the default changed at 2.6.23, with 2.6.23 or later
> >  do you notice any difference with "acpi_osi=Linux"?)
> >
> > Please send me the output from acpidump.
> >   
> attached...

thanks for the acpidump output.

OSI(Linux) is a NOP on this box b/c LINX is never referenced after it is written.

-Len

    OperationRegion (GNVS, SystemMemory, 0xBF6CAA37, 0x0100)
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
...
   Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)
        {
            If (DTSE)
            {
                TRAP (0x47)
            }

            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (One, LINX)
                }

                If (_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }
...
