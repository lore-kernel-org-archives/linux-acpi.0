From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 06/13] Thermal: Add a policy sysfs attribute
Date: Mon, 13 Aug 2012 15:07:11 +0800
Message-ID: <1344841631.1682.798.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-7-git-send-email-durgadoss.r@intel.com>
	 <1344839331.1682.779.camel@rui.sh.intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB5919A3D6@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27562 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab2HMHGF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2012 03:06:05 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5919A3D6@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

On =E4=B8=80, 2012-08-13 at 00:34 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> > +
> > >  	thermal_remove_hwmon_sysfs(tz);
> > >  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> > >  	idr_destroy(&tz->idr);
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index f9ce1e2..1d49f05 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -173,6 +173,7 @@ struct thermal_zone_device {
> > >  	struct list_head node;
> > >  	struct delayed_work poll_queue;
> > >  	struct thermal_zone_params *tzp;
> > > +	struct device_attribute policy_attr;
> >=20
> > do we need a device_attribute for each thermal zone?
> > I think we can share one static DEVICE_ATTR here.
>=20
> We need a policy sysfs node per zone. That=E2=80=99s why I put it
> this way, and thought this looks cleaner.
>=20
> But, as per the implementation point, static DEVICE_ATTR=20
> would also work. Either ways is fine for me.
>=20
I'd prefer the static DEVICE_ATTR, which is the way we do for other
attributes like type, mode, temp, etc.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
