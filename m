From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to ram problem
Date: Sun, 3 Feb 2008 19:22:02 +0100
Message-ID: <200802031922.02877.rjw@sisk.pl>
References: <47A5C399.7010405@free.fr> <200802031839.02397.rjw@sisk.pl> <20080203181855.GB1629@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40728 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbYBCSYC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Feb 2008 13:24:02 -0500
In-Reply-To: <20080203181855.GB1629@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: matthieu castet <castet.matthieu@free.fr>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

On Sunday, 3 of February 2008, Pavel Machek wrote:
> On Sun 2008-02-03 18:39:01, Rafael J. Wysocki wrote:
> > On Sunday, 3 of February 2008, matthieu castet wrote:
> > > matthieu castet wrote:
> > > > Hi,
> > > > 
> > > > I am trying to make work suspend to ram on a MSI MS-6380E with a 2.6.23 
> > > > kernel.
> > > > 
> > > > Standby mode works.
> > > > S2ram suspend seems to work : the computer turn off and I can wake up it 
> > > > with the keyboard.
> > > > 
> > > > But when the computer wakeup, I see the video card POST on the screen, 
> > > > but after that the computer hangs : black screen, no working numlock.
> > > > 
> > > > I tried to compile PM_TRACE, but it give no result. So this means the 
> > > > resume hang very early.
> > > > 
> > > > What can I do to debug this ?
> > > >
> > > I play with the s2_beep feature and :
> > > - echo 4 > /proc/sys/kernel/acpi_video_flags make the computer beep
> > > - echo 4 > /proc/sys/kernel/acpi_video_flags make the computer not beep
> > > - adding a beep in bogus_real_magic, make the computer not beep
> > > 
> > > So the hang seems located in wakeup_start.
> > 
> > Hm.  Can you add unconditional BEEP after "jne bogus_real_magic" in
> > arch/x86/kernel/acpi/wakeup.S and see if it beeps?
> 
> Hmm, maybe I know where problem could be. Try
> 
>         movl     $(wakeup_stack - wakeup_code), %esp              # Private stack is needed for ASUS bo\
> 
> instead of existing stack setup. That helped on one of my test-boxes
> -- I uncovered that during rewrite.

Well, that could explain some mysterious failures reported from time to time by
ASUS users.

Rafael
