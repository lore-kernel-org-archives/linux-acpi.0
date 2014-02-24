From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI / PM: Resume runtime-suspended devices later
 during system suspend
Date: Mon, 24 Feb 2014 13:58:05 -0700
Message-ID: <CAErSpo5rX=1YnAR8QZYLsww-1c4_KvAgEZEkkQ5C26=+cEYqFw@mail.gmail.com>
References: <1853950.oxM3KDpyLu@vostro.rjw.lan> <3851541.s2776YTCMH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58822 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbaBXU60 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Feb 2014 15:58:26 -0500
Received: by mail-ie0-f173.google.com with SMTP id lx4so4017870iec.18
        for <linux-acpi@vger.kernel.org>; Mon, 24 Feb 2014 12:58:25 -0800 (PST)
In-Reply-To: <3851541.s2776YTCMH@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

On Sun, Feb 23, 2014 at 4:21 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Runtime-suspended devices are resumed during system suspend by
> pci_pm_prepare() for two reasons: First, because they may need
> to be reprogrammed in order to change their wakeup settings and,
> second, because they may need to be operatonal for their children
> to be successfully suspended.  That is a problem, though, if there
> are many runtime-suspended devices that need to be resumed this
> way during system suspend, because the .prepare() PM callbacks of
> devices are executed sequentially and the times taken by them
> accumulate, which may increase the total system suspend time quite
> a bit.
>
> For this reason, move the resume of runtime-suspended devices up
> to the next phase of device suspend (during system suspend), except
> for the ones that have power.ignore_children set.  The exception is
> made, because the devices with power.ignore_children set may still
> be necessary for their children to be successfully suspended (during
> system suspend) and they won't be resumed automatically as a result
> of the runtime resume of their children.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

You can merge these two via your tree if you want.  I don't have any
changes queued up for pci-driver.c.

Bjorn

> ---
>  drivers/pci/pci-driver.c |   33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -616,15 +616,11 @@ static int pci_pm_prepare(struct device
>         int error = 0;
>
>         /*
> -        * PCI devices suspended at run time need to be resumed at this
> -        * point, because in general it is necessary to reconfigure them for
> -        * system suspend.  Namely, if the device is supposed to wake up the
> -        * system from the sleep state, we may need to reconfigure it for this
> -        * purpose.  In turn, if the device is not supposed to wake up the
> -        * system from the sleep state, we'll have to prevent it from signaling
> -        * wake-up.
> +        * Devices having power.ignore_children set may still be necessary for
> +        * suspending their children in the next phase of device suspend.
>          */
> -       pm_runtime_resume(dev);
> +       if (dev->power.ignore_children)
> +               pm_runtime_resume(dev);
>
>         if (drv && drv->pm && drv->pm->prepare)
>                 error = drv->pm->prepare(dev);
> @@ -654,6 +650,16 @@ static int pci_pm_suspend(struct device
>                 goto Fixup;
>         }
>
> +       /*
> +        * PCI devices suspended at run time need to be resumed at this point,
> +        * because in general it is necessary to reconfigure them for system
> +        * suspend.  Namely, if the device is supposed to wake up the system
> +        * from the sleep state, we may need to reconfigure it for this purpose.
> +        * In turn, if the device is not supposed to wake up the system from the
> +        * sleep state, we'll have to prevent it from signaling wake-up.
> +        */
> +       pm_runtime_resume(dev);
> +
>         pci_dev->state_saved = false;
>         if (pm->suspend) {
>                 pci_power_t prev = pci_dev->current_state;
> @@ -808,6 +814,14 @@ static int pci_pm_freeze(struct device *
>                 return 0;
>         }
>
> +       /*
> +        * This used to be done in pci_pm_prepare() for all devices and some
> +        * drivers may depend on it, so do it here.  Ideally, runtime-suspended
> +        * devices should not be touched during freeze/thaw transitions,
> +        * however.
> +        */
> +       pm_runtime_resume(dev);
> +
>         pci_dev->state_saved = false;
>         if (pm->freeze) {
>                 int error;
> @@ -915,6 +929,9 @@ static int pci_pm_poweroff(struct device
>                 goto Fixup;
>         }
>
> +       /* The reason to do that is the same as in pci_pm_suspend(). */
> +       pm_runtime_resume(dev);
> +
>         pci_dev->state_saved = false;
>         if (pm->poweroff) {
>                 int error;
>
