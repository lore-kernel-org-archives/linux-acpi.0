From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method
 mode"
Date: Thu, 11 May 2017 12:12:40 +0200
Message-ID: <20170511101240.GG30987@mail.corp.redhat.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
 <20170510161240.13229-2-benjamin.tissoires@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA1260@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA129E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932129AbdEKKMt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 May 2017 06:12:49 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA129E@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On May 11 2017 or thereabouts, Zheng, Lv wrote:
> Hi, Benjamin
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Zheng,
> > Lv
> > Subject: RE: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method mode"
> > 
> > Hi, Benjiamin
> > 
> > > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > > Sent: Thursday, May 11, 2017 12:13 AM
> > > To: Rafael J . Wysocki <rjw@rjwysocki.net>; Zheng, Lv <lv.zheng@intel.com>
> > > Cc: Jiri Eischmann <jeischma@redhat.com>; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: [PATCH 1/2] Revert "ACPI / button: Remove lid_init_state=method mode"
> > >
> > > This reverts commit ecb10b694b72ca5ea51b3c90a71ff2a11963425a.
> > >
> > > Even if the method can be buggy some times, it's still a need
> > > when you boot a laptop with a lid closed and an external monitor
> > > connected (typical situation when using a docking station)
> > >
> > > Note: this option has been removed without being deprecated, which
> > > is terrible in term of distribution handling. The new default "open"
> > > is plain wrong and we don't even have the chance to keep the current
> > > default option because it's not there anymore.
> > 
> > I have reverted this:
> > https://patchwork.kernel.org/patch/9717109/

Yeah, sorry, as mentioned to Rafael, I only saw it after I sent my
series.

> > 
> > Also I noticed one thing:
> > https://patchwork.kernel.org/patch/9717111/
> > 
> > After I changed kernel lid notification to always send lid return value to other drivers.
> > In order to find out a single driver mode (without platform quirks) to handle both cases.
> > I failed.

Yes. As long as you do not have more information on the device, this is
not something you can solve with hacks in the kernel.

> > I should still send close init state to the user space program to work around the external monitor
> > issues.
> > 
> > So as you know, we need to send "open" init state to the user space program to work around
> > suspend/resume loop issue.

I disagree. You are solving a user space issue (suspend boot loop), with
the wrong tool. The user space expects the kernel to provide accurate
events, but if the hardware is wrong, we should either fix it
(overwriting AML tables), make reasonable assumptions based on the exact
model capabilities (is the power button accessible with the LID closed),
or teach user space about these situations.
There is no point in assuming wrong states in the kernel "to fix user
space" when user space is obviously not doing the right thing.

> > 
> > Then for such platforms, how can ACPI button driver automatically detect if an external monitor is
> > there?

That's not the ACPI button role.
However, user space can write to the switch to overwrite it's value when
it judges that the kernel is doing things wrong. Libinput is a pretty
good candidate, given it has a view of all input devices. And guess
what, the code is already there.

> > Unless we fix the BIOS code to make lid return value work as user space's expectation.

That would be great.

> > OK, then this creates an endless business in ACPI community to "re-develop" BIOS tables if they cannot
> > meat user space's expectation.
> > That sucks.

Yes, but unless you teach OEM to not do crap, that's our daily burden.
I'd love to not have to quirk endlessly all the drivers I maintain, but
each generation of new devices has a new creative way of breaking the
existing code, "because it works under Windows".

> > 
> > It sound the best way is the user space program equipped with hwdb quirks who knows everything to
> > alter acpi button driver mode from user space to work around this.

Yes, the hwdb entry is the solution (or a quirk list in acpi/button.c).
The advantage of the hwdb entry is that it will be asynchronous from the
kernel releases, and users can just drop a file in their /etc folder and
they solved the issue. Distribution will also be able to carry the list
of quirked devices, and hopefully end users won't see the boot loop.

> > For example:
> > 
> > If hwdb is hit, and there is no external monitor, then
> >  Echo "open" > /sys/module/button/parameters/lid_init_state
> > If hwdb is not hit or there is an external monitor, then
> > If hwdb is hit, and there is no external monitor, then
> >  Echo "close" > /sys/module/button/parameters/lid_init_state

Hum, no. This is too late. acpi/button.c is loaded before udev hits, so
the initial state will already be evaluated.

> 
> Let me do re-wording.
> If hwdb is not hit
>   echo "method" > /sys/module/button/parameters/lid_init_state
> If hwdb is hit, and there is no external monitor, then
>   echo "open" > /sys/module/button/parameters/lid_init_state
> If hwdb is hit, and there is an external monitor
>   echo "close" > /sys/module/button/parameters/lid_init_state
> Then this always assumes the hard requirements of the platform quirks.
> And it then looks it's better to do such switches in the user space as ACPI button driver doesn't know and doesn't have to know the existence of the external monitor.

Again, the external monitor doesn't matter here. The external monitor
issue is a user space choice to:
- not suspend if the LID is closed and a monitor is plugged
- only show the greater on the internal monitor if both are turned on.

The issue we are fixing here is the fact that the switch state is wrong,
which makes user space assumptions wrong too (and users angry).

But given that the LID switch is an actual input switch device, user
space can overwrite it by simply writing to the input node.


