From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 07/16] Thermal: Introduce .get_trend() callback.
Date: Fri, 20 Jul 2012 09:12:56 -0700
Message-ID: <20120720091256.1cc811ca@chromoly>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	<1342679480-5336-8-git-send-email-rui.zhang@intel.com>
	<20120719150915.069ccf91@chromoly>
	<201207201153.41668.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32217 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab2GTQMx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jul 2012 12:12:53 -0400
In-Reply-To: <201207201153.41668.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On Fri, 20 Jul 2012 11:53:41 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Friday, July 20, 2012, Jacob Pan wrote:
> > On Thu, 19 Jul 2012 14:31:11 +0800
> > Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > > tc1 and tc2 are used by OSPM to anticipate the temperature trends.
> > > But they are ACPI platform specific concepts.
> > > 
> > > Introduce .get_trend() as a more general solution.
> > > 
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/acpi/thermal.c        |   30
> > > ++++++++++++++++++++++++++++++ drivers/thermal/thermal_sys.c |
> > > 19 +++++++++++++++++-- include/linux/thermal.h       |    9
> > > +++++++++ 3 files changed, 56 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > > index a7c97f5..b345646 100644
> > > --- a/drivers/acpi/thermal.c
> > > +++ b/drivers/acpi/thermal.c
> > > @@ -704,6 +704,35 @@ static int thermal_get_crit_temp(struct
> > > thermal_zone_device *thermal, return -EINVAL;
> > >  }
> > >  
> > > +static int thermal_get_trend(struct thermal_zone_device *thermal,
> > > +				int trip, enum thermal_trend
> > > *trend) +{
> > > +	struct acpi_thermal *tz = thermal->devdata;
> > > +	enum thermal_trip_type type;
> > > +	unsigned long trip_temp;
> > > +	int i;
> > > +
> > > +	if (thermal_get_trip_type(thermal, trip, &type))
> > > +		return -EINVAL;
> > > +
> > > +	/* Only PASSIVE trip points need TREND */
> > > +	if (type != THERMAL_TRIP_PASSIVE)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * tz->temperature has already been updated by generic
> > > thermal layer,
> > > +	 * before this callback being invoked
> > > +	 */
> > > +	i = (tz->trips.passive.tc1 * (tz->temperature -
> > > tz->last_temperature))
> > > +		+ (tz->trips.passive.tc2
> > > +		* (tz->temperature -
> > > tz->trips.passive.temperature)); +
> > > +	*trend = i > 0 ? THERMAL_TREND_RAISING :
> > > +		(i < 0 ? THERMAL_TREND_DROPPING :
> > > THERMAL_TREND_STABLE);
> > > +	return 0;
> > > +}
> > > +
> > > +
> > >  static int thermal_notify(struct thermal_zone_device *thermal,
> > > int trip, enum thermal_trip_type trip_type)
> > >  {
> > > @@ -832,6 +861,7 @@ static const struct thermal_zone_device_ops
> > > acpi_thermal_zone_ops = { .get_trip_type = thermal_get_trip_type,
> > >  	.get_trip_temp = thermal_get_trip_temp,
> > >  	.get_crit_temp = thermal_get_crit_temp,
> > > +	.get_trend = thermal_get_trend,
> > >  	.notify = thermal_notify,
> > >  };
> > >  
> > > diff --git a/drivers/thermal/thermal_sys.c
> > > b/drivers/thermal/thermal_sys.c index db35300..29b6dba 100644
> > > --- a/drivers/thermal/thermal_sys.c
> > > +++ b/drivers/thermal/thermal_sys.c
> > > @@ -698,6 +698,18 @@ thermal_remove_hwmon_sysfs(struct
> > > thermal_zone_device *tz) }
> > >  #endif
> > >  
> > > +static void thermal_get_trend(struct thermal_zone_device *tz,
> > > +		int trip, enum thermal_trend *trend)
> > > +{
> > > +	if (tz->ops->get_trend)
> > > +		if (!tz->ops->get_trend(tz, trip, trend))
> > > +			return;
> > > +
> > > +	*trend = tz->temperature >= tz->last_temperature ?
> > > +		 THERMAL_TREND_RAISING : THERMAL_TREND_DROPPING;
> > I think you are mixing things a little here. ACPI passive cooling
> > formula generates a performance trend to guide thermal management,
> > which is not a simple temperature trend.
> > 
> > In case of no .get_trend() present, caller can easily figure out
> > temperature trend explicitly instead of getting uninformed
> > information.
> 
> thermal_zone_device_passive() (below) is the caller and I don't think
> it can really do that.
> 
perhaps i did not make it clear, i meant in case caller wants to know
the simple temperature trend, it can keep the last reading and
timestamp to figure out trend.

Going back to the original point, even though TC1 TC2 are ACPI specific
time constants but they represents a generic characteristic of the
platform thermal dynamics. These are useful for userspace or governors
to do thermal control in general. perhaps, we can generalize TCx
paramenters instead. i.e. allow a set of thermal constants exposed from
ACPI/BIOS and treat ACPI passive formular as a simple governor. In the
future, more constants can be added to have a better control logic.
e.g. I have written a PID controller (userspace) to manage passive
cooling, it shows better result than the ACPI passive formula in terms
of responsiveness, overshoot etc. In case of PID, we need three
constants which i have to tune manually at this point.

> That said, since thermal_zone_device_passive() seems to me the only
> caller of thermal_get_trend(), it might be better to move the code to
> that function directly.
> 
> Thanks,
> Rafael
> 
> 
> > > +	return;
> > > +}
> > > +
> > >  static void thermal_zone_device_set_polling(struct
> > > thermal_zone_device *tz, int delay)
> > >  {
> > > @@ -732,6 +744,8 @@ static void thermal_zone_device_passive(struct
> > > thermal_zone_device *tz, if (temp >= trip_temp) {
> > >  		tz->passive = true;
> > >  
> > > +		thermal_get_trend(tz, trip, (enum thermal_trend
> > > *)&trend); +
> > >  		trend = (tz->tc1 * (temp -
> > > tz->last_temperature)) + (tz->tc2 * (temp - trip_temp));
> > >  
> > > @@ -1090,6 +1104,9 @@ void thermal_zone_device_update(struct
> > > thermal_zone_device *tz) goto leave;
> > >  	}
> > >  
> > > +	tz->last_temperature = tz->temperature;
> > > +	tz->temperature = temp;
> > > +
> > >  	for (count = 0; count < tz->trips; count++) {
> > >  		tz->ops->get_trip_type(tz, count, &trip_type);
> > >  		tz->ops->get_trip_temp(tz, count, &trip_temp);
> > > @@ -1149,8 +1166,6 @@ void thermal_zone_device_update(struct
> > > thermal_zone_device *tz) thermal_zone_device_passive(tz, temp,
> > > tz->forced_passive, THERMAL_TRIPS_NONE);
> > >  
> > > -	tz->last_temperature = temp;
> > > -
> > >  leave:
> > >  	if (tz->passive)
> > >  		thermal_zone_device_set_polling(tz,
> > > tz->passive_delay); diff --git a/include/linux/thermal.h
> > > b/include/linux/thermal.h index b355c62..ab656d6 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -44,6 +44,12 @@ enum thermal_trip_type {
> > >  	THERMAL_TRIP_CRITICAL,
> > >  };
> > >  
> > > +enum thermal_trend {
> > > +	THERMAL_TREND_STABLE, /* temperature is stable */
> > > +	THERMAL_TREND_RAISING, /* temperature is raising */
> > > +	THERMAL_TREND_DROPPING, /* temperature is dropping */
> > > +};
> > > +
> > >  struct thermal_zone_device_ops {
> > >  	int (*bind) (struct thermal_zone_device *,
> > >  		     struct thermal_cooling_device *);
> > > @@ -65,6 +71,8 @@ struct thermal_zone_device_ops {
> > >  	int (*set_trip_hyst) (struct thermal_zone_device *, int,
> > >  			      unsigned long);
> > >  	int (*get_crit_temp) (struct thermal_zone_device *,
> > > unsigned long *);
> > > +	int (*get_trend) (struct thermal_zone_device *, int,
> > > +			  enum thermal_trend *);
> > >  	int (*notify) (struct thermal_zone_device *, int,
> > >  		       enum thermal_trip_type);
> > >  };
> > > @@ -109,6 +117,7 @@ struct thermal_zone_device {
> > >  	int tc2;
> > >  	int passive_delay;
> > >  	int polling_delay;
> > > +	int temperature;
> > >  	int last_temperature;
> > >  	bool passive;
> > >  	unsigned int forced_passive;
> > 
> > 
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Jacob
