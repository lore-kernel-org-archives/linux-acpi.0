From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method
 mode"
Date: Fri, 12 May 2017 11:50:28 +0200
Message-ID: <20170512095028.GH30987@mail.corp.redhat.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
 <20170510161240.13229-2-benjamin.tissoires@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA1260@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA129E@SHSMSX101.ccr.corp.intel.com>
 <20170511101240.GG30987@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA2D9B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753174AbdELJuf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 May 2017 05:50:35 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA2D9B@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On May 12 2017 or thereabouts, Zheng, Lv wrote:
> Hi, 
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Benjamin
> > Tissoires
> > Subject: Re: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method mode"
> > 
> > On May 11 2017 or thereabouts, Zheng, Lv wrote:
> > > Hi, Benjamin
> > >
> > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of
> > Zheng,
> > > > Lv
> > > > Subject: RE: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method mode"
> > > >
> > > > Hi, Benjiamin
> > > >
> > > > > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > > > > Sent: Thursday, May 11, 2017 12:13 AM
> > > > > To: Rafael J . Wysocki <rjw@rjwysocki.net>; Zheng, Lv <lv.zheng@intel.com>
> > > > > Cc: Jiri Eischmann <jeischma@redhat.com>; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > > > > Subject: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method mode"
> > > > >
> > > > > This reverts commit ecb10b694b72ca5ea51b3c90a71ff2a11963425a.
> > > > >
> > > > > Even if the method can be buggy some times, it's still a need
> > > > > when you boot a laptop with a lid closed and an external monitor
> > > > > connected (typical situation when using a docking station)
> > > > >
> > > > > Note: this option has been removed without being deprecated, which
> > > > > is terrible in term of distribution handling. The new default "open"
> > > > > is plain wrong and we don't even have the chance to keep the current
> > > > > default option because it's not there anymore.
> > > >
> > > > I have reverted this:
> > > > https://patchwork.kernel.org/patch/9717109/
> > 
> > Yeah, sorry, as mentioned to Rafael, I only saw it after I sent my
> > series.
> > 
> > > >
> > > > Also I noticed one thing:
> > > > https://patchwork.kernel.org/patch/9717111/
> > > >
> > > > After I changed kernel lid notification to always send lid return value to other drivers.
> > > > In order to find out a single driver mode (without platform quirks) to handle both cases.
> > > > I failed.
> > 
> > Yes. As long as you do not have more information on the device, this is
> > not something you can solve with hacks in the kernel.
> > 
> > > > I should still send close init state to the user space program to work around the external monitor
> > > > issues.
> > > >
> > > > So as you know, we need to send "open" init state to the user space program to work around
> > > > suspend/resume loop issue.
> > 
> > I disagree. You are solving a user space issue (suspend boot loop), with
> > the wrong tool.
> 
> I'm not trying to solve it.
> I'm trying to confirm, it’s the input event not the lid notifier event triggered the problem.

You would have asked, I would have answered without you spending too
much time figuring this out.

The reason is simple: the kernel should report an accurate state, no
matter what.
Given this statement, user space made some design decisions, and in that
situation, the design differs from the Windows behavior. Which means OEM
only check Windows and might break Linux.

End of the story. The only viable way of not having boot/resume loops is
to report accurate events/states, and for that you need a way to fix it.

> 
> > The user space expects the kernel to provide accurate
> > events, but if the hardware is wrong, we should either fix it
> > (overwriting AML tables),
> 
> I don't think it's hardware related.
> If it's hardware related, we should always be able to fix it.

Well, yeah, hardware/firmware, for me it's all before the kernel.
And hardware would mean an actual failure of the sensor, so definitely
not something we can fix at the software level.

> 
> IMO, it's firmware related.
> And the firmware only provides functionalities Windows requires.
> It cares no about what the Linux user space requires.
> We have no mean to prevent future firmwares from breaking Linux user space again.

agree.

> So if it trends to break in AML, introducing quirks to fix the old AMLs doesn't help to solve the problem.
> 
> > make reasonable assumptions based on the exact
> > model capabilities (is the power button accessible with the LID closed),
> 
> Sounds it's always accessible.

hmm, I am not sure we have the same fingers.... For me on all the
laptops I have seen, if the LID is actually (physically) closed, I can
not press the button. It's a design choice to not have anything powering
on the laptop when it's in your bag.

The reported state is something different, and it's software only.

Remember that the _LID acpi method corresponds to a physical state of
the laptop. So if the ACPI returned value is crap, that means user space
should either ignore it, or it should be fixed. But we can't have a
situation where we say, yes, it's reliable except few cases, without
telling which cases are unreliable.

