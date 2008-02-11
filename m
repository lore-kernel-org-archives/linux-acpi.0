From: Len Brown <lenb@kernel.org>
Subject: Re: Please send dmidecode to linux-acpi@vger.kernel.org - Acer Extensa 5220
Date: Sun, 10 Feb 2008 21:08:54 -0500
Message-ID: <200802102108.55052.lenb@kernel.org>
References: <e678b6ed0802061215n38a1b38eu22fe150e18bb920d@mail.gmail.com> <200802072349.58324.lenb@kernel.org> <e678b6ed0802080433x7fad7155t42f58e6b26888823@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50197 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbYBKCJJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Feb 2008 21:09:09 -0500
In-Reply-To: <e678b6ed0802080433x7fad7155t42f58e6b26888823@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dennis Jansen <d.g.jansen@googlemail.com>
Cc: linux-acpi@vger.kernel.org

On Friday 08 February 2008 07:33, Dennis Jansen wrote:
> Glad I can help.
> 
> On Feb 8, 2008 5:49 AM, Len Brown <lenb@kernel.org> wrote:
> > please send me the output from acpidump.
> >
> > thanks,
> > -Len
> >
> >         Manufacturer: Acer
> >         Product Name: Extensa 5220

Thanks for the acpidump.
OSI(Linux) appears to be a NOP in this version of the BIOS.
It sets LINX, but nothing (in AML) ever reads it.

-Len


            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x01, LINX)
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
            }

            If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
            {
                TRAP (0x3D)
            }

            TRAP (0x2B)
            TRAP (0x32)
        }
    }

    OperationRegion (GNVS, SystemMemory, 0x7F6DFDBC, 0x0100)
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
