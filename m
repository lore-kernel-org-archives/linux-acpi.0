From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3 3/3] ACPI / button: Add quirks for initial lid state notification
Date: Thu, 2 Jun 2016 17:25:01 +0200
Message-ID: <CAN+gG=Fb7tAYQRq6NsjtiL-2W=KgpntkiS_h4Jo=QaP3y+oCmA@mail.gmail.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
	<284674cb8228f4f2b40f940a3c4a666f367d7b6a.1464775699.git.lv.zheng@intel.com>
	<1464778871.2432.12.camel@hadess.net>
	<1AE640813FDE7649BE1B193DEA596E883BBB7382@SHSMSX101.ccr.corp.intel.com>
	<1464876110.2432.31.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464876110.2432.31.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 2, 2016 at 4:01 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2016-06-02 at 01:08 +0000, Zheng, Lv wrote:
>> Hi,
>>
>> > From: Bastien Nocera [mailto:hadess@hadess.net]
>> > Subject: Re: [PATCH v3 3/3] ACPI / button: Add quirks for initial
>> > lid state
>> > notification
>> >
>> > On Wed, 2016-06-01 at 18:10 +0800, Lv Zheng wrote:
>> > > Linux userspace (systemd-logind) keeps on rechecking lid state
>> > > when the
>> > > lid state is closed. If it failed to update the lid state to open
>> > > after
>> > > boot/resume, the system suspending right after the boot/resume
>> > > could
>> > be
>> > > resulted.
>> > > Graphics drivers also uses the lid notifications to implment
>> > > MODESET_ON_LID_OPEN option.
>> >
>> > "implement"
>> [Lv Zheng]
>> Thanks for pointing out, I'll send an UPDATE to this.
>>
>> >
>> > > Before the situation is improved from the userspace and from the
>> > graphics
>> > > driver, users can simply configure ACPI button driver to send
>> > > initial
>> > > "open" lid state using button.lid_init_state=open to avoid such
>> > > kind of
>> > > issues. And our ultimate target should be making
>> > > button.lid_init_state=ignore the default behavior. This patch
>> > > implements
>> > > the 2 options and keep the old behavior
>> > > (button.lid_init_state=method).
>> >
>> > I still don't think it's reasonable to expect any changes in user-
>> > space
>> > unless you start documenting what the API to user-space actually
>> > is.
>> [Lv Zheng]
>> IMO, the ACPI lid driver should be responsible for sending lid key
>> event (especially "close") to the user space.
>> So if someone need to implement an ACPI lid key event quirk, we could
>> help to implement it from the kernel space.
>> And since the initial lid state is not stable, we have to stop doing
>> quirks around it inside of the Linux kernel, or inside of the
>> customized AML tables.
>> User space can still access /proc/acpi/button/lid/LID0/state, but
>> should stop thinking that it is reliable.
>>
>> These are what I can conclude from the bugs.

After further thoughts, I also think it is a bad idea to request user
space to change behavior with respect to the LID switch event we
forward from the keyboard:
- it looks like Windows doesn't care about LID open on some
(entry-level) platforms: the Samsung N210 is one of the first netbooks
from 2010. The Surface (pro or not) are tablets. On these low cost
systems, we can easily assume that the user needs to have the LID open
to have the system working. You can't connect a docking station, and
they are probably not used in a professional environment.
- for the high end machines (think professional), we actually need to
have a valid LID state given that the machines can be used on a
docking station, so LID closed. If we do not send a reliable LID state
for those laptops we will break user space and more likely annoy
users: we might light up the closed internal monitor and migrate all
the currently open applications to this screen.

So I think Windows might be able to detect those 2 categories of
environments and behave accordingly.

Then, if we want to express to user space that the LID switch state is
not reliable, we should stop setting it up as an input device with a
EV_SWITCH in it. The kernel has to be reliable, and we can't start
saying that this particular switch in a system might not be reliable.
In this, I join Bastien's point of view where we need to start
deprecating and document what needs to be done, and introduce a new
way of reporting the LID events to user space (by using a
KEY_LID_CLOSE for instance).

I still think this patch is necessary. Until we manage to understand
what is going on on Windows for the non reliable LID state, we can
always ask users to use the button.lid_init_state=open to prevent the
freeze loops they are seeing.
The deprecation process could be to send the open state at resume on
the SW_LID event, and send both the close and a KEY_LID_CLOSE event on
close (no KEY_* on open).

For professional laptops (with docking capability), I can't see how we
could avoid forwarding a reliable state, and we need them to stick to
button.lid_init_state=method (keep SW_LID and not send the
KEY_LID_CLOSE event so userspace knows it's reliable).

Hope this helps,
Benjamin


>
> There's still no documentation for user-space in the patch, and no way
> to disable the "legacy" support (disabling access to the cached LID
> state, especially through the input layer which is what logind and
> upower use).
>
> You can't expect user-space to change in major ways for those few
> devices if the API doesn't force them to, through deprecation notices
> and documentation.
>
> Cheers
