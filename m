From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 02/13] Thermal: Move thermal_instance to thermal.h
Date: Thu, 16 Aug 2012 15:12:32 +0800
Message-ID: <1345101152.1682.870.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-3-git-send-email-durgadoss.r@intel.com>
	 <1345097667.1682.855.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591A5104@BGSMSX101.gar.corp.intel.com>
	 <1345098562.1682.864.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB591A5152@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8381 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2HPHL2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2012 03:11:28 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591A5152@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>, Jean Delvare <jdelvare@suse.com>

On =E5=9B=9B, 2012-08-16 at 00:31 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> [cut.]
> > > > > +/*
> > > > > + * This structure is used to describe the behavior of
> > > > > + * a certain cooling device on a certain trip point
> > > > > + * in a certain thermal zone
> > > > > + */
> > > > > +struct thermal_instance {
> > > > > +	int id;
> > > > > +	char name[THERMAL_NAME_LENGTH];
> > > > > +	struct thermal_zone_device *tz;
> > > > > +	struct thermal_cooling_device *cdev;
> > > > > +	int trip;
> > > > > +	unsigned long upper;	/* Highest cooling state for this trip=
 point */
> > > > > +	unsigned long lower;	/* Lowest cooling state for this trip =
point */
> > > > > +	unsigned long target;	/* expected cooling state */
> > > > > +	char attr_name[THERMAL_NAME_LENGTH];
> > > > > +	struct device_attribute attr;
> > > > > +	struct list_head tz_node; /* node in tz->thermal_instances =
*/
> > > > > +	struct list_head cdev_node; /* node in cdev->thermal_instan=
ces */
> > > > > +};
> > > > > +
> > > >
> > > > as this structure is used internally only, I'm thinking if we c=
an rename
> > > > drivers/thermal/thermal_sys.c to drivers/thermal/thermal_core.c=
,
> > > > and introduce drivers/thermal/thermal_core.h for these internal=
 stuff.
> > > > what do you think?
> > >
> > > Yes agree with you.
> > > Also, we can keep the sysfs things in thermal_sys.c
> > > and rest of the things in thermal_core.c, and have a thermal_core=
=2Eh also.
> > > (This is how the power supply subsystem does it)
> > >
> > > I will include this clean up, as part of v2, if you are Ok with t=
his.
> > >
> > yes, please go ahead.
>=20
> Ok. I will include this change.
>=20
> >=20
> > > Other things;
> > >  I was thinking is 'removal of netlink things' from
> > > thermal_sys.c
> >=20
> > and where to move it to?
>=20
> I was thinking of completely removing this, as raw netlink
> usage is phasing out, and kobj_uevent () is being used
> increasingly.
>=20
> But we will keep it as a separate change, and not club with this one.
>=20
We need to hold this for a while as I'm not sure if someone is using
this or not.
IMO, you can introduce a Config option to enable/disable the netlink
events for now, and marking it as deprecated.

thanks,
rui
> > >
> > > Removing the hwmon related code (the thermal subsystem has grown
> > > quite a bit and provides more thermal functionalities than Hwmon)
> > > So, why do we need CONFIG_HWMON inside thermal subsystem ?
> > > If all of us agree, I am Ok to remove this also.
> > >
> > we need Jean's opinion on this.
> > But anyway, we can do this at anytime, if really needed.
>=20
> Yes, will wait for Jean's thoughts..
>=20
> Thanks,
> Durga
>=20
> >=20
> > thanks,
> > rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
