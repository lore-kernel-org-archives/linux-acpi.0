From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] PM: Introduce core framework for run-time PM of I/O
	devices
Date: Sun, 14 Jun 2009 18:41:04 +0900
Message-ID: <aec7e5c30906140241w174e9585y3c5ebac2f4e8537d@mail.gmail.com>
References: <200906140023.36147.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:48713 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbZFNJlD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Jun 2009 05:41:03 -0400
In-Reply-To: <200906140023.36147.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Magnus Damm <damm@igel.co.jp>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Rafael,

On Sun, Jun 14, 2009 at 7:23 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> Below is the current version of my "run-time PM for I/O devices" patc=
h.
>
> I've done my best to address the comments received during the recent
> discussions, but at the same time I've tried to make the patch only c=
ontain
> the most essential things. =A0For this reason, for example, the sysfs=
 interface
> is not there and it's going to be added in a separate patch.

Good decision. Let's do this step by step.

> Please let me know if you want me to change anything in this patch or=
 to add
> anything new to it. =A0[Magnus, I remember you wanted something like
> ->runtime_wakeup() along with ->runtime_idle(), but I'm not sure it's=
 really
> necessary. =A0Please let me know if you have any particular usage sce=
nario for
> it.]

I will keep on building my arch specific platform bus code on top of
the latest version of this patch.

However, to begin with I'll not make use of the ->runtime_idle()
callback in the bus code. This because rearranging the existing
platform devices into a tree will require a lot of rewriting, and I'm
not convinced it's the right approach. I'd rather focus on getting
basic functionality in place at this point. So if no one else needs
->runtime_idle(), feel free to exclude the ->runtime_idle() part if
you want to make the patch even leaner to begin with.

Together with the bus specific callbacks I plan to modify device
drivers to include pm_runtime_suspend() / pm_runtime_resume() calls to
notify the bus code when they are idle and when they need wakeup,
similar to my earlier proposal with
platform_device_idle()/platform_device_wakeup().

> --- linux-2.6.orig/include/linux/pm.h
> +++ linux-2.6/include/linux/pm.h
> @@ -182,6 +205,11 @@ struct dev_pm_ops {
> =A0 =A0 =A0 =A0int (*thaw_noirq)(struct device *dev);
> =A0 =A0 =A0 =A0int (*poweroff_noirq)(struct device *dev);
> =A0 =A0 =A0 =A0int (*restore_noirq)(struct device *dev);
> +#ifdef CONFIG_PM_RUNTIME
> + =A0 =A0 =A0 int (*runtime_suspend)(struct device *dev);
> + =A0 =A0 =A0 int (*runtime_resume)(struct device *dev);
> + =A0 =A0 =A0 void (*runtime_idle)(struct device *dev);
> +#endif

Do we really need to wrap these in CONFIG_PM_RUNTIME? The callbacks
for STR and STD are not wrapped in CONFIG_SUSPEND and
CONFIG_HIBERNATION, right?

> --- /dev/null
> +++ linux-2.6/drivers/base/power/runtime.c
[snip]
> +/**
> + * pm_runtime_suspend - Run a device bus type's runtime_suspend() ca=
llback.
> + * @dev: Device to suspend.
> + *
> + * Check if the status of the device is appropriate and run the
> + * ->runtime_suspend() callback provided by the device's bus type dr=
iver.
> + * Update the run-time PM flags in the device object to reflect the =
current
> + * status of the device.
> + */
> +int pm_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 int error =3D 0;

I'm sure you put a lot of thought into this already, but is it really
the best approach to assume that busses without runtime pm callbacks
can be suspended? I'd go with an error value by default and only
return 0 as callback return value.

> +/**
> + * pm_cancel_suspend - Cancel a pending suspend request for given de=
vice.
> + * @dev: Device to cancel the suspend request for.
> + *
> + * Should be called under pm_lock_device() and only if we are sure t=
hat the
> + * ->autosuspend() callback hasn't started to yet.
> + */
> +static void pm_cancel_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 dev->power.suspend_aborted =3D true;
> + =A0 =A0 =A0 cancel_delayed_work(&dev->power.runtime_work);
> + =A0 =A0 =A0 dev->power.runtime_status =3D RPM_ACTIVE;
> +}

This pm_lock_device() comment seems to come from old code, no?

> +/**
> + * pm_runtime_resume - Run a device bus type's runtime_resume() call=
back.
> + * @dev: Device to resume.
> + *
> + * Check if the device is really suspended and run the ->runtime_res=
ume()
> + * callback provided by the device's bus type driver. =A0Update the =
run-time PM
> + * flags in the device object to reflect the current status of the d=
evice. =A0If
> + * runtime suspend is in progress while this function is being run, =
wait for it
> + * to finish before resuming the device. =A0If runtime suspend is sc=
heduled, but
> + * it hasn't started yet, cancel it and we're done.
> + */
> +int pm_runtime_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 int error =3D 0;

Same here, does non-existing runtime pm callbacks really mean we can re=
sume?

> +/**
> + * pm_runtime_disable - Disable run-time power management for given =
device.
> + * @dev: Device to handle.
> + *
> + * Increase the depth field in the device's dev_pm_info structure, w=
hich will
> + * cause the run-time PM functions above to return without doing any=
thing.
> + * If there is a run-time PM operation in progress, wait for it to c=
omplete.
> + */
> +void pm_runtime_disable(struct device *dev)
> +{
> + =A0 =A0 =A0 might_sleep();
> +
> + =A0 =A0 =A0 atomic_inc(&dev->power.depth);
> +
> + =A0 =A0 =A0 if (dev->power.runtime_status & RPM_IN_PROGRESS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion(&dev->power.work_do=
ne);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_disable);
> +
> +/**
> + * pm_runtime_enable - Disable run-time power management for given d=
evice.
> + * @dev: Device to handle.
> + *
> + * Enable run-time power management for given device by decreasing t=
he depth
> + * field in its dev_pm_info structure.
> + */
> +void pm_runtime_enable(struct device *dev)
> +{
> + =A0 =A0 =A0 if (!atomic_add_unless(&dev->power.depth, -1, 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev, "PM: Excessive pm_runtime=
_enable()!\n");
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_enable);

Any thoughts on performing ->runtime_resume()/->runtime_suspend() in
enable() and disable()? I guess it's performed too early/late to make
sense from the driver point of view?

Looking good, thanks a lot for your work on this!

Any chance we can get this included in -rc1?

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
