From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH V2] ACPI/Battery: Retry to get Battery information if
 failed during probing
Date: Wed, 18 Jun 2014 15:15:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1406181515160.21927@chino.kir.corp.google.com>
References: <1402988994-27067-1-git-send-email-tianyu.lan@intel.com> <1474004.fDjayHqHT9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:42152 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaFRWPu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2014 18:15:50 -0400
Received: by mail-ie0-f172.google.com with SMTP id lx4so1312087iec.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2014 15:15:49 -0700 (PDT)
In-Reply-To: <1474004.fDjayHqHT9@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 17 Jun 2014, Rafael J. Wysocki wrote:

> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index e48fc98..8ed93a3 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/dmi.h>
> >  #include <linux/slab.h>
> >  #include <linux/suspend.h>
> > +#include <linux/delay.h>
> >  #include <asm/unaligned.h>
> >  
> >  #ifdef CONFIG_ACPI_PROCFS_POWER
> > @@ -1119,7 +1120,7 @@ static struct dmi_system_id bat_dmi_table[] = {
> >  
> >  static int acpi_battery_add(struct acpi_device *device)
> >  {
> > -	int result = 0;
> > +	int result = 0, retry = 5;
> >  	struct acpi_battery *battery = NULL;
> >  
> >  	if (!device)
> > @@ -1135,9 +1136,20 @@ static int acpi_battery_add(struct acpi_device *device)
> >  	mutex_init(&battery->sysfs_lock);
> >  	if (acpi_has_method(battery->device->handle, "_BIX"))
> >  		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
> > -	result = acpi_battery_update(battery, false);
> > +
> > +	/*
> > +	 * Some machines'(E,G Lenovo Z480) ECs are not stable
> > +	 * during boot up and this causes battery driver fails to be
> > +	 * probed due to failure of getting battery information
> > +	 * from EC sometimes. After several retries, the operation
> > +	 * may work. So add retry code here and 20ms sleep between
> > +	 * every retries.
> > +	 */
> > +	while ((result = acpi_battery_update(battery, false)) && retry--)
> > +		msleep(20);
> >  	if (result)
> >  		goto fail;
> 
> Why not to write this as
> 
> 	for (;;) {
> 		result = acpi_battery_update(battery, false);
> 		if (!result)
> 			break;
> 		else if (!--retry)
> 			goto fail;
> 
> 		msleep(20);
> 	}
> 

I suggested a similar for loop earlier, I think it's cleaner.
