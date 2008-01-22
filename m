From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for Lenovo N100 3000 0768
Date: Mon, 21 Jan 2008 23:15:26 -0500
Message-ID: <200801212315.26278.lenb@kernel.org>
References: <50d9f33a0708111300x3c5e4e23n3d1249539113ece8@mail.gmail.com> <200801182208.51610.lenb@kernel.org> <50d9f33a0801211147i6ec08e44u2804b90e3715bb76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43805 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbYAVEPn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 23:15:43 -0500
In-Reply-To: <50d9f33a0801211147i6ec08e44u2804b90e3715bb76@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Neil Wilson <neil@aldur.co.uk>
Cc: linux-acpi@vger.kernel.org

On Monday 21 January 2008 14:47, Neil Wilson wrote:
> On 1/19/08, Len Brown <lenb@kernel.org> wrote:
> >
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >         Manufacturer: LENOVO
> >         Product Name: 0768BXG
> >         Version: 3000 N100

I guess I'll key off this:
DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),

as the Board info below looks like it wasn't updated by Lenovo.

> >         Serial Number: L3PV880
> >         UUID: E384EFFA-25CB-11DC-9EB2-001B38087FD3
> >         Wake-up Type: Power Switch
> >         SKU Number: Intel
> >         Family: Lenovo
> >
> > Handle 0x0002, DMI type 2, 8 bytes
> > Base Board Information
> >         Manufacturer: LENOVO
> >         Product Name: CAPELL VALLEY(NAPA) CRB
> >
> > This must be a pretty early BIOS if it still says
> > Capell Valley CRB in the DMI....
> 
> Indeed. However it is the latest version available for this particular
> model of laptop.
> 
> 
> > Thanks for the dmidecode output.
> >
> > Do you notice any functional difference when booting with
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> 
> None whatsoever. The boot traces and facilities appear identical.
> 

thanks for the acpidump, Neil, it confirms that OSI(Linux)
is a NOP on this box, since LINX is not referenced, and OSYS is over-written.

-Len

            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (One, LINX)
                    Store (0x03E8, OSYS)
                }

                If (_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }
....
    OperationRegion (GNVS, SystemMemory, 0x7F6EDDBC, 0x0100)
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
