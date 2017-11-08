From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / PM: Fix acpi_pm_notifier_lock vs.
 flush_workqueue() deadlock
Date: Wed, 8 Nov 2017 13:55:06 +0100
Message-ID: <CAJZ5v0hc-3GcNizFUTk6iJOQjxOvT6CSOuG_0+z1Y1s9AjiNZA@mail.gmail.com>
References: <20171107210810.1300-1-ville.syrjala@linux.intel.com>
 <CAJZ5v0hDWbxHSJn++8JneA7UHO1_0wUoYFg_y26DKDqPV2ZejA@mail.gmail.com>
 <20171108123122.GY10981@intel.com> <2610015.zRzb04OUDn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:57121 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbdKHMzI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Nov 2017 07:55:08 -0500
In-Reply-To: <2610015.zRzb04OUDn@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Stable <stable@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>

On Wed, Nov 8, 2017 at 1:41 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> On Wednesday, November 8, 2017 1:31:22 PM CET Ville Syrj=C3=A4l=C3=A4 wro=
te:
>> On Wed, Nov 08, 2017 at 01:23:56PM +0100, Rafael J. Wysocki wrote:
>> > On Wed, Nov 8, 2017 at 12:06 AM, Rafael J. Wysocki <rjw@rjwysocki.net>=
 wrote:
