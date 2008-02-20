From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Wed, 20 Feb 2008 02:43:00 +0100
Message-ID: <1203471780.3358.174.camel@linux-2bdv.site>
References: <200801190240.45718.lenb@kernel.org>
	 <20080119120830.GA16308@khazad-dum.debian.net>
	 <20080119141727.GJ28387@mit.edu>
	 <20080119153304.GA27060@khazad-dum.debian.net>
	 <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu>
	 <20080120194919.GE19295@khazad-dum.debian.net>
	 <1203353902.6019.119.camel@queen.suse.de>
	 <20080218191729.GB9724@khazad-dum.debian.net>
	 <1203416783.2764.14.camel@linux-2bdv.site>
	 <20080219142431.GC15883@khazad-dum.debian.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57448 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860AbYBTBnE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 20:43:04 -0500
In-Reply-To: <20080219142431.GC15883@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Tue, 2008-02-19 at 11:24 -0300, Henrique de Moraes Holschuh wrote:
> On Tue, 19 Feb 2008, Thomas Renninger wrote:
> > > Looks quite a bad idea IMO.  2.6.24 means what?  SuSE's?  Mainlin=
e's?
> > > Debian's?  At what patch level?  With which user patches tacked o=
n top?  And
> > > at what level of userspace support (X.org can make a LOT of diffe=
rence
> > > here)?
> >=20
> > So you think on next Lenovo pre-load we should compile a "SLED10 SP=
2"
>=20
> Huh?!  No, I don't.  I would walk away in disgust if we did it.  OSI(=
SLED10
> SP2) would be even worse than OSI(Linux) plus a OS<whatever>(2.6.24),=
 I
> think I can safely assume that we *all* agree on THAT one.
>=20
> > into our kernel and let Lenovo BIOS fixups use it? E.g. we could us=
e the
> > default BCM/BQC/BCL brightness interface easily then, just a small
>=20
> AFAIK, there is no problem with the *ACPI* brightness firmware on Thi=
nkPads.
> At all.  Its only quirk is that you want to call _BCL at least once a=
t
> driver load.
No it's not that it's:
 - you call BCLL, a totally undefined AML function, found out by DSDT
   examination..., Lenovo is allowed to and will change the name this
   function at some time, they even could for a BIOS update
 - It is that we have to use the ibm_acpi driver quirks for an interfac=
e
   that is specified and which nearly every Vista compatible machine is
   providing.
   You need special handling for Lenovos. You need to blacklist them to
   not use the well defined interface, but use the ibm_acpi quirks.

I really like to ask Lenovo to add a =EF=BB=BF(on Intel graphics cards)=
:
if (linux)
   call _BCM/BQC/BCL this way
else
=EF=BB=BF   call _BCM/BQC/BCL the other way
All this should be only some simple AML lines...
and simply use the video driver for Lenovo backlight switching...

> Anyway, the whole backlight brightness stink is our (as in Linux kern=
el
> people, userspace people, distro people) doing.  The laptop vendors, =
for
> once, had nothing to do with it. Also, for once, the ACPI 3.0 specifi=
cation
> (when correctly implemented in the AML *and* ACPI OSI) does give us a=
ll we
> need to have it work properly in any way we see fit.
>=20
> Since the brightness issues have *nothing* to do with OSI(anything), =
let's
> leave it for another thread.
>=20
> > Please let us not end up with hacks like ???"SLED10 SP2", "FEISTY" =
or
> > whatever weirdness and this will come if we ignore osi=3Dlinux or d=
o not
> > provide something else.
> > We should make up something more robust and more Linux kernel
> > appropriate and propagate it to the vendors.
>=20
> We all agree on that, Thomas.
Puhhh... good. So I have missed the one or other suggestion or there ar=
e
no suggestions yet?

> I am actually arguing for something *even* more fine-grained than a k=
ernel
> version, but at the same time completely independent of kernel versio=
ns, so
> that if we backport something, or our userspace improves, we can stop=
 (or
> start) advertising it through OSI() without messing with anything els=
e.

IMO kernel version is enough and the right thing, everything else is
over-designed (please provide an example, I cannot imagine anything
useful/generic but only osi=3Dlinux or better osi=3Dlinux + kernel vers=
ion).

I start a new thread/discussion now. I was quite late with reading up
the list and this is important and should get some more attention also
by others who might not have read into this thread.

   Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
