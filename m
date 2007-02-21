From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH - 2.6.19 -0/2] Backport of psmouse suspend/shutdown cleanups
Date: Wed, 21 Feb 2007 21:26:24 +0100
Message-ID: <200702212126.25234.rjw@sisk.pl>
References: <1172077685.10619.101.camel@d36.suse.de> <20070221195203.GF3732@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39946 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423093AbXBUUbz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Feb 2007 15:31:55 -0500
In-Reply-To: <20070221195203.GF3732@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Renninger <trenn@suse.de>, Stable <Stable@kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi,

On Wednesday, 21 February 2007 20:52, Pavel Machek wrote:
> Hi!
> 
> I'm not input or stable maintainer, but...
> 
> > I like to ask for inclusion into stable series for these.
> > 
> > The original patch from Dmitry can be found here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=7689
> > comment #64, #65.
> > 
> > The reason is:
> >  - These patches fix a lot weird stuff on all recent
> >    HP nc/nx series laptop models.
> 
> Well, I'd call that "work around hardware problems in broken HP
> laptops". There's HP BIOS bugzilla somewhere, perhaps we should fix it
> that way?
> 
> >  - The problem with the psmouse thing is, if you booted
> >    a broken kernel, rebooting a fixed one will still result
> >    in a broken system (things break (or get fixed) on shutdown
> >    and survive the reboot).
> >    Therefore the patch(es) should get into as much kernels
> >    as possible to avoid further confusions on bug reports...
> 
> Yes, it is quite nasty problem, but:
> 
> 1) Fix is non-trivial (>100 lines, which violates -stable rule IIRC)
> 
> 2) Fix is very disconnected from the problem. "Deinitialize mouse so
> that fans work after reboot". WTF?
> 
> 3) AFAICT it is not a regression.

No, it isn't, but there are many people who have problems with suspending
and even rebooting their laptops without this patch.  Including me. ;-)

Greetings,
Rafael
