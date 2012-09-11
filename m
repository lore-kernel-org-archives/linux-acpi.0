From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCHv3 13/15] Thermal: Remove throttling logic out of
 thermal_sys.c
Date: Tue, 11 Sep 2012 08:24:18 +0800
Message-ID: <1347323058.1682.1093.camel@rui.sh.intel.com>
References: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
	 <1346500296-25200-14-git-send-email-durgadoss.r@intel.com>
	 <1347266657.1682.1086.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591B54AA@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48384 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758851Ab2IKAX3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Sep 2012 20:23:29 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591B54AA@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

On =E4=B8=80, 2012-09-10 at 02:56 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Monday, September 10, 2012 2:14 PM
> > To: R, Durgadoss
> > Cc: lenb@kernel.org; linux-acpi@vger.kernel.org; eduardo.valentin@t=
i.com
> > Subject: Re: [PATCHv3 13/15] Thermal: Remove throttling logic out o=
f
> > thermal_sys.c
> [cut.]
>=20
> > > +
> > > +static void handle_non_critical_trips(struct thermal_zone_device=
 *tz,
> > > +			int trip, enum thermal_trip_type trip_type)
> > > +{
> > > +	tz->governor->throttle(tz, trip);
> > > +}
> > here is the problem, we must make sure every registered thermal zon=
e
> > have a governor when it is running, right?
>=20
> Yes, agree with you. Had some thoughts here, but wanted to get your o=
pinion
> before I implemented them.
>=20
> 1. We can make the default governor as 'user space', and make it load=
 inside
> thermal_sys.c (so that every zone will always have a default governor=
)
>=20
No, the default governor should be step wise so that it behaves the sam=
e
as before. if we use userspace as default governor, most of the thermal
driver will stop working with this patch set.

IMO, we should make all of the governors configurable, but at least one
of them must be selected as the default governor, that's why we need
something below.

choice
        prompt "Default thermal governor"
        default THERMAL_DEFAULT_GOV_STEP_WISE
        help
          This option sets which thermal governor shall be loaded at
          startup.

thanks,
rui

