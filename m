From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/4] RFC Thermal: Enhance Generic Thermal layer with
 policies
Date: Tue, 12 Jun 2012 15:46:15 +0300
Message-ID: <20120612124615.GB8724@besouro>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
 <1339436374-26881-2-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:48611 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752040Ab2FLMqa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 08:46:30 -0400
Received: by obbuo19 with SMTP id uo19so9168404obb.12
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jun 2012 05:46:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339436374-26881-2-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org

Hello Durgadoss,

Things are moving fast! Losts of work on going.
This is good. Just that now we have some overlaps. I'd propose to be
more structured and align between ourselves. Having branches would
be a nice starting point. I can collect your changes and post to gitorious
or something if you agree.

I like the approach Durgadoss is proposing. So we can have different
policy behavior on different zones.

But we need to see how we merge both of your work. There is still
Amit's work, and I haven't sent my changes yet :-)

On Mon, Jun 11, 2012 at 11:09:31PM +0530, Durgadoss R wrote:
> This patch enhances the generic thermal layer with the
> infrastructure required to implement thermal governors.
> This introduces a platform level thermal_zone_params
> structure tp provide platform specific data, a
> notify_thermal_framework() API for use by the sensor
> drivers, and a simple 'get_trend' callback inside the
> thermal_zone_device_ops.

This patch introduces several things. I see at least three
major changes. Can you split it into smaller pieces?


> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  Documentation/thermal/sysfs-api.txt |   26 +++
>  drivers/thermal/thermal_sys.c       |  383 ++++++++++++++++++++++++++---------
>  include/linux/thermal.h             |   55 +++++
>  3 files changed, 368 insertions(+), 96 deletions(-)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index 1733ab9..632a163 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -103,6 +103,32 @@ temperature) and throttle appropriate devices.
>      trip: indicates which trip point the cooling devices is associated with
>  	  in this thermal zone.
>  
> +1.4 Thermal Zone Parameters
> +1.4.1 struct thermal_zone_params
> +    This structure defines the platform level parameters for a thermal zone.
> +    This data, for each thermal zone should come from the platform layer.
> +    This is an optional feature where some platforms can choose not to
> +    provide this data.
> +1.4.2 struct thermal_zone_params attributes
> +    .thermal_zone_name: Name of the thermal zone, for which these parameters
> +			are being defined.
> +    .num_cdevs: Number of cooling devices associated with this
> +			  thermal zone.
> +    .cdevs_name: Names of the cooling devices associated with this
> +			   thermal zone.
> +    .cdevs: Pointers to cooling devices
> +    .weights: This parameter defines the 'influence' of a particular cooling
> +	      device on this thermal zone, on a percentage scale. The sum of
> +	      all these weights cannot exceed 100. The order of values in
> +	      this array should match with that of the cooling_devices_name.
> +1.4.3 An example thermal_zone_params structure
> +	struct thermal_zone_params tzp = {
> +                .thermal_zone_name = "CPU",
> +                .num_cdevs = 2,
> +                .cdevs_name = {"CPU", "Memory"},
> +                .weights = {70, 30},
> +        };
> +

Nice! Only missing point from the documentation above is that it is not
so clear how platform code is suppose to provide the zone params structure...

>  2. sysfs attributes structure
>  
>  RO	read only value
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 022bacb..0412c7f 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -60,6 +60,9 @@ static LIST_HEAD(thermal_tz_list);
>  static LIST_HEAD(thermal_cdev_list);
>  static DEFINE_MUTEX(thermal_list_lock);
>  
> +int (*get_platform_thermal_params)(struct thermal_zone_device *tzd);
> +EXPORT_SYMBOL(get_platform_thermal_params);
> +

Are we sure we want to go in this way? Shouldn't the zone register be
enough to provide this data per zone?

>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>  {
>  	int err;
> @@ -666,81 +669,275 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>  				      msecs_to_jiffies(delay));
>  }
>  
> -static void thermal_zone_device_passive(struct thermal_zone_device *tz,
> -					int temp, int trip_temp, int trip)
> +static void thermal_zone_device_check(struct work_struct *work)

