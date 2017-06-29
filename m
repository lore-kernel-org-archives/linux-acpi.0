From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] acpi: thermal: honor "mode" sysfs file setting
Date: Thu, 29 Jun 2017 13:19:42 +0800
Message-ID: <1498713582.2510.27.camel@intel.com>
References: <20170622124542.12063-1-enric.balletbo@collabora.com>
         <3358778.pxacZRAVRa@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20499 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbdF2FTt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Jun 2017 01:19:49 -0400
In-Reply-To: <3358778.pxacZRAVRa@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Sameer Nanda <snanda@chromium.org>, "Zhang, Rui" <rui.zhang@intel.com>

On Thu, 2017-06-29 at 00:14 +0200, Rafael J. Wysocki wrote:
> On Thursday, June 22, 2017 02:45:42 PM Enric Balletbo i Serra wrote:
> > 
> > From: Sameer Nanda <snanda@chromium.org>
> > 
> > Under each thermal zone there is a file called "mode". Writing
> > enabled
> > or disabled to this file allows a given thermal zone to be enabled
> > or
> > disabled. Honor writes to this file by enabling or disabling the
> > polling timers.
> > 
> > With this change, in the acpi_thermal_add path,
> > acpi_thermal_get_info
> > gets called before acpi_thermal_register_thermal_zone. Since
> > tz_enabled
> > was getting set to 1 only in acpi_thermal_register_thermal_zone,
> > acpi_thermal_get_info ended up disabling thermal polling so moved
> > the
> > setting of tz_enabled to 1 into acpi_thermal_add itself.
> > 
> > After this patch echoing enabled|disabled to "mode" sysfs will
> > start/stop
> > the polling of the temperature.
> > 
I see, so there are three logics to decide the polling frequency

1. returned by _TZP, according to ACPI spec
2. overridden by thermal.tzp module parameter
3. cleared when the thermal zone is disabled and restored when the
thermal zone is re-enabled (missing in current code)

what we are doing in this patch is to introduce the third logic, and
move all the code of 1, 2 and 3 into
acpi_thermal_get_polling_frequency().
To align with this change, tz->tz_enable=1 is moved earlier, before
acpi_thermal_get_polling_frequency() being invoked in
acpi_thermal_add().
right?

> > Signed-off-by: Sameer Nanda <snanda@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com
> > >
> Rui, Srinivas, can you please have a look at this one and let me know
> what you
> think?
> 
> > 
> > ---
> >  drivers/acpi/thermal.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 1d0417b..68ad9fe 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -223,6 +223,17 @@ static int
> > acpi_thermal_get_polling_frequency(struct acpi_thermal *tz)
> >  	if (!tz)
> >  		return -EINVAL;
> >  
> > +	if (tz->tz_enabled == THERMAL_DEVICE_DISABLED) {
> > +		tz->polling_frequency = 0;
> > +		return 0;
> > +	}
> > +
> > +	/* Get default polling frequency [_TZP] (optional) */
> > +	if (tzp) {
> > +		tz->polling_frequency = tzp;
> > +		return 0;
> > +	}
> > +
> >  	status = acpi_evaluate_integer(tz->device->handle, "_TZP",
> > NULL, &tmp);
> >  	if (ACPI_FAILURE(status))
> >  		return -ENODEV;
> > @@ -582,6 +593,14 @@ static int thermal_set_mode(struct
> > thermal_zone_device *thermal,
> >  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >  			"%s kernel ACPI thermal control\n",
> >  			tz->tz_enabled ? "Enable" : "Disable"));
> > +
> > +		acpi_thermal_get_polling_frequency(tz);
> > +
> > +		mutex_lock(&tz->thermal_zone->lock);
> > +		tz->thermal_zone->polling_delay = tz-
> > >polling_frequency * 100;
> > +		tz->thermal_zone->passive_delay = tz-
> > >polling_frequency * 100;

To me, this policy, "disabling polling when disabling thermal zone,
enabling polling after enabling thermal zone" applies to all the
thermal zones, thus it's better to be implemented in thermal subsystem,
rather than ACPI thermal driver.

BTW, two other comments about the code itself,
1. I don't like the way how tz->polling_delay/tz->passive_delay are
changed here. If we have to do this, better using a thermal API, and we
should invoke monitor_thermal_zone() right after updating these two
fields.
2. passive_delay is set to wrong value here.

thanks,
rui
> > +		mutex_unlock(&tz->thermal_zone->lock);
> > +
> >  		acpi_thermal_check(tz);
> >  	}
> >  	return 0;
> > @@ -930,8 +949,6 @@ static int
> > acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
> >  	if (ACPI_FAILURE(status))
> >  		return -ENODEV;
> >  
> > -	tz->tz_enabled = 1;
> > -
> >  	dev_info(&tz->device->dev, "registered as
> > thermal_zone%d\n",
> >  		 tz->thermal_zone->id);
> >  	return 0;
> > @@ -1039,11 +1056,7 @@ static int acpi_thermal_get_info(struct
> > acpi_thermal *tz)
> >  	if (!result)
> >  		tz->flags.cooling_mode = 1;
> >  
> > -	/* Get default polling frequency [_TZP] (optional) */
> > -	if (tzp)
> > -		tz->polling_frequency = tzp;
> > -	else
> > -		acpi_thermal_get_polling_frequency(tz);
> > +	acpi_thermal_get_polling_frequency(tz);
> >  
> >  	return 0;
> >  }
> > @@ -1088,6 +1101,7 @@ static int acpi_thermal_add(struct
> > acpi_device *device)
> >  		return -ENOMEM;
> >  
> >  	tz->device = device;
> > +	tz->tz_enabled = 1;
> >  	strcpy(tz->name, device->pnp.bus_id);
> >  	strcpy(acpi_device_name(device),
> > ACPI_THERMAL_DEVICE_NAME);
> >  	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
