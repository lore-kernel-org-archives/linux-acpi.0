From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / PM: Fix acpi_pm_notifier_lock vs. flush_workqueue() deadlock
Date: Wed, 08 Nov 2017 00:06:35 +0100
Message-ID: <1551349.SyN5ciAXNe@aspire.rjw.lan>
References: <20171107210810.1300-1-ville.syrjala@linux.intel.com> <CAJZ5v0gMsuj11CHD_+Ap08rsea9OgdT54LnzkN8oyg03PaAjZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47331 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751741AbdKGXGk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Nov 2017 18:06:40 -0500
In-Reply-To: <CAJZ5v0gMsuj11CHD_+Ap08rsea9OgdT54LnzkN8oyg03PaAjZA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Stable <stable@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>

On Tuesday, November 7, 2017 11:47:54 PM CET Rafael J. Wysocki wrote:
> On Tue, Nov 7, 2017 at 10:08 PM, Ville Syrjala
> <ville.syrjala@linux.intel.com> wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> > acpi_remove_pm_notifier() ends up calling flush_workqueue() while
> > holding acpi_pm_notifier_lock, and that same lock is taken by
> > by the work via acpi_pm_notify_handler(). This can deadlock.
> 
> OK, good catch!
> 
> [cut]
> 
> >
> > Cc: stable@vger.kernel.org
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Fixes: c072530f391e ("ACPI / PM: Revork the handling of ACPI device wakeup notifications")
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/acpi/device_pm.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > index fbcc73f7a099..18af71057b44 100644
> > --- a/drivers/acpi/device_pm.c
> > +++ b/drivers/acpi/device_pm.c
> > @@ -387,6 +387,7 @@ EXPORT_SYMBOL(acpi_bus_power_manageable);
> >
> >  #ifdef CONFIG_PM
> >  static DEFINE_MUTEX(acpi_pm_notifier_lock);
> > +static DEFINE_MUTEX(acpi_pm_notifier_install_lock);
> >
> >  void acpi_pm_wakeup_event(struct device *dev)
> >  {
> > @@ -443,24 +444,25 @@ acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
> >         if (!dev && !func)
> >                 return AE_BAD_PARAMETER;
> >
> > -       mutex_lock(&acpi_pm_notifier_lock);
> > +       mutex_lock(&acpi_pm_notifier_install_lock);
> >
> >         if (adev->wakeup.flags.notifier_present)
> >                 goto out;
> >
> > -       adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
> > -       adev->wakeup.context.dev = dev;
> > -       adev->wakeup.context.func = func;
> > -
> 
> But this doesn't look good to me.
> 
> notifier_present should be checked under acpi_pm_notifier_lock.
> 
> Actually, acpi_install_notify_handler() itself need not be called
> under the lock, because it does sufficient checks of its own.
> 
> So say you do
> 
> mutex_lock(&acpi_pm_notifier_lock);
> 
> if (adev->wakeup.context.dev)
>         goto out;
> 
> adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
> adev->wakeup.context.dev = dev;
> adev->wakeup.context.func = func;
> 
> mutex_unlock(&acpi_pm_notifier_lock);
> 
> >         status = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
> >                                              acpi_pm_notify_handler, NULL);
> >         if (ACPI_FAILURE(status))
> >                 goto out;
> >
> > +       mutex_lock(&acpi_pm_notifier_lock);
> 
> And here you just set notifier_present under acpi_pm_notifier_lock.
> 
> > +       adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
> > +       adev->wakeup.context.dev = dev;
> > +       adev->wakeup.context.func = func;
> >         adev->wakeup.flags.notifier_present = true;
> > +       mutex_unlock(&acpi_pm_notifier_lock);
> >
> >   out:
> > -       mutex_unlock(&acpi_pm_notifier_lock);
> > +       mutex_unlock(&acpi_pm_notifier_install_lock);
> >         return status;
> >  }
> 
> Then on removal you can clear notifier_present first and drop the lock
> around the acpi_remove_notify_handler() call and nothing bad will
> happen.
> 
> If you call acpi_add_pm_notifier() twice in parallel, the first
> instance will set context.dev and the second one will see it set and
> bail out.  The first instance will then do the rest.
> 
> If you call acpi_remove_pm_notifier() twice in a row, the first
> instance will see notifier_present set and will clear it, so the
> second one will see notifier_present unset and it will bail out.
> 
> Now, if you call acpi_remove_pm_notifier() in parallel with
> acpi_add_pm_notifier(), either the former will see notifier_present
> unset and bail out, or the latter will see context.dev unset and bail
> out.
> 
> It doesn't look like the outer lock is needed, or have I missed anything?

So something like the below (totally untested) should work too, shouldn't it?

---
 drivers/acpi/device_pm.c |   35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -424,6 +424,13 @@ static void acpi_pm_notify_handler(acpi_
 	acpi_bus_put_acpi_device(adev);
 }
 
+static void acpi_dev_wakeup_cleanup(struct acpi_device *adev)
+{
+	adev->wakeup.context.func = NULL;
+	adev->wakeup.context.dev = NULL;
+	wakeup_source_unregister(adev->wakeup.ws);
+}
+
 /**
  * acpi_add_pm_notifier - Register PM notify handler for given ACPI device.
  * @adev: ACPI device to add the notify handler for.
@@ -445,17 +452,24 @@ acpi_status acpi_add_pm_notifier(struct
 
 	mutex_lock(&acpi_pm_notifier_lock);
 
-	if (adev->wakeup.flags.notifier_present)
+	if (adev->wakeup.context.dev || adev->wakeup.context.func)
 		goto out;
 
 	adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
 	adev->wakeup.context.dev = dev;
 	adev->wakeup.context.func = func;
 
+	mutex_unlock(&acpi_pm_notifier_lock);
+
 	status = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
 					     acpi_pm_notify_handler, NULL);
-	if (ACPI_FAILURE(status))
+
+	mutex_lock(&acpi_pm_notifier_lock);
+
+	if (ACPI_FAILURE(status)) {
+		acpi_dev_wakeup_cleanup(adev);
 		goto out;
+	}
 
 	adev->wakeup.flags.notifier_present = true;
 
@@ -477,17 +491,22 @@ acpi_status acpi_remove_pm_notifier(stru
 	if (!adev->wakeup.flags.notifier_present)
 		goto out;
 
+	adev->wakeup.flags.notifier_present = false;
+
+	mutex_unlock(&acpi_pm_notifier_lock);
+
 	status = acpi_remove_notify_handler(adev->handle,
 					    ACPI_SYSTEM_NOTIFY,
 					    acpi_pm_notify_handler);
-	if (ACPI_FAILURE(status))
-		goto out;
 
-	adev->wakeup.context.func = NULL;
-	adev->wakeup.context.dev = NULL;
-	wakeup_source_unregister(adev->wakeup.ws);
+	mutex_lock(&acpi_pm_notifier_lock);
 
-	adev->wakeup.flags.notifier_present = false;
+	if (ACPI_FAILURE(status)) {
+		adev->wakeup.flags.notifier_present = true;
+		goto out;
+	}
+
+	acpi_dev_wakeup_cleanup(adev);
 
  out:
 	mutex_unlock(&acpi_pm_notifier_lock);

