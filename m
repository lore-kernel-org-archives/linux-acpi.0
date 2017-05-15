From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method
 mode"
Date: Mon, 15 May 2017 09:42:28 +0200
Message-ID: <20170515074228.GI30987@mail.corp.redhat.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
 <20170510161240.13229-2-benjamin.tissoires@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA1260@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA129E@SHSMSX101.ccr.corp.intel.com>
 <20170511101240.GG30987@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA2D9B@SHSMSX101.ccr.corp.intel.com>
 <20170512095028.GH30987@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA3937@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbdEOHmi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 May 2017 03:42:38 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA3937@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Lv,

On May 15 2017 or thereabouts, Zheng, Lv wrote:
> Hi, Benjamin
> 
> Let's stop endless discussing and focus on our needs.
> 
> I just copied my questions here.
> You can ask them directly.
> For the below inlined replies, I'll stop replying if they are based on dependent on our basic agreements.
> And I'll reply if something is really bad from my point of view.
> 
> My point of view is:
> There is a gap between (BIOS ensured/Windows expected) acpi control method lid device behavior and Linux user space expected acpi control method lid device behavior.
> Button driver default behavior should be: button.lid_init_state=ignore
> If user space programs have special needs, they can fix problems on their own, via the following mean:
>  echo -n "open" > /sys/modules/button/parameters/lid_init_state
>  echo -n "close" > /sys/modules/button/parameters/lid_init_state
> Keeping open/close modes is because I don't think there is any bug in button driver.
> So I need to prepare quirk modes from button driver's point of view and use them as a response to related bug reports reported in acpi community.
> Your point of view is:
> There is a gap between (BIOS ensured/Windows expected) acpi control method lid device behavior and Linux user space expected acpi control method lid device behavior.

Yep. But our role, as kernel developers, is to not break user space even
if they made wrong design choices.

> Button driver default behavior should be (not 100% sure if this is your opinion): button.lid_init_state=method

Yes, I'd like to revert to the old behavior (see below for a rationale).

> If user space programs have special needs, they can fix them on their own, via the following mean:
>  libinput:name:*Lid Switch*:dmi:*svnMicrosoftCorporation:pnSurface3:*
>   LIBINPUT_ATTR_LID_SWITCH_RELIABILITY=write_open
> From this point of view, we actually don't need open/close modes.

We don't need close, but we need to keep open, for 2 reasons I'll detail
below.

> 
> It seems we just need to determine the following first:
> 1. Who should be responsible for solving bugs triggered by the conflict between bios and linux user space expectations:
>    button driver? libinput? Some other user space programs? Users?

Hopefully libinput or systemd (through a udev rule). If things gets
worse a acpi/button quirk might be used, but in a second time.

> 2. What should be the default button driver behavior?
>    button.lid_init_state=ignore? button.lid_init_state=method?

button.lid_init_state=method:
- this was the old default state, and switching to something else
  creates regression
- the lid switch input node is an EV_SWITCH. And this has a state we
  need to synchronise with the hardware first. The default EV_SW state
  is closed, so if we do not sync it first, we might report wrong state
  to user space.

> 3. If non button driver quirks are working, button driver quirk modes are useless.
>    The question is: Should button.lid_init_state=open/close be kept?

We should keep button.lid_init_state=open:
- it's kernel API now, so you can't remove it without breaking users
  configuration
- it helps booting laptops that are not known to be working, the time
  the user installs the distribution and add the hwdb entry to fix it.

we should not keep button.lid_init_state=close:
- I don't see a good use case where it is needed, besides debugging
  drivers that should be debugged in an other way.

> 4. From button driver's point of view, button.lid_init_state=ignore seems to be always correct, so we won't abandon it.

We can keep it, and we should, it's kernel API

>    If we can use libinput to manage platform quirks, then button.lid_init_state=method also looks useless.

No. 'method' is the only way to guarantee the exported input node is
synced properly with the actual physical world.

>    The question is: Should button.lid_init_state=method be kept?

Definitively.

> 
> I should also let you know my preference:
> 1. using button.lid_init_state=ignore and button.lid_init_state=method as default behavior is ok for me if answer to 1 is not button driver, otherwise using button.lid_init_state=method is not ok for me
> 2. deletion of button.lid_init_state=open/close is ok for me if answer to 1 is not button driver, otherwise deletion of button.lid_init_state=open/close is not ok for me
> 3. deletion of button.lid_init_state=method is always ok for me
> 
> See the base line from my side is very clear:
> If acpi community need to handle such bug reports, button.lid_init_state=method cannot be the default behavior.

I already proposed to handle those reports. I don't see why you are
concerned about those future reports.

