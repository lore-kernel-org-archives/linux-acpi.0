From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to
 lid_init_state=open"
Date: Wed, 17 May 2017 16:16:40 +0200
Message-ID: <20170517141640.GB15333@mail.corp.redhat.com>
References: <CAJZ5v0jJ0SruFMp+v5ibcBnzctvjZF7U1w4+XThzFjwxTpdUUQ@mail.gmail.com>
 <20170515093752.GB11762@mail.corp.redhat.com>
 <CAJZ5v0iD33i4B+gFvKLOnLKB557eLx1yzFCJeiR6hghD9fmKeQ@mail.gmail.com>
 <20170515130531.GC11762@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA41F1@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA420E@SHSMSX101.ccr.corp.intel.com>
 <20170516071532.GD11762@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA4569@SHSMSX101.ccr.corp.intel.com>
 <20170516101030.GF11762@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA4C0A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753341AbdEQOQu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 May 2017 10:16:50 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA4C0A@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Eischmann <jeischma@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Lv,

[thank you Peter for jumping in the thread]

Just a few precisions regarding questions you asked:

On May 17 2017 or thereabouts, Zheng, Lv wrote:
[stripped]
> > [User space tools] *are* correct.
> > They are following the exported ACPI documentation
> 
> I doubt. In ACPI world, Windows is the only standard.

I was talking here about the i915 driver that uses the Linux ACPI
documentation in regard to the call of acpi_lid_open().
User space tool shouldn't rely on the _LID call through the sysfs if
acpi/button.c actaully forwards the ACPI call, because it is clear now
that it is not reliable in all situations.

> 
> > and the input node documentation.
> > Quoting the input doc:
> > file Documentation/input/event-codes.rst:
> > EV_SW
> > -----
> > 
> > EV_SW events describe stateful binary switches. For example, the SW_LID code is
> > used to denote when a laptop lid is closed.
> > 
> > Upon binding to a device or resuming from suspend, a driver must report
> > the current switch state. This ensures that the device, kernel, and userspace
> > state is in sync.
> > 
> > Upon resume, if the switch state is the same as before suspend, then the input
> > subsystem will filter out the duplicate switch state reports. The driver does
> > not need to keep the state of the switch at any time.
> > ----
> 
> That's really a convenient feature for driver.
> If I'm the driver writers, I would be very appreciated for being able to use such features.
> So you see I don't have objections to having this feature.

It's not a feature on how the system could be improved, it's the
definition of an input node that relay an EV_SW element. acpi/button.c
exports a LID_SW, so it has to conform to the definition. That is not
something we should be discussing.

> 
> I just have concerns related to:
> 1. Is it required to have a timeout in systemd, forcing platform to suspend again, just due to event delays?
> 2. Is it required to use SW_LID to determine whether an internal display should be lit on?
> I don't see any conflicts between the ABI of EV_SW and the 2 questions.

As Peter mentioned, the users of the switch are doing what they want.
But if you don't have the LID_SW input node, you can not know the state
of the laptop (opened or closed). So yes, it's there for a reason.

[stripped]

> > No. We can do whatever we want in libinput. And we can fix hardware when
> > it appears. We don't need to have the correct solution for everybody,
> > ever. libinput is a library and it can be updated, and we can ask users
> > to upgrade. We can even break the API by bumping the soname. We have
> > much more liberty that the kernel has, so the libinput implementation
> > shouldn't be a concern.
> 
> It seems you don't know all the details I was looking at.
> It's about a timing problem, with button.lid_init_state=method and libinput quirk, we actually have 2 quirks.
> And libinput write can appear before/after the faked init notification triggered by "method" mode.

See Peter's answer (nothing will happen in user-space), but I just
wanted to raised the fact that the "method" parameter doesn't trigger
"faked init notifications". The "method" parameter only syncs the state
with the hardware. And given this happens in the .resume() callback,
it means that users will have to wait for the resume to finish before
taking any action. So it's on their side that there is a problem if they
are reading the state before the kernel even had the chance to update
it.

