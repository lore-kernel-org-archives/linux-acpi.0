From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Apple MacPro
Date: Sun, 20 Jan 2008 14:26:16 -0500
Message-ID: <200801201426.16441.lenb@kernel.org>
References: <200708291349.46987.rene@exactcode.de> <200801182236.40494.lenb@kernel.org> <F6DBF27A-F208-42A1-BE69-F6CD86AE29EE@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59735 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbYATT0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Jan 2008 14:26:41 -0500
In-Reply-To: <F6DBF27A-F208-42A1-BE69-F6CD86AE29EE@exactcode.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 05:16, Ren=E9 Rebe wrote:
> Hi Len,
>=20
> now that was some time between the mails :-)
>=20
> Unfortunately the 8-core box is sort of running in production
> and I can not randomly boot kernels.
>=20
> Passing acpi_os=3Dwhatever did not really changed anything
> back in the days when I tried that. Actually the box is running
> quite fine (normal server load, no suspend or so) though currently
> an older 2.6.18+openvz kernel as that was the only openvz patch-
> set that was stable, all the other openvz patchsets locked up sooner
> than later ...
>=20
> If you are still interested in the acpidump I can hunting for it.

Yes, I'm still interseted in the acpidump.

While I hear a lot from folks running Linux on Apple laptops,
I hear less from folks running Linux on Apple servers --
so I don't have this acpidump yet.

Hopefully the acpidump will tell all, and we'll have no need for testin=
g.

thanks,
-Len

>=20
> On 19.01.2008, at 04:36, Len Brown wrote:
>=20
> > On Wednesday 29 August 2007 07:49, Ren=E9 Rebe wrote:
> >> Hi all,
> >>
> >> I just post because my dmesg says so:
> >>
> >> ACPI: System BIOS is requesting _OSI(Linux)
> >> ACPI: Please test with "acpi_osi=3D!Linux"
> >> Please send dmidecode to linux-acpi@vger.kernel.org
> >>
> >> Handle 0x003A, DMI type 0, 24 bytes
> >> BIOS Information
> >>        Vendor: Apple Computer, Inc.
> >>        Version:     MP21.88Z.007F.B02.0703191612
> >>        Release Date: 03/19/07
> >>
> >> Handle 0x003B, DMI type 1, 27 bytes
> >> System Information
> >>        Manufacturer: Apple Computer, Inc.
> >>        Product Name: MacPro2,1
> >>        Version: 1.0
> >>
> >> ...
> >>
> >> If you need more let me know. I mostly looked thru the dmesg
> >> because the box shuts down sometimes, randomly. Maybe too hot?
> >> But I still investigate.
> >>
> >> However, the box (2 Quad-Core CPUs) even awakes from echo mem >
> >> /sys/power/state (without graphic though, maybe s2ram posting woul=
d =20
> >> fix
> >> that - but I do not really care about the graphic as it is indende=
d =20
> >> to be used
> >> as server anyway).
> >
> > Thanks for the dmidecode output.
> >
> > Do you notice any functional difference when booting with
> >
> > "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
> >
> > Also, please send me the output from acpidump.
> >
> > thanks,
> > -Len
> >
> > ps
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php
>=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
