From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Samsung R10P/R41P
Date: Sun, 20 Jan 2008 15:10:21 -0500
Message-ID: <200801201510.21576.lenb@kernel.org>
References: <184fd4090801170441r6d93157gfa1548b737a796c4@mail.gmail.com> <200801181452.21179.lenb@kernel.org> <184fd4090801190339y1e2d4deaw881af3240c93464c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43571 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762AbYATUKh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 15:10:37 -0500
In-Reply-To: <184fd4090801190339y1e2d4deaw881af3240c93464c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yurij Perepelytsia <yurij.perepelytsia@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 06:39, Yurij Perepelytsia wrote:
> Hello Len,
> 
> Thank for your answer. I've made as you said with "acpi_osi=!Linux"
> and additional with
> "acpi_osi=Linux" here is dmidecode and acpidump in attachment :
> "acpi_osi=Linux": acpidump0.txt
> "acpi_osi=!Linux":  acpidump1.txt
> 
> Thanks.
> 
> 
> Jan 19 16:32:14 yura kernel: ACPI: Please test with "acpi_osi=!Linux"
> 
> 2008/1/18, Len Brown <lenb@kernel.org>:
> > On Thursday 17 January 2008 07:43, Yurij Perepelytsia wrote:
> > > Hello,
> > >
> > > in my log file I've found "Please send dmidecode to
> > > linux-acpi@vger.kernel.org" my laptop is Samsung R40Plus R40XY0E.
> > > Here is copy past of that.
> >
> > Thank you Yurij.
> > Does  your system behave any differently when booted with this?:
> >
> > acpi_osi=Linux
> >
> > please e-mail me the output from acpidump.
> >
> > thanks,
> > -Len
> >
> > > yura:/home/yura# dmidecode
> > > # dmidecode 2.9
> >
> > >
> > > Handle 0x0001, DMI type 1, 27 bytes
> > > System Information
> > >     Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
> > >     Product Name: R40P/R41P
> > >     Version: 06YE
> > >     Serial Number: 967Y93FP800126
> > >     UUID: 20B7E72E-D21D-B211-8000-9F20205EAF5B
> > >     Wake-up Type: Power Switch
> > >     SKU Number: Not Specified
> > >     Family: Not Specified
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > >     Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
> > >     Product Name: R40P/R41P
> > >     Version:
> > >     Serial Number: 123490EN400015

Thanks for the acpidump
Looks a lot like that on the Quanta boards from HP...

We need to disable OSI(Linux) on this box if we want
the proposd PNP0C32 to work.

-Len



   Scope (\_SB)
    {
        Name (LINX, 0x00)
        Name (OSTB, Ones)
        OperationRegion (OSTY, SystemMemory, 0x2FE9FF4C, 0x00000001)
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
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x08, ^OSTB)
                        Store (0x08, ^TPOS)
                    }
...
                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX) // NOP -- never refereced after set
                        Store (0x80, ^OSTB)
                        Store (0x80, ^TPOS)
                    }

PHNP0C32 looks for OSTB == 0x40, which this code clobbers,
so OSI(Linux) will disable that:
                    Device (MBTN)
                    {
                        Name (_HID, EisaId ("PNP0C32"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (\_SB.OSTB, 0x40))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (GHID, 0, NotSerialized)
                        {
                            If (DMED)
                            {
                                Notify (MBTN, 0x02)
                            }

                            Return (Buffer (0x01)
                            {
                                0x01
                            })
                        }
                    }





