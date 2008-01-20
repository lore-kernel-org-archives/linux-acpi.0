From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output from Benq notebook
Date: Sun, 20 Jan 2008 14:08:40 -0500
Message-ID: <200801201408.40945.lenb@kernel.org>
References: <web-7724225@backend13.aha.ru> <200801181856.30845.lenb@kernel.org> <web-56975710@backend13.aha.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40444 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbYATTI6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:08:58 -0500
In-Reply-To: <web-56975710@backend13.aha.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Dmitry A. Marin" <corvax@corvax.ru>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 02:54, Dmitry A. Marin wrote:
> Hello! The output of acpidumop is attached. I working with
> 2.6.24-4 kernel now (Ubuntu Hardy (testing)), but if it
> important I can try 2.6.23 as it exist in distribution.
> It seems, that I worked with 2.6.18 5-6 month ago and tried
> some options for booting with another acpi-table (?) and
> don't seen any differnce. Hibirnate and sleep worked well.
> 
> On Fri, 18 Jan 2008 18:56:30 -0500
>  Len Brown <lenb@kernel.org> wrote:
> > On Sunday 15 July 2007 06:40, Dmitry A. Marin wrote:
> > > System Information
> > >         Manufacturer: BenQ
> > >         Product Name: Joybook S31
> > 
> > Do you notice any functional difference when booting with
> > 
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> > 
> > Also, please send me the output from acpidump.
> > 

thanks for the acpidump.

OSI(Linux) has no effect on the AML of this machine,
as OSYS is over-written.  So I'll just kill the warning
on this box by adding it to the NOP DMI list.

thanks,
-Len

            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
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

                If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
                {
                    TRAP (0x3D)
                }
            }