[stripped]

> That sounds great!
> If systemd/logind can be changed, can we ask systemd/logind to change it to be longer enough.
> For example, allowing users to configure this to "INFINITE"?

I think they have a good reason but I never fully understood why they
have to poll on the state.

> That solves many other problems.
> 
> NOTE, EV_SW is a good feature to reduce duplicated events,
> but that doesn't mean users of EV_SW need to be so strict to the timings of SW_LID, right?

When an input event happens over evdev, it's expected that the user
treats it immediately.
In the LID_SW case we can somewhat tell user space that they need to be
extra careful, but they can argue that we should comply to the
definition of an input switch, or not exporting it at all.

[stripped]

> 
> > >    What's the root cause of this issue?
> > 
> > Poorly written EC?
> > It doesn't matter. We know the machine is buggy, we'll just need a
> > workaround.
> 
> It seems you know better than the SAMSUNG official supporters?

I wouldn't pretend to know more than Samsung engineers. All I see is
that there is an issue in the notification and/or the acpi _LID call, so
all I can say is that there is a bug in the firmware of the embedded
controller in charge of answering acpi calls.

> The 10-20 seconds lag can be seen even on Windows:
> http://www.samsung.com/uk/support/model/NP-N210-JP02UK
> 
> Since you seem to be able to see something I'm not aware of.
> Let me ask, which do you mean by using word "poorly", EC driver or EC firmware?

'Driver' implies in the kernel, and I never intended that there was such
a bug. If there is, then yes, I'd expect the people in charge of it to
fix it. But given the bug also happens in Windows, it's more likely that
it's a firmware issue, and it's the responsibility of Samsung to fix it.

I thought using EC was more precise that when talking about 'ACPI'
because ACPI can also be the project to support it under Linux, not the
FW itself.

> If it's EC driver, can you fix it?

I can't say I can fix anything. I don't have the machine and don't have
much time to dedicate to it. So no I guess.

> 
> > > 3. How can we generate the quirk for the following possible breakage:
> > >    No lid notification and _LID return cached open after boot/resume
> > 
> > "method" will fetch and report the cached _LID value as open, so there
> > is no breakage. Unless the lid is actually closed and the EC is plain
> > wrong, but that is something we can also explain to users or fix by an
> > other mean. But nothing generic will work. For instance, on the Surface
> > 3, the LID notification for open isn't forwarded, so I wrote a specific
> > driver to get the correct behavior based on a careful analysis of the
> > DSDT.
> 
> First, I couldn't see anything related to EC here but you kept on talking EC.
> Do you have personal feelings against EC?

For me EC == Embedded Controller == Firmware written in it that we both not
control (unless Intel writes part of it, which I am not aware of).
Sorry if EC means something else for you.

Cheers,
Benjamin

> 
> In fact, this is just a theoretical issue showing that something cannot be worked around by libinput when "method" is the default mode.
> I don't even know any platform acting in this way.
> But it is likely there are such platforms as the default "method" mode may cause them invisible to us.
> 
> The broken cases related to the timing are:
> 1. If libinput writes "close" after button driver sends initial notification using _LID return value:
>    For a platform that has no lid notification and _LID return cached "open" after boot/resume.
>    If such a system connects to an external monitor, and users configure to use external display, then
>    "open" will arrive user space programs first, thus internal monitor will be lit on and external one will be lit off.
>    Which is not what users want.
> 2. If libinput writes "close" before button driver sends initial notification using _LID return value:
>    For a platform that has no lid notification and _LID return cached "close" after boot/resume.
>    If such a system connects to an external monitor, and users configure to use internal display, then
>    "close" will arrive userspace programs first, thus internal monitor will be lit off and external one will be lit on.
>    Which is not what users want.
>    There are even more cases broken if libinput writes "close" before button driver sends initial notification using _LID return value.
> So either 1 or 2 will be broken.
> What I supposed was 1 would be broken thus I listed such theoretical platform.
> 
> Cheers,
> Lv
