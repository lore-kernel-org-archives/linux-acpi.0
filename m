From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Tue, 19 Feb 2008 11:24:31 -0300
Message-ID: <20080219142431.GC15883@khazad-dum.debian.net>
References: <200801190240.45718.lenb@kernel.org> <20080119120830.GA16308@khazad-dum.debian.net> <20080119141727.GJ28387@mit.edu> <20080119153304.GA27060@khazad-dum.debian.net> <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu> <20080120194919.GE19295@khazad-dum.debian.net> <1203353902.6019.119.camel@queen.suse.de> <20080218191729.GB9724@khazad-dum.debian.net> <1203416783.2764.14.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57422 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753182AbYBSOYi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 09:24:38 -0500
Content-Disposition: inline
In-Reply-To: <1203416783.2764.14.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Tue, 19 Feb 2008, Thomas Renninger wrote:
> > Looks quite a bad idea IMO.  2.6.24 means what?  SuSE's?  Mainline's?
> > Debian's?  At what patch level?  With which user patches tacked on top?  And
> > at what level of userspace support (X.org can make a LOT of difference
> > here)?
> 
> So you think on next Lenovo pre-load we should compile a "SLED10 SP2"

Huh?!  No, I don't.  I would walk away in disgust if we did it.  OSI(SLED10
SP2) would be even worse than OSI(Linux) plus a OS<whatever>(2.6.24), I
think I can safely assume that we *all* agree on THAT one.

> into our kernel and let Lenovo BIOS fixups use it? E.g. we could use the
> default BCM/BQC/BCL brightness interface easily then, just a small

AFAIK, there is no problem with the *ACPI* brightness firmware on ThinkPads.
At all.  Its only quirk is that you want to call _BCL at least once at
driver load.

Anyway, the whole backlight brightness stink is our (as in Linux kernel
people, userspace people, distro people) doing.  The laptop vendors, for
once, had nothing to do with it. Also, for once, the ACPI 3.0 specification
(when correctly implemented in the AML *and* ACPI OSI) does give us all we
need to have it work properly in any way we see fit.

Since the brightness issues have *nothing* to do with OSI(anything), let's
leave it for another thread.

> Please let us not end up with hacks like ???"SLED10 SP2", "FEISTY" or
> whatever weirdness and this will come if we ignore osi=linux or do not
> provide something else.
> We should make up something more robust and more Linux kernel
> appropriate and propagate it to the vendors.

We all agree on that, Thomas.

I am actually arguing for something *even* more fine-grained than a kernel
version, but at the same time completely independent of kernel versions, so
that if we backport something, or our userspace improves, we can stop (or
start) advertising it through OSI() without messing with anything else.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
