From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: RE: [PATCH 2/2] Revert "ACPI / button: Change default behavior to
 lid_init_state=open"
Date: Wed, 17 May 2017 21:54:27 +1000
Message-ID: <20170517115427.GA32482@jelly>
References: <1AE640813FDE7649BE1B193DEA596E886CEA4C0A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA4C0A@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Lv

> > Yes, it's called a quirk. And the good practice is to register those
> > quirks and make them available to everybody. Being in hwdb in user space
> > or in acpi/button in kernel space doesn't matter, we need them.
> 
> I have no objections but concerns related to the combination of "default mode" and "quirk responsibles".
> From my point of view, these are my conclusions:
> 1. If you want to use libinput to generate quirks, you should use "ignore"
> rather than "method" mode as default mode;

libinput does not replace the kernel. libinput can help with some
heuristics, but that should be the exception, not the default. And
heuristics cannot detect some cases, ignore suffers from that problem (see
below).

> 2. If you want to use button driver to generate quirks, we need "close" mode;
> 3. If GDM can change or users are ok use command lines, we can remain to use "open" as the default behavior.
> (I'll send technical details in private about these conclusions)
> But you seem to always:
> 1. Say no to "ignore" which makes 1 impossible;

as an outsider, 'ignore' makes me wonder: Why wouldn't you query the state
of the hardware if it lets you? That's what we do in userspace with EV_SW.
We don't just rely on the notification, we look at the state of it too.

sure, some hardware is buggy and we can somehow work around this but that's
not a reason to throw everyone else under the bus too.

> 2. Say no to "close" which makes 2 impossible;

'close' forces userspace to fix up the kernel in every case rather than for
those devices where method doesn't work correctly. That's just effectively
deciding to be always the least wrong just to avoid a few outliers.
(also, if the kernel is always wrong, what purpose does it serve? :)

> 3. Say no to "open" which makes 3 impossible.

as mentioned above, some things we cannot detect.
we cannot detect a false-open with heuristics, this makes it impossible to
fix with heuristics in userspace. for 'close' and 'method' we can take user
input as indication that the lid isn't as closed as it pretends to be. That
doesn't work the other way round, lack of user input does not imply the
lid is closed.

> > > We haven't asked user space to change.
> > > We are just discussing the correctness of some user space behaviors.
> >
> > They *are* correct.
> > They are following the exported ACPI documentation
> 
> I doubt. In ACPI world, Windows is the only standard.

ok, here I need to note something: ACPI doesn't matter to userspace.
the kernel has EV_SW/SW_LID, which is *not* ACPI. that promises that a
userspace can assume that if SW_LID is 1, then the lid is closed,
otherwise it's open. Some leeway can be given because, well, reality, 
but a userspace behaviour to assume a lid is closed when the lid switch is
set to that state should not be up for discussion.
 
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
> 
> I just have concerns related to:
> 1. Is it required to have a timeout in systemd, forcing platform to suspend again, just due to event delays?
> 2. Is it required to use SW_LID to determine whether an internal display should be lit on?
> I don't see any conflicts between the ABI of EV_SW and the 2 questions.

the ABI of EV_SW? that's just evdev. It seems you're discussing three, four
things simultaneously, ACPI, the button driver, the evdev switch API and
userspace behaviour in response to this whole thread. The simple answer is:
the last bit doesn't matter - if EV_SW/SW_LID is on, the lid can be assumed
to be closed.

How you get to this point is your side of the problem :)
And I'm willing to accommodate for some issues (see the heuristics benjamin
already mentioned) but they should be exception, not the rule.

but whether e.g. displays are lit or not has nothing to do with this
discussion, it just doesn't matter what userspace does with the information.

> > So no, you can't have 'ignore' or 'open' to be the default, because user
> > space expects the switch to reflect the current state of the hardware.
> 
> Then what's the benefit of having 'method' to be the default,
> Given it is still not able to reliably deliver the current state of hardware?

isn't this just a case of: method is less wrong than ignore? 100%
reliability is not possible given the hardware available on the market, but
it seems that 'method' is the least wrong of them, followed by ignore,
trailed by open and close.

> Actually both 'ignore/open/method' modes are trying to be compliant to EV_SW.

"compliant to EV_SW" just means "SW_LID state reflects state of the
hardware", right?

> Among them, "ignore" did the best IMO.

how did ignore do better than method? what devices give you an incorrect
state but send you a correct notification later? And even then it would only
matter for 50% of the cases anyway, because a false state of open first
followed by a close notification later wouldn't matter.

> And cases broken in "ignore" mode but not broken in "method" mode are all issues:
>  - Platform doesn't send notification after boot/resume.
>    IMO, we should also collect them and indicate them to desktop managers.
> 
> So in the end, we just have differences related to picking which default mode.
> 
> > > > You can not also change the semantic of an input switch. An input
> > > > switch, as per the input subsystem is supposed to forward an actual
> > > > state of the underlying hardware. Any fake information is bad and has to
> > > > be avoided.
> > > Since fake events are harmful, why do we fake an event after boot/resume?
> > > button.lid_init_state=method seems can fake such an event.
> > We don't fake an event, we are syncing the input switch state with the
> > hardware.
> > Faking an event is when you send "switch is open" while you know there
> > is a possibility it's actually closed.
> 
> No we are faking events in this mode.
> _LID can return cached state, and:
> 1. it might be "close" while LID is "open" after suspend.
> 2. it might be "open" while LID is "close" after suspend.
> In this case, it explains the side effect of having type 1 fake event:
> https://bugzilla.kernel.org/show_bug.cgi?id=106151
> If we don't evaluate _LID and send such a "close", the platform can
> correctly send "open" just with a delay.

