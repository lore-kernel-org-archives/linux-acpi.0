From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Tue, 19 Feb 2008 23:47:50 -0300
Message-ID: <20080220024750.GE12850@khazad-dum.debian.net>
References: <20080119141727.GJ28387@mit.edu> <20080119153304.GA27060@khazad-dum.debian.net> <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu> <20080120194919.GE19295@khazad-dum.debian.net> <1203353902.6019.119.camel@queen.suse.de> <20080218191729.GB9724@khazad-dum.debian.net> <1203416783.2764.14.camel@linux-2bdv.site> <20080219142431.GC15883@khazad-dum.debian.net> <1203471780.3358.174.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39926 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755641AbYBTCr4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 21:47:56 -0500
Content-Disposition: inline
In-Reply-To: <1203471780.3358.174.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 20 Feb 2008, Thomas Renninger wrote:
> > AFAIK, there is no problem with the *ACPI* brightness firmware on ThinkPads.
> > At all.  Its only quirk is that you want to call _BCL at least once at
> > driver load.
> No it's not that it's:
>  - you call BCLL, a totally undefined AML function, found out by DSDT
>    examination..., Lenovo is allowed to and will change the name this
>    function at some time, they even could for a BIOS update

That's gone in my devel tree, already.  A first incarnation of it is even
out on the latest thinkpad-acpi devel snapshot (it works, but it has a lot
of thinkos, so I changed it a lot).   thinkpad-acpi only calls _BCL now.

And that's hardly Lenovo's fault, *I* chose to call BCLL, their standard
ACPI interface works just fine.  The reason I switched from _BCL to BCLL was
that you warned me that _BCL had "side-effects".  Unfortunately, it took me
this long to realise the side-effects were desired ones.

>  - It is that we have to use the ibm_acpi driver quirks for an interface
>    that is specified and which nearly every Vista compatible machine is
>    providing.
>    You need special handling for Lenovos. You need to blacklist them to
>    not use the well defined interface, but use the ibm_acpi quirks.

It is the other way around.  thinkpad-acpi detects that ACPI generic
brightness control exists, and refuses to load its own interface to avoid
races with video.c and ACPI.

And if you need thinkpad-acpi's interface instead of the one provided by
video.c in a Lenovo ThinkPad, it is likely due to bugs in video.c.  Or it is
because X.org is making sure you have to use RandR backlight control.

> I really like to ask Lenovo to add a ???(on Intel graphics cards):
> if (linux)
>    call _BCM/BQC/BCL this way
> else
> ???   call _BCM/BQC/BCL the other way
> All this should be only some simple AML lines...
> and simply use the video driver for Lenovo backlight switching...

**** DO NOT DO THIS! ****

Please, if you ever find yourself in a position to ask anything of the sort
from Lenovo, CC me.  And, preferably, we should talk about it first so we
can reach an agreement and present a single position to Lenovo.

As far as I know, there is *nothing* wrong with the Lenovo-provided
_BCM/BQC/BCL handlers.  If thinkpad-acpi gave you *any* ideas about asking
Lenovo to change their DSDTs, please run them by me first, it is likely
something I should change in thinkpad-acpi.

And we have to get the X.org people in the loop *as* *well*.  X.org wants to
do the backlight switching directly in some drivers, because it is safer (no
SMIs! Anything that avoids an SMI is a Good Thing), faster (no ACPI calls,
no context switches, no SMI traps!), and it often gives you even more
control and levels than what is available through ACPI, for example.

We have to give userspace a sane way to tell the kernel to block access to
any backlight interfaces dealing with a given video device.  Again, this has
nothing to do with Lenovo.  We don't have any decent way to know what video
device a backlight is tied to, either.  That's something else that needs to
be fixed.

We have a buggy drivers/acpi/video.c.  It is being fixed, look at the git
logs and bugzilla...

We have userspace fighting itself over how to handle KEY_BRIGHTNESS_*.  It
has to be fixed, too.  Fortunately, it won't have to ALSO fight video.c
anymore, the patch to stop that is already in mainline, although we might
want to modify how that is done a bit to make life easier for the console
warriors ;-)

Nothing in the my-goodness-this-is-fucked-up list of troubles plaguing
brightness control on ThinkPads relates to Lenovo's _BCM/BQC/BCL handlers,
AFAIK.

> > I am actually arguing for something *even* more fine-grained than a kernel
> > version, but at the same time completely independent of kernel versions, so
> > that if we backport something, or our userspace improves, we can stop (or
> > start) advertising it through OSI() without messing with anything else.
> 
> IMO kernel version is enough and the right thing, everything else is
> over-designed (please provide an example, I cannot imagine anything
> useful/generic but only osi=linux or better osi=linux + kernel version).

I did.  X.org userspace video device POST on resume.  It is a real-world
example.  Others have given you other reasons why a kernel version is not a
perfect solution, too.

> I start a new thread/discussion now. I was quite late with reading up
> the list and this is important and should get some more attention also
> by others who might not have read into this thread.

That I agree with fully :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
