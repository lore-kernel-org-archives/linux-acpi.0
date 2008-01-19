From: Len Brown <lenb@kernel.org>
Subject: Re: Toshiba Satellite u305-7477 dmidecode output
Date: Sat, 19 Jan 2008 01:04:04 -0500
Message-ID: <200801190104.05097.lenb@kernel.org>
References: <d8dde2940801060326k7c1a1d29wd199527aa68df520@mail.gmail.com> <d8dde2940801181438o74bbc96al7e5ef35d47c05fba@mail.gmail.com> <d8dde2940801181444q72d93019l6f001922d157a1be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52888 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbYASGER (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 01:04:17 -0500
In-Reply-To: <d8dde2940801181444q72d93019l6f001922d157a1be@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Goguen <dgoguen@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Friday 18 January 2008 17:44, David Goguen wrote:

> > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > System Information
> > > >         Manufacturer: TOSHIBA
> > > >         Product Name: Satellite U305
> > > >         Version: PSU30U-054012
> > > >         Serial Number: X7068484W
> > > >         UUID: 607BC0A3-0E91-D811-8DB6-001B24BBF5FC
> > > >         Wake-up Type: Power Switch
> > > >         SKU Number: Not Specified
> > > >         Family: Not Specified
> > >
> > > Does this system run any better or worse when booted with "acpi_osi=Linux"?
> > >

> System does report thermal info where it was not present before.

So you are running 2.6.23 or later and gave it acpi_osi=Linux
and just that parem made thermal info show up?

Can you dump the /proc/acpi/thermal_zone files
with and without this parameter?

This is sort of mysterious, for ASL does this:

          If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x01, LINX)
                }



    OperationRegion (GNVS, SystemMemory, 0x7F6E2B2D, 0x0100)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16,
        SMIF,   8,
        PRM0,   8,
        PRM1,   8,
        SCIF,   8,
        PRM2,   8,
        PRM3,   8,
                Offset (0x09),
                Offset (0x0A),
                Offset (0x0B),
        P80D,   32,
                Offset (0x10),
        PWRS,   8,
                Offset (0x12),
        LINX,   8,
                Offset (0x1B),


And there is no other reference to LINX in the ASL..
So something like the EC must be accessing this location?

What does the e820 stuff in the beginning of dmesg say about 0x7F6E2B2D?
I'm wondering if GNVS stands for Global Non Volatile Storage...

thanks,
-Len

