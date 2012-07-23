From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 03/16] Thermal: Documentation update
Date: Mon, 23 Jul 2012 16:36:07 +0800
Message-ID: <1343032567.1682.329.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <1342679480-5336-4-git-send-email-rui.zhang@intel.com>
	 <4D68720C2E767A4AA6A8796D42C8EB5916675C@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39679 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081Ab2GWIet (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 04:34:49 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5916675C@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>

Hi, Durga,

thanks for review. :)

On =E5=9B=9B, 2012-07-19 at 04:51 -0600, R, Durgadoss wrote:
> Hi Rui,
>=20
> No major comments. Just some spell checks.
>=20
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Thursday, July 19, 2012 12:01 PM
> > To: linux-acpi@vger.kernel.org; linux-pm@vger.kernel.org
> > Cc: Rafael J. Wysocki; Matthew Garrett; Len Brown; R, Durgadoss; Ed=
uardo
> > Valentin; Amit Kachhap; Wei Ni; Zhang, Rui
> > Subject: [PATCH 03/16] Thermal: Documentation update
> >=20
> > With commit 6503e5df08008b9a47022b5e9ebba658c8fa69af,
> > the value of /sys/class/thermal/thermal_zoneX/mode has been changed
> > from user/kernel to enabled/disabled.
> > Update the documentation so that users won't be confused.
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  Documentation/thermal/sysfs-api.txt |   20 ++++++++++----------
> >  drivers/acpi/thermal.c              |    6 ++----
> >  2 files changed, 12 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/Documentation/thermal/sysfs-api.txt
> > b/Documentation/thermal/sysfs-api.txt
> > index 3c8c2f8..b7b3609 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -47,11 +47,11 @@ temperature) and throttle appropriate devices.
> >  	.bind: bind the thermal zone device with a thermal cooling device=
=2E
> >  	.unbind: unbind the thermal zone device with a thermal cooling de=
vice.
> >  	.get_temp: get the current temperature of the thermal zone.
> > -	.get_mode: get the current mode (user/kernel) of the thermal zone=
=2E
> > -	    - "kernel" means thermal management is done in kernel.
> > -	    - "user" will prevent kernel thermal driver actions upon trip=
 points
> > +	.get_mode: get the current mode (enabled/disabled) of the thermal
> > zone.
> > +	    - "enabled" means the kernel thermal management is enabled.
> > +	    - "disable" will prevent kernel thermal driver actions upon t=
rip points
>=20
> /s/disable/disabled
>=20
fixed.

thanks,
rui
> >  	      so that user applications can take charge of thermal manage=
ment.
> > -	.set_mode: set the mode (user/kernel) of the thermal zone.
> > +	.set_mode: set the mode (enabled/disabled) of the thermal zone.
> >  	.get_trip_type: get the type of certain trip point.
> >  	.get_trip_temp: get the temperature above which the certain trip =
point
> >  			will be fired.
> > @@ -170,14 +170,14 @@ temp
> >  	RO, Required
> >=20
> >  mode
> > -	One of the predefined values in [kernel, user].
> > +	One of the predefined values in [enabled, disableed].
>=20
> /s/disableed/disabled
>=20
> Thanks,
> Durga


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
