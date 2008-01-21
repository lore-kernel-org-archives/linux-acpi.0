From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - dv9500
Date: Mon, 21 Jan 2008 00:57:56 -0500
Message-ID: <200801210057.56752.lenb@kernel.org>
References: <1192260691.7970.1.camel@localhost> <200801182330.33809.lenb@kernel.org> <1200820449.3977.8.camel@LCEMobile02.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53595 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023AbYAUF6N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 00:58:13 -0500
In-Reply-To: <1200820449.3977.8.camel@LCEMobile02.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Siegfried =?utf-8?q?L=C3=B6sch?= <S.Loesch@inode.at>
Cc: linux-acpi@vger.kernel.org

On Sunday 20 January 2008 04:14, Siegfried L=C3=B6sch wrote:
> Hi Len!
>=20
> Please find attached the output of acpidump (file acpidump_out.txt).
>=20
> Up to now I observed the following differences between 2.6.22 and 2.6=
=2E23
> kernel:
>=20
> Power-Management:
> 2.6.22: ok
> 2.6.23:	after some time, during which starting different processes, t=
he
> CPU's are working with 2GHz all the time (ondemand is not present). I
> work around by restarting gnome-power-management.
>=20
> Shutdown:
> 2.6.22: ok
> 2.6.23: gdm crashes
>=20
> Network:
> 2.6.22: LAN and Wlan ok.
> 2.6.23: LAN and Wlan shut down after some time (aprox. 2 to 4 hours -
> but that differs much) and I have to reinitialize networking.
>=20
> I'll further check the different boot options this week and come back=
 to
> you till the end of next week.
>=20
> Thank's very much for your work and efforts!
>=20
> Siegfried
>=20
> Am Freitag, den 18.01.2008, 23:30 -0500 schrieb Len Brown:
> > On Saturday 13 October 2007 03:31, Siegfried L=C3=B6sch wrote:
> > > System Information
> > >         Manufacturer: Hewlett-Packard
> > >         Product Name: HP Pavilion dv9500 Notebook PC   =20
> > >         Version: Rev 1
> > >         Serial Number: CNF7364LT9
> > >         UUID: 434E4637-3336-344C-5439-001B2496B6BB
> > >         Wake-up Type: Power Switch
> > >         SKU Number: GU135EA#ABD=20
> > >         Family: 103C_5335KV
> > >=20
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > >         Manufacturer: Quanta
> > >         Product Name: 30CB
> >=20
> > Thanks for the dmidecode output.
> >=20
> > Do you notice any functional difference when booting with
> >=20
> > "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
> >=20
> > Also, please send me the output from acpidump.
> >=20
> > thanks,
> > -Len
> >=20
> > ps
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php

The 2.6.22 vs 2.6.23 differences must be caused by something else,
for the AML on this box sets but never consults LINX, making
acpi_osi=3DLinux a NOP for this system.

thanks,
-Len

    OperationRegion (GNVS, SystemMemory, 0x7FEDEDBC, 0x0100)
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
=2E..
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (One, LINX)
                }

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
