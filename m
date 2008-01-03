From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while suspended
	(rev. 2)
Date: Thu, 3 Jan 2008 11:56:15 +0100
Message-ID: <20080103105615.GC1732@elf.ucw.cz>
References: <200801020032.45529.rjw@sisk.pl> <200801021356.59865.rjw@sisk.pl> <20080102131529.GA32160@elte.hu> <200801021428.25164.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756109AbYACK4X@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200801021428.25164.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, David Brownell <david-b@pacbell.net>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > That way any suspend breakage would be detectable (and bisectable) 
> > > > in automated testing - if the resume does not come back after 10-20 
> > > > seconds then the test failed.
> > > 
> > > Yes, but please note that some systems require user space 
> > > manipulations of the graphics adapter for suspend to work and to 
> > > detect a breakage of such a system you need to boot it into X and use 
> > > s2ram to suspend.
> > 
> > yeah, i wouldnt expect graphics mode to come back without quirks. But it 
> > should still work fine over the network, right? (which is my main mode 
> > of testing anyway)
> 
> Well, if the graphics is sufficiently broken, it won't resume at
> all.

Actually, no. Unless you try to boot the bios, it should come up
without graphics. 

Hmm... first framebuffer access may kill the machine at that
point... so disable framebuffer...? ;-). 

vga=1 and no acpi_sleep options usually does the trick for me. That
should work everywhere, independend of graphics options, AFAICT.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
