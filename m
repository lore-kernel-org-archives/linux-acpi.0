From: jlee@suse.com
Subject: Re: [PATCH v3] acpi: handle the acpi hotplug schedule error
Date: Sat, 8 Jul 2017 11:25:12 +0800
Message-ID: <20170708032512.jz7bxgmobzrf7dzp@linux-rasp2>
References: <20170707062242.29588-1-jlee@suse.com>
 <1704918.scVG4c48Sb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:48480 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdGHDZj (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Fri, 7 Jul 2017 23:25:39 -0400
Content-Disposition: inline
In-Reply-To: <1704918.scVG4c48Sb@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Michal Hocko <mhocko@suse.cz>

Hi Rafael,

On Fri, Jul 07, 2017 at 03:16:40PM +0200, Rafael J. Wysocki wrote:
> On Friday, July 07, 2017 02:22:42 PM Lee, Chun-Yi wrote:
> > Kernel should decrements the reference count of acpi device
> > when the scheduling of acpi hotplug work failed, and evaluates
> > _OST to notify BIOS the failure.
> > 
> > v3:
> > More simplify the code. (Rafael J. Wysocki)
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
> This has been applied too AFAICS.
> 

I saw patches in linux-next.

Thanks for your review.

Joey Lee

> > ---
> >  drivers/acpi/bus.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 784bda6..9d4fea6 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -432,11 +432,15 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
> >  	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
> >  		driver->ops.notify(adev, type);
> >  
> > -	if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> > +	if (!hotplug_event) {
> > +		acpi_bus_put_acpi_device(adev);
> > +		return;
> > +	}
> > +
> > +	if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> >  		return;
> >  
> >  	acpi_bus_put_acpi_device(adev);
> > -	return;
> >  
> >   err:
> >  	acpi_evaluate_ost(handle, type, ost_code, NULL);
> > 
> 
