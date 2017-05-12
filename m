From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 5/5] ACPI: button: Obselete acpi_lid_open() invocations
Date: Fri, 12 May 2017 12:20:36 +0200
Message-ID: <CAN+gG=GazunH_RFDUusbnT+ncNoejLuA5=v-49KDFFJ4oy8xuw@mail.gmail.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
 <22b130fe0cf3fca19b0e14c69426fe36766cf2ee.1494311429.git.lv.zheng@intel.com>
 <CAN+gG=G_yh77Vab_bvWxTOVHsiUm21-X8bajo14utjaCwf1x=Q@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA2BB0@SHSMSX101.ccr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E886CEA2E0E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33782 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbdELKUj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2017 06:20:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id y10so12894352wmh.0
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2017 03:20:38 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA2E0E@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>

Hi Lv,

I am trying to reduce the number of parallel discussion we have on the
same subject, but there is something here I can't let you have.

On Fri, May 12, 2017 at 8:08 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
> If my previous reply is not persuasive enough.
> Let me do that in a different way.
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.ker=
nel.org] On Behalf Of Zheng,
>> Lv
>> Subject: RE: [PATCH v2 5/5] ACPI: button: Obselete acpi_lid_open() invoc=
ations
>>
>> Hi,
>>
>> > From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
>> > Subject: Re: [PATCH v2 5/5] ACPI: button: Obselete acpi_lid_open() inv=
ocations
>> >
>> > On Tue, May 9, 2017 at 9:02 AM, Lv Zheng <lv.zheng@intel.com> wrote:
>> > > Since notification side has been changed to always notify kernel lis=
teners
>> > > using _LID returning value. Now listeners needn't invoke acpi_lid_op=
en(),
>> > > it should use a spec suggested control method lid device usage model=
:
>> > > register lid notification and use the notified value instead, which =
is the
>> > > only way to ensure the value is correct for "button.lid_init_state=
=3Dignore"
>> > > mode or other modes with "button.lid_fake_events=3DN" specified.
>> > >
>> > > This patch fixes i915 driver to drop acpi_lid_open() user. It's not
>> > > possible to change nouveau_connector.c user using a simple way now. =
So this
>> > > patch only marks acpi_lid_open() as deprecated to accelerate this pr=
ocess
>> > > by indicating this change to the nouveau developers.
>> >
>> > If  the only 2 users of acpi_lid_open() are intel and nouveau, and if
>> > they should rely on the value stored in the input node, not the one
>> > exported by the _LID method (which can be wrong on some platforms),
>> > how about simply changing the implementation of acpi_lid_open() to
>> > fetch the value from the input node directly?
>
> If acpi_lid_open() returns stored value in input node,
> then it actually returns the value we notified to the input layer.
> While i915 and nouveau explicitly do not trust that value and invoke acpi=
_lid_open().
>
> For button.lid_init_state=3Dmethod, PATCH 4/5 is useless as the values ar=
e same.
>
> However in my reply of PATCH 2.
> I explained the difference of method/close, for the same reason, we can a=
lso sense the difference of method/open.
> The difference then can explain the usefulness of open/close modes.
>
> Given open/close modes are all useful:
> button.lid_init_state=3Dopen
> 1. button driver sends open to input layer after boot/resume
> 2. i915/nouveau uses _LID return value after boot/resume
> If _LID return value after boot/resume is "close", they are different.
>
> button.lid_init_state=3Dclose
> 1. button driver sends close to input layer after boot/resume
> 2. i915/nouveau uses _LID return value after boot/resume
> If _LID return value after boot/resume is "open", they are different.
>
> The only way to be consistent to old i915/nouveau behavior is:
> button.lid_init_state=3Dopen/close

But these two modes are wrong in the absolute case:
- a laptop has no reasons for not being powered up with the lid
physically closed (wake on lan?) -> so open is an approximation
already made on good assumption that there is not a high chance of the
users powering/resuming the laptop with the lid closed
- in the "close" case, this setting works for docked laptops, but if
the laptop can be docked, it can also be undocked. And if you boot
with button.lid_init_state=3Dclose, undock your laptop, go into suspend,
resume -> the lid state is now "closed" while it should be opened.

So no, these are just workarounds. i915/nouveau expect the acpi/button
state to be reliable, or they should ignore it. But you can't fake
events when you are not absolutely sure of what is happening.

> 1. button driver sends open/close to input layer after boot/resume
> 2. button driver sends _LID return value to i915 after boot/resume (PATCH=
 4)