> 
> > or teach user space about these situations.
> 
> We are trying.
> But if the end users don't buy it, no user space programs will be interested in looking into the details of these issues.
> So we need to teach end users first IMO.
> Telling them to raise the issues to the right responsibles rather than acpi button driver.

I believe they are correct raising it in acpi button. Again, kernel should
provide accurate state. It's not the case. Then, we can redirect them to
the band-aid provided by libinput.

> 
> Some end users even make reports according to some BKMs (it has been changed now after discussed on ACPI Bugzilla bug):
> https://wiki.archlinux.org/index.php/Razer#Suspend_Loop
> 
> > There is no point in assuming wrong states in the kernel "to fix user
> > space" when user space is obviously not doing the right thing.
> 
> Agreed, as we've already synchronized. :)
> 
> But the only problem is:
> We can see flooded ACPI button driver problems reported on kernel Bugzilla.
> That's why we changed the default behavior of button driver.

... and you broke thousands to fix a handful :)

> It really helped to mute all suspend/resume loop issue reports.

No. It helped you in your daily work routine. It broke thousands of
customers.

> 
> > 
> > > >
> > > > Then for such platforms, how can ACPI button driver automatically detect if an external monitor is
> > > > there?
> > 
> > That's not the ACPI button role.
> > However, user space can write to the switch to overwrite it's value when
> > it judges that the kernel is doing things wrong. Libinput is a pretty
> > good candidate, given it has a view of all input devices. And guess
> > what, the code is already there.
> 
> You only told us the way the user space should use to fix the issue.
> But didn't tell us who should be responsible of fixing this issue.

"Who" is libinput if you saw above. And if you are interested in the
actual names, that's Peter Hutterer and myself mostly.

> 
> > 
> > > > Unless we fix the BIOS code to make lid return value work as user space's expectation.
> > 
> > That would be great.
> 
> That's not the real fix.

According to the kernel policy, that's the only viable fix.

> Just another kind of work around and cannot prevent future bug reports.

Agree, that's a workaround, but you can not prevent OEMs to do crap.

> 
> > 
> > > > OK, then this creates an endless business in ACPI community to "re-develop" BIOS tables if they
> > cannot
> > > > meat user space's expectation.
> > > > That sucks.
> > 
> > Yes, but unless you teach OEM to not do crap, that's our daily burden.
> > I'd love to not have to quirk endlessly all the drivers I maintain, but
> > each generation of new devices has a new creative way of breaking the
> > existing code, "because it works under Windows".
> 
> Or we can teach user space to not do any expectation other than what Windows supports on OEMs.
> 
> > 
> > > >
> > > > It sound the best way is the user space program equipped with hwdb quirks who knows everything to
> > > > alter acpi button driver mode from user space to work around this.
> > 
> > Yes, the hwdb entry is the solution (or a quirk list in acpi/button.c).
> 
> I'd rather to see such quirks accumulated in the user side not in the button driver.
> 
> > The advantage of the hwdb entry is that it will be asynchronous from the
> > kernel releases, and users can just drop a file in their /etc folder and
> > they solved the issue. Distribution will also be able to carry the list
> > of quirked devices, and hopefully end users won't see the boot loop.
> 
> The advantage sounds good.
> 
> > 
> > > > For example:
> > > >
> > > > If hwdb is hit, and there is no external monitor, then
> > > >  Echo "open" > /sys/module/button/parameters/lid_init_state
> > > > If hwdb is not hit or there is an external monitor, then
> > > > If hwdb is hit, and there is no external monitor, then
> > > >  Echo "close" > /sys/module/button/parameters/lid_init_state
> > 
> > Hum, no. This is too late. acpi/button.c is loaded before udev hits, so
> > the initial state will already be evaluated.
> 
> But this can affect post-resume behavior.
> And the bug reports are related to the post-resume behaviors.

Nothing prevents libinput to fix that. And I think it'll fix it too,
because there is no differences between the boot false state and the
resume false state: the state is wrong, and this can be detected.

Also, nothing prevents to have the rule you wrote (overwriting
lid_init_state) to have resume work even better.

> 
> > 
> > >
> > > Let me do re-wording.
> > > If hwdb is not hit
> > >   echo "method" > /sys/module/button/parameters/lid_init_state
> > > If hwdb is hit, and there is no external monitor, then
> > >   echo "open" > /sys/module/button/parameters/lid_init_state
> > > If hwdb is hit, and there is an external monitor
> > >   echo "close" > /sys/module/button/parameters/lid_init_state
> > > Then this always assumes the hard requirements of the platform quirks.
> > > And it then looks it's better to do such switches in the user space as ACPI button driver doesn't
> > know and doesn't have to know the existence of the external monitor.
> > 
> > Again, the external monitor doesn't matter here. The external monitor
> > issue is a user space choice to:
> > - not suspend if the LID is closed and a monitor is plugged
> > - only show the greater on the internal monitor if both are turned on.
> 
> Which program turned the lid off when the lid was closed?

