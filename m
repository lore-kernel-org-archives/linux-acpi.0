From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCHv4 07/15] Thermal: Add a policy sysfs attribute
Date: Mon, 24 Sep 2012 13:44:10 +0800
Message-ID: <1348465450.10877.151.camel@rui.sh.intel.com>
References: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
	 <1347946506-18449-8-git-send-email-durgadoss.r@intel.com>
	 <1348214827.10877.138.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591C03A3@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52512 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325Ab2IXFn1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Sep 2012 01:43:27 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591C03A3@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

On =E4=BA=94, 2012-09-21 at 02:09 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Friday, September 21, 2012 1:37 PM
> > To: R, Durgadoss
> > Cc: lenb@kernel.org; linux-acpi@vger.kernel.org; eduardo.valentin@t=
i.com
> > Subject: Re: [PATCHv4 07/15] Thermal: Add a policy sysfs attribute
> >=20
> > On =E4=BA=8C, 2012-09-18 at 11:04 +0530, Durgadoss R wrote:
> > > This patch adds a policy sysfs attribute to a thermal zone.
> > > This attribute denotes the throttling governor used for the
> > > zone. This is a RW attribute.
> > >
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > > ---
> > >  drivers/thermal/thermal_sys.c |   42
> > ++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 39 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/ther=
mal_sys.c
> > > index a67c6c0..0948a60 100644
> > > --- a/drivers/thermal/thermal_sys.c
> > > +++ b/drivers/thermal/thermal_sys.c
> > > @@ -454,10 +454,41 @@ passive_show(struct device *dev, struct
> > device_attribute *attr,
> > >  	return sprintf(buf, "%d\n", tz->forced_passive);
> > >  }
> > >
> > > +static ssize_t
> > > +policy_store(struct device *dev, struct device_attribute *attr,
> > > +		    const char *buf, size_t count)
> > > +{
> > > +	int ret =3D -EINVAL;
> > > +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> > > +	struct thermal_governor *gov;
> > > +
> > > +	mutex_lock(&thermal_governor_lock);
> > > +
> > > +	gov =3D __find_governor(buf);
> > > +	if (!gov)
> > > +		goto exit;
> > > +
> > > +	tz->governor =3D gov;
> > > +	ret =3D count;
> > > +
> > > +exit:
> > > +	mutex_unlock(&thermal_governor_lock);
> > > +	return ret;
> > > +}
> > > +
> > > +static ssize_t
> > > +policy_show(struct device *dev, struct device_attribute *devattr=
, char
> > *buf)
> > > +{
> > > +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> > > +
> > > +	return sprintf(buf, "%s\n", tz->governor->name);
> > > +}
> > > +
> >=20
> > we should introduce an API for platform thermal drivers to switch t=
heir
> > policy.
> > say they may want to switch to "userspace" to disable the kernel th=
ermal
> > control.
> > and policy_store should invoke that function directly.
>=20
> Yes, makes sense, we can introduce an EXPORT_SYMBOL API.

yes, we can have an incremental path for this.

thanks,
rui
>=20
> Thanks,
> Durga
>=20
> > BTW, IMO, deactiving all the thermal_instances and updating the coo=
ling
> > devices when a thermal zone switches to "userspace" governor is
> > reasonable.
> >=20
> > thanks,
> > rui
> > >  static DEVICE_ATTR(type, 0444, type_show, NULL);
> > >  static DEVICE_ATTR(temp, 0444, temp_show, NULL);
> > >  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
> > >  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show,
> > passive_store);
> > > +static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show,
> > policy_store);
> > >
> > >  /* sys I/F for cooling device */
> > >  #define to_cooling_device(_dev)	\
> > > @@ -1512,10 +1543,14 @@ struct thermal_zone_device
> > *thermal_zone_device_register(const char *type,
> > >  			passive =3D 1;
> > >  	}
> > >
> > > -	if (!passive)
> > > -		result =3D device_create_file(&tz->device,
> > > -					    &dev_attr_passive);
> > > +	if (!passive) {
> > > +		result =3D device_create_file(&tz->device, &dev_attr_passive);
> > > +		if (result)
> > > +			goto unregister;
> > > +	}
> > >
> > > +	/* Create policy attribute */
> > > +	result =3D device_create_file(&tz->device, &dev_attr_policy);
> > >  	if (result)
> > >  		goto unregister;
> > >
> > > @@ -1591,6 +1626,7 @@ void thermal_zone_device_unregister(struct
> > thermal_zone_device *tz)
> > >  	device_remove_file(&tz->device, &dev_attr_temp);
> > >  	if (tz->ops->get_mode)
> > >  		device_remove_file(&tz->device, &dev_attr_mode);
> > > +	device_remove_file(&tz->device, &dev_attr_policy);
> > >  	remove_trip_attrs(tz);
> > >  	tz->governor =3D NULL;
> > >
> >=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
