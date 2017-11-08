From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] ACPI / PM: Fix acpi_pm_notifier_lock vs.
 flush_workqueue() deadlock
Date: Wed, 8 Nov 2017 14:31:22 +0200
Message-ID: <20171108123122.GY10981@intel.com>
References: <20171107210810.1300-1-ville.syrjala@linux.intel.com>
 <CAJZ5v0gMsuj11CHD_+Ap08rsea9OgdT54LnzkN8oyg03PaAjZA@mail.gmail.com>
 <1551349.SyN5ciAXNe@aspire.rjw.lan>
 <CAJZ5v0hDWbxHSJn++8JneA7UHO1_0wUoYFg_y26DKDqPV2ZejA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbdKHMb1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Nov 2017 07:31:27 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hDWbxHSJn++8JneA7UHO1_0wUoYFg_y26DKDqPV2ZejA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Stable <stable@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>

On Wed, Nov 08, 2017 at 01:23:56PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 8, 2017 at 12:06 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, November 7, 2017 11:47:54 PM CET Rafael J. Wysocki wrote:
> >> On Tue, Nov 7, 2017 at 10:08 PM, Ville Syrjala
> >> <ville.syrjala@linux.intel.com> wrote:
> >> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >> >
> >> > acpi_remove_pm_notifier() ends up calling flush_workqueue() while
> >> > holding acpi_pm_notifier_lock, and that same lock is taken by
> >> > by the work via acpi_pm_notify_handler(). This can deadlock.
> >>
> >> OK, good catch!
> >>
> >> [cut]
> >>
> >> >
> >> > Cc: stable@vger.kernel.org
> >> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> > Cc: Len Brown <lenb@kernel.org>
> >> > Cc: Peter Zijlstra <peterz@infradead.org>
> >> > Cc: Tejun Heo <tj@kernel.org>
> >> > Cc: Ingo Molnar <mingo@kernel.org>
> >> > Fixes: c072530f391e ("ACPI / PM: Revork the handling of ACPI device wakeup notifications")
> >> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >> > ---
> >> >  drivers/acpi/device_pm.c | 21 ++++++++++++---------
> >> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >> >
> >> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> >> > index fbcc73f7a099..18af71057b44 100644
> >> > --- a/drivers/acpi/device_pm.c
> >> > +++ b/drivers/acpi/device_pm.c
> >> > @@ -387,6 +387,7 @@ EXPORT_SYMBOL(acpi_bus_power_manageable);
> >> >
> >> >  #ifdef CONFIG_PM
> >> >  static DEFINE_MUTEX(acpi_pm_notifier_lock);
> >> > +static DEFINE_MUTEX(acpi_pm_notifier_install_lock);
> >> >
> >> >  void acpi_pm_wakeup_event(struct device *dev)
> >> >  {
> >> > @@ -443,24 +444,25 @@ acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
> >> >         if (!dev && !func)
> >> >                 return AE_BAD_PARAMETER;
> >> >
> >> > -       mutex_lock(&acpi_pm_notifier_lock);
> >> > +       mutex_lock(&acpi_pm_notifier_install_lock);
> >> >
> >> >         if (adev->wakeup.flags.notifier_present)
> >> >                 goto out;
> >> >
> >> > -       adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
> >> > -       adev->wakeup.context.dev = dev;
> >> > -       adev->wakeup.context.func = func;
> >> > -
> >>
> >> But this doesn't look good to me.
> >>
> >> notifier_present should be checked under acpi_pm_notifier_lock.
> >>
> >> Actually, acpi_install_notify_handler() itself need not be called
> >> under the lock, because it does sufficient checks of its own.
> >>
> >> So say you do
> >>
> >> mutex_lock(&acpi_pm_notifier_lock);
> >>
> >> if (adev->wakeup.context.dev)
> >>         goto out;
> >>
> >> adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
> >> adev->wakeup.context.dev = dev;
> >> adev->wakeup.context.func = func;
> >>
> >> mutex_unlock(&acpi_pm_notifier_lock);
> >>
> >> >         status = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
> >> >                                              acpi_pm_notify_handler, NULL);
> >> >         if (ACPI_FAILURE(status))
> >> >                 goto out;
> >> >
> >> > +       mutex_lock(&acpi_pm_notifier_lock);
> >>
> >> And here you just set notifier_present under acpi_pm_notifier_lock.
> >>
> >> > +       adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
> >> > +       adev->wakeup.context.dev = dev;
> >> > +       adev->wakeup.context.func = func;
> >> >         adev->wakeup.flags.notifier_present = true;
> >> > +       mutex_unlock(&acpi_pm_notifier_lock);
> >> >
> >> >   out:
> >> > -       mutex_unlock(&acpi_pm_notifier_lock);
> >> > +       mutex_unlock(&acpi_pm_notifier_install_lock);
> >> >         return status;
> >> >  }
> >>
> >> Then on removal you can clear notifier_present first and drop the lock
> >> around the acpi_remove_notify_handler() call and nothing bad will
> >> happen.
> >>
> >> If you call acpi_add_pm_notifier() twice in parallel, the first
> >> instance will set context.dev and the second one will see it set and
> >> bail out.  The first instance will then do the rest.
> >>
> >> If you call acpi_remove_pm_notifier() twice in a row, the first
> >> instance will see notifier_present set and will clear it, so the
> >> second one will see notifier_present unset and it will bail out.
> >>
> >> Now, if you call acpi_remove_pm_notifier() in parallel with
> >> acpi_add_pm_notifier(), either the former will see notifier_present
> >> unset and bail out, or the latter will see context.dev unset and bail
> >> out.
> >>
> >> It doesn't look like the outer lock is needed, or have I missed anything?
> >
> > So something like the below (totally untested) should work too, shouldn't it?
> 
> There is a problem if a device is removed while acpi_add_pm_notifier()
> is still in progress, in which case with my patch the
> acpi_remove_pm_notifier() called from the removal path may bail out
> prematurely (that doesn't seem likely to happen, but still I don't see
> why it cannot happen), so I'll just use your patch. :-)

OK. I was just looking at your version and was pretty much convinced
that it would work. But I'll take your word that it might not :)

-- 
Ville Syrjälä
Intel OTC
