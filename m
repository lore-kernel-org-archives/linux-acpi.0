From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/16] Thermal: Add Hysteresis attributes
Date: Thu, 19 Jul 2012 22:00:12 +0200
Message-ID: <201207192200.12806.rjw@sisk.pl>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com> <1342679480-5336-3-git-send-email-rui.zhang@intel.com> <4D68720C2E767A4AA6A8796D42C8EB59166724@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48582 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab2GSTyc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 15:54:32 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59166724@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>

On Thursday, July 19, 2012, R, Durgadoss wrote:
> Hi Rui,
> 
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Thursday, July 19, 2012 12:01 PM
> > To: linux-acpi@vger.kernel.org; linux-pm@vger.kernel.org
> > Cc: Rafael J. Wysocki; Matthew Garrett; Len Brown; R, Durgadoss; Eduardo
> > Valentin; Amit Kachhap; Wei Ni; Zhang, Rui
> > Subject: [PATCH 02/16] Thermal: Add Hysteresis attributes
> > 
> > From: Durgadoss R <dugardoss.r@intel.com>
> > 
> > The Linux Thermal Framework does not support hysteresis
> > attributes. Most thermal sensors, today, have a
> > hysteresis value associated with trip points.
> > 
> > This patch adds hysteresis attributes on a per-trip-point
> > basis, to the Thermal Framework. These attributes are
> > optionally writable.
> > 
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  Documentation/thermal/sysfs-api.txt |    6 +++
> >  drivers/thermal/thermal_sys.c       |   89
> > ++++++++++++++++++++++++++++++++---
> >  include/linux/thermal.h             |    5 ++
> >  3 files changed, 94 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/thermal/sysfs-api.txt
> > b/Documentation/thermal/sysfs-api.txt
> > index 0c7c423..3c8c2f8 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -121,6 +121,7 @@ if hwmon is compiled in or built as a module.
> >      |---mode:			Working mode of the thermal zone
> >      |---trip_point_[0-*]_temp:	Trip point temperature
> >      |---trip_point_[0-*]_type:	Trip point type
> > +    |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
> > 
> >  Thermal cooling device sys I/F, created once it's registered:
> >  /sys/class/thermal/cooling_device[0-*]:
> > @@ -190,6 +191,11 @@ trip_point_[0-*]_type
> >  	thermal zone.
> >  	RO, Optional
> > 
> [cut.]
> 
> > +		/* create Optional trip hyst attribute */
> > +		if (!tz->ops->get_trip_hyst)
> > +			continue;
> > +		snprintf(tz->trip_hyst_attrs[indx].name,
> > THERMAL_NAME_LENGTH,
> > +			 "trip_point_%d_hyst", indx);
> > +
> > +		sysfs_attr_init(&tz->trip_hyst_attrs[indx].attr.attr);
> > +		tz->trip_hyst_attrs[indx].attr.attr.name =
> > +					tz->trip_hyst_attrs[indx].name;
> > +		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
> > +		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
> > +		if (tz->ops->set_trip_hyst) {
> > +			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
> > +			tz->trip_hyst_attrs[indx].attr.store =
> > +					trip_point_hyst_store;
> > +		}
> > +
> > +		device_create_file(&tz->device,
> > +				   &tz->trip_hyst_attrs[indx].attr);
> >  	}
> >  	return 0;
> >  }
> > @@ -1151,9 +1225,13 @@ static void remove_trip_attrs(struct
> > thermal_zone_device *tz)
> >  				   &tz->trip_type_attrs[indx].attr);
> >  		device_remove_file(&tz->device,
> >  				   &tz->trip_temp_attrs[indx].attr);
> > +		if (tz->ops->get_trip_hyst)
> > +			device_remove_file(&tz->device,
> > +				  &tz->trip_hyst_attrs[indx].attr);
> >  	}
> >  	kfree(tz->trip_type_attrs);
> >  	kfree(tz->trip_temp_attrs);
> 
> I believe we should have a check here for 'if (tz->ops->get_trip_hyst)' and then
> only free this, if required.
> 
> > +	kfree(tz->trip_hyst_attrs);
> >  }

No, we don't have to, kfree() checks for NULL pointers.

Thanks,
Rafael
