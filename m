From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCHv2 06/14] Thermal: Add a policy sysfs attribute
Date: Mon, 27 Aug 2012 09:25:17 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263210229@SHSMSX101.ccr.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-7-git-send-email-durgadoss.r@intel.com>
 <744357E9AAD1214791ACBA4B0B909263210161@SHSMSX101.ccr.corp.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB591AD524@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17998 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258Ab2H0JZV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 05:25:21 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591AD524@BGSMSX101.gar.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>



> -----Original Message-----
> From: R, Durgadoss
> Sent: Monday, August 27, 2012 12:02 PM
> To: Zhang, Rui; lenb@kernel.org
> Cc: linux-acpi@vger.kernel.org; eduardo.valentin@ti.com
> Subject: RE: [PATCHv2 06/14] Thermal: Add a policy sysfs attribute
> Importance: High
> 
> Hi Rui,
> 
> > > +static ssize_t
> > > +policy_show(struct device *dev, struct device_attribute *devattr,
> > > +char
> > > +*buf) {
> > > +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> > > +	struct thermal_zone_params *tzp = tz->tzp;
> > > +
> > > +	if (!tzp)
> > > +		return sprintf(buf, "step_wise(default)\n");
> > > +
> > > +	switch (tzp->throttle_policy) {
> > > +	case THERMAL_FAIR_SHARE:
> > > +		return sprintf(buf, "fair_share\n");
> > > +	case THERMAL_STEP_WISE:
> > > +		return sprintf(buf, "step_wise\n");
> > > +	case THERMAL_USER_SPACE:
> > > +		return sprintf(buf, "user_space\n");
> > > +	default:
> > > +		return sprintf(buf, "unknown\n");
> > > +	}
> > > +}
> > > +
> > >  static DEVICE_ATTR(type, 0444, type_show, NULL);  static
> > > DEVICE_ATTR(temp, 0444, temp_show, NULL);  static DEVICE_ATTR(mode,
> > > 0644, mode_show, mode_store);  static DEVICE_ATTR(passive, S_IRUGO
> |
> > > S_IWUSR, passive_show, passive_store);
> > > +static DEVICE_ATTR(throttle_policy, S_IRUGO, policy_show, NULL);
> > >
> > >  /* sys I/F for cooling device */
> > >  #define to_cooling_device(_dev)	\
> > > @@ -1349,10 +1371,16 @@ static int retrieve_zone_params(struct
> > > thermal_zone_device *tz)
> > >
> > >  	/* It is not an error to not have any platform data */
> > >  	ret = get_platform_thermal_params(tz);
> > > -	if (ret)
> > > +	if (ret) {
> > >  		tz->tzp = NULL;
> > > +		return 0;
> > > +	}
> > >
> > > -	return 0;
> > > +	ret = device_create_file(&tz->device, &dev_attr_throttle_policy);
> > > +	if (ret)
> > > +		dev_err(&tz->device, "creating policy attr failed:%d\n",
> > > ret);
> > > +
> > > +	return ret;
> > >  }
> >
> > What does this mean?
> > We will not create "policy" attributes if there is no
> thermal_zone_params?
> 
> Yes, that's what I thought initially. Because if there is no
> 'throttle_policy'
> we assume that it is (by default) step_wise.
> 
> But, if we make tz_params be provided through tzd_register function
> call, it makes sense for this to be a mandatory attribute, showing
> 'step_wise"
> if there is no thermal_zone_params.
> 

IMO, every thermal zone should have a policy. And they can be changed anytime if user wants to.

Thanks,
rui