> So that i915 can just use the notified value in this patch (PATCH 5).
> For nouveau, no change has been made for now, and as a concequence, acpi_=
lid_open() is still kept but marked as deprecated.
>
>>
>> See my reply of PATCH 4.
>> It seems they trust _LID return value more than what we send to them.
>>
>> We can actually send faked "open/close" to them when button.lid_init_sta=
te=3Dopen/close is specified.
>>
>> So these 2 patches [PATCH 4-5/5] are used to do a small cleanup for lid =
event notifier APIs.
>> I think they are not strictly related to the lid issues we are talking a=
bout.
>
> See Documentation/acpi/acpi-lid.txt:
> The _LID control method is described to return the "current" lid state.
> However the word of "current" has ambiguity, some buggy AML tables return
> the lid state upon the last lid notification instead of returning the lid
> state upon the last _LID evaluation.
>
> In order to have acpi lid event notifier API compliant to the above menti=
oned both "buggy" and "nonbuggy" implementation.
> The ensured lid event model interface should be:
> 1. Lid event notifier listeners invokes acpi_lid_notifier_register().
> 2. And in the callback, uses _LID return value.
> This is also the only possible way to combine "receiving lid notify" and =
"evaluate _LID" into 1 single atomic operation.
>
> So I trend to remove acpi_lid_open() and enforce the new API.
>
> As a conclusion, PATCH 4-5
> 1. makes a hidden logic explicit - the lid event listeners always use _LI=
D return value. Less hidden logics should leave less chances of bugs.
> 2. is an implementation for our documented ACPI lid event model.
> And the implementation is done in a regression safe way.

I understand all of that. But my point is still that on some
platforms, the lid acpi state is not reliable, and the code in
i915/nouveau is not made for those platforms. So the ideal solution is
to know which platforms are problematic and take the right decisions
having everything at hands. Just "fixing" the internal API won't help
teaching these drivers to not make the assumption that the _LID acpi
call is always correct.

So yes, nouveau/i915 might need to be fixed, but IMO, fixing
acpi/button to report correct (true, accurate, actual, or physical if
you prefer) is the best, future proof way (minus platform quirks).

Cheers,
Benjamin

>
> Thanks,
> Lv
>
>>
>> Cheers,
>> Lv
>>
>> >
>> > Cheers,
>> > Benjamin
>> >
>> > >
>> > > Cc: <intel-gfx@lists.freedesktop.org>
>> > > Cc: <nouveau@lists.freedesktop.org>
>> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> > > ---
>> > >  drivers/acpi/button.c             | 7 ++++++-
>> > >  drivers/gpu/drm/i915/intel_lvds.c | 2 +-
>> > >  2 files changed, 7 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>> > > index 7ff3a75..50d7898 100644
>> > > --- a/drivers/acpi/button.c
>> > > +++ b/drivers/acpi/button.c
>> > > @@ -348,7 +348,12 @@ int acpi_lid_notifier_unregister(struct notifie=
r_block *nb)
>> > >  }
>> > >  EXPORT_SYMBOL(acpi_lid_notifier_unregister);
>> > >
>> > > -int acpi_lid_open(void)
>> > > +/*
>> > > + * The intentional usage model is to register a lid notifier and us=
e the
>> > > + * notified value instead. Directly evaluating _LID without seeing =
a
>> > > + * Notify(lid, 0x80) is not reliable.
>> > > + */
>> > > +int __deprecated acpi_lid_open(void)
>> > >  {
>> > >         if (!lid_device)
>> > >                 return -ENODEV;
>> > > diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i91=
5/intel_lvds.c
>> > > index 9ca4dc4..8ca9080 100644
>> > > --- a/drivers/gpu/drm/i915/intel_lvds.c
>> > > +++ b/drivers/gpu/drm/i915/intel_lvds.c
>> > > @@ -548,7 +548,7 @@ static int intel_lid_notify(struct notifier_bloc=
k *nb, unsigned long val,
>> > >         /* Don't force modeset on machines where it causes a GPU loc=
kup */
>> > >         if (dmi_check_system(intel_no_modeset_on_lid))
>> > >                 goto exit;
>> > > -       if (!acpi_lid_open()) {
>> > > +       if (!val) {
>> > >                 /* do modeset on next lid open event */
>> > >                 dev_priv->modeset_restore =3D MODESET_ON_LID_OPEN;
>> > >                 goto exit;
>> > > --
>> > > 2.7.4
>> > >
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> > > the body of a message to majordomo@vger.kernel.org
>> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>  =EF=BF=BD=EF=BF=BD=EC=B9=BB =EF=BF=BD&=EF=BF=BD~=EF=BF=BD&=EF=BF=BD =EF=
=BF=BD=EF=BF=BD+-=EF=BF=BD=EF=BF=BD=DD=B6 =EF=BF=BD=EF=BF=BDw=EF=BF=BD=EF=
=BF=BD=CB=9B=EF=BF=BD=EF=BF=BD=EF=BF=BDm=EF=BF=BDb=EF=BF=BD=EF=BF=BDZr=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD^n=EF=BF=BDr=EF=BF=BD=EF=BF=BD=EF=BF=BDz=
=EF=BF=BD =EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD=
=EF=BF=BD =EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD (=EF=BF=BD=E9=9A=
=8E
>> =EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD =EF=BF=BD m=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=DE=96=EF=BF=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BD=
=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BDm=EF=BF=BD
