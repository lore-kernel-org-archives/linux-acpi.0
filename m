From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCHv2 06/14] Thermal: Add a policy sysfs attribute
Date: Mon, 27 Aug 2012 10:25:58 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB591AD665@BGSMSX101.gar.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-7-git-send-email-durgadoss.r@intel.com>
 <744357E9AAD1214791ACBA4B0B90926321026B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15703 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082Ab2H0K0T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 06:26:19 -0400
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926321026B@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

> > +static ssize_t
> > +policy_show(struct device *dev, struct device_attribute *devattr, char
> > +*buf) {
> > +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> > +	struct thermal_zone_params *tzp = tz->tzp;
> > +
> > +	if (!tzp)
> > +		return sprintf(buf, "step_wise(default)\n");
> > +
> > +	switch (tzp->throttle_policy) {
> > +	case THERMAL_FAIR_SHARE:
> > +		return sprintf(buf, "fair_share\n");
> > +	case THERMAL_STEP_WISE:
> > +		return sprintf(buf, "step_wise\n");
> > +	case THERMAL_USER_SPACE:
> > +		return sprintf(buf, "user_space\n");
> > +	default:
> > +		return sprintf(buf, "unknown\n");
> > +	}
> > +}
> > +
> >  static DEVICE_ATTR(type, 0444, type_show, NULL);  static
> > DEVICE_ATTR(temp, 0444, temp_show, NULL);  static DEVICE_ATTR(mode,
> > 0644, mode_show, mode_store);  static DEVICE_ATTR(passive, S_IRUGO |
> > S_IWUSR, passive_show, passive_store);
> > +static DEVICE_ATTR(throttle_policy, S_IRUGO, policy_show, NULL);
> >
> >  /* sys I/F for cooling device */
> >  #define to_cooling_device(_dev)	\
> > @@ -1349,10 +1371,16 @@ static int retrieve_zone_params(struct
> > thermal_zone_device *tz)
> >
> >  	/* It is not an error to not have any platform data */
> >  	ret = get_platform_thermal_params(tz);
> > -	if (ret)
> > +	if (ret) {
> >  		tz->tzp = NULL;
> > +		return 0;
> > +	}
> >
> > -	return 0;
> > +	ret = device_create_file(&tz->device, &dev_attr_throttle_policy);
> > +	if (ret)
> > +		dev_err(&tz->device, "creating policy attr failed:%d\n",
> > ret);
> > +
> > +	return ret;
> >  }
> >
> >  /**
> 
> We should remove this attribute in thermal_zone_device_unregister();

Oh yes, missed it :-(
Will fix in v3..

Thanks for the catch,
Durga
