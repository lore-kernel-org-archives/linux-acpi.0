From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 09/16] Thermal: Introduce thermal_zone_trip_update()
Date: Tue, 24 Jul 2012 15:11:01 +0800
Message-ID: <1343113861.1682.370.camel@rui.sh.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
	 <1342679480-5336-10-git-send-email-rui.zhang@intel.com>
	 <CAK44p21hNYGH4YkH5E+XK-pM2upingQbvm77WkJbttCRp6ZamQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37113 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755086Ab2GXHJo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2012 03:09:44 -0400
In-Reply-To: <CAK44p21hNYGH4YkH5E+XK-pM2upingQbvm77WkJbttCRp6ZamQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Wei Ni <wni@nvidia.com>

On =E4=BA=8C, 2012-07-24 at 12:27 +0530, Amit Kachhap wrote:
>=20
>=20
> On 19 July 2012 12:01, Zhang Rui <rui.zhang@intel.com> wrote:
>         This function is used to update the cooling state of
>         all the cooling devices that are binded to an active trip
>         point.
>        =20
>         This will be used for passive cooling as well, in the future
>         patches.
>         as both active and passive cooling can share the same
>         algorithm,
>         which is
>        =20
>         1. if the temperature is higher than a trip point,
>            a. if the trend is THERMAL_TREND_RAISING, use higher
>         cooling
>               state for this trip point
>            b. if the trend is THERMAL_TREND_DROPPING, use lower
>         cooling
>               state for this trip point
>        =20
>         2. if the temperature is lower than a trip point, use lower
>            cooling state for this trip point.
>=20
> Hi Rui,
>=20
> Your patches looks useful.
> For my platform I need to have get_trend called even in the case when
> current temp is less than the trip point and then use
> THERMAL_TREND_DROPPING to actually lower the cooling state.
>=20
hmm, why?
in the current cooling algorithm, when the temperature is lower than th=
e
trip point, the cooling state is decreased by 1 every time,
unconditionally, isn't this what you want?

thanks,
rui

