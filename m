From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 02/13] Thermal: Move thermal_instance to thermal.h
Date: Mon, 20 Aug 2012 23:41:31 +0300
Message-ID: <20120820204131.GQ9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-3-git-send-email-durgadoss.r@intel.com>
 <1345097667.1682.855.camel@rui.sh.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB591A5104@BGSMSX101.gar.corp.intel.com>
 <1345098562.1682.864.camel@rui.sh.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB591A5152@BGSMSX101.gar.corp.intel.com>
 <1345101152.1682.870.camel@rui.sh.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41548 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752656Ab2HTUll (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 16:41:41 -0400
Received: by wibhm6 with SMTP id hm6so3279679wib.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 13:41:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345101152.1682.870.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>, Jean Delvare <jdelvare@suse.com>

Hello,

On Thu, Aug 16, 2012 at 03:12:32PM +0800, Zhang Rui wrote:
> On =E5=9B=9B, 2012-08-16 at 00:31 -0600, R, Durgadoss wrote:
> > Hi Rui,
> >=20
> > [cut.]
> > > > > > +/*
> > > > > > + * This structure is used to describe the behavior of
> > > > > > + * a certain cooling device on a certain trip point
> > > > > > + * in a certain thermal zone
> > > > > > + */
> > > > > > +struct thermal_instance {
> > > > > > +	int id;
> > > > > > +	char name[THERMAL_NAME_LENGTH];
> > > > > > +	struct thermal_zone_device *tz;
> > > > > > +	struct thermal_cooling_device *cdev;
> > > > > > +	int trip;
> > > > > > +	unsigned long upper;	/* Highest cooling state for this tr=
ip point */
> > > > > > +	unsigned long lower;	/* Lowest cooling state for this tri=
p point */
> > > > > > +	unsigned long target;	/* expected cooling state */
> > > > > > +	char attr_name[THERMAL_NAME_LENGTH];
> > > > > > +	struct device_attribute attr;
> > > > > > +	struct list_head tz_node; /* node in tz->thermal_instance=
s */
> > > > > > +	struct list_head cdev_node; /* node in cdev->thermal_inst=
ances */
> > > > > > +};
> > > > > > +
> > > > >
> > > > > as this structure is used internally only, I'm thinking if we=
 can rename
> > > > > drivers/thermal/thermal_sys.c to drivers/thermal/thermal_core=
=2Ec,
> > > > > and introduce drivers/thermal/thermal_core.h for these intern=
al stuff.
> > > > > what do you think?
> > > >
> > > > Yes agree with you.
> > > > Also, we can keep the sysfs things in thermal_sys.c
> > > > and rest of the things in thermal_core.c, and have a thermal_co=
re.h also.
> > > > (This is how the power supply subsystem does it)
> > > >
> > > > I will include this clean up, as part of v2, if you are Ok with=
 this.
> > > >
> > > yes, please go ahead.

I also second this step. This split makes a lot of sense.

> >=20
> > Ok. I will include this change.
> >=20
> > >=20
> > > > Other things;
> > > >  I was thinking is 'removal of netlink things' from
> > > > thermal_sys.c
> > >=20
> > > and where to move it to?
> >=20
> > I was thinking of completely removing this, as raw netlink
> > usage is phasing out, and kobj_uevent () is being used
> > increasingly.
> >=20
> > But we will keep it as a separate change, and not club with this on=
e.
> >=20
> We need to hold this for a while as I'm not sure if someone is using
> this or not.
> IMO, you can introduce a Config option to enable/disable the netlink
> events for now, and marking it as deprecated.


At least from my side, I don't have any legacy application using the ne=
tlink :-)

How about you guys, what are the known applications using this link?

In any case, for me, at least we need to have a standard notification s=
ystem,
for monitoring, debugging and also in case applications need to react o=
n thermal
events.

>=20
> thanks,
> rui
> > > >
> > > > Removing the hwmon related code (the thermal subsystem has grow=
n
> > > > quite a bit and provides more thermal functionalities than Hwmo=
n)
> > > > So, why do we need CONFIG_HWMON inside thermal subsystem ?
> > > > If all of us agree, I am Ok to remove this also.
> > > >
> > > we need Jean's opinion on this.
> > > But anyway, we can do this at anytime, if really needed.
> >=20
> > Yes, will wait for Jean's thoughts..

What where the original design decisions to have these two linked toget=
her?

> >=20
> > Thanks,
> > Durga
> >=20
> > >=20
> > > thanks,
> > > rui
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