I am not remotely sure of what you are asking here...

> 
> > 
> > The issue we are fixing here is the fact that the switch state is wrong,
> > which makes user space assumptions wrong too (and users angry).
> 
> Considering no platform quirks.
> 
> If ACPI button driver sends SW_LID, users are likely angry.
> Unless the user space programs are changed to "ignore open event".
> 
> If ACPI button driver doesn't send switch events, but key events.
> The user space programs need to change to handle the new events.
> 
> So finally whatever we do, user space need to change a bit related to ACPI control method lid device.

Or we fix the switch to report accurate events/state.
You do realise that all the energy you are spending, answering to me,
talking to user space maintainers, users, all comes down to the fact
that you refuse to have hardware quirks?

If you don't want to write/maintain the code, fine. I can do it, but
please stop trying to make everyone else change because you just don't
want the burden of quirking a handful of laptops.

> 
> > 
> > But given that the LID switch is an actual input switch device, user
> > space can overwrite it by simply writing to the input node.
> 
> I can see what you mean here.
> You are suggesting to use input overwrite rather than changing lid_init_state to fix the issue.
> 
> This also means to me: user space is able to fix everything on its own, ACPI button driver needn't participant in.

Well, fixing it in the kernel means you don't need user space to fix it,
which is nice too on systems where there is no libinput. But on such
systems, maybe they just don't care and do something different.

Having a fix in user space has advantages too (see above), but for it to
be working, you need to stop changing the kernel behavior and the
kernel API.

