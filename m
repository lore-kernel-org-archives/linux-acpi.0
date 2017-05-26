From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to
 lid_init_state=open"
Date: Fri, 26 May 2017 17:39:53 +1000
Message-ID: <20170526073953.GA29786@jelly>
References: <20170524080830.GE13096@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:19013 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936863AbdEZHmH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 May 2017 03:42:07 -0400
Content-Disposition: inline
In-Reply-To: <20170524080830.GE13096@mail.corp.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On May 25 2017, Benjamin Tissoires wrote:
> On May 15 2017 or thereabouts, Rafael J. Wysocki wrote:

> > >> >> Benjamin, my understanding is that this is the case, is it correct?
> > >> >
> > >> > That is correct. This patch I reverted introduces regression for professional
> > >> > laptops that expect the LID switch to be reported accurately.
> > >>
> > >> And from a user's perspective, what does not work any more?
> > >
> > > If you boot or resume your laptop with the lid closed on a docking
> > > station while using an external monitor connected to it, both internal
> > > and external displays will light on, while only the external should.
> > >
> > > There is a design choice in gdm to only provide the greater on the
> > > internal display when lit on, so users only see a gray area on the
> > > external monitor. Also, the cursor will not show up as it's by default
> > > on the internal display too.
> > >
> > > To "fix" that, users have to open the laptop once and close it once
> > > again to sync the state of the switch with the hardware state.
> >
> > OK
> >
> > Yeah, that sucks.
> >
> > So without the Lv's patch the behavior (on the systems in question) is
> > as expected, right?
> 
> Would you agree to take both these reverts without Lv's ACK? We already
> tried to explain for 2 weeks that they are valuable, but it seems we
> can't make change his mind.
> 
> I have more that 26 emails in my INBOX (not counting my replies) and I
> would really like switching to more valuable work than explaining again
> and again that when a regression is introduced, it needs to be fixed (or
> reverted in that case).

Yes please. This should have stopped right after "regression on basically
every decent laptop out there" and we should be discussing how to fix the
devices that actually need quirks because they're broken. Instead it 
turned into a discussion on why we should stick with the regression and
convince all of userspace to change and implement broken heuristics. I've
used up my time budget for that.

Cheers,
   Peter
