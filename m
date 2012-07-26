From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 09/16] Thermal: Introduce thermal_zone_trip_update()
Date: Thu, 26 Jul 2012 13:08:03 +0800
Message-ID: <1343279283.1682.412.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <1342679480-5336-10-git-send-email-rui.zhang@intel.com>
	 <CAK44p21hNYGH4YkH5E+XK-pM2upingQbvm77WkJbttCRp6ZamQ@mail.gmail.com>
	 <1343113861.1682.370.camel@rui.sh.intel.com>
	 <CAK44p20a6zKHLWhUeguL7ZZH+b55=ZYMv7KiA=q2LdcoDk05uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39709 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab2GZFGr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2012 01:06:47 -0400
In-Reply-To: <CAK44p20a6zKHLWhUeguL7ZZH+b55=ZYMv7KiA=q2LdcoDk05uQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Wei Ni <wni@nvidia.com>

On =E4=BA=8C, 2012-07-24 at 13:36 +0530, Amit Kachhap wrote:
> On 24 July 2012 12:41, Zhang Rui <rui.zhang@intel.com> wrote:
> > On =E4=BA=8C, 2012-07-24 at 12:27 +0530, Amit Kachhap wrote:
> >>
> >>
> >> On 19 July 2012 12:01, Zhang Rui <rui.zhang@intel.com> wrote:
> >>         This function is used to update the cooling state of
> >>         all the cooling devices that are binded to an active trip
> >>         point.
> >>
> >>         This will be used for passive cooling as well, in the futu=
re
> >>         patches.
> >>         as both active and passive cooling can share the same
> >>         algorithm,
> >>         which is
> >>
> >>         1. if the temperature is higher than a trip point,
> >>            a. if the trend is THERMAL_TREND_RAISING, use higher
> >>         cooling
> >>               state for this trip point
> >>            b. if the trend is THERMAL_TREND_DROPPING, use lower
> >>         cooling
> >>               state for this trip point
> >>
> >>         2. if the temperature is lower than a trip point, use lowe=
r
> >>            cooling state for this trip point.
> >>
> >> Hi Rui,
> >>
> >> Your patches looks useful.
> >> For my platform I need to have get_trend called even in the case w=
hen
> >> current temp is less than the trip point and then use
> >> THERMAL_TREND_DROPPING to actually lower the cooling state.
> >>
> > hmm, why?
> > in the current cooling algorithm, when the temperature is lower tha=
n the
> > trip point, the cooling state is decreased by 1 every time,
> > unconditionally, isn't this what you want?
>=20
> Basically the requirement is that I do not want to remove the cooling
> device when the temp just reaches below the trip point because this
> causes many throttling in this trip point so say I will remove coolin=
g
> device when the temp is < (trip - 5) which can be done inside the new
> platform get_trend call.
>=20
As Durga is working on the thermal governor patches, I think that one
can handle this, right?

Currently, as I do not want to change the behavior of the current
drivers, ACPI passive cooling, etc, I did not use trend when the
temperature is lower  than the trip point.
But anyway, if really needed, I can generate an incremental patch.
what do you think?

thanks,
rui

