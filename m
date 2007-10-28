From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: System hard lock when closing lid(2nd try)
Date: Sun, 28 Oct 2007 13:18:39 +0000
Message-ID: <1193577519.6402.9.camel@pcjc2lap>
References: <200710261741.50531.rasasi78@gmail.com>
	 <1193483848.7171.3.camel@pcjc2lap>   <ffvaf8$99k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:56246 "EHLO
	ppsw-6.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbXJ1NSr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Oct 2007 09:18:47 -0400
In-Reply-To: <ffvaf8$99k$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Ra=FAl_S=E1nchez?= Siles <rasasi78@gmail.com>
Cc: linux-acpi@vger.kernel.org


On Sat, 2007-10-27 at 14:20 +0200, Ra=C3=BAl S=C3=A1nchez Siles wrote:
> Hello:
>=20
> Peter Clifton wrote:
>=20
> >=20
> > On Fri, 2007-10-26 at 17:41 +0200, Ra=C3=BAl S=C3=A1nchez Siles wro=
te:
> >>   Hello All:
> >>=20
> >>   Some time ago(2007/09/17) I wrote this e-mail:
> >>=20
> >> Ra=C3=BAl S=C3=A1nchez Siles wrote:
> >>=20
> >> >   Hello all:
> >> >=20
> >> >   I've searched for a more user related ML, but this is the clos=
est
> >> >   I've
> >> > found. I own a Dell inspiron 510m laptop which include the HW li=
sted at
> >> > [1]
> >> >=20
> > >   As you can see there the graphics card is an intel 855GM. The n=
ewer
> xorg
> > > intel driver tries to save power by disabling one of the video ou=
tput
> > > pipes of the card, the one that could drive an external VGA monit=
or. As
> a
> > > result, someone told me that the system enters in SMM (System Man=
agement
> > > Mode), leaves the system in such a state that the system ends up =
locking
> > > totally: no ssh connection or sys-rq combination works, just hard=
 power
> > > off. More details at https://bugs.freedesktop.org/show_bug.cgi?id=
=3D11432
> >>=20
> >>   The lid problem stills exist on a current Xorg version, even wit=
h intel
> >> video driver git version. I'm not surprised since I suspect heavil=
y on a
> >> BIOS problem. I'm coming back with more attached info:
> >=20
>   Thanks a lot for your reply, Peter. :)
>=20
> > There is probably a BIOS issue (from reports I've seen on this issu=
e),
> > however the git version of the xserver-xorg-video-intel driver does=
 not
> > address a couple of crashes with 855 hardware which are caused by t=
he X
> > driver writing registers in the card.
> >=20
> >
> http://www2.eng.cam.ac.uk/~pcjc2/ubuntu/xserver-xorg-video-intel_2.1.=
1-0ubuntu10~pcjc2.2.diff.gz
>=20
> >=20
> > Shows the diff applied to a (yet unreleased) Ubuntu package for the
> > drivers. (Applies against 2.1.1 release version). You should be abl=
e to
> > find the patches in the debian/patches/ dir which the diff creates.
> >=20
> I've been following this thread on the xorg-devel ML, and I have thos=
e
> patches queued for testing ;)
>=20
> > It might be worth looking at these, and revisiting the BIOS issue i=
f (as
> > is unfortunately likely) if there remains an issue.
> >=20
>=20
> If you pay attention to https://bugs.freedesktop.org/show_bug.cgi?id=3D=
11432 I
> had published there a patch (comment #23) there that has been happily
> working for me since I post it (yet it works). But what it does is ug=
ly and
> has drawbacks as explained there so I still consider it a workaround =
and
> not a final solution.
>=20
> That's the reason I came here, to check out wether the Linux kernel c=
ould
> address the issue.

I guess this depends on whether it turns out to be ACPI code which is
poking the video chip when you close / open the lid. Please try the
above patches without the patch from comment #23, as there is a chance
it will still improve things. (It'd be good to identify which cases it
does help in).

There might of course be a similar test required in the display
detection code which enables PipeA temporarily, as in the Video overlay
enable code. If it still crashes with the patches I wrote, it would be
good to find out exactly what line in the driver locks the system up in
your case. I guess it might be a register access to PIPEACONF somewhere=
=2E

=46or the patches I made, I added lots of driver print messages, before
and after suspect register accesses, added a sync(); call after each
message, and got my tester to work with hard-drive write-caching
switched off. (This got the log entries previous to the hang to disk.)

Please let us know on the xorg mailing-list if you discover anything
interesting!

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
