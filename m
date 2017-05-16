From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to
 lid_init_state=open"
Date: Tue, 16 May 2017 12:10:30 +0200
Message-ID: <20170516101030.GF11762@mail.corp.redhat.com>
References: <2574646.jh0JF0mi0Y@aspire.rjw.lan>
 <20170515074553.GJ30987@mail.corp.redhat.com>
 <CAJZ5v0jJ0SruFMp+v5ibcBnzctvjZF7U1w4+XThzFjwxTpdUUQ@mail.gmail.com>
 <20170515093752.GB11762@mail.corp.redhat.com>
 <CAJZ5v0iD33i4B+gFvKLOnLKB557eLx1yzFCJeiR6hghD9fmKeQ@mail.gmail.com>
 <20170515130531.GC11762@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA41F1@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA420E@SHSMSX101.ccr.corp.intel.com>
 <20170516071532.GD11762@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA4569@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbdEPKKi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 May 2017 06:10:38 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA4569@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On May 16 2017 or thereabouts, Zheng, Lv wrote:
> Hi, Benjamin
> 
> > > > > > >> >> > > > > For example, such a hwdb entry is:
> > > > > > >> >> > > > > libinput:name:*Lid Switch*:dmi:*svnMicrosoftCorporation:pnSurface3:*
> > > > > > >> >> > > > >  LIBINPUT_ATTR_LID_SWITCH_RELIABILITY=write_open
> > > > > > >> >> Well, if it worked in a specific way that users depended on before the commit in
> > > > > > >> >> question and now it works differently, then it does break things.
> > > > > > >> >> Benjamin, my understanding is that this is the case, is it correct?
> > > > > > >> > That is correct. This patch I reverted introduces regression for professional
> > > > > > >> > laptops that expect the LID switch to be reported accurately.
> > > > > > >> And from a user's perspective, what does not work any more?
> > > > > > > If you boot or resume your laptop with the lid closed on a docking
> > > > > > > station while using an external monitor connected to it, both internal
> > > > > > > and external displays will light on, while only the external should.
> > > > > > > There is a design choice in gdm to only provide the greater on the
> > > > > > > internal display when lit on, so users only see a gray area on the
> > > > > > > external monitor. Also, the cursor will not show up as it's by default
> > > > > > > on the internal display too.
> > > > > > > To "fix" that, users have to open the laptop once and close it once
> > > > > > > again to sync the state of the switch with the hardware state.
> > > > > > OK
> > > > > > Yeah, that sucks.
> > > > > > So without the Lv's patch the behavior (on the systems in question) is
> > > > > > as expected, right?
> > > > > Yes, reverting these 2 patches restores the pre v4.11 kernel behavior.
> > > > I would make an argument that:
> > > > A. Is this necessarily a button driver regression?
> > > > 1. Users already configured to not using internal display, why gdm need to determine it again
> > instead
> > > > of users choice?
> > > > 2. Can gdm/graphics driver saves state before suspend, and restores saved state after resume?
> > > >    If users didn't change state during suspend, then everything should be correct.
> > > >    If users changed state during suspend, it should be acceptable for users to change it again to
> > make
> > > > the state correct.
> > > > See, this is obviously a case that is not so strictly related to ACPI button driver.
> > > > Why do we need to force button driver to marry external monitors.
> > > > B. Bug reporters are all ok with using quirk modes as boot parameters to work this around.
> > > > Why should we change our default behavior aimlessly?
> > >
> > > I have one more concern:
> > > In button.lid_init_state=method mode,
> > > Is that possible for libinput to work things around if _LID return value is not correct?
> > > How libinput ensures correct timing of overwriting the input node value?
> > > Will button driver faked event value overwrites what libinput has written?
> > >
> > > From this point of view, button.lid_init_state=ignore might be a better choice than
> > button.lid_init_state=method to allow libinput to deal with all kind of cases.
> > >
> > 
> > This is my last email on this topic, I don't even want to fully read/answer
> > the one in 1/2 given the amount of bad faith you put in that.
> 
> What's that?
> I mean, the bad faith?

I already explained 4 times why we need to revert these two patches and
why we need to keep 'method'. And you keep answering with long emails
that you would rather not. I call it bad faith, sorry.

> 
> > This is a REGRESSION. It used to work on thousands of devices, it
> > doesn't anymore. So any regression has to be chased down and no good
> > reason can justify such a regression.
> 
> I triggered many such kind of layered regressions and did fix them 1 by 1 in different places.
> However, this might be different.

No. It is a regression. It used to work for thousands of devices befor
v4.11, and now it's broken for those devices. It's a regression.

Some new devices are broken with "method", it's a bug, and we can't fix
them by regressing on all the others.

> Which depends on our agreement.
> 
> > The only solution is to revert both these changes. We can not ask user
> > space to fix a kernel regression, it's not how it works.
> 
> Yes, I know.
> We just asked users to use quirk modes of button driver.

I call this "fixing by users", and this is wrong. It used to work for
years for almost everybody, you can not ask users to fix this one by
one.

> And there is in fact always one of them working.

Yes, it's called a quirk. And the good practice is to register those
quirks and make them available to everybody. Being in hwdb in user space
or in acpi/button in kernel space doesn't matter, we need them.

> We haven't asked user space to change.
> We are just discussing the correctness of some user space behaviors.