> 
> However, is that possible to not introduce platform quirks?
> For example, for systemd:
> If it detected ACPI lid device, automatically switch to an "IgnoreLidOpenEvent" mode (like nouveau drivers' ignorelid=Y option).

Well, given that 99.9% of laptops have this ACPI lid button, you'll just
remove the feature from all laptops. 

> BTW, which program is responsible for lighting on internal/external monitors?

I would say the compositor or X, so gdm, kdm, gnome, kde, etc...

> Can it determine that by its own without listening to the lid key events?

Basically no. This switch is there for a reason. However, I am convinced
that a good heuristic is to say that if you are using the internal keyboard,
touchscreen or touchpad, unless the user has very very thin fingers, the
lid is open.

> This is what we preferred.
> If all of above usage models are corrected, we'll change acpi button driver default mode to "ignore".

No, we need to report accurate state, or explicitly mark the platform as
not reliable, and so we need "method" and a hwdb of problematic ones.

> 
> Another problem for changing default mode back to "method" is:
> If we changed button driver default mode back to "method", then ACPI community will be flooded of suspend/resume loop bug reports.

But that's your job to fix bugs. If there is a user space problem that
can be solved in user space, you just need to redirect the users to the
correct solution and close the bug.

But you are talking about "flood", and I don't think we ever talked
about more than 4 devices. So could you point me at a list of bugs that
you actually had to fix?

> After we root cause that's not a kernel problem, do we have mean in other community to handle such reports?
> For example, to collect hwdb entries.

libinput, systemd are good candidate.
Libinput already has the bits in place, so I'd say we should probably
ask the users to report a bug on the wayland/libinput component of
bugs.freedesktop.org. But this will only work if the default initial lid
state is "method".

Sorry for showing I am angry. But I thought we solved this months ago
and this bites back.

Cheers,
Benjamin

> 
> Thanks and best regards
> Lv
> 
> > 
> > So PATCH 2 is not useful.
> > Reverting that can trigger a regression loop we surely do not want to handle.
> > 
> > Thanks and best regards
> > Lv
> > 
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > ---
> > >  Documentation/acpi/acpi-lid.txt | 16 ++++++++++++----
> > >  drivers/acpi/button.c           |  9 +++++++++
> > >  2 files changed, 21 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
> > > index 22cb309..effe7af 100644
> > > --- a/Documentation/acpi/acpi-lid.txt
> > > +++ b/Documentation/acpi/acpi-lid.txt
> > > @@ -59,20 +59,28 @@ button driver uses the following 3 modes in order not to trigger issues.
> > >  If the userspace hasn't been prepared to ignore the unreliable "opened"
> > >  events and the unreliable initial state notification, Linux users can use
> > >  the following kernel parameters to handle the possible issues:
> > > -A. button.lid_init_state=open:
> > > +A. button.lid_init_state=method:
> > > +   When this option is specified, the ACPI button driver reports the
> > > +   initial lid state using the returning value of the _LID control method
> > > +   and whether the "opened"/"closed" events are paired fully relies on the
> > > +   firmware implementation.
> > > +   This option can be used to fix some platforms where the returning value
> > > +   of the _LID control method is reliable but the initial lid state
> > > +   notification is missing.
> > > +   This option is the default behavior during the period the userspace
> > > +   isn't ready to handle the buggy AML tables.
> > > +B. button.lid_init_state=open:
> > >     When this option is specified, the ACPI button driver always reports the
> > >     initial lid state as "opened" and whether the "opened"/"closed" events
> > >     are paired fully relies on the firmware implementation.
> > >     This may fix some platforms where the returning value of the _LID
> > >     control method is not reliable and the initial lid state notification is
> > >     missing.
> > > -   This option is the default behavior during the period the userspace
> > > -   isn't ready to handle the buggy AML tables.
> > >
> > >  If the userspace has been prepared to ignore the unreliable "opened" events
> > >  and the unreliable initial state notification, Linux users should always
> > >  use the following kernel parameter:
> > > -B. button.lid_init_state=ignore:
> > > +C. button.lid_init_state=ignore:
> > >     When this option is specified, the ACPI button driver never reports the
> > >     initial lid state and there is a compensation mechanism implemented to
> > >     ensure that the reliable "closed" notifications can always be delievered
> > > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > > index 668137e..6d5a8c1 100644
> > > --- a/drivers/acpi/button.c
> > > +++ b/drivers/acpi/button.c
> > > @@ -57,6 +57,7 @@
> > >
> > >  #define ACPI_BUTTON_LID_INIT_IGNORE	0x00
> > >  #define ACPI_BUTTON_LID_INIT_OPEN	0x01
> > > +#define ACPI_BUTTON_LID_INIT_METHOD	0x02
> > >
> > >  #define _COMPONENT		ACPI_BUTTON_COMPONENT
> > >  ACPI_MODULE_NAME("button");
> > > @@ -376,6 +377,9 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
> > >  	case ACPI_BUTTON_LID_INIT_OPEN:
> > >  		(void)acpi_lid_notify_state(device, 1);
> > >  		break;
> > > +	case ACPI_BUTTON_LID_INIT_METHOD:
> > > +		(void)acpi_lid_update_state(device);
> > > +		break;
> > >  	case ACPI_BUTTON_LID_INIT_IGNORE:
> > >  	default:
> > >  		break;
> > > @@ -559,6 +563,9 @@ static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
> > >  	if (!strncmp(val, "open", sizeof("open") - 1)) {
> > >  		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
> > >  		pr_info("Notify initial lid state as open\n");
> > > +	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
> > > +		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> > > +		pr_info("Notify initial lid state with _LID return value\n");
> > >  	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
> > >  		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
> > >  		pr_info("Do not notify initial lid state\n");
> > > @@ -572,6 +579,8 @@ static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
> > >  	switch (lid_init_state) {
> > >  	case ACPI_BUTTON_LID_INIT_OPEN:
> > >  		return sprintf(buffer, "open");
> > > +	case ACPI_BUTTON_LID_INIT_METHOD:
> > > +		return sprintf(buffer, "method");
> > >  	case ACPI_BUTTON_LID_INIT_IGNORE:
> > >  		return sprintf(buffer, "ignore");
> > >  	default:
> > > --
> > > 2.9.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
