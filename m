From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCHv2 04/14] Thermal: Add platform level information to
 thermal.h
Date: Mon, 27 Aug 2012 09:22:33 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263210204@SHSMSX101.ccr.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-5-git-send-email-durgadoss.r@intel.com>
 <744357E9AAD1214791ACBA4B0B909263210135@SHSMSX101.ccr.corp.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB591AD4FD@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57496 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007Ab2H0JWh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 05:22:37 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591AD4FD@BGSMSX101.gar.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>



> -----Original Message-----
> From: R, Durgadoss
> Sent: Monday, August 27, 2012 11:57 AM
> To: Zhang, Rui; lenb@kernel.org
> Cc: linux-acpi@vger.kernel.org; eduardo.valentin@ti.com
> Subject: RE: [PATCHv2 04/14] Thermal: Add platform level information to
> thermal.h
> Importance: High
> 
> Hi Rui,
> 
> [cut.]
> 
> > > +int (*get_platform_thermal_params)(struct thermal_zone_device *);
> > > +EXPORT_SYMBOL(get_platform_thermal_params);
> > > +
> > If this function is used by the thermal layer, and provided by the
> > platform thermal driver, why not make it mandatory when registering a
> thermal zone?
> >
> > Say,
> >
> > +/* Structure to define Thermal Zone parameters */ struct
> > +thermal_zone_params {
> > +	int trips,
> > +	int mask,
> > +	struct thermal_zone_device_ops *ops;
> > +	enum thermal_throttle_policy throttle_policy;
> > +	int num_tbps;	/* Number of tbp entries */
> > +	struct thermal_bind_params *tbp;
> >  };
> > And modify thermal_zone_device_register to Struct thermal_zone_device
> > *thermal_zone_device_register(const char *type, struct
> > thermal_zone_params *params);
> >
> > The first 3 fields are necessary for registering a zone, the
> > thermal_bind_params can either be filled by platform thermal driver,
> > or be NULL and filled by thermal layer later, when user invokes
> > thermal_zone_bind_cooling_devices.
> >
> > In this way, we do not need this API at all.
> 
> We can do it either ways. In this case, we need to modify all the
> tzd_register calls. If we are Ok doing that, I am happy to change.
> 
> Just that we are adding one more to the already existing 7 args :-)

No, we are trying to reducing the args by moving them into thermal_zone_params.

> 
> > >  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
> {
> > >  	int err;
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index
> > > 32af124..b644b8e 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -67,6 +67,12 @@ enum thermal_trend {
> > >  	THERMAL_TREND_DROPPING, /* temperature is dropping */  };
> > >
> > > +enum thermal_throttle_policy {
> > > +	THERMAL_USER_SPACE,
> > > +	THERMAL_FAIR_SHARE,
> > > +	THERMAL_STEP_WISE,
> > > +};
> > > +
> > >  /* Events supported by Thermal Netlink */  enum events {
> > >  	THERMAL_AUX0,
> > > @@ -162,6 +168,37 @@ struct thermal_zone_device {
> > >  	struct mutex lock; /* protect thermal_instances list */
> > >  	struct list_head node;
> > >  	struct delayed_work poll_queue;
> > > +	struct thermal_zone_params *tzp;
> > > +};
> > > +
> > > +/* Structure that holds binding parameters for a zone */ struct
> > > +thermal_bind_params {
> > > +	struct thermal_cooling_device *cdev;
> > > +
> > > +	/*
> > > +	 * This is a measure of 'how effectively these devices can
> > > +	 * cool 'this' thermal zone. The shall be determined by platform
> > > +	 * characterization. This is on a 'percentage' scale.
> > > +	 * See Documentation/thermal/sysfs-api.txt for more information.
> > > +	 */
> > > +	int weight;
> > > +
> > > +	/*
> > > +	 * This is a bit mask that gives the binding relation between
> > > this
> > > +	 * thermal zone and cdev, for a particular trip point.
> > > +	 * See Documentation/thermal/sysfs-api.txt for more information.
> > > +	 */
> > > +	int trip_mask;
> > > +	int (*match) (struct thermal_zone_device *tz,
> > > +			struct thermal_cooling_device *cdev); };
> >
> > You should start a new line here.
> 
> Again, not sure what you meant here. The new line is already there.
> 
		struct thermal_cooling_device *cdev);
	 };

I'm not sure what it is in your original patch, but I see something like
"struct thermal_cooling_device *cdev); };"
May be this is because I'm using outlook?

thanks,
rui
> > > +/* Structure to define Thermal Zone parameters */ struct
> > > +thermal_zone_params {
> > > +	const char *zone_name;
> >
> >
> > What is this zone_name used for?
> 
> This is required when we retrieve platform data from framework layer.
> Now, that we make it as an argument in tzd_register, we don't need this.
> 
> Thanks,
> Durga
