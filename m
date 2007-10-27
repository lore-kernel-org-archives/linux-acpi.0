From: =?UTF-8?B?UmHDumwgU8OhbmNoZXogU2lsZXM=?= <rasasi78@gmail.com>
Subject: Re: System hard lock when closing lid(2nd try)
Date: Sat, 27 Oct 2007 14:20:56 +0200
Message-ID: <ffvaf8$99k$1@ger.gmane.org>
References: <200710261741.50531.rasasi78@gmail.com> <1193483848.7171.3.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52877 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbXJ0MVN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Oct 2007 08:21:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ilkf1-00035k-SC
	for linux-acpi@vger.kernel.org; Sat, 27 Oct 2007 12:21:03 +0000
Received: from 213.pool85-53-181.dynamic.orange.es ([85.53.181.213])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 27 Oct 2007 12:21:03 +0000
Received: from rasasi78 by 213.pool85-53-181.dynamic.orange.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 27 Oct 2007 12:21:03 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello:

Peter Clifton wrote:

>=20
> On Fri, 2007-10-26 at 17:41 +0200, Ra=C3=BAl S=C3=A1nchez Siles wrote=
:
>> =C2=A0 Hello All:
>>=20
>> =C2=A0 Some time ago(2007/09/17) I wrote this e-mail:
>>=20
>> Ra=C3=BAl S=C3=A1nchez Siles wrote:
>>=20
>> > =C2=A0 Hello all:
>> >=20
>> > =C2=A0 I've searched for a more user related ML, but this is the c=
losest
>> > =C2=A0 I've
>> > found. I own a Dell inspiron 510m laptop which include the HW list=
ed at
>> > [1]
>> >=20
> > =C2=A0 As you can see there the graphics card is an intel 855GM. Th=
e newer
xorg
> > intel driver tries to save power by disabling one of the video outp=
ut
> > pipes of the card, the one that could drive an external VGA monitor=
=2E As
a
> > result, someone told me that the system enters in SMM (System Manag=
ement
> > Mode), leaves the system in such a state that the system ends up lo=
cking
> > totally: no ssh connection or sys-rq combination works, just hard p=
ower
> > off. More details at https://bugs.freedesktop.org/show_bug.cgi?id=3D=
11432
>>=20
>> =C2=A0 The lid problem stills exist on a current Xorg version, even =
with intel
>> video driver git version. I'm not surprised since I suspect heavily =
on a
>> BIOS problem. I'm coming back with more attached info:
>=20
=C2=A0 Thanks a lot for your reply, Peter. :)

> There is probably a BIOS issue (from reports I've seen on this issue)=
,
> however the git version of the xserver-xorg-video-intel driver does n=
ot
> address a couple of crashes with 855 hardware which are caused by the=
 X
> driver writing registers in the card.
>=20
>
http://www2.eng.cam.ac.uk/~pcjc2/ubuntu/xserver-xorg-video-intel_2.1.1-=
0ubuntu10~pcjc2.2.diff.gz

>=20
> Shows the diff applied to a (yet unreleased) Ubuntu package for the
> drivers. (Applies against 2.1.1 release version). You should be able =
to
> find the patches in the debian/patches/ dir which the diff creates.
>=20
I've been following this thread on the xorg-devel ML, and I have those
patches queued for testing ;)

> It might be worth looking at these, and revisiting the BIOS issue if =
(as
> is unfortunately likely) if there remains an issue.
>=20

If you pay attention to https://bugs.freedesktop.org/show_bug.cgi?id=3D=
11432 I
had published there a patch (comment #23) there that has been happily
working for me since I post it (yet it works). But what it does is ugly=
 and
has drawbacks as explained there so I still consider it a workaround an=
d
not a final solution.

That's the reason I came here, to check out wether the Linux kernel cou=
ld
address the issue.

Regards,

=C2=A0 =C2=A0 =C2=A0Ra=C3=BAl S=C3=A1nchez Siles
----->Proud Debian user<-----
Linux registered user #416098

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
