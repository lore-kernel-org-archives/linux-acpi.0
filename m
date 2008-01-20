From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for LG P1 PRO Express Dual 150B
Date: Sun, 20 Jan 2008 14:13:19 -0500
Message-ID: <200801201413.19814.lenb@kernel.org>
References: <46B461D9.3000604@ellobo> <200801182120.24536.lenb@kernel.org> <4791AD8D.5000508@ellobo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42276 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbYATTNe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:13:34 -0500
In-Reply-To: <4791AD8D.5000508@ellobo>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miguel Gea Milvaques <xerakko@debian.org>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 02:58, Miguel Gea Milvaques wrote:
> Len Brown wrote:
> > On Saturday 04 August 2007 07:24, Miguel Gea Milvaques wrote:
> >   
> >> System Information
> >>         Manufacturer: LG Electronics
> >>         Product Name: P1-J150B
> >>         Version: Not Applicable
> >>         Serial Number: 701KSWK002977
> >>         UUID: 80B450F8-B164-0010-94B0-E3E13E4B84D0
> >>         Wake-up Type: Power Switch
> >>         SKU Number: Not Specified
> >>         Family: Not Specified
> >>
> >> Handle 0x0002, DMI type 2, 8 bytes
> >> Base Board Information
> >>         Manufacturer: LG Electronics
> >>         Product Name: ROCKY
> >>     
> >
> > Thanks for the dmidecode output.
> >
> > Do you notice any functional difference when booting with
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> >   
> That message has dissapeared from my dmesg in 2.6.23 kernel.
> 
> Attached you yave the acpidump

thanks for the acpidump.

The ASL sets "LINX" but never references it,
so OSI(Linux) is a NOP on this machine.

thanks,
-Len


   OperationRegion (GNVS, SystemMemory, 0x3FEEDDBC, 0x0100)
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
