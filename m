From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 1/4] RFC Thermal: Enhance Generic Thermal layer with
 policies
Date: Tue, 12 Jun 2012 16:09:15 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5913621E@BGSMSX101.gar.corp.intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
 <1339436374-26881-2-git-send-email-durgadoss.r@intel.com>
 <20120612124615.GB8724@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23576 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab2FLQJX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jun 2012 12:09:23 -0400
In-Reply-To: <20120612124615.GB8724@besouro>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>

Hi Eduardo,

> Hello Durgadoss,
> 
> Things are moving fast! Losts of work on going.
> This is good. Just that now we have some overlaps. I'd propose to be
> more structured and align between ourselves. Having branches would
> be a nice starting point. I can collect your changes and post to gitorious
> or something if you agree.
> 
> I like the approach Durgadoss is proposing. So we can have different
> policy behavior on different zones.

Thank you..

> 
> But we need to see how we merge both of your work. There is still
> Amit's work, and I haven't sent my changes yet :-)

Yes in the next patch set I will try to be synced up with Rui's patches.

> 
> This patch introduces several things. I see at least three
> major changes. Can you split it into smaller pieces?

True and agree with you.
I had various reasons due to which I could not do that.
Now things are clear, and will make it more organized in the next set.

> > +    .weights: This parameter defines the 'influence' of a particular cooling
> > +	      device on this thermal zone, on a percentage scale. The sum of
> > +	      all these weights cannot exceed 100. The order of values in
> > +	      this array should match with that of the cooling_devices_name.
> > +1.4.3 An example thermal_zone_params structure
> > +	struct thermal_zone_params tzp = {
> > +                .thermal_zone_name = "CPU",
> > +                .num_cdevs = 2,
> > +                .cdevs_name = {"CPU", "Memory"},
> > +                .weights = {70, 30},
> > +        };
> > +
> 
> Nice! Only missing point from the documentation above is that it is not
> so clear how platform code is suppose to provide the zone params structure...

I hope (luckily) my patch 4/4 explains that :-)

> >
> > +int (*get_platform_thermal_params)(struct thermal_zone_device *tzd);
> > +EXPORT_SYMBOL(get_platform_thermal_params);
> > +
> 
> Are we sure we want to go in this way? Shouldn't the zone register be
> enough to provide this data per zone?

As I mentioned in other patch, this can here or can be in a platform
thermal driver file. I think keeping it here makes it easier, otherwise
we need to make sure every driver (that wants to fetch pdata) has
this defined there.
I am not saying it is a difficult thing, but thinking from the view of
somebody who just writes driver for a thermal chip, this approach
can make his/her life easy.

> > +	struct thermal_zone_params *tzp = tz->tzp;
> > +
> > +	if (!strcmp(policy, "fair_share")) {
> > +		tzp->throttle_policy = THERMAL_FAIR_SHARE;
> > +	} else if (!strcmp(policy, "step_wise")) {
> > +		tzp->throttle_policy = THERMAL_STEP_WISE;
> > +	} else if (!strcmp(policy, "user_space")) {
> > +		tzp->throttle_policy = THERMAL_USER_SPACE;
> > +	} else {
> > +		dev_err(&tz->device, "Setting throttling policy failed:\n");
> > +		return -EINVAL;
> > +	}
> 
> For the comparison above: sysfs_streq.

I am not aware of the API. Will look at it. Thank you.

> 
> How do we handle locking and make sure the policy switch is sane and not having
> concurrency issues?

Will add protection.

> > +
> > +static int create_policy_attr(struct thermal_zone_device *tz)
> 
> This function name is not so good as the function also creates the device file.

You seem to be good at naming :-)
Any free suggestions for this name here ?

> > +static void update_tz_params(struct thermal_zone_params *tzp,
> 
> Any better naming for this function?

I can think through, but suggestions are welcome :-)

> 
> Is flag bool? If so, please use it.

Yes will use bool. 

