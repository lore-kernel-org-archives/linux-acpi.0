From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] acpi: handle the acpi hotplug schedule error
Date: Wed, 7 Jun 2017 18:18:32 +0800
Message-ID: <20170607101832.GW30622@linux-l9pv.suse>
References: <20170607060527.23407-1-jlee@suse.com>
 <CAHp75Vdeagae37PHoD4yw4dncFQJ2tmuxRu0zzbH_b+SnY4pEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:51152 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdFGKSv (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Wed, 7 Jun 2017 06:18:51 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75Vdeagae37PHoD4yw4dncFQJ2tmuxRu0zzbH_b+SnY4pEQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

Hi Andy, 

Thanks for your help to review my patch.

On Wed, Jun 07, 2017 at 11:36:55AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 7, 2017 at 9:05 AM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > Kernel should decrements the reference count of acpi device
> > when scheduling acpi hotplug work is failed, and also evaluates
> > _OST to notify BIOS the failure.
> 
> > -       if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> > -               return;

A note here...
When the acpi hotplug job is scheduled success, the adev device can not
be put because acpi_device_hotplug() will put it until hotplug routine
finished.

drivers/acpi/bus.c  acpi_bus_notify()
                    acpi_bus_get_acpi_device(handle) //get here
    drivers/acpi/osl.c  acpi_hotplug_schedule()
        drivers/acpi/osl.c  acpi_hotplug_work_fn()
            drivers/acpi/scan.c  acpi_device_hotplug()
                                 acpi_bus_put_acpi_device(adev) //put here

> > +       if (hotplug_event) {
> > +               if (ACPI_FAILURE(acpi_hotplug_schedule(adev, type))) {
> > +                       acpi_bus_put_acpi_device(adev);
> > +                       goto err;
> > +               } else {
> > +                       return;
> > +               }
> > +       }
> 
> Wouldn't be simpler to
> 
> -               return;
> +               goto err_put_device;
> 
> + err_put_device:
> +       acpi_bus_put_acpi_device(adev);
>  err:
>

So, do you mean like this?

	-       if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
	-               return;
	+       if (hotplug_event) {
	+               if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type))) 
	+                       return;
	+               else
	+                       goto err_put_device;
	+       }

		acpi_bus_put_acpi_device(adev);
		return;

	+err_put_device:
	+       acpi_bus_put_acpi_device(adev);
	 err:
		acpi_evaluate_ost(handle, type, ost_code, NULL);
	}

Thanks for your suggestion, it looks simpler.

Joey Lee