side-note: _LID and LID makes for confusing reading. _LID is ACPI and LID is
SW_LID? 

if acpi/the hw gives you an incorrect cached state, you'll need to quirk
*that* hardware, because it's more broken than others.

> > > > I already gave you 2 solutions to fix the 7 machines you see that are
> > > > problematic, and you just seem to ignore them:
> > > > - revert to the v4.10 behavior and let libinput fix that for you
> > >
> > > I already chose this.
> > > But I just raised a concern that button.lid_init_state=method could bring troubles to libinput
> > quirks.
> >
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
> Causing some cases not workaroundable.
> See below for details.

see below for answers, but basically:
if libinput writes the correct state before the notification arrives,
*nothing* happens in userspace. The kernel filters duplicate events, so even
if libinput sets the state before the kernel driver does, userspace won't
receive an event.
 
> > > No, I currently cannot persuade myself to revert to "method" mode.
> > > But that doesn't mean I don't want to or I want to.
> > > You just didn't prove that by answering my questions in PATCH 1/2 and in this email.
> > > Especially:
> > > 1. After reverting to "method" mode, can libinput work all cases around?
> > If it doesn't, we'll fix it. So yes, it will eventually.
> 
> That's great.
> 
> > >    Are there any timing issues that can prevent libinput from working some sucks around.
> > >    Considering this case, it's likely such problems can happen.
> > >    https://bugzilla.kernel.org/show_bug.cgi?id=106151
> >
> > logind has a delay between the time it starts and the time it starts
> > polling the lid switch state. The default value is a little bit too
> > short on Fedora considering the faulty devices are running small CPUs.
> > But this can be changed as wish by the user and by systemd. They told us
> > they took one arbitrary value by default, and we can change it.
> >
> > We can ask systemd/logind to change part of the behavior for new devices
> > when there is a bug. But we can't ask them to change the whole design
> > because there is a regression in the kernel.
> 
> That sounds great!
> If systemd/logind can be changed, can we ask systemd/logind to change it to be longer enough.
> For example, allowing users to configure this to "INFINITE"?
> That solves many other problems.
> 
> NOTE, EV_SW is a good feature to reduce duplicated events,
> but that doesn't mean users of EV_SW need to be so strict to the timings of SW_LID, right?
> 
> If it can be configured to "INFINITE", with "ignore" mode,
> systemd/logind should always be able to see an "open" event before seeing a new BIOS triggered "close" events.
> 
> So why do you refuse the possibilities of using "open/ignore" as default modes?
> 
> > > 2. Who should be responsible for fixing this issue after reverting to "method" mode:
> > >    https://bugzilla.kernel.org/show_bug.cgi?id=106151
> >
> > libinput will change the value to open given the heuristics we have.
> 
> Yes, I see.
> But I also can see one broken case cannot be worked around by libinput if you insist to use "method".
> 
> > >    What's the root cause of this issue?
> >
> > Poorly written EC?
> > It doesn't matter. We know the machine is buggy, we'll just need a
> > workaround.
> 
> It seems you know better than the SAMSUNG official supporters?
> The 10-20 seconds lag can be seen even on Windows:
> http://www.samsung.com/uk/support/model/NP-N210-JP02UK
> 
> Since you seem to be able to see something I'm not aware of.
> Let me ask, which do you mean by using word "poorly", EC driver or EC firmware?
> If it's EC driver, can you fix it?
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

let's not go down that type of discussion please...

> In fact, this is just a theoretical issue showing that something cannot be
> worked around by libinput when "method" is the default mode.
> I don't even know any platform acting in this way.
> But it is likely there are such platforms as the default "method" mode may
> cause them invisible to us.

note: it may be likely, but it's a *definitive* that existing platforms
break with the current 'open'...

> The broken cases related to the timing are:
> 1. If libinput writes "close" after button driver sends initial notification using _LID return value:

This is a theoretical case only. libinput does not write close, ever.
because there is no heuristics we can use that can guarantee that the lid is
closed (well, short of enabling the camera and checking if it looks really
dark, but let's not do that ;)

>    For a platform that has no lid notification and _LID return cached "open" after boot/resume.
>    If such a system connects to an external monitor, and users configure to use external display, then
>    "open" will arrive user space programs first, thus internal monitor will be lit on and external one will be lit off.
>    Which is not what users want.
> 2. If libinput writes "close" before button driver sends initial notification using _LID return value:

see 1, libinput does not write 'close'.

also, just in case that's not obvious yet: libinput behaviour is a) internal
to libinput and b) tailored to the hardware. The current behaviour works for
the devices we've needed to fix. We can change that at any time and we can
add other behaviours at any time. So even if some theoretical platforms
appear that do the wrong thing - we can deal with it then and figure out.

note also, that the only reason libinput even writes the switch event to the
event node is because we are nice to others. We have that information (user
is typing, therefore lid is not closed) so we share it with anyone else by
changing the device's state. This way other processes can pick it up,
without needing the same heuristics.

Cheers,
   Peter

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