> 
> > 
> > 
> > >
> > > However, is that possible to not introduce platform quirks?
> > > For example, for systemd:
> > > If it detected ACPI lid device, automatically switch to an "IgnoreLidOpenEvent" mode (like nouveau
> > drivers' ignorelid=Y option).
> > 
> > Well, given that 99.9% of laptops have this ACPI lid button, you'll just
> > remove the feature from all laptops.
> 
> No, I only removed the wrong usage models related to the strict "open" event.
> All laptops are still capable of sending correct "close" event.

My bad, I read too fast and missed the "...Open..." part of
"IgnoreLidOpenEvent".

Though I am not sure IgnoreLidOpenEvent is accurate.
"OpenEventNeverSent" seems to reflect more the reality. But again,
that's not of our (kernel developers) business.

> 
> > 
> > > BTW, which program is responsible for lighting on internal/external monitors?
> > 
> > I would say the compositor or X, so gdm, kdm, gnome, kde, etc...
> 
> So I already raised this to freedesktop:
> https://bugs.freedesktop.org/show_bug.cgi?id=100923
> But couldn't see any one there responding.

Well, Joachim answered, saying that there is likely a regression in
acpi/button.c, not in i915.

I guess you presented the problem in the wrong term: what you want is
developer to fix the acpi_lid_open() call. All you need to do is
explaining them that the call might not be accurate. And I also believe
the solution is not to tweak i915 or nouveau driver, but make sure
acpi/button does the right thing.

> 
> > 
> > > Can it determine that by its own without listening to the lid key events?
> > 
> > Basically no. This switch is there for a reason. However, I am convinced
> > that a good heuristic is to say that if you are using the internal keyboard,
> > touchscreen or touchpad, unless the user has very very thin fingers, the
> > lid is open.
> 
> I'm also convinced that the benefit of having a file in sysfs/procfs to allow user to know if the lid is open is marginal.

I am convinced I don't get your point. We are obviously not talking
about the same thing here. I was talking about the physical world, where
the user interact with the laptop...

> 
> > 
> > > This is what we preferred.
> > > If all of above usage models are corrected, we'll change acpi button driver default mode to "ignore".
> > 
> > No, we need to report accurate state, or explicitly mark the platform as
> > not reliable, and so we need "method" and a hwdb of problematic ones.
> 
> I'm actually OK with any default value.

Thanks.

> But like previously I don't want to send a patch to change the default behavior to "open".
> I don't want to be the one to change the default behavior back to "method".

I already did. So feel free to point finger at me if somebody else
complains.

> 
> > 
> > >
> > > Another problem for changing default mode back to "method" is:
> > > If we changed button driver default mode back to "method", then ACPI community will be flooded of
> > suspend/resume loop bug reports.
> > 
> > But that's your job to fix bugs. If there is a user space problem that
> > can be solved in user space, you just need to redirect the users to the
> > correct solution and close the bug.
> > 
> > But you are talking about "flood", and I don't think we ever talked
> > about more than 4 devices. So could you point me at a list of bugs that
> > you actually had to fix?
> 
> I just opened my Bugzilla filter, and copied top most lid related ones here:
> https://bugzilla.kernel.org/show_bug.cgi?id=187271
> https://bugzilla.kernel.org/show_bug.cgi?id=192231
> https://bugzilla.kernel.org/show_bug.cgi?id=191211
> https://bugzilla.kernel.org/show_bug.cgi?id=189171
> https://bugzilla.kernel.org/show_bug.cgi?id=116001

That's 3 new laptops I wasn't aware of:
- Razer Blade Stealth 2016
- SAMSUNG 530U3C/530U4C
- Razerblade 2014

The Dell one is different as it seems the EC is doing things wrong, and
do not forward the notification even if the _LID acpi method returns the
proper value.

> ...
> 
> And old reports here, occasionally opened by different users:
> https://bugzilla.kernel.org/show_bug.cgi?id=89211

MS Surface Pro 1, already known

> https://bugzilla.kernel.org/show_bug.cgi?id=106151

Samsung N210 Plus something like 8 or 10 year old laptop, already known

> https://bugzilla.kernel.org/show_bug.cgi?id=106941

Surface 3, already fixed in the kernel by myself
(drivers/platform/x86/surface3-wmi.c)

> https://bugzilla.novell.com/show_bug.cgi?id=326814

Lenovo X60, at least 5 years old one, recent models don't have any issue.

> 
> Do you think the kernel community should prepare a candidate to handle such bug flood?

Well, I don't mind receiving such "flood" in my face: 7 laptops in 10
years seems something manageable. And also looks like Razer has a common
way of being wrong, so we can just match on RazerBlade to fix all
current and future generations.

> I'm unfortunately the one changed button driver recently and have to handle them.
> That's why I changed default behavior from method to open.
> After upstream merged that default behavior change, no such reports could be seen again.

Well, that is not true. Once a change gets in linux-acpi, you need to
wait for the next merge window for it to be in linus' tree to get wider
testing. Then you need to wait for the release to have distributions
taking it and actually have broader testers and most use cases tackled.

And this corresponds to the 2 months you had between your submission and
the v4.11 release, where fedora picked it in Fedora 26, and where our
users started testing it intensively.

> 
> But it's just 1-2 months Bugzilla silence before seeing a different bug flood trend:
> This time, they are related to the external monitor usage model:
> https://bugzilla.kernel.org/show_bug.cgi?id=187271
> https://bugzilla.redhat.com/show_bug.cgi?id=1430259
> https://bugzilla.kernel.org/show_bug.cgi?id=195455
> Now that you can see why I didn't send a patch to change the default behavior to "open" at the time we were discussing.
> That's also why I think we needn't revert back to "method" as the default behavior.

Still, I strongly disagree. We do not fix 7 devices by breaking
hundreds. That's just not how the kernel work.

> 
> I'm afraid you may need to be prepared to handle some of the reports if you revert the default behavior back to "method".
> So if you insist, I can put my Acked-by to your PATCH 2/2.

I insist, and I am not afraid. I'd rather be facing those than having
someone else breaking a single switch in the system in a way we can't do
anything else to solve the issue in user space.

> 
> > 
> > > After we root cause that's not a kernel problem, do we have mean in other community to handle such
> > reports?
> > > For example, to collect hwdb entries.
> > 
> > libinput, systemd are good candidate.
> > Libinput already has the bits in place, so I'd say we should probably
> > ask the users to report a bug on the wayland/libinput component of
> > bugs.freedesktop.org. But this will only work if the default initial lid
> > state is "method".
> 
> Good to know. :)
> I've just changed the category of the forwarded report.

Well, I am not sure your bug report should have been changed. The bug
report was regarding i915 being confident in the _LID acpi call, and
that is not something libinput can change.

> 
> > 
> > Sorry for showing I am angry. But I thought we solved this months ago
> > and this bites back.
> 
> You always help me a lot, appreciated!
> 

Thanks for your kindness :)

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

