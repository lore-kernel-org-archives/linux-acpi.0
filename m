From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Sony VAIO - VGN-NR11S_S
Date: Tue, 12 Feb 2008 15:24:49 -0500
Message-ID: <200802121524.49489.lenb@kernel.org>
References: <66b1c5c60802100631s279bf82aje3906d44309d5083@mail.gmail.com> <200802102157.15703.lenb@kernel.org> <66b1c5c60802110605g32732292kc4c7a668ba59c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44599 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbYBLUZD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 15:25:03 -0500
In-Reply-To: <66b1c5c60802110605g32732292kc4c7a668ba59c6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mateu Soler <mito150@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Monday 11 February 2008 09:05, Mateu Soler wrote:
> 2008/2/11, Len Brown <lenb@kernel.org>:
> > On Sunday 10 February 2008 09:31, you wrote:
> > > Handle 0x0001, DMI type 1, 27 bytes
> > > System Information
> > >         Manufacturer: Sony Corporation
> > >         Product Name: VGN-NR11S_S
> > >         Version: C3LPZGMR
> > ...
> > >
> > > Handle 0x0002, DMI type 2, 10 bytes
> > > Base Board Information
> > >         Manufacturer: Sony Corporation
> > >         Product Name: VAIO
> >
thanks for the acpidump.

OSI(Linux) is a NOP on this box.

-Len


    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)
        {
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
