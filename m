From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 01/16] Thermal: Make Thermal trip points writeable
Date: Mon, 23 Jul 2012 16:11:43 +0800
Message-ID: <1343031103.1682.321.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <1342679480-5336-2-git-send-email-rui.zhang@intel.com>
	 <201207192138.12181.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:1218 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab2GWIK0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 04:10:26 -0400
In-Reply-To: <201207192138.12181.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>

Hi, Rafael,

thanks for reviewing this patch set.

On =E5=9B=9B, 2012-07-19 at 21:38 +0200, Rafael J. Wysocki wrote:
> On Thursday, July 19, 2012, Zhang Rui wrote:
> > From: Durgadoss R <dugardoss.r@intel.com>
> >=20
> > Some of the thermal drivers using the Generic Thermal Framework
> > require (all/some) trip points to be writeable. This patch makes
> > the trip point temperatures writeable on a per-trip point basis,
> > and modifies the required function call in thermal.c. This patch
> > also updates the Documentation to reflect the new change.
> >=20
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  Documentation/thermal/sysfs-api.txt      |    4 +-
> >  drivers/acpi/thermal.c                   |    4 +-
> >  drivers/platform/x86/acerhdf.c           |    2 +-
> >  drivers/platform/x86/intel_mid_thermal.c |    2 +-
> >  drivers/thermal/spear_thermal.c          |    2 +-
> >  drivers/thermal/thermal_sys.c            |  147 ++++++++++++++++++=
+++---------
> >  include/linux/thermal.h                  |   15 ++-
> >  7 files changed, 125 insertions(+), 51 deletions(-)
> >=20
> > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/th=
ermal/sysfs-api.txt
> > index 1733ab9..0c7c423 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -32,7 +32,8 @@ temperature) and throttle appropriate devices.
> > =20
> >  1.1 thermal zone device interface
> >  1.1.1 struct thermal_zone_device *thermal_zone_device_register(cha=
r *name,
> > -		int trips, void *devdata, struct thermal_zone_device_ops *ops)
> > +		int trips, int flag, void *devdata,
> > +		struct thermal_zone_device_ops *ops)
> > =20
> >      This interface function adds a new thermal zone device (sensor=
) to
> >      /sys/class/thermal folder as thermal_zone[0-*]. It tries to bi=
nd all the
> > @@ -40,6 +41,7 @@ temperature) and throttle appropriate devices.
> > =20
> >      name: the thermal zone name.
> >      trips: the total number of trip points this thermal zone suppo=
rts.
> > +    flag: Bit string: If 'n'th bit is set, then trip point 'n' is =
writeable.
> >      devdata: device private data
> >      ops: thermal zone device call-backs.
> >  	.bind: bind the thermal zone device with a thermal cooling device=
=2E
>=20
> I wonder.  What is the maximum number of trip points currently passed=
 to this
> function in one call?
>=20
in include/linux/thermal.h
#define THERMAL_MAX_TRIPS 12

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