> > +	ret = get_platform_thermal_params(tz);
> > +	if (ret) {
> > +		dev_err(&tz->device,
> > +		"parameters for zone %s not defined:%d\n", tz->type, ret);
> > +		return;
> 
> checkpatch.pl --strict says this about the above:
> CHECK: Alignment should match open parenthesis
> #205: FILE: drivers/thermal/thermal_sys.c:759:
> +		dev_err(&tz->device,
> +		"parameters for zone %s not defined:%d\n", tz->type, ret);

I don't run it with --strict.
Will try next time, if it does not affect readability will make this change.

> > +	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
> 
> This is not good. I believe we have a userspace notification mechanism already.
> 
> Rui, in general we need to standardize the kernel <-> userland userspace
> communication/
> notification system. Is the existing netlink enough? Why would we need a sysfs
> notify?

I agree on the standardization.
I added the existing netlink mechanism a year ago, and we have a couple of
systems using that. That time, the inspiration came from one of the acpi
drivers.

Now, I would like to move towards a UEvent approach (as more user land
apps are moving towards that).

> > -		if (state > 0)
> > -			cdev->ops->set_cur_state(cdev, --state);
> > -		if (state == 0)
> > -			tz->passive = false;
> > +
> > +		if (trend == THERMAL_TREND_HEATING)
> > +			__throttle(cdev);
> > +		else
> > +			__dethrottle(cdev);
> 
> I like the above. Looks way cleaner.

Thank you.

> 
> On the other hand, does it make sense to make linear_throttle a
> real throttle_policy, instead of treating it as a separate case?
> 
> Meaning, also having its own file, just like the others.

Exactly..Will do.

> > +static inline int sw_throttle(struct thermal_zone_device *tz, int trip,
> > +			enum thermal_trip_type trip_type)
> > +{
> > +	return 0;
> > +}
> > +#endif
> 
> Nip: Another way, instead of having the ifdeferry here, we could have a header
> file which does the config check above.

Do you think it is Ok to have this inside thermal.h ?
Or is it better to create one more new .h say thermal_policy.h or thermal_governor.h ?

> 
> 
> Can someone explain me why .notify is a must for thermal_shutdow?

I have no idea. I also wanted to know the reason.
I thought instead of asking in an e-mail, if I touch code more people will answer,
and looks like it worked :-)

If I don't get any valid reason, I will remove this check/modify this as necessary.

> 
> It is not clear what is the difference of the above and the existing
> thermal_zone_device_update().

Again not intended to be different.
I will clean it up.

> 
> Is this one supposed to be called from interrupt context?
> 
> device_update has mutex locking, this one does not have...

Interrupt context is fine, but only from a bottom half.
So, I will add protection here and clean this.

> Something like this might look better?

I don't know why I did not do this :-(

> +		switch (trip_type) {
> +		case THERMAL_TRIP_CRITICAL:
> +		case THERMAL_TRIP_HOT:
> +			handle_critical_trips(tz, count, trip_type);
> +			break;
> +		case THERMAL_TRIP_ACTIVE:
> +		case THERMAL_TRIP_PASSIVE:
> +			handle_non_critical_trips(tz, count, trip_type);
> +			break;


> >  };
> >
> > +enum thermal_trend {
> > +	THERMAL_TREND_NONE,
> 
> Same comment on Rui's patch applies here... Does TREND_NONE stands for
> 'TREND_STABLE'?

We can use 'stable'. I will sync up with Rui's Patches.

> > +	 * See Documentation/thermal/sysfs-api.txt for more information.
> > +	 */
> > +	int weights[MAX_COOLING_DEVICES];
> 
> Would it make sense to have an array of structs here instead of two arrays?
> 
> Instead of doing:
> +	{
> +		.thermal_zone_name = "CPU",
> +		.throttle_policy = THERMAL_FAIR_SHARE,
> +		.num_cdevs = 2,
> +		.cdevs_name = {"CPU", "Battery"},
> +		.weights = {80, 20},
> +	},
> 
> one would do:
> +	{
> +		.thermal_zone_name = "CPU",
> +		.throttle_policy = THERMAL_FAIR_SHARE,
> +		.num_cdevs = 2,
> +		.cdevs = {
> +			{
> +				.name = "CPU",
> +				.weight = 80,
> +			},
> +			{
> +				.name = "Battery",
> +				.weight = 20,
> +			},
> +		},
> +	},
> 
> It looks lengthier, I know. But at least looks more well structured I'd say.

I dropped it for the same reason.
But, this is going to be inside a platform file, so we can choose to do this.

Thanks,
Durga

