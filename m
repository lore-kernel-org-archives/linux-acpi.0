From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to ram problem
Date: Sun, 3 Feb 2008 19:18:55 +0100
Message-ID: <20080203181855.GB1629@elf.ucw.cz>
References: <47A5C399.7010405@free.fr> <47A5DE60.1080402@free.fr> <200802031839.02397.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44212 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750746AbYBCSSl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Feb 2008 13:18:41 -0500
Content-Disposition: inline
In-Reply-To: <200802031839.02397.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: matthieu castet <castet.matthieu@free.fr>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

On Sun 2008-02-03 18:39:01, Rafael J. Wysocki wrote:
> On Sunday, 3 of February 2008, matthieu castet wrote:
> > matthieu castet wrote:
> > > Hi,
> > > 
> > > I am trying to make work suspend to ram on a MSI MS-6380E with a 2.6.23 
> > > kernel.
> > > 
> > > Standby mode works.
> > > S2ram suspend seems to work : the computer turn off and I can wake up it 
> > > with the keyboard.
> > > 
> > > But when the computer wakeup, I see the video card POST on the screen, 
> > > but after that the computer hangs : black screen, no working numlock.
> > > 
> > > I tried to compile PM_TRACE, but it give no result. So this means the 
> > > resume hang very early.
> > > 
> > > What can I do to debug this ?
> > >
> > I play with the s2_beep feature and :
> > - echo 4 > /proc/sys/kernel/acpi_video_flags make the computer beep
> > - echo 4 > /proc/sys/kernel/acpi_video_flags make the computer not beep
> > - adding a beep in bogus_real_magic, make the computer not beep
> > 
> > So the hang seems located in wakeup_start.
> 
> Hm.  Can you add unconditional BEEP after "jne bogus_real_magic" in
> arch/x86/kernel/acpi/wakeup.S and see if it beeps?

Hmm, maybe I know where problem could be. Try

        movl     $(wakeup_stack - wakeup_code), %esp              # Private stack is needed for ASUS bo\

instead of existing stack setup. That helped on one of my test-boxes
-- I uncovered that during rewrite.

Otherwise use BEEP and infinite loops to find out where it hangs...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