> Cheers
> Lv
> 
> > 
> > Cheers,
> > Benjamin
> > 
> > >
> > > Thanks and best regards
> > > Lv
> > >
> > > >
> > > > So PATCH 2 is not useful.
> > > > Reverting that can trigger a regression loop we surely do not want to handle.
> > > >
> > > > Thanks and best regards
> > > > Lv
> > > >
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > > ---
> > > > >  Documentation/acpi/acpi-lid.txt | 16 ++++++++++++----
> > > > >  drivers/acpi/button.c           |  9 +++++++++
> > > > >  2 files changed, 21 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
> > > > > index 22cb309..effe7af 100644
> > > > > --- a/Documentation/acpi/acpi-lid.txt
> > > > > +++ b/Documentation/acpi/acpi-lid.txt
> > > > > @@ -59,20 +59,28 @@ button driver uses the following 3 modes in order not to trigger issues.
> > > > >  If the userspace hasn't been prepared to ignore the unreliable "opened"
> > > > >  events and the unreliable initial state notification, Linux users can use
> > > > >  the following kernel parameters to handle the possible issues:
> > > > > -A. button.lid_init_state=open:
> > > > > +A. button.lid_init_state=method:
> > > > > +   When this option is specified, the ACPI button driver reports the
> > > > > +   initial lid state using the returning value of the _LID control method
> > > > > +   and whether the "opened"/"closed" events are paired fully relies on the
> > > > > +   firmware implementation.
> > > > > +   This option can be used to fix some platforms where the returning value
> > > > > +   of the _LID control method is reliable but the initial lid state
> > > > > +   notification is missing.
> > > > > +   This option is the default behavior during the period the userspace
> > > > > +   isn't ready to handle the buggy AML tables.
> > > > > +B. button.lid_init_state=open:
> > > > >     When this option is specified, the ACPI button driver always reports the
> > > > >     initial lid state as "opened" and whether the "opened"/"closed" events
> > > > >     are paired fully relies on the firmware implementation.
> > > > >     This may fix some platforms where the returning value of the _LID
> > > > >     control method is not reliable and the initial lid state notification is
> > > > >     missing.
> > > > > -   This option is the default behavior during the period the userspace
> > > > > -   isn't ready to handle the buggy AML tables.
> > > > >
> > > > >  If the userspace has been prepared to ignore the unreliable "opened" events
> > > > >  and the unreliable initial state notification, Linux users should always
> > > > >  use the following kernel parameter:
> > > > > -B. button.lid_init_state=ignore:
> > > > > +C. button.lid_init_state=ignore:
> > > > >     When this option is specified, the ACPI button driver never reports the
> > > > >     initial lid state and there is a compensation mechanism implemented to
> > > > >     ensure that the reliable "closed" notifications can always be delievered
> > > > > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > > > > index 668137e..6d5a8c1 100644
> > > > > --- a/drivers/acpi/button.c
> > > > > +++ b/drivers/acpi/button.c
> > > > > @@ -57,6 +57,7 @@
> > > > >
> > > > >  #define ACPI_BUTTON_LID_INIT_IGNORE	0x00
> > > > >  #define ACPI_BUTTON_LID_INIT_OPEN	0x01
> > > > > +#define ACPI_BUTTON_LID_INIT_METHOD	0x02
> > > > >
> > > > >  #define _COMPONENT		ACPI_BUTTON_COMPONENT
> > > > >  ACPI_MODULE_NAME("button");
> > > > > @@ -376,6 +377,9 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
> > > > >  	case ACPI_BUTTON_LID_INIT_OPEN:
> > > > >  		(void)acpi_lid_notify_state(device, 1);
> > > > >  		break;
> > > > > +	case ACPI_BUTTON_LID_INIT_METHOD:
> > > > > +		(void)acpi_lid_update_state(device);
> > > > > +		break;
> > > > >  	case ACPI_BUTTON_LID_INIT_IGNORE:
> > > > >  	default:
> > > > >  		break;
> > > > > @@ -559,6 +563,9 @@ static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
> > > > >  	if (!strncmp(val, "open", sizeof("open") - 1)) {
> > > > >  		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
> > > > >  		pr_info("Notify initial lid state as open\n");
> > > > > +	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
> > > > > +		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> > > > > +		pr_info("Notify initial lid state with _LID return value\n");
> > > > >  	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
> > > > >  		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
> > > > >  		pr_info("Do not notify initial lid state\n");
> > > > > @@ -572,6 +579,8 @@ static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
> > > > >  	switch (lid_init_state) {
> > > > >  	case ACPI_BUTTON_LID_INIT_OPEN:
> > > > >  		return sprintf(buffer, "open");
> > > > > +	case ACPI_BUTTON_LID_INIT_METHOD:
> > > > > +		return sprintf(buffer, "method");
> > > > >  	case ACPI_BUTTON_LID_INIT_IGNORE:
> > > > >  		return sprintf(buffer, "ignore");
> > > > >  	default:
> > > > > --
> > > > > 2.9.3
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