> Thanks,
> Amit D
> >
> > thanks,
> > rui
> >
> >> Thanks,
> >> Amit
> >>
> >>
> >>         Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >>         ---
> >>          drivers/acpi/thermal.c        |    7 +++-
> >>          drivers/thermal/thermal_sys.c |   91
> >>         +++++++++++++++++++++++++++++------------
> >>          2 files changed, 71 insertions(+), 27 deletions(-)
> >>
> >>         diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal=
=2Ec
> >>         index 73e335f..14c4879 100644
> >>         --- a/drivers/acpi/thermal.c
> >>         +++ b/drivers/acpi/thermal.c
> >>         @@ -715,7 +715,12 @@ static int thermal_get_trend(struct
> >>         thermal_zone_device *thermal,
> >>                 if (thermal_get_trip_type(thermal, trip, &type))
> >>                         return -EINVAL;
> >>
> >>         -       /* Only PASSIVE trip points need TREND */
> >>         +       if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> >>         +               /* aggressive active cooling */
> >>         +               *trend =3D THERMAL_TREND_RAISING;
> >>         +               return 0;
> >>         +       }
> >>         +
> >>                 if (type !=3D THERMAL_TRIP_PASSIVE)
> >>                         return -EINVAL;
> >>
> >>         diff --git a/drivers/thermal/thermal_sys.c
> >>         b/drivers/thermal/thermal_sys.c
> >>         index 59af3b8..011faba 100644
> >>         --- a/drivers/thermal/thermal_sys.c
> >>         +++ b/drivers/thermal/thermal_sys.c
> >>         @@ -1076,6 +1076,70 @@ void
> >>         thermal_cooling_device_unregister(struct
> >>          }
> >>          EXPORT_SYMBOL(thermal_cooling_device_unregister);
> >>
> >>         +/*
> >>         + * Cooling algorithm for active trip points
> >>         + *
> >>         + * 1. if the temperature is higher than a trip point,
> >>         + *    a. if the trend is THERMAL_TREND_RAISING, use highe=
r
> >>         cooling
> >>         + *       state for this trip point
> >>         + *    b. if the trend is THERMAL_TREND_DROPPING, use lowe=
r
> >>         cooling
> >>         + *       state for this trip point
> >>         + *
> >>         + * 2. if the temperature is lower than a trip point, use
> >>         lower
> >>         + *    cooling state for this trip point
> >>         + *
> >>         + * Note that this behaves the same as the previous passiv=
e
> >>         cooling
> >>         + * algorithm.
> >>         + */
> >>         +
> >>         +static void thermal_zone_trip_update(struct
> >>         thermal_zone_device *tz,
> >>         +                                    int trip, long temp)
> >>         +{
> >>         +       struct thermal_cooling_device_instance *instance;
> >>         +       struct thermal_cooling_device *cdev =3D NULL;
> >>         +       unsigned long cur_state, max_state;
> >>         +       long trip_temp;
> >>         +       enum thermal_trend trend;
> >>         +
> >>         +       tz->ops->get_trip_temp(tz, trip, &trip_temp);
> >>         +
> >>         +       if (temp >=3D trip_temp) {
> >>         +               thermal_get_trend(tz, trip, &trend);
> >>         +
> >>         +               list_for_each_entry(instance,
> >>         &tz->cooling_devices, node) {
> >>         +                       if (instance->trip !=3D trip)
> >>         +                               continue;
> >>         +
> >>         +                       cdev =3D instance->cdev;
> >>         +
> >>         +                       cdev->ops->get_cur_state(cdev,
> >>         &cur_state);
> >>         +                       cdev->ops->get_max_state(cdev,
> >>         &max_state);
> >>         +
> >>         +                       if (trend =3D=3D THERMAL_TREND_RAI=
SING) {
> >>         +                               cur_state =3D cur_state <
> >>         instance->upper ?
> >>         +                                           (cur_state + 1=
) :
> >>         instance->upper;
> >>         +                       } else if (trend =3D=3D
> >>         THERMAL_TREND_DROPPING) {
> >>         +                               cur_state =3D cur_state >
> >>         instance->lower ?
> >>         +                                   (cur_state - 1) :
> >>         instance->lower;
> >>         +                       }
> >>         +                       cdev->ops->set_cur_state(cdev,
> >>         cur_state);
> >>         +               }
> >>         +       } else {        /* below trip */
> >>         +               list_for_each_entry(instance,
> >>         &tz->cooling_devices, node) {
> >>         +                       if (instance->trip !=3D trip)
> >>         +                               continue;
> >>         +
> >>         +                       cdev =3D instance->cdev;
> >>         +                       cdev->ops->get_cur_state(cdev,
> >>         &cur_state);
> >>         +
> >>         +                       cur_state =3D cur_state >
> >>         instance->lower ?
> >>         +                                   (cur_state - 1) :
> >>         instance->lower;
> >>         +                       cdev->ops->set_cur_state(cdev,
> >>         cur_state);
> >>         +               }
> >>         +       }
> >>         +
> >>         +       return;
> >>         +}
> >>          /**
> >>           * thermal_zone_device_update - force an update of a ther=
mal
> >>         zone's state
> >>           * @ttz:       the thermal zone to update
> >>         @@ -1086,9 +1150,6 @@ void thermal_zone_device_update(stru=
ct
> >>         thermal_zone_device *tz)
> >>                 int count, ret =3D 0;
> >>                 long temp, trip_temp;
> >>                 enum thermal_trip_type trip_type;
> >>         -       struct thermal_cooling_device_instance *instance;
> >>         -       struct thermal_cooling_device *cdev;
> >>         -       unsigned long cur_state, max_state;
> >>
> >>                 mutex_lock(&tz->lock);
> >>
> >>         @@ -1124,29 +1185,7 @@ void thermal_zone_device_update(str=
uct
> >>         thermal_zone_device *tz)
> >>                                                 tz->ops->notify(tz=
,
> >>         count, trip_type);
> >>                                 break;
> >>                         case THERMAL_TRIP_ACTIVE:
> >>         -                       list_for_each_entry(instance,
> >>         &tz->cooling_devices,
> >>         -                                           node) {
> >>         -                               if (instance->trip !=3D co=
unt)
> >>         -                                       continue;
> >>         -
> >>         -                               cdev =3D instance->cdev;
> >>         -
> >>         -                               cdev->ops->get_cur_state(c=
dev,
> >>         &cur_state);
> >>         -                               cdev->ops->get_max_state(c=
dev,
> >>         &max_state);
> >>         -
> >>         -                               if (temp >=3D trip_temp)
> >>         -                                       cur_state =3D
> >>         -                                               cur_state =
<
> >>         instance->upper ?
> >>         -                                               (cur_state=
 +
> >>         1) :
> >>         -
> >>         instance->upper;
> >>         -                               else
> >>         -                                       cur_state =3D
> >>         -                                               cur_state =
>
> >>         instance->lower ?
> >>         -                                               (cur_state=
 -
> >>         1) :
> >>         -
> >>         instance->lower;
> >>         -
> >>         -                               cdev->ops->set_cur_state(c=
dev,
> >>         cur_state);
> >>         -                       }
> >>         +                       thermal_zone_trip_update(tz, count=
,
> >>         temp);
> >>                                 break;
> >>                         case THERMAL_TRIP_PASSIVE:
> >>                                 if (temp >=3D trip_temp || tz->pas=
sive)
> >>         --
> >>         1.7.9.5
> >>
> >>
> >
> >


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
