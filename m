From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for Compal HEL80 Notebook
Date: Sun, 20 Jan 2008 18:56:15 -0500
Message-ID: <200801201856.15742.lenb@kernel.org>
References: <470746EB.2000707@gmail.com> <200801182320.15049.lenb@kernel.org> <47921522.9070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34584 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754404AbYATX42 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 18:56:28 -0500
In-Reply-To: <47921522.9070008@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jochen Kemnade <kemnade@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 10:20, Jochen Kemnade wrote:
> Hello,
> 
> Len Brown schrieb:
> > Do you notice any functional difference when booting with
> > 
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> 
> No, i didn't. I was running 2.6.22 for some time and at the moment, I'm
> running 2.6.24-rc8, but I couldn't make out any functional change. Do
> you have anything specific in mind that I could test and report about?
> 
> > Also, please send me the output from acpidump.

Thanks for the acpidump.
Please verify that the battery and AC/CD switch evenst are working
properly in both cases above.

-Len


...
    Name (ECDY, 0x05)
...
       Method (_INI, 0, NotSerialized)
        {
            Store (0x9999, MARK)
            If (DTSE)
            {
                TRAP (0x47)
                ^PCI0.LPCB.PHSS (0x10)
            }

            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
                    Store (Zero, ECDY)
// ECDY is used all over the battery and AC code.

                }

                If (_OSI ("Windows 2001"))
                {
// here OSYS gets over-written, so writing it for Linux above was a NOP
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

                If (LLessEqual (OSYS, 0x07D2))
                {
                    TRAP (0x49)
                }

                If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
                {
                    TRAP (0x3D)
                }
            }
        }
