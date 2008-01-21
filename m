From: Len Brown <lenb@kernel.org>
Subject: Re: Dmidecode of the Clevo M720R
Date: Mon, 21 Jan 2008 00:09:26 -0500
Message-ID: <200801210009.26275.lenb@kernel.org>
References: <4710F714.6040704@gmail.com> <200801182331.54356.lenb@kernel.org> <62e5edd40801191007p299165bei3438862c6b2ad277@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55548 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbYAUFJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 00:09:39 -0500
In-Reply-To: <62e5edd40801191007p299165bei3438862c6b2ad277@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik =?utf-8?q?Andr=C3=A9n?= <erik.andren@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 13:07, Erik Andr=C3=A9n wrote:
> Hi,
>=20
> 2008/1/19, Len Brown <lenb@kernel.org>:
> >
> > On Saturday 13 October 2007 12:49, Erik Andr=C3=A9n wrote:
> > > System Information
> > > Manufacturer: Intel Corporation
> > > Product Name: Crestline & ICH8M Chipset
> > > Version: Not Applicable
> > > Serial Number: Not Applicable
> > > UUID: FFFFFFFF-FFFF-0000-0000-000000000000
> > > Wake-up Type: Power Switch
> > > SKU Number: Not Specified
> > > Family: Not Specified
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > > Manufacturer: Intel Corporation
> > > Product Name: SANTA ROSA CRB
> >
> > Thanks for the dmidecode output
> >
> > Looks like a pre-production BIOS,
> > can you update and....
>=20
>=20
>=20
> There are no updates available on the clevo homepage...
>=20
> then do you notice any functional difference when booting with
> >
> > "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
> >
> > Also, please send me the output from acpidump.
>=20
>=20
> So far I haven't noticed any difference when with or without the Linu=
x
> string.
> I'm attaching the acpidump with this message.
>=20
> Regards,
> Erik
>=20
> thanks,
> > -Len
> >
> > ps
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php
> >
>=20

acpi_osi=3DLinux is a NOP on this box b/c it simply sets LINX
and never referes to it after that.

thanks,
-Len

    OperationRegion (GNVS, SystemMemory, 0xBF6DEDBC, 0x0100)
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
=2E...
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
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
