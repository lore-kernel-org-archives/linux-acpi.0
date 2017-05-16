From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to
 lid_init_state=open"
Date: Tue, 16 May 2017 09:15:32 +0200
Message-ID: <20170516071532.GD11762@mail.corp.redhat.com>
References: <20170511094551.GF30987@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA2CC4@SHSMSX101.ccr.corp.intel.com>
 <2574646.jh0JF0mi0Y@aspire.rjw.lan>
 <20170515074553.GJ30987@mail.corp.redhat.com>
 <CAJZ5v0jJ0SruFMp+v5ibcBnzctvjZF7U1w4+XThzFjwxTpdUUQ@mail.gmail.com>
 <20170515093752.GB11762@mail.corp.redhat.com>
 <CAJZ5v0iD33i4B+gFvKLOnLKB557eLx1yzFCJeiR6hghD9fmKeQ@mail.gmail.com>
 <20170515130531.GC11762@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA41F1@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA420E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdEPHPj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 May 2017 03:15:39 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA420E@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On May 16 2017 or thereabouts, Zheng, Lv wrote:
> Hi,
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Zheng,
> > Lv
> > Subject: RE: [PATCH 2/2] Revert "ACPI / button: Change default behavior to lid_init_state=open"
> > 
> > Hi, Guys
> > 
> > > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > > Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to lid_init_state=open"
> > >
> > > On May 15 2017 or thereabouts, Rafael J. Wysocki wrote:
> > > > On Mon, May 15, 2017 at 11:37 AM, Benjamin Tissoires
> > > > <benjamin.tissoires@redhat.com> wrote:
> > > > > On May 15 2017 or thereabouts, Rafael J. Wysocki wrote:
> > > > >> On Mon, May 15, 2017 at 9:45 AM, Benjamin Tissoires
> > > > >> <benjamin.tissoires@redhat.com> wrote:
> > > > >> > On May 12 2017 or thereabouts, Rafael J. Wysocki wrote:
> > > > >> >> On Friday, May 12, 2017 02:36:20 AM Zheng, Lv wrote:
> > > > >> >> > Hi,
> > > > >> >> >
> > > > >> >> > > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > > > >> >> > > Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to
> > > lid_init_state=open"
> > > > >> >> > >
> > > > >> >> > > On May 11 2017 or thereabouts, Zheng, Lv wrote:
> > > > >> >> > > > Hi,
> > > > >> >> > > >
> > > > >> >> > > > > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > > > >> >> > > > > Subject: [PATCH 2/2] Revert "ACPI / button: Change default behavior to
> > > lid_init_state=open"
> > > > >> >> > > > >
> > > > >> >> > > > > This reverts commit 77e9a4aa9de10cc1418bf9a892366988802a8025.
> > > > >> >> > > > >
> > > > >> >> > > > > Even if the method implementation can be buggy on some platform,
> > > > >> >> > > > > the "open" choice is worse. It breaks docking stations basically
> > > > >> >> > > > > and there is no way to have a user-space hwdb to fix that.
> > > > >> >> > > > >
> > > > >> >> > > > > On the contrary, it's rather easy in user-space to have a hwdb
> > > > >> >> > > > > with the problematic platforms. Then, libinput (1.7.0+) can fix
> > > > >> >> > > > > the state of the LID switch for us: you need to set the udev
> > > > >> >> > > > > property LIBINPUT_ATTR_LID_SWITCH_RELIABILITY to 'write_open'.
> > > > >> >> > > > >
> > > > >> >> > > > > When libinput detects internal keyboard events, it will
> > > > >> >> > > > > overwrite the state of the switch to open, making it reliable
> > > > >> >> > > > > again. Given that logind only checks the LID switch value after
> > > > >> >> > > > > a timeout, we can assume the user will use the internal keyboard
> > > > >> >> > > > > before this timeout expires.
> > > > >> >> > > > >
> > > > >> >> > > > > For example, such a hwdb entry is:
> > > > >> >> > > > >
> > > > >> >> > > > > libinput:name:*Lid Switch*:dmi:*svnMicrosoftCorporation:pnSurface3:*
> > > > >> >> > > > >  LIBINPUT_ATTR_LID_SWITCH_RELIABILITY=write_open
> > > > >> >> > > >
> > > > >> >
> > > > >> > [...]
> > > > >> >
> > > > >> >>
> > > > >> >> Well, if it worked in a specific way that users depended on before the commit in
> > > > >> >> question and now it works differently, then it does break things.
> > > > >> >>
> > > > >> >> Benjamin, my understanding is that this is the case, is it correct?
> > > > >> >
> > > > >> > That is correct. This patch I reverted introduces regression for professional
> > > > >> > laptops that expect the LID switch to be reported accurately.
> > > > >>
> > > > >> And from a user's perspective, what does not work any more?
> > > > >
> > > > > If you boot or resume your laptop with the lid closed on a docking
> > > > > station while using an external monitor connected to it, both internal
> > > > > and external displays will light on, while only the external should.
> > > > >
> > > > > There is a design choice in gdm to only provide the greater on the
> > > > > internal display when lit on, so users only see a gray area on the
> > > > > external monitor. Also, the cursor will not show up as it's by default
> > > > > on the internal display too.
> > > > >
> > > > > To "fix" that, users have to open the laptop once and close it once
> > > > > again to sync the state of the switch with the hardware state.
> > > >
> > > > OK
> > > >
> > > > Yeah, that sucks.
> > > >
> > > > So without the Lv's patch the behavior (on the systems in question) is
> > > > as expected, right?
> > > >
> > >
> > > Yes, reverting these 2 patches restores the pre v4.11 kernel behavior.
> > 
> > I would make an argument that:
> > A. Is this necessarily a button driver regression?
> > 1. Users already configured to not using internal display, why gdm need to determine it again instead
> > of users choice?
> > 2. Can gdm/graphics driver saves state before suspend, and restores saved state after resume?
> >    If users didn't change state during suspend, then everything should be correct.
> >    If users changed state during suspend, it should be acceptable for users to change it again to make
> > the state correct.
> > See, this is obviously a case that is not so strictly related to ACPI button driver.
> > Why do we need to force button driver to marry external monitors.
> > B. Bug reporters are all ok with using quirk modes as boot parameters to work this around.
> > Why should we change our default behavior aimlessly?
> 
> I have one more concern:
> In button.lid_init_state=method mode,
> Is that possible for libinput to work things around if _LID return value is not correct?
> How libinput ensures correct timing of overwriting the input node value?
> Will button driver faked event value overwrites what libinput has written?
> 
> From this point of view, button.lid_init_state=ignore might be a better choice than button.lid_init_state=method to allow libinput to deal with all kind of cases.
> 

This is my last email on this topic, I don't even want to fully read/answer
the one in 1/2 given the amount of bad faith you put in that.

This is a REGRESSION. It used to work on thousands of devices, it
doesn't anymore. So any regression has to be chased down and no good
reason can justify such a regression.

The only solution is to revert both these changes. We can not ask user
space to fix a kernel regression, it's not how it works.

You can not also change the semantic of an input switch. An input
switch, as per the input subsystem is supposed to forward an actual
state of the underlying hardware. Any fake information is bad and has to
be avoided.

I already gave you 2 solutions to fix the 7 machines you see that are
problematic, and you just seem to ignore them:
- revert to the v4.10 behavior and let libinput fix that for you
- revert to the v4.10 behavior and have a quirk database in acpi/button

I also proposed to take maintainership on this particular module because
you said you were assigned this by default because you were the last
introducing changes in it. I asked you twice, and two times you replied
skipping this part.

It's clear you don't want to revert to the old state, and even if I can
prove to you that you have to, you don't listen.

So please, do not force me to call the maintainers and Linus on this
simple 2 reverts.

Cheers,
Benjamin
