From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output (MacBook2,1)
Date: Mon, 21 Jan 2008 00:14:51 -0500
Message-ID: <200801210014.51716.lenb@kernel.org>
References: <46BD3881.50106@ubuntu.com> <200801182125.11838.lenb@kernel.org> <9dbd3d650801191224r1f5dc024l373d6f6048959be0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50160 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757880AbYAUFPI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 00:15:08 -0500
In-Reply-To: <9dbd3d650801191224r1f5dc024l373d6f6048959be0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christer Edwards <christer.edwards@ubuntu.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 15:24, Christer Edwards wrote:
> On Jan 18, 2008 7:25 PM, Len Brown <lenb@kernel.org> wrote:
> > Thanks for the dmidecode output.
> >
> > Do you notice any functional difference when booting with
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> 
> I have not yet had a chance to try these values at boot, but I've
> attached acpidump.

No testing necessary, the acpudump shows that this box
is like other Apples -- it basically tells the difference
between Darwin and other - and treats Linux and Windows the same.
So if we set OSI(Linux) or not doesn't make any difference.

thanks,
-Len
---
     Method (_INI, 0, NotSerialized)
        {
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Darwin"))
                {
                    Store (0x2710, OSYS)
                }
                Else
                {
                    If (_OSI ("Linux"))
                    {
                        Store (0x03E8, OSYS)
                    }
                    Else
                    {
                        Store (0x07D1, OSYS)
                    }
                }
            }
            Else
            {
                Store (0x07D0, OSYS)
            }

...

    Method (OSDW, 0, NotSerialized)
    {
        If (LEqual (OSYS, 0x2710))
        {
            Return (0x01)
        }
        Else
        {
            Return (0x00)
        }
    }
