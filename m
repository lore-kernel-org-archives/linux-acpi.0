From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Sun, 22 Jul 2007 11:10:10 +0200
Message-ID: <20070722091010.GH3701@elf.ucw.cz>
References: <878xb35sje.fsf@goat.bogus.local> <20070612153102.GD5986@ucw.cz> <20070613173925.GA20628@gamma.logic.tuwien.ac.at> <200706132342.55336.rjw@sisk.pl> <878xb35sje.fsf@goat.bogus.local> <20070612153102.GD5986@ucw.cz> <20070614181329.GA31277@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45472 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756611AbXGVJKA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:10:00 -0400
Content-Disposition: inline
In-Reply-To: <20070614181329.GA31277@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu 2007-06-14 20:13:29, Norbert Preining wrote:
> Hi all!
> 
> On Die, 12 Jun 2007, Pavel Machek wrote:
> > > When I resume, everything seems to come up (fan becomes busy, disk and
> > > dvd spin up for a short time), but the machine is not responding to
> > > anything - neither keyboard, mouse nor ping from another machine. The
> > > laptop is effectively dead and only a power cycle helps.
> > > 
> > > I've tried a minimal config and init=/bin/bash as well, but the result
> > > is the same.
> > 
> > Beeping patch? It is in -mm now. noapic nolapic and nosmp are useful,
> > too.
> 
> 
> Ok, no beeping at all. Nothing after resume, only fan. And I did not
> forget to activate the BEEP line.
> 
> So where can I go from here? DSDT hacking? Anything else?

Hmm, it was 'hardware debugger' time when I hit similar problem few
years ago :-(.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
