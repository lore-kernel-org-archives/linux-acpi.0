From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Tue, 19 Feb 2008 01:00:59 +0100
Message-ID: <1203379259.3971.90.camel@linux-2bdv.site>
References: <200801171504.26361.lenb@kernel.org>
	 <20080117213135.GF5547@mit.edu> <200801190240.45718.lenb@kernel.org>
	 <20080119120830.GA16308@khazad-dum.debian.net>
	 <20080119141727.GJ28387@mit.edu>
	 <20080119153304.GA27060@khazad-dum.debian.net>
	 <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu>
	 <20080120194919.GE19295@khazad-dum.debian.net>
	 <1203353902.6019.119.camel@queen.suse.de>
	 <20080218191729.GB9724@khazad-dum.debian.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56110 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbYBSABE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 19:01:04 -0500
In-Reply-To: <20080218191729.GB9724@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>


On Mon, 2008-02-18 at 16:17 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 18 Feb 2008, Thomas Renninger wrote:
> > The problem is that OSI is used by Windows to pass the exact Window=
s
> > (not OS) version they are running, this function should be called W=
OSI.
> > We of course want to run on the latest fix-ups here and should pass
> > "Windows 2006" (or whatever latest string there exists).
> >=20
> > IMO we need the same for Linux.
> > We even have the advantage, that the string in LOSI(String) makes s=
ome
> > sense, e.g. 2.6.24, so why not use LOSI(int, int, int)
> > How the exact interface might look like I am not sure, just an idea=
=2E
>=20
> Looks quite a bad idea IMO.  2.6.24 means what?  SuSE's?  Mainline's?
> Debian's?  At what patch level?  With which user patches tacked on to=
p?  And
> at what level of userspace support (X.org can make a LOT of differenc=
e
> here)?
Every distribution is based on a specific kernel, right?

Most stuff that gets fixed by these workarounds would make no sense to
backport, because backports are much too intrusive, e.g.:
  - AML interpreter workarounds
  - suspend to ram (s3bios or kernel graphics driver support)
  - suspend order
  - FSC V5505 does not like a specific EC write done with
    Osi=3D"Windows 2006" -> easy to workaround for the vendor, they
    already implement "Linux" as Osi string
    http://bugzilla.kernel.org/show_bug.cgi?id=3D9939
  - Lenovo brightness (Internal Intel graphics card needs kernel
    graphics driver supported for their BQC, BCL, BCM implementation)
    This will never ever be possible to backport
  - Dozens more...

> No, if you are going to go about that, use OSI to ask about specific =
support
> you need, like Len said.  Yes, this might mean a lot of OSI strings.
Not for us, we can just pass the kernel version and check for
greater/less.

> > A)
> > Vendors *must* have a flag for Linux to be able to provide proper
> > support for multiple kernels and to be able to provide easy and ris=
kless
> > fixes for Linux at all.
>=20
> You need it to be more fine-grained than that, a LOT more fine-graine=
d.
No you need not. It would be fine, but it's better than nothing.

> > I expect we now have this problem because nobody (including myself)
> > never dreamed of that it could ever happen that a vendor adds Linux
> > specific AML code.
>=20
> Then WTF did we start shipping an OSI(Linux) string in the first plac=
e?
> Don't tell me it was done just for the heck of it.
Right..., it's invoked by BIOS and the kernel can return true on
multiple strings.
It's a good idea, not perfect yet. Removing it with the dmi white/black
list..., puhhhh, IMO not a good idea.

> > But now that it happens we should react quickly and come up with a
> > robust interface for the future...
>=20
> Len already explained what is needed, and I added how to do it in a w=
ay that
> it would be accepted from my experience with vendors.
Len wants to get rid of it after BIOS vendors finally started to use it=
, I got that now.
And what should be the replacement?
This whole dmi white/black listing to use osi(linux) or not cannot be
the final solution?
I didn't really realize what is going on, I did a short double delete o=
n
most osi=3Dlinux mails of the past weeks..., what was your way that you
think gets accepted by vendors?

Vendors need a knob for their BIOS fixes, that should be proven since s=
o
many are using osi=3Dlinux for some time now (since some came up with
pre-loads I expect...).

> Basically, it needs to be fine-grained and function-specific, AND it =
must be
> allow for near-perfect backward and forward compatibility or it will =
be a
> lot more difficult to see it get any use.
?!?
It simply must be knob which vendors can use to place AML code in for
which they can be sure that it's only processed on Linux. That would
vendors already help a lot to release a BIOS fix (for which everybody
screams: those broken BIOS'es AML code does not get fixed up by the
vendors...).
This will reduce the QA vendors have to do: Only need to test one OS
when releasing a BIOS fix.
Or for most it's an argument to do a fix for Linux *at all*. I wouldn't
risk any line of code for an OS that runs on 5% of my sold machines...,
maybe if it's "if(linux)" embedded. And fact is, there are not much
laptop models sold on which Windows is not the most common used
Operation System (Macs maybe...).
So either you get them a reasonable possibility to fix their BIOSes or
you end up blacklisting forever.

This is what we do for years, right?
We do it that way, because Windows is doing it on that machine..., it
breaks some others... then better do the middle of it, or better dmi
blacklist the one and the other machine...
Sorry, but =EF=BB=BFthis:
"ACPI: add DMI to enable OSI(Linux) on ThinkPad T61"
cannot be the solution. A blacklist for Linux specific BIOS
workarounds...

Why not moving these very machine specific workarounds into the BIOS,
this is what we always wanted, get it fixed in the BIOS?
Or even better, the vendors already do some QA on it and make sure that
the machine works perfectly with the latest kernel xy.

> > > Now, the real test will be if we ask for something that would req=
uire
> > > changing their Windows drivers.  I sure hope they would do it, bu=
t...
> > Yep nobody would ever do this.
>=20
> I have some doubts about the "nobody", but you'd have to present a he=
ck of a
> good case.
>=20
> BTW, I am perfectly happy with OSI(Linux) being used to disable crap =
that is
> only relevant to work around *bugs* in windows drivers.  But that's n=
ot how
> most vendors use it.
I am already perfectly happy to disable crap that just makes the machin=
e
work perfectly with the latest kernels and this is what these guys are
doing.

Maybe I just missed it, but there is no replacement for osi=3Dlinux ven=
dor
workarounds decided/discussed yet?

    Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