> 2. All other governors, that are implemented in a separate .c file ca=
n be
> optional i.e. left to the user to select/deselect.
>=20
> IMO, this will make our implementation easier and cleaner.
> What do you think ?
>=20
> Thanks,
> Durga
>=20
> >=20
> > then the default governor must always be built in.
> > We can have a Kconfig option for step_wise, but we should not make =
it
> > configurable by users.
> > or we can use prompt to get the default governor at build time. say
> >=20
> > choice
> >         prompt "Default thermal governor"
> >         default THERMAL_DEFAULT_GOV_STEP_WISE
> >         help
> >           This option sets which thermal governor shall be loaded a=
t
> >           startup.
> >=20
> > config THERMAL_DEFAULT_GOV_STEP_WISE
> >         bool "step-wise"
> >         select THERMAL_GOV_STEP_WISE
> >         help
> >           Use the thermal governor 'step-wise' as default.blabla
> >=20
> >=20
> > thanks,
> > rui
> >=20
> > > +
> > > +static void handle_critical_trips(struct thermal_zone_device *tz=
,
> > > +				int trip, enum thermal_trip_type trip_type)
> > > +{
> > > +	long trip_temp;
> > > +
> > > +	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> > > +
> > > +	/* If we have not crossed the trip_temp, we do not care. */
> > > +	if (tz->temperature < trip_temp)
> > > +		return;
> > > +
> > > +	if (tz->ops->notify)
> > > +		tz->ops->notify(tz, trip, trip_type);
> > > +
> > > +	if (trip_type =3D=3D THERMAL_TRIP_CRITICAL) {
> > > +		pr_emerg("Critical temperature reached(%d C),shutting
> > down\n",
> > > +			 tz->temperature / 1000);
> > > +		orderly_poweroff(true);
> > > +	}
> > > +}
> > > +
> > > +static void handle_thermal_trip(struct thermal_zone_device *tz, =
int trip)
> > > +{
> > > +	enum thermal_trip_type type;
> > > +
> > > +	tz->ops->get_trip_type(tz, trip, &type);
> > > +
> > > +	if (type =3D=3D THERMAL_TRIP_CRITICAL || type =3D=3D
> > THERMAL_TRIP_HOT)
> > > +		handle_critical_trips(tz, trip, type);
> > > +	else
> > > +		handle_non_critical_trips(tz, trip, type);
> > > +	/*
> > > +	 * Alright, we handled this trip successfully.
> > > +	 * So, start monitoring again.
> > > +	 */
> > > +	monitor_thermal_zone(tz);
> > > +}
> > > +
> > > +static void update_temperature(struct thermal_zone_device *tz)
> > > +{
> > > +	long temp;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&tz->lock);
> > > +
> > > +	ret =3D tz->ops->get_temp(tz, &temp);
> > > +	if (ret) {
> > > +		pr_warn("failed to read out thermal zone %d\n", tz->id);
> > > +		return;
> > > +	}
> > > +
> > > +	tz->last_temperature =3D tz->temperature;
> > > +	tz->temperature =3D temp;
> > > +
> > > +	mutex_unlock(&tz->lock);
> > > +}
> > > +
> > > +void thermal_zone_device_update(struct thermal_zone_device *tz)
> > > +{
> > > +	int count;
> > > +
> > > +	update_temperature(tz);
> > > +
> > > +	for (count =3D 0; count < tz->trips; count++)
> > > +		handle_thermal_trip(tz, count);
> > > +}
> > > +EXPORT_SYMBOL(thermal_zone_device_update);
> > > +
> > > +static void thermal_zone_device_check(struct work_struct *work)
> > > +{
> > > +	struct thermal_zone_device *tz =3D container_of(work, struct
> > > +						      thermal_zone_device,
> > > +						      poll_queue.work);
> > > +	thermal_zone_device_update(tz);
> > > +}
> > > +
> > >  /* sys I/F for thermal zone */
> > >
> > >  #define to_thermal_zone(_dev) \
> > > @@ -936,30 +1048,6 @@ thermal_remove_hwmon_sysfs(struct
> > thermal_zone_device *tz)
> > >  }
> > >  #endif
> > >
> > > -static void thermal_zone_device_set_polling(struct thermal_zone_=
device
> > *tz,
> > > -					    int delay)
> > > -{
> > > -	cancel_delayed_work(&(tz->poll_queue));
> > > -
> > > -	if (!delay)
> > > -		return;
> > > -
> > > -	if (delay > 1000)
> > > -		queue_delayed_work(system_freezable_wq, &(tz-
> > >poll_queue),
> > > -				      round_jiffies(msecs_to_jiffies(delay)));
> > > -	else
> > > -		queue_delayed_work(system_freezable_wq, &(tz-
> > >poll_queue),
> > > -				      msecs_to_jiffies(delay));
> > > -}
> > > -
> > > -static void thermal_zone_device_check(struct work_struct *work)
> > > -{
> > > -	struct thermal_zone_device *tz =3D container_of(work, struct
> > > -						      thermal_zone_device,
> > > -						      poll_queue.work);
> > > -	thermal_zone_device_update(tz);
> > > -}
> > > -
> > >  /**
> > >   * thermal_zone_bind_cooling_device - bind a cooling device to a=
 thermal
> > zone
> > >   * @tz:		thermal zone device
> > > @@ -1283,183 +1371,6 @@ void thermal_cdev_update(struct
> > thermal_cooling_device *cdev)
> > >  }
> > >  EXPORT_SYMBOL(thermal_cdev_update);
> > >
> > > -static void thermal_zone_do_update(struct thermal_zone_device *t=
z)
> > > -{
> > > -	struct thermal_instance *instance;
> > > -
> > > -	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> > > -		thermal_cdev_update(instance->cdev);
> > > -}
> > > -
> > > -/*
> > > - * Cooling algorithm for both active and passive cooling
> > > - *
> > > - * 1. if the temperature is higher than a trip point,
> > > - *    a. if the trend is THERMAL_TREND_RAISING, use higher cooli=
ng
> > > - *       state for this trip point
> > > - *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooli=
ng
> > > - *       state for this trip point
> > > - *
> > > - * 2. if the temperature is lower than a trip point, use lower
> > > - *    cooling state for this trip point
> > > - *
> > > - * Note that this behaves the same as the previous passive cooli=
ng
> > > - * algorithm.
> > > - */
> > > -
> > > -static void thermal_zone_trip_update(struct thermal_zone_device =
*tz,
> > > -				     int trip, long temp)
> > > -{
> > > -	struct thermal_instance *instance;
> > > -	struct thermal_cooling_device *cdev =3D NULL;
> > > -	unsigned long cur_state, max_state;
> > > -	long trip_temp;
> > > -	enum thermal_trip_type trip_type;
> > > -	enum thermal_trend trend;
> > > -
> > > -	if (trip =3D=3D THERMAL_TRIPS_NONE) {
> > > -		trip_temp =3D tz->forced_passive;
> > > -		trip_type =3D THERMAL_TRIPS_NONE;
> > > -	} else {
> > > -		tz->ops->get_trip_temp(tz, trip, &trip_temp);
> > > -		tz->ops->get_trip_type(tz, trip, &trip_type);
> > > -	}
> > > -
> > > -	if (!tz->ops->get_trend || tz->ops->get_trend(tz, trip, &trend)=
) {
> > > -		/*
> > > -		 * compare the current temperature and previous
> > temperature
> > > -		 * to get the thermal trend, if no special requirement
> > > -		 */
> > > -		if (tz->temperature > tz->last_temperature)
> > > -			trend =3D THERMAL_TREND_RAISING;
> > > -		else if (tz->temperature < tz->last_temperature)
> > > -			trend =3D THERMAL_TREND_DROPPING;
> > > -		else
> > > -			trend =3D THERMAL_TREND_STABLE;
> > > -	}
> > > -
> > > -	if (temp >=3D trip_temp) {
> > > -		list_for_each_entry(instance, &tz->thermal_instances,
> > tz_node) {
> > > -			if (instance->trip !=3D trip)
> > > -				continue;
> > > -
> > > -			cdev =3D instance->cdev;
> > > -
> > > -			cdev->ops->get_cur_state(cdev, &cur_state);
> > > -			cdev->ops->get_max_state(cdev, &max_state);
> > > -
> > > -			if (trend =3D=3D THERMAL_TREND_RAISING) {
> > > -				cur_state =3D cur_state < instance->upper ?
> > > -					    (cur_state + 1) : instance->upper;
> > > -			} else if (trend =3D=3D THERMAL_TREND_DROPPING) {
> > > -				cur_state =3D cur_state > instance->lower ?
> > > -				    (cur_state - 1) : instance->lower;
> > > -			}
> > > -
> > > -			/* activate a passive thermal instance */
> > > -			if ((trip_type =3D=3D THERMAL_TRIP_PASSIVE ||
> > > -			     trip_type =3D=3D THERMAL_TRIPS_NONE) &&
> > > -			     instance->target =3D=3D THERMAL_NO_TARGET)
> > > -				tz->passive++;
> > > -
> > > -			instance->target =3D cur_state;
> > > -			cdev->updated =3D false; /* cooling device needs
> > update */
> > > -		}
> > > -	} else {	/* below trip */
> > > -		list_for_each_entry(instance, &tz->thermal_instances,
> > tz_node) {
> > > -			if (instance->trip !=3D trip)
> > > -				continue;
> > > -
> > > -			/* Do not use the inactive thermal instance */
> > > -			if (instance->target =3D=3D THERMAL_NO_TARGET)
> > > -				continue;
> > > -			cdev =3D instance->cdev;
> > > -			cdev->ops->get_cur_state(cdev, &cur_state);
> > > -
> > > -			cur_state =3D cur_state > instance->lower ?
> > > -				    (cur_state - 1) : THERMAL_NO_TARGET;
> > > -
> > > -			/* deactivate a passive thermal instance */
> > > -			if ((trip_type =3D=3D THERMAL_TRIP_PASSIVE ||
> > > -			     trip_type =3D=3D THERMAL_TRIPS_NONE) &&
> > > -			     cur_state =3D=3D THERMAL_NO_TARGET)
> > > -				tz->passive--;
> > > -			instance->target =3D cur_state;
> > > -			cdev->updated =3D false; /* cooling device needs
> > update */
> > > -		}
> > > -	}
> > > -
> > > -	return;
> > > -}
> > > -/**
> > > - * thermal_zone_device_update - force an update of a thermal zon=
e's
> > state
> > > - * @ttz:	the thermal zone to update
> > > - */
> > > -
> > > -void thermal_zone_device_update(struct thermal_zone_device *tz)
> > > -{
> > > -	int count, ret =3D 0;
> > > -	long temp, trip_temp;
> > > -	enum thermal_trip_type trip_type;
> > > -
> > > -	mutex_lock(&tz->lock);
> > > -
> > > -	if (tz->ops->get_temp(tz, &temp)) {
> > > -		/* get_temp failed - retry it later */
> > > -		pr_warn("failed to read out thermal zone %d\n", tz->id);
> > > -		goto leave;
> > > -	}
> > > -
> > > -	tz->last_temperature =3D tz->temperature;
> > > -	tz->temperature =3D temp;
> > > -
> > > -	for (count =3D 0; count < tz->trips; count++) {
> > > -		tz->ops->get_trip_type(tz, count, &trip_type);
> > > -		tz->ops->get_trip_temp(tz, count, &trip_temp);
> > > -
> > > -		switch (trip_type) {
> > > -		case THERMAL_TRIP_CRITICAL:
> > > -			if (temp >=3D trip_temp) {
> > > -				if (tz->ops->notify)
> > > -					ret =3D tz->ops->notify(tz, count,
> > > -							      trip_type);
> > > -				if (!ret) {
> > > -					pr_emerg("Critical temperature
> > reached (%ld C), shutting down\n",
> > > -						 temp/1000);
> > > -					orderly_poweroff(true);
> > > -				}
> > > -			}
> > > -			break;
> > > -		case THERMAL_TRIP_HOT:
> > > -			if (temp >=3D trip_temp)
> > > -				if (tz->ops->notify)
> > > -					tz->ops->notify(tz, count, trip_type);
> > > -			break;
> > > -		case THERMAL_TRIP_ACTIVE:
> > > -			thermal_zone_trip_update(tz, count, temp);
> > > -			break;
> > > -		case THERMAL_TRIP_PASSIVE:
> > > -			if (temp >=3D trip_temp || tz->passive)
> > > -				thermal_zone_trip_update(tz, count, temp);
> > > -			break;
> > > -		}
> > > -	}
> > > -
> > > -	if (tz->forced_passive)
> > > -		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE,
> > temp);
> > > -	thermal_zone_do_update(tz);
> > > -
> > > -leave:
> > > -	if (tz->passive)
> > > -		thermal_zone_device_set_polling(tz, tz->passive_delay);
> > > -	else if (tz->polling_delay)
> > > -		thermal_zone_device_set_polling(tz, tz->polling_delay);
> > > -	else
> > > -		thermal_zone_device_set_polling(tz, 0);
> > > -	mutex_unlock(&tz->lock);
> > > -}
> > > -EXPORT_SYMBOL(thermal_zone_device_update);
> > > -
> > >  /**
> > >   * create_trip_attrs - create attributes for trip points
> > >   * @tz:		the thermal zone device
> >=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