> We are just using a different default behavior than "method" to drive things to reach the final root caused solution.
> 
> Could you let me know your preference so that we can figure out an agreement between us.
> Though I don't know if end users will buy it (they may keep on filing regression reports in ACPI community).

Switching back to button.lid_init_state=method will prevent regressions
to be filled. If a user buys a new machine and the LID switch doesn't
work as expected, it's not a regression, it's a bug. Regression is
something we absolutely need to avoid, and switching to
button.lid_init_state=open introduced far too many regressions on
systems.

> 
> > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > Subject: Re: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method mode"
> 
> > ...
> Skip as it looks the result of debating here can also be concluded from the answers of the questions.
> Let's just stop arguing same thing again and again using different contexts.
> 
> > > > make reasonable assumptions based on the exact
> > > > model capabilities (is the power button accessible with the LID closed),
> > >
> > > Sounds it's always accessible.
> > 
> > hmm, I am not sure we have the same fingers.... For me on all the
> > laptops I have seen, if the LID is actually (physically) closed, I can
> > not press the button. It's a design choice to not have anything powering
> > on the laptop when it's in your bag.
> 
> Wow...
> I can see that recent laptops are having their power buttons on the edge, not on the keypad.
> For recent laptop/tablet 2-in-1 PCs or touch laptops which can have their keyboards folded and act notebooks, the power buttons are obviously not on the detachable keypads.

Right. I forgot about this new class of tablets/convertible. I was
probably too focused on the professional laptops.

> Also for the laptops supporting external monitors, obviously allow users to push power buttons while the lid is closed.

Well, on the Thinkpads (and Fujitsu from what I can tell), this
situation can happen because there is a physical power button on the
docking station itself.

> 
> > ...
> Skip as it looks the result of debating here can also be concluded from the answers of the questions.
> 
> 
> > > > The issue we are fixing here is the fact that the switch state is wrong,
> > > > which makes user space assumptions wrong too (and users angry).
> > >
> > > Considering no platform quirks.
> > >
> > > If ACPI button driver sends SW_LID, users are likely angry.
> > > Unless the user space programs are changed to "ignore open event".
> > >
> > > If ACPI button driver doesn't send switch events, but key events.
> > > The user space programs need to change to handle the new events.
> > >
> > > So finally whatever we do, user space need to change a bit related to ACPI control method lid device.
> > 
> > Or we fix the switch to report accurate events/state.
> > You do realise that all the energy you are spending, answering to me,
> > talking to user space maintainers, users, all comes down to the fact
> > that you refuse to have hardware quirks?
> > 
> > If you don't want to write/maintain the code, fine. I can do it, but
> > please stop trying to make everyone else change because you just don't
> > want the burden of quirking a handful of laptops.
> 
> But I have a very interesting question to ask:
> Can button driver/libinput actually fix this without modifying BIOS:
> 
> It seems we both rely on user's decision to use proper quirk modes for a specific usage model.
> For example, for this case:
>  A BIOS never sends lid notification after boot/resume, and _LID return value is close after boot/resume.

It used to work for years (_LID return value is correct on most laptops
after boot/resume).

> Let's see which quirk mode should the user choose before suspending:
> 1. with no external monitor attached, user should:
>     write_open/button.lid_init_state=open
> 2. with external monitor attached, if user wants the lid to be lit on
>     write_open/button.lid_init_state=open
> 3. with external monitor attached, if user wants the lid not to be lit on
>     write_close/button.lid_init_state=close
> See there is no single default value for all usage models.

No. Users shouldn't interact with kernel parameters. The kernel
parameter can help them to boot the system if the user space is not able
to fix the situation. But in any case, end users should not have to deal
with kernel parameters.

> 
> Thus there is no possible __FIX__ for acpi button driver and libinput.

I never talked about a fix. I know the situation is unsolvable, which is
why I talked about quirks or workarounds.

> While user space programs can just fix their usage models.

You can't expect user space to change anything from the kernel point of
view without a long enough warning.

> 
> So finally we actually cannot fix anything by maintaining the quirk table, but just create a business of maintaining the quirk table.

Yes, but I never asked you to maintain such table. I am volunteering to
do that if needed.

