From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Wed, 13 Jun 2007 23:42:55 +0200
Message-ID: <200706132342.55336.rjw@sisk.pl>
References: <878xb35sje.fsf@goat.bogus.local> <20070612153102.GD5986@ucw.cz> <20070613173925.GA20628@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48385 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753994AbXFMVgA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2007 17:36:00 -0400
In-Reply-To: <20070613173925.GA20628@gamma.logic.tuwien.ac.at>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Wednesday, 13 June 2007 19:39, Norbert Preining wrote:
> Hi all!
> 
> On Die, 12 Jun 2007, Pavel Machek wrote:
> > > Hibernate (aka suspend to disk) works, however.
> > > 
> > > When I resume, everything seems to come up (fan becomes busy, disk and
> > > dvd spin up for a short time), but the machine is not responding to
> > > anything - neither keyboard, mouse nor ping from another machine. The
> > > laptop is effectively dead and only a power cycle helps.
> > > 
> > > I've tried a minimal config and init=/bin/bash as well, but the result
> > > is the same.
> 
> All same here, same problem with Acer TM3012, Intel Core Duo, intel
> 945M, ipw3945.
> 
> > Beeping patch? It is in -mm now. noapic nolapic and nosmp are useful,
> > too.
> 
> Can you tell me more about the beeping patch? I checked the patches in
> -mm and the patch names do not contain "beep", neither does
> git-acpi.patch. Where does it come from, do I need some special
> configureation? Is there a bit of explanation around?

See http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc4/patches/30-beeping-patch-for-debugging-acpi-sleep.patch

There's a comment in the patch itself explaining what to do to turn on the
beeping.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