>> > > On Tuesday, November 7, 2017 11:47:54 PM CET Rafael J. Wysocki wrote=
:
>> > >> On Tue, Nov 7, 2017 at 10:08 PM, Ville Syrjala
>> > >> <ville.syrjala@linux.intel.com> wrote:
>> > >> > From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> > >> >
>> > >> > acpi_remove_pm_notifier() ends up calling flush_workqueue() while
>> > >> > holding acpi_pm_notifier_lock, and that same lock is taken by
>> > >> > by the work via acpi_pm_notify_handler(). This can deadlock.
>> > >>
>> > >> OK, good catch!
>> > >>
>> > >> [cut]
>> > >>
>> > >> >
>> > >> > Cc: stable@vger.kernel.org
>> > >> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > >> > Cc: Len Brown <lenb@kernel.org>
>> > >> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > >> > Cc: Tejun Heo <tj@kernel.org>
>> > >> > Cc: Ingo Molnar <mingo@kernel.org>
>> > >> > Fixes: c072530f391e ("ACPI / PM: Revork the handling of ACPI devi=
ce wakeup notifications")
>> > >> > Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel=
.com>
>> > >> > ---
>> > >> >  drivers/acpi/device_pm.c | 21 ++++++++++++---------
>> > >> >  1 file changed, 12 insertions(+), 9 deletions(-)
>> > >> >
>> > >> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>> > >> > index fbcc73f7a099..18af71057b44 100644
>> > >> > --- a/drivers/acpi/device_pm.c
>> > >> > +++ b/drivers/acpi/device_pm.c
>> > >> > @@ -387,6 +387,7 @@ EXPORT_SYMBOL(acpi_bus_power_manageable);
>> > >> >
>> > >> >  #ifdef CONFIG_PM
>> > >> >  static DEFINE_MUTEX(acpi_pm_notifier_lock);
>> > >> > +static DEFINE_MUTEX(acpi_pm_notifier_install_lock);
>> > >> >
>> > >> >  void acpi_pm_wakeup_event(struct device *dev)
>> > >> >  {
>> > >> > @@ -443,24 +444,25 @@ acpi_status acpi_add_pm_notifier(struct acp=
i_device *adev, struct device *dev,
>> > >> >         if (!dev && !func)
>> > >> >                 return AE_BAD_PARAMETER;
>> > >> >
>> > >> > -       mutex_lock(&acpi_pm_notifier_lock);
>> > >> > +       mutex_lock(&acpi_pm_notifier_install_lock);
>> > >> >
>> > >> >         if (adev->wakeup.flags.notifier_present)
>> > >> >                 goto out;
>> > >> >
>> > >> > -       adev->wakeup.ws =3D wakeup_source_register(dev_name(&adev=
->dev));
>> > >> > -       adev->wakeup.context.dev =3D dev;
>> > >> > -       adev->wakeup.context.func =3D func;
>> > >> > -
>> > >>
>> > >> But this doesn't look good to me.
>> > >>
>> > >> notifier_present should be checked under acpi_pm_notifier_lock.
>> > >>
>> > >> Actually, acpi_install_notify_handler() itself need not be called
>> > >> under the lock, because it does sufficient checks of its own.
>> > >>
>> > >> So say you do
>> > >>
>> > >> mutex_lock(&acpi_pm_notifier_lock);
>> > >>
>> > >> if (adev->wakeup.context.dev)
>> > >>         goto out;
>> > >>
>> > >> adev->wakeup.ws =3D wakeup_source_register(dev_name(&adev->dev));
>> > >> adev->wakeup.context.dev =3D dev;
>> > >> adev->wakeup.context.func =3D func;
>> > >>
>> > >> mutex_unlock(&acpi_pm_notifier_lock);
>> > >>
>> > >> >         status =3D acpi_install_notify_handler(adev->handle, ACPI=
_SYSTEM_NOTIFY,
>> > >> >                                              acpi_pm_notify_handl=
er, NULL);
>> > >> >         if (ACPI_FAILURE(status))
>> > >> >                 goto out;
>> > >> >
>> > >> > +       mutex_lock(&acpi_pm_notifier_lock);
>> > >>
>> > >> And here you just set notifier_present under acpi_pm_notifier_lock.
>> > >>
>> > >> > +       adev->wakeup.ws =3D wakeup_source_register(dev_name(&adev=
->dev));
>> > >> > +       adev->wakeup.context.dev =3D dev;
>> > >> > +       adev->wakeup.context.func =3D func;
>> > >> >         adev->wakeup.flags.notifier_present =3D true;
>> > >> > +       mutex_unlock(&acpi_pm_notifier_lock);
>> > >> >
>> > >> >   out:
>> > >> > -       mutex_unlock(&acpi_pm_notifier_lock);
>> > >> > +       mutex_unlock(&acpi_pm_notifier_install_lock);
>> > >> >         return status;
>> > >> >  }
>> > >>
>> > >> Then on removal you can clear notifier_present first and drop the l=
ock
>> > >> around the acpi_remove_notify_handler() call and nothing bad will
>> > >> happen.
>> > >>
>> > >> If you call acpi_add_pm_notifier() twice in parallel, the first
>> > >> instance will set context.dev and the second one will see it set an=
d
>> > >> bail out.  The first instance will then do the rest.
>> > >>
>> > >> If you call acpi_remove_pm_notifier() twice in a row, the first
>> > >> instance will see notifier_present set and will clear it, so the
>> > >> second one will see notifier_present unset and it will bail out.
>> > >>
>> > >> Now, if you call acpi_remove_pm_notifier() in parallel with
>> > >> acpi_add_pm_notifier(), either the former will see notifier_present
>> > >> unset and bail out, or the latter will see context.dev unset and ba=
il
>> > >> out.
>> > >>
>> > >> It doesn't look like the outer lock is needed, or have I missed any=
thing?
>> > >
>> > > So something like the below (totally untested) should work too, shou=
ldn't it?
>> >
>> > There is a problem if a device is removed while acpi_add_pm_notifier()
>> > is still in progress, in which case with my patch the
>> > acpi_remove_pm_notifier() called from the removal path may bail out
>> > prematurely (that doesn't seem likely to happen, but still I don't see
>> > why it cannot happen), so I'll just use your patch. :-)
>>
>> OK. I was just looking at your version and was pretty much convinced
>> that it would work. But I'll take your word that it might not :)
>
> Well, you don't have to. :-)
>
> The scenario I have in mind is as follows:
>
> 1. acpi_add_pm_notifier() sets context.dev and context.func and drops the
>    lock.  notifier_present is still unset.
>
> 2. acpi_remove_pm_notifier() checks notifier_present under the lock.
>    It is (still) unset, so the function decides that there's nothing to d=
o.
>
> 3. acpi_add_pm_notifier() continues with notifier installation and the
>    device goes away at the same time.

Of course, the outer lock doesn't help against
acpi_remove_pm_notifier() in the removal path running right before
acpi_add_pm_notifier(), so if there's no other mutual exclusion, we
still have a problem in there (need to check that).

Thanks,
Rafael
