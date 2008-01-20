From: Len Brown <lenb@kernel.org>
Subject: Re: IT SAID " Please send dmidecode to linux-acpi@vger.kernel.org" ... - Toshiba Satellite A210
Date: Sun, 20 Jan 2008 14:50:46 -0500
Message-ID: <200801201450.46664.lenb@kernel.org>
References: <473F2D96.8040305@praxisarzt.de> <200801181718.09891.lenb@kernel.org> <4791DCB2.6010802@praxisarzt.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49121 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbYATTvF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:51:05 -0500
In-Reply-To: <4791DCB2.6010802@praxisarzt.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "W. Conrad GP" <conrad@praxisarzt.de>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 06:19, W. Conrad GP wrote:
> Dear Len,
> 
> 
> I remember sending this mail  because an error message popped up and 
> asked me to do so but I am at loss what it was all about since so many 
> things happend since then and everything has been up to my satisfaction 
> with Ubuntu Gutsy Gibbon on this notebook.
> 
> 
> In order to answer the question "With 2.6.22, did you notice any 
> functional difference with "acpi_osi=!Linux"?" you would have to tell me 
> where this parameter was set. Sorry.
> 
> 
> The acpi dumps the following on a
> 
> 
> Linux conport 2.6.23-coney #1 SMP Sat Nov 17 15:48:15 CET 2007 x86_64 
> GNU/Linux
> 
> 
>             (  ... a lot of boring data following a hope it's of help, 
> if there is anything else I can do, instruct me.
> 
> 

I'm glad to hear that 2.6.23 is working well for you.
With kernel 2.6.23 or later, please append "acpi_osi=Linux" to the boot command line
to see if that has any change with and without.

Others Toshiba models had sound issues with acpi_osi=Linux,
so you might confirm that works in both cases.
Your box may potentially have an issue with SATA power states --
which you might notice when you suspend or hibernate.
(below)

thanks,
-Len

> 
> > On Saturday 17 November 2007 13:06, W. Conrad GP wrote:
> >   
> >>         Manufacturer: TOSHIBA
> >>         Product Name: Satellite A210
> >>     
> >
> > With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?
> >
> > (or since the default changed at 2.6.23, with 2.6.23 or later
> >  do you notice any difference with "acpi_osi=Linux"?)
> >

thanks for the acpidump output.
       Name (LINX, 0x00)
        Name (OSTB, Ones)
        OperationRegion (OSTY, SystemMemory, 0x37E83F04, 0x00000001)
        Field (OSTY, AnyAcc, NoLock, Preserve)
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
...
                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)
                        Store (0x80, ^OSTB)
                        Store (0x80, ^TPOS)
                    }
...
            Return (^OSTB)
        }


LINX is set, but not referenced.
OSTB is compared to 4 only, (win NT or later)
TPOS is compared to 0x40 later (Vista) in the SATA wakeup ASL
so OSI(Linux) will change that.

                   Method (_PS0, 0, NotSerialized)
                    {
                        If (LEqual (TPOS, 0x40))
                        {
                            Store (0x32, Local0)
                            While (LAnd (LEqual (\_SB.PCI0.SATA.PMBY, 0x01), Local0))
                            {
                                Sleep (0xFA)
                                Decrement (Local0)
                            }
                        }

                        Store (0x00, PRIS)
                    }

OSTP() is invoked in various places, but its return value is never checked.

