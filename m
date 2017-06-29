From: joeyli <jlee@suse.com>
Subject: Re: [PATCH v2] acpi: handle the acpi hotplug schedule error
Date: Fri, 30 Jun 2017 07:16:49 +0800
Message-ID: <20170629231649.GA13714@linux-l9pv.suse>
References: <20170621070434.16570-1-jlee@suse.com>
 <2576656.sje5KLSpq7@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:55460 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdF2XR3 (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Thu, 29 Jun 2017 19:17:29 -0400
Content-Disposition: inline
In-Reply-To: <2576656.sje5KLSpq7@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Michal Hocko <mhocko@suse.cz>

Hi Rafael, 

Thanks for your review.

On Thu, Jun 29, 2017 at 12:06:20AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, June 21, 2017 03:04:34 PM Lee, Chun-Yi wrote:
> > Kernel should decrements the reference count of acpi device
> > when the scheduling of acpi hotplug work is failed, and
> > evaluates _OST to notify BIOS the failure.
> > 
> > v2:
> > To simplify the code. (Andy Shevchenko)
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Michal Hocko <mhocko@suse.cz>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> 
> Well, what about:
> 
>     if (!hotplug_event) {
>         acpi_bus_put_acpi_device(adev);
>         return;
>     }
> 
>     if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
>         return;
> 
>     acpi_bus_put_acpi_device(adev);
> 
> err:
>     acpi_evaluate_ost(handle, type, ost_code, NULL);
> 
> This achieves the same as the patch below to my eyes, but looks
> less convoluted IMO.
> 

Yes, that's better. I will send v3 patch.

Joey Lee

> 
> > ---
> >  drivers/acpi/bus.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 34fbe02..91adb71 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -427,12 +427,17 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
> >  	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
> >  		driver->ops.notify(adev, type);
> >  
> > -	if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> > -		return;
> > +	if (hotplug_event) {
> > +		if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> > +			return;
> > +		goto err_put_device;
> > +	}
> >  
> >  	acpi_bus_put_acpi_device(adev);
> >  	return;
> >  
> > + err_put_device:
> > +	acpi_bus_put_acpi_device(adev);
> >   err:
> >  	acpi_evaluate_ost(handle, type, ost_code, NULL);
> >  }
> > 
> 
