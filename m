From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to lid_init_state=open"
Date: Sat, 27 May 2017 21:23:34 +0200
Message-ID: <10472378.BstUXsYGq3@aspire.rjw.lan>
References: <20170526073953.GA29786@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60267 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750737AbdE0TaY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 May 2017 15:30:24 -0400
In-Reply-To: <20170526073953.GA29786@jelly>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday, May 26, 2017 05:39:53 PM Peter Hutterer wrote:
> On May 25 2017, Benjamin Tissoires wrote:
> > On May 15 2017 or thereabouts, Rafael J. Wysocki wrote:
> 
> > > >> >> Benjamin, my understanding is that this is the case, is it correct?
> > > >> >
> > > >> > That is correct. This patch I reverted introduces regression for professional
> > > >> > laptops that expect the LID switch to be reported accurately.
> > > >>
> > > >> And from a user's perspective, what does not work any more?
> > > >
> > > > If you boot or resume your laptop with the lid closed on a docking
> > > > station while using an external monitor connected to it, both internal
> > > > and external displays will light on, while only the external should.
> > > >
> > > > There is a design choice in gdm to only provide the greater on the
> > > > internal display when lit on, so users only see a gray area on the
> > > > external monitor. Also, the cursor will not show up as it's by default
> > > > on the internal display too.
> > > >
> > > > To "fix" that, users have to open the laptop once and close it once
> > > > again to sync the state of the switch with the hardware state.
> > >
> > > OK
> > >
> > > Yeah, that sucks.
> > >
> > > So without the Lv's patch the behavior (on the systems in question) is
> > > as expected, right?
> > 
> > Would you agree to take both these reverts without Lv's ACK? We already
> > tried to explain for 2 weeks that they are valuable, but it seems we
> > can't make change his mind.
> > 
> > I have more that 26 emails in my INBOX (not counting my replies) and I
> > would really like switching to more valuable work than explaining again
> > and again that when a regression is introduced, it needs to be fixed (or
> > reverted in that case).
> 
> Yes please. This should have stopped right after "regression on basically
> every decent laptop out there" and we should be discussing how to fix the
> devices that actually need quirks because they're broken. Instead it 
> turned into a discussion on why we should stick with the regression and
> convince all of userspace to change and implement broken heuristics. I've
> used up my time budget for that.

Appreciated.

Also please note that it actually might help to make the decision.

Thanks,
Rafael

