From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: System hard lock when closing lid(2nd try)
Date: Sat, 27 Oct 2007 12:17:28 +0100
Message-ID: <1193483848.7171.3.camel@pcjc2lap>
References: <200710261741.50531.rasasi78@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:60257 "EHLO
	ppsw-2.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbXJ0LRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Oct 2007 07:17:34 -0400
In-Reply-To: <200710261741.50531.rasasi78@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Ra=FAl_S=E1nchez?= Siles <rasasi78@gmail.com>
Cc: linux-acpi@vger.kernel.org


On Fri, 2007-10-26 at 17:41 +0200, Ra=C3=BAl S=C3=A1nchez Siles wrote:
>   Hello All:
>=20
>   Some time ago(2007/09/17) I wrote this e-mail:
>=20
> Ra=C3=BAl S=C3=A1nchez Siles wrote:
>=20
> >   Hello all:
> >=20
> >   I've searched for a more user related ML, but this is the closest=
 I've
> > found. I own a Dell inspiron 510m laptop which include the HW liste=
d at
> > [1]
> >=20
> >   As you can see there the graphics card is an intel 855GM. The new=
er xorg
> > intel driver tries to save power by disabling one of the video outp=
ut
> > pipes of the card, the one that could drive an external VGA monitor=
=2E As a
> > result, someone told me that the system enters in SMM (System Manag=
ement
> > Mode), leaves the system in such a state that the system ends up lo=
cking
> > totally: no ssh connection or sys-rq combination works, just hard p=
ower
> > off. More details at https://bugs.freedesktop.org/show_bug.cgi?id=3D=
11432
> >=20
> >   This result is the same no matter what Linux version I use, tried
> > 2.6.20,21 and 22. I have done some research as to know if this coul=
d be
> > avoided some way in Linux. I ran the linux firmwarekit, I checked t=
he dsdl
> > table, I upgraded bios, tried different boot parameters but no valu=
able
> > results I got. This information is available, so feel free to ask f=
or it.
> >=20
> >   I'd like to know if there's anything that could be done with rega=
rd to
> > Linux kernel to soothe or solve the issue. Of course, I'm at your d=
isposal
> > to do whatever test is needed.
> >=20
> >   Just in case, I also attach a dmesg output, maybe not the latest =
stable
> > kernel, but still 2.6.22.
> >=20
> >   Thanks a lot.
> >=20
> > [1]
> > lspci -nn
> > 00:00.0 Host bridge [0600]: Intel Corporation 82852/82855 GM/GME/PM=
/GMV
> > Processor to I/O Controller [8086:3580] (rev 02)
> > 00:00.1 System peripheral [0880]: Intel Corporation 82852/82855
> > GM/GME/PM/GMV Processor to I/O Controller [8086:3584] (rev 02)
> > 00:00.3 System peripheral [0880]: Intel Corporation 82852/82855
> > GM/GME/PM/GMV Processor to I/O Controller [8086:3585] (rev 02)
> > 00:02.0 VGA compatible controller [0300]: Intel Corporation 82852/8=
55GM
> > Integrated Graphics Device [8086:3582] (rev 02)
> > 00:02.1 Display controller [0380]: Intel Corporation 82852/855GM
> > Integrated Graphics Device [8086:3582] (rev 02)
> > 00:1d.0 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM
> > (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 [8086:24c2] (rev 01)
> > 00:1d.1 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM
> > (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 [8086:24c4] (rev 01)
> > 00:1d.2 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM
> > (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 [8086:24c7] (rev 01)
> > 00:1d.7 USB Controller [0c03]: Intel Corporation 82801DB/DBM (ICH4/=
ICH4-M)
> > USB2 EHCI Controller [8086:24cd] (rev 01)
> > 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridg=
e
> > [8086:2448] (rev 81)
> > 00:1f.0 ISA bridge [0601]: Intel Corporation 82801DBM (ICH4-M) LPC
> > Interface Bridge [8086:24cc] (rev 01)
> > 00:1f.1 IDE interface [0101]: Intel Corporation 82801DBM (ICH4-M) I=
DE
> > Controller [8086:24ca] (rev 01)
> > 00:1f.5 Multimedia audio controller [0401]: Intel Corporation
> > 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller [8086:2=
4c5]
> > (rev 01)
> > 00:1f.6 Modem [0703]: Intel Corporation 82801DB/DBL/DBM
> > (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller [8086:24c6] (rev 01)
> > 01:01.0 CardBus bridge [0607]: Texas Instruments PCI4510 PC card Ca=
rdbus
> > Controller [104c:ac44] (rev 02)
> > 01:01.1 FireWire (IEEE 1394) [0c00]: Texas Instruments PCI4510 IEEE=
-1394
> > Controller [104c:8029]
> > 01:03.0 Network controller [0280]: Intel Corporation PRO/Wireless 2=
200BG
> > Network Connection [8086:4220] (rev 05)
> > 01:08.0 Ethernet controller [0200]: Intel Corporation 82801DB PRO/1=
00 VE
> > (MOB) Ethernet Controller [8086:103d] (rev 81)
> >=20
>=20
>   Maybe by that date there was nobody avaible for considering this is=
sue so
> I'm trying again.
>=20
>   The lid problem stills exist on a current Xorg version, even with i=
ntel
> video driver git version. I'm not surprised since I suspect heavily o=
n a
> BIOS problem. I'm coming back with more attached info:

There is probably a BIOS issue (from reports I've seen on this issue),
however the git version of the xserver-xorg-video-intel driver does not
address a couple of crashes with 855 hardware which are caused by the X
driver writing registers in the card.

http://www2.eng.cam.ac.uk/~pcjc2/ubuntu/xserver-xorg-video-intel_2.1.1-=
0ubuntu10~pcjc2.2.diff.gz

Shows the diff applied to a (yet unreleased) Ubuntu package for the
drivers. (Applies against 2.1.1 release version). You should be able to
find the patches in the debian/patches/ dir which the diff creates.

It might be worth looking at these, and revisiting the BIOS issue if (a=
s
is unfortunately likely) if there remains an issue.

Regards,

--=20
Peter Clifton

Electrical Engineering Division,
Engineering Department,
University of Cambridge,
9, JJ Thomson Avenue,
Cambridge
CB3 0FA

Tel: +44 (0)7729 980173 - (No signal in the lab!)

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
