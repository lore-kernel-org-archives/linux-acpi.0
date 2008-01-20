From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output, as requested (MacBook1,1)
Date: Sun, 20 Jan 2008 18:46:57 -0500
Message-ID: <200801201846.57879.lenb@kernel.org>
References: <200712071858.03017.H.A.J.Koster@xs4all.nl> <200801181648.00291.lenb@kernel.org> <200801191555.10467.H.A.J.Koster@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48509 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179AbYATXrM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 18:47:12 -0500
In-Reply-To: <200801191555.10467.H.A.J.Koster@xs4all.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henk Koster <H.A.J.Koster@xs4all.nl>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 09:55, Henk Koster wrote:
> On Friday 18 January 2008 22:48:00 you wrote:
> > 	Manufacturer: Apple Computer, Inc.
> > 	Product Name: MacBook1,1
> >
> > With 2.6.22, did you notice any functional difference with
> > "acpi_osi=!Linux"?
> 
> No difference
> 
> > (or since the default changed at 2.6.23, with 2.6.23 or later
> >  do you notice any difference with "acpi_osi=Linux"?)
> 
> No difference
> 
> > Please send me the output from acpidump.
> 
> Attached, running 2.6.23 now.

OSI(Linux) changes teh value of OSYS:

    OperationRegion (GNVS, SystemMemory, 0x7EED5C10, 0x0100)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16,

...

    Scope (\_SB)
    {
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
OSYS 0x7D1 enables the UI bit in HPET _STA (Linux doen't care)
and is used by the OS=Darwin test method:

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

which treats Linux and Windows the same,
so OSI(Linux) is a NOP on the MacBook1,1

thanks,
-Len

