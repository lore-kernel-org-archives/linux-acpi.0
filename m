From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Execute the _PTS method when system reboot
Date: Fri, 24 Jun 2016 14:36:02 +0200
Message-ID: <17478802.Gfb4ydscFk@vostro.rjw.lan>
References: <1462772495-71113-1-git-send-email-hehy1@lenovo.com> <CAJZ5v0iR6KU+Oy3iP5Ungw2cpqpmRBPw6fy26OL+cjFUnMJCUg@mail.gmail.com> <BCBE834BAC19744BA2C3AC4D68DBF2198D8ACDFB@CNMAILEX03.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46675 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751209AbcFXMbq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Jun 2016 08:31:46 -0400
In-Reply-To: <BCBE834BAC19744BA2C3AC4D68DBF2198D8ACDFB@CNMAILEX03.lenovo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Tanaka <dtanaka@lenovo.com>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>, "Zheng, Lv" <lv.zheng@intel.com>, Sumeet Kochar <skochar@lenovo.com>

On Friday, June 24, 2016 02:59:24 AM Ocean HY1 He wrote:
> 
> Regards,
> Ocean He
> SW Development Dept. 
> Beijing Design Center
> Enterprise Product Group
> Mobile: 18911778926
> E-mail: hehy1@lenovo.com
> No.6 Chuang Ye Road, Haidian District, Beijing, China 100085
> 
> 
> > -----Original Message-----
> > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
> > Rafael J. Wysocki
> > Sent: Thursday, June 23, 2016 9:13 PM
> > To: Ocean HY1 He
> > Cc: Rafael J. Wysocki; lenb@kernel.org; linux-acpi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; David Tanaka; Nagananda Chumbalkar
> > Subject: Re: [PATCH] ACPI: Execute the _PTS method when system reboot
> > 
> > On Thu, Jun 23, 2016 at 2:55 PM, Ocean HY1 He <hehy1@lenovo.com>
> > wrote:
> > > Hi Rafael,
> > > Please see my reply in below.
> > >
> > > Regards,
> > > Ocean He
> > > SW Development Dept.
> > > Beijing Design Center
> > > Enterprise Product Group
> > > Mobile: 18911778926
> > > E-mail: hehy1@lenovo.com
> > > No.6 Chuang Ye Road, Haidian District, Beijing, China 100085
> > >
> > >> -----Original Message-----
> > >> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > >> Sent: Wednesday, June 22, 2016 7:56 AM
> > >> To: Ocean HY1 He
> > >> Cc: lenb@kernel.org; linux-acpi@vger.kernel.org;
> > >> linux-kernel@vger.kernel.org; David Tanaka; Nagananda Chumbalkar
> > >> Subject: Re: [PATCH] ACPI: Execute the _PTS method when system
> > reboot
> > >>
> > >> On Monday, May 09, 2016 05:50:11 AM Ocean HY1 He wrote:
> > >> > The _PTS control method is defined in the section 7.4.1 of acpi 6.0
> > >> > spec. The _PTS control method is executed by the OS during the sleep
> > >> > transition process for S1, S2, S3, S4, and for orderly S5 shutdown.
> > >> > The sleeping state value (For example, 1, 2, 3, 4 or 5 for the S5
> > >> > soft-off state) is passed to the _PTS control method. This method
> > >> > is called after OSPM has notified native device drivers of the sleep
> > >> > state transition and before the OSPM has had a chance to fully
> > >> > prepare the system for a sleep state transition.
> > >> >
> > >> > The _PTS control method provides the BIOS a mechanism for
> > performing
> > >> > some housekeeping, such as writing the sleep type value to the
> > >> embedded
> > >> > controller, before entering the system sleeping state.
> > >> >
> > >> > According to section 7.5 of acpi 6.0 spec, _PTS should run after _TTS.
> > >> >
> > >> > Thus, a _PTS block notifier is added to the reboot notifier list so that
> > >> > the _PTS object will also be evaluated when the system reboot.
> > >>
> > >> So I understand why it may be necessary to evaluate _PTS before
> > entering
> > >> S5,
> > >> but I'm totally unsure about reboot.
> > >>
> > >> What does reboot have to do with S5?
> > >>
> > > In ACPI spec, there is no explicit words saying _PTS should be
> > > executed when reboot. But reboot could be equal to the
> > > process S0->S5->S0.
> > 
> > Not in general.
> > 
> > In particular, wakeup devices that would be set up for S5 need not be
> > set up for that.  Also the mechanism by which transitions to S5 are
> > entered is different from the reboot one, at least from the OS
> > perspective.
> > 
> > > Thus _PTS should be executed when reboot.
> > 
> > No, it doesn't follow.
> > 
> > > I am thinking this is the same as _TTS. In ACPI spec, there is also
> > > no explicit words saying _TTS should be executed when reboot.
> > > But kernel executes _TTS when reboot indeed.
> > 
> > Yes, it does.  Maybe it shouldn't?
> > 
> > It may not hurt to call _PTS before reboot too, but is it guaranteed
> > to work across the board on all systems everywhere?
> > 
> I try to clarify the key point of this case: does devices should go to S5(shutdown) when reboot?
> 
> I think the answer is yes. 
> And It has no hurt to let devices go to S5 before reboot is invoked, here is the reasons:

S5 is a platform (system) state, not a device state.

You seem to be confusing platforms with devices.

> #1 The new _PTS codes block nothing thus reboot can be guaranteed to be invoked eventually.
> #2. Devices are mandatory to support S5 state, this means go to S5 could be a safe trip.
> #3 Reboot would cause devices re-initialization from the scratch.
> 
> What's your decision then? ;-)

I guess you can argue that since _TTS is already executed in the reboot
path, it might be good to execute _PTS in that path too and that might help
to avoid issues in some cases.

That is a reasonable argument, but then there still is the question if that
is not going to break anything.

I guess that cannot be answered without trying, so the simplest patch would
be to add a _PTS evaulation to the existing notifier (and maybe change the
notifiers name to reflect the fact that it's not for _TTS ony any more).

Thanks,
Rafael