> 
> > ...
> Skip as it looks the result of debating here can also be concluded from the answers of the questions.
> 
> > > > > However, is that possible to not introduce platform quirks?
> > > > > For example, for systemd:
> > > > > If it detected ACPI lid device, automatically switch to an "IgnoreLidOpenEvent" mode (like
> > nouveau
> > > > drivers' ignorelid=Y option).
> > > >
> > > > Well, given that 99.9% of laptops have this ACPI lid button, you'll just
> > > > remove the feature from all laptops.
> > >
> > > No, I only removed the wrong usage models related to the strict "open" event.
> > > All laptops are still capable of sending correct "close" event.
> > 
> > My bad, I read too fast and missed the "...Open..." part of
> > "IgnoreLidOpenEvent".
> > 
> > Though I am not sure IgnoreLidOpenEvent is accurate.
> > "OpenEventNeverSent" seems to reflect more the reality. But again,
> > that's not of our (kernel developers) business.
> 
> IMO this is the only root cause fix. :)
> It's the only way that the user can use without changing its quirk modes for different usage models.

Yes and no. There is a design issue in logind, but this is based on the
design choice made in acpi/button: we use an input switch. A switch has
a state, and the kernel ought to report correct state. With this in
mind, the design choice in logind is correct. But now we are
seeing that some OEM are not providing everything we need, and we need
to find the solution.

> 
> > > So I already raised this to freedesktop:
> > > https://bugs.freedesktop.org/show_bug.cgi?id=100923
> > > But couldn't see any one there responding.
> > 
> > Well, Joachim answered, saying that there is likely a regression in
> > acpi/button.c, not in i915.
> 
> He surely can add more details as he is responsible of triage of the referenced bug reported on redhat.

(Joachim doesn't work for Red Hat, from what I can tell).

> But there is no agreement reached yet.
> 
> > > > > Can it determine that by its own without listening to the lid key events?
> > > >
> > > > Basically no. This switch is there for a reason. However, I am convinced
> > > > that a good heuristic is to say that if you are using the internal keyboard,
> > > > touchscreen or touchpad, unless the user has very very thin fingers, the
> > > > lid is open.
> > >
> > > I'm also convinced that the benefit of having a file in sysfs/procfs to allow user to know if the
> > lid is open is marginal.
> > 
> > I am convinced I don't get your point. We are obviously not talking
> > about the same thing here. I was talking about the physical world, where
> > the user interact with the laptop...
> 
> See my previous reply against accessing power buttons when lid is closed.
> 
> > ...
> Skip as it looks the result of debating here can also be concluded from the answers of the questions.
> 
> > > But it's just 1-2 months Bugzilla silence before seeing a different bug flood trend:
> > > This time, they are related to the external monitor usage model:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=187271
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1430259
> > > https://bugzilla.kernel.org/show_bug.cgi?id=195455
> > > Now that you can see why I didn't send a patch to change the default behavior to "open" at the time
> > we were discussing.
> > > That's also why I think we needn't revert back to "method" as the default behavior.
> > 
> > Still, I strongly disagree. We do not fix 7 devices by breaking
> > hundreds. That's just not how the kernel work.
> 
> No. The word of "broken" is entirely wrong and emotional here.

Yes. There was bug before, and now there are regressions.

> If both user space and kernel space are changed to act according to button.lid_init_state=ignore.

Again, you can't expect a good synchronisation between kernel space and
user space without regressing some configurations (yes, it's a pain).

> No one will be broken.

'ignore' is not the solution, see above for the rationale.

> And no future laptops will be broken.

no comments.

> 
> > ...
> Skip as it looks the result of debating here can also be concluded from the answers of the questions.
> 
> > > > > After we root cause that's not a kernel problem, do we have mean in other community to handle
> > such
> > > > reports?
> > > > > For example, to collect hwdb entries.
> > > >
> > > > libinput, systemd are good candidate.
> > > > Libinput already has the bits in place, so I'd say we should probably
> > > > ask the users to report a bug on the wayland/libinput component of
> > > > bugs.freedesktop.org. But this will only work if the default initial lid
> > > > state is "method".
> > >
> > > Good to know. :)
> > > I've just changed the category of the forwarded report.
> > 
> > Well, I am not sure your bug report should have been changed. The bug
> > report was regarding i915 being confident in the _LID acpi call, and
> > that is not something libinput can change.
> 
> OK, I see.
> 
> > ...
> Skip as it looks the result of debating here can also be concluded from the answers of the questions.
> 

Thanks for your answer, however, you did not answered my questions:

Would you agree on:
- acking both my patches so Rafael can take them ans stable can apply
  them ASAP
- give me maintainership of drivers/acpi/button.c (ACK a following patch
  where I add me to MAINTAINERS)
- redirect all kernel bugs to me related to LID switch (or having me the
  default assignee for a new acpi/button component)
- allow me to add a list of quirk in acpi/button.c if I judge this as
  fit

If you agree on that, that would be good for both our sake I think.

Cheers,
Benjamin

> Cheers,
> Lv