I know this is not really related to your patch but, this workqueue handler
name is a bit misleading. I'd propose to at least have the _wq suffix.

>  {
> -	int trend = 0;
> -	struct thermal_cooling_device_instance *instance;
> -	struct thermal_cooling_device *cdev;
> -	long state, max_state;
> +	struct thermal_zone_device *tz = container_of(work, struct
> +						      thermal_zone_device,
> +						      poll_queue.work);
> +	thermal_zone_device_update(tz);
> +}
>  
> -	/*
> -	 * Above Trip?
> -	 * -----------
> -	 * Calculate the thermal trend (using the passive cooling equation)
> -	 * and modify the performance limit for all passive cooling devices
> -	 * accordingly.  Note that we assume symmetry.
> -	 */
> -	if (temp >= trip_temp) {
> -		tz->passive = true;
> -
> -		trend = (tz->tc1 * (temp - tz->last_temperature)) +
> -			(tz->tc2 * (temp - trip_temp));
> -
> -		/* Heating up? */
> -		if (trend > 0) {
> -			list_for_each_entry(instance, &tz->cooling_devices,
> -					    node) {
> -				if (instance->trip != trip)
> -					continue;
> -				cdev = instance->cdev;
> -				cdev->ops->get_cur_state(cdev, &state);
> -				cdev->ops->get_max_state(cdev, &max_state);
> -				if (state++ < max_state)
> -					cdev->ops->set_cur_state(cdev, state);
> -			}
> -		} else if (trend < 0) { /* Cooling off? */
> -			list_for_each_entry(instance, &tz->cooling_devices,
> -					    node) {
> -				if (instance->trip != trip)
> -					continue;
> -				cdev = instance->cdev;
> -				cdev->ops->get_cur_state(cdev, &state);
> -				cdev->ops->get_max_state(cdev, &max_state);
> -				if (state > 0)
> -					cdev->ops->set_cur_state(cdev, --state);
> -			}
> +static int set_throttle_policy(struct thermal_zone_device *tz,
> +				const char *policy)
> +{
> +	struct thermal_zone_params *tzp = tz->tzp;
> +
> +	if (!strcmp(policy, "fair_share")) {
> +		tzp->throttle_policy = THERMAL_FAIR_SHARE;
> +	} else if (!strcmp(policy, "step_wise")) {
> +		tzp->throttle_policy = THERMAL_STEP_WISE;
> +	} else if (!strcmp(policy, "user_space")) {
> +		tzp->throttle_policy = THERMAL_USER_SPACE;
> +	} else {
> +		dev_err(&tz->device, "Setting throttling policy failed:\n");
> +		return -EINVAL;
> +	}

For the comparison above: sysfs_streq.

How do we handle locking and make sure the policy switch is sane and not having concurrency issues?

> +
> +	return 0;
> +}
> +
> +static ssize_t show_throttle_policy(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +	struct thermal_zone_params *tzp = tz->tzp;
> +
> +	switch (tzp->throttle_policy) {
> +	case THERMAL_FAIR_SHARE:
> +		return sprintf(buf, "fair_share\n");
> +	case THERMAL_STEP_WISE:
> +		return sprintf(buf, "step_wise\n");
> +	case THERMAL_USER_SPACE:
> +	default:
> +		return sprintf(buf, "user_space\n");
> +	}
> +}
> +
> +static ssize_t store_throttle_policy(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +	int ret = set_throttle_policy(tz, buf);
> +
> +	return ret ? ret : count;
> +}
> +
> +static int create_policy_attr(struct thermal_zone_device *tz)

This function name is not so good as the function also creates the device file.

> +{
> +	sysfs_attr_init(&tz->policy_attr.attr);
> +	tz->policy_attr.attr.name = "throttle_policy";
> +	tz->policy_attr.attr.mode = S_IRUGO | S_IWUSR;
> +	tz->policy_attr.show = show_throttle_policy;
> +	tz->policy_attr.store = store_throttle_policy;
> +	return device_create_file(&tz->device, &tz->policy_attr);
> +}
> +
> +static void update_tz_params(struct thermal_zone_params *tzp,

Any better naming for this function?

> +			struct thermal_cooling_device *cdev, int flag)
> +{
> +	int i;
> +
> +	for (i = 0; i < tzp->num_cdevs; i++) {
> +		if (!strcmp(cdev->type, tzp->cdevs_name[i])) {
> +			tzp->cdevs[i] = flag ? cdev : NULL;

Is flag bool? If so, please use it.

> +			break;
>  		}
> +	}
> +}
> +
> +static void retrieve_zone_params(struct thermal_zone_device *tz)
> +{
> +	int ret;
> +
> +	/* Check whether the platform data pointer is defined */
> +	if (!get_platform_thermal_params)
> +		return;

Another way would be to, in the register, you receive the plat data as parameter
and you simply store it.

> +
> +	ret = get_platform_thermal_params(tz);
> +	if (ret) {
> +		dev_err(&tz->device,
> +		"parameters for zone %s not defined:%d\n", tz->type, ret);
> +		return;

checkpatch.pl --strict says this about the above:
CHECK: Alignment should match open parenthesis
#205: FILE: drivers/thermal/thermal_sys.c:759:
+		dev_err(&tz->device,
+		"parameters for zone %s not defined:%d\n", tz->type, ret);



> +	}
> +
> +	ret = create_policy_attr(tz);
> +	if (ret) {
> +		dev_err(&tz->device,
> +		"create_policy_attr for zone %s failed:%d\n", tz->type, ret);

CHECK: Alignment should match open parenthesis
#212: FILE: drivers/thermal/thermal_sys.c:766:
+		dev_err(&tz->device,
+		"create_policy_attr for zone %s failed:%d\n", tz->type, ret);


>  		return;
>  	}
> +}
>  
> +static void notify_user_space(struct thermal_zone_device *tz, int trip)
> +{
>  	/*
> -	 * Below Trip?
> -	 * -----------
> -	 * Implement passive cooling hysteresis to slowly increase performance
> -	 * and avoid thrashing around the passive trip point.  Note that we
> -	 * assume symmetry.
> +	 * TODO: Add more parameters (like zone id, trip etc) to
> +	 * send to the user land, so that they can use it efficiently.
>  	 */
> +	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);

This is not good. I believe we have a userspace notification mechanism already.

Rui, in general we need to standardize the kernel <-> userland userspace communication/
notification system. Is the existing netlink enough? Why would we need a sysfs notify?

> +}
> +
> +static void __dethrottle(struct thermal_cooling_device *cdev)
> +{
> +	unsigned long cur_state, max_state;
> +
> +	cdev->ops->get_cur_state(cdev, &cur_state);
> +	cdev->ops->get_max_state(cdev, &max_state);
> +
> +	if (cur_state - 1 > 0)
> +		cdev->ops->set_cur_state(cdev, cur_state - 1);
> +	else
> +		cdev->ops->set_cur_state(cdev, 0);
> +}
> +
> +static void __throttle(struct thermal_cooling_device *cdev)
> +{
> +	unsigned long cur_state, max_state;
> +
> +	cdev->ops->get_cur_state(cdev, &cur_state);
> +	cdev->ops->get_max_state(cdev, &max_state);
> +
> +	if (cur_state + 1 < max_state)
> +		cdev->ops->set_cur_state(cdev, cur_state + 1);
> +	else
> +		cdev->ops->set_cur_state(cdev, max_state);
> +}
> +
> +static void linear_throttle(struct thermal_zone_device *tz,
> +			int trip, enum thermal_trip_type trip_type)
> +{
> +	enum thermal_trend trend;
> +	struct thermal_cooling_device *cdev;
> +	struct thermal_cooling_device_instance *instance;
> +
> +	/* Heavy Assumption */
> +	if (!tz->ops->get_trend)
> +		trend = THERMAL_TREND_HEATING;
> +	else
> +		tz->ops->get_trend(tz, trip, &trend);
> +
>  	list_for_each_entry(instance, &tz->cooling_devices, node) {
>  		if (instance->trip != trip)
>  			continue;
> +
>  		cdev = instance->cdev;
> -		cdev->ops->get_cur_state(cdev, &state);
> -		cdev->ops->get_max_state(cdev, &max_state);
> -		if (state > 0)
> -			cdev->ops->set_cur_state(cdev, --state);
> -		if (state == 0)
> -			tz->passive = false;
> +
> +		if (trend == THERMAL_TREND_HEATING)
> +			__throttle(cdev);
> +		else
> +			__dethrottle(cdev);

I like the above. Looks way cleaner.

On the other hand, does it make sense to make linear_throttle a
real throttle_policy, instead of treating it as a separate case?

Meaning, also having its own file, just like the others.

If no platform data is set, just create a throttle policy which
is linear_throttle.

>  	}
>  }
>  
> -static void thermal_zone_device_check(struct work_struct *work)
> +#ifdef CONFIG_FAIR_SHARE
> +static int fs_throttle(struct thermal_zone_device *tz)
>  {
> -	struct thermal_zone_device *tz = container_of(work, struct
> -						      thermal_zone_device,
> -						      poll_queue.work);
> -	thermal_zone_device_update(tz);
> +	return fair_share_throttle(tz);
> +}
> +#else
> +static inline int fs_throttle(struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#ifdef CONFIG_STEP_WISE
> +static int sw_throttle(struct thermal_zone_device *tz, int trip,
> +			enum thermal_trip_type trip_type)
> +{
> +	return step_wise_throttle(tz, trip, trip_type);
> +}
> +#else
> +static inline int sw_throttle(struct thermal_zone_device *tz, int trip,
> +			enum thermal_trip_type trip_type)
> +{
> +	return 0;
> +}
> +#endif

Nip: Another way, instead of having the ifdeferry here, we could have a header
file which does the config check above.

> +
> +static void handle_non_critical_trips(struct thermal_zone_device *tz,
> +			int trip, enum thermal_trip_type trip_type)
> +{
> +	/*
> +	 * To handle other trip points, we assume that the platform
> +	 * data existence is a must. For now, to keep things not break,
> +	 * do the same linear_throttle for both active/passive trips.
> +	 * But eventually we should move towards a better solution.
> +	 *
> +	 * The other option would be to just do a notify_user_space,
> +	 * and return.
> +	 *
> +	 * The step-wise throttle is the same as linear-throttle, but it
> +	 * expects platform data i.e thermal_zone_params.
> +	 */
> +	if (!tz->tzp) {
> +		linear_throttle(tz, trip, trip_type);
> +		return;
> +	}
> +
> +	switch (tz->tzp->throttle_policy) {
> +	case THERMAL_FAIR_SHARE:
> +		fs_throttle(tz);
> +		break;
> +	case THERMAL_STEP_WISE:
> +		sw_throttle(tz, trip, trip_type);
> +		break;
> +	case THERMAL_USER_SPACE:
> +		notify_user_space(tz, trip);
> +		break;
> +	}
> +}
> +
> +static void handle_critical_trips(struct thermal_zone_device *tz,
> +				int trip, enum thermal_trip_type trip_type)
> +{
> +	int ret;
> +	long temp, trip_temp;
> +
> +	tz->ops->get_temp(tz, &temp);
> +	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +
> +	/*
> +	 * If we have not crossed the trip_temp, we do not care.
> +	 * If we do not have a way to notify, then there is
> +	 * nothing much we can do.
> +	 */
> +	if (temp < trip_temp || !tz->ops->notify)
> +		return;


Can someone explain me why .notify is a must for thermal_shutdow?

> +
> +	ret = tz->ops->notify(tz, trip, trip_type);
> +
> +	if (trip_type == THERMAL_TRIP_CRITICAL && !ret) {
> +		pr_emerg("Critical temperature reached(%ld C),shutting down\n",
> +			 temp/1000);
> +		orderly_poweroff(true);
> +	}
> +}
> +
> +/**
> + * notify_thermal_framework - Sensor drivers use this API to notify framework
> + * @tz:		thermal zone device
> + * @trip:	indicates which trip point has been crossed
> + *
> + * This function handles the trip events from sensor drivers. It starts
> + * throttling the cooling devices according to the policy configured.
> + * For CRITICAL and HOT trip points, this notifies the respective drivers,
> + * and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
> + */
> +void notify_thermal_framework(struct thermal_zone_device *tz, int trip)
> +{
> +	enum thermal_trip_type trip_type;
> +
> +	tz->ops->get_trip_type(tz, trip, &trip_type);
> +
> +	if (trip_type == THERMAL_TRIP_CRITICAL ||
> +			trip_type == THERMAL_TRIP_HOT) {
> +		handle_critical_trips(tz, trip, trip_type);
> +	} else {
> +		handle_non_critical_trips(tz, trip, trip_type);
> +	}
>  }
> +EXPORT_SYMBOL(notify_thermal_framework);

It is not clear what is the difference of the above and the existing
thermal_zone_device_update().

Is this one supposed to be called from interrupt context?

device_update has mutex locking, this one does not have...

>  
>  /**
>   * thermal_zone_bind_cooling_device - bind a cooling device to a thermal zone
> @@ -943,6 +1140,8 @@ thermal_cooling_device_register(char *type, void *devdata,
>  	mutex_lock(&thermal_list_lock);
>  	list_add(&cdev->node, &thermal_cdev_list);
>  	list_for_each_entry(pos, &thermal_tz_list, node) {
> +		if (pos->tzp)
> +			update_tz_params(pos->tzp, cdev, 1);
>  		if (!pos->ops->bind)
>  			continue;
>  		result = pos->ops->bind(pos, cdev);
> @@ -993,6 +1192,8 @@ void thermal_cooling_device_unregister(struct
>  		if (!tz->ops->unbind)
>  			continue;
>  		tz->ops->unbind(tz, cdev);
> +		if (tz->tzp)
> +			update_tz_params(tz->tzp, cdev, 0);
>  	}
>  	mutex_unlock(&thermal_list_lock);
>  	if (cdev->type[0])
> @@ -1013,11 +1214,9 @@ EXPORT_SYMBOL(thermal_cooling_device_unregister);
>  
>  void thermal_zone_device_update(struct thermal_zone_device *tz)
>  {
> -	int count, ret = 0;
> -	long temp, trip_temp;
> +	int count;
> +	long temp;
>  	enum thermal_trip_type trip_type;
> -	struct thermal_cooling_device_instance *instance;
> -	struct thermal_cooling_device *cdev;
>  
>  	mutex_lock(&tz->lock);
>  
> @@ -1029,52 +1228,23 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  
>  	for (count = 0; count < tz->trips; count++) {
>  		tz->ops->get_trip_type(tz, count, &trip_type);
> -		tz->ops->get_trip_temp(tz, count, &trip_temp);
>  
>  		switch (trip_type) {
>  		case THERMAL_TRIP_CRITICAL:
> -			if (temp >= trip_temp) {
> -				if (tz->ops->notify)
> -					ret = tz->ops->notify(tz, count,
> -							      trip_type);
> -				if (!ret) {
> -					pr_emerg("Critical temperature reached (%ld C), shutting down\n",
> -						 temp/1000);
> -					orderly_poweroff(true);
> -				}
> -			}
> +			handle_critical_trips(tz, count, trip_type);
>  			break;
>  		case THERMAL_TRIP_HOT:
> -			if (temp >= trip_temp)
> -				if (tz->ops->notify)
> -					tz->ops->notify(tz, count, trip_type);
> +			handle_critical_trips(tz, count, trip_type);
>  			break;
>  		case THERMAL_TRIP_ACTIVE:
> -			list_for_each_entry(instance, &tz->cooling_devices,
> -					    node) {
> -				if (instance->trip != count)
> -					continue;
> -
> -				cdev = instance->cdev;
> -
> -				if (temp >= trip_temp)
> -					cdev->ops->set_cur_state(cdev, 1);
> -				else
> -					cdev->ops->set_cur_state(cdev, 0);
> -			}
> +			handle_non_critical_trips(tz, count, trip_type);
>  			break;
>  		case THERMAL_TRIP_PASSIVE:
> -			if (temp >= trip_temp || tz->passive)
> -				thermal_zone_device_passive(tz, temp,
> -							    trip_temp, count);
> +			handle_non_critical_trips(tz, count, trip_type);
>  			break;

Something like this might look better?
+		switch (trip_type) {
+		case THERMAL_TRIP_CRITICAL:
+		case THERMAL_TRIP_HOT:
+			handle_critical_trips(tz, count, trip_type);
+			break;
+		case THERMAL_TRIP_ACTIVE:
+		case THERMAL_TRIP_PASSIVE:
+			handle_non_critical_trips(tz, count, trip_type);
+			break;
+		}

>  		}
>  	}
>  
> -	if (tz->forced_passive)
> -		thermal_zone_device_passive(tz, temp, tz->forced_passive,
> -					    THERMAL_TRIPS_NONE);
> -
>  	tz->last_temperature = temp;
>  
>  leave:
> @@ -1214,9 +1384,26 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
>  
>  	thermal_zone_device_update(tz);
>  
> +	retrieve_zone_params(tz);

Again, this could be just a simple parameter...

> +
> +	if (!tz->tzp)
> +		goto exit_success;
> +
> +	/*
> +	 * A new thermal zone has been added. Look up the existing
> +	 * cooling devices list and fill the thermal zone parameters
> +	 * for this zone.
> +	 */
> +	mutex_lock(&thermal_list_lock);
> +
> +	list_for_each_entry(pos, &thermal_cdev_list, node)
> +		update_tz_params(tz->tzp, pos, 1);
> +
> +	mutex_unlock(&thermal_list_lock);
> +
> +exit_success:
>  	if (!result)
>  		return tz;
> -
>  unregister:
>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>  	device_unregister(&tz->device);
> @@ -1266,6 +1453,10 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  		device_remove_file(&tz->device,
>  				   &trip_point_attrs[count * 2 + 1]);
>  	}
> +
> +	if (tz->tzp)
> +		device_remove_file(&tz->device, &tz->policy_attr);
> +
>  	thermal_remove_hwmon_sysfs(tz);
>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>  	idr_destroy(&tz->idr);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 796f1ff..4b8a730 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -29,9 +29,25 @@
>  #include <linux/device.h>
>  #include <linux/workqueue.h>
>  
> +#define THERMAL_USER_SPACE	0
> +/* Following are kernel space policies */
> +#define THERMAL_FAIR_SHARE	1
> +#define	THERMAL_STEP_WISE	2
> +#define	THERMAL_POLICY_DEFAULT	THERMAL_USER_SPACE
> +
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
>  
> +/*
> + * The platform layer shall define a 'function' that provides the
> + * parameters for all thermal zones in the platform. This pointer
> + * should point to that 'function'.
> + *
> + * In thermal_zone_device_register() we update the parameters
> + * for the particular thermal zone.
> + */
> +extern int (*get_platform_thermal_params)(struct thermal_zone_device *tzd);
> +
>  enum thermal_device_mode {
>  	THERMAL_DEVICE_DISABLED = 0,
>  	THERMAL_DEVICE_ENABLED,
> @@ -44,12 +60,21 @@ enum thermal_trip_type {
>  	THERMAL_TRIP_CRITICAL,
>  };
>  
> +enum thermal_trend {
> +	THERMAL_TREND_NONE,

Same comment on Rui's patch applies here... Does TREND_NONE stands for 'TREND_STABLE'?

> +	THERMAL_TREND_HEATING,
> +	THERMAL_TREND_COOLING,
> +	THERMAL_TREND_DEFAULT = THERMAL_TREND_HEATING,
> +};
> +
>  struct thermal_zone_device_ops {
>  	int (*bind) (struct thermal_zone_device *,
>  		     struct thermal_cooling_device *);
>  	int (*unbind) (struct thermal_zone_device *,
>  		       struct thermal_cooling_device *);
>  	int (*get_temp) (struct thermal_zone_device *, unsigned long *);
> +	int (*get_trend) (struct thermal_zone_device *, int,
> +				enum thermal_trend *);

Cool! We just need to device in which patch this change goes in as we have a collision :-)

>  	int (*get_mode) (struct thermal_zone_device *,
>  			 enum thermal_device_mode *);
>  	int (*set_mode) (struct thermal_zone_device *,
> @@ -69,9 +94,17 @@ struct thermal_cooling_device_ops {
>  	int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
>  };
>  
> +
>  #define THERMAL_TRIPS_NONE -1
>  #define THERMAL_MAX_TRIPS 12
>  #define THERMAL_NAME_LENGTH 20
> +
> +/* Really no great reason for '12'. But at max one device per trip point */
> +#define MAX_COOLING_DEVICES	THERMAL_MAX_TRIPS
> +
> +int step_wise_throttle(struct thermal_zone_device *, int, enum thermal_trip_type);


WARNING: line over 80 characters
#598: FILE: include/linux/thermal.h:105:
+int step_wise_throttle(struct thermal_zone_device *, int, enum thermal_trip_type);

total: 0 errors, 1 warnings, 3 checks, 588 lines checked


> +int fair_share_throttle(struct thermal_zone_device *);
> +
>  struct thermal_cooling_device {
>  	int id;
>  	char type[THERMAL_NAME_LENGTH];
> @@ -104,7 +137,29 @@ struct thermal_zone_device {
>  	struct mutex lock;	/* protect cooling devices list */
>  	struct list_head node;
>  	struct delayed_work poll_queue;
> +	struct device_attribute policy_attr;
> +	struct thermal_zone_params *tzp;
>  };
> +
> +struct thermal_zone_params {
> +	char *thermal_zone_name;
> +	int throttle_policy;
> +
> +	/* Number of cooling devices associated with this thermal zone */
> +	int num_cdevs;
> +	char *cdevs_name[MAX_COOLING_DEVICES];
> +	struct thermal_cooling_device *cdevs[MAX_COOLING_DEVICES];
> +
> +	/*
> +	 * This is a measure of 'how effectively these devices can
> +	 * cool 'this' thermal zone. The shall be determined by platform
> +	 * characterization. This is on a 'percentage' scale.
> +	 *
> +	 * See Documentation/thermal/sysfs-api.txt for more information.
> +	 */
> +	int weights[MAX_COOLING_DEVICES];

Would it make sense to have an array of structs here instead of two arrays?

Instead of doing:
+	{
+		.thermal_zone_name = "CPU",
+		.throttle_policy = THERMAL_FAIR_SHARE,
+		.num_cdevs = 2,
+		.cdevs_name = {"CPU", "Battery"},
+		.weights = {80, 20},
+	},

one would do:
+	{
+		.thermal_zone_name = "CPU",
+		.throttle_policy = THERMAL_FAIR_SHARE,
+		.num_cdevs = 2,
+		.cdevs = {
+			{
+				.name = "CPU",
+				.weight = 80,
+			},
+			{
+				.name = "Battery",
+				.weight = 20,
+			},
+		},
+	},

It looks lengthier, I know. But at least looks more well structured I'd say.

One can aways define a macro:
+#define CDEV_PDATA_WEIGHT_ENTRY(n, w) \
+{				\
+	.name = n,		\
+	.weight = (w),		\
+}
...
+	{
+		.thermal_zone_name = "CPU",
+		.throttle_policy = THERMAL_FAIR_SHARE,
+		.num_cdevs = 2,
+		.cdevs = {
+			CDEV_PDATA_WEIGHT_ENTRY("CPU", 80),
+			CDEV_PDATA_WEIGHT_ENTRY("Battery", 20),
+		},
+	},

> +};
> +
>  /* Adding event notification support elements */
>  #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
>  #define THERMAL_GENL_VERSION                    0x01
> -- 
> 1.7.0.4
> 