They *are* correct. They are following the exported ACPI documentation
and the input node documentation. Quoting the input doc:
file Documentation/input/event-codes.rst:
EV_SW
-----

EV_SW events describe stateful binary switches. For example, the SW_LID code is
used to denote when a laptop lid is closed.

Upon binding to a device or resuming from suspend, a driver must report
the current switch state. This ensures that the device, kernel, and userspace
state is in sync.

Upon resume, if the switch state is the same as before suspend, then the input
subsystem will filter out the duplicate switch state reports. The driver does
not need to keep the state of the switch at any time.
----

So no, you can't have 'ignore' or 'open' to be the default, because user
space expects the switch to reflect the current state of the hardware. 

> 
> > You can not also change the semantic of an input switch. An input
> > switch, as per the input subsystem is supposed to forward an actual
> > state of the underlying hardware. Any fake information is bad and has to
> > be avoided.
> 
> Since fake events are harmful, why do we fake an event after boot/resume?
> button.lid_init_state=method seems can fake such an event.

We don't fake an event, we are syncing the input switch state with the
hardware.

Faking an event is when you send "switch is open" while you know there
is a possibility it's actually closed.

> 
> > I already gave you 2 solutions to fix the 7 machines you see that are
> > problematic, and you just seem to ignore them:
> > - revert to the v4.10 behavior and let libinput fix that for you
> 
> I already chose this.
> But I just raised a concern that button.lid_init_state=method could bring troubles to libinput quirks.

No. We can do whatever we want in libinput. And we can fix hardware when
it appears. We don't need to have the correct solution for everybody,
ever. libinput is a library and it can be updated, and we can ask users
to upgrade. We can even break the API by bumping the soname. We have
much more liberty that the kernel has, so the libinput implementation
shouldn't be a concern.

> 
> > - revert to the v4.10 behavior and have a quirk database in acpi/button
> > 
> > I also proposed to take maintainership on this particular module because
> > you said you were assigned this by default because you were the last
> > introducing changes in it. I asked you twice, and two times you replied
> > skipping this part.
> 
> I didn't, you just skipped PATCH 1/2 reply...
> Let me copy it from that email:
> =====
> Actually there is no special maintainership related to the button driver.
> All drivers of ACPI spec defined devices (PNPxxx stuffs) are maintained as a whole by Rafael.

I know, but there is the file MAINTAINER where you can add individual
maintainer per file. Rafael will still be the ACPI maintainer, providing
PR to Linus, but I'll just be the other goto-guy when people run
get_maintainer.pl on the acpi/button file.

> And we are helping him by doing triage on kernel Bugzilla.
> 
> There isn't a category on kernel Bugzilla related to lid issues.
> Probably you can help to create one under ACPI product.

That would be good to have such a category (maybe not LID, but input or
button to reflect the file name)

> If this can be achieved, you can be the default assignee for such issues.
> If this cannot be achieved, we'll just forward some lid reports to you first.

Please do.

> Please tell me which product/component you'd prefer for us to forward.

I'd be happy to be redirected anything input related.

> 
> For modifying acpi/button.c, it's open source, you can send patches and ACPI community can help to review.

Which I already did. My concern is more when there is a change I am not
aware of which introduces regressions and which I could have provided a
valid NACK early enough.

> =====
> 
> > It's clear you don't want to revert to the old state, and even if I can
> > prove to you that you have to, you don't listen.
> > So please, do not force me to call the maintainers and Linus on this
> > simple 2 reverts.
> 
> No, I currently cannot persuade myself to revert to "method" mode.
> But that doesn't mean I don't want to or I want to.
> You just didn't prove that by answering my questions in PATCH 1/2 and in this email.
> Especially:
> 1. After reverting to "method" mode, can libinput work all cases around?

If it doesn't, we'll fix it. So yes, it will eventually.

>    Are there any timing issues that can prevent libinput from working some sucks around.
>    Considering this case, it's likely such problems can happen.
>    https://bugzilla.kernel.org/show_bug.cgi?id=106151

logind has a delay between the time it starts and the time it starts
polling the lid switch state. The default value is a little bit too
short on Fedora considering the faulty devices are running small CPUs.
But this can be changed as wish by the user and by systemd. They told us
they took one arbitrary value by default, and we can change it.

We can ask systemd/logind to change part of the behavior for new devices
when there is a bug. But we can't ask them to change the whole design
because there is a regression in the kernel.

> 2. Who should be responsible for fixing this issue after reverting to "method" mode:
>    https://bugzilla.kernel.org/show_bug.cgi?id=106151

libinput will change the value to open given the heuristics we have.

>    What's the root cause of this issue?

Poorly written EC?
It doesn't matter. We know the machine is buggy, we'll just need a
workaround.

> 3. How can we generate the quirk for the following possible breakage:
>    No lid notification and _LID return cached open after boot/resume

"method" will fetch and report the cached _LID value as open, so there
is no breakage. Unless the lid is actually closed and the EC is plain
wrong, but that is something we can also explain to users or fix by an
other mean. But nothing generic will work. For instance, on the Surface
3, the LID notification for open isn't forwarded, so I wrote a specific
driver to get the correct behavior based on a careful analysis of the
DSDT.

Cheers,
Benjamin

> 
> Cheers,
> Lv