> Thanks,
> Amit
> =20
>        =20
>         Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>         ---
>          drivers/acpi/thermal.c        |    7 +++-
>          drivers/thermal/thermal_sys.c |   91
>         +++++++++++++++++++++++++++++------------
>          2 files changed, 71 insertions(+), 27 deletions(-)
>        =20
>         diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>         index 73e335f..14c4879 100644
>         --- a/drivers/acpi/thermal.c
>         +++ b/drivers/acpi/thermal.c
>         @@ -715,7 +715,12 @@ static int thermal_get_trend(struct
>         thermal_zone_device *thermal,
>                 if (thermal_get_trip_type(thermal, trip, &type))
>                         return -EINVAL;
>        =20
>         -       /* Only PASSIVE trip points need TREND */
>         +       if (type =3D=3D THERMAL_TRIP_ACTIVE) {
>         +               /* aggressive active cooling */
>         +               *trend =3D THERMAL_TREND_RAISING;
>         +               return 0;
>         +       }
>         +
>                 if (type !=3D THERMAL_TRIP_PASSIVE)
>                         return -EINVAL;
>        =20
>         diff --git a/drivers/thermal/thermal_sys.c
>         b/drivers/thermal/thermal_sys.c
>         index 59af3b8..011faba 100644
>         --- a/drivers/thermal/thermal_sys.c
>         +++ b/drivers/thermal/thermal_sys.c
>         @@ -1076,6 +1076,70 @@ void
>         thermal_cooling_device_unregister(struct
>          }
>          EXPORT_SYMBOL(thermal_cooling_device_unregister);
>        =20
>         +/*
>         + * Cooling algorithm for active trip points
>         + *
>         + * 1. if the temperature is higher than a trip point,
>         + *    a. if the trend is THERMAL_TREND_RAISING, use higher
>         cooling
>         + *       state for this trip point
>         + *    b. if the trend is THERMAL_TREND_DROPPING, use lower
>         cooling
>         + *       state for this trip point
>         + *
>         + * 2. if the temperature is lower than a trip point, use
>         lower
>         + *    cooling state for this trip point
>         + *
>         + * Note that this behaves the same as the previous passive
>         cooling
>         + * algorithm.
>         + */
>         +
>         +static void thermal_zone_trip_update(struct
>         thermal_zone_device *tz,
>         +                                    int trip, long temp)
>         +{
>         +       struct thermal_cooling_device_instance *instance;
>         +       struct thermal_cooling_device *cdev =3D NULL;
>         +       unsigned long cur_state, max_state;
>         +       long trip_temp;
>         +       enum thermal_trend trend;
>         +
>         +       tz->ops->get_trip_temp(tz, trip, &trip_temp);
>         +
>         +       if (temp >=3D trip_temp) {
>         +               thermal_get_trend(tz, trip, &trend);
>         +
>         +               list_for_each_entry(instance,
>         &tz->cooling_devices, node) {
>         +                       if (instance->trip !=3D trip)
>         +                               continue;
>         +
>         +                       cdev =3D instance->cdev;
>         +
>         +                       cdev->ops->get_cur_state(cdev,
>         &cur_state);
>         +                       cdev->ops->get_max_state(cdev,
>         &max_state);
>         +
>         +                       if (trend =3D=3D THERMAL_TREND_RAISIN=
G) {
>         +                               cur_state =3D cur_state <
>         instance->upper ?
>         +                                           (cur_state + 1) :
>         instance->upper;
>         +                       } else if (trend =3D=3D
>         THERMAL_TREND_DROPPING) {
>         +                               cur_state =3D cur_state >
>         instance->lower ?
>         +                                   (cur_state - 1) :
>         instance->lower;
>         +                       }
>         +                       cdev->ops->set_cur_state(cdev,
>         cur_state);
>         +               }
>         +       } else {        /* below trip */
>         +               list_for_each_entry(instance,
>         &tz->cooling_devices, node) {
>         +                       if (instance->trip !=3D trip)
>         +                               continue;
>         +
>         +                       cdev =3D instance->cdev;
>         +                       cdev->ops->get_cur_state(cdev,
>         &cur_state);
>         +
>         +                       cur_state =3D cur_state >
>         instance->lower ?
>         +                                   (cur_state - 1) :
>         instance->lower;
>         +                       cdev->ops->set_cur_state(cdev,
>         cur_state);
>         +               }
>         +       }
>         +
>         +       return;
>         +}
>          /**
>           * thermal_zone_device_update - force an update of a thermal
>         zone's state
>           * @ttz:       the thermal zone to update
>         @@ -1086,9 +1150,6 @@ void thermal_zone_device_update(struct
>         thermal_zone_device *tz)
>                 int count, ret =3D 0;
>                 long temp, trip_temp;
>                 enum thermal_trip_type trip_type;
>         -       struct thermal_cooling_device_instance *instance;
>         -       struct thermal_cooling_device *cdev;
>         -       unsigned long cur_state, max_state;
>        =20
>                 mutex_lock(&tz->lock);
>        =20
>         @@ -1124,29 +1185,7 @@ void thermal_zone_device_update(struct
>         thermal_zone_device *tz)
>                                                 tz->ops->notify(tz,
>         count, trip_type);
>                                 break;
>                         case THERMAL_TRIP_ACTIVE:
>         -                       list_for_each_entry(instance,
>         &tz->cooling_devices,
>         -                                           node) {
>         -                               if (instance->trip !=3D count=
)
>         -                                       continue;
>         -
>         -                               cdev =3D instance->cdev;
>         -
>         -                               cdev->ops->get_cur_state(cdev=
,
>         &cur_state);
>         -                               cdev->ops->get_max_state(cdev=
,
>         &max_state);
>         -
>         -                               if (temp >=3D trip_temp)
>         -                                       cur_state =3D
>         -                                               cur_state <
>         instance->upper ?
>         -                                               (cur_state +
>         1) :
>         -
>         instance->upper;
>         -                               else
>         -                                       cur_state =3D
>         -                                               cur_state >
>         instance->lower ?
>         -                                               (cur_state -
>         1) :
>         -
>         instance->lower;
>         -
>         -                               cdev->ops->set_cur_state(cdev=
,
>         cur_state);
>         -                       }
>         +                       thermal_zone_trip_update(tz, count,
>         temp);
>                                 break;
>                         case THERMAL_TRIP_PASSIVE:
>                                 if (temp >=3D trip_temp || tz->passiv=
e)
>         --
>         1.7.9.5
>        =20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
